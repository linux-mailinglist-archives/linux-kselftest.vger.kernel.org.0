Return-Path: <linux-kselftest+bounces-42849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E5BC24B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA45E35020B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B11FBE87;
	Tue,  7 Oct 2025 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IVj1OSui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE221DF26A
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859135; cv=none; b=s84AvKs0hdXIlzHZA9/Jg7t7FRjXvjVC5POmpSNDx9XErvFeDE0sU4Pd2RSxJQ9D/uq+micNfzsE74UiDGISQKYj2FL2OgMrTxzv+Zp/vNrjDNuYxneAduEU5HXtpPIPyKjC3WMCfaQoA/fmjz80F51qo+zdS9rQOtI+/1vgGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859135; c=relaxed/simple;
	bh=A9ePXX71Y+LsTLae1xp4zR0f461PjyxprdjUgwTk7fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAuzToQXY5nD2A75hJKQqE4DzGbJug9rdCx4Kzovp65oe50Ojqun7V7bcRYYgrnBnOSKHH9mnseI/ukEMlGkzy7xkRrQe46BDQ2ND0JLihcKwTiYpXOXtBrmDNROM1XSNbiFsPRNPdUH+NmhEyQzAxeu2ommPY74v6kf8wA1hP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=IVj1OSui; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4df2911ac5aso40677961cf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759859132; x=1760463932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pg8Ok5I2xXMgGAu/MYDoh42vS3DGGi3CdtYED5anodk=;
        b=IVj1OSuip0Tb0+Yf3E2iRsjnfBHmc/0mPSPh3MHPVQpfvbrPHU69v+GkcKagqs2wZA
         PL4FBiXnakC3/aCRB/7VsFKgBbZpY8rcVUF+qzVp/KF+QMo9rRkgopdts5IVUUxtvch5
         2S4fpHQqPWuQwqamtIGZ5Ee4Dm0wXKipuzpGtks8KhRhyNh0upgL+S4Cs5JH1fjFO2bv
         bR6vzTleoUtfxBXcslvcCtJqp7QbSAgUPI6iZQ3wqHBgh7+TQFPJGODYi/H4RMzYe0/k
         OzuAtu7PuMf43mPFa/z25th3H/0oIprKlSXH90c5HcXwrILnc56CZq3L9VHo4rU3Wo/8
         M41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759859132; x=1760463932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg8Ok5I2xXMgGAu/MYDoh42vS3DGGi3CdtYED5anodk=;
        b=JPOqZZ9l9plGmxngMD1qqWtqc7H2e6uKcbFmHWtuqvsJs0JfoMDI0JP6vJ0+uDmdp0
         ae+pfLiFP4XtG7jBhPb+KuMLXIiDj/mYyHw2QupeUFQLEP/UdNhovzBcBNaxopYM9cdN
         BL+fY4i1ODUk+blYRGhGqq4XpyfV8Pru9FB6v0TzjKPz3x7o799K7Xtrt5U1JzoqYouU
         iLsntnohCwazCjw+AVlbJr13p7pXV+Acc0P15T06jfdXgG6vkY1aqim91cMlW1vYWVOn
         /fKbIe34WSGIZXNc7Auj2r3H2F0cl+9uROS3mV/xYjaxtp48VwlQJ9Z900zgbF+gFpyW
         Nczw==
X-Forwarded-Encrypted: i=1; AJvYcCVcX7DOFDswmLtGG1eviezyimFQ2k8261ZfaYDhrsohmQeYMr00HFjWPBAx7cSDaRaRVw9shqKgQdhfwcgqTOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiAsI2xlMCL3kkPzGVaxEYfQb7qE6BLZNfPLfr2t0OmfR3Ag4
	DjT/tTEwB4eohcqyEDeTaqyMhPUOmeIDMH6i89h+Q/E3RObzK31Cla0NjyKmYDJXFAaWKbjnYWA
	ls4ejqVyt3f/a/k2bBEkTqB9jqM8zxEkhJ27FudKfPw==
