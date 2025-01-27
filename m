Return-Path: <linux-kselftest+bounces-25240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB3EA1DAA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 17:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AB13A4940
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91B415B99E;
	Mon, 27 Jan 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alivTVP9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA4152E12;
	Mon, 27 Jan 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995502; cv=none; b=rIeAjR0AAY8U7KXLAR5O6rQ8XlSkWFtmsLmuyS/7ukhoIj0Ant41aSBEArtXzhDv6C8ASYjL8eBFbgVhygt+eSbMQ28lhO47XjL+s4EmsxF04kZhps9WRFom6qe58VSKY8kDZpA0zQwE57ypFRC4dG/eN4WloGXeHEzGiMCM2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995502; c=relaxed/simple;
	bh=+QNWyu54UoFRSzwPxyjGf0cc7ES/0NFeDBvLV9Q2of8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCJIc37So8Tbz2BSlXiuehZwckTSvVk/0Vj9Sz98E62iuf2Nz/2uj0R6olWkxWkBZ5sT0tiUH8gLqCgPBDeRav4oKSc6Gd34SzkBQjM1nfaCJ4H/SSMSaybPvQLB4X20qDZUZUAVdfXKuqkqhvh1WaijEJ77lPvBESdtHLB7InA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alivTVP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33028C4CED2;
	Mon, 27 Jan 2025 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737995502;
	bh=+QNWyu54UoFRSzwPxyjGf0cc7ES/0NFeDBvLV9Q2of8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alivTVP9giaAmpnEj4v1P3jaoe/aIX06fGRzxDp2+fsHgYeP5Uuz2sy6UwBjm6Uon
	 RFrdAl1F/j/4Tmyf7LBGlHbmzsA6/en1fFyIC7nFTgeamKV2AZXkG1tBXFQiPiCDvV
	 bjgatL9/326fm6qtvnijb5cM10S8mu7Cg9+Ej+DMf92rTM+WSxgkN1dtKuwCx154Ir
	 jWuSapsdv2lsqckBrQhV/SVtpqhHrAHg1flwVMUtvMXax8ZBoWUivBGjIuV2hjvmke
	 foFT2WjEgzHfzgkqIRCI1uQ6e9W2ErFuhEMpXj40w3ZbPMQCLzwpyjwD0GT0mvO4zx
	 tZBVJr/diN9nw==
Date: Mon, 27 Jan 2025 17:31:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com, kw@linux.com
Cc: linux-pci@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: Give disabled BARs a
 distinct error code
Message-ID: <Z5e06sgIp3DI8viG@ryzen>
References: <20250123120147.3603409-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123120147.3603409-3-cassel@kernel.org>

On Thu, Jan 23, 2025 at 01:01:48PM +0100, Niklas Cassel wrote:
> ---
> Hello PCI maintainers.
> This patch might give a trivial conflict with:
> https://lore.kernel.org/linux-pci/20250123095906.3578241-2-cassel@kernel.org/T/#u
> because the context lines (lines that haven't been changed)
> might be different. If there is a conflict, simply look at
> this patch by itself, and resolution should be trivial.

Note to PCI maintainers:

As mentioned in the comment section of this patch,
this patch has a trivial conflict with:
https://lore.kernel.org/linux-pci/20250123095906.3578241-2-cassel@kernel.org/T/#u

I noticed that git still manages to apply this patch correctly if applying
this patch using:
$ git am -3


Kind regards,
Niklas

