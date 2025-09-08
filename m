Return-Path: <linux-kselftest+bounces-40936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69307B48C53
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295FB3B56FB
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B6299920;
	Mon,  8 Sep 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVLuMqej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2292E371F
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331447; cv=none; b=hfQp6CubaS82QPfW0uoo2zYRKzjqJH4hQD4xsSW7EOkxsSmAtox0+qoYN4xlEOSoRY427ADnnskrAMPq/KW5uVeql8NCoGWbLmxxJkQrUI+oCm2x4zzvK+BE2FVvt7whS942jA4f6DR3btX27GZLHjpinM34W0Z8BrnNukyoLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331447; c=relaxed/simple;
	bh=Z0lQ6NnUvMGncmPaQWFx/tsnc+zIIpvP5hzKvREAakk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R6Qd35Xch/wh117CGUQUhR/gmeePV3d6AkW4FjSdJrqavV7Y8/9J/bkaG7bE1iPsikZeA4OyZCo0KWUzx+Ir89wFWkoV80Hno8VNvCX8k8um0tVijNvabpvyFIzSuK5vbU6QIFCQJ3kQi07veoW7ep8R9EVrRWfVFnBPPVk/gU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVLuMqej; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7727edb9d3cso3723769b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Sep 2025 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757331445; x=1757936245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qTe8Cug9ZkN6A0v6ou02v4J9C6gYARogp0/zKK1tnj8=;
        b=fVLuMqejlJUAynd/SIjV3KV4LGQct8xTUUs9lpB4Q5QPX4vFzLJ2tN9/7F9PbyHa2l
         rBDDD1q0ZzMaE2/KrQomxEw/81se7WdfeZP8zC6KjHQZmj3gtnnyP2EQVfTfcxoL3sSr
         cJK1Z5QYG2mnZS25nnPXqNcoQYr6jFbkVQ/ck0/5wDdeR92c3/xo0P48K8t/Gbuibz+7
         GYZFXtNZeNdNCbODVmhqi7eKEezV34geffAmdipJ5S6LCI0eFj/dtVILhqBtEjS1pOk4
         fLgr5hdwZYvo15Uuu+HgtP2cPry94U1xaHddwrH0AGnfN6vVw2TWFz2G/MjxlTHlWSwe
         jOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757331445; x=1757936245;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTe8Cug9ZkN6A0v6ou02v4J9C6gYARogp0/zKK1tnj8=;
        b=HT6Cw/JTuyTuJcdAokHBqIT1DAA0sIazNDIE3VaTUCxEdmJghEpYeBt8ajMH7lMuUH
         3LJCsHqkgdNnCUdc0u7Cgwg2770sFtCU//qrGO+Ij5jzymJsubmFusRHriDRZN4P+Nk6
         vDaH0N3zXcx0RO84qNSL6dOllieApCSv/87g84FMClsSQZBTd5X/A2uX5XmpUwmu5X+5
         IP7fIJsEYxz9COsqekxfNPGp9QArKP8u0i+0QUtHjZYrKmcPdZLynMeAeUZnHxe+u6Wd
         RbxhYCW0Mtic/4MB9bmorn6NXzowxzeZBI2cffJTXFZQRxli3XxAtp7Vl8UEFkqQT9rq
         IZog==
X-Forwarded-Encrypted: i=1; AJvYcCVoUY7w0fvTpLjPqZGace/cGYqBnAR+14VHSAsXf0fy90MK9znTNWMbPvaESkuLGSzISVCtRBojsF2gWEyXHrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKdogfi6QUObI8fnCwRIoso8MEjl1+Dfg1kFZE7K4kEvEesiN
	sLirKUDUDt7ka8NPajuTMt9oBJT2e9GPLwGEMFPorIa+rPwrOxYBfv7rAUF8NTyHKfby8ueG3QO
	Ylg==
X-Google-Smtp-Source: AGHT+IGBKCGzB6MxHOjzvaLePBq6tlh3PsUacYIKdu3RehAtLyoXe31cr6aD+Kx7YqouHT+NJ8dqf/a6sA==
X-Received: from pjbsi6.prod.google.com ([2002:a17:90b:5286:b0:327:e172:e96])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:68e:b0:252:9bf:ad7f
 with SMTP id adf61e73a8af0-25344130937mr10349305637.53.1757331445092; Mon, 08
 Sep 2025 04:37:25 -0700 (PDT)
Date: Mon,  8 Sep 2025 19:37:20 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250908113721.4031242-1-wakel@google.com>
Subject: [PATCH] selftests/futex: Conditionally run futex_numa_mpol test
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Wake Liu <wakel@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The futex_numa_mpol test requires libnuma, which is not available on
all platforms. When the test is not built, the run.sh script fails
because it unconditionally tries to execute the test binary.

Check for the futex_numa_mpol executable before running it. If the
binary is not present, print a skip message and continue.

This allows the test suite to run successfully on platforms that do
not have libnuma and therefore do not build the futex_numa_mpol
test.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/futex/functional/run.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 81739849f299..f3e43eb806bf 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -88,4 +88,8 @@ echo
 ./futex_priv_hash -g $COLOR
 
 echo
-./futex_numa_mpol $COLOR
+if [ -x ./futex_numa_mpol ]; then
+    ./futex_numa_mpol $COLOR
+else
+    echo "SKIP: futex_numa_mpol (not built)"
+fi
-- 
2.51.0.355.g5224444f11-goog


