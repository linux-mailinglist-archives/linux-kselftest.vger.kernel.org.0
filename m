Return-Path: <linux-kselftest+bounces-41121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9680B518F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883EB188D928
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 14:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742F322777;
	Wed, 10 Sep 2025 14:07:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4503218DE;
	Wed, 10 Sep 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513235; cv=none; b=BY8mT0XlDAvDTNcKpos05/gPrgypRLA/OWd5MXYPGB9vixXaWuW8RwrI+kgqzGo7JfVGdbl80xH2GC1QWHPJ+GgtaO4F0xloYvITBm9EMQi+4JTgO7zB3aJlFojJdI7ClZorfaxR/Zyu12N7GVLsfLDf47pQb2rz1z9viVeq/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513235; c=relaxed/simple;
	bh=PWTGFoya3ts52XQxLkJ32u4VIXukd3NLAGvRdEqH5Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1LPEOky6tHoL6FbUXNRaWMlekX03aTdL/HG9UEjt6vqK5Imu87j8WWxSh9ynSyj2HM7Coo1Jmz3h5o5RS4w+SToU8Gudd/LivqbN9yDVZu3s7JIf9aPPUJUqLz67SDzcoAiWMOSQHQUfAUlPrIOEk36kSVnqtLocfUh1s6dT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-621b8b0893bso8869582a12.2;
        Wed, 10 Sep 2025 07:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513232; x=1758118032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXD/Pw5KYF4j6teQtZ9HCC4ut3LTL+irS1zpw392hxQ=;
        b=G4CzjgUCda3l/aYOy2vroLjQ9/3hBAtWOLNhEWWwZMGHa/ygjlhkRY4BpsFleQ+CT9
         0h0NyLjyERbO/c6bS4zjaWpkaoBGlOJ4WLVyzk8fYas0JzZzGdQtIfvkVKeUXwfX9nWe
         32XwHgg/1w4vlMOmKleYSii+VHBGuPKQYYhqbe9z6ZLxwRqaU8XY2+ws4IltyfqK9CRt
         cTMxh02PtaBW0N00qAhZBnIldSAYp+zXaQoNd7ikj9QkPkAE8fe0Yg0SszQdTt0KNQ2F
         vYcODCNB4Eflz6ISTJQD51XKV4T9mnzazYEO0H1/8qtHgYCLirdlRMbEzmXmTVxq/Unm
         r+6w==
X-Forwarded-Encrypted: i=1; AJvYcCU4xnnMB3F9sYAddYvuPvNI7N5nWsXqT0ZUjEHjSHUeNEAjneMeegD4OyinEgg9aE2OeyILJSY8ATU2MRU=@vger.kernel.org, AJvYcCV5i0o4lHJIJnxPR2NU26DFZUf8jT1gIDh/sfYT1mX7bAAZffa1tW1gUNvlmiTvyXiYt4PNzg4ZdXc9kLOQObOY@vger.kernel.org, AJvYcCVl4XqQSiAfX3Ls1yYzHIc2xH/Y1KzRAgE/nZMKhPk+X0/j3xJcRZcReaOCjWf5XbxiZtqy76EP@vger.kernel.org, AJvYcCWytm7p6S8bkNtzRZbg5ZkqDtNmQA5K6r9TK6lnDkWQ+92u+TEXIbLpuSECqvEsRT9brnTXtSUz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0+6nuPTcfLne5XohH5HhrYQBmkNY6pgnDCfD+eNSjRAKeSXE
	RC5GHNmZ+z6kn6g0tLHzpryg3MtHcv80se8cZEwmwlbtLXA052lWfFJs
X-Gm-Gg: ASbGncsWQeCFMw5pOZkpXSP/4DN2JRY1zHnSiA+iXr8kHdynBlyaA1EQXGrw2P3FeKX
	/0DSVZx/AxuFGo8/epyPZu2e33cAVB1vxWbg1/hnxswDHfhq0Y7ByuYzXWkeWMBRNGrR5vmU3NG
	xNtNA1OUhIFnd/3nClFif5mDxVjpT0EpEOVq7agW1Tx+lYvew4B7h8t8ELIbIGtzbbZURvfxJeM
	SKNqgelaxXA5/ZzTjjpytxuGjUuXyF+r7Tm3rsgaRarkPf8hX9PgIGmjI0hefYIhoFWuQ/wE2CG
	Vdh7X+EjDoO/imsQ1M1w+xCtfGfyUqAwpn1X/yGBhiOGOftMeWpS9SsMtBa25ePYgLjHMR9PLJg
	O6LmZv3/7pvnC
X-Google-Smtp-Source: AGHT+IEVvhlFnImEIU54bcnU7okLIjmPiQuksidXcPAThW7x3Ajaq7a6wVNfOGY1HKl5feHNthSgHw==
X-Received: by 2002:a05:6402:5cd:b0:61e:1636:aeee with SMTP id 4fb4d7f45d1cf-62380d6ff8amr12700420a12.38.1757513231409;
        Wed, 10 Sep 2025 07:07:11 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01bdb952sm3347484a12.52.2025.09.10.07.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:07:10 -0700 (PDT)
Date: Wed, 10 Sep 2025 07:07:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Calvin Owens <calvin@wbinvd.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <5hiawr3ved4xonlmc3yxmomhimn3lo5d2u7z66elkyurcde2nq@7kqossblfmfy>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
 <aL9A3JDyx3TxAzLf@mozart.vkv.me>
 <20250908182958.23dc4ba0@kernel.org>
 <2930648.1757463506@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2930648.1757463506@famine>

Hello Jay,

On Tue, Sep 09, 2025 at 05:18:26PM -0700, Jay Vosburgh wrote:
> 	Second, I'm a bit unsure what's going on with the struct netpoll
> *np parameter of __netpoll_setup for the second and subsequent netpoll
> instances (i.e., second and later call), as the function will
> unconditionally do
> 
> 	npinfo->netpoll = np;
> 
> 	which it seems like would overwrite the "np" supplied by any
> prior calls to __netpoll_setup. 

This is clearly a bug. Trying to understand where this field is used, it
seems it is not used at all.

I was not able to find any usage of it, and removing it and compiling
with `allyesconfig` didn't complain about any other users also.

I think we should remove it.

commit 5da5611575ce94ca557c194d4147ae3011cedb6f
Author: Breno Leitao <leitao@debian.org>
Date:   Wed Sep 10 06:32:25 2025 -0700

    netpoll: remove unused netpoll pointer from netpoll_info
    
    The netpoll_info structure contained a useless pointer back to its
    associated netpoll. This field is never used, and the assignment in
    __netpoll_setup() is does not comtemplate multiple instances, as
    reported by Jay[1].
    
    Drop both the member and its initialization to simplify the structure.
    
    Link: https://lore.kernel.org/all/2930648.1757463506@famine/ [1]
    Reported-by: Jay Vosburgh <jv@jvosburgh.net>
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index b5ea9882eda8b..f22eec4660405 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -55,7 +55,6 @@ struct netpoll_info {
 
 	struct delayed_work tx_work;
 
-	struct netpoll *netpoll;
 	struct rcu_head rcu;
 };
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5f65b62346d4e..c58faa7471650 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -591,7 +591,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 	np->dev = ndev;
 	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
-	npinfo->netpoll = np;
 
 	/* fill up the skb queue */
 	refill_skbs(np);

