Return-Path: <linux-kselftest+bounces-44080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A108C0BD35
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 06:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21EBC4E7F06
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 05:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91B2D5C8E;
	Mon, 27 Oct 2025 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWJLei58"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA921A421
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 05:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543138; cv=none; b=MfdkphknzlCdGHrBwMnc8svSDHhqQ+01A8jj6iYn6BTX5Mt3Bp/W0vqMhvmLIhKSFSXr+gTMWtHnOQxNxkoaEbdDKXffFlcb9C2UwdHvdjUVWvn5zMt/lmcbSwgvFLqn2mDPatJCaEF9bRx/LvcResOiK12mUOvzHwdWNrB0log=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543138; c=relaxed/simple;
	bh=BiZQZWYzCEbU/wZ9q9vihxV/NEjhA6GMCF121pXKmzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3sMRKC0NhIBid6VRv4Bxvy7dlttRG+0cHDLyz5hJ8atVVrf+38Mnb/cEs0hY9MAXcFudnUCg4RDpx/DLbNS+rHgvRHbz++T9PX+SZIWM7dT+SdydkmFKUwiyFuClfUxe18TkdjbiE6yM8wGyph2+jMJlK/5JgMUAwidroM10yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWJLei58; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3503606a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 22:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761543135; x=1762147935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvaWnuts0+GAzN1C4s4frRI39aWzTgLO69HpFB7yOYY=;
        b=VWJLei5800qFQKNLzx0eFu3KsQKOQHwaX1ugKh3/uhksJ0r++UBgaR0N9iE2XKuIyq
         RV0BmrF3eu46ABvcYO44fEdj6uDLsgaIzVbZRQebWGqfKHtV+s3A9KMCBHHdH2aYrfn3
         K4LuBDkGjLQg+9uBTTGZ/R5oxc4QErad+0DlviZ/6JqHuuOV0g7/4iuyCZTHvLLLwYdy
         DynleRefFHcLzZYWR75vbwK1OhalyoXw2jKYHJeSuhpKOvnl97h/cdtzKOonrlo1llbe
         XMQchco1w3XVRz3ejjjANQteGujmR+FFoINGwVIMWnzclcjilGfoFoz5rDVw9MOkJJV1
         APNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761543135; x=1762147935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvaWnuts0+GAzN1C4s4frRI39aWzTgLO69HpFB7yOYY=;
        b=aMEI5Xo+oyvaMPt0AkXxXwMWLswrCuo9J9gES2xdeVjag2oKNzvvEbJObQKB1bnXIp
         J/URNtYMLnQbdfMb37CVSoAjLWXLmOzplmFvZLbPIHJmwuHVWX1vVnUZCnwQWsWNj80v
         nyriesvuKq+AtRNhwTK5Jh9YQ5rRM/QsxXvSh5ppuv6wXwxD1zfrD84V99AxBt24eH2U
         aRc8tOv7sxL5/6Gv6h4Zzu61ME2DXyNkrYzSDCQkRfc9BmhGexoUcWlPKvFj2ONgs3DK
         FAaC+wqZb5HGnJSk//8CPHoGjJDSLPQcrA8suVNSmiLGgBHumnholYJ5Yj5z9zXY2088
         lrWg==
X-Forwarded-Encrypted: i=1; AJvYcCV/TndzMPeiJm8/XT7spKHVZzbcBrc/BPXhSSlvmWD14UwU7kUkYWH6ISE4Zo536Xazb+LwbfaICWYE/fKkur8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4TWGNVWp2l3ha9sAvd5xRP4sKJn8PLzp95lofW0tJX8kn61g
	1Y4PBUnGk6ZGh0xgcuZel7cQA0SwKaJymQdZ3P5vMoqwQrY4/SjlgUCt
