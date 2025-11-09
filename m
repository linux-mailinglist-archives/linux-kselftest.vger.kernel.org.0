Return-Path: <linux-kselftest+bounces-45193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C756AC43C4C
	for <lists+linux-kselftest@lfdr.de>; Sun, 09 Nov 2025 12:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8733B1FF3
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Nov 2025 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0D2DAFD7;
	Sun,  9 Nov 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSqDLK7q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12042C0F97
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Nov 2025 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686379; cv=none; b=ty5NK5ReN5sAfdUUUltp5r9g4UJSBe/CbuVbNWNoe8w30wwt/Ra47lxih/gp2hDlYIjpZJog7xiKUgX1JgERkSAge1/x9FzTUkxxR/wwh3F/cRSOlc++ZM+m5rH99b6mMM7R3h5tTNSQmui+KqwgWNMHgHo77P0goeAhOjzxCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686379; c=relaxed/simple;
	bh=0a6Z9vm59vHUX3M3EDlQdpNuJbepNNHLaFpEBjgVj1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAPCGoFFMcsiR9zd56oTK6/B0FeG0GOezEq/vf9kBDidUo7j6eoY4fcTT27Repmw/NsASLQm4SS2KmjYVIfGDgpLIB93VT0rZTlx+JYNQdvupF9CUC9aLjfdXd7oYm64a+XA6W3N800JQ9Qd984PvOJcr9swwL1PY77DRdHcOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSqDLK7q; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429b7ba208eso1119623f8f.1
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Nov 2025 03:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686376; x=1763291176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMuZ/D7eDR+K5SfJd8pIttc4xM0fYqKI56Vw1YxCazE=;
        b=PSqDLK7q+7+x9cpznSyDTJYm/t3Yj7KXUS4bZcNOwy1Z9zFvLA6GgVQynuuveJrA8I
         8viCBBc9foVP7X4unSNMkfnnvKdwq8EfGv2P3HANFP+UffL5knxtRgkoZdbFykK3KK9b
         zFIIUjkdIgwCdgr7n5PXqs7TZn6ZxS0X5SOhQZ8eB5YfUkmj7Sv+jK27/1kH9ltqPRfM
         d88jd1laeyzm5CeXpfSU1sX+fUbg14UpE8zl1hRABqbP0llFUdhakHIOPxwq6QbLcSOQ
         dElBK4fdGwJAix8+ohmIurRoOSaF37ZAFS5reVyrfy6Zr46t5oQ8peozu/0fTeCeAKs/
         Y38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686376; x=1763291176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UMuZ/D7eDR+K5SfJd8pIttc4xM0fYqKI56Vw1YxCazE=;
        b=lxBXBMBvywO7DJvdIA6waDaaTX68vO4tolOWykNTcpLs6P6uWlOTrGPGMoyq+wCfV+
         oT+5aCaJ0jL/1ehvCl2lg7YSsvIEa0z6aaWmUXuxgNxarGng7rg+13sTuyFGwR0alMbY
         l0Cwcw59oGFznFjdmwUAKrWvlT21PKOCLfku17iaEYEH30uxY8sbJswWFPtZ5g98lxwi
         SqnxM9SIdkYAYWeSyGnR5MsAXgXzGHmJWnpb9TlwNizfKWqrYlbmsCTWKSm0RVNkGDKB
         JCV2qxSXlAAgMdU3WuV+oeWBV/TqpwkxfIByTagB3bvuW1aTiLuc/Y+RYJOdFuMxFO1Q
         p1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXhWjw/hBdKvSZHvL0iAizkTYC0b36DVq3VuJ/Lx4f4k2VQeZ/Xvz2Q+GpbCITMB1TjTLijV+IxA+8F0rRHN90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/q+dh7tR5h7rEjnaQbNrA1p3PGJVmWcHJaH/cB/oYxbvyLWQ6
	uR0Umx+FTPDKgrw98LCLAl8Alrb/rnWiaUhY89QG8yZ63xgiVSf7xinU
X-Gm-Gg: ASbGncuz1fhylUL4X160cnsDyGOcdLKQ/rajge/lITsQPil70sZmwX+2G3DnMeNkG6K
	UT0xOH7MrqI4Qv0Xlko1Ttez1V9inf93mEfwpSXrh0/TqFyEEa4pSVpLjJ0mTaW9sWQGebd3Flh
	djy3rYQEqgVoSQcWEtkbCf/2PcFN7mGkNkimkhf2srVvAp0rCoaAC2MMZchKcH7tgZBFO1LgFjI
	dSI9ZfclzAi5jxTWhR/ZeOKbk/ATdrAnFQxlwVVWCYwV+XRzvoca60DqqQ02xJsJqcxD/r/XpPP
	QBV7/NICE+keqqVbNoKWc3LW3xVuxUKBDMknUVuJrgzIo4Y6iO9FoCLGAYi7t8EhiwEPSZE9wWn
	wbPaPNbombaMguMTlLXBNg2dkg/VoyCofHjWeWBC9oNfh00sclP861048ljrPOCPC5ZvaLhkaSE
	PJggqc91yWOHfUk2E=
X-Google-Smtp-Source: AGHT+IHFhjADorg/ZR5107ihIL53sgAhlpAdhqkAU05FL/iFU41EOoPQsS82Rvhk2qa66vEBuFTWSA==
X-Received: by 2002:a05:6000:2f86:b0:42b:2a41:f2e with SMTP id ffacd0b85a97d-42b2dbefcfcmr3776049f8f.23.1762686375742;
        Sun, 09 Nov 2025 03:06:15 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:15 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 09 Nov 2025 11:05:51 +0000
Subject: [PATCH net-next v3 1/6] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-netcons-retrigger-v3-1-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=748;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Po4s941eMErBwuDFYeqR/VDMArYoBzjcjN8/MMT+h9s=;
 b=Dob/xrKXJfj0d4xZnl+MCY/sthJswm5B+vonAmQ2jJUC40wOI+WQMq9EY9UZP0OdSo/OqAzvi
 sGBHZfFAmgpACXKkgVcqacoh5HiO2KkyE2FaVqEAiOjeUmhl2PYJVn7
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
index bb6e03a92956..7a7eba041e23 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -117,6 +117,11 @@ enum sysdata_feature {
 	SYSDATA_MSGID = BIT(3),
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
2.51.2


