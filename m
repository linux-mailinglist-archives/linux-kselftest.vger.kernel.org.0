Return-Path: <linux-kselftest+bounces-35869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9451AEA387
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993331C44490
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0C2ED878;
	Thu, 26 Jun 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+kHMsd2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6A2ED867
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955391; cv=none; b=TE5R+hZkIJjTSUNwGrKFN+JTgXzP7hxAM8VDVoP9YiaYlV2fD5iXJWhQihnI4TbDqrpPgpX3qaZgF4UCSRTuvuQqghE1LBhf853IoTrNYc5oM22fJfbpM5DuinG/I4/aitBk+VvpI2qSlF1noMPHcHEYeIwNarO8sWUC8hfukZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955391; c=relaxed/simple;
	bh=AgCtIvqoexub9Qv7N/AgH5wxwMGGGs/6YulBNCxbeCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9j0AbAsotVxUF9xn2707J8DPdMmJPYy6AW4arVwVF2SUr9pecdJg7BeQy8avIWhIwumuDFdKEllBPfaxm+e5AHhcvXAz/+eeWBx/nINsG7Db3s+P4BaeaiDDBpiUaaoNpH1GfxqTpQXHQP0tMb62iTY5kAJ0+7GPssUHaPNbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+kHMsd2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b7123edb9so11027641fa.2
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750955388; x=1751560188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhgWMpVftN0BXlOXEuQTKXHJQDcbuJWCCJBvXCzzlws=;
        b=j+kHMsd28pa2eEUT5k7m2NZt/ZYbHThGKY2Gc38l8n/zflNGyorZYxKAY08FzUTPv0
         jS+acmTxaThxS6o1SDFjXyCJw6Bq5AesRY/hGPjzZQFvQMIu6Frw3qbO9EtbYTrWi5YD
         CLL4kBT4xsSGpItx98cFM1E6CAy6JgrS0XY1BOUTleTSU7HUD/svSvg2FLqjK58TXad9
         hIWcAYnsWPpgQ4FGvf8YsnLfpslaj3hqZcgbMuMz+kIbDSCJtKj4c3OIpDKjaL9n7nld
         4i9uImBbIHzgen3TSbbjfJI404hM1o3h6ViVKDHnmAaXBwTprsgueR0806w+AxfCQNWn
         e+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750955388; x=1751560188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhgWMpVftN0BXlOXEuQTKXHJQDcbuJWCCJBvXCzzlws=;
        b=X2phU6e1wNiJOF4HJSzMl6gnVgCtO9+aefwmMYVgSvuLv5WRc5KEONDqtLAyDxyiTE
         QDKGXElRP2OULE+gMR9k2Nr3fdqaGJEYcHkJTodIcoFJ5/x489hvoQFSMkADNT9cCDfG
         ZlZgbHvJRPfqUUbIBSxiRb/MMEYB/PqTiyFxpmp8pIxKkNIAnt4eEbqPMBDlxjf9IdYh
         nodyCwkK7+7pgBRelSwln7675egdhgFFIhR4ZZGaPUgr8XD18HPjMVA1IH+wvo9ELPNr
         6mLbcygx+lNZH2hPfw9GiOXKzLnYaGzF7zx2NGhznIpPxr2/JVbKgkZLoi6uZtYuM9nh
         ZhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcykMqgjINBpQWrUpvm5PfDVoIFFTmWPtm+7u4iV4BkuyHVmyu4oVkzHJ+ot46X/rQvmY7VyF3+JHsM+QbCS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFLfVnVW/ro0R6J0qV3+BLolOgdk7J/CibZcM41qNrD/lqczj
	WMK+1yfUw/YWxzY5FU9Ktx0tsAZDGKZZ9hqulXy8GbaSd5+L/421w1mQ4alsucdli+E93oDAWH9
	X5w29UiNelh7beEO4rf3SjfQks2twZP358AkHzGHZ
X-Gm-Gg: ASbGncs5U3YHYbed1EAkF4UjzQYfNIQfm8uekI+FanZr18D3zbE8wBcWHTPo0x/2NEY
	nii8NS2a/QK9kUnYHh3MWn7Pm/TYyiSlGmmS6g95/xLbqA4ksw3C49hr28qdPzwABowkIvfOR/x
	x14pSAEqy8MLKEj46TQqhA9nBModiIQYO9daJDC5T8AO0=
X-Google-Smtp-Source: AGHT+IEEwFR4Q1I48a+7OABIyBDRSlZA5tbdQsFM85tiZhc32of4fKA/nSlskPFcjFXcvfWw+C300VPrlQj8CDH2vFU=
X-Received: by 2002:a05:6512:3d0d:b0:553:2159:8718 with SMTP id
 2adb3069b0e04-5550b9e9f76mr68343e87.40.1750955387360; Thu, 26 Jun 2025
 09:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <20250620232031.2705638-4-dmatlack@google.com>
 <fe4b1d31-e910-40a1-ab83-d9fd936d1493@amd.com> <4aef95a0-a0de-4bd5-b4ec-5289f0bc0ab1@amd.com>
In-Reply-To: <4aef95a0-a0de-4bd5-b4ec-5289f0bc0ab1@amd.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 26 Jun 2025 09:29:20 -0700
X-Gm-Features: Ac12FXxh3iVx0ijncX4D0ghMn9yxTN7axomwuLA6jqvWOXSFOfPrvAPiEnHLUx4
Message-ID: <CALzav=fZcLpQ+9J=XOZ-=Cr1UA8qKa5NHXB1dJpqhCp7pee7Ow@mail.gmail.com>
Subject: Re: [PATCH 03/33] vfio: selftests: Introduce vfio_pci_device_test
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 4:44=E2=80=AFAM Sairaj Kodilkar <sarunkod@amd.com> =
wrote:
> On 6/26/2025 4:57 PM, Sairaj Kodilkar wrote:
> > On 6/21/2025 4:50 AM, David Matlack wrote:
> >> +/*
> >> + * Limit the number of MSIs enabled/disabled by the test regardless
> >> of the
> >> + * number of MSIs the device itself supports, e.g. to avoid hitting
> >> IRTE limits.
> >> + */
> >> +#define MAX_TEST_MSI 16U
> >> +
> >
> > Now that AMD IOMMU supports upto 2048 IRTEs per device, I wonder if we
> > can include a test with max MSIs 2048.

That sounds worth doing. I originally added this because I was hitting
IRTE limits on an Intel host and a ~6.6 kernel.

Is there some way the test can detect from userspace that the IOMMU
supports 2048 IRTEs that we could key off to decide what value of
MAX_TEST_MSI to use?

> >> +
> >> +    vfio_pci_dma_map(self->device, iova, size, mem);
> >> +    printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size,
> >> iova);
> >> +    vfio_pci_dma_unmap(self->device, iova, size);
> >
> >
> > I am slightly confused here. Because You are having an assert on munmap
> > and not on any of the vfio_pci_dma_(map/unmap). This test case is not
> > testing VFIO.
>
> I missed to see ioctl_assert. Please ignore this :) Sorry about that.

No worries, it's not very obvious :)

vfio_pci_dma_map() and vfio_pci_dma_unmap() both return void right now
and perform internal asserts since all current users of those
functions want to assert success.

If and when we have a use-case to assert that map or unmap fails
(which I think we'll definitely have) we can add __vfio_pci_dma_map()
and __vfio_pci_dma_unmap() variants that return int instead of void.

