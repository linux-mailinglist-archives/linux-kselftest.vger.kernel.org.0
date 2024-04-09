Return-Path: <linux-kselftest+bounces-7458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5820189D0DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13025285F54
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF5454BCA;
	Tue,  9 Apr 2024 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHFlhLjI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00C548FC;
	Tue,  9 Apr 2024 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632618; cv=none; b=PUoKmcYxkkDw/fdl1wgkZKgodZzfV2jIrCJcfxAoqvTMdV4vrUt2wwmz9ZT1FaaH8ycNWf5zqeU0aC8nCd0lzkZ80oxzvm5O7v7wLu7Kr9tVpZrEhtQPYWsTUBn17xoyQs2Ucqph5tDf6LSBKrxHskhbEZcb+7Rn88QnFrjeYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632618; c=relaxed/simple;
	bh=IIxE3PzC/7i7cnSTl0qPB9glUfBRw55X9DcZwinzfp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOa/QMuaCsDmGMPlwNOyinNePpwHohB5xlcJgw4VWZdzWcdTU3lvTaCBOzROKLYl02sPNJDn0kWi+iDuJwWOFDAtjWNwj6jJZvUftEs8eMyOyrWDF1qWLgBrJu01H+g4n9e3nFRKTqeJ6cdac4kowftOsSizFYyq7AoF64xvZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHFlhLjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E97C433A6;
	Tue,  9 Apr 2024 03:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712632617;
	bh=IIxE3PzC/7i7cnSTl0qPB9glUfBRw55X9DcZwinzfp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHFlhLjId0BHL0tZnvPPOBiARRDKV1rJuyMQRAz/spjeWWhmR9z/uL3jvUp0mg+cR
	 6h10oW76Vy5Omd9SU302d9Fy3NlJne5PKy4KAj4W2AUg3S3SG11Nk+VSNk1bHQHpEh
	 4hCIUHt5AsNnOI6s46QczywXYray6ihqVUPd6UVzERFqliU3OAX02QVb+K7JW2oU3s
	 wPlRCAwhCzUfYDbd3q1HJ2uyQgR+xUAT9Fo2JJ9XxRd0erk2CDyQETRBsq2u1ggalF
	 14Q3pS5FKXzqZkGO1RJou/GfNmfa0okjO2RWzTcKHIvxWaFQn0176djy2PclnuTbzA
	 yKm8hECcY05HA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	mykolal@fb.com,
	eddyz87@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] selftests: move bpf-offload test from bpf to net
Date: Mon,  8 Apr 2024 20:15:46 -0700
Message-ID: <20240409031549.3531084-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409031549.3531084-1-kuba@kernel.org>
References: <20240409031549.3531084-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're building more python tests on the netdev side, and some
of the classes from the venerable BPF offload tests can be reused.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                      | 1 -
 tools/testing/selftests/net/Makefile                      | 8 +++++++-
 .../selftests/{bpf/test_offload.py => net/bpf_offload.py} | 0
 .../progs/sample_map_ret0.c => net/sample_map_ret0.bpf.c} | 0
 .../{bpf/progs/sample_ret0.c => net/sample_ret0.bpf.c}    | 0
 5 files changed, 7 insertions(+), 2 deletions(-)
 rename tools/testing/selftests/{bpf/test_offload.py => net/bpf_offload.py} (100%)
 rename tools/testing/selftests/{bpf/progs/sample_map_ret0.c => net/sample_map_ret0.bpf.c} (100%)
 rename tools/testing/selftests/{bpf/progs/sample_ret0.c => net/sample_ret0.bpf.c} (100%)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3b9eb40d6343..b0be07f29dde 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -102,7 +102,6 @@ TEST_PROGS := test_kmod.sh \
 	test_xdp_redirect_multi.sh \
 	test_xdp_meta.sh \
 	test_xdp_veth.sh \
-	test_offload.py \
 	test_sock_addr.sh \
 	test_tunnel.sh \
 	test_lwt_seg6local.sh \
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5e34c93aa51b..e8bfa715aa49 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -84,6 +84,8 @@ TEST_GEN_FILES += sctp_hello
 TEST_GEN_FILES += csum
 TEST_GEN_FILES += nat6to4.o
 TEST_GEN_FILES += xdp_dummy.o
+TEST_GEN_FILES += sample_ret0.bpf.o
+TEST_GEN_FILES += sample_map_ret0.bpf.o
 TEST_GEN_FILES += ip_local_port_range
 TEST_GEN_FILES += bind_wildcard
 TEST_PROGS += test_vxlan_mdb.sh
@@ -93,6 +95,7 @@ TEST_PROGS += test_bridge_backup_port.sh
 TEST_PROGS += fdb_flush.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
+TEST_PROGS += bpf_offload.py
 
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
@@ -142,7 +145,10 @@ endif
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 
-$(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o: $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
+BPF_PROG_OBJS := $(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o \
+	$(OUTPUT)/sample_map_ret0.bpf.o $(OUTPUT)/sample_ret0.bpf.o
+
+$(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
 	$(CLANG) -O2 --target=bpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) -o $@
 
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/net/bpf_offload.py
similarity index 100%
rename from tools/testing/selftests/bpf/test_offload.py
rename to tools/testing/selftests/net/bpf_offload.py
diff --git a/tools/testing/selftests/bpf/progs/sample_map_ret0.c b/tools/testing/selftests/net/sample_map_ret0.bpf.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/sample_map_ret0.c
rename to tools/testing/selftests/net/sample_map_ret0.bpf.c
diff --git a/tools/testing/selftests/bpf/progs/sample_ret0.c b/tools/testing/selftests/net/sample_ret0.bpf.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/sample_ret0.c
rename to tools/testing/selftests/net/sample_ret0.bpf.c
-- 
2.44.0