X-Gm-Gg: ASbGncu0QZTV/ifQsLOYOQOZAmfYDbdMVTvqtCHLg6oxQABisTpdi1Tuke3rjwNQlT6
	rVmZHdIkILfgdiTmuT72O9OAL4hzak6yZoUQqkT8V2aN0htpfM6IwB2iOpMZZT+cWX8UMNbBjhy
	PUCgHqd/+1cKHrUCqRGLY4sZliA0n3ttJPvaMu+OunQ8Ce16MmA85ycyb6Nki15K1KL7V8vZY/G
	FB/ZQUZLvaxr0YcR4Zlo2omsyMq
X-Google-Smtp-Source: AGHT+IHNjzqpOMzH8y9LtPxqns/WAVziX7arXy0dAsX1RKPk6LIPf4fgO+HjB3KbrVxZePVT+qHVLaK+4PsanmQvw4Y=
X-Received: by 2002:a05:622a:5984:b0:4cb:57b4:4d6c with SMTP id
 d75a77b69052e-4e6eaccc73cmr6198371cf.12.1759859131884; Tue, 07 Oct 2025
 10:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 7 Oct 2025 13:44:54 -0400
X-Gm-Features: AS18NWDVmKIn_CzJQvh8opoEabYMKh9EbkUyk4WKvUuBQpzLn_UekMBEkXUqjwM
Message-ID: <CA+CK2bBT80np3hZbSu=dRH8UOKT9RruHF3jtaXyTJUmNe8UfFQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] Consolidate iommu page table implementations (AMD)
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 12:12=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> [All the precursor patches are merged now and AMD/RISCV/VTD conversions
> are written]
>
> Currently each of the iommu page table formats duplicates all of the logi=
c
> to maintain the page table and perform map/unmap/etc operations. There ar=
e
> several different versions of the algorithms between all the different
> formats. The io-pgtable system provides an interface to help isolate the
> page table code from the iommu driver, but doesn't provide tools to
> implement the common algorithms.
>
> This makes it very hard to improve the state of the pagetable code under
> the iommu domains as any proposed improvement needs to alter a large
> number of different driver code paths. Combined with a lack of software
> based testing this makes improvement in this area very hard.
>
> iommufd wants several new page table operations:
>  - More efficient map/unmap operations, using iommufd's batching logic
>  - unmap that returns the physical addresses into a batch as it progresse=
s
>  - cut that allows splitting areas so large pages can have holes
>    poked in them dynamically (ie guestmemfd hitless shared/private
>    transitions)
>  - More agressive freeing of table memory to avoid waste
>  - Fragmenting large pages so that dirty tracking can be more granular
>  - Reassembling large pages so that VMs can run at full IO performance
>    in migration/dirty tracking error flows
>  - KHO integration for kernel live upgrade
>
> Together these are algorithmically complex enough to be a very significan=
t
> task to go and implement in all the page table formats we support. Just
> the "server" focused drivers use almost all the formats (ARMv8 S1&S2 / x8=
6
> PAE / AMDv1 / VT-D SS / RISCV)
>
> Instead of doing the duplicated work, this series takes the first step to
> consolidate the algorithms into one places. In spirit it is similar to th=
e
> work Christoph did a few years back to pull the redundant get_user_pages(=
)
> implementations out of the arch code into core MM. This unlocked a great
> deal of improvement in that space in the following years. I would like to
> see the same benefit in iommu as well.
>
> My first RFC showed a bigger picture with all most all formats and more
> algorithms. This series reorganizes that to be narrowly focused on just
> enough to convert the AMD driver to use the new mechanism.
>
> kunit tests are provided that allow good testing of the algorithms and al=
l
> formats on x86, nothing is arch specific.
>
> AMD is one of the simpler options as the HW is quite uniform with few
> different options/bugs while still requiring the complicated contiguous
> pages support. The HW also has a very simple range based invalidation
> approach that is easy to implement.
>
> The AMD v1 and AMD v2 page table formats are implemented bit for bit
> identical to the current code, tested using a compare kunit test that
> checks against the io-pgtable version (on github, see below).
>
> Updating the AMD driver to replace the io-pgtable layer with the new stuf=
f
> is fairly straightforward now. The layering is fixed up in the new versio=
n
> so that all the invalidation goes through function pointers.
>
> Several small fixing patches have come out of this as I've been fixing th=
e
> problems that the test suite uncovers in the current code, and
> implementing the fixed version in iommupt.
>
> On performance, there is a quite wide variety of implementation designs
> across all the drivers. Looking at some key performance across
> the main formats:
>
> iommu_map():
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     53,66    ,      51,63      ,  19.19 (AMDV1)
>  256*2^12,    386,1909  ,     367,1795    ,  79.79
>  256*2^21,    362,1633  ,     355,1556    ,  77.77
>
>      2^12,     56,62    ,      52,59      ,  11.11 (AMDv2)
>  256*2^12,    405,1355  ,     357,1292    ,  72.72
>  256*2^21,    393,1160  ,     358,1114    ,  67.67
>
>      2^12,     55,65    ,      53,62      ,  14.14 (VTD second stage)
>  256*2^12,    391,518   ,     332,512     ,  35.35
>  256*2^21,    383,635   ,     336,624     ,  46.46
>
>      2^12,     57,65    ,      55,63      ,  12.12 (ARM 64 bit)
>  256*2^12,    380,389   ,     361,369     ,   2.02
>  256*2^21,    358,419   ,     345,400     ,  13.13
>
> iommu_unmap():
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     69,88    ,      65,85      ,  23.23 (AMDv1)
>  256*2^12,    353,6498  ,     331,6029    ,  94.94
>  256*2^21,    373,6014  ,     360,5706    ,  93.93
>
>      2^12,     71,72    ,      66,69      ,   4.04 (AMDv2)
>  256*2^12,    228,891   ,     206,871     ,  76.76
>  256*2^21,    254,721   ,     245,711     ,  65.65
>
>      2^12,     69,87    ,      65,82      ,  20.20 (VTD second stage)
>  256*2^12,    210,321   ,     200,315     ,  36.36
>  256*2^21,    255,349   ,     238,342     ,  30.30
>
>      2^12,     72,77    ,      68,74      ,   8.08 (ARM 64 bit)
>  256*2^12,    521,357   ,     447,346     , -29.29
>  256*2^21,    489,358   ,     433,345     , -25.25
>
>   * Above numbers include additional patches to remove the iommu_pgsize()
>     overheads. gcc 13.3.0, i7-12700
>
> This version provides fairly consistent performance across formats. ARM
> unmap performance is quite different because this version supports
> contiguous pages and uses a very different algorithm for unmapping. Thoug=
h
> why it is so worse compared to AMDv1 I haven't figured out yet.
>
> The per-format commits include a more detailed chart.
>
> There is a second branch:
>    https://github.com/jgunthorpe/linux/commits/iommu_pt_all
>
> Containing supporting work and future steps:
>  - ARM short descriptor (32 bit), ARM long descriptor (64 bit) formats
>  - RISCV format and RISCV conversion
>     https://github.com/jgunthorpe/linux/commits/iommu_pt_riscv
>  - Support for a DMA incoherent HW page table walker
>  - VT-D second stage format and VT-D conversion
>     https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd
>  - DART v1 & v2 format
>  - Draft of a iommufd 'cut' operation to break down huge pages
>  - A compare test that checks the iommupt formats against the iopgtable
>    interface, including updating AMD to have a working iopgtable and patc=
hes
>    to make VT-D have an iopgtable for testing.
>  - A performance test to micro-benchmark map and unmap against iogptable
>
> My strategy is to go one by one for the drivers:
>  - AMD driver conversion
>  - RISCV page table and driver
>  - Intel VT-D driver and VTDSS page table
>  - Flushing improvements for RISCV
>  - ARM SMMUv3
>
> And concurrently work on the algorithm side:
>  - debugfs content dump, like VT-D has
>  - Cut support
>  - Increase/Decrease page size support
>  - map/unmap batching
>  - KHO

I'm wondering if this work could be used in the future to expand
page_table_check to support IOMMU page tables. For instance, every
time a PTE is inserted or removed, an external state machine could
check for false sharing or improper logic. This approach could
significantly help with preventing and detecting memory corruption
early.

The main requirement would be to define a common logic for all IOMMU
page tables. For the existing page_table_check, we use double-mapping
detection logic [1]. If we were to implement something similar for the
IOMMU, what kind of logic could we apply?

Pasha

[1] https://docs.kernel.org/mm/page_table_check.html

