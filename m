Return-Path: <linux-kselftest+bounces-49037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3CD251FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D74F53072EE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D7E3559F8;
	Thu, 15 Jan 2026 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB2SXpok"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45591395DBD
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488852; cv=none; b=Uv4re2CX9m2KR27tHObAXjtq380zdbwK84DwQAhDbSUMmqsj1C1fKS4onZhwLXiEMl3PXj9y8qlQld/6FHeFgemtz0wEn5Oh4XTL7yhGbORifunTmL2S29p4nZtWs0pZmUprbHjwmVVHavw/lTcTQQoNUt9tYchIP+H6pc3eFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488852; c=relaxed/simple;
	bh=kGn5ufCD2jXTTdxEirwcUNO4FHgwrNNxGOcBr7XwKF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TuBRtGiwZ3kCv9Q5qsU8z3OXL4eX6PJjrWGxZHI37+UqSIrGJ0gg0sNK1F3IaN41lVJ/QX2i6XM1f+nHdT5LhlvnDgmT3TJPVU3IeMBN+MwmOGJ64jwvhFmunnZeI5VM93PcviCvj9+htU1nDS+1GfFVhsDzIqEe1q+S+RuOi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB2SXpok; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a07fac8aa1so7241005ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 06:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768488849; x=1769093649; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5/4FHNHwz9CtyRKUeDLugwuQOX195LiHNnu/QshYQE=;
        b=ZB2SXpokVWCd0WkkZrX7LUuIKpaqa4WP/Gao3y2TAMXf5m9nDgEi3u9FT75cwT5g7i
         f+JS7RQp4T3dpwKt+y9BjgKdxUuwRjlLZvEDnkflz0Id09YiAv4DnB3EDB8VTQyo972w
         f8TbvsgWvjn+ubrfZR3sMsoLl1qWHqcZ4pUND4vMCPchmIWzMTEM1L0Z/6DxDDxmENcu
         gf//tmZ9BF0yeh8Uc/LiSRWhBXfa74ancz0FD4LI3CBnArSSo94QKTMjT7Ne4h9onL9f
         NV1gHdCN915J2tBS+0lqBX/z2ICihME0oK+I0CNIBjxjTTCqdsppsWC5rpfwld52rrMV
         QFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488849; x=1769093649;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5/4FHNHwz9CtyRKUeDLugwuQOX195LiHNnu/QshYQE=;
        b=mQDr9x95jRUxK3OivJofdTDV7rI5ITD+9PiV2owL6pEyoMhlHoXGLHjyLxYfvkcq/o
         iS2HynF6bnM8HPh7c0Yu+N8/JTje6iHiBkDTSNuGgE8td1gJKD9CosDQ2LJFZTCfd3i0
         bU+VSt7bBzMnu4u0uBX5v7ms27U7eGgpNOaGVp9ySCcfEHp6zRUHllHraRDSZOKt0j9B
         2QqW4M26E8YEMkALSETJHYGfnRPTFXh8NZoSomKSwmhk2+aQN4agi4q17gbUTBCZ1bCq
         vPyAt7l/xexnmC1e3teRm/pxPG2noOghZddNojpHujaYwUO+9eNYSxDHoEvYxcvl4Oaa
         2XeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpeHUmk+NbRy1NTLhAIpARtXRS2xtu1eacdSTDf56/wY06Xc51CilKOP/HHoOUKzTSkUXh3jvJmUEJVJj855c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wFuq2srUxQJ+LX7LzP/6NkKvsNZv58Eoe45HFUqkR18yUJS/
	H0QOX90thpk1J4qf1gMG8/Mmowr6Adi4tvuzuvvgtDCGUtO2zKcOSZMjdzmc92vE
