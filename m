Return-Path: <linux-kselftest+bounces-1985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D514A813FF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5370C2845B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54381C;
	Fri, 15 Dec 2023 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="H74JQPEd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE76FB3
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so2377025e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607850; x=1703212650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt1dh5/JqMvurNe8YmLhxD9EQXmDHJaWbJpRUNQdstY=;
        b=H74JQPEdQtZ/iO5+6RQZI9KooQHhGPl/ATpNQH9iOvdG3RIdp3J9ZzCIbGjBKurmHJ
         dPU8uCUDq1yA6ne+U077Yzp6LaMz0f+YB/pDDO5g0mSYQYnRRi7wmefZ8hdH7yJebctm
         EP2DMdeKn3S044+LvaX7mHH8eb6qpNReoFx7bYPqzzqoNPFqno/7lJYwVr9rlPwl2U7c
         9nwJ3tDX/RvUmipxr/1wXwTm0zOttRHEn56yDpCILstxCA3M9f9CP/9zuDmUhzg78r5r
         Rcu8Y/1dAHzho1jBT0NRt+Ub5zcI8uHyNdNNhabmVlURHJDrd89T7pkzeCZs+uThMYpA
         b10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607850; x=1703212650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt1dh5/JqMvurNe8YmLhxD9EQXmDHJaWbJpRUNQdstY=;
        b=I88FXqA0o3UTsICOzig1EXH+3nVf3O6baCZDFljNEp968nQnZ6PYmqK5cqLyX0fDU8
         oCpNM3ANIV0vWhfMLtHmwCanTLGmaupRSdww2Ph6POwO40nai2VqqwwqioqGIw00jZMB
         en/xAc5/U/iLFFw3uSqogem198KzZklOLbhSbL3T+rU6LYr9w5JWxd8H87rq+MxlLtX5
         KioeL0OcAo3KshVAC0vhJIeZGTTbRmeBQH7Uu3IqHiI+Vxav7TslhXbnzrJajmTnwPTM
         T6FRgf7v6V625MuS6DGBrKWpxvkcEHZUlC5LyXxntA7s1txYbQlAQYjmCb0FqL+GDVCb
         BCOg==
X-Gm-Message-State: AOJu0YyNmc+KvdXXMAE3kPjMyq7Epvk4G1ECL2pTLmLWxiNPCVfWUlXf
	tA6c5D7rwUh7szuta+zdSJU3C2otG9xq8Jj8Fqc=
X-Google-Smtp-Source: AGHT+IHkcayaWl8M4DVA3std2ntmwJ4w5Sr2DtiH+26FbpUEmsRuOzwUJIT6CjkB8RStehVCNxHr+Q==
X-Received: by 2002:a05:600c:4507:b0:40b:5e21:cc15 with SMTP id t7-20020a05600c450700b0040b5e21cc15mr5453572wmo.64.1702607849486;
        Thu, 14 Dec 2023 18:37:29 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:28 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH 05/12] selftests/net: Add test for TCP-AO add setsockopt() command
