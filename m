Return-Path: <linux-kselftest+bounces-21724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E459C2D2E
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 13:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AF61F21611
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD1F152166;
	Sat,  9 Nov 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjQUrJy/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847F1DDF5;
	Sat,  9 Nov 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731156033; cv=none; b=fW9tPGUTtkRDBukQqBKPKojXWNORZWEN33297GIBl0TBamMUt5jTJbsJLe+oQ/mKTRQia9kH6jizcuJqFyuUhxzWUdTNuzA1OFnfkSV7cL4IpD0zGjcaG3L0DOK9ZGmNu/ifQgrHLnheYIu3kn3uC7+WrjV+pLKplySbKDA6pvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731156033; c=relaxed/simple;
	bh=37DkIbH6IVcc1mhsUx++8EY8SMDfD47GSHX+qaDYUNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if/UpC8A2opUDz+Z+wj7eh4mrbrb4IWmCh84ERUB0m9kUNvtd4EcraCueghOC9fiSIU/yQ7YamuDZ1gVQ3P5hB2ouSkHulYE1RUZWhpa9oMvSKRK3P9kh0bCwtmlFPlCjAQm9RgScWT1Sb0xmJKefZtFGYZCaRBlmSuhTx3nBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjQUrJy/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2558182b3a.2;
        Sat, 09 Nov 2024 04:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731156030; x=1731760830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20aNdHfPYeI5XxoI+unGx2aV6UeU9gRcxK8wbi74JOc=;
        b=TjQUrJy/JG+GVubGfvv3eKe4/Awh/L5t6uC08pF5QLn6AtCiCgO9vDgaeVJyP+14UX
         PyD2l2H1afXt8XHSf8uvqhKYVGQGuPROvlXpbM1Gb9vkbemkNH/PwvHN6XAf48wcvcBO
         2We+X4Q01MWGs4bnovkGFHn1tzbQsHMFHKjGOXpQhDBaLkCK02TyD4YbTndy1FlVfRKv
         HadtqubbEJfjcACWVj3vbBWM7jRRBKF2FLf0KT22JZpNgo0D1i63xHrFne5eWCoNKvFJ
         VZp7/OKEDhwuINUC2Icj1o+HtOc8Dt7NQx0+P7z3qXvYQWJYsZlw2nXRWFkIV1jYWtV4
         PT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731156030; x=1731760830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20aNdHfPYeI5XxoI+unGx2aV6UeU9gRcxK8wbi74JOc=;
        b=OCnj1VUz9dNW5AGKJH8EY3ZI877H6egLmvKeDfpTU4Rn8N5KDg92Nr6Eq2fY4fdLQa
         v4rPn++sJpTUJpmcUCYFX1tbksgqCGfx79DpeL4EMehuapJPy05VYQt2wEoZZaOEnqeu
         Z651TUMGFL+EgG3WX4j0eX21dhPFWIQr4xGDdu3tBgJRuV0IYuGA6wqZ0My+WXwkhlOV
         weaZqGgNKg+vBm/d6vvsnrAGj/SWU/46i5p3CRPRLp/cGm6mhuKV07SvKZ8gbh8GmYs0
         MODlfchtzFxvx7HGcbRXz9OPkDoiEAKwL4iZLZglve8HOJfcdRIVqTeSwyvJpvMzWKKp
         6Vkw==
X-Forwarded-Encrypted: i=1; AJvYcCVN1dUVOopWcgp3jW8/Gviswr8//xQyNpo97yXHkgpdJ/EQLi9Ync2m87VnPLzy3bsm7Yx1mb1NazoINDM=@vger.kernel.org, AJvYcCWltiKcSakM5mOIu5ztHnanYMnJvo0iBRgojLe2SOkCcmx1D6wxgyGBiOMIMndvQcqpd8EW2ctzgW1Sg2JZymXV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw58U8/esWqu0P65BgJ/47iXPPgt2CYAA51KmFWs9D7j6KCYKg0
	6EpkTLPTpTbZ5p5mPXZMmlziQM0GHx/HELvyWWtM8PhltoclAQ1V
X-Google-Smtp-Source: AGHT+IEx9D940RfrHt68o7eKuots15KmpF4zQS5BmlqUzi0xlbjLwY0jXAovoNv9JeAZvLGHCDDekA==
X-Received: by 2002:a17:90b:2dcc:b0:2e2:cd22:b083 with SMTP id 98e67ed59e1d1-2e9b14d83f1mr8536239a91.0.1731156030321;
        Sat, 09 Nov 2024 04:40:30 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f8f1dasm5801461a91.25.2024.11.09.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:40:28 -0800 (PST)
Date: Sat, 9 Nov 2024 20:40:25 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
	skhan@linuxfoundation.org, rf@opensource.cirrus.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: string-stream: Fix a UAF bug in kunit_init_suite()
Message-ID: <Zy9YOTxMv6tVAXzX@visitorckw-System-Product-Name>
References: <20241024094303.1531810-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024094303.1531810-1-ruanjinjie@huawei.com>

Hi Jinjie,

On Thu, Oct 24, 2024 at 05:43:03PM +0800, Jinjie Ruan wrote:
> In kunit_debugfs_create_suite(), if alloc_string_stream() fails in the
> kunit_suite_for_each_test_case() loop, the "suite->log = stream"
> has assigned before, and the error path only free the suite->log's stream
> memory but not set it to NULL in string_stream_destroy(), so the later
> string_stream_clear() of suite->log in kunit_init_suite() will cause
> below UAF bug.
> 
> Set stream pointer to NULL after free in string_stream_destroy()
> to fix it.
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
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  lib/kunit/string-stream.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 54f4fdcbfac8..00ad518b730b 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -178,6 +178,7 @@ void string_stream_destroy(struct string_stream *stream)
>  
>  	string_stream_clear(stream);
>  	kfree(stream);
> +	stream = NULL;

Thanks for proposing the fix. However, I don't believe it fully
resolves the UAF issue. Changing the stream pointer value within
string_stream_destroy() doesn't update the caller's stream pointer, so
the issue remains.

I think the correct approach would be to set the log pointer to NULL in
the error path of kunit_debugfs_create_suite() to address the issue.
Let me know if I've missed something or overlooked an obvious detail.

Here's the proposed code:

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index d548750a325a..b25d214b93e1 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -212,8 +212,11 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)

 err:
 	string_stream_destroy(suite->log);
-	kunit_suite_for_each_test_case(suite, test_case)
+	suite->log = NULL;
+	kunit_suite_for_each_test_case(suite, test_case) {
 		string_stream_destroy(test_case->log);
+		test_case->log = NULL;
+	}
 }

 void kunit_debugfs_destroy_suite(struct kunit_suite *suite)


>  }
>  
>  static void resource_free_string_stream(void *p)
> -- 
> 2.34.1
> 
> 

