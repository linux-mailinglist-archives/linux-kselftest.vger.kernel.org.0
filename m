Return-Path: <linux-kselftest+bounces-18683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F58B98AC63
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1062D281250
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F3F198850;
	Mon, 30 Sep 2024 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaQX0gm5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572465466B;
	Mon, 30 Sep 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722240; cv=none; b=pYf2zMTEXlVdWITP6mUqDTuMIgTBs5b9wH1Gs474hvgDTUwREJXXjJJmdb3UnPIWwaD/kuP+9aXB4hx9DP+ikNl4Nvc6pK1bTx5igCVf291NDNv/k0SdDprlQ2dI6JTdH95i7XKrLBZHRolPln4ugF026wlaQAM/Af6uIY+JfYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722240; c=relaxed/simple;
	bh=QCuJAKv6lY+Q/0k/dpFOlLOo9HDXoU0cTyY1ij8srgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dkxflwxti6cYXISdSteYuJ/H3U0mSLUx0Vai2AReZ2SoJRXyYrLBqS9uDNXwVQMQzBzodAK8wDEwrE5tVQcoFlhJttfhRRyJDwetD1E9Eyq5bd/TfdgtQOoU63VS3oPnPlx6nqfxvRXB+2bWiut7rzVR9B3ctq0Viip72zyL8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaQX0gm5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so3163312a12.3;
        Mon, 30 Sep 2024 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727722238; x=1728327038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YyMWNcFxe4HDMNJ1STfPS+rIobmz+W956uN/DEibcfQ=;
        b=HaQX0gm5xPtDHTSOvhloCmJeSJ4vJRjoQ2oB7SANMqiLw27pijMy1DRikDVJEFuCUx
         /6SsKkFJoU1AxH9zYJhW8N370JERjE2o2ZEL5xSeii0RL0ESJn4LzWeo820H5hvQu1Fu
         HsiJhkRUELf1NYCGZKpotJat0I7zy1OC9dOhCBfrrn6pHcxfRrhRLs8MNwoxqQTV8BPC
         NYQYwDZnKBVfYa/QjRNGR+lYkLMXTX43Fz7H22zmnDK1RjB0EIHErFc/3JWGvkd7P/gN
         lvMjWZo7UEZorvGwDS5WY+eI7YFINTqy94jgcj8Ygnjv4wUD0JGNM6Q5Zy1LT7uSUVHq
         Ri7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722238; x=1728327038;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyMWNcFxe4HDMNJ1STfPS+rIobmz+W956uN/DEibcfQ=;
        b=xDUtyOPcFO4yQ76ndWISwpFMsxCnwINs5xA+88icZWE/uPuquhaRv9QZSzNDQnSKyQ
         9FzapQBHuJhyPSneOBqvn3dy5jqgQGLWgyUpr3Dskkg8rSbrsvD0PTfhLWcB4qXN+VpK
         BFPUdh8OzvjlWchCFamd11Qi8UqIsq6ZYVOBC9vzN9fjStorzufU2mCJw4rhpOoOrObg
         KLJBOMigjNuW6cMuVDKjOKPSkEvm8tAcI+sr9ydW1Pwe6KhPW2RbOipBy7dCxsjsuVpm
         /AhEuXrHh7HowTsgKWQgRIjO81KrYoYWdT0jZT5JwM/bC2GQdlvn+KypWlSBHpNQ8L6Y
         h9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVxykURyKwuDpREq43YyuW1wS8S0hT9DS4uQSEAzYh5ArBjMMsHt2qlZX4/uWtm8u1n+m/0EtFJdIihrSo72WzO@vger.kernel.org, AJvYcCWFIzhK6fQ5msDEksXCRoGCCMpXgr82WbSvk6zT3NBKbnTH7SlSGROXrRVopy5952z1V5xbgRbWEp/Qzuk=@vger.kernel.org, AJvYcCXzMdi1zSbm+jpFQ+U0N4CDnG1oVBE/JPOPf6P1sotv+CbiYHE9F3lBYw2VtR1n6RFIfWXH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzd/qolkGqXlgIP7M9DSPIcLfN0pvz/CSpHba6EvDhMyEH7Uka
	lGAK4HwpMi/osRofWmtV5VlxsO0TzoCDTBIB/Ict4Uj9vYpDU7BO7EfPLw==
X-Google-Smtp-Source: AGHT+IEvCTX8+dcbsrHBXXo/lHNC2UZVG9t4IOCBaIZYSLwZCB/gtunO/+sfAx8y/eavrtl6cwLOzQ==
X-Received: by 2002:a05:6a21:181a:b0:1cf:3677:1c4a with SMTP id adf61e73a8af0-1d4fa6a17e0mr18730917637.16.1727722238466;
        Mon, 30 Sep 2024 11:50:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652bb5esm6776500b3a.175.2024.09.30.11.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 11:50:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9dd56c26-12db-4b69-af0e-fdea33bb8208@roeck-us.net>
Date: Mon, 30 Sep 2024 11:50:35 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab hotfixes 2/2] kunit: move call to
 kunit_run_all_tests() after rcu_end_inkernel_boot()
