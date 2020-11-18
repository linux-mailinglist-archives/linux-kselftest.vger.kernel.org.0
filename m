Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACB82B7D04
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 12:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgKRLrG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 06:47:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38886 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbgKRLrF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 06:47:05 -0500
Received: from zn.tnic (p200300ec2f0caf00530924e6be7c3eae.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:5309:24e6:be7c:3eae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 436ED1EC01A8;
        Wed, 18 Nov 2020 12:47:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605700024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SYSWDGgTLkW7eZl1OUk8PyG3sUmRTa7sx/pZ/IuV3+w=;
        b=YVmRYIuUyrKNHc/iZxJReZaCZeQJF+Eb0Zig4qTNtVyT5lanuJzgt0KoIajzXpl3vYpfs+
        29soo5zoNr97oPMV/S4fVu0jykZErNV9EWjsjBV+E+CQtl+XJZl/JN6dsjMr485RRkj5Rs
        XfTbO6dP32G8Fa7aPPkcBekFmCXpuiA=
Date:   Wed, 18 Nov 2020 12:47:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
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
Message-ID: <20201118114703.GD7472@zn.tnic>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118111123.GA7472@zn.tnic>
 <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
 <20201118114444.GC7472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118114444.GC7472@zn.tnic>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 12:44:44PM +0100, Borislav Petkov wrote:
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> encl_load: encl->nr_segments: 3
> encl_load: seg2 offset: 0x3000, seg2 size: 12288
> encl_load: encl_size: 32768, src_size: 24576
> encl_map_area: encl_size: 32768
> encl_map_area: area: 0x0x7feae0db2000
> encl_map_area: encl_base: 0x7feae0db8000
> SGX_IOC_ENCLAVE_INIT failed: errno=1

Running that same thing again succeeded this time:

0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
encl_load: encl->nr_segments: 3
encl_load: seg2 offset: 0x3000, seg2 size: 12288
encl_load: encl_size: 32768, src_size: 24576
encl_map_area: encl_size: 32768
encl_map_area: area: 0x0x7f846bec0000
encl_map_area: encl_base: 0x7f846bec0000
mapping segment 0, seg->prot: (read write )
base: 0x7f846bec0000, offset 0x0, size: 8192
mapping segment 1, seg->prot: (read  exec)
base: 0x7f846bec0000, offset 0x2000, size: 4096
mapping segment 2, seg->prot: (read write )
base: 0x7f846bec0000, offset 0x3000, size: 12288
SUCCESS

then I did a couple of successful runs and the next one failed again:

0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
encl_load: encl->nr_segments: 3
encl_load: seg2 offset: 0x3000, seg2 size: 12288
encl_load: encl_size: 32768, src_size: 24576
encl_map_area: encl_size: 32768
encl_map_area: area: 0x0x7fb09d4a0000
encl_map_area: encl_base: 0x7fb09d4a0000
SGX_IOC_ENCLAVE_INIT failed: errno=1

Fun.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
