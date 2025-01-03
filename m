Return-Path: <linux-kselftest+bounces-23869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065EAA009D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 14:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03953A3F4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB811F9437;
	Fri,  3 Jan 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f2p3Khft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAD847B;
	Fri,  3 Jan 2025 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735910345; cv=none; b=d7G1SrRP+wvw8v5e5khelzvxec+ssNsa4W3kAg7T5110zqzMQBeygSmvuGkjyAvqjsf7t5nX9xZtvUlxJ8aeE2HlBUbqoutGRVoKeSHuYDFL+cz6NHdA77sLXxOpgtWS7a68aae958VKz2HVoICbdHlBNfexb+5UXtiJy7EhfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735910345; c=relaxed/simple;
	bh=WKGtEvg/p5Wn4jEJ+kAHCcFEJdCYkHW9bgEWdhUg9eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0t5LZ7/avoyVMMZy5CzhcHnZYjX3UZpsiWpF524n3g3mIIxoXu/WS14vbyJ6GZiyr4r5ZlGCylgsoNcPOh4gPiDvtu56+5n3jHSGjESjK2FhYapg49Le9ixzuW23n6ULOBI5uko1kO8tBdnnqe7BPfJvpIzChwg02IqaOlB9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f2p3Khft; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3D08E0003;
	Fri,  3 Jan 2025 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735910335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OhRHMZBqtEyjsqClXtT6Rub61ZPkxxqlIv0XRyJpuk=;
	b=f2p3KhftF2vjBWhFT9b/qQV7AP8JFqWbwPbKovckR9XHpbtd5w441W/xHiuGxOaJQBWT95
	PRObxL8RbZw5jGeCi9PxZd4gHS/PfIemh74YsxfayD/kmojMAFO0CxkJh+N57/kT2B0F57
	AELtjBMFQC/QXwt30RmESyDh/in8C8JGHoS5+TF9QvyC5wmMta8u2E5pU4tAK9CUkMyBzY
	EQSF/JNSZ9E8cp+Snx8LSoxCondGVYK9HZoxWxJ3+lLe0TsBcWexoTr98Oy4fSlKqXEY5H
	C2+nbXSJHizRphHyX1XrKAnZaC0yoFV67VFdGv62/0rCxbgCQl6FwQ0kQfB8/w==
Message-ID: <c469a6f3-489f-4455-933a-c1c8399403be@bootlin.com>
Date: Fri, 3 Jan 2025 14:18:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/bpf: test_xdp_redirect: Rename BPF sections
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
 <20250103-xdp_redirect-v1-1-e93099f59069@bootlin.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250103-xdp_redirect-v1-1-e93099f59069@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/3/25 11:10, Bastien Curutchet (eBPF Foundation) wrote:
> SEC("redirect_to_111") and SEC("redirect_to_222") can't be loaded by the
> __load() helper.
> 
> Rename both sections SEC("xdp") so it can be interpreted by the __load()
> helper in upcoming patch.
> Update the test_xdp_redirect.sh to use the program name instead of the
> section name to load the BPF program.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

LGTM :)
Reviewed-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

