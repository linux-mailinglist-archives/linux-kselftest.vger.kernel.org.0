Return-Path: <linux-kselftest+bounces-1012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B58019D8
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EB6B210BA
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54418567D;
	Sat,  2 Dec 2023 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJrOxjHm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843410F1;
	Fri,  1 Dec 2023 18:02:02 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35c18e55633so10691845ab.2;
        Fri, 01 Dec 2023 18:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482521; x=1702087321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXhSu6TXsCGagi8Oys92YNO86rSbK3g062wTle3A7hs=;
        b=aJrOxjHmvNwdYurTTXACXzZjDowQlesjyczM50xz0bERDbqeXtoG+Ij9xY49gU5owv
         v939Y/Gyz8Ba/1jzHegBhX0aNbxXT7+5CbjyuYZnzHPhYRiN8NP9eF1DSghSeyz4PWx2
         6Ai8RWhVbu6IFdycteNxMniLCG1uqCkzpDXJsLfcbB0f6Q+T0ryHX9SBtQdlc84n37I+
         60A0Xj6dOC40TQjmWxT5soy0qrN1IRn3cZZSnVHqMAs/ax1oOjRPc7I1E7wCz4Ao0Y4v
         JMBO2nIzSI1Jt6WTIURu1xyE3ZB/lvLpI5AngGyEmsphPgTOnQBvFR7sfSN4kLLinTFY
         h6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482521; x=1702087321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXhSu6TXsCGagi8Oys92YNO86rSbK3g062wTle3A7hs=;
        b=dpsObPmyxmzACHpipkL7WbFGJLLVSFS1WNtZ9gIKCi3anKeJFLGCv+gTBlOOV1MWe2
         wygX4/tLDfD2PtDzd6rYhhP4JIPDSb5kdzBakPrzinnA2LCYkcX+XRi4Ogl2hWVeJHsD
         p3RyK2Zo4DyJEyBZcUOPkBEwnZQBkcMY5aCBP9rTt8MLManE9ajvH5lK+9HLS/C/85DR
         bqfHSdRHg7doHBVn8X62Bnow/g8ko7cOpnAirbQjoiMX/JezDkIIu3MmO0UUTktJAMLg
         wSF6zzPCnBGci1TblXvBq9G80l1I+v9b3d7VBlWcWi6FlxqRTQXBo4Oh/Gt8tzcOGns2
         XAnA==
X-Gm-Message-State: AOJu0Yylw2pQYjG7dhPKde8WjCS6ry52Yi0xTYNXwNgnnxPN6ovMXFgm
	LZLJrLQ68G9fspBsmxD5gYzXSdJGfmQ1RFRp
X-Google-Smtp-Source: AGHT+IHbFwCZMELoc4Hc4qHf3MhsRt7sA/KaMiTeZb8K1pRfoU3z2hTX4Ogh4M2EtpRedQ+H09Yr/g==
X-Received: by 2002:a05:6e02:118f:b0:35d:59a2:2e2 with SMTP id y15-20020a056e02118f00b0035d59a202e2mr557393ili.130.1701482521446;
        Fri, 01 Dec 2023 18:02:01 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:02:00 -0800 (PST)
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
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 09/14] sleftests/net: convert icmp.sh to run it in unique namespace
Date: Sat,  2 Dec 2023 10:01:05 +0800
Message-ID: <20231202020110.362433-10-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202020110.362433-1-liuhangbin@gmail.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
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

Acked-by: David Ahern <dsahern@kernel.org>
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
2.43.0


