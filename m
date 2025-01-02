Return-Path: <linux-kselftest+bounces-23814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFF9FF690
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 08:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF361882367
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 07:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB5A1922FD;
	Thu,  2 Jan 2025 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PT08JefV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0418622
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Jan 2025 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735801455; cv=none; b=cHurniNFtKizk8ROMdtITt8lltYN6BdojGYQjKM3HmGD6OigStV/v6SdWtZJ6mDb0eRekP95dND3VgdGu8JAGtKE7NtNLOGTQCeAemPnn2k36KCsmsC4DaGOc9m2HDRYjb5MUXCS8Ykk8VwDmnq65rjKDUOJh1pq5B0/ZnImwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735801455; c=relaxed/simple;
	bh=zieacA1cYlHL87jzXdWRIgLRo2zS5s609/3sOj0WpDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkbUaKFhkjzLF/e4NRMg4WNdUj4WnkvBEb+r1nHCq85vZsEPLHeyJpyGEmC0D/449NoR9vbzq3VkkmiYCkXcmoFdKQsHP+H4Bk2mjJ4JYw0n0vCx88YA4zHTDsPIXc/u1ROX/hj2egfkxn27j7PHvWEGm9qquh3FAEsTC7Si/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PT08JefV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21669fd5c7cso152123265ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Jan 2025 23:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735801453; x=1736406253; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tHyUTKV8cPdD2XAVx2quh19xU07+Qy2rusEJ0dFWoeY=;
        b=PT08JefVm2JdTRp5H6zg3y6zCVji6ZuQRdYFlkZTHNKeKmEovCn8dRYZ9cPCBAy4U8
         7cLPUN2+PJMkdc3nfqRIjjMoXery17W2uRF1V1HgFXcHK/vWVW2MNyAFad4NQ366YBkC
         VqXJDX4DO4sDoQlAAOW87DQ8pocuy/wk5YBF2p0oz4o0L8BGGHs+1jx5n/EtljqFQ2fv
         z3PhgeWKBAuGaGfAqyBacR5hoZVmdD1PMVTBBLG5PX8fcsI+ZBxdFnRO0HUN7roBj5Po
         myQMU9nVjtduUhOq/ytWRZDhe+OYeltAnhgAd/ShLvJnY0OeNHAWUWV6yjVKo3MdmB+D
         +yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735801453; x=1736406253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHyUTKV8cPdD2XAVx2quh19xU07+Qy2rusEJ0dFWoeY=;
        b=M6ge6NxOUVeJ1xWt0NUXeHDCvdNnVKmMhMt/N8ey4SPDEwomROu/ZCahsY1w1Csctb
         1A+fPvh9qQs6OVoQEBja62Q2qc7C0kWCRQc9KSWjzs6m1qDJBUlU4UgfBwvJqtSH4Kg3
         gc6v0FT0O0mA4Emmsu1bMgSRLy4p0K/6lV8Rd4/H2+rEl+G8dnxBCMpk1BJaHEvRUf1D
         pIBB0Y/UDBFgitptkdOYbF4y7/YjCFGiEeaQnSD05O37GRTKfHOZm1/Zo12Kfl8qKTy4
         ExRHOpyCMWivq2+sEhhDtiAJ5m6+zVx0W/XrOW1+jigd17E51zC/+IAykllSKACoa2XC
         +3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVnDHWh3E1y2MxfxCI5+KAxtRPExYR8Qf7LpdLddifl6Hg8/8KoQmSu5oulbjWNH0mgz4w0SJ9G78YojoTlzeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMH7zE2h6inxbh/EgNTOoKpZUdQ/pEx3ZeXZ/7gvIzFPCxbUX
	W43OHOzy0i8c0aR9qgKGVASAGfJOKszuxduG+4jvZcAN/yzlSsX/hkjKaYqMbxwoegYULB9GvYA
	=
X-Gm-Gg: ASbGnctgb500UzE+LvIkBPPmGcrxIzmLqgA/fC2B/lZLMn3J9S/9hTnF5aD1kVB62sa
	zD1ie7HRX9OFq+Hq41/7zmS5ySX/kzhxEnrOLR7w2M/u7ivOdluuwwiN3R8sfpRC7VVXKTKpQ24
	5vBs27Ft3SyJn2QpDCaAK2CEqxV+B7Srv5/me6bLt5atOVJDc9k5+rNg9QqT5K4PCUR+dLF9M8d
	Wa44Ebs2UkeoKdY4vtk2oOh56wjMi91XkYmnIUz4+2d3mrhBuehXZcb/txx0f2rlUqH
