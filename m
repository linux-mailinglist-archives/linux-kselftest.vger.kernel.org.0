Return-Path: <linux-kselftest+bounces-36752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053E7AFC987
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 13:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9426C562FFF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1A29A30A;
	Tue,  8 Jul 2025 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhJMpraE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32672F9E8;
	Tue,  8 Jul 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973884; cv=none; b=DYkeBzGW1yH4nybYbCHVTE72l5iV9E6sahYgilFMUTznIyvTFs9CaDnXaur9dWceyKWzz8pPb+8l4+zYBItDO5861OzlfDSu7w2y5wzDjxeWZJ70hd7qXLQyCrQNPE3KL4pHeUt/29ulRdKzIIhImSjx+b6zIMhPlymmLC0xndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973884; c=relaxed/simple;
	bh=ub0XD/BUBPwpna9WJBPqCPyFaCbrf6wCSkIYxQtFAjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0/rJsF05vJujdg24GXzIC63iyDBfn8A3+4rCjWZUDsXxDkqzQdXjJe7PvXU0lzWqyzWtSQN6IhRlCfk2cdx0FxAQEz6HiZ+hevpf5lKsGBEbNfTUzP4EM20RP0hJHHHIZVPu8zMRQDNZ/XWbWBONexScJbRp/dZ70u7GtLGNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhJMpraE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C832CC4CEED;
	Tue,  8 Jul 2025 11:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751973883;
	bh=ub0XD/BUBPwpna9WJBPqCPyFaCbrf6wCSkIYxQtFAjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhJMpraEN5xRRR79r142B/FvOOIOBlLbSNwH6giqHZ3J3f8bOotU33EcQt1gjLLLU
	 nv6uYBx1SNPIq8PZAiywCaiXl4+dz30aJwpye0mNKSwOigAkeGnpM23Gdn2oLCqzJ1
	 yt7MrgppQQn0ztN49pUA5dlShazE1yxuklUZVPI5HZDz3mTaVnasWNtRW5N4+xdwb6
	 OD3PsxNWM1XG3mk8go4uqt0JDgnPePhSOg4gsJDea9o1rQBuH4nRsBPbq2FcA3VCqs
	 UK4TbpQVhSbZnqhywVzM4SON3rjUF7rc5VFmC89amKqxvAXtLi3c3YqO8O/3Non4xT
	 cMyYvp59zib3Q==
Date: Tue, 8 Jul 2025 16:54:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
	Marc Zyngier <maz@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v19 00/10] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
Message-ID: <p46vymcn76xpz64z66bwxjnbkbdbhqhtwycff2xyb3damnf2se@yo6puygfwxjq>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <roskp2zsjohrgll464u4jtbulzjid523u3yvgciifwiuoygv5t@7f7cj4wfy2y7>
 <aGz9ApsBD-gQ50pf@ryzen>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGz9ApsBD-gQ50pf@ryzen>

On Tue, Jul 08, 2025 at 01:12:02PM GMT, Niklas Cassel wrote:
> On Wed, Jul 02, 2025 at 06:57:23PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jun 09, 2025 at 12:34:12PM GMT, Frank Li wrote:
> > 
> > Frank, thanks for your persistence in pushing this series, really appreciated!
> > I've left some comments, but no real blocker.
> > 
> > Unfortunately, I don't have access to my endpoint setup right now. So I'll go
> > ahead with the Tested-by tag from Niklas once my comments are addressed.
> 
> (snip)
> 
> > > Changes in v6:
> > > - add Niklas's test by tag
> 
> My Tested-by tag was added on v6, now it is v19 :)
> 

Ouch!

> To be comfortable of still having my Tested-by tag here,
> I decided to test v19.
> 
> However I got this:
> 
> [ 3255.257047] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040

Very well... thanks for testing it. I will also try to get hold of the device in
the meantime.

- Mani

