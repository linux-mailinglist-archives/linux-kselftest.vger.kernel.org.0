Return-Path: <linux-kselftest+bounces-41110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7DB51172
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 10:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70267188AF0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 08:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41B43101A2;
	Wed, 10 Sep 2025 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TTC97Rhn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828D309EEF;
	Wed, 10 Sep 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493291; cv=none; b=cr8g+tM4DSOYTEp2bsM9U7cdB8N8nMyF6pnYN7975UnbobnL5O6h+M/R89uuJW4zsEXizmmWF98qeNvm2qAy5grEAb2MpMviFttp1KmIfW4Wpk/3TPitFXBme0juFUggHpTvBBjf0gvPdylntqV6woJEsJKEHMwM0TSJmhAijGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493291; c=relaxed/simple;
	bh=b30MO4zp9p/RKhKI6RZvaV69XNrXjRj73xkh/4Xi8jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU+fpiOLxSREt1g8quH4mzaRZCgVnVKYGbXjfJD4YetzfDK378Z+POYcuE7Rh5qVK7QB1PmtwLdz1w/eSc3Yc4Fc2NzAQFeMlWtLKFIK7Nrd3FCdJ/7ajaeFh3uWV+JC9zxOVfgOVvgX+gMzEGyOzrO+Sxf7CqcegXsrLOQfFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TTC97Rhn; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ZfdHANOehTUP1HPo2Io2Zx+Al3fFDMd7EV9Pa2pY7UU=;
	b=TTC97RhnEgJfdlDzGW47lqFtg2e6cVlsSCFfrsS/oXpiK2FMEG2qNi5T/ibO0f
	vlpeixtVmt1bFDP4BvEV0nNZDFTnVMZhDOA/n2fPXrb7JnyIKu8wBGBocSMbxJwL
	sE+NWsgAtsE0QI2yAAAtP0WKCTHAT8Tu4r4IigBUOgd8k=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBnJW+NN8FoDMs8BA--.39270S3;
	Wed, 10 Sep 2025 16:32:16 +0800 (CST)
Date: Wed, 10 Sep 2025 16:32:13 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank.Li@nxp.com
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
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
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v21 9/9] arm64: dts: imx95: Add msi-map for pci-ep device
Message-ID: <aME3jbmlRVcT2biX@dragon>
References: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
 <20250710-ep-msi-v21-9-57683fc7fb25@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-ep-msi-v21-9-57683fc7fb25@nxp.com>
X-CM-TRANSID:M88vCgBnJW+NN8FoDMs8BA--.39270S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU8zVbUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIhB84WjBN5DjOQAA37

On Thu, Jul 10, 2025 at 03:13:55PM -0400, Frank Li via B4 Relay wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add msi-map for pci-ep device.
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


