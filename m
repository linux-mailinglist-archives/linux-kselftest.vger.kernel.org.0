Return-Path: <linux-kselftest+bounces-25986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CDDA2C159
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965FC3A2EE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4F1DED57;
	Fri,  7 Feb 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuTsSJQp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E639154C05
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926528; cv=none; b=deJUgstPdpkHouZJkDfgt9STWX6puDeYe/mMNkc0kbFmeZDUZae3f+tE6CQp86gDi4SRzWpAnRLEairuZe44yfFJ3AkozixtTBHGVdLDcoVZZfGCxYrSiAacS/0Sg3SBzKTWsYGvmGWFEb/ECdmcsOcbNqCEzYsNTuCoLeqPobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926528; c=relaxed/simple;
	bh=f/yNJNGOKRY35QAo1PWoMdiBK82+/Rfv1trboTm/QHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSYuFdv+ms+jUmiBpW6ZnNS8XvfRRl4DV2nPoMpJrnsjjx7olYnY+QiN3coKG6qHEUXm21nAw/n6GY22S3c6pVPHgSPfuplF/tJv7wNjy3778Cv1qRC49K+0+Ws/lbr43dg2R5VoKc5WFus6/uTXo1qvTkWVbLwcficOp4Nex3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZuTsSJQp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f02a2410aso46020965ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738926526; x=1739531326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0utfYowDQ93T6RyTX0nJtci3hBHyGiedBymm0LKsjGI=;
        b=ZuTsSJQp+y2rbbEyJKsKcO35YPhdiTHtUo2TBJ/KNeLJz1DnQ0GvHETdkStdBVakJX
         yZAr91B3TmIdwiE5m92P7xXN++l8xRfi6R0QMTJCtcYyevcAbZn8NUBOTIvRChLiVN8P
         92Xi/3mvHjYYRWu4zez4gnB4NrgtTpncu3opChGeMW0ZSmrVGGdnKVX+ddY/GiHnJnI5
         XNU4nLCwG839nygqL+stub0SrbaOZ/084/hSg7/zHrtNw95X77NK1u89dDDDLnHQNRne
         wOBwYY+QNd6s6KRjCLS5MZGAFYQodFDozsV1j4coJGoo1prt9dmJUyO7Nv8WZgHR9c5U
         E43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926526; x=1739531326;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0utfYowDQ93T6RyTX0nJtci3hBHyGiedBymm0LKsjGI=;
        b=PGTIvzGBed+AeK9sbc2SJGWe9P2O9aWYJJfVr4+epa2ihOqOHrafeP8u8vN2BKy+eX
         uIrrC8Es9cEJUASbU0pN5X3eDxf7b+tMaZo0OEOwnUTFEw5m7TmE7SeuzSrqkWCiliHB
         FmbH6d0pzhVX0rwDox7Vjs38jlgYAsZ0EcRA25LLXYEeFDt+f5irzOb9dFhEa/127QUk
         AObGQ14+n6GENLC7vle4mmSlP3UVZSHE5j3sWO4qXtifwOEvhuduNEgQyb9ZWrGk6l9G
         t4PThRCZLFhJnJAECrcomECcLDoZoSkZTmUq2DfgiQSdzg0LvwNO5LNLtW42MDtlmCwa
         YG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs70iPh1ZzgShjiuSgvzxrYXoWOkG9A9AaP17RrAK7IjGzeM4ELHWB4xZJcFe8JUOT3jvFYV16vxX1DGGKYmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykjzkMKu3nQZ17EUnU0O7D02uraMzsXN2H1dMygbS4h58qO32M
	o+d2UUHQz5oF5CBvYecSEXEjI05C9nNJ9s3+qtuYDkbPqmJHtxDy6rYHs1b7WcNdbu7eHcaJyoQ
	U1djjUyU2QY8a97LY2kN9sA==
X-Google-Smtp-Source: AGHT+IEUbTeaAIDnwWmnGfXjl+PT41bz7Igc1+QChc81LslqObzZ54A7CFnDypHOrSf1FV1jbu6+NXmrd53KUdhbLQ==
X-Received: from pgmm34.prod.google.com ([2002:a05:6a02:5522:b0:ace:e770:ea95])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c909:b0:1e1:9ba5:80d8 with SMTP id adf61e73a8af0-1ee03b20a10mr5265795637.33.1738926525685;
 Fri, 07 Feb 2025 03:08:45 -0800 (PST)
