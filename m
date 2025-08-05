Return-Path: <linux-kselftest+bounces-38307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A21F6B1B8E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 19:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6B817A5F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087F21A43D;
	Tue,  5 Aug 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnqJdZsS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF433997;
	Tue,  5 Aug 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413439; cv=none; b=EeqIHhe+Us5Mc0tHrp0IP2pIA3qVmLSsoJ1Gl2twHA4j221e2NyZWPn1/9/vASTVwlseuM0E5sbk3Y6lk9nXnY3BGtZHDWQYWjVUihfrT739HYStyjuQtP6TnDiX/QHfALoAPHe5XnAoMDm9qMVzbet5+7zCuzDQ+sLAsD3YF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413439; c=relaxed/simple;
	bh=UvMe0V6kKXltSytEvFS/hOQFEj/5VxmSNqBL6fa8VGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8/W46Pd3ZeenjADgVEHCcOayEmKY6GlD1r7Y6xrSaroI61+AZYvhJVM9SGppL+PgDJdDARf/398Nx9P7h4uK9bSFE2RGbFB04YqWVt8MDZPkrpXmxbj3E9o0RtFJkDfg/4Wd7tonAf1bcVWQ0et3xIhkgj2CYkFzqDv4vB1etI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnqJdZsS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61530559887so7844644a12.1;
        Tue, 05 Aug 2025 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754413436; x=1755018236; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocAA6Mc755BpdMt20sH6v5c6z0jN15Kqz/vvCPh53bY=;
        b=JnqJdZsSJkJdd1c+x38m4027ebaezVUMyx/XfQqESQEFyGzNRDC2b/2VI9r54GzM01
         Zt9CMUwC90pmsK/z6MgbJRNZkyIPrrpAPyRRt2tKu+0x+oK5ghRILAHvqf8VqituXxSS
         1H5IGs6Zw9ah00cSPu7zR+S/nk97Misfemz8MhF48IJcYaAm0/GMDQah95XqZ0NKGOP5
         RCOV8yDf7QIs2HT/VuQF08iZHmHG6ZW/qW76DZeL7fv75QL5LP9NWQQ8DNN4YxKv+ECw
         tgmTCG3chDYEYYWLlvdasgyBE5Lr1x/x+I29f84hsrZntBXUILUCc1gjPuR0OikxVtIi
         hBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754413436; x=1755018236;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocAA6Mc755BpdMt20sH6v5c6z0jN15Kqz/vvCPh53bY=;
        b=RuG+l0EBgP9x4ZsYvAxbOpb1xw5DsKIUprquKsmCGOv6pjDaoWaXin1jj4x82PAhxg
         mBltF2UnZD4cHu+24VwMz0eMNqLHEYJbzgeKb2MjbckcwmTnlOvdh4u6bGX52w00vvLU
         1knFPqCLs1nM6u/jRXWugjats+XOaEtxQofM0U8O3bIZsptjKx4AAWL0GlX+A7vj9dFB
         gzClxF8jgVRMZlhpJ3KLFIZEdLPx+7wbPw/IbI/oTYxRJbXktJLuFCfg/5rgv307kIG1
         +UoEmpS1Q1JumMl+2N+bBBXcVC56EyONjrMlnhf2yyrNe16zZISVMKkB6HxhHTGirqvH
         Kjhg==
X-Forwarded-Encrypted: i=1; AJvYcCV27JZwDS3NZoDyCSAxY0Txq/K+ljYaQeLqLMVfNwSg1SvazpJewEuMBILMed9/ONrzjbkp1OXc/sYS557FyK2T@vger.kernel.org, AJvYcCWhXtiTcvtGbYvhjKG++9tqDDMlVUNsZ6GgKUWzxUTHgczBoIIqwchULW0JYGErYk9YzhP6k3J/rEsJ1fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydoaAvEQ6Mwg5i0j1ZRzMwbf7QZbj57xWeo2Po1erOciphEf3s
	7dsIQMELRvL+jEhLAN0EF1HHijTX+hfnerKIRPQyltUec6Y4SQcPaoBu
X-Gm-Gg: ASbGncv/NVxKd1uTUAvoq5SW6fx6DZ82rftr2xNixa0SdlXiKTxkZikIhZTJmAiyNdn
	jTtccIUgFKCHbplPNBhfE6vmHGeqhSa/YXGf9VbNrd3M9xtkl4IbbX6YB0+il0HZfGRWInYMIJN
	93f2UGxcGuauCeuasKZjLxK57JnqnenK8tf9db3FBJJpUU2CTepKrH+O2lEjVkhAna1vg8b71h9
	IuIqDgbH6/V7wRg6sTk6dkgNRwBxMVwX7w8clhqwk0ohXvP/7uAoA2vZh7dy9c4fqpfo/NzSFEo
	KU4Tlj8xrmJ4p3QhaJE75JEXIxes1jJ4B96BS2gxNZ9ZuV3+l+lNV39nbNpEf4U+XlKDhDDscMx
	6GEPTFJ3lgS4x/hTiUuNUmNcCTDRGEKNl
