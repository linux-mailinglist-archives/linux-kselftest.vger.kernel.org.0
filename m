Return-Path: <linux-kselftest+bounces-44531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75D9C25EEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428041B203F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0942F28E9;
	Fri, 31 Oct 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="duc4OLqZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103702F1FCF;
	Fri, 31 Oct 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926134; cv=none; b=JbLAoqkG+49D/SryB+DSrJZ4JxHs+IIiEg7HMt3v9PqFx0Y2+HUdz8K3b1SYfxxN3LxuBLjixinc66HunuvGAoCXgYDhw2wcBvwrfbKfNJT71LlEafBqmIl4DXfdcB48I66CrhFa1x4OeG9I6iZ5R7PUSZe4XSQR5UINRk515fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926134; c=relaxed/simple;
	bh=FlMQW/zdoeUwy361J2x3EnxoLoLiW3cy367tB6TXpLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ueFaL8nvNOK7KsOhF1nPiIIqutp0S5BVr9U0qwiXFL8s/yEy1ost4PZ43o3L5RgjZSoB+WCoBy6RVsFCg4I9PHchcylx+BOnoY6fVDSCGCF13Ozkw/0GNWrxSK9iMa7kaV550enEfYGDHC0+0zu1s7Rw9gjDd/54tbeQpm1nNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=duc4OLqZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F12F7C0E95A;
	Fri, 31 Oct 2025 15:55:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 801B560704;
	Fri, 31 Oct 2025 15:55:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89C8311818064;
	Fri, 31 Oct 2025 16:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761926129; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lTXyjSXSIjBvnWIvqP/bdwEhFOhi3TM275wXbjbaKaI=;
	b=duc4OLqZwkstgkZTRIsgkmIdBJeMxXGXQth5UyQ2BYkGKD/B+RQ2J5NcM5ayGgUz0QvWri
	JyYixFKKmf+uwkDYmoTvQjSgXXUrOGDxf8v4eyswz37Hii9aX+bnAvKQmDFuEm68Nw/Phb
	IsiQ1IIkUyR/U6mZbo79Sj77CeNx3IIiBsOgQsNrB1CcA/mSoVO5HMEcJFB/nZXkzw33AR
	7uqzZBp+4nkpQRor+ME3iq08AbHZNKQhcuto3FQrL2vyFEncxd1FPxnlgvU1B16U4A8YEQ
	Zv5C7NE6eIacGR8OkZSEgHjO4Xpf4Pr2YQW65tqEWziTI/x2vXYfK/YVy6cyoA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 31 Oct 2025 16:55:15 +0100
Subject: [PATCH bpf-next 3/4] selftests/bpf: remove test_tc_edt.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-tc_edt-v1-3-5d34a5823144@bootlin.com>
References: <20251031-tc_edt-v1-0-5d34a5823144@bootlin.com>
In-Reply-To: <20251031-tc_edt-v1-0-5d34a5823144@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Now that test_tc_edt has been integrated in test_progs, remove the
legacy shell script.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile       |   2 -
 tools/testing/selftests/bpf/test_tc_edt.sh | 100 -----------------------------
 2 files changed, 102 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 02981b0d9b03..8793305bcee6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -99,13 +99,11 @@ TEST_GEN_PROGS += test_progs-cpuv4
 TEST_INST_SUBDIRS += cpuv4
 endif
 
-TEST_GEN_FILES = test_tc_edt.bpf.o
 TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
 	test_lirc_mode2.sh \
-	test_tc_edt.sh \
 	test_xdping.sh \
 	test_bpftool_build.sh \
 	test_bpftool.sh \
