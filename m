Return-Path: <linux-kselftest+bounces-16749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B9E965459
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 03:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32B11F25C31
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 01:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C6134AC;
	Fri, 30 Aug 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hSg8uOri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2EE4C9F
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724979635; cv=none; b=a5jGJlF9AT2qw152+0Cr36UVRHtTOKt6awmXTIP6iQguGljZx3fkgpSFiU8zxHzkzgnpKckXjC+E1rG3u2dtPOrhKfv7EF4oqNlCXuoJ5cChGy3moqTi8b8HhSqJHAOCUdDUmx0zRKr9B2NMztJgYS9u0dVrUBl0Rp1GcxECqh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724979635; c=relaxed/simple;
	bh=JFmFm326geTp2LLoKmoyFRxPiCe1hcFYAQqWCNUoWnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twHQdwHEiLnvCzvBGdfQjf7irJi+aFzzYW5Ju/wawz0c2HWc9Z3seDUg6zAU4PSfm3EmjW5KSTtKm7NVuMhsjKBBdAl/nmTKdEMVF9QA0lyXO4xD/ki9cbi11BWGiuV4MpZNgTQs4og/Iu28KiAsAdJV5DS0WNMtxmAdCLbue6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hSg8uOri; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd835872ceso920548a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724979633; x=1725584433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LS53wxxaShUerh6Nzz4tUD12WQZd3J6t0NqAtqOlEuU=;
        b=hSg8uOriZEdEuidblwZU9g8DEAcO+1wEMMLRhogmPY3O4CZUHf+cPLvelFeIcPhmj2
         Ojguhht/upiAyTOTKONNDQw/CE8s8ZOWzDoSu23qXpOVleVJ72D8qRdB3jzKb0baVN0/
         nsLCvKpdiHswu84Ix/QeC1I3i8kf2q1noCaRLPQmZG88fcQnMaqvCwqJ+zIMwjzPASXi
         5cwJR9N3wq2yp5QWKiyrB7vrQxqHH8ogqh+Q/y84+PZCfZsC1Vaz59o9hceswv34gC+R
         5sQ7kN1gilpy5Brtmqjj0/JnVhpngSfXu8tcb5rTmW/8ebtT4M/cyT/UPi5/fYvyHNiG
         KB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724979633; x=1725584433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS53wxxaShUerh6Nzz4tUD12WQZd3J6t0NqAtqOlEuU=;
        b=fu0amesnb6OnWpceokN61g4eLOCn/p8ANCamfJfnhNPvFteTn3CO2zhnf9OL2TdHJ9
         aDHevSYK2iMMX98mw2/x226s7EKTu7UUxkrPJnk8EAZAqmkXT9NawYh8lMTou4bPQf2x
         UQjEcfpw0fn6Ew/Jg4XWv1gsdOrUihVzMfok3Dc46HO18PX3xu0bJlfwpYYvHZaVYF15
         N8ZjtRXou1K+JGoMS7WG2TA/1/j9T2WycKvsePJLo36183WvqmqYEv2TFWdbAUoTbJqi
         Evl2eaETDaHfJA9ZAfK+kUrspnHG5xxFmEYW/hI8VF+ovP6EC072ymudiexlO0HRPmCu
         LVSA==
X-Forwarded-Encrypted: i=1; AJvYcCWYOqI28MhLY0/hVfAexb+HqcXuZtx+WdcDXlWy035pGUo/RH7J3o+o79tWGEvRKUMExw9tZoftQ3Rsdiub9oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHGDAkRIC8XcSKuRAcFWO+dNCdcDKwLZQlGHwK+cafxScGkHvi
	ULeAz87YF97kNlTAJeip61mXXbWCoOHoSguCXOw5+EYtbauIuyJtzLqB+AiC+xw=
X-Google-Smtp-Source: AGHT+IHskamnwhuEnVsgXagVygWurPjxZHIPCEOoqvpXtCAUWcyWg3cwyRWbxqEUzrtAK6MXZRChtw==
X-Received: by 2002:a17:902:e84a:b0:202:3e32:5d3e with SMTP id d9443c01a7336-2050c3faf20mr48056025ad.36.1724979631231;
        Thu, 29 Aug 2024 18:00:31 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051555bf89sm17096775ad.289.2024.08.29.18.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 18:00:30 -0700 (PDT)
Date: Thu, 29 Aug 2024 18:00:25 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/16] mm: Introduce MAP_BELOW_HINT
Message-ID: <ZtEZqUSkVvi5Bmpt@ghost>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <fd1b8016-e73d-4535-9c67-579ab994351f@intel.com>
 <Zs+FYbII0ewwdisg@ghost>
 <4219f619-4b32-40bc-85b8-cb11d76fde98@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4219f619-4b32-40bc-85b8-cb11d76fde98@intel.com>

On Thu, Aug 29, 2024 at 09:54:08AM -0700, Dave Hansen wrote:
> On 8/28/24 13:15, Charlie Jenkins wrote:
> > A way to restrict mmap() to return LAM compliant addresses in an entire
> > address space also doesn't have to be mutually exclusive with this flag.
> > This flag allows for the greatest degree of control from applications.
> > I don't believe there is additionally performance saving that could be
> > achieved by having this be on a per address space basis.
> 
> I agree with you in general.  The MAP_BELOW_HINT _is_ the most flexible.
>  But it's also rather complicated.

Can you expand upon what you mean by it being complicated? Complicated
for the kernel or complicated for a user?

> 
> My _hope_ would be that a per-address-space property could share at
> least some infrastructure with what x86/LAM and arm/TBI do to the
> address space.  Basically put the restrictions in place for purely
> software reasons instead of the mostly hardware reasons for LAM/TBI.

That is a good point, perhaps that would be a way to hook this into LAM,
TBI, and any other architecture's specific address masking feature.

- Charlie

> 
> Lorenzo also raised some very valid points about a having a generic
> address-restriction ABI.  I'm certainly not discounting those concerns.
> It's not something that can be done lightly.

