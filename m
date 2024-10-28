Return-Path: <linux-kselftest+bounces-20819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76449B340C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 15:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5561F2247C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BE71DE2A5;
	Mon, 28 Oct 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOsYWneh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949461D2B24
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127233; cv=none; b=AQdh1/JS9l/FMW5hRMDWAKU26k3JKJ14sI653B0rr3ouTNbVhmaFilt67DIQ3amUQSkLnDaBfo6MuclEj9ENHOD7DrGUNl6i4DUphWLOSRG55+FXujiFm0DEsN0tSZXTiks7JhIx2dVeRGN7JWPd9CeES+2Za/2XAmIj+v8orMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127233; c=relaxed/simple;
	bh=tYb/zBUosi1Aw03l7Ek5wmBbG3dG3J1OV92E6B3BlZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT1sPMIHigruzu7Tyx5OUQ3kopUrQfQzaBcQocnjMb10hBKLT2cz5PqMeuO3xuOSJpTwimKTd3i5/fxc871Het6MNkqfupHmow3DyYhkOOnxwbfKfFxad0IfGv9bIXtRISIpgZGHR2vRrWumm9agruKZFdalS0DILbRVdfZVf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MOsYWneh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53b34ed38easo1746566e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730127230; x=1730732030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tYb/zBUosi1Aw03l7Ek5wmBbG3dG3J1OV92E6B3BlZg=;
        b=MOsYWnehb6VWf8PGsIvVUn69xF51tB0HmDEo/UQ2+SwqGQYdZRB1C4iEPBWN0iyiJY
         P2ehIdPgEZJCkfjrJpQJlgwECUAZjuspEFikSZzovExv1gz8ao9SkAIe+oJWcNJi91Uq
         TDWrOyFbwRRV4cZcmdBm0/UWJ7ofQiZaZ/DyWuV5iNolFez6ysj7uaT2CA6K/ruhsb/1
         7mL8sQO6Z9q8G4rs1EJXw1zzZiJ6YAjHQe0nNOxgupCUTVVHWIBfz1dApWYN5IJn+kaG
         2yeolHTZzDT4zRRd2CDXFCJtdxAXoCn6176WODmtLE3CxPeb5BLomdCT90SRscGtNeiK
         Lg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730127230; x=1730732030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYb/zBUosi1Aw03l7Ek5wmBbG3dG3J1OV92E6B3BlZg=;
        b=gOQbHy2KnR/dZHhL9xRPbnB0lNHc6duiSgvnrS7mH1YgD2eP6v9T4nSYSaGMtPWOlK
         IuvCyKUMWnw8JxVJlL9CVwUaDUjaJnC4xxDuZnxaovGiG/6AdHX4elh6HZSGK/cMBbkd
         gW6/Srpn/ESbirPk9+Ut9GMrOexO/qF4wxacb8soBpqQPVpYdBmK6CcVZIy37uxhKBO7
         qXmEIB2FaLh6+LA3xYpxmZ/LgvpkLxx87UL9BGor+LKwS3GnRXWnPI63kRfQyOTJ/oDv
         Kd7xwsFKKRmhhjOtDlG+GKag2lMy+JZuToyDC+XSeUbm8KGTao0YMPhwwwRrqwjq48Xa
         3eDw==
X-Forwarded-Encrypted: i=1; AJvYcCXI/7tS3u30tt1IqJsuWX4rXJFWMI2ZzoHn35PWMBPxiSK162pUcFBARkKTifHaCWCsJJL0eeMIfQYkf3izYuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTngzyyRsIKBiHOpNF2KZv+hgzRqg0wc24JUjR11drW3Snn08
	hHx4+6wyp50n0gzWyfdjzmo2NQYxQVOeOnoGf/OPXCjEONaOSapEQuOKOWWaiXhNjHoiNiTBLFT
	HFtinp2UUowi/3TxfhQdw3VN6KpWz6ZNCatxmDg==
X-Google-Smtp-Source: AGHT+IGlKQWc3SNm51s3PmWaJ7k8IkmWwj+g1zwTCjME9I3N35fBxQXDjWPZqSRQvbi+ZoURs9MmaNgH4mwrA6FxW5g=
X-Received: by 2002:a05:6512:1590:b0:539:f554:78ac with SMTP id
 2adb3069b0e04-53b348b9125mr3453985e87.9.1730127229738; Mon, 28 Oct 2024
 07:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729897352.git.nicolinc@nvidia.com> <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
 <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
In-Reply-To: <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 28 Oct 2024 22:53:38 +0800
Message-ID: <CABQgh9EgXsyHDzZHK2FMuUw-eu9zeczyMGLTUjS3AKYUHKwwDg@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com, 
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com, 
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com, yi.l.liu@intel.com, 
	aik@amd.com, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 11:24, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:

> By the way, has qemu changed compared with v3?
> I still got a hardware error in this version, in check

Found iommufd_viommu_p2-v5 misses some patches,
Simply tested ok with iommufd_viommu_p2-v5-with-rmr, (with some hacks)

Thanks

