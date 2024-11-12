Return-Path: <linux-kselftest+bounces-21848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087519C515E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 10:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9881FB23CBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCC20C000;
	Tue, 12 Nov 2024 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2M102Q/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F11154456;
	Tue, 12 Nov 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401806; cv=none; b=nc1t4DmkPpkgdc/U7z3Ckt3mii1Jny/RMLqKJ7aMFU3N4Q1OpmnPcCD7r3bTIlg/yHAQysWW/gM0HVrYkq7pmMxtsgIC96YiW22bvbB6EOPrk97w71VO0yx5qEbp/Nf7gpdp9FQ4dLRoragFG+ije3SlVcRi2wo+O2lEDTTqNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401806; c=relaxed/simple;
	bh=CgwqNxD4b5hVXKWixRdDhIuy16f3CR/fFi6c86yuQFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr76Ll77EXY3TOdsrWHlzEaO5frHFvOfx+G/i2Qx3K8Mi5O7WSDDBSnPH7hi7bBW1bvjquIVdErecbxhjiiUyB+LX7np2Su9utW4obQKKfvkoY6eetjeF2RTzDhzIWmvDlCAzxJKvTDyCcR443GwYutAZVW4v60bEpuOP6T2jNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2M102Q/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c70abba48so51891505ad.0;
        Tue, 12 Nov 2024 00:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731401804; x=1732006604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8gh+260UsnPZvt7qaiSyrpQ5TcKF/2NN+cGBxN4hwE=;
        b=k2M102Q/mN9h2BU60FthOiHkXeRKqNU6OJ9y5ET0ulgXFvYgZKvGz8ul2XCBQRz3dw
         C9yJBy1a/Yl8p4Yo3FwkmGC3aAAO3EtozANog013ANcegLbV1KdzjdG09cSjWwlFGrn5
         0a6udMOdt7A0X/siOIc3w7Q4Uvkv/7LW5KfFzRv6dqCOKL7SPbvqKa1OI/eFdBaHe1YE
         7BQN5/zsfaVyEFv4wIpLZlvo7jg1/mY6UqF8l6X4NV0X/vFNxtIbS1WgSxW+rx93znts
         oEE7FIdQt+kXuFF9UQLY2pBfLqFJQ2ROBivsHRN7aXZ00ACMvB2xo21YdbOzfWWlez/R
         g7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401804; x=1732006604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8gh+260UsnPZvt7qaiSyrpQ5TcKF/2NN+cGBxN4hwE=;
        b=TC1qkyQD0ZMR8vBkkPboL50Mh74r/2JDTMEuY131oX8sXZBEV1R3snylxYR9L49EL0
         ODU+oLt2yNHNHszag5PIv+qzGH7g9OXx9WGOpAdEfNLE8I/p+xCsB7zGtQj1ER8pZ9V1
         q1V6FonBEi2mAPUIzyc96Gue2YWNR3+UejW6EWyjDG/ytaQ+pFHIRD/4qWtOUyIha/02
         D5ZLcDN4VI4SGiQIwEV9ksK8lldqTgnL4muUWu0ThS/0Wljw7fiYzAQ+LTOAASd0PnD8
         Mw25zpDjriG4zxdY7zxUz3jYe5Lx5Yjr1juEInMU8K3HBGSIONKiiY47mp2JvJ9OUNUC
         mHtg==
X-Forwarded-Encrypted: i=1; AJvYcCV3tNGroFfwGTsiA/Ez4Ymxfyjfor6/tbA7UmLMF+/Fr/Ji82QKRb7zVYtIasuMQhTBVA+Un/l0ByLpml4OTuWs@vger.kernel.org, AJvYcCVG4dSN2Ridx867aEgl4zuQELo9IOXNjq1V697KCo8MJ0I/5mgX7hVSq+zyr7cM0G6DOAfc8YvNX3iI9Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9CGE35COX1xl0BHrTPABRZ1VKa1Ts3waN/fqj/NZyahLo8cj
	sNXhvfvUIRcY2GL8F85wxxm8Dlt0o7z3OY2ePVaJw7Om3cRmi/818QdWPQ==
X-Google-Smtp-Source: AGHT+IHnuNtMJJXjm/8WJ4Tvnm+7ZEuZsTNkzjYWnsfS/T8ExAJzK75DHjmExKE65gOXJwPTNXaQyA==
X-Received: by 2002:a17:903:1209:b0:20c:6bff:fc88 with SMTP id d9443c01a7336-21183cffdaamr221576465ad.28.1731401804412;
        Tue, 12 Nov 2024 00:56:44 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf050sm89174105ad.90.2024.11.12.00.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:56:43 -0800 (PST)
Date: Tue, 12 Nov 2024 16:56:40 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
	skhan@linuxfoundation.org, rf@opensource.cirrus.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kunit: string-stream: Fix a UAF bug in
 kunit_init_suite()
