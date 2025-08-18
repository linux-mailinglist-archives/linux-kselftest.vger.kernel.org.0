Return-Path: <linux-kselftest+bounces-39223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13930B29E44
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6677B0D82
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A01A30F53B;
	Mon, 18 Aug 2025 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hVcdb+/+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE230F533
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510260; cv=none; b=eR3xB0VOT7sin1L/77kQKzhmfqxCnbiWOmRVNwJSu0mWQrsJIjY6QJjk9q2rOMb6kvdw08qSyVMkb+evyFSDnmzR4eSXuN5SfcFq/3HG/lttAqO0ECsjd8UgS4tfv7eF+bE47vI1OO8cG+fdTBPLudElphygALmW+/IK2x5VtY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510260; c=relaxed/simple;
	bh=D1SHf/Q6k0gRHYTrXsDfLwpQODuU63rUiRHOBs/zSPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z579HAJC1bbMnIImui1kSdrSp5upc/1jNCRXtKltGeVGKRUZ/O8hIzqQkM9qkMePNF3SIYBuM3nyl9PpkuA4aqPdu4Uj9xV3w1FZ33aVKGvCIleWV8JhPCB0mAFTZeNCw+6nIRUeXn0XEAPg/zQI3vP9tuz/sbD0atmSxYxYdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hVcdb+/+; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so2756221b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755510256; x=1756115056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhUabrkYn48Lbikledq2qqqh5BAE4/QD+CFPQO3FXYg=;
        b=hVcdb+/+2F6eC8dmagybpHuDcj+SckB99H98mgqiKJNlCR7A9Y32zyYRMRCEuYiQdq
         2p7R0YV2adsgeL40iNrcKmb2u04IhkUQXNjOX2GV3l/gNcfB3Y9oGJOw3I12tO1ur38D
         A6lHYVDIZRUfVKGR0xHweDKiPIVWpCXvMsJVELGP6B+nDlNpCeOftCiDSeS4F4nt7ZU8
         AnuxVTyGXcNjfGKdkUdbGyq3hDW0SZhp7kn2vN+c3t+GmDwpRssGtiJHgQUalJwZdGRU
         fCXih0nlFHW3v0Kqt6jvNe9+439EXXMDjeHvHjbZXD3aTZenPbUjRX3ItK7g9JVnH0jx
         5OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510256; x=1756115056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhUabrkYn48Lbikledq2qqqh5BAE4/QD+CFPQO3FXYg=;
        b=Qyn6dqrcKlbDT5qT3IuZIIpCJCktqigcxWqeyFNpqQgPF8oP5376shJK0SREe69XY7
         xrioj/dDpDHCjeLbMRIotInf6zC4M3kW5UHXWmWoEXS3IVLoZHcWVQ59k6y/WhO6fahF
         yOJtguqGLWuCsF3sKI9rSnvtd2hpTBuurr02pOUsqSwxStMAnukfNaRxPFB0bST14El/
         Uydu1YZsbiSkV4Woia6sv3Ldg+5AcGADUrnhc8ouwyr/2jh+wSIuhMrhVFomemJuC62t
         QhEUgqxHHQ6qT0S132CyWcBoxaP+1Sl6uZKq1nCvnF+Qx2PQzVv2D8HObPgoos+mPkjr
         PsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjXbduwdr1rVlFgDuau+G3/IDGAgqRbu5HQtd1AWQW/lm1CKjeOVjqA9uiolRCjKXIjnwh6RQHC/kGTiCiPkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuS2ZXpIiIUJiMBWY/WC4jH8+ULu4YihsqWrElS4n4jgSpFET
	2EA7Vs4FIKFLOzVdj/ZZ8fBZ/2wzyrtOhTqhCYJm7r/f6m6obXlVHa4OK8wPxHpddT0=
X-Gm-Gg: ASbGncu2tgrbKwXalZfFA2/L1vtGkKwah7POQrjWWhfp+g4PufCKDVEy09tFdkZH6m8
	/D6zPqPNdQmCibO2SPPRsuzf/29U26jbPtu37XXV1GcROGj5+j2go0gnrpreerkWFazc2K2oeYy
	jgWkit+8QQIGt8+26d0eXuwDmqOJeCCcIoVQdk1GJYrDX66xBmwMUAlEIRBL1myJdtGar4d08Gk
	/I6VorE8hgiKbqXBk4mAMJQJH+EREZjOQfL6926XOZ2JID4QQh5V8BbTJRno9zeqKjuQciDf0sE
	eZWcDBkJNO1XQd8pbv7H8+c2UKvReLNd6pj+9V6eKxuiD3D+u6CS19d5RY9JYtq2yVZTSYRo1Xv
	LkFbOO9/kvJRcMia8H8320M2yW4NL2ST2sz1iYjaYpu1YaaTbXRiaw9OogBeY
