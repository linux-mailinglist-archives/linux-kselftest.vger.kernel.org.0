Return-Path: <linux-kselftest+bounces-24697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6CA14AF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E951A188D6EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB91F8917;
	Fri, 17 Jan 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2GoPwR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2381F8906
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101784; cv=none; b=TpGf0ZP6H/+102Y7iP8X63lXCu0yUg/tbLZu3SWKOVkZPFXkNpEKZGzoXUUPF8FwmVsFa+PYaFGQ7nTsb3TJS+EkedzF7606j6c/i5FErEI5H3lNyRZe672jv/mk6Y3IxtyyxZm4YfyWBmryLiAdrH1zeUfwUga5Nfgu95S1tsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101784; c=relaxed/simple;
	bh=IEstVE73bxSWMoqBp276ZR+huMjCwaHah5tR3p0yfac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PNUoiFHFCStqacGQ3d6RpETko2oMyVSGI3/5JW8SUDh7noe7e3ODgJlxpP7NpfNmRACovUyX0/nNvFo0WlBUjG2rsYeDtBImlZ46+i//E8mVoQk+x6v6KZJ3rhJGBnUpM7XrRMiUgMy4mRXmWq2pugPFpecv+1MiXs9BwC0I34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2GoPwR+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef35de8901so3612726a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 00:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737101782; x=1737706582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jy+DCfw2XCGTlv3unkqWdeg12NadzWHbDdoF9mTjolA=;
        b=T2GoPwR+uXPKDVzEZpINNNadwXDRN0n/IhmVIt1aSvnpKgdYXtKcs2CCPb5PKU4no8
         6Bg5gNF5nsfKpFocXmpe2+Ci5cs6TGZjnoZeOiO6+0OJp1HNkE275qt4l/5UN3Fi5Dfd
         F2cYFRTDACYUvSFxO5i4CMG5MqGEhb62sjjIS4OlhPmf4EARhiT5Fj7PSLFKniM2elGM
         nrLJTIUof/lcmWswRaWOyHifjore8mhkbV26RN8P+30zcvvmmbDctj+4miSIe9mE4nZw
         IbMD1ivcEA2gxa+H84fvpCLn+mS7Kcd+ahugdO6VrwehYrkpLU6SQlrW+c3TNrFurGOe
         +uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737101782; x=1737706582;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jy+DCfw2XCGTlv3unkqWdeg12NadzWHbDdoF9mTjolA=;
        b=k2CESjS60gqpyTYn1VOK5/QeA3bqvOhT2mq74el5MNp5jQXwZt94kRY8VXpfukW3OE
         eOyTy98Ap3wCMmk2M2AdqF2xOp1flBsZHtObbr40Y9ecgoOME+5DlNv3/H+qAiS6HX9O
         cjSeOaXUKwgVJiVPOp9He1Yb2p1Xp3fJEC8veVeKQDdg4qtPIUsfy+8Jzw/pDwI87SdR
         pvLJ6GUQ+hLvvV69q8X0ydUhENA8Mn4GjVo9hKaEDKZtx7sDDkyShBSB8r2KNvBT2qZT
         iCRm25bdQJBAAoJSec4z99Ax3dxhzAmNLFsUSUuFWfM4aZedHju59y/pJ5SpxvwrW/mW
         KHWw==
X-Forwarded-Encrypted: i=1; AJvYcCXDjQvjTM2WJ0fMQjhMX1r00ad42KpGPwRYarvCYIgyQZVvfjJHurA8wI2EkMvGRlv2MJY0c5iqi88bUHh56IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CcdnuRZLuAGikZ4XgkjZdwrVX1g5ZjRvRIY+hyOdFjIknDdw
	p1zGUl1gSfV0UOBiywYBkJcT2PwR3pfJvKAqd4B5g9ITmCF+HJwLpXXcSK4eZakkfrdqWfGgD9U
	MQ/0Oo/HMmuerbLF3SWkVUA==
