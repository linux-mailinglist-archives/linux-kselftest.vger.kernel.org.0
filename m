Return-Path: <linux-kselftest+bounces-22210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5589D1AB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 22:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EA51F22E3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 21:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98F01E882B;
	Mon, 18 Nov 2024 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="arPwm1sD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09F1E7653;
	Mon, 18 Nov 2024 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965981; cv=none; b=jBsGmiclZ/zQmIT1MUOurYN56I1TWGycwWvXstNPTr4x/xEuDWZY0AbjwnPb65y3TU8E74/wo3qjxCAiQdvy5htf8r1SOFfMFQsJSQiJm6vTORaZ0VZBi5ZNT28KAEuoozsiFV0h/Vm/UymAtYDCPC/LXSqGNGKbDULox97tfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965981; c=relaxed/simple;
	bh=VozJIrDceJq4zgppU8iRDiha9kXDC6EVUdlJkNnNnBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPpGvqw0/lp/Rf9qMqW10x0C1GpReqhH2IqekcCamaDaXxINW5uXkbvhBhYMhUNZ8umkV/OyDBYOc8Da9XJ5HwNnEPt0EmKuKBy+OMb+Ruy7RyuFAB//qsJDCXwbLUs+FT39fQjvAaaI+HRdXZ3Bfae4wUV4f1h8zUGhCdAP4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=arPwm1sD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba7c39cb-18ab-4c51-a4cb-89769ea09e6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731965971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfkamGQY47DZR9G8xLHyPYfbW34L0/79y4mIancRHDQ=;
	b=arPwm1sDNXI47rNpmsXiVNGRTa3+wVnwbKvsMavZG7g4bMP8cGjGQnTk+ixlpFpn6fMf+9
	KQ2zGVdaJ3AQS9O4j5EDrpzfBKnqZh16YfwGW4Wc9DH6Zat3sBnCtnXE/YhMGS//TAzZdD
	+vEDPgyltTw1AldiRoeUmVcow5N0D+g=
Date: Mon, 18 Nov 2024 13:39:16 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 0/2] bpf: fix recursive lock and add test
To: Jiayuan Chen <mrpre@163.com>, Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, daniel@iogearbox.net, mykolal@fb.com, ast@kernel.org,
 kpsingh@kernel.org, jolsa@kernel.org, eddyz87@gmail.com, shuah@kernel.org,
 sdf@fomichev.me, linux-kselftest@vger.kernel.org, haoluo@google.com,
 song@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, mhal@rbox.co,
 yonghong.song@linux.dev
References: <20241118030910.36230-1-mrpre@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241118030910.36230-1-mrpre@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/17/24 7:09 PM, Jiayuan Chen wrote:
> 1. fix recursive lock when ebpf prog return SK_PASS.
> 2. add selftest to reproduce recursive lock.
> 
> Note that the test code can reproduce the 'dead-lock' and if just
> the selftest merged without first patch, the test case will
> definitely fail, because the issue of deadlock is inevitable.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, please help to land it to the net tree. Thanks!


