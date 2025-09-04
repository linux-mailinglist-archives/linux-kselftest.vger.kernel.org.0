Return-Path: <linux-kselftest+bounces-40757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242EBB4377E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 11:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14D83AA32A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4328B2F60DD;
	Thu,  4 Sep 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji4B1n1Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE652E62D1;
	Thu,  4 Sep 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979315; cv=none; b=nLk5Vdme2XkeQjkeJGgq1HYzge8KE981kD1gHkRKo5dC6ndobVhcGWM92UMabNsXhyii858ipiJppLrghVWLlJ3uwsH54/mdR7qA9igZ2s+/oZtsh3TRNgIY5FloPUn07zzLqlW78BW19IWL9p6sgT0sMpVMb/TuCGgix9H7Aqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979315; c=relaxed/simple;
	bh=sSwkUYF31EYfDWUi1ekgZrvpYkbnG+yUu343gN42CB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CABUOedoLfAovkxP/+oYARDFoAuxRF3ktRIem2Mgi4SOA8V+356ERIx4Sqw3yCvtIUK4c22cZGmCQHFDThyhJnIF6xdZPqwRsicn/em6KtwAbLkokxFNQJcfXZW9GTffLlIcAC7Iwvk3bLzZkmAv9NQENCCmVqMPgVDdME8d0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji4B1n1Z; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-32326e20aadso865609a91.2;
        Thu, 04 Sep 2025 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756979313; x=1757584113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IurcVIvDmIouCP1bc4ecxaPSklAYPP27lDW3IVEMq8=;
        b=ji4B1n1ZeIOvEnmtihxYnxPG/TBXF4jPvs7SO/4wcwnOtJ9aC/ekqJGppLiDTIdzZ8
         wxrCTvkY47Ahp10kSQjrHchgD2MOosc9ec2EuE29rAPwHFBKAIk0HBWlyz9G2Mw2sLif
         M3bETKkxyQzArWfIjZmuBHIMfw41Ddpr+BnvmkDguKoaxzFSmRq2fBXVRl6nMW10MI2O
         d6LvyQ5kODqdNl2KNws6Wlz370O5DPb84xzrlFth1ELYmVWwnOdTF+jeNzksMePrKRJk
         N38zJaL/FdjwjHxmhM5gT+jTLN2TPlmWadmE365tvrHWskphia0KWmg18Pu8O5frRl5s
         v6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979313; x=1757584113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IurcVIvDmIouCP1bc4ecxaPSklAYPP27lDW3IVEMq8=;
        b=lxjsG9p4cN6WkJEMSqCDG8a7dRerpyKTRPqMmqLeOd8ArWUGK76D/7OwrrgXjmrrPJ
         xfKY5UMPM8qXq6sAe1zF8bMkHPXjGgAmtWb9B/3ZJRfq3XzqypcLSA8U0pNW8wkCL/YS
         LsyCyQqS9akxJjGVGupe8CitfC1JzW5GRN0GX+RE/60HwIjXKKCRB582bOn76TvBJIb8
         LQR6qyxpPgIFnTGjXH1VKlxQzoLJ06C32ll59RsTuGLHaC4xdi64F5I/5V3O/3c1ASTm
         E4uAAiHyeyRk9P8bp42nsKTW2LDGJ43gdd2qYn431OR0fwdrx1w5ghKfodGhMrO4faJe
         0H2g==
X-Forwarded-Encrypted: i=1; AJvYcCV55d26uDV4roLS+0lxke903YykNKEoP5n0U6il14bxpqm3P8hi7tbFUDUvuJpyILzo7fQ=@vger.kernel.org, AJvYcCWRDeM2piQYgAjcmZQq8khu80UAkiMLwXMjw9uNcEB74k8l/j08j/h4XXJzR6S4vnTe7cfF/3im8vfrkSDI@vger.kernel.org, AJvYcCWyHjOiwqPRTFzrmq6N2gJ64pZLxMd9HdAOYDHn1tjEj1IiAQQmL4MCBQsxWgxW528C4rDclcFvE4i9+1OY/xwE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxig6BqUDSp7zfb02niM7swp7kCCDNyXRtQ+VJ5PauPzdJq6Dmv
	QrgdtySqGzAIhYUaE7zhD5R8csO62ly1lnsxxmoh5Tt2i4AckDSO+aWf
