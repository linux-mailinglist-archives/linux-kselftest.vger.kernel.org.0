Return-Path: <linux-kselftest+bounces-36818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA13AFE5CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 12:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569377B143B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95D28CF4C;
	Wed,  9 Jul 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja+kjQ3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF128852B;
	Wed,  9 Jul 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057253; cv=none; b=CRavCuJCqwk430JijETThK0KBtYzhOyHvWPGntDTgR1m6EDCJ60Tk5uHsuqYK82Yx92O46PygzjQqEl/fHvVv5GB1SSFAyPWk7vGyC2/i9wYe1tEbZ0MY3Mm2qpv9Jez0UjLHHKM4h4OSikZ6PdQ4rgSI3KEMQCiNuq1zKBopZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057253; c=relaxed/simple;
	bh=RrMs7jb9Owzmd41VYTEMBPmljFB7+r5sQc9aQn/1l+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9HAmI1sXiQAMNmfVb+urAdDfhXHjTFYAM97qud2QhYfr7NCTNNzkG6ghTycEnBqlTwV1gTtYtXbbSF+EE0ylR8f8DalxwltKWSE08f4YcDhuycVi86ZrLyEaee/ZSMyF5gFZzYICXypbP4wQwRLNS57x6nM14k0IWWK1FOiTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja+kjQ3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0859DC4CEEF;
	Wed,  9 Jul 2025 10:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057253;
	bh=RrMs7jb9Owzmd41VYTEMBPmljFB7+r5sQc9aQn/1l+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ja+kjQ3Lc9ztkPibgFI8EvyOzBXUbDXpI0q5qPudQ0sTTuOvKafWyrT1IMlmCsEQh
	 YJiF4j2u/czhenhFarj61pcOUQOVRHRRohoumonJJtTlTa7IBAcehOYpa4inipHw0T
	 ILhw9rrOymaM2AyLf9lDJ4OEb1YBqutqE34npym9PBUjPiq5KjL0/524LxG9w/51DU
	 QNRzSM+D9Erbm966L9QJkMU4GDz5avVUkIf4Q0MPsXuM1e22RNtAjNnnOcH4DMF3YW
	 q1dNvpXI+EZ7soF5lM4wl//kVpkRbSYfFfxCsj4Ou3f3KKbc5xXvPP8lNKcSx+ZUJd
	 Pbl1wxGGzijgg==
Date: Wed, 9 Jul 2025 16:03:57 +0530
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
Message-ID: <3aq4qqx6ip2f567f6vjraojqcgvoo6t4impyhlbovb2zo5ptxq@5x3g5zdbhxgo>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>
 <ne5yrjtdevmndqds4uwo2ppq6gay2wuwjouyf33lqr5g3nfkwr@lkwqlwqjqbmx>
 <aGVE6veZm3bL0mVJ@lizhi-Precision-Tower-5810>
 <75opnvi46fbmsnmykjwn3gmir7r3uqhzp7tfoua42cado6aopu@dmos2v2qd3jn>
 <aGVN/5yoLumfmlDv@lizhi-Precision-Tower-5810>
 <aGv4slE8/kmxHvlU@lizhi-Precision-Tower-5810>
 <jx3nhhyj3dh5ivga6i3va35rz7n4disz33dtbwvbs4raqb4iww@q6m73lnwkjsf>
 <aG1sGgQ4EYC2D8Wc@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG1sGgQ4EYC2D8Wc@lizhi-Precision-Tower-5810>

