Return-Path: <linux-kselftest+bounces-36338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8EAF5C0E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 17:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32169522EEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730B11531E3;
	Wed,  2 Jul 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFPz1ekK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF72D0C61;
	Wed,  2 Jul 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468504; cv=none; b=K5tTxEw6fO+XgTQYcRcfVpi+S+x28oQbIfmAriuooZF9gYoByZECwqladuOwv6bHijJFE3ZFBVLbY60CHjcLh1cGHusjsQYUD6W3I5Aq4wJVv9WX5ZNFPO2WA0phKVw4TrhsjYu6g83UyJozNTWzvxfoe6q2Qqose1r9g57t50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468504; c=relaxed/simple;
	bh=SaHDZ4wIBsKxb9s+1iRJfvfGTvCsTriRDi+uhUgl3qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeEN72xbTZF9XQarSUSZGsOt1E+ZAKaTLbWdgRCaZ8nYAkM7ZzK6RCcD8r/FfWIzYGUtC6zuMozOneWegmGcmhMRGxNap8yGDJXF5ANIR11y2lDHp0+vajB+WVVNWQORP1/RUkCuNZ7PIWe1SXgG7s8TgHjA6pmcAr55/4XFsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFPz1ekK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D895C4CEE7;
	Wed,  2 Jul 2025 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468503;
	bh=SaHDZ4wIBsKxb9s+1iRJfvfGTvCsTriRDi+uhUgl3qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFPz1ekKdZbVNAz4rJGd5xyY5sZ4nqGJ+5hipsT580I38dRu8oiRtgERhYUGL17Dw
	 OLLSrukOiRKQqk1QszwYYUfSyffBrcBmdkpPPNk722l6XE4DDnPXgt9jnW+IsfOyWg
	 6nk2yLMejqVFloDl7E6PNxNapikx72jx4TufUVvI/x/j6wsdr9dRdnfmkOQmQH5XC5
	 9Rcyq+yh2Q9iNexx2zcOy7LZXMM6pb5OQoWn+Bq4f6vfz1n8To/nIOmhdfdvQ+DrGT
	 egmcTbxiUt3JJ413o+IYnU53CQrO2X3C1AeROg3WY7ywthUO4zhjGX8Z9udVC3wkXp
	 Kr8PhJFJNpprQ==
Date: Wed, 2 Jul 2025 20:31:25 +0530
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
Subject: Re: [PATCH v19 03/10] PCI: endpoint: pci-ep-msi: Add MSI
 address/data pair mutable check
Message-ID: <tkamojjbdfrwhvgyufcncikl6fkndedfyzm5ebo7qof66s4gmu@mjsgrcfdkms5>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-3-77362eaa48fa@nxp.com>
 <5axgxbtyqbwwncimjiiedvkm3ap7at553vgj72bht4kynke5cd@xfghwfmp6cy7>
 <aGVFWgnAIwWOnLjK@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGVFWgnAIwWOnLjK@lizhi-Precision-Tower-5810>

On Wed, Jul 02, 2025 at 10:42:43AM GMT, Frank Li wrote:
> On Wed, Jul 02, 2025 at 05:00:23PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jun 09, 2025 at 12:34:15PM GMT, Frank Li wrote:
> > > Some MSI controller change address/data pair when irq_set_affinity().
> > > Current PCI endpoint can't support this type MSI controller. Call
> > > irq_domain_is_msi_immutable() check if address/data pair immutable.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > change in v18
> > > - update commit message. remove 'include/linux/msi.h' part.
> > >
> > > change from v14 to v17
> > > - none
> > >
> > > change from  v13 to v14
> > > - bring v10 back
> > >
> > > Change from v9 to v10
> > > - new patch
> > > ---
> > >  drivers/pci/endpoint/pci-ep-msi.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > > index 549b55b864d0e..c0e2d806ee658 100644
> > > --- a/drivers/pci/endpoint/pci-ep-msi.c
> > > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > > @@ -44,6 +44,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> > >
> > >  	dev_set_msi_domain(dev, dom);
> > >
> > > +	if (!irq_domain_is_msi_parent(dom))
> > > +		return -EINVAL;
> >
> > This check is not justified in commit message.
> >
> > > +
> > > +	if (!irq_domain_is_msi_immutable(dom)) {
> > > +		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
> > > +		return -EINVAL;
> >
> > GICv3 ITS is an immutable MSI controller. From the earlier patches, I could see
> > that you have tested this series with ITS. How did that happen if it errors out
> > here?
> 
> I removed IMMUTASBLE flags in ITS driver to check if go to this error branch.
> 

Sorry, I misread the check and got confused by the error message. Presence of
IMMUTABLE flag is required by this driver, which is fine. Please reword the
error message to,

	"MSI controller not supported\n"

If one bothers to check why, the !irq_domain_is_msi_immutable() check is self
explanatory.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

