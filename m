Return-Path: <linux-kselftest+bounces-36321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE9AF5866
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261D44E0555
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4E21E5B70;
	Wed,  2 Jul 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3owOUtM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C327700B;
	Wed,  2 Jul 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462184; cv=none; b=StGOa9KkFMRrSnru/r8014+VmJN52E/OuUSoF4+QGhmHnnYi0r5z1MkM2tM1eDx7C44DwiKeNeFLTQ7gWvIcRAca37ei+ZX9Dp1xR1HYq8q0emC6XKbaQ3vsVFQV0n6vFinhWMarnSsgPXQ65DbSAPKCd3HKLuKSPM+uZPGH6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462184; c=relaxed/simple;
	bh=BalqjDGonmJyXEzDFjwpcwkTqv8MDEHIz2hYDyigmKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS8yu7PS2fhR15yuNjrbBV+9UbYJLQBdw/Eng4wB6hTV97oQhW/KRuXNIpgKzuRl4bbWed/JBZJ9SZfUGB08GywelI3O95dwi0k28Elm3XOZwz2dAFzAIX54m5gNIZn/G5QNtPSxgAd9J7LpA+El/HgoJobklXzz4O02A1artNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3owOUtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C4BC4CEED;
	Wed,  2 Jul 2025 13:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462184;
	bh=BalqjDGonmJyXEzDFjwpcwkTqv8MDEHIz2hYDyigmKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3owOUtMnbbvO0krTqvLoWpLm1WkZCnvikqym0I+oe5gDYS6XcLZM0ON4AOd3e1Mf
	 hllI3RTOM+c8lyijWVGowILYr/ZOAHLki7Ud+J//IpPO9JA6BeK5PdVTDdperVX8SY
	 Sw/14lBoOgyzoA1OF5kX/ZxmW+4kxHw6lOWj2atwl5gT7Im+nRCjoprVWU3A5cFet9
	 62spxD0/kOK47Uh0NZTFQjUR+pXgGdr2OQk+BAyOmaPisTgVjPBRSTj34ab5DAC1c0
	 nIIZZmTXw+ZelUkHzkwsSGCRK/wQXYWDBKK8khIdHO/UvRAec5DJK2w8mdzt5d45c2
	 dNgaIEF2P+eUA==
Date: Wed, 2 Jul 2025 18:46:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v19 07/10] selftests: pci_endpoint: Add doorbell test case
Message-ID: <u7crpzltdyqypkvrkfbs6sruc4z3cpzyvcnqkokzsicbqkoj7e@6uxhoifc5xl7>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-7-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-ep-msi-v19-7-77362eaa48fa@nxp.com>

On Mon, Jun 09, 2025 at 12:34:19PM GMT, Frank Li wrote:
> Add doorbell test case.
> 

This also warrants a documentation change.

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v14 to v16
> - Add set IRQ type
> 
> change from v13 to v14
> - merge to selftests framework
> ---
>  .../selftests/pci_endpoint/pci_endpoint_test.c     | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> index ac26481d29d9d..da0db0e7c9693 100644
> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> @@ -229,4 +229,32 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
>  					 test_size[i]);
>  	}
>  }
> +
> +FIXTURE(pcie_ep_doorbell)
> +{
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(pcie_ep_doorbell)
> +{
> +	self->fd = open(test_device, O_RDWR);
> +
> +	ASSERT_NE(-1, self->fd) TH_LOG("Can't open PCI Endpoint Test device");
> +};
> +
> +FIXTURE_TEARDOWN(pcie_ep_doorbell)
> +{
> +	close(self->fd);
> +};
> +
> +TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
> +{
> +	int ret;
> +
> +	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
> +	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
> +
> +	pci_ep_ioctl(PCITEST_DOORBELL, 0);
> +	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
> +}
>  TEST_HARNESS_MAIN
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

