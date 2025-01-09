Return-Path: <linux-kselftest+bounces-24147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663EEA07F02
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2B3A8420
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC221F8671;
	Thu,  9 Jan 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="SGRjUb+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57719C556;
	Thu,  9 Jan 2025 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444393; cv=pass; b=jzntqlKjtisOSAdU3w1cpNIx+ic8lnarw/hOuw2rVzFjKyM3DKC9SPO7C1asOoEMJ1NU1862YoBP2Fs3klWbmhwfafkDrBylE+zEhTEdCjmQAeuw+onFxcDXucfc4E1Zh7kvVxD/fd8sOV4J0CqN2mclC2dyBkdwZeGITjTITQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444393; c=relaxed/simple;
	bh=KkAodbObtFuwfRBdsRngg593jBONAOLn9IpJAwMbVPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyBaT7iN8iNLnhYV5Le6JOv6aCykalukBM/maBP4TAi9RFB+nokUTGgVzWKg+ASGWIuGSG984uJ8geRJcgTHX0hqD0F/kyWOlcaTe553tJ7tvzMTxYzMA5U23F9LZjp7oHE1PeC/HJR2VEtYZC+mYRb3JU6FYxrbtVr6NAkuqwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=SGRjUb+y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444375; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gCeZlQSBxYxbEofSHyuBmGhzyA3rtzfkyJCo4CBUSewzwXIKBHHWuNlBNtKEo4hcWWDL3aPPdBgjfswYXrGh+Vpg0ilyRmaFA14cICnowljxLE8VS3Xvh8oxvy/QDov97Y6x90/xvXt35VAzugCa7rxPMC3k0NuaZUByza+nfY0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444375; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sNEn0+DKZ9Qi4hSYGXnwr6Bzx8uRu60xvq6lQUh7sU0=; 
	b=kCBh6gBGSAHSrbZ2Ruf6BNKiskGvBVcUyLkauabrNsRRKFwwLnnKbzV7zQQvmEWPxsKaATTLOjG41kyoy7g/ZhoC3lW2U/UCyuj4tS15jDCajgVcJ0Vfnx5Ci/Cn0LpxpooFTkcDKQBOcWcUEOiT2jPPSIrbMA6uCfOrHmxQpJs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444375;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=sNEn0+DKZ9Qi4hSYGXnwr6Bzx8uRu60xvq6lQUh7sU0=;
	b=SGRjUb+yhYnaImCJ1G16kHv9uZN4IhywMM8RR0XaD6Q4mcm8Vga2Wm0qA+M86o+d
	R7+jHZaD7zK1kj/bMiOnNONnDcV6c5RSpT4N+gJmpuM5CKMzuRytfUKiya/2Waxssm9
	etc1MM2baE5Qp3O3p5mJHDj2MIxMN/fFQtCTVAtg=
Received: by mx.zohomail.com with SMTPS id 1736444373227676.4020326211726;
	Thu, 9 Jan 2025 09:39:33 -0800 (PST)
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
Subject: [PATCH 09/16] selftests/mm: hugetlb-madvise: fix type mismatch issues
Date: Thu,  9 Jan 2025 22:38:35 +0500
Message-Id: <20250109173842.1142376-10-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix type mismatch warnings:
  hugetlb-madvise.c:30:25: warning: comparison of integer expressions of different signedness: ‘int’ and ‘long unsigned int’ [-Wsign-compare]
     30 |                 if (fhp != (exp_free)) {                                \
        |                         ^~
  hugetlb-madvise.c:114:9: note: in expansion of macro ‘validate_free_pages’
    114 |         validate_free_pages(free_hugepages - NR_HUGE_PAGES);
        |         ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/hugetlb-madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index 43f16c12c8e9a..8f527084858d0 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -26,7 +26,7 @@
 
 #define validate_free_pages(exp_free)					\
 	do {								\
-		int fhp = get_free_hugepages();				\
+		unsigned int fhp = get_free_hugepages();		\
 		if (fhp != (exp_free)) {				\
 			printf("Unexpected number of free huge "	\
 				"pages line %d\n", __LINE__);		\
-- 
2.39.5


