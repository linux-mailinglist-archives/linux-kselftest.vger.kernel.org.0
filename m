Return-Path: <linux-kselftest+bounces-24376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EACBA0BA05
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A473A0492
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9123352A;
	Mon, 13 Jan 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3Ot6lW+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D122F85B;
	Mon, 13 Jan 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779150; cv=none; b=b78+wc98x13NzAHukQDgpPUcCqfX/qYsBmdNz9oo3OvU3u6UT/wnIph76+1rdE3kLGTiwY1cQDPtrzDpPdTacgW9sWFd6EbEgYMkY4YMjBb4hHAdYFErDg8fpEnq3o5nXIz2FNq6LXcyboJDMO6cS8rEmK0vhOE2apl4sA5vZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779150; c=relaxed/simple;
	bh=PdyhCxIiCvxYyD0kNCUPOuthJbFGoqxPJVmAtqTiJvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9E/x05jq27mX1dPGXdr0+MhDSTzx46lyRzfc+AK7vTHgF290t2w236lK1R10DgrboUdK24saQjona5/rkkB97AClEhy/JPHD73mC1pIU9Nf+0FVOTE8xWJKiuWykICjv/Wt+HhDwgmY/Vt75WuyGuxHwUWPM06tnh92dyS256E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3Ot6lW+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21634338cfdso59145665ad.2;
        Mon, 13 Jan 2025 06:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779144; x=1737383944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=e3Ot6lW+8joJAi0eKlVl2nVNUGLesEBz2Q0hc/J1rXj80ispWBadpyxATfOYlbyKgc
         64dwTybb5bkNi2lMF+kLX5ybhABUg1+AO4xUhZFV/JiZgOIiy+TvzPz49PhcpddWeX4+
         XMOOiPm8FWHTfCMcxYk+J/NcptoFdEbDt94Xn41Ep/04yvOzmFk8CUrSORF36wClb6Pf
         sXwwSv9EIeGtZ/OsCAVo7AMRvD16e0AaYqpwWDGQr8oY9AJfN98fyy31C2Wx4FeJFWWH
         +T8ROylJ1ys9beZfvCkB8I9lEROsHJZSEV7psafWdW1snJUKvH4O3RdNa6np5pbHwi7A
         gLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779144; x=1737383944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=V4cqOI8PVc2KHat+2POyCU3fwnxTSLkh4XU9oqLlyYP7CeDFa2dRajVN9s6na8V0bx
         GHjLHf/5vwCzqXj17SSBfNkJLoRHTp5fiOXmd6+RXTyDbUs1w01btc5OscvudRggZIpU
         Hln1+jD/m0fRJ014S6g50qOakn5WWJQUip2yg95Syj5DAztcJAIbNjNSmgYu0ydwnrIu
         L+CIQNkEO9eW6GA9PGcU1aJfuJ2NF08h3l71D3IniFG17nUUZCAOadgH8xXpC/hpVt4k
         MesWhWsZC2rLrRe9y994jzG/R1OvNiP+StXiES1Je0TYxgcG1rrv29FIRmR+dkQcn1vj
         QBww==
