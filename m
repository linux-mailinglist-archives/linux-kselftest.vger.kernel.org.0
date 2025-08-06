Return-Path: <linux-kselftest+bounces-38378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057FB1C7FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 16:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED5D3B898C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27931DED49;
	Wed,  6 Aug 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6Yr3zQB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9391D63C7;
	Wed,  6 Aug 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492076; cv=none; b=fMshoMcnP1gGks/PliFMHkaOhKaPDwQWwyLOGsQbTfyMbk+DnkX7yPyxMZuDWtpLMUIQfO6deomQmAzxkcmgi0kOx437PpR/XucO3WJnCsm/z68rAs8xVw7MjWcMhsxss/BgNTTxDCgO9Az8oT5YhEejNVw31dCX7QTdXyFX+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492076; c=relaxed/simple;
	bh=20UlBhFxiM7AmMKXTe391uusOsHNWtrdHst1H5qTpqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+MYhsLqbVEWxNKE0NcgunEqKtnVHBvSdUbKQRfvJiJaVsmlUZacK860LUYBrOyVyQpQWm0cnANPP9pJXkme/mFFisOAdyqsmM3iKM3pHqTopENaS07XbXbZ4ihf7fmm8hzMe9nUjo11JBY79CC1OQbTQIh3LFQbfWpbD9XXoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6Yr3zQB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so1505162366b.3;
        Wed, 06 Aug 2025 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754492073; x=1755096873; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/rb74Rn4CUT7usZvguA3GJ62ZV1pluEnH5A6t2WngA=;
        b=U6Yr3zQBhyDBFvSh2F2gyChz359lbMcF/lXwnUNejSEq0WSKpGxSqQvkx5cqqOvLGS
         XlXccT80rDJvQL1iRpXB9X6zQpg0StTC6fbVywmJfWzwE0tfsQtlaF9m9/jzRc2ijCr2
         e8zeciGEJvaJfS+Tgg/JTjpuI+qbG5pmj76oZwCKfIBWG/sOxQLWmAfsG6BEQeYZ9PYf
         A+Fjj6eAisrZWPHG+DpXcrgBqOWrdoqQ+97mkGKYl5yG1lOIufDXVkFEYrvV+44AtHFk
         mkW9dNafT+ZADoTVD9dOUMBgNlytw6ibneyUSw+2Hoki8syd6jcMWnIXj42OmL+epP64
         UG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754492073; x=1755096873;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/rb74Rn4CUT7usZvguA3GJ62ZV1pluEnH5A6t2WngA=;
        b=bWcrTtjrZu+57nVsnw7OQ7+hrWnWqS/NxBsO1i6im4jSq6P+D9TkEOxzvjxYf/SIq4
         Xdy4GiovwbaRoYlX1Zupu1zPIykchr0k+6Vcu6wrpcwQwTAEcoS+3uUxJC8Wr8cG5/jb
         rW9ssuLLZkCINFm0g2b6WgSiypSIPPjs4zxuK5FxgatznlVgLdaZQEndcho2rqUOlnKY
         2qBKxeSzm9oMojBWXpuqmCoSpC1a7tE6Xy7ExsGjVqkwML170exNKl2jy2rmdTOCwuru
         0bm9VIUI1NViXEyI2LTPPcm++JGci/DUg8sigCnvsMyxe2ewFZkr/GfRkKdcyppWzn8Z
         9fXA==
X-Forwarded-Encrypted: i=1; AJvYcCVKkKBEBA4KecoUTbR9ELTNFc07tZDFfP++UwnoyybW5/X3jmaTbKdAOp+jNAnJI9Spx6xyTDVDCF4Pt/SvIcCL@vger.kernel.org, AJvYcCXxSYHbyrtC02WSOIFuJO//oNex9sKYz/t03U0tcbftPI+g8rkC1U4/+dQ6T0Lcm7QIo4xznENPzBqcQ4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpa4pO7uRUmAFHqJReGYiOL3JewDqmYdG0ZooOiTgFyXoY5Fh
	oJzf0rOr1DjL/ai857r1weU24P3utsFoHig/N4nN5ZxNENwV8lpruomg
X-Gm-Gg: ASbGnctSBnFCCw6JYQEPYbK7PwSpLrX9lZwZ/3j7JytxJFPLUDoyJ67u95vY0prUOKo
	q+9LFKdCLRoL+Z9TPZeTGgLyGPNl+IhkPTNhIbrrcFBSlS+01mGLo4EHasiRSPanOrLOk4sUKbo
	K+ecPStUMorshihA4H5qCshu2Alzt/IukyLtwdEODoXSbLfhWYwCPRFwIK+S5ABSJ+2z9zrvO2D
	zk2tYpXNWQiE/LYucV9zDSEfBNhE+nulRGZn1zhaLmdfXNPPssjiNLXQYgQ6Or84+m3/9N22Wrc
	L+Nyt6kM0QMSsF7sWAshqBUsdwQbUCI4/kdNDR2pS9PImB8TTg+cdJ14mA8XcI/dY9Dj7i96cic
	6IzKiuyY1u4fwhxnfrVU21w==
