Return-Path: <linux-kselftest+bounces-23911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48302A014D2
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 14:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18BA161A59
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5941D4605;
	Sat,  4 Jan 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COJmNev7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F11C5F08;
	Sat,  4 Jan 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995550; cv=none; b=Shj33mTcG++UfOc7mciwwyES9zQcDkZLqgbplOeUK2tNH/yEqsPx7m5pO7R5J2tUiB4Ytp4zKaeS+SfSgfVfnYWYoqwvwx6LnCgqasmE7RdNa6srUc9YW+TnOdST5CtlUnUbpsRaxEf6nT71A8LCTILnP73MZafntnLnbQXRUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995550; c=relaxed/simple;
	bh=PdyhCxIiCvxYyD0kNCUPOuthJbFGoqxPJVmAtqTiJvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfYNZUhyvpb1njBq5CuOqVknfaedL/H8s6GnhT8dN4iKMT10IdzWu2rq+Sldz3ndhecmGqTnGW7AlNDxtnbAofVfxIEB52EqRlt1ZZH/jp3nkiw/iFepsmf/w16CSWc+uceaGzP9WMgLTLJKIP9LjakbPchszwE4fxzj21jH+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COJmNev7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2165448243fso218865615ad.1;
        Sat, 04 Jan 2025 04:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995547; x=1736600347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=COJmNev7P9C36EqDDqGA4iO37FHDFEmtcO7NlMTIFYdLPWsxk2BRcXPv0pJh6k3ay0
         gfqbfU7AykbcofYEaDxJlMM+w9C6ugkrz/EQA8BhsAFZOwd+pmy4xpTWS06YLeoiiAqK
         zIn4J4rcyYwV9ySzC6qnmjYCt8cqvuELQo7jHs0FdCX3WP1JBEawy0xp46sJgAkYhAqS
         aT3TyDgDJldoHQMnZLkbj8MZmSt//6hLWZxhnXLk6guE3IFEW9NdiOTEtWzpKs2li8WM
         KtaoYxfZ55koS7HW7H9Z8GFRIZiH0YFovnx1bF385C8A9uIg4IzZNC9QktRMYiXTDTE4
         Jo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995547; x=1736600347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=CrNE7m+rloCLJF0oq7F9/TmbYQiV9rH7Fk8ZiwUkmWo3V2WW3iEygZszJRRGvLCBoo
         eyD2mSruWFBwSciEQwobMc9Qp+WR2FAAjoRH8ZTIcn/lIaa1CfpROc32hOhGwDJEIhYf
         2xOiWurD9f822IKhbqdn78qrkP+NqLNSYazGHUgw10zm1JZsUxJQcYnbXtZNcLEWv0ZE
         2fEwbjFRG343mBcmg1jcpG4/dd6OafTSKoy905DKWWPERx7Dn7iDRdObolUiKr2G4urE
         MCS8VX5PaB3x4Moa4IEdmJRqJXxuX4gpk5ZslAYy7gmWcl4FDkS1MgBqX/ErJWyvFgUO
         9toQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3RmIR2pTHOj/0YwUD/cPfYoe3ZQ4KXRmZPhGyz+Arv0XI2DNTilINVSTt761vbsPJmdmVP+NL6s/TQ==@vger.kernel.org, AJvYcCVDVr8SnB+c9NKnA6V4eBTcId+1Tqb1JeVjHT6MEtrpQA3MuiQQ1v20i4aNZshM7vYX+0c+kkA6jO5p@vger.kernel.org, AJvYcCVKwwKsagkO14Mre/NM+YTjSozxfCWSiC9tp+MJPmAWyVIwJ+1Oh3rKZnzgx+5P6qx2mIgG39akZ8Kghw==@vger.kernel.org, AJvYcCWCXT+LuCqMorlz4VhGx0vwaFObJddqLi3Kp1E11G+hJSUAP6zumD8X5BI39vXZrb3k1XlFFPnBlrvrZwYr@vger.kernel.org, AJvYcCWbgOzu4lzKm7NgSE+BLXdNvlyDENLAAJtOyhzLiqoKw0sTxI/GARPiHIydTiqr8cmAjakhzYPqABy7@vger.kernel.org, AJvYcCXIxJCbXM9HKMG15nXYk0WlchefSKeuoaUpCplA9xLrrXWRERceAHcf/j2Q/BU+b/wIXmME/yLCtEc8wMQJ6XQ=@vger.kernel.org, AJvYcCXZnyIznZomIjUbsGGS2wuxIrVBvEHv4QRe+SdVu6rJslKxtrrYDO9caERTAdlyFIBn37g=@vger.kernel.org, AJvYcCXwAt7boof9xxs1nMZD9awADlPWAIHSvTQT9MXoN8/+sWxV9e11mRfnw2nRR34XaNea5phwjTTUgBhNW2xreAk/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7X62yuC2NhLcu/uljo6qdB1BRK0xl0amATGBNQD59yFbFQjkX
	9w6g28e8LmtKY7CBcm5RNpCgbL9lgH5DDszv/g61hJX+vR9MF/GhpvJSVFJ11ic=
X-Gm-Gg: ASbGnctd50UFk7x8mXb8YEwaf4B0v3P505p62tAr0XknEss4ZsdFuOGkacb/U3/jAoS
	1ZXkv/E4+G4l7guK7PuGBZKXFCQAzmz6vHkNW+DAdpUhaa8uMIXnpeiOdanM0R3joh5rC3hAoHm
	tGfi6MTreANAxwmjXEWgfblKdqaU84Sq1nsRjxSAfgfdEj7uxV3RlP5fIZliMqFvM0abyUzjs5B
	83+aUzXo5oHQyBwge8D5qkvH6FVxGS/wSD03iKxaRh94bQ=
X-Google-Smtp-Source: AGHT+IGUseWUHEPuZ2azBnIbXH4/rAn+CSEtKsSSu9kCqJsAhEDYnxH1YaaDUJFfNwCRIx8vP1I8ew==
X-Received: by 2002:a05:6a20:2d14:b0:1e1:dbfd:1fde with SMTP id adf61e73a8af0-1e5e04a3427mr79059917637.27.1735995547161;
        Sat, 04 Jan 2025 04:59:07 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:59:06 -0800 (PST)
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
Subject: [PATCH net-next v7 10/11] selftests: net: Add python context manager for netns entering
Date: Sat,  4 Jan 2025 20:57:31 +0800
Message-ID: <20250104125732.17335-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
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


