Return-Path: <linux-kselftest+bounces-7105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B70A897557
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 18:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0221C24DF9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 16:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37BC14D71E;
	Wed,  3 Apr 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2dBHy20"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3750A60
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162282; cv=none; b=REAlgY0vEYL4AedieO3wA6+WZ4YY/6Y4roq4HjPRKuhJowhyuTCY9FIQa1y2VCXASE49YOq3Kt9IYTTuX6dsI1LEpRIOYiHC95ci58OJ2ulgoUPQ+cw1v397yobOuYLRapgViOk5kkOc8fBJyIcaG6LvNsKZdEXjRdjgsMKisE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162282; c=relaxed/simple;
	bh=ytvGI9heir8jUTNz8fa21KCx3UR41dZ1BEei/fkS/tk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X0u0RSBfBg3gtJ5IcRgtH14j6VXTcWlbDMaJEg2GDUHx04Zn5JCrfSofE32+Jr1HvHH2S5QHKa6txbNcAIqPhLdDhZJ8B/dCtbvoVF7qSzb4rQQ58fbeDdb9gETfO8KL/RDM2mZ0NZf9WXAfT505FyFd4FnEKVGhbZzoU2yS2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2dBHy20; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7d022d0c76aso2862739f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712162280; x=1712767080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q1vrkM4qy+eCxZFi+KNPrNFLVrCIYB9n/XwoXXqqv5s=;
        b=X2dBHy20VCfrkvrQ6WM2WSZVss0oa5SFr3NpuNhg6lMs1wVBBc0U+qJfCXzpXvRdAz
         3EnOr43T6+cwziuo9Ez1jx9GO1UkoLE0wGcys4K3+9tqoxUST6TcVyn2KUnfiOrv/UYs
         1qFf77G3s5l0KgLHt82yoo+eMjTI4JDJO75HKUdMLfvY7Gay2+WC4nJM49FXoNDegy40
         I+PkoFZOlZoy812OD+CWreLMYEYdh0fq2XtKFERUDxmWhsErqEWfF/POnUPGqdc+wjUl
         GHF/0htmJxmizb0DyMDSoPlj5vh2CYdmK5xHx+MXLuroELuq1gucI9ZSyLUH0CmIWp00
         brCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162280; x=1712767080;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1vrkM4qy+eCxZFi+KNPrNFLVrCIYB9n/XwoXXqqv5s=;
        b=ZgA5XjNkAecAiVTbZVVWnj9aLAXZP8eIoG/qF77jiH4YQc1cVRIlrL4dt6NbWAwH+U
         ap7f4B34G3YIr+AfVsWiTxzfsNZHvcI/RgSodtWGRtH3CW4OFTgjy+kguH25uMcsAx4X
         C0AlqQuxtbnyNi2PB4OSNB8xHMs5cXXsZ3xLgpiPoSTsurPql1DlpcCAzoz3aktpj0Z/
         +uxWfWw8b7ArTWWZgFJ6GBuUrID8qGVaxhg1xdHMBZ/NWRXAidO/UIS3X6AQ+FZ7mN0g
         Ks4PDJTWwe+H+NZGqj8gQv2al8Y9xSWTAHwSsvwaFa2PH2n8W35KI26GLGI+5c6f/gfY
         oyGw==
X-Forwarded-Encrypted: i=1; AJvYcCUXU6/twsnulBOJ7/U44XmDNs+nbwdTAgmaRvxL7pr17OeLNsgGYSopee2rqtJ75Ea2ngtkfEY8CpfB3w2/Bwnp1oVT7uJ7/EV0qrDUkI0h
X-Gm-Message-State: AOJu0YzGZs6nzT+fFMTILEsDUzviNLJ4mx1/i+EvUuoMt9E81Q/4pKWR
	f/QJ1gJYZK60Sk9sKqZpcm8vu8e3hMMeXoHjqvz5FuM1lCc6hR4qe+R/F+ZZ3hk1yQ2yoLxnxCm
	86g88kw==
X-Google-Smtp-Source: AGHT+IGB4vV/Sw5krILq3RILr7noozz1vwF6KwvYjFIURr/fONHnLOvW+gLWPcsGnEAhdPwH930QmeaHYght
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:20a1])
 (user=rananta job=sendgmr) by 2002:a05:6638:3488:b0:47c:1788:e23 with SMTP id
 t8-20020a056638348800b0047c17880e23mr953740jal.4.1712162280573; Wed, 03 Apr
 2024 09:38:00 -0700 (PDT)
Date: Wed,  3 Apr 2024 16:37:52 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403163753.1717560-1-rananta@google.com>
Subject: [PATCH] KVM: selftests: Fix build error due to assert in dirty_log_test
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
Change-Id: I52c2c28d962e482bb4f40f285229a2465ed59d7e
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


