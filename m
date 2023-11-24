Return-Path: <linux-kselftest+bounces-517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF277F6FA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79D4281DBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66FA125D5;
	Fri, 24 Nov 2023 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp0FAnbh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4843710C7;
	Fri, 24 Nov 2023 01:28:59 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf8c462766so10468145ad.1;
        Fri, 24 Nov 2023 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818138; x=1701422938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Fg7n4YOLNwtEdlT/a9JGTzCacybrQJpgDXqsVabTi4=;
        b=Xp0FAnbhAORpM8wm+2m6iWW7l+eYQQl6WYgiJRx57cBcanrCUfXXV4vI+/4P/JoT4U
         QCtxapLnTMEYbwGsDygKVJS4t//myZxeAwc8KhcJClfeQNP5HIDczPpvsx703MeifDzP
         6JOQ+83wjqkKZVAPGxsyFshudk7EJ7e1NStR4auUxrCzJYO3oJIM3WUWJILNEodZkRmm
         zWRNZENKSjoFsM5LeTCzHWw38usgVpBmwPgCvTBczw6U2PoZ5e6fVD0miu0MZ0n7bXnT
         dUR3k+h1Fo1mcfixrhTlW+r8G2DFm+iTKkgkcRjSNB/M3NKz37c2HQ0mboinqvv6D0UY
         ybMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818138; x=1701422938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Fg7n4YOLNwtEdlT/a9JGTzCacybrQJpgDXqsVabTi4=;
        b=Y1H+HBX+/jJtXewQEb9vKjhkVRG1SnJ5ehUG/5zRB7UsexcqqOzVqkbznDgfZKsVUg
         pEyQ/shT8UB7CMfClw7HBjcZVeFH7AWe041kBIrDknPB1GLdtImYy81ydBWv19o5DnVK
         iCXuic3anu8BNYJroEW3C1uJIwRgb0CLzmttTB/epQuBAojfkJM+nKgvW/dLk/cm5QEu
         DuNJm1JG7BBa7CBU9NeTazvTHJYMnhNyMvNq7dex2qHpyzNK9SX1afdxld39ki1SeUuU
         sS51hoeA2SshESgPaEEvPRrLF5+IAtjhG6kduOhyh+vVt/05DOyBIHNyZKG7IZQkUzBL
         8iyg==
X-Gm-Message-State: AOJu0Yz7zjSNRdr0DEoyfS+7vYRCjzgPmMRPhwRpT8lEQkdKeJVR8Yok
	EdjOFu64d5ib0AgP9Q2+IxZoMEzMUbwyjnOp
X-Google-Smtp-Source: AGHT+IEhw+LYSyY+Y1mH98a11aae+4PjNiNVAQeBhEEoya3kSbJfwEz3pZ9nK/itrmwXytTroyH2rg==
X-Received: by 2002:a17:902:e847:b0:1cf:8c7a:6aea with SMTP id t7-20020a170902e84700b001cf8c7a6aeamr2156705plg.45.1700818138193;
        Fri, 24 Nov 2023 01:28:58 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:57 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 15/38] sleftests/net: convert icmp.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:13 +0800
Message-ID: <20231124092736.3673263-16-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./icmp.sh
OK

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/icmp.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/icmp.sh b/tools/testing/selftests/net/icmp.sh
index e4b04cd1644a..824cb0e35eff 100755
--- a/tools/testing/selftests/net/icmp.sh
+++ b/tools/testing/selftests/net/icmp.sh
@@ -18,8 +18,8 @@
 # that address space, so the kernel should substitute the dummy address
 # 192.0.0.8 defined in RFC7600.
 
-NS1=ns1
-NS2=ns2
+source lib.sh
+
 H1_IP=172.16.0.1/32
 H1_IP6=2001:db8:1::1
 RT1=172.16.1.0/24
@@ -32,15 +32,13 @@ TMPFILE=$(mktemp)
 cleanup()
 {
     rm -f "$TMPFILE"
-    ip netns del $NS1
-    ip netns del $NS2
+    cleanup_ns $NS1 $NS2
 }
 
 trap cleanup EXIT
 
 # Namespaces
-ip netns add $NS1
-ip netns add $NS2
+setup_ns NS1 NS2
 
 # Connectivity
 ip -netns $NS1 link add veth0 type veth peer name veth0 netns $NS2
-- 
2.41.0