X-Gm-Gg: ASbGncsqK5bXPkuhYdg/cZ/+eU/pnXae/yxqzrHrYghjyEsYPnyPS3d/NQwy61h95n1
	GUik7b6UhertqcE0gYpAMcUXmwdipyKTA8iUlX8y8mhyclsayAr1baHRlznsywpSRHOTnbsO/hn
	ZnB5Yw1aW7CZga49+wjh3/MaP6VtAw2fvnzWIksOr2yxGvX9SyriewK4qDF/H5H73MQj6uN53qe
	fF7lu0Gnbiaw9GAyzH+ZVtU53Bea/b8mcvk4O0dM5wydHcXBnQVg804xi+y316BFAsTqtK/i6VJ
	vlL9xtPdNqdnFnq9T9kEtfKOJqCCjRD6VJ4jWUBTSj25haIgCN43PIKA/CiFddnIsQNHm735ldx
	kmrnrnElpwtEb7NWYA6EdxKeM
X-Google-Smtp-Source: AGHT+IEjJvp6rZMEUJSWcF25yiJN1Bj1VOnRLqvBit6RxKK7N20DSMX22/c7VA4ex8hcWLfqNlRIIw==
X-Received: by 2002:a17:90b:1dcc:b0:31e:7410:a4d7 with SMTP id 98e67ed59e1d1-328156e473cmr24241658a91.33.1756979312777;
        Thu, 04 Sep 2025 02:48:32 -0700 (PDT)
Received: from days-ASUSLaptop ([50.7.253.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm7668990a91.4.2025.09.04.02.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:48:32 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:48:21 +0800
From: Dong Yang <dayss1224@gmail.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, anup@brainfault.org,
	atish.patra@linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/3] KVM: riscv: selftests: Enable supported test cases
Message-ID: <aLlf6ZQ1uNjs8XS+@days-ASUSLaptop>
References: <cover.1756710918.git.dayss1224@gmail.com>
 <20250902-9cc0d0dad59ba680062dbbf8@orel>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-9cc0d0dad59ba680062dbbf8@orel>

On Tue, Sep 02, 2025 at 10:36:10AM -0500, Andrew Jones wrote:
> On Mon, Sep 01, 2025 at 03:35:48PM +0800, dayss1224@gmail.com wrote:
> > From: Dong Yang <dayss1224@gmail.com>
> > 
> > Add supported KVM test cases and fix the compilation dependencies.
> > ---
> > Changes in v3:
> > - Reorder patches to fix build dependencies
> > - Sort common supported test cases alphabetically
> > - Move ucall_common.h include from common header to specific source files
> > 
> > Changes in v2:
> > - Delete some repeat KVM test cases on riscv
> > - Add missing headers to fix the build for new RISC-V KVM selftests
> > 
> > Dong Yang (1):
> >   KVM: riscv: selftests: Add missing headers for new testcases
> > 
> > Quan Zhou (2):
> >   KVM: riscv: selftests: Use the existing RISCV_FENCE macro in
> >     `rseq-riscv.h`
> >   KVM: riscv: selftests: Add common supported test cases
> > 
> >  tools/testing/selftests/kvm/Makefile.kvm                    | 6 ++++++
> >  tools/testing/selftests/kvm/access_tracking_perf_test.c     | 1 +
> >  tools/testing/selftests/kvm/include/riscv/processor.h       | 1 +
> >  .../selftests/kvm/memslot_modification_stress_test.c        | 1 +
> >  tools/testing/selftests/kvm/memslot_perf_test.c             | 1 +
> >  tools/testing/selftests/rseq/rseq-riscv.h                   | 3 +--
> >  6 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.34.1
> 
> In the future please CC previous reviewers on the entire series
> (particularly when they have reviewed the entire previous series).
Okay, I will pay attention to this in the future. Thanks.
> 
> For the series,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