X-Gm-Gg: ASbGncthzatgPRJZ5dpA0JACed6KHt4fncYlU1yUz1wKLieQWxlx6qiSePUP4Pc/byC
	627j6Rz6H/XGiIZYGgea2QZVLV5l7zbH9pAKKrUgjMecNImvNfXY9GKWJcqdjSUg7SB2NqwTrik
	nMXyR7fhCvq9o56xNN4obHAh7x0+1kPyEyly1MQ0Y8fbdiwx6Y5SUfG3PwRZa+pLrDt3aESXy93
	T2+RKOSNyTM9pqVvsP1AFystqs3JvaR9fxVif7pY6qea3f9Jcp7wbwjvZBCIRSufAYe8hJUD22T
	X6yyVN246mRLa6C16ZQiWzylAoQxlPBWLXIhIF1yUmEKxn+Hb349Vyosz+NFM+ZiqA2jcu+iO+J
	RT+/px+1kgVkPpAJF9gS8JuN0acq/cKNp90O/qqKftVLNxurGEMRUL8kkFSZP1cyaNjzWj8KUGl
	S771SRad69M6qBJWoN3BA=
X-Google-Smtp-Source: AGHT+IGFxkBGGf3onfO8Chr2ltK6y4LuXfk+2qofYqflJam8vbY4kH2nypV/mGTAj8xXg0sXgRUULQ==
X-Received: by 2002:a17:903:1746:b0:269:a4ed:13c9 with SMTP id d9443c01a7336-290caf85146mr423652875ad.30.1761543135506;
        Sun, 26 Oct 2025 22:32:15 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e41125sm67120155ad.94.2025.10.26.22.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 22:32:15 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH v2] selftest: net: fix variable sized type issue not at the end of a struct
Date: Mon, 27 Oct 2025 11:01:56 +0530
Message-ID: <20251027053156.34368-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some network selftests defined variable-sized types variable at the middle
of struct causing -Wgnu-variable-sized-type-not-at-end warning.

warning:
timestamping.c:285:18: warning: field 'cm' with variable sized type 
'struct cmsghdr' not at the end of a struct or class is a GNU 
extension [-Wgnu-variable-sized-type-not-at-end]
  285 |                 struct cmsghdr cm;
      |                                ^

ipsec.c:835:5: warning: field 'u' with variable sized type 'union 
(unnamed union at ipsec.c:831:3)' not at the end of a struct or class 
is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
  835 |                 } u;
      |                   ^

This patch move these field at the end of struct to fix these warnings.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
Changelog:
v2: https://lore.kernel.org/linux-kselftest/20251027050856.30270-1-ankitkhushwaha.linux@gmail.com/
- fixed typos in the commit msg.

---
 tools/testing/selftests/net/ipsec.c        | 2 +-
 tools/testing/selftests/net/timestamping.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 0ccf484b1d9d..36083c8f884f 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -828,12 +828,12 @@ static int xfrm_state_pack_algo(struct nlmsghdr *nh, size_t req_sz,
 		struct xfrm_desc *desc)
 {
 	struct {
+		char buf[XFRM_ALGO_KEY_BUF_SIZE];
 		union {
 			struct xfrm_algo	alg;
 			struct xfrm_algo_aead	aead;
 			struct xfrm_algo_auth	auth;
 		} u;
-		char buf[XFRM_ALGO_KEY_BUF_SIZE];
 	} alg = {};
 	size_t alen, elen, clen, aelen;
 	unsigned short type;
diff --git a/tools/testing/selftests/net/timestamping.c b/tools/testing/selftests/net/timestamping.c
index 044bc0e9ed81..ad2be2143698 100644
--- a/tools/testing/selftests/net/timestamping.c
+++ b/tools/testing/selftests/net/timestamping.c
@@ -282,8 +282,8 @@ static void recvpacket(int sock, int recvmsg_flags,
 	struct iovec entry;
 	struct sockaddr_in from_addr;
 	struct {
-		struct cmsghdr cm;
 		char control[512];
+		struct cmsghdr cm;
 	} control;
 	int res;
 
-- 
2.51.0


