Return-Path: <linux-kselftest+bounces-27956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4EA4A874
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 05:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E403BA130
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 04:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61E1AF0D7;
	Sat,  1 Mar 2025 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqxEFTN4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CA132122
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Mar 2025 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802576; cv=none; b=RXPtkMHTJA6peUtrz4C4xZBSk6k3ybLQvfBJUH+NXER1FemIaT/HsBvK/2QthJXjdCeH9m1IOcYKV31SGI161TDHQJT+Ab2JAPFjjAWSWtCYtThq2Z46xh/wJ81WA7atEDFk3HDX6zIc71E/0W6ZTf1nIIQ6I9UNZ8LbhHgG8sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802576; c=relaxed/simple;
	bh=nRJXVNbZUpNIBtt8TFs13UDH3fN+Tw1tbm1ZW4YHs/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIoovfJ6Jgc4CJnv+I2kGmUB/oLaLbOQBkiVsspYNgxEq19/a4hu0cnH5ljyZZm0J4x5vwXDf3iIvsktO/E6uPBFjpNJAeJUoBv1xayW2zSL9hEIQjqrKDBPxAMLkTeQM1lbqd/gIuo5vj2uzKgt1mRdavbzvXcG1pQ+y/Fixx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dqxEFTN4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5494bc8a526so2009646e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 20:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740802572; x=1741407372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nRJXVNbZUpNIBtt8TFs13UDH3fN+Tw1tbm1ZW4YHs/4=;
        b=dqxEFTN4T+LXT8b/WGkWy3B6mb3egi21CVMTXjvbd8GUrkJEp4RsQLMXzwFjABlnys
         EyWGxaN8RxwDJgmT4Ho4J9wQdn5NhnLVV/r6vvH21ehUIR1OdbpsdWZYh9g6Zi+9qQp+
         LYUBFiMTHCdALkboNfGsDFdVXQRS5dZg7VaS4v8L7prSDQbwV6Mg58oFUfDhv0PUyNLl
         8R3nmWcgPsJWIDG/19gPv0zOU5YJwwMDVbJRXQi0GChfB8BxkFjNiDnZzaR48PIQN5zG
         OFhGRLmJiA5uyelk2i5G8lfVUjLjyARxh65oE9aanbQjYy0WMzwgMYwcrkSGtSeedAGo
         KwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740802572; x=1741407372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRJXVNbZUpNIBtt8TFs13UDH3fN+Tw1tbm1ZW4YHs/4=;
        b=eezuclR+R8H+fzD/bRIjCG49YNFDntNfAEbgQFAMDMsiQ/wmBZIUapxlyG5BUQOA+A
         p9qp4N2Yjakb5Xm1OhliPD2QpWyeDN2xBWSzs21V6NyY3gPUrDzKXmh3RSqMPg80BjqJ
         YNYW8NFj5H2bOPrK4joFcV0QDXeZhj2WcHnG7uB3078/uaH1r+EF0Qrc96k43fbX3Pab
         kMXD/5YufwH2mZqiuu3M/LZ8MfVGvJmQmuHfyYlXJyXPPGrwvtL1x7akH9fwV7NI5KdR
         UTMy4qew+Aj5xD7UcjoBGnL6BrGrZSN9uf6P7dHV17fJkN9ejUGfZtYDrBlWSLyqr354
         gNGA==
X-Forwarded-Encrypted: i=1; AJvYcCWM2EN3GaMldBTEQfh537PO/hXX01x5B4hAEZ4V/lFy9xPLSS7Fe50m5RTxylB2XphoQe6auE5SbT86IqID9y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//EARa1xjSlyLackJBNyqyx9bBkqm36BdBHMQHOqdyPUQuaQu
	BwtFvS2TUfXBH6JyjivyPSGK5UlImWacDG817A/8F9uo6WIOKBCZjFrwFlVTHb5N2YPTmZq8cPX
	/n5fP5Kp11STfp0jrv57X0KdGeuQ5ljLS9mDPaw==
X-Gm-Gg: ASbGncvMa7gJMFYL8FIWxUkUaMRD6f8uIoLHsiEh3+x3/Wi6oXELQRXlfYGi2N//OVH
	oTv+aJyV1VCWrXUUMMToKiWrL6rc5GbmgijRo6JMxxf4OSAvSvjh2fLr1jvxTYzNywUeY5jTlir
	mqc1Z46ODPpnf/UX2FM3H8VcQvkZrmK8g=
X-Google-Smtp-Source: AGHT+IFP5aCHULz6zpIiPlJszPYhhIKQa4bjgAfv6H6nwuK5koq1iQ2nHbNDaxSV+n8l900FUXdJNFmIzAGeKlhCAx4=
X-Received: by 2002:a05:6512:693:b0:545:b28:2fa9 with SMTP id
 2adb3069b0e04-5494c122af7mr2774025e87.16.1740802571668; Fri, 28 Feb 2025
 20:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740504232.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 1 Mar 2025 12:16:00 +0800
X-Gm-Features: AQ5f1Jq1aPPNEUtuYw2bvAu1XDeZv-PKWUyrHeAmpxtPMb0nHo1DtYawDISk28E
Message-ID: <CABQgh9FYqzoUxjR246QBPGW9jqngK1JpgfACvBTLTHq-mBBCJg@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] iommufd: Add vIOMMU infrastructure (Part-3: vEVENTQ)
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, 
	joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org, 
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com, smostafa@google.com, 
	ddutile@redhat.com, yi.l.liu@intel.com, praan@google.com, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 01:33, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> As the vIOMMU infrastructure series part-3, this introduces a new vEVENTQ
> object. The existing FAULT object provides a nice notification pathway to
> the user space with a queue already, so let vEVENTQ reuse that.
>
> Mimicing the HWPT structure, add a common EVENTQ structure to support its
> derivatives: IOMMUFD_OBJ_FAULT (existing) and IOMMUFD_OBJ_VEVENTQ (new).
>
> An IOMMUFD_CMD_VEVENTQ_ALLOC is introduced to allocate vEVENTQ object for
> vIOMMUs. One vIOMMU can have multiple vEVENTQs in different types but can
> not support multiple vEVENTQs in the same type.
>
> The forwarding part is fairly simple but might need to replace a physical
> device ID with a virtual device ID in a driver-level event data structure.
> So, this also adds some helpers for drivers to use.
>
> As usual, this series comes with the selftest coverage for this new ioctl
> and with a real world use case in the ARM SMMUv3 driver.
>
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v8
> Paring QEMU branch for testing:
> https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v8

Thanks Nico

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

After rebase on your branch
https://github.com/Linaro/linux-kernel-warpdrive/tree/iommufd_veventq-v8
https://github.com/Linaro/qemu/tree/for_iommufd_veventq-v8

Tested with multi-device in guests, with io page faults happen.

Thanks

