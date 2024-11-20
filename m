Return-Path: <linux-kselftest+bounces-22329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE269D349C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B05286EF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091AA1A0BD6;
	Wed, 20 Nov 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZHTIVbiL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4C19F12D;
	Wed, 20 Nov 2024 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088624; cv=none; b=qtkOSQj14G2K3tds6Jv2Zm6J4Cfmi4ASWG5xwmnMC9IbX08ShgACT/X3n+kixRxEhxREAQMaWQleg49MIIwvvGEfcA26RtNVDOyq3h1M6rnHiamvMPdb73wFidgZmo37VZDPs8bOjJ1CYlM+ZsjApvwvfkvWQoeJ1QsH47x6WsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088624; c=relaxed/simple;
	bh=A6loL3DIbb/TWJvPM2is/NXE3O3QcAJ0e7l9H/ABMXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCT3XHli2mH67/IkTkOifFjHaWUrJ9bAG1jlhLJxPYGDw0qdAE/oIyICtG31O0crflH+jHJcVZ7BCRCOqc+zqqBidXtDN6cM9ONQDFr0bLCKRoaf+gu9NsvxIgPPm7bxhdACU46y0XGVy0qT3VFSZacBYtLeLW5fLgOyfUhoJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZHTIVbiL; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9556E240003;
	Wed, 20 Nov 2024 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7+1tu1obsozpkzBOz04NQkuph6F9597Tw0cYk+imHQ=;
	b=ZHTIVbiLEwfupvvMAvSKMMDj2pKgpOyVwMDndfjQ/Pl5dTSvyfRsduZPx+LIMwcAa9sQuF
	sxtgGeNt1w5Q2VSX4+sPlbuvaWPpORy3bGc2/JJLzjs2OKDMU8iMzDY9kqMkuozdL20pd0
	tQkxTCmb9ywOywmMfwV3Zw3sxtLqAhEM9yXedsfj+TIAwqj5hf+t/CDqVTLdcPIkTJ4CQ5
	oOlTe6nB94rElzpHEVbcLz3fKsEPaDKGVY4ZH35mtmomtT8dAL1F23qi6Gh/1TmAAjukbC
	gjstuKrpIqhAVjUqvqgQ6uc3dFtr9N09l5wInPK7MYyY4sm0YK060ZCJKN3Hyg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:21 +0100
Subject: [PATCH bpf-next v3 11/14] selftests/bpf: use the same udp and tcp
 headers in tests under test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-11-45b46494f937@bootlin.com>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
In-Reply-To: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Trying to add udp-dedicated helpers in network_helpers involves
including some udp header, which makes multiple test_progs tests build
fail:

In file included from ./progs/test_cls_redirect.h:13,
                 from [...]/prog_tests/cls_redirect.c:15:
[...]/usr/include/linux/udp.h:23:8: error: redefinition of ‘struct udphdr’
   23 | struct udphdr {
      |        ^~~~~~
In file included from ./network_helpers.h:17,
                 from [...]/prog_tests/cls_redirect.c:13:
[...]/usr/include/netinet/udp.h:55:8: note: originally defined here
   55 | struct udphdr
      |        ^~~~~~

This error is due to struct udphdr being defined in both <linux/udp.h>
and <netinet/udp.h>.

Use only <netinet/udp.h> in every test. While at it, perform the same
for tcp.h. For some tests, the change needs to be done in the eBPF
program part as well, because of some headers sharing between both
sides.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- new patch, needed because of usage of struct udphdr in the next commit
---
 tools/testing/selftests/bpf/network_helpers.c                | 2 +-
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c     | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_cls_redirect.h        | 2 +-
 tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c                | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 27784946b01b8b045983d3a17da91775553776f7..80844a5fb1feef2ff73c2f0293e52495803ab769 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -21,7 +21,7 @@
 #include <linux/limits.h>
 
 #include <linux/ip.h>
-#include <linux/udp.h>
+#include <netinet/udp.h>
 #include <netinet/tcp.h>
 #include <net/if.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 05d0e07da3942738a67d1e3c774065625960c617..ba6b3ec1156ae8729e09739319b7ad0955002b88 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 
-#include <linux/tcp.h>
+#include <netinet/tcp.h>
 #include <linux/netlink.h>
 #include "sockopt_sk.skel.h"
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index 6d8b54124cb359697bcb85b369c9bcd7457e71b4..fb952703653e48e0340730fb7ff0edaf2b191482 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -17,7 +17,7 @@
 #include "network_helpers.h"
 #include <linux/if_bonding.h>
 #include <linux/limits.h>
-#include <linux/udp.h>
+#include <netinet/udp.h>
 #include <uapi/linux/netdev.h>
 
 #include "xdp_dummy.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index bad0ea167be7011e98f94b48e5319df03bdd010b..d12f926b4b8b1fcbc2a88ef7e3bd20ef2cbbd72c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -7,7 +7,7 @@
 #include <linux/if_link.h>
 #include <linux/ipv6.h>
 #include <linux/in6.h>
-#include <linux/udp.h>
+#include <netinet/udp.h>
 #include <bpf/bpf_endian.h>
 #include <uapi/linux/netdev.h>
 #include "test_xdp_do_redirect.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
index e1bf141d340152a4e5ac0dae7abe4dbfaaef1750..3f9146d83d7915167837b668ac9798b5c0b7645d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
@@ -3,7 +3,7 @@
 #include <network_helpers.h>
 #include <bpf/btf.h>
 #include <linux/if_link.h>
-#include <linux/udp.h>
+#include <netinet/udp.h>
 #include <net/if.h>
 #include <unistd.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 7f8e161655336127e5bd7a573d1a09db85a92f53..3d47878ef6bfb55c236dc9df2c100fcc449f8de3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -10,7 +10,7 @@
 #include <linux/errqueue.h>
 #include <linux/if_link.h>
 #include <linux/net_tstamp.h>
-#include <linux/udp.h>
+#include <netinet/udp.h>
 #include <sys/mman.h>
 #include <net/if.h>
 #include <poll.h>
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index 683c8aaa63dac3ceee8b4d7a5807642e30ab121e..f344c6835e84e7991c97bb6bb28366e33394f2b4 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -15,7 +15,7 @@
 #include <linux/ipv6.h>
 #include <linux/pkt_cls.h>
 #include <linux/tcp.h>
-#include <linux/udp.h>
+#include <netinet/udp.h>
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
index 233b089d1fbacf5601e218f8dc6de7840bda4c10..eb55cb8a3dbd1d773d6cbd48272bb3658daef6d2 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
@@ -10,7 +10,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/udp.h>
+#include <netinet/udp.h>
 
 /* offsetof() is used in static asserts, and the libbpf-redefined CO-RE
  * friendly version breaks compilation for older clang versions <= 15
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
index 464515b824b94386948f50314a64076863b14b0d..d0f7670351e587c2995d90972f1c2dcb19af2f50 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
@@ -15,7 +15,7 @@
 #include <linux/ipv6.h>
 #include <linux/pkt_cls.h>
 #include <linux/tcp.h>
-#include <linux/udp.h>
+#include <netinet/udp.h>
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6f9956eed797f30b9611596909ef2954654eab18..06266aad2f99f005f8dbe34ff375e209c273257d 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -27,7 +27,7 @@
 #include <linux/errqueue.h>
 #include <linux/if_link.h>
 #include <linux/net_tstamp.h>
-#include <linux/udp.h>
+#include <netinet/udp.h>
 #include <linux/sockios.h>
 #include <linux/if_xdp.h>
 #include <sys/mman.h>

-- 
2.47.0


