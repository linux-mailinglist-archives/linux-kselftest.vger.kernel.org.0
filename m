Return-Path: <linux-kselftest+bounces-34600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3358AD3D05
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01843AB21A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F0724113D;
	Tue, 10 Jun 2025 15:18:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6E22A4CC;
	Tue, 10 Jun 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568709; cv=none; b=RISzVcegixf+AAduahThWhfOueVPMbuMqCHXuTvUJrLfkBPTzbZ4fjyk8As2l6ufwOB3Zx105x4VvcirEJeC48jBveQlrIDRz2ynYUEEdBoEGHda5JOJxYKmNV6DKgFlW9V6cg7RidC2sASLvJfRkaBZxZvQ1jeW23bCAyZKFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568709; c=relaxed/simple;
	bh=kaPQVqJqh+eg2jcnJq+k42Jh9O4UIBng+B1OeZ2n8IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZKgT1hDHW2lKggP5xiC9NADglJPUQO2LHhYESaRTXR/orq+DMENOsNIZ9WbGaTtHnFWvFOUxjXcUmb7ny4q5Kq8Rp1kSp4G+p+mEruaWUot8+CTrDWqYwepKrjaqyvjO3HgSczee4Rd3ZqXGjG6sxnw82vJJKPWGkokQf8dnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so8404632a12.3;
        Tue, 10 Jun 2025 08:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568705; x=1750173505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLOOJJpc60B0rv4JPb2Hwjyu0WdXvR5+iYJdvbJfP3Q=;
        b=N0oHlt1I3O6/uogX/43sLGc9K/HOMyMQAH5kdv0P6AhybpCJpR5cUnIzvsMuOPA8Bm
         OSXHXlNbrgShq7/gNGivuLEByVpjrLt3A+0gOk7+7iyfJokcuYNaByn8iEySEIhIbvFJ
         SIylf9dUwwFLwKRuGEkc0YusXhtHitaxHQRepCohPYNrEMBjE1g3XqSBgYI2fuLOAgrb
         kovywRkeqkjOQWXzWQsTZVWNBvWSazbzcX/sT43cTcii27cDqCqd36ZjrfyoourWMbPw
         cZ9/ZDqLLQYiYmj8Olx6hPZpWA0uCLcXvuiUT7zFoUL8IVfDm37j84SDWaTQgFjWeE+I
         ZmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuAmH+xJ7PP7sMklmrwgIBmtwKz+NEEtHXnusVYumdKkO9cPEzuU5+tzfeTuTv74iGLaqJvSiQyOgXlADoE9e/@vger.kernel.org, AJvYcCXvdfYkBkwFcrQsZkBEbzlfkYBNWfG9RJBGRGswH90yrqCFmZ/eioVyKP6/Q4Jw09LdIjfzTgk/gT4r2Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnssViIFlfFIqXQj1iZjKNDAwYboAde3B7C6xyIfIXfuToqG5e
	0Cg5FeLpvgVmNE8fBuYLpKlOPqavkREI7kD5YpKBhMTBxWCmsrna54xI
X-Gm-Gg: ASbGncskBsMBsjFJwvRfH8Tve3jVHNitc784+FnzbxIvvkOBh8YQy/fpvBXJ1o98vjH
	JYpTzLfNjwCfd6Ca9/n6W40H/dKtkjQ15XdLlZOOCAPUSptWJJgC2Di/e/qFHCxAbI2MR2AUnF6
	/GWLtMVims4AYjD1b0NjpFjx/JYEmiEUnKtzsyewBXw976XfcME61nN6MQ3XdLbXdOqOejH4Hk6
	ZlLsbTqhhLmwTfJQiRNHGulwQT8W1NWwrONBRKGyVDTVvPltJYRQF7PTWj9MirdMYq60evluywn
	qCZOnOOCzplrleb/669+xJs3egNzuHdKxGtf++HQxEH8Pq6zua7q/cvgZZ6D
X-Google-Smtp-Source: AGHT+IE9WVA+kbFrnmT1TlL+TV+6AcVIBawnAOeskXYVBGEHFwX/ukFBz4SHKuCvRS0A7itqPfPprw==
X-Received: by 2002:a05:6402:2554:b0:605:878:3553 with SMTP id 4fb4d7f45d1cf-60773ecd524mr15584636a12.16.1749568705223;
        Tue, 10 Jun 2025 08:18:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6077836fe51sm6312471a12.13.2025.06.10.08.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:18:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Jun 2025 08:18:13 -0700
Subject: [PATCH net-next 1/7] netpoll: remove __netpoll_cleanup from
 exported API
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rework-v1-1-7cfde283f246@debian.org>
References: <20250610-rework-v1-0-7cfde283f246@debian.org>
In-Reply-To: <20250610-rework-v1-0-7cfde283f246@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSEy9cbamCtk1q+VC3hBblqcpJ/gZ0ql8ZGNKa
 j9+AkbUZ9mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEhMvQAKCRA1o5Of/Hh3
 bSGMD/wJT5gteXkme6oDQxMbBr2uzXcXsryawLuy+gz0A1w4UStNjLOPIb3TEZk9TezsVlaNxs6
 hRiSnwIXsxu5Oa/2VVwY6Fx/cZKVNfG+oAtFIQK60ys0Sq2cb8ipxdcwM69MX+KusXZmCAjsZ9Z
 gguQYq2Q5I7svysDoN9zyDAm7EkravGWiXJevP/tb6jX8WRHq+uhVUeVvkz/5+uQnJv5MjneqGa
 eRZJ+YRp/ukBRrdWrU/TXEcsVIDXGGdGXTFGkYw5c3SZrcTEciWxqq+aR2NjD+h/FtvjxV0kmta
 ooUGZR+HyH6mceVFxlkXFd32wJW0upysesQv9JEC+e1MejuwN0e8Xn0u0umvTC9KX7HpHZIQJyB
 eA5Q4EkQBr4XyzQC69QU2xAdRJ1TDMvwSm/QAOt9soi3DvjyJwsMJ7ZUd83EsPSwThgBGV76YhH
 ke6KwIpfx6ogyf/0g/NR/dSdfcAOrnIUBCsJJ1e7JG9UxFBWVbiJCG1xk7VGUkBGTjWPoVvM/tg
 6wivFIp67CYzmgWp4lyOu0S/90IYuBrq0c4aYvzOa30NCjkj8RRTNqoZ+HzIxuXMeSpZjV3tmN9
 GRuI0fWPGXNL/OfHODnc/NGcxjkCYjxGrNUIxF3kJq4ayeGOm4y2ronObeJO6YvMe9lGjBsE9DQ
 FKPwI/VyoSz+Bpg==
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


