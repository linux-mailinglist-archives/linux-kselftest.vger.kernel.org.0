Return-Path: <linux-kselftest+bounces-49254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAFAD39453
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 12:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD6B6300462D
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E932A3DA;
	Sun, 18 Jan 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObtrVycN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90E62BE658
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734030; cv=none; b=UINsSSrUuqqKi7dgrmIiVP108G0pxbkh7HJPsQLysOVPHCRzlBnd0JCfih9CZx4g3stvXdUR4otjHkNscsUMIhmHifU1hmxCN2UPiTsrC8d/xQa+OanicG+ODGbmE7ocTGuJWY4qtTM/3EiiZegPC6sPs+ig8m2kqUjmPdyCyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734030; c=relaxed/simple;
	bh=xTW7lVbfJsgnlziO9m7HRTBaTgvYhjTEK5XGbQnoB3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Re3KDp5QLnctHa8VS6OEyO0hMauPDiCtX9Uz65Sm1ckW08EYsYyQsb8SV8dADq4uePdvKRqKPZfk5eklLJifbNZO1lMJIhjlgcJYG2+RGhN0OtVUMRMfjSKfFaJAWG9SnhL9IDTf+9chh1b+G9f0lKlvE+PWRdeuSku+N6KM+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObtrVycN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d2c96215so2803758f8f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 03:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734027; x=1769338827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=ObtrVycNhWQxpzGEbvfkl6t74RD+e5Xa8s5K+vzWrG4huyRSRM1lXj3b/5u6vP19Ot
         CBTCp1s/plfYmd/GqQ4VATWlw5vY9pxkoAxtPVLdXjkKrtR0bi8WqHS9wTLp/7NNp9J0
         86pbwEAhyxSBKmwwIelLMyVSgD6m/cba3ZbHM4zwfvsTd8fvCXzERn5T4loCldcyYWoL
         oojMehVHZiCZUDuZ9NbOwjdWSgSsyIOedMx7IN6CLUUUo9VG0h/5eBy6UwqvxBJe+QdI
         eri0BSPXaNiN/i/FWFuTR6nag9xTOBA93F5/ON7cfgVCAm4bqOJaaSV+7TjMKTnLV8SF
         9pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734027; x=1769338827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=mqv1u59r+fRAEIbwDC/Be/I0sfLBntfbW9F9vvLPTePBv9Xw2wRaNP+YrYHRUxKt68
         TiMVJqBriVDtAjUpkI0cFTOAwRRGEOJghhuMTKNn77Emhckizy1tL1dnWY64q/QfiJxK
         sPWGSKq3I+LJTLBfUPkOoJJW4TNbU740kPwUr/F80/e+XT8LgT7BanFCD+Vgl38JzBJA
         GwIAzpw+SfJIxRB9txlxY3+rJis2cIVSJ8itCsz5Zk1JtnCAAbkxrGxli5T+wSSfgAUW
         NmLp9DVI1RuvA2lTzcRyeV6GDjaqM5AtncdkK92CLOCpAxWafaaP5VhlwjLrJ3LndUI9
         B/6w==
X-Forwarded-Encrypted: i=1; AJvYcCV9vgeramshBzVnL+yezpDAbfuR4wir7Gi//YpW1PcbPX6TEzwV5NLKnHj27vuqY8HKfle7SlujjBMVcCd6DFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywlB4qjF3mwbUiSnGRtP+Wtmg9y00qb+Ed465nQNzpvgkbTtOX
	v9ZKfIQYP8Jw3uCrEKL6BXy0sIS498kXeTSDR92PRijnQMxLOf2XNZ1C
X-Gm-Gg: AY/fxX5qOACJKFsnHfqnAX1CbChr6udw+jb26AMQVF4d1iZI6+wfQgoKzqxR+9HmVfe
	rI2uYhGb7Q6xDT+YccgZ0jRYdRgESDiuFaKzxDfsrZSBEthk86yztLP5JeUNPyswaiBZzro8GAm
	WqzZWJ1pYG4XO1fydq/Z493TZvVS/2a3IQpCwDpjEUZfMK1aV9D/2R3U+GYO4c/lStflfS2uech
	JP522rq0VDQVGaszwfXwiwRCKbSE+J5bDGrPfnjgLZLZNHO3n1NZhixAMKvWv+h1hP0ZGdb16m1
	tEEa/Y+0wC4Lno4AX7ra9T2FA4HgM3v0IMV5dZylRTzsLp5aLNNvTJIU6ETKrveTBLCKPM+Jbq9
	pZ+p6h79tJgc/FeV1LDMZ3wtqG3OXVJQqLvwA8cUu0h6kdyJ1iweGlGyfQ6DBB7xBQQwnGzlZDd
	rQCeYBS6tADAPyMg==
X-Received: by 2002:a05:6000:2508:b0:42f:a025:92b3 with SMTP id ffacd0b85a97d-4356997f624mr9664336f8f.2.1768734027088;
        Sun, 18 Jan 2026 03:00:27 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:26 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 18 Jan 2026 11:00:21 +0000
Subject: [PATCH net-next v11 1/7] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-netcons-retrigger-v11-1-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=747;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=BLduFEel2At1ZpRoHzUB/43M6t0wpDLHJLh+eokOBeA=;
 b=EXwY2RlQfw+7R/YiOkF4CCoYwqRLJCiNBYIb5qg9mHzMZqxohK2PlhJhzFdz5dhoB5uLQcSEK
 721xCiHBkgnDeNXximlgcX9AUeO3WyGBjqH1bdaO9j7QdNj/9y9Rk/h
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


