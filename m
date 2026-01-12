Return-Path: <linux-kselftest+bounces-48725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF28D118F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0DE030C4794
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2734B1A2;
	Mon, 12 Jan 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcmupVpG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21434AAF4
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210872; cv=none; b=LWAlr3U1ptHZMF5CIqsz3r00OPi+9FgiScXszvnFu7NdN+UHGLOeVAvsv5VMqCSA72IIlh7dvCZ77jRkz5yTf80P0Iy/1887mLrthaKdtIs2h5Cmw3u3bgM1zuV0H8wOYJqz0Upv/sX4mWBaMlxInAHeX/htArTGesP/OwwPbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210872; c=relaxed/simple;
	bh=xTW7lVbfJsgnlziO9m7HRTBaTgvYhjTEK5XGbQnoB3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRRE34piNtsnDfwe1gu1r/F4mps2gZcP6q4A1C/RDgXEJ3IY1fOTOXVfTzMxpgD4HrsZ25E0RbPXHM7i4NNOWpVlbSEkIdg5C2Tp19887CtMLuszsjy8/ecAanyJpNmGmd3KJMrLIJgGVouhH+Xaw4gaRiJYbel6yhitlMNP8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcmupVpG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso890475466b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 01:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210866; x=1768815666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=NcmupVpG3yUfEuJKyC4J5XzkgvOgSSQf0JE37JAzRCly2NVPEEjO1rxZTyr700XIXy
         CrHAuqTeAuwkQTfYdESbaXR82qnroBYGpfIKBcTcJmwuicEQ6PEyiF6SDtMWeu7DpmEt
         M/RfdExvYfpV+egXLxIh2VMUXKFp2io4r/Tqeb9KRRsbGRkcTFGwKSwCbLPZUi7AJ11U
         8EYfvpw3UazwgJ8DGVLwom47h7Pc6nM8k3ARp++vmhNZ3X7rs0vqcVavlPN6nHO9XL1G
         85caFPqPTNa6Cdj5M9QNQ9yaH7tR/7fPUTKhkziQSSfqq89iBEtcN/93RddXWKPw963X
         /lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210866; x=1768815666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=VRhfpqfJi5WhkB7gfcCLvYb6/3M51rMzS0Dhm52Dk1gdZLKQkxSe+u06u7nWzYinen
         AP/FbHSllvKDwCRpIyeudGW6zlH0HUPT1TX1teJzemV0yjctFvv4ECHloHGCHiMU+rsO
         u5l51XAjJs+/QdWtv8Rvahvsw56w3d/nGDNu3w27OIU9aRH7morGZp+w0dU9Oz1jtiOK
         eYSjGH8j8pYBPf3gyHLVTd7PmqtPk6M4q1IIpJz6BJnxvz0vV14ypFTY/ewvuOlpm3nU
         l3SRDulT+n+zQn99qrgfdfVKu6ChVvzLGyorQOvaHRaSWkk/VVHl/v5w0WXE728ILclD
         YRMw==
X-Forwarded-Encrypted: i=1; AJvYcCWo1q0zKWBbqRxyaTYdntn/Bd8awtxIYOwr0a86ub9BjsOQUGADhnEnoIb97OdXTt7rqEcAZQ0WiVkwG8oNpm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxShWQm2jWbEOIPVJw6JDRH13XaOeWwN/pJ6f+bELHvRmxUXCKd
	nv5qQdlxgOMuu9jMfYstXyYwH3jkxINEEqKXMzEbNj4Bf2cR9OcmSPXY
X-Gm-Gg: AY/fxX6w4LxgiSQz8aw07fVXrvGbGb5mv42VCDog8IbKm6keNTeXHp5mELaFASRO2UG
	BYkQVX7VeiSOXKd5elcmjGMd8ycPhQ3JGMTPKjzPlE508CtD/XEtoHZNegMf83jHOb4W+t02LeF
	Upk4IXz5vIyX7s2u6Ip2ThC2YFpoxDzjY72Yg6DtBM7QU8ZTcKpdVegxmsZwySCdDXh/KiP1KLS
	AwNVC1Wnl2wNXMaEHdlUeVphZGaMrXueVvdV9RLfi/AAFmmphmAdJ98+YUctWgMsgZ1zwZxYUh/
	+FMERoLNLDEkVjRht5baBIc/HEM0X0aivX9CfZSMJ/pe0fKyGMhu2p/dfUuPi7nPQlaky6RTiLf
	l3ZrRZ330FKbHajvGQH7qF8+8GbRIPzUEN62sCjT8ZnssoY0qANpynph3mXeX1aSdRvR6mZwMwc
	dXyS5x7a0booQudA==
X-Google-Smtp-Source: AGHT+IGsuYYlcfIswN483on6lkd9zrTHj3Op5tXVtbRnccE6HxdH76+tt4k/Vdc/GSDG184bF4lJPA==
X-Received: by 2002:a17:907:728f:b0:b87:2410:594d with SMTP id a640c23a62f3a-b8724105abfmr146400666b.49.1768210865520;
        Mon, 12 Jan 2026 01:41:05 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:04 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 12 Jan 2026 09:40:52 +0000
Subject: [PATCH net-next v10 1/7] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-netcons-retrigger-v10-1-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
In-Reply-To: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=747;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=BLduFEel2At1ZpRoHzUB/43M6t0wpDLHJLh+eokOBeA=;
 b=E0UQ3fv0rAx5q3iuk18b+VTRGt7svBbjpNHMgaJhnnV4zqLBiCrOV1pfmsu/PHSsEapXoewqN
 EHd4Be1TvTFBumN0KwyYPfZw0Mdw97XjNmlsgGi7WHQjAcON97+XOoj
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


