Return-Path: <linux-kselftest+bounces-36750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47297AFC942
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 13:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28B5424594
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D312D323D;
	Tue,  8 Jul 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMvJNSSX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BD1E9B2D;
	Tue,  8 Jul 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973131; cv=none; b=iCOE6GgJUueYc6UV6SmhgAsh93ABHI04CdjO0t6ln+ZV8yHjwdxTkaOAlp1ugB7veROSA5LUbna2dY9oVh00Pb7HQvzRda+c5/tdeLfHdCX0xvskW0Rw48ksohTL/CY3Eh2pQrebpu7q6t6o6q5McgIZ88dN3F1/ILjDTixnFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973131; c=relaxed/simple;
	bh=qYlJIQBZZw0QX7Jkhi3+cl9CFM1ZAaSQYY9DTNGZLoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3iP7VsSLRl8AidoIXyh1foWJdurSU4UomGIQXYMhJkgOQPJ9FaLxm6Zzm4E4i0BZi72WqUPuTpTOR8uo2mCrUJ4Ihh+wNSGR9I+Gc1Qjk18Xd+sc9LFjeJ3F8Yl6zh/WSjIJ961cmumboEvdN+/PjeOzO4BfFaBoIOzirRrUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMvJNSSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4C9C4CEED;
	Tue,  8 Jul 2025 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751973131;
	bh=qYlJIQBZZw0QX7Jkhi3+cl9CFM1ZAaSQYY9DTNGZLoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMvJNSSXJZOQ97hxkJGqHTHq1gJrmB7LR5lJL3TkMi189Qmdm08zr3t2Efa3Koyby
	 T5l+dbsvTuMBgRM79wxfqrpEvk5iZzWMRbEJ7xFmzqRjGouYk1x9GJUs5kfagP7f8m
	 2I1d4YhhcJCJSOdXpuytA/B2zMnsucdBmWpUav9YjZRP2+i1GhJDB2pmTjQcQ/+7Bd
	 owIDZ1wQWEviozdtHSW9OAsqYaYzL79b6dozKfFJu4y3aIrJnNJaYXn6nnI7lc3WCX
	 +ISVSm3kghRa12AMF9Oz6wolGPTad+/YAOKXw34JI+rfaFhl+zXampKZ3etHS30PcP
	 Vv7jEdahtlRvg==
Date: Tue, 8 Jul 2025 13:12:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v19 00/10] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
Message-ID: <aGz9ApsBD-gQ50pf@ryzen>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <roskp2zsjohrgll464u4jtbulzjid523u3yvgciifwiuoygv5t@7f7cj4wfy2y7>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <roskp2zsjohrgll464u4jtbulzjid523u3yvgciifwiuoygv5t@7f7cj4wfy2y7>

On Wed, Jul 02, 2025 at 06:57:23PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 09, 2025 at 12:34:12PM GMT, Frank Li wrote:
> 
> Frank, thanks for your persistence in pushing this series, really appreciated!
> I've left some comments, but no real blocker.
> 
> Unfortunately, I don't have access to my endpoint setup right now. So I'll go
> ahead with the Tested-by tag from Niklas once my comments are addressed.

(snip)

> > Changes in v6:
> > - add Niklas's test by tag

My Tested-by tag was added on v6, now it is v19 :)

To be comfortable of still having my Tested-by tag here,
I decided to test v19.

However I got this:

