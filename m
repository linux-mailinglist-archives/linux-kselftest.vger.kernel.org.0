Return-Path: <linux-kselftest+bounces-14814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0599D9484BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 23:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618BCB22E9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 21:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B3817B511;
	Mon,  5 Aug 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHlEgzMQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91255179957
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Aug 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893172; cv=none; b=dTEJfTaFLmKhy5lqs3mQ+gH7M0EKqp73d5OzlMvJS/+zWxjiZuyUntBJDNbHffaMgSx5cW9XrJ5/zerrllL6otyktYaam+4M+jTwqqOeHYyZklVHidI7In3H4FHz29SQ3BtfS0o4RxZpcdhrfolOgCFvuWwvnS6H7JEmeLL8cCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893172; c=relaxed/simple;
	bh=LgiLDLTX33q18o5W65IlMXTIyh4LnzFdIQaMEcpsFlU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RuDos3kwRzebamc14KahEs8QEq5GrglQZ+0gZFW+o+pcnxjQpEKOEXbEYcrD/VZ80F0T61Yye5uE2t2Hr8kAJPJO+8W+izji5ltVzQ59Xb+DzEvq41O3ayyWvvBpPo1yz9y5NyNW0k5kX/vyFukFhrO6R4/xl2FDgedyYY3awF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHlEgzMQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6688c44060fso241338377b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Aug 2024 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722893163; x=1723497963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWGUTGje3OgKxfJ1WL3sD8jzv7ddHMAhOPujZayMMnM=;
        b=rHlEgzMQxouBwBxhFW11Jzy5yilQD4YlqANL/GeSEFQDilRR3TBEnxM1cmANYW2/pU
         /FB7aBck8r1KSdxf+YPKxSi9Hd/PL1Swi+xAGH0oF00rbRmj2y6LcnPDllupsz+0MgsV
         Ks01XBQfUDxd+dBebTeGppRYHpJFKCqZ+u1Hf9xs7tPNIImYQ59F80u0THjeor+BP9Uu
         sLUZxg3y5vua4+s80Owv/DtBjE2gmmpnP0gLjF1OBWBHvFOz078oN6RPQ8BormlLA0PY
         VF4QnZPv8iqQleRspLfo64Dj94Z8X4xY+jg50rZUVappWrdwy60dHK6WqTnEM7uoLlY6
         o/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893163; x=1723497963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWGUTGje3OgKxfJ1WL3sD8jzv7ddHMAhOPujZayMMnM=;
        b=KeQbxVkud85ycZJ2bkbuOhNufopuPrezALzH8tXnDFRCY4P76CBeMgMaL0aRY0atRA
         IXn2wajvBhWTiRJZWR+9e3VJ2UaxtIliFnZYDI2SQx6ViVnUrZpvPhg0XeSUa7b24aze
         B/jQE+TKfqIS/+7usKajsQvE22SFwsDqpJCV4IEZb1Az2NHg24XpFYGeqwKe3WNAOpYe
         ZA5MC/EQdgeukYbXdBlAhqJ1VLmzlvSubbX2g4VqGYQCuzkz7Yv4WPlrzhrNkUswbqJ/
         8QDOmOomIwgR3HwFVyoPjfagP7xFp2snOKFHK8ekcvSbIbmtcaAayIOWP6MT8sMkgOhi
         0ccw==
X-Forwarded-Encrypted: i=1; AJvYcCXO5YKnWjn9GXAycuTnW8XDcSIBlcp6PHM897LlFHYgBF31RCoVX7o8t5y9dWKyybeN0wSw8DSPlEgO1ak/terUBiFtw0SGg5KQUDtRunxC
X-Gm-Message-State: AOJu0YwJfko/RalxOkuf+sufNmssMVY3+Bf8re+ptnGcSDQbgLo9I9mo
	jYDaTFeaplcq9tFCs9yr6wtmYk4GORTDqez7LF73P2r6Dh7TcF8CW5M54Yuq/e0R0fKwlllh4ug
	62cwvm/xEOr7hhdf0+qC+4g==
X-Google-Smtp-Source: AGHT+IF2iJJ+TMzRQFxKLYD7k1Xdg0h1v+OtQHU8fqKJvkNmeQ54QPertD7ief3QvJJoH0iN+1teTojKRQmiUtS15w==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:3008:b0:68d:1d96:6a72 with
 SMTP id 00721157ae682-68d1d966f02mr1276747b3.1.1722893163042; Mon, 05 Aug
 2024 14:26:03 -0700 (PDT)