X-Gm-Gg: AY/fxX7Ww+SSmtMx8/KjCzi3FsjZMPGQmE666tSPBne6YRjBPHjqZ9Eml3ed7XYvE+Q
	W3tkf8OlbaFDUVoLS0XwJ4C+BIwBgSq0bJE36XMaxnR+OZ2YNQAvjZUGvjHHBFQlec1HtUtFTVx
	xXhhCi8k2H4bAKLeNGvDhGnijAfkBs+kDRl5CyO+vUzwixKBthscmhT13LFIhdnNuH1lRWO+/ah
	MRUb4YyoNgRgxB2Mx5o5tPg3J/SQyKCMDD5vBl/YIbhhkgGjvcI6cXHdJN3bJcDCJ4+7VpbfZ3u
	URWRgZtK16ri4pA4rbeqZIwL2eQQqpwIwdOH/9ONfWe7Ky3HqwyOXHPXubpBgE+eG0nUHOxy0CV
	n6bYi+NRLTl9gV1di0ReoNKKMB9p9WYEo9LqyebW5tRXzjp8sjf9ae/p2G9PWiWICZbauvsVSQY
	uKLinj+xqI9blXqjxsY34=
X-Received: by 2002:a17:902:c408:b0:2a0:afeb:fbbb with SMTP id d9443c01a7336-2a599ded4b5mr63604885ad.1.1768488848976;
        Thu, 15 Jan 2026 06:54:08 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm261120955ad.62.2026.01.15.06.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:54:08 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Thu, 15 Jan 2026 23:53:56 +0900
Subject: [PATCH] kunit: add bash completion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-kunit-completion-v1-1-4de6564962c4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TlBJ0b4SHcK2WioLtQjCvycdB
 2bmhYiBMEJbvRDwpkiHLyDqCtwy+BkZjYVBcqm5EA1bL0+JuWM/N0xFZlIrY+ykrFMSSnYGnOj
 5l12f8wdrRnFKYgAAAA==
X-Change-ID: 20260114-kunit-completion-265889f59c52
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2

Currently, kunit.py has many subcommands and options, making it difficult
to remember them without checking the help message.

Add --list-cmds and --list-opts to kunit.py to get available commands and
options, use those outputs in kunit-completion.sh to show completion.

This implementation is similar to perf and tools/perf/perf-completion.sh.

Example output:
  $ source tools/testing/kunit/kunit-completion.sh
  $ ./tools/testing/kunit/kunit.py [TAB][TAB]
  build   config  exec    parse   run
  $ ./tools/testing/kunit/kunit.py run --k[TAB][TAB]
  --kconfig_add  --kernel_args  --kunitconfig

Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst |  9 ++++++++
 tools/testing/kunit/kunit-completion.sh       | 33 +++++++++++++++++++++++++++
 tools/testing/kunit/kunit.py                  | 30 ++++++++++++++++++++++++
 tools/testing/kunit/kunit_tool_test.py        | 21 +++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 6697c71ee8ca020b8ac7e91b46e29ab082d9dea0..3c0b585dcfffbd3929d0eef1ab9376fa4f380872 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -335,3 +335,12 @@ command line arguments:
 
 - ``--list_tests_attr``: If set, lists all tests that will be run and all of their
   attributes.
+
+Command-line completion
+==============================
+
+The kunit_tool comes with a bash completion script:
+
+.. code-block:: bash
+
+	source tools/testing/kunit/kunit-completion.sh
diff --git a/tools/testing/kunit/kunit-completion.sh b/tools/testing/kunit/kunit-completion.sh
new file mode 100644
index 0000000000000000000000000000000000000000..3b9b68e3bc384c026f10f74b8a1df2129cb2cd50
--- /dev/null
+++ b/tools/testing/kunit/kunit-completion.sh
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+# bash completion support for KUnit
+
+_kunit_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
+
+_kunit()
+{
+	local cur prev words cword
+	_init_completion || return
+
+	local script="${_kunit_dir}/kunit.py"
+
+	if [[ $cword -eq 1 && "$cur" != -* ]]; then
+		local cmds=$(${script} --list-cmds 2>/dev/null)
+		COMPREPLY=($(compgen -W "${cmds}" -- "$cur"))
+		return 0
+	fi
+
+	if [[ "$cur" == -* ]]; then
+		if [[ -n "${words[1]}" && "${words[1]}" != -* ]]; then
+			local opts=$(${script} ${words[1]} --list-opts 2>/dev/null)
+			COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
+			return 0
+		else
+			local opts=$(${script} --list-opts 2>/dev/null)
+			COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
+			return 0
+		fi
+	fi
+}
+
+complete -o default -F _kunit kunit.py
+complete -o default -F _kunit kunit
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index cd99c1956331dbbfb06cf4ddf130db3dcf2a7c31..a5aee1eb88e65fa2387b2623642d2ee9a66db600 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -323,6 +323,17 @@ def get_default_jobs() -> int:
 		return ncpu
 	raise RuntimeError("os.cpu_count() returned None")
 
