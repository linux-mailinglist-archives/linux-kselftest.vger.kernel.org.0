Return-Path: <linux-kselftest+bounces-34893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82DAD8A7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9AD1E226A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE52DFA24;
	Fri, 13 Jun 2025 11:31:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868931E7C2E;
	Fri, 13 Jun 2025 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814316; cv=none; b=F7qKx1XjOYED1QPFJM0794of3ViSojoks0dcTsMXcHKZSHFJ1aY7y14IFLTE+bRvXq4Xpl4IJvPQhDIRKB7x2ZxbxYGkSWy1H2Vy804BXwGXmiY1ZgAV+UBaD7OG0yHNm5QvaRhbkFoAI+SIs6+/0LrsLnGgiuTqw8Qu7w2boAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814316; c=relaxed/simple;
	bh=kaPQVqJqh+eg2jcnJq+k42Jh9O4UIBng+B1OeZ2n8IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ac1WggYUujzhfmi9dpmeNpK1ZUbU+78jsv/DCq9zNjdo17S73/kC6NTFMj3mh3xEh/IfbavxsZFSR0uKjsNFe2/ogczVQTPhe6HM8mUy7/w/xFd6rl7j/DJeZEc3k/mGAi4//ag0MsgJbR1p/JiOZQYKYj/0JAORI58C0jdbRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad572ba1347so312625366b.1;
        Fri, 13 Jun 2025 04:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814312; x=1750419112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLOOJJpc60B0rv4JPb2Hwjyu0WdXvR5+iYJdvbJfP3Q=;
        b=enFDGdefH3goEWHZQiF3mEAdcjDO3K/NRsrdqdaCqa7qEAJvHdKHoANoqEDKXylynd
         64VdB+yLLEmhUTjw6C4eiEqKW4czAPBOhWX4eNpja+1xJvOTrKpKFM07hJQGgWFEArzJ
         VEZ4Ho0IJah6ErCB9hbp0oE4Myi8kmNrADvth1RdRlOUQJAaDCA9Ztn3GYX5ZxupY8vf
         RyUQsL/z+9m8aq9hYh9yQYy4Np1SrQUULl8e7u+ulGrzwmgFBVF182itCnQkcF05Qotk
         DrJJnmQA2H8r3drLoDUkkSE4tUGeYCIg3ry7S0pJfDgdRsdomNTuuec2Pd8cH0h1zooA
         r7mg==
X-Forwarded-Encrypted: i=1; AJvYcCVeNHKwJJJeGgDmlYz9xR4gt+vWOXfJ054vrSx9XUBRW0w9YwEhNBEq/L3j+AQCk1jogz9ZniwrSMXKaWg=@vger.kernel.org, AJvYcCXnHC1A0OKvAZot6raoNLB5R5+YJZyic0yrVm9Q4DyF93aO+B9XjMRUHs5IYEcWeqbxIkmCxAA4dSP2VLzi4sLu@vger.kernel.org
X-Gm-Message-State: AOJu0YwjB7dd0oaKP5Rii+KxbjUaapgERipiy96pCi9Ig4eXBJVhGI7Q
	DA4QPrW2OucAoQRyK+MTdKbDk+hUkQI281lrGO80V/Gy7EE78g4aAWv2KR+YHA==
X-Gm-Gg: ASbGncsbwGzP86j/pHd6TDVYt8pHbCjbfTiBKU8cXoQTrahTgYN+8ZW0gcYlWC66KZr
	PH5gG66cu9pPH/RTqrdBL27cD/f/MtFa7GMsjO4JG6cuzLc6b6AI0tHK3evhhUE66GQiuHF2cKp
	eN8EGf4V2iTRMO6MVHOEtKiEsJFT0p2RFyNpxemEIiUUDfDf6eB9mKc0vi40bblAXLyay+aGHet
	Qpk+hqp5vYOhqDd+BHnh6LfPiN4L3uW/PuEFICHiwS+rd/W6JE0IRA1jXcEeWkeGaXHvcAB/+/r
	V/JmmemjKU7KhVXCryq4eTLXDqAi5p6nbpTCt90nNEFZz4sHB3Ea
X-Google-Smtp-Source: AGHT+IGekdLCPAKBBRyYeCUtI2lpZBIcn98/RbsMGORvyz4EZDGfKeW1hlHHtngaqoOWWeQnMbFSKw==
X-Received: by 2002:a17:907:7fac:b0:ad8:8d89:bbfe with SMTP id a640c23a62f3a-adec5d21774mr215713366b.60.1749814312321;
        Fri, 13 Jun 2025 04:31:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fe978sm114496066b.107.2025.06.13.04.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:31:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 04:31:30 -0700
Subject: [PATCH net-next v3 1/8] netpoll: remove __netpoll_cleanup from
 exported API
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-rework-v3-1-0752bf2e6912@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=leitao@debian.org;
 h=from:subject:message-id; bh=kaPQVqJqh+eg2jcnJq+k42Jh9O4UIBng+B1OeZ2n8IE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAwl6ipGpZ4sM+Es4k630z79KMxVRKEepP1Sl
 oQSK3YmBFOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwMJQAKCRA1o5Of/Hh3
 bcvBEACH6xSpZMVkAyLouW/pNM3btOEqwZOYTTjW9XowlBKb3+W5BsxYytpPnyHhwgCZAd4kWbm
 JVZ+4JR8pEJ2iMNRvFma9FGRw2Q98LDtlNFlcVPWZmccy0F7Kz8LMKr49MiYe794ArWFq879sIO
 R2gRPyacpPy8ee2FWa9de/70+rBUY5eh+XzlwLBcMgQ/IwWd+THr2cPaoLRlRnKw8qAZKvo3vf9
 HKV6I9HzyJoev2Rzr5P9PTGRkIAv5FzAZ0BQvx0jZCUabjy1B6D11746MbUQ1O3KIpQz+PoBxuX
 UlVM4buQ+3nioB9ulqbs3S4Z9L6wAO1rNWbCUJ+3uUADXaFiut0NPcwyVwT5uR+0MqiVS4o2BD9
 +aFdTA0s1utbaKKgUu+xfRJ4paKV4YYJNEqsnLnO8U9xBWNpVSNP69uW91LGbd9YaDEiexwxZZp
 zxTabP4jkcal0TxR6ZK7FxPD45UMVBtNqURpEMZeJinI+2oDabPfs0q0OY5yuxmSOMMcIv07Tg9
 GxWskG34zCRd6gdML0hXNQ/bdDehGgo0tiPelJd67iik0RjDHfp6jkpSGCGzbRXV9ml5/UD/SaK
 CrvezrQz4gFz4x80dvNA9l1RMKV1lNXcXGoYnFq8H4GWm7XCgTzOMfYRx+SsbWqV22o26gZQsb5
 OO8hSfTfhVOqqQQ==
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


