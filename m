Return-Path: <linux-kselftest+bounces-15125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A302194E2EB
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 22:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DD62812E9
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3C15C126;
	Sun, 11 Aug 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1sF8JtE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77779F4;
	Sun, 11 Aug 2024 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407825; cv=none; b=hPjMINtem2FrurnytgjlvRiLJU2G106PpeEkFeyY2RF8A6cyJCuvagjxehFlKiD5BDQouC+VgExytvYtlDjP3vPnAVdy9GdysYAkYjcR6BJN4DyuaytPfBeOFd3wuxuzJKf//gJBBNlwbBsO4KyUOe85ZOHteELoG3UshS2AbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407825; c=relaxed/simple;
	bh=7UbzMqn/P9kgJRH81QXhgErFr6m0LrMun0mPR0+6Ip4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YbDO6dzXHVaXZct8dmxafAv+vsMVB+wHq4tkuMLQHpBY2e/9uHiDEAal8/F2KE37fxTpKqurtXZE/WjUsFEGrCVBgT8Ou8jbD+xebPUhVb/8uUpoN+KMVWUNAmUDO5ujC0bptI0qYdvBimFbjbEJYSD2/6x5GjNw4J+rQzAJoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1sF8JtE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-368633ca4ffso509273f8f.0;
        Sun, 11 Aug 2024 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723407822; x=1724012622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r+rOAiVcYu0OekMmJdCAnb7U0kqUoqJSFUrEDUQgd4=;
        b=i1sF8JtE6UatZ3SMtBVCEHK7Abv1DH+gN2TtuLC+nUjd5V/JqkDe7W77oV/4kS4Dco
         SstBftF4XWMCKfu6+FFDvtJOPa+V3bVD1MtSEzjzlIzrVYvCLiGUIyNByn+gA6hN+jEs
         p9IL9JrLtthEAekGi/6gsYRnuAD1g0tVeOzkZuh2nSRx7ZKfg6UiI928bN8HLaGmywbT
         W7q59FfjOYGCttV+vJfVyQFoKWuFra63Pr+fegwH6UPZn1ceS3d1HOuYHVroPlpyLTBP
         5iLnGtOgAW4p7rCrhP7eWBWFHt3m9fRjYFPi9aVrjnHlqJnnl2lBXRJPrce8FZRARDIj
         +P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407822; x=1724012622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+r+rOAiVcYu0OekMmJdCAnb7U0kqUoqJSFUrEDUQgd4=;
        b=AjZxsAEV02qUUmWof1c30aJNUfAMSh559Renr7O8YxbfBn+0FhAnIy4gYZfcnjXJSX
         nqniRx/M4PnaKzHvGRGSkLmcnkSv9VV6QKa8xRxLmE3UeSIfqM76HZcYttNdGxEdtwkc
         NZkRPz1OyXN1texs6PwSrPrDh7GINPRJSJ0H0IGwghAtaY5lE+m2JnB5dR/qwGXb62cq
         S9CXHp27Efh7zBuWjtJBjBc5HPRDScYXVT39ACQyv63it9Cun4hCC5b0/JFhFyB/w3jn
         WSvmkT3SQGJ8QXwOS8DKc2pTL0LbGAZQe72jKFATmSSGb0293pgNKphET5yOhWHx571h
         vz6w==
X-Forwarded-Encrypted: i=1; AJvYcCU3SOZInr/YXybCEg3FX1ZCoAkGEj/4j4PBQDEcK4XtIACtCFs+pSLT3edyt/gTIMyu5w1v3tWpqsA=@vger.kernel.org, AJvYcCUdZvXM9JdI/k0SOFhTpxS4APsFk2g0ja4bqZOjIiWcEgLrvUXOeQvn/CrppCmm+cAydgt+xu+pvaX0DQ0=@vger.kernel.org, AJvYcCWMf1XOHuduqxFVrK6zyKuC4EH57dTOtuycOY1NJgtCRpThYQSQ+EBxsy9d4fzcfx11u1/luXFSE6mpsvlD+T25@vger.kernel.org, AJvYcCWXNlnEqOSyfOmKmmskXImFmQq2xR13XUBVNGGoFovFdAjDKJxOQs40eYeUxv/Pmp+q5G44r5sq5pZRju3D@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAIP5Dqgk+XrEmF+IcnklQ58Lz9e8QJRgKKGktkseHLcxp1Io
	SQGfkcxyQrlwxhc+ISgq7+zmxtjqFpwz+KIYMdCiQcCtKEDOaoLL
X-Google-Smtp-Source: AGHT+IEaRmfmFhDWnCK+2JdPo8oJwlUyNCONMYOPdBpDiq+VJiS4mTF9itrMJvDqNBsCB0bDyrD7rg==
X-Received: by 2002:a5d:6d8e:0:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-36d60a1eac6mr3500830f8f.8.1723407822080;
        Sun, 11 Aug 2024 13:23:42 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:24a1:28fd:3a06:5636])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd31edsm5553305f8f.98.2024.08.11.13.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:23:41 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	shuah@kernel.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	aholzinger@gmx.de
Subject: [PATCH v4 1/4] ALSA: aloop: Allow using global timers
Date: Sun, 11 Aug 2024 21:23:34 +0100
Message-Id: <20240811202337.48381-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811202337.48381-1-ivan.orlov0322@gmail.com>
References: <20240811202337.48381-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow using global timers as a timer source when card id is equal to -1
in the timer_source parameter.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- No changes
V2 -> V3:
- No changes
V3 -> V4:
- No changes

 sound/drivers/aloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index d6dd4b8c750a..a1e5e7fe9c72 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1130,6 +1130,8 @@ static int loopback_parse_timer_id(const char *str,
 			}
 		}
 	}
+	if (card_idx == -1)
+		tid->dev_class = SNDRV_TIMER_CLASS_GLOBAL;
 	if (!err && tid) {
 		tid->card = card_idx;
 		tid->device = dev;
-- 
2.34.1


