Return-Path: <linux-kselftest+bounces-42586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70EBA9EE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CC03B8374
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ED430CB37;
	Mon, 29 Sep 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIEdNKCJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF030C614
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161795; cv=none; b=ils3n3nzECxJ4Xu4Hz1SOGVPD6NNrggc+bwBcjAQ6ZeR2SIjsmX+CP2Z1ZnavqCQd6ch8mNCAqBi7N8zUvAdRaz8KC+NvZCkLGwQNINLSb4I0UZ8O2ZKNzunjjuPnarrsez/ZCuTedDWt2vzuqi0fhIMmeeZQMWr+Ne9o+3U2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161795; c=relaxed/simple;
	bh=1jkw+7EvuIa/Han8qcxFLmMTXaJYMq7ZJC5YxwM3xL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvjU8ZKBCmj5wJG7uxMKy+aCgeABsh8WfmAAlNX9jp8Dl3Xc61g+nMn//BETugg+JUElFbsDb1OnYJCtys6KdTZF2AhMgW9Hx5RDmztOFAY2HAHMcNBrfoIhEkKf4Chw8To/+Dtxz8YIwR+3tFi6wLcyZDZcRjCZaf2rYwDjD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIEdNKCJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78104c8cbb4so4975048b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759161793; x=1759766593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KefHEpASHlImKTlDtTejqsu/vtIp51mWF2HZGf1Fkyo=;
        b=WIEdNKCJukuVi1h9DOdGQ8/Muw/4sk1r+sFqcwhZkzSs/T7nS0Z5rIDRn0aJ6QR4nD
         L/ujvWnbM0exKAO889chaTUy8tlRN6IsN3nWEnANfXUV0O+wt6pJH7+L7wjJKiVQxVEV
         etiSJTLGdU3bIKYBrO5CitRoAZ+zhm9sET7i9OoMMxIkzQ31xC+s3zWMH3SZgFr6yhnn
         RkNGWUtxM1lrAPY8Rc4pCk6z/GF8x4C2rrkOyin9DU+vHh+X0hNrVbpVkV2oNWC4WeYS
         7cxdtiNjT0m1NveXp8MgDzScEXYM3IQEuAjTCdAtwFxaQmZlEWn8XD+AV4r+J20HiGYg
         NOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161793; x=1759766593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KefHEpASHlImKTlDtTejqsu/vtIp51mWF2HZGf1Fkyo=;
        b=ZutcixPJNOA8NVvvJdgJ2NB4sttSNZan6L4+Nv2IAwtR17txmbj2CU4v0BrrHDqtAR
         iDnzri+VimyvkgiSB26WM61L3XT7qtxJL2EWB4doIy7JgJKaSvQCVgImezwmB/dd7oos
         mPHv4/Jg5ciLZ14Ixodti55a2yjpuDShGtid2kUXleoolobJYglQWPqFdspyc6iyoEPS
         rXM1oK4qZB8NZmX1TWWArHPqjm1T8EDb1Az1kqzUjEz07tpLZQNTYQ3Q2QvEQsPF2nBd
         dlbtFBIQluUERnMgfC18q6hpBq2l2T6q5TOr8IqaCJtUpYvfRuYitO/aJRtlDzNOEdY9
         0x2g==
X-Forwarded-Encrypted: i=1; AJvYcCVnbOsBQD+cQyrFTwJM9AXIPOuRQJjXW3QPYESIM5qoiQS3DI3959mqw2t1QakkiSiIQxmC8i/3LO+nCfrMVo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2IQh40l/Nok3bbdEog3yAX9NADcmHstva3slpDjqpCPaBVxc
	B3jQ5S5GL+0TgyBWwvaTmGMhCc16nwKhJFCR4+13XbAt/kVWVEeISfWd
X-Gm-Gg: ASbGncsFH3Pnbx9dIAaEU+odnUn6MGrd7JSqNMBSmySdwXvVk2VvfArBxNzNOMzUCmC
	DEZnfUhdZydy/haofbypK46sjcSv+Y33vKTqpnRfEtAOIhzZizZ1UX3njZ6BLTC0bJWr/qekVO7
	jbvca6DmL5UVLwhoe34RtGZYRoqTMirhIDiTyXJlbNxSCnOO9HX8rX42FBsSzOibwXdadY2sV4j
	3r5tVo7xEcXYyACrVVmvdD6ew+Kv4daoVP9FtZf0gukxttpowcY9ZeKhA2o1ULpCp3Kn1YtGhLF
	6+QzI8ZFEstf1wO+V7Kte8Xg3xCMPN5sM52cScDcrtx929+SSQLfN+75uvI/1uI6BdNkqIOyI2F
	0d2W5QnW21Tonn0VBQWUBkbzX+LwO
X-Google-Smtp-Source: AGHT+IFLs3m9GZxE68Q18gbvy+0afYHaST+CDXcgc2TlSHRuYVzEECyokcNZHk3sUQVFmBJDY053zw==
X-Received: by 2002:a05:6a20:9150:b0:248:4d59:93d5 with SMTP id adf61e73a8af0-2e7d72637famr22343288637.55.1759161792642;
        Mon, 29 Sep 2025 09:03:12 -0700 (PDT)
Received: from y740.local ([2401:4900:1f30:25ff:36cb:10ee:ba03:839f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a0ca2sm11504525a12.42.2025.09.29.09.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:03:12 -0700 (PDT)
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
Subject: [PATCH v2] net: Fix uninit character pointer and return values
Date: Mon, 29 Sep 2025 21:32:31 +0530
Message-ID: <20250929160230.36941-2-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix uninitialized character pointer, and functions that return
undefined values. These issues were caught by running clang using LLVM=1
option; and are as follows:
--
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
--
so_txtime.c:210:3: warning: variable 'reason' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
  210 |                 default:
      |                 ^~~~~~~
so_txtime.c:219:27: note: uninitialized use occurs here
  219 |                         data[ret - 1], tstamp, reason);
      |                                                ^~~~~~
so_txtime.c:177:21: note: initialize the variable 'reason' to silence this warning
  177 |                 const char *reason;
      |                                   ^
      |
--
Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
ovpn module")
Fixes: ca8826095e4d4 ("selftests/net: report etf errors correctly")

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

v2:
	- Use subsystem name "net".
	- Add fixes tags.
	- Remove txtimestamp fix as default case calls error.
	- Assign constant error string instead of NULL.
--

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
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 8457b7ccbc09..5bf3c483069b 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -174,7 +174,7 @@ static int do_recv_errqueue_timeout(int fdt)
 	msg.msg_controllen = sizeof(control);
 
 	while (1) {
-		const char *reason;
+		const char *reason = "unknown errno";
 
 		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
 		if (ret == -1 && errno == EAGAIN)
-- 
2.47.3


