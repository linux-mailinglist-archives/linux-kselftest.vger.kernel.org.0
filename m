Return-Path: <linux-kselftest+bounces-24542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A5A116CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 02:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DC71889B51
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 01:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E32227BAE;
	Wed, 15 Jan 2025 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="UkHSp+En"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F12227B88;
	Wed, 15 Jan 2025 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905610; cv=none; b=AEo8t9qWGDT872xwn4hqHBUD+4oMuLJ/3al+iWu7B4Ga6r9ng4pWvizIwR2P3O9cFR091kygyhEH42jPmaQviriLgTRugzjcSeYaIytE2vTCET+xUVG5/8xiz2GgrecCQYsnBE09MOj7GRtk72K8cInMcbl4vgGRixAH5xXVUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905610; c=relaxed/simple;
	bh=21TcC/rql3eON+hX7CuhqWrvpu5XXzotwJKQP7ydNKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0foORLZqAgUW+JHT7/T+1ayDIyUnCAFWweNetv0afLonIh5tTFrPw9AWYT1t5Vx7Q6OGJn7xLRlx/IRGz0yJ126Y6mXWor550C3Az4BTdgqkEFudrsMwRq5sh0NV/FmpHmuj+cENbvhe7MxRi0DYgcrbDDeawKziCouV+ZTdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=UkHSp+En; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736905609; x=1768441609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=21TcC/rql3eON+hX7CuhqWrvpu5XXzotwJKQP7ydNKM=;
  b=UkHSp+EnLmK5Y9PKG1yRGdcokuHJO7BQQDl1AIug1YMz+LtykOFY8vPD
   YGPJo6BvrjQA6/ZEvaZf+FRSkjRiwPkCuxzFJvxoKGhfb1K+wGeNwApkb
   pNGMEvBFVzM80XFRt5Xz/ZYXYXNkS/Xgz3o2zePYIVDICrYkkvHxrMu7M
   iIuaiJdXQfx8VjrG4WKA9Jl8jjhICUxHCTKK7oODcvIn3aii1qXvu5ob7
   pUqqcAJssdgfqMcJOld28OGtHZR2CcwPAYLJBHFBJE6J9J77cvlFgvAUv
   lwA50y+Ibd8z4sEttOwDe4sh9boDq3oVwihNAfRZlKZCewxl1ePqm/fc1
   w==;
X-CSE-ConnectionGUID: Nzg6XFEJSGGyZ7Of+MnG7g==
X-CSE-MsgGUID: 46L8MYSDRt2SYdtRHFf7wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="165479798"
X-IronPort-AV: E=Sophos;i="6.12,315,1728918000"; 
   d="scan'208";a="165479798"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 10:46:40 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8EA0CD500F;
	Wed, 15 Jan 2025 10:46:37 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5F8D6D5036;
	Wed, 15 Jan 2025 10:46:37 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D055120071A06;
	Wed, 15 Jan 2025 10:46:36 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B25311A0071;
	Wed, 15 Jan 2025 09:46:35 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH bpf-next v3] selftests/Makefile: override the srctree for out-of-tree builds
Date: Wed, 15 Jan 2025 09:47:34 +0800
Message-ID: <20250115014734.438225-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28924.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28924.003
X-TMASE-Result: 10--2.378300-10.000000
X-TMASE-MatchedRID: QxNw5Kr7aBeh8NIgadoMHh1kSRHxj+Z5ohrMq0nEhQciKqWY7QWAeyJ1
	YT6M2y/ptjClCUseMxHZ5nzC46YpxcwitucT3dE7v8fLAX0P50DNKdtHc3A3XFHpIy6wt5Uw2Ca
	d5s625rB2Ve4lIas8vPv7YatA3DRB0ekSi+00U24ReM8i8p3vgI5UEPjB4tXTYKqjwB8QwAfkYB
	DLwsbmZ5kvRcwHwyS1nagtny7ZPcQfE8yM4pjsDwtuKBGekqUpnH7sbImOEBRcrZUZpIpVuY0MN
	210hdsMUVQg0hCHTxQSbjtxD1tRN3YVT44NixONSphYGXunSvyR88aL5Jmd22FLtpZ6hBUpo9GD
	1VwsMaabDRBqS2n66yzP5xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Fixes an issue where out-of-tree kselftest builds fail when building
the BPF and bpftools components. The failure occurs because the top-level
Makefile passes a relative srctree path to its sub-Makefiles, which
leads to errors in locating necessary files.

For example, the following error is encountered:

```
$ make V=1 O=$build/ TARGETS=hid kselftest-all
...
make -C ../tools/testing/selftests all
make[4]: Entering directory '/path/to/linux/tools/testing/selftests/hid'
make  -C /path/to/linux/tools/testing/selftests/../../../tools/lib/bpf OUTPUT=/path/to/linux/O/kselftest/hid/tools/build/libbpf/ \
            EXTRA_CFLAGS='-g -O0'                                      \
            DESTDIR=/path/to/linux/O/kselftest/hid/tools prefix= all install_headers
make[5]: Entering directory '/path/to/linux/tools/lib/bpf'
...
make[5]: Entering directory '/path/to/linux/tools/bpf/bpftool'
Makefile:127: ../tools/build/Makefile.feature: No such file or directory
make[5]: *** No rule to make target '../tools/build/Makefile.feature'.  Stop.
```

To resolve this, override the srctree in the kselftests's top Makefile
when performing an out-of-tree build. This ensures that all sub-Makefiles
have the correct path to the source tree, preventing directory resolution
errors.

Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Tested-by: Quentin Monnet <qmo@kernel.org>
---
Cc: Masahiro Yamada <masahiroy@kernel.org>

V3:
  collected Tested-by and rebased on bpf-next

V2:
 - handle srctree in selftests itself rather than the linux' top Makefile # Masahiro Yamada <masahiroy@kernel.org>

V1: https://lore.kernel.org/lkml/20241217031052.69744-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2401e973c359..f04a3b0003f6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -154,15 +154,19 @@ override LDFLAGS =
 override MAKEFLAGS =
 endif
 
+top_srcdir ?= ../../..
+
 # Append kselftest to KBUILD_OUTPUT and O to avoid cluttering
 # KBUILD_OUTPUT with selftest objects and headers installed
 # by selftests Makefile or lib.mk.
+# Override the `srctree` variable to ensure it is correctly resolved in
+# sub-Makefiles, such as those within `bpf`, when managing targets like
+# `net` and `hid`.
 ifdef building_out_of_srctree
 override LDFLAGS =
+override srctree := $(top_srcdir)
 endif
 
-top_srcdir ?= ../../..
-
 ifeq ("$(origin O)", "command line")
   KBUILD_OUTPUT := $(O)
 endif
-- 
2.44.0


