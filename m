Return-Path: <linux-kselftest+bounces-26170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3230AA2EE37
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95600168859
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64C236A67;
	Mon, 10 Feb 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d78z8dH+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00722F391;
	Mon, 10 Feb 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194310; cv=none; b=sz/4T2UPqOPh47SiChlXlZrqERJYkJcc4+DBlsSZeDS7gVde4k+QNFjIOFVAy8scUvNDf8QnOj7PGRRMwJkDy6S7oXMOuU/iD9Hr2pqPc5W/L9l0Dl4quTb2BvXOF1/MV2qPTEmqtrBCdJjYcoyV3KTbEUrpAdYDFw/+SLtAoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194310; c=relaxed/simple;
	bh=lzUgC/O1T6CC8pluTdthNoUVgnv/C+cqDItFQE9UsXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsOSlXvvSBu4q7+AzzBtQFiy3N2VGjyrBfgXyKHLDqLWhykMtk1ih6Npz93qML2WioOuLTX+Lwsd/k3tpxrQ7a5q/zAdNO10GYuzVFKXOl995o5HsgcP1/AoFYtFReJTIFvZxfxd9yky6JFlfWdMZWTa5kBt7PziNBaUCvo0rOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d78z8dH+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso6795402a91.1;
        Mon, 10 Feb 2025 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194308; x=1739799108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ke0PFn5ns0UuVrqND5gWG1VnmGxHj7kcjuhyXJXO0M=;
        b=d78z8dH+1sOy8vwvSPL6y3tMYSovBWOg948D9tDGttOdVeACxMyz7v9ldR7VsD4O0X
         R5jtNJiUX1vdCq0qts7Ij5SOk1xQcSZYWCOcD2nIFgxHnSLRmF1fI31Cvng5JtrHLImO
         QozSaZZ136bd6o3G2eF2SK6IPmqXgt9tilesZtUlJW7aPJkYHzSaYKMI/S1XU2tBarZC
         IXZsYZdvza9YTn6h6McrccIWZYcjed2n85lzyo2SvTDQGjws5BZFGYq57AVUIxHZ799y
         kHfDUksoBPw3xiybGqkvfpENsS5d0u9f0dJYlMn8R+ajvZzvTEdeOftlITFKOSBnRuqE
         7TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194308; x=1739799108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ke0PFn5ns0UuVrqND5gWG1VnmGxHj7kcjuhyXJXO0M=;
        b=HJ3PbUfL9n0KE4l4iqhvZg+1lpvvXO/ENu9VzDcCn7CLDtZieDoLKOoE75aFBWT3td
         CdXN6Yl3DS9k6F6wrwhXem5TbGTFnCJ41hIWZ54Aaobjw5Xzu7XDGgc2kPgb4n9m3Vh/
         Zo8CmHx2uMl2IBOg/SKVoLtUcX9YcMSbM5xRBNXSUqz0E7yQAs79+zLVd+lJne4Bg2AW
         HqoPFtL6fWwVvpIM72sqR34z9R38rQNNjFkkoSaDZwICGBCtnblS8KDa+RgY+WsOZT6I
         va/dV8s9Eb+l9dyeRKPQLi9E7bLlDH5+4If51ZUBTNuz2osPwrPbZRKySIC0Ax/IkbdN
         dA/w==
X-Forwarded-Encrypted: i=1; AJvYcCUVzXatitO0nuE+pvXRs/KGIFjIXYMEFFdwmK2x2CuNXYWjkV85aO+xiDw0btB9/GQ6g8A8CrfpsH6hHjAk@vger.kernel.org, AJvYcCUlb2Pvrh6xunSaSx5gEo1finojPqjvgMBQR7JHCBbid9k2/7BmL7PE0s8MGSj00ojI1A1FSSnAWlY6jOFkmKq8@vger.kernel.org, AJvYcCUo9bWK0bZcfbsphunlY83j5+gWzcthetdp0JhetsHrgD6qhtTrUaDnAho1f4cbCYpHFj6U1d/tmNUKFA==@vger.kernel.org, AJvYcCVyZk1q8x47P0LgRlQSrzkC6a0beQdOR8aeo4EQSERRWP88yPkY6p6B+SKSevC9K5Edl7Z8a+/M53u9vf5QJiE=@vger.kernel.org, AJvYcCWnS66054xFKWdOTvjJEw61LHGNcF4UwSu+thWsePgy/khxJ/TF2vhxANCVTwUuiOLRaJR705hPhvjg@vger.kernel.org, AJvYcCX9fsL9zVWeVxG6l3SafzOTJe2vy+yXno2jCHbGKWJ1XuG4mYMVi9oiXgkqqZCzEJJugbkApr2ge+H9@vger.kernel.org, AJvYcCXXqq0FU/0lJ0YEDbzGuCaA61aMXGkK/rAex9TyfXCDpw3989DIYkiFu8gTYFixa4IPXpM=@vger.kernel.org, AJvYcCXt9rrfw7HQLWBzOCoI5F+sopXSI4n2L1458fTGBN5P7kpAjWTBrYXkSYR+NlLHUuSna69CQj+f08dMAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2RM31O6z5BRBpx5MChYPkh3PzxyO2+GqteQOW1/fudyuTgS5
	X9UN5LrjaTJZuoLa8+YvqV8RsoVcVAkWLVWZog2L/PALoFulicreaf7wfu7nyag=
X-Gm-Gg: ASbGnctOmvimp6dL98JFfXSLCzndzd3EJdzAWGDcTP4Gqk4mE0B9ZEq+QFgV4u1USB2
	tVi78vSfxp+UE2MJ9Cw1+FzSq5r67yym0IGJsDFY2nWFjaeMTxl6pgE0MPFVrHycTihRUJNV6pN
	ksO3L148vT25ish6/4uvWh2lOpMZ2yGKBZ9Z7BoExLuGDr+lFvZZ73Q2QDcGuS6tYxMJSVxBQv5
	Kd9jH0lup5qpFYzvIfFg+3CmVjgFHPOwY+zqFCCNBpJ2f1dpfYqc74LSJMez8w8rtGn8i/q8OiW
	Y1kqRg==
X-Google-Smtp-Source: AGHT+IFPiBsnnOAy2e8DGACZaeMc4ZZCgfCsAVv3/+u7QA91zVdRjIX/zkP0E7/3XIVhHqlMh6JYtA==
X-Received: by 2002:a17:90b:350e:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-2f9ffb7ba83mr30255082a91.15.1739194308152;
        Mon, 10 Feb 2025 05:31:48 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:47 -0800 (PST)
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
Subject: [PATCH net-next v9 10/11] selftests: net: Add python context manager for netns entering
Date: Mon, 10 Feb 2025 21:30:01 +0800
Message-ID: <20250210133002.883422-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
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
2.48.1


