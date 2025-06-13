Return-Path: <linux-kselftest+bounces-34894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A947AD8A7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7556E189D890
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1B2E1751;
	Fri, 13 Jun 2025 11:31:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77762DCBEA;
	Fri, 13 Jun 2025 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814317; cv=none; b=E9TMPEyYUHrG995tr2kG1brSIaYGdXdQEs3016LKlZYgcXvzH9GICjuyTrLWSbv6b6FglsyANC5WqnVDOEU5UaBjaRVzuYWeDwdZ6ghwiUV9PmQS6lz+8WpEih0wELdVBiueGk5XcTx5CZzqbXH4Ux7ykYeByZjxDZptHUR+sUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814317; c=relaxed/simple;
	bh=9MWyVnOGtCTb6f3l99b+ZT3EK3ZbCVffW6Ctmx3iUqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fVBXClOA4ag2s+4Gf/phS6PA9KbJFNAk80vmxWvuIRCMi5m268VxP3h9c+SDVtrwSgGVoFAf/eOHXH5nJ1rP7FmJggzipi9mZrYhudFX7NdvRIOInRH7FSlLZXbaNHEcdWU5VV9eTS+vC3bUHcsEEF3ZtpcBSysfI1+rlPxakXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so5529785a12.0;
        Fri, 13 Jun 2025 04:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814314; x=1750419114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBPQhHa8Mre4rsIn6yFSq4q69O1rqX0rwLacF4V2/d0=;
        b=kIqOFIwgcE70qZEDf7iK/9c3EuADM/ECftmxoqy4JPSwekhVOgZkvtflP5DRvSZB6A
         WwM6dxM9bCSqg66SFxK4oekOFxegC/0WHunTodSE2ajwnbz4Pz91WQUxc0n7tGbxeLFD
         cFTibFVkd0tramt3hvpQyleTvMDYdJRqTjOJSxvUjUVgMAR3L6zVg7XPSFqN69xNqIal
         iJxkTL5CDHqivc7D+bqVj6D3EK9yJjNGoyCqaqc0Nt3xwPq7Ia1gK0X1wEuGs18e8ZjG
         6eLhW4sF2ba6faE5pxdGbHuIXUbjswQfgdrqAzzMGCmeSaQLvd1+Po6w/oVm2090x0YQ
         SUxg==
X-Forwarded-Encrypted: i=1; AJvYcCXI+NHdegtroPVCQQSikXuLEdirukYb56ubCqfC/OBQHzkC4zBn6RfPNLRu31d3i1GASJXa7HOdlDhNlg4=@vger.kernel.org, AJvYcCXOz0vdD3A121N4LJALxDI5ytN+1kkFTfUuHnUfvDNXXLIat7QDT67NZI9nlKMdOENRgaXOUkpmvKiGBoCjd4g/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6eN2YuX/WxcOBaDR9JoDb/N2tBCvZyGV7pQTZjCKWdk7s+aga
	byYcHpTGhz+cjd7HyzZb3dN+RYK5wnxrEggvLkJfCzRAAaQPdEJIyEr9y3x9sQ==
X-Gm-Gg: ASbGncvx5N28ILzLAuCogcN165CsY/rPRyYY/w+UT51eSn7ME5eeNC5orE6ob5IxiLN
	yXuQ8P6UH5rO8UUcCulDYRHqW+qmsrJtodlMEB7yyUTOWhCDgYQVdvp1mByTKDzA7cRcpxn3PuK
	y1wMRv4XKxhLpDKnKgyr66M5hFj/0HPqiE2hltOag2EApdzKVuZU3znyuuKaWnr3ljR2aChKO5z
	tEIb7kwtmzp14mnNtZa4ZkC2DIGglyOHxdRx7vSQNJY05U7b/yc/+R0IOrocMiZrp475LFibMR2
	8hWzM1jgagPseIXXXy6C++16jSSPXyK8dIlxwLf8h230DVfAcRv84TNaHmr49uc=
X-Google-Smtp-Source: AGHT+IFEE/Hrw7FVowC4BHdc/CWs8v6HooTdlZb2smo221CwA5NVT3XEy2NXICMTTimCXWM1BnnnbA==
X-Received: by 2002:a17:907:3da5:b0:ade:44da:d2cf with SMTP id a640c23a62f3a-adf553f0e43mr35281766b.18.1749814313651;
        Fri, 13 Jun 2025 04:31:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fee81sm114903166b.91.2025.06.13.04.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:31:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 04:31:31 -0700