Date: Fri, 15 Dec 2023 02:36:19 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-5-f6c08180b985@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607832; l=32886; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=6a0tVjQcwMevfKzZWg0qGKQftNVT5CteLQPjSkIibSk=; b=TcZS1WaKaW2nZ82JjjOESWV7YfICK1G5yVxKIEcLzyy1xNIpETF1nAHWAh7hyJuQJgv6cOg/3 pV7FqKKP5UEDcr7v+ttBHtKNCD1TXk9Eo1+alatm08OOobEpDnW1zTQ
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Verify corner-cases for UAPI.
Sample output:
> # ./setsockopt-closed_ipv4
> 1..120
> # 1657[lib/setup.c:254] rand seed 1681938184
> TAP version 13
> ok 1 AO add: minimum size
> ok 2 AO add: extended size
> ok 3 AO add: null optval
> ok 4 AO del: minimum size
> ok 5 AO del: extended size
> ok 6 AO del: null optval
> ok 7 AO set info: minimum size
> ok 8 AO set info: extended size
> ok 9 AO info get: : extended size
> ok 10 AO set info: null optval
> ok 11 AO get info: minimum size
> ok 12 AO get info: extended size
> ok 13 AO get info: null optval
> ok 14 AO get info: null optlen
> ok 15 AO get keys: minimum size
> ok 16 AO get keys: extended size
> ok 17 AO get keys: null optval
> ok 18 AO get keys: null optlen
> ok 19 key add: too big keylen
> ok 20 key add: using reserved padding
> ok 21 key add: using reserved2 padding
> ok 22 key add: wrong address family
> ok 23 key add: port (unsupported)
> ok 24 key add: no prefix, addr
> ok 25 key add: no prefix, any addr
> ok 26 key add: prefix, any addr
> ok 27 key add: too big prefix
> ok 28 key add: too short prefix
> ok 29 key add: bad key flags
> ok 30 key add: add current key on a listen socket
> ok 31 key add: add rnext key on a listen socket
> ok 32 key add: add current+rnext key on a listen socket
> ok 33 key add: add key and set as current
> ok 34 key add: add key and set as rnext
> ok 35 key add: add key and set as current+rnext
> ok 36 key add: ifindex without TCP_AO_KEYF_IFNINDEX
> ok 37 key add: non-existent VRF
> ok 38 optmem limit was hit on adding 69 key
> ok 39 key add: maclen bigger than TCP hdr
> ok 40 key add: bad algo
> ok 41 key del: using reserved padding
> ok 42 key del: using reserved2 padding
> ok 43 key del: del and set current key on a listen socket
> ok 44 key del: del and set rnext key on a listen socket
> ok 45 key del: del and set current+rnext key on a listen socket
> ok 46 key del: bad key flags
> ok 47 key del: ifindex without TCP_AO_KEYF_IFNINDEX
> ok 48 key del: non-existent VRF
> ok 49 key del: set non-exising current key
> ok 50 key del: set non-existing rnext key
> ok 51 key del: set non-existing current+rnext key
> ok 52 key del: set current key
> ok 53 key del: set rnext key
> ok 54 key del: set current+rnext key
> ok 55 key del: set as current key to be removed
> ok 56 key del: set as rnext key to be removed
> ok 57 key del: set as current+rnext key to be removed
> ok 58 key del: async on non-listen
> ok 59 key del: non-existing sndid
> ok 60 key del: non-existing rcvid
> ok 61 key del: incorrect addr
> ok 62 key del: correct key delete
> ok 63 AO info set: set current key on a listen socket
> ok 64 AO info set: set rnext key on a listen socket
> ok 65 AO info set: set current+rnext key on a listen socket
> ok 66 AO info set: using reserved padding
> ok 67 AO info set: using reserved2 padding
> ok 68 AO info set: accept_icmps
> ok 69 AO info get: accept_icmps
> ok 70 AO info set: ao required
> ok 71 AO info get: ao required
> ok 72 AO info set: ao required with MD5 key
> ok 73 AO info set: set non-existing current key
> ok 74 AO info set: set non-existing rnext key
> ok 75 AO info set: set non-existing current+rnext key
> ok 76 AO info set: set current key
> ok 77 AO info get: set current key
> ok 78 AO info set: set rnext key
> ok 79 AO info get: set rnext key
> ok 80 AO info set: set current+rnext key
> ok 81 AO info get: set current+rnext key
> ok 82 AO info set: set counters
> ok 83 AO info get: set counters
> ok 84 AO info set: no-op
> ok 85 AO info get: no-op
> ok 86 get keys: no ao_info
> ok 87 get keys: proper tcp_ao_get_mkts()
> ok 88 get keys: set out-only pkt_good counter
> ok 89 get keys: set out-only pkt_bad counter
> ok 90 get keys: bad keyflags
> ok 91 get keys: ifindex without TCP_AO_KEYF_IFNINDEX
> ok 92 get keys: using reserved field
> ok 93 get keys: no prefix, addr
> ok 94 get keys: no prefix, any addr
> ok 95 get keys: prefix, any addr
> ok 96 get keys: too big prefix
> ok 97 get keys: too short prefix
> ok 98 get keys: prefix + addr
> ok 99 get keys: get_all + prefix
> ok 100 get keys: get_all + addr
> ok 101 get keys: get_all + sndid
> ok 102 get keys: get_all + rcvid
> ok 103 get keys: current + prefix
> ok 104 get keys: current + addr
> ok 105 get keys: current + sndid
> ok 106 get keys: current + rcvid
> ok 107 get keys: rnext + prefix
> ok 108 get keys: rnext + addr
> ok 109 get keys: rnext + sndid
> ok 110 get keys: rnext + rcvid
> ok 111 get keys: get_all + current
> ok 112 get keys: get_all + rnext
> ok 113 get keys: current + rnext
> ok 114 key add: duplicate: full copy
> ok 115 key add: duplicate: any addr key on the socket
> ok 116 key add: duplicate: add any addr key
> ok 117 key add: duplicate: add any addr for the same subnet
> ok 118 key add: duplicate: full copy of a key
> ok 119 key add: duplicate: RecvID differs
> ok 120 key add: duplicate: SendID differs
> # Totals: pass:120 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile        |   1 +
 .../selftests/net/tcp_ao/setsockopt-closed.c       | 835 +++++++++++++++++++++
 2 files changed, 836 insertions(+)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index f3b1d7f42edb..1efd98ca12db 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -2,6 +2,7 @@
 TEST_BOTH_AF := connect
 TEST_BOTH_AF += connect-deny
 TEST_BOTH_AF += icmps-accept icmps-discard
