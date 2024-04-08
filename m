Return-Path: <linux-kselftest+bounces-7407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B5489C854
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 17:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20C82867C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 15:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C041411C7;
	Mon,  8 Apr 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BHu/3H5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772214038F
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Apr 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590320; cv=none; b=Qrs6s5AHEMlsshaa+8Lnh1PdnjLvIXgf79g3ZehlV9SxrxF0Kl45v/JSB5XLeYKCslV6P69n/Fyk0RUFvOohX+OI8LlbMpMAV5aFN/y6m/1+oULhI6LdCUn03pM+jmuZHEVhiihkg3rO/gLiAI7dzJll3JNg6rf7w/G2e1br8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590320; c=relaxed/simple;
	bh=tjGt1QyN3u9SP4WWPTA1ilz084j0cSgzKV09txr9r/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMmWIqXEd4AEtmz5cQf89yczCaQcf3lKzPAm9B1csXSBUcTVFCcVKF5lKalNlD/1CTIQNzvIYqyolHi0EHaXdBLhS1rSCXsL6MpmMdpEsqcRRUyKILxq3yb1nBOIpLg3Xcv5pEiDxAJhuobojZvCo+C99kRtGjajRredt3uHVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BHu/3H5K; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f348afb5-684e-4cd7-a8e0-d5a10221dfaa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712590315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjGt1QyN3u9SP4WWPTA1ilz084j0cSgzKV09txr9r/E=;
	b=BHu/3H5KbrEWe1u/+wFTHRkWp+IaZV2pwuHoPyv9t2T0sDstk+EvDR6obNnJ/Unt+NbC0c
	1hgtbWozusE5JqIJLMqp4At8ymZz5OHnEWsY2g+y2KwbpIYgho1JQ848X/h/IbTnIvZcpK
	OLof+IZ5d0N2igNyMsufTWRFhWAB/pA=
Date: Mon, 8 Apr 2024 08:31:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] selftests/bpf: eliminate warning of
 get_cgroup_id_from_path()
Content-Language: en-GB
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20240406144613.4434-1-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240406144613.4434-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/6/24 7:46 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>
> The output goes like this if I make samples/bpf:
> ...warning: no previous prototype for ‘get_cgroup_id_from_path’...

The CI does not build samples/bpf...

>
> Make this function static could solve the warning problem since
> no one outside of the file calls it.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

But your change looks fine.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


