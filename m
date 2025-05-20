Return-Path: <linux-kselftest+bounces-33381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25785ABD315
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB73AD16B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A534D2116FE;
	Tue, 20 May 2025 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhiYxGE2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2582192E3
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732602; cv=none; b=JV0nqkxhrZCcJbyHIUzphzgaXx5y8eGvswzF5em796UZi1AsOq8bJUu7cBWJbeZUreNsjwygvdCjZR4oIznWblLygcXpqWW9RBoIl2AM7DuIjj7DhkPZoCs79Ufb2UX7cZ6yruq/SMvF14017JNzvSXfpW4lTLB8Z8+kF43d10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732602; c=relaxed/simple;
	bh=OWQyDxf4pdV7NXqRsTreru/4sz7j9p7kNz2GE6Dg1I8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0BF4lThhgc/VNuEgJgPoQ676bit0hI3OPH/ijqqYbQHkQS7eDav34wazWkUnBpH0EBGKk7TEJ348iuuezOx136swvEhiTWK5kRh3XHMbbAODcbI0z+zorL34yAxoFO21YNRDK3tCQ8j338LqwtQlKU+tObOBfRm4g2gEHE3+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhiYxGE2; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a364d121ccso917096f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 02:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747732599; x=1748337399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M49HFsU6Pb6WX2e+1aRCio5ocQDP8AMxA4CCf+KlIDA=;
        b=QhiYxGE26zhiImTnnMAbPz4st08W93XnQWfNntnVo5TBdBBgQ+boyaCSXXjZ1v+Imi
         D5MYlJq8jzf6YObw6KSH5U23+S433icLOl4fDZhOLUKM4SXBGcLwr5BMteWR7DTBgVN8
         63bDVQj8awdvvx1Qn/HPeL+rj4Rxo9zezoOja+m6gbPfqQiuXAqxwLQ8VG9BvH4+5pn0
         T/gxrxr/Osp9JDzMG3rTxJ4SVIBOpPmlBzt6ky1ZTugKwNg0jhN3q2FztiAgbjMiy1mI
         ssyv0p4Pisab6rLn3F2Sy4VyV/F4l1/bkUHVuUQ4+SG2GgY4AtoZvu8g/cQadGoq6q4S
         afAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732599; x=1748337399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M49HFsU6Pb6WX2e+1aRCio5ocQDP8AMxA4CCf+KlIDA=;
        b=Og8PLoais7D+VJNP57LoJ3P3RqgV0skbvBGGbLq6qG+tdRAuVxqBd8ehUtOe+I1FAO
         Jj/S1n1a3JHdfF6NU+ktAdD5mMagr4hEyqCfoidvfzGQS2K4QdOkzwekKdwQOkAiJrAW
         GZX2aZSJtwT/acpujv1O+xNdtSqmUJyAlEOYKfWBbhBiX3c2u5kzy09RGB8Saj29mKX4
         xLpfPB0MzBlKHJSuIkKa4hSSoTifPDDgJMHD4edq04rtz0hZdGLK77RlrZihwhzW9wJ5
         ai79/e9TwglNabhIhi/7Wlu61GBzpyWkFbO3SyiJay+wzqUQx1syt7M6t6bDND3Rw+FM
         jqAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyflIqdZzfwDVYeLuqTk930ik60ofUY1aAov64ztzP3cD6oCMPPWKobTsh7VXPhg4oN/aAt1t5ruZLvAWV3/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YweI0z9o22TdQo8eltcXt6qcAg4wh6anydrdJ3DATUFMw0Pxlxw
	PNnkuP2JunJord7YXG7ddvQQ3WnQvs0FZ5ClpaY/qJG8ntEu4RQIpXBcp0lJIN042oOyTqJyb8A
	29qil96lLWdxGdg==
X-Google-Smtp-Source: AGHT+IEdEysW4HTaGc37Upjr0n86XOGgGu3Xq2zEH7pHo0DLNR5gZ2MKL5FFJktJtfla8a1/c+K0w9OcvR4I+g==
X-Received: from wmbfl25.prod.google.com ([2002:a05:600c:b99:b0:442:f8cb:d12a])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2012:b0:3a0:830a:3d63 with SMTP id ffacd0b85a97d-3a35c821bc7mr14418992f8f.9.1747732599206;
 Tue, 20 May 2025 02:16:39 -0700 (PDT)
