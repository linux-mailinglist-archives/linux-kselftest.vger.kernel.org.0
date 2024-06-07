Return-Path: <linux-kselftest+bounces-11442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F28900D11
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E2C1F270F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A93A154424;
	Fri,  7 Jun 2024 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftj7s3hf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67514F9E6
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792558; cv=none; b=PnCC8rNG6E934iX//1WabSMCNXEYUDUxAORix+ouMxyurcmy+JpPe2q408wH5+6cSHZyxFci1PJWuXBrwB15sXnnhM6n+i2GZet88hbvX9SqIdFJXyRmYUeEABYDEhvk2GWHII49+Ny1KTSi+CLc9SWLs4CCW3xM8tT5Lkbg8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792558; c=relaxed/simple;
	bh=g6CX1AvKNa0Ad5jlGLH1uQ8N6quEUKwY01IZWX3Kczo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jU/3PXSwkXUIRh88jth9HEBvTPqNdVJoDZDwLmFPhenzpvboNAP7ldPADbiuxZyrg3jX/PISnsNcj03T8Pti1DO96iPBiwAHiaeDBoYeMENSCcL/0KFsFjuZMNnRapnfjpoeG0jUayx4ac4bu+my0qbWI+LzXJJnd/kkDIp+eAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ftj7s3hf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f60a502bb2so19902515ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717792556; x=1718397356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oXWJ5Wemf0IINqz67lVh3TgdBP0Qd9snz/STsYYB+I=;
        b=ftj7s3hfA85GTj0475K0nRtrNghdGXdns5BTKw618i5koK3qmf/rmT5lksG5EkThgI
         LAd2OMcqWGLw5fn3gVT0o9Rgz4iZvKM0xnpdT4y+44OVwzIqI9qNKJ8ILqWcRktdS3K5
         Es7HAbOGFl6xphRdwo82KggtazMTzJSSwALtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717792556; x=1718397356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oXWJ5Wemf0IINqz67lVh3TgdBP0Qd9snz/STsYYB+I=;
        b=A7HQACm+s83hrE0w0YfoLbJ4Zq6hkzYylgNwoDq1cpDtGP5W1lGIvrIExkEj1guzSl
         8Kn2vkY7aT3itVbZgc+Uf8O67J4z56jT/yspgNkr85wB5lCrsGj30gsYKX7f8EAx3fyd
         pwsSlmY+04mHfQAZ+gMeYQsI0Eg651tOJKOl+XTI7J7OeD7NovKCR9+YrFoOJwzuW1HJ
         mxxRSBpO1YaUAk9eKY2P42j4ZklRPk6NxKHewRXiKOzK24T3bWlndiZCtpn+foy/c8Hq
         GG0FrYbmypUxgvSUi8uc4zel+pq5/jxpOAqCEMFaWyQikMWbwkPn7uyEMf53DcESM204
         F12Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRBXS7bu1CP80mERwigYYA00OlWHsVS4lplmiFF1A21MUKawlBqsZIyO4BZlfmwi3BUmEKHfqEFCErhIQSJaYDrdoyLpbwTIVh1q2dlrHc
X-Gm-Message-State: AOJu0YwHiFoBlvts5ynGg6lh0Hxpc1VhpDfS9CpiPNpwpL2xzsCyIEZ4
	LKgKTR7LpoNh41RhgHP75Pp+peq5yTWjAecrRoQiTEus4zvQXAhSdvb71ryhrA==
X-Google-Smtp-Source: AGHT+IFnrQY/Ai8Uk6udhcAWbv2t7ZCDY3TRPvTN4XQwhL+Rwb7V0TBa2XUWwrA1IeeDyrYAYKBOgQ==
X-Received: by 2002:a17:902:c94f:b0:1f6:8a19:4562 with SMTP id d9443c01a7336-1f6dfc426d6mr25813685ad.24.1717792555893;
        Fri, 07 Jun 2024 13:35:55 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f6bd7ccfd3sm38538225ad.132.2024.06.07.13.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:35:55 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org,
	cyphar@cyphar.com,
	david@readahead.eu,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
