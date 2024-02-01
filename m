Return-Path: <linux-kselftest+bounces-3938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AB1845866
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 14:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8332875B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD253376;
	Thu,  1 Feb 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jt/4NHVe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B261253365;
	Thu,  1 Feb 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792742; cv=none; b=ls9JP16NYbQe/86uv/y27TINz6a3AN75rmQQmyHcKGcxokk4CwZNogo7lXQp4P07D+2osok9wGcJ8MuisHseuzA3Mj7f/EiQ1nNBCG1f3Vi5C1B3JMpXc1f5MG0dJjs0w4QlEsFWGFqlaDUqiifqCTMYcVdRadEVQ2HxYuetX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792742; c=relaxed/simple;
	bh=/MVnfk7AH4h6a4QWSYQJHX+ejX6+Vh4/dMORXjSgQU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baGE7f0V1c52WKzUMnwEuV1wMARkQOq0SDXRfro/oMrfSUYuR5iWdQrD1JqVU3zwzmiii/92X2XTriSxz8+/C+XjPs0+X9tF3JhUCek2i2etaT4FIzzapOkxbrfrsUWU1liv9DnLOJBLHtPuss8isMwsiF4AbduiDOAaYRVj6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Jt/4NHVe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706792739;
	bh=/MVnfk7AH4h6a4QWSYQJHX+ejX6+Vh4/dMORXjSgQU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jt/4NHVe/eHjQOovfkzSj8baPCTpY78dmgFcjqjUcSXuiP6HHE06v7rm8fAbqxHKg
	 5k41CAryBdxKya+QjkFmLw7IWZoD70GoqbS7b9dV11H0yUoVTiKENm+Dyu1AV/z1jt
	 wzKOcJmb0RF94Sr1VANtHgYPr62sdIlk2OVYjC+6NQYoz3kW2oafxwXMd4Oxpj5xIT
	 A4Xe8Nf9KpJCe/HVG8td8Y6EReEUgF1gBXcSn+j1gJB7oeZJrU0VGXela+rwJIB3+0
	 T1NkLdmn7k0ljjHI0ezSUpbtn+Z4j0J3KsT1XBVwAzu758rLHJ0Jmnu1wodLbYgG31
	 AyLGaaIqrgiWg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 577DF378208C;
	Thu,  1 Feb 2024 13:05:36 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	ryan.roberts@arm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/mm: run_vmtests: Use correct flag in the code
Date: Thu,  1 Feb 2024 18:05:37 +0500
Message-ID: <20240201130538.1404897-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240201130538.1404897-1-usama.anjum@collabora.com>
References: <20240201130538.1404897-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use correct -d flag as mentioned in comments for destructive tests.
Rename variable and update comment for some clarification.

Fixes: cc7b9955344c ("selftests/mm: run_vmtests.sh: add missing tests")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Please fold this patch in the Fixes patch if needed.
---
 tools/testing/selftests/mm/run_vmtests.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index edd73f871c79a..99734a2a091b3 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -15,7 +15,7 @@ usage() {
 	cat <<EOF
 usage: ${BASH_SOURCE[0]:-$0} [ options ]
 
-  -a: run all tests, including extra ones
+  -a: run all tests, including extra ones (other than destructive ones)
   -t: specify specific categories to tests to run
   -h: display this message
   -n: disable TAP output
@@ -80,7 +80,7 @@ EOF
 }
 
 RUN_ALL=false
-RUN_DESTRUCTIVE_TEST=false
+RUN_DESTRUCTIVE=false
 TAP_PREFIX="# "
 
 while getopts "aht:n" OPT; do
@@ -89,7 +89,7 @@ while getopts "aht:n" OPT; do
 		"h") usage ;;
 		"t") VM_SELFTEST_ITEMS=${OPTARG} ;;
 		"n") TAP_PREFIX= ;;
-		"a") RUN_DESTRUCTIVE_TEST=true ;;
+		"d") RUN_DESTRUCTIVE=true ;;
 	esac
 done
 shift $((OPTIND -1))
@@ -323,7 +323,7 @@ CATEGORY="mremap" run_test ./mremap_test
 CATEGORY="hugetlb" run_test ./thuge-gen
 CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
 CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
-if $RUN_DESTRUCTIVE_TEST; then
+if $RUN_DESTRUCTIVE; then
 CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
 fi
 
-- 
2.42.0


