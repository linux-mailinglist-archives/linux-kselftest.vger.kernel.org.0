Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58752B805C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 16:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgKRPYj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 10:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgKRPYj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 10:24:39 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA8320709;
        Wed, 18 Nov 2020 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605713078;
        bh=FyYoBHVFOyzbhXLtLpQfg8WphnHlN3ZX3R925HrY+Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yhzg4eF2iNUJyuy+EE+DAQYeMVdr0ksqRLRUtegX9IPTkIFzf1L6NMqDj5xQ2d5Gb
         fXq5lLSDz6cmmMh4xzKgutiCC0PcTiLcT4pmuj9Ca9tulG+jI3cjH6UxWRFNcGN2Cb
         J8ZDuPX2YaD7qnQCA5BdDrGty6ZTWt/+MGEMGlvg=
Date:   Wed, 18 Nov 2020 17:24:29 +0200
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
Message-ID: <20201118152429.GC30164@kernel.org>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118111123.GA7472@zn.tnic>
 <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
 <20201118114444.GC7472@zn.tnic>
 <20201118114703.GD7472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118114703.GD7472@zn.tnic>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 12:47:03PM +0100, Borislav Petkov wrote:
> On Wed, Nov 18, 2020 at 12:44:44PM +0100, Borislav Petkov wrote:
> > 0x0000000000000000 0x0000000000002000 0x03
> > 0x0000000000002000 0x0000000000001000 0x05
> > 0x0000000000003000 0x0000000000003000 0x03
> > encl_load: encl->nr_segments: 3
> > encl_load: seg2 offset: 0x3000, seg2 size: 12288
> > encl_load: encl_size: 32768, src_size: 24576
> > encl_map_area: encl_size: 32768
> > encl_map_area: area: 0x0x7feae0db2000
> > encl_map_area: encl_base: 0x7feae0db8000
> > SGX_IOC_ENCLAVE_INIT failed: errno=1
> 
> Running that same thing again succeeded this time:
> 
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> encl_load: encl->nr_segments: 3
> encl_load: seg2 offset: 0x3000, seg2 size: 12288
> encl_load: encl_size: 32768, src_size: 24576
> encl_map_area: encl_size: 32768
> encl_map_area: area: 0x0x7f846bec0000
> encl_map_area: encl_base: 0x7f846bec0000
> mapping segment 0, seg->prot: (read write )
> base: 0x7f846bec0000, offset 0x0, size: 8192
> mapping segment 1, seg->prot: (read  exec)
> base: 0x7f846bec0000, offset 0x2000, size: 4096
> mapping segment 2, seg->prot: (read write )
> base: 0x7f846bec0000, offset 0x3000, size: 12288
> SUCCESS
> 
> then I did a couple of successful runs and the next one failed again:
> 
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> encl_load: encl->nr_segments: 3
> encl_load: seg2 offset: 0x3000, seg2 size: 12288
> encl_load: encl_size: 32768, src_size: 24576
> encl_map_area: encl_size: 32768
> encl_map_area: area: 0x0x7fb09d4a0000
> encl_map_area: encl_base: 0x7fb09d4a0000
> SGX_IOC_ENCLAVE_INIT failed: errno=1
> 
> Fun.

If you adjust log level, then you should probably see this from
sgx_enclave_init():

	} else if (ret) {
		pr_debug("EINIT returned %d\n", ret);
		ret = -EPERM;
	}

EINIT fails with big certainty because SIGSTRUCT is malformed. The only
dynamic thing in that process is RSA key generation sigstruct.c.
Otherwise, everything is static between the runs. That's why I'm quite
confident that key generation is the issue. Given how the issue behaves
I'd guess it eats the entropy pool.

So what I would propose is that I fix this by adding a static 3072-bit
key and remove the generation code

I found a patch that I can use to revert dynamic generation:

https://lore.kernel.org/linux-sgx/20200319023306.6875-1-jarkko.sakkinen@linux.intel.com/

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

/Jarkko