X-Forwarded-Encrypted: i=1; AJvYcCViUcUc6rMeGMWChzr+hpxO4LvQxkBzmXB7eTjPUkCpErbfNJuuWaX/ZJgzAROR7+A2hAJJ+xo+HQSbBWf3r0A=@vger.kernel.org, AJvYcCWTwNurXeqsXteB8zhgAsAOM54/8RUK6YPizfNt44r/+rUbrp9WeY3wd954XQYv8IiwbojSoYEk0g/G2g==@vger.kernel.org, AJvYcCWtuKvjtmSHHiyyeutdDcdiksUfKsmIZv6garbXW9EfDYxEghkI+1PSR6vPUQw2A8iQEwmVlRUui/iOrngtNYsW@vger.kernel.org, AJvYcCXAj3IwuLZg5JYLq1eV3Z2mQndBoNsCsyTD0LK+D2/upLl5CiU+V9RH/waydv5i6lHX0LY=@vger.kernel.org, AJvYcCXCg60Buj/SFbAemV6oub/tQT7Wsakg9Fzy5s6OvbWk1g3cVHAp7kDJVE0eEcX5WXLvso4KW1jAJOaF@vger.kernel.org, AJvYcCXaVsVXz/GCKF3P2ChX5fLnZjVATTD6YsQYIG0vgfCy/18hp31v0mOvTE2Q4SzLI+fvVB1dHAlbyDp8@vger.kernel.org, AJvYcCXk0vvtQkYH8NR10zOadZn0ShG/51m5uvUtz83DZQbv6tjzi5wDrSm31IQBRKIsbDabTz4yRMUThMSCcg==@vger.kernel.org, AJvYcCXvtRLLsrshGs1p3SnRHhL0x9qTdZhiTVyHfPbnNnZi6oRAfaDR+r9ZwtL0FuktWQ6ByaAWWXtgyP81ip3x@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5FIvWUob2CC8Gg6gyoQQjv0aqwl/2ksHjDbc9jyEGgosf0fD
	PhEyUUGrKmzl6YzOPrG3IOTAoHO6ovqlQw/6jxkwlOk/VeIFiwoDxBt9Pn/8Dl4=
X-Gm-Gg: ASbGncu1WIfjx1pz+RaF00QwJVpHoHRer7icV/6t31i6Q169qHGyM4Lw+hbzaEiqsNH
	RqYAewCqmxLFRQ4XtNG9Bkl+bw6OUPVwHQ9X643kn1ZmmqXqprzvyTmAZgSgCF6wso4jddI4NLu
	+Iq+wyPLekztmU4L8u4kIn/sMVLVFdgZPgmPtOPjmmcefPCMyKiHN89ukjbnsZPzsjYUMr2V9th
	dCuXRC7XStW+9Twjr9i2DyxzhJWy+f2RN6aYgCtLbsThxs=
X-Google-Smtp-Source: AGHT+IEL9Q/TeE8X83a4D73J5c4BnqISbL2nsMzkDnt4Xq2JHmNtTfGl7cYLX08uLNv4xfpjIcH6KQ==
X-Received: by 2002:a17:902:f685:b0:216:5002:7341 with SMTP id d9443c01a7336-21a83fde2bcmr322676685ad.44.1736779144551;
        Mon, 13 Jan 2025 06:39:04 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:39:04 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 10/11] selftests: net: Add python context manager for netns entering
Date: Mon, 13 Jan 2025 22:37:18 +0800
Message-ID: <20250113143719.7948-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change netns of current thread and switch back on context exit.
For example:

    with NetNSEnter("ns1"):
        ip("link add dummy0 type dummy")

The command be executed in netns "ns1".

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/lib/py/__init__.py |  2 +-
 tools/testing/selftests/net/lib/py/netns.py    | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 54d8f5eba810..e2d6c7b63019 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -2,7 +2,7 @@
 
 from .consts import KSRC
 from .ksft import *
-from .netns import NetNS
+from .netns import NetNS, NetNSEnter
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
diff --git a/tools/testing/selftests/net/lib/py/netns.py b/tools/testing/selftests/net/lib/py/netns.py
index ecff85f9074f..8e9317044eef 100644
--- a/tools/testing/selftests/net/lib/py/netns.py
+++ b/tools/testing/selftests/net/lib/py/netns.py
@@ -1,9 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
 from .utils import ip
+import ctypes
 import random
 import string
 
+libc = ctypes.cdll.LoadLibrary('libc.so.6')
+
 
 class NetNS:
     def __init__(self, name=None):
@@ -29,3 +32,18 @@ class NetNS:
 
     def __repr__(self):
         return f"NetNS({self.name})"
+
+
+class NetNSEnter:
+    def __init__(self, ns_name):
+        self.ns_path = f"/run/netns/{ns_name}"
+
+    def __enter__(self):
+        self.saved = open("/proc/thread-self/ns/net")
+        with open(self.ns_path) as ns_file:
+            libc.setns(ns_file.fileno(), 0)
+        return self
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        libc.setns(self.saved.fileno(), 0)
+        self.saved.close()
-- 
2.47.1


