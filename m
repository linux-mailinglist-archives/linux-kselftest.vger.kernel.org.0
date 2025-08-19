Return-Path: <linux-kselftest+bounces-39296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC542B2BB53
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 10:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1B21BA6A0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E23112C2;
	Tue, 19 Aug 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1n5rJE7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D7B3451CD
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590485; cv=none; b=l41nfiZE28bhwJHV68B0qWeHZgP7dv4qgyk+6jbzEydD4GOi12isqDxVge6V11GQjNS7b3DWnVbl5h7y9ACgApW9BSN5UUl5eSojOK5gTGPzrdVB8snJJLazb/mHAlpvwD44LWuurgkWce3JfT5CZ3fKHBpC6I9GRWQQm58Ut84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590485; c=relaxed/simple;
	bh=2/TaWURSZi6hSZOgfUnwWw7rv34NCfJWsFK59wIgsbs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aKMs+m0HfXmVcEdTvnjnTl2YxJE+IjrRBDMohyGy7imrX3j9j8uEHo3M9LqNAI8Q6El/s+4ZHzYNL/YguxiY+QdGhueanO5IP/0Ts4O4KDXzZXpP+9pxHvR0T/wJpivQ07hMILvO76xHkkjPZgZ86JxdJm5Dtl/4YrKZXQSN6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1n5rJE7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78ead12so705009266b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755590481; x=1756195281; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NttAVGS/kcZ6hlvGlfVRJ78tj9AfbuwLK6+h4J2zKbY=;
        b=H1n5rJE7YmZEXxgxRUW9lsJYCZSPiqIHB3fzw3MBFHrDO4RAKbd0Ez1W4g3560+xlm
         LiLlWdBS+uxlkonkriTRtuSxGbf5hW1aZdvU68in/w24uXuirOgrQEw7e4ni9vefC295
         T4bGy/qKvjron/IhVOGJR+rFGvvggFrYQU+zPh2LQLrU9oG9bpvcJMDVVsxOzU41R4yK
         6XJecQWXn4Hd1LGq2PvVJ0yNO9cFf0jt84nvyF6iJ/bLg+jHP29eJqqwImf/TKy1e9Cp
         u5E6HZLXRHtaKklHPc/WxflQKMpRPmElLdNmz7P2M3TPv6ew6hgwWcCbgye7CSbTBmZ9
         buGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755590481; x=1756195281;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NttAVGS/kcZ6hlvGlfVRJ78tj9AfbuwLK6+h4J2zKbY=;
        b=KpnP8dNLmFk9CBblrZd86Mlz4q44s1OyQQU77/mImkaaf/bE1/+hp3zEhl/RdM+lSp
         NE39h7y4YPqyc906UyGsQ0sw4+AY0aJpxCp/8obe8pNb7iRG9rGIdPFhZgCSku75C8HN
         c7FyqOEbjogmbZnyuuh8PPbyygB7kL3nfooiS4S1ny9q1u8+4zVkAz3GWwCcDc9+gKx0
         7dSi/XZoxDIITlX4MXEimo6hONzcxqZhTW+T686UwbeWZ8hh7im42pPQIhHgeJcbvYaM
         bzY1CntBhq44AEDBCKH5BzONrlThrDPG+BkXfYLU7mmbb2agG3nhngCNkgMfMdfcVeqM
         MTfA==
X-Forwarded-Encrypted: i=1; AJvYcCVm0U6K5oiV/vbx8MLZpS+g+M29KH/CAwlKqnqPNPTTk0w7fx3NwfXBpY5sRveBykUwnTgB+ZgsczO5BTj/WqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6uJzVHRvCBxiB4x8nnbE3QTH3mz0GhhqlHXCQrk0a+GZwWOK
	Zm9g3mU0TjJAMigCEfiyPpaWfe+E663Uc6h8M1+ie6ZN7wR0khq9jjYg
X-Gm-Gg: ASbGncv7fFRc7gADqbNKZSKC1drO/kUN4rKvIrH38+45+H8JUsrPhfRcFIqyCum7bXf
	6q9G0bB8HBd3Y24DBu4EAe9eLF8S+U4fAO9HA7VuililBFQvNn4k31AiXrn3qfLX3K3+G2/kG6k
	bHcEeRLPCsTYAwS6aWM2CYeuqP8TAzL4BOtOPsb8E7UgUD4apc0mk97dMEA0/u8+uEKPUYaikCE
	ZaYxFA5Vdu5vystbxHSFScP3QpjQtoeuDCpjg4wkSyx+D35GhcHRVmy9dG9Z36gCFRgkS7U1PFk
	zcBfvAZ5BKQM0738d3sCWHijbis4i6YAvL9MwO7vhr5oaykgZncH4RRfpzIZsJfPzAVtDSYaUCB
	fb6L0B6Pee7YKScWQbRJRiQ==
X-Google-Smtp-Source: AGHT+IHfZ4gJXCV35zyoWZxt1c6c/l2A0KwHyNY18HT54S89W2xNZNz3Owx4pMwREM3jmcHj38yfLg==
X-Received: by 2002:a17:907:3f21:b0:af8:f9e8:6fae with SMTP id a640c23a62f3a-afddd1fb9e8mr158328466b.46.1755590481381;
        Tue, 19 Aug 2025 01:01:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53f49sm961046466b.7.2025.08.19.01.01.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Aug 2025 01:01:21 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	riel@surriel.com,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v4 0/2] test that rmap behaves as expected
Date: Tue, 19 Aug 2025 08:00:45 +0000
Message-Id: <20250819080047.10063-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

As David suggested, currently we don't have a high level test case to
verify the behavior of rmap. This patch set introduce the verification
on rmap by migration.

Patch 1 is a preparation to move ksm related operations into vm_util.
Patch 2 is the new test case for rmap.

Currently it covers following four scenarios:

  * anonymous page
  * shmem page
  * pagecache page
  * ksm page

v3->v4:
  * rebase on mm-new(dd1510cefdfe)
  * "assert" -> "test that" in subject
v2->v3:
  * handle ksm error return in worker
  * rebase on current mm-unstable
v1->v2:
  * do check on file opening in init_global_file_handlers()
  * factor out ksm_merge() and ksm_unmerge() instead of partial of it
  * align the return value of helpers: 0 on success, -errno on error
  * skip instead of assert if numa not available
  * check ksm sys file before continue
  * use private anonymous map instead of shared map
  * check pfn instead of content
  * retry migrate
  * fault in region for each process by FORCE_READ()

RFC->v1:
  * open file in function itself instead of pass fd as parameter
  * fault in the region by accessing it instead of print content

Wei Yang (2):
  selftests/mm: put general ksm operation into vm_util
  selftests/mm: test that rmap behave as expected

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   3 +
 .../selftests/mm/ksm_functional_tests.c       | 142 +-----
 tools/testing/selftests/mm/rmap.c             | 433 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 tools/testing/selftests/mm/vm_util.c          | 123 +++++
 tools/testing/selftests/mm/vm_util.h          |   7 +
 8 files changed, 596 insertions(+), 118 deletions(-)
 create mode 100644 tools/testing/selftests/mm/rmap.c

-- 
2.34.1


