Return-Path: <linux-kselftest+bounces-34612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF527AD4007
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 19:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2A53A22F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30504230BF5;
	Tue, 10 Jun 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dpZ1Dw44"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5823FC49
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575165; cv=none; b=FWGymfyNclbzDHoTqNJHnn8EMBjcbuhW7EjcFuqj3A7JYebKd9wJEhdq6iFkzAxe+ZNoxhTMn1rxCQbSJjp6AOHVD3Ob1WJVCClpRR0e0nC79/iMlGJr4uVKhFhHIkn6mrcSh1/yJQMZ2lzsRAEJLv9vxoGWyELEGelnMFJMaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575165; c=relaxed/simple;
	bh=IAtOakXEDOiDeB8dbTjVCrkDnKm8NLoU/2cmouqEjK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb6vMENVzKfGY2Hep8vutYvlKSyH9zflMDPslOA45h3vpY7c4O1OAEPvm3YI/MlqnFRocaGfNDZlYcyKCZJBuM3VxRyaAimcBiiQWDEIoZFQlAiBQLmoPcfTUV00k/tcj+jMsUQ6+letT4TZB21vioj3nsJWte8x7GEPZ4Uo8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dpZ1Dw44; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749575159;
	bh=IAtOakXEDOiDeB8dbTjVCrkDnKm8NLoU/2cmouqEjK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpZ1Dw44lrmlD1WsVer7xPpkXdVLP4Ek9cR4GHblImhkzs+BA1xZh7JQA3EcbIyzu
	 UmFHEsVtYK1t04jQnqP01xtuZIMhX7/t4xfkehZB7+vEzKqSy/WfpR832UQMmssovZ
	 MEkadVcArxvHiLnPIic22tUS8SDhOgmn2X1Z4ZJQ=
Date: Tue, 10 Jun 2025 19:05:59 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org
Subject: Re: nolibc test target overwites kernel config without asking
Message-ID: <5df3037e-2486-43f2-9fc8-e0aeb716c848@t-8ch.de>
References: <3d5128b9-b4b6-4a8e-94ce-ea5ff4ea655b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d5128b9-b4b6-4a8e-94ce-ea5ff4ea655b@sirena.org.uk>

Hi Mark,

On 2025-06-09 17:42:47+0100, Mark Brown wrote:
> While running the nolibc tests I discovered that they build a kernel in
> the current directory, including overwriting the existing .config.  This
> is rather suprising for the selftests build system - it usually wouldn't
> do a kernel build at all - and might be annoying for users.

This is not intended. I think a recent configuration change is broken [0].
The order-only dependencies don't work as I thought they would.
I'll rework this.

> KUnit deals with this by doing it's kernel build in a .kunit directory,
> it'd probably be good to do something similar for nolibc.

I assume you are using "make" directly. For a more complete
kunit.py-like solution we have run-tests.sh, which does indeed use a
dedicated build directory.

And maybe "soon" you get to use kunit directly to test nolibc.

[0] d7d271ec30dd ("selftests/nolibc: execute defconfig before other targets")


Thomas

