Return-Path: <linux-kselftest+bounces-42654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A917BB05B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 14:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5A73C0991
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Oct 2025 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E516F198A11;
	Wed,  1 Oct 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya11i5CU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194318DB1F
	for <linux-kselftest@vger.kernel.org>; Wed,  1 Oct 2025 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321899; cv=none; b=iP+9r6zxZc2JfGGT0bhRJRPdeWKCN5W6TH2Yq15w3o4yn2ayz21hgFZQp5U35aVmjYcwdUmSJdjOpF/x8EXCZ3SI1/6HlRlWQegSNTTZFnvQdnLLMlY7/kto7jA5n0n5D9V1hFW5RMQIY7lPaAFTZT9fwsrEcDk0tzSV7oNU9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321899; c=relaxed/simple;
	bh=LT6OsX0lf7O/SnduNG3xCio3YGyWrV3JydVjCVzZwTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpNNLXSk3WfFRwDR4Ont8VhDLn/p1IaPq28De8FOflE/VvzKlKIW1la/fIrmg9s0MgXjmhKkHUe8w9BFx/LbvQC54SiQE1HeWvcInndi92PlD1/3goo0qkGdJ0uPo5Dy7rv/RZBv2yaGWQCSNX0juAlcbis9u4iADKh+9Y4n8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya11i5CU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so5541219a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Oct 2025 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759321898; x=1759926698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tFVvlaf3lil4r9hOm59jQkgdcxMqRbEMlT/+2CO02kA=;
        b=Ya11i5CUj4v9iyiAaqwuXToHvsmK8zIeWrKRc3j+SEr8olnmP7231JjS28oPCbmKvJ
         Yvgzzgu7Zqm2uOySk9L27Qc1Ji+rRoEfZ4JAP9c3OkZSNfUDsJkWMKhfkn9z9CmKqTgZ
         La9x2kivAahV6YGwWiuoSyZLRUgWCGT1o/1lPThMO8XDdtIs0IYXh1CaoS10x1rXz8Gh
         k5QNee8CciQs2eSSs8CbnQfYXPcDDNk69vconG9kSwfP6QD3ijVhas0UvNpX21O8bk7T
         aoL1KwYGrzbyFWuUgNKBu4CVPNdcQ8//jydcj1RuGMXwO3QwDn0x4X9efpwc+RFX+69X
         dDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759321898; x=1759926698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFVvlaf3lil4r9hOm59jQkgdcxMqRbEMlT/+2CO02kA=;
        b=DdXUaa8aqNbxQEDZsTxx32JeTDONNaWPZrBQoLDXX+aBC9wGj0DT3mjnIfe9jofbj/
         FFFSiYNZgv8jWfsx9eYuxgtvVA4hjBE5FHCY9SIhoKIgyw+XDXJgF4FMLZVVep9FzTBa
         Rzqnydf+r2Plia97uS7YlkibcjVP36/jdUoaibZbUpwT/hjpqiChOlDdFfhIbH6hR73U
         WggEYsWa+I36fEW19CEhYzxVp7YmSCMBG73Cli5EEFB/6o9OG2DlazjHa8uip2a/eMbd
         PD02Hqq2KmQd5NNDJi3VGDcol+8rfUCdh4BI19MXimf3/wdMhE1vaZ8t65b1SseDtpUi
         NyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1M2X1Jj1uAY+VIa0CwCg99czXSFisDnotDQwHbNhWwZ/2MuB7ncpb/506FO1zfKzBWIaml2Qs6L77uet4CLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjy+pa9hZoV5oONwZLYjaKvZ0v5tbeYU6o/JXowaxHi3/coo5
	1f1x4HFITyxknj8k5Mkkp85b3SSfgP5gHhrDNx6WJFT0ZejF1pxKxDtP
X-Gm-Gg: ASbGncsCsjZW3B0kD4khsy66RAliMRXjMVJCHzFJ/QTZzMXKluaOHezsXRLegbf4xyb
	TXyBgDfl0xyx1/aFPBIU3w7rAAi2g4P45HnSK38l9B8luG/RnDhwbA+33in+wBK3gDxjlx6wYQu
	/oLUVJZNDY4W4DKAT4Su1JlaUrZgJTT1/S4AyNKZtC6v2z82deeXTwF1z1mwEjQLp+p1NS0ltQa
	rSZd2N5oqOhRWZ55dtT2Lx/8Xa6kjbGE+Sj+j+iGj3aKSEl/q1VUzMeIeAx0l+Vx+l7MLrhd7xp
	KlI2jgE3xNs2Q8Hixps9lLjB7eCFpnIQsmR/YdFyWP4aR+CI0cDrncyN/u7lcndS/MXiWtS2h03
	aUHrsIdSN4CHznrKa1hJJH2C6HvEEz+nEMETuDkI7frg6iHjePZhD
X-Google-Smtp-Source: AGHT+IHSyE7SmrpnfhhqOTD87lPajcRX58kiO1gqfrmzhvB+s9NGFmNKGY55vASwBDmRxXxeRC63WA==
X-Received: by 2002:a17:90b:4d82:b0:329:7285:6941 with SMTP id 98e67ed59e1d1-339a6f36bc3mr3479360a91.19.1759321897400;
        Wed, 01 Oct 2025 05:31:37 -0700 (PDT)
Received: from y740.local ([2401:4900:1f31:e91f:2d6d:e8a8:f2d7:94ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9f0bcsm2277865a91.1.2025.10.01.05.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:31:36 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: antonio@openvpn.net,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: david.hunter.linux@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH net v6] selftest:net:ovpn: Fix uninit return values
Date: Wed,  1 Oct 2025 18:01:08 +0530
Message-ID: <20251001123107.96244-2-sidharthseela@gmail.com>
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
Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---
v6:
	- Remove stray line near Fixes tag.
	- Include ovpn prefix in commit message.

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


