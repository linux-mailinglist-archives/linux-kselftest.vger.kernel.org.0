Return-Path: <linux-kselftest+bounces-48806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1142D15F23
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45DA302AFB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425ED21D3C5;
	Tue, 13 Jan 2026 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH68Opfv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7FA207A09;
	Tue, 13 Jan 2026 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768263400; cv=none; b=lGtzcTO9sUvRV5GRZ7IMisqC9+4DRLwTDT7LAfrr+75kxjhCceGhVQBqEqzLUbuvLAWS653p4kYSW8pY+hQmUiSU13Ct0/bWzUOnlIZpaCjmQSycfpl56EZR7IY6O6nh7ATO1xCnUDax1nAVI+iMcLTPBZHDpaUml4+t1uX4mvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768263400; c=relaxed/simple;
	bh=vdgFt7gSlg6ggrH6DgKL7XYQH5crGDTqbC6FP+yfTt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArIZyMYrvAv+lo/ONxjz3msWXynM7J60grz1PJ0p8/ZEZMorU4MD80QgqUAB5LrvylpNKHUH/XdfZiGOMknp9/tYIMNt1CtHAfT9Jvn3sm40de5hZ0oLMaiBa9GiNJ6VWa7wBy8hIjfitMkiFKh3RMD+qC48EHBZefTPOUPck8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH68Opfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5E5C116D0;
	Tue, 13 Jan 2026 00:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768263399;
	bh=vdgFt7gSlg6ggrH6DgKL7XYQH5crGDTqbC6FP+yfTt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fH68OpfvcQ8hrS2GE06M00HWTGys+qDdrNokEiVWsbsWdrOTiECTBTOFZwGuDYU3c
	 VMr5bumV/Ov3mNIHfmGLsw0epUTRKxOAp+onAxlErOYxt6kOcS09DezNtcmNX6oNqQ
	 0QsaGxwNSaOiTshoW8NvLBd+lwDIymf7a16CP3aKpYGravuiljT9EMa6z10F8nY9Bt
	 zzn0WdUkyVt+FW4WM3HDzJKNmwToG7lBbdVoIbcF9/c3eyF895AFndMzofEpUK0fxr
	 0ln8Js030UoUxLxsHM90l5XCBm9Qd410ClzXCYLtCIinoYxMeBfWVpCX2+poMxpUB9
	 vpHRzazyalfNg==
Date: Mon, 12 Jan 2026 16:16:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 6/6] selftests: drv-net: gro: break out all
 individual test cases
Message-ID: <20260112161638.3e4f361a@kernel.org>
In-Reply-To: <willemdebruijn.kernel.3ad3dec6c886b@gmail.com>
References: <20260110005121.3561437-1-kuba@kernel.org>
	<20260110005121.3561437-7-kuba@kernel.org>
	<willemdebruijn.kernel.3ad3dec6c886b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jan 2026 12:12:09 -0500 Willem de Bruijn wrote:
> Interesting that many devices do seem to fail some tests.

The case that convinced me to do this was TCP option handling.
Older Broadcom NICs appear to coalesce mismatched timestamps.
I suppose it may be related to the Microsoft sec which seems
to recommend coalescing incrementing timestamps like seq no :|

