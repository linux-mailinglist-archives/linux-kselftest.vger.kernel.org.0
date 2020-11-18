Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B842B806D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 16:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKRP2J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 10:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgKRP2J (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 10:28:09 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DE13207D3;
        Wed, 18 Nov 2020 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605713288;
        bh=hfZb4az+f7VqmwXRlCAfJ7AsFFZSUWV6kBcmQ89BI1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKZgFkK9GPHZdJc06LhFHV6ZSa1ALwVCXqtlgY6bgKZ1yqzt8R816l2EOvcalcxvZ
         x/KwqKf9HIQoED6p6CXmAbwoGzjcicZAvU6CEln2vjohTeloIN4vslrB4chIsf46LZ
         ZfyMGpU4OLEqF+yRxz5CgSl5Ec+fuKvrxR2H8wsg=
Date:   Wed, 18 Nov 2020 17:27:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jethro Beekman <jethro@fortanix.com>, linux-sgx@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH] selftests/x86: Fix malformed src_offset initialization
Message-ID: <20201118152759.GD30164@kernel.org>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118111123.GA7472@zn.tnic>
 <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
 <20201118114444.GC7472@zn.tnic>
 <0d2b3af9-eb19-b5ad-aa82-f85ba2a3ee4b@fortanix.com>
 <20201118121550.GG7472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118121550.GG7472@zn.tnic>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 01:15:50PM +0100, Borislav Petkov wrote:
> On Wed, Nov 18, 2020 at 01:00:30PM +0100, Jethro Beekman wrote:
> > On some distros, unfortunately, yes, and this breaks SGX. See
> > https://www.spinics.net/lists/linux-sgx/msg02562.html and
> > https://www.spinics.net/lists/linux-sgx/msg02617.html
> 
> I guess anonymous inode doesn't sound all too bad, albeit Sean calls it
> an ugly hack.
> 
> Thx.

LOL, I did not even remember that I had created patches for it at some
point.

I'll send the fix for the sigstruct issue. It's not a good idea to
generate big rsa keys on fly I guess.

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

/Jarkko
