Return-Path: <linux-kselftest+bounces-27917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D5A49E5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7957A86DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731521C191;
	Fri, 28 Feb 2025 16:08:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB86188CCA;
	Fri, 28 Feb 2025 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758920; cv=none; b=OwFAyR1TPJI9yaZl+iNUvycR3DHv74AvWc15eeycrrPRy6AqwpWDKv0RgfBTyKExn2qGdyWRJnxZDq+0vWY+QkCzFxSNJl61xA7LJeQfK9RaBd6ut5j4Tj5e59hvFU0uTpXc/IxHtgAb9eCku6cHJONg2j01BpfPX5H1GG/uJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758920; c=relaxed/simple;
	bh=GBGR7fAnoa1MrE+FTmswdxLhjH6N3U8RXuA8gE9Y/gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdpyF6sYLMgtrB9W3sxQq8P0HC76mIiHaEUlcexqs1ADfBAUvBnd/xY2nlbs0zRfZ6XiEle4Kl4MHGru3k6gMcvRjLP8J9nt2C8KwjZq7Q7GO3JhSlnAU1ZrX+0gUfrNZpGBUG3FuTXee52Xq4znsfii24o6jFbbmYBP4WyE0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1to2uT-000093-7O; Fri, 28 Feb 2025 17:08:21 +0100
Received: from [2a0d:3344:1523:1f10:f118:b2d4:edbb:54af]
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1to2uT-000GWU-2G;
	Fri, 28 Feb 2025 17:08:20 +0100
Message-ID: <d46f5f84-41a4-40ab-bcf4-f604ea3199c9@hetzner-cloud.de>
Date: Fri, 28 Feb 2025 17:08:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/6] XDP metadata support for tun driver
To: Lei Yang <leiyang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, hawk@kernel.org
References: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
 <CAPpAL=wLk0Z3jfg9eY75c3ZFhH-3w7H--WqFuaGMcCJ+Bm5q+g@mail.gmail.com>
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
In-Reply-To: <CAPpAL=wLk0Z3jfg9eY75c3ZFhH-3w7H--WqFuaGMcCJ+Bm5q+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27563/Fri Feb 28 11:01:44 2025)

Am 28.02.25 um 06:43 schrieb Lei Yang:
> Hi Marcus
>=20
> Since your patches are about the virtual network, I'd like to test it,
> but it conflicts (Please review the attachment to review more details)
> when I apply it to the master branch.
> My test based on this commit:
> commit 1e15510b71c99c6e49134d756df91069f7d18141 (origin/master, origin/=
HEAD)
> Merge: f09d694cf799 54e1b4becf5e
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Feb 27 09:32:42 2025 -0800
>=20
>     Merge tag 'net-6.14-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>=20
>     Pull networking fixes from Jakub Kicinski:
>      "Including fixes from bluetooth.
>=20

Hi,

thank you for including it in your tests.

The mentioned commit is not yet in bpf-next, but I rebased my patch on
latest mainline and attached the updated patch for the conflicting
commit (now with proper formatting, hopefully).

The conflict was just about a section that was removed right below
my added line in network_helpers.h, so no functional change.

---

=46rom c7182e5a4d21696b9e8cd25f92e64e28129e2c6e Mon Sep 17 00:00:00 2001
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Date: Thu, 13 Feb 2025 16:28:19 +0000
Subject: [PATCH] selftests/bpf: move open_tuntap to network helpers

To test the XDP metadata functionality of the tun driver, it's necessary
to create a new tap device first. A helper function for this already
exists in lwt_helpers.h. Move it to the common network helpers header,
so it can be reused in other tests.

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 28 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  3 ++
 .../selftests/bpf/prog_tests/lwt_helpers.h    | 29 -------------------
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
index 80844a5fb1fe..fcee2c4a637a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -548,6 +548,34 @@ void close_netns(struct nstoken *token)
 	free(token);
 }
=20
+int open_tuntap(const char *dev_name, bool need_mac)
+{
+	int err =3D 0;
+	struct ifreq ifr;
+	int fd =3D open("/dev/net/tun", O_RDWR);
+
+	if (!ASSERT_GT(fd, 0, "open(/dev/net/tun)"))
+		return -1;
+
+	ifr.ifr_flags =3D IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
+	strncpy(ifr.ifr_name, dev_name, IFNAMSIZ - 1);
+	ifr.ifr_name[IFNAMSIZ - 1] =3D '\0';
+
+	err =3D ioctl(fd, TUNSETIFF, &ifr);
+	if (!ASSERT_OK(err, "ioctl(TUNSETIFF)")) {
+		close(fd);
+		return -1;
+	}
+
+	err =3D fcntl(fd, F_SETFL, O_NONBLOCK);
+	if (!ASSERT_OK(err, "fcntl(O_NONBLOCK)")) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
 int get_socket_local_port(int sock_fd)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
index ebec8a8d6f81..175dd547849f 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -8,6 +8,7 @@
 typedef __u16 __sum16;
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
+#include <linux/if_tun.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/ethtool.h>
@@ -98,6 +99,8 @@ int send_recv_data(int lfd, int fd, uint32_t total_byte=
s);
 int make_netns(const char *name);
 int remove_netns(const char *name);
=20
+int open_tuntap(const char *dev_name, bool need_mac);
+
 static __u16 csum_fold(__u32 csum)
 {
 	csum =3D (csum & 0xffff) + (csum >> 16);
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools=
/testing/selftests/bpf/prog_tests/lwt_helpers.h
index fb1eb8c67361..ccec0fcdabc1 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
@@ -5,7 +5,6 @@
=20
 #include <time.h>
 #include <net/if.h>
-#include <linux/if_tun.h>
 #include <linux/icmp.h>
=20
 #include "test_progs.h"
@@ -37,34 +36,6 @@ static inline int netns_delete(void)
 	return system("ip netns del " NETNS ">/dev/null 2>&1");
 }
=20
-static int open_tuntap(const char *dev_name, bool need_mac)
-{
-	int err =3D 0;
-	struct ifreq ifr;
-	int fd =3D open("/dev/net/tun", O_RDWR);
-
-	if (!ASSERT_GT(fd, 0, "open(/dev/net/tun)"))
-		return -1;
-
-	ifr.ifr_flags =3D IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
-	strncpy(ifr.ifr_name, dev_name, IFNAMSIZ - 1);
-	ifr.ifr_name[IFNAMSIZ - 1] =3D '\0';
-
-	err =3D ioctl(fd, TUNSETIFF, &ifr);
-	if (!ASSERT_OK(err, "ioctl(TUNSETIFF)")) {
-		close(fd);
-		return -1;
-	}
-
-	err =3D fcntl(fd, F_SETFL, O_NONBLOCK);
-	if (!ASSERT_OK(err, "fcntl(O_NONBLOCK)")) {
-		close(fd);
-		return -1;
-	}
-
-	return fd;
-}
-
 #define ICMP_PAYLOAD_SIZE     100
=20
 /* Match an ICMP packet with payload len ICMP_PAYLOAD_SIZE */
--=20
2.43.0


