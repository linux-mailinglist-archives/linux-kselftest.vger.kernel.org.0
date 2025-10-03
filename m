Return-Path: <linux-kselftest+bounces-42738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ED0BB70E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 03 Oct 2025 15:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 858613460F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6E2F3608;
	Fri,  3 Oct 2025 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgeU7H9s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFE2F0C7C
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Oct 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498768; cv=none; b=RPkEzWCr0olM5vzzXqy3tYuhtns3IHhP13beDeoYcr64da2KubnMwH1EgMOeos0q78nCBFQ6tLrHKWlz6odD6KKUKXNRUwd6EEbtTjyQIYev3biYq785Z9i8htrvl3fQRZ23nfZ9X3xqIcA0HY++IwWifZ30MqGtwotQjTlBBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498768; c=relaxed/simple;
	bh=EhJlCtUGcSeWQktaiM83P9YNtXVSdRR4pDoNVCpu5bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPnP6ny7XNMYWWDvPnnBUubQOo3fmZOUdhaLiYgMrM8x08r5EkMEvFZ7VSo1RFGqMuOy4WKmVK83XJIRqSoD2zG5wg97+oh2W0jgEuospJU3ZuMpjWZ9PZwiS4b8P81ISbHh2L7rF6rs8XdY1gDBZDiECBDf6vhFD+6BIrQwPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgeU7H9s; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso8887525e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Oct 2025 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498763; x=1760103563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UM3bjOGfRXsiIqNoVQZ3XTLMtvfmMCHhcAES2xrn08=;
        b=wgeU7H9sSbsrjdJ3kHLO/aKVcmAegzUy/xfLFaWHfe+rLIfmkIkDxnh3nar4ajBVA9
         AjjZgt+gIq+P18hFGbDKF4YchbyAShj5kMOBTQESUQRrjI410WQp9Osdm7tnUniCFruL
         /CtpA97GZHe5EBtY89CaJKEH0s9dm3gdunWjQQmRg2lvtqCwClkT6LSSOAsR9upS5+yW
         EecikaBye/FAYxcB8CcYPpVwBv7NNOKfXQqlqBDzxsXSo+Nwta4gfSy1JHV1O8D3EL5e
         KEb6NtBsTDKpc+4A5egb8wWIofq126Qn54RHpWa3FhngkZt4vlxJeG+vocDTX9VFb3da
         miAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498763; x=1760103563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UM3bjOGfRXsiIqNoVQZ3XTLMtvfmMCHhcAES2xrn08=;
        b=XJ1s3k4ZvJYSR8PClTVRqmC7S7lh3sqWzSij5Xwug5NngBOEEegm+Q6BVwxoEJ7u9t
         zLXjpO8MntHonmTL0WNIPPpxLw5weRcpvUW8iGhNuoFW+V+gmONT5mIpWtw3i1dluFOp
         IYxifaLzG1m9mOLkIOwivKt+ueQMj+7S8rr9+juyPrKA21MasNt12LsQy0pJQFJDk/6M
         Tx/0RoNxu2LM+V7L3pvY0KMQmU1eXRq+adPe08WquObMWQVOKzNtWfHgA2F3KWybmEu5
         +gB9EFw10Z/zMAKSRN9bkIUyA/AnXusole+o/gvIbPBZgDsLdhNQQqL9XxsdtHJ7one6
         J8jw==
X-Forwarded-Encrypted: i=1; AJvYcCWisDdQEIeVb9BeC/RY95JoCca0TjEFI/mSRC8t3CrHDs3JSheRioYWeEQeJszKZJE7j1EJx6SnoUJknTfcnQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEc/PwumpkU+2tykznmkHB61Y/9ByFRZeexdiIXSHYNICIXAhL
	bmF+o22KjYe31nfRdsaDdveW51L0WIsL6YguCBBGdCM2wCbJgENBF/lX8mNB3anLUdY2tbV9cel
	bLUeI9N4SvS3xsKLjfwqlnA==
X-Google-Smtp-Source: AGHT+IH69tFTi6ZXKv+400BRPyLOvUgxD9vIa5eZfePSc6PtEn5y2PQMqER0DyOBvI5qOTvfVEhXP1sn9nPiGRc7
X-Received: from wmco6.prod.google.com ([2002:a05:600c:a306:b0:45d:cfa4:ce0d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4447:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46e7113ceddmr26045525e9.17.1759498763415;
 Fri, 03 Oct 2025 06:39:23 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:25 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-29-vdonnefort@google.com>
Subject: [PATCH v7 28/28] tracing: selftests: Add pKVM trace remote tests
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Run the trace remote selftests with the pKVM trace remote "hypervisor".

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
new file mode 100644
index 000000000000..2de07e4d72fe
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor trace buffer size
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/buffer_size.tc
+
+set -e
+setup_remote "hypervisor"
+test_buffer_size
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
new file mode 100644
index 000000000000..48afc51627e8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor trace buffer reset
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/reset.tc
+
+set -e
+setup_remote "hypervisor"
+test_reset
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
index 49dca7c3861a..00aed1c2e650 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
@@ -1,9 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: Test pkvm hypervisor tracing pipe
+# description: Test pkvm hypervisor non-consuming trace read
+# requires: remotes/hypervisor/write_event
 
 SOURCE_REMOTE_TEST=1
-. $TEST_DIR/remotes/trace_pipe.tc
+. $TEST_DIR/remotes/trace.tc
 
 set -e
 setup_remote "hypervisor"
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
new file mode 100644
index 000000000000..b63339aca380
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor consuming trace read
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/trace_pipe.tc
+
+set -e
+setup_remote "hypervisor"
+test_trace_pipe
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
new file mode 100644
index 000000000000..eb1640a927cc
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor trace buffer unloading
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/unloading.tc
+
+set -e
+setup_remote "hypervisor"
+test_unloading
-- 
2.51.0.618.g983fd99d29-goog