X-Google-Smtp-Source: AGHT+IH9nwERlosMjdsEgTvUTZz+UtSdbMO37OfoSDYJmN7EC6YhT1wtQhFI+n2ONrpgFvtYnN8Zt+OewnGkfl5kgg==
X-Received: from pjwx14.prod.google.com ([2002:a17:90a:c2ce:b0:2ef:d283:5089])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e41:b0:2ee:b875:6d30 with SMTP id 98e67ed59e1d1-2f782c779d1mr2586862a91.9.1737101782036;
 Fri, 17 Jan 2025 00:16:22 -0800 (PST)
Date: Fri, 17 Jan 2025 17:15:59 +0900
In-Reply-To: <20250117081600.150863-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250117081600.150863-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250117081600.150863-2-yuyanghuang@google.com>
Subject: [PATCH net-next, v6 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-kselftest@vger.kernel.org, 
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
 Documentation/netlink/specs/rt_link.yaml | 70 ++++++++++++++++++++++++
 tools/testing/selftests/net/Makefile     |  1 +
 tools/testing/selftests/net/rtnetlink.py | 30 ++++++++++
 3 files changed, 101 insertions(+)
 create mode 100755 tools/testing/selftests/net/rtnetlink.py

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netli=
nk/specs/rt_link.yaml
index 0d492500c7e5..7dcd5fddac9d 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -92,6 +92,41 @@ definitions:
       -
         name: ifi-change
         type: u32
+  -
+    name: ifaddrmsg
+    type: struct
+    members:
+      -
+        name: ifa-family
+        type: u8
+      -
+        name: ifa-prefixlen
+        type: u8
+      -
+        name: ifa-flags
+        type: u8
+      -
+        name: ifa-scope
+        type: u8
+      -
+        name: ifa-index
+        type: u32
+  -
+    name: ifacacheinfo
+    type: struct
+    members:
+      -
+        name: ifa-prefered
+        type: u32
+      -
+        name: ifa-valid
+        type: u32
+      -
+        name: cstamp
+        type: u32
+      -
+        name: tstamp
+        type: u32
   -
     name: ifla-bridge-id
     type: struct
@@ -2253,6 +2288,18 @@ attribute-sets:
       -
         name: tailroom
         type: u16
+  -
+    name: ifmcaddr-attrs
+    attributes:
+      -
+        name: addr
+        type: binary
+        value: 7
+      -
+        name: cacheinfo
+        type: binary
+        struct: ifacacheinfo
+        value: 6
=20
 sub-messages:
   -
@@ -2493,6 +2540,29 @@ operations:
         reply:
           value: 92
           attributes: *link-stats-attrs
+    -
+      name: getmaddrs
+      doc: Get / dump IPv4/IPv6 multicast addresses.
+      attribute-set: ifmcaddr-attrs
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
+            - addr
+            - cacheinfo
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
diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selft=
ests/net/rtnetlink.py
new file mode 100755
index 000000000000..9b9dfbe4dd7b
--- /dev/null
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_exit, ksft_run, ksft_ge, RtnlFamily
+import socket
+
+IPV4_ALL_HOSTS_MULTICAST =3D b'\xe0\x00\x00\x01'
+
+def dump_mcaddr_check(rtnl: RtnlFamily) -> None:
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
+        addr for addr in addresses if addr['addr'] =3D=3D IPV4_ALL_HOSTS_M=
ULTICAST
+    ]
+
+    ksft_ge(len(all_host_multicasts), 1,
+            "No interface found with the IPv4 all-hosts multicast address"=
)
+
+def main() -> None:
+    rtnl =3D RtnlFamily()
+    ksft_run([dump_mcaddr_check], args=3D(rtnl, ))
+    ksft_exit()
+
+if __name__ =3D=3D "__main__":
+    main()
--=20
2.48.0.rc2.279.g1de40edade-goog