On Tue, Jul 08, 2025 at 03:06:02PM GMT, Frank Li wrote:
> On Tue, Jul 08, 2025 at 04:51:55PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jul 07, 2025 at 12:41:22PM GMT, Frank Li wrote:
> > > On Wed, Jul 02, 2025 at 11:19:36AM -0400, Frank Li wrote:
> > > > On Wed, Jul 02, 2025 at 08:25:17PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Wed, Jul 02, 2025 at 10:40:53AM GMT, Frank Li wrote:
> > > > > > On Wed, Jul 02, 2025 at 04:30:48PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Mon, Jun 09, 2025 at 12:34:13PM GMT, Frank Li wrote:
> > > > > > > > Set device ID as 'vfunc_no << 3 | func_no' and use
> > > > > > > > 'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
> > > > > > > > device.
> > > > > > > >
> > > > > > > > Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
> > > > > > > > settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
> > > > > > > > functions use the EPC's device node, but they should use the EPF one.
> > > > > > > > For multiple function drivers, IOMMU/MSI should be different for each
> > > > > > > > function driver.
> > > > > > > >
> > > > > > >
> > > > > > > We don't define OF node for any function, so device_set_of_node_from_dev() also
> > > > > > > ends up reusing the EPC node. So how can you make use of it in multi EPF setup?
> > > > > >
> > > > > > In mfd devices, children devices reuse parent's of_node
> > > > > > drivers/gpio/gpio-adp5585.c
> > > > > > drivers/input/keyboard/adp5589-keys.c
> > > > > > drivers/pwm/pwm-adp5585.c
> > > > > >
> > > > > > multi EPF should be similar to create multi children devices of mfd.
> > > > > >
> > > > >
> > > > > No, they are not similar. MFD are real physical devices, but EPFs are (so far)
> > > > > software based entities.
> > > > >
> > > > > > > I don't understand.
> > > > > >
> > > > > > >
> > > > > > > > If multiple function devices share the same EPC device, there will be
> > > > > > > > no isolation between them. Setting the ID and 'of_node' prepares for
> > > > > > > > proper support.
> > > > > >
> > > > > > Only share the same of_node.
> > > > > >
> > > > > > Actually pci host bridge have similar situation, all pci ep devices reuse
> > > > > > bridge's of node. framework use rid to distringuish it. EPF can use device::id
> > > > > > to do similar things.
> > > > > >
> > > > > > Actually iommu face the similar problem. So far, there are not EP device enable
> > > > > > iommu yet, because it needs special mapping.
> > > > > >
> > > > > > Prevously, I consider create dymatic of_node for each EPF and copy iommu/msi
> > > > > > information to each children. But when I see adp5585 case, I think direct
> > > > > > use parent's of_node should be simple and good enough.
> > > > > >
> > > > > > In future, I suggest add children dt binding for it. For example: EPF provide
> > > > > > a mailbox interface. how other dts node to refer to this mailbox's phandle?
> > > > > >
> > > > >
> > > > > As I said above, EPFs are not real devices. There is currently only one
> > > > > exception, MHI, which is backed by a hardware entity. So we cannot add
> > > > > devicetree nodes for EPF, unless each EPF is a hardware entity.
> > > >
> > > > But how resolve this problem, if a DT device need phandle to a EPF? anyway
> > > > this is off topic. let go back this doorbell.
> > > >
> > > > It needs an of_node for EPF device, I tried many method before.
> > > >
> > > > Create dymatic of_node for it? MSI framework still go through to parent
> > > > of_node to get such information. not big differnece as my view.
> > >
> > > Actually, DMA have simular issues, just 'workaround' it now.
> > >
> > > pci_epf_test_read() {
> > > 	...
> > > 	struct device *dma_dev = epf->epc->dev.parent;
> > > 	...
> > > 	dst_phys_addr = dma_map_single(dma_dev, buf, map_size,
> > >                                                        DMA_FROM_DEVICE);
> > > 					^^^ [1]
> > > 	...
> > > }
> > >
> > > [1] here direct use epc->dev.parent's of node implicy. If IOMMU enable,
> > > two EPF will share one IOMMU space without isolation. If add of_node(may
> > > dyamatic create one). we should resolve this problem by use epf device
> > > here. Difference EPF will use difference IOMMU space like MSI.
> > >
> >
> > Unless your platform comes up with a hardware based EPF, we are not going to
> > have DT node for any EPF. So all EPFs have to share the same DT node of the EPC.
> > So right now, it doesn't make a difference if you use a dynamic of_node or copy
> > the EPC node.
> >
> > Just reuse the EPC node for now.
> 
> It is show-stop issue. The closest version like
> https://lore.kernel.org/all/20241204-ep-msi-v10-2-87c378dbcd6d@nxp.com/
> 
> Or we just support one EPF. There are not good way to pass down epf ID to MSI
> controller.
> 
> [1]: Add DOMAIN_BUS_DEVICE_PCI_EP_MSI (like PCI RC bus),
> https://lore.kernel.org/all/20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com/
> rejected by irq mantainer, they think it is too similar with platform msi.
> 
> The key problem is MSI controller need known both EPF's ID and EPC's MSI
> domain information.
> 
> If use EPC, there are no way to pass down EPF's ID. as above dma example,
> use EPC devices, dma_map_single() can't distringiush difference EPF. It is
> not big issue all EPF share a IO space. but can't do that for MSI. the
> different devices can't share the MSI space.
> 
> software managed dt property already used in many devices.
> 

You need not just a property, but a whole new DT node. This won't fly with the
DT maintainers, so it is not my call.

I'd suggest that we merge this initial implementation that supports only one EPF
for doorbell and tackle the multi-EPF implementation in future patches. I do not
want this series to be in a limbo for another 5-6 releases.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

