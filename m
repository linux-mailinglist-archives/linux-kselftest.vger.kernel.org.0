Return-Path: <linux-kselftest+bounces-36337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB1AF5BD4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6BC177FBC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 14:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543330AACC;
	Wed,  2 Jul 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4dOc7rR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108017A316;
	Wed,  2 Jul 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468137; cv=none; b=eUZyFWGTQRH1Z97lryY/PXKEDiH32n0ZxTPyVWN+VOcizz5Kx+zATt6U5AF2dFPxlYWv3ApbEBNbCjwZqNF9LevB6u59kspDJkXTn4qPw/22ZUgdW360ywvSESwyDEoNJTJEcZyjWaN870J9iPS9Ydq/ZaCQPxvBTlZu+TRr8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468137; c=relaxed/simple;
	bh=odc42PZm0xJO0diX1K58N47iddxW3a0F4HZfOHM34QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhmtbFsk30+RmabzEz3wqq1ScH147T2X8n47JiyojZVeoZRRbXhvJ0qxja9sg48C3Jkzm53y9EdpxYlI+wk9iiTXc4GZpNlu4UMP24Xg2K6po+Wa5voeJRF0JjtpmVJVfDIAb/mnM1yOXZaCvLrTdnGbLpIbX3NTR40micnw85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4dOc7rR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7004C4CEE7;
	Wed,  2 Jul 2025 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468137;
	bh=odc42PZm0xJO0diX1K58N47iddxW3a0F4HZfOHM34QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4dOc7rRMoTUrPqkvoVH5KlxVpdU6iDMm2rDEi+KlTjIIDv+7QNH9XaqWCWQj4OoT
	 zbzjAWxc3IYGTwZrkS3cvU9VHATYI/yGlBu2sn96cJrffqibdZeCa/0G4jjmoziguF
	 GlZ3vbYwRHql8BA9Q4SCt1HgQ7URRolg7gqp0ShtPK2P37mdoegDMOHpDzVqW/vTRa
	 BrrmyEINlk52COqWZhKyeTsDkIsaKHvntPkZmJYEYD533pltwZ5NWi8gTlrABTWN5V
	 Yucf/dcJQpMPS0K9YHh5kyNeSkz9kiXrM1c4UZgPuQrVSMQEwf4s4UXaij+akTO8KS
	 jFhyFmMdklDiA==
Date: Wed, 2 Jul 2025 20:25:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
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
Subject: Re: [PATCH v19 01/10] PCI: endpoint: Set ID and of_node for function
 driver
Message-ID: <75opnvi46fbmsnmykjwn3gmir7r3uqhzp7tfoua42cado6aopu@dmos2v2qd3jn>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>
 <ne5yrjtdevmndqds4uwo2ppq6gay2wuwjouyf33lqr5g3nfkwr@lkwqlwqjqbmx>
 <aGVE6veZm3bL0mVJ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGVE6veZm3bL0mVJ@lizhi-Precision-Tower-5810>

On Wed, Jul 02, 2025 at 10:40:53AM GMT, Frank Li wrote:
> On Wed, Jul 02, 2025 at 04:30:48PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jun 09, 2025 at 12:34:13PM GMT, Frank Li wrote:
> > > Set device ID as 'vfunc_no << 3 | func_no' and use
> > > 'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
> > > device.
> > >
> > > Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
> > > settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
> > > functions use the EPC's device node, but they should use the EPF one.
> > > For multiple function drivers, IOMMU/MSI should be different for each
> > > function driver.
> > >
> >
> > We don't define OF node for any function, so device_set_of_node_from_dev() also
> > ends up reusing the EPC node. So how can you make use of it in multi EPF setup?
> 
> In mfd devices, children devices reuse parent's of_node
> drivers/gpio/gpio-adp5585.c
> drivers/input/keyboard/adp5589-keys.c
> drivers/pwm/pwm-adp5585.c
> 
> multi EPF should be similar to create multi children devices of mfd.
> 

No, they are not similar. MFD are real physical devices, but EPFs are (so far)
software based entities.

> > I don't understand.
> 
> >
> > > If multiple function devices share the same EPC device, there will be
> > > no isolation between them. Setting the ID and 'of_node' prepares for
> > > proper support.
> 
> Only share the same of_node.
> 
> Actually pci host bridge have similar situation, all pci ep devices reuse
> bridge's of node. framework use rid to distringuish it. EPF can use device::id
> to do similar things.
> 
> Actually iommu face the similar problem. So far, there are not EP device enable
> iommu yet, because it needs special mapping.
> 
> Prevously, I consider create dymatic of_node for each EPF and copy iommu/msi
> information to each children. But when I see adp5585 case, I think direct
> use parent's of_node should be simple and good enough.
> 
> In future, I suggest add children dt binding for it. For example: EPF provide
> a mailbox interface. how other dts node to refer to this mailbox's phandle?
> 

As I said above, EPFs are not real devices. There is currently only one
exception, MHI, which is backed by a hardware entity. So we cannot add
devicetree nodes for EPF, unless each EPF is a hardware entity.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

