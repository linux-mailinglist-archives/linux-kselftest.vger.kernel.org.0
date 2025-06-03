Return-Path: <linux-kselftest+bounces-34215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE0CACC709
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 14:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFB3A2945
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347B722DF84;
	Tue,  3 Jun 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhUi49wi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036E1CAB3
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955114; cv=none; b=C+Y+NF1Djecwoa0WeRd1+GcJb8NIWJXlh6kHwrorgBtaf8SQ23drG99n/ge1wcmbqmLeSNnRiK3zPUeeID1otLHmihsxzQ2y9LKsJKfBUYV1aA05dRWdG0VA/XrrJz09G3Ml3cy4dx3wfuq4hG3Xhf8jIohsACGFKoFfP5it30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955114; c=relaxed/simple;
	bh=XMMC4GZrKrTz+PtYFGjhon4CVSaVJrm3lUp7Eqo1VeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHmJd12sBIfwdHwdOmD2ELXN/UyqwsXXiOY/hT2xXwqsgzN103H5KxHFi5foHyCcCBbfhW1DbpL8bDUFh42lo6zrA3o/0cS6a1z2IcdK/xkiW4zWvLBop6syHqQT6X1SNzLYAAlFrtjcF2oMlCulvDtq6hhPG4FwpyT0aF4NN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhUi49wi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748955110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=372y/IAdKZEsWMnwRoDF3w+Ey3Nn1qYXNMQvOyleGOc=;
	b=XhUi49wip09pfU0UzarDtjqPWsxvcZq3V5zTdK0I0CvgCPzavhjLZkTj6eOV+ZITo9uVnt
	JfElNxW6vlSpwCpqs6L0y4ONp8bg5o+pLz/FEHJalqVUNqd8BXafq2XwyJcYzrwFLaE679
	2ks3VTYOEZuUynayc8oBd5qN/x9Qc9A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-4aCPLZXpMDCnfHshfkZWyQ-1; Tue, 03 Jun 2025 08:51:49 -0400
X-MC-Unique: 4aCPLZXpMDCnfHshfkZWyQ-1
X-Mimecast-MFC-AGG-ID: 4aCPLZXpMDCnfHshfkZWyQ_1748955108
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so1618715f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 05:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748955108; x=1749559908;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=372y/IAdKZEsWMnwRoDF3w+Ey3Nn1qYXNMQvOyleGOc=;
        b=gDV4EXmHPE2AiX1uHkdSlRZX52w+CUOWsWHMOiQbtoAminrYipt71yxcl2+rzq3tvI
         TiUXyaEaCco/w2AFlw8xGrlguSZsa14ODUTFJCwzwPgsJuBsLi1RHQk7GEFPXdnnxttG
         U5rFuWkiABWP4QqHTE4lJ2Hhyu8t5HXJYKDALRy97nKpMcoXDjZP3Yvik3bXJ4G0WKBX
         qsEIO6S8VoRictWs0t6mHznkN3hSw2tGSNDb5D/SM/t/et3z0fU1JeG7fzsdFRGJ7mPh
         HXDvpRIK5pZYGxsIyZtKUF4sqvfZ3SLT1n7Wi3K7lVsodnTtS/f8NvQ4YV+EFcTYq2EM
         esug==
X-Forwarded-Encrypted: i=1; AJvYcCUeadBFtX/m5UmS5tVdb9psoQ5SYDVVM8iUm0WQyloGsdvTX6LS9gES2I6jtj4LO0VfppT1psKZquV/FUKvjdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy6P2Is1EPD+8x7Z8/j6Jplsp7fF0ahsRbkM3ncIV+ZfxK6U02
	/3i9s3pFfPfymBMku/gr5lzLCH2KZJG9J5JsM5WHBc0VDW+08/DWfKoASbZB9WRKfiQLJSy+gx1
	bIu8DsZ5sgvcV6ASW04Wfw+5uHcW8VtTdp5ce5kbEl2Vcqch/2BUY7dKMw/7dORGCBoKuQg==