X-Google-Smtp-Source: AGHT+IHg2poof9nm6xmGEfRIM/7L18y09RE8bRAhvnrt2eAaqx4Y2wGX6dk9nmtbikSVdZkiCToGqw==
X-Received: by 2002:a05:6402:4491:b0:614:a23b:4959 with SMTP id 4fb4d7f45d1cf-615e6ec6e07mr12362413a12.10.1754413435687;
        Tue, 05 Aug 2025 10:03:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm8777081a12.25.2025.08.05.10.03.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Aug 2025 10:03:54 -0700 (PDT)
Date: Tue, 5 Aug 2025 17:03:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ritesh.list@gmail.com
Subject: Re: [PATCH v3 3/7] selftest/mm: Fix ksm_funtional_test failures
Message-ID: <20250805170353.6vlbyg6qn5hv4yzz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
 <20250729053403.1071807-4-aboorvad@linux.ibm.com>
 <20250804091141.ifwryfmgjepwrog4@master>
 <20fb853c-7d79-4d26-9c8a-f6ce9367d424@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20fb853c-7d79-4d26-9c8a-f6ce9367d424@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 05, 2025 at 11:39:15AM +0530, Donet Tom wrote:
>
>On 8/4/25 2:41 PM, Wei Yang wrote:
>> On Tue, Jul 29, 2025 at 11:03:59AM +0530, Aboorva Devarajan wrote:
>> > From: Donet Tom <donettom@linux.ibm.com>
>> > 
[...]
>> > diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
>> > index d8bd1911dfc0..996dc6645570 100644
>> > --- a/tools/testing/selftests/mm/ksm_functional_tests.c
>> > +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>> > @@ -46,6 +46,8 @@ static int ksm_use_zero_pages_fd;
>> > static int pagemap_fd;
>> > static size_t pagesize;
>> > 
>> > +static void init_global_file_handles(void);
>> > +
>> > static bool range_maps_duplicates(char *addr, unsigned long size)
>> > {
>> > 	unsigned long offs_a, offs_b, pfn_a, pfn_b;
>> > @@ -274,6 +276,7 @@ static void test_unmerge(void)
>> > 	ksft_test_result(!range_maps_duplicates(map, size),
>> > 			 "Pages were unmerged\n");
>> > unmap:
>> > +	ksm_unmerge();
>> In __mmap_and_merge_range(), we call ksm_unmerge(). Why this one not help?
>> 
>> Not very familiar with ksm stuff. Would you mind giving more on how this fix
>> the failure you see?
>
>
>The issue I was facing here was test_prctl_fork was failing.
>
># [RUN] test_prctl_fork
># Still pages merged
>#
>
>This issue occurred because the previous test performed a merge, causing
>the value of /proc/self/ksm_merging_pages to reflect the number of
>deduplicated pages. After that, a fork() was called. Post-fork, the child
>process
>inherited the parent's ksm_merging_pages value.
>

Yes, this one is fixed by calling init_global_file_handles() in child.

>Then, the child process invoked __mmap_and_merge_range(), which resulted
>in unmerging the pages and resetting the value. However, since the parent
>process
>had performed the merge, its ksm_merging_pages value also got reset to 0.
>Meanwhile, the child process had not performed any merge itself, so the
>inherited

I assume the behavior described here is after the change to call
init_global_file_handles() in child.

Child process inherit the ksm_merging_pages from parent, which is reasonable
to me. But I am confused why ksm_unmerge() would just reset ksm_merging_pages
for parent and leave ksm_merging_pages in child process unchanged.

ksm_unmerge() writes to /sys/kernel/mm/ksm/run, which is a system wide sysfs
interface. I expect it applies to both parent and child.

>value remained unchanged. That’s why get_my_merging_page() in the child was
>returning a non-zero value.
>

I guess you mean the get_my_merging_page() in __mmap_and_merge_range() return
a non-zero value. But there is ksm_unmerge() before it. Why this ksm_unmerge()
couldn't reset the value, but a ksm_unmerge() in parent could.

>Initially, I fixed the issue by calling ksm_unmerge() before the fork(), and
>that
>resolved the problem. Later, I decided it would be cleaner to move the
>ksm_unmerge() call to the test cleanup phase.
>

Also all the tests before test_prctl_fork(), except test_prctl(), calls

  ksft_test_result(!range_maps_duplicates());

If the previous tests succeed, it means there is no duplicate pages. This
means ksm_merging_pages should be 0 before test_prctl_fork() if other tests
pass. And the child process would inherit a 0 ksm_merging_pages. (A quick test
proves it.)

So which part of the story I missed?

-- 
Wei Yang
Help you, Help me

