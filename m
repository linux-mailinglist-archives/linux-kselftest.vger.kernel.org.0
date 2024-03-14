Return-Path: <linux-kselftest+bounces-6325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A187BCB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 13:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27341F2235F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53736F535;
	Thu, 14 Mar 2024 12:23:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783736F51A;
	Thu, 14 Mar 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419021; cv=none; b=StM5sF+j9h8u6CR4sWdUFuL6dOMqqUeS/wRD6D66nODKCbBkYvQVIFU833LfT8mzX8uCakXqEr9pksWAJaU5VujR+D4AAHh8SAVLN31r5Ni7N7eumXmv0GzZCHg1c1gguxjmy8VcWNdu5ckibOcUJwrjdTE+IC60Zrt3PLp7Shw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419021; c=relaxed/simple;
	bh=lYUcSfHE+Q8ifZotzLipusX7K282QRZ2Go0JFtIPsJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJVKFBZaLUWupSGup6V+2QHSlzNSusrQZ74TZOtCq8bRYkF4tWaZ/5Z0mA0nQWZEvBtO1DLatD3uFWd+fPsK9X2qaew8EkiyVvpSHFxGYtFIJaHArAH6lhAL58DmSOJosxZGnhLlsaqUb2oNCk6by7UEdpg7xjK9nnMXK5p+4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E187F1007;
	Thu, 14 Mar 2024 05:24:14 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4F533F73F;
	Thu, 14 Mar 2024 05:23:35 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: usama.anjum@collabora.com,
	akpm@linux-foundation.org,
	shuah@kernel.org
Cc: dev.jain@arm.com,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com
Subject: [PATCH] selftests/mm: virtual_address_range: Switch to ksft_exit_fail_msg
Date: Thu, 14 Mar 2024 17:52:50 +0530
Message-Id: <20240314122250.68534-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <07e2e91b-7b0d-4810-a2a1-ed4654ecafb4@collabora.com>
References: <07e2e91b-7b0d-4810-a2a1-ed4654ecafb4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmap() must not succeed in validate_lower_address_hint(), for if it does, it
is a bug in mmap() itself. Reflect this behaviour with ksft_exit_fail_msg().
While at it, do some formatting changes.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 7bcf8d48256a..426ddfc345fb 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -85,7 +85,7 @@ static int validate_lower_address_hint(void)
 	char *ptr;
 
 	ptr = mmap((void *) (1UL << 45), MAP_CHUNK_SIZE, PROT_READ |
-			PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		   PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 	if (ptr == MAP_FAILED)
 		return 0;
@@ -105,13 +105,11 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < NR_CHUNKS_LOW; i++) {
 		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
-					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 		if (ptr[i] == MAP_FAILED) {
-			if (validate_lower_address_hint()) {
-				ksft_test_result_skip("Memory constraint not fulfilled\n");
-				ksft_finished();
-			}
+			if (validate_lower_address_hint())
+				ksft_exit_fail_msg("mmap unexpectedly succeeded with hint\n");
 			break;
 		}
 
@@ -127,7 +125,7 @@ int main(int argc, char *argv[])
 	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
 		hint = hind_addr();
 		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
-					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 		if (hptr[i] == MAP_FAILED)
 			break;
-- 
2.34.1


