Return-Path: <linux-kselftest+bounces-34840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8509AD7BC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7C41883DA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9B2E1729;
	Thu, 12 Jun 2025 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keS+JI32"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AD2E0B73;
	Thu, 12 Jun 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758596; cv=none; b=svINsYeh156TvHlewtvUat4gXGJObK7b8wtP45F9f6g50LfRWIfgKBW9rLgdrQv4Bt96hxp0iXiRfHrfxN39LFNkHgnCVbWAw8ufriyiUImDxK6yphFwt9MgPFVECxpKqmgPAyI4joUe4FYnJffsGXP8+eWOasamJ07ZYtGzXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758596; c=relaxed/simple;
	bh=p94oIFo4jUglnAhbc3gfVf3Xl1s0WKJ0t3PNRYqQRvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzTuRWggctzloCILkr+B2gCAulAugMYk0yG2jSU9M6qlYnuTUap0yi6mL8rtlpYqo8OhFeM+EWWI+E/JTpmkHvOTQ+Quqacyj3Y/Sd2TxuiYVfszPPIcb8KSCWiPrqoE/GU6L0YD/LHdNOkEvIV8YcG5pdPLJFX+teCooKSr+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keS+JI32; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-48b7747f971so1513301cf.3;
        Thu, 12 Jun 2025 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749758594; x=1750363394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqK4XVmf88e+UTUicEUcYEEd52VK5FIFk2p//V1IESs=;
        b=keS+JI32l9TQ8njvXDiHqu+5MxZq81deZkT8Kc8/8CpDfx6EQ3nmW4V5TukVNjOG6g
         UFVeKh3RctIw0Ami27xVyBbCH+6gCO8hT3pNMT9Z3SXom9kN9g/Zft7sn7wND2gwulcA
         +knRN+r2c7JrMVRlcZzNOVrr2QahTCrdixsQkaQsHTe7muf8mpguVzUZA+LvMpracJ+F
         PeePpxAxljGsEPybzedKlunfbFDN2JuD6a2QVmyXR9s08uSO0g6cj80bWQEDCdiycgEp
         cNiQRzX+rxHoXMbn/zL9I8xVU/RVhMw1kvoAYUPtdqbHu8hVrKnjwGJxVP3GzSt4YzGz
         AEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758594; x=1750363394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqK4XVmf88e+UTUicEUcYEEd52VK5FIFk2p//V1IESs=;
        b=LuWCMlJtCo8kg0wyhAJRfu1FNs63hgraV4SdY+VzKManiU9f3VAz9LhTGqu+NG7O1+
         9kmRZprSU317+7doxFcr91SKjzicLB7t8i23yTEtSWv/Z+CB4S4uoCqgS1nGPZn5zWy2
         A0hvumPtM2fnUhFEEMTjj9LHEgy02/+enxnzTILa8d9qqKHc0/6chClnWSLh4+4g80Tp
         Tp6zghTVSnj0u4wdrKl02FkrbX2Iq6pd/ndXoxdgsgF1mAYIm4l+TwlUvPotoS4McApf
         c4Av4Gb9zO8rrIUPUvTEQMbIO81b0of3SBqNbF4Tihob5yMxI77CHe6LSjgTsmAl0l6x
         8JMw==
X-Forwarded-Encrypted: i=1; AJvYcCVkmNiFaPoJzGt541P0DGZpqyzuROlEVgAdHE/VYkZ744LZMcioM7zp4W90yXnYv1EL4Pf9xa7lApc=@vger.kernel.org, AJvYcCVwzbuNM2jx+11ANkP1zm9osmzmcpYfLNKRdoFSG1VEbwMHx67F2Hoj/7BPaQM30ABDZ/Wr3HTNCxd18IhaUjuh@vger.kernel.org, AJvYcCWPJCoY0UG0ptVbHNIJuBVlIgpu/aRnAbCexr5RErjB0INCE9zCZtBr3CUUNTNOmjWSbs0jWKm0eoZTjZNz@vger.kernel.org
X-Gm-Message-State: AOJu0YwTI0ev4ZZleUW9V1em597olyNZh6tAgkUeXDEwoK9iveg+3TH9
	N+Eo+DSSGL5tZTavH4xSsIfUod0nPBMLQxoeiDEbugsKCrsMjezhZmsr
X-Gm-Gg: ASbGncu6wg5oDF8hSDZ+KoMw3XigD2Y8RRxUDO5Je8CfOlgSS8rZo8M3IeE7L9RIVgI
	/eGWB+Pzv89mLEHdzLYvclGf8q8fxSm+bN9rB7qJldiirGnWVD5OPsge50u92a11hLFNNAicgqO
	cZ7b7eUxxuKqJIF+FQaREitVMr1NSodOuC58+8E705HpYgphuyS+1a8c8GW4zGnmz1qGBbqWhAk
	OmWSvYy+8kU+1V+rSAZdbwAH1jxYIs+v33hDGD9Gf/K6KkoEfIOHPC67/yc20EOCNhSU/IUQ8lt
	DHWFJzcBdodpGCYRr3UJkddisJ/Laim5NnAxw+PwrqDF/uzwG6AhZnY=
X-Google-Smtp-Source: AGHT+IHaJ8YHfWK3ymwJNH+TEVoQLf7B7caofHWGb4f5nJ1C2jtwl17bBUz8ImIy+guO+S4h4KW2tA==
X-Received: by 2002:a05:6214:f29:b0:6fa:ed8e:372c with SMTP id 6a1803df08f44-6fb3e5fc540mr1071226d6.1.1749758594031;
        Thu, 12 Jun 2025 13:03:14 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b20f67sm13696456d6.16.2025.06.12.13.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:03:13 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 12 Jun 2025 13:02:14 -0700
Subject: [PATCH net-next v2 1/5] netconsole: introduce 'msgid' as a new
 sysdata field
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-netconsole-msgid-v2-1-d4c1abc84bac@gmail.com>
References: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
In-Reply-To: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

This adds a new sysdata field to enable assigning a per-target unique id
to each message sent to that target. This id can later be appended as
part of sysdata, allowing targets to detect dropped netconsole messages.
Update count_extradata_entries() to take the new field into account.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1eb678e07dd0..5f8c8c6c5393 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -113,6 +113,8 @@ enum sysdata_feature {
 	SYSDATA_TASKNAME = BIT(1),
 	/* Kernel release/version as part of sysdata */
 	SYSDATA_RELEASE = BIT(2),
+	/* Include a per-target message ID as part of sysdata */
+	SYSDATA_MSGID = BIT(3),
 };
 
 /**
@@ -782,6 +784,8 @@ static size_t count_extradata_entries(struct netconsole_target *nt)
 		entries += 1;
 	if (nt->sysdata_fields & SYSDATA_RELEASE)
 		entries += 1;
+	if (nt->sysdata_fields & SYSDATA_MSGID)
+		entries += 1;
 
 	return entries;
 }

-- 
2.47.1


