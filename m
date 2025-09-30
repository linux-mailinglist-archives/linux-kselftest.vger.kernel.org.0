Return-Path: <linux-kselftest+bounces-42623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF7DBAC690
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BD214E25AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6D62F6171;
	Tue, 30 Sep 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHRRs3bb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C892F3C34
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226871; cv=none; b=q1X+61jdvG0hIKGRonLhaltzheacK4JE5xnDZbynfYgjaSGC6JU6/g2Tgb6zc931IHDDHurEK6YwqeudUc8FnIQUkwHu3BPU1aVGH78T27f9UWBk0LN7w1X87AfTD1ntIZS+jlJ7yQwwv3cyJsVYjev6iVg7G2R/uRdSOZWE+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226871; c=relaxed/simple;
	bh=FKY8z1CEGgUY6q+4pHNC/Om4xVBeYJauYh54XqnoY6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kv3MF8vc8rsErJjZgzcdXCwBl6pnFUeFpI+IKVFF0/lsgwaxmXIhnwyFqBvKoqI9t8yBphHA0GakPoYlh5JD/i/iAYbfYLk5eqTkdM6SsUc7XADbHU7q7t94jxOePcapYEhijhtE23WOEBOJ5LMPiPfn2GWsQqs/UfjO4onVvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHRRs3bb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-271d1305ad7so74906075ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759226870; x=1759831670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HgwqWLqv5BJjpLMqtyvMalLTTdm/aF2XY54W3HTWoA=;
        b=JHRRs3bbCfqBryaK1C7aE8tJvio5eG4vzQqVNUN2GsQ+5lMXTsxDuNhfqwLyMD0FTH
         dug+Vi+EipGWxS5WU1Rjainb1etD7zd+i5F2xBQae5KyCyc8M8JvEhZz7jW+UEhHiwFZ
         M52g7ukWZqSO1GiUuPQXWwCCaQwFvrMocBBTClHYA1kqdBsTndXIMMYK+xOhkJ8pjbwx
         iRG5es4Rqvam4zMCcsjbaxZ4x5MAoiq2dYS+vuUR/8vk1R3QGstP+XB/FDF29/Y0g+pp
         wUgARCzejgYXBefAiINq3UOA2hllyE8nQihSJurhAft0xdBYFB4XQ/siLTVyFVdiNHfb
         lpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759226870; x=1759831670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HgwqWLqv5BJjpLMqtyvMalLTTdm/aF2XY54W3HTWoA=;
        b=lFFaIEIXKKoMVr8OBLXqVmxdHo32D6OwaMc8Ri51O+SwAHarzjyI1SCFasPGbscPRF
         u6LlwoYiN7318awY3lduxlZBMNurNBov4V0sAr8U5eWDz8bac9/09F07KCbsuWouMwLk
         pwgR09csPfwgoGIp3kcILwPg4sqPg1muVZNhbafJUbyw5xdlO+E2R3xa00nDAFddsT37
         fAZHD9316dFSYLD2Qr8uIwhPR8re+51nWEnyS2xPrOSwHTaIFWB6u8MMIWO7jhubVjW7
         nhcvuuG5KjPa1cIbp8WFU3TkPifVnx0Sx5Jnqd86KFXdAJ7nkOM/iCg6FGoVc4bKIy0T
         zXXA==
X-Forwarded-Encrypted: i=1; AJvYcCVEkk8Y8E2CfV+b1AseY7PIJB8RezWgIyol9r/6snLucfhUaaukB0DdPbIU212cYzfa7v19O11r43ZvMDDb6jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZvaHK5zRjN8HlSaZqqO6Mubqx6A11an8CgxNtH3REAXFAzGr
	Ghtnpyffe28xMp0lI0zNJZ2daA48i8RaChBpDQyMg10BW2i+27DmJKh8
X-Gm-Gg: ASbGncuKIua/d7HsKjhbwufCjG3eEhh1XMqyjiMasZo8JcX/0hxQvW1KDxiPL31lOi9
	cyrjEr6mqLF2MdPvGa2TU79RGkR+brMPY+7ak6ZoMHxXUfF+9Y6XZ2JPv38po2VPEINuMTE8hU8
	MfSxS3u+eBJsjIvBmW3iTMOOHr7PkG2U92jIxNA8w7in8s2b48kin+eiwQg+6GZByxNQn7slVzh
	ka9NlLbqZMNqC+//Zhg31Fk68n00OGlH+BxLaY9w8Ykr7cLzEOw1tDfKTAUSPvB4+QslEmQXLhg
	S+cS0bmqqhRfwyUeBxFChiLv31ivYkmFHLZr4atBwkLsROCdmhvs1b66wq+/fAsZ4ft9ncJBc//
	VHzdyBz9ZLginbkCnbPhF7768TljyV7+EX6Jh2ihoRurC4FO9FFbJavPmiKLv1QM=
X-Google-Smtp-Source: AGHT+IEUeUIAzZJUtqx0W1k5wrTJY310MNYv8ZMr9OBtEg3B71EpiDEoNAOJyPoAlF3t85pkcXk0Ig==
X-Received: by 2002:a17:903:19cf:b0:269:7427:fe37 with SMTP id d9443c01a7336-27ed4a30e5cmr216987585ad.29.1759226869598;
        Tue, 30 Sep 2025 03:07:49 -0700 (PDT)
Received: from y740.local ([2401:4900:1f31:e91f:2d6d:e8a8:f2d7:94ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6733a63sm155381685ad.64.2025.09.30.03.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:07:49 -0700 (PDT)
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
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH net v4] selftest:net: Fix uninit return values
Date: Tue, 30 Sep 2025 15:36:57 +0530
Message-ID: <20250930100656.80420-2-sidharthseela@gmail.com>
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
index 9201f2905f2c..20d00378f34a 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1581,7 +1581,7 @@ static int ovpn_listen_mcast(void)
 {
 	struct nl_sock *sock;
 	struct nl_cb *cb;
-	int mcid, ret;
+	int mcid, ret = -1;
 
 	sock = nl_socket_alloc();
 	if (!sock) {
@@ -1936,7 +1936,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 {
 	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
 	char raddr[128], rport[10];
-	int n, ret;
+	int n, ret = -1;
 	FILE *fp;
 
 	switch (ovpn->cmd) {
-- 
2.47.3


