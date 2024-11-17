Return-Path: <linux-kselftest+bounces-22246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AD29D2290
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B2C2831E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDE519C54D;
	Tue, 19 Nov 2024 09:36:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90571925B3;
	Tue, 19 Nov 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009018; cv=none; b=NMjMqrJzhQTg1Vj3QKzH47KqPk88vPkkNWFYVxvaFwNj5MYjjm8fYiNJ6Ezgm95A6fpQI4AvmbirHoYRf/Ux/RuPWmvYOyMcCM6uZp0/TzhOo+QtFK+dRLAiWKwm4M0sB7GAdZtTL9u3uz7Okg8Ts9rNvwz6Un8HxqM6GoD9TT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009018; c=relaxed/simple;
	bh=52/0Yw7upQLX+DkYnXMAKU3T9jvRn9MiFFYrwKplFjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OG15doHaTZ8jOLTsib+5vHYr54LyfdpXkOI0T8V74PYp9/i2cyKYgwHsxU+7UxC0pTWtfhVgW9lXy0DhMNDZakciv0M2XXZ3R3GOlDCeRVtLuk01yPq87wPGuXbYNXAsZSFUz7IaON9UvgXw4spkQ+IuwJlYYXpunGO0tBoTRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8673c5c2d300-8634b;
	Tue, 19 Nov 2024 17:36:46 +0800 (CST)
X-RM-TRANSID:2ee8673c5c2d300-8634b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4673c5c2657d-04a4e;
	Tue, 19 Nov 2024 17:36:46 +0800 (CST)
X-RM-TRANSID:2ee4673c5c2657d-04a4e
From: guanjing <guanjing@cmss.chinamobile.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v1] selftests/bpf: Fix unnecessary conversion to bool in 'run_subtest'
Date: Sun, 17 Nov 2024 18:28:57 +0800
Message-Id: <20241117102857.198803-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following coccicheck:

tools/testing/selftests/bpf/test_loader.c:1033:64-69: WARNING: conversion to bool not needed here

Fixes: 80a4129fcf20 ("selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/test_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 3e9b009580d4..400f56f81272 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1030,7 +1030,7 @@ void run_subtest(struct test_loader *tester,
 		}
 
 		do_prog_test_run(bpf_program__fd(tprog), &retval,
-				 bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false);
+				 bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL);
 		if (retval != subspec->retval && subspec->retval != POINTER_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
 			goto tobj_cleanup;
-- 
2.33.0




