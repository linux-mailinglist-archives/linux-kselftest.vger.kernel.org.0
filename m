Return-Path: <linux-kselftest+bounces-23616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70FB9F85B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 21:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D496316E2DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E51B5ED1;
	Thu, 19 Dec 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMkiyrqI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3091A0BE1;
	Thu, 19 Dec 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639439; cv=none; b=ufogQ/VJNN0iEKxaWg2910s/zfRvZ/u2k/DH+DXrpSGyO7MHlR2rZ8Pz3UBhmNiv5kK5TaoHg1P/RRW73LPETSBWkLCE8KkC+YuXJEu80A8wu0deZCrIQoDtLWasGMmHpu80i7MdEDlReysjYfFMDRLg1ff9qZGE2ejECN32q/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639439; c=relaxed/simple;
	bh=3h0uiajfoakNl56J+/kdQYPvb9B9KCRsW/9Eg9hqcpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpafHPCaEdWUe7ozQIIUsFlFKBpt6eG8+Qm/8uZayOGVqGG04mGjxFPPPn0cu9AXgqaYOV/YJER2BdRaWDDcD2Ky4/yXCOYg6f94j1ZaeCOram/5mPtshMPmj04eLw6nJkjliK04eWiUQCyuva7yg/RhYx11gnxpC2F5O5fD9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMkiyrqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DA4C4CECE;
	Thu, 19 Dec 2024 20:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734639437;
	bh=3h0uiajfoakNl56J+/kdQYPvb9B9KCRsW/9Eg9hqcpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMkiyrqIY4DqH7GOIayfTuIEaTV6GHJYJSYuK98Q0e2qNpasqp30b/Oo9uFjx2GWR
	 uHQr8YazSAFUZt4481nBDhL179j9dPF3+hRJdOyXOkGCn6asrtnQOXp4IBjkkQukr6
	 Vhy7U1zAhsc+8GLjgSEDiA+/lQMN6I/Iycw3g+U705f6lnafMmL6UNLaC3V5dRFGMI
	 D1TPlYI5DgqItWuZf8EOg0D9SgLASxCnxAD9QtQ7ISED+YoNXttkpwxGtpB6fj73Rc
	 pLl1qP8TBkjayqIv7e45QxzZ9hoVD5Ljm5WgAqvfam0AKMToJ8vtQKgDisudTtZXdI
	 eyJLgUWalBD6g==
Date: Thu, 19 Dec 2024 21:17:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	gregkh@linuxfoundation.org, arnd@arndb.de, lpieralisi@kernel.org,
	shuah@kernel.org, kishon@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <Z2R_SJcHurFJWcPD@ryzen>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
 <20241219000112.GE1444967@rocinante>
 <Z2QuORW5kXSrc1AX@ryzen>
 <20241219155504.GA309825@rocinante>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219155504.GA309825@rocinante>

On Fri, Dec 20, 2024 at 12:55:04AM +0900, Krzysztof Wilczyński wrote:

[...]

> > Mani suggested that my patch (which conflicts with this),
> > should be picked up first.
> > 
> > Is there a reason for the sudden chance of plans?
> 
> No, no change to the plan here.
> 
> There were some mixed signals between the mailing list, IRC and
> the Patchwork queue.  But I will proceed as planned there.
> 
> > Please advice on how to proceed.
> 
> I will pick your patch and drop Mani's series.  Mani told me on IRC that he
> plans to work on it a bit more.

Ok, thanks!

I really hope that the kselftest conversion will have time to land this
cycle as well.

Feel free to CC me on the next revision and I will make sure to send a
Tested-by and/or Reviewed-by.


Kind regards,
Niklas