+def add_completion_opts(parser: argparse.ArgumentParser) -> None:
+	parser.add_argument('--list-opts',
+			    help=argparse.SUPPRESS,
+			    action='store_true')
+
+def add_root_opts(parser: argparse.ArgumentParser) -> None:
+	parser.add_argument('--list-cmds',
+			    help=argparse.SUPPRESS,
+			    action='store_true')
+	add_completion_opts(parser)
+
 def add_common_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
@@ -374,6 +385,8 @@ def add_common_opts(parser: argparse.ArgumentParser) -> None:
 			    help='Additional QEMU arguments, e.g. "-smp 8"',
 			    action='append', metavar='')
 
+	add_completion_opts(parser)
+
 def add_build_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
@@ -569,6 +582,7 @@ subcommand_handlers_map = {
 def main(argv: Sequence[str]) -> None:
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
+	add_root_opts(parser)
 	subparser = parser.add_subparsers(dest='subcommand')
 
 	# The 'run' command will config, build, exec, and parse in one go.
@@ -603,12 +617,28 @@ def main(argv: Sequence[str]) -> None:
 	parse_parser.add_argument('file',
 				  help='Specifies the file to read results from.',
 				  type=str, nargs='?', metavar='input_file')
+	add_completion_opts(parse_parser)
 
 	cli_args = parser.parse_args(massage_argv(argv))
 
 	if get_kernel_root_path():
 		os.chdir(get_kernel_root_path())
 
+	if cli_args.list_cmds:
+		print(" ".join(subparser.choices.keys()))
+		return
+
+	if cli_args.list_opts:
+		target_parser = subparser.choices.get(cli_args.subcommand)
+		if not target_parser:
+			target_parser = parser
+
+		# Accessing private attribute _option_string_actions to get
+		# the list of options. This is not a public API, but argparse
+		# does not provide a way to inspect options programmatically.
+		print(' '.join(target_parser._option_string_actions.keys()))
+		return
+
 	subcomand_handler = subcommand_handlers_map.get(cli_args.subcommand, None)
 
 	if subcomand_handler is None:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bbba921e0eacb18663abfcabb2bccf330d8666f5..a7f09a6c97a473ff85e087d17c2f5faf7755b994 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -11,11 +11,13 @@ from unittest import mock
 
 import tempfile, shutil # Handling test_tmpdir
 
+import io
 import itertools
 import json
 import os
 import signal
 import subprocess
+import sys
 from typing import Iterable
 
 import kunit_config
@@ -855,5 +857,24 @@ class KUnitMainTest(unittest.TestCase):
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', filter='', filter_action=None, timeout=300),
 		])
 
+	@mock.patch.object(sys, 'stdout', new_callable=io.StringIO)
+	def test_list_cmds(self, mock_stdout):
+		kunit.main(['--list-cmds'])
+		output = mock_stdout.getvalue()
+		output_cmds = sorted(output.split())
+		expected_cmds = sorted(['build', 'config', 'exec', 'parse', 'run'])
+		self.assertEqual(output_cmds, expected_cmds)
+
+	@mock.patch.object(sys, 'stdout', new_callable=io.StringIO)
+	def test_run_list_opts(self, mock_stdout):
+		kunit.main(['run', '--list-opts'])
+		output = mock_stdout.getvalue()
+		output_cmds = set(output.split())
+		self.assertIn('--help', output_cmds)
+		self.assertIn('--kunitconfig', output_cmds)
+		self.assertIn('--jobs', output_cmds)
+		self.assertIn('--kernel_args', output_cmds)
+		self.assertIn('--raw_output', output_cmds)
+
 if __name__ == '__main__':
 	unittest.main()

---
base-commit: b71e635feefc852405b14620a7fc58c4c80c0f73
change-id: 20260114-kunit-completion-265889f59c52

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


