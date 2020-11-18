Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00E42B8707
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 22:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgKRVy4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 16:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRVyz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 16:54:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AAFC0613D4;
        Wed, 18 Nov 2020 13:54:55 -0800 (PST)
Received: from zn.tnic (p200300ec2f0caf003ca6ed11c9851040.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:3ca6:ed11:c985:1040])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC2EC1EC0473;
        Wed, 18 Nov 2020 22:54:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605736494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qu7sO3SWRkR9r2p9MxyB1cJnvWyynyu47YjDGRHH5wA=;
        b=lalXrumFBqfPyuxmcjvpqPEr3vZcZ1/QXHIT2Ig1gR0vwB2bEMK4XFoMJ3QEI0V+iVSQgq
        yzRsquUMuvIcfqVt9OfTeIvqUeYMFaHQwjs9mnOZO5sZk2yEjtg9bc2gWNFrpHdHX6xKmi
        Jl4YDLwaJ5kF9hiiBvnVhIwThcxu1TI=
Date:   Wed, 18 Nov 2020 22:54:46 +0100
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
Message-ID: <20201118215446.GO7472@zn.tnic>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118171900.GJ7472@zn.tnic>
 <20201118175850.GA42022@kernel.org>
 <20201118180450.GL7472@zn.tnic>
 <20201118213755.GA62979@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118213755.GA62979@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 11:37:55PM +0200, Jarkko Sakkinen wrote:
> Just checking that I got this right: you want me to port my anon inode
> changes from March to be applied on top of tip and send them?

Well, we need to somehow address the issue when some distros map /dev
noexec and that is conflicting with SGX due to it needing to mmap with
executable permissions but /dev/sgx_enclave is noexec...

I guess the first thing that needs figuring out is why are some distros
mounting /dev noexec.

I mean, you can always do the easiest thing: somewhere in the SGX
docs say that one of the steps towards running SGX enclaves on such
distros is for the admin to map /dev exec. However, does that have other
security implications which would make such exec mounting a security
hazard?

If so, then the SGX code would need changing...

Questions like those.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
