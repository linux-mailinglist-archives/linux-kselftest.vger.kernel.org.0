Return-Path: <linux-kselftest+bounces-26970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AD1A3BF26
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FFB3B4DAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236C1FDA97;
	Wed, 19 Feb 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRoOiMNE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4A1E3DE7;
	Wed, 19 Feb 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969565; cv=none; b=CVY9wtKrSm32R/M/dY6VriIGpiSOcAzbL70axbv9StasaEVR7XGagG5xbQzpIRD2+HW6vqI5eMDzgH1cHeEFod0cG/2hqfRggMRY24fx3poTCaqNSRADT8PB2h1sf1WwDl9wBQGdLEG6inhcSDK8Dw9Sz6/Gn1m2Fx2xoCa/Fbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969565; c=relaxed/simple;
	bh=d5YqzA1/hOIwxn+aPZBjNIWViPAXuH4DTCUtu2j0BLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIkDJDgNmBEOWl0Ypat5/TRHUh7QYmxPpMBa7tCJVu7K2OO2gWCAbka33iZznABQORJ/vy5n4TG7BDnGNE17pLuzFaS6QhpY+YlSTOQfSzBb/3f3hfIZjpwypP7Cx7yeMG7nhcgWaCK+UCH3e+TcHfZkm8QY6lKmJDwfe4Hn3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRoOiMNE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so1358452a91.1;
        Wed, 19 Feb 2025 04:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969562; x=1740574362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h02RoEg/neSt/B+WrRVdIe6OiEkHR+ibxktqvHMDB4Y=;
        b=XRoOiMNEA5nlmQjsaluC8FmB83TRr12P3FH9/2uOpeg1O0xdxx+89DNwOViuJggJPw
         67LOuu6KoHXBdizFr+mBEwE4j4r9J+aCVCJq9+MtAJ3QeVw7uw/IfPj9uDVeQZPMFw3m
         X3JwNUriD4UesMyl/gv70l9h2jw/s6uQ+v8i+oOTOQPzi3J4AIkvQbj6s3OXJDqU8/Ip
         WvaJHBgunrYMbKo9590Ti+WsFNK1VYb0YpwN/NiRYGAZ6wOgf62Y3SeMgBLU/EODJ+ww
         LJJfLHtspYbaKF3z24XiFeQzQjQXVoBkE+pEMNAZu9FKBAtJKbVkKOFW2Jus0/NHOHYU
         PNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969562; x=1740574362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h02RoEg/neSt/B+WrRVdIe6OiEkHR+ibxktqvHMDB4Y=;
        b=qxTTVaRciIyFxOLYJLBuX27dSDVRk9FguwrJXwxaY5UNWVoAAcub3ookwpdSWsBk4Q
         s4U+tP6NJOfbNh5Pdah5QpDMbyKErjyX2OnOUEcbT5Gigj//gHBiYJCsqWiWjfuzwpMH
         2KEwonwpb6hquEtO2U/1PdXoluUnTQJjjLIq7dHnDvI5/8njGlE27Re9jtfQgaQvnq7d
         Z303oSqB10niKf5VUuCrFRxXbSeoPmrVw5iUcPVdKDWc2r3sEEDx5pzMwUngTGKzr1+c
         0BM0hcXcGJbdHEjlCU9EiBmofSjhlAYcAwXcA7Ychb0KOFK4RKyQZOq1RIYk3vahNgm5
         Nuuw==
X-Forwarded-Encrypted: i=1; AJvYcCVHbnh4j2UJTE7NnfasZtuqjgTJTY17WmVSxq8s0zJQfPL+RJgdWbvtmDdpoqVAlNZJSkFhpToaMs97xA==@vger.kernel.org, AJvYcCW831ieJxjB68C26RqnP+xhYQIlPJBdqZQg6GP6QChDivhvRezDGUubcV4eP0w80ON6tpyLnT5AGkKFaQ==@vger.kernel.org, AJvYcCWC6D8tTjYzO8+hyqPpHLy189tvILJZ0fomh5c0nn7+oU4gylPcVSUX/ijTakkOD4J9DCRLGzRSit9T3aIG@vger.kernel.org, AJvYcCWu/uqwGbeLqQ+352HoAPZw6oZWQgM9FEN2Zy0xSAYHLKwxp3ieiQnoehWUUrbqw8ZXI8P5aq2yjMQA@vger.kernel.org, AJvYcCX0hyhFsDoVWeoAvUIgurfNG/2gyLsgKLtd+LtZWYnUGJOAFZKg4NBmVQZPee7lOMjOtok=@vger.kernel.org, AJvYcCX9FqNzgL7C+AxkMqiJPKbv8sLubiy4sRXQeWok5QkgwG/mWFGFFfeUpTFs00r77XJJjkbjeE9kkthn@vger.kernel.org, AJvYcCXY6ZwNOhwpRf8Sayq9COebHqI9CVgw8RRatz+qGjKKTftvJPj/2YFsAdtLXrFDe1xc9s7hdGaJeQCBwfZiTM8=@vger.kernel.org, AJvYcCXfnsfPTUuZqk8OK8z/irPrwA3xENfXW/XtRA+RjA3A7pFYImLhIkrAG6CvnnUtgUXCNtIjiVH+x5iSRMtpMved@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTyR1kKC/eIQK4OvYpAAI4w560/Y0G2PTJ4IfUP6H8V3YUHUu
	NeFK0LIqg4PZVFwKBSBDlze4eO3YqJ6BrufYb8AIX6LqxCz6aF6q/QHp8KNp
X-Gm-Gg: ASbGnct6pPE++9k3dtjYeoKTxZfNc1C7DXi+YvgeikXDcM83aGCVc3F7hDyNzYHU33d
	qBMu+85LKDgy9tJHu2b2k/oDjQhRujQcUUC6Z8w8lD6hWi5lKmMdyfR/U14zKfh1F1WQkRPlI9g
	UZQEW6QSy82wkIqyjUKPf4vsebQJKSnnYVVNgao6FhqparN77oVmq9zANPJU2z1lITkOC9AFq6N
	3r5TYBvDjY0GEHsmmq7Ehuyc8zB574PtSnjz+OOxzhpAlCi/yPS0RJjvSzlcI+2s9v81IAJlka8
	TmI6Yw==
X-Google-Smtp-Source: AGHT+IHPqeS3VaEOgvZ8Tx3PUVaGMIEIbKpPjORqTeM6yeMS+BbAs1PKrGLT5/zDq05f9NI0VnGgXw==
X-Received: by 2002:a17:90b:2887:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-2fc40f26600mr24663034a91.21.1739969561721;
        Wed, 19 Feb 2025 04:52:41 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:41 -0800 (PST)
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
Subject: [PATCH net-next v10 12/13] selftests: net: Add python context manager for netns entering
Date: Wed, 19 Feb 2025 20:50:38 +0800
Message-ID: <20250219125039.18024-13-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
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
index 729457859316..8697bd27dc30 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -2,7 +2,7 @@
 
 from .consts import KSRC
 from .ksft import *
-from .netns import NetNS
+from .netns import NetNS, NetNSEnter
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
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
2.48.1


