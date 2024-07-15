Return-Path: <linux-kselftest+bounces-13736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF793189B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 18:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810E11C218AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B131CD3C;
	Mon, 15 Jul 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJCuFfSJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E31CD31;
	Mon, 15 Jul 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061602; cv=none; b=V7BNTicwl00wzry9A4EE523O8lYwsE/q1DzRlrWtar65+rTGqArxgc2ezrfOpA6SJ7zYwchaKk50EVZhi9y763jTuOvOURP7ZWRP6VtEp1db+Ui/uHicT6a1A5VcJlTthG2pX8osTlCfHqiu8z5uWKjCTKJzbm5u3Xjkfm0sOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061602; c=relaxed/simple;
	bh=XOFvyTZ32FBHBAS6hPDwIo8P+tM1woaiYXgTdMt0StE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHdPfHmWR5pwzk+pEYUthq7DtkRHemjqS6Zb1WBLiyb4xbS9GFA2wTmb2jBtTWCDdLpl3/VJP1c+91NkNWcwLtZ5NIc3le4pngEe+/TY9KZAnvqC4Fz4UNE04aXgRUmDGttD5/I5S0cyCi6EJBnInUWnQ/BxnQm+llEu0zHxhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJCuFfSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02AFC32782;
	Mon, 15 Jul 2024 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721061601;
	bh=XOFvyTZ32FBHBAS6hPDwIo8P+tM1woaiYXgTdMt0StE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJCuFfSJxbtTukvYB0Ve6bfVEEUT3UEk4SLzUWuRinWUcoRdQRz6JUgT0NbghuIsA
	 rJTj43xLVEBJHmaY0SGQ+93kic7AlfVXJ79eifFvdqkFkYVzunAGpBnNrt3MbSKBrL
	 V+dM4jiPIXnVsYQSBaFTRLp579YDxEVR9bBnlQo6S1p/BT9l8IIbu6/jhtOKV22dWP
	 M8PXw+N+FqRWMrnMmj4/hJoUUlkdu97pILhE3EhJBGgx1dy+natVo+A3ZGPYJve6m2
	 xa4iSIZ64MS+NYdlCIVllLRohXcQpxSTwRMzYe0kGG9rbCtQntgGXZGEtyfDLH+I7S
	 dvQl+OnfpExzA==
Date: Mon, 15 Jul 2024 09:40:01 -0700
From: Kees Cook <kees@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, davidgow@google.com,
	"open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	kunit-dev@googlegroups.com,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: Converting kselftest test modules to kunit
Message-ID: <202407150936.C32FE24CA@keescook>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>

On Mon, Jul 15, 2024 at 03:09:24PM +0500, Muhammad Usama Anjum wrote:
> Hi Kees and All,
> 
> There are several tests in kselftest subsystem which load modules to tests
> the internals of the kernel. Most of these test modules are just loaded by
> the kselftest, their status isn't read and reported to the user logs. Hence
> they don't provide benefit of executing those tests.
> 
> I've found patches from Kees where he has been converting such kselftests
> to kunit tests [1]. The probable motivation is to move tests output of
> kselftest subsystem which only triggers tests without correctly reporting
> the results. On the other hand, kunit is there to test the kernel's
> internal functions which can't be done by userspace.
> 
> Kselftest:	Test user facing APIs from userspace
> Kunit:		Test kernel's internal functions from kernelspace

I would say this is a reasonable guide to how these things should
be separated, yes. That said, much of what was kind of ad-hoc kernel
internals testing that was triggered via kselftests is better done via
KUnit these days, but not everything.

> This brings me to conclusion that kselftest which are loading modules to
> test kernelspace should be converted to kunit tests. I've noted several
> such kselftests.

I would tend to agree, yes. Which stand out to you? I've mainly been
doing the conversions when I find myself wanting to add new tests, etc.

-- 
Kees Cook

