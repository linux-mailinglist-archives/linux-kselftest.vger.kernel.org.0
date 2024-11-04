Return-Path: <linux-kselftest+bounces-21381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9859BB390
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 12:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A701C21988
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41441B6D01;
	Mon,  4 Nov 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbIsMZt7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE561B21BA;
	Mon,  4 Nov 2024 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720161; cv=none; b=bnEg19D7YDHDPaAeFlvVzCZuzTOTaIX8uaDr6KFzDibtNM5u9ACMyJPa1BI0XCIHnjXvWMyNR9moReYiRzlV3V0Mxxbd2Aal1U9FsZYKex8VCThodinV0ttGgF+fnIxqE8FPy/NUQNRaSaJdqOAVe0ZhN3g3SuuTyYe0at2N2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720161; c=relaxed/simple;
	bh=MqirJQHMXIgrfKDB2SAWPcaT1jCCe/5NGNaz+2tKpMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SVaPaGzcBA9Bsz+ROjTMfEzDPiquRn2QsjMcDIeDfKE675V7a11tkieP5kLFDXjfx05FxnfVq0KW8nKSu5EOvQFjllQDGeC1oDLsW2L3TXcuke6Rl+LWPsRAcMRiLap185xIq3YoNKRd5oNPrakle1iS6/1Xfw4zm438IR20oDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbIsMZt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A25C4CECE;
	Mon,  4 Nov 2024 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730720159;
	bh=MqirJQHMXIgrfKDB2SAWPcaT1jCCe/5NGNaz+2tKpMA=;
	h=From:Date:Subject:To:Cc:From;
	b=PbIsMZt7hKTv3fj2KAiDJGXwOJprKiA42UjoyNkf088vbEDcC8R47RkVHsdvhOqag
	 pEqAILOH3bldzNhZfDdJij3NKcYqIaBn5LH2WZnopPoNgc+KwhkMqvdc5qZbzNHJk5
	 KIYJ5dCDBBhhnHd7abTlFdouhAC8AAft46IZ9EcGCo2FCKibGpLo4vP8/N+MhSU80w
	 OXjhXpVUV4w+kc0YsU/BCaDKCn+XFgAJnt0nVXD8UezgjWjyXoPyTMo7ttIQShajBF
	 3jYjBZLkS4Hm2SGwvCL+4jb3dH3ChYVSz+2tQairUK2cMH4BFJ4N8ABi7RUOB9mhop
	 B4A+2mmHuCUXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 04 Nov 2024 12:34:26 +0100
