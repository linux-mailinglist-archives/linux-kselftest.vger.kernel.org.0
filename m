Return-Path: <linux-kselftest+bounces-37449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A0B08042
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 00:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8864B56672F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3872EE604;
	Wed, 16 Jul 2025 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdpoP4ho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77532EE5FD
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703911; cv=none; b=IMH67PltpAvoreo66smiTBDkWYZkP9wPludO+lnB4yXhQQzEZk62p+hs0mnEy0h774RtjJHVjU4dP1Mfw0QWXgcDqynni8BlivHgVSX0fhLneNeyQtazQKVHDfcvfbbCyxvWH8DoDwOIAYllTwIYcvar0KcCB4+62O3F9y0vKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703911; c=relaxed/simple;
	bh=Q84IssU5I5XN6Yo1Ohn+CZZASewRU7RVTbCnNA6xs44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GlAq/X5oKhw/1yZqgma6IQTJsUt473AE9JsU1m9D6bGmGgWcBbSyEKTQCpaB/fgL/SpejoYO5Ni63f/SKgS6ZNOtYx3S14RHR+UYj/nkLrl1CZLJUJE+OjOqYiq7PKTJTQjixNOpRAuTur50Cn20JA9U8VbITGlw36jJHMrgKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdpoP4ho; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74b4d2f67d5so235962b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703909; x=1753308709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QbGln+ffY7Y90MI7q8gu1bng9ELAU4xtMdmaYq3UUR4=;
        b=QdpoP4hoEmO5BFW6v5SH57WkNaU6gApIYon2TEueKPC5mE0vxDYHC3YUJK1+ZoBdoI
         EAcMIB0qzcP4ykk7KxM/8zJdEm92EflaB9xk7fYqAyXkym7uYHkM851qkbVWI5SUTDht
         henKu14fPyXszLfdQg9qCGA6IlUygOaIxnKsaQeFiMfoRvRiPasE77bwhK5btEVrhji7
         IWo6qfId9hYIG1fZtjhpPSzVO7xFlcgRTm7qWXQ6FDunnsT9y0DRMHKbEh7z3wdDqHgH
         tll9zbM4Ksb5dz7UqI0DGRaqD4VssmXZHB7oE9+YNfnfFYVZFZfpgYD4dh6r6lZRZdGm
         QpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703909; x=1753308709;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbGln+ffY7Y90MI7q8gu1bng9ELAU4xtMdmaYq3UUR4=;
        b=BOZ/Y75CiXmXYZQRjI8xL8zwmYsgpj4S2vWAkwvPRxx8mfm4ccicUirmN5Vfz/hson
         qQtVHuHMMzZmtLpHp5jz9Eca6Pc7sarbwHv3CfoDAvSZbdWdXRqiypGSL3lWQWW4UZBy
         GF48E82lME+7aEZQ8zxTvrOHapcahkQ9n0/VFS9oLwh7hGpcpSUwJbxybAClPutgtgqD
         gPaXQ99egm0Kg3LFaTInletTj/Q0JkCGUmVeH3qHDzq2YxUAJf9UJBmaNl01hNpdkNQ/
         VfNNlYzhhtTejhvo9RYjlNUrwL3IgbrbQK8o/GTtZAyOLrST9mNOQg+Ij+DQm26hFvqP
         orhw==
X-Forwarded-Encrypted: i=1; AJvYcCX0yuVYYdk7S+8dOFbQoz2FBdocHLgOKqRpTPFBZOhIjQMGc9as/4pZEGA/sKc3GYpVTI/qSXLhxQ2QA2Lh3Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4JME6z7mQR9bs4KEVtN3If+AVQZz+g0kV73u68o7B8AP4Eor
	MhnSPhT6U058A1UXYwISEFHKuZYpfRaq5E2wkvSz9Sczs015/u+KzjyVuZtX2IbNgmyeD87cRmQ
	aLg1CjTCJgw==
X-Google-Smtp-Source: AGHT+IE4W3Y7BnmBMjylTlzwr3yn9ZQJLSQMx/KCC8HNBVskNFPesWOI3UYKKnXj/2g0YetXVi/bL9AR0ySj
X-Received: from pfbjr14.prod.google.com ([2002:a05:6a00:914e:b0:746:247f:7384])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b70f:b0:748:e150:ac5c
 with SMTP id d2e1a72fcca58-756ea8b92dcmr7030056b3a.23.1752703908898; Wed, 16
 Jul 2025 15:11:48 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:11:47 -0700
In-Reply-To: <202507160729.468A057@keescook> (Kees Cook's message of "Wed, 16
 Jul 2025 07:30:42 -0700")
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-3-ynaffit@google.com>
 <202507160729.468A057@keescook>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8cy9z6b18.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH v3 2/6] binder: Store lru freelist in binder_alloc
