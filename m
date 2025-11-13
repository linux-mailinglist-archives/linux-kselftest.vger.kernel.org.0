Return-Path: <linux-kselftest+bounces-45587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C3C5A000
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 21:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAB784E5C28
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A031A042;
	Thu, 13 Nov 2025 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmaBbqaC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181131D721
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066463; cv=none; b=OlWOyovYmGmtFWng+UexwRGaeXHBblgFGWYmUi2rlw2De2iKuDdV52zr/b3cxjzABgxmBAquhBZ/tIQmKBZzW0N0eXb+cCQ1OJbma9+ZmyeI+zWCqF3DTvxeh9TtmQWN8zA/ixxJlowntGgGdeCyxPXMUl8FuJOMP6Oui5SbCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066463; c=relaxed/simple;
	bh=pcZKawp/Kyv1VBo//0O1FARICKW1xEF+GTJkGg9h7EI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nttmn535GSoPFkX+x9ALg+dgmw1p3QWXbNj1ZfdzsZr724/UqcuPW18W7fCvC0GUujnMDBUFy4RG0Va74TFwNiRAPFW1Xlrm0QdO/6xFiVqfoy3ix9HAKFKQTN89RAyC/kEAAe6Bgl919uMCTP62JcbEg0FR7yivwTpUFtboRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmaBbqaC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso2697350a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 12:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763066462; x=1763671262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V+YD+xhf7ggyhixBrgPINuaozCmmMHmC4KEG53hwEik=;
        b=WmaBbqaCqpkE8y9CHiDn8IbTIRw0jAk44UwdWYoK5rP8uC4AMQBRemULCbnZMLqxnj
         6dPyMe8jyGnraOwxX8KBKwp79Eaw65iVPH6/kgF82aPCixy70QRDCEECOdVYWFq4kz+g
         hC9Lx+cjVMabsDtjvAbhWBaQwgIRSp8lT07plYEBuV+qh7kW6rRVZXloFN65PtDIJ7Sy
         umQHoDEGqFax1VRYSo1LJdjB0Ymyns8mt0YiCnCXbk8TcB6x0xMyZyLAtMhnZgnBG/dT
         o4TJsS6Tb42Yr/MOf8UBlOOX44KycEe4/BpuOuhAtddWSKIhKjenSFzXUOXwE/I0L+l0
         v2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763066462; x=1763671262;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+YD+xhf7ggyhixBrgPINuaozCmmMHmC4KEG53hwEik=;
        b=pVqplcoxocmh7jd33MPkg3ew9av1Fw46UnN9tegJy+IFqydObxqpJnXSMl16yk4VUZ
         WR+ywISwHwaz3g8bWQwLnjj+OgzP0fuUe1eka51WIn20viSyBJ09Td3oXVZwiN7fOiu+
         ElMSAl4dW8bXXFOWQ/erbleteMBEFqxkYAtJaf5SUmlaU+MIkPPxbLX6A8Ol7TDNHB7Q
         Jp7ZV5whh3kkSRa5w3KCKOTBHJ30slO83Ei9g/uaklXhO2v/FTg4mGyWTnpUDpC22hS9
         4hKbnTwHLxQS0amZH/+helVUBg5HqoUyQKQTiiz9aUNk2QYEeXZkOeDS2anjixkTohbR
         goQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4rw8C2eAmg1fD64wAvMJOjXZBxIR8XxDqPNn/U6w1OHxBG7oALXgFydZ6UT83IpO+Y3WIJizanx0c2ECVLDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywpAkyMighNnTP+zKdIcHwth7ASYZmTsDrL51/7tbGE7VDY6Ha
	5Ch6h51aufggFZ0prkgk5wFdUytTN5z5QE2f1wvpkqHWoubHZ6eQNOB7eHpKWt5KhVub4BVQqL4
	nXHuv2QYjq9sdEw==
X-Google-Smtp-Source: AGHT+IE+53YsFgNJpF/Sd28SVvSVDRTgU9AEy4Wo4n3PJqxsxf9xx/yjHNbRPUtZKEHcjF++FUazv1j8HsiVoQ==
X-Received: from dlbds38.prod.google.com ([2002:a05:7022:2526:b0:119:49ca:6b99])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:3886:b0:119:e569:fb92 with SMTP id a92af1059eb24-11b40e7b6a2mr353733c88.1.1763066460937;
 Thu, 13 Nov 2025 12:41:00 -0800 (PST)
Date: Thu, 13 Nov 2025 20:40:29 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113204054.3566557-1-cmllamas@google.com>
Subject: [PATCH RESEND] selftests/futex: skip tests if shmget unsupported
From: Carlos Llamas <cmllamas@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Shuah Khan <shuah@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On systems where the shmget() syscall is not supported, tests like
anon_page and shared_waitv will fail. Skip these tests in such cases to
allow the rest of the test suite to run.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 tools/testing/selftests/futex/functional/futex_wait.c  | 2 ++
 tools/testing/selftests/futex/functional/futex_waitv.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
index 152ca4612886..1269642bb662 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -71,6 +71,8 @@ TEST(anon_page)
 	/* Testing an anon page shared memory */
 	shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 	if (shm_id < 0) {
+		if (errno == ENOSYS)
+			ksft_exit_skip("shmget syscall not supported\n");
 		perror("shmget");
 		exit(1);
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index c684b10eb76e..3bc4e5dc70e7 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -86,6 +86,8 @@ TEST(shared_waitv)
 		int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 
 		if (shm_id < 0) {
+			if (errno == ENOSYS)
+				ksft_exit_skip("shmget syscall not supported\n");
 			perror("shmget");
 			exit(1);
 		}
-- 
2.52.0.rc1.455.g30608eb744-goog