[ 3255.257047] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040
[ 3255.257824] Mem abort info:
[ 3255.258069]   ESR = 0x0000000096000004
[ 3255.258398]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 3255.258862]   SET = 0, FnV = 0
[ 3255.259147]   EA = 0, S1PTW = 0
[ 3255.259423]   FSC = 0x04: level 0 translation fault
[ 3255.259849] Data abort info:
[ 3255.260102]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 3255.260580]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 3255.261020]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 3255.261483] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000100a03000
[ 3255.262045] [0000000000000040] pgd=0000000000000000, p4d=0000000000000000
[ 3255.262639] Internal error: Oops: 0000000096000004 [#1]  SMP
[ 3255.263132] Modules linked in: rk805_pwrkey hantro_vpu v4l2_jpeg v4l2_vp9 v4l2_h264 v4l2_mem2mem videobuf2_v4l2 videobuf2_dma_contig videobuf2_memops videobuf2_common vidf
[ 3255.265357] CPU: 5 UID: 0 PID: 213 Comm: ln Not tainted 6.16.0-rc1+ #233 PREEMPT 
[ 3255.266009] Hardware name: Radxa ROCK 5B (DT)
[ 3255.266388] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 3255.266995] pc : pci_epf_bind+0x160/0x240
[ 3255.267350] lr : pci_epf_bind+0x40/0x240
[ 3255.267694] sp : ffff800081593c30
[ 3255.267983] x29: ffff800081593c30 x28: ffff0001024b2300 x27: ffff000102fc2800
[ 3255.268606] x26: ffff00010191e000 x25: ffff000100504098 x24: ffff000107b8ec80
[ 3255.269228] x23: ffff000104cf3578 x22: 0000000000000000 x21: 0000000000000000
[ 3255.269850] x20: ffff000104cf3000 x19: ffff000104cf3578 x18: 0000000000000000
[ 3255.270472] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[ 3255.271093] x14: 0000000000000000 x13: ffff00010245c037 x12: ffff800081593b94
[ 3255.271715] x11: 0000000528aa6179 x10: 0000000000000002 x9 : ffffa2593ce92b30
[ 3255.272336] x8 : 00000031636e7566 x7 : 00000000ffffbe12 x6 : 0000000000000003
[ 3255.272958] x5 : ffff000102413f78 x4 : ffff000102413f08 x3 : 0000000000000000
[ 3255.273580] x2 : ffff0001024b2300 x1 : 0000000000000000 x0 : ffff000104cf3000
[ 3255.274201] Call trace:
[ 3255.274416]  pci_epf_bind+0x160/0x240 (P)
[ 3255.274767]  pci_epc_epf_link+0x54/0xb0
[ 3255.275104]  configfs_symlink+0x208/0x540
[ 3255.275457]  vfs_symlink+0x158/0x1e0
[ 3255.275770]  do_symlinkat+0x8c/0x138
[ 3255.276083]  __arm64_sys_symlinkat+0x7c/0xc8
[ 3255.276455]  invoke_syscall.constprop.0+0x48/0x100
[ 3255.276874]  el0_svc_common.constprop.0+0x40/0xe8
[ 3255.277285]  do_el0_svc+0x24/0x38
[ 3255.277575]  el0_svc+0x34/0x100
[ 3255.277852]  el0t_64_sync_handler+0x10c/0x140
[ 3255.278233]  el0t_64_sync+0x198/0x1a0
[ 3255.278554] Code: a9446bf9 394ff280 b902aa80 aa1403e0 (f94022a1) 
[ 3255.279085] ---[ end trace 0000000000000000 ]---


Seems to be from patch 1/10:

(gdb) l *(pci_epf_bind+0x160)
0xffff800080892c50 is in pci_epf_bind (drivers/pci/endpoint/pci-epf-core.c:132).
127                             goto ret;
128                     epf_vf->is_bound = true;
129             }
130
131             epf->dev.id = PCI_EPF_DEVID(epf->func_no, 0);
132             device_set_of_node_from_dev(&epf->dev, epc->dev.parent);
133             ret = epf->driver->ops->bind(epf);
134             if (ret)
135                     goto ret;
136             epf->is_bound = true;


I can see that there is a lot of discussion on patch 1/10 already,
but please drop my Tested-by tag until this has been fixed.

Feel free to CC me on v20 of this series, if the problem is fixed,
I will provide my Tested-by tag once again.


Kind regards,
Niklas

