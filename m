Return-Path: <linux-kselftest+bounces-23941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF8BA0209E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 09:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6631516398C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B41D88D0;
	Mon,  6 Jan 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cmSSzwjw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B41D79B3;
	Mon,  6 Jan 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151896; cv=none; b=KNP3XlG6b+mrJfrQ5CAUtAgRH7imIHKQzyMDlbm+EEdXLAWoafrbhEAEetROiUhnEcLQZ4lQwKjTE9EqVVRUWhuJy/pY1ZOGDSvvW2t0zIG/YxnQSVzcH/NJrcNqr4KIHC7GwM77oK7KAklgeDfR14v+tGYJpGfkz0SFfeCAOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151896; c=relaxed/simple;
	bh=S2F2dIfezGTmqlQlk9l97nL9e4QagNwoh8cI9qFLocA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiDsr6isNFgVsBHpBnbx92/DjFa4MXgnK3J5Uh4oKLK5qJUlbAtkZy3SvhYb+WpvIWdR3yEjtPlfpi7jeuCkggFiIYfEhCbtEJ2svO34aXEh7Jv2mQdxjjiKzSWRnJMmeNqzujbVVdJpbsDX5XWeT6oP8ADVtJ2wk+wSNqcIO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cmSSzwjw; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0DE41C0004;
	Mon,  6 Jan 2025 08:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736151885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kbWRqHIeGCABSSU+YqAMFrnOSpEB1icFN/fpfYeHMo=;
	b=cmSSzwjwKp0DEugsKZRozsgqMLye0F0PzJ0jAiu1Nxjf/0zMm/gVPSK2Wz7m3afWOI7zZ8
	zrJBt/B/r6pPu8T2hZUi8plqBeio+9gL0PrIfJEvgfPlexdXE1dRJUqXyKI5FLMgaW+xoY
	VMZkZeG8vmsAmBboJAx7+M2tvVWKOIwB2yMIgkUF1tnFqcwVytKFBmTPqqlayI7itkpuzJ
	4XCZ/jbidcPCemTllEcU1i/qZUckB076+01He+8acOkKSvJTZXDypNXOAIal+Gx9Q1lREz
	GH9LYBAjpsaJyZOvKMaOhzXKMsQhzFRRC/r2Rs+Ujej5EgaEIZwBcppL537KLg==
Message-ID: <bd6f77d6-17b4-41fc-b906-13c56f3fb753@bootlin.com>
Date: Mon, 6 Jan 2025 09:24:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests/bpf: Migrate test_xdp_redirect.sh to
 xdp_do_redirect.c
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
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
 <20250103-xdp_redirect-v1-2-e93099f59069@bootlin.com>
 <1c7bcca1-a940-44e4-aba3-b83b82d3bfbf@bootlin.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <1c7bcca1-a940-44e4-aba3-b83b82d3bfbf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi again,

On 1/3/25 2:17 PM, Alexis Lothoré wrote:
> On 1/3/25 11:10, Bastien Curutchet (eBPF Foundation) wrote:
>> test_xdp_redirect.sh can't be used by the BPF CI.
> 
>> +	dummy_prog = bpf_object__find_program_by_name(skel_dummy->obj, "xdp_dummy_prog");
> Also missed this one: why not using directly skel_dummy->progs.xdp_dummy_prog ?
> (same for all progs below)
> 

Indeed, that would be more straightforward

Thanks,
Bastien

