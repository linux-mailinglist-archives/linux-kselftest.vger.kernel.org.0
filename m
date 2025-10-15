Return-Path: <linux-kselftest+bounces-43209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2080BDF459
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 17:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE6D3A9C11
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5F42D739A;
	Wed, 15 Oct 2025 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYGsImU3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33B2046BA;
	Wed, 15 Oct 2025 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540702; cv=none; b=QCOr22Dt9Gu8fyC2a+Vop28Ik5KmbWKnj21A1Al691Gi+2L0qZhBTZGSOR6K99Qv/RPovZueVPJfI/JpwyU922xANs+MC0BFBc2DLguLR8gJh1RT3HRM9deh6bmvCsXSkRELo1LFYREf/8aR/BOHTIRh+BJJEXeRL1NcZmA60fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540702; c=relaxed/simple;
	bh=Wdbu91UHG7NXXe6k08cBk3T/+pvUqlyl9VvW3phwgNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcUN7JG+uA06W536WkbobNGVp6FD9q4dMVetKp+WFbc4Sju1Uk++AadgP5iCrr9JjpmofIakMi3sg4cP1hkHAG130FfveH710CmflnkfzVlZQFB+isHGvml5CxgRMHNCMVSkABCsEYxBVyFBdueHgnYBHVq/huvIQRAM2QvOXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYGsImU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842CFC4CEF8;
	Wed, 15 Oct 2025 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760540701;
	bh=Wdbu91UHG7NXXe6k08cBk3T/+pvUqlyl9VvW3phwgNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aYGsImU3Per5JLsRWKEDgSU53GVias3oxkv3lcMOJyTF2/c5lzyw2mtJxaYSCavuH
	 wbaCEkmbUtHKcgzV8+Rd9HkAU542mDJJNLVv7ZLIwh7hHX65uxF02j6/qf+HBCWCr5
	 a3SDnYLcIaJLj3CG8shPVh1uDD9PGHxB0uwfo6dsz01FKRPCdWlYOJ5Fr2Ur+oEy8m
	 HzxrY4ov7Z1kbMBdW2sPJBcEDJVajDnhRpxhR69uKn2pllOAh6ktBWAQvIYb8QmygG
	 i9hUEjmhdzalFSGO5bNoADPFDFBTlJjew3xdACovDj0EokV3my/h3MUgQn0EZN/yiO
	 mzmbfLOBm1LVw==
Date: Wed, 15 Oct 2025 08:04:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?0K/QvdCwINCR0LDRiNC70YvQutC+0LLQsA==?= <yana2bsh@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1 00/15] genetlink: Test Netlink subsystem of Linux
 v6.1
Message-ID: <20251015080459.6e681582@kernel.org>
In-Reply-To: <CAEP49o+-=HeW4NgB5a0H6gM9tPJg=oNeUA1iCbXq_1qZPPaGnA@mail.gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
	<20250912131722.74658ec0@kernel.org>
	<CAEP49o+-=HeW4NgB5a0H6gM9tPJg=oNeUA1iCbXq_1qZPPaGnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 17:49:22 +0300 =D0=AF=D0=BD=D0=B0 =D0=91=D0=B0=D1=88=D0=
=BB=D1=8B=D0=BA=D0=BE=D0=B2=D0=B0 wrote:
> The motivation for this work is to improve the test coverage and
> reliability of the Netlink subsystem, specifically for the core
> af_netlink.c and genetlink.c components. While the subsystem is
> critical for kernel-userspace communication, its coverage by the
> existing selftests is quite limited.
>=20
> To quantify the improvement, these new selftests achieve the following
> line coverage (as measured by gcov):
> - net/netlink/af_netlink.c: 84.0%
> - net/netlink/genetlink.c: 88.8%

For what it's worth syzbot has:

    af_netlink.c  91%
    genetlink.c   68%

Without a line of code added to the kernel. Of course it's not
functional testing.

> Integrating these tests into the upstream suite will provide long-term
> stability and make it safer to refactor or add new features to the
> Netlink core in the future.

Happy to hear from others if they disagree but what kernel tests get
merged into the tree is pretty subjective. Do we have a lot of bugs=20
in genetlink? Are you planning to do major development in this area
and want to catch regressions? If the answers to both of those questions
is "no" IMHO this 7kLoC is not worth carrying in the tree.

