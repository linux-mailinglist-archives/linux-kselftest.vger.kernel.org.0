Return-Path: <linux-kselftest+bounces-8633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56D8AD340
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 19:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A72DB213E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A76153BE0;
	Mon, 22 Apr 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIJ9ieH5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27616153BCF;
	Mon, 22 Apr 2024 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806475; cv=none; b=p9TdXOTd0e3ST7xm2gA5CX7vT8aCiwhIRBUfK1lfifx05Iat2R3XWE2L7ThLMIGQ/BTDMEKgnHHybAlHG0Pxe6fey9PUh5qdpVuLj3iUsXjEK33aUi31Q0nLMNxDdZGE8AmaC61xjN6sk0OmRAyaZEmHBAeCjTn2vkErlMGhJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806475; c=relaxed/simple;
	bh=FV2TUJKtwirxm+DazLdq+MAfYd7Y+YmL4J1Jaqx2Izc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWw+gytKMj27HKvsRqWOrKToClq+RUkzSMGINF5KY4zHmmR7FsLJW1B6wJYVEhTaeOYxGnS0ornaGwvFVOGk52yiMPk5LIEk8tUCYiGbvaFxnSfdN6ZyZfvaOwWMJp3UDlkIyUtLs9XvniEx7M+PmkubDXT+m5LdJgoMGu2oUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIJ9ieH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E67C113CC;
	Mon, 22 Apr 2024 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713806474;
	bh=FV2TUJKtwirxm+DazLdq+MAfYd7Y+YmL4J1Jaqx2Izc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIJ9ieH5lXiEuSkFe73f4Pcnx7rkadU0wqXw23nokeklWX8Zm7ECLOdagMtbrWUlB
	 cR8EfZOOD7wdefTzUbaxPmt94ksDywAbhnzzyA49ow6zR21g/JOfyYOAcJ0RK6JM9V
	 KZBwfbcGkM1bF66kcSVz9wOo9R2wZHiuVbJiM6aqNh5+0zg6Twt7hr+etKIKeCvQS7
	 f3ZgazFmhqpDOK0vwitrJHp/CxKl7szWwcLkEq9ocvxPEpPxqXCd3kczr16iv96ovs
	 JirZcx7x0cSYwH5pGl6LE7S/rdxna8jDIxIblMdh4Bkof5WL2gDVYcB8bufUwJ6jKY
	 GB8cmY/GQo21A==
Date: Mon, 22 Apr 2024 18:21:08 +0100
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com, suzuki.poulose@arm.com,
	ryan.roberts@arm.com, rob.herring@arm.com, Catalin.Marinas@arm.com,
	broonie@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Subject: Re: [PATCH v2 0/4] A new selftests/ directory for arm compatibility
 testing
Message-ID: <20240422172108.GD6223@willie-the-truck>
References: <20240422070717.2194201-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422070717.2194201-1-dev.jain@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 22, 2024 at 12:37:13PM +0530, Dev Jain wrote:
> This series introduces the selftests/arm directory, which tests 32 and 64-bit
> kernel compatibility with 32-bit ELFs running on the Aarch platform.
> The need for this bucket of tests is that 32 bit applications built on legacy
> ARM architecture must not break on the new Aarch64 platforms and the 64-bit
> kernel. The kernel must emulate the data structures, system calls and the
> registers according to Aarch32, when running a 32-bit process; this directory
> fills that testing requirement.
> 
> One may find similarity between this directory and selftests/arm64; it is
> advisable to refer to that since a lot has been copied from there itself.

Isn't this going to be difficult to maintain if we have two divergent copies
of the same stuff? From a very quick skim, a bunch of the signals stuff is
idential to what we have on arm64...

Will

