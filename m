Return-Path: <linux-kselftest+bounces-23603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746509F7E95
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A347A2037
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067C7226531;
	Thu, 19 Dec 2024 15:55:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C547226163;
	Thu, 19 Dec 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623709; cv=none; b=Jde7BEs9aFVrTCVzRwvjSn0KliWNbIwB5VMB+uZno4CSfE+klBCMsavxDRSpPpGRSkSCBl+y38Ykv8hTDluJ8RQyxHwBFnhxnsnbDpALnlLrv7snXgPzRAQJSQEMEAl8QMFYq7ogif836Xo/LDjiyau21hN4ayCv9PVaYmk7n60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623709; c=relaxed/simple;
	bh=GQqf1fRpSu/2k+MlXCkD0lKi8IukdszBOzdqzf5L/qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebSijicMshVwZuHOrygHvcucVVGoM3CI5csmmHb5mf9Th5v0zSX1RtButIixFh+zGvL0b18LTkuHAxZlk7SlpIqAj/OrdlHQZefRSYpEGsIiw0ac90YrrNpt0RYS7+x434XtR42OEVPFhQnfwvcHff3+9XNjr6ZpAT95leSt7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so632845a91.1;
        Thu, 19 Dec 2024 07:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734623707; x=1735228507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t6Jq4KRiIS1xK87Xyuxl8mXW7KiJrj7EInR2tG+Z7g=;
        b=dqU0IYeeJU17I4WNQzZxGb46jc1SabHf+GGmbikEeQpfd2EJF3LQN23vWewo8HDeqD
         ElZCuLeBuS5NNbPFiTjwbFfZaCRmL9En0P4Ta6DsQSngEr6DbYXOlW8OVpd44K0MP2Ch
         s68TB/kWZjbH4dA9/Pe0osNPguycR9P77iy341d+CqJry8FWMbJSMytZv4oN2Ay+oBzk
         BtfCaFr200PzMSl0X2VZK1mr0vPmDrZ1IDAQ+XL82VstIW8ZvKHBz4fvVCesjjeGesi0
         2Hv5+T2blDJiWk3dPLAx77WdfI07T3XDAsDyiVukJIdagvTmDuRbNnfvwFRmwzya0kFM
         1j5g==
X-Forwarded-Encrypted: i=1; AJvYcCUircVSz0u6nMP60xB5mB/KX65JqojlK+4007NtpxklSldtXjNsXAgN4rDeUS3GWyr8KsTOsS4SGCOO@vger.kernel.org, AJvYcCVOuSfWRYyULQAp7CS5SsNFBfTwcsqUwEg3L3JQeHWRCcpzOL1vctH9QlbHP+lXsZY0rJD29O7NAU6TMSSM@vger.kernel.org, AJvYcCX3YlcTaZlZtbVWbixkK/r8n8CsLMYvf4bKWmQyn5LGk6Jhygk3IJ4e283TnZGC/me1TRJBvRtSz+NRVsExv0Jm@vger.kernel.org, AJvYcCXfNoGmGKDq7aTrlT1dvHXqWQ/KTvLtIs9yLzHu1eDrlimOgIob9KNak/s9ntasBsomb6Hwbm0CzSIeaLOG@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3qn8Gp/gpkRcX6x8P5pTR1Mf136LJgMFmA2CcAfvPBJNwwW9
	D4QU8nitG6cxmZYUxD6Yet89/IJYAJs5LmX81A+M59dVVGJS/ypn
X-Gm-Gg: ASbGncvJSPOaagEQDQtPB58vL4X+qkQvP+P7vvPkECrnWOXK6KVwgJWZZ1Img69mI4H
	79O9la+AukPzK4mv8xe0X5RdRBon2Hzp6Bqb+vSy81L5XM43zc33CpmxAqxOzUqUtKH/u72NPMs
	2PsH7XL4c4LvM1a9wapJzoM0TyiBMsZWmINCkxhBIxY3ClCDGngvaNpmjEOt8hktV/4Ga9RZpwo
	yvDRIGIx6SKAfLOHPqZKhXjoB523Woii0+GDVsGDKGEU7rVMXURoHnxrfpSxWZgL6tfarKIfgPS
	fC5gyq2bPS64kHA=
X-Google-Smtp-Source: AGHT+IFlQFnGW0LCelWqxYVDXsvjMbButg7GSvf2SPbqNdVqeI8uyNyNcjur3wHNigpyGQThVq+77g==
X-Received: by 2002:a17:90b:5484:b0:2ea:853b:2761 with SMTP id 98e67ed59e1d1-2f2e93865f6mr11139181a91.37.1734623707451;
        Thu, 19 Dec 2024 07:55:07 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52d27esm3505678a91.10.2024.12.19.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:55:06 -0800 (PST)
Date: Fri, 20 Dec 2024 00:55:04 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	gregkh@linuxfoundation.org, arnd@arndb.de, lpieralisi@kernel.org,
	shuah@kernel.org, kishon@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <20241219155504.GA309825@rocinante>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
 <20241219000112.GE1444967@rocinante>
 <Z2QuORW5kXSrc1AX@ryzen>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2QuORW5kXSrc1AX@ryzen>

Hello,

[...]
> > Applied to selftests, thank you!
> > 
> > [01/04] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
> >         https://git.kernel.org/pci/pci/c/71ae1c3a342c
> > 
> > [02/04] misc: pci_endpoint_test: Fix the return value of IOCTL
> >         https://git.kernel.org/pci/pci/c/7908208a2f6a
> > 
> > [03/04] selftests: Move PCI Endpoint tests from tools/pci to Kselftests
> >         https://git.kernel.org/pci/pci/c/5c892b60e4c6
> > 
> > [04/04] selftests: pci_endpoint: Migrate to Kselftest framework
> >         https://git.kernel.org/pci/pci/c/62f966e676b5
> > 
> > 	Krzysztof
> 
> I'm a bit surprised that this series was picked up,
> since as you could see earlier in this same thread:
> https://lore.kernel.org/linux-pci/20241219000112.GE1444967@rocinante/T/#m7bb0e624a4bf88f5cc13dc3804972c4fa9a79bcd
> 
> Mani suggested that my patch (which conflicts with this),
> should be picked up first.
> 
> Is there a reason for the sudden chance of plans?

No, no change to the plan here.

There were some mixed signals between the mailing list, IRC and
the Patchwork queue.  But I will proceed as planned there.

> Please advice on how to proceed.

I will pick your patch and drop Mani's series.  Mani told me on IRC that he
plans to work on it a bit more.

	Krzysztof

