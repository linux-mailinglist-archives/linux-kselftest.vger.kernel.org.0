Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF06782A60
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 15:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjHUNWn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjHUNWn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 09:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998CD8F;
        Mon, 21 Aug 2023 06:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 309F163605;
        Mon, 21 Aug 2023 13:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8F8C433C8;
        Mon, 21 Aug 2023 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692624160;
        bh=Gsh7y4rBsZmv860cQuOWJia5PKZBOnb13FvRUWG93mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYKx7hPouHmFupChZ2XcCUEx4EolCxIk4hUFuti7K2ZwJjRyuzESkwrPLE5FwuNl0
         ghA3jNISuwbq1d4qDBZkXM47uw7LXJqlJy0m21RrFqre6JznPsGFRe+FRHZetZNLCE
         F5wtiSidSWqCuqrT5P1p7LXY1HUNbEhx7OPHhNPs=
Date:   Mon, 21 Aug 2023 15:22:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v4 4.19 1/1] test_firmware: prevent race conditions by a
 correct implementation of locking
Message-ID: <2023082127-granite-emporium-b3e7@gregkh>
References: <20230816212717.817202-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816212717.817202-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 16, 2023 at 11:27:18PM +0200, Mirsad Goran Todorovac wrote:
> [ Upstream commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 ]
> 
> Dan Carpenter spotted a race condition in a couple of situations like
> these in the test_firmware driver:

Both backports now queued up, thanks.

greg k-h
