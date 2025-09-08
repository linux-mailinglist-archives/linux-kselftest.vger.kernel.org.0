Return-Path: <linux-kselftest+bounces-40990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18668B49AE8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 22:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CD8208734
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 20:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85E12DA742;
	Mon,  8 Sep 2025 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTXHqS7h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE62D9ECD;
	Mon,  8 Sep 2025 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362759; cv=none; b=QVqDITd+JdtcFsAn2BqDf1qZYn+K2HKwYGQ+Tdd8DxrQmvfQDkvGzhbWaQjZBtom+qoMtCS1sb1oyzW92qidL5JJVCesJwAbUPhdD5b3TYdgq0LFkTTtfXjbjrwnjq7idRGTEZfE9asraTo7/5vEHk9u0Iy2ZKM+1v86oDSW0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362759; c=relaxed/simple;
	bh=bmj7baRZNqvumNY5NHpR2oWGL0EJxE8zmdop29BhMQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU24loyHGqu2aOoOpMH97P9iVdi9skxtAomJ1lb5FRG/5NgAeA4OJeUD3tsreC4ouSII2b2Z/ymo0Wg4gBKuofhE5TOmRq+EUxoRi9YuZuwsHc3GcW8mRjr9rN2A8vkCDzmOX1LfxFNtK/plJrpeHoRXjIGP6pw7o1P9erQq2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTXHqS7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897E3C4CEF1;
	Mon,  8 Sep 2025 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757362759;
	bh=bmj7baRZNqvumNY5NHpR2oWGL0EJxE8zmdop29BhMQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DTXHqS7h+yz+vFVX545ZtDbe4ETk0KETGFu3KDxUMr/ylXeFqu54hmZCNuiVzX8Hc
	 Xewcg9CZc2iHreLP8EpD+KZVL8m/UzzYywZDISFiSpfdcrtgCCVY3BA3jUWZpK7ZFu
	 1YDPlG+afsx73hM0Mp+FoYOFw1qvw/BWHFxwjF+Brk6JLEkJ8n2K4qJKyWjcneUYlk
	 75tv4J0ILR6GI25uvK3Vu/kC35y1Ne0lR8NpduPGAXFEnq1qi48QP8O4oV013OrnXb
	 4FIszjqRdSbXY7N3bnV65Eb+/jBTptn1+zvKIYlXfVHwom2mcq8lFkuj3Kxu7pKnoz
	 HwbWze95MSo0w==
Date: Mon, 8 Sep 2025 13:19:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: drv-net: Relax total BW check in
 devlink_rate_tc_bw.py
Message-ID: <20250908131917.10785ce0@kernel.org>
In-Reply-To: <0cd98e25-b387-452b-b1a6-414ab20a4cf3@nvidia.com>
References: <20250831080641.1828455-1-cjubran@nvidia.com>
	<20250831080641.1828455-4-cjubran@nvidia.com>
	<20250902162101.5c78cc88@kernel.org>
	<20250905153243.6c03e257@kernel.org>
	<0cd98e25-b387-452b-b1a6-414ab20a4cf3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sep 2025 22:16:29 +0300 Carolina Jubran wrote:
> However, I=E2=80=99ll also need to extend load.py:
>=20
> 1. Binding support to ensure traffic flows through the specific VLAN
>  =C2=A0 =C2=A0 interface.
> 2. Interval-based measurement for iperf3 --json to analyze only the
>  =C2=A0 =C2=A0 stable period.
>=20
> So my plan is:
>=20
> 1. Send v2 for net to fix the current test with interval-based
>  =C2=A0 =C2=A0 measurement.
> 2. Follow up with a patch to extend load.py with reverse/binding/interval
>  =C2=A0 =C2=A0 support and then migrate the test to use it.
>=20
> Does that sound good to you?

Sounds too complicated, this is just a stability improvement for a test
which works on single device, and is not exercised / reported upstream.
Let's jump straight to step 2.

