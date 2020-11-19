Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227B02B984F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgKSQly (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 11:41:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbgKSQlx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 11:41:53 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADC0622264;
        Thu, 19 Nov 2020 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605804112;
        bh=a8DNh3KKaUy/3Z0QZ4V7Dwx43lhtI1TlCwUDoL5hZeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKI9kb3ScOMKv2/vXY82ULiPASQ+9D3ThWZhtEfMbp5r6XCSu5ZmUj6YaXxMixlMu
         Nn5OYo7Y/7FVaz6CWjYYndq0gHQ35zz++ZkRppGSdBrFkKrEA19e0lm96YYHBv0uak
         x26WBeckLvnRyJGb9M09KY0tX/CTngPuz5x+YPSE=
Date:   Thu, 19 Nov 2020 18:41:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20201119164144.GA77509@kernel.org>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118171900.GJ7472@zn.tnic>
 <20201118175850.GA42022@kernel.org>
 <20201118180450.GL7472@zn.tnic>
 <20201118213755.GA62979@kernel.org>
 <20201118215446.GO7472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118215446.GO7472@zn.tnic>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 10:54:46PM +0100, Borislav Petkov wrote:
> On Wed, Nov 18, 2020 at 11:37:55PM +0200, Jarkko Sakkinen wrote:
> > Just checking that I got this right: you want me to port my anon inode
> > changes from March to be applied on top of tip and send them?
> 
> Well, we need to somehow address the issue when some distros map /dev
> noexec and that is conflicting with SGX due to it needing to mmap with
> executable permissions but /dev/sgx_enclave is noexec...
> 
> I guess the first thing that needs figuring out is why are some distros
> mounting /dev noexec.
> 
> I mean, you can always do the easiest thing: somewhere in the SGX
> docs say that one of the steps towards running SGX enclaves on such
> distros is for the admin to map /dev exec. However, does that have other
> security implications which would make such exec mounting a security
> hazard?
> 
> If so, then the SGX code would need changing...
> 
> Questions like those.
> 
> HTH.

OK I did re-read the whole thing:

https://lore.kernel.org/linux-sgx/20200331114432.7593-1-jarkko.sakkinen@linux.intel.com/

As Topi (the Debian developer who did this change) stated in the thread,
the threat scenario is that someone could create executable files to
/dev if it isn't noexec. It's not about the permissions of device files
per se.

The problem with anonymous inode is that LSM's cannot label it easily
like you can a non-anonymous inode.

There's a patch set for secure anonymous inodes but it hasn't landed yet
and I think it would make the whole security model somewhat more
complicated [1]. What I mean is that secure anonymous inodes would make
sense in a context where anonymous inodes are used for other reasons to
begin with.

The route of using sgxfs was discarded because it results static
permissions and is also quite big hammer for the purpose [2].

In that thread there were two valid routes to move forward:

1. You can always create a separate tmpfs and create enclave nodes
   and even bind mount them (proposed by Andy) to /dev.
2. It would be possible (given how Topi described the threat scenario)
   implement "noexec_dev" mount option that would allow 'x' for dev's
   but not for anything else (proposed by me).

To summarize, I would not change the SGX code for this but apply either
(1) and (2) when deploying SGX.

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

[1] https://lore.kernel.org/linux-security-module/20201011082936.4131726-1-lokeshgidra@google.com/
[2] https://lore.kernel.org/linux-sgx/CALCETrWkaUS2RU61_4KoNhn3RkW-J+SWiCQTZ623wu4b7snJ0w@mail.gmail.com/

/Jarkko
