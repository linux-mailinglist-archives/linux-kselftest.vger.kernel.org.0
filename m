Return-Path: <linux-kselftest+bounces-22709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF759E0A44
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 18:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D916162CDD
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA241DAC97;
	Mon,  2 Dec 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwzL9nrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD031D61A2;
	Mon,  2 Dec 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161209; cv=none; b=Ut5ScEp+iwRFIP1+tFposbgFWoPen+cryQl84XwkBTWl/BicqqDf02MW5jGE562LSshjDi8/7qR0rkbfPmgYXQ+gD7gZ38yk3sEUIB4am+eKNTzlRqq+bz4EOs5F23SG1aA0SdprhoCgIqF5BsBs1YrGsFGBgjqdK5qqQDVoB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161209; c=relaxed/simple;
	bh=eaL8cC21xnf23Ecwe2rInbBhfl0hfiNSoyNwp9NMFTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TMceABs4umpaqp3yM2a55HCLLh/qwzLlgvqqbg00mI9hkNuTccomuW8wyxA457rtUNE324znY+SOsrGnfZ7BIWBOk63cYxamAfvQj9Py7EikQ9AmcwM3iK/qCalqxFgypxosxQRPki0tagCcN2i2EwViwx0lbNo5R1OcdXbELXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwzL9nrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BA7C4CED1;
	Mon,  2 Dec 2024 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733161209;
	bh=eaL8cC21xnf23Ecwe2rInbBhfl0hfiNSoyNwp9NMFTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XwzL9nrR46ZUQQBF/Cfqgfs1w85invh8HKkiybCnyLrEAtVqNB1p68veHs8gpbJ2A
	 /hq1NkFqHuPqePepEotMIWmvb0CUvsez4rFylJtAuXgRW+lUMwYMxJp/ggkvrc04IO
	 O7ZHYiWVvUfb2uxuewRaeY3txjgR9NxWbVj3I/aLJPus3ZRwAeV7y58XSBgx4e2G0W
	 NSIMcaUOqF8bISHy7KoAjYmboKzhD7SjH6a1e4r/5B+Yncjp0auvf7p29ztozgTzmU
	 ibMvf6dcSOaeByzIu8DgAVoeigO3Oo8ZO0Vfs7yza43w4TtijMK+7ZNc0kid2/gy1F
	 74sTjn3Ni7ZcA==
Date: Mon, 2 Dec 2024 11:40:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH v2 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and
 BAR1/BAR3 as RESERVED
Message-ID: <20241202174007.GA2902663@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202125845.rp4vc7ape52v4bwd@thinkpad>

On Mon, Dec 02, 2024 at 06:28:45PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 29, 2024 at 01:55:37PM -0600, Bjorn Helgaas wrote:
> > On Fri, Nov 29, 2024 at 02:54:12PM +0530, Manivannan Sadhasivam wrote:
> > > On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default
> > > and software cannot change the type. So mark the those BARs as
> > > 64bit BARs and also mark the successive BAR1/BAR3 as RESERVED
> > > BARs so that the EPF drivers cannot use them.
> ...

> > > Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
> > 
> > If stable maintainers need to act on this, do they need to search for
> > the patch introducing only_64bit flag?  That seems onerous; is there a
> > SHA1 that would make it easier?
> 
> But that's not the point of having noautosel tag, AFAIK.
> 
> Documentation/process/stable-kernel-rules.rst clearly says that this
> tag is to be used when we do not want the stable team to backport
> the commit due to a missing dependency.
> ...

> Here I did not intend to backport this change with commit adding
> only_64bit flag because, I'm not sure if that dependency alone would
> be sufficient. If someone really cares about backporting this
> change, then they should figure out the dependencies, test the
> functionality and then ask the stable team.

Oh, sorry, I was assuming "stable+noautosel@kernel.org" was a hint for
stable maintainers to pick this up, not a hint to ignore it.
Eventually this meaning will sink in.

Bjorn

