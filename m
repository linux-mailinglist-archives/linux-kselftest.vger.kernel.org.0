Return-Path: <linux-kselftest+bounces-41859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7943B8584C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 17:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9133A84E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268D92C21C5;
	Thu, 18 Sep 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trja0lui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF472264CB;
	Thu, 18 Sep 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208507; cv=none; b=DH79wHslMvBHrH4KIBkqSa5BdkgCWveAuFsFG4HWdOYC+MsSAk8S7Hzb8NMs7936QjI7ZjSnw4SfD+0xwrngKxUI+Kq0UIDAnvp/m1pCUWR5BJaGURxgHrMkOH8f5q/mW3sBcsZVXFIF1/89SloQOw2rjRfoBBXxXH580/ZmbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208507; c=relaxed/simple;
	bh=9cbSk6+mZ/JrPOLQ24x/4/EE/51AgOhzhqGiKBm5vf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIQBbrMz0H1gIHNq1d9/kEuWKLo//6g1UkqX8B66nH7hfrDgk6AVMXWMTKEft7wWFb/9qy9C389F/XlVJ8rD89OUNFsC808Mi6zRy37eyTZyqaVKXP4nhFr5sYVIWd64CQ3rwlXikk1iaUs1OPUJV8Nc08Ktd/4NczOpBzvHTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trja0lui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78381C4CEE7;
	Thu, 18 Sep 2025 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208506;
	bh=9cbSk6+mZ/JrPOLQ24x/4/EE/51AgOhzhqGiKBm5vf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trja0luiZFB9ihF1GlN40zg9VSi0MgAYsxgoSIytd5SNUo3LldZJa4NQr+cW6cD2K
	 18DtQsxD6IhMEIVfeChbR8/sgkELiVIgL1G+clAcmh5eKnnJ3wO11xK/+wjkFQSFGp
	 ZiA+pHuAg3wpAAwUgxifcaICq08APfJc6NbNUFdRnKbyaDRGbJQPc1iAnEyP9gC6oK
	 HpLqC15tQej3bnzyl1JZ0OM9f4PRXEXE0iTZzs2zjaPkti9uZAHbYLKX50Doa4nb29
	 xQnD28cTyVvmz5XuVP/gV/2JPCZiyDJIFhFHjTOub8MdTcw2ZMa4XR64ZuCSl4X2/N
	 7Flsj1J/DQWpg==
Date: Thu, 18 Sep 2025 18:15:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-integrity@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: kselftest and cargo
Message-ID: <aMwh95tMxB7sMEzy@kernel.org>
References: <aMlqouOSU8XN7V5H@kernel.org>
 <f18854b2-f9c8-44a3-a09d-3b2ddbcb971a@linuxfoundation.org>
 <aMwf89qekCuAdD1L@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMwf89qekCuAdD1L@kernel.org>

On Thu, Sep 18, 2025 at 06:06:31PM +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 16, 2025 at 04:39:37PM -0600, Shuah Khan wrote:
> > On 9/16/25 07:48, Jarkko Sakkinen wrote:
> > > Hi,
> > > 
> > > The pre-existing kselftest for TPM2 is derived works of my earlier Python
> > > based rudimentary TPM2 stack called 'tpm2-scripts'.
> > > 
> > > In order to get more coverage and more mainintainable and extensible test
> > > suite I'd like to eventually rewrite the tests with bash and tpm2sh, which
> > > is a TPM2 cli written with Rust and based on my new TPM2 stack [1] [2].
> > > 
> > > Given linux-rust work, would it be acceptable to require cargo to install
> > > a runner for kselftest? I'm finishing off now 0.11 version of the tool,
> > > which will take some time (versions before that are honestly quite bad,
> > > don't try them) but after that this would be something I'd like to
> > > put together.
> > 
> > Probably fine - how does this impact kselftest default run?
> 
> OK so this was early query: I might introduce such test as part
> of series that hasa waited for long time for an update [1]. I can
> use tpm2sh more easily to reproduce equivalent crypto as kernel
> does and make a test that can compare the results in a meaningful
> manner. I also plan to relocate tpm2sh as part of git.kernel.org
> custody from Github, as its main dependency tpm2-protocol crate 
> already is [2].

Some motivation context, I left out on doing the aforementioned
patch set because I did not see importing TPM2 keys useful enough
application but recently I've been dealing with remote attestation
and that levels up the feature something quite useful.

I.e. so called attestation identity keys are persisted to the NVRAM of a
TPM chip and it would great if kernel could at boot time reserve
selected (in the command-line) NV indexes and wrap them up into keyring
keys. Since in UKI model command-line is signed that effectively locks
them in into controlled use only through keyring as kernel can
guard that via the device.

I could put tons more detail into this but point to open up this
complexity is that getting all cryptography right is easiest done
by reproducing it in a test in user space and comparing the 
results, and Rust and the crate I did give sort of powerful
way to describe all this. And also because of the complexity
it needs to be anchroed with some kind of sufficient test.

BR, Jarkko

