Return-Path: <linux-kselftest+bounces-42630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B540ABACC0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 14:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3EA7A816F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 11:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069CD26A0E7;
	Tue, 30 Sep 2025 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He/33/UP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37B2561AA
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233641; cv=none; b=EN4N3h//C8Cp8GzbSmoDyoKf0lq20IHfpz8vS7fL+cJaPwJhHeLc2oxMs9Ea4XrbkYulbb2XssrUFM4IrfU+xQNnQAIHF3wfJ38W+dL6tGUCiH6RuvTivNfj9i5+85uGgwgUYEEqGj9wODyMHjafBCtxchnmrSjuB5C+jL4k/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233641; c=relaxed/simple;
	bh=FabH5mN4zhLuKZr9se2KR/RjA3IMi9d2QCJpAU9/dIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IR3tWoI4MQxcZJuCK1WXHvUmJHPqt7My/r1Cloa0oNjQxeD0PkLL+IADXxksf0GUc1zNd6qP6T9gXrAefVZ+miAjzo+yStdfkgOcJ/QGwfG2uFa7sS5oaZOfkhBQY4MNIJeKJDuZlnVQ8hiBz7XKrJ/L6s/uzGPtNmOOW/BJiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He/33/UP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33082aed31dso6371647a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759233640; x=1759838440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SgDDrNZnsegWRc2V1qujx9PuTP9rgoyvrSx11R8wMak=;
        b=He/33/UPPkJFyCtjMmul8cs6OIRe8pjT7+NpUt/PV8ED45vLHXV6g4Rq4js9TuOVXc
         jH13D/v7Cql6EmLaRSP/BaIBBDqYhdFHEFBm6EBxyXdVk8XsdP5WiesgRteEU5aZSWwh
         VT5a1GH15m4P5ME1xiKP+1ajjTu4Xyt0Tz18XmQ5dvzipmsONPkhIXLHubuN5mAEJL1c
         83sYv+UiVAFsjtjogwvcTNpRls6erdVI9QegasV+9urFdaM2arOpC7y/ZeuZwP1pVYEb
         11L49g5EtZqPgt6s/Q4MchKFGzp9TmL8tzA/48XmwTWWp5vzfk6diDLr9OZgCN99tY5h
         burw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759233640; x=1759838440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgDDrNZnsegWRc2V1qujx9PuTP9rgoyvrSx11R8wMak=;
        b=iHJx8Kw9UsNbhBJTAzx196eX1nNAYS9yV7PXVmx96TppjVhJQfV+eeoM2QlRkXLchi
         7D3ZjqaRbxhYZt9+DvHNzx60mb2J3jkhsInNFBog8qi6n4dYaF+fE3a96tw67eiQsGBI
         bPvdWV78ij1ej0OeuDImR6yJrjQgMCBo9dCT/ZvBkgvaXySJZlnJhW30DXlJmwYRz0yo
         vYnJstM0wkJuPdBCt2kU/ec3dzk5sVJPchaMu9otTQahRSi1xGsnqw5W83ZxAruAvHqy
         WKlGX+mcU3bqRoFggVN7bgv8EmMbf8uJ9+sShHx8UrcdMpKZc6iPqRbwTL/iHQ8egHPt
         55JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkZFuETKmHIOVuoPy8oFNO85ODJQbalJVk3SG79o0rQEpasLtwjRBTFD9PcH/yqBRlTYwuU7wgsqrv2xtExNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4qRwgrk+FFy7XB1NMKo7UFunIy1ZqhBxnNOHD99HyS9boIM80
	A4iVDkpphklkIGOWWHqP6lGM12byh0gBOeQcx7xd2CkjE9BKkd9Xp7EY
X-Gm-Gg: ASbGncvydjolzAJcWfQaR+vKOafcmMtT4hZq9CHNp42Pp4wmqK8Iz9oszrhx+AofDzf
	/USiy3SrHkutqr2Lm3A0YvpGPzxQTYkPEXkqTJrcZD1sHyDV36PXs3kud0SL/vE1DSLVws1zzbZ
	G0SO9GaPcURHS0hlyflRPT30zOOoj7vNh5OwLqTLXZh1+ibJU/Q/GipxKrenhNammY/lhKt/tmu
	cNM7+rb50jAaQJzJfY79HH8muuT4VBxGWsb6CfaCtYCbyitFyklKQgXPhU76a1AhysNkoZBpces
	/7lTJy8dDdiGq9SqSaf5M+pYIAPREVqJJYimGB42ay5OL1gsekulpv/3n1EdKubNRgKHcX2n811
	/fSgxp8vW+knlO4pZz95IBF0S//TiiN59n7LMENaHtzBCkYL/ywGk6GoePud3ROc=
X-Google-Smtp-Source: AGHT+IF5xytoamoNNnFsGzqI3I/1zL8QxwW1vpNTaidF0bgHfcirdj8j2+a5eRIDt+HWn3cuLf8DSQ==
X-Received: by 2002:a17:90b:4a4c:b0:32e:8c14:5d09 with SMTP id 98e67ed59e1d1-3342a23718dmr20535324a91.7.1759233639182;
        Tue, 30 Sep 2025 05:00:39 -0700 (PDT)
Received: from y740.local ([2401:4900:1f31:e91f:2d6d:e8a8:f2d7:94ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399cd190e9sm823160a91.2.2025.09.30.05.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:00:38 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: antonio@openvpn.net,
	sd@queasysnail.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	willemdebruijn.kernel@gmail.com,
	kernelxing@tencent.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	david.hunter.linux@gmail.com,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH net v5] selftest:net: Fix uninit return values
Date: Tue, 30 Sep 2025 17:30:28 +0530
Message-ID: <20250930120028.390405-1-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix functions that return undefined values. These issues were caught by
running clang using LLVM=1 option.

Clang warnings are as follows:
ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 1587 |         if (!sock) {
      |             ^~~~~
ovpn-cli.c:1635:9: note: uninitialized use occurs here
 1635 |         return ret;
      |                ^~~
ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
 1587 |         if (!sock) {
      |         ^~~~~~~~~~~~
 1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1589 |                 goto err_free;
      |                 ~~~~~~~~~~~~~~
 1590 |         }
      |         ~
ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
 1584 |         int mcid, ret;
      |                      ^
      |                       = 0
ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
 2107 |         case CMD_INVALID:
      |              ^~~~~~~~~~~
ovpn-cli.c:2111:9: note: uninitialized use occurs here
 2111 |         return ret;
      |                ^~~
ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
 1939 |         int n, ret;
      |                   ^
      |

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
ovpn module")
Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---

v5:
	- Assign -ENOMEM to ret inside if block.
	- Assign -EINVAL to ret inside case block.
v4:
	- Move changelog below sign-off.
	- Remove double-hyphens in commit description.
v3:
	- Use prefix net.
	- Remove so_txtime fix as default case calls error().
	- Changelog before sign-off.
	- Three dashes after sign-off
v2:
	- Use subsystem name "net".
	- Add fixes tags.
	- Remove txtimestamp fix as default case calls error.
	- Assign constant error string instead of NULL.

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 9201f2905f2c..8d0f2f61923c 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1586,6 +1586,7 @@ static int ovpn_listen_mcast(void)
 	sock = nl_socket_alloc();
 	if (!sock) {
 		fprintf(stderr, "cannot allocate netlink socket\n");
+		ret = -ENOMEM;
 		goto err_free;
 	}
 
@@ -2105,6 +2106,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 		ret = ovpn_listen_mcast();
 		break;
 	case CMD_INVALID:
+		ret = -EINVAL;
 		break;
 	}
 
-- 
2.47.3