diff --git a/tools/testing/selftests/bpf/test_tc_edt.sh b/tools/testing/selftests/bpf/test_tc_edt.sh
deleted file mode 100755
index 8db8e146a431..000000000000
--- a/tools/testing/selftests/bpf/test_tc_edt.sh
+++ /dev/null
@@ -1,100 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# This test installs a TC bpf program that throttles a TCP flow
-# with dst port = 9000 down to 5MBps. Then it measures actual
-# throughput of the flow.
-
-BPF_FILE="test_tc_edt.bpf.o"
-if [[ $EUID -ne 0 ]]; then
-	echo "This script must be run as root"
-	echo "FAIL"
-	exit 1
-fi
-
-# check that nc, dd, and timeout are present
-command -v nc >/dev/null 2>&1 || \
-	{ echo >&2 "nc is not available"; exit 1; }
-command -v dd >/dev/null 2>&1 || \
-	{ echo >&2 "nc is not available"; exit 1; }
-command -v timeout >/dev/null 2>&1 || \
-	{ echo >&2 "timeout is not available"; exit 1; }
-
-readonly NS_SRC="ns-src-$(mktemp -u XXXXXX)"
-readonly NS_DST="ns-dst-$(mktemp -u XXXXXX)"
-
-readonly IP_SRC="172.16.1.100"
-readonly IP_DST="172.16.2.100"
-
-cleanup()
-{
-	ip netns del ${NS_SRC}
-	ip netns del ${NS_DST}
-}
-
-trap cleanup EXIT
-
-set -e  # exit on error
-
-ip netns add "${NS_SRC}"
-ip netns add "${NS_DST}"
-ip link add veth_src type veth peer name veth_dst
-ip link set veth_src netns ${NS_SRC}
-ip link set veth_dst netns ${NS_DST}
-
-ip -netns ${NS_SRC} addr add ${IP_SRC}/24  dev veth_src
-ip -netns ${NS_DST} addr add ${IP_DST}/24  dev veth_dst
-
-ip -netns ${NS_SRC} link set dev veth_src up
-ip -netns ${NS_DST} link set dev veth_dst up
-
-ip -netns ${NS_SRC} route add ${IP_DST}/32  dev veth_src
-ip -netns ${NS_DST} route add ${IP_SRC}/32  dev veth_dst
-
-# set up TC on TX
-ip netns exec ${NS_SRC} tc qdisc add dev veth_src root fq
-ip netns exec ${NS_SRC} tc qdisc add dev veth_src clsact
-ip netns exec ${NS_SRC} tc filter add dev veth_src egress \
-	bpf da obj ${BPF_FILE} sec tc
-
-
-# start the listener
-ip netns exec ${NS_DST} bash -c \
-	"nc -4 -l -p 9000 >/dev/null &"
-declare -i NC_PID=$!
-sleep 1
-
-declare -ir TIMEOUT=20
-declare -ir EXPECTED_BPS=5000000
-
-# run the load, capture RX bytes on DST
-declare -ir RX_BYTES_START=$( ip netns exec ${NS_DST} \
-	cat /sys/class/net/veth_dst/statistics/rx_bytes )
-
-set +e
-ip netns exec ${NS_SRC} bash -c "timeout ${TIMEOUT} dd if=/dev/zero \
-	bs=1000 count=1000000 > /dev/tcp/${IP_DST}/9000 2>/dev/null"
-set -e
-
-declare -ir RX_BYTES_END=$( ip netns exec ${NS_DST} \
-	cat /sys/class/net/veth_dst/statistics/rx_bytes )
-
-declare -ir ACTUAL_BPS=$(( ($RX_BYTES_END - $RX_BYTES_START) / $TIMEOUT ))
-
-echo $TIMEOUT $ACTUAL_BPS $EXPECTED_BPS | \
-	awk '{printf "elapsed: %d sec; bps difference: %.2f%%\n",
-		$1, ($2-$3)*100.0/$3}'
-
-# Pass the test if the actual bps is within 1% of the expected bps.
-# The difference is usually about 0.1% on a 20-sec test, and ==> zero
-# the longer the test runs.
-declare -ir RES=$( echo $ACTUAL_BPS $EXPECTED_BPS | \
-	 awk 'function abs(x){return ((x < 0.0) ? -x : x)}
-	      {if (abs(($1-$2)*100.0/$2) > 1.0) { print "1" }
-		else { print "0"} }' )
-if [ "${RES}" == "0" ] ; then
-	echo "PASS"
-else
-	echo "FAIL"
-	exit 1
-fi

-- 
2.51.1.dirty


