Return-Path: <linux-kselftest+bounces-40816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C789B452C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173423A5AB8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CCF28A704;
	Fri,  5 Sep 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMODJ+pJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC9308F17
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063483; cv=none; b=qhMHxGK2p6dDfx9WYmHe4+ZY+LuYh3iKGD8VfoZOCqyDZXSemUjAswwMf26S5pRDIGfifsn5WH/+Z5E0DNy2sydxTMURlH2kP+uFMiGInBiJIvWBK5ryk5mPiTqSsVj0EdLk8b78sxnnYSH4jLutRIG3C4ExuRQCDBNxiJxWADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063483; c=relaxed/simple;
	bh=SlZ5pxKsFZ4zQcY7fmqaUER4enHweRQi28dFaXZPG9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyTUpzxkPJwFiP1+BPJqZqrlgu04KrUqlvqNSiyZMLlcTriWj3uTWtyBfpcAHhJQKGsAHo15/K/KotDs7tKnl/h10DPqc1gDaX3+Pc3LKaS3kg/l5HwHqwdKs7AN/Ikxp4e9L97/kmBscXG/hpEzgApY/rf0FRByz6ETQcKqJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMODJ+pJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4f8bf49aeaso1609753a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Sep 2025 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757063482; x=1757668282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlGG8iiLjAgEhLCZ5aniw1KKqM9ZJMnfWAApeRI+6ec=;
        b=eMODJ+pJDa7D9oiaKhNFxYTRfvKAkHPd2/o5RQCfVby9dl2sUnNtdKvKe2FTNTt9CZ
         98Bs9pSRBlxidoI9ss5qW7H7HbHqiw8IgxS1mh1/hkJf8N7hXNuXI2PF93/o1kkwlVYY
         uLJdrzaBQk0sPUxc7Dv7hKwdkBYdnLzG5iKk+B99u3Zn8pwzKYHcY4kwxWf18RFENVW0
         9QaW8TCJQX7/05ZKaxBg0wRGJG6X0XXS2rxCzaDTVyHwCYc5g0als6hq+3NXoe7+MMWN
         LNYXdNGqadLyfBJ2Cvv2KiN8V6yYA9XOQs0R85iNX8oGkbL1QvV8Yy8Wua/S6nEQcI3n
         I9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063482; x=1757668282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlGG8iiLjAgEhLCZ5aniw1KKqM9ZJMnfWAApeRI+6ec=;
        b=lHbkxBQY3UItnt6h92WYbSZzncU0To2bDuPnll1qLPuArl9kjt7lgw0g6VggP5JPAp
         8Sxtl/VEDKwfrw8OOMAkRWn3hwozVzCQNDu8q+4AZDHIhHBzMySKojTQsqhItoMZhsNC
         z2l52sB7DnmLRrbK34x4v4XsFjFzGJpx698/sLaEXp3l70YlZ2M5MVWKFC6KSL6LRJ5a
         hREn6tKhogKQZHocR5aU+jOTQUm7dNxLiQXANAnwqfdHkACpvPD3pYCmmcIaMVpAzyDo
         MdLnU8VjxVY+gVL92eHVEBasJbqniAyY92GzIWPDl65oF6nnIJp8eqkeXx0d4196mQkF
         UYvg==
X-Forwarded-Encrypted: i=1; AJvYcCUF/H6n5BjKiCUVDl5OB9SLCJH5bMlOG++T1I7XuCtoqgNetCtoPTYiSxSrU2xYywMrVb/aalTEOqLNXoI0RSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUAY4zrQEX5l+eRp1UaUqJVV+aeYb+ZtsOap7JWiqu65ULw/J
	AYR9mBhYLAcsQ3buxsytS9swwsRXVTEGT9WKfJZ9s8wqGpT8cI07kkwx
X-Gm-Gg: ASbGncvUnzWNb7gkfHnAUBxKAGYfAfvvGhCecSHncjTx+okIWJvfiQTg3ym2KYfv/S8
	7AGducpn+r4ZtP9gKIs1Cr7/IGI354EWmntXtyPPOvJtFrihUGrYhDgCvnhVsVqSQHeIa7nsgh2
	n8vCKWrnxo7OSmnLWiGg2ip8vR14n9a+v6Hy8KpI9qg4MK+jIgjcgcz4hyzPOpx1VrVjv5wFf+B
	gRxtNiGMe+86ZpZaW6Ye4N4Je/PncPm2DrfuIKUi/Mjl71b1BcIecDgiy8Qg9/sLrMm9F6NRjwv
	u/ftBKlutiRvhOBUCqlJ7URj+eAh9CQACKX+67Gmk3hdAoIXxwP+MeLPkA+6lDzz7FD1hykh7I5
	ddSDx6LCLjf+t/cDkStaMpLUI0x+0wX8bQYYLlS+o8VUsm4JsUhGBQIQCuBW8Xk9AvCRlZCfe0W
	fAsA==
X-Google-Smtp-Source: AGHT+IE82S29cgshAHVDQSgk2SXvBJzbM4szgZ9lovhGnhK7RR2Eatj8DsSh0hxrXAeuoDMb6cbafg==
X-Received: by 2002:a17:903:3c45:b0:242:9be2:f67a with SMTP id d9443c01a7336-24944873f96mr300977675ad.11.1757063481583;
        Fri, 05 Sep 2025 02:11:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:32e7:81b8:8974:3701:d82:56ac])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648d67dsm209318045ad.108.2025.09.05.02.11.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 02:11:21 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: richard.weiyang@gmail.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	donettom@linux.ibm.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH] selftests/mm: refactore split_huge_page_test with kselftest_harness
Date: Fri,  5 Sep 2025 17:10:29 +0800
Message-Id: <20250905091029.81259-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250905032431.22179-1-richard.weiyang@gmail.com>
References: <20250905032431.22179-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Refactor split_huge_page_test with kselftest_harness, since there is a
> magic counting about valid tests.

> The idea is simple:

> For standalone test, put it into TEST().

> For tests iterating order/offset, define fixture and variant with
> order and offset. And skip it if order/offset is not valid.

> No functional change is expected.

Sounds good.

> -static void split_pmd_zero_pages(void)
> +TEST(split_pmd_zero_pages)
> {
>  	char *one_page;
> 	int nr_hpages = 4;
> 	size_t len = nr_hpages * pmd_pagesize;

nr_hpages and len appeared many times and 
david use nr_thps and thp_area_size rename it.
and maybe we can unify it and make it into FIXTURE and init.
 
> +	prepare_proc_fd();
> +
>  	one_page = allocate_zero_filled_hugepage(len);
>  	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
> -	ksft_test_result_pass("Split zero filled huge pages successful\n");
>  	free(one_page);
> +
> +	cleanup_proc_fd();
>  }
 


Best regards,
wang lian

