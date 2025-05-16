Return-Path: <linux-kselftest+bounces-33192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD91AB9DC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4075C7B00A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CB7202C44;
	Fri, 16 May 2025 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCBS1o02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2A200110
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402883; cv=none; b=HFuhId7n0kywZdr0XjfwYjLde32ZtnZ55QaGggSSiAjWYkPFkPBObvmJhaKm/wLgxPAfUb8s+UjqwDvjM52o62FNg7KS2vKS0CXGgQumegYh28WpgC9NnK8VMW2qR2fOJNHa4RbRTHeqPP3b574zoS2CpiapB1O/wbdtDw2UcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402883; c=relaxed/simple;
	bh=uJWI89wvuu58ssW9qPj7mRyoSGLNQzk4PZd/GC7Hv54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cLSt4qccHR9MKc6S3LOq7PYwY52ygxoQn15yEjEbkrMGQo7N2ZSIfepkwV+EaUdolCXVDWqAHydXql5gLrHp39gVdeupzfLXhGoq+T/9fkvDFRarsFsIwzD7nprbr0uXv09hkG04rNxLtFcE5TOGvFhQ3Vul8mFhR/MNdXvE1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCBS1o02; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a35c86b338so764354f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402880; x=1748007680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7GVxU0/r+w5zLWT8gZSbiy4WliZZRj39MPigOv2RvQ=;
        b=oCBS1o02JWuLlxLVHuSLTSRdLb9z6FcUCDF20hjE0sPvvRVQG/uhXCSyEBmQ/ajAHj
         LE2sZ3c37fnIYC4QlU5uwKWxhZhVM/70wOXou+jf/Q57L5kvDSlOutPhI/alMVvWV5yH
         VfWn+SUEfmzBqjf5NGcImMhcoB6s5UjKpGkFGTubZnFIgs3nXDbCIY84Jj/iq+k1qt1X
         q1tHDCJHV5c80wdceKmrZvyIK3HjTLg6QCVYNlQBnSqpllkI2ZGT0YuoiQtqQzd458ZY
         MP0l3pz9vH2nzY9gKGlU8LZ/siM4f6AgqC1/yST+s0WUnHwbrMgdM5Cp0jKDQHla9epj
         oOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402880; x=1748007680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7GVxU0/r+w5zLWT8gZSbiy4WliZZRj39MPigOv2RvQ=;
        b=OLJ8PVhBXe9O2BFCE0ToUr4TZTLNZp9pQykebKycYavOqYNih2OLp8S1tf6GuJQQif
         Xp0xyho0Y8tQ3W3vBZlEbnrQbQft04Pj2Ef/tJtEsLfQNREW3cbe+msnMymfUc3JHBw1
         6TJA9ri59PTbZCxyT2iGXJvN4Uabd2WJWNzNy+gRg2xMBSALtmNVMoK7Xutghw4Z9kXu
         M8BmwZ6K8dH4G3gQ2tpvJ1i87WN3qq9gcwpsg/f4VZpgcoyFjqbzgvvnABAP0N0WX4+F
         7bR+s2zCAfTVyFcXSAeqD2yoUaNt4XeL8lCjsOxxYt/KBgNe05PS/9fnbqctGc4p+iTg
         +tsw==
X-Forwarded-Encrypted: i=1; AJvYcCWtICdmFfJ37fxZIWblOZCndxRUzPIREqpQRjfVRJjicbqFC2WSCkMlazahs5oDAHQ0fujk/tsC1KsQR60WZDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwORnGMTfYk2aFa0O3ehnn/2ujarTdFItQ91+N8dmY+u/o3sW
	bRADr6zOiN2+3u/t3K0DP5aPrGtvK+CbRweq3ayrcenQxBrZqrNnBrnugtqoL3RsxHFGlTAJxAf
	0o/Xn1As+bFfxqXAjGc7yYA==
X-Google-Smtp-Source: AGHT+IF5jgzJGfaBS/UHJ3X8WaZX+60Zli0llPdcw+b0LDQXYJrpjyQFz+/w5KLRHR1Rt2m4D1p45WOPNgP2H7ul
X-Received: from wmbhg17.prod.google.com ([2002:a05:600c:5391:b0:43d:58c9:bb51])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2289:b0:3a0:bcb1:fc02 with SMTP id ffacd0b85a97d-3a35c84ae4dmr3449099f8f.54.1747402880322;
 Fri, 16 May 2025 06:41:20 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:31 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-26-vdonnefort@google.com>
Subject: [PATCH v5 25/25] tracing: selftests: Add pKVM trace remote tests
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Run the trace remote selftests with the pKVM trace remote "hypervisor".

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
new file mode 100644
index 000000000000..383ef7a84274
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing buffer size
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/buffer_size.tc
+
+set -e
+setup_remote "hypervisor"
+test_buffer_size
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
new file mode 100644
index 000000000000..679e31257d0b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing reset
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/reset.tc
+
+set -e
+setup_remote "hypervisor"
+test_reset
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
new file mode 100644
index 000000000000..4c77431e884f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing pipe
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/trace_pipe.tc
+
+set -e
+setup_remote "hypervisor"
+test_trace_pipe
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
new file mode 100644
index 000000000000..059c7ad1c008
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing buffer unloading
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/unloading.tc
+
+set -e
+setup_remote "hypervisor"
+test_unloading
-- 
2.49.0.1101.gccaa498523-goog


