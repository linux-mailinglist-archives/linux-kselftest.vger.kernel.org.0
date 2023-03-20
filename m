Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF296C25A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 00:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjCTXbN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 19:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCTXbL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 19:31:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFFC26C25;
        Mon, 20 Mar 2023 16:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF31B8118D;
        Mon, 20 Mar 2023 23:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4535DC433D2;
        Mon, 20 Mar 2023 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679355067;
        bh=NpFdQAbBRLTzFJaY6HfR2sUNYDD/ylY5ktsWdjJaH4k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ox5K5g5ZANNdo0lkAPFnjS9r0JQjy4+EJzhHIGxUoFoYBzLmGTQaVjSD6yRgvGfbJ
         CRP1QBb9dnxGnH9kMIWwrOQD84tjER3q1/aPKLwG3igEIrDbrTws5tMx2wyTjPFnyv
         X3LFe9ae3gusd7zp61KuzUIvQBUbnJkeYbBU/Umh+VC8+eaJBSVAc/FPS0PFS8vOiM
         QUkDrs/c3Vh0GRN+hnHBEQkp3G83I1U4R1cPUEKd+/w5ntfRAfOXfde5men8yB3o4O
         tznkh2aHhSgUSBrCOK8zUOCWcQvZt8UGxEHP8Tfb2RsNh/KsRKMFQ3dqEqr7p0Ic4f
         IZgru2eef6PfQ==
Message-ID: <155a112f-c6e7-57a0-b8bd-6b3bde85d685@kernel.org>
Date:   Mon, 20 Mar 2023 17:30:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selftests: sigaltstack: fix -Wuninitialized
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230308195933.806917-1-ndesaulniers@google.com>
 <CA+G9fYtTL+y-ZYeZXKHbVg9XiYVeHE-RaAjaRHTT+EfXO924cA@mail.gmail.com>
 <CAKwvOdnM9WjxHY_uw_0nyhGTZDuQ+730NrX2sgw9cBLkrhF8oA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
In-Reply-To: <CAKwvOdnM9WjxHY_uw_0nyhGTZDuQ+730NrX2sgw9cBLkrhF8oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/20/23 12:41, Nick Desaulniers wrote:
> Hi Shuah,
> Did this get picked up? Just checking it doesn't fall through the cracks.
> EOM
> 

Thanks for the ping. Now applied Applied to linux-kselftest fixes
branch for rc4.

Somehow this one didn't show up in my inbox and responses made it
fine. I have to check what's happening to emails on my end.

thanks,
-- Shuah