Date: Mon,  5 Aug 2024 21:25:26 +0000
In-Reply-To: <20240805212536.2172174-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805212536.2172174-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805212536.2172174-14-almasrymina@google.com>
Subject: [PATCH net-next v18 13/14] selftests: add ncdevmem, netcat for devmem TCP
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"

ncdevmem is a devmem TCP netcat. It works similarly to netcat, but it
sends and receives data using the devmem TCP APIs. It uses udmabuf as
the dmabuf provider. It is compatible with a regular netcat running on
a peer, or a ncdevmem running on a peer.

In addition to normal netcat support, ncdevmem has a validation mode,
where it sends a specific pattern and validates this pattern on the
receiver side to ensure data integrity.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v16:
- Remove outdated -n option (Taehee).
- Use 'ifname' instead of accidentally hardcoded 'eth1'. (Taehee)
- Remove dead code 'iterations' (Taehee).
- Use if_nametoindex() instead of passing device index (Taehee).

v15:
- Fix linking against libynl. (Jakub)

v9: https://lore.kernel.org/netdev/20240403002053.2376017-15-almasrymina@google.com/
- Remove unused nic_pci_addr entry (Cong).

v6:
- Updated to bind 8 queues.
- Added RSS configuration.
- Added some more tests for the netlink API.

Changes in v1:
- Many more general cleanups (Willem).
- Removed driver reset (Jakub).
- Removed hardcoded if index (Paolo).

RFC v2:
- General cleanups (Willem).

---
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   9 +
 tools/testing/selftests/net/ncdevmem.c | 536 +++++++++++++++++++++++++
 3 files changed, 546 insertions(+)
 create mode 100644 tools/testing/selftests/net/ncdevmem.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 666ab7d9390b1..fe770903118c5 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -17,6 +17,7 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 log.txt
 msg_zerocopy
+ncdevmem
 nettest
 psock_fanout
 psock_snd
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8eaffd7a641c5..e4708975ef428 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -95,6 +95,11 @@ TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
 
+# YNL files, must be before "include ..lib.mk"
+EXTRA_CLEAN += $(OUTPUT)/libynl.a
+YNL_GEN_FILES := ncdevmem
+TEST_GEN_FILES += $(YNL_GEN_FILES)
+
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
@@ -104,6 +109,10 @@ TEST_INCLUDES := forwarding/lib.sh
 
 include ../lib.mk
 
