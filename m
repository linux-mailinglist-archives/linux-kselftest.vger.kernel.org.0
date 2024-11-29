Return-Path: <linux-kselftest+bounces-22630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED89DEB52
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81786B20EA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298EB1974FE;
	Fri, 29 Nov 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnsRYVM1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C778276
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Nov 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899185; cv=none; b=DnEP2fg19I31fWeeIqnr4vVCciP/JJii4Fjv1CHKN5VCk5ANKVTQk7rapqCbG/xkrMM7G1zf42BB+590/2Pv7KDb/J8kjdxywnN4j5RNXBv0PVrQ9l5UtgGyX4NZ8fOWAo4QYj1MpmhmMyNfvNHsNFw9YDh62Ac6rfLuu7iFUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899185; c=relaxed/simple;
	bh=sOFiuhO5vsMdTi5SVwyGzfNynTcxWRGvJ2d795d1uF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpX6X35ZAR8TwhPGwD+goCS7gCdxf8dShdQ3X1J8IQdOYKdi1tRPPaIMi5l+uG1lECk2XOSvhGguzShb6kD6L5Gppz0APxF2q+T1K6liBus8OWGQtegeDuXQqb/R+dzhOiGDnpEnrb4QdorLqYFSRQr4YCAXTfo01v1OhFsdwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QnsRYVM1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21285c1b196so20337005ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Nov 2024 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732899183; x=1733503983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZFbMuwJoupeTuVIANvu9of3sRyXIlInw9R0HVQxUTXk=;
        b=QnsRYVM19PCr1yMt2BhY3TrgVFyTOxqez7wGNRZN4OGef9nvY+7pgAFrbOqOix1hPz
         FfptMpJCGGSRMN41PaCXbUCFbR1SySR/V/SzmB2n9tFx0JodrKKAE/1uW9e3nwjNaGxU
         BgGIC4hiGDtkgya8PakPdfXLRqdO/YvsSwIy3NQJppkq+BXg/G96hDcN7nRNkUKZ5Fep
         hk03/GSbtxzXelhdZ/FhAvruOb88s96M9rP6W3SUh2j8gUaEf7Lhvsn8VNy/q17xskf5
         ujejsWUaXU2e3UyrEKHYVaNz7DXb5izHdNpjaS53N1nhBVrfVM+YAx98jLWJK1ldNo+W
         EIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732899183; x=1733503983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFbMuwJoupeTuVIANvu9of3sRyXIlInw9R0HVQxUTXk=;
        b=BylqqDILExo7gtN9J+18KAXv3DcWOJPs3RjdpmUVCG8+MYTx6q2jJ4M+AJUPz1Ji25
         s/nQ06O3ywpn16zoMpUAETSPFHq+c9sHJ/qifXvbHnl9I5wfmOrjeyIo0GLi/7jJCSjx
         o8HloBLGNK66vlhzZ8DMhIt474UGM1EfCJf8kK9cCGD9sKg5C8grzkeG5qKGfxIMvVMh
         uuBbrOVASE/EbQq4ZodW478ySo9W1ae37U4/rxtFZKdRNMfIDvWmiNov2YTIMYxt19qy
         XZ7ytKSoo4anf6/K/YxeSfETjerZ8KEHVo3/f5v9EsdW2YszWFfUcyf9awWXvtFYC4iZ
         AFig==
X-Forwarded-Encrypted: i=1; AJvYcCW+sjppQdOiZXCKxYKdEi+trBLCSxNLMIbpQSNXtte+wp3k39Ha9FywzU+yjiuC8EJfhA/2jp9tMogCt4xgK74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCAA4iJEMFDeP5Fpzv3Y0ZU9i/3yDg8DNqD61NHIHF7jDX4mn1
	pUBonhFfWFKalt9ZCVZIi7zZekGSPqRf6ck/XTChyZBYUhm7fq8qwrtjSlYrRg==
