Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C272761F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 22:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWUXe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 16:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgIWUXe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 16:23:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C666C0613CE;
        Wed, 23 Sep 2020 13:23:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E869829C1E8
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 7/9] x86: Enable Syscall User Dispatch
Organization: Collabora
References: <20200904203147.2908430-1-krisman@collabora.com>
        <20200904203147.2908430-8-krisman@collabora.com>
        <202009221236.04AA334C2@keescook>
Date:   Wed, 23 Sep 2020 16:23:26 -0400
In-Reply-To: <202009221236.04AA334C2@keescook> (Kees Cook's message of "Tue,
        22 Sep 2020 12:37:02 -0700")
Message-ID: <87zh5g5jk1.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, Sep 04, 2020 at 04:31:45PM -0400, Gabriel Krisman Bertazi wrote:
>> Syscall User Dispatch requirements are fully supported in x86. This
>> patch flips the switch, marking it as supported.  This was tested
>> against Syscall User Dispatch selftest.
>> 
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  arch/x86/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 7101ac64bb20..56ac8de99021 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -150,6 +150,7 @@ config X86
>>  	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
>>  	select HAVE_ARCH_PREL32_RELOCATIONS
>>  	select HAVE_ARCH_SECCOMP_FILTER
>> +	select HAVE_ARCH_SYSCALL_USER_DISPATCH
>
> Is this needed at all? I think simply "the architecture uses the generic
> entry code" is sufficient to enable it. (Especially since there's a top
> level config for SYSCALL_USER_DISPATCH, it feels like overkill).

Maybe it is not necessary.  The reason I have this is to prevent
architectures migrating to the generic entry code from inadvertently
starting to support this feature, without thinking in advance whether
arch_syscall_is_vdso_sigreturn is needed.  If that is not a good reason,
I'm happy to drop it.

-- 
Gabriel Krisman Bertazi
