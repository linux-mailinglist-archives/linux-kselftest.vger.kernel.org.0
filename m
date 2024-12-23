Return-Path: <linux-kselftest+bounces-23733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C159FAB8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265381883BC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A82188A0C;
	Mon, 23 Dec 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="URuq4j4f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB313C682;
	Mon, 23 Dec 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942778; cv=none; b=WLMjjI8w6tLP5ZsxzQHs3Kxsij0osk0NMRwCGHHhEdFWPWSV2VfHPSZQQEPViMHrRWlfrfpp9CSe1SHYcu848MhPyxaWvM4DbLk4CUmOgGDSZGDiPMN0Skvii+UnPNZbDOdx55HMM/NA/eDn517ECT1gAeeL98z2jRbpKWm1e0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942778; c=relaxed/simple;
	bh=Msxb2zAg7IhmamyxKf2nGcR5dyO5ozyS/RBV8+TaMzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjJUtwDSpFY4iBqSHTHcD/24zVZAIjE2AyR+3jEzBIfBRul6IjXLgxUoRsVC6pf7MWIhdSlJVTuowOjWNcGhhC24RdiFpf0jbZpvW52xOKBjA+mD6gOHaLinh9ABFNQtuDr2ZvaKDqh+0SstwHUIjy+cQNhyCadE03JJHqWxW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=URuq4j4f; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734942776; x=1766478776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Msxb2zAg7IhmamyxKf2nGcR5dyO5ozyS/RBV8+TaMzE=;
  b=URuq4j4fX2gVkI4E1kpCQDORCVwck3tluYaOjpMBM0JoKwhBe9HqiKOX
   nN3x9I2ueLd/B2QLRI+gnFjBKVjrMA50kKVTIKPVbrcYhT1g8x9I/uBWu
   cljmSptfG774/Kmbjc9YxXciRI6QB0Q2AE4URhEN+o1D/1CMewx38iLnp
   WDdTuaPl4cMUD2OE1Rn3wZw7/q7dDYlMd+BQGu1rcBzsZZ8rACwSHlnF8
   DaGPq6rRzWRulr5+1F9qojmvrZWn20Ip13Emeivnqhs0RX3BAVng/m7g9
   0rrcqa+kWObyTeweYfrkbnySHC/8aSksBlnPsX9zO+G1iMqIkxeGJgwQG
   Q==;
X-CSE-ConnectionGUID: nTcPLerkQySVIexPCOS8iA==
X-CSE-MsgGUID: iD5CtAtYSdilFLwxwZKjqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="173028163"
X-IronPort-AV: E=Sophos;i="6.12,256,1728918000"; 
   d="scan'208";a="173028163"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 17:32:46 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9ACAAD4809;
	Mon, 23 Dec 2024 17:32:44 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6B3EAD4C3B;
	Mon, 23 Dec 2024 17:32:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C46E920076D2C;
	Mon, 23 Dec 2024 17:32:43 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 11C331A006C;
	Mon, 23 Dec 2024 16:32:42 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v2] selftests/Makefile: override the srctree for out-of-tree builds
Date: Mon, 23 Dec 2024 16:33:42 +0800
Message-ID: <20241223083342.1172756-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28876.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28876.006
X-TMASE-Result: 10--2.378300-10.000000
X-TMASE-MatchedRID: QxNw5Kr7aBeh8NIgadoMHh1kSRHxj+Z5ohrMq0nEhQciKqWY7QWAeyJ1
	YT6M2y/ptjClCUseMxHZ5nzC46YpxcwitucT3dE7v8fLAX0P50DNKdtHc3A3XFHpIy6wt5Uw2Ca
	d5s625rB2Ve4lIas8vPv7YatA3DRB0ekSi+00U24ReM8i8p3vgI5UEPjB4tXTYKqjwB8QwAfkYB
	DLwsbmZ5kvRcwHwyS1nagtny7ZPcQfE8yM4pjsDwtuKBGekqUpnH7sbImOEBR1v1HNMzZow0AQX
	SvqbUiaMuIFhQgRTV6GEHijen4mM0e9GdKscJD29GHfJKIOMD1pNGcgqiS/zkoymDxKZ01/zS24
	WhZE0s+bDRBqS2n66yzP5xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
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

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: Masahiro Yamada <masahiroy@kernel.org>

V2:
 - handle srctree in selftests itself rather than the linux' top Makefile # Masahiro Yamada <masahiroy@kernel.org>

V1: https://lore.kernel.org/lkml/20241217031052.69744-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3d8a80abd4f0..ab82278353cf 100644
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