X-Gm-Gg: ASbGnctkgvqdI8XSLppmpn4pBHtNzBtYhq/zOtpvAWpRxEgBO5MEWvEUWHB5u6MhrQH
	nmJiiEdpO9PAexokJ7j7bZG7gd/Sv+I0l6sb+f2MYy5EVM0Ba61R1BHC1zElCAE4lRIP6XZJiBc
	iM3QzimZfqeaQNS5ZG4MzIZgKHbo38FJOgl80kC3EKb9t0Cx2fruP0SabXgB13zbZI6WI3glWYi
	Q0xppVRNESgIcnqEpLn5TFmtN9Z5hCUFa1xRm/T/nW0DNnMq9ThNtyzgEr/
X-Google-Smtp-Source: AGHT+IGgMDneUQoezXtXtm82L/rrJjPpPfA4CVESzXST0WVlaDqWVPOFPzJbew1ac7rLRRJmGXV8Fw==
X-Received: by 2002:a17:902:fc47:b0:215:5204:3913 with SMTP id d9443c01a7336-21552044c13mr16503025ad.52.1732899182903;
        Fri, 29 Nov 2024 08:53:02 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219d0aafsm32851455ad.271.2024.11.29.08.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:53:02 -0800 (PST)
Date: Fri, 29 Nov 2024 22:22:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests: pci_endpoint: Migrate to Kselftest
 framework
Message-ID: <20241129165256.dkzcbfdvmf2n4rxx@thinkpad>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-5-manivannan.sadhasivam@linaro.org>
 <Z0nG3oAx66plv4qI@ryzen>
 <20241129163555.apf35xa6x5joscha@thinkpad>
 <Z0nu8n5GEuZ0zaBD@ryzen>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0nu8n5GEuZ0zaBD@ryzen>

On Fri, Nov 29, 2024 at 05:42:26PM +0100, Niklas Cassel wrote:
> On Fri, Nov 29, 2024 at 10:05:55PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 29, 2024 at 02:51:26PM +0100, Niklas Cassel wrote:
> > > Hello Mani,
> > > 
> > > On Fri, Nov 29, 2024 at 02:54:15PM +0530, Manivannan Sadhasivam wrote:
> > > > Migrate the PCI endpoint test to Kselftest framework. All the tests that
> > > > were part of the previous pcitest.sh file were migrated.
> > > > 
> > > > Below is the exclusive list of tests:
> > > > 
> > > > 1. BAR Tests (BAR0 to BAR5)
> > > > 2. Legacy IRQ Tests
> > > > 3. MSI Interrupt Tests (MSI1 to MSI32)
> > > > 4. MSI-X Interrupt Tests (MSI-X1 to MSI-X2048)
> > > > 5. Read Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > 6. Write Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > 7. Copy Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > 8. Read Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > 9. Write Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > 10. Copy Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > 
> > > I'm not sure if it is a great idea to add test case number 10.
> > > 
> > > While it will work if you use the "dummy memcpy" DMA channel which uses
> > > MMIO under the hood, if you actually enable a real DMA controller (which
> > > often sets the DMA_PRIVATE cap in the DMA controller driver (e.g. if you
> > > are using a DWC based PCIe EP controller and select CONFIG_DW_EDMA=y)),
> > > pci_epf_test_copy() will fail with:
> > > [   93.779444] pci_epf_test pci_epf_test.0: Cannot transfer data using DMA
> > > 
> > 
> > So the idea is to exercise all the options provided by the epf-test driver. In
> > that sense, we need to have the DMA COPY test. However, I do agree that the
> > common DMA controllers will fail this case. So how about just simulating the DMA
> > COPY for controllers implementing DMA_PRIVATE cap? I don't think it hurts to
> > have this feature in test driver.
> 
> I guess you could modify pci-epf-test to simply do MMIO in test_copy(),
> if USE_DMA && DMA_PRIVATE is set, as you suggest.
> 

No not memcpy, but using the DMA to copy from src to local buf and then local
buf to dst. This way, we do not need to fallback and at the same time simulate
DMA COPY.

- Mani 

-- 
மணிவண்ணன் சதாசிவம்

