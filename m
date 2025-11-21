Return-Path: <linux-kselftest+bounces-46225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0302CC79110
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 13:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15B0A4EC8CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16544333437;
	Fri, 21 Nov 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuSyy081"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947512FE05F
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729364; cv=none; b=hpPIs6A9qZXb5LaXicuaa2WXQcCORpIyH8DF80oz8JWJQsdrQlHAg1Yq9E6SW4OP20csEcBy94mSnoANeRtNtCfMsiCZY59DjNKOV+qkdz1y12h6wcZpJkMcN/zPrL86Y2VJ/hwYd9U5Ipo7Xnrbd6ki2mRSRfAVSQqhDGLZta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729364; c=relaxed/simple;
	bh=xTW7lVbfJsgnlziO9m7HRTBaTgvYhjTEK5XGbQnoB3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYp5WgfIVgYTsEFviBQx7VgR41zbjUN+ga2tqBVXCm+mUV2ZH484nUYgqmolOynQ0nlK6z+ua1WOBWZw0g4rigdOJXFBwYRG7iVrHbCzZSYdyISFW6VQM2J9TTnsl03/jUofSgRpqrbsmK4Fxb3aUxzsGSgBkDPfygh0mJGoMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuSyy081; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2984dfae0acso30745075ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 04:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763729361; x=1764334161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=SuSyy081RDHOKYo9u3icd9+cCB4iEvbdDcMvZGeOEWRBNJ0FL/GOaViCx4/AJOQrzX
         VQvcdps3MO7lw53crA0CudtCHlZ1f8r0CrVc4IGKfmwsmooZJzZ7PYSPF8ErlvRTR5rC
         xN6DEO2mC9DIod9kN9zpI+HJQbCQbQ/RqWdMbRwjXimF7a9scy4pvu/zTesFhlOMHYNq
         zilws2IYLnlBnA7A3KjO9vGciegwen1mYv9Q0wBnuuMQGAGpIi1w8U3orHrJEqJabUF7
         GNC3t3exv9EtL1WaiLp698RTCYIZIjIMPJDr0M1ta9HfKi+SbEzPzcBzmM/ctSXJpYOC
         p6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729361; x=1764334161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=M7g6k+GAXKmjy0LQQztqYSnhT6BaUy1UYwwv5TPM8HJmUCRK3FBqBD4mb+a+gOL/wa
         Ke27wL5LTibDgNxXzNnuM7w9Ov8oteokBHYkFdXtsATuHGfWMnf7onEX52lBdxJdEYTG
         TpMWN5U2XpZNIgEBDX7dOXq69vQTBT4HKeLRfIfH4T1BxEPUQSIs5blGJAcUHkhRTzAO
         6gSREmEkDQaL733NyzeIAYAxO0MomIpsI9GGNRZBQERRqtu/zI7IXCwV06LaWFLd9g8V
         FANimgaHxeqWWWRqfWDpVZlcWSNKC+BiTK8RhuEuuwUoPvE772b24AZyL0ELtMA0Wxkh
         HBRA==
X-Forwarded-Encrypted: i=1; AJvYcCUhvWqNbLZkv5QxavlyRlLvI7yyzLQM1RTOmhAd56Cug3so8yDPRUmIyVYGfu+2xOYaFikwE0BYaw88zrBzfx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwRMLXjf47QdbSEol6Us21W7yb1wbTENfJ23ChjjNpcv/3xag
	j7CsukMPHRJ/4cwlvBiZZrBqV9C3B/+efG5Tg5unRUKQDT3mvQsU9eev
X-Gm-Gg: ASbGncttAqRuL//EQrVZeW8pnMztzWTDn06IKXNm2KPv9i11QDuknVm+o7h1dPdRXYm
	Xs+VjqUBu9ncp2ghB4YN7pZKvxYVY79gIW0V1+TaH/PokFB5Nunp1ZIqc6wjyzyuMNnU24wjBDt
	roXrUq7EfqEtb1XRUFkqIAfcftWAoxqy7Z0sW+vu/rMNEoWQ3pzB6IoO7Jun97Zy4JNdr3qp0xq
	5MtFSWkWXyjUMVMwvJZ+PCl3jdsv2Box4KYO7G4Kj0LJnSfon8zMojnLvIxlbxjJGeRPFtLcWP4
	9unhiyHQG6ShhO3YTAZVRvOPCC5arn2cQOwvnS/b4xV+wCmpAYAtLHJ8iB8cjOQMI+nhD156wmd
	rZ3Ve9wiqVTH7AH08c/N9Z1untwON0193o87TkXddq4xU7T50obCBZ05eP76is4aTnXdCK6dY7b
	aDETyrkI2WmQysfmOT
X-Google-Smtp-Source: AGHT+IGADjPBSv6dneXmHvy/d7ImNW4K6lxe2fy+G/Ozmk9OtVRsRVjcF0a8edFY+XOXLca6s+ACgQ==
X-Received: by 2002:a17:903:2c06:b0:297:fc22:3a9f with SMTP id d9443c01a7336-29b6bf19f1dmr29423045ad.38.1763729360830;
        Fri, 21 Nov 2025 04:49:20 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm56644045ad.75.2025.11.21.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:49:20 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 21 Nov 2025 12:49:00 +0000
Subject: [PATCH net-next v6 1/5] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-netcons-retrigger-v6-1-9c03f5a2bd6f@gmail.com>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
In-Reply-To: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763729347; l=747;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=BLduFEel2At1ZpRoHzUB/43M6t0wpDLHJLh+eokOBeA=;
 b=i5LMsfARwRqneqwPou9ysaSmPXgBprcP+Cdxs4zWJpbgkFhrfOS1RNzxP4zJ9iujoEomejMWo
 TKx/4fNVTYbDBn+xFqIHIFbB4/zBHsT8jC7e3G5y4sHcD3GQNroRnUP
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