From: Tiffany Yang <ynaffit@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXY=?= =?utf-8?B?w6Vn?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Kees Cook <kees@kernel.org> writes:
>> -		/**
>> -		 * Error message on a free page can be false positive
>> -		 * if binder shrinker ran during binder_alloc_free_buf
>> -		 * calls above.
>> -		 */
>>   	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
>>   		if (list_empty(page_to_lru(alloc->pages[i]))) {
>>   			pr_err_size_seq(sizes, seq);

> Ah, I see the comment is removed entirely here. Better to move this
> hunk to patch 1, then.


This comment is actually "true" until we allow a test-specific freelist
in this change, but I've moved the "for" line back to where it was in
the previous change. Thanks for noting this!

>> @@ -162,8 +159,8 @@ static void binder_selftest_free_page(struct  
>> binder_alloc *alloc)
>>   	int i;
>>   	unsigned long count;

>> -	while ((count = list_lru_count(&binder_freelist))) {
>> -		list_lru_walk(&binder_freelist, binder_alloc_free_page,
>> +	while ((count = list_lru_count(&binder_selftest_freelist))) {
>> +		list_lru_walk(&binder_selftest_freelist, binder_alloc_free_page,
>>   			      NULL, count);
>>   	}

>> @@ -187,7 +184,7 @@ static void binder_selftest_alloc_free(struct  
>> binder_alloc *alloc,

>>   	/* Allocate from lru. */
>>   	binder_selftest_alloc_buf(alloc, buffers, sizes, seq);
>> -	if (list_lru_count(&binder_freelist))
>> +	if (list_lru_count(&binder_selftest_freelist))
>>   		pr_err("lru list should be empty but is not\n");

>>   	binder_selftest_free_buf(alloc, buffers, sizes, seq, end);
>> @@ -275,6 +272,20 @@ static void binder_selftest_alloc_offset(struct  
>> binder_alloc *alloc,
>>   	}
>>   }

>> +int binder_selftest_alloc_get_page_count(struct binder_alloc *alloc)
>> +{
>> +	struct page *page;
>> +	int allocated = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
>> +		page = alloc->pages[i];
>> +		if (page)
>> +			allocated++;
>> +	}
>> +	return allocated;
>> +}
>> +
>>   /**
>>    * binder_selftest_alloc() - Test alloc and free of buffer pages.
>>    * @alloc: Pointer to alloc struct.
>> @@ -286,6 +297,7 @@ static void binder_selftest_alloc_offset(struct  
>> binder_alloc *alloc,
>>    */
>>   void binder_selftest_alloc(struct binder_alloc *alloc)
>>   {
>> +	struct list_lru *prev_freelist;
>>   	size_t end_offset[BUFFER_NUM];

>>   	if (!binder_selftest_run)
>> @@ -293,14 +305,41 @@ void binder_selftest_alloc(struct binder_alloc  
>> *alloc)
>>   	mutex_lock(&binder_selftest_lock);
>>   	if (!binder_selftest_run || !alloc->mapped)
>>   		goto done;
>> +
>> +	prev_freelist = alloc->freelist;
>> +
>> +	/*
>> +	 * It is not safe to modify this process's alloc->freelist if it has  
>> any
>> +	 * pages on a freelist. Since the test runs before any binder ioctls  
>> can
>> +	 * be dealt with, none of its pages should be allocated yet.
>> +	 */
>> +	if (binder_selftest_alloc_get_page_count(alloc)) {
>> +		pr_err("process has existing alloc state\n");
>> +		goto cleanup;
>> +	}
>> +
>> +	if (list_lru_init(&binder_selftest_freelist)) {
>> +		pr_err("failed to init test freelist\n");
>> +		goto cleanup;
>> +	}
>> +
>> +	alloc->freelist = &binder_selftest_freelist;
>> +
>>   	pr_info("STARTED\n");
>>   	binder_selftest_alloc_offset(alloc, end_offset, 0);
>> -	binder_selftest_run = false;
>>   	if (binder_selftest_failures > 0)
>>   		pr_info("%d tests FAILED\n", binder_selftest_failures);
>>   	else
>>   		pr_info("PASSED\n");

>> +	if (list_lru_count(&binder_selftest_freelist))
>> +		pr_err("expect test freelist to be empty\n");
>> +
>> +cleanup:
>> +	/* Even if we didn't run the test, it's no longer thread-safe. */
>> +	binder_selftest_run = false;
>> +	alloc->freelist = prev_freelist;
>> +	list_lru_destroy(&binder_selftest_freelist);
>>   done:
>>   	mutex_unlock(&binder_selftest_lock);
>>   }
>> --
>> 2.50.0.727.gbf7dc18ff4-goog

> Otherwise looks good.

-- 
Tiffany Y. Yang

