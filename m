Return-Path: <linux-kselftest+bounces-5394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5008620EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 01:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB561F2747C
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 00:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3EED9;
	Sat, 24 Feb 2024 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+P3uORr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772464A;
	Sat, 24 Feb 2024 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732980; cv=none; b=kDjM32wcEVGQYrqAaq+rVbsPABqUznuaeW06aDEjf2rdiLt2eYmayeTaFOtOZW1ecBPxj3jZA216nVpkyHh6kY6vZGweDJUrSmiWVGS7m9uEb4sY3kgjhZqno0CFHc7Ypd/FYR/xiQEo1kQMFd9khX6SEVm2DZJPXI1GjjiKmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732980; c=relaxed/simple;
	bh=E1uy0ZF05Atmh5fp16Nfgz89BZCFPu4kh33ZjkboSKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyxlFrCcyp+qgX5vefNfihbNkd+g1LB7GcAHHuL4gDfQD645ARAW8VwGeQ1ktH6QRDBUr/WWu1YhV1H2mmTBPVTXIyPe1g+0wJsGZVJLyD75UJEJHWZFA2DMrqfgoVhapAY2X7qfAn6tcucpKTCZhkdbInW6pNDjxvKlTUnCzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+P3uORr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42869C433C7;
	Sat, 24 Feb 2024 00:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708732980;
	bh=E1uy0ZF05Atmh5fp16Nfgz89BZCFPu4kh33ZjkboSKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+P3uORrRjLKyypCblsp3pTaVGTXwPDPYAlzHcXvJrMYeHhRkSmcPr7mbij/EqxUB
	 T6gMs5c9GdnCkgRXsqf43n+6dez0qMV5JRqq9TZHTIJBlbYqSW9dTlePvpNzB9psCj
	 3XvkZN+LxtByOqMb1hORzh0yJ3Ae9ihSwhWdaU7TH5Qg8a3VQnYyFeujswipWkMXFY
	 L4U7Ihlt7/n83EoG3KDxRsKBGJYbFPP3bR1S+MW4h+/m+vNrw/8vfxNMWVFgiTsyc+
	 Lai3ADRfmUAd4DMkJLiwZ4JvTbcXm+FwcAACxj1l40IEhtZbJJIcxpEVpHDJhTUo7a
	 mswj3I/Mhrphw==
Date: Fri, 23 Feb 2024 16:02:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: mic@digikod.net
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 00/11] selftests: kselftest_harness: support
 using xfail
Message-ID: <20240223160259.22c61d1e@kernel.org>
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Feb 2024 11:22:24 -0800 Jakub Kicinski wrote:
> When running selftests for our subsystem in our CI we'd like all
> tests to pass. Currently some tests use SKIP for cases they
> expect to fail, because the kselftest_harness limits the return
> codes to pass/fail/skip.
>=20
> Clean up and support the use of the full range of ksft exit codes
> under kselftest_harness.
>=20
> Merge plan is to put it on top of -rc4 and merge into net-next.
> That way others should be able to pull the patches without
> any networking changes.

Hi Micka=C3=ABl,

would you be able to take a look at those changes? landlock seems to be
the sole user of the "no_print" functionality in the selftest harness.
If the patches look good I'll create a branch based on Linus's tree
so that anyone interested can pull the changes in..

