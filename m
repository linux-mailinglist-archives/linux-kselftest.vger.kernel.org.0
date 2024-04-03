Return-Path: <linux-kselftest+bounces-7107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1D897569
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 18:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309D21F2841E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB49152164;
	Wed,  3 Apr 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIfAWDCk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51401514EC
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162557; cv=none; b=RZo3p/9zQUklef+lox+Zy25MSVDDDRHHkt+KMY3GlvuYWIXZ4qYT6YBpYe/qUvyI6ISs+bOo3j1EE8QNL38rw+NRTkUQI9qO2+ouRk35RsisehiHSRiHcmA5z0dW/RkbU3pubd8zvLhi285p5m+IOLUhkuQaQCkJgTQ3NLa2ivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162557; c=relaxed/simple;
	bh=13pzuYSzeQAEjsqL42hszPIFIbvOLO7/tUFfzFZ7DN4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tiMi5eon7VV3KWyqggpdaWkf10qqwvIEBufudyhUzQtgKOKyJQTNZbOdk3FqECmBjF9goFDsjel3kUibOln70oTuRCo/doXqIbyPLqCeTMCii+NEHkkZDQOvPSyOn+iWXCEz3vtUTtpB8V/AF+lcv1p3LU9GigS2b2fJLUfPmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIfAWDCk; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7cc61b1d690so2897539f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712162555; x=1712767355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zL9VryjlYsGlQOxrrXBc4s+acw2W31pFo0ivkt7WDt4=;
        b=PIfAWDCkfSG47Ye5IlLAlA7E4G3UIrfcHS+DCr5nxEsNYY3gIqXBRUpv7HXKwRe1wI
         LkU+kUIzFc5ODGyU9dVvmdIPKtuRbBDJ0A79Es/2Eb4AdhaZS/hPiA7/7Dp+Z5VbXllh
         GCI5CxHNZO9BXpWnjbLoAaWNVxg5XxGeSfiH1fKY8vinS5vkZhmAiI9EiIwqayS8/Ztj
         0KkL/khK4IvvNeakhs/5wJjXXA17kqPzHjxVE+VODXDj60M2E4vxUiptH99PIYgCMZqy
         nM5GqN5zlWl33Hh7mQWO/3N0Emdq3JkTzRmcShNMXtbkVBFjYlTLdOmcGchPbgFtKS+Q
         7p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162555; x=1712767355;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zL9VryjlYsGlQOxrrXBc4s+acw2W31pFo0ivkt7WDt4=;
        b=GTTHA4NNek6uE4aytPICxHf7IehjbHj4xTN96BTjwFHm8YttuoUeV4pM3AAlghYqVv
         TI8wcMQI2L2I0EeArSPbROsCItfqnVVBG4l+Qs3Y4e9guv5a09I807VBTuO/YpfT+CTO
         D5vdtqkQbxtfVOCtt9QmgMESWjv1F0WuoSxXjAsi5N+Kt/Z4tvOio9rs+PKJZ06mNYgI
         lQzOZibCRdqPrYWpXxhkpA3nY5alZXg1Xof8AT1dWnOEilD+a9/F/v4PqDUf1ouCYNTz
         bjWIMFc5dw9tf5nDuLA6lDhRwHyGRo07QpDlfHxyZtwQqTjUF26z/Cmiwo1+RvfdNjAa
         Bvww==
X-Forwarded-Encrypted: i=1; AJvYcCXKqkC5uFukf4Q/oATHXuSPD0V8VB7AvbJyMBtDzk28i9JlSnCpQcJAovDCi227vh3ggRKCCfyTolcwgIi/6/WvgfbfL/nHGp9lI6VQpMyi
X-Gm-Message-State: AOJu0YxAdNV9zmeHAjTN6Ey5WxveoajIcV8FfkQ2HH34cueIo4pIghR7
	qCUMnl7Jwnf4cNCeFBwCMkeOubScYX6yOHwGe2t7m6NyGB8rzJr7ph6Q9hpjTxWTswryORxctbw
	nRWqf6Q==
X-Google-Smtp-Source: AGHT+IF0rO1Bjeb7TUkL6kSTrX663vMZ3XBPI3uHeZiTz2sTccbaBGMG83mBaqMove3qM6FC98OsRNgJym+A
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:20a1])
 (user=rananta job=sendgmr) by 2002:a05:6638:8904:b0:47f:1496:13e5 with SMTP
 id jc4-20020a056638890400b0047f149613e5mr111392jab.4.1712162555133; Wed, 03
 Apr 2024 09:42:35 -0700 (PDT)
Date: Wed,  3 Apr 2024 16:42:30 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403164230.1722018-1-rananta@google.com>
Subject: [PATCH v2] KVM: selftests: Fix build error due to assert in dirty_log_test
From: Raghavendra Rao Ananta <rananta@google.com>
To: Sean Christopherson <seanjc@google.com>, Sasha Levin <sashal@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

The commit e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in
the dirty ring logging test") backported the fix from v6.8 to stable
v6.1. However, since the patch uses 'TEST_ASSERT_EQ()', which doesn't
exist on v6.1, the following build error is seen:

dirty_log_test.c:775:2: error: call to undeclared function
'TEST_ASSERT_EQ'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
        TEST_ASSERT_EQ(sem_val, 0);
        ^
1 error generated.

Replace the macro with its equivalent, 'ASSERT_EQ()' to fix the issue.

Fixes: e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test")
Cc: <stable@vger.kernel.org>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index ec40a33c29fd..711b9e4d86aa 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -772,9 +772,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	 * verification of all iterations.
 	 */
 	sem_getvalue(&sem_vcpu_stop, &sem_val);
-	TEST_ASSERT_EQ(sem_val, 0);
+	ASSERT_EQ(sem_val, 0);
 	sem_getvalue(&sem_vcpu_cont, &sem_val);
-	TEST_ASSERT_EQ(sem_val, 0);
+	ASSERT_EQ(sem_val, 0);
 
 	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 

base-commit: e5cd595e23c1a075359a337c0e5c3a4f2dc28dd1
-- 
2.44.0.478.gd926399ef9-goog


