Return-Path: <linux-kselftest+bounces-34717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE48AAD586A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94657169B93
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABB52BD037;
	Wed, 11 Jun 2025 14:19:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA6224D7;
	Wed, 11 Jun 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651552; cv=none; b=BbsGVwYfuIxLPfix/+NTAoT3QQ08vKaZbqs/PlPXUqDfgHQJuYGiVmy1tuW/S/9cQ/tDn7vnlUPoi8wa4W1tMeLhforhFkFieRVbzLFFtdjKclRqHJdJv0UcC/2guOwzjAyZGDOsuY78lgFctfssQoD51yFW/ntUVmAxN0nPNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651552; c=relaxed/simple;
	bh=kaPQVqJqh+eg2jcnJq+k42Jh9O4UIBng+B1OeZ2n8IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uD1Tdta9f2akK6fvQwxbqPJpSwgmtIawXIZcGjU2BUKx0lv4yYz7w3tfySuOswMVUUrmg308NH0zvoAKg7WsugtEUYwih1isuDlq7XVRSWbprdkkH6iNUSFbm19Gl1pz9NOtzav1F7o8g6CuxDJd/psF5gTFBLiJcZGU2OlO/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso9378843a12.3;
        Wed, 11 Jun 2025 07:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651549; x=1750256349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLOOJJpc60B0rv4JPb2Hwjyu0WdXvR5+iYJdvbJfP3Q=;
        b=QMF1T/RLS01sGiZsMDb6TzaQf48cTsZlqkXJf9baSEHFdBQj9es6mbsKaFwDranVPD
         fPqQkUJKLhgOeBAILwx9ttAbstp8qOXuB2VIB5bv3zcvBL9/6Lp0e1qstICgmOwzRAIL
         dTkPU3QoU7G4YEip+IqfSI4fKX8/H9KrgXKZctUM1Mt9QinDGvjGPt1ShOQRAY6M8ctv
         co5rIn9nbUrm03b8tlV2jQthE6dv8WO65PbnMbeYtPcXitNFaJoxJ9ZKXz5QgUxw7TsE
         eDhK6QSbGlUD9aG9611DaJ4HDFwku0oEfjOt/slVfsnVNN7V+TzcS0szLeRm0ddZuXam
         4EQg==
X-Forwarded-Encrypted: i=1; AJvYcCUTTXCxajtJ86RT4aesI5ZZw8QqmCc/P2KCW156OHGMEkSw9o270uE6jy5bj8r+5bTLrqbH3WHxYXvyNKcRgNlk@vger.kernel.org, AJvYcCUhKZdIus9Ot3XsFfZXtY+1AP9UvMwqKloHNbMZTMZWPRibIuPLH3vCpwpLVaWOSFiMDsNroI6H2wwOub8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznnymyxH1KnksL9j5uq9a58dPWFP84Jqev/u51KF/ojlv+cNAm
	UGDr5jin9msYvGNA5z4YvA06gOfsfp6yVlEoiIvLPhJMfaCVwJLUtqBt
X-Gm-Gg: ASbGncsee7odZRh/orume36QCWMj261wpWLjfI7gu7jblJZ+AWrzmGaxA4GgTEe1dzF
	xZqHwirEnqyJhfJBLkO/yGs7nlGlYaHHYxoCzFc7P3O7G2kpOlwlczTEcPFVQXFGGyTU60Cqk1F
	Es82vCIS8gyrmTJoZYTWb2+Ce9eSOjIFzOYLYkNSkj57VV4GFNe2yQgYq7VU0LNZG0GqJ+RLXln
	ONmXVN7p8yl361Zs+VZWg76K4hd9iS+T50QEoh+VrXRbZHVVU6z7OkCe7cxU9s6ACtyrEJgU0hn
	UADwZcF5PKpncXvcVI24uTSC55e0lIONthXULD0iRsetcHgl51kl
