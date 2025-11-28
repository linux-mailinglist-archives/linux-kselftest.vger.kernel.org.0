Return-Path: <linux-kselftest+bounces-46703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1396C9339B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 23:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148583AD33E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9572E7BB5;
	Fri, 28 Nov 2025 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw56JsIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652C2E764E
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367699; cv=none; b=N1bRUdICaZEiEpNAMSnJcvE41NI1Y+5/Cej7vylbJCMatxQl1E5MZV5cdSnssxCocARw0VnGLSeWUEvk+8SuH45Ul3wOxzUGrsinkluAwavIFBYh4TwoP36Vlb/m/1jjHmYrkteBGMKKbuZci0Y09FnjOth7YvK5zlu5ap/umHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367699; c=relaxed/simple;
	bh=xTW7lVbfJsgnlziO9m7HRTBaTgvYhjTEK5XGbQnoB3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMl2WRDYnX1RXnXEKzvQpCsCv97CMUQyDLEJanaeRc20thg8Y60Tl8ymKcfwAkBByVq87NDC0MlfJr/lrE05s/oHbGNd+6BGZcuX6kyXqXT5yjVTuRg+YS2kcH1h5n07K8TmWLlwXohGrU+9Mhs0QmxyAVfWuDAVknkt7Qb3msM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw56JsIU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b9387df58cso3743272b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 14:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764367697; x=1764972497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=lw56JsIUvRfUzKE1d5p1NT9t5PT3FOx5kpDVfPjqP7xZgiO5K62KGeii5dJzuciG3q
         4Jd37AqbQKcEYCM+/B5QIAwoQGJKockq8hmzTqpdakqsrEnlc2vXiSEqX7r1YHbDWLU3
         UEvzBByZRG76sJEbrU3wtqYB1Tc+8eFxDjarVOjF/5PEsYIVtS1FiD38SyMTJ1q3njoe
         ObuNwFWi29D/thUpWr/fMFkFJKjRzLhHLkh/h/xroww8RE5jb8nr3moi4Z9PQID3U15z
         zjc4XnwLGQJsKQ0VYCRKuiKZerb4jkQpAH2xGFmHSOTOBcxkKHqL3KDzwWMrlGcsyJeH
         SV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764367697; x=1764972497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=ikv5L9H+0RZAm4lYyDCfJ9J65xnV/vDTIDLCxewn5S58AiJnFdaorCAxugrfuR5WsP
         AQ/VRvAvtNzKpiQjkefx+NRfaYlKuBffMVgB0aPl9gPYTz+WGJvGT03ErAB0K+ayrOuy
         amJ5gAayjLyk8SJO5OoKbKYfEhTuf9aiRLXs5AbtX06gnvGQ+EhKmyjf1MvkXWNK+Cjw
         OHh5AB23UkTaQY1ytuE185nF5/QHcdlEClZjiTs0j5ioh2tETxZcLaXJQhEonkt3P/8B
         oohxtvTPAtpo7Md0x+yEBkf7YHn2jAxijF6VSgaTUkhPxfOiYzJ1mQbPX0yendwWNYpZ
         Ycxg==
X-Forwarded-Encrypted: i=1; AJvYcCUdPqLezq3H2Jt3/dmhmvStW3QqKtEqnCtEca/mXuqMTgDilLN9n7DFWeL6ig8jwt5aM+omXkKR2akiBhQJITE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6r9T4iL3KjCy2nOyl1rwCrZG1PkFHhl0u9Ggj/nN3QZiHQaYX
	N2JDhMW9QD6+pCciH4PrrydSfwO6WV34EUpDEDuioCGb9LKjCGn92Aeo
X-Gm-Gg: ASbGnctuIQZp+/0GoOsLAwnh5mSPjkF1YH1BomMyfnFJZzRXvQZFuulZMcSm9fbl4eB
	Kjce4l8Moof4hP/NFOrU2bBkxSKrqAIbRqNanaXWMHtBAIvKSSSPU6AB5/d89pM2elykKZPRQi+
	946ypQkt6Ax2O8WXFv6Y2g9UlUqaVCaz1ZT3pHqv8bRRYL6+hr2EooC3nwM+4UQFGxrhBnNFVS3
	2kCa6o2m1s7x/1aG9ubIpxnS0nZEMLvNzmtQnEKa5Oy/wkn/cpKb52hPJBRjTk5tr4Ht0EawYiW
	bsGQqzMzGcyAo7nlTw/iE8/B+BVerGPnuUzU6TU37DoJ/LoJERmk/7HPDp6n0wnEDZuwDcC9vez
	0L7FdwsjZ1CjS1tEmS+tXsaHmHbfkeF/1IdGBl2EBA/s+inx+SQKPKU+gAsFKpPoclp9Hz3HqTW
	unhn2Q0MWStIaxlv1zLUdUZwCsOAPD
X-Google-Smtp-Source: AGHT+IG96Ew3wIHjHCSFXG9Xfo5v4F9/EYogTuGNipjIquk4InZHh8U4hQ73L9WUMm2Wlf1t2d5moA==
X-Received: by 2002:a05:7023:a8c:b0:11b:9386:7ecc with SMTP id a92af1059eb24-11cbba4d5camr10969807c88.41.1764367697082;
        Fri, 28 Nov 2025 14:08:17 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm26824205c88.3.2025.11.28.14.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 14:08:16 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 28 Nov 2025 22:08:00 +0000
Subject: [PATCH net-next v8 1/5] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-netcons-retrigger-v8-1-0bccbf4c6385@gmail.com>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
In-Reply-To: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764367687; l=747;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=BLduFEel2At1ZpRoHzUB/43M6t0wpDLHJLh+eokOBeA=;
 b=OIwF8snp4GEFauU1eSsb5+HvWSBdPkP2AKY060QPoCIQ7XBogHbro5wfv+xHyX55HsWfAML6f
 AiOvBn4hEymBD92Ca9fBwjontME3X+tV4w+vxvBaULW90eNoORn+H+m
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


