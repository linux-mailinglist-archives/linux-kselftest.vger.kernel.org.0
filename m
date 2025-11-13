Return-Path: <linux-kselftest+bounces-45506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A344C556CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 03:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43B504E1972
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 02:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC632F7AAE;
	Thu, 13 Nov 2025 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+OhYIvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094042F6910;
	Thu, 13 Nov 2025 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000632; cv=none; b=e+X1BA7kPYaeAVIlfWuNoxfqM/lnDU5QYHpGUWUTQJvm1F1mPVDqASTG79EL5KGxbKRfdcW6zDUuqOovfwGSm59qbOLx5YEVncus0cxiSgvzfw1fBcy5HmZx5PrZO06xI/pYISeLsGjx3on3wY/XfvKMYCyd4jJ9zmLhCsuKKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000632; c=relaxed/simple;
	bh=uiIKjmlOaAuVzG/eOCcOMDdAt1BLiAZtilWHaUZlBp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f05lLaqMIz1HTfdPrfN9jkZY6yGwH1yJHcthBppw0yTXr0m/2X2h0eF8RXMTuxj7DU2oUjaLVTZsymIowLhC5RtDTrMY231bWHwMiXQaBXjeerYYkcQChxT6XQo5e6PbHB6vhj6da5mgwFh+znhdiBI6y3x4PB/FGgZQmYGNdU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+OhYIvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E38C4CEF1;
	Thu, 13 Nov 2025 02:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763000631;
	bh=uiIKjmlOaAuVzG/eOCcOMDdAt1BLiAZtilWHaUZlBp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I+OhYIvLdMiP1mW5j/cV/kopMRJpCWVRFR3lRntku6GmbCToIZY329xsfRedUegmv
	 ZxhYT+fg7PhIa080G0AgZYogyz5dCXaPfBHYD3BDCsCIGcyCCYu7lzX2NEYLDH7HDe
	 7xjxE1e9A63IaO1sTt1dY45Hb+JiqaqzUk3WvqrRjdI8RyWVZVUTOsKZyOk+iLl2mx
	 hs9T1Zfx1IqwdlhSubVEUHcDgkTeOd6f66Kz8vfWxkhbBM7ypxHVqYvJyFI2UZRVrd
	 1k9T3H33cEwhKCVKrtFFws+GGDseWphrX51h0gO3rjrQn5rYUi/FsTJH8nyfzdbApQ
	 n2CUHvBW4mKcw==
Date: Wed, 12 Nov 2025 18:23:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Christoph Paasch
 <cpaasch@apple.com>, Florian Westphal <fw@strlen.de>, Peter Krystad
 <peter.krystad@linux.intel.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v5 0/3] mptcp: Fix conflicts between MPTCP and
 sockmap
Message-ID: <20251112182349.281a6a11@kernel.org>
In-Reply-To: <cf035c68-fe96-49e0-acdb-bf813ae71d57@kernel.org>
References: <20251111060307.194196-1-jiayuan.chen@linux.dev>
	<cf035c68-fe96-49e0-acdb-bf813ae71d57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 11:35:04 +0100 Matthieu Baerts wrote:
> I think this series can be applied directly in 'net', if that's OK for
> both of you.

Also no preference here, Martin mentioned he will take it via bpf
tomorrow. 

Please let us know on the off chance that you have anything that may
conflict queued up. These will likely need a week of travel before 
they reach net in this case.

