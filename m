Return-Path: <linux-kselftest+bounces-23799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DB99FF110
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 18:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0043A316C
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3C11ACEDF;
	Tue, 31 Dec 2024 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX8xeGoD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075661ACEB8;
	Tue, 31 Dec 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735666969; cv=none; b=r5CrCeKZogWtWnZ+oq1POFJibrl47Zl3wIbo2f8JMIvCWoZ9mivRNQtnh6mWWEBPz/ltQRtZpViiXSG7QkBuJRPslHIYGx9RaSB3NXb91cVILbgV2Bc85uHcNxvUl3WC+w4F51QNst0qM+4Ea7A6iAh/Tug+WmdFjHhgveXxH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735666969; c=relaxed/simple;
	bh=IEPX7dqSkzpod9dMPu+rnhC0mWcA4/iiEodsksuiqCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVma38P+JRj7KlbZ+GY4ld2WGQ22iRY60SswbFbr1vflDlOncA2zMVqFe/f0q+4XKvCFStZVUqG/w8GIM9R6OFDwEhESi8dmC/lpZjNJYQQYv2/Or86zGY1wgFT2i9CwUTPbkTrZCsogCK5NtMYS2e+ZsWh+Hi7xRRlwiJcMPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX8xeGoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F67C4CED2;
	Tue, 31 Dec 2024 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735666968;
	bh=IEPX7dqSkzpod9dMPu+rnhC0mWcA4/iiEodsksuiqCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JX8xeGoDSvZfv/b1mgJdWDHuC1jVL0S58TE3mefqRsYxxuRueeNgPwT5uxpeSLx3/
	 axwotL6kGCwe5/iXjLNNp0qsBgG+N3mhpycxPjOaxd0oGcvS/CpV7FKmGzBwN4iBru
	 z08/PT48cN99ZeIeExHjA8rukXqLoycdGLOe+GWmQUOnjQPWmkcbYodEXvD8mp4p1Q
	 qd2qrJ0JnMXCjVN7xbAt7EYqCkcVDakW+IXvymDtoMiubnvBJH3pqtc5r8GybpMsCS
	 E41jsw4sCP9RcuLF+SPB+YpZ/R64DMRHv4mq26c5IzBIrjIR0Toats4Tt0GX87tjhF
	 Zk8TNekZEZPiw==
Date: Tue, 31 Dec 2024 18:42:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Aman Gupta <aman1.gupta@samsung.com>,
	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: Re: [PATCH v4 3/3] selftests: pci_endpoint: Migrate to Kselftest
 framework
Message-ID: <Z3QtEihbiKIGogWA@ryzen>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
 <20241231131341.39292-4-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231131341.39292-4-manivannan.sadhasivam@linaro.org>

On Tue, Dec 31, 2024 at 06:43:41PM +0530, Manivannan Sadhasivam wrote:

(...)

> +	#  RUN           pci_ep_data_transfer.dma.COPY_TEST ...
> +	#            OK  pci_ep_data_transfer.dma.COPY_TEST
> +	ok 11 pci_ep_data_transfer.dma.COPY_TEST
> +	# PASSED: 11 / 11 tests passed.
> +	# Totals: pass:11 fail:0 xfail:0 xpass:0 skip:0 error:0
> +
> +
> +Testcase 11 (pci_ep_data_transfer.dma.COPY_TEST) will fail for most of the DMA
> +capable endpoint controllers due to the absence of the MEMCPY over DMA. For such
> +controllers, it is advisable to skip the forementioned testcase using below
> +command::

Hm.. this is strictly not correct. If will currently fail because pci-epf-test.c
does:
if ((reg->flags & FLAG_USE_DMA) && epf_test->dma_private)
	return -EINVAL;

So even if a DMA driver has support for the DMA_MEMCPY cap, if the DMA driver
also has the DMA_PRIVATE cap, this test will fail because of the code in
pci-epf-test.c.

Not sure how to formulate this properly... Perhaps:
Testcase 11 (pci_ep_data_transfer.dma.COPY_TEST) will fail for DMA drivers that
have the DMA_PRIVATE cap set. For DMA drivers which have the DMA_PRIVATE cap
set, it is advisable to skip the forementioned testcase using below command::

> +
> +	# pci_endpoint_test -f pci_ep_basic -v memcpy -T COPY_TEST -v dma

Is this really correct? I would guess that it should be
pci_endpoint_test -f pci_ep_data_transfer -v memcpy -T COPY_TEST -v dma


(...)

> +TEST_F(pci_ep_basic, BAR_TEST)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i <= 5; i++) {
> +		pci_ep_ioctl(PCITEST_BAR, i);
> +		EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", i);
> +	}
> +}

From looking at this function, will we still be able to test a single BAR?
Previous pcitest.c allowed us to do pcitest -b <barno> to only test a
specific BAR. I think that is a useful feature that we shouldn't remove.

It would be nice if we could do something like:
# pci_endpoint_test -f pci_ep_basic -T BAR_TEST -v <barno>


(...)

> +
> +TEST_F(pci_ep_data_transfer, COPY_TEST)
> +{
> +	struct pci_endpoint_test_xfer_param param = {0};

This (also other places in this file) can be written as:
struct pci_endpoint_test_xfer_param param = {};



Kind regards,
Niklas

