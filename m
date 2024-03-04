Return-Path: <linux-kselftest+bounces-5836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE80870654
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 16:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF11282996
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BB1481B7;
	Mon,  4 Mar 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ic2QKeqC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A811B273;
	Mon,  4 Mar 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567959; cv=none; b=FkoUSALjyKmjIt44shNiE85tWRIyYhzgxfhsGk6PwR8sT9Idu9CxGSe6BnUCDrSrZu5dXUcF5AaMDrmVAMB/vXyXVkWXNdvhZSCfjSSBIWiqmWKjL1RYTaMMZVhnSAdoNsu+M9Dawa7L5CsLJBy3X1IcgWLotL4BVRtMy7LYILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567959; c=relaxed/simple;
	bh=ZjZh6MK4cK0nPO2xkcbSCU48Cy25SeM0mup4wcmCJx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iUQBmHQGC/+N//hpzz6ill+cqw/i/Xh3GMMb05OVMf1MordFaTH1cRsN/E/bYCzdxkyL0+kZBgDgpgp8mLo7Ckw3Xr6oJZjhCLL5hC8lZYtW65td2w3qVGqHUeGpZcpR9981wqLUU/RIoUNoG8E0kVz8J4qSWj6+Quxpvy28c5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ic2QKeqC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709567956;
	bh=ZjZh6MK4cK0nPO2xkcbSCU48Cy25SeM0mup4wcmCJx0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ic2QKeqCWnv2YCtCbqdlmm6TQXqw+vJJ4o9Y/hkzs526iD/Xg6sjTT2v2rfRalK5r
	 E9RIMd9iBKWZlKh4PJXTDUWMAoOt6qrAJvjk+qpQi4TE0Cc/IN3ifJvt38WogftARr
	 cTyMSY/7nqGn60ybvTZgWfZdsjT5qBpMJk/69S9M5JUHwmvOdGH9GkTCVdBmLDfB4E
	 cOIrZCquDjSTNw5Vm6cVjXuOVrJ+/YbfrjHo8bMEvb/itiKb6+LgALQqcypmQ7AfwF
	 FOiYdUEOiwrnOjX9t8VcCWwgPbUcuLCw0ArSnkoj66tIqoAJ2f38jAs8jvzCgpSm7g
	 kxkM1qltBck7g==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 04BA037820D7;
	Mon,  4 Mar 2024 15:59:13 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] selftests/exec: Add the overall result line accourding to TAP
Date: Mon,  4 Mar 2024 20:59:23 +0500
Message-Id: <20240304155928.1818928-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following line is missing from the test's execution. Add it to make
it fully TAP conformant:
  # Totals: pass:27 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/exec/binfmt_script.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/exec/binfmt_script.py b/tools/testing/selftests/exec/binfmt_script.py
index 05f94a741c7aa..2c575a2c0eab4 100755
--- a/tools/testing/selftests/exec/binfmt_script.py
+++ b/tools/testing/selftests/exec/binfmt_script.py
@@ -16,6 +16,8 @@ SIZE=256
 NAME_MAX=int(subprocess.check_output(["getconf", "NAME_MAX", "."]))
 
 test_num=0
+pass_num=0
+fail_num=0
 
 code='''#!/usr/bin/perl
 print "Executed interpreter! Args:\n";
@@ -42,7 +44,7 @@ foreach my $a (@ARGV) {
 # ...
 def test(name, size, good=True, leading="", root="./", target="/perl",
                      fill="A", arg="", newline="\n", hashbang="#!"):
-    global test_num, tests, NAME_MAX
+    global test_num, pass_num, fail_num, tests, NAME_MAX
     test_num += 1
     if test_num > tests:
         raise ValueError("more binfmt_script tests than expected! (want %d, expected %d)"
@@ -80,16 +82,20 @@ def test(name, size, good=True, leading="", root="./", target="/perl",
         if good:
             print("ok %d - binfmt_script %s (successful good exec)"
                   % (test_num, name))
+            pass_num += 1
         else:
             print("not ok %d - binfmt_script %s succeeded when it should have failed"
                   % (test_num, name))
+            fail_num = 1
     else:
         if good:
             print("not ok %d - binfmt_script %s failed when it should have succeeded (rc:%d)"
                   % (test_num, name, proc.returncode))
+            fail_num = 1
         else:
             print("ok %d - binfmt_script %s (correctly failed bad exec)"
                   % (test_num, name))
+            pass_num += 1
 
     # Clean up crazy binaries
     os.unlink(script)
@@ -166,6 +172,8 @@ test(name="two-under-trunc-arg", size=int(SIZE/2), arg=" ")
 test(name="two-under-leading",   size=int(SIZE/2), leading=" ")
 test(name="two-under-lead-trunc-arg", size=int(SIZE/2), leading=" ", arg=" ")
 
+print("# Totals: pass:%d fail:%d xfail:0 xpass:0 skip:0 error:0" % (pass_num, fail_num))
+
 if test_num != tests:
     raise ValueError("fewer binfmt_script tests than expected! (ran %d, expected %d"
                      % (test_num, tests))
-- 
2.39.2


