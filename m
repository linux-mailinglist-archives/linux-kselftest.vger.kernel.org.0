Return-Path: <linux-kselftest+bounces-20600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15609AF709
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E281E1C20D2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2DC1537C8;
	Fri, 25 Oct 2024 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FWskN4Eu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F597C0BE;
	Fri, 25 Oct 2024 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820453; cv=none; b=fJwaFF6Z1K9dNtxEkhI7PLYbyKvp1BvKyfat8QUT9IdReAdLf4kty0eG8pgUG/B/fRed4W/1v+RMgqcEYzm7XrruKxDmSyKXFYv7o7FW+MsmRyhN9VBx4u33OuD8tkTedF8ntqmJUhPMhPUnPF8cKKoieORcJbZS5jdH3qloQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820453; c=relaxed/simple;
	bh=Nn9+6N/wjtkyrB4OkpKbzfIbJW3ll5RS6cPN6VWxA1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgxG2E03lCNjyEQ2jYmLzIj4MNlaw815xFfvHekpnU8aF/CgtQCo/E5ILqapMtqgwY0e0NT/qa/2WTLLSZgzHxDh4VqWifw4LAX+xobx8BjbPCrJLI+ycbYdGlags0H1+mLcJkWwGJoVL60mPL/cx+AVuQ8x/7zPrkiMF7SL4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FWskN4Eu; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820451; x=1761356451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nn9+6N/wjtkyrB4OkpKbzfIbJW3ll5RS6cPN6VWxA1c=;
  b=FWskN4EussNILevAkIV2cMvtCpYNF88LWWYvoRhAg+RxgvANHgKaBaav
   52LV+yLw/n+NdDtY2zTaaXVLq54Lp0+DXTd/rn9RG9REFXFBnIKxAUMKn
   YkntgiUQrRKbbm1AvbKV4N5pmEGNCThZnGsBRTCu9k5qpf/0phIy4piMx
   7CUv5tMeXS56QswZ6XLquwUuhitITujj8MGonHA5ITjnEhbbrtcFirRhG
   rRwuYw41bdwS8I0XNbZDZhv1p4qJd7RRwsaeEMS3VOiWhy/50b6WX7JER
   9it9CfLW3DizCyl3BVcyTFnqp5niZGjSXvDsEF7sE9L4IUu26vLKwMiO9
   g==;
X-CSE-ConnectionGUID: 2OAeEKrURpG+kyoAFvaeow==
X-CSE-MsgGUID: 6YkXRSG5SI6GAKkGzg6T4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="156807501"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="156807501"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:39:38 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 26380CA1F0;
	Fri, 25 Oct 2024 10:39:36 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 66E7CBF3FF;
	Fri, 25 Oct 2024 10:39:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 01CA421CB00;
	Fri, 25 Oct 2024 10:39:35 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 594E11A01E9;
	Fri, 25 Oct 2024 09:39:34 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH for-next 5/7] selftests/cpufreq: gitignore output files and clean them in make clean
Date: Fri, 25 Oct 2024 09:40:08 +0800
Message-ID: <20241025014010.6533-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241025014010.6533-1-lizhijian@fujitsu.com>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28752.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28752.003
X-TMASE-Result: 10--5.467200-10.000000
X-TMASE-MatchedRID: FAP6nufyV76AIpLP/qXbGbnHu4BcYSmtegIHHX2L4YyjEIt+uIPPOOPh
	s17991vRV89FgO/U4vBeAZpJlX3ct6Mqw1MrQ3Xs0e7jfBjhB8f4qCLIu0mtIL5/tqn0MloN7Pt
	3qk+AS2v5jQz76et+v8rbguuTTSDuTBhdFGvbKaeqh5pv1eDPz/Wr7HvOSElaPbCkSqodb8QYQb
	1oGZV/vOLzNWBegCW2wgn7iDBesS0gBwKKRHe+r6JKhpMS1tR9U3ObiTaV1W3AT3bRyqNrcgPMJ
	BLBlOaSBM5cfL0JmKE=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

After `make run_tests`, the git status complains:
Untracked files:
    (use "git add <file>..." to include in what will be committed)
        cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
        cpufreq/cpufreq_selftest.dmesg_full.txt
        cpufreq/cpufreq_selftest.txt

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: linux-pm@vger.kernel.org
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V2:
  split as a separate patch from a small one [0]
  [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/cpufreq/.gitignore | 1 +
 tools/testing/selftests/cpufreq/Makefile   | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/cpufreq/.gitignore

diff --git a/tools/testing/selftests/cpufreq/.gitignore b/tools/testing/selftests/cpufreq/.gitignore
new file mode 100644
index 000000000000..f684d27f5d91
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/.gitignore
@@ -0,0 +1 @@
+cpufreq_selftest.*
diff --git a/tools/testing/selftests/cpufreq/Makefile b/tools/testing/selftests/cpufreq/Makefile
index c86ca8342222..9b2ccb10b0cf 100644
--- a/tools/testing/selftests/cpufreq/Makefile
+++ b/tools/testing/selftests/cpufreq/Makefile
@@ -3,6 +3,7 @@ all:
 
 TEST_PROGS := main.sh
 TEST_FILES := cpu.sh cpufreq.sh governor.sh module.sh special-tests.sh
+EXTRA_CLEAN := cpufreq_selftest.dmesg_cpufreq.txt cpufreq_selftest.dmesg_full.txt cpufreq_selftest.txt
 
 include ../lib.mk
 
-- 
2.44.0


