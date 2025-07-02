Return-Path: <linux-kselftest+bounces-36319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A2AF4D04
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA191C4368A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37AE279DC9;
	Wed,  2 Jul 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHF+p8ac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B224BCF5;
	Wed,  2 Jul 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461632; cv=none; b=o3TnbhWDi0X7co/R5vhb11m/OD1SpXofFj5jU4xKqeWDFGxJ0Pixn7hXs3ppMu7QIbB0g+Fsrbo23H4QANOHhX/XTeAKs/kcJOleqdILCC64VZXkJkxX4/BHXi8MXAUHA5PbACFtRtVb4rV5WtJ1dzeCT3E7lie4uq2xu3ue+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461632; c=relaxed/simple;
	bh=gf2sQbHcLAupqATPVKtpgXGyK+779f5rPVv4yhPoP3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2tz/gkkuz/GuqwbYec9QPxB1c9OF0nIoHUxgohdoyNvF0njjzm2bo7I5nLNmvncatRrNoV6NwDNy6dMCa98lXTq8vyszApRUmqMdnf2L7b7Z5mTo91CNErW57zjSmlaFv1QfqvWNHR8rvID8Jl1cBFQ8qTE2M5HPjHh8Lb+gNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHF+p8ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7AEC4CEED;
	Wed,  2 Jul 2025 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751461632;
	bh=gf2sQbHcLAupqATPVKtpgXGyK+779f5rPVv4yhPoP3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHF+p8acu21kpFfa5z6AeaF7zGgAsr39mm4n3xlsl5wUuJ79NVHx2Oe/kutY+WUIQ
	 1zF6CA6DLLvbtpi9yAGn2+bb8AuUpOhoxr7Kcyhh/4gsgTGZxTQsvyVRmXE1fuEiER
	 PHL8sZdkO1nBlT95ybIDoRAuXZoauuvxOFZl+ybl/URXhuy3/OxJFdPKIsMbwDV1B9
	 5Q29UpAe6G4B9HTThjaMnddlgSM+O8oMwI+wGdrkeWWY7Y9yBa/SbBANwtM2gpqUc7
	 Q3bqS7HFZFsXLXlzXCBcETCRdzbPaDEa/eyuDKvU1fbcKfGRAm8FV+TrLb1uYa3L/X
	 GK9ee/icUL3Ww==
Date: Wed, 2 Jul 2025 18:36:52 +0530
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
Subject: Re: [PATCH v19 05/10] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <357zznvglssmaemq4j3v3s4atrkljq3o6ivx35h3ztw64iml3d@hauozlcoaaog>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-5-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-ep-msi-v19-5-77362eaa48fa@nxp.com>

On Mon, Jun 09, 2025 at 12:34:17PM GMT, Frank Li wrote:

[...]

> +static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
> +{
> +	struct pci_epf_test *epf_test = data;
> +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	u32 status = le32_to_cpu(reg->status);
> +
> +	status |= STATUS_DOORBELL_SUCCESS;
> +	reg->status = cpu_to_le32(status);
> +	pci_epf_test_raise_irq(epf_test, reg);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> +{
> +	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> +	struct pci_epf *epf = epf_test->epf;
> +
> +	if (le32_to_cpu(reg->doorbell_bar) > 0) {

Is this check necessary?

> +		free_irq(epf->db_msg[0].virq, epf_test);
> +		reg->doorbell_bar = cpu_to_le32(NO_BAR);
> +	}
> +
> +	if (epf->db_msg)

Same here.

> +		pci_epf_free_doorbell(epf);
> +}
> +
> +static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> +					 struct pci_epf_test_reg *reg)
> +{
> +	u32 status = le32_to_cpu(reg->status);
> +	struct pci_epf *epf = epf_test->epf;
> +	struct pci_epc *epc = epf->epc;
> +	struct msi_msg *msg;
> +	enum pci_barno bar;
> +	size_t offset;
> +	int ret;
> +
> +	ret = pci_epf_alloc_doorbell(epf, 1);
> +	if (ret) {
> +		status |= STATUS_DOORBELL_ENABLE_FAIL;
> +		goto set_status;

I think you can just set the failure status directly in err path:

	if (ret)
		goto set_err_status;

> +	}
> +
> +	msg = &epf->db_msg[0].msg;
> +	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
> +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {

Can 'bar' really be 'epf_test->test_reg_bar' here? You just need to check for
NO_BAR, that's it.

Also 'epf->db_msg' can't be NULL here. You were already dereferencing above, so
this check is pointless.

> +		status |= STATUS_DOORBELL_ENABLE_FAIL;
> +		goto set_status;
> +	}
> +
> +	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
> +			  "pci-test-doorbell", epf_test);

