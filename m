Return-Path: <linux-kselftest+bounces-11641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3434902F3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 05:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF341F23363
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 03:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FCB170827;
	Tue, 11 Jun 2024 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UY+r/yId"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD42AE8C
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718077752; cv=none; b=pqRk0ijSI15/oBVygDawoXKYU62PUquKHfgfqJxMH1YDw9OGERj3ebHZTegZbmaqp3oMsqqyrj7y0KzMhP32v1WsntaKEhGGnvFs+VtoJTIqxQdGwc6Is7TI9H/+wfjKgXsReFtQjx31SZIN5sQxYb1pAAbD0aOqaJ8X4vT19/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718077752; c=relaxed/simple;
	bh=uDslm+F8BLroWx8lagivRgQLsQPBEJuINn4OBcAFnGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Os+CtguwcunD86yMpPaGtsEP4pbS2B+pgzqLwUGsVOhl26+QA8b0iVL4MmFnxMxZL0O9IcGTiRP9HXdBT1fjZ+qCGmJokUh1WoKk8HlZDwh4Bj2jxq2wPoz5JJiV3oLXPBWi+GtE3cuaigiYoJnhRKKJ7HAn3Wzw8osjFK+jokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UY+r/yId; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b5254f9c32so2668182eaf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 20:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718077749; x=1718682549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NovBVUB3IuRICfhBAy0nOxMqOymWO9ozrSvccHzKh4E=;
        b=UY+r/yIdEdKuGV4ViI81S9UaT9NmHCU9PrKvM++KbvxZKaX/xOEefdZw0pJZyGuQhL
         QJ27J0MaO7idIl5JcJlh+ETWxiFGxH+KckFGHVm/Q4A+NrcZ0VxPNV+saehyPJDRF1g3
         4dSzEeH8DsF1fvuhJyv1rfoz+YpXcLf+Q7l/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718077749; x=1718682549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NovBVUB3IuRICfhBAy0nOxMqOymWO9ozrSvccHzKh4E=;
        b=th0Vrau7oBXoxCvV0QEw7Xt77Dv0ZvOLzrSoxLBkSJpQPisOC7ouLRIJSkRekCElYf
         uJFgxRSEt83DMM/LoSL+Do9cuFdntwQ5EqjLTVWpiN+KlAp+VoGdmuR2BwoAR7KZsYxm
         NM9LM4bgwBvJm9uQVW45hs4YEI8kj/D76bPUeF+s4S0wDHSmkMXkWaBvQzpNhCXJeNCx
         key3CnWHgyzP7/0fIULZnCj9Lr/jsTDrSQahIYdE/Ws2sPcmsN3VK9TbRf3xrg51cjA4
         IZIb2KfbLSC6vKzx06buRi5j3nelzvOXuRMBkmuT8E6NNDQB3dfcFhII1yXuHPe57yuz
         xPcA==
X-Forwarded-Encrypted: i=1; AJvYcCWD6aN+8AZ5/0mwn4gMYxI+KzhsAXIeZuQw19tEziws0If7R8HBlOcfiCWAWpEqUx4lwmwKtM2pkNYHrZKdosrVM7HfB1yQLdxDhftkN/Vl
X-Gm-Message-State: AOJu0YxcOmfxI1LtR3zLvG7TSyQYwib3h4VPcSJtwzLq9758Ub4e7CF/
	5ye6xJqTjjzd4c3rYCYJZd+efyQSUsPu3MGql5rB0163go0ceXsaWB1kFXe9lQ==
X-Google-Smtp-Source: AGHT+IGagdt9lLhDYs8ZQLE5oZzdPqsj7gJG4Akw+QK/PSWbea/brv9OKcIEQqIgzG1KsFZZteI9uA==
X-Received: by 2002:a05:6359:6b83:b0:19f:34c5:db76 with SMTP id e5c5f4694b2df-19f34c5dcb0mr814063555d.23.1718077749288;
        Mon, 10 Jun 2024 20:49:09 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-6e5fb4df3a5sm4226581a12.50.2024.06.10.20.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 20:49:08 -0700 (PDT)
From: jeffxu@chromium.org
To: rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	cyphar@cyphar.com,
	david@readahead.eu,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
Date: Tue, 11 Jun 2024 03:49:01 +0000
Message-ID: <20240611034903.3456796-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240611034903.3456796-1-jeffxu@chromium.org>
References: <20240611034903.3456796-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add documentation for memfd_create flags: MFD_NOEXEC_SEAL
and MFD_EXEC

Cc: stable@vger.kernel.org
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
index 000000000000..ec6e3560fbff
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
+Since Linux introduced the memfd feature, memfds have always had their
+execute bit set, and the memfd_create() syscall doesn't allow setting
+it differently.
+
+However, in a secure-by-default system, such as ChromeOS, (where all
+executables should come from the rootfs, which is protected by verified
+boot), this executable nature of memfd opens a door for NoExec bypass
+and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
+process created a memfd to share the content with an external process,
+however the memfd is overwritten and used for executing arbitrary code
+and root escalation. [2] lists more VRP of this kind.
+
+On the other hand, executable memfd has its legit use: runc uses memfd’s
+seal and executable feature to copy the contents of the binary then
+execute them. For such a system, we need a solution to differentiate runc's
+use of executable memfds and an attacker's [3].
+
+To address those above:
+ - Let memfd_create() set X bit at creation time.
+ - Let memfd be sealed for modifying X bit when NX is set.
+ - Add a new pid namespace sysctl: vm.memfd_noexec to help applications to
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
+	an app doesn't want sealing, it can add F_SEAL_SEAL after creation.
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
+The sysctl allows finer control of memfd_create for old software that
+doesn't set the executable bit; for example, a container with
+vm.memfd_noexec=1 means the old software will create non-executable memfd
+by default while new software can create executable memfd by setting
+MFD_EXEC.
+
+The value of vm.memfd_noexec is passed to child namespace at creation
+time. In addition, the setting is hierarchical, i.e. during memfd_create,
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