> [ 3255.257824] Mem abort info:
> [ 3255.258069]   ESR = 0x0000000096000004
> [ 3255.258398]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 3255.258862]   SET = 0, FnV = 0
> [ 3255.259147]   EA = 0, S1PTW = 0
> [ 3255.259423]   FSC = 0x04: level 0 translation fault
> [ 3255.259849] Data abort info:
> [ 3255.260102]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [ 3255.260580]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [ 3255.261020]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [ 3255.261483] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000100a03000
> [ 3255.262045] [0000000000000040] pgd=0000000000000000, p4d=0000000000000000
> [ 3255.262639] Internal error: Oops: 0000000096000004 [#1]  SMP
> [ 3255.263132] Modules linked in: rk805_pwrkey hantro_vpu v4l2_jpeg v4l2_vp9 v4l2_h264 v4l2_mem2mem videobuf2_v4l2 videobuf2_dma_contig videobuf2_memops videobuf2_common vidf
> [ 3255.265357] CPU: 5 UID: 0 PID: 213 Comm: ln Not tainted 6.16.0-rc1+ #233 PREEMPT 
> [ 3255.266009] Hardware name: Radxa ROCK 5B (DT)
> [ 3255.266388] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 3255.266995] pc : pci_epf_bind+0x160/0x240
> [ 3255.267350] lr : pci_epf_bind+0x40/0x240
> [ 3255.267694] sp : ffff800081593c30
> [ 3255.267983] x29: ffff800081593c30 x28: ffff0001024b2300 x27: ffff000102fc2800
> [ 3255.268606] x26: ffff00010191e000 x25: ffff000100504098 x24: ffff000107b8ec80
> [ 3255.269228] x23: ffff000104cf3578 x22: 0000000000000000 x21: 0000000000000000
> [ 3255.269850] x20: ffff000104cf3000 x19: ffff000104cf3578 x18: 0000000000000000
> [ 3255.270472] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [ 3255.271093] x14: 0000000000000000 x13: ffff00010245c037 x12: ffff800081593b94
> [ 3255.271715] x11: 0000000528aa6179 x10: 0000000000000002 x9 : ffffa2593ce92b30
> [ 3255.272336] x8 : 00000031636e7566 x7 : 00000000ffffbe12 x6 : 0000000000000003
> [ 3255.272958] x5 : ffff000102413f78 x4 : ffff000102413f08 x3 : 0000000000000000
> [ 3255.273580] x2 : ffff0001024b2300 x1 : 0000000000000000 x0 : ffff000104cf3000
> [ 3255.274201] Call trace:
> [ 3255.274416]  pci_epf_bind+0x160/0x240 (P)
> [ 3255.274767]  pci_epc_epf_link+0x54/0xb0
> [ 3255.275104]  configfs_symlink+0x208/0x540
> [ 3255.275457]  vfs_symlink+0x158/0x1e0
> [ 3255.275770]  do_symlinkat+0x8c/0x138
> [ 3255.276083]  __arm64_sys_symlinkat+0x7c/0xc8
> [ 3255.276455]  invoke_syscall.constprop.0+0x48/0x100
> [ 3255.276874]  el0_svc_common.constprop.0+0x40/0xe8
> [ 3255.277285]  do_el0_svc+0x24/0x38
> [ 3255.277575]  el0_svc+0x34/0x100
> [ 3255.277852]  el0t_64_sync_handler+0x10c/0x140
> [ 3255.278233]  el0t_64_sync+0x198/0x1a0
> [ 3255.278554] Code: a9446bf9 394ff280 b902aa80 aa1403e0 (f94022a1) 
> [ 3255.279085] ---[ end trace 0000000000000000 ]---
> 
> 
> Seems to be from patch 1/10:
> 
> (gdb) l *(pci_epf_bind+0x160)
> 0xffff800080892c50 is in pci_epf_bind (drivers/pci/endpoint/pci-epf-core.c:132).
> 127                             goto ret;
> 128                     epf_vf->is_bound = true;
> 129             }
> 130
> 131             epf->dev.id = PCI_EPF_DEVID(epf->func_no, 0);
> 132             device_set_of_node_from_dev(&epf->dev, epc->dev.parent);
> 133             ret = epf->driver->ops->bind(epf);
> 134             if (ret)
> 135                     goto ret;
> 136             epf->is_bound = true;
> 
> 
> I can see that there is a lot of discussion on patch 1/10 already,
> but please drop my Tested-by tag until this has been fixed.
> 
> Feel free to CC me on v20 of this series, if the problem is fixed,
> I will provide my Tested-by tag once again.
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

