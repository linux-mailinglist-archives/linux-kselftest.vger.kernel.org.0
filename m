Return-Path: <linux-kselftest+bounces-43341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D3BE48E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598813ACF2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC5823EA8E;
	Thu, 16 Oct 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yu52fW7J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8D23EA92
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631636; cv=none; b=WWR0tbNdPTeubfdEe39v9AhrHGOiqxfBYqF0BX3z+ISPUfN82phRLeGBYVTzg/mbCb6doe99aly8WuB/NUZDRH7XIFy3W/2CT6eIRlIZPpVJQUUgk/yDspsE8CPG2wCtbf3jr6wKgmoszTRPQ+QB/E2tgauupty7eF2xh8LPHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631636; c=relaxed/simple;
	bh=odHyk61nJmeo6+J+Zx1z4MHCgB/EH+RBahpkCczJc1I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HCqwdQJrbxH16u+UQkXMzeYoTVjZ+KCIgCN7ZhlLDhYWfpTLhw7YfW6roV1tXptHuQ6WHAELHXlbtMWVnwzrA2vKNRzHo8r+9+9b2v/9/jrOtEfn3M9RBZ3pD0cpBiqBS5TwY8ISqHNqmDZjweB0bXVuwq/i1Jd/gUYvFrS45vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yu52fW7J; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290b13e3ac0so6565955ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760631634; x=1761236434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=opgpSi9HCyYeb5QaoJFK0+KAYLm9MmQJSNhZlyWP97E=;
        b=yu52fW7J9oXJmywPsNE8LoS0ZrHec3QpeZ7SuN9hXu6C5+DoUjilfz9A4LlTojFawU
         x1JEyS4CYdP7KvKcJHcZu3CKFLR83dYjKRZBsugie06KgRMVT0vSBx0Ra5Q5C4amXRxx
         50+yYfeZ6jQPHK/bZI+EbCQpQSSBPyQfOK0tW03BYlZ8eLILYPI0D1awiOKdRIBZE0Ub
         VrLzX4rMYRNCRAvYXZ1ieqsTHewpDOHy6G2bYElQziJreKN3es8GqBe/1Y6IzjPcotb8
         Sdf6uEpdXhIW2ey0EACqIY+3PgT92qmdYIZfmam5tgpPvUIkMdZgwocvmM/oQLiz2Wo4
         Yb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631634; x=1761236434;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opgpSi9HCyYeb5QaoJFK0+KAYLm9MmQJSNhZlyWP97E=;
        b=WUYyBDY2FjiDc/aZMAtVtbahlJJnUunCMIYVve4bWZsaHBOgLD+COhD44BViHK7KRk
         3ZFJ5MECat6Zh6UvXk9plph0fEVMuk144mSX5CKjaXKITBepVqsXgDJ7kmQOhx3jdVO5
         Aj33agT5jaMKCsUjQSNkBY9A2dieRi0lzUmehdkkOXwBzrzIeHy7jIcjkoV8qZeXnKxw
         Nhjx4Xb1yPPcGStb0mnvwplmJW3Gm+1qCeMBgJkEA6DjDJNCPmCSufrEw5MkAw8i9jCP
         lSmw5+3op8UZna5bZGUXqlSlPE9ts21K2fwCcIl7//35LXKLowyC0BszygK4pRSEOe+d
         XndA==
X-Forwarded-Encrypted: i=1; AJvYcCVsfQXQYFcl1YRELdsHf6WQPf8wqDsVeNQnpKCs8OhxpmHbt2MUqFXK8syIhKIfK2xwE6j4TknqMSarxVwZ7o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4iiMzcGY4o0qU+VEk5ZVgGitE5iKcDb/Cn9Vj/J+vUXab/Kz
	QjdlR2QgAwDe5BlcAvGX6jnZewWCuFH3x2DNKtVUBOVU3PUZFthwjE28D8nrp5RmTHcVq7mBunV
	03wKkRPKlDzhGsw==
X-Google-Smtp-Source: AGHT+IEAchZCEYXbzttQRhqLO9QAGbSjjSUxUK9QNMdzsGd5ULRJQFOzo2z7Urwl/wXb5vQxCHwQk2cCqD9wJg==
X-Received: from plbms6.prod.google.com ([2002:a17:903:ac6:b0:290:258e:f666])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2408:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-290c9ca6afbmr7175385ad.14.1760631634376;
 Thu, 16 Oct 2025 09:20:34 -0700 (PDT)
Date: Thu, 16 Oct 2025 16:19:41 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251016162009.3270784-1-cmllamas@google.com>
Subject: [PATCH] selftests/futex: skip tests if shmget unsupported
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
2.51.0.869.ge66316f041-goog


