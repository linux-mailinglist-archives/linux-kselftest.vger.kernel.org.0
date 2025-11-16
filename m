Return-Path: <linux-kselftest+bounces-45702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E97C6190B
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 18:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A32DD291B1
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275630F7F7;
	Sun, 16 Nov 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6o68pa2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9B30F547
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313256; cv=none; b=stIsvZdTdxSl2Eil1R1FjPhaPndlyBJ252l/gk0xh67mi3NytGuxOyBEfvxa3DkfdW1I0ePEiqX3kNSJQ5/mrolgqox+l7I12ePZgUvSxnYdJsapF35sE5v+1ENaWheoBO5gJuQdAE+uwFlGAInfZLffUI323Gey6iKRfIOm8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313256; c=relaxed/simple;
	bh=0a6Z9vm59vHUX3M3EDlQdpNuJbepNNHLaFpEBjgVj1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQzS01ZsKNa2OBaB8q05+Tm6L01sk3PdZA+DTEm6mO9nOMgJ8ZwNpSvtD1iXGOWB8NTrraD9f7rwsiZUklBlbha8p/JPfLbooOGSsItW+CcqrAzUfwewdery6+dxw3HW0bbuClowKcZRzLYf937/jDmaulBDvTFochZkMVNKK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6o68pa2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477549b3082so29408985e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763313253; x=1763918053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMuZ/D7eDR+K5SfJd8pIttc4xM0fYqKI56Vw1YxCazE=;
        b=c6o68pa21r1uHzylALiS8pNz8OR+WIGlq8ElAx1D7Dq9f80uIprYApa4teOqssRBXr
         jGsdOcUUk5LzD6JVHmdz5zpByrAfBC81mbkCHYr3K5rZIZy6+6llkW+4rkZeVbhaIAR1
         oVjivLiUuQyoPApPlyU9UKsxTv3hNrVmc8QxsbV1exoe7GgHemZYLxiN0kBEIrqB3ver
         57LrcXXf6XItsGOerGHbRiwFI26hdWUYaYkcWq4q6fDOEZDcS+qoOwXLHYN0euLSflI7
         idw/lMYRub2XtbQlizzofo2EYePpha8eobcPZEGGvDgmOJvgXU9j2Q0mpx1A3DhZ2Az3
         sOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763313253; x=1763918053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UMuZ/D7eDR+K5SfJd8pIttc4xM0fYqKI56Vw1YxCazE=;
        b=P5Bh3Z7A7pJZFxYZ/C+FEaaQxGjgFY6j1j2UuWB/NckOAH4WboyF737G2dg0xHv24v
         TSKSDNVCKYvTLjXHV3nCKOAFwp7naqIOiwKFgTsp+DgT6Ssho37y4PdakeZcvQo5Q2oj
         2v0bCwT9z6rNrxbOuamWe5KkCDb80QRn7S+w4PGwiaEdbcaN0qd9Aum8p16BGxxe9MCE
         jkTrDvU/v1zbHtPBnP6aC2A22m1yIT9s4VCfVy6u5fwMQVAd39qoPwoyKl8HfyNHvWHd
         hNWPgl7xjJwVMFof6bL/qw5yn0cqnNg2aI4Da3GOX9WUBTDAjZPsdj6GVgfQ9CySUTOW
         Ox9g==
X-Forwarded-Encrypted: i=1; AJvYcCUvxGm/WyHym2PyOffSFtQrLnzB7btwOn9ZaFBQ3FAZ3a+t9CmUaTk1RXVvX5QVVJbMwq71vDmD5cur/I9cr8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym34lKzbUip6G6KPsyCta09x/SNB7HDIEj8sxCInt6WkhaexAW
	uw2hRkR794gXDHNUd9yYBks84eMgXVjg5uEP4u3XiEg9Sr25Cfz9c0Il
X-Gm-Gg: ASbGnctrX4EuOln2MlLQHo6eBRF3YutHEpfmdw9EwGQbLEy9i0oKBBsJt/D7NLgEnUo
	TWVid1Y3YwJXX19QOhVrUIK+/8+e0ANdGQodspz50IGwfQSTR1Do/mtEaz05vh3P4pG42/gV9AI
	dqKQIw+hiDBCU1MWED3RTDcL+pHHidG4WCQfcva8dSwBdDXYQe+izt4lQPSIltACLeymYrxJZK6
	xD/gVDKwGnypxKU5uyHBXA9Ed3kww6BSAoj6kbI26Zz9uiEuKrhH+XdzgWqCJp4Upo3qcflgOt4
	EHxq6E+uxNOUBoVJVt5UbZEe1lXThkhsU0l8dCPQdxYellW1UoEQbSU+Q10o3BV6QOd7H2wAEXD
	03S9jjy5RKFbptw31z9inJHn13zNSDqqCVG5yDeMtHB0glugNisL9a1oHP7FVEYX/Cg1I6VNJ5v
	OGhbvnIGIeBffTo9hNmzI1jkItYQ==
X-Google-Smtp-Source: AGHT+IGaJQSbBg0scRQwoqpO2LnoYwBbyvoHjgTiaDQttepFJp4lo5T1z5/q8/Xfbyh821BznglVig==
X-Received: by 2002:a05:600c:4f53:b0:477:8985:4038 with SMTP id 5b1f17b1804b1-4778fe5e5a9mr78657905e9.13.1763313252898;
        Sun, 16 Nov 2025 09:14:12 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779d722bc5sm70874245e9.2.2025.11.16.09.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:14:10 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 16 Nov 2025 17:14:01 +0000
Subject: [PATCH net-next v4 1/5] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-netcons-retrigger-v4-1-5290b5f140c2@gmail.com>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
In-Reply-To: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763313249; l=748;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Po4s941eMErBwuDFYeqR/VDMArYoBzjcjN8/MMT+h9s=;
 b=q+6VDeBUQHVy3dWpDvJ30vnZYXdn7u5NFIRd54++VPhR5zv6KTt5T1MEp26o/RFR75bRC7rdq
 IB1wCnVXItMBWQhdvB1/vDBQR30aOgsS7Xjkd3cOa0rWOGgJhl4tBHR
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


