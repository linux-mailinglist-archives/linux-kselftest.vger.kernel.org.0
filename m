Return-Path: <linux-kselftest+bounces-45945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE40C6C7EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 04:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 59C572C8DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 03:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862F2DAFA4;
	Wed, 19 Nov 2025 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDc7h5BL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEE2D9ECA
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763521259; cv=none; b=C5G28UWEVaqZFmrjfWiEBtPgMw1/kyPP0miLzg2c26EqSbUWLoQTERi3p+m9wpOSDuhBG/fuqLq1UHstjF8MLf9SyUh0/sPU5sxoeeUipyxS5zXxGqpb61S/nuhR71P6ts+EnZQtIRe360sFwEib6FayvcL9U5hPIOpQZ6fMHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763521259; c=relaxed/simple;
	bh=pHimzpz0JrFKitwplZ0oZBv+o8lDExhZNNtty5Fn39Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NTNHyV5nZfN6T/F7hQBC8FxETOZUG2FY5AhNzJjJcu1zu0o4U9QmQEvRCKdzd4M+azG/fvcFSLoLuwnagi0nz2+Z8LMmW5P31pwDu1o7BKn/2nMjq+ehApyoRLEEzI3ryGcFwyC8mjHmVbKlX3XCw0ED+6o/QkofVAi4/YTNOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDc7h5BL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3438b1220bcso7306119a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 19:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763521257; x=1764126057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GPnRV621mSFWdVkRrlxjQUs0yR9eeqoAfk/k/20HuCQ=;
        b=tDc7h5BL9HbYHy1/urn2mCq74/8MX//7B7mk4KIs4Fps8K0DPZrCUXvLej4q9+HhWk
         XHOFUGmSA6XGxgnH3U3BkjzAVNknIXwBLd5cTnkw63n3vG4aFvFTKmMABEtqQXhn+u8w
         u4lG7IljWIjEV17Np5JITHnH7NOwUiIh3Mi83FqCah287lwudfoIOaYt/UZpPPkSgudj
         lGoyL48Ju/ZHsgXVITvbVeetFdenthBcdd67yOER8KTno43FYGlrbhZusQ3MS8X5v5DO
         iYn6Qn6IfsKljM/CsXYcS9vctfW9sH9/Amn4HLnLxxzJPf9pFnfI+ogskTW2jSdqtwxp
         zZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763521257; x=1764126057;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPnRV621mSFWdVkRrlxjQUs0yR9eeqoAfk/k/20HuCQ=;
        b=iQv9mUL2Ya6A3HJsNfNh+rA6eZPHQn/9TfhdDD0I6ucA10aIS8oUxaRIqlRmXsM4WZ
         H6jfmEkFhKiK83eiVyBWmApC3c/HJbKCW6iRd8u74wDO8qPyr+mpYREKrQjfRp4ivQmQ
         6O/PSeuI+i7yAYO9sEdcMUnnDF8+l1BHymfG1AgRKM4vx1+YFB7L/JMLf9q5OVhSH7M4
         PUQGv7595/N40Ywo8X340I7RYqtYayopHYhzeTJFgxh7dpn8HzGqUIx6gt+1zifNLO9a
         +85OzBlY3PySAUKZxjMltlY0ShHGYzrQ41el2do+aIWjAzOBoaeEPVBRki5/+tttoM1g
         ShFw==
X-Forwarded-Encrypted: i=1; AJvYcCVGCbIQnmYzjAWr8m84STvc8P8s0AyHmUbwVp0S7lLFC/smVd/+AitigMlmhl4HzubtQqk0nwHPHdGDc8zN8dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2n3KCMMRDfzrOBGkYHKcOkRjTBgx/7UQMzZj9sJUrJNnLH9Wf
	Ac+6T6C+hroyxritZjKcA4KXZjbe6NqZoRgiEYEQ+Fk8fhM/ZA3/Pbw/J0siqhhjDNTwXYilARC
	zJA==
X-Google-Smtp-Source: AGHT+IFg7IvdOZLNxRNQgIw0yD0vIM89Tx2bUKPCgXJ/t0C49/+FCiYkgi9t1KlQXeQCsNvMdG942Ma/1w==
X-Received: from pjbpm10.prod.google.com ([2002:a17:90b:3c4a:b0:340:a9b3:320c])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a86:b0:343:7714:4cab
 with SMTP id 98e67ed59e1d1-343fa52559cmr18845341a91.22.1763521256926; Tue, 18
 Nov 2025 19:00:56 -0800 (PST)
Date: Wed, 19 Nov 2025 11:00:52 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119030052.315502-1-wakel@google.com>
Subject: [PATCH] kselftest: futex: Fix memset with zero size warning
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Wake Liu <wakel@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The `FIXTURE(args)` macro defines an empty `struct _test_data_args`,
leading to `sizeof(struct _test_data_args)` evaluating to 0. This
caused a build error due to a compiler warning on a `memset` call
with a zero size argument.

Adding a dummy member to the struct ensures its size is non-zero,
resolving the build issue.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index f299d75848cd..000fec468835 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -52,6 +52,7 @@ struct thread_arg {
 
 FIXTURE(args)
 {
+	char dummy;
 };
 
 FIXTURE_SETUP(args)
-- 
2.52.0.rc1.455.g30608eb744-goog


