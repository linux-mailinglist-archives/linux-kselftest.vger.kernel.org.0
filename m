Return-Path: <linux-kselftest+bounces-21930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77F69C7066
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 14:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E973B2E226
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFA9205155;
	Wed, 13 Nov 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNWfVjqH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E8200B8A;
	Wed, 13 Nov 2024 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502701; cv=none; b=Ku3Z5wrs54xTJD4UACLub3aMc2SpD0FxSELqCjtph4XMHN7A/mIRO6jyq7GVWH8Ulbq5YudfhcjCPPCxQfWEWpZ8rs8RnNufReuRLH8X7YthkKR+I4//qDgGK/NWqCOQNagdwuXncw0Ozv0bL4wi+8pP13LgEKRQt9t4SSWfQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502701; c=relaxed/simple;
	bh=P49fr9H0xVRpU4qpX215T6Lw8ChU2UXvkXGar2kWP84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dX+NbcwGIGP8/Xm/agYkrzSgtAkOoYqxU9JpMS4xlrF8EmmoXiQYyDsGyreVIIwXObxt94m6nGBndrZcWyqHez7WPVWw/yEYbcmbn9wvoa4Zmg1Y+s1am98o6BusFvLYlsLsIBGGEE4rc9rpPP/IQPCtHWFKkVsnweRKBMKYF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNWfVjqH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so5448993a91.1;
        Wed, 13 Nov 2024 04:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502699; x=1732107499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=GNWfVjqHetrpxvBNqAFQxtrohLNUN9sG5fmg5xv45gA93Yy+eKY+0tcAekb7JJMYel
         t0y/iU7yAwK4A8rAxoncSeRK0drqKfNHI8gDHIQavh2agKAoxcIff5pNK2dF4HqboOfk
         +Wc/rel3bCMTmDcoLrD/Nk/LiZk76iRY7DELEGpM7QWfN989HW6Z8tcxd/VGP59Hgs/e
         VrQ8iq8hlPBTljM8MomCMkXmFehTDQhuoIWu0+BWdmT0Agkhu5AC6jShdBvcVE6R1Q/O
         oIOt4bZswaBSd3DN5MRj8EYudFwV4g9pmQNiyr0NDMms8HarDlYfiXSBeSJxLnoakR4u
         sLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502699; x=1732107499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=HBBnNVmmD0aK/FPrqx0q7l8ETAcM4JoYqt7jPronReT1ep5TJdyBfwRO1n39serlQH
         hHQDjUTKWclJRcaFYs0Nk5ZnB3nZRNQcM3j2Qii8wLMTgb6JfoyMHcSP59FLr9mkhP1d
         yvviiELoCtSSa5T/x9mxcJ94dEzCemqwmMf0gIaibBAXkhPUulwjj0Mc7Xp1ejSaYET0
         rqvFzSWs4O+pwThF0VzMY04VIV+GQQ5XaLwMVEN0feIbA2g6YtGRGaRpfD0jvD3TITcJ
         AlQzuCAxiu/h+8fKdMURYH/PX/F+Ii6gJrAhkp53lPaNvtjKOD4HnPJm+7D6w+DCOx8q
         rC6A==
X-Forwarded-Encrypted: i=1; AJvYcCUKqXEF2c5vZh1EAKYGtOII8i2Ga+yIxTlPnCWMCJqVYi7dV/qB6E1YVYLT2fvZXVQWCbNBMvY0j/O8@vger.kernel.org, AJvYcCV5oib2N6BSReShAF0mxES0IQAh0nCZ7k/NpWD/X2Byx6nDsfrJY6Ct+PRDudbUkjkONq33jgo7+GKrOQ==@vger.kernel.org, AJvYcCV70N1fJwhQVi3IthXVOD359MdTxV9Nga2g2idcGSezUe6C6+Fi1OXr+2EjUOS5GYWXn5Y=@vger.kernel.org, AJvYcCVWeShzJpt3dFmfZ/O+uyHIjUNlVULQQ9FnbfmRB2ldQ4mDuJUVXpPsKpr41E0om/YRIVlYeCXk2iEfEiyEWrPd@vger.kernel.org, AJvYcCVbkjcQBsVCnRo2K7/YLo0ZdzqgaHI+GIF0j4NLTKW9BMod1RcArHpXs1hFJS84li6k3WZytPKPNlE4@vger.kernel.org, AJvYcCVumpoBHjWhP9fHfWxtSU/o2H5hXH1Ce1E2825bz7Vbtl6/tl4JfsKhjTLhU9Voluc7CZ7LonzReSxNpFi257g=@vger.kernel.org, AJvYcCWAYHZEzMM920B9D+Ryu/rQZgjeZrHdarPCtd3YGUYenImvxPc8cI8Zn2dX73UJQ24MyYvwkdOHjefqFV3M@vger.kernel.org, AJvYcCXR1fmrrX+nJpwDrLygwMc0LJsA0vMGoaryo5HnCWGAIHp1GlP8ouOBBgniLGsBV4JxTPCljo0d+9ZrlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDVAYVNe0iCvuAeIWhcnL4QzKfUb5Yx3MjXXQDmoVsZwtr007f
	eJb/zbV4sMksfWafwfat7xz30KUE6X1ydta7P2oqDHujQ/mWB6h1jI/MnLtASU4=
X-Google-Smtp-Source: AGHT+IG3aP3jfG+H+mqTGfWaQF6eC/hcm8KAxQSToRubUMwTZod3v43r/5qYZbnllxo9jc+4RsAB2Q==
X-Received: by 2002:a17:90b:1810:b0:2e2:cd5e:7eef with SMTP id 98e67ed59e1d1-2e9b1773411mr26583707a91.27.1731502698852;
        Wed, 13 Nov 2024 04:58:18 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:58:18 -0800 (PST)
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
Subject: [PATCH net-next v3 5/6] selftests: net: Add python context manager for netns entering
Date: Wed, 13 Nov 2024 20:57:14 +0800
Message-ID: <20241113125715.150201-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
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
2.47.0


