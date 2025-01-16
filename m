Return-Path: <linux-kselftest+bounces-24665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE630A13EF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053D3167E36
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7522CA11;
	Thu, 16 Jan 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUkafOqM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4765922C356
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043961; cv=none; b=UEGtPNTl+iktGBqXazYNmHDI0OrCTofdK1IYOC+a+tBU/iiT1+/MqamURlnIYpMgski56RNeUcK6gIGiug+xBE8qzWHPa8bGoOAETMTy2Zm+SHSgn1L4KsridRrAIBAIWeJmdoraUwVRC5UocfmrlSasMoul9XeGspjqx8fp/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043961; c=relaxed/simple;
	bh=IK3Ql96gyS4VFEeFhV8k9b3ysohqF4iypjPD7WYYkxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKcH/SFSSdDi/ZWQPi2hObruyFdU2cQMpLvsDogg+NUq9avILlMv/v/DvYXSnIrTltBWJOBR8jvpsfhLTx/Vqx6QP9sPZEGrYYhNxLMeD6QDlWNqQNj4ZXSUzWnzpUa3vXfv1ND2WZ/PrQHj537k94QYg1XRa9LYE8ZSeD5dDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUkafOqM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2156e078563so14892015ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737043958; x=1737648758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Vs6BBUKG7PBaEM3z/slrYo3/W2WHS+37scYn69oAcA=;
        b=mUkafOqMOjWYIKFB5Lmos8D/mTq9C8ePq+s+gcaeUYiF5usphMGp1eIhDblLX+uJOs
         K5F+XmchSvd0DfKsdVWdxab5VF49JS3Nj49lYWLAlXbV9e1redSpB+1nok+7ASOvbps2
         Xci2qKfWXWiYStlI2RSlAbCjHkbFjNqmS/aohapQyYeCW1V/Q+OSu/D/ksUGBEzK8NxP
         fdaiaN1l/8UFkz+IhzoheclVxkUG+LLCnc/gQHreWl6gQ6vaj9husxQGs7VNa27gkvjh
         2QN9s7bgEIrby2d5obfLw3Gk9ARmtsj4pj8r9cq8AGwMCWsf5KLe3jvPmjhiq7nwTpio
         HegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737043958; x=1737648758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Vs6BBUKG7PBaEM3z/slrYo3/W2WHS+37scYn69oAcA=;
        b=hYiBXuXHHkkoa+FRCH4PTBi2sDJsJTiAVOSLTBWF02SUBALGD5ttACX2a54YwLo0rk
         /Jps3mjAIWMxHVYkrb5NMAcAF3bT/utf4l9e9ceMgcC/qYLVExMa1MN7eQNvNC2phjC0
         Qk4q74SXNVcY7eGopMLuZs8fCVLyEGF1+14hE7xitbGdeLz8qY6fj70EJNMFOhiusQUr
         gNL99ZP0tpuYb6VAhbXz4sNndD+NEc/8SQApbvmox1z9CnT6XbvCu5FUp1S7o3ZHNWsi
         T8WcVLkyzBOBCXsgBmtyZ+2b0FJvGewyoBAUOtb1oCzvPS3QU+ivY650ithc9iWcJHhp
         P71g==
X-Forwarded-Encrypted: i=1; AJvYcCXpgukenOPPlIg0wlzRlnGojWSP+3WijftCOt62NeS9OiHe2yDuLQh6DhxJUUrnat/xqb1i5CdcKEnEnPz3QVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitTGA9RzzUr1vLsUzvMI8mESggq4R/BTOeq2wwz2ThbHZ68BV
	5SM9lfcxO2BWCM0QjZzJnib8ddgnykOKXHmRAzjP+lo3f+H+077sqXMUCHTn8n9c7GCMfaKRi80
	=
X-Gm-Gg: ASbGncs98bGL/x6HH+DT26dia6e31BE5Wl0wd4qZp1sIiPh7uVs77puVVeQseQpV7yF
	d3BV8YBFwd6RyMCyaO38MginvcnnB8Zo8laCpAJJEAVqgsrNiiXsno606qy7n4ZsBL2WEdoXQNa
	8CtZlqyTvzvwzrbfeNIUPGu2GxS+rgHmhaEvj7btFY7RggVo9F+zMf41+VAiagY54NKn7w8jwPh
	aK7twjtEir33JZ8jIZDf6FxtSxLHVYqXT6WTQA18MAoCtm873cvBb57Ln2MPQ/x6OM=
X-Google-Smtp-Source: AGHT+IG73qQrUyxMIaRV8i9mCwuIdQXxnZ82Wm9zIN9i+4KXbSA3xGqkT4I0QTkuhM7mkhQuPiK/0g==
X-Received: by 2002:a05:6a21:2d09:b0:1e0:d1db:4d8a with SMTP id adf61e73a8af0-1e88d0edac9mr46715628637.10.1737043958526;
        Thu, 16 Jan 2025 08:12:38 -0800 (PST)
Received: from thinkpad ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b5153sm198375a12.70.2025.01.16.08.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:12:38 -0800 (PST)
Date: Thu, 16 Jan 2025 21:42:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <20250116161227.gk2psmbzpexswgrm@thinkpad>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
 <Z4knZyKrEvVNopeX@ryzen>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4knZyKrEvVNopeX@ryzen>

