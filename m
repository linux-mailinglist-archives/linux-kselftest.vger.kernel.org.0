Return-Path: <linux-kselftest+bounces-46569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4B1C8BCFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 21:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AB36359A61
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C9F342C9A;
	Wed, 26 Nov 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crwV1k8C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7CC342C8E
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188592; cv=none; b=BXGInSNV1y3mp/P5Fa2bxH/DmmL+xB4goXlPRsuNtLjmD2kLL/T68TaukhvyKp/8MSYUSRAV/upjGP6oc8SUK6ogMdmQM3SdY78CvUVJa1slorho9B5TCYsUw04wkzJXOz3LLKZ9o+Wbo9b7eU2MnOO98VoAv+R/nBCe9Lmkwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188592; c=relaxed/simple;
	bh=xTW7lVbfJsgnlziO9m7HRTBaTgvYhjTEK5XGbQnoB3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkgpUooEETr3hRYtiexl6dq5M9Dr+4vHHTu4vjL/UbRlxCgV2f0o1mFI2D8FHFi72f/dgWcDHxNKxJzTKbaz7RWWcRW2NTQ3KAnr3NptB+fUyKH9D/C3AGoLO3vbiWn5/3BTC2UFajH8SdMaltNiV2qxr3KI7UavIy1fFRMlYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crwV1k8C; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298456bb53aso2287375ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764188590; x=1764793390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=crwV1k8CqAp6gsxDKUZASEZmUJv/e0e4Bqo8tTx2WisiU0a26ZpQ+Jv2jl4CIf2LVs
         2vjfNzp8WOB7240fiLAixlW+AlmCOGkk2EkFLy/uETp6jIUP/C76bj39u4WTgMXTq4fM
         u0AA+EiOqSs07QApsw1EJaO8cY5bT0+H7xzMfdvSWWh67QQQ5DApQz5DBuaipWCS7xY3
         LB4/CaiKrWD0NSjGQsPX2lY64WS2/LIN79U9NHhl6+JDZep3vq5P+7NCzCm2VZVvYa0v
         WrbUNHJuoN0LJvaUZua1ok+B6/ehsR1LHS35UIzw9RbzcTbvf9qmmYRVd2m5xI5vuXHk
         sA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188590; x=1764793390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=Z+V83R0iDex8Lloumti8fKWIAvV0whRwftKXxU8xs7qHZUQrMLwta6zt3FeZJ6WSWs
         aFp6TweJhXkgWGD07qgdFOcZuSGZzYta8qxBpuUTv+Uhy/2vWaEPZS0MwyXyHEWId4EY
         s4uHEqXWdYvn1JrOw9hNcZWpvW1U5YDBLpaUEEvUxssy5nhXwRRmzSovTSQlwBBhsvH0
         OHBN8G0faHgAk1AmLQ8MWxEC47N7brUphe4bC3SHO7bO1+RRyocxHwkujPF3cMoGIezG
         pNJqgKu8HmaFd9dbCo42pZZIGrqcigt6cc6iJAjiWFW3i6ILb0lepQGbe+Lc//ClHczO
         u4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWb8FuQErVaGVotEM1psjxTAEpHwJdNZGALuVXrea1y05LWYXzQoxve2ncdkZSGDGZVB2adJc32rPAx7dSSvBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLdDCnKEG4ey4bNFMqL4MXJ4dzGez+O//G3DwUcGlrTaur+Py
	DJ0peEZej68CfRNst/KAl/HTKb86XAoFgYeVGku7seJ1wAFXX4mkxAbT
X-Gm-Gg: ASbGncuFVnm7FPRyS4gcrWjGNrBSzPES6iiTKwotB7FBha0azVStBCrGYRxlnOTcw2M
	49vqMvdZl1eLve6ynWHnVkNeK7k+Gz34nxQuxaQQ9A37zwXon1pIY7kGN6aVT+fG2BKgXvbGvte
	bwUGVFjdSoHbIu4Cyq3u8qTsLLEP5VwRhl4bUwf4iLVSWVHc+qqM8lw5Y9YDGTULyz6/+jNy4iZ
	pFzIviZSDfkELewrQOivlZ29ktgCw0xHuCKj5kFoIxz30uFNa1cRt13ShV/WpyKpV2IKWzSRg+i
	cyynUFEvlZzvjAD1HhkUgYIMVfsXW58n4GJSBmEuEoiTxueBw4YPAT6o+4tElyakc1JDFKQe8R2
	PqNAbvamyW8iZRK4VLhRbf/rzMWobEQ3B0/EXtjhP97LI2M3VVSUV+R0jv8Emjng+vQgbRiLpG/
	mLeJggKSdQ52E0GzWHcg==
X-Google-Smtp-Source: AGHT+IGyvkmPXc4dmQLZ9+AKbI5kISLDRdVPiQNUOyHu8BG6Wb6Rsz1S8AiwQtQYbSVom1NHh9Ecag==
X-Received: by 2002:a17:902:cf4b:b0:295:7b8c:6611 with SMTP id d9443c01a7336-29b6c404112mr221821495ad.15.1764188589903;
        Wed, 26 Nov 2025 12:23:09 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a80csm207100475ad.35.2025.11.26.12.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:23:09 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 26 Nov 2025 20:22:53 +0000
Subject: [PATCH net-next v7 1/5] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-netcons-retrigger-v7-1-1d86dba83b1c@gmail.com>
References: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
In-Reply-To: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764188576; l=747;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=BLduFEel2At1ZpRoHzUB/43M6t0wpDLHJLh+eokOBeA=;
 b=N/tl4cJC3zNG2CcT6bNGU7DO0K7bXp3dQ9rmLvLGL+8EHWN+ZXe3VMhsqbqkBEvwrVHyX2X9S
 Mf2b6DrobN9CNil0c8d0pMT2wdWsaYn/k2umZ5vHEfUxsZf+6/qc62z
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9cb4dfc242f5..e2ec09f238a0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -119,6 +119,11 @@ enum sysdata_feature {
 	MAX_SYSDATA_ITEMS = 4,
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.52.0


