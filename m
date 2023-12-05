Return-Path: <linux-kselftest+bounces-1197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815D6805DEF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30561C21072
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184875F1D6;
	Tue,  5 Dec 2023 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPBywQkG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD8BA
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE8ijlql5yJARnazpyl45/u3+npm3s09B/RpWnHdyUU=;
	b=EPBywQkGcnqtrRE8QYnMzIXYYBFyHyTxbXEQZvZ5zhqGQAtOFK85kgFz22LJVdQsq5MHkm
	dHgiKM0y0LAgGwDheBq2MedSsOMlaFd2htM/L6fpjn1mzdblhbXu1dpk13/MGEE2vALoRS
	gYKxFjHJ2h+GZBrJq3Mgmq6yTtgjJ9Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-CgPwecmMMKuMmYV-O7r4jg-1; Tue,
 05 Dec 2023 13:45:56 -0500
X-MC-Unique: CgPwecmMMKuMmYV-O7r4jg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11BB51C068EC;
	Tue,  5 Dec 2023 18:45:56 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7539F492BE6;
	Tue,  5 Dec 2023 18:45:53 +0000 (UTC)
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
To: workflows@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>,
	Theodore Ts'o <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>,
	kernelci@lists.linux.dev,
	Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Subject: [RFC PATCH v2 08/10] docs: tests: Document kunit in general
Date: Tue,  5 Dec 2023 20:03:04 +0200
Message-ID: <20231205184503.79769-9-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Add an entry on the complete set of kunit tests to the
Documentation/process/tests.rst, so that it could be referenced in
MAINTAINERS, and is catalogued in general.

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 Documentation/process/tests.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/process/tests.rst b/Documentation/process/tests.rst
index cfaf937dc4d5f..0760229fc32b0 100644
--- a/Documentation/process/tests.rst
+++ b/Documentation/process/tests.rst
@@ -71,3 +71,26 @@ kvm-xfstests smoke
 
 The "kvm-xfstests smoke" is a minimal subset of xfstests for testing all major
 file systems, running under KVM.
+
+kunit
+-----
+
+:Summary: complete set of KUnit unit tests
+:Command: tools/testing/kunit/kunit.py run --alltests
+:Docs: https://docs.kernel.org/dev-tools/kunit/
+
+KUnit tests are part of the kernel, written in the C (programming) language,
+and test parts of the Kernel implementation (example: a C language function).
+Excluding build time, from invocation to completion, KUnit can run around 100
+tests in less than 10 seconds. KUnit can test any kernel component, for
+example: file system, system calls, memory management, device drivers and so
+on.
+
+KUnit follows the white-box testing approach. The test has access to internal
+system functionality. KUnit runs in kernel space and is not restricted to
+things exposed to user-space.
+
+In addition, KUnit has kunit_tool, a script (tools/testing/kunit/kunit.py)
+that configures the Linux kernel, runs KUnit tests under QEMU or UML (User
+Mode Linux), parses the test results and displays them in a user friendly
+manner.
-- 
2.42.0


