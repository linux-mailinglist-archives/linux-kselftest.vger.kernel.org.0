Return-Path: <linux-kselftest+bounces-37230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD5B03B81
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9B717462A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D450245031;
	Mon, 14 Jul 2025 09:57:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D525221FD4;
	Mon, 14 Jul 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487042; cv=none; b=lbDsV/CQRM8wL/ZIV6Vudw05GxOOtOkBxcSkUmkuA5qCjGZtNrSm8TMLafOcasaFg4RZQCoQENFfKhCpsNdP4R3Xm176h9vkNblo3FSjtkWt98Hge7zt1s4vUm1HQeJMHLCJObV3SqdLNe3NHzHy1HLt7wYbhYBY4fJsWJAll9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487042; c=relaxed/simple;
	bh=P7JVfsBUsMMZTxDh1HoNFYhHQjPyRSuGC1h9Mc5xifY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rh63pcZM/wThfNwtx1tPdYnpT1n51Cqn1xjElpwT7lS8K4D/DyP9K4cDT2cPdPW3AoDMsuwNWybDRU1PIZMg6A+rZuQ0li25qApFY72kyF7SJR8qOc/Wk+ZWzEHQICN2TT2R8KM9mJS8Ge3LytP5u0yX7WhrpuTRcerOIokHBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae361e8ec32so773935366b.3;
        Mon, 14 Jul 2025 02:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752487039; x=1753091839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMqqFmzAzdaOBbXXBjjnzeqSqi7pvd+kihHl/a1RYho=;
        b=quOXhM/+M9JCd2JXLD6beRZvHRHWm+aa1cFPEZ6Qe+gpDfmZ+JVUzJQX5rMvumCett
         quRGLZV20P8xF27c6pbPFIzcpMqnqm+6Z5Hy5egUKDHPq1hvoMTIdpZ79SDyCKtruK5m
         xjdT4xnvaVfrkeQZ/EKrzDwAZLi1CSHJ1QFBJY3KhcmxrLakDIFeLc1KRcHERClWghsH
         J/cw4j8BmI9d9VDP4urC1MqiYzPuyPdmDVHsJM2IL3V8lVdOhnMaxK2/Qp+vkCp8c95W
         92HlGo2RYHUrFaOpv2gcYx/PdIwmyFS0rnRQs7BDgj+nUnpLhZnwb0ghc9Z3/xtDvvtT
         Ie1g==
X-Forwarded-Encrypted: i=1; AJvYcCV5s1bQbZ51Niyu8ln4GclmExZO190QmWQEgv6iD0aQ6puGW2BM/sdNhqqVfEo/C7dOeADETupymdDXBVA+kOQd@vger.kernel.org, AJvYcCVaXi9fL9KRVpcV/w2fPI5uQCUfpb4Yh1CjrgaMYmPrKsgkUdzA+jApSuyZyp9tfWx1NKQ=@vger.kernel.org, AJvYcCX3TDF2ZS6/n5OHVDU2bcgHh8DR3O+jGkRan8WOJtYLa1pQbEovjsiKBXtiQDEFzI0oobwvs2R4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfi/hCXsac4RyJUeyN2j8AecYaCVM68SSWzIbYhyX4vtxGuK41
	gd31/pukMG4UaQhWoWjlua5gRx/ENyDpalmStQI7Q8DcMs621LOFLGOQ0mANHg==
X-Gm-Gg: ASbGnctdUWEE5COm3HZ+rvX+B9n98yHY6sY0Bd3tATUjWcPjAHeYt14kwi27Xyf4htL
	MGkZ6YF2QVjquOJVtTWlXn3bbl7LmX4/6rzS9Y3ct03iOfmBVVglCrku+zvaKGRh9qGdiUG7Zjv
	NwPbf8ZIzPyolG7FA/Oq9ZfQp0y6bGKRMHZoACKIwL6Cc4gQIrbp4kSvLfh6TcuerEaDBc/2GDB
	l/ysnPKMgCBw2jK58FQp91CEzxL+8oYpwJqvDTeG4FopBm5LQa7TduY3OfXHR4bNPAEOHXzqfEA
	tAdbZQ6RJ6rGET2EFl2lOamawAGew27GNBQ71ORFTVqAFi9WeyRrHmc9Q/g4VMnP0Aesq5J+r8G
	ejLjlIobEBJZ5ng==
X-Google-Smtp-Source: AGHT+IF/vD7T/pdpzQLhGdJzue0ydgrWDnzLvOvIpcPbUQlXvvlh6V78EeHIOZ+orpW9suJ0cQjrDQ==
X-Received: by 2002:a17:907:1ca1:b0:ae0:c690:1bed with SMTP id a640c23a62f3a-ae7012db12emr1256262766b.51.1752487038948;
        Mon, 14 Jul 2025 02:57:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bb2sm794448366b.114.2025.07.14.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:57:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Jul 2025 02:56:49 -0700
Subject: [PATCH net-next v7 2/3] selftests: drv-net: Strip '@' prefix from
 bpftrace map keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-netpoll_test-v7-2-c0220cfaa63e@debian.org>
References: <20250714-netpoll_test-v7-0-c0220cfaa63e@debian.org>
In-Reply-To: <20250714-netpoll_test-v7-0-c0220cfaa63e@debian.org>
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
 h=from:subject:message-id; bh=P7JVfsBUsMMZTxDh1HoNFYhHQjPyRSuGC1h9Mc5xifY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBodNR6hwPa3EaEIwDul2tGXRF7LnTiEeR0ew812
 s6F9w/8zBSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHTUegAKCRA1o5Of/Hh3
 bYAuD/4oSX5diUff8wqHFaRoOq1h/+Ucfw5o5OQig7JUXDzUD2rF5hv01rd7U9CXsMRctR+2OM5
 +Hv28kJ6oaNTIsA97sn86sr/5YhMaJZb/VlTYJEwUOYlXrR+DfI5qzVaTA6tMuz2UafArmN2y6k
 buBfSCqe2Z5jbkVckAi4RSoTtxYVF6v+cWneKxINo3ITz25k4P9C0iORBhaamZqseV2u7PRyGD3
 gs+sIi/o5QLgr56k+GN1c1wuA9m8T0oG1CE+nW6wQaqXuFcLSxmD5PkrR6DLQ3JYmlbcGqw3+0g
 x+rNy/YObFCJxhENyIyWtkJblGKf6c8+GMNL2sK4yVN8bMHrRe6+zXz1WeKch+yI80pZHO5aOLk
 WD5xadurPtmcYjxxPtSgVcgm1zo2Cw6WYMpB7SSIAoAAxK0nbjHEllOPv+8f59PNmYTpCF+T436
 upP3xmhaF2DK0nJjPyADumailuC78GkHiNOk6zjr8dr0vINrXTmxFfNrsqBOa7oFqyrmgybgcGX
 FNSOeVXSez1Vx2shzmRsRNtZnAhUv5+tiNXvu0+cSH0kk3Fxh4JPHyjmjasK64w4vB/UCEZlk6B
 3mmt/gKsOtDNwQ75ga0x+x3/khkml9ztYhyYQqTCvjrv8SxGQsh0VfrcW8868BA2iPQoF7bv6zH
 h7I0k3uDUq55P1A==
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
index 5950a643a5336..f395c90fb0f19 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -217,6 +217,8 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
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


