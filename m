Return-Path: <linux-kselftest+bounces-48363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E54CFBA58
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 03:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25975309A6CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858123A98E;
	Wed,  7 Jan 2026 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+8r0fkw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B95230D35
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751183; cv=none; b=fHN5FPALyXeqy3QKfA97FZKCHROlDGqTFLOYmT/nXt+XClk9qXQ5ZlQD0YrN6aMKgI02ddzPJRMF0yCcFRDUx4B2yxXnV6V1Cvn8SttrQun3ulBWwdEdCkb5EcHCjv4w8IiZbknnTZYTNE0b+nzCvOnEbDop/9VnDPtQLHp+bKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751183; c=relaxed/simple;
	bh=fCNgOzeicMmEuMqrRSPuUBXGA6QlmVhzx8zl7naLVHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ys56TtiAvPSjeNFCOYxDbS7GWu1+oiZCwG9v1wAjIWv85hFqRxhyycx7wFkXA4EAC4sTaon3vylAfV1HYI9iJMPJT0CmehwAjWvpk809tlMe8hqBPVq/vDHyoehZE24JnQoC7p+02rPL8cA7NxY/mVHhE/NbTvpM17DEQPGyOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+8r0fkw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so2429978b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 17:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767751181; x=1768355981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPKJBtAWhngfzBfrJffHmf//LwUHhRdPEYWcMzo5trE=;
        b=Q+8r0fkwC1hqUA7KUsttvOWtLTuHyGb4zMXchgU/M1zeGMlsW74oYwC2NaE1Kcjn7s
         FTOmvHCXIUU5eXpuYWl6HDVhBR0CyQ7j4KXMLBNADJi+GiNU7iaLgqlxpcQ71mpwD0cq
         7XAIPHBQj4cgCeytNdTZZub1K82WKRwp8r+kmzsa0+5wGiCTT/m0OwP24Q0zXUgCo4Nu
         8VFNWuUw9DmAp6hnX9nb/oGXbCixlP2WcLGDnf5qh8QWRouufyqM61eiu7dVsgWAg3pD
         OK8nv18RyjF0RbI+toPqfvL/kQ+4yFgjusrXNukUBuwYYnYCW/TPqBEQP1Sr7qFS8BCu
         XDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767751181; x=1768355981;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pPKJBtAWhngfzBfrJffHmf//LwUHhRdPEYWcMzo5trE=;
        b=PruwxQP32mtOH5VTiNHhvDeeZx34Vulo3c4bLWcWaJ9C6jOSuXa9zFN74vYwi7xVQH
         9r/QQ5bMhfXv+x2zFm9j3wfgynDUNcMtQF+6Cgg6Q4bpOcbGmaxNnKsL0aUGQEGc3CxN
         jCuxDe/oYkguH2me2XPhVbjJ6N/akB26M9GKyREVZV//IuLxK92sWuEA4dNJYTK1PkJa
         +1zFlUT7Sc3suZLjfBiYYUklSpFbvR8J/yEjuJWN5QxJkbYzwEuAU3nhdCfJhaAtdM/v
         xkc6iTdO7cBR+kY6rMdzSx0/aXYKYtp+9pWPo3hH6swho1QhrwcZCCPNT7sze+S42h/6
         6/yg==
X-Gm-Message-State: AOJu0YwlGj97aNYBkXKqKv2RJK1dl59QTdZtQeUuJgDVuKFA7Nk2YJ67
	TnXdWGAcJD7hSaJivHaQwf6qm94KI8NDl14PT+lSRY0QoiZr62jaPz83N7zDr0PAzz4/xqco6RY
	jgnIJXzgbn0nxuw==
X-Google-Smtp-Source: AGHT+IGIU8sCgbuagvzSkRlmcHAHbNa/SrZo5u0sCdUV5I2bLY7fjCFau6leaTLOvBZCI2fLGEQOutcorWNBpg==
X-Received: from pfbfj31.prod.google.com ([2002:a05:6a00:3a1f:b0:7dd:8bba:639b])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:300d:b0:819:9dee:7a4a with SMTP id d2e1a72fcca58-81b7d65603dmr963459b3a.6.1767751180652;
 Tue, 06 Jan 2026 17:59:40 -0800 (PST)
Date: Wed,  7 Jan 2026 09:59:34 +0800
In-Reply-To: <20260107015936.2316047-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107015936.2316047-1-davidgow@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107015936.2316047-2-davidgow@google.com>
Subject: [PATCH v2 2/2] kunit: tool: test: Don't rely on implicit working
 directory change
From: David Gow <davidgow@google.com>
To: shuah@kernel.org, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

If no kunitconfig_paths are passed to LinuxSourceTree() it falls back to
DEFAULT_KUNITCONFIG_PATH. This resolution only works when the current
working directory is the root of the source tree. This works by chance
when running the full testsuite through the default unittest runner, as
some tests will change the current working directory as a side-effect of
'kunit.main()'. When running a single testcase or using pytest, which
resets the working directory for each test, this assumption breaks.

Explicitly specify an empty kunitconfig for the affected tests.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20251230-kunit-pytest-v1-2-e2dae0da=
e200@linutronix.de/
- No-op rebase on top of kselftest/kunit

---
 tools/testing/kunit/kunit_tool_test.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/k=
unit_tool_test.py
index 30ac1cb6c8ed..238a31a5cc29 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -477,7 +477,8 @@ class LinuxSourceTreeTest(unittest.TestCase):
 		want_kconfig =3D kunit_config.Kconfig()
 		want_kconfig.add_entry('NOT_REAL', 'y')
=20
-		tree =3D kunit_kernel.LinuxSourceTree('', kconfig_add=3D['CONFIG_NOT_REA=
L=3Dy'])
+		tree =3D kunit_kernel.LinuxSourceTree('', kunitconfig_paths=3D[os.devnul=
l],
+						    kconfig_add=3D['CONFIG_NOT_REAL=3Dy'])
 		self.assertTrue(want_kconfig.is_subset_of(tree._kconfig), msg=3Dtree._kc=
onfig)
=20
 	def test_invalid_arch(self):
@@ -489,7 +490,7 @@ class LinuxSourceTreeTest(unittest.TestCase):
 			return subprocess.Popen(['echo "hi\nbye"'], shell=3DTrue, text=3DTrue, =
stdout=3Dsubprocess.PIPE)
=20
 		with tempfile.TemporaryDirectory('') as build_dir:
-			tree =3D kunit_kernel.LinuxSourceTree(build_dir)
+			tree =3D kunit_kernel.LinuxSourceTree(build_dir, kunitconfig_paths=3D[o=
s.devnull])
 			mock.patch.object(tree._ops, 'start', side_effect=3Dfake_start).start()
=20
 			with self.assertRaises(ValueError):
--=20
2.52.0.351.gbe84eed79e-goog


