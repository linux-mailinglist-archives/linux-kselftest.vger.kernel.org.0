Return-Path: <linux-kselftest+bounces-21849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 902B69C5262
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 10:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478701F228DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 09:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6420D4E2;
	Tue, 12 Nov 2024 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdAvJzqb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025E1E4AD;
	Tue, 12 Nov 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404916; cv=none; b=G/mBsQghSHqCfmhyiMFNSgsXmjpj3rCgYfbhGcbsWBSoGK1q7yxeEoQO9/Mp0PkbF3pUIhl7+IDMLcfkvQAD+PncE2XAVWHiXHNHJ5Ja1ScUYujRHo/atRoCQg31gKZMDeidnyMdv3T3SvXFbfGXdtDouCSaqLzq9OU5qZ02+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404916; c=relaxed/simple;
	bh=WaWjjsYz9BmIZpqgw1XZyjMywbYmeHHpgSiipOgAzpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRStXl4dDGX15akSD6vuEcovqlxXK4g/W/YYYMPE9XkgiaYKXCEuByP1ueuy2+GxNJtnCby7IOAdKnv7XFFLw+30ptRkydlwWO/IvBtn6kyD7nK0FBjQqra2IMm8XsoHmH+d0nr4lPzD2aul8L0hXRE2BxjW/0BWqA9wbKyF+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdAvJzqb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720c2db824eso5883002b3a.0;
        Tue, 12 Nov 2024 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731404914; x=1732009714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnhCA+KfybkzGlQJdiXLfcOgUmb8rP+rbO7sRqwJqe8=;
        b=SdAvJzqb6xvL416fimWzUJ5fm/Z2acSsktxOYUgo9CFEklMB474bnlhvYIlDKSl2nh
         6bdruJXyOTiRbdOZedRFADoTpxmuYeb03GPzEDOGMsYMPH06gxM8BUus1kyXTC8BzpRw
         PULbkA7cEEjVc/qfIFyXYLH90DYah7Z6BZ+CUnkkuZ/OGQPXgjr2AomzNsWpIK91jGJZ
         rBpzPCrbA8IVPW7jlTtOX95IwJzSfAZNKnV/ebqHwxk6Y1CUfiqUMSxGf/K0hTGb8wxU
         CC9eL7RS5+oW/qOOx16CapLa5QAyhiy3kNb4hDJ6DM4e7WWtWCaJY5N1CFmR3rXRgNiL
         Hlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404914; x=1732009714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnhCA+KfybkzGlQJdiXLfcOgUmb8rP+rbO7sRqwJqe8=;
        b=cCwdWIkxnckNStIersuL2wsvXLmyLp7XTylRh21inOrTgFfC8/wNFxXP3MuRiIs4EG
         h0wrZsgEH1AvNVpb7i0CR25U1zwms4N+SsQtSOmBXEUoW5k44IVKnxBvqEiqV5mdzLT5
         bZ1CG8VZdyjtMpI2HvzqY0ZSArkJiB4uXbKhl0Y5gTUVcn77qAH6Bdmbkr6xprdvisS3
         1lSiHxXsL6KEkHvx7CXXiROCZKXGH/DlprII4uVNmq7HrxS/9REDBEJQWSIVms5hkPaA
         HfdkzlqrGy8pprluDoN4jqCL1ybnuTeaA2oeCSvp3tUOjoZ2CMc2EMCdfmrxJ86YlXCe
         DQdA==
X-Forwarded-Encrypted: i=1; AJvYcCXQhWqKVhwxbpBNG4k+4urz05QAyiziXpdatAyzQGtoo5rlqdZTGSSJdjcN/xqbNPESViJiDnEaiVoViTM=@vger.kernel.org, AJvYcCXmcx9GHiMj6QINxdkthUyTEJPdypF9CP+Dpj34QQ8WuEGYg2vO8f7w4QUYNtZK0wALB9Q8/JG942oteWEgeUFW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0QpJHjJKClkA5kff83U5XHxjQXzFp0XSGaD7P4aljb0hBoIi
	4I2QAxfYtn0LFQS92AKP4pyAaUqiIjU+v2qreos+HqpaQFj1dp2usg8PuX+I1Ls=
X-Google-Smtp-Source: AGHT+IHloP3SwFnWfmVSzGduUyRMZMHGhisk1H1OAr/Wbq1gp2qDOnB3PDtglid5zBEShhGqBNypUg==
X-Received: by 2002:a05:6a00:2e0d:b0:717:86e9:cc34 with SMTP id d2e1a72fcca58-7241328e927mr20123951b3a.8.1731404914213;
        Tue, 12 Nov 2024 01:48:34 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa8e2sm10712102b3a.92.2024.11.12.01.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:48:33 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net] selftests: wireguard: load nf_conntrack if it's not present
Date: Tue, 12 Nov 2024 09:48:27 +0000
Message-ID: <20241112094828.391002-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distros may not load nf_conntrack by default, which will cause
subsequent nf_conntrack settings to fail. Let's load this module if it's
not loaded by default.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: load the mode directly in case nf_conntrack is build in (Simon Horman)
---
 tools/testing/selftests/wireguard/netns.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index 405ff262ca93..fa4dd7eb5918 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -66,6 +66,7 @@ cleanup() {
 orig_message_cost="$(< /proc/sys/net/core/message_cost)"
 trap cleanup EXIT
 printf 0 > /proc/sys/net/core/message_cost
+modprobe nf_conntrack
 
 ip netns del $netns0 2>/dev/null || true
 ip netns del $netns1 2>/dev/null || true
-- 
2.39.5 (Apple Git-154)


