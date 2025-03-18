Return-Path: <linux-kselftest+bounces-29344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65166A67134
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 11:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30196189250A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D93207E09;
	Tue, 18 Mar 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G7z/occu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA300206F18;
	Tue, 18 Mar 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293563; cv=none; b=MamwU2Vn0CXxjeH7+6l1F1Dz4ZyTkxD0B7MlKGz7y4XOquAByrhTEP6Bq9HGYuRy+soP+BbGlYAUcvm0e/ttfLhh0GOsTIBvWziZPQeU2vrv4poYWg9VYV++bUV1Cb/HKN+JPcHEIg9Rn4+HVoHLzXnHmUzoutFmp126AGmysA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293563; c=relaxed/simple;
	bh=5jmDAGXiKABLCfb/KqDmMFp6vEjQ7B/rBqEoAHMmpxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRLbXYOegxrYRuFws6Q4pnx4RZCHnQmj6D9GyGS+ulAGRJrek3Ec4EiNADDMvFJh3zWb5cW1JVryYv5l1dl/viJFv+jT4X/mgON0TuHj1OwW3xPVNAZoarrb64Xh6Fb1o5fAdj+T2hofRbHdwfhP677AjptPEYQIPHilMpqzXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G7z/occu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 160CC441CC;
	Tue, 18 Mar 2025 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742293558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zc6oFFUkHlFqpMlsRLdHY4M65dhXM48dn+z1oDl557o=;
	b=G7z/occuwy0xr3+04zbh37s1Cajns5D+bR/lPxepiSwcGntuCZn6jkXFFBFo6mAvBb3kws
	N/E9oeWnI72T5bbg+/TT/TF1bYkXEmLODtmMoxpqLsEzefSupFIKAvI2+r0Grff6NJ9vU8
	C7Kg/3ZnvPDce8NL7ywILWBGpN8/E1mnqF5RGwgQRVcw8CU9H8acvUgeDByTRWqVKnN/EU
	FTr6gzzsGZcMO3Lq8l2tnV+WfScQ6fGFUFJ6u4h5sotUpEg2THMR5+pPJxL7hB0hBFr3lw
	V4uMBqF5kN4e2adzAeryTPGulf66tD3D8Zj1ZA2yDjxQiPBkPGSCF+zdxHYtNA==
Message-ID: <f416d179-6405-4a84-8fea-2f6c0a60aef3@bootlin.com>
Date: Tue, 18 Mar 2025 11:25:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: Migrate test_xdp_vlan.sh into
 test_progs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
 <Z7yZ8OxdisKbFYBi@mini-arch>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <Z7yZ8OxdisKbFYBi@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegrshhtihgvnhcuvehurhhuthgthhgvthcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhheeggfetffekheevuedvkedvvdeufeegjeevgfelveevveetffevfefgheeijeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepshhtfhhomhhitghhvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

On 2/24/25 5:10 PM, Stanislav Fomichev wrote:
> On 02/21, Bastien Curutchet (eBPF Foundation) wrote:
>> Hi all,
>>
>> This patch series continues the work to migrate the script tests into
>> prog_tests.
>>
>> test_xdp_vlan.sh tests the ability of an XDP program to modify the VLAN
>> ids on the fly. This isn't currently covered by an other test in the
>> test_progs framework so I add a new file prog_tests/xdp_vlan.c that does
>> the exact same tests (same network topology, same BPF programs) and
>> remove the script.
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Small gentle ping on this, as I haven't received any updates since 
Stanislav acked it.


Best regards,
Bastien

