Return-Path: <linux-kselftest+bounces-30153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A28A7C637
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 00:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7FA178521
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64A214230;
	Fri,  4 Apr 2025 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEhIdI1n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7881EF368
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743804758; cv=none; b=dFP90wh3XAq6tdXE+DmJgINlomBbvxYBuH5oIYX7TRyxPsUChUePqHjP00qGvUZVZrQkPaH5dcGDHDIIjyDi+kZmflZugrvBCbPfBi7BUd4ESWBVX+5dlAcpnWdq49wgnc/KqpqCrId+8nBadI0mkfsONKZUCjBoFysLVOSsjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743804758; c=relaxed/simple;
	bh=g+xVFtyBpZ06wdvPmdcjIlfg/j4hhnFLxaCyL3AVl6E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZtUVATjsBs0GTOjTYl8p8o1A3lciXwg3lzPoIgtBvQVfNt+2WrGd5apDofIabzP8/oboAYhKFJ+Ysy0a8+1CV7OO5Lzr9iyNZG96gMw7dYDX+aQafH4NGfyXObAm1ceTOOFdSMKTfWXTZER2FTBSP5nUMvVnlNK08u7SDiSWRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEhIdI1n; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af51d92201fso2831214a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Apr 2025 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743804756; x=1744409556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/U4kVqaAyKMKtv8m2nE/g7H/7hJOuqXNvkeHjTm7xgA=;
        b=BEhIdI1nm7XkT7msnC3nQWXVTuC0E0ZFX9gDPci07iGG4B4OchCaWMMP69ILUB5nGN
         CqEKsd0fdeytzQznMdn0M8N7jukRPu5MOESM39bq8rpll1pelRtedYEr1BBmPRiY2440
         N0qfeXi5VL5xGfwEnCnyqf/hST8IO09R/KbJXuIhFHUO9tUafe1ve+XIj9sE0/aTqtGJ
         Qg5emg44360RZgAQ/65d8UD1OJXJ7Mgr0iIqM0lfYDrN86IqO9fFfF/BO4DkewCxpDWz
         ERkvqUf5UK7607dLy/X42Dpcpv4W8ak63lJqkro3oiagRR1cdEd66he1koAcvWz3Ej7W
         USjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743804756; x=1744409556;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/U4kVqaAyKMKtv8m2nE/g7H/7hJOuqXNvkeHjTm7xgA=;
        b=lZRubSc9GIB9kKSWRHPMJcNVMns5BXM8Ov6GqJD02nri2CW/1DZTj6POuBMkFmZg87
         VahRCWKF4YR8izhLF7b9MS92EMpFMcG5pxKJkM/erkOUzwF5DuNt6eQOibbkhpYwQj/X
         eMBpdLdiJJHw4+J1SLIL3YqbTl5dJWsQQ1BgEmjJQl4DKg9R7e7pnzVEtnFn5gmQLYF+
         MXuqw69BGX/cSzS94YLCUv2TRptwv3RMcjW+zLH0sB5M944cw7U3uVxF4xMBA4QWO9co
         +KbXGQ3TRFPP0WbPa/G4/d7S2aTImqYMivjGvYa1IZDZbBzBmRzR5bVaIDtaBWDSmt9b
         XH9Q==
X-Gm-Message-State: AOJu0Yx7Dk1xHWwgu3YrMiwC+WsCIqFWCv1WS6gKEjwLo5+PxeJ5sh9X
	B3HFyAxn2P/WdJlpIDTgH9SAdWd33lGQS83xdtfO35EX67h1gzWGpsTr0NNuzEQHl3wZqSVQmrR
	b0bd61+EQ+qlw0QdGpwDlQ13zr4TjRUW3UchSPpyceor+YbKrXDCO29nYcTaEuG/fI7iKhWpNSS
	RjO0pgJdY7etSwQFE5c1Zg/fev2OfcHKrE8xZ0Q1KROtuB
X-Google-Smtp-Source: AGHT+IE13OUugeg3CeRGcslDvnyM5A0feauPtld5nJtjovt2pXIKA4CqWaZp7OWEqbj4lz/Qf23nRU966GY=
X-Received: from pfbhu13.prod.google.com ([2002:a05:6a00:698d:b0:732:51fc:618f])
 (user=edliaw job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aac:b0:224:10a2:cad5
 with SMTP id d9443c01a7336-22a954f9e54mr17813325ad.10.1743804755735; Fri, 04
 Apr 2025 15:12:35 -0700 (PDT)
Date: Fri,  4 Apr 2025 22:12:20 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404221225.1596324-1-edliaw@google.com>
Subject: [PATCH] selftests/futex: futex_waitv wouldblock test should fail
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"

Testcase should fail if -EWOULDBLOCK is not returned when expected value
differs from actual value from the waiter.

Fixes: 9d57f7c79748920636f8293d2f01192d702fe390 ("selftests: futex: Test sys_futex_waitv() wouldblock")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../testing/selftests/futex/functional/futex_wait_wouldblock.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 7d7a6a06cdb7..2d8230da9064 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -98,7 +98,7 @@ int main(int argc, char *argv[])
 	info("Calling futex_waitv on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
 	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
 	if (!res || errno != EWOULDBLOCK) {
-		ksft_test_result_pass("futex_waitv returned: %d %s\n",
+		ksft_test_result_fail("futex_waitv returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
 		ret = RET_FAIL;
-- 
2.49.0.504.g3bcea36a83-goog


