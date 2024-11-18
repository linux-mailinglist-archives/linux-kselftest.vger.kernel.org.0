Return-Path: <linux-kselftest+bounces-22183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB08B9D1325
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 15:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311A91F223B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37781BD9E1;
	Mon, 18 Nov 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eawFkf/P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126E1BD9D9;
	Mon, 18 Nov 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940430; cv=none; b=OJ/bu8GlAt0T118iBNxePkVHygABug9EzNWtEO1ByGaTYTnMOJf6ze8uDSN1WOrQjXiqtTyHT062+5LQa5HoHcu7Wg3SVi8pjb2sWNxFizY1NgoC8fe83P9DswvYDjQHAJCAAS6q9XLHsafV8YAhNZaaoyRbBvLryYylEMtZRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940430; c=relaxed/simple;
	bh=P49fr9H0xVRpU4qpX215T6Lw8ChU2UXvkXGar2kWP84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAOOKqn42ksrQKXjvkAjTO42TvFDfJBCdE/lGrLMWGvqa0zj9wPAS5MusKG5wCUx5GUre5lQ0KSDwfmLoQAKJCy9audIth0GZMprmcnJYVqkmSwpVvkBGOLHCPeo6/o+OPmfoAShV0TQM5vI1UwyZMLDZcv0JsxknDTBkLeT54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eawFkf/P; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso2787576a12.1;
        Mon, 18 Nov 2024 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940428; x=1732545228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=eawFkf/PWYvAS+KyE7Xz7YHcep87fN/ZT2HFhPQZnlAWQcnGvdHbGKpvTHMNbAJB8E
         OQXQSGaBNUq1zPbksAfbIomdCb4tRC8IwMm8b+ludvpmi0moVdetGBswj3KzdUmsesnA
         oCvY78PTP8RPHNV8/W9vYHq77dmEvCBFb0K8srfUsDre3ztRKEHHKiob6j9Fr93QJh2i
         iqDVAHBjFoumLoBnwK/5i5hOxG9aSRSYmoGj/1RIjofx6nEeQhgEHDhHnGTNzD4AMCnr
         qZp40H04+Nb/WIrYFZwDIk8GjCZDbtl5udEN4B+qxwdNAkGIoQvThCrPUU3uedbbtJqS
         74KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940428; x=1732545228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=xPoyRhxigmdk/HFhCYeKCoXWNDHUNUgJqQxutEm5FW49YHEWhs6c9XIaqeH47OfJBB
         qp+rjQ84IP6N05V5oMYpwRYZZZ9jhCKYmwIV2rrNkwfTqbi2LtS/DqZRksG+NP+L+ady
         i+V3W9vvQdPp4d+PSQmRkkJKJFQ+EksaeU8QI0OeRWpaMeqxkszS+cXqHgV91NDryk8R
         1S6dbi95d/ufsbAbhSEKumRToLqOIqnFuyHGBsCQVBNmXzTCPd6PeA8nestX2yG+pKzm
         GutDdecrjyFLSlIXibwW1IzT6SZu4/H11jXfOUdMQ/GHxTOe8Pe3XRHbUZc+VgzJcePz
         Ie9w==
X-Forwarded-Encrypted: i=1; AJvYcCU10PjRPY/Ul9+MnpJJS/igHNwGQKIBmbD7roTAD7F2oaPpELR+aaCVqfBxibz7j3ls4t091LGqPSUUrg==@vger.kernel.org, AJvYcCUBnhrQqcoESiW7CazLHsdfvveVy5Kec6KCjC+X8SRH6cv0zEVRQ6OUCwI3rIZZYmsH+6U7sBAQqT/v@vger.kernel.org, AJvYcCUWXTuox83F1wr/P9C/DWb8V7tCR63QZTYzFNPRn/2ypYXeRNf/WEnR7DhkDl/YVUmdqVA=@vger.kernel.org, AJvYcCVzJSvIMOmsHCBsPdGHozF4eoaZl5r4qffLmm4pOtHtg0VauDslfVoevU+J585OCzk/hP4+EfiJ2wNG7Zu3MtEQ@vger.kernel.org, AJvYcCWAaWDNriEnE7YoaN7gDCiQMM6ysBzOqSafar7mGO2hMSHTGmdXdC6mp2z8AQmmuqWr8mq1Mx367SQYbjSn@vger.kernel.org, AJvYcCXEFV3KTivyoBC1GxVARnQ6OS5UA2SA77sa6qC5e9kmdVtpq4+JQfrGFrgZNXwFXiCbrrcqD3l2jOpd363dr6A=@vger.kernel.org, AJvYcCXMG1/KM0VGe7My2B8LHOktPtSEf0FGSRwVu75Dw7aeemlKBVpRtOvnkdnnsTIMosSH7vaiTQHn8sOE4w==@vger.kernel.org, AJvYcCXW26VwD2jiRNYrD1Yn6VwrWE/HUEudwktSH3E+vegEgWpga00YL+XzPJ36d2lmmtkovw9Yc9+tMhYw@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGuOubV+QaDnhldGUqH94UVCZN++dgC2nuAD4fpzorZvB1UAz
	LjpFN+rwoSV96/l3s6bKiw+OiOZUfwGR8RxjyI8VGFQnq7efWninsmndixBiNwY=
X-Google-Smtp-Source: AGHT+IEB4OLbXUI9lGpusUMTTQj7CZMlri2szirQ6bOEHE+aXQRtMaJMjzV66+oDEF7uQxq+tjw2ug==
X-Received: by 2002:a17:90b:4a87:b0:2ea:7bdd:f320 with SMTP id 98e67ed59e1d1-2ea7bddf3c1mr5084481a91.1.1731940427545;
        Mon, 18 Nov 2024 06:33:47 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:46 -0800 (PST)
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
Subject: [PATCH net-next v4 4/5] selftests: net: Add python context manager for netns entering
Date: Mon, 18 Nov 2024 22:32:43 +0800
Message-ID: <20241118143244.1773-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
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


