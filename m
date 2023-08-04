Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78A76FF57
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 13:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjHDLWg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 07:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjHDLWg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 07:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ACF11B;
        Fri,  4 Aug 2023 04:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1518F61FA0;
        Fri,  4 Aug 2023 11:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C21BC433C8;
        Fri,  4 Aug 2023 11:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691148154;
        bh=1AnaPxv5/G8D8QqzYmp/pQIdhQ892wpjF9yMtnDtGmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3H2K9EjC3l2wD66ZFzGYx3qZCS2owUDQ6c+XwPS00JSxDGm9LqYEySwTYi8eJeZR
         3fgF2pLWIuafqnP6kIQtoa/IttNqNU54/yGz7itGaSzAjrAckO0K3peVeh3CHk5TeE
         NiC1BScmAlK+bynYp2y/quZgZTps5JUX/FUCbJSw=
Date:   Fri, 4 Aug 2023 13:22:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
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
Subject: Re: [PATCH v3 1/2] test_firmware: prevent race conditions by a
 correct implementation of locking
Message-ID: <2023080435-unweave-suspect-3299@gregkh>
References: <20230803165304.9200-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803165304.9200-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 06:53:04PM +0200, Mirsad Todorovac wrote:
> [ Upstream commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 ]

<snip>

Ok, I am totally confused as to what patch is the newest one, and which
is for what branches, sorry.

So, I've deleted all of the patches from my review queue and I would ask
that you start over.

Note, if you put the kernel version in the subject line, it makes it
simpler for me to understand what goes where.

Here is an example to follow:
	https://lore.kernel.org/r/20230802170227.1590187-1-eahariha@linux.microsoft.com

There are loads of other examples on the stable mailing list, please
don't make it hard for me to understand what to do here, make it obvious
as I'm dealing with hundreds of patches a day.

thanks,

greg k-h