X-Gm-Gg: ASbGnctEKXyf0xHbfWehZH3kWUd8r3JJPWCMiH2q/srGy6KPbozieBNQs+Qi1nGZtMS
	tGY4uLQfHHQqrzqgnzptP2w1ZWDqfqkXLW6XAaan+GWSflfhgqgMyp/eBAnAIEo4X3Rh90JP/Mu
	SHt6DoPhV7FnCefbnI3vuf0ts/hO6riqHWP2bUKOFmY9M4XXmGSY5bPD/ftT/Y7R/C52Jcmzr8A
	lfC8PHAA70jqWcpYLojVSbObtBuIYXLXm40rhg3QZZ0uRu5X42dr4erDysz0ComPrP+teqyPoza
	Ou/oWmvEoCddlSz6w+XWROcTA4gjoOF4uR3XuHa8DIa95mhK4IKscoDA6woDw0P6seF/bplX9Tf
	oLRGgoTTBePd2RQcLJ2hpV7/caFEKUwDNsrW5Ue8=
X-Received: by 2002:a05:6000:4283:b0:3a5:1241:ce99 with SMTP id ffacd0b85a97d-3a51241ceb1mr3376248f8f.24.1748955107556;
        Tue, 03 Jun 2025 05:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZaRJg+SsN2hMfIu4+2kktVrsynu7W9/V6Llee5LgTWDBtKZaZzc5Yi5spmGqamFhVYSpK3A==
X-Received: by 2002:a05:6000:4283:b0:3a5:1241:ce99 with SMTP id ffacd0b85a97d-3a51241ceb1mr3376223f8f.24.1748955107055;
        Tue, 03 Jun 2025 05:51:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa249esm166836395e9.13.2025.06.03.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 05:51:46 -0700 (PDT)
