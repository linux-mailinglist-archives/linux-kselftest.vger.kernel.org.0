Return-Path: <linux-kselftest+bounces-49002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFED2356E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 10:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF575308277E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC8342509;
	Thu, 15 Jan 2026 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+TIzgsj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FBA341ADF
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467791; cv=pass; b=J/MTfKu6GRjYICBeyLsQWfdH438d9w/9TWU95umWbci43NeHfP6sA76oZ/F4Tp1+11aet5P3aP3IEcxBnfzFM3jPK63uazVZhseKEg7xif3OVlzGTnFpWOcagJ8goPSWSwbSoG7oNQYMts1tFvlbLCDsg+zWrVy6ZxiTXs4ujYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467791; c=relaxed/simple;
	bh=03g5GHo7VUuroNdnNffpeJG0qnrQfvR4X6uMf/z1OKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqwlZRNoT+D/XX4vzuuj2yUd7aFPuG2S3eyPJUfZbOi5liGhW4KGaeoDERi3c79wALN82CoNFFNO8kVBvaAj1hXGz42VfA0zng1AKTH4PEBJxjT3I+60Za26C+DAwvhNMyKQCod7+ZQFpz89Obqrtmvl+6JPTmuIoaZeNqTKFh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+TIzgsj; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-501511aa012so446281cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 01:03:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768467788; cv=none;
        d=google.com; s=arc-20240605;
        b=KdLdLiZ6XtsRh98QP3QHnBMFmJnB4zI7JYEjAAr7TJAtsd2ZeoYKfgoqQbt21DX5Dy
         y4vLTrMM+z+nmx4PnUjAskVVa7plnZq8F1CfO4g3cagr5UOPSlfqEnYs9zLsEFPfnYxb
         qwHRQOOiNn7VPlRwGDocTv0zH01LiVXatvIz4M+B/pzMdTv08xpN6+PV7NeHevPAS0LL
         uBCFDwnDP08FKiYZekrOv85MKA84xuYLHY8bMH6QTu0YS0NcVPUp3nKfp/BXUlWgwsjQ
         nOU0nZ4wMx3TzhyBuvhiQcJvEWTFFvpLBufMR5dnJuhVwH/W8978U/LXa9oivBRTIeip
         jY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jaHTBHlKT0XpapwOdZ2HklxNZ/MZMO/Ynn29Wqw5zNk=;
        fh=81mEk9VEKnuHL/Mz+ktt3OJf8XRdrsKwKJgF/vVMDgQ=;
        b=J7sNu2ekg3RClAbRFU/B4DqScucIeWFU8jwx7z5CNwRzUbrsbn2uBpz+njJw2rlqgQ
         p09QxEJ5iS2VhybOCB6hlViJknmCo/aLSl3zIN8fVsGysh4ZGL35FEsu1tSrKHLLFfNK
         QLqaIHOE7RfIbgh3bJ8eYeGNOx5cSlEIVKwp7vQmpUb/dHtA8r5PITPV2/RZ1o7BVDR9
         FLYQFd0bu+SIzrWNtmtRXsYP4siaT8iNxHcVeCZ42gl58YT+p4yycIHsLrpJZrljRGys
         oR07YseJl5NnFCvidvSe9IRWuKRb3+/QDAo11+XtUfY+hvV2bmXdTjVVu4wnJGsZ1x2B
         VsFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768467788; x=1769072588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jaHTBHlKT0XpapwOdZ2HklxNZ/MZMO/Ynn29Wqw5zNk=;
        b=Y+TIzgsjwX0wqyLVxHk1V9ZPIbOXuA9OZSYYibpJez1wFrkQujaRFOo5p1sGkl6fgj
         LU6bpaiZtR9+7pL1gjOyJyuMOP3+ihoibFETGmuyNoIdjWuuJMXbCyr4Z0P90eaN3eQB
         h9hvaEOE47igHK8xd1x0aJZVoURBgg5zQ7CWNpwwoIkD6AXlhTuUDHnNPS+rm+VV+NH9
         8rZx9qCAkzjg7MVA5OjbSq2lhVvt5AN48pR3jVKYjqHQbBmAnYwClOtgLMh9YaWZ83Ui
         JF5XEiFMQsi2pbet37O5LZz/pNq7yUnZnGk3uMpUT9MGOrDvvI6oquIOHZwLBBodRCBc
         rtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768467788; x=1769072588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaHTBHlKT0XpapwOdZ2HklxNZ/MZMO/Ynn29Wqw5zNk=;
        b=bCTGJ9ixWJyucyqN5fXSV+sXj9L2VhM48zOiwQcciOYes5/zDdoCagX8DPalGPvK9Z
         uNQkiLkRpoSuD4kUBPSrNmp4MBgEXTkcqZYKqgYFdUsuX+MGKsBEMVpyFtAJ+fCQgMS9
         YHluQ4PZ1WAAbqghOiREQYlGBSuBQySlm86VfI9aQhZtl/P7k08Xs6Hu58gfpRKZWhyC
         ggU5zStVDKG8HaOfz1lmOPMdmmQ0LjpQOhs3u/+GqvGvpuIGmz+GbtW6KYvS3B3d5VMW
         6CICCHarI0gOlgH4bB45Zese0aB1CcbjqSh/f1f5dX0P5giDG5PeKJqtNMkPc839Xcew
         mLGw==
