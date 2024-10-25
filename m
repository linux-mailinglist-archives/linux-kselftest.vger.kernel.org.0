Return-Path: <linux-kselftest+bounces-20708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7589B1159
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9431C213BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92790216DF6;
	Fri, 25 Oct 2024 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFbAoVbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA512161F6;
	Fri, 25 Oct 2024 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890255; cv=none; b=OFjjwCtZAHrQVAwntFJJ1ppthp7VnFKMk9H/mw8RMT6vL9xn5qrWpO1UIEIOcjp+y572amqZtrI99uzaiy2zGASqobVs8b4+sxA8Sr4LaANrh53LyxK7PRwUsZ2b9gRXamuObR03xyT8LuCpn6ztXF+7Zg4eSZEMBBJ6B0krfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890255; c=relaxed/simple;
	bh=ZTqBXUsCMjXnl83i92Nu+/DV25tDzAgk0A0CVeIit9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McQX+7OGUXRR2a+fZmVSfC8Ocxcs5438H6iuiMu/n0Ck1HJp6INT2ypJ+Q8wqLWkjWR0wRg64QPDicwNNm4w/egBVOJh+49y6vAsPCrDSVfludeuH5aLDIQeiE/7nBo/BqjQ6pdjHQzk8ciL1az0LLkVFcV5FVM8Arsg17qEYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFbAoVbu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b12a02596aso160520785a.2;
        Fri, 25 Oct 2024 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729890252; x=1730495052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdrwVQGek2veJ9C+SeMpvoGTn32i6qalpt1cR6XqlsQ=;
        b=UFbAoVbuxs2OxZ6AbtuH8Wxl0jAvQduQ/0FfWDZYMmu+Ey38AblpEGpOdwiCxgtzwY
         MmE2Es2K46IWpvC+JRosyao0zyK5CjLUQpc/uEtg+w9rkeIlvn0w4zQ/lRZjPe1UxHDR
         PCeUypjXMvvx1LDDVItQK8pdeuRN7jfE3XWW0zR6GlOEz3oDCVL4NTFvaU7vnXLnM1Cj
         4K8wyK+hr4kcQxIiZ2JOjsdwvXOs/Gweely6HltFSNRF1HWXwuriXgY0l4fHfVUVhbFR
         n9fB8Z807j0thmLZjpenZyAcWFx2l+MBCggHQ8gnIqDSgLnoqTl1g0meDa8fyZy8NF1R
         il+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729890252; x=1730495052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdrwVQGek2veJ9C+SeMpvoGTn32i6qalpt1cR6XqlsQ=;
        b=XL9tIRKRlqGRrJPN+MGh42cn6izcmZdXvVi0ibQIQtzAmkoOoXZpEMopfp0fLLLL9y
         7vgAft4anTXMD5bwJuhFCyq8oicm4frR0eM12/FD7GdaYj1us3UoKb45tTbFAzy7m9Mz
         ffjSCmdi7+S8VxbRqzE3ISDjFKkO/mpSGGIIVNbnPyotbNpDlNx0P5X29S89P6W7EfSD
         UTlLA+CEqB3/1NZ6rKgXAEVIRWWa1C73be/Rx8TvOuF6jGZ/NoHCQCR5oyMRju8ZnKZ5
         LmLk4VgytSe/CoZ28AuSCGI8tA6bLjDEZ0i76WHgHyb88JQa/K2oBhIugGMRnW21tM/j
         kcRg==
X-Forwarded-Encrypted: i=1; AJvYcCVYEwRUvHrKDgkPRi+mtC5oEHdjYWEoS8Jl3SR1KaWyrQOcfaiWTRViCap5O1W+gfKk5e436x+FHtBotys=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTUMiGLVpcUjRMGYRsFqs5OhwMxWOSPLwsTChbaCI/PJIIsRn
	PpNtP+kofZMiVcYVX1eZ+ph/yjLAFrUOG9nnr99QeTWtPUcoIe4R
X-Google-Smtp-Source: AGHT+IGM0/WmKBbfrLxcsACgUSxPCaWBcJfuFn4svdSAvL3T2T7jPpCY+5Wm+/oRSjFd5YZf+3IFgg==
X-Received: by 2002:a05:620a:4623:b0:7af:c856:820 with SMTP id af79cd13be357-7b193f3e0b8mr111163485a.46.1729890252100;
        Fri, 25 Oct 2024 14:04:12 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa (pool-100-37-170-231.nycmny.fios.verizon.net. [100.37.170.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27be4csm91036185a.15.2024.10.25.14.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:04:10 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 25 Oct 2024 17:03:54 -0400
Subject: [PATCH 2/2] kunit: enable hardware acceleration when available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-kunit-qemu-accel-macos-v1-2-2f30c26192d4@gmail.com>
References: <20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com>
In-Reply-To: <20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use KVM or HVF if supported by the QEMU binary and available on the
system.

This produces a nice improvement on my Apple M3 Pro running macOS 14.7:

Before:
./tools/testing/kunit/kunit.py exec --arch arm64
[HH:MM:SS] Elapsed time: 10.145s

After:
./tools/testing/kunit/kunit.py exec --arch arm64
[HH:MM:SS] Elapsed time: 1.773s

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 tools/testing/kunit/kunit_kernel.py       | 26 +++++++++++++++++++++++++-
 tools/testing/kunit/qemu_configs/arm64.py |  2 +-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 61931c4926fd6645f2c62dd13f9842a432ec4167..10cacf5a3c443bacd6c074647e4bddfc31599cf8 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -116,7 +116,8 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		kernel_path = os.path.join(build_dir, self._kernel_path)
-		qemu_command = ['qemu-system-' + self._qemu_arch,
+		qemu_binary = 'qemu-system-' + self._qemu_arch
+		qemu_command = [qemu_binary,
 				'-nodefaults',
 				'-m', '1024',
 				'-kernel', kernel_path,
@@ -124,6 +125,29 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 				'-no-reboot',
 				'-nographic',
 				'-serial', self._serial] + self._extra_qemu_params
+		accelerators = {
+			line.strip()
+			for line in subprocess.check_output([qemu_binary, "-accel", "help"], text=True).splitlines()
+			if line and line.islower()
+		}
+		if 'kvm' in accelerators:
+			try:
+				with open('/dev/kvm', 'rb+'):
+					qemu_command.extend(['-accel', 'kvm'])
+			except OSError as e:
+				print(e)
+		elif 'hvf' in accelerators:
+			try:
+				for line in subprocess.check_output(['sysctl', 'kern.hv_support'], text=True).splitlines():
+					if not line:
+						continue
+					key, value = line.split(':')
+					if key == 'kern.hv_support' and bool(value):
+						qemu_command.extend(['-accel', 'hvf'])
+						break
+			except subprocess.CalledProcessError as e:
+				print(e)
+
 		# Note: shlex.join() does what we want, but requires python 3.8+.
 		print('Running tests with:\n$', ' '.join(shlex.quote(arg) for arg in qemu_command))
 		return subprocess.Popen(qemu_command,
diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index d3ff27024755411441f910799be30399295c9541..5c44d3a87e6dd2cd6b086138186a277a1473585b 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
 			   qemu_arch='aarch64',
 			   kernel_path='arch/arm64/boot/Image.gz',
 			   kernel_command_line='console=ttyAMA0',
-			   extra_qemu_params=['-machine', 'virt', '-cpu', 'max,pauth-impdef=on'])
+			   extra_qemu_params=['-machine', 'virt', '-cpu', 'max'])

-- 
2.47.0