On Thu, Jan 16, 2025 at 04:36:07PM +0100, Niklas Cassel wrote:
> On Thu, Jan 16, 2025 at 07:21:02PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > This series carries forward the effort to add Kselftest for PCI Endpoint
> > Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
> > based on another patch that fixes the return values of IOCTLs in
> > pci_endpoint_test driver and did many cleanups. Since the resulting work
> > modified the initial version substantially, I took over the authorship.
> > 
> > This series also incorporates the review comment by Shuah Khan [2] to move the
> > existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
> > migrating to Kselftest framework. I made sure that the tests are executable in
> > each commit and updated documentation accordingly.
> > 
> > - Mani
> > 
> > [1] https://lore.kernel.org/linux-pci/20221007053934.5188-1-aman1.gupta@samsung.com
> > [2] https://lore.kernel.org/linux-pci/b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org
> > 
> > Changes in v5:
> > 
> > * Incorporated comments from Niklas
> > * Added a patch to fix the DMA MEMCPY check in pci-epf-test driver
> > * Collected tags
> > * Rebased on top of pci/next 0333f56dbbf7ef6bb46d2906766c3e1b2a04a94d
> > 
> > Changes in v4:
> > 
> > * Dropped the BAR fix patches and submitted them separately:
> >   https://lore.kernel.org/linux-pci/20241231130224.38206-1-manivannan.sadhasivam@linaro.org/
> > * Rebased on top of pci/next 9e1b45d7a5bc0ad20f6b5267992da422884b916e
> > 
> > Changes in v3:
> > 
> > * Collected tags.
> > * Added a note about failing testcase 10 and command to skip it in
> >   documentation.
> > * Removed Aman Gupta and Padmanabhan Rajanbabu from CC as their addresses are
> >   bouncing.
> > 
> > Changes in v2:
> > 
> > * Added a patch that fixes return values of IOCTL in pci_endpoint_test driver
> > * Moved the existing tests to new location before migrating
> > * Added a fix for BARs on Qcom devices
> > * Updated documentation and also added fixture variants for memcpy & DMA modes
> > 
> > 
> > Manivannan Sadhasivam (4):
> >   PCI: endpoint: pci-epf-test: Fix the check for DMA MEMCPY test
> >   misc: pci_endpoint_test: Fix the return value of IOCTL
> >   selftests: Move PCI Endpoint tests from tools/pci to Kselftests
> >   selftests: pci_endpoint: Migrate to Kselftest framework
> > 
> >  Documentation/PCI/endpoint/pci-test-howto.rst | 170 +++++------
> >  MAINTAINERS                                   |   2 +-
> >  drivers/misc/pci_endpoint_test.c              | 255 +++++++++--------
> >  drivers/pci/endpoint/functions/pci-epf-test.c |   4 +-
> >  tools/pci/Build                               |   1 -
> >  tools/pci/Makefile                            |  58 ----
> >  tools/pci/pcitest.c                           | 264 ------------------
> >  tools/pci/pcitest.sh                          |  73 -----
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../testing/selftests/pci_endpoint/.gitignore |   2 +
> >  tools/testing/selftests/pci_endpoint/Makefile |   7 +
> >  tools/testing/selftests/pci_endpoint/config   |   4 +
> >  .../pci_endpoint/pci_endpoint_test.c          | 221 +++++++++++++++
> >  13 files changed, 435 insertions(+), 627 deletions(-)
> >  delete mode 100644 tools/pci/Build
> >  delete mode 100644 tools/pci/Makefile
> >  delete mode 100644 tools/pci/pcitest.c
> >  delete mode 100644 tools/pci/pcitest.sh
> >  create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
> >  create mode 100644 tools/testing/selftests/pci_endpoint/Makefile
> >  create mode 100644 tools/testing/selftests/pci_endpoint/config
> >  create mode 100644 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > 
> > -- 
> > 2.25.1
> > 
> 
> I ran the test using simply:
> 
> $ ./pci_endpoint_test
> 
> and got:
> 
> #  RUN           pci_ep_basic.MSIX_TEST ...
> # pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X33
> # pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X34
> # pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X35
> # pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X36
> # pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X37
> # pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X38
> # pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X39
> 
> 
> I think that you should also do:
> 
> diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
> index 7d0dbad61456..7d5049c884dd 100644
> --- a/Documentation/PCI/endpoint/pci-test-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-test-howto.rst
> @@ -81,8 +81,8 @@ device, the following commands can be used::
>  
>         # echo 0x104c > functions/pci_epf_test/func1/vendorid
>         # echo 0xb500 > functions/pci_epf_test/func1/deviceid
> -       # echo 16 > functions/pci_epf_test/func1/msi_interrupts
> -       # echo 8 > functions/pci_epf_test/func1/msix_interrupts
> +       # echo 32 > functions/pci_epf_test/func1/msi_interrupts
> +       # echo 2048 > functions/pci_epf_test/func1/msix_interrupts
>  
> 
> Such that the documentation suggests values that will actually make the
> pci_endpoint_test pass without any special parameters set.
> 

Agree and this is what I am doing locally, but that change is not really related
to this series. So I'll submit it separately.

> 
> Other than that small nit, for the series:
> Tested-by: Niklas Cassel <cassel@kernel.org>

Thanks a lot!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

