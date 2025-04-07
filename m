Return-Path: <linux-kselftest+bounces-30235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A93A7D88A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824D017585B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A822A4EE;
	Mon,  7 Apr 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hudHDkwz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD222687C
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015907; cv=none; b=WESZaXru7SiCmZLImuJn20wiTv0hGoMym4KArCKtNeTdFANUmdrnQukQQfPFV6Y/3EGGMbnYB6Ux/lgDQs32zv5kWkiQFqMQKrzDlpEqMl/CpaJP9RN2+53XP7/0oZnYbr0lXi6Tp5EwSstEHhAspR2S7O1sm3Q8K2TvkOAbkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015907; c=relaxed/simple;
	bh=JzUuLgQjqzsuDFsOmyFLNHi+3ZA2NXJNSaqGAaMZIJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2hPR71YWR/zEMrjwA0it/73IzCOFPeFdTHVRN6P5uZIXDfbtOFQIy4qyVZbssAiqsFtY1URCNvPkgazkUrw9rQ9EfDJFDEsY+Dgcwo/UYPnN3ghtbgylQMtKDGEF8msTI2nrUh8BFw8JwmNoZH65Po24jsZgcgoW9E3DIbG29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hudHDkwz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22548a28d0cso54000605ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744015904; x=1744620704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uyJxUSjwirFDuWmm3Ov2pKSAd0ErZhNjYPXSZRPwMg=;
        b=hudHDkwzHMFKEzT7mdhekPHwsOQAsrP6Ny/5DVlghsRkOSCgd+KdTm8xlEVMHpA35l
         W36haTVziOQCALDdix5wP1dDRAZLH++YGAB2PVpUpxBXCH9zj+GafFSCPYUWV+RtHa1R
         8x+z41ht6Yqil3o9RLDC42HNfiHlO667FLVQFcgF+TOxW6m8KC6/tBYhtuL77nGqAH1y
         z/1EZfdPcqsqQUDnKu8k/ZyI4ujT9lM/0B++iBy5lPlzEvV2flgPJrOZrsFO4bkl0D0T
         0bd6jxcSIinf85j5ctJyPX8eb3s4jZrH2m12ebvna/fsJP9o8Ceq4GzuHSMfT0YEVPLu
         YMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015904; x=1744620704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uyJxUSjwirFDuWmm3Ov2pKSAd0ErZhNjYPXSZRPwMg=;
        b=rLuEc2qljA0odxwW/Ek+OZIRsGkI4XuBSCzSsqHBmjtJRQ+Tyv69JBuY0P9eCbSLqW
         t3Fbend+AoPnZ5tAwg+J4kgYJhxqvcBlf7g2NxS6b+dfMGn9zwMXKrzv53c053jtH24P
         hESP06oeK22NVrrRaJn08itynsk1wyM+5zWT7pZK5mRsZmfj0l9ilthGP517ZbHwwT42
         h5aqtmcL8AumEuCba/MjGlqVKtmobkb1Eyt7cq6FKSMKGa8qtMxXZT9K6oz9R3ZWk+Kk
         1ZO4vM0O/T+oWPle8ou7nw9kJcS+JGXohTtEBGRKKNe/Iq0zDsOkR2xV1JUJBVty8uk3
         /Brw==
X-Forwarded-Encrypted: i=1; AJvYcCXIWL7LXRVqGxxqxMgXwaVfrlCAb/8Kmrr99IVzLPbk94hcyRAI74Hj+UzotwqlVRduXj1eMW/r7hvh875Lu/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOXc/RvkfVJ0NtOforS8xMkQLacJgMfZ2JM3vYoNApelUpZLT
	adCSemOODFwj7AisADkiGdMw0RzWRkJPe58s8KX/KYAOKdKSbGcKlEo7YAo6kDo=
X-Gm-Gg: ASbGncsN94URlp7hGQN6NbQ+Gk0FIrKiWoArTBBKe6lFQ67c75D9+UJo9t8w5BwSixQ
	TB0hLEd3TMcnI12Yb6dIJgYSM2NTBObVuaNnTDtJZLJigMsWn9eBf6lBFvSpUl7twr3niIvBsmf
	cQ7jsF3KEwvURsKkrBz3oecX3pzvVXNmHQVyE3PoN0k3lG9UQb6sThMpzZA/yYFOkOvObDKPqNW
	8wHZwL0C/Q54kTUtRU+Wi9rwKp0qj/xA1dcJys5Yj+C955Gp1Nzw1nI9SYAZLTq8gBM6+KW1Ruc
	OMmtb9zYiGf28CIm85Wa97S7rVZ5WTv3uIEEaV7wV20yNyC7CeUBWsIg3Wytaf4P54Q=
X-Google-Smtp-Source: AGHT+IGW7/HQcOSrWsFxMUBwQZEFvu6hcIo8WL0C16qqewIUDvPZ3V176EqIWn668YLPeuSi7WpN/A==
X-Received: by 2002:a17:902:f64d:b0:220:f87d:9d5b with SMTP id d9443c01a7336-22a8a867cfdmr200793525ad.24.1744015904387;
        Mon, 07 Apr 2025 01:51:44 -0700 (PDT)
Received: from always-zbook.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787727eesm75759455ad.224.2025.04.07.01.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:51:44 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	viktor.soderqvist@est.tech,
	zhenwei pi <pizhenwei@bytedance.com>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH] selftests: mptcp: add comment for getaddrinfo
Date: Mon,  7 Apr 2025 16:51:22 +0800
Message-ID: <20250407085122.1203489-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_connect.c is a startup tutorial of MPTCP programming, however
there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
getaddrinfo MPTCP support.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c83a8b47bbdf..6b9031273964 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -179,6 +179,18 @@ static void xgetnameinfo(const struct sockaddr *addr, socklen_t addrlen,
 	}
 }
 
+/* There is a lack of MPTCP support from glibc, these code leads error:
+ *	struct addrinfo hints = {
+ *		.ai_protocol = IPPROTO_MPTCP,
+ *		...
+ *	};
+ *	err = getaddrinfo(node, service, &hints, res);
+ *	...
+ * So using IPPROTO_TCP to resolve, and use TCP/MPTCP to create socket.
+ *
+ * glibc starts to support MPTCP since v2.42.
+ * Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
+ */
 static void xgetaddrinfo(const char *node, const char *service,
 			 const struct addrinfo *hints,
 			 struct addrinfo **res)
-- 
2.34.1


