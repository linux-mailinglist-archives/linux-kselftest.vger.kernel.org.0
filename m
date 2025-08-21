Return-Path: <linux-kselftest+bounces-39464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2BFB2F0D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 10:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F417A9BE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FBB2F5474;
	Thu, 21 Aug 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM0UtY8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69452EAB97
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764099; cv=none; b=W+74nN96+Hdn9sggilTUvyCGXgENxml/b3FIwOoit7RVe9bG3aciKS1yn3xbzb0RfI0CwexcBfmuRddtW5nINaVW0ODfqPtUrUm5VJgRwc3BhfrYOWdZKqKoox7hYoYw2BIgL9H6TX/4DzYJm4j8S8OKz/mzpp2COii4jQkM7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764099; c=relaxed/simple;
	bh=3KMoWYrKCS9iXFyZU23vQdmkGsH1bjakmfocPm6yigk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nkX5NiE8ETv2f9xh/o2wcPB0ymeB+oLfXk7XZbm7oRE0ZE7L1dzhUbxA5moWiXBI/VNnY5zFxwGXHbWDENpu/RltBi7hs3hw+PN2HPWf6xI64SoqLaFgXMYHFOvo95ktlwvZeTHZ9MRxl4V+xC//KqH3a5jpjyp2Huf+ZG8qDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hM0UtY8/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so3843155e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764096; x=1756368896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXmeaJhI9e99CmL9wkkDfiednrjI4qTS7gtaFJx7Vrs=;
        b=hM0UtY8/PDxLvU684ct/gumgTLbeTeQm8/iI37L77iHdMsdCmx9css7YopzJmmniVO
         1R4pd6QNIM1fu1o1z9kyaLS5DRjS9Q/FN4oI2TPopv+2erXcwNtRpfVTOc0USIfFbGYv
         3yWqg2+c0mmPKsbEbF6wO56HneUz/I3aX8b727tmFomieVEKKGglITHu3HfRoaZV9zfR
         nXYnMNy2JPggizwZfD6yLr+skdPBeRYHSaJsZkH51cDuCCWbfPNrouze1Qb++Q23jcWT
         yXvrtWq/HV+NDArRW1sAYevoN/Qk46HEzFFCU3oNO1x5ukH5HzvjU3+TX5VNwCApSKNf
         QwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764096; x=1756368896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXmeaJhI9e99CmL9wkkDfiednrjI4qTS7gtaFJx7Vrs=;
        b=SM/YHi3D24Roigcf85rtrXUdeymegnwsCxG0MIsNIvVzDfTON4d8muox9rEDPgsIJj
         zHMZMVz6+Aiv4y9W/LMQlFdSJbFxvxVcTfC1T6d5XWeI6353jEvlVTJA4sGACq0bTnxu
         teBSVSiQSe3dtIljONGg/J0G6RJMWyb2MdaeDfQ93jp80N8jIKY0TP5j5hFLlHjObH1j
         4XrPAeXU+g40XIktLWLdkCm5jtwHDFJa3poqQM3XZRpiTvXKkSVMDSZ506K+SyXT+slR
         8mxGQ/fJ6iLmBbgLko9pf7Tr4ZIVYZxeU1eP3DY3HZwcF5VaQcRuLR+xhILN4DdswU4M
         OdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP7vxcy2TH2hRGarkkHKdfgHEiOa7u/GptE64SmgJm2V4kRyXb93dVcQ+TNoTnZc3bJVKRc55KP4qKjWDAwjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5oAB00n0K9cNoX+HsFBFQzo4KZZsaax6WT/Chp7hS2DAontq
	5JcR1EM453EHGrvpDNld0CuB06KU+fIUb9ys7jX/jGzkuKWtf1r+8yb9xRwFcYDg2DKZECHzMr1
	ewzK3lTedXPocHLRQ5i8oYQ==
X-Google-Smtp-Source: AGHT+IHVkLSbuPXaBGbeYxLB8Apzj2J/LjIQ1ACzqcVV+IhVmKpANZi8n0fKVREaY1XDOmHvrY0P+LX9S3g8rjan
X-Received: from wmcn3-n2.prod.google.com ([2002:a05:600c:c0c3:20b0:45b:4777:8063])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a46:b0:45b:47e1:ef79 with SMTP id 5b1f17b1804b1-45b4d869ceemr12017085e9.36.1755764096134;
 Thu, 21 Aug 2025 01:14:56 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:12 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-25-vdonnefort@google.com>
Subject: [PATCH v6 24/24] tracing: selftests: Add pKVM trace remote tests
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
2.51.0.rc2.233.g662b1ed5c5-goog


