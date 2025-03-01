Return-Path: <linux-kselftest+bounces-27953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08702A4A773
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 02:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1707AAF81
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 01:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760311401B;
	Sat,  1 Mar 2025 01:32:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C128F5;
	Sat,  1 Mar 2025 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792729; cv=none; b=CgbsTBPH0DCONjpHxTL4yxl64imr0Cn0n4lgZhYpMLs9m3arhylXpNsBRlccuZMJPQgQTnoxIlFB+zI/kR0HuX+DMhrJRWifznmRt6EbCNXva6G0Vr/lqoCGHcWQVIC9V7oQWHpm3VmNIlPMWBPezg+KRjBdmSVn/VB/peE897c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792729; c=relaxed/simple;
	bh=C0xF352bf3NSJ1MxeiWrWudgMezqRE5qZ+gXR8Mw3Gs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pXVgG0tsLVnirFsOWfgiV8s3Yk+xj+/Qs+qwHAnL/hQolvBz3TXZzHqf9hYOs1qnp8XF5towKtiC5yJg8p8NF/VGjH5FTLS/xmQmnvJFx0L2mxF9bKsUSlRDR/HhqS4Uximd+Y7u7mp6Ury+dCEvtsFPwCQbL3+jOsXU+CfLp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z4SGg5Gm1z4f3lxG;
	Sat,  1 Mar 2025 09:31:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A65291A07BB;
	Sat,  1 Mar 2025 09:32:01 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgC3CMONY8Jn2r2AFA--.18363S2;
	Sat, 01 Mar 2025 09:32:01 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Fixes for test_maps test
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: john.fastabend@gmail.com, davem@davemloft.net, kuba@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, hawk@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mrpre@163.com
References: <20250227142646.59711-1-jiayuan.chen@linux.dev>
 <20250227142646.59711-4-jiayuan.chen@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <69d3cd4f-3ea3-78c5-59ea-d4a1185a4251@huaweicloud.com>
Date: Sat, 1 Mar 2025 09:31:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250227142646.59711-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgC3CMONY8Jn2r2AFA--.18363S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw18tr15KFyfuFy7Zw45Awb_yoW5GF4Upr
	Wruay5KrW5tFy2qr1xtw40gF4F9anrG34jyryqqrZrA34kGwn2vryxCF1Fyr9FgrZ5Zan3
	Aa93trWfGF18XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/27/2025 10:26 PM, Jiayuan Chen wrote:
> BPF CI has failed 3 times in the last 24 hours. Add retry for ENOMEM.
> It's similar to the optimization plan:
> commit 2f553b032cad ("selftsets/bpf: Retry map update for non-preallocated per-cpu map")
>
> Failed CI:
> https://github.com/kernel-patches/bpf/actions/runs/13549227497/job/37868926343
> https://github.com/kernel-patches/bpf/actions/runs/13548089029/job/37865812030
> https://github.com/kernel-patches/bpf/actions/runs/13553536268/job/37883329296

Er, it is suspicious that the allocation of htab_elem failed, because
the size of key and value is small in these cases. It usually means that
there is something wrong with bpf mem allocator or the slub, therefore,
I think it is a bad idea to retry for ENOMEM in this case. Will try to
reproduce the problem first when get some time.
>
> selftests/bpf: Fixes for test_maps test
> Fork 100 tasks to 'test_update_delete'
> Fork 100 tasks to 'test_update_delete'
> Fork 100 tasks to 'test_update_delete'
> Fork 100 tasks to 'test_update_delete'
> ......
> test_task_storage_map_stress_lookup:PASS
> test_maps: OK, 0 SKIPPED
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  tools/testing/selftests/bpf/test_maps.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 8b40e9496af1..986ce32b113a 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -1396,9 +1396,10 @@ static void test_map_stress(void)
>  #define MAX_DELAY_US 50000
>  #define MIN_DELAY_RANGE_US 5000
>  
> -static bool retry_for_again_or_busy(int err)
> +static bool can_retry(int err)
>  {
> -	return (err == EAGAIN || err == EBUSY);
> +	return (err == EAGAIN || err == EBUSY ||
> +		(err == ENOMEM && map_opts.map_flags == BPF_F_NO_PREALLOC));
>  }
>  
>  int map_update_retriable(int map_fd, const void *key, const void *value, int flags, int attempts,
> @@ -1451,12 +1452,12 @@ static void test_update_delete(unsigned int fn, void *data)
>  
>  		if (do_update) {
>  			err = map_update_retriable(fd, &key, &value, BPF_NOEXIST, MAP_RETRIES,
> -						   retry_for_again_or_busy);
> +						   can_retry);
>  			if (err)
>  				printf("error %d %d\n", err, errno);
>  			assert(err == 0);
>  			err = map_update_retriable(fd, &key, &value, BPF_EXIST, MAP_RETRIES,
> -						   retry_for_again_or_busy);
> +						   can_retry);
>  			if (err)
>  				printf("error %d %d\n", err, errno);
>  			assert(err == 0);


