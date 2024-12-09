Return-Path: <linux-kselftest+bounces-23061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5320C9E9EB5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E75B1600F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6119E99A;
	Mon,  9 Dec 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Y90OE4mV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341219882B;
	Mon,  9 Dec 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770615; cv=pass; b=e8TEf36pZK9oLMZuy7312DKmzB4WMSNSqCOwWVO35Jvt+xd6HVIFK9XK0ZeE3k0iYNogAEZxY8W/6aLPavpiO+/8rCe5msYuGAJbj9BGmDG5d9PwbmcIZ4mD6v3Vx+KtWNeohKl/SekzmuhBGKK6czRhRp6zzQxm+vwcx21kD/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770615; c=relaxed/simple;
	bh=3relNmZtyxy5E34BIXCkjF6j9XsDWsCEZwkfMcoYRyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqETcQHmVFuH6EOfpfRqXH4b0h504K0q6FnWTV6urfFkBmEAHqPNe7ayGaOYyhPgCaMlSG1Ms71UYO3pLeLIGQ/QQXrCoLCr3CXjMpxLgH2qXjffrCN53DYghVjBx56K1hocFwPY+WYJSy1Qb473vytlsyYBsBjDzDe2bTpb8BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Y90OE4mV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733770597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RjOhkKQL1I0ZoRri8DBlSn6/WZHwpyl500sYUpzR1zUxcT5VyAu44vbwDPBR/tdyey29SP3a/Y+ZrvbVTiV0pJi/Ic2+CcrfFldjqD24PV7qI+411XfUxa8EPUlKN00Fg2rA8tuSJ+K3eIUuA5MH9tqqYwZ1OVXd2E+4b4Au6Gg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733770597; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UCUyWepyHotuSHog4wQxtOXcYGnVWgzvFlwrr2hbZtY=; 
	b=PCzaPWQE4/KHetJ4fD+Nq7FSo2Kxsf0flxCBUTg3sAmSN/G9/JAAM5xaGdlCJKrFDu49nZH8m5qEdBzNNByajn2laqX5y0vba2jEh6Q0aCMLus0U1cPwZ1u7YNSQuu5x/pynE7NNhRJOOjfjjOZH2jDvf3Sd9jxOhFsPkmP6CCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733770596;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=UCUyWepyHotuSHog4wQxtOXcYGnVWgzvFlwrr2hbZtY=;
	b=Y90OE4mViAeVkzbbCQ+v8pzdjHBzPVEfGFSDQZdffEn/kPr4TGm7A2jtnBd1m8un
	9KH9iKCaYSNoigtyKpTHuFK5JsoBh4KTDZKJ9TCwYuDZjkbLAq9y5K54Wd770Cigj74
	JN/2EJhKdLIGIKkQOItNPv363aUi9FJ1Tb3WxjZ0=
Received: by mx.zohomail.com with SMTPS id 1733770595734477.42886681047787;
	Mon, 9 Dec 2024 10:56:35 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 3/4] selftests/mm: mseal_test: remove unused variables
Date: Mon,  9 Dec 2024 23:56:23 +0500
Message-Id: <20241209185624.2245158-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185624.2245158-1-usama.anjum@collabora.com>
References: <20241209185624.2245158-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix following warnings:
- Remove unused variables and fix following warnings:

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/mseal_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 01675c412b2a8..ad17005521a8e 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -802,7 +802,7 @@ static void test_seal_mprotect_partial_mprotect_tail(bool seal)
 }
 
 
-static void test_seal_mprotect_two_vma_with_gap(bool seal)
+static void test_seal_mprotect_two_vma_with_gap(void)
 {
 	void *ptr;
 	unsigned long page_size = getpagesize();
@@ -1864,7 +1864,7 @@ static void test_seal_madvise_nodiscard(bool seal)
 	REPORT_TEST_PASS();
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	bool test_seal = seal_support();
 
@@ -1913,8 +1913,8 @@ int main(int argc, char **argv)
 	test_seal_mprotect_partial_mprotect(false);
 	test_seal_mprotect_partial_mprotect(true);
 
-	test_seal_mprotect_two_vma_with_gap(false);
-	test_seal_mprotect_two_vma_with_gap(true);
+	test_seal_mprotect_two_vma_with_gap();
+	test_seal_mprotect_two_vma_with_gap();
 
 	test_seal_mprotect_merge(false);
 	test_seal_mprotect_merge(true);
-- 
2.39.5


