Return-Path: <linux-kselftest+bounces-45176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C532EC42FBD
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B45F74E322D
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9ED20102B;
	Sat,  8 Nov 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpn239pY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF901DF980
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762618727; cv=none; b=LaF6spaohDhD9SkKyubO7MkU3ibDuoJNEYqXl29olZK6Jmq1ACmY0Rw3h0iJz8AYW7Nnbx/4TNhPrkBTecqIAtW1UKbRzWHRsSM9vhSxySeWTZkmh4cZBRD/l8sJvfozFWzWNsrybHT0lVG6ql1UxheAYcf4yf+qYj31CmsDP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762618727; c=relaxed/simple;
	bh=kHu9xb/m8OnJFaZlkDBT3bgLQ5H4ttZWM1JNTx18jJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSqg0FljVwo4bINZzo/JmLMMB0I1cvuE39Gm0Fboc1q1Xu8II6CldTtqGF1p47Lv3WnAMV+tSFlr9uufbmaoeS4rCUkESBE8LhnrGI6nhoAvAVx+YCEt6ASBd4PMw3B+I5ha+SlHZ2iJTA+fYaMFfyysdsUJNEjWi4Gmc+S7WYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpn239pY; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3436d6aa66dso482264a91.1
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762618725; x=1763223525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vBksDJnztjGyjVxw8Yb9adtDqx05xzbEcYJxzPS4MU=;
        b=fpn239pYXOa9vag6ACQ8g8FLe5tAmuZtIDOLUE447d91G2vzz4ds/40s6eS6jI6Mvv
         U5pmIySrIXbaa0qNffFWigx2i5QjDddUNLUtsKGUXAa6rxBGUZ3Mm+kJ2x8IGFVWJ0Ho
         yWlxmhcJwvPf8PfHdWSsDlY1DOoTTQsL1kp0FM0UZRiSw4khDwlMNp/GLpFoKIZ3h4sl
         HHgr1WcJeBCjB2AYHB5r3xGTUsxp4yxhW9qOw/YQKSIQdGfDb9aurJtk842zd5pRJYj4
         Un87CRh/NVmhMPjOFVt66hx/WR/SSoh5cTYBwAkL69lHUBsZa+zKauyZEg8meBYwp5aB
         XByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762618725; x=1763223525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vBksDJnztjGyjVxw8Yb9adtDqx05xzbEcYJxzPS4MU=;
        b=lHgvoyFI8XpABaNkJO/WBwynbwL4k8L7lXs7vvY+QaDdDCFgC2r3IPkc9Ez+gCmW7T
         i5XHXImEyQRuApYda+BJr+yUxx+7LaBQ9JaxyxmMbB4hMIDxIQvb1aFHK68DntMUeSvT
         ov4Cq7gBBO2scJPlKWyII3P2ipiGJgELLwdmN4bcas+AlKA6gvhtW+xbk8+LhlRF2Jqz
         vnWhGYjyOIydGnLP3iXTxHgkg/9CU5Nm7cH9tuOP0WcqJQOqPocbklNC7TmcFz2wUtDo
         y2lhlMoio5PN4hNuuRnljR2uxGzRaBAXMPHFqDU4AXHtLfJ3Jj8UlY5c6WfK2SuRHGco
         cYbA==
X-Forwarded-Encrypted: i=1; AJvYcCVLLzHzdUvJ6YG2/LY2bW0zZVUe2MRS/OE379z78612etS4csZBCcQkjQk17EDQh7S/k8oDbJyXSPrV67TilK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/RxGFUIaaNcqBtuEJr/tVHTzOSDoAde8ctWh8xIQLSTtG9Sc
	Uav8a8LwxEX5lXutc+lvtMitgDRNGa4S6ZIY4iLr1v52w5+a5hF8Mo/x
X-Gm-Gg: ASbGncvd5ohhluKm5xDBwjdYI+/ytunybZdfcyEdyS1a2V42CT7qcP9u0xoIWY0rAEE
	rVVOjO0ZTAqyhGyrS+7v3ikrxxuol1x1AROeFGpufN9u+yyVk4QgQEcRWxB4zf0rYdnbkYnQ/qP
	pjXfJVcAoMlFiu/rxWpiWE41jZhsiw/6sQ57CNViC+ToRZTOC8b84msLY2Gr6pO2Ak7pi0giBEr
	LINE/dR5m2upnaV3hzl46baQCCg6t/QsIc3lsx6WEayGlcSgXx0pY6f9FIohySzajHup2bWCEuN
	NCp4sLxClim1+Oq4DFbDHngD45fEWvyW75+E8H3HJDAIjk13umr+zzRHSx2fcnaITcq7ZSBvG4a
	0p20y56z0dVF80FYX+0pgC3Cy8K9csc5s0jpzyqCnrcSX0ZQLx3l300vqxJ828dMBjyHGn0MxMe
	57cJqh4n3da2YKmDkTpbh1n36aiR2vuD+nwmP/fsTj
X-Google-Smtp-Source: AGHT+IGLxQf5Mvke/vM2EkF6/583Zl67fDA8/F7qScezPJe1ESf4y4dMVf2DpQ3IkfNkW8uyBNV79g==
X-Received: by 2002:a17:90b:2f50:b0:340:b501:7b83 with SMTP id 98e67ed59e1d1-3436aca72a6mr3619510a91.10.1762618724753;
        Sat, 08 Nov 2025 08:18:44 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3435e25e508sm4310773a91.13.2025.11.08.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:18:44 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH v2] selftest/mm: fix pointer comparison in mremap_test
Date: Sat,  8 Nov 2025 21:48:29 +0530
Message-ID: <20251108161829.25105-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer arthemitic with 'void * addr' and 'ulong dest_alignment'
triggers following warning:

mremap_test.c:1035:31: warning: pointer comparison always evaluates to
false [-Wtautological-compare]
 1035 |                 if (addr + c.dest_alignment < addr) {
      |                                             ^

this warning is raised from clang version 20.1.8 (Fedora 20.1.8-4.fc42).

use 'void *tmp_addr' to do the pointer arthemitic.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
Changelog:
v2:
- use 'void *tmp_addr' for pointer arthemitic instead of typecasting
'addr' to 'unsigned long long' as suggested by Andrew.

v1: https://lore.kernel.org/linux-kselftest/20251106104917.39890-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/mm/mremap_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index a95c0663a011..308576437228 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -994,7 +994,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp, unsigned long page_siz
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char *rand_addr)
 {
-	void *addr, *src_addr, *dest_addr, *dest_preamble_addr = NULL;
+	void *addr, *tmp_addr, *src_addr, *dest_addr, *dest_preamble_addr = NULL;
 	unsigned long long t, d;
 	struct timespec t_start = {0, 0}, t_end = {0, 0};
 	long long  start_ns, end_ns, align_mask, ret, offset;
@@ -1032,7 +1032,8 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	/* Don't destroy existing mappings unless expected to overlap */
 	while (!is_remap_region_valid(addr, c.region_size) && !c.overlapping) {
 		/* Check for unsigned overflow */
-		if (addr + c.dest_alignment < addr) {
+		tmp_addr = addr + c.dest_alignment;
+		if (tmp_addr < addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
 			goto clean_up_src;
--
2.51.1