+TEST_BOTH_AF += setsockopt-closed
 
 TEST_IPV4_PROGS := $(TEST_BOTH_AF:%=%_ipv4)
 TEST_IPV6_PROGS := $(TEST_BOTH_AF:%=%_ipv6)
diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
new file mode 100644
index 000000000000..7e4601b3f6a3
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -0,0 +1,835 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dmitry Safonov <dima@arista.com> */
+#include <inttypes.h>
+#include "../../../../include/linux/kernel.h"
+#include "aolib.h"
+
+static union tcp_addr tcp_md5_client;
+
+static int test_port = 7788;
+static void make_listen(int sk)
+{
+	sockaddr_af addr;
+
+	tcp_addr_to_sockaddr_in(&addr, &this_ip_addr, htons(test_port++));
+	if (bind(sk, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		test_error("bind()");
+	if (listen(sk, 1))
+		test_error("listen()");
+}
+
+static void test_vefify_ao_info(int sk, struct tcp_ao_info_opt *info,
+				const char *tst)
+{
+	struct tcp_ao_info_opt tmp;
+	socklen_t len = sizeof(tmp);
+
+	if (getsockopt(sk, IPPROTO_TCP, TCP_AO_INFO, &tmp, &len))
+		test_error("getsockopt(TCP_AO_INFO) failed");
+
+#define __cmp_ao(member)							\
+do {										\
+	if (info->member != tmp.member) {					\
+		test_fail("%s: getsockopt(): " __stringify(member) " %zu != %zu",	\
+			  tst, (size_t)info->member, (size_t)tmp.member);	\
+		return;								\
+	}									\
+} while(0)
+	if (info->set_current)
+		__cmp_ao(current_key);
+	if (info->set_rnext)
+		__cmp_ao(rnext);
+	if (info->set_counters) {
+		__cmp_ao(pkt_good);
+		__cmp_ao(pkt_bad);
+		__cmp_ao(pkt_key_not_found);
+		__cmp_ao(pkt_ao_required);
+		__cmp_ao(pkt_dropped_icmp);
+	}
+	__cmp_ao(ao_required);
+	__cmp_ao(accept_icmps);
+
+	test_ok("AO info get: %s", tst);
+#undef __cmp_ao
+}
+
+static void __setsockopt_checked(int sk, int optname, bool get,
+				 void *optval, socklen_t *len,
+				 int err, const char *tst, const char *tst2)
+{
+	int ret;
+
+	if (!tst)
+		tst = "";
+	if (!tst2)
+		tst2 = "";
+
+	errno = 0;
+	if (get)
+		ret = getsockopt(sk, IPPROTO_TCP, optname, optval, len);
+	else
+		ret = setsockopt(sk, IPPROTO_TCP, optname, optval, *len);
+	if (ret == -1) {
+		if (errno == err)
+			test_ok("%s%s", tst ?: "", tst2 ?: "");
+		else
+			test_fail("%s%s: %setsockopt() failed",
+				  tst, tst2, get ? "g" : "s");
+		close(sk);
+		return;
+	}
+
+	if (err) {
+		test_fail("%s%s: %setsockopt() was expected to fail with %d",
+			  tst, tst2, get ? "g" : "s", err);
+	} else {
+		test_ok("%s%s", tst ?: "", tst2 ?: "");
+		if (optname == TCP_AO_ADD_KEY) {
+			test_verify_socket_key(sk, optval);
+		} else if (optname == TCP_AO_INFO && !get) {
+			test_vefify_ao_info(sk, optval, tst2);
+		} else if (optname == TCP_AO_GET_KEYS) {
+			if (*len != sizeof(struct tcp_ao_getsockopt))
+				test_fail("%s%s: get keys returned wrong tcp_ao_getsockopt size",
+					  tst, tst2);
+		}
+	}
+	close(sk);
+}
+
+static void setsockopt_checked(int sk, int optname, void *optval,
+			       int err, const char *tst)
+{
+	const char *cmd = NULL;
+	socklen_t len;
+
+	switch (optname) {
+	case TCP_AO_ADD_KEY:
+		cmd = "key add: ";
+		len = sizeof(struct tcp_ao_add);
+		break;
+	case TCP_AO_DEL_KEY:
+		cmd = "key del: ";
+		len = sizeof(struct tcp_ao_del);
+		break;
+	case TCP_AO_INFO:
+		cmd = "AO info set: ";
+		len = sizeof(struct tcp_ao_info_opt);
+		break;
+	default:
+		break;
+	};
+
+	__setsockopt_checked(sk, optname, false, optval, &len, err, cmd, tst);
+}
+
+static int prepare_defs(int cmd, void *optval)
+{
+	int sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+
+	if (sk < 0)
+		test_error("socket()");
+
+	switch (cmd) {
+	case TCP_AO_ADD_KEY: {
+		struct tcp_ao_add *add = optval;
+
+		if (test_prepare_def_key(add, DEFAULT_TEST_PASSWORD, 0, this_ip_dest,
+					-1, 0, 100, 100))
+			test_error("prepare default tcp_ao_add");
+		break;
+		}
+	case TCP_AO_DEL_KEY: {
+		struct tcp_ao_del *del = optval;
+
+		if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest,
+				 DEFAULT_TEST_PREFIX, 100, 100))
+			test_error("add default key");
+		memset(del, 0, sizeof(struct tcp_ao_del));
+		del->sndid = 100;
+		del->rcvid = 100;
+		del->prefix = DEFAULT_TEST_PREFIX;
+		tcp_addr_to_sockaddr_in(&del->addr, &this_ip_dest, 0);
+		break;
+		}
+	case TCP_AO_INFO: {
+		struct tcp_ao_info_opt *info = optval;
+
+		if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest,
+				 DEFAULT_TEST_PREFIX, 100, 100))
+			test_error("add default key");
+		memset(info, 0, sizeof(struct tcp_ao_info_opt));
+		break;
+		}
+	case TCP_AO_GET_KEYS: {
+		struct tcp_ao_getsockopt *get = optval;
+
+		if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest,
+				 DEFAULT_TEST_PREFIX, 100, 100))
+			test_error("add default key");
+		memset(get, 0, sizeof(struct tcp_ao_getsockopt));
+		get->nkeys = 1;
+		get->get_all = 1;
+		break;
+		}
+	default:
+		test_error("unknown cmd");
+	}
+
+	return sk;
+}
+
+static void test_extend(int cmd, bool get, const char *tst, socklen_t under_size)
+{
+	struct {
+		union {
+			struct tcp_ao_add add;
+			struct tcp_ao_del del;
+			struct tcp_ao_getsockopt get;
+			struct tcp_ao_info_opt info;
+		};
+		char *extend[100];
+	} tmp_opt;
+	socklen_t extended_size = sizeof(tmp_opt);
+	int sk;
+
+	memset(&tmp_opt, 0, sizeof(tmp_opt));
+	sk = prepare_defs(cmd, &tmp_opt);
+	__setsockopt_checked(sk, cmd, get, &tmp_opt, &under_size,
+			     EINVAL, tst, ": minimum size");
+
+	memset(&tmp_opt, 0, sizeof(tmp_opt));
+	sk = prepare_defs(cmd, &tmp_opt);
+	__setsockopt_checked(sk, cmd, get, &tmp_opt, &extended_size,
+			     0, tst, ": extended size");
+
+	memset(&tmp_opt, 0, sizeof(tmp_opt));
+	sk = prepare_defs(cmd, &tmp_opt);
+	__setsockopt_checked(sk, cmd, get, NULL, &extended_size,
+			     EFAULT, tst, ": null optval");
+
+	if (get) {
+		memset(&tmp_opt, 0, sizeof(tmp_opt));
+		sk = prepare_defs(cmd, &tmp_opt);
+		__setsockopt_checked(sk, cmd, get, &tmp_opt, NULL,
+				     EFAULT, tst, ": null optlen");
+	}
+}
+
+static void extend_tests(void)
+{
+	test_extend(TCP_AO_ADD_KEY, false, "AO add",
+		    offsetof(struct tcp_ao_add, key));
+	test_extend(TCP_AO_DEL_KEY, false, "AO del",
+		    offsetof(struct tcp_ao_del, keyflags));
+	test_extend(TCP_AO_INFO, false, "AO set info",
+		    offsetof(struct tcp_ao_info_opt, pkt_dropped_icmp));
+	test_extend(TCP_AO_INFO, true, "AO get info", -1);
+	test_extend(TCP_AO_GET_KEYS, true, "AO get keys", -1);
+}
+
+static void test_optmem_limit(void)
+{
+	size_t i, keys_limit, current_optmem = test_get_optmem();
+	struct tcp_ao_add ao;
+	union tcp_addr net = {};
+	int sk;
+
+	if (inet_pton(TEST_FAMILY, TEST_NETWORK, &net) != 1)
+		test_error("Can't convert ip address %s", TEST_NETWORK);
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	keys_limit = current_optmem / KERNEL_TCP_AO_KEY_SZ_ROUND_UP;
+	for (i = 0;; i++) {
+		union tcp_addr key_peer;
+		int err;
+
+		key_peer = gen_tcp_addr(net, i + 1);
+		tcp_addr_to_sockaddr_in(&ao.addr, &key_peer, 0);
+		err = setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY,
+				 &ao, sizeof(ao));
+		if (!err) {
+			/*
+			 * TCP_AO_ADD_KEY should be the same order as the real
+			 * sizeof(struct tcp_ao_key) in kernel.
+			 */
+			if (i <= keys_limit * 10)
+				continue;
+			test_fail("optmem limit test failed: added %zu key", i);
+			break;
+		}
+		if (i < keys_limit) {
+			test_fail("optmem limit test failed: couldn't add %zu key", i);
+			break;
+		}
+		test_ok("optmem limit was hit on adding %zu key", i);
+		break;
+	}
+	close(sk);
+}
+
+static void test_einval_add_key(void)
+{
+	struct tcp_ao_add ao;
+	int sk;
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.keylen = TCP_AO_MAXKEYLEN + 1;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "too big keylen");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.reserved = 1;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "using reserved padding");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.reserved2 = 1;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "using reserved2 padding");
+
+	/* tcp_ao_verify_ipv{4,6}() checks */
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.addr.ss_family = AF_UNIX;
+	memcpy(&ao.addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "wrong address family");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	tcp_addr_to_sockaddr_in(&ao.addr, &this_ip_dest, 1234);
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "port (unsupported)");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.prefix = 0;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "no prefix, addr");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.prefix = 0;
+	memcpy(&ao.addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, 0, "no prefix, any addr");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.prefix = 32;
+	memcpy(&ao.addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "prefix, any addr");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.prefix = 129;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "too big prefix");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.prefix = 2;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "too short prefix");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.keyflags = (uint8_t)(-1);
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "bad key flags");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	make_listen(sk);
+	ao.set_current = 1;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "add current key on a listen socket");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	make_listen(sk);
+	ao.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "add rnext key on a listen socket");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	make_listen(sk);
+	ao.set_current = 1;
+	ao.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "add current+rnext key on a listen socket");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.set_current = 1;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, 0, "add key and set as current");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, 0, "add key and set as rnext");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.set_current = 1;
+	ao.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, 0, "add key and set as current+rnext");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.ifindex = 42;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL,
+			   "ifindex without TCP_AO_KEYF_IFNINDEX");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.keyflags |= TCP_AO_KEYF_IFINDEX;
+	ao.ifindex = 42;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EINVAL, "non-existent VRF");
+	/*
+	 * tcp_md5_do_lookup{,_any_l3index}() are checked in unsigned-md5
+	 * see client_vrf_tests().
+	 */
+
+	test_optmem_limit();
+
+	/* tcp_ao_parse_crypto() */
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao.maclen = 100;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EMSGSIZE, "maclen bigger than TCP hdr");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	strcpy(ao.alg_name, "imaginary hash algo");
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, ENOENT, "bad algo");
+}
+
+static void test_einval_del_key(void)
+{
+	struct tcp_ao_del del;
+	int sk;
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.reserved = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, EINVAL, "using reserved padding");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.reserved2 = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, EINVAL, "using reserved2 padding");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	make_listen(sk);
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, DEFAULT_TEST_PREFIX, 0, 0))
+		test_error("add key");
+	del.set_current = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, EINVAL, "del and set current key on a listen socket");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	make_listen(sk);
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, DEFAULT_TEST_PREFIX, 0, 0))
+		test_error("add key");
+	del.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, EINVAL, "del and set rnext key on a listen socket");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	make_listen(sk);
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, DEFAULT_TEST_PREFIX, 0, 0))
+		test_error("add key");
+	del.set_current = 1;
+	del.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, EINVAL, "del and set current+rnext key on a listen socket");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.keyflags = (uint8_t)(-1);
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, EINVAL, "bad key flags");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.ifindex = 42;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, EINVAL,
+			   "ifindex without TCP_AO_KEYF_IFNINDEX");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.keyflags |= TCP_AO_KEYF_IFINDEX;
+	del.ifindex = 42;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "non-existent VRF");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.set_current = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set non-exising current key");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set non-existing rnext key");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.set_current = 1;
+	del.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set non-existing current+rnext key");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, DEFAULT_TEST_PREFIX, 0, 0))
+		test_error("add key");
+	del.set_current = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, 0, "set current key");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, DEFAULT_TEST_PREFIX, 0, 0))
+		test_error("add key");
+	del.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, 0, "set rnext key");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, DEFAULT_TEST_PREFIX, 0, 0))
+		test_error("add key");
+	del.set_current = 1;
+	del.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, 0, "set current+rnext key");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.set_current = 1;
+	del.current_key = 100;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set as current key to be removed");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.set_rnext = 1;
+	del.rnext = 100;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set as rnext key to be removed");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.set_current = 1;
+	del.current_key = 100;
+	del.set_rnext = 1;
+	del.rnext = 100;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set as current+rnext key to be removed");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.del_async = 1;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, EINVAL, "async on non-listen");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.sndid = 101;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "non-existing sndid");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	del.rcvid = 101;
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "non-existing rcvid");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	tcp_addr_to_sockaddr_in(&del.addr, &this_ip_addr, 0);
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "incorrect addr");
+
+	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
+	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, 0, "correct key delete");
+}
+
+static void test_einval_ao_info(void)
+{
+	struct tcp_ao_info_opt info;
+	int sk;
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	make_listen(sk);
+	info.set_current = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, EINVAL, "set current key on a listen socket");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	make_listen(sk);
+	info.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, EINVAL, "set rnext key on a listen socket");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	make_listen(sk);
+	info.set_current = 1;
+	info.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, EINVAL, "set current+rnext key on a listen socket");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.reserved = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, EINVAL, "using reserved padding");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.reserved2 = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, EINVAL, "using reserved2 padding");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.accept_icmps = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, 0, "accept_icmps");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.ao_required = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, 0, "ao required");
+
+	if (!should_skip_test("ao required with MD5 key", KCONFIG_TCP_MD5)) {
+		sk = prepare_defs(TCP_AO_INFO, &info);
+		info.ao_required = 1;
+		if (test_set_md5(sk, tcp_md5_client, TEST_PREFIX, -1,
+				 "long long secret")) {
+			test_error("setsockopt(TCP_MD5SIG_EXT)");
+			close(sk);
+		} else {
+			setsockopt_checked(sk, TCP_AO_INFO, &info, EKEYREJECTED,
+					   "ao required with MD5 key");
+		}
+	}
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.set_current = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, ENOENT, "set non-existing current key");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, ENOENT, "set non-existing rnext key");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.set_current = 1;
+	info.set_rnext = 1;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, ENOENT, "set non-existing current+rnext key");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.set_current = 1;
+	info.current_key = 100;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, 0, "set current key");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.set_rnext = 1;
+	info.rnext = 100;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, 0, "set rnext key");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.set_current = 1;
+	info.set_rnext = 1;
+	info.current_key = 100;
+	info.rnext = 100;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, 0, "set current+rnext key");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	info.set_counters = 1;
+	info.pkt_good = 321;
+	info.pkt_bad = 888;
+	info.pkt_key_not_found = 654;
+	info.pkt_ao_required = 987654;
+	info.pkt_dropped_icmp = 10000;
+	setsockopt_checked(sk, TCP_AO_INFO, &info, 0, "set counters");
+
+	sk = prepare_defs(TCP_AO_INFO, &info);
+	setsockopt_checked(sk, TCP_AO_INFO, &info, 0, "no-op");
+}
+
+static void getsockopt_checked(int sk, struct tcp_ao_getsockopt *optval,
+			       int err, const char *tst)
+{
+	socklen_t len = sizeof(struct tcp_ao_getsockopt);
+
+	__setsockopt_checked(sk, TCP_AO_GET_KEYS, true, optval, &len, err,
+			     "get keys: ", tst);
+}
+
+static void test_einval_get_keys(void)
+{
+	struct tcp_ao_getsockopt out;
+	int sk;
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+	getsockopt_checked(sk, &out, ENOENT, "no ao_info");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	getsockopt_checked(sk, &out, 0, "proper tcp_ao_get_mkts()");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.pkt_good = 643;
+	getsockopt_checked(sk, &out, EINVAL, "set out-only pkt_good counter");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.pkt_bad = 94;
+	getsockopt_checked(sk, &out, EINVAL, "set out-only pkt_bad counter");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.keyflags = (uint8_t)(-1);
+	getsockopt_checked(sk, &out, EINVAL, "bad keyflags");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.ifindex = 42;
+	getsockopt_checked(sk, &out, EINVAL,
+			   "ifindex without TCP_AO_KEYF_IFNINDEX");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.reserved = 1;
+	getsockopt_checked(sk, &out, EINVAL, "using reserved field");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.prefix = 0;
+	tcp_addr_to_sockaddr_in(&out.addr, &this_ip_dest, 0);
+	getsockopt_checked(sk, &out, EINVAL, "no prefix, addr");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.prefix = 0;
+	memcpy(&out.addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	getsockopt_checked(sk, &out, 0, "no prefix, any addr");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.prefix = 32;
+	memcpy(&out.addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	getsockopt_checked(sk, &out, EINVAL, "prefix, any addr");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.prefix = 129;
+	tcp_addr_to_sockaddr_in(&out.addr, &this_ip_dest, 0);
+	getsockopt_checked(sk, &out, EINVAL, "too big prefix");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.prefix = 2;
+	tcp_addr_to_sockaddr_in(&out.addr, &this_ip_dest, 0);
+	getsockopt_checked(sk, &out, EINVAL, "too short prefix");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.prefix = DEFAULT_TEST_PREFIX;
+	tcp_addr_to_sockaddr_in(&out.addr, &this_ip_dest, 0);
+	getsockopt_checked(sk, &out, 0, "prefix + addr");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 1;
+	out.prefix = DEFAULT_TEST_PREFIX;
+	getsockopt_checked(sk, &out, EINVAL, "get_all + prefix");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 1;
+	tcp_addr_to_sockaddr_in(&out.addr, &this_ip_dest, 0);
+	getsockopt_checked(sk, &out, EINVAL, "get_all + addr");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 1;
+	out.sndid = 1;
+	getsockopt_checked(sk, &out, EINVAL, "get_all + sndid");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 1;
+	out.rcvid = 1;
+	getsockopt_checked(sk, &out, EINVAL, "get_all + rcvid");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.is_current = 1;
+	out.prefix = DEFAULT_TEST_PREFIX;
+	getsockopt_checked(sk, &out, EINVAL, "current + prefix");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.is_current = 1;
+	tcp_addr_to_sockaddr_in(&out.addr, &this_ip_dest, 0);
+	getsockopt_checked(sk, &out, EINVAL, "current + addr");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.is_current = 1;
+	out.sndid = 1;
+	getsockopt_checked(sk, &out, EINVAL, "current + sndid");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.is_current = 1;
+	out.rcvid = 1;
+	getsockopt_checked(sk, &out, EINVAL, "current + rcvid");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.is_rnext = 1;
+	out.prefix = DEFAULT_TEST_PREFIX;
+	getsockopt_checked(sk, &out, EINVAL, "rnext + prefix");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.is_rnext = 1;
+	tcp_addr_to_sockaddr_in(&out.addr, &this_ip_dest, 0);
+	getsockopt_checked(sk, &out, EINVAL, "rnext + addr");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.is_rnext = 1;
+	out.sndid = 1;
+	getsockopt_checked(sk, &out, EINVAL, "rnext + sndid");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.is_rnext = 1;
+	out.rcvid = 1;
+	getsockopt_checked(sk, &out, EINVAL, "rnext + rcvid");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 1;
+	out.is_current = 1;
+	getsockopt_checked(sk, &out, EINVAL, "get_all + current");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 1;
+	out.is_rnext = 1;
+	getsockopt_checked(sk, &out, EINVAL, "get_all + rnext");
+
+	sk = prepare_defs(TCP_AO_GET_KEYS, &out);
+	out.get_all = 0;
+	out.is_current = 1;
+	out.is_rnext = 1;
+	getsockopt_checked(sk, &out, 0, "current + rnext");
+}
+
+static void einval_tests(void)
+{
+	test_einval_add_key();
+	test_einval_del_key();
+	test_einval_ao_info();
+	test_einval_get_keys();
+}
+
+static void duplicate_tests(void)
+{
+	union tcp_addr network_dup;
+	struct tcp_ao_add ao, ao2;
+	int sk;
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &ao, sizeof(ao)))
+		test_error("setsockopt()");
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: full copy");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	ao2 = ao;
+	memcpy(&ao2.addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	ao2.prefix = 0;
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &ao2, sizeof(ao)))
+		test_error("setsockopt()");
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: any addr key on the socket");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &ao, sizeof(ao)))
+		test_error("setsockopt()");
+	memcpy(&ao.addr, &SOCKADDR_ANY, sizeof(SOCKADDR_ANY));
+	ao.prefix = 0;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: add any addr key");
+
+	if (inet_pton(TEST_FAMILY, TEST_NETWORK, &network_dup) != 1)
+		test_error("Can't convert ip address %s", TEST_NETWORK);
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &ao, sizeof(ao)))
+		test_error("setsockopt()");
+	if (test_prepare_def_key(&ao, "password", 0, network_dup,
+				 16, 0, 100, 100))
+		test_error("prepare default tcp_ao_add");
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: add any addr for the same subnet");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &ao, sizeof(ao)))
+		test_error("setsockopt()");
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: full copy of a key");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &ao, sizeof(ao)))
+		test_error("setsockopt()");
+	ao.rcvid = 101;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: RecvID differs");
+
+	sk = prepare_defs(TCP_AO_ADD_KEY, &ao);
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &ao, sizeof(ao)))
+		test_error("setsockopt()");
+	ao.sndid = 101;
+	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: SendID differs");
+}
+
+static void *client_fn(void *arg)
+{
+	if (inet_pton(TEST_FAMILY, __TEST_CLIENT_IP(2), &tcp_md5_client) != 1)
+		test_error("Can't convert ip address");
+	extend_tests();
+	einval_tests();
+	duplicate_tests();
+	/*
+	 * TODO: check getsockopt(TCP_AO_GET_KEYS) with different filters
+	 * returning proper nr & keys;
+	 */
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(120, client_fn, NULL);
+	return 0;
+}

-- 
2.43.0