Subject: [PATCH net-next] selftests: net: include lib/sh/*.sh with lib.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-net-next-selftests-lib-sh-deps-v1-1-7c9f7d939fc2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEGxKGcC/zWNywqDMBBFf0Vm3YEkPqD9ldKFxhsdkFQyQQLiv
 xsKXZzFWZx7T1IkgdKrOSnhEJVvrGIfDfl1jAtY5urkjOusNR1H5ErJrNhChmblTSbWlWfsyt6
 3/dOP/WBcoDqyJwQpv4M3/Vv6XNcNIqwXwXoAAAA=
X-Change-ID: 20241104-net-next-selftests-lib-sh-deps-cc359ca5602f
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2947; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MqirJQHMXIgrfKDB2SAWPcaT1jCCe/5NGNaz+2tKpMA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnKLGbZaVJYSzdQbmHRGDBiYAjohF7t43yplQ4R
 GtiBzByYqeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZyixmwAKCRD2t4JPQmmg
 c49jEACcw3RMvJT3kJc7KsxPMp9NRi/Tj0bXnfvpVBNOo/aQc+EZsAaleU7LTj6vbemiS5b1+zO
 aOBKAi0SG1AgoB7BCp0C/NvCP9eMCulz04ilcqKuiBpwP2gaIx31tJhUAwHdTPvl3sR6gwxHxoo
 hMWsCuvlxBYjjmpOj7nk2c3t/N22jQBT9QD4ujE8TQiusaIuKocksSLD1APRyL8f4u95kU4/Ss8
 bZVxyyLXZ7czg7YOIFSR+KRAw9Sk0sn1uPvebLq6qmtWlZJfH7jSuQ5MmihiCLJEmFRtLZ1dVj7
 2gYDPfgF2z8vgcJ0GwMn+fRB37W++zhIYGwl2Q2NHiKnnDYax0B6sdOhqm8pzn6utnLJKNVLwEC
 T5Xv8IyuKApLQ3WcaU/ek9jo2J0/vFdBW1sRE+gltnQABLNALnk5L7Fi7zH+QDuuXKA4kfcf5Py
 BL4RwJ+T3beRhz6kHethWBGEm3CQwUbldBieEZtjcV66i2c2cl9lkCT8/s1JR0T0X4Ks+4LQK9K
 EWUDQkmdlkXvo83OBVVk/tcF7QXSLqTR162D9lPB1LfybCHb1vgL0E50Xr5VcxH4HcwubtSlSIK
 4kmYFweQ19Qrt2pqFqrJav7rgXp3CSnf5EgOytIjLd+jTkE8rw5zPpLIQn9jiS9UuAoQb+4DLJH
 uooUrsbDdtmhySQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, the net/lib.sh file has been modified to include defer.sh from
net/lib/sh/ directory. The Makefile from net/lib has been modified
accordingly, but not the ones from the sub-targets using net/lib.sh.

Because of that, the new file is not installed as expected when
installing the Forwarding, MPTCP, and Netfilter targets, e.g.

  # make -C tools/testing/selftests TARGETS=net/mptcp install \
        INSTALL_PATH=/tmp/kself
  # cd /tmp/kself/
  # ./run_kselftest.sh -c net/mptcp
    TAP version 13
    1..7
    # timeout set to 1800
    # selftests: net/mptcp: mptcp_connect.sh
    # ./../lib.sh: line 5: /tmp/kself/net/lib/sh/defer.sh: No such file
      or directory
    # (...)

This can be fixed simply by adding all the .sh files from net/lib/sh
directory to the TEST_INCLUDES variable in the different Makefile's.

Fixes: a6e263f125cd ("selftests: net: lib: Introduce deferred commands")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/forwarding/Makefile | 3 ++-
 tools/testing/selftests/net/mptcp/Makefile      | 2 +-
 tools/testing/selftests/net/netfilter/Makefile  | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 224346426ef2220470bf2dbef66198eae9331f56..7d885cff8d79bc6882d2341d0a1a59891fc1cb2e 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -126,6 +126,7 @@ TEST_FILES := devlink_lib.sh \
 	tc_common.sh
 
 TEST_INCLUDES := \
-	../lib.sh
+	../lib.sh \
+	$(wildcard ../lib/sh/*.sh)
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 5d796622e73099d0a0331c1bc8a41f09e1d36b4d..8e3fc05a539797c5e0feab72be69db623ef3fa96 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -11,7 +11,7 @@ TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
 TEST_FILES := mptcp_lib.sh settings
 
-TEST_INCLUDES := ../lib.sh ../net_helper.sh
+TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh) ../net_helper.sh
 
 EXTRA_CLEAN := *.pcap
 
diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index 542f7886a0bc2ac016f41d8b70357a8e0c1d271b..9d009f74cfc2da66428b1e23d5884e2c3bc4a85d 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -55,4 +55,5 @@ TEST_FILES := lib.sh
 TEST_FILES += packetdrill
 
 TEST_INCLUDES := \
-	../lib.sh
+	../lib.sh \
+	$(wildcard ../lib/sh/*.sh)

---
base-commit: ecf99864ea6b1843773589a935bb026951bf12dd
change-id: 20241104-net-next-selftests-lib-sh-deps-cc359ca5602f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


