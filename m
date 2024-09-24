Return-Path: <linux-kselftest+bounces-18270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F69983D4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 08:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16110283FA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 06:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414251E515;
	Tue, 24 Sep 2024 06:46:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC11B85FA;
	Tue, 24 Sep 2024 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160403; cv=none; b=NKNkVvYT9ZZ4yetS9DhLu5GOELzf54MR/r8+FTrsYOs2NVAXn/iITaDgFEnJCzz0dnwEi7ia53n0Btr6HZzqkVmUmJUjWx/Qj5CrHqnBqkMOrYYqFnxYDr9mnIpaHaEN5YZShnSufLPavSzcbwRmS/595qTrqKdTaCxwYJCO870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160403; c=relaxed/simple;
	bh=N4L3Ma/ohQWO3wgqI5BRqisp8dWYVrEejFRIaSIlLlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sJN7JleZCp6m4u2s5sVlNEWiJ0s0od6FrBN+oAKD68kqjZY2ta9SSZp69cOwdYXrQh4oE99RNakikyzy/zIkXVZp2j7mKODPRPaOUzu6p8iJ1wnDijttXaCR2xKnc6leoHSD89XEW/RR9el1A234zcFNV9ibcG4izWNumTzuVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166f2604b3a6-51ca9;
	Tue, 24 Sep 2024 14:46:35 +0800 (CST)
X-RM-TRANSID:2ee166f2604b3a6-51ca9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee266f2604a111-8dd92;
	Tue, 24 Sep 2024 14:46:35 +0800 (CST)
X-RM-TRANSID:2ee266f2604a111-8dd92
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] selftests/bpf: Add missing va_end.
Date: Tue, 24 Sep 2024 12:55:34 +0800
Message-Id: <20240924045534.8672-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

There is no va_end after va_copy, just add it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/test_progs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index c7a70e1a1085..7846f7f98908 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -868,6 +868,7 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 
 		va_copy(args2, args);
 		vfprintf(libbpf_capture_stream, format, args2);
+		va_end(args2);
 	}
 
 	if (env.verbosity < VERBOSE_VERY && level == LIBBPF_DEBUG)
-- 
2.33.0




