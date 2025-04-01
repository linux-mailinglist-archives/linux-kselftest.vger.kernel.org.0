Return-Path: <linux-kselftest+bounces-29974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54726A774B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 08:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04F7188DC51
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B21DF73A;
	Tue,  1 Apr 2025 06:46:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698801C3C08;
	Tue,  1 Apr 2025 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489980; cv=none; b=Z/+PbLApmz4XM/8iVV+u2uVMEPixfb9SgQz9AsQ2G8sVB9HM4HO8u6xwN9OTtB6GDyv7f/KSR3kRn6tTFZY8DyafFbufxKyoXMRfkV3cVJ4toFuI4x+uVUVeIleTBvtlChVw7Jt1dIxLnECPi82tXMUIekQioAMdu9Aw0e1oBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489980; c=relaxed/simple;
	bh=W9rSmiwKduxUWi49l8wNtNetlF5W1ByAEmk9M9wIH9Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IqImrX33umqACpTGRBavH43d7sv2p0Kxn09M9wXK5j0WMNTA+9kvLDskkjWwV26ilQ0w6GiTg8oSpBV9oY6NA7jn6pLTwNmiKXCsT2OfqpqbybiTOXmQbpbXKT5HeGH2Oqgl5yNO5JyjTOmPm6/Lbst4Y+duEZU9jCCEWGaBG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZRdmr5nmYz4f3jJH;
	Tue,  1 Apr 2025 14:45:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EC88C1A10CD;
	Tue,  1 Apr 2025 14:46:11 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgB3gmWvi+tnaud_IA--.20876S2;
	Tue, 01 Apr 2025 14:46:11 +0800 (CST)
Subject: Re: [PATCH] selftests/bpf: close the file descriptor to avoid
 resource leaks
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <malayarout91@gmail.com>
 <20250324064234.853591-1-malayarout91@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <fd481035-5608-6c8e-eb72-65b4ad320d4d@huaweicloud.com>
Date: Tue, 1 Apr 2025 14:46:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250324064234.853591-1-malayarout91@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgB3gmWvi+tnaud_IA--.20876S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW7Xw48AF48ArW8JF1fZwb_yoW8urWfpa
	4xGa4YkFySyF1FyF17CF4YqFWfurn7Xr45AF4rJr1UuF1xJFWIqr1xKayFqan8C34Fqrs5
	Z3WIgF9xZw48Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 3/24/2025 2:42 PM, Malaya Kumar Rout wrote:
> Static Analyis for bench_htab_mem.c with cppcheck:error
> tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
> error: Resource leak: fd [resourceLeak]
> tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
> error: Resource leak: tc [resourceLeak]
>
> fix the issue  by closing the file descriptor (fd & tc) when
> read & fgets operation fails.
>
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>

Acked-by: Hou Tao <houtao1@huawei.com>

The right subject prefix for the patch should be "[PATCH bpf-next]",
however, it seems there is no need or no reason to respin the patch.
> ---
>  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 1 +
>  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> index 926ee822143e..59746fd2c23a 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> @@ -281,6 +281,7 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
>  	got = read(fd, buf, sizeof(buf) - 1);
>  	if (got <= 0) {
>  		*value = 0;
> +		close(fd);
>  		return;
>  	}
>  	buf[got] = 0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> index 0b9bd1d6f7cc..10a0ab954b8a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -37,8 +37,10 @@ configure_stack(void)
>  	tc = popen("tc -V", "r");
>  	if (CHECK_FAIL(!tc))
>  		return false;
> -	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> +	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
> +		pclose(tc);
>  		return false;
> +	}
>  	if (strstr(tc_version, ", libbpf "))
>  		prog = "test_sk_assign_libbpf.bpf.o";
>  	else


