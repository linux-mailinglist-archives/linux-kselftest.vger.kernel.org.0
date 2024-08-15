Return-Path: <linux-kselftest+bounces-15434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4175953966
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 19:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018771C229F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C2433D6;
	Thu, 15 Aug 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8Vd36Lo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1653214;
	Thu, 15 Aug 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743912; cv=none; b=U9M1EZsh8/0Yz1zeKEt8vUY26UCZcuDPFTINIqSJiY1n3KJIgP0T7e2Uls+a5/kjlP2TDNaieU0hzFKtfIgNJTCABeHSgiHozjeLSZIGeXfWE5hJJfrYDYda27Uc3JLZa4VYF8AmSFuKj6CKLBkXec9da1wGNv387sybeH6fNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743912; c=relaxed/simple;
	bh=SHLuA+g25pyaHNWFOa+DFBHCAPjCdm6b3iHy5+TW3JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCI55E+e6ifJ1bUp63n8ce9gy9s/xkw2Czsb9m//lv2wy7k+IWn5d8B37YOyPa0VAEb0yemMnOiv0qB/SZrJOsibKJUUy0wvRGuLRhzl5nIAzMuSOTdcjdHllh85CSgZ3Mws0n1rnJmAf6/kknCwwELTfB0pextYemRiedMewMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8Vd36Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33657C32786;
	Thu, 15 Aug 2024 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723743911;
	bh=SHLuA+g25pyaHNWFOa+DFBHCAPjCdm6b3iHy5+TW3JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8Vd36LoanqMOWSx85hUmMsvFf8zJVkVeYnulxXeaVSQvc9xOUFlcADNbc9XuVtU9
	 +CisLAkETMfpt9RHOitN0rzGFg/tyDa5mJm8zODw0GqNLPw2yaYNJhff6Qm2MACLCW
	 dW5l59gwoc47oXx0EQyRMTZmihe39VkJDgl1CKGB1nnG7L6enIhh7magDPtqnMf1RP
	 h0nOWG3xhcOPK3rKvZfa6Rv8UO94kalFmuTzeNspRvhSskI+M69VTWv9ybahTja6si
	 waS2osULc8AbE6gomkInCk1UIr8lKup3WxH3XzhJWVVK8zGCXqfapcSNP10lfH1tqi
	 JfrRAtDdwED+g==
Date: Thu, 15 Aug 2024 18:45:08 +0100
From: Simon Horman <horms@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kuba@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
	liuhangbin@gmail.com
Subject: Re: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
Message-ID: <20240815174508.GO632411@kernel.org>
References: <20240814173121.33590-1-abhashkumarjha123@gmail.com>
 <20240815125321.GA632411@kernel.org>
 <CAG=0RqKvw58-aN1onSjzc+WwhXk8uh_Ak=Po5gQyOmZUNgvaKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=0RqKvw58-aN1onSjzc+WwhXk8uh_Ak=Po5gQyOmZUNgvaKg@mail.gmail.com>

On Thu, Aug 15, 2024 at 10:37:19PM +0530, Abhash jha wrote:
> > I agree with the correctness of this change.
> > And I verified that with this patch applied,
> > coedspell only flags false positives in this file.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Hi Simon,
> Thanks for the review, Should I still send the patch again with the
> fixes tag and the target repo for the patch as suggested by
> liuhangbin@gmail.com. Or is it fine for now.

Sorry for sending my response before I noticed Hangbin's -
I didn't mean to send conflicting information.

TBH, I'm not entirely sure this is a fix, for which my
rule of thumb is that it resolves a user-visible bug.
But if you believe it is, then please follow Hangbin's advice.


