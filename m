Return-Path: <linux-kselftest+bounces-39970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F319B370A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 18:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F27A16920E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09738369341;
	Tue, 26 Aug 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8o1NA52"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9B27BF7D
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226298; cv=none; b=EUkqY6VDFn8i8Jdc9EGAIEh2ovVAHkRCDpPtJaz9c7sxeyFkdGYWhRlLKOjqzxU36x8BNMiC3aBv2g8kUoY3GtRZEvZGgkz+ft/8L1UjFej5gl0mQeYbUY2oX6TePH0H4cYKyGRqGydKmI5SeakWlfphh+h5WA32risJ54SXhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226298; c=relaxed/simple;
	bh=IZA6OL5p8O+5QNVz1cw/X3Wrim59+EoqxbFxaryX0Cc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nJM5vjRxOuCGZQrT0cAhsQF6RuhSVhp136Yf/JjQwOvdIi5IJwu6O4TeWkTaMvhPsRcBN4sEfkXMRwPBtZZcLwtB6npW3kcyyyCDDBRyU0y8qi2r58Zzuu6S50T07L5XwlZeq5PJc9qWSXio7O7bSvbKkHa4iB3b7byrFDKDUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8o1NA52; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-771e331f0fcso1942038b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756226297; x=1756831097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KArhLKucBXK1qma7WLAGLPHRkqsc2bT2vqsvNWf6PMM=;
        b=e8o1NA524f3NKL/ph8L3v/cRKbXvrP4LfgBiux/K/hKN4MHdDHYUAdHXx8nz1h7g/8
         thQeU7L5Q6itRTejj1d3uI7rxYy2VzOJPs/EIaZ/qHY822Nqcn4HGJTx1ccXYeVD+07q
         y+NvdwhgBtOIK2XRc1Cr2pNwYL5GPGcZHaDKiZ5ym7O+fU3Yzky660ErRCxNz9vHTgJP
         utnjihofGdYw1UNWCC4pYBAHemgSwbHTmEhlrGATocS1rrxmP5pUFQ2bHhFimNCk7tFn
         ZAh7vlFMWgXVB8nlHf+FjBMnT5m5nKcANLfvaEPokCu6RDlwg+BrHDjfRCfQmw5GRTpv
         gABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226297; x=1756831097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KArhLKucBXK1qma7WLAGLPHRkqsc2bT2vqsvNWf6PMM=;
        b=NYFF+jlz4PPzfqZpTs1zoxPO5SU3VtI7QZ6VX//tlYn9zKD4gwdvJsDSelZpvbAzu4
         2zhYY4EUH2ghzSoUsgdFkbkbme3U3iVaTX3rzH8J7yVTou0Cq+JUTajGmkkTh6Q/O+A/
         Yd/KnB17B14kvvjpZDWTPcm+11mB7aVH7sl0e8xAE3blBKh51lQRUpzPPjL+P5OrCTjZ
         eTaq4mEbuIq5DBVGNfxpzGBMzNY7e+s51WtUnQhlqGJixIz/FAUVbn7vU1RzyhLy1Ags
         /eNxhyvwK6k/UvCxLaTihADReE+17GEOIF2CBK9S4nQLWIeCkYeSXgUsd0UYGSRk7Z3K
         I26Q==
X-Forwarded-Encrypted: i=1; AJvYcCWj4fkQd/Xm8J4bFH6KXwVle/a6b5rMCt+Su1sFDp87HnTmpVe3PulVs8lMxUMQLxxa2aQLmCDFiEK20M2jEdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZZ4yhzI7vdqECTT5zee9Zn+W/sBp+lAY0NbrakCPVsHLwDae
	vZK7xsLNuyOEolVcu9qia/SBlxoPay72UjEC4kbdoxfCX6Hv/uFUEJIX4kpwvbFHh5E3zrnUacS
	F9R7tNQ==
X-Google-Smtp-Source: AGHT+IHW22aqV9V9u5Zze8D3GfPgtdWWFsehZkrUkllA1TCvbFhmXlWXij1jXskDhKIIjelfwPENG1eV3eQ=
X-Received: from pgww6.prod.google.com ([2002:a05:6a02:2c86:b0:b4c:2bd1:3d27])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b32a:b0:243:6e7b:9666
 with SMTP id adf61e73a8af0-2436e7ba22dmr9292868637.28.1756226296889; Tue, 26
 Aug 2025 09:38:16 -0700 (PDT)
Date: Tue, 26 Aug 2025 09:38:15 -0700
In-Reply-To: <aKv1VNFiOPJZBN/T@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-11-sagis@google.com>
 <aKv1VNFiOPJZBN/T@yzhao56-desk.sh.intel.com>
Message-ID: <aK3i910ghgsaIkir@google.com>
Subject: Re: [PATCH v9 10/19] KVM: selftests: Set up TDX boot code region
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 25, 2025, Yan Zhao wrote:
> > +	/*
> > +	 * Handcode "JMP rel8" at the RESET vector to jump back to the TD boot
> > +	 * code, as there are only 16 bytes at the RESET vector before RIP will
> > +	 * wrap back to zero.  Insert a trailing int3 so that the vCPU crashes
> > +	 * in case the JMP somehow falls through.  Note!  The target address is
> > +	 * relative to the end of the instruction!
> > +	 */
> > +	TEST_ASSERT(TD_BOOT_CODE_SIZE < 256,
> Looks TD_BOOT_CODE_SIZE needs to be <= 126, as the jump range is limited to -128
> to +127 for JMP rel8.

Gah, I managed to forget that relative targets obviously need to be signed values,
and I also forgot to account for the size of the JMP in the assert.  Go me.

Maybe express this as:

	TEST_ASSERT(TD_BOOT_CODE_SIZE + 2 < 128,
		    "TD boot code not addressable by 'JMP rel8'");
	
> > +		    "TD boot code not addressable by 'JMP rel8'");
> > +	hva[0] = 0xeb;
> > +	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;

I think I lucked into getting this right though?

> > +	hva[2] = 0xcc;
> > +}
> > -- 
> > 2.51.0.rc1.193.gad69d77794-goog
> > 
> > 

