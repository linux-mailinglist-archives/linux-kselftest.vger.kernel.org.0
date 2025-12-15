Return-Path: <linux-kselftest+bounces-47578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C74CBD074
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 09:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5566301D648
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B23321D7;
	Mon, 15 Dec 2025 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXlA8vWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259523321D8
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788552; cv=none; b=OeNh77htqMDIOc08RZWNAJMldM7RpzzIIfpptwJTR7Z8WYbDWHw6XGrx+pxO2iuHD126UwzO9yYpa2Rsrc7BXxyxyLMy5dem4O6ECZyTebi/Fm2+t3xYjLfs4JbiKjbxSB9qfZ7Jw+Ib5whJkmBTH6SXCfL2nvJnFyiJo3fm5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788552; c=relaxed/simple;
	bh=8i1Q4oq+cytJl0IcVUuiEN7sbmcQ3V9vJUtywYQr9Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9FBsX01Mv719g4hKUvDcXFw+3oLsBL8zWl2ZrW7/KpHHochIUKuk+XAL+0mxggKDHhSjZxNzCyRxMJTPu3UJa5yoZDaz9EtO0RDNJ2KsWgPwZVbNn52VzGIyt5YFOdfwLcTlaaVoXeUYPWknJz8O3n4n6IagglVgp1JB4AAlp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXlA8vWT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aad4823079so2824522b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 00:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765788548; x=1766393348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ3tmZ1IHwFtnfG4tSNUz05gU5jSKEuY1R6lKbDLdrU=;
        b=KXlA8vWTLRnyJ29LkTwiX0TXRGQB0KWWcnJXqc4lP4UbPeW5ShZHUs7Y2LOFEfnAn8
         Py+4DuCzIUylWhaQHUTu89Rv6r9Od7U+62LYL2q6xIqmbQLJBIOS7Rl7gJ8iezPDVxpy
         m/mqLIZoD8ntDdZhtX+bkFOKJuIb8MJJJ5CPvVwGFob9I840p99cL2M2Xko9vVPV/RWO
         Ymw2F9MCuI0oQqVCWtt+CbiiNNJb97foBWW2V5QCeIRgak87Cp8HiyJ6Jxr8kH0rkeL2
         TcGxVOrBT3K24t2qOKeBtme83wBoU3D370ZyGVrg3ntSj+IKbjQeAaXjfbhyvbx1uvJT
         CwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788548; x=1766393348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ3tmZ1IHwFtnfG4tSNUz05gU5jSKEuY1R6lKbDLdrU=;
        b=qeiUUlUB808BAFqwnV394jFcbn7nnqiatlhXJMDcr3lYr/BQbXtkWQs3Di8CLVQ/3T
         IqP1GL/FkNQ+jM+mwhggysQH9xP9anu62si55YwsMQcJNWVV77L2OQ5Gfe/ABIDqjp17
         4LFt/wdMyDhOgiFVrqfBA3bqW8ysg1NyHM1ieYGawI0bfa3muyPuBnxyPwYpk3jGrIXg
         Cewg5zVxoO54ltE08AztT4SuMMrPTAkw2TQ/givhbLTmHx7WoYRz/GMCOUJ1WA0nNms9
         okyfNvvkvS/bxSYdTJroIFKEBASBhB9l0BzbHi9PyV61VQGgMgWnrpnWRMlGgkRPXNxz
         gMEQ==
X-Gm-Message-State: AOJu0YyKQJMzLuUOdmPBnLWNuowL6pngq4RIaJuuYj/pZxAr2NrH3QZw
	lkG/dcGJyq4pjYmcDJdBJT/LLEaX3G155ydHsZTb9w9X+E5tgo424r7O
