Return-Path: <linux-kselftest+bounces-37132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DBB02142
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1016B4648A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D52EF646;
	Fri, 11 Jul 2025 16:05:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47A2EF64E;
	Fri, 11 Jul 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249927; cv=none; b=LmjJMEor6uOl+z4Xg4i1epeVBo+Dlv4JmUh7MTXVw2murauQ8YpWnx2TttVYw1W3h5RYA6asVN1o3kuv2/XZp2hcRk8dX9Q6M/kzPGLmxdsQuchlvjWWSW9vUsybg3tRLLxMHqy89aStyeNhBlJmakjPjxH+3Vdoe/d99LLX5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249927; c=relaxed/simple;
	bh=5e7Gu2hSYoF78NHOOQ4u3fblm9IpAmXxrCi48b0pb34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ox8/L+Evu/CtsmrpHiXPB3/RITdjx9Hct5M7xLb9BE/mtlv4Yiy+ZgrGhXpAi0BnGQhE42oNdJ8ary6OLw0OkXyoQEYr3WiAELjhTF64yaCrbx4Formrap0NpXlI7sSRoGEKT7lp0y/hipFTPj+GcXNqPjr8DSfPG21yBJLAvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso179003966b.0;
        Fri, 11 Jul 2025 09:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249924; x=1752854724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gaqp+BTPfvuWnqLQlzPe4IbE5DQFSHBJTK+OlPf0tvE=;
        b=gowgm9d3KoOpmtVmAJavHVQDQcM90LQSGW9JXrp5bnOlec+rhGJGTshaLI8cEN4FHM
         tMRS9AnbEwGQpDuZ0cmaxXLcCESoATCeTcWpp7h4nPlR+qMVuE1L0o2RYzqSHhUOkWm7
         MoBQuFr2K5pnZj61Ss9fR0HacK/6LX7yKyi7bzrieaXR+sEC46ZVOaL3ml5MSH+p9OGF
         2p+vv8kF0xxLhRpS4hRBws0GJgNXEBBf1nhWfdrm63fMoIxq3eR7E+CYVn+j6y1J9oPW
         TB1hoLNOml2y7jIub8hbBo3p+/Vfte4DsHGXO/6xtXB1Jv6qwpSMdIYLndGlQX6bqSZi
         CNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZrmCNzqQpFI9auBi6TpN9Ypkn/QmVWqyRaPMiLHVzMvdUahjcb+jROFK49aGifkieIIQc6lgQs2ZsbZY2Iyj@vger.kernel.org, AJvYcCVJ9Caey5CpKHbzO16o0FWlCjSNdKBFtgbSUNQX0I5xT0QW7Zv8/KE986wE+QT7NEWGVVGcLgyp@vger.kernel.org, AJvYcCWj7sYgJhKub02h+13Oq4C+XTw/gzxSEwkl6EKrXJd27Ys/mlxTcfxkmA8o0sly7jzrzjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqDGPyJ54cLUaaBQV+5uqBfspZJdwUUkmho/RG7eTkKMIvHdYO
	/X8zn0bZazJMouVtmkx5YJ4CfbNLrJUAnvpDAYjYyN4aajnnom+6gF1S
X-Gm-Gg: ASbGncttgCPe3shaZhiFe6+M6Lq+HD/OowN1Eae7WEActADyN6fAkW0otjmWlh6+Woo
	K6gZaW125DPru9kZXK1cwUV7nl7cB2gjpiy35oVTNMQ4rioES30xDPHZSR2PYzA1F2uFKwRxoml
	C4PVPeh0jlfEJAzp/qzw9djUCMyg8K8h2d8O3DMzZDY4FV7GJC9f2D4zk/w3KqcrfRPUOVIO0V8
	eb0plTmYfTjwSt/96n6GyxXWuf6ORxIvrBM6yR0KhW5rpsJVqO0pjXYhKeXGGC1+Luy3yTOTzlI
	7QUXnUzzDANppuOWAwFWoQ/Es4ldYMqM9znS+mgOYyQRt74BIYjXrTXdNz/yRSCfsjgJU5mmjeu
	pQ8MZDDWzplPe
X-Google-Smtp-Source: AGHT+IEOk8Txtw7wZrA6mgAZZ3zGVAl1tkX4/fAps4bB2HOYHCbHS9q01TOG2Zz1Z6XjlvyRYQwQJg==
X-Received: by 2002:a17:907:94c8:b0:ae6:ddc2:f9f4 with SMTP id a640c23a62f3a-ae6fc9ff022mr405030066b.6.1752249923490;
        Fri, 11 Jul 2025 09:05:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82635eesm313881966b.81.2025.07.11.09.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:05:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Jul 2025 09:05:10 -0700
Subject: [PATCH net-next v6 2/3] selftests: drv-net: Strip '@' prefix from
 bpftrace map keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-netpoll_test-v6-2-130465f286a8@debian.org>
References: <20250711-netpoll_test-v6-0-130465f286a8@debian.org>
In-Reply-To: <20250711-netpoll_test-v6-0-130465f286a8@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=leitao@debian.org;
 h=from:subject:message-id; bh=5e7Gu2hSYoF78NHOOQ4u3fblm9IpAmXxrCi48b0pb34=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBocTY+oEsQp+IO4aE31w+WTCng05k+3qn0r0LDS
 m8RygsELaiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHE2PgAKCRA1o5Of/Hh3
 bafqD/0WXwdjs2NHHl5Ferwad32LyL06R2iMKwfNI63GyhPOd8/mezKSwvn/BE6nSSVpcQFQ3eo
 fCURY1a1J1lHUpHlcn3fWgo75nGW7fmgRSW0mIcBYw3JikQ/CoIhwoEE3IaIYQRGpvFz4ZCVPxl
 0sLR+pYsxc56Q9Y5JaIx7F4A3vFOFBCNkISuJfb35Hb2+jfD2Mi3dbVUblKqW0lJ6PHrocMHc8v
 P+QZra0uvw/Nv0sdWX/Y6ixzV+Y3DaBCEXEAc5a7hlNZuuMKH/lOCj1dUhKtI6ohE7agjwUbCzs
 3Nu2lQg5Skam+e2LXSG4WEBXoCN4F9PXyi4KP8bZPXVaiA1xyRg8wyIx4zWIaHeGGGUkDvEACkf
 BET2Yb9/+PdF2Mf+5nYMyMQNL6PtaOdRE8DdZfuX/uS8d5YziL+BrwCqxMeZP1ftJZGU43q+2OK
 GPwf6HRP8YRN13cUnpCb8Aqcty0/hG+dV1i1nUvBfLM8igpygS0QBnIQXQyAP7xGVPwJrUlAz2H
 SE4tNgeB6Aa8Ii+FBmHff8/bvmfWc3ZDXUkYEHrrKtp1xqdUf9V0UJkttrHNsJJMsLvKi0zjX5X
 BFnyAVMJrIaLQszuELZ6KOpWnUiksdog9ch3uGlbGk938JUCIvzbGRlGGkKuBmSNEik4rWYMw0M
 XuK6NJoE6QZfMVw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The '@' prefix in bpftrace map keys is specific to bpftrace and can be
safely removed when processing results. This patch modifies the bpftrace
utility to strip the '@' from map keys before storing them in the result
dictionary, making the keys more consistent with Python conventions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 760ccf6fccccc..33c23a928ed1d 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -213,6 +213,8 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
             if one.get('type') != 'map':
                 continue
             for k, v in one["data"].items():
+                if k.startswith('@'):
+                    k = k.lstrip('@')
                 ret[k] = v
         return ret
     return cmd_obj

-- 
2.47.1


