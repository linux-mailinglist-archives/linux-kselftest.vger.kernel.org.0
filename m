Return-Path: <linux-kselftest+bounces-22643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 455759DF1F6
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA02AB21550
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8019419F121;
	Sat, 30 Nov 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NfUoPrSu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819E42AA4;
	Sat, 30 Nov 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732983482; cv=none; b=KbYJEpFBhwmiQgB/EfE1seyNEPyzc60QYxVJifVQW/gHHdVO7yAiO1ZeLWlQL+8fFoDyTJ73/9MTQ6JK+at3kXP19GrhAlvVsJQHcio+74aW83I4C12UWtlnkk2ChTJUB1Zo/8dwFA/moFEWYHw2DdUILhsPvudjK1y1+OUSmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732983482; c=relaxed/simple;
	bh=5EcFezNDIfLoX+AW+e5HPHB1UA8mXxmsmQZ1je4SRTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgN2RsvcCsEn8ktOHnjaSLylI3FiZ8FM1fnA6V6pvBf5e+wGA+roWShAJKKsmCLUhHk7+/9tRSSJIVKYRXFhhmftKt766VZzpM+W/S/NYWeVgL5X96IetcYdufc7VTDiS38ad6v89wYQdlMEYMSHZV+Ewn5vkV64tetNJeBPcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NfUoPrSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7095DC4CECC;
	Sat, 30 Nov 2024 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732983482;
	bh=5EcFezNDIfLoX+AW+e5HPHB1UA8mXxmsmQZ1je4SRTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfUoPrSuDdkStWo2G8h/BgmpRn+psCwcgoPLdf/JpyN/SvrnNnY7twPksLNd06DtX
	 5pyxApO7cDaDhUqwclpiX6m2XC2yrsm1ha6lgFmC9zdDJuH7odPoBb1m5ldp81Gf0m
	 LAW82aUZE3UTy5dKclwgckrcGOUeCPFNWEPOZm4U=
Date: Sat, 30 Nov 2024 17:17:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, kw@linux.com,
	arnd@arndb.de, lpieralisi@kernel.org, shuah@kernel.org,
	kishon@kernel.org, aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH v2 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and
 BAR1/BAR3 as RESERVED
Message-ID: <2024113005-oboe-widow-d61e@gregkh>
References: <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>
 <20241129195537.GA2770926@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129195537.GA2770926@bhelgaas>

On Fri, Nov 29, 2024 at 01:55:37PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 29, 2024 at 02:54:12PM +0530, Manivannan Sadhasivam wrote:
> > On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
> > cannot change the type. So mark the those BARs as 64bit BARs and also mark
> > the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
> > use them.
> 
> "Default" implies an initial setting that can be changed, but you say
> "by default" and also "software cannot change the type."  Can they be
> anything *other* than 64-bit BARs?
> 
> If they're hardwired to be 64-bit BARs, I would just say that.
> 
> > Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
> 
> If stable maintainers need to act on this, do they need to search for
> the patch introducing only_64bit flag?  That seems onerous; is there a
> SHA1 that would make it easier?
> 
> > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")

Yes, having a sha1 that has that "feature addition" would be great,
surely that isn't 6.13-rc1, is it?

thanks,

greg k-h

