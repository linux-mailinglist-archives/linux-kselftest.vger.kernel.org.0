Return-Path: <linux-kselftest+bounces-23508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983AA9F670D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 14:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316EA166729
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173211FCCE3;
	Wed, 18 Dec 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwyUxSWg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF921B0425;
	Wed, 18 Dec 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527450; cv=none; b=aXhsRxupDrvRF8bZT7K11teihRPQyXYDWoEMNvXL29ThyoAXa4a4JHg3IpU3lg5WfQBkWAbTxJezuZv0XWTHsw10L3HuGKEY1bZa9VrVk+x/C5pVvcdF6dEjP3HfFWe/jFwYfNBpDgBtUqPmYWds8784C3+7+K/no5lDggN9LLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527450; c=relaxed/simple;
	bh=PdyhCxIiCvxYyD0kNCUPOuthJbFGoqxPJVmAtqTiJvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+upu15c+aGsUgNT9ne4Z6AH0hDkVs+/YM1Ib8WTlYw1r13dtW6k4GcIjXFx8BtNP1/3HH/20dFQDmbsW4QdpuFqYa9+i8AskEqi+fzrb+jMsiP15aqK/DJ6T8GVD+8lwPN9FtGvTVUZhGx440Vl9YrcunWpbIl+RzK3Nqd3R14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwyUxSWg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ef0397aeso5776280b3a.2;
        Wed, 18 Dec 2024 05:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527446; x=1735132246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=mwyUxSWgeAJstMKG1S3NO3wvrfsxcTMy/Td3gywlCDDXyFkuljjDvBWu9j6AaPO0VA
         XOyHWhWe3jRUgZ0lH8wfItdHIvEbPc/A6LdDYL+PglqLGu6xdTWMl6enzoh8B8MsqnXk
         iQFR7DLcpTYTDqd4abfa25vCkOaGq88AziJ0wZtaGY1OVH9CrKhlSOZc/EWtG7Axe1DC
         nj1/XQu7dP+zpq1yVxjoi9kFOYVBIWMsSKKGAbo1wBsYEhUL9x8KKqUodM5LfmZRW5Ai
         318K76Hhba64sMVp1DUzwnj5/adoRTx0ThQUXvAJTGpiLyu7fHtHK+GetI9wXaS29I/d
         GCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527446; x=1735132246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=wfmyQKimoCWqSgEHRTMap0Eh+vpBtQBiGM/AuJUR/jt2dIPaPAd5asb9HI3FUxD713
         gNQoAau3YIm0xOo86Osf4PFCTia81YS59GhBff89s94A1qyBs45Tk3dB8hazgciaKBqN
         3+gBxoknJ+v91IzzaENwPUDZ9SwYEjKS/EElTdYRvGD0jcim9KsA21N+oVrlIP/YolEu
         2BSD/xM9E8A1Mo9C3lcBnvtK5zyuItpaM0xObg3C2Wi9RMhIDAkLwjku+NbJEjTkJI05
         JUve8rcXgIUFNp+gwzJ3Kt9JpuxQaYfzxocdiqz0dPWjj0K+5PBKSXPolJy+k2tzbq5z
         H/4g==
X-Forwarded-Encrypted: i=1; AJvYcCUKnRx/Q+f3sntBQXep7f8/Q/p1cUnoGuxSimCrQB4vno5zGDD9fkZN1ih6feKTFcxUnQ9dt87GMwES6chDtYw=@vger.kernel.org, AJvYcCVG9JrjftG/LemhBpDWmgBjTu3Q74yNeMM4w57TTD4dt+/lj+8s213HfXbrBrDvKg6HK45oCgIE787zRL9B@vger.kernel.org, AJvYcCVsGyUFkrNBUTrWzfSYsbCEHga00i19lfYYinFvbUapjZjvxUbtbQulL/8N3I4m01eeI+NJgAp4yVDy9Yfwd3RK@vger.kernel.org, AJvYcCWII15uQIMa6RhdbZR6EH/QjqhQmnH4Vpny6pNvTAZyCV3ARC8PGOc0KzWrmhh3kU6dPC8=@vger.kernel.org, AJvYcCWfyQRxtZ1CCxx1qzCu2V+GYwQb9vwGCqZcVrODbmZjoqTe0PsH4ksQL/ol1s/M26UGAjhPXooAmSCl@vger.kernel.org, AJvYcCWrMTq3BucU//B522/2nuDmfVkjiUKAgyVNJ+cv5FP1U3+OfvrBleqJ65+UWlKtVlZespG0JrHgZzRjWw==@vger.kernel.org, AJvYcCXZgAYDKB79vNAuWn9l3nsYVQYqiY64w3NqY78wdaMg7l9njg9Sbdh6xwwEWAnlv5b1N4EvnTNmhGJnEA==@vger.kernel.org, AJvYcCXvTqbZUdiJSXNiS66LjaYDWyxraUUkA6lnoar6zlboXrPmHeVtb3dQSkuLQQkaenvXy07Mz1t+322M@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDG2R0ybQ04K5alL9oA3qDm5AlTlSqNlogZopvGOiLeJlTmgW
	/zSLWCu0JbEB6rSNHv7NNlUjsZb4PmvZ+47NL0IcJBeEMY3SyXk3mvk0U1dvYY0=
X-Gm-Gg: ASbGnctir3FQR13Z87on4ZWCdZ6M8ylYYTwKOMCGSzSC05mj2EfHXOUhGzABTd7qSpw
	+7/i2yCEL7wa7ABkkWR/3bxai+WLDfMvYOQXJ+T3j1F5qiYxrkGTNA87fJZqIkN6zaPQgxtWHcN
	vUytLi/k81VdmzkTHkOuBuWi3Idv0FzKmwmjEiieP53C8etgvgKGzIJaRiscEYX5yxHnxcRyvzL
	cuZd1uq/SXBlgb7nuvnMjDcoGhI3xnOF1pb7AsLpgG4cg4=
X-Google-Smtp-Source: AGHT+IFJSba0hMYoxDtWWfQo3+fMH+6cNLxoIt5yunX4KkQHyaeVCZq9fnVPYHJO8DT42j8sEsCrNg==
X-Received: by 2002:a05:6a21:6f02:b0:1e0:dcc5:164d with SMTP id adf61e73a8af0-1e5b47f3b12mr5217374637.8.1734527446438;
        Wed, 18 Dec 2024 05:10:46 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:45 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
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
Subject: [PATCH net-next v6 10/11] selftests: net: Add python context manager for netns entering
Date: Wed, 18 Dec 2024 21:09:08 +0800
Message-ID: <20241218130909.2173-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
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


