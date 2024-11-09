Return-Path: <linux-kselftest+bounces-21725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C599C2D6E
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 14:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95F60B21482
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542751537B9;
	Sat,  9 Nov 2024 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx+5Kt7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654C1BC3F;
	Sat,  9 Nov 2024 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731157375; cv=none; b=XH6d6DwBGXLf0f2S1PNo+qrBwMITre04l167ZpmgqQKT73xgnWTpRz/VD95u7swnvsjhmxUwh8wq0MAf5AnsvlxOsbvmYR9hVAr2B9fzmJ/05ccd5OGCamhLGcQVSDRTRHuYko+jgwace3s6Gy/TV0TBEu17aqC2T7bmpekbYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731157375; c=relaxed/simple;
	bh=a6JHhad8Uq0nFgPJzJDUsZHui48ziYKA8Y4AF3asVdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PinHQttfdTCgpMZi4NPt0oGTgw5gNb9vQcZxdAm+H6Dv42RGN0GFdXN7M3vEmVabxU+Kya964wXX7dG/cu2aYvi/xYWn3wbAVedoNC+t7K8i7PQ1UIdCEZidmkOLNv1ZPBrVTOUYIvBEpYbSt9lkN2RBRzwpDzK1npr75ZA9Oao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx+5Kt7Q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c8c50fdd9so28843015ad.0;
        Sat, 09 Nov 2024 05:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731157373; x=1731762173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DlmhTfTUG1CY8BJqLA3dNzmUX81qWaoK1uznnl+92tg=;
        b=kx+5Kt7QjeauDV75a+hZWBtKDXRJztH1qxWawIysZHwZc3VaV2qgmY1ajXJ3aOy/Zv
         /UJNl7HPCI8NChlua7fud9qO6mEkjsSv6I9wAmSKVh62tUuFVsw1ezb34+CTMfGsuUZU
         VibsSjGyl22xCAtLEiKVZ8ORaznbqf+Octp+FThCe1bmG4pSMfjzyip/nQZQGrZBlYv4
         zFJm+6OULsmMk2NvM+i3VFU7JG7LW73w01Ain6nO5Be0FyFohDNDWsSOgImMQMiE0UOg
         wKgW/IJ9eYKLAVazIRx/Nsa+bwcYp1yIVRBOECqXD5Ys6uBQSlx157HHp8L50+BzCFky
         q+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731157373; x=1731762173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlmhTfTUG1CY8BJqLA3dNzmUX81qWaoK1uznnl+92tg=;
        b=jBethXMJmQ8dq+essue72a50K3+k6XuWRdDjVNSQnCt0q1BOQ9romr/vqm70zal50H
         L53lsGrT0fF8bx6aNNrjj35n/7w9GNeHU/oYrzgKpPCPw14nL9CVXc6u5IcA7ohuqLfQ
         CQ4cyvOFO6ySNVOQ1XrvM6cFiJrT0TDgaviOyIese6csW/nOlsaSm3pB99GwMrRYe8ow
         68qpRmv/R/PvOlEMhriGIfAv9glrUU8fMt5swkaVs/i3Gz3m2Dvr+2YknLetHcZxRrzQ
         km1jAG4kGfkqisHZ9Aw5g1LjRQWNerdhD96/BvjMyLmP14/KbogW8H0+a557OZydDnNg
         vsPg==
X-Forwarded-Encrypted: i=1; AJvYcCUwz3SYXxTFSU4CbzYCd5i7feLYk4RupVcWOmnAlgkqGVnXVQJbiWegiwNUd1iJGWEZrocsfwkWeogthjX0IcWj@vger.kernel.org, AJvYcCVP0b42n6+M32gqh7r6oGgZJmlWROa30DnD9mi5QnDibLtmGg+O4ng1+UvD+uQ1LgfGhUrhL2rnq8c5VOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4fWGiVTJbM1GQCKBxOSIUXWlHmHQFmI0Kb7G4gq5fU9OR96dK
	5Bvs7/un+X2trSBa72CrT20OTQY8H6tsFO6+WRLUJghlfEQIYuhU
X-Google-Smtp-Source: AGHT+IGmRwKKTPH4RquYUsQRA226sRU2HlZ2jVK6h1XdfV1ip2i/B0Xhdtr1FWploXFMJIyZXWEivw==
X-Received: by 2002:a17:902:ce01:b0:20c:68af:a4e3 with SMTP id d9443c01a7336-211837a151bmr100319145ad.22.1731157372950;
        Sat, 09 Nov 2024 05:02:52 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e418bfsm46220985ad.169.2024.11.09.05.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 05:02:52 -0800 (PST)
Date: Sat, 9 Nov 2024 21:02:49 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
	skhan@linuxfoundation.org, rf@opensource.cirrus.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: string-stream: Fix a UAF bug in kunit_init_suite()
Message-ID: <Zy9deU5VK3YR+r9N@visitorckw-System-Product-Name>
References: <20241024094303.1531810-1-ruanjinjie@huawei.com>
 <Zy9YOTxMv6tVAXzX@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy9YOTxMv6tVAXzX@visitorckw-System-Product-Name>