Date: Fri,  7 Jun 2024 20:35:41 +0000
Message-ID: <20240607203543.2151433-2-jeffxu@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240607203543.2151433-1-jeffxu@google.com>
References: <20240607203543.2151433-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add documentation for memfd_create flags: FMD_NOEXEC_SEAL
and MFD_EXEC

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_noexec.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 5926115ec0ed..8a251d71fa6e 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -32,6 +32,7 @@ Security-related interfaces
    seccomp_filter
    landlock
    lsm
+   mfd_noexec
    spec_ctrl
    tee
 
diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation/userspace-api/mfd_noexec.rst
new file mode 100644
index 000000000000..0d2c840f37e1
--- /dev/null
+++ b/Documentation/userspace-api/mfd_noexec.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Introduction of non executable mfd
+==================================
+:Author:
+    Daniel Verkamp <dverkamp@chromium.org>
+    Jeff Xu <jeffxu@chromium.org>
+
+:Contributor:
+	Aleksa Sarai <cyphar@cyphar.com>
+
+Since Linux introduced the memfd feature, memfd have always had their
+execute bit set, and the memfd_create() syscall doesn't allow setting
+it differently.
+
+However, in a secure by default system, such as ChromeOS, (where all
+executables should come from the rootfs, which is protected by Verified
+boot), this executable nature of memfd opens a door for NoExec bypass
+and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
+process created a memfd to share the content with an external process,
+however the memfd is overwritten and used for executing arbitrary code
+and root escalation. [2] lists more VRP in this kind.
+
+On the other hand, executable memfd has its legit use, runc uses memfd’s
+seal and executable feature to copy the contents of the binary then
+execute them, for such system, we need a solution to differentiate runc's
+use of  executable memfds and an attacker's [3].
+
+To address those above.
+ - Let memfd_create() set X bit at creation time.
+ - Let memfd be sealed for modifying X bit when NX is set.
+ - A new pid namespace sysctl: vm.memfd_noexec to help applications to
+   migrating and enforcing non-executable MFD.
+
+User API
+========
+``int memfd_create(const char *name, unsigned int flags)``
+
+``MFD_NOEXEC_SEAL``
+	When MFD_NOEXEC_SEAL bit is set in the ``flags``, memfd is created
+	with NX. F_SEAL_EXEC is set and the memfd can't be modified to
+	add X later. MFD_ALLOW_SEALING is also implied.
+	This is the most common case for the application to use memfd.
+
+``MFD_EXEC``
+	When MFD_EXEC bit is set in the ``flags``, memfd is created with X.
+
+Note:
+	``MFD_NOEXEC_SEAL`` implies ``MFD_ALLOW_SEALING``. In case that
+	app doesn't want sealing, it can add F_SEAL_SEAL after creation.
+
+
+Sysctl:
+========
+``pid namespaced sysctl vm.memfd_noexec``
+
+The new pid namespaced sysctl vm.memfd_noexec has 3 values:
+
+ - 0: MEMFD_NOEXEC_SCOPE_EXEC
+	memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+	MFD_EXEC was set.
+
+ - 1: MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
+	memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+	MFD_NOEXEC_SEAL was set.
+
+ - 2: MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
+	memfd_create() without MFD_NOEXEC_SEAL will be rejected.
+
+The sysctl allows finer control of memfd_create for old-software that
+doesn't set the executable bit, for example, a container with
+vm.memfd_noexec=1 means the old-software will create non-executable memfd
+by default while new-software can create executable memfd by setting
+MFD_EXEC.
+
+The value of vm.memfd_noexec is passed to child namespace at creation
+time, in addition, the setting is hierarchical, i.e. during memfd_create,
+we will search from current ns to root ns and use the most restrictive
+setting.
+
+[1] https://crbug.com/1305267
+
+[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
+
+[3] https://lwn.net/Articles/781013/
-- 
2.45.2.505.gda0bf45e8d-goog