Message-ID: <ZzMYSA/EMN8GWsMI@visitorckw-System-Product-Name>
References: <20241112080314.407966-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112080314.407966-1-ruanjinjie@huawei.com>

On Tue, Nov 12, 2024 at 04:03:14PM +0800, Jinjie Ruan wrote:
> In kunit_debugfs_create_suite(), if alloc_string_stream() fails in the
> kunit_suite_for_each_test_case() loop, the "suite->log = stream"
> has assigned before, and the error path only free the suite->log's stream
> memory but not set it to NULL, so the later string_stream_clear() of
> suite->log in kunit_init_suite() will cause below UAF bug.
> 
> Set stream pointer to NULL after free to fix it.
> 
> 	Unable to handle kernel paging request at virtual address 006440150000030d
> 	Mem abort info:
> 	  ESR = 0x0000000096000004
> 	  EC = 0x25: DABT (current EL), IL = 32 bits
> 	  SET = 0, FnV = 0
> 	  EA = 0, S1PTW = 0
> 	  FSC = 0x04: level 0 translation fault
> 	Data abort info:
> 	  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> 	  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> 	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> 	[006440150000030d] address between user and kernel address ranges
> 	Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> 	Dumping ftrace buffer:
> 	   (ftrace buffer empty)
> 	Modules linked in: iio_test_gts industrialio_gts_helper cfg80211 rfkill ipv6 [last unloaded: iio_test_gts]
> 	CPU: 5 UID: 0 PID: 6253 Comm: modprobe Tainted: G    B   W        N 6.12.0-rc4+ #458
> 	Tainted: [B]=BAD_PAGE, [W]=WARN, [N]=TEST
> 	Hardware name: linux,dummy-virt (DT)
> 	pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> 	pc : string_stream_clear+0x54/0x1ac
> 	lr : string_stream_clear+0x1a8/0x1ac
> 	sp : ffffffc080b47410
> 	x29: ffffffc080b47410 x28: 006440550000030d x27: ffffff80c96b5e98
> 	x26: ffffff80c96b5e80 x25: ffffffe461b3f6c0 x24: 0000000000000003
> 	x23: ffffff80c96b5e88 x22: 1ffffff019cdf4fc x21: dfffffc000000000
> 	x20: ffffff80ce6fa7e0 x19: 032202a80000186d x18: 0000000000001840
> 	x17: 0000000000000000 x16: 0000000000000000 x15: ffffffe45c355cb4
> 	x14: ffffffe45c35589c x13: ffffffe45c03da78 x12: ffffffb810168e75
> 	x11: 1ffffff810168e74 x10: ffffffb810168e74 x9 : dfffffc000000000
> 	x8 : 0000000000000004 x7 : 0000000000000003 x6 : 0000000000000001
> 	x5 : ffffffc080b473a0 x4 : 0000000000000000 x3 : 0000000000000000
> 	x2 : 0000000000000001 x1 : ffffffe462fbf620 x0 : dfffffc000000000
> 	Call trace:
> 	 string_stream_clear+0x54/0x1ac
> 	 __kunit_test_suites_init+0x108/0x1d8
> 	 kunit_exec_run_tests+0xb8/0x100
> 	 kunit_module_notify+0x400/0x55c
> 	 notifier_call_chain+0xfc/0x3b4
> 	 blocking_notifier_call_chain+0x68/0x9c
> 	 do_init_module+0x24c/0x5c8
> 	 load_module+0x4acc/0x4e90
> 	 init_module_from_file+0xd4/0x128
> 	 idempotent_init_module+0x2d4/0x57c
> 	 __arm64_sys_finit_module+0xac/0x100
> 	 invoke_syscall+0x6c/0x258
> 	 el0_svc_common.constprop.0+0x160/0x22c
> 	 do_el0_svc+0x44/0x5c
> 	 el0_svc+0x48/0xb8
> 	 el0t_64_sync_handler+0x13c/0x158
> 	 el0t_64_sync+0x190/0x194
> 	Code: f9400753 d2dff800 f2fbffe0 d343fe7c (38e06b80)
> 	---[ end trace 0000000000000000 ]---
> 	Kernel panic - not syncing: Oops: Fatal exception
> 
> Cc: stable@vger.kernel.org
> Fixes: a3fdf784780c ("kunit: string-stream: Decouple string_stream from kunit")
> Suggested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> v2:
> - Correct the fix way.
> - Add Suggested-by.
> ---
>  lib/kunit/debugfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index d548750a325a..b25d214b93e1 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -212,8 +212,11 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
>  
>  err:
>  	string_stream_destroy(suite->log);
> -	kunit_suite_for_each_test_case(suite, test_case)
> +	suite->log = NULL;
> +	kunit_suite_for_each_test_case(suite, test_case) {
>  		string_stream_destroy(test_case->log);
> +		test_case->log = NULL;
> +	}
>  }
>  
>  void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
> -- 
> 2.34.1
> 