Date: Tue, 20 May 2025 09:16:37 +0000
In-Reply-To: <CALkFLLLfxT1pQ_ySB1NU4KXOEGLd2wB8pbhpBG2HfK3_mLOYAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250510160335.1898-1-ujwal.kundur@gmail.com>
 <D9V0UTL5BCLM.1WHR6F4UN14QQ@google.com> <CALkFLLLfxT1pQ_ySB1NU4KXOEGLd2wB8pbhpBG2HfK3_mLOYAQ@mail.gmail.com>
X-Mailer: aerc 0.20.0
Message-ID: <DA0VHZ6KE96B.XOYNEFMGWD58@google.com>
Subject: Re: [PATCH v3 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
From: Brendan Jackman <jackmanb@google.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: <akpm@linux-foundation.org>, <peterx@redhat.com>, <shuah@kernel.org>, 
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon May 19, 2025 at 1:50 PM UTC, Ujwal Kundur wrote:
> Thanks for the review and testing!
>
>>> -static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
>>> -                         unsigned long offset)
>>> +static void retry_copy_page(uffd_global_test_opts_t *gopts, struct uffdio_copy *uffdio_copy,
>>> +                                                     unsigned long offset)
>>>  {
>>> -     uffd_test_ops->alias_mapping(&uffdio_copy->dst,
>>> -                                  uffdio_copy->len,
>>> -                                  offset);
>>> -     if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
>>> +     uffd_test_ops->alias_mapping(gopts,
>>> +                                                             &uffdio_copy->dst,
>>> +                                                             uffdio_copy->len,
>>> +                                                             offset);
>
>> Looks like your editor got a bit excited here :D
>>
>> There are a few other places where this happened too, e.g. the
>> are_count() declaration and there's a pthread_create_call() that's quite
>> messed up.
>
> I use vim with `:set list` turned on to display control characters and
> it looked fine to me when I submitted the patch :(
> Here's the output of $ cat -A uffd-common.c | grep -A 15 retry_copy_page:
> (where ^I represents a tab equivalent to 4 spaces)

Sounds like that's your issue - for the kernel, tab is supposed to be
as wide as 8 spaces, not 4.

>> Unfortunately I don't know of any tool that can find/fix these issues
>> automatically without also messing up the whole file. Could you just
>> do a visual skim and fix what you can spot?
>
> Yeah, I ran clang-format and it's playing by its own rules -- do we
> have a standard .clang-format file?
> Please let me know if there's a better way to find/fix whitespace
> formatting issues, I found a few inconsistencies which I will fix.

There is a .clang-format in the tree. The issue is that (AFAIK) there's
no way to retrofit clang-format really, it has to be applied to the
entire source file so if there are pre-existing deviations from its
configuration then it will "fix" those too, creating a bunch of diff
noise.

I think we just have to do it manually. checkpatch.pl can help with some
formatting issues (and it is diff-aware) but I don't think it knows
anything about this kind of hanging indentation stuff.

>
>>  static void sigalrm(int sig)
>>  {
>>       if (sig != SIGALRM)
>>               abort();
>> -     test_uffdio_copy_eexist = true;
>> +     // TODO: Set this without access to global vars
>> +     // gopts->test_uffdio_copy_eexist = true;
>>
>> Did you mean to leave this like that?
>
> Nice catch! I was hoping someone would suggest a better way to handle
> this. As far as I can tell, this was written the way it was as a
> consequence of using global variables.
> I think this sets up retries for copies in a racy way using alarm(2) /
> signal(2), not sure how effective that has proven to be. I believe the
> only way to keep this functionality would be to introduce some async
> action (libev, libuv, etc.), but is that required?

I'm afraid I'm too ignorant of this code to be able to suggest something
good here. But, can we just remove the comment and plumb the gopts
through to uffd_poll_thread()->uffd_handle_page_fault()->__copy_page()?

This is not pretty but it lets us remove the global vars which is
clearly a step in the right direciton.