Date: Fri,  7 Feb 2025 20:08:36 +0900
In-Reply-To: <20250207110836.2407224-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207110836.2407224-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207110836.2407224-2-yuyanghuang@google.com>
Subject: [PATCH net-next, v8 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, petrm@nvidia.com, linux-kselftest@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This change introduces a new selftest case to verify the functionality
of dumping IPv4 multicast addresses using the RTM_GETMULTICAST netlink
message. The test utilizes the ynl library to interact with the
netlink interface and validate that the kernel correctly reports the
joined IPv4 multicast addresses.

To run the test, execute the following command:

$ vng -v --user root --cpus 16 -- \
    make -C tools/testing/selftests TARGETS=3Dnet \
    TEST_PROGS=3Drtnetlink.py TEST_GEN_PROGS=3D"" run_tests

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v7:
- Create a new RtnlAddrFamily to load rt_addr.yaml.

Changelog since v6:
- Move `getmaddrs` definition to rt_addr.yaml.

 Documentation/netlink/specs/rt_addr.yaml      | 23 ++++++++++++++
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  4 +++
 tools/testing/selftests/net/rtnetlink.py      | 30 +++++++++++++++++++
 5 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/rtnetlink.py

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netli=
nk/specs/rt_addr.yaml
index cbee1cedb177..5dd5469044c7 100644
--- a/Documentation/netlink/specs/rt_addr.yaml
+++ b/Documentation/netlink/specs/rt_addr.yaml
@@ -168,6 +168,29 @@ operations:
         reply:
           value: 20
           attributes: *ifaddr-all
+    -
+      name: getmaddrs
+      doc: Get / dump IPv4/IPv6 multicast addresses.
+      attribute-set: addr-attrs
+      fixed-header: ifaddrmsg
+      do:
+        request:
+          value: 58
+          attributes:
+            - ifa-family
+            - ifa-index
+        reply:
+          value: 58
+          attributes: &mcaddr-attrs
+            - ifa-multicast
+            - ifa-cacheinfo
+      dump:
+        request:
+          value: 58
+            - ifa-family
+        reply:
+          value: 58
+          attributes: *mcaddr-attrs
=20
 mcast-groups:
   list:
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests=
/net/Makefile
index 73ee88d6b043..e2f03211f9b3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -36,6 +36,7 @@ TEST_PROGS +=3D cmsg_so_priority.sh
 TEST_PROGS +=3D cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS +=3D netns-name.sh
 TEST_PROGS +=3D nl_netdev.py
+TEST_PROGS +=3D rtnetlink.py
 TEST_PROGS +=3D srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS +=3D srv6_end_dt4_l3vpn_test.sh
 TEST_PROGS +=3D srv6_end_dt6_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing=
/selftests/net/lib/py/__init__.py
index 54d8f5eba810..729457859316 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -5,5 +5,5 @@ from .ksft import *
 from .netns import NetNS
 from .nsim import *
 from .utils import *
-from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFami=
ly
+from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFami=
ly, RtnlAddrFamily
 from .ynl import NetshaperFamily
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/self=
tests/net/lib/py/ynl.py
index ad1e36baee2a..8986c584cb37 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -42,6 +42,10 @@ class RtnlFamily(YnlFamily):
         super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
                          schema=3D'', recv_size=3Drecv_size)
=20
+class RtnlAddrFamily(YnlFamily):
+    def __init__(self, recv_size=3D0):
+        super().__init__((SPEC_PATH / Path('rt_addr.yaml')).as_posix(),
+                         schema=3D'', recv_size=3Drecv_size)
=20
 class NetdevFamily(YnlFamily):
     def __init__(self, recv_size=3D0):
diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selft=
ests/net/rtnetlink.py
new file mode 100755
index 000000000000..80950888800b
--- /dev/null
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_exit, ksft_run, ksft_ge, RtnlAddrFamily
+import socket
+
+IPV4_ALL_HOSTS_MULTICAST =3D b'\xe0\x00\x00\x01'
+
+def dump_mcaddr_check(rtnl: RtnlAddrFamily) -> None:
+    """
+    Verify that at least one interface has the IPv4 all-hosts multicast ad=
dress.
+    At least the loopback interface should have this address.
+    """
+
+    addresses =3D rtnl.getmaddrs({"ifa-family": socket.AF_INET}, dump=3DTr=
ue)
+
+    all_host_multicasts =3D [
+        addr for addr in addresses if addr['ifa-multicast'] =3D=3D IPV4_AL=
L_HOSTS_MULTICAST
+    ]
+
+    ksft_ge(len(all_host_multicasts), 1,
+            "No interface found with the IPv4 all-hosts multicast address"=
)
+
+def main() -> None:
+    rtnl =3D RtnlAddrFamily()
+    ksft_run([dump_mcaddr_check], args=3D(rtnl, ))
+    ksft_exit()
+
+if __name__ =3D=3D "__main__":
+    main()
--=20
2.48.1.502.g6dc24dfdaf-goog


