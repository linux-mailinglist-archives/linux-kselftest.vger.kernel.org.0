Return-Path: <linux-kselftest+bounces-38090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9564B16AFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 05:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B021AA1810
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 03:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE2A23FC74;
	Thu, 31 Jul 2025 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4svhFk5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7161FAC54
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 03:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753934030; cv=none; b=ToKevr0d/4NH74qSMPULxA/tMhsN7nB3s6sOSxYuMCw/UkHgoVuIczDFLeXvhGkYz9a7XNjyjI4866gRtInJsVVqfMQj0zpnjl7JrmXJUWD4wdAvzZfXmjEClAKSGcZ87wdABz8HJM04LUw7SdH0nal8ZRucL5JzqbHdA8aKwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753934030; c=relaxed/simple;
	bh=fnv2bvW4oL/8fcth3UuQDvT5MgVnJMi8x7vBniJJriE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZHGXiMFu9/HPXYbG0R9VqIT5uJN76Levy1GD1e/ociAZV8jadLKdDngDf1xDQpIfa25NnNwSR4Y8ohnkWaF2HnXMKOiqpw3+rwUceUNZYz354wu3f7DihUHcV8coZtruE70uULXmrssOwl7MRmqY6Bz5aE2YHUIQrOKgFG7vCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4svhFk5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so674007a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jul 2025 20:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753934029; x=1754538829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Djjw1+5LVyuqfZpLJ3GjIIXfp47bzR2xiLcSbpiWKlg=;
        b=V4svhFk5B4kLyZe9IgA9tVSymU1Jly08ZqiF5kEKuwhb9GU9n8+v/NUF9qlXyUJZQD
         7XwLLKrUrRz38NnoXZG1dn/ohZVlwu6Asa64q3nFY2laD+nt1n3RfyLRwU3jp/ODWHL9
         HDXZ169ezRM/+jHNNKLRrKsuP4wt2a6i4xXgbtXl6/AEm1SYJJ6HhVLGCpsAuc3tv66W
         NyugSaTTb8dpplftJWCB9KH9Lu2FROPaOe1PIv+GDSTwtBHODtKffmrh1PfKUS5N3+N9
         Zp6Iw0hpfyXjvGt3u37o+JE1ZLbgtNBMnf6Xcm2JHo2i10d7CqzdUPxGkFwRio4odK2Z
         tKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753934029; x=1754538829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Djjw1+5LVyuqfZpLJ3GjIIXfp47bzR2xiLcSbpiWKlg=;
        b=b8GBPEK4vcj+Yd9MQPnK5G65vxLBljBihd/KejvZDCoseMHgGbfwzF2BOyU1K8Qvaa
         /oPc7B/+cQV+WBAsxzu0YhQXG6x8ykal5PFgsFg5NAysviqj3dUq5CGT8IeeWYRiCik8
         Wvs/zRybLvbMZ5u+Lcj6K8jbPI2ZJHeyp/a9vtT7eqZ8rW++yIVunF95JvcNLWaT+W0L
         qZiJo6gBqAx5f0MV5pomftWmo4Vc0WbuH/KwJhMoEYc5pVq5aTHuAp5aJBpxbgqw5PB3
         PqjJi7oRe78s/5hymGekuU1e3XTsLropQXT5rAaBbjUXcmg2JanD7c5vdra5NYUhMS6r
         aoOA==
X-Forwarded-Encrypted: i=1; AJvYcCWUb9/fPzXq/ZAIbvhLiPAO3Ws6eEOFv+SAcSjsy8oRN4557/Np5DrfuJWjY2Bv9/zEsmpDEoAZPiN6OxayJO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywQU9xm2UFTzG38P+p5vAf5vnMCq39Sd/Ch9/zrx4Si03+viSc
	k+eQJMUCRjONPtg89vmIx+zLoBFsT+92qLZ8hFrq/oDmA+7DgMAr/3wIunJljNJi7r7zaLR06RG
	l6mrQIzU3ltyQmw==
X-Google-Smtp-Source: AGHT+IHJhtfPbQPby19heSPhpuT8uaue0FoOH5AflASoVfIOyeBYE3RG3OgXokkY0Wcvw2Jf0scRqJz+Fzxypg==
X-Received: from pjf8.prod.google.com ([2002:a17:90b:3f08:b0:311:ef56:7694])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:562b:b0:312:959:dc4f with SMTP id 98e67ed59e1d1-31f5dd6b53amr7215759a91.5.1753934028679;
 Wed, 30 Jul 2025 20:53:48 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:53:36 +0800
In-Reply-To: <20250731035341.2598127-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731035341.2598127-1-davidgow@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731035341.2598127-2-davidgow@google.com>
Subject: [RFC PATCH 2/2] kunit: tool: Automatically pick a default
 architecture if none is specified
From: David Gow <davidgow@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, kunit.py will default to 'um' (User-Mode Linux) if no specific
--arch option is given. However, UML is only available on x86-based
architectures, so kunit.py fails by default on anything else.

Instead, for non-x86 architectures, enumerate the qemu configs looking
for one which matches the current architecture. This currently uses
`uname -m`, which doesn't always match the kernel/kunit's architecture
name (e.g., aarch64 versus arm64), so look at both the kernel and qemu
architecture names in the qemu config until one matches.