'pci-ep-test-doorbell'

> +	if (ret) {
> +		dev_err(&epf->dev,
> +			"Failed to request irq %d, doorbell feature is not supported\n",

'Failed to request doorbell IRQ: %d\n'

> +			epf->db_msg[0].virq);
> +		status |= STATUS_DOORBELL_ENABLE_FAIL;
> +		pci_epf_test_doorbell_cleanup(epf_test);

this can be moved to a err label:

		goto cleanup_doorbell;

> +		goto set_status;
> +	}
> +
> +	reg->doorbell_data = cpu_to_le32(msg->data);
> +	reg->doorbell_bar = cpu_to_le32(bar);
> +
> +	msg = &epf->db_msg[0].msg;
> +	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
> +					 &epf_test->db_bar.phys_addr, &offset);
> +
> +	if (ret) {
> +		status |= STATUS_DOORBELL_ENABLE_FAIL;
> +		pci_epf_test_doorbell_cleanup(epf_test);
> +		goto set_status;
> +	}
> +
> +	reg->doorbell_offset = cpu_to_le32(offset);
> +
> +	epf_test->db_bar.barno = bar;
> +	epf_test->db_bar.size = epf->bar[bar].size;
> +	epf_test->db_bar.flags = epf->bar[bar].flags;
> +
> +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
> +	if (ret) {
> +		status |= STATUS_DOORBELL_ENABLE_FAIL;
> +		pci_epf_test_doorbell_cleanup(epf_test);
> +	} else {
> +		status |= STATUS_DOORBELL_ENABLE_SUCCESS;
> +	}
> +

Set the success status directly here:

	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
	reg->status = cpu_to_le32(status);

	return;

cleanup_doorbell:
	pci_epf_test_doorbell_cleanup(epf_test);
set_err_status:
	status |= STATUS_DOORBELL_ENABLE_FAIL;
	reg->status = cpu_to_le32(status);

> +set_status:
> +	reg->status = cpu_to_le32(status);
> +}
> +
> +static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
> +					  struct pci_epf_test_reg *reg)
> +{
> +	enum pci_barno bar = le32_to_cpu(reg->doorbell_bar);
> +	u32 status = le32_to_cpu(reg->status);
> +	struct pci_epf *epf = epf_test->epf;
> +	struct pci_epc *epc = epf->epc;
> +	int ret;
> +
> +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {

Same comment about as above for these checks.

> +		status |= STATUS_DOORBELL_DISABLE_FAIL;
> +		goto set_status;
> +	}
> +
> +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
> +	if (ret)
> +		status |= STATUS_DOORBELL_DISABLE_FAIL;
> +	else
> +		status |= STATUS_DOORBELL_DISABLE_SUCCESS;
> +
> +	pci_epf_test_doorbell_cleanup(epf_test);
> +
> +set_status:
> +	reg->status = cpu_to_le32(status);
> +}
> +
>  static void pci_epf_test_cmd_handler(struct work_struct *work)
>  {
>  	u32 command;
> @@ -714,6 +847,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  		pci_epf_test_copy(epf_test, reg);
>  		pci_epf_test_raise_irq(epf_test, reg);
>  		break;
> +	case COMMAND_ENABLE_DOORBELL:
> +		pci_epf_test_enable_doorbell(epf_test, reg);
> +		pci_epf_test_raise_irq(epf_test, reg);
> +		break;
> +	case COMMAND_DISABLE_DOORBELL:
> +		pci_epf_test_disable_doorbell(epf_test, reg);
> +		pci_epf_test_raise_irq(epf_test, reg);
> +		break;
>  	default:
>  		dev_err(dev, "Invalid command 0x%x\n", command);
>  		break;
> @@ -987,6 +1128,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  		pci_epf_test_clean_dma_chan(epf_test);
>  		pci_epf_test_clear_bar(epf);
>  	}
> +	pci_epf_test_doorbell_cleanup(epf_test);

Why is this necessary?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