Message-ID: <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
Date: Tue, 3 Jun 2025 14:51:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] selftests/mm: Report unique test names for each
 cow test
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.05.25 18:04, Mark Brown wrote:
> The kselftest framework uses the string logged when a test result is
> reported as the unique identifier for a test, using it to track test
> results between runs. The cow test completely fails to follow this pattern,
> it runs test functions repeatedly with various parameters with each result
> report from those functions being a string logging an error message which
> is fixed between runs.
> 
> Since the code already logs each test uniquely before it starts refactor
> to also print this to a buffer, then use that name as the test result.
> This isn't especially pretty but is relatively straightforward and is a
> great help to tooling.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/mm/cow.c | 333 +++++++++++++++++++++++++--------------
>   1 file changed, 217 insertions(+), 116 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index e70cd3d900cc..dbbcc5eb3dce 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -112,9 +112,12 @@ struct comm_pipes {
>   
>   static int setup_comm_pipes(struct comm_pipes *comm_pipes)
>   {
> -	if (pipe(comm_pipes->child_ready) < 0)
> +	if (pipe(comm_pipes->child_ready) < 0) {
> +		ksft_perror("pipe()");

"pipe() failed"

>   		return -errno;
> +	}
>   	if (pipe(comm_pipes->parent_ready) < 0) {
> +		ksft_perror("pipe()");

"pipe() failed"

[...]

>   		 */
>   		ret = mprotect(mem, size, PROT_READ);
> -		ret |= mprotect(mem, size, PROT_READ|PROT_WRITE);
>   		if (ret) {

Not sure if that change is really required: if the second mprotect 
succeeds, errno should not be updated. At least if my memory is correct :)

Same applies to similar cases below.

> -			ksft_test_result_fail("mprotect() failed\n");
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
> +			write(comm_pipes.parent_ready[1], "0", 1);
> +			wait(&ret);
> +			goto close_comm_pipes;
> +		}
> +
> +		ret = mprotect(mem, size, PROT_READ|PROT_WRITE);
> +		if (ret) {
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
>   			write(comm_pipes.parent_ready[1], "0", 1);
>   			wait(&ret);
>   			goto close_comm_pipes;
> @@ -248,16 +261,16 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
>   		ret = -EINVAL;
>   
>   	if (!ret) {
> -		ksft_test_result_pass("No leak from parent into child\n");
 > +		log_test_result(KSFT_PASS);>   	} else if (xfail) {
>   		/*
>   		 * With hugetlb, some vmsplice() tests are currently expected to
>   		 * fail because (a) harder to fix and (b) nobody really cares.
>   		 * Flag them as expected failure for now.
>   		 */
> -		ksft_test_result_xfail("Leak from parent into child\n");

We're losing improtant information here.

> +		log_test_result(KSFT_XFAIL);
>   	} else {
> -		ksft_test_result_fail("Leak from parent into child\n");

Same here and in other cases below (I probably didn't catch all).

We should log that somehow to indicate what exactly is going wrong, 
likely using ksft_print_msg().

> +		log_test_result(KSFT_FAIL);
>   	}
>   close_comm_pipes:
>   	close_comm_pipes(&comm_pipes);
> @@ -306,26 +319,29 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>   
>   	ret = setup_comm_pipes(&comm_pipes);
>   	if (ret) {
> -		ksft_test_result_fail("pipe() failed\n");
> +		log_test_result(KSFT_FAIL);
>   		goto free;
>   	}
>   
>   	if (pipe(fds) < 0) {
> -		ksft_test_result_fail("pipe() failed\n");
> +		ksft_perror("pipe() failed");
> +		log_test_result(KSFT_FAIL);
>   		goto close_comm_pipes;
>   	}
>   
>   	if (before_fork) {
>   		transferred = vmsplice(fds[1], &iov, 1, 0);
>   		if (transferred <= 0) {
> -			ksft_test_result_fail("vmsplice() failed\n");
> +			ksft_print_msg("vmsplice() failed\n");

ksft_perror?

> +			log_test_result(KSFT_FAIL);
>   			goto close_pipe;
>   		}
>   	}
>   
>   	ret = fork();
>   	if (ret < 0) {
> -		ksft_test_result_fail("fork() failed\n");
> +		ksft_perror("fork() failed\n");
> +		log_test_result(KSFT_FAIL);
>   		goto close_pipe;
>   	} else if (!ret) {
>   		write(comm_pipes.child_ready[1], "0", 1);
> @@ -339,7 +355,8 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>   	if (!before_fork) {
>   		transferred = vmsplice(fds[1], &iov, 1, 0);
>   		if (transferred <= 0) {
> -			ksft_test_result_fail("vmsplice() failed\n");
> +			ksft_perror("vmsplice() failed");
> +			log_test_result(KSFT_FAIL);
>   			wait(&ret);
>   			goto close_pipe;
>   		}
> @@ -348,7 +365,8 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>   	while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
>   		;
>   	if (munmap(mem, size) < 0) {
> -		ksft_test_result_fail("munmap() failed\n");
> +		ksft_perror("munmap() failed");
> +		log_test_result(KSFT_FAIL);
>   		goto close_pipe;
>   	}
>   	write(comm_pipes.parent_ready[1], "0", 1);
> @@ -356,7 +374,8 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>   	/* Wait until the child is done writing. */
>   	wait(&ret);
>   	if (!WIFEXITED(ret)) {
> -		ksft_test_result_fail("wait() failed\n");
> +		ksft_perror("wait() failed");
> +		log_test_result(KSFT_FAIL);
>   		goto close_pipe;
>   	}
>   
> @@ -364,22 +383,23 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>   	for (total = 0; total < transferred; total += cur) {
>   		cur = read(fds[0], new + total, transferred - total);
>   		if (cur < 0) {
> -			ksft_test_result_fail("read() failed\n");
> +			ksft_perror("read() failed");
> +			log_test_result(KSFT_FAIL);
>   			goto close_pipe;
>   		}
>   	}
>   
>   	if (!memcmp(old, new, transferred)) {
> -		ksft_test_result_pass("No leak from child into parent\n");
> +		log_test_result(KSFT_PASS);
>   	} else if (xfail) {
>   		/*
>   		 * With hugetlb, some vmsplice() tests are currently expected to
>   		 * fail because (a) harder to fix and (b) nobody really cares.
>   		 * Flag them as expected failure for now.
>   		 */
> -		ksft_test_result_xfail("Leak from child into parent\n");
> +		log_test_result(KSFT_XFAIL);

Same comment as above.

>   	} else {
> -		ksft_test_result_fail("Leak from child into parent\n");
> +		log_test_result(KSFT_FAIL);

Dito.
[...]

>   		 */
>   		ret = mprotect(mem, size, PROT_READ);
> +		if (ret) {
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
> +			goto unregister_buffers;
> +		}
> +
>   		clear_softdirty();
> -		ret |= mprotect(mem, size, PROT_READ | PROT_WRITE);
> +		ret = mprotect(mem, size, PROT_READ | PROT_WRITE);
>   		if (ret) {
> -			ksft_test_result_fail("mprotect() failed\n");
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
>   			goto unregister_buffers;
>   		}
>   	}
> @@ -498,25 +530,29 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
>   	memset(mem, 0xff, size);
>   	sqe = io_uring_get_sqe(&ring);
>   	if (!sqe) {
> -		ksft_test_result_fail("io_uring_get_sqe() failed\n");
> +		ksft_print_msg("io_uring_get_sqe() failed\n");
> +		log_test_result(KSFT_FAIL);
>   		goto quit_child;
>   	}
>   	io_uring_prep_write_fixed(sqe, fd, mem, size, 0, 0);
>   
>   	ret = io_uring_submit(&ring);
>   	if (ret < 0) {
> -		ksft_test_result_fail("io_uring_submit() failed\n");
> +		ksft_print_msg("io_uring_submit() failed\n");
> +		log_test_result(KSFT_FAIL);
>   		goto quit_child;
>   	}
>   
>   	ret = io_uring_wait_cqe(&ring, &cqe);
>   	if (ret < 0) {
> -		ksft_test_result_fail("io_uring_wait_cqe() failed\n");
> +		ksft_print_msg("io_uring_wait_cqe() failed\n");
> +		log_test_result(KSFT_FAIL);
>   		goto quit_child;
>   	}
>   
>   	if (cqe->res != size) {
> -		ksft_test_result_fail("write_fixed failed\n");
> +		ksft_print_msg("write_fixed failed\n");
 > +		log_test_result(KSFT_FAIL);>   		goto quit_child;
>   	}
>   	io_uring_cqe_seen(&ring, cqe);
> @@ -526,15 +562,18 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
>   	while (total < size) {
>   		cur = pread(fd, tmp + total, size - total, total);
>   		if (cur < 0) {
> -			ksft_test_result_fail("pread() failed\n");
> +			ksft_print_msg("pread() failed\n");

perror?

> +			log_test_result(KSFT_FAIL);
>   			goto quit_child;
>   		}
>   		total += cur;
>   	}
>   
>   	/* Finally, check if we read what we expected. */
> -	ksft_test_result(!memcmp(mem, tmp, size),
> -			 "Longterm R/W pin is reliable\n");
> +	if (!memcmp(mem, tmp, size))
> +		log_test_result(KSFT_PASS);
> +	else
> +		log_test_result(KSFT_FAIL);
>   
>   quit_child:
>   	if (use_fork) {
> @@ -582,19 +621,21 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
>   	int ret;
>   
>   	if (gup_fd < 0) {
> -		ksft_test_result_skip("gup_test not available\n");
> +		ksft_print_msg("gup_test not available\n");
> +		log_test_result(KSFT_SKIP);
>   		return;
>   	}
>   
>   	tmp = malloc(size);
>   	if (!tmp) {
> -		ksft_test_result_fail("malloc() failed\n");
> +		ksft_print_msg("malloc() failed\n");

perror?

Probably worth going over all your changes and double checking them, I'm 
sure I missed some.

> +		log_test_result(KSFT_FAIL);
>   		return;
>   	}
>   
>   	ret = setup_comm_pipes(&comm_pipes);
>   	if (ret) {
> -		ksft_test_result_fail("pipe() failed\n");
> +		log_test_result(KSFT_FAIL);
>   		goto free_tmp;

[...]

>   	ret = fork();
>   	if (ret < 0) {
> -		ksft_test_result_fail("fork() failed\n");
> +		ksft_perror("fork() failed");
> +		log_test_result(KSFT_FAIL);
>   		goto close_comm_pipes;
>   	} else if (!ret) {
>   		switch (test) {
> @@ -1314,7 +1385,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>   		 */
>   		ret = madvise(mem, size, MADV_DOFORK);
>   		if (ret) {
> -			ksft_test_result_fail("MADV_DOFORK failed\n");
> +			ksft_perror("MADV_DOFORK failed");
> +			log_test_result(KSFT_FAIL);
>   			write(comm_pipes.parent_ready[1], "0", 1);
>   			wait(&ret);
>   			goto close_comm_pipes;
> @@ -1324,8 +1396,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>   		/* Collapse before anyone modified the COW-shared page. */
>   		ret = madvise(mem, size, MADV_COLLAPSE);
>   		if (ret) {
> -			ksft_test_result_skip("MADV_COLLAPSE failed: %s\n",
> -					      strerror(errno));
> +			ksft_perror("MADV_COLLAPSE failed");
> +			log_test_result(KSFT_SKIP);
>   			write(comm_pipes.parent_ready[1], "0", 1);
>   			wait(&ret);
>   			goto close_comm_pipes;
> @@ -1345,7 +1417,10 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>   	else
>   		ret = -EINVAL;
>   
> -	ksft_test_result(!ret, "No leak from parent into child\n");
> +	if (!ret)
> +		log_test_result(KSFT_PASS);
> +	else
> +		log_test_result(KSFT_FAIL);

Are we losing the "No leak from parent into child\n" especially on the 
failure path?

>   close_comm_pipes:
>   	close_comm_pipes(&comm_pipes);
>   }
> @@ -1430,7 +1505,7 @@ static void run_anon_thp_test_cases(void)
>   	for (i = 0; i < ARRAY_SIZE(anon_thp_test_cases); i++) {
>   		struct test_case const *test_case = &anon_thp_test_cases[i];
>   
> -		ksft_print_msg("[RUN] %s\n", test_case->desc);
> +		log_test_start("%s", test_case->desc);
>   		do_run_with_thp(test_case->fn, THP_RUN_PMD, pmdsize);
>   	}
>   }
> @@ -1453,8 +1528,10 @@ static void test_cow(char *mem, const char *smem, size_t size)
>   	memset(mem, 0xff, size);
>   
>   	/* See if we still read the old values via the other mapping. */
> -	ksft_test_result(!memcmp(smem, old, size),
> -			 "Other mapping not modified\n");

Are we losing the "Other mapping not modified\n" information especially 
on the failure path?

> +	if (!memcmp(smem, old, size))
> +		log_test_result(KSFT_PASS);
> +	else
> +		log_test_result(KSFT_FAIL);
>   	free(old);

[...]

>   
> @@ -1531,9 +1613,15 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
>   	smem = (char *)(((uintptr_t)mmap_smem + pmdsize) & ~(pmdsize - 1));
>   
>   	ret = madvise(mem, pmdsize, MADV_HUGEPAGE);
> +	if (ret != 0) {

if (ret)

> +		ksft_perror("madvise()");
> +		log_test_result(KSFT_FAIL);
> +		goto munmap;
> +	}
>   	ret |= madvise(smem, pmdsize, MADV_HUGEPAGE);
> -	if (ret) {
> -		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
> +	if (ret != 0) {

if (ret) as it was

> +		ksft_perror("madvise()");
> +		log_test_result(KSFT_FAIL);
>   		goto munmap;
-- 
Cheers,

David / dhildenb


