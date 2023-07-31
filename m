Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1587769F77
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjGaR1d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGaR1c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 13:27:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3601A0;
        Mon, 31 Jul 2023 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/04mzdZdAWjnY4Fmn8mRCyHmZjqyRZ419aYIDV85A3k=; b=QGEiMjVGOpgEzUV34YC5Q0c24E
        MvNOcHiZ9eRK/1Co/pS7wJN/8MACxBXhfI10l7oyiMOLrhCS6yydrAsf1LkrOoaHLILjVInFEBoAn
        1T0855574d183TNmQ6U8Y4cGqjoq6QNqV4/gZg8TrkUMasypKcNzK0XrRgZ9TMTcqWlyhUgzEi/Oc
        mkOdlip1gLGVmvdUL88/36ZTpC7BVNS4zRtdwhhM2NwVstnPl8SJI5UpUl9bjrjmHflBBpErYeRp1
        y1BoXM16Prn5/mv9VQeF12Vx6NFjRWmF+RG+EqsB5QEsFJzVyy9CbEmKaXrCXbSnwoHmcPnjgVzFc
        3IDHQraw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQWg6-00GrFl-1u;
        Mon, 31 Jul 2023 17:27:30 +0000
Date:   Mon, 31 Jul 2023 10:27:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v1 1/1] test_firmware: prevent race conditions by a
 correct implementation of locking
Message-ID: <ZMfvAhOfSP5UXN6l@bombadil.infradead.org>
References: <20230731165018.8233-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731165018.8233-1-mirsad.todorovac@alu.unizg.hr>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 06:50:19PM +0200, Mirsad Todorovac wrote:
> NOTE: This patch is tested against 5.4 stable
> 
> NOTE: This is a patch for the 5.4 stable branch, not for the torvalds tree.
> 
>       The torvalds tree, and stable tree 5.10, 5.15, 6.1 and 6.4 branches
>       were fixed in the separate
>       commit ID 4acfe3dfde68 ("test_firmware: prevent race conditions by a correct implementation of locking")
>       which was incompatible with 5.4
> 

The above part is not part of the original commit, you also forgot to
mention the upstream commit:


[ Upstream commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 ]

> Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Colin Ian King <colin.i.king@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: stable@vger.kernel.org # v5.4
> Suggested-by: Dan Carpenter <error27@gmail.com>

Here you can add the above note in brackets:

[ explain your changes here from the original commit ]

Then, I see two commits upstream on Linus tree which are also fixes
but not merged on v5.4, did you want those applied too?

  Luis
