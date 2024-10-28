Return-Path: <linux-kselftest+bounces-20793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3221C9B26A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 07:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A001F22D31
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 06:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2394518E368;
	Mon, 28 Oct 2024 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kG3/Gsv5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E02C697
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097689; cv=none; b=qlTOVITHfJ4ECXQuyHhx/h98kcQRhMb+F9qERmUEEoqeQkho3PWNG4zyboax5/jRlK6lM6MCOke8+aYll/amvPwFKnbZMuNBUzoOuMiEFtvZns6tThCsDBCMjCAUElal+Xij5V7uoU1YwYTUD6ScAqtzqx0tx1dCuR1vkhQAIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097689; c=relaxed/simple;
	bh=NS+Tuf100NVa1bY+369mrzPv7GRrI/vVftNytsJXNYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIHLqMBAfFuPU9ZjrLxRJP7lkNf0ruv8YVepc9zWTaEI/b57tjye9CX7DiZsoxD8GzVetqYnvEYJkV8IPAdLs4V7aCM0xUiH7GGTg+B8sgbjO+EV5jRLDei6O2IEMWIbrFX4dBVWgQWlRji6JWZS1BdkPSdFb/opsOj/HuyvIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kG3/Gsv5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e63c8678so3819748e87.0
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Oct 2024 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730097684; x=1730702484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NS+Tuf100NVa1bY+369mrzPv7GRrI/vVftNytsJXNYU=;
        b=kG3/Gsv5K4JJHq8dpeTQ/s4O5B5HoKB8WD52ygd4YkwV3iniipVxHtWN5npoBdtOdy
         yX6ZLUagY8ZBZXc6QcXGVDLP0518bU/fHNDoiQQ2hWzq2nSOA4/LxrXpGZDa1zNSxp2g
         +Ja6x3uFSpeWCO63hKUmKQ1dbRW9OS3QXqFfGTFqNpuii/rmw8bT16oDl4U/EI9ptuXZ
         7u3Iu2w17Zv+e0VjPhKzAp7WLXNOutU+ByZt0FraH2NQn6SVFL/YUp/jOBT0wqrZmBPd
         M39//XZB/Qcy5YrYVYQPDHnPzcJQ/rhaPT/5lKp3KcVQ1XEJahVdw4pkEcrofrJFy7Lo
         nAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730097684; x=1730702484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS+Tuf100NVa1bY+369mrzPv7GRrI/vVftNytsJXNYU=;
        b=HgeBsgY/7krGIUyVkXOD7Ua+BTZKxyA8+4TZCj30djoo5t7B3WR8gJvF2Bka/Bv9Xi
         A0T0KkeLTXjdNa39EeEp0XzGFvTd8WwLkD2ASJUClhNQSrYAI1ADd0eAOLVLC7PlBihz
         6YMxbJk532kNqmXI3Fi9zIB8Xyl7Kap7JEGe6f0PwL2rMO41bImcQT3J4CZINb/MuEun
         JA7eLYp4c+oRvsk+bZkJeQZFkO765+Qc5DtxDrTe9mEETHAQJ+l9ZdrQ7zAIgnCrkAD6
         u51odcv4yorApnJrltcQHUNzThE6sFalKX5stNyZu25tUG2T9qlWXB8yjEThj13Kvmva
         DSFg==
X-Forwarded-Encrypted: i=1; AJvYcCUaWmJ9iF+fJjOUGr/bCnI8o2q0lzRU81CqrU7Ws5ezcXG/JYlhXrttIjGlYYDMMKIwwyHUo0S+lisboY6dw0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8/G9E4PQL3YZ2RFI6wlRXyIo7eBc9maHcZjrbvIRrqU0FNqB
	h0QLsHjj/cq4/knq4go6bUO7ahUnRzUzMnd9i/8ralHVJs4h57ngMgxI8ZDhtsxbFhUhId+TH5O
	z6jHIQM/2ojhcWXWWMQRC2t4OlJBdBGz4JidW1Q==
X-Google-Smtp-Source: AGHT+IFgFEA9LsVMQUWWo/dM/XVqyt5Trns048cVWzUxR/mKJTkgDk+3ErfamKRGebF05Z9nNEe+Ai1eCzQr3FLp3x4=
X-Received: by 2002:a05:6512:3d93:b0:539:8bc6:694a with SMTP id
 2adb3069b0e04-53b3491e22cmr2604980e87.43.1730097684106; Sun, 27 Oct 2024
 23:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912131729.14951-1-yi.l.liu@intel.com> <20240912131729.14951-5-yi.l.liu@intel.com>
In-Reply-To: <20240912131729.14951-5-yi.l.liu@intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 28 Oct 2024 14:41:12 +0800
Message-ID: <CABQgh9HvJLJ9Zsa69oHiNSPaRr+NGhrbY4n-80kNWA+DA5W_ug@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] iommufd: Extend IOMMU_GET_HW_INFO to report PASID capability
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com, 
	baolu.lu@linux.intel.com, alex.williamson@redhat.com, eric.auger@redhat.com, 
	nicolinc@nvidia.com, kvm@vger.kernel.org, chao.p.peng@linux.intel.com, 
	iommu@lists.linux.dev, zhenzhong.duan@intel.com, 
	linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 21:18, Yi Liu <yi.l.liu@intel.com> wrote:
>
> PASID usage requires PASID support in both device and IOMMU. Since the
> iommu drivers always enable the PASID capability for the device if it
> is supported, so it is reasonable to extend the IOMMU_GET_HW_INFO to
> report the PASID capability to userspace.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Thanks Yi

Have verified on aarch64 platform.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

