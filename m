Return-Path: <linux-kselftest+bounces-33852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B22AAC4E99
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB5116FF79
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781C9268FF1;
	Tue, 27 May 2025 12:19:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB7252900;
	Tue, 27 May 2025 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748348367; cv=none; b=grJD73JxifuCwuwem1y/WA9L5Ti4cL1S2CQr5pZ/nVhcmhx82VLR+Q+dhBdKQG/DCuGldPd52ftqrbT9GvmTnARTZ0s+51ToIvY3OG1SBLnHk2Pr4K91jY7V0C87YJ9yLnb2uSgJSn/Cmqj042vXdUsJUFV9ymZxltP3nP9G/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748348367; c=relaxed/simple;
	bh=yF/sygMf/EQ2ZHBqQawCfuDcwnMUnpyiExXLsfZaK6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZpETI4kaCSI+3ReTwi9eRbSWCafXTcDE2yMpTyPssOV94cn6xy2OytbT24HWt1IgTAQ+kFboKOM6QHhUAQyQRHyMYnOIwKgDsInyQ1Bco0843MfqJrkb+Oc5zaefjfKhV84VcXp65ke14VGVi7wZAOObmpYXriP9dIQ0xLsUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4b6BWM2sWPz4f3jJK;
	Tue, 27 May 2025 20:18:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A43941A07BB;
	Tue, 27 May 2025 20:19:20 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgB33GDFrTVoSsiwNg--.53275S2;
	Tue, 27 May 2025 20:19:18 +0800 (CST)
Message-ID: <69b24e21-13aa-42b6-bb42-6aad89284aee@huaweicloud.com>
Date: Tue, 27 May 2025 20:19:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/2] bpf, arm64: support up to 12 arguments
Content-Language: en-US
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Florent Revest <revest@chromium.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Xu Kuohai <xukuohai@huawei.com>
References: <20250527-many_args_arm64-v3-0-3faf7bb8e4a2@bootlin.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250527-many_args_arm64-v3-0-3faf7bb8e4a2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB33GDFrTVoSsiwNg--.53275S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF47tr47Xw1UJF1kWw1fCrg_yoW5Wr1rpF
	Wvga13Kas7Aw4xuFsavw12ga15Ka95ta1a9F1ay343ZFn0yFy8XF4SkFsI9ry5Xr93Wry2
	vr429F13G3WUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	4xRDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 5/27/2025 6:06 PM, Alexis Lothoré wrote:
> Hello,
> 
> this is the v2 of the many args series for arm64, being itself a revival
> of Xu Kuhoai's work to enable larger arguments count for BPF programs on
> ARM64 ([1]).
> 
> The discussions in v1 shed some light on some issues around specific
> cases, for example with functions passing struct on stack with custom
> packing/alignment attributes: those cases can not be properly detected
> with the current BTF info. So this new revision aims to separate
> concerns with a simpler implementation, just accepting additional args
> on stack if we can make sure about the alignment constraints (and so,
> refusing attachment to functions passing structs on stacks). I then
> checked if the specific alignment constraints could be checked with
> larger scalar types rather than structs, but it appears that this use
> case is in fact rejected at the verifier level (see a9b59159d338 ("bpf:
> Do not allow btf_ctx_access with __int128 types")). So in the end the
> specific alignment corner cases raised in [1] can not really happen in
> the kernel in its current state. This new revision still brings support
> for the standard cases as a first step, it will then be possible to
> iterate on top of it to add the more specific cases like struct passed
> on stack and larger types.
> 
> [1] https://lore.kernel.org/all/20230917150752.69612-1-xukuohai@huaweicloud.com/#t
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v3:
> - switch back -EOPNOTSUPP to -ENOTSUPP
> - fix comment style
> - group intializations for arg_aux
> - remove some unneeded round_up
> - Link to v2: https://lore.kernel.org/r/20250522-many_args_arm64-v2-0-d6afdb9cf819@bootlin.com
> 
> Changes in v2:
> - remove alignment computation from btf.c
> - deduce alignment constraints directly in jit compiler for simple types
> - deny attachment to functions with "corner-cases" arguments (ie:
>    structs on stack)
> - remove custom tests, as the corresponding use cases are locked either
>    by the JIT comp or the verifier
> - drop RFC
> - Link to v1: https://lore.kernel.org/r/20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com
> 
> ---
> Alexis Lothoré (eBPF Foundation) (1):
>        selftests/bpf: enable many-args tests for arm64
> 
> Xu Kuohai (1):
>        bpf, arm64: Support up to 12 function arguments
> 
>   arch/arm64/net/bpf_jit_comp.c                | 225 ++++++++++++++++++++-------
>   tools/testing/selftests/bpf/DENYLIST.aarch64 |   2 -
>   2 files changed, 171 insertions(+), 56 deletions(-)
> ---
> base-commit: 9435138c069117cd59a4912b5ea2ae44cc2c5ffa
> change-id: 20250220-many_args_arm64-8bd3747e6948
> 
> Best regards,

For the series:

Acked-by: Xu Kuohai <xukuohai@huawei.com>


