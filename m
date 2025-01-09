Return-Path: <linux-kselftest+bounces-24137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA56A07EE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B293816844A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E3A18FC90;
	Thu,  9 Jan 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="NiVeLQGH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0D18DF73;
	Thu,  9 Jan 2025 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444347; cv=pass; b=dd5uyFWbrQjDkKltbrLGEQj4ftoGH9mk0si133S9A/47zT+xz8cwfkPmGaO2vL7yku/4NQ5V4Y5jccZVsh5tn/VNhcAI9rTsR5uileKkgUCTx/d0ozWtb1S1CG5r0PxcfUex4Ysih8+9UQPTZgfYvxjIEEPBiHlNl8k00ZAfdtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444347; c=relaxed/simple;
	bh=mJjykTyPuB2tvi48HF5lkznPMZJsCd+GQDPU7snsalE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uNbdo8xbwN39vVseqZW694yzBJ1JYAcZ0esSMs3feNvD07yRoQjEEF2T+sShNY2f8LfZZguckJQMmQT2fTuvv14WRfOG9VZoqDg+a7vx2Iq+nFlIOGlr2yzHBavj4+gM6viae8j9q98jHBCCmcg5RZKCS/+vFB3zakyef7EUr+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=NiVeLQGH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444329; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X7gvn2H6vDyOWcB530rjEqr6sOydURpP3fosCAB+9Ev8YV045RZJiesbllY4Wp5xHoM6KE6quLRf0lRgrL5QOOj6Ff8O2WnIPDANlEvRoEyWbcKvZ5oCdZdefXqNDByF5WRXaR8B5syFAw3sV8T1KLPs5C5eSAI7EVsko3dcwtE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444329; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E5lvGfPhJCrdgpWIOv0+xLeRXWy6owHBeDWNShBCLX0=; 
	b=bku0ZbP8Cibt2Cyd1MLafZYWs8tdW8kn9WGhRxpsK4Rr4pVhXz0uGNqZlvNuEbtfV2yHV9pD0zU6j9Q9bH/zDZ/X60qVqJQy4Lcbv9uGVvAS2Qdq3GRLqXZ6dDvpHRRy7vrnRiP2uKWpf9wD+v9RRoW9AU2Ti37Jlhgf66EuEGo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444329;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=E5lvGfPhJCrdgpWIOv0+xLeRXWy6owHBeDWNShBCLX0=;
	b=NiVeLQGHhJ+U+92e4jJ3RYo8fjFBggJiQ6ov5OS3wKMoYfiE6uMOvznhO3/YU0Zf
	9zY0j9EMOm4yVA2tNfTr/UCNZ6Vdgm1vnGQ79BCb03N34tru0A0TywU7UIickJKl0/u
	8ayGCsxeTyUZUyPflXPyOmTgjvaIkWNcwZ9JgEYs=
Received: by mx.zohomail.com with SMTPS id 1736444327359273.5270312514208;
	Thu, 9 Jan 2025 09:38:47 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 00/16] selftest/mm: Remove warnings found by adding compiler flags
Date: Thu,  9 Jan 2025 22:38:26 +0500
Message-Id: <20250109173842.1142376-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Recently, I reviewed a patch on the mm/kselftest mailing list about a
test which had obvious type mismatch fix in it. It was strange why that
wasn't caught during development and when patch was accepted. This led
me to discover that those extra compiler options to catch these warnings
aren't being used. When I added them, I found tens of warnings in just
mm suite.

In this series, I'm fixing those warnings. The last check adds the
compiler flags with which the warnings have been caught.

Muhammad Usama Anjum (16):
  selftests/mm: remove argc and argv unused parameters
  selftests/mm: Fix unused parameter warnings
  selftests/mm: Fix unused parameter warnings
  selftests/mm: Fix type mismatch warnings
  selftests/mm: kselftest_harness: Fix warnings
  selftests/mm: cow: remove unused variables and fix type mismatch
    errors
  selftests/mm: hmm-tests: Remove always false expressions
  selftests/mm: guard-pages: Fix type mismatch warnings
  selftests/mm: hugetlb-madvise: fix type mismatch issues
  selftests/mm: hugepage-vmemmap: fix type mismatch warnings
  selftests/mm: hugetlb-read-hwpoison: Fix type mismatch warnings
  selftests/mm: khugepaged: Fix type mismatch warnings
  selftests/mm: protection_keys: Fix variables types mismatch warnings
  selftests/mm: thuge-gen: Fix type mismatch warnings
  selftests/mm: uffd-*: Fix all type mismatch warnings
  selftests/mm: Makefile: Add the compiler flags

 tools/testing/selftests/kselftest_harness.h   |  6 +-
 tools/testing/selftests/mm/Makefile           |  1 +
 tools/testing/selftests/mm/compaction_test.c  |  4 +-
 tools/testing/selftests/mm/cow.c              | 48 ++++++++-------
 tools/testing/selftests/mm/droppable.c        |  2 +-
 tools/testing/selftests/mm/guard-pages.c      |  4 +-
 tools/testing/selftests/mm/gup_longterm.c     |  5 +-
 tools/testing/selftests/mm/hmm-tests.c        |  4 +-
 tools/testing/selftests/mm/hugepage-vmemmap.c |  5 +-
 tools/testing/selftests/mm/hugetlb-madvise.c  |  4 +-
 .../selftests/mm/hugetlb-read-hwpoison.c      |  6 +-
 .../selftests/mm/hugetlb-soft-offline.c       |  2 +-
 tools/testing/selftests/mm/hugetlb_dio.c      |  2 +-
 .../selftests/mm/hugetlb_fault_after_madv.c   |  6 +-
 .../selftests/mm/hugetlb_madv_vs_map.c        |  8 +--
 tools/testing/selftests/mm/khugepaged.c       | 16 ++---
 .../selftests/mm/ksm_functional_tests.c       |  6 +-
 tools/testing/selftests/mm/ksm_tests.c        | 17 +++---
 tools/testing/selftests/mm/madv_populate.c    |  2 +-
 tools/testing/selftests/mm/map_populate.c     |  2 +-
 tools/testing/selftests/mm/memfd_secret.c     |  6 +-
 .../testing/selftests/mm/mlock-random-test.c  |  6 +-
 tools/testing/selftests/mm/mlock2-tests.c     |  2 +-
 tools/testing/selftests/mm/on-fault-limit.c   |  2 +-
 tools/testing/selftests/mm/pkey-x86.h         |  4 +-
 .../selftests/mm/pkey_sighandler_tests.c      | 21 ++++---
 tools/testing/selftests/mm/protection_keys.c  | 34 ++++++-----
 tools/testing/selftests/mm/soft-dirty.c       |  8 +--
 .../selftests/mm/split_huge_page_test.c       |  4 +-
 tools/testing/selftests/mm/thuge-gen.c        | 10 ++--
 tools/testing/selftests/mm/uffd-common.c      | 24 ++++----
 tools/testing/selftests/mm/uffd-common.h      |  2 +-
 tools/testing/selftests/mm/uffd-stress.c      |  4 +-
 tools/testing/selftests/mm/uffd-unit-tests.c  | 58 +++++++++----------
 tools/testing/selftests/mm/uffd-wp-mremap.c   |  2 +-
 .../selftests/mm/virtual_address_range.c      |  2 +-
 36 files changed, 180 insertions(+), 159 deletions(-)

-- 
2.39.5


