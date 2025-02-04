Return-Path: <linux-kselftest+bounces-25648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4AA26E0A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 10:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957F8165E8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73033207A14;
	Tue,  4 Feb 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NyAFoNZE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD6207A1D
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Feb 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660769; cv=none; b=a9m2Vivi9wmUmDbks5NKtOSCxWznf1wXEXyerAednlnhK9k19lOy8HWgr+uWbN6aHADtJQ0BKW8kJpGtxTB068he5NwEdY5SCaYuBegGdgQudRmNvJaZwP56tK2BIycuK0IHWEYsPzuIRPr/Vjsuyh0VfvdAjhJ+8nQb4CAXsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660769; c=relaxed/simple;
	bh=+2Uwn1dlReU+p25WQX1k/dHw7cKSwopnEmrxDwBmxnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PDW6Vu+o9oC6hwGnb0GCNyFP/Le1CPyER8lekQQ1RH0wZtNo3nJMBtS3liCUJNFmY9PKAjgIwWpjufZrQTsAHmT65SoJ5LCs7R3RA5U/XePgoLFocv2JhynzB0r3gnVQQtr1k98HlYk66llABMZSf+fcWSm6NZmuQ5IinQmai0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NyAFoNZE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f9c774c1c1so829565a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 01:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738660767; x=1739265567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfosGC18V72Sx7nmApv3fJtv3M6FvNlLvFgvaD2d+1s=;
        b=NyAFoNZELOMkQXPb5m7/bLjUFK9fDbh6zw+Xy4jJ6Etsu0Lf00xa7AbW7FPSZ0313G
         W9bODi6HNb9nAIf24SUTeLag1ODzpxFyEtaOHnLaHtvSj/JGhNMdeu3eHn8VGTyQ0uvp
         auYDSuAVTpTgNTl6WhC4tp2NhBsSeGwtwZOxg2sOsIP+Aza/IAX4aQs1Y+v6Nz7Pcjio
         IbQaOgPmDImHUb3Ne827RgB8p6puyXFzD5SQLvsWwIInQ+2hWKL6o9QDy7jd194RnjGJ
         y1T20Wbl9JYDftbQfLb1Yc0ozmWlZpp/PQaPcIx5RI04YyeJk2tBYTqUngplF7xXTocr
         lXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738660767; x=1739265567;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lfosGC18V72Sx7nmApv3fJtv3M6FvNlLvFgvaD2d+1s=;
        b=CKf7bySW04l1MApDvuAnFJLNIr3pdpS687olBRscMJkBzk4nVW0ZA+MiQUv7wgb9/U
         7mB4Hhi/Da/qRzt4NGm7WbBpLMfmv43qeHQV804acuUHODxMPNypDnIntVWPbvlsH8dQ
         dRxAt8xjmg60Ifnea3AVQsb1sRGBg8/YIcp91byEhhWrNsp65kOcNBkgCYZYllXGknVB
         3delZkgmcKCYI0ZdDsdUbc62KN9ZwwbIG1ThEXDinUOlg1ca283RQhixkh89nNy0oGcD
         H7f/vqDSljRW1xiG3a4lvwcFW1HXipsE4p7hvZMkzPMkVU8uDfRBvXR6XdGspX2U2EqA
         A1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCX5tEkUzjSnDDVmSVleOcF3YgYu9rN34IP0cFWzRIHAlPaB0BxVWoBEg0uVey0WP9H8SAeU1UzXCo8O8+0w56U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8yBBG9d1epn+NQKyK99G9nKwW685kjR8Z88TYH+GCetPKX2K
	Geddm4rQ5rJfhpAM9Z65+BgVAFW4xZs0hRRCHqCVwz5qb0iL/4JLQUKucQtfPxnvt4KgFaAlkzk
	ct23w++DUWpl0HVcwHJ3yUQ==
X-Google-Smtp-Source: AGHT+IFYIQIFD/gK0d6v3SZwEHcXfXXpG8Mg55A3HITfVJNPw9tDzBqUAqo8T545lDmVO+CfUMNbBrUEkot1nYcHsw==
X-Received: from pfbil12.prod.google.com ([2002:a05:6a00:8d4c:b0:72f:f8ad:8649])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2443:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72fd0c97f99mr36855779b3a.21.1738660766861;
 Tue, 04 Feb 2025 01:19:26 -0800 (PST)
Date: Tue,  4 Feb 2025 18:19:17 +0900
In-Reply-To: <20250204091918.2652604-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204091918.2652604-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204091918.2652604-2-yuyanghuang@google.com>
Subject: [PATCH net-next, v7 2/2] selftests/net: Add selftest for IPv4
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

Changelog since v6:
- Move `getmaddrs` definition to rt_addr.yaml.

 Documentation/netlink/specs/rt_addr.yaml  | 23 +++++++++++++++++
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/lib/py/ynl.py |  4 +--
 tools/testing/selftests/net/rtnetlink.py  | 30 +++++++++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)
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
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/self=
tests/net/lib/py/ynl.py
index ad1e36baee2a..7b1e29467e46 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -38,8 +38,8 @@ class EthtoolFamily(YnlFamily):
=20
=20
 class RtnlFamily(YnlFamily):
-    def __init__(self, recv_size=3D0):
-        super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
+    def __init__(self, recv_size=3D0, spec=3D'rt_link.yaml'):
+        super().__init__((SPEC_PATH / Path(spec)).as_posix(),
                          schema=3D'', recv_size=3Drecv_size)
=20
=20
diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selft=
ests/net/rtnetlink.py
new file mode 100755
index 000000000000..b12e12827219
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
+        addr for addr in addresses if addr['ifa-multicast'] =3D=3D IPV4_AL=
L_HOSTS_MULTICAST
+    ]
+
+    ksft_ge(len(all_host_multicasts), 1,
+            "No interface found with the IPv4 all-hosts multicast address"=
)
+
+def main() -> None:
+    rtnl =3D RtnlFamily(spec=3D'rt_addr.yaml')
+    ksft_run([dump_mcaddr_check], args=3D(rtnl, ))
+    ksft_exit()
+
+if __name__ =3D=3D "__main__":
+    main()
--=20
2.48.1.362.g079036d154-goog


