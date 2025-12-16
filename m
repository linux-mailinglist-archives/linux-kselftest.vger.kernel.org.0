Return-Path: <linux-kselftest+bounces-47600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C24FCC2535
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 12:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FFE308BB27
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B7341066;
	Tue, 16 Dec 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbIDB6Au"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CDA340DA4
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884696; cv=none; b=U3iagnoGA/IZ6c8CI+sHbbxJa7LDIjU7Mj/c3as5dxAp+Ll+Cu9wU6sOSpK61mFROYtN+Fsfrh0y5D9BIB1fRoav4pLb7G2sxU6jQ9nr8EyCVG7+8HYiIA1T2zfJontAzbPYV1F9URjUfhETrvcnTTYEEubE6mW+ouKEeoeKe2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884696; c=relaxed/simple;
	bh=ntbk0Qg64mB+eRdow45mqcltJofKTd87yIfqFj6CdOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uICABlMFxoT20aLOQrSh9CuizOYyrfWRSiDQks87dXDniRf0UXarMTiomx97efUM75DU0nvExNYF5m0LAyhsRTjprDiFDHcUbj39icBvfOAnKNhr1uli4yJKrU9LmgFgqZPXHSsIgliNps6E9neRcwxTLK2MB8qI1Ewz2+5fRag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbIDB6Au; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d67f1877so26675725ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 03:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765884693; x=1766489493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPjuXZ4/6Ll8iE3Rz28AaFI0svhctDC7vgBQffR8h0U=;
        b=cbIDB6Aurdo6Qg7jy2rnK0HXpv01qQ+S0FkbLynBIJOAZBf4yQT6qtsiWqe2LcQwqX
         jDlwmyMXYjhdlwLZ1avjPiSBPEpel9b7dG4cjcsk7BmVrAKaXo3fr4XHczCx+JaO8t5j
         m4k8fc2oE/Zjn+t+m+wDDXWdD3q6WB9fre4WKsBA7i0Xuq3IxzbEOXj56CViDdiJe4ms
         N/XU3CtT2WW+20AelN1iXrm0Xtd+0d6AQ9rXNxVOcNx88lZh4dRf2p0uxB+YeDHHln4K
         mltZ2r4LfEJxxBUUcjwcycnncptdQjUduMqw506STKED0pH+5t5wdrA2ZRWqFvzlwx18
         mFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765884693; x=1766489493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPjuXZ4/6Ll8iE3Rz28AaFI0svhctDC7vgBQffR8h0U=;
        b=Cco/0pvQptRvHhqPn95eYPS1fHEUdMjtJDSItDposKTQMTBo/fQpxSzbH+wFat9xyA
         s42HOh7mpv/d1hn5ifO8Dght7zetkhSJOC+TxcoG5PLWxuK3/JlwGBooqn2LkTkK5O6p
         nHODxVPO6HpuYNAxEANsYAkItFmin7kK/UUqj1oI0Xrzkrs7pbZSk6G5/qozjyRAxDYU
         1t6EBfoyYOoPgD3wZc9z7gSvCnZctU8vlQ3QE/5orafnBhcDBPl4BaAZKuPHwZnGZOkD
         54+rBZI4ZXJA9D3wnwB5ZiecmOq5blZnMn1CIU6Wv3EZz/rAEpa01sQR30g7tS7Xa29n
         NptQ==
X-Gm-Message-State: AOJu0YxiYvFxstP/S/FtUWmJW/FnudNSvlx3z1A0EK8iCClf5JTVkaNu
	0wZHqWFL2l5tJFwe3/dQf5iFncRU44VYtiGqg8vMS7Z7E+ikeI0+aPam
X-Gm-Gg: AY/fxX6lb1LMTSkXeXspMW21/yI4LJ3ggnPCdh2MggWjetr7MAZ3mmk5nFvyf6nTC17
	Urh8NzZN15CyWtE8mUW8/BauIZ/bIjirKLaisrkmEEuk+za4lF2UqL1EDFMzubYehTBHSpXZpK1
	qXQxF1LcyEc2d913jsyoynDCwxYfNNpRfSVTlZjmCGsaa2vS+5nuVyg+B+LMHHzB0foM+vTzhX9
	7mFumKzO7Oy0zpmDuaCqUum5CB2HQ50o11ywL7eR8rWPb9WNkcyibFFWIcr3cRW85carxqdP3YH
	Dkgqt+DtWAbZz5KQIm36G6taOt0CSiPbVpkTrwqOBSg+9a8IRFX8GMs4zzWKqldFyvgsEecd0CQ
	2LblTWB993YAarPK1s62FBpuC48qcUPM2GFBql1/SEgXh/ZeuQAZrtRVBD7j44ynDb1RcAAEUFT
	tItl/np4WAfllWHJjAE9uva0dN2xlZVTnu8+s=
X-Google-Smtp-Source: AGHT+IErSHd7LCl7veNUggNMiOy8RjvXrn1zvEt+0F4+GSG9YkcBPanzUna8QSO4lmk0MrToIVu23w==
X-Received: by 2002:a17:903:3b87:b0:2a0:97be:61a5 with SMTP id d9443c01a7336-2a097be6581mr101276985ad.3.1765884692481;
        Tue, 16 Dec 2025 03:31:32 -0800 (PST)
Received: from clint-ThinkPad-L14-Gen-2.. ([110.226.180.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f7f6900949sm8620678b3a.29.2025.12.16.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:31:32 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	Clint George <clintbgeorge@gmail.com>
Subject: [PATCH] kselftest/coredump: use __builtin_trap() instead of null pointer
Date: Tue, 16 Dec 2025 17:01:24 +0530
Message-ID: <20251216113124.4150-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __builtin_trap() to truly crash the program instead of dereferencing
null pointer which may be optimized by the compiler preventing the crash
from occurring

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---

[] Testing:
The diff between before and after of running the kselftest test of the
module shows no regression on system with x86 architecture

Let me know if any more testing is needed to be done


[] Error log:
~/Desktop/kernel-dev/linux-v1/tools/testing/selftests/coredump$ make LLVM=1 W=1
  CC       stackdump_test
coredump_test_helpers.c:59:6: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
   59 |         i = *(int *)NULL;
      |             ^~~~~~~~~~~~
coredump_test_helpers.c:59:6: note: consider using __builtin_trap() or qualifying pointer with 'volatile'
1 warning generated.
  CC       coredump_socket_test
coredump_test_helpers.c:59:6: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
   59 |         i = *(int *)NULL;
      |             ^~~~~~~~~~~~
coredump_test_helpers.c:59:6: note: consider using __builtin_trap() or qualifying pointer with 'volatile'
1 warning generated.
  CC       coredump_socket_protocol_test
coredump_test_helpers.c:59:6: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
   59 |         i = *(int *)NULL;
      |             ^~~~~~~~~~~~
coredump_test_helpers.c:59:6: note: consider using __builtin_trap() or qualifying pointer with 'volatile'
1 warning generated.


 tools/testing/selftests/coredump/coredump_test_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index a6f6d5f2a..5c8adee63 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -56,7 +56,7 @@ void crashing_child(void)
 		pthread_create(&thread, NULL, do_nothing, NULL);
 
 	/* crash on purpose */
-	i = *(int *)NULL;
+	__builtin_trap();
 }
 
 int create_detached_tmpfs(void)
-- 
2.43.0