Subject: [PATCH net-next v3 2/8] netpoll: expose netpoll logging macros in
 public header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-rework-v3-2-0752bf2e6912@debian.org>
References: <20250613-rework-v3-0-0752bf2e6912@debian.org>
In-Reply-To: <20250613-rework-v3-0-0752bf2e6912@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=leitao@debian.org;
 h=from:subject:message-id; bh=9MWyVnOGtCTb6f3l99b+ZT3EK3ZbCVffW6Ctmx3iUqo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAwlGl7TGFljpJzNHQyL6AJPpfVsZSEniRO9r
 mlwWKIOTnKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwMJQAKCRA1o5Of/Hh3
 bUukD/wMyN/xgJ+vB7fKRsceosH+elhVsNcK3lEMpHWcj/vVdoblYXmrkCjN/vRrl6bNbG/ceCI
 50W9w4yky14XLtjdZbY+q+V7S0w25AwCw9SXoX3jV5awep//KkLUo5YBuUixD61N913VDbrreQ1
 DsMokZdga9G6i27Ok4RwnCGrLYecJghFCQpFM4YLuy8euq5ur0TuQt8xGItlKvbgvsy2N9D8x6Q
 KJEu7U+nNbQ53+QxQNn15dpjQ0IvuNOvq2xoTEDBgJb/HYO7NTDozchovQ9KErBD21vZtOyEXEn
 cUDwIDZYLRa7LQB4b2ECPZ4BL23UjjC43EJhmpE9Y70rxUi1NDHesvYQRTE+PptoFzYYfxucR+j
 KfJX9MQHpUpxE4OPF0SlqSwdtsnOpDyPisDbijMgBE/iCBmlTfgYIY4Kv0xlFq+m2GZO4b4CBNZ
 Yi5BkpV3wSrhNOJFyPiDIeKC9kyl7HZsCAs1CP2EYEcPN12rY35IVNcQ0yI4d1Z1+sEJDHsTv1p
 Kfdeu4/aRtO+FuBfgF9I/9O7ko9Udrp++x03c3AO7Iar+TlVkHuE3cjPyN7sXs6RqMVB3DQ/wQB
 AKnocX/2Lb2v6y7XH4ZyF3Ewnm2cuCqgP2kNWaMYTe9v+JRdLd++wSAuwrRhKB1Xsa2Sq1TVvu3
 FAvxrd0G4Elgdmg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move np_info(), np_err(), and np_notice() macros from internal
implementation to the public netpoll header file to make them
available for use by netpoll consumers.

These logging macros provide consistent formatting for netpoll-related
messages by automatically prefixing log output with the netpoll instance
name.

The goal is to use the exact same format that is being displayed today,
instead of creating something netconsole-specific.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 7 +++++++
 net/core/netpoll.c      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index a637e51152544..72086b8a3decd 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -42,6 +42,13 @@ struct netpoll {
 	struct work_struct refill_wq;
 };
 
+#define np_info(np, fmt, ...)				\
+	pr_info("%s: " fmt, np->name, ##__VA_ARGS__)
+#define np_err(np, fmt, ...)				\
+	pr_err("%s: " fmt, np->name, ##__VA_ARGS__)
+#define np_notice(np, fmt, ...)				\
+	pr_notice("%s: " fmt, np->name, ##__VA_ARGS__)
+
 struct netpoll_info {
 	refcount_t refcnt;
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a69c2773841a5..9e86026225a36 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -58,13 +58,6 @@ static void zap_completion_queue(void);
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 
-#define np_info(np, fmt, ...)				\
-	pr_info("%s: " fmt, np->name, ##__VA_ARGS__)
-#define np_err(np, fmt, ...)				\
-	pr_err("%s: " fmt, np->name, ##__VA_ARGS__)
-#define np_notice(np, fmt, ...)				\
-	pr_notice("%s: " fmt, np->name, ##__VA_ARGS__)
-
 static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev,
 				      struct netdev_queue *txq)

-- 
2.47.1


