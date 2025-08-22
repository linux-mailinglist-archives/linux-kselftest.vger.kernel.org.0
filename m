Return-Path: <linux-kselftest+bounces-39683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB1B31C2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 16:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D058645194
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D23D309DA1;
	Fri, 22 Aug 2025 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCgekmc5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF730748B;
	Fri, 22 Aug 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872867; cv=none; b=LGwlDlK/TzCe09HTWPavb7p9jTgVjOFbXk2jHAwoV1lOGGAcYhkE6GZYMBDH4oRqwGxqYjFyVVnoJ7Yd0STDf9ABqIP6zd5XLB4RwN+mqwyQ2Vg/nEzy62CzsIlgLJljQEsSCpAVSoXHhRgrIELRER3btHbP3EQ3W12rv5fBb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872867; c=relaxed/simple;
	bh=rdRrontDhsPp/Q6400n+syvBUOq8MstaY0GwaWkO7mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmVCCLRS3+jnQ1U8LESDxSUIXnJW8m3I4WgWi5uxzohf7uIFQTpQrM4OD7SJuem4gfJ+INvH7JHc31l2CUcUAb6YJ+IulyHnGOz9vYx3xb9jhnD+jAxroTLTomxLIXObrI80ylDvuQOoMiFvqFeMnQZO/o6eLHw3QPGVK9WLaTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCgekmc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2594BC4CEED;
	Fri, 22 Aug 2025 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872867;
	bh=rdRrontDhsPp/Q6400n+syvBUOq8MstaY0GwaWkO7mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QCgekmc56J4w5cSUnqBCJX5OO5ISCZ5/AIbkfiX3sHtxlJ3U1Kx5yB3crwjVWkcup
	 iMW8DhfmvV+xEXvX9H7d8tJL8pA52Muxuo3PQxB5rORPYZjR1Eg/ikN85OZKo1Qk9O
	 hEn08RW+Jvhgfye0NHbjTgjcla4u7t8vERKZRWe/EAlzJC2hxL3F0JZuNIs9M+nA6X
	 gV+PmqykX+45Nmc0+iz8KtuJPoqPF8U+FnCkRDNAqid9Kd3DzxLd/YnbBx1+8p2v7W
	 AzCf87wejyJzuffLtaXmJcmHvOZSFhyNz6ZkIQ6t471uKU70mOSD9xSqWP/ARfk/tA
	 3Sxu92cs1lvSQ==
Date: Fri, 22 Aug 2025 07:27:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: liuhangbin@gmail.com, davem@davemloft.net, edumazet@google.com,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 skhan@linuxfoundation.org
Subject: Re: [PATCH net-next v3] selftests: rtnetlink: skip tests if tools
 or feats are missing
Message-ID: <20250822072746.16ef5058@kernel.org>
In-Reply-To: <20250822140633.891360-1-alessandro@0x65c.net>
References: <aKhqmsheZAqThrSu@fedora>
	<20250822140633.891360-1-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 16:03:39 +0200 Alessandro Ratti wrote:
> Thanks again for your feedback on the previous version.
> 
> This is v3 of the patch, with the `Reviewed-by:` tag now correctly
> placed above the `Signed-off-by:` line as per your suggestion.

Do me a favor and read this please:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

