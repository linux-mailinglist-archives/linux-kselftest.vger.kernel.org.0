Return-Path: <linux-kselftest+bounces-40364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E54AB3CEC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 20:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618671897D4C
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 18:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2082DAFD8;
	Sat, 30 Aug 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBzU1Ts9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB342DAFC5;
	Sat, 30 Aug 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579401; cv=none; b=LyRoAxRCd34uz/LxhdiNRgYPRUO8YgLULCRU4EwitoJy7Ta/8sUURFxrgikTXLoWvvzyaP2W6USzM3VZLzqWw5E88SPiRrlW35lskqSq5GwFLVbOkV6yTu2V3VEK7XC9EY5pwrxaOXDPqcjccVHJAfKzWkvy9sI0y0XhIzpYGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579401; c=relaxed/simple;
	bh=c9xqtmLf/Uv9cBZ4HCVvZ/CLHcFtriX2GWiu52jCUC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLQAJjHdxWVmEFzX4XphG+X3eQHSdSlpeYVYjACSmOgwRwpn1C+MbPCf7t7O9R7+5CBgiGUw/15OpedIW4V1g7/aI18J1GGCW0JjdyqIqBo3lcAJS//H+s9K2S2RcyXvzWCbOhlU3NJaX9FnETQoloj7D3VOdQJENQMG9Zp3c8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBzU1Ts9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEF9C4CEF6;
	Sat, 30 Aug 2025 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756579401;
	bh=c9xqtmLf/Uv9cBZ4HCVvZ/CLHcFtriX2GWiu52jCUC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBzU1Ts9N6LqtM82PE0laXEuBe2fgFDv5+vQnLZHk0gFz8UBVnbm5/9whoOG+ATPM
	 tCz0c9Wou4HbcltN2DEh3ljDztsc+8nZWSNtvWI57ajx33asewTPKkj9arbnSxXyzn
	 A3lJJWnnpwyMGf6obA/aBydIBQoU9MOQgDHWeRqYqV6zATlSSu9ny5ISxJLBvD1S8g
	 LZX2JNMl8ieFILsAwKrgNFv7PqAXFe0MX4zEnae3onSnSYizOHGfu3M1NcCm0M3CWL
	 r1ILf4weiYTAxZx/FbwKDFpgMK5yUOyznpNV56JaJxN+iYMjJCaRtq4+Vy2njaSPrz
	 mKpfI97GjHqqg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	joe@dama.to,
	leitao@debian.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: net: py: don't default to shell=True
Date: Sat, 30 Aug 2025 11:43:17 -0700
Message-ID: <20250830184317.696121-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250830184317.696121-1-kuba@kernel.org>
References: <20250830184317.696121-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overhead of using shell=True is quite significant.
Micro-benchmark of running ethtool --help shows that
non-shell run is 2x faster.

Runtime of the XDP tests also shows improvement:
this patch: 2m34s 2m21s 2m18s 2m18s
    before:     2m54s 2m36s 2m34s

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index b188cac49738..e7155b6db9a3 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -29,9 +29,12 @@ import time
     """
     Execute a command on local or remote host.
 
+    @shell defaults to false, and class will try to split @comm into a list
+    if it's a string with spaces.
+
     Use bkg() instead to run a command in the background.
     """
-    def __init__(self, comm, shell=True, fail=True, ns=None, background=False,
+    def __init__(self, comm, shell=None, fail=True, ns=None, background=False,
                  host=None, timeout=5, ksft_wait=None):
         if ns:
             comm = f'ip netns exec {ns} ' + comm
@@ -45,6 +48,10 @@ import time
         if host:
             self.proc = host.cmd(comm)
         else:
+            # If user doesn't explicitly request shell try to avoid it.
+            if shell is None and isinstance(comm, str) and ' ' in comm:
+                comm = comm.split()
+
             # ksft_wait lets us wait for the background process to fully start,
             # we pass an FD to the child process, and wait for it to write back.
             # Similarly term_fd tells child it's time to exit.
@@ -111,7 +118,7 @@ import time
 
         with bkg("my_binary", ksft_wait=5):
     """
-    def __init__(self, comm, shell=True, fail=None, ns=None, host=None,
+    def __init__(self, comm, shell=None, fail=None, ns=None, host=None,
                  exit_wait=False, ksft_wait=None):
         super().__init__(comm, background=True,
                          shell=shell, fail=fail, ns=ns, host=host,
-- 
2.51.0


