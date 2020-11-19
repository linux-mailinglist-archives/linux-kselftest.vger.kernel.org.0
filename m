Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D82B9A56
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 19:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgKSSFF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 13:05:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48276 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgKSSFF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 13:05:05 -0500
Received: from zn.tnic (p200300ec2f0caf00499206e3ae50e028.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:4992:6e3:ae50:e028])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 303751EC04D3;
        Thu, 19 Nov 2020 19:05:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605809104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vq5t1Uz17dCgETjKB9ITKMfAU/o1Sa0SYb9IbQFQGrQ=;
        b=itdzlzZtMV5Gr657sdXwsZqjymbg7B6uFERbDRCdg+arNWsIsYMV9KzqLjFHAPd1YVLLeW
        Mgfu6sLcoyLH+9GMaUvNRqSHTW5SCjXGyk8rgn1JcvrszAV3DX9xqveDS9C0H1zoisjZpm
        61eRCQJMG5YcDET0xLk9HOTV4Iff+LU=
Date:   Thu, 19 Nov 2020 19:04:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH] selftests/x86: Fix malformed src_offset initialization
Message-ID: <20201119180459.GF3769@zn.tnic>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118171900.GJ7472@zn.tnic>
 <20201118175850.GA42022@kernel.org>
 <20201118180450.GL7472@zn.tnic>
 <20201118213755.GA62979@kernel.org>
 <20201118215446.GO7472@zn.tnic>
 <20201119164144.GA77509@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119164144.GA77509@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 19, 2020 at 06:41:44PM +0200, Jarkko Sakkinen wrote:
> As Topi (the Debian developer who did this change) stated in the thread,
> the threat scenario is that someone could create executable files to
> /dev if it isn't noexec. It's not about the permissions of device files
> per se.

Aha, makes sense.

> The problem with anonymous inode is that LSM's cannot label it easily
> like you can a non-anonymous inode.
> 
> There's a patch set for secure anonymous inodes but it hasn't landed yet
> and I think it would make the whole security model somewhat more
> complicated [1].

More complicated is never good.

> 1. You can always create a separate tmpfs and create enclave nodes
>    and even bind mount them (proposed by Andy) to /dev.
> 2. It would be possible (given how Topi described the threat scenario)
>    implement "noexec_dev" mount option that would allow 'x' for dev's
>    but not for anything else (proposed by me).
> 
> To summarize, I would not change the SGX code for this but apply either
> (1) and (2) when deploying SGX.

Both sound ok to me, especially 1 since you can do that now, without any
changes needed.

Anything else means adding more code which for distros and people using
older kernels means, more backporting and more verif.

But WTH do I know...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