With this change `./tools/testing/kunit/kunit.py run` should function
out-of-the-box on most non-x86 architectures, assuming qemu is installed.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py           |  2 +-
 tools/testing/kunit/kunit_kernel.py    | 43 ++++++++++++++++++++------
 tools/testing/kunit/kunit_tool_test.py | 10 +++---
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7f9ae55fd6d5..188bb7f2802f 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -351,7 +351,7 @@ def add_common_opts(parser: argparse.ArgumentParser) -> None:
 				  'string passed to the ARCH make param, '
 				  'e.g. i386, x86_64, arm, um, etc. Non-UML '
 				  'architectures run on QEMU.'),
-			    type=str, default='um', metavar='ARCH')
+			    type=str, metavar='ARCH')
 
 	parser.add_argument('--cross_compile',
 			    help=('Sets make\'s CROSS_COMPILE variable; it should '
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index c3201a76da24..7042e44e3a88 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -211,6 +211,31 @@ def _default_qemu_config_path(arch: str) -> str:
 
 	raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
 
+def _detect_default_architecture() -> str:
+	uname_arch = os.uname().machine
+
+	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
+
+	if uname_arch == 'x86_64' or uname_arch == 'i486' or uname_arch == 'i586' or uname_arch == 'i686':
+		return 'um'
+
+	for option in options:
+		config_path = os.path.join(QEMU_CONFIGS_DIR, option + '.py')
+		module_path = '.' + os.path.join(os.path.basename(QEMU_CONFIGS_DIR), os.path.basename(config_path))
+		spec = importlib.util.spec_from_file_location(module_path, config_path)
+		assert spec is not None
+		config = importlib.util.module_from_spec(spec)
+		# See https://github.com/python/typeshed/pull/2626 for context.
+		assert isinstance(spec.loader, importlib.abc.Loader)
+		spec.loader.exec_module(config)
+
+		if config.QEMU_ARCH.linux_arch == uname_arch:
+			return option
+		if config.QEMU_ARCH.qemu_arch == uname_arch:
+			return option
+
+	raise ConfigError('Could not find a valid config for ' + uname_arch + ', options are ' + str(sorted(options)))
+
 def _get_qemu_ops(config_path: str,
 		  extra_qemu_args: Optional[List[str]],
 		  cross_compile: Optional[str]) -> Tuple[str, LinuxSourceTreeOperations]:
@@ -247,19 +272,19 @@ class LinuxSourceTree:
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
 	def __init__(
-	      self,
-	      build_dir: str,
-	      kunitconfig_paths: Optional[List[str]]=None,
-	      kconfig_add: Optional[List[str]]=None,
-	      arch: Optional[str]=None,
-	      cross_compile: Optional[str]=None,
-	      qemu_config_path: Optional[str]=None,
-	      extra_qemu_args: Optional[List[str]]=None) -> None:
+		  self,
+		  build_dir: str,
+		  kunitconfig_paths: Optional[List[str]]=None,
+		  kconfig_add: Optional[List[str]]=None,
+		  arch: Optional[str]=None,
+		  cross_compile: Optional[str]=None,
+		  qemu_config_path: Optional[str]=None,
+		  extra_qemu_args: Optional[List[str]]=None) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 		if qemu_config_path:
 			self._arch, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
 		else:
-			self._arch = 'um' if arch is None else arch
+			self._arch = _detect_default_architecture() if arch is None else arch
 			if self._arch == 'um':
 				self._ops = LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
 			else:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bbba921e0eac..a3dd456d62cd 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -747,7 +747,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.mock_linux_init.assert_called_once_with('.kunit',
 						kunitconfig_paths=['mykunitconfig'],
 						kconfig_add=None,
-						arch='um',
+						arch=None,
 						cross_compile=None,
 						qemu_config_path=None,
 						extra_qemu_args=[])
@@ -758,7 +758,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.mock_linux_init.assert_called_once_with('.kunit',
 						kunitconfig_paths=['mykunitconfig'],
 						kconfig_add=None,
-						arch='um',
+						arch=None,
 						cross_compile=None,
 						qemu_config_path=None,
 						extra_qemu_args=[])
@@ -769,7 +769,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.mock_linux_init.assert_called_once_with('.kunit',
 						kunitconfig_paths=[kunit_kernel.ALL_TESTS_CONFIG_PATH, 'mykunitconfig'],
 						kconfig_add=None,
-						arch='um',
+						arch=None,
 						cross_compile=None,
 						qemu_config_path=None,
 						extra_qemu_args=[])
@@ -783,7 +783,7 @@ class KUnitMainTest(unittest.TestCase):
 		mock_linux_init.assert_called_once_with('.kunit',
 							kunitconfig_paths=['mykunitconfig', 'other'],
 							kconfig_add=None,
-							arch='um',
+							arch=None,
 							cross_compile=None,
 							qemu_config_path=None,
 							extra_qemu_args=[])
@@ -794,7 +794,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.mock_linux_init.assert_called_once_with('.kunit',
 						kunitconfig_paths=[],
 						kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
-						arch='um',
+						arch=None,
 						cross_compile=None,
 						qemu_config_path=None,
 						extra_qemu_args=[])
-- 
2.50.1.552.g942d659e1b-goog