On Sat, Nov 09, 2024 at 08:40:30PM +0800, Kuan-Wei Chiu wrote:
> Hi Jinjie,
> 
> On Thu, Oct 24, 2024 at 05:43:03PM +0800, Jinjie Ruan wrote:
> > In kunit_debugfs_create_suite(), if alloc_string_stream() fails in the
> > kunit_suite_for_each_test_case() loop, the "suite->log = stream"
> > has assigned before, and the error path only free the suite->log's stream
> > memory but not set it to NULL in string_stream_destroy(), so the later
> > string_stream_clear() of suite->log in kunit_init_suite() will cause
> > below UAF bug.
> > 
> > Set stream pointer to NULL after free in string_stream_destroy()
> > to fix it.
> > 
> > 	Unable to handle kernel paging request at virtual address 006440150000030d
> > 	Mem abort info:
> > 	  ESR = 0x0000000096000004
> > 	  EC = 0x25: DABT (current EL), IL = 32 bits
> > 	  SET = 0, FnV = 0
> > 	  EA = 0, S1PTW = 0
> > 	  FSC = 0x04: level 0 translation fault
> > 	Data abort info:
> > 	  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > 	  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > 	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > 	[006440150000030d] address between user and kernel address ranges
> > 	Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > 	Dumping ftrace buffer:
> > 	   (ftrace buffer empty)
> > 	Modules linked in: iio_test_gts industrialio_gts_helper cfg80211 rfkill ipv6 [last unloaded: iio_test_gts]
> > 	CPU: 5 UID: 0 PID: 6253 Comm: modprobe Tainted: G    B   W        N 6.12.0-rc4+ #458
> > 	Tainted: [B]=BAD_PAGE, [W]=WARN, [N]=TEST
> > 	Hardware name: linux,dummy-virt (DT)
> > 	pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > 	pc : string_stream_clear+0x54/0x1ac
> > 	lr : string_stream_clear+0x1a8/0x1ac
> > 	sp : ffffffc080b47410
> > 	x29: ffffffc080b47410 x28: 006440550000030d x27: ffffff80c96b5e98
> > 	x26: ffffff80c96b5e80 x25: ffffffe461b3f6c0 x24: 0000000000000003
> > 	x23: ffffff80c96b5e88 x22: 1ffffff019cdf4fc x21: dfffffc000000000
> > 	x20: ffffff80ce6fa7e0 x19: 032202a80000186d x18: 0000000000001840
> > 	x17: 0000000000000000 x16: 0000000000000000 x15: ffffffe45c355cb4
> > 	x14: ffffffe45c35589c x13: ffffffe45c03da78 x12: ffffffb810168e75
> > 	x11: 1ffffff810168e74 x10: ffffffb810168e74 x9 : dfffffc000000000
> > 	x8 : 0000000000000004 x7 : 0000000000000003 x6 : 0000000000000001
> > 	x5 : ffffffc080b473a0 x4 : 0000000000000000 x3 : 0000000000000000
> > 	x2 : 0000000000000001 x1 : ffffffe462fbf620 x0 : dfffffc000000000
> > 	Call trace:
> > 	 string_stream_clear+0x54/0x1ac
> > 	 __kunit_test_suites_init+0x108/0x1d8
> > 	 kunit_exec_run_tests+0xb8/0x100
> > 	 kunit_module_notify+0x400/0x55c
> > 	 notifier_call_chain+0xfc/0x3b4
> > 	 blocking_notifier_call_chain+0x68/0x9c
> > 	 do_init_module+0x24c/0x5c8
> > 	 load_module+0x4acc/0x4e90
> > 	 init_module_from_file+0xd4/0x128
> > 	 idempotent_init_module+0x2d4/0x57c
> > 	 __arm64_sys_finit_module+0xac/0x100
> > 	 invoke_syscall+0x6c/0x258
> > 	 el0_svc_common.constprop.0+0x160/0x22c
> > 	 do_el0_svc+0x44/0x5c
> > 	 el0_svc+0x48/0xb8
> > 	 el0t_64_sync_handler+0x13c/0x158
> > 	 el0t_64_sync+0x190/0x194
> > 	Code: f9400753 d2dff800 f2fbffe0 d343fe7c (38e06b80)
> > 	---[ end trace 0000000000000000 ]---
> > 	Kernel panic - not syncing: Oops: Fatal exception
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: a3fdf784780c ("kunit: string-stream: Decouple string_stream from kunit")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >  lib/kunit/string-stream.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> > index 54f4fdcbfac8..00ad518b730b 100644
> > --- a/lib/kunit/string-stream.c
> > +++ b/lib/kunit/string-stream.c
> > @@ -178,6 +178,7 @@ void string_stream_destroy(struct string_stream *stream)
> >  
> >  	string_stream_clear(stream);
> >  	kfree(stream);
> > +	stream = NULL;
> 
> Thanks for proposing the fix. However, I don't believe it fully
> resolves the UAF issue. Changing the stream pointer value within
> string_stream_destroy() doesn't update the caller's stream pointer, so
> the issue remains.
> 
> I think the correct approach would be to set the log pointer to NULL in
> the error path of kunit_debugfs_create_suite() to address the issue.
> Let me know if I've missed something or overlooked an obvious detail.
>
BTW, since alloc_string_stream() returns -ENOMEM on error rather than
NULL, it's best for the caller to check it with IS_ERR() instead of
IS_ERR_OR_NULL(). It's not a big issue, but I can send a cleanup patch
later to address this.

Regards,
Kuan-Wei