X-Forwarded-Encrypted: i=1; AJvYcCUzV5TEy+SKQdkcv1EV4MmJFf8t55W4d0fW/YBNqCOHJ+izAcfU/DJhQSifUQDoQugxV5eQapcVyvZK7rE3P9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOaHsUUe9Y0V4CXTub8hZ+MCRGEzgmbGvcYiiHUdjd5N92vfL
	QYzBhRjo2kx3wq3cmJIOOo7F11oxodEE0i05fP7BWtYTb/UOPMUM5UVgFGSoxEgpLBxW49Rh4eV
	iadpwWi0v6hN+rhxvCukc3G0hUpAp1nvjIqm9sLVL
X-Gm-Gg: AY/fxX633pZZHkoh7347uKHJdY2OripyQY9ez1sif3R58HLN7zUokqnfIBenfXCROVa
	TsamlAnRTtyF1PXBViec3gffh3HtWHUXhO1LIXbVtM6u4rLbPrJcn1Wz2moAmJkaLiT+uPNjGVL
	Kf76ZTbBeJPB1UZAsp8211AH05i+rZlGHyhsvblfUVQ32Neg+BdZyG0BGdjyX0be94ftbDQguPZ
	qz1ntAT/DkTApNGHl/lxnJhV7JbUD9Rp6/SwMqGuQaHaA4s90KyWKWHeM+2HebDcYGaaXwh
X-Received: by 2002:ac8:5dd3:0:b0:4f0:2e33:81aa with SMTP id
 d75a77b69052e-5026ed4f925mr5343061cf.11.1768467788106; Thu, 15 Jan 2026
 01:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-23-8be3867cb883@kernel.org> <CA+EHjTyYcrWwBR0AwwdWFfOSwbmTMOhSee7y_-vrMfOxphrvqw@mail.gmail.com>
 <5a053bb6-5052-4664-b0cb-f05d56d4679d@sirena.org.uk>
In-Reply-To: <5a053bb6-5052-4664-b0cb-f05d56d4679d@sirena.org.uk>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 15 Jan 2026 09:02:31 +0000
X-Gm-Features: AZwV_Qg4xCZRn6ebTpsQyf1oiKPYkQGhv7VLsovgzCpdoBOU9QpCHpXoiLQKrWU
Message-ID: <CA+EHjTwMs6BzZwtcNjyZnxLb9Gs01B1RcDvo1RB-f2w98eMzFQ@mail.gmail.com>
Subject: Re: [PATCH v9 23/30] KVM: arm64: Context switch SME state for guests
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, 
	Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 17:28, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 13, 2026 at 02:24:56PM +0000, Fuad Tabba wrote:
> > On Tue, 23 Dec 2025 at 01:23, Mark Brown <broonie@kernel.org> wrote:
>
> > > +#define sme_cond_update_smcr_vq(val, reg)                      \
> > > +       do {                                                    \
> > > +               u64 __smcr = read_sysreg_s((reg));              \
> > > +               u64 __new = __smcr & ~SMCR_ELx_LEN_MASK;        \
> > > +               __new |= (val) & SMCR_ELx_LEN_MASK;             \
>
> > Similar to what I pointed out in patch 15 [1], I think you need to
> > preserve the other bits, since SMCR isn't just about the length.
>
> This does preserve the existing bits?  It reads SMCR, masks out and then
> replaces the length.

You're right. Sorry for the noise.

Cheers,
/fuad

