Return-Path: <linux-kselftest+bounces-22233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A49D1FA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 06:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF181F21A39
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 05:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6B149C57;
	Tue, 19 Nov 2024 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aho+kv7R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BA2563;
	Tue, 19 Nov 2024 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995083; cv=none; b=T4OSWRSBIbzHpy+lpRZ01jdy0E3MmuBkjXnGg88+5+m08Vi9NfwPZkzXOwz7NdDwUj4nHoapevYkOt68o+Qcgwpx5XvqEOpSG8+x+CA1kifbdpG56hEJI++fYHIZjqr91dSxXp3Al4LBrRfTT4r/If3KpAtz0MYYiaT67cRIAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995083; c=relaxed/simple;
	bh=WOIpDyTBFer6NRdvEdnfKceDSEcFOLTveWh00ai72E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBnmxX0JL14crt+BTJX4vsUPhL5FU1fTfcUO/tub3yNQm4WmyHwu9VmkH2agCIew55xPPHxuolBI4k+pAmHSjhVhZjg9v73UlAzjlKwl86yjvT75cODVyO/1SAsIscyyXHHwXM6HkLh8PifN29LTqB63v+L2TYZPqim0LaQk28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aho+kv7R; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c9978a221so4803455ad.1;
        Mon, 18 Nov 2024 21:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731995081; x=1732599881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S31o8lGUzpvnXYeIe9E0q96l4NFr1QYtgA045hjQDUg=;
        b=aho+kv7RcuKmaIpAtZrJE/4t/bB6kkWF91WTU8qGt5WBOAw4dhH2Ycv1RwdBXerXrR
         fCztIVg97KKKPZZifEbDB0awIhCW3oZrVcSSUP5gliWevmldR9GXgYe3+f4GK3JG0lVC
         YB40HkMjqlMDrgDJxdJRP6hJLI1zB+HYJ3ZHf039nL2+bgA1tX1RqA7UvqYLWuvrnabs
         rs8lS442h543otPrLjvSXaGHKAYjfDtu9sV/fo0G5b++wf0R8faGEKhOMvxDS8xCPlTc
         0x3AAxLoQqnXOict373PFX0/JYQkxr1Pw8ZVHSTQEaZYL6k9XFrR3JYWJoSusLWYVvAh
         +s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731995081; x=1732599881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S31o8lGUzpvnXYeIe9E0q96l4NFr1QYtgA045hjQDUg=;
        b=Q8/S3ISf7lQua515QCvmuNQ9fxBRrDbhiYyvGkIMhvAKS+ECWw8m3mSBIAu4CwtW1K
         FmYD0wdTnMRZFwi9TD8injrAnIWXMMVRLAizWIea8WbTvy8Pva+RkzZ2hS0oo5oJ+8VM
         rLhM8iLOzgLPmfWrJm5/w1GmpTgtvk/ROW3jHpBcnuBaEOzXTYIALQHhBoYv/2n+zyxQ
         HwIyXNuquF5Fv0gq8IOsqEZmL6bfmUtNBdX8nuxA9zMgQ3BC1cq0G2KvfiQ/UOfWuI0l
         LyC+yMsoHG7YfWLz8an21KVLlX4zzaeuM7i8HpFxRROUuj9ReDf2MskcfxbGC+l3MMOZ
         weEw==
X-Forwarded-Encrypted: i=1; AJvYcCVQRMi/KOjy4OMGNCNe6zCgM/pb9XCTRLv622/ZN1o+zRoagBk/7I9pik0aEwX9TQ9HjTD1IFdcvp0oDAxLWVmX@vger.kernel.org, AJvYcCVfJKtmaKeTKS0iVXp0XsnAWPPEYMx1+gT0zfrKASo6vNC6sxCieZFubegRpyn5QKMGPV3YTF4BJUf0z+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOn7tScojTmOpWpZuJgrthxbLBecYiw4t/nqM7LjnRU8TN0Exb
	NpCIK6L2dkILFoHyxYHNsdgrhWkOfrGGCnbKs7yQC7UGLlD1M0NE
X-Google-Smtp-Source: AGHT+IHQek7r5Gt5WDLPMJII/24+21dEy/S/cq7SVa28dbdCeBPjRQtwgXKcgwbXWYXRU7S94MXmfg==
X-Received: by 2002:a17:902:ec84:b0:212:514:b31f with SMTP id d9443c01a7336-2120514b620mr106282375ad.18.1731995080664;
        Mon, 18 Nov 2024 21:44:40 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f344cfsm64399785ad.120.2024.11.18.21.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 21:44:40 -0800 (PST)
Date: Tue, 19 Nov 2024 13:44:36 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
	skhan@linuxfoundation.org, rf@opensource.cirrus.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kunit: string-stream: Fix a UAF bug in
 kunit_init_suite()
Message-ID: <ZzwlxMbDH64S6geV@visitorckw-System-Product-Name>
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

I just noticed that since v2, we no longer set the stream pointer to
NULL but instead set suite->log to NULL. This description needs a
slight adjustment.

Regards,
Kuan-Wei

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

