Return-Path: <linux-kselftest+bounces-23493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F5F9F614A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 10:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4A16C323
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FB91990D6;
	Wed, 18 Dec 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSavLOVH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283A1990AF;
	Wed, 18 Dec 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513566; cv=none; b=qVUfaA9pSgn7sMJyP7vdqoS0DibzEyfDcRhgx1+rdkNPBCVlb7dkl0GWrcRlyP9p6xSvbVbX4UoDD41QCnHg/86YP9yuskkp0poya1L/npm9n5R3rwCy4jrYxpMPKFnsk6qPqZw2jXwp734A6upytAlESzs5pSLssV44K/AwO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513566; c=relaxed/simple;
	bh=XTLIOHxUqyXug0V3m3wdVWkNSyqhrDwpS2lvo1q2VfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1kLxX4gw8r/QJcVO3uvJeHgLDC6M0zp7/V5IB0PrM6V0/rAwj/nkGS2XAVdi+svONkn62cjPZ+0L2szK57/hthKcW1GSvxHQplzI1EUOwNJRInIYmrfXxkyjA7/BDGiPueDz1Flch9EEMhFlZ6hFfJpQOxnZuwxNJcyX+bxfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSavLOVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E16EC4CED0;
	Wed, 18 Dec 2024 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734513565;
	bh=XTLIOHxUqyXug0V3m3wdVWkNSyqhrDwpS2lvo1q2VfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSavLOVH5DIbKaU+nW9OA1MY/kWn5fZrXc1XDKhfnZ1pcdunthoYWcAgQP9orrWPr
	 e0GFO9xHVGJvsfRdMhTJeW2tP4ZNIZGGUGN8kGPEh6Zfl4UTyC2GGEBGqDi9Sd/aRH
	 Zq8z3XHhRc9L+f0yDPFV+j+T9VOtfp+OBaWUf1/IhPrwOUcQZ3nBnKhFpKCsX5jHcM
	 BRDBRcelN+QelQnfajL88XBLwh6ruQqpJ1hIUW8krttG3LVcImCx9p0tDxxIJHkxUC
	 Igskn+085k7a+bzHMMYLtwdqmlOM+EApgOQ2tpb7tUlm5sXvlx9gEFlxVXodQ8Bxay
	 ZTpJrU3izGpWA==
Date: Wed, 18 Dec 2024 10:19:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <Z2KTmMjzRPIFdvfo@ryzen>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
 <Z1qsIREtdeR38fF6@ryzen>
 <20241216060337.cvhwvdzt34ocg2uf@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216060337.cvhwvdzt34ocg2uf@thinkpad>

On Mon, Dec 16, 2024 at 11:33:37AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Dec 12, 2024 at 10:25:53AM +0100, Niklas Cassel wrote:
> > 
> > If you need to respin this series, I strongly suggest that you send the
> > Qcom fix separately. It is totally independent, and should be merged ASAP.
> > 
> 
> Even though it is an independent fix, it is needed to get Kselftests (also the
> legacy ones) passing without failures. That's why I kept it as patch 1.
> Otherwise, someone may test it and report failures.

If qcom needs this fix, then surely pcitest.sh is already failing for the
BAR test for BAR 1 and BAR 3, for all qcom SoCs, and must have been doing
so since the introduction of the introduction of the qcom-pcie-ep driver.

That should be fixed of course, but I do not see why converting the tests
to kselftests is related in any way.

It seems cleaner if this series just converts the tests cases to
kselftests, and nothing else. EPC drivers that was passing before should
still pass after this conversion.

I understand that the qcom fix is important though, which is even bigger
reason that it should be sent separately, so that it can go in ASAP, and
not be blocked on this series landing. Because, AFAICT, you need that qcom
fix to make the pcitest.sh test cases (even without converting to
kselftests).


Kind regards,
Niklas

