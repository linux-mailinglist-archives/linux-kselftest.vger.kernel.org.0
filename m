Return-Path: <linux-kselftest+bounces-48081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161FCEF4E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 21:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13841301277E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 20:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99EA2D12F3;
	Fri,  2 Jan 2026 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpFEpb1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59852BE646;
	Fri,  2 Jan 2026 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385598; cv=none; b=WP4Jm6mWDyu1Ic95j4B/fnGn3WtuF8o+CacGC2Yc2RwYoFv8etWHtaQXTdVCseinIdGuPtElcvZVCU32DYQ0czUyIxM2M/9GImWZwlChlAJDNnMzuYVEIqaJ1PwNQjTCoApUezweUV/Nv7cUrrE7XozqQwwEUdUKWX2VPUiX4FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385598; c=relaxed/simple;
	bh=69Vj5Q9Rf2Q1+8bWYhSvejuzOwrPHdL8T1fMzDcxvGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2I6wDMQCIvKdYPniTlD3OjQB62bdw/NiF9fmmRODoh3Bla5N/9dA2eohXtJE+T51gwSJW0mSJoIESUOaoEqQseeflotosYLZW9t2QDEbh3psOyh5dlF1rEiYW7+o32IX8YMLmEjQCmuScb5FA1AAtfwfyrzmNMhPrf5keuyD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpFEpb1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0742FC116B1;
	Fri,  2 Jan 2026 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767385598;
	bh=69Vj5Q9Rf2Q1+8bWYhSvejuzOwrPHdL8T1fMzDcxvGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NpFEpb1ClOwt4ZwNeztGj6bFngkNGUIRdZGRva7bxXMpxed8TTbuWRGeEsXvHdXEA
	 nZ7lYV4HGC4T7BApp7POIX0+hvmD5SHr29SA1/IF2Wye9EtFZF4JZ0HUqrHzpkNe4x
	 I9Bzy711YQNx968faXSNg0XCuQnjzFDnTydPWs0fARIvYSypGcZJU/Qmm8RujLD8Zr
	 mCMxqYuCyMDaKHvk5VBG1mBCNXwPr9aDJHxW3Hj82WwAO0w9DZTRs6aSP0WCgfVR/B
	 dFM82iMTKE5xkplrlCQqhDzR4NhU6iyOcCTL+pgZvWeo2a9zwjjVLHxg5Prj19fSNX
	 aXFucHm85FPRg==
Date: Fri, 2 Jan 2026 12:26:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Skorodumov <dskr99@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Dmitry
 Skorodumov <skorodumov.dmitry@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v4 net 2/2] selftests: net: simple selftest for ipvtap
Message-ID: <20260102122637.40556d72@kernel.org>
In-Reply-To: <20251230140333.2088391-3-skorodumov.dmitry@huawei.com>
References: <20251230140333.2088391-1-skorodumov.dmitry@huawei.com>
	<20251230140333.2088391-3-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 17:03:24 +0300 Dmitry Skorodumov wrote:
> @@ -122,6 +123,7 @@ CONFIG_TEST_BPF=m
>  CONFIG_TLS=m
>  CONFIG_TRACEPOINTS=y
>  CONFIG_TUN=y
> +CONFIG_TAP=m

alphabetical order please

>  CONFIG_USER_NS=y
>  CONFIG_VETH=y
>  CONFIG_VLAN_8021Q=y
> diff --git a/tools/testing/selftests/net/ipvtap_test.sh b/tools/testing/selftests/net/ipvtap_test.sh
> new file mode 100755

> +NS_COUNT=32
> +IP_ITERATIONS=1024
> +[ "$KSFT_MACHINE_SLOW" = "yes" ] && NS_COUNT=8

This still fails on our slow VMs with debug kernel enabled (even tho
they set KSFT_MACHINE_SLOW). The test runs for 15+ minutes without
printing anything. That's pretty bad, humans running this tests will
also have no idea what's going on. Maybe limit the runtime of the test
as well as the iterations? To 1min? It takes <50sec on non-debug kernels
in our CI.
-- 
pw-bot: cr