X-Google-Smtp-Source: AGHT+IEZaY/YH9MtTwNMDfFJQKUI2OS6UAuZArNL0C86X+FxToOfXP0efaPYaMKUFj+v4u4OB+zJ+g==
X-Received: by 2002:a05:6a20:2451:b0:222:ca3f:199 with SMTP id adf61e73a8af0-240d297f5c3mr16558144637.18.1755510255710;
        Mon, 18 Aug 2025 02:44:15 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45292c7bsm6733189b3a.36.2025.08.18.02.44.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Aug 2025 02:44:15 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	andreyknvl@gmail.com,
	arnd@arndb.de,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@intel.com,
	david@redhat.com,
	ebiederm@xmission.com,
	khalid@kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linyongting@bytedance.com,
	luto@kernel.org,
	markhemm@googlemail.com,
	maz@kernel.org,
	mhiramat@kernel.org,
	neilb@suse.de,
	pcc@google.com,
	rostedt@goodmis.org,
	vasily.averin@linux.dev,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	xhao@linux.alibaba.com,
	linux-kselftest@vger.kernel.org,
	libo.gcs85@bytedance.com,
	yuanzhu@bytedance.com
Subject: Re: [PATCH v2 13/20] x86/mm: enable page table sharing
Date: Mon, 18 Aug 2025 17:44:02 +0800
Message-Id: <20250818094402.13385-1-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <e3aca3b7-4f38-410d-91d6-5a2521dedb6c@oracle.com>
References: <e3aca3b7-4f38-410d-91d6-5a2521dedb6c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you! Anthony.

Yep, I checked the comments in arch/mm/x86/fault.c file which says as your
advices in previous email.


I changed my code in kernel 5.5 as below:

       if (unlikely(is_shared_vma) && ((fault & VM_FAULT_RETRY) &&
           (flags & FAULT_FLAG_ALLOW_RETRY) || fault_signal_pending(fault, regs)))
               mmap_read_unlock(mm);

BTW: I wrote some selftests in my github repostory, which perform
the basic function of mshare, and I will write some complicated cases
to support the new functions or defect found in mshare. For example,
once you support mshare as a VMA in KVM (just as the defeat viewed by 
Jann Horn), I will add extra test cases to verify its correctiness for 
this scenario.

From Jann Horn's review:
https://lore.kernel.org/all/CAG48ez3cUZf+xOtP6UkkS2-CmOeo+3K5pvny0AFL_XBkHh5q_g@mail.gmail.com/

Currently, I put my selftest in my github repostory, and you could retrieve it
as below:

    git remote add yongting-mshare-selftests https://github.com/ivanalgo/linux-kernel-develop/
    git fetch yongting-mshare-selftests dev-mshare-v2-selftest-v1
    git cherry-pick a64f2ff6497d13c09badc0fc68c44d9995bc2fef

At this stage, I am not sure what is the best way to proceed:
- Should I send them as part of your next version (v3)?
- Or should I post them separately as [RFC PATCH] for early review?

Please let me know your preference and any sugestion is welcome.
I am happy to rebase and resend in the format that works best for
the community.

Thanks
Yongting

> Anthony
>
>>
>> As a result, needs to release vma->vm_mm.mmap_lock as well.
>>
>> So it is supposed to be like below:
>>
>> -    fault = handle_mm_fault(vma, address, flags, regs);
>> +    fault = handle_mm_fault(vma, addr, flags, regs);
>> +
>> +    if (unlikely(is_shared_vma) && ((fault & VM_FAULT_COMPLETED) ||
>> +        (fault & VM_FAULT_RETRY) || fault_signal_pending(fault, regs))) {
>> +        mmap_read_unlock(vma->vm_mm);
>> +        mmap_read_unlock(mm);
>> +    }
>>
>>>         if (fault_signal_pending(fault, regs)) {
>>>           /*
>>> @@ -1413,6 +1446,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>           goto retry;
>>>       }
>>>   +    if (unlikely(is_shared_vma))
>>> +        mmap_read_unlock(vma->vm_mm);
>>>       mmap_read_unlock(mm);
>>>   done:
>>>       if (likely(!(fault & VM_FAULT_ERROR)))
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index e6c90db83d01..8a5a159457f2 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1344,7 +1344,7 @@ config PT_RECLAIM
>>>     config MSHARE
>>>       bool "Mshare"
>>> -    depends on MMU
>>> +    depends on MMU && ARCH_SUPPORTS_MSHARE
>>>       help
>>>         Enable msharefs: A ram-based filesystem that allows multiple
>>>         processes to share page table entries for shared pages. A file 
>>
>> Yongting Lin. 
>
>

