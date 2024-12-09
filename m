Return-Path: <linux-kselftest+bounces-23044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78659E984F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B6A1633E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84891B4223;
	Mon,  9 Dec 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVkCNNR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417181B041D;
	Mon,  9 Dec 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753168; cv=none; b=a54uZkup+f66Badul/d60ofxZppr9HPpuMYr5iJMJ6knBluvFH1o65ybvnHNozFM04yP9xGtWq800ni8NhJeB7IPqsS9DVgo3PC2byZ7Dc47Gg3oLt7QvCMQclvQOVx+IPIqiSawBl7WljtOmp/nVZvQMh/fjB0BO91aT2XV/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753168; c=relaxed/simple;
	bh=PdyhCxIiCvxYyD0kNCUPOuthJbFGoqxPJVmAtqTiJvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/zbH9wnTfrJ4EumzOHnrt7+qls93fkzK4VW/NF8rUhA+eRwr02e5rsTZAQurMaXObaeHPtXShZUoFGalTMYRTxJqcyArwSV+EVWeyfPlRubammYKcAcpfie2Ga7XyGRGsEjsUtWW/O+Xa8TKYpl74L0hxOtN0nVBFEe6TEfXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVkCNNR+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21631789fcdso10136295ad.1;
        Mon, 09 Dec 2024 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753166; x=1734357966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=eVkCNNR+UKL8FReBt63H9WAvQni4P76FTC+P1dlE+pA2rp0attiuUQgoRli716xlxL
         zt05pD/it7OUs9VN3oAcMihjUe3hoKiXsuGbLSGj+zUeDt94TwVsj2/0F1DpD32m3is2
         /FIH7I6z/nuC3KR9DQ1PvCP3xiInTLB0uL4P3/2TEBUlQPXsq1bHzO3x7nYq/d3o6jcZ
         TgEx0Fg354yIVsbCcJZnjQ/7/F7xx1rs2wmmkowOtIbcfBn03OqKRoQKSEqmH4nk1S43
         2MJVTMvULajp4ERw2l18WC6jwdAssKlswz9Wum7w7kiKTG4GVqiEZnmFxtOPc7D4aZVP
         ccMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753166; x=1734357966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=KxrycRM8B/OeZBQfCzYZbzRtC5P7FkuV8AOcHudnxxNKk+YbZv1q3KhMtjiOwtOhx0
         VE4qTwVd2LX9qyeEh0MMhpQ3Fh9dVKgb3czrnuJ/n9gnliOon2G9rv6fCkwJ8lerZjqS
         Azd+UxkFFYCLzSLx0g5B/Z7LYNJLsjwz5VESoefqCCGtSyR2MYSiBubfKzp0fQU1wEjw
         NAx5pal++FsE6XIG2H6nxzjpjFkqoJ9gvF3717GKJM5X5iw+d6S1iiBb+uWpwp39fY6Y
         nJ0h8eEzsMFYGTUKp6FoibBVgwkHaJC2zApnmfXr6Y8AN5yNPg3qVa8VaI8SW6J1ZXn7
         l5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUFt5mBA5dCVIyqXgZeXF7sODjA1wWysuGeA/Q48qzqeQshZIl7MjXzCMR1y7VKdrl0h3jcuqarxwhVpw==@vger.kernel.org, AJvYcCUSjv7L7maGTOj3FKSLsLyY28y4b9ODNOafRFt+6gnzM2LvD6+BlNL7JPd5BqMBkq8BL2wP9jwbKpWQ00AW1pxO@vger.kernel.org, AJvYcCUXo1rY5l/Ucp1vrTJ6Np9Y+qsITk/YdoqscT9Yr8hVnCuxL39uSHCOLi7iEnXzZOqQY/LHNj3O08f0Zaas@vger.kernel.org, AJvYcCUoLOoQCfSXTZY7UKxQOC7G+RbB+PnRCsZlzoQLQ7xhM8wXwp5jFSxRSUdKBD/kmVgKCfsjrgT2dHB8+Aa1Nqk=@vger.kernel.org, AJvYcCVEQnjVM2ouJ64JHJywMgojFRAxn76M4qUHf3NYR7Ds3ldSOfYERnij2UqnauQGTenR9H4QQKF+URr+Xw==@vger.kernel.org, AJvYcCVJfolVoh7M2IlDlNm2xbVCbJIzDFqm0L8IYLQle+c3ccLW2Dev9ATPNCF23bWam2lclfk=@vger.kernel.org, AJvYcCW2jTVbq1qATm37RyEPbnDum7pJpi/uqo2hZmvHE9P62VrTVyMtWzsZ04ezfb4SoEomL8PCJUhBBQUr@vger.kernel.org, AJvYcCXhZeM9RY10QyZyAKG9J8WnKx+DzSNqRRQIaxmJaWReHUyRx3O20vp/UcFRsn6C2SGyAgDQ/lt7mFdf@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkq2opGi4KdHaORgEo4/aaZ9w1oWrzjdPjwG6PEpEb6AgN1UB
	ZyKFb73Bautcg8+qAYfbkwaP/+BmMoE+o6bUv8wFq453xFrboyS17jx0qrnGvsU=
X-Gm-Gg: ASbGncs5g4JZQUv7VDThNT5hRThmpD1XPH5X1SwZ8qw7qLWapTmYrBkIV9canCzbJQY
	ysYT7Bkabn9pU+Azv+OidTdZu3Zy2tjaUnP1s/7qLj+WuE1iHaM5dLS2lm/l66WGeWeFoB893fF
	7Ipi8yiasJzpjDCkW731np7u74Mr+lEEJQBnsPzS/dr7WWO/ws/5XMy0kc4849EiuxI724+80QF
	VMyFHWBzreMf2jZxuoSKXVlo4L/N3Sqn6iTCW3AuugVlfc=
X-Google-Smtp-Source: AGHT+IEgO+eAsdpey+DR5/LF2b2LrxgYAnjIwOd9wPEert31MRK25WTtIv1pjQ5j1prur61gIiJ4iQ==
X-Received: by 2002:a17:902:c949:b0:215:58be:334e with SMTP id d9443c01a7336-21610b3539amr198169675ad.10.1733753165835;
        Mon, 09 Dec 2024 06:06:05 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:06:05 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next v5 4/5] selftests: net: Add python context manager for netns entering
Date: Mon,  9 Dec 2024 22:01:50 +0800
Message-ID: <20241209140151.231257-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
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


