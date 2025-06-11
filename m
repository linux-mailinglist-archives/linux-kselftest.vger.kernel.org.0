Return-Path: <linux-kselftest+bounces-34727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7174AD58ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788187A9308
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2254A2749C5;
	Wed, 11 Jun 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjXd2Ngk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852891865FA;
	Wed, 11 Jun 2025 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652660; cv=none; b=KA6n0RB+jb5icUvjT1ff4PnePlgxCi6F13Z6KJnlxS4S02ZD5nvmog0G4ZMLxgJ4Bq2PnxSzcleSJ9iUl6oMNVW6H3fW3z1cuLzWXy0CF20I2KPbp2/FP1lHvP4ndU05BaqtWLOgpYfP8IpHFwBzN6Qatysgd1Bh/nuBxvgsf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652660; c=relaxed/simple;
	bh=l+T5ZhzNUucEtcBwYebsvbIy6IaT4jf/3TtvPE2rO/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLvE0Bc2MhkWufTjT8lFvdn6kFOl2ULof796TZgiRh0MKz1fXducgorBYW9DEBllX6wdeKEaO96HTT9BS9kDWNetIH1vMeuhVeRClfbnRlovuuX7umlvWdmaoSOx6oIYsS8ESS6MxASPQnxys62XBVkklIl68iEN7QTD1ETax1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjXd2Ngk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d0a5ac00aaso12959585a.3;
        Wed, 11 Jun 2025 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749652657; x=1750257457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYnwybKCqEHQVsPm8x/SvQihwGROCOX4dUeuWu4RKaU=;
        b=QjXd2Ngk0G2i2DL7psCcC6b6nvT2LFIC72Ix+0wZp7UOGIysB09BF5q7gE3TIKY6q/
         P7qIxPhIkxzlCp3gOZNPC8KQp9UWDh463oEzcGjze4/G13Zp0NJpvTw3iOQOWC+gXrVq
         f/M7TQ9UoABCSTCda5TNcp+NG4vL1b+nbYkRNA8wti9EAXAMQ4wihcwd8nz56p+WyYoi
         j7i6UQAuIaLQ8uWK8wINq3WU3yvVQ/X0HU8NXNwUsQ4jxk/C7GIOSug6UTmT1ULknbi4
         WG9KyYFM2tdc7E52ZRMz+P7vf0j+ojB9yvzTmz9+MONgkyMFjYH8FuSEarkzW+ZfO6cc
         SFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652657; x=1750257457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYnwybKCqEHQVsPm8x/SvQihwGROCOX4dUeuWu4RKaU=;
        b=I6Y2EjNBNFvwcm7wOv/cdSQhA9x0hxxh1NmxNLDc01a/1JgpG6v7M4maVy9VPJckAi
         6/JQ1HQArYkajpaoGXdi+/991U+l5SnJKoYKr7COpxCePOaS1yoE9BQWkwzypa3EhIFR
         /nK3AgTQCwfqrrd634CIwYOLfziDpFAOJLa+NNuzqKZMsXrYZQlF39nNu8cxRY/ezyr/
         H3fnkRxEgNVMzasrkfAKKso0OnRu5yQDGSxMdUyahEbLJ/c0iCXuQoWrwlPAORc1WpjH
         cwS6wSekvGJ8oNbZbSc3JgOgKXDx8zb4f/uBq8oIUiw9PMEW6KY50gr1Yc8qmzOVPZHj
         k5nw==
X-Forwarded-Encrypted: i=1; AJvYcCVzeRnmX/F2ssEurEwIw+S4Z2XpLP7p9WmOwatGe3kqnOOgA1AN6BSvWTsYMx255E0hi+Haz4UsKUHz17vW@vger.kernel.org, AJvYcCW3fWL8clZtJGRAIfQ9jxorwfAsnoL5CMD1mLTJnwqAfwBZXr0K/+y24wuOPqPwcl/9yplfxhBhr+s=@vger.kernel.org, AJvYcCXjF8jIRYbCWESXoROFG8fE1MyiCSTGV1ToWxIVRdKw9X+ZtiJ0NWy0i9gjlaG7frZIHed9gwavNkX2odYMmBvP@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRT12A+UdzYz91aupvrdDIhD9KtUrxDJ3UWaG/B7UMCSN1fho
	y6kHe0dFiVuc7ja/V4RhYSd+8xBH2/a32Pz6as+geF0JsPVwolPr2JIuXUU4m3QNhYc=
X-Gm-Gg: ASbGncvpXNXylCk+GkQ2L0YrZgDjgA6P3hoWhu4s8NWNaIG+r+kbKn1BvKuFO3/GfXu
	8XyGagHwe5Y08MN4/sqLx6MY8E5siNKQrKcSAgSK2oeJJh5WypvwpKjV1I1qYeZ4gIsbEfIpOYc
	fGLlzSkhvGbZLENHWhcB3qzKgx50D9tKpAk22kNKrmEh0zFD+K33yKyPTQfY9u6yNOxltasu4in
	ASNtpid3RGGJCqLD2DNQf7jqG15xthSGcGGUiYbTcWNd94GkXIAzsA5HLObU6OHpj+zi2r/adOA
	EaL5vXVqfe4VWAPHY9BeP0Ni9vyDOdQlYtr2pFv40ne5EKy22ncvitdP
X-Google-Smtp-Source: AGHT+IGmxDOEBxXiNTnrWWFc27mEmo6BZIx4ubp2n281p1VAtAi7M13sbshETP3POiK4gC7uA3x/8Q==
X-Received: by 2002:a05:620a:4514:b0:7c5:8f36:fbeb with SMTP id af79cd13be357-7d3a884260amr183598685a.12.1749652656727;
        Wed, 11 Jun 2025 07:37:36 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:71::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d250e70898sm861571885a.20.2025.06.11.07.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:37:36 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 11 Jun 2025 07:36:03 -0700
Subject: [PATCH net-next 1/5] netconsole: introduce 'msgid' as a new
 sysdata field
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-netconsole-msgid-v1-1-1784a51feb1e@gmail.com>
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
In-Reply-To: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
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

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 21077aff061c..787d170c3a0b 100644
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