X-Google-Smtp-Source: AGHT+IHveiYw51Ybj8GZVsAu8rFz0ffgplnugz6CVwRBRHmUA3RuHT29SnSj6wt1va/tqT00jC21hQ==
X-Received: by 2002:a05:6a00:8d1:b0:725:df1a:281 with SMTP id d2e1a72fcca58-72abdda0cf3mr53988360b3a.10.1735801452677;
        Wed, 01 Jan 2025 23:04:12 -0800 (PST)
Received: from thinkpad ([117.213.100.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8164d3sm23643829b3a.15.2025.01.01.23.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 23:04:12 -0800 (PST)
Date: Thu, 2 Jan 2025 12:34:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Aman Gupta <aman1.gupta@samsung.com>,
	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: Re: [PATCH v4 3/3] selftests: pci_endpoint: Migrate to Kselftest
 framework
Message-ID: <20250102070404.aempesitsqktfnle@thinkpad>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
 <20241231131341.39292-4-manivannan.sadhasivam@linaro.org>
 <Z3QtEihbiKIGogWA@ryzen>
 <20241231191812.ymyss2dh7naz4oda@thinkpad>
 <2C16240A-28F8-4D9B-9FD7-33E4E6F0879E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2C16240A-28F8-4D9B-9FD7-33E4E6F0879E@kernel.org>

On Tue, Dec 31, 2024 at 08:33:57PM +0100, Niklas Cassel wrote:
> 
> 
> On 31 December 2024 20:18:12 CET, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >On Tue, Dec 31, 2024 at 06:42:42PM +0100, Niklas Cassel wrote:
> >> On Tue, Dec 31, 2024 at 06:43:41PM +0530, Manivannan Sadhasivam wrote:
> >> 
> >> (...)
> >> 
> >> > +	#  RUN           pci_ep_data_transfer.dma.COPY_TEST ...
> >> > +	#            OK  pci_ep_data_transfer.dma.COPY_TEST
> >> > +	ok 11 pci_ep_data_transfer.dma.COPY_TEST
> >> > +	# PASSED: 11 / 11 tests passed.
> >> > +	# Totals: pass:11 fail:0 xfail:0 xpass:0 skip:0 error:0
> >> > +
> >> > +
> >> > +Testcase 11 (pci_ep_data_transfer.dma.COPY_TEST) will fail for most of the DMA
> >> > +capable endpoint controllers due to the absence of the MEMCPY over DMA. For such
> >> > +controllers, it is advisable to skip the forementioned testcase using below
> >> > +command::
> >> 
> >> Hm.. this is strictly not correct. If will currently fail because pci-epf-test.c
> >> does:
> >> if ((reg->flags & FLAG_USE_DMA) && epf_test->dma_private)
> >> 	return -EINVAL;
> >> 
> >> So even if a DMA driver has support for the DMA_MEMCPY cap, if the DMA driver
> >> also has the DMA_PRIVATE cap, this test will fail because of the code in
> >> pci-epf-test.c.
> >> 
> >
> >Right. But I think the condition should be changed to test for the MEMCPY
> >capability instead. Like,
> >
> >diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> >index ef6677f34116..0b211d60a85b 100644
> >--- a/drivers/pci/endpoint/functions/pci-epf-test.c
> >+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> >@@ -328,7 +328,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
> >        void *copy_buf = NULL, *buf;
> > 
> >        if (reg->flags & FLAG_USE_DMA) {
> >-               if (epf_test->dma_private) {
> >+               if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {
> >                        dev_err(dev, "Cannot transfer data using DMA\n");
> >                        ret = -EINVAL;
> >                        goto set_status;
> >
> 
> That check does seem to make more sense than the code that is currently there.
> (Perhaps send this as a proper patch?)

Will do.

> Note that I'm not an expert at dmaengine.
> 
> I have some patches that adds DMA_MEMCPY to dw-edma, but I'm not sure if the DWC eDMA hardware supports having both src and dst as PCI addresses, or if only one of them can be a PCI address (with the other one being a local address).
> 
> If only one of them can be a PCI address, then I'm not sure if your suggested patch is correct.
> 

I don't see why that would be an issue. DMA_MEMCPY is independent of PCI/local
addresses. If a dmaengine driver support doing MEMCPY, then the dma cap should
be sufficient. As you said, if a controller supports both SLAVE and MEMCPY, the
test currently errors out, which is wrong.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

