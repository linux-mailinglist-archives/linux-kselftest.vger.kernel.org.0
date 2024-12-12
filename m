Return-Path: <linux-kselftest+bounces-23246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E449EE2FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438821696B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC662101BA;
	Thu, 12 Dec 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAQ34xxz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F320E337;
	Thu, 12 Dec 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995559; cv=none; b=skJKRfuUZMj3B0A98WCzXGQtthusD/m+WuS480/WWX8qKmL2H5B3KZhOAqFW2eQ26azzqEg7DsEsn5Ci0aWNJi1u8Ng3N+MJ214OOBWKvjOfsv37rtjGc+sX1wX0HCQPKpFRnOwJ4IHDVQJEBT9W7oFHUPBoZB9/C3Sg24vBmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995559; c=relaxed/simple;
	bh=Bi5Hm1hKHqJlQUSQA4wsm321XMcO3ZElLnoKLUpFdUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/23+G5mc22bPWAaBcIgIzf02kTumZIIZIXvBy0sy3KS3ArsIDYaHgYy2pbzSHG0mzoE4ASXsgt9OcpZwnLmo5kPQ1Bv3NR+7PAisYMKl/jGEg/Bj39EUwOGitpEdaND2sYlHe+jMJfDx87TIUG6b/m6MZDkQJ9EbqDucDO+mJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAQ34xxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D408C4CECE;
	Thu, 12 Dec 2024 09:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733995559;
	bh=Bi5Hm1hKHqJlQUSQA4wsm321XMcO3ZElLnoKLUpFdUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAQ34xxzHYZQvQcYjwixMatdVbC+eGq5oOmqXyHtVY/kpxVipD76h2ilOCpKdnM/O
	 EoyY6W2Jr77BJ7xUUm62bmOcYfK6dOCrFX2MqWZYq1TR3ovrhnrf1WsKHcrWt6HlbK
	 tGsLAsBMT0R8jcRW5bO+UaYfMwoYdJUVSQs6iT0IebME6V6qVuLxKkW9SY54DfiXsn
	 s0nlyEhnqD9HKvV6CgQO9kVGSp3bhgC4eJ8Izmuo8dwer4bnJniXAHKfzJRVR7uf81
	 wDRl52Mnx7+QaD2YCpNHytRzJSIoQ45Z865Ivc5hwigHJcw1Fs6cWcGGB5m1g8jV+R
	 ZF+dfj+WwDtvQ==
Date: Thu, 12 Dec 2024 10:25:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <Z1qsIREtdeR38fF6@ryzen>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>

Hello Mani,

On Wed, Dec 11, 2024 at 01:31:01PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series carries forward the effort to add Kselftest for PCI Endpoint
> Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
> based on another patch that fixes the return values of IOCTLs in
> pci_endpoint_test driver and did many cleanups. Since the resulting work
> modified the initial version substantially, I took over the authorship.
> 
> This series also incorporates the review comment by Shuah Khan [2] to move the
> existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
> migrating to Kselftest framework. I made sure that the tests are executable in
> each commit and updated documentation accordingly.
> 
> NOTE: Patch 1 is strictly not related to this series, but necessary to execute
> Kselftests with Qualcomm Endpoint devices. So this can be merged separately.

Having to write a big NOTE is usually a hint that you should just have done
things differently :)

If you need to respin this series, I strongly suggest that you send the
Qcom fix separately. It is totally independent, and should be merged ASAP.

As you know, this series conflicts with:
https://lore.kernel.org/linux-pci/20241116032045.2574168-2-cassel@kernel.org/

I don't see any reason why the above patch has not been merged yet,
but it would be really nice if the above could be picked up first,
so this series could also add a kselftest testcase for the above.


Kind regards,
Niklas