To: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 rcu@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Brendan Higgins <brendan.higgins@linux.dev>
References: <20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz>
 <20240930-b4-slub-kunit-fix-v1-2-32ca9dbbbc11@suse.cz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240930-b4-slub-kunit-fix-v1-2-32ca9dbbbc11@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 01:37, Vlastimil Babka wrote:
> Guenter Roeck reports that the new slub kunit tests added by commit
> 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
> test_leak_destroy()") cause a lockup on boot on several architectures
> when the kunit tests are configured to be built-in and not modules.
> 
> These tests invoke kfree_rcu() and kvfree_rcu_barrier() and boot
> sequence inspection showed the runner for built-in kunit tests
> kunit_run_all_tests() is called before setting system_state to
> SYSTEM_RUNNING and calling rcu_end_inkernel_boot(), so this seems like a
> likely cause. So while I was unable to reproduce the problem myself,
> moving the call to kunit_run_all_tests() a bit later in the boot seems
> to have fixed the lockup problem according to Guenter's limited testing.
> 
> No kunit tests should be broken by calling the built-in executor a bit
> later, as when compiled as modules, they are still executed even later
> than this.
> 
> Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: rcu@vger.kernel.org
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   init/main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index c4778edae7972f512d5eefe8400075ac35a70d1c..7890ebb00e84b8bd7bac28923fb1fe571b3e9ee2 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1489,6 +1489,8 @@ static int __ref kernel_init(void *unused)
>   
>   	rcu_end_inkernel_boot();
>   
> +	kunit_run_all_tests();
> +
>   	do_sysctl_args();
>   
>   	if (ramdisk_execute_command) {
> @@ -1579,8 +1581,6 @@ static noinline void __init kernel_init_freeable(void)
>   
>   	do_basic_setup();
>   
> -	kunit_run_all_tests();
> -
>   	wait_for_initramfs();
>   	console_on_rootfs();
>   
> 
Unfortunately it doesn't work. With this patch applied, I get many backtraces
similar to the following, and ultimately the image crashes. This is with arm64.
I do not see the problem if I drop this patch.

Guenter

---
[    9.465871]     KTAP version 1
[    9.465964]     # Subtest: iov_iter
[    9.466056]     # module: kunit_iov_iter
[    9.466115]     1..12
[    9.467000] Unable to handle kernel paging request at virtual address ffffc37db5c9f26c
[    9.467244] Mem abort info:
[    9.467332]   ESR = 0x0000000086000007
[    9.467454]   EC = 0x21: IABT (current EL), IL = 32 bits
[    9.467576]   SET = 0, FnV = 0
[    9.467667]   EA = 0, S1PTW = 0
[    9.467762]   FSC = 0x07: level 3 translation fault
[    9.467912] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000042a59000
[    9.468055] [ffffc37db5c9f26c] pgd=0000000000000000, p4d=1000000044b36003, pud=1000000044b37003, pmd=1000000044b3a003, pte=0000000000000000
[    9.469430] Internal error: Oops: 0000000086000007 [#1] PREEMPT SMP
[    9.469687] Modules linked in:
[    9.470035] CPU: 0 UID: 0 PID: 550 Comm: kunit_try_catch Tainted: G                 N 6.12.0-rc1-00005-ga65e3eb58cdb #1
[    9.470290] Tainted: [N]=TEST
[    9.470356] Hardware name: linux,dummy-virt (DT)
[    9.470530] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    9.470656] pc : iov_kunit_copy_to_kvec+0x0/0x334
[    9.471055] lr : kunit_try_run_case+0x6c/0x15c
[    9.471145] sp : ffff800080883de0
[    9.471210] x29: ffff800080883e20 x28: 0000000000000000 x27: 0000000000000000
[    9.471376] x26: 0000000000000000 x25: 0000000000000000 x24: ffff80008000bb68
[    9.471501] x23: ffffc37db3f7093c x22: ffff80008000b940 x21: ffff545847af4c00
[    9.471622] x20: ffff545847cd3940 x19: ffff80008000bb50 x18: 0000000000000006
[    9.471742] x17: 6c61746f7420303a x16: 70696b7320303a6c x15: 0000000000000172
[    9.471863] x14: 0000000000020000 x13: 0000000000000000 x12: ffffc37db6a600c8
[    9.471983] x11: 0000000000000043 x10: 0000000000000043 x9 : 1fffffffffffffff
[    9.472122] x8 : 00000000ffffffff x7 : 000000001040d4fd x6 : ffffc37db70c3810
[    9.472243] x5 : 0000000000000000 x4 : ffffffffc4653600 x3 : 000000003b9ac9ff
[    9.472363] x2 : 0000000000000001 x1 : ffffc37db5c9f26c x0 : ffff80008000bb50
[    9.472572] Call trace:
[    9.472636]  iov_kunit_copy_to_kvec+0x0/0x334
[    9.472740]  kunit_generic_run_threadfn_adapter+0x28/0x4c
[    9.472835]  kthread+0x11c/0x120
[    9.472903]  ret_from_fork+0x10/0x20
[    9.473146] Code: ???????? ???????? ???????? ???????? (????????)
[    9.473505] ---[ end trace 0000000000000000 ]---