X-Gm-Gg: AY/fxX7PpmGP1KFm3wDNzNlFh+mIkoBaLIetkRzwoKF2jrJ4l2xGncLukgMrrbvQoIo
	1F5RRf0+KsyUcUKx41V5gBpSoDBOUPaZf68IMyKv5MOKOQioKkB9PCUFZzfm2Gu0LjsQ7KqErQq
	nyaCiJ+6RMQ4e4YY2soEKiYIcEQ4g4re1r65Cr75DildZsTZCEUBcVbCaakXF1RETQZOJsZEOpR
	oXzER6GyAgK4Bhoq7yUGHhsuZbW+P+tCd1Bo00dt2HHuN+JC8WycxRSHpLNtRqT1pj96M1jlp3q
	mfzJkyIFMIx9Nm4PZHKwwajYsT94aStEIi2FaeFymgxRd0X4rrzIh6ki9JqlF9uAvnMfsq4MML2
	8mug9JMDPlK7g1zaMIK9R+QUFNsMOrZbR3rO8IZOwE6mA+RHpPIFuC9zCkwTlzRthKSimqQSy6N
	RYRP4tlS/EtyNUYIqw730ebf+B9SDwwzPt+7Yd02Ddy4PKBA==
X-Google-Smtp-Source: AGHT+IGFOLhOHUN0HBIHPChEhB8BYMiAZvuRpj05aTiyNpnf/kXx8TbMc7tFpRcia34euXu/C2dH3g==
X-Received: by 2002:a05:6a20:6a26:b0:366:14b0:4b07 with SMTP id adf61e73a8af0-369afdfcb23mr9317176637.67.1765788548220;
        Mon, 15 Dec 2025 00:49:08 -0800 (PST)
Received: from clint-ThinkPad-L14-Gen-2.. ([110.226.180.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c509cb51sm12035577b3a.54.2025.12.15.00.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 00:49:07 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org,
	Clint George <clintbgeorge@gmail.com>
Subject: [PATCH] kselftest/anon_inode: replace null pointers with empty arrays
Date: Mon, 15 Dec 2025 14:19:00 +0530
Message-ID: <20251215084900.7590-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of empty (NULL-terminated) array instead of NULL pointer to
avoid compiler errors while maintaining the behavior of the function
intact

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---

[] Testing:
The diff between before and after of running the kselftest test of the
module shows no regression on system with x86 architecture

Let me know if any more testing is needed to be done

[] Error log:
~/Desktop/kernel-dev/linux-v1/tools/testing/selftests/filesystems$ make LLVM=1 W=1
  CC       devpts_pts
  CC       file_stressor
  CC       anon_inode_test
anon_inode_test.c:45:37: warning: null passed to a callee that requires a non-null argument [-Wnonnull]
   45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
      |                                            ^~~~
/usr/lib/llvm-18/lib/clang/18/include/__stddef_null.h:26:14: note: expanded from macro 'NULL'
   26 | #define NULL ((void*)0)
      |              ^~~~~~~~~~
/home/clint/Desktop/kernel-dev/linux-v1/tools/testing/selftests/../../../tools/testing/selftests/kselftest_harness.h:535:11: note: expanded from macro 'ASSERT_LT'
  535 |         __EXPECT(expected, #expected, seen, #seen, <, 1)
      |                  ^~~~~~~~
/home/clint/Desktop/kernel-dev/linux-v1/tools/testing/selftests/../../../tools/testing/selftests/kselftest_harness.h:758:33: note: expanded from macro '__EXPECT'
  758 |         __typeof__(_expected) __exp = (_expected); \
      |                                        ^~~~~~~~~
1 warning generated.


 tools/testing/selftests/filesystems/anon_inode_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 94c6c81c2..2c4c50500 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -42,7 +42,10 @@ TEST(anon_inode_no_exec)
 	fd_context = sys_fsopen("tmpfs", 0);
 	ASSERT_GE(fd_context, 0);
 
-	ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
+	char *const empty_argv[] = {NULL};
+	char *const empty_envp[] = {NULL};
+
+	ASSERT_LT(execveat(fd_context, "", empty_argv, empty_envp, AT_EMPTY_PATH), 0);
 	ASSERT_EQ(errno, EACCES);
 
 	EXPECT_EQ(close(fd_context), 0);
-- 
2.43.0


