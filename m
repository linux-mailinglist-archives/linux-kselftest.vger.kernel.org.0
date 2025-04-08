Return-Path: <linux-kselftest+bounces-30323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC8A7F2A8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 04:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7477A63FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 02:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708A3199237;
	Tue,  8 Apr 2025 02:30:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D32610D;
	Tue,  8 Apr 2025 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079446; cv=none; b=joZMnRCjCpcPZZLJNHVXvmOwsN97VO++s5r3fHZmXfCVra9TFzytPk+OJ6jGL5/sK92kGc3UzsPSgQzS36vnkxhKr74nsBjVfG13b3WZ+BY6w9D1iEtXd+YhrNAHXJixDN7SnFyxbqdWIPKeoKEEi+cZ75oLiN4Lj4U4y4TTgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079446; c=relaxed/simple;
	bh=vxSR4qoeAaxo3jAFbr5vM/RG917YaQvN1X3kPh4iQXc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=naPlFvyKiX2ZSxo/rvLQbcWMpor1RS/SMxY05n2vRR9B92E0CGYN2IY8cc/pdYzN98pcNphytwPKTKlaRRUWf0h7g97x6G4NBGUSkAxzjKlrD92JWwVFS3wQpkPDqOdk8IUsDIcIJJq7L8aJJm68riImQMoTURTfcknTm6AWVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZWqmf4Jqjz4f3jtK;
	Tue,  8 Apr 2025 10:30:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8EABF1A058E;
	Tue,  8 Apr 2025 10:30:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDnS3xBivRnHJvPIg--.58832S2;
	Tue, 08 Apr 2025 10:30:28 +0800 (CST)
Subject: Re: [PATCH v2] selftests/bpf: close the file descriptor to avoid
 resource leaks
To: Malaya Kumar Rout <malayarout91@gmail.com>, andrii.nakryiko@gmail.com
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
References: <CAE2+fR992BprqDXkZTqi3Mgtq9WErSFvOtxvc16ZT9ufiBLNNQ@mail.gmail.com>
 <20250407100132.439412-1-malayarout91@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <92596c82-4a12-3afc-6cb2-21a11bef3739@huaweicloud.com>
Date: Tue, 8 Apr 2025 10:30:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250407100132.439412-1-malayarout91@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDnS3xBivRnHJvPIg--.58832S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW7Xw48AF48ArW8JF1fZwb_yoW8Kr47pa
	48Ga4jkFySvF1YyF17CFWqvFWfurn7Xr45AF4rAr1UZF1xJFWxXr1xKa95Xan8C3yFgrs3
	ZFyIgFnxZw48Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07j7l19UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 4/7/2025 6:01 PM, Malaya Kumar Rout wrote:
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

It will be better to resend the patch and change the subject prefix to
"[PATCH RESEND bpf-next v2]" instead of "[PATCH v2]".
> ---
>  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
>  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> index 926ee822143e..297e32390cd1 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> @@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
>  	}
>  
>  	got = read(fd, buf, sizeof(buf) - 1);
> +	close(fd);
>  	if (got <= 0) {
>  		*value = 0;
>  		return;
> @@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
>  	buf[got] = 0;
>  
>  	*value = strtoull(buf, NULL, 0);
> -
> -	close(fd);
>  }
>  
>  static void htab_mem_measure(struct bench_res *res)
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


