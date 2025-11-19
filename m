Return-Path: <linux-kselftest+bounces-45974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 941EDC6E72E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 13:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9FC238835A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8AE35BDDB;
	Wed, 19 Nov 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtLPYGgX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819335BDC2
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555095; cv=none; b=ExZBZrSq+nlZPu0F+gvclmufOXiLvf6u+lF7DYMTUgahwvkqP3fLdMrtrXm2Uu9FnQE5tOvoyM8/N2Hq509XFSWaqSz6MbRIT9xq+StOJH24dsPN91Qxwv1/8EdQ/FBA+xstfxJruzJuH5uMr4v+4ENgTjYKmbYKRwxR18vJkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555095; c=relaxed/simple;
	bh=TVKagHLMq86niku/IsrWaT6VJmg3K0mXFoR5k1tmH4g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LsQ6yDxtJR8thWFeQsoorGR7CJNbptnIJMUjlqYnmJ7vt6VrGeMukhTYJtfObafCbcdAe1zoVoTscyXiV1F+bazIoDbg9GtqNK4fAadZzb6TsWQnRJzteh0ld8Qh1JvGMgrt7fwuVn+6IaF8E8kxi1ymdJyXBILFNx6ASCRp3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtLPYGgX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297e5a18652so78160045ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 04:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763555093; x=1764159893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NYWYlJeGDo5clFNrAJGuFwv30IEE1UTtRiLwWKQi3e4=;
        b=rtLPYGgXVtNfDzUSEE4dtgjlXOuxhyiryeVt6pytsi8m1CzpcbQLqrPoUaCLh0cBvM
         vC7rU6xetiNzvq/04x+8L+hUdvNZnoiBuKnyWnVAd4nDAu9ao5lXKHCBsaZnA9DiI8M9
         ogN2jnsUgWYjmBLmH59E5xkVGyw6TMF1g49hGOss7KGEkRfRkPl4egG4AFRM18Jiqhbp
         NmrpbInWwdeR1e5kLbsHZaNXT4rIWIQOJUmjvy2EdzRB1pLDTIzQ/FYPWjviurfmKnBQ
         82Lw4lmlEavvzhelG188LarpYLm0+YJIBq+dZLAQ62HYe9Pi3pMrjEp1Qmntv53EAjSm
         4+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555093; x=1764159893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYWYlJeGDo5clFNrAJGuFwv30IEE1UTtRiLwWKQi3e4=;
        b=b+cuYq7GzPNMOq5LhDnjePby05OpYgaedLaixDrz9LDue5UYhiI20kLc+uogOnhZVt
         X4UmKPB/PfZQA8RO/6jPm+ybC7F94KD9SgpYSoWtA1ZKphwJjJlbGrmVW0dDQYbxAx2k
         yF3qaaWR/0Oxx3rQtp4KOXsrAh7XmD0hsPFETj5MUBZPTW0ZizUeuoTR+EYQzkgetC/b
         HYAKSm44FqT7/uGy/aRbuO6MsBrwon4PRyhdWEYU631NUf9i/kE7KRJff8caAiytvSZ/
         7JTFAajXengwZycY56noVS/yAerXj5NTy4BagzAwAqYdBdtQBKg5n/EiX1be5QxVnMbm
         nO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV00CjYQfwWTj/JPzrltipl3x0h10OitkZncxSdOTqbZ3Q5Of9iCn3rnUiGpye08HDfA9wiBGebXWGH8OMG3g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycvhJH3aypsOQ9f/O3cYxXdvXToWJV3JoVX7nJ3yppaaROUsfo
	BheYiq0qoCIviunhEKB2hhgqRaTQsIVYQsvJZ6+/IBic+8UBge1MgZZe9I9sS64jJq8cHIgsqhs
	y4w==
X-Google-Smtp-Source: AGHT+IEfRw6i/kbpmpgUOp8qq5WqsJEozs8Mg64CN6IAOihR7+nbVd7lj0znyp/a2PV0e5Wq/pXwp4XKqQ==
X-Received: from pjblp4.prod.google.com ([2002:a17:90b:4a84:b0:340:bb32:f5cf])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc7:b0:297:db6a:a82f
 with SMTP id d9443c01a7336-2986a6d27fcmr243511015ad.24.1763555093194; Wed, 19
 Nov 2025 04:24:53 -0800 (PST)
Date: Wed, 19 Nov 2025 20:24:49 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119122449.517565-1-wakel@google.com>
Subject: [PATCH] selftests: seccomp: Handle syscall interruption in
 notification test
From: Wake Liu <wakel@google.com>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

The user_notification_wait_killable_after_reply test fails due to an
unhandled error when a traced syscall is interrupted by a signal.

When a signal arrives after the tracer has received a seccomp
notification but before it has replied, the notification can become
stale. Any subsequent reply (like with SECCOMP_IOCTL_NOTIF_ADDFD)
will fail with -ENOENT.

This patch fixes the test by handling the -ENOENT return value from
SECCOMP_IOCTL_NOTIF_ADDFD, preventing the test from failing
incorrectly. The loop counter is decremented to re-run the iteration
for the restarted syscall.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 574fdd102eb5..c3e598c9c4ee 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5048,8 +5048,12 @@ TEST(user_notification_wait_killable_after_reply)
 		addfd.id = req.id;
 		addfd.flags = SECCOMP_ADDFD_FLAG_SEND;
 		addfd.srcfd = 0;
-		ASSERT_GE(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), 0)
-			kill(pid, SIGKILL);
+		ret = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+		if (ret < 0 && errno == ENOENT) {
+			i--;
+			continue;
+		}
+		ASSERT_GE(ret, 0);
 	}

 	/*
--
2.52.0.rc1.455.g30608eb744-goog

