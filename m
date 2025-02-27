Return-Path: <linux-kselftest+bounces-27676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF485A470FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 02:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A5016F5F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A404E13777E;
	Thu, 27 Feb 2025 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JPJzSLI6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F249620
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619360; cv=none; b=GVrim5hcPPQqqQKyZnTsFAwaQmibnMOzffYyJYmhRgstRF56gjuJ6zen+DU26JGJOuYR40rkqvHgGWLNiH3cqWCWjcBob8lGQjKDqkQB63GkoEES0ByrPQ3fhWxRMdRek/XAoZFP+oTJrJPcBxe9xnnp39EADiN4ISuRd0oDyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619360; c=relaxed/simple;
	bh=y6mUovoJ4zVyggWOqdlDboz+r7zYTEhOhKwmOpqPHjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m375qJYIEQzsiwq5qZlH70Qu0OPAEf6sLN4+axXKTZ1eDo8tKtLWO/jAKMt+e0v85OTc4VJBZCTFiImYR9suxl6QpYKwP3kraRCLmZ+pVQyqWG9FcoCV1sYmWHSAByCeNU7RAYon08pbrQ346RvQosz3OQVUy/8JLQ57IegftKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JPJzSLI6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43998deed24so4063245e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 17:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619356; x=1741224156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdfKqS/S3Nwpnvoe6TJKWmaZ5X7KroH8Z+ouvGptrEk=;
        b=JPJzSLI6Fhsge9nzDERRHFuwUuGwISqbpwI0fqfsOxgQ/7tey6NsDlkbQKnG71RevR
         Bl7qmwVndYSRlnB6Aig0ndxwlXE7YoHCeUxdT/ItroScs2ti9rseI4IQNx6i1eq10HNT
         BSSIGYiQmVYk2N8JdSrHb7Q8yseLp4hUQfzdAoUVxtEZnlD8ddSKPChLiq9obPSgm2GP
         TSIS/KJzwgwtjrtJxMX2Q285/FyUqxOntU0HcA12f7LDBXbZdMjuV5pvCvYWdk+5Jdqc
         GHy81XRsytR5MWnbvHsDXD+lTJB7LwXX3Dd+bWjXLipLtkvFcusRFSDDdQKFbRd9xnQz
         sOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619356; x=1741224156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdfKqS/S3Nwpnvoe6TJKWmaZ5X7KroH8Z+ouvGptrEk=;
        b=ntv97FprROqKL6YWt0kFedpckqkLkRKhPT1xdhyR1IAfwkTMMqscrtQn7iAwl2ylY5
         4iyTDFdF6zsH/uWYQCOcjGcCfODYBSqs5i4GqavtXMBy2G36fJtbmh5Mugx5ylrNHbgL
         oRh7yhciRqmiGkJZ8r6s3wDC+6KNzx0+i9W6d/8UJDVWs+5H8YiHn57jCoFK6C8Zbspl
         uM/U2PTCNH3tOb3Ce6a0NtaljgY8bqCXyCLVBUfakRjouZ1dUAa5G1Wt3+jh+ASFzXVz
         TMXYjg6ivvo91ciIU5j6KEm2mE9yp9nKa/IchpnXXh0kE5rJi1o72v+pZx61kUoM98W/
         OnKw==
X-Forwarded-Encrypted: i=1; AJvYcCW7lGJXEIFhTF8606u1nJbSXqGfOhBgk5769jALF1ufyFSVa04IYQ7G3vwEDMH4XfVScgbtiuJdaMfwbfeRbFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1wcx19UW9I1bo8bLB9n/NLuJGnTsZx3YsxSpfYCrvSS9zMMn
	vNwTvv+0Gy40C2Z1OLwCq+1a+PGZO8gBxqbZD/kkKaAG5hn+dGakFOHKax3VrnU=
X-Gm-Gg: ASbGncuBeacVw83Kxl2iY0qGzCtMGsGDBv6DHNoeUhJt9oobt2VWmAYHr//HCP8NBGK
	8073ZxzDRWVH3eXcdJp+220uOAY8r2VxIb7ZO1LeV95acpT0m9iT8NYMtL20C8TX/OwwzX8yOwh
	Pg84Sg/DEJPGzKWdZ2raHtpyehMkEYjpG23l9lqknbyZvPaAxxywxToqb2dEAGsRsjsZGGR/pDH
	yHI1yR2pwfL5K7iF1wckgwy4SzA/YZgiL3CVtX6XkJ+Z57YNc5OcfIAAZLKXZDN6neyW1Qb04EY
	hANLCuWzYcbJQk/CHzyxly7UY6KHa8tM5Fe8tA==
X-Google-Smtp-Source: AGHT+IFuD086KE3IAHPOqeV5OitkRUpotX+d0FjrsOtHmdahN+jMBJNI8NUWvlQaP+NlR+jbn/ChPg==
X-Received: by 2002:a05:600c:35c6:b0:439:a251:895b with SMTP id 5b1f17b1804b1-439ba17768amr162210245e9.15.1740619356599;
        Wed, 26 Feb 2025 17:22:36 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:22:36 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:26 +0100
Subject: [PATCH net-next v20 01/25] mailmap: remove unwanted entry for
 Antonio Quartulli
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-1-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=y6mUovoJ4zVyggWOqdlDboz+r7zYTEhOhKwmOpqPHjE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75fBs8huVUeoIH5dzDxJQU9vYaUqDe7Z3ShE
 djLWHzpKdiJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++XwAKCRALcOU6oDjV
 hyApB/9a53JHuZvgnv4Pa1kOftffR61HE7Pk0wU7FtfnfgWUYlOgNsfbW1RYh1TRkO8YTS9ZO/d
 HZLV5X2bR8L65XMujwXu2Xpv/Eu/zWR0CUXpV5PmQtmC2fq7d9qR85w4cL5ThJd3GxTppEytX74
 v4yqm0wYArKe3qDWgmsT5Us1T7OBlsgvOqkwIxSV90lAw1F/AaKgPaPrFJ+BhtP41cXQkPcnH1y
 DVzwPDmq4TsK5h1wIZ0oRLp8iQXQRq2tKzQMrJq7bURurk5Crk6/HYFs28xFmz+ZmGA8uDHwEX0
 IjVyv+Xvy+SLkBjoMCLwaof6SO9uIHviRvAzDGo/55k2rL2+
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

antonio@openvpn.net is still used for sending
patches under the OpenVPN Inc. umbrella, therefore this
address should not be re-mapped.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 .mailmap | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a897c16d3baef92aa6a2c1644073088f29a06282..598f31c4b498e4e20bffd7cf06e292252475f187 100644
--- a/.mailmap
+++ b/.mailmap
@@ -88,7 +88,6 @@ Antonio Quartulli <antonio@mandelbit.com> <antonio@open-mesh.com>
 Antonio Quartulli <antonio@mandelbit.com> <antonio.quartulli@open-mesh.com>
 Antonio Quartulli <antonio@mandelbit.com> <ordex@autistici.org>
 Antonio Quartulli <antonio@mandelbit.com> <ordex@ritirata.org>
-Antonio Quartulli <antonio@mandelbit.com> <antonio@openvpn.net>
 Antonio Quartulli <antonio@mandelbit.com> <a@unstable.cc>
 Anup Patel <anup@brainfault.org> <anup.patel@wdc.com>
 Archit Taneja <archit@ti.com>

-- 
2.45.3


