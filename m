Return-Path: <linux-kselftest+bounces-48713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D6D108BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 05:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBADE300E4DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 04:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40A30C37C;
	Mon, 12 Jan 2026 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPuwW9ni"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84037303C93
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191256; cv=none; b=TWDs9PSicVjKe2nfSfr3KYCSpKcp3aQjSZF7cmPafi6d+SJg0/bMALuEs3cmJ7fptzZ+MJJVTPjqMuW7rnSLJIT6O0BHRhQEDXWOsTvn7MhvhUgXyY59GkmVPLvuoARBs9KKNpRBzX9FCqr/gUF2j8Jl5SRbTROh7ucsKdWowZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191256; c=relaxed/simple;
	bh=zEZ4FJ91wM5SW6mtBv+cwt0syhCWtJG/ZFQoV/5vuKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uoq9/cwLsp2JOo0Duemx24agSxxJP51vORn4sQFugTjfc+TmHXGziSUpVa2YkqN2/Pu6DtQYrFIZYYLxPB7Bha6BU1gfodZR4hkT4ajHPBpoX1revfKCiq2vP4RahhYmgX6GQ680M7zhg1FNovPP7qd40HgJI+kayuMlYJzRlEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPuwW9ni; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81df6a302b1so2330390b3a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 20:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768191254; x=1768796054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXUxwFIq7nIMAiSrPnHffaEFsbuxmM0yUEysHSd0Tjw=;
        b=aPuwW9ni2A9FSX0RLudh8RlTeU9lBgfjdqhRhDhYk7Y8o44TKGyzBULo93TJE8z3kC
         PN0u02tjkdq9GRGrvTqNCTy4yOIsHMdO5zmmTSr4THa5pM1LHBbgaMblDy8eZZCT/Td6
         pkSMFWBUZNOkatd5zUfDiXetCYE4ps0X9VAJQLRVpkm/wvmt/vU4+IRyUE7JHGq8FYJY
         9y9A67dekRF6CkeH0Ieqww+amgLykuvjC8jt7wALltqPJVFUmI8AMjhleFREgyJMo9Wi
         jOpRZwuQCp0qWOggLcUh+mq7usYwVdz7fB3IZR8kOKKG18prpg9+qnVF0UKofhVGlmiv
         wnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768191254; x=1768796054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXUxwFIq7nIMAiSrPnHffaEFsbuxmM0yUEysHSd0Tjw=;
        b=oSYfT+PkK3xvcUv+wPL9/Eh7Jl86Bk4lzZMPb9+Tb20V+//864H1EARYBHPF+os/CG
         36UALFG+iQJzEClSCW5SKXlhOvNaSIMeeh6YAVKzNJQu1VfYYPB5HKgx8wVOP/EJHBBr
         1sg+qwqwmjUNRJDUsGuqnUAJbTcdDdfPAK192mWM+iT1ZlbfnoYuAKliWZKBXZxzLwUV
         eROTHbLBnuirNnS9sXhZpcE2NZZB7sG9Ln2+0UQIetIPGR0q1+PlmBNQ+vAFvnA+U+bi
         jKh3yYka63C61qb6rM1cBApVquWGiRfnb/egGPbUYDgs2wr5GCfy0N/ZuITYJ8Q1gTfA
         d60Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqu0fd1COhGKlB9sI/z4TGRdo832TjnbD1QK/cNApnyJvvEPeGwa4O1c2BWGyHWrbYWfcf09U7/Ic1YIyc40g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6n1gbffMyeocpbk6OQbffkfjjboL9K997UaYvqxdg22QlUia
	UKOQKfPHi6hBx58XAFt0V2b/ZP1PGqUv5Ligk/o1IQOJpFh00F/vcC4=
X-Gm-Gg: AY/fxX5Tc9Y7L7kvJ+HErbDw8ft464jx+fqTzFNPpP7ncPo5BPzuuxZMez3ax/ofrbK
	d3/L50l5tQJfYg/hE0K9FLJvV5TFaLDMCklRKsXHyPSsh4Nr/evQn8ascYuOZyOjolEvHcVhG8D
	zIMP+hTxYS/eh9fnbCN8mu6poWXibSs7MHrEv2JOOnACPutQmossKFD7JhtqSsxatmHl1H71SR5
	F63cAnjjoNI0cOmClEXrWNO9wP2KaRddA9S6A40ZfZN5u1njB3T24/a0j9hQzCa1okXTWwUnvhb
	c+tVaOSRg9vSiv9rN++un138GMfDDIEOBGK2dCIOfWePiOHtws/gyQjKJz3pa+OSPoIpY6m13p3
	Ws/FMTW8ljK8Sg4BaEmPtPsPZftfCumHvWnufXYCLlV3g9f7pX6oSD3wGMMgCY2GJ8ereQfRIXC
	qyrc0ysfeZXeggSMrTmq0ayUdqQHQq9a+7ABKOlA+t
X-Google-Smtp-Source: AGHT+IFR2xRoN/aXN1qsDiZrft89+zKTzqGmIr0wW7Zg2bDoZGYSZ2ApSgKw7F11Pg6dEuplZHQW+A==
X-Received: by 2002:a05:6a00:6c9d:b0:81f:3a83:9756 with SMTP id d2e1a72fcca58-81f3a839ee5mr5674290b3a.30.1768191253833;
        Sun, 11 Jan 2026 20:14:13 -0800 (PST)
Received: from localhost.localdomain ([38.190.47.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81c96d762f8sm10901231b3a.64.2026.01.11.20.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 20:14:13 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com
Cc: raemoar63@gmail.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Jinseok Kim <always.starving0@gmail.com>
Subject: [PATCH] kunit: tool: suppress confusing error output in test
Date: Sun, 11 Jan 2026 20:13:22 -0800
Message-ID: <20260112041322.2168-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running kunit_tool_test.py, the test_run_raw_output_invalid test
prints invalid usage text and error messages to stderr. This happens because the
test triggers kunit.main() with an invalid argument, causing argparse to
print the usage and exit.

This output is confusing to the user because it looks like a test failure
or usage error, even though the test passed successfully. Furthermore,
argparse displays 'usage: kunit_tool_test.py run ...', which is misleading
since the test script itself does not accept the 'run' command.

This patch mocks sys.stderr in the test to suppress this expected error
output, making the test execution output cleaner.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 tools/testing/kunit/kunit_tool_test.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bbba921e0eac..7a8ba8e4f1d4 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -8,6 +8,7 @@

 import unittest
 from unittest import mock
+import io

 import tempfile, shutil # Handling test_tmpdir

@@ -688,8 +689,9 @@ class KUnitMainTest(unittest.TestCase):

 	def test_run_raw_output_invalid(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		with self.assertRaises(SystemExit) as e:
-			kunit.main(['run', '--raw_output=invalid'])
+		with mock.patch('sys.stderr', new=io.StringIO()):
+			with self.assertRaises(SystemExit) as e:
+				kunit.main(['run', '--raw_output=invalid'])
 		self.assertNotEqual(e.exception.code, 0)

 	def test_run_raw_output_does_not_take_positional_args(self):
--
2.43.0

