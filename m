Return-Path: <linux-kselftest+bounces-18397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59725987115
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 12:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EDA1C24C01
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B0C1AD40B;
	Thu, 26 Sep 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q+xuC6B4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568611AC439;
	Thu, 26 Sep 2024 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345705; cv=none; b=cl0/OapnjtmbBkIzoqMKEqajMJQiuXsdDuWVWXGIvaa2a+ninfrOsuCoN2kjix+jlIMfduQiY3u3HoPXZKOAf4yASUBiuenEyvDEpZiDz79RvYLS+gOlIN7cthj+JYuiXg+TbevdgowIiLKNv38O4opaTD/4JF3/F8hN8n04d8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345705; c=relaxed/simple;
	bh=mK8E6roVpKMN/3vVZJVnEYbNn+L5/AJNGPGcyLhdz+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOrYrzce/bEmcCbvIPFxSHJ2HALL1M31bW4nQPNDadcRz45DGMbWx+HFz3n2kXhaYIyv0FHs4YAmkH+uvzGohIXiTV7A86IfOq9+gtr6tSADl/cNLlb83XyWn2cdL5zLu9VqA3KGKoqy0hAK2anmb5igbdeU1B28IstyC17wl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q+xuC6B4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 038F71BF207;
	Thu, 26 Sep 2024 10:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727345700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8udeDPcoMfeO/Ujp2zLkJzbghHjrfVi5kQRU+IvkPYM=;
	b=Q+xuC6B443sFC1pIxGb9Hg+0FRffFUYJNmuiNeFaaRfJMCfJtBEJELJYVMC+pDMM7Us3ix
	l1A42XPnsVipZQUoF2fekvC1umKiiwDuCDrLGGb9N3uKzE0bsQf+M0wZwWKhW0t/PA/dsl
	nlpScQkGJapdUsThwkTLK5kqm8HoiFXH4s6jvuApehIdKHTmXZGenOE2JZtM+zjIGCL2tn
	pODmdoLO0IPRV/kZ04QRm7UhgOyPLG8aoIRrHwyCK6tkasR8mJUtlaD1iWQ79t90+5d3u3
	uhCyIWK0roOdz9fqk7VS65tTecgzC45wlRMto/C9tFCbhZfG0pJC0G3UgXNELQ==
Message-ID: <b4b2f589-19fd-4d22-abb7-545c7121fbba@bootlin.com>
Date: Thu, 26 Sep 2024 12:14:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
 <64df8d41-6cfb-45a9-8337-5cc04daedb60@linux.dev> <ZuVWmxoqXFI3qvVI@lore-desk>
 <20240914063828.7bd73c5e@kernel.org>
 <464e0ae0-d6e3-4da4-a157-f74260f96275@bootlin.com>
 <366e4392-bd00-4120-8585-a71b3952e365@linux.dev>
 <895a685b-7449-4bf1-b14d-00aee1d8f75b@linux.dev>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <895a685b-7449-4bf1-b14d-00aee1d8f75b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Martin,

On 9/25/24 22:01, Martin KaFai Lau wrote:
> On 9/25/24 3:37 AM, Martin KaFai Lau wrote:
>> I am not sure which case in xdp_features.c does not have existing coverage in
>> test_progs. From a quick look, it seems only BPF_MAP_TYPE_CPUMAP is missing
>> (please check)?
> 
> Re: CPUMAP, I noticed there is a xdp_(cpu)map_attach.c test but it only does
> attach test. May be something similar can be done like
> https://lore.kernel.org/bpf/20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de/ to exercise the xdp prog that does cpumap redirect.

Thanks for the guidance, I was not aware of the possibility to perform those
tests with BPF_PROG_RUN.
Indeed, the basic return values from XDP programs seem to be covered with this
method in other tests under prog_tests. For BPF_MAP_TYPE_CPUMAP, I can check and
try to apply the same logic as the series in progress you have pointed.

Once done, test_xdp_features.sh could be let as-is. Let me know if we should
stillmove it elsewhere instead of keeping it in selftests
(tools/bpf/xdp_features/ maybe ?)

And noted for the most relevant tests to convert after that, thanks :)

Alexis


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


