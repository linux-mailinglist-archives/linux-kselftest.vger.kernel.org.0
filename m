Return-Path: <linux-kselftest+bounces-3580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC283C72D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85F51F21307
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B077626;
	Thu, 25 Jan 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FrGw2wr9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513A76906;
	Thu, 25 Jan 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197631; cv=none; b=RxT5Zm/zxst2+2Kx8DntmQjjasamxSNj7BkK5uI8B3/SX2ick4R1OHd+A1Uj/TJEoT4e0CcPmHuLDRkhQVcOjeBl4d8PRqelxjXs2kt8CJ6H+MiU++qlDxH7Yd+RGKNQBBZsdznQjJWrtCXeITGS7Gevm3qdonASgqTu5ryrPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197631; c=relaxed/simple;
	bh=VhAHDNe75pln/83b0IF4gK7LDikmUOQyoWwqkY00mK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2KBc3kkDLFe0oBhQt2gLdwTJemH+gOf2hKn14KDsmfqDNFzDgTT5qaudEb91pODfzj49fwiCO3UZddYicK6TDDfZ2l3qXcTGrt/WcrK69gcqU55RqQMK/L0faA9dqs8q02gAZ2XP5C522ruzSH0tTKA6+/EotWcuQivQCuw4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FrGw2wr9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706197628;
	bh=VhAHDNe75pln/83b0IF4gK7LDikmUOQyoWwqkY00mK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrGw2wr9tOpj1o2El1l4vuB1W314NWo7egQbv93gBtqVgLnN9/8lMnVd5QEISk0i/
	 P+PfLP8Rf5Hs/DWxR8CntipCjFruIfWx4s/9b3OmhDoxgRlwQVzTpdWWU1e+R+nyQE
	 aXoeOEZFU5n6MSvmzYxED9LKOtGTK6bV6SHBXUfvbZJXqWhH8okkJp9pUGGUKrFQqz
	 vMyQtOMGlHzsBAd0G6l4tC6NWDSssISpgeq2vc5wZM3DPhzwZ91tKva1fIguYTAtqj
	 0YHgF9SMDHf7V/s98YMljk1yQh5tpUkoyagRJEuUlXESfzsMMqc+Ek0m7OPQ3ETE4+
	 ru1PKBGXn2I6w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B314837820C2;
	Thu, 25 Jan 2024 15:47:05 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] selftests/mm: protection_keys: save/restore nr_hugepages settings
Date: Thu, 25 Jan 2024 20:46:07 +0500
Message-ID: <20240125154608.720072-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125154608.720072-1-usama.anjum@collabora.com>
References: <20240125154608.720072-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save and restore nr_hugepages before changing it during the test. A test
should not change system wide settings.

Fixes: 5f23f6d082a9 ("x86/pkeys: Add self-tests")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/protection_keys.c | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 48dc151f8fca8..f822ae31af22e 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -54,6 +54,7 @@ int test_nr;
 u64 shadow_pkey_reg;
 int dprint_in_signal;
 char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
+char buf[256];
 
 void cat_into_file(char *str, char *file)
 {
@@ -1744,6 +1745,38 @@ void pkey_setup_shadow(void)
 	shadow_pkey_reg = __read_pkey_reg();
 }
 
+void restore_settings_atexit(void)
+{
+	cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
+}
+
+void save_settings(void)
+{
+	int fd;
+	int err;
+
+	if (geteuid())
+		return;
+
+	fd = open("/proc/sys/vm/nr_hugepages", O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "error opening\n");
+		perror("error: ");
+		exit(__LINE__);
+	}
+
+	/* -1 to guarantee leaving the trailing \0 */
+	err = read(fd, buf, sizeof(buf)-1);
+	if (err < 0) {
+		fprintf(stderr, "error reading\n");
+		perror("error: ");
+		exit(__LINE__);
+	}
+
+	atexit(restore_settings_atexit);
+	close(fd);
+}
+
 int main(void)
 {
 	int nr_iterations = 22;
@@ -1751,6 +1784,7 @@ int main(void)
 
 	srand((unsigned int)time(NULL));
 
+	save_settings();
 	setup_handlers();
 
 	printf("has pkeys: %d\n", pkeys_supported);
-- 
2.42.0


