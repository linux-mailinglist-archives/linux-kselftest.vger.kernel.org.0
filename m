Return-Path: <linux-kselftest+bounces-16404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CA0960D17
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40DB1F23D84
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FAE1C68BD;
	Tue, 27 Aug 2024 14:06:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85C1C460A;
	Tue, 27 Aug 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767567; cv=none; b=jPSV3pCdyuaOtMu8yxX8XYUpDRrqY9L0zR0PbAqj13QhbcM8nHvkZTz1PqhjXnyEE9oH54HloiwxRNEyKdvEa1oimaEbEkPRhdABf7r8KAWU5/0wvEwJOj6gBSyxztVmCgTZpKIWyHlzk4MI8XrsDoOWwQ4Of4j8gNiPigiPWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767567; c=relaxed/simple;
	bh=OCzY6libtAYWj2Rsuw8HRR4vnRYae4owpnFV22vCy5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QdSU4yoU3GqnYLeFT3tIyv9TWqXf2T/4EcLRtp3vIYLmTpNFuSWLX2iTRC47SWTgECva/YjzexAs+G36B4b8+9ihZOfnj3S1S7Dw0ub8jomYFBZuIKvFWAGx9JYGxAPYgZdv/f4pVoHblJ3yCPSUa/s3GYR7Mz/xb4DTB/OftZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WtTpV3scVz1S976;
	Tue, 27 Aug 2024 22:05:38 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 505AF140259;
	Tue, 27 Aug 2024 22:05:49 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Aug 2024 22:05:48 +0800
Message-ID: <f1dd704e-dfbd-496b-9466-83efe38c5287@huawei.com>
Date: Tue, 27 Aug 2024 22:05:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Update "vmtest.sh" for
 cross-compile arm64 on x86_64 host.
Content-Language: en-US
To: Lin Yikai <yikai.lin@vivo.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Nick Terrell
	<terrelln@fb.com>, <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>
References: <20240827133959.1269178-1-yikai.lin@vivo.com>
 <20240827133959.1269178-2-yikai.lin@vivo.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240827133959.1269178-2-yikai.lin@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2024/8/27 21:39, Lin Yikai wrote:
> Identify "$CROSS_COMPILE" to enable vm_test for cross-compile situation.
> Additionally, use "-cpu cortex-a57" flag to accommodate the majority of QEMU CPU lists,
> avoiding using "-cpu host," which can cause qemu_system_aarch64 start failure on x86_64 host.
> 
> Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
> ---
>   tools/testing/selftests/bpf/README.rst | 12 ++++++++-
>   tools/testing/selftests/bpf/vmtest.sh  | 37 +++++++++++++++++++++-----
>   2 files changed, 42 insertions(+), 7 deletions(-)
> 
Hi Yikai,

Your patch reminds me of a previous commit [0], which was able to 
support running vmtest in cross platform for all arch.

Link: 
https://lore.kernel.org/all/20240328124916.293173-2-pulehui@huaweicloud.com/ 
[0]

