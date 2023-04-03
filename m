Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B66D51D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 22:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDCUEX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 16:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCUEW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 16:04:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086733AA9
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 13:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F2A361F8D
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 20:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E15AAC433EF;
        Mon,  3 Apr 2023 20:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680552259;
        bh=SkQKXg7e6jWC+JmwEDnAzIME7oRvA/Mg8OWanQG97Wg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=MFq0ap/w4iRH9Rkn9zhxp930+VkKfsIcUD3W48zz+gHKAqeE7q/Rkp4fViZWPw+xC
         VYAKlawhHf+wlkyjEDyeX8u8tHpnM4OFiOI0ctmFAxsJXPu8mqAC+Zcqygu99/NARH
         nP/ygGIZjrEEozoLR2tz1baovYvOC3k6hCcM+jHqGp1QH8bZAgWpuAq2y4R/D1txv+
         GgSmC7A70Vi8wdCvG9l2bcsdHWrN9qVEFM9lFyz1V64P/5+JXOB/GkjuODpno0etqA
         NXkZu9F6t+OSsFZqP+ajN0vxG6npPuPly9XqXFsjNfuCWudqvxGZUuTck1v2fDwjY0
         sqH8oWEVC0thw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C751AC41670;
        Mon,  3 Apr 2023 20:04:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        bugs@lists.linux.dev, rdunlap@infradead.org,
        skhan@linuxfoundation.org
Message-ID: <20230403-b217293c2-4b94a5e6478a@bugzilla.kernel.org>
In-Reply-To: <20230403-b217293c0-1e5391e4b7f5@bugzilla.kernel.org>
References: <20230403-b217293c0-1e5391e4b7f5@bugzilla.kernel.org>
Subject: Re: Kernel panic, CONFIG_FIPS_SIGNATURE_SELFTEST, missing
 dependency
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Mon,  3 Apr 2023 20:04:19 +0000 (UTC)
X-Spam-Status: No, score=-3.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_FROM_NAME_TO_DOMAIN,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

o6irnndpcv7 writes via Kernel.org Bugzilla:

Hi Randy!

(In reply to Bugbot from comment #1)
> Randy Dunlap <rdunlap@infradead.org> writes:
>
> Please tell us what the kernel panic message is.
> 

There is no message. I'm sorry.
I just get a black screen.

I'm using EFI to boot my machine. And I can get some output if I enable 'earlycon=efifb' via CMDLINE. 

The output stops at:
Console: colour dummy device 80x25
printk: console [tty0] enabled
printk: bootconsole [efifb0] disabled

At this point the machine freezes. No error message.

And when I set:
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=-1

That gives me a reboot loop.

> 
> Have you tested this on a mainline kernel, without gentoo patches?
> 
> Does gentoo add any patches in this area?
>

Unfortunately I don't know if Gentoo is adding any patches that may affect this.

But I can confirm that the problem persists while using vanilla-sources for kernel 6.2.9.

Thanks,
   sephora

> 
> Thanks.

View: https://bugzilla.kernel.org/show_bug.cgi?id=217293#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