X-Google-Smtp-Source: AGHT+IFS6g0g1OqUDi72LqUCVo/ND5e7JBrkMGvo/NtwvaBttPCiw1Ma69w75ETAugGec2ZHXmvHzA==
X-Received: by 2002:a17:907:3f8c:b0:ad5:2e5b:d16b with SMTP id a640c23a62f3a-af990350c69mr348859766b.27.1754492073165;
        Wed, 06 Aug 2025 07:54:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766f9sm1139997566b.24.2025.08.06.07.54.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Aug 2025 07:54:32 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:54:32 +0000
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
Message-ID: <20250806145432.nygrslkiyvzulujn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
 <20250729053403.1071807-4-aboorvad@linux.ibm.com>
 <20250804091141.ifwryfmgjepwrog4@master>
 <20fb853c-7d79-4d26-9c8a-f6ce9367d424@linux.ibm.com>
 <20250805170353.6vlbyg6qn5hv4yzz@master>
 <e9079694-1e30-46b6-97e7-b79be01c65a6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9079694-1e30-46b6-97e7-b79be01c65a6@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Aug 06, 2025 at 06:30:37PM +0530, Donet Tom wrote:
[...]
>> Child process inherit the ksm_merging_pages from parent, which is reasonable
>> to me. But I am confused why ksm_unmerge() would just reset ksm_merging_pages
>> for parent and leave ksm_merging_pages in child process unchanged.
>> 
>> ksm_unmerge() writes to /sys/kernel/mm/ksm/run, which is a system wide sysfs
>> interface. I expect it applies to both parent and child.
>
>I am not very familiar with the KSM code, but from what I understand:
>
>The ksm_merging_pages counter is maintained per mm_struct. When
>we write to /sys/kernel/mm/ksm/run, unmerging is triggered, and the
>counters are updated for all mm_structs present in the ksm_mm_slot list.
>
>A mm_struct gets added to this list  when MADV_MERGEABLE is called.
>In the case of the child process, since MADV_MERGEABLE has not been
>invoked yet, its mm_struct is not part of the list. As a result,
>its ksm_merging_pages counter is not reset.
>

Would this flag be inherited during fork? VM_MERGEABLE is saved in related vma
I don't see it would be dropped during fork. Maybe missed.

>
>> > value remained unchanged. That’s why get_my_merging_page() in the child was
>> > returning a non-zero value.
>> > 
>> I guess you mean the get_my_merging_page() in __mmap_and_merge_range() return
>> a non-zero value. But there is ksm_unmerge() before it. Why this ksm_unmerge()
>> couldn't reset the value, but a ksm_unmerge() in parent could.
>> 
>> > Initially, I fixed the issue by calling ksm_unmerge() before the fork(), and
>> > that
>> > resolved the problem. Later, I decided it would be cleaner to move the
>> > ksm_unmerge() call to the test cleanup phase.
>> > 
>> Also all the tests before test_prctl_fork(), except test_prctl(), calls
>> 
>>    ksft_test_result(!range_maps_duplicates());
>> 
>> If the previous tests succeed, it means there is no duplicate pages. This
>> means ksm_merging_pages should be 0 before test_prctl_fork() if other tests
>> pass. And the child process would inherit a 0 ksm_merging_pages. (A quick test
>> proves it.)
>
>
>If I understand correctly, all the tests are calling MADV_UNMERGEABLE,
>which internally calls break_ksm() in the kernel. This function replaces the
>KSM page with an exclusive anonymous page. However, the
>ksm_merging_pages counters are not updated at this point.
>
>The function range_maps_duplicates(map, size) checks whether the pages
>have been unmerged. Since break_ksm() does perform the unmerge, this
>function returns false, and the test passes.
>
>The ksm_merging_pages update happens later via the ksm_scan_thread().
>That’s why we observe that ksm_merging_pages values are not reset
>immediately after the test finishes.
>

Not familiar with ksm internal. But the ksm_merging_pages counter still has
non-zero value when all merged pages are unmerged makes me feel odd.

>If we add a sleep(1) after the MADV_UNMERGEABLE call, we can see that
>the ksm_merging_pages values are reset after the sleep.
>
>Once the test completes successfully, we can call ksm_unmerge(), which
>will immediately reset the ksm_merging_pages value. This way, in the fork
>test, the child process will also see the correct value.
>> 
>> So which part of the story I missed?
>> 
>
>So, during the cleanup phase after a successful test, we can call
>ksm_unmerge() to reset the counter. Do you see any issue with
>this approach?
>

It looks there is no issue with an extra ksm_unmerge().

But one more question. Why an extra ksm_unmerge() could help.

Here is what we have during test:


  test_prot_none()
      !range_maps_duplicates()
      ksm_unmerge()                  1) <--- newly add
  test_prctl_fork()
      >--- in child
      __mmap_and_merge_range()
          ksm_unmerge()              2) <--- already have

As you mentioned above ksm_unmerge() would immediately reset
ksm_merging_pages, why ksm_unmerge() at 2) still leave ksm_merging_pages
non-zero? And the one at 1) could help.

Or there is still some timing issue like sleep(1) you did?

-- 
Wei Yang
Help you, Help me