+# YNL build
+YNL_GENS := netdev
+include ynl.mk
+
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
new file mode 100644
index 0000000000000..92c4fda346821
--- /dev/null
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#define __EXPORTED_HEADERS__
+
+#include <linux/uio.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <string.h>
+#include <errno.h>
+#define __iovec_defined
+#include <fcntl.h>
+#include <malloc.h>
+#include <error.h>
+
+#include <arpa/inet.h>
+#include <sys/socket.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+
+#include <linux/memfd.h>
+#include <linux/dma-buf.h>
+#include <linux/udmabuf.h>
+#include <libmnl/libmnl.h>
+#include <linux/types.h>
+#include <linux/netlink.h>
+#include <linux/genetlink.h>
+#include <linux/netdev.h>
+#include <time.h>
+#include <net/if.h>
+
+#include "netdev-user.h"
+#include <ynl.h>
+
+#define PAGE_SHIFT 12
+#define TEST_PREFIX "ncdevmem"
+#define NUM_PAGES 16000
+
+#ifndef MSG_SOCK_DEVMEM
+#define MSG_SOCK_DEVMEM 0x2000000
+#endif
+
+/*
+ * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
+ * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
+ *
+ * Usage:
+ *
+ *	On server:
+ *	ncdevmem -s <server IP> -c <client IP> -f eth1 -l -p 5201 -v 7
+ *
+ *	On client:
+ *	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
+ *		tr \\n \\0 | \
+ *		head -c 5G | \
+ *		nc <server IP> 5201 -p 5201
+ *
+ * Note this is compatible with regular netcat. i.e. the sender or receiver can
+ * be replaced with regular netcat to test the RX or TX path in isolation.
+ */
+
+static char *server_ip = "192.168.1.4";
+static char *client_ip = "192.168.1.2";
+static char *port = "5201";
+static size_t do_validation;
+static int start_queue = 8;
+static int num_queues = 8;
+static char *ifname = "eth1";
+static unsigned int ifindex;
+static unsigned int dmabuf_id;
+
+void print_bytes(void *ptr, size_t size)
+{
+	unsigned char *p = ptr;
+	int i;
+
+	for (i = 0; i < size; i++)
+		printf("%02hhX ", p[i]);
+	printf("\n");
+}
+
+void print_nonzero_bytes(void *ptr, size_t size)
+{
+	unsigned char *p = ptr;
+	unsigned int i;
+
+	for (i = 0; i < size; i++)
+		putchar(p[i]);
+	printf("\n");
+}
+
+void validate_buffer(void *line, size_t size)
+{
+	static unsigned char seed = 1;
+	unsigned char *ptr = line;
+	int errors = 0;
+	size_t i;
+
+	for (i = 0; i < size; i++) {
+		if (ptr[i] != seed) {
+			fprintf(stderr,
+				"Failed validation: expected=%u, actual=%u, index=%lu\n",
+				seed, ptr[i], i);
+			errors++;
+			if (errors > 20)
+				error(1, 0, "validation failed.");
+		}
+		seed++;
+		if (seed == do_validation)
+			seed = 0;
+	}
+
+	fprintf(stdout, "Validated buffer\n");
+}
+
+static void reset_flow_steering(void)
+{
+	char command[256];
+
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command), "sudo ethtool -K %s ntuple off",
+		 ifname);
+	system(command);
+
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command), "sudo ethtool -K %s ntuple on",
+		 ifname);
+	system(command);
+}
+
+static void configure_rss(void)
+{
+	char command[256];
+
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command), "sudo ethtool -X %s equal %d",
+		 ifname, start_queue);
+	system(command);
+}
+
+static void configure_flow_steering(void)
+{
+	char command[256];
+
+	memset(command, 0, sizeof(command));
+	snprintf(command, sizeof(command),
+		 "sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d",
+		 ifname, client_ip, server_ip, port, port, start_queue);
+	system(command);
+}
+
+static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
+			 struct netdev_queue_id *queues,
+			 unsigned int n_queue_index, struct ynl_sock **ys)
+{
+	struct netdev_bind_rx_req *req = NULL;
+	struct netdev_bind_rx_rsp *rsp = NULL;
+	struct ynl_error yerr;
+
+	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!*ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = netdev_bind_rx_req_alloc();
+	netdev_bind_rx_req_set_ifindex(req, ifindex);
+	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
+	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
+
+	rsp = netdev_bind_rx(*ys, req);
+	if (!rsp) {
+		perror("netdev_bind_rx");
+		goto err_close;
+	}
+
+	if (!rsp->_present.id) {
+		perror("id not present");
+		goto err_close;
+	}
+
+	printf("got dmabuf id=%d\n", rsp->id);
+	dmabuf_id = rsp->id;
+
+	netdev_bind_rx_req_free(req);
+	netdev_bind_rx_rsp_free(rsp);
+
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
+	netdev_bind_rx_req_free(req);
+	ynl_sock_destroy(*ys);
+	return -1;
+}
+
+static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmabuf_size)
+{
+	struct udmabuf_create create;
+	int ret;
+
+	*devfd = open("/dev/udmabuf", O_RDWR);
+	if (*devfd < 0) {
+		error(70, 0,
+		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
+		      TEST_PREFIX);
+	}
+
+	*memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	if (*memfd < 0)
+		error(70, 0, "%s: [skip,no-memfd]\n", TEST_PREFIX);
+
+	/* Required for udmabuf */
+	ret = fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0)
+		error(73, 0, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+
+	ret = ftruncate(*memfd, dmabuf_size);
+	if (ret == -1)
+		error(74, 0, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+
+	memset(&create, 0, sizeof(create));
+
+	create.memfd = *memfd;
+	create.offset = 0;
+	create.size = dmabuf_size;
+	*buf = ioctl(*devfd, UDMABUF_CREATE, &create);
+	if (*buf < 0)
+		error(75, 0, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
+}
+
+int do_server(void)
+{
+	char ctrl_data[sizeof(int) * 20000];
+	struct netdev_queue_id *queues;
+	size_t non_page_aligned_frags = 0;
+	struct sockaddr_in client_addr;
+	struct sockaddr_in server_sin;
+	size_t page_aligned_frags = 0;
+	int devfd, memfd, buf, ret;
+	size_t total_received = 0;
+	socklen_t client_addr_len;
+	bool is_devmem = false;
+	char *buf_mem = NULL;
+	struct ynl_sock *ys;
+	size_t dmabuf_size;
+	char iobuf[819200];
+	char buffer[256];
+	int socket_fd;
+	int client_fd;
+	size_t i = 0;
+	int opt = 1;
+
+	dmabuf_size = getpagesize() * NUM_PAGES;
+
+	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+
+	reset_flow_steering();
+
+	/* Configure RSS to divert all traffic from our devmem queues */
+	configure_rss();
+
+	/* Flow steer our devmem flows to start_queue */
+	configure_flow_steering();
+
+	sleep(1);
+
+	queues = malloc(sizeof(*queues) * num_queues);
+
+	for (i = 0; i < num_queues; i++) {
+		queues[i]._present.type = 1;
+		queues[i]._present.id = 1;
+		queues[i].type = NETDEV_QUEUE_TYPE_RX;
+		queues[i].id = start_queue + i;
+	}
+
+	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+		error(1, 0, "Failed to bind\n");
+
+	buf_mem = mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		       buf, 0);
+	if (buf_mem == MAP_FAILED)
+		error(1, 0, "mmap()");
+
+	server_sin.sin_family = AF_INET;
+	server_sin.sin_port = htons(atoi(port));
+
+	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
+	if (socket < 0)
+		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+
+	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
+	if (socket < 0)
+		error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
+			 sizeof(opt));
+	if (ret)
+		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
+			 sizeof(opt));
+	if (ret)
+		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+
+	printf("binding to address %s:%d\n", server_ip,
+	       ntohs(server_sin.sin_port));
+
+	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
+	if (ret)
+		error(errno, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
+
+	ret = listen(socket_fd, 1);
+	if (ret)
+		error(errno, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
+
+	client_addr_len = sizeof(client_addr);
+
+	inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
+		  sizeof(buffer));
+	printf("Waiting or connection on %s:%d\n", buffer,
+	       ntohs(server_sin.sin_port));
+	client_fd = accept(socket_fd, &client_addr, &client_addr_len);
+
+	inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
+		  sizeof(buffer));
+	printf("Got connection from %s:%d\n", buffer,
+	       ntohs(client_addr.sin_port));
+
+	while (1) {
+		struct iovec iov = { .iov_base = iobuf,
+				     .iov_len = sizeof(iobuf) };
+		struct dmabuf_cmsg *dmabuf_cmsg = NULL;
+		struct dma_buf_sync sync = { 0 };
+		struct cmsghdr *cm = NULL;
+		struct msghdr msg = { 0 };
+		struct dmabuf_token token;
+		ssize_t ret;
+
+		is_devmem = false;
+		printf("\n\n");
+
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+		msg.msg_control = ctrl_data;
+		msg.msg_controllen = sizeof(ctrl_data);
+		ret = recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
+		printf("recvmsg ret=%ld\n", ret);
+		if (ret < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
+			continue;
+		if (ret < 0) {
+			perror("recvmsg");
+			continue;
+		}
+		if (ret == 0) {
+			printf("client exited\n");
+			goto cleanup;
+		}
+
+		i++;
+		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+			if (cm->cmsg_level != SOL_SOCKET ||
+			    (cm->cmsg_type != SCM_DEVMEM_DMABUF &&
+			     cm->cmsg_type != SCM_DEVMEM_LINEAR)) {
+				fprintf(stdout, "skipping non-devmem cmsg\n");
+				continue;
+			}
+
+			dmabuf_cmsg = (struct dmabuf_cmsg *)CMSG_DATA(cm);
+			is_devmem = true;
+
+			if (cm->cmsg_type == SCM_DEVMEM_LINEAR) {
+				/* TODO: process data copied from skb's linear
+				 * buffer.
+				 */
+				fprintf(stdout,
+					"SCM_DEVMEM_LINEAR. dmabuf_cmsg->frag_size=%u\n",
+					dmabuf_cmsg->frag_size);
+
+				continue;
+			}
+
+			token.token_start = dmabuf_cmsg->frag_token;
+			token.token_count = 1;
+
+			total_received += dmabuf_cmsg->frag_size;
+			printf("received frag_page=%llu, in_page_offset=%llu, frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu, dmabuf_id=%u\n",
+			       dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
+			       dmabuf_cmsg->frag_offset % getpagesize(),
+			       dmabuf_cmsg->frag_offset, dmabuf_cmsg->frag_size,
+			       dmabuf_cmsg->frag_token, total_received,
+			       dmabuf_cmsg->dmabuf_id);
+
+			if (dmabuf_cmsg->dmabuf_id != dmabuf_id)
+				error(1, 0,
+				      "received on wrong dmabuf_id: flow steering error\n");
+
+			if (dmabuf_cmsg->frag_size % getpagesize())
+				non_page_aligned_frags++;
+			else
+				page_aligned_frags++;
+
+			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
+			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+
+			if (do_validation)
+				validate_buffer(
+					((unsigned char *)buf_mem) +
+						dmabuf_cmsg->frag_offset,
+					dmabuf_cmsg->frag_size);
+			else
+				print_nonzero_bytes(
+					((unsigned char *)buf_mem) +
+						dmabuf_cmsg->frag_offset,
+					dmabuf_cmsg->frag_size);
+
+			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_END;
+			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+
+			ret = setsockopt(client_fd, SOL_SOCKET,
+					 SO_DEVMEM_DONTNEED, &token,
+					 sizeof(token));
+			if (ret != 1)
+				error(1, 0,
+				      "SO_DEVMEM_DONTNEED not enough tokens");
+		}
+		if (!is_devmem)
+			error(1, 0, "flow steering error\n");
+
+		printf("total_received=%lu\n", total_received);
+	}
+
+	fprintf(stdout, "%s: ok\n", TEST_PREFIX);
+
+	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+		page_aligned_frags, non_page_aligned_frags);
+
+	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+		page_aligned_frags, non_page_aligned_frags);
+
+cleanup:
+
+	munmap(buf_mem, dmabuf_size);
+	close(client_fd);
+	close(socket_fd);
+	close(buf);
+	close(memfd);
+	close(devfd);
+	ynl_sock_destroy(ys);
+
+	return 0;
+}
+
+void run_devmem_tests(void)
+{
+	struct netdev_queue_id *queues;
+	int devfd, memfd, buf;
+	struct ynl_sock *ys;
+	size_t dmabuf_size;
+	size_t i = 0;
+
+	dmabuf_size = getpagesize() * NUM_PAGES;
+
+	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+
+	/* Configure RSS to divert all traffic from our devmem queues */
+	configure_rss();
+
+	sleep(1);
+
+	queues = malloc(sizeof(*queues) * num_queues);
+
+	for (i = 0; i < num_queues; i++) {
+		queues[i]._present.type = 1;
+		queues[i]._present.id = 1;
+		queues[i].type = NETDEV_QUEUE_TYPE_RX;
+		queues[i].id = start_queue + i;
+	}
+
+	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+		error(1, 0, "Failed to bind\n");
+
+	/* Closing the netlink socket does an implicit unbind */
+	ynl_sock_destroy(ys);
+}
+
+int main(int argc, char *argv[])
+{
+	int is_server = 0, opt;
+
+	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:")) != -1) {
+		switch (opt) {
+		case 'l':
+			is_server = 1;
+			break;
+		case 's':
+			server_ip = optarg;
+			break;
+		case 'c':
+			client_ip = optarg;
+			break;
+		case 'p':
+			port = optarg;
+			break;
+		case 'v':
+			do_validation = atoll(optarg);
+			break;
+		case 'q':
+			num_queues = atoi(optarg);
+			break;
+		case 't':
+			start_queue = atoi(optarg);
+			break;
+		case 'f':
+			ifname = optarg;
+			break;
+		case '?':
+			printf("unknown option: %c\n", optopt);
+			break;
+		}
+	}
+
+	ifindex = if_nametoindex(ifname);
+
+	for (; optind < argc; optind++)
+		printf("extra arguments: %s\n", argv[optind]);
+
+	run_devmem_tests();
+
+	if (is_server)
+		return do_server();
+
+	return 0;
+}
-- 
2.46.0.rc2.264.g509ed76dc8-goog