X-Google-Smtp-Source: AGHT+IEyBfj35EXjgV32POhKGaylOa97e3Bq7ODAGeZcwTni4MntpM/huQTqSsgbGq9kV6ApSNrmfQ==
X-Received: by 2002:a17:907:fd15:b0:ad8:8621:924f with SMTP id a640c23a62f3a-ade8c990163mr286915366b.56.1749651548599;
        Wed, 11 Jun 2025 07:19:08 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db55c7esm893884666b.49.2025.06.11.07.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:19:08 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Jun 2025 07:18:50 -0700
Subject: [PATCH net-next v2 1/7] netpoll: remove __netpoll_cleanup from
 exported API
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-rework-v2-1-ab1d92b458ca@debian.org>
References: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
In-Reply-To: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=leitao@debian.org;
 h=from:subject:message-id; bh=kaPQVqJqh+eg2jcnJq+k42Jh9O4UIBng+B1OeZ2n8IE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZBZeAy8rCRhIviW++2d+F+ridtJSqQtX41dr
 nRf+QPEMxKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmQWQAKCRA1o5Of/Hh3
 bYquD/9rI5rqqz5kcKugBm2oz5O2S6Uc76i1XENSnMCmti57knfLjPDaYlmagaxGrbNFX3VW3JP
 A8OT5f6a19XE8PXSObS/wGLBkoX5lwDzPI2uAodDPdL3D+Oqqj0/F2HQ0CJG6Hmb61MQQN7u9qw
 yXKz9doq9L3fGCx6iF+eBN86XWRAhmGznjDu8HhedXxT0MoUwDx9tXfVlxQgwVu/KTixvjov/gM
 wL9tlMtpOE2Qj/m9UTZUQbY609crbUzUgiAVEYy/Tgzo4QKQP6vioOBhV0ZmupdHHDdsCq+KpSu
 s0l4wLicgf0UuVr0I1RwSABRciguT0s3c9PlkMFnD+CbRjy0J3Cp2hbeFXX5EWmiSoV+rFhLI39
 yehpxhFPIWbnop3vQKBmzYYqEOHoWhKdj/AX0riwxSxXYreBj/YHgrcgaaBLNouDLQI2Z3xbU+t
 /thsnp6InzKyQtFX7IuuBLmxyZhanWLJn9DAGugzfmsoIX6THl0/Y6tKlu1OT7eYaUfREEd7Z1a
 Bi3q3YJgncGL6hNPLnx6TjVG/bRMw6XcOzPPXtDnLSc0601Gk8UDFJMTQ8nHfchBdsjIfZqHSZL
 soeW10Fb82E9G7SKv07kmVeklBm3n2bn5FTgfftto5njryhsD/6c9FXoISj9bqGBt8/cFVEOlDH
 mDpKUYaeMMZkKbA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Since commit 97714695ef90 ("net: netconsole: Defer netpoll cleanup to
avoid lock release during list traversal"), netconsole no longer uses
__netpoll_cleanup(). With no remaining users, remove this function
from the exported netpoll API.

The function remains available internally within netpoll for use by
netpoll_cleanup().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 1 -
 net/core/netpoll.c      | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 0477208ed9ffa..a637e51152544 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -69,7 +69,6 @@ void netpoll_print_options(struct netpoll *np);
 int netpoll_parse_options(struct netpoll *np, char *opt);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
-void __netpoll_cleanup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 4ddb7490df4b8..a69c2773841a5 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -863,7 +863,7 @@ static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 	kfree(npinfo);
 }
 
-void __netpoll_cleanup(struct netpoll *np)
+static void __netpoll_cleanup(struct netpoll *np)
 {
 	struct netpoll_info *npinfo;
 
@@ -885,7 +885,6 @@ void __netpoll_cleanup(struct netpoll *np)
 
 	skb_pool_flush(np);
 }
-EXPORT_SYMBOL_GPL(__netpoll_cleanup);
 
 void __netpoll_free(struct netpoll *np)
 {

-- 
2.47.1


