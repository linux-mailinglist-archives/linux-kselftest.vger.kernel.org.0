Return-Path: <linux-kselftest+bounces-34729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CCAD58F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DE216F969
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB232BD587;
	Wed, 11 Jun 2025 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8yGJ529"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEE2E611B;
	Wed, 11 Jun 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652670; cv=none; b=AkM3cyYVxpDsx5Tplv2xbwfirvML8Yc16qfl1vkTEEM5hcuqi2U6LIXPEoc1MkPN3vVRzvfUlCrRy/xWyO7u4e29QPW1HUYi/m5pY4U9DbY+e6yeKl7db1aK1SnWvJUPNCuX3LtiWHaE9YYWy1ewLAcVeqzrr2vFqgtloAkISf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652670; c=relaxed/simple;
	bh=JYJreZkOHHz79z5ZTMlVk20LPBbeJoc475yWOc1bu+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxQC6u91UTe+HE2RdrgPgP6amdcXC72eeYwrkVFIDBLoW0+4yTwGP8J3Z33sttLnrBidtUvHC+VvJqqtyskDaqboleTdrVIxt37SyqmcpLAKqrcKqi6PnI8rBbFIoNPXmarN8DZ6TJ1j8Y0+9JClUJfErNmfLy8n5TEaoSSVIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8yGJ529; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a43e5c2b1aso382521cf.2;
        Wed, 11 Jun 2025 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749652667; x=1750257467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AXukWCQuh8tn2wAnl2VEUgBuzOqFWDlGEpyKe2E7R0=;
        b=S8yGJ529iwrQVPnKrGVoprooSmxtR/HdaSzaHG0b9Ou9Dfe1OmSwEE6kzreVh8w8/M
         BG+vL608c+/kh93oyOSiw51/MWJZSs3E1Y5LJCiqb3AEavNvZBhdNjJxrs7PSbxvjDRI
         fjHUos7JJhVw4G3YQ8AB7wDEh+9H95B4GdK6ByE28lYqqVQoYJL4KEEGGd5ErcY7jDMu
         RflCbVD04oZdkERiJ1RyY5sL1ieXccICjetPdaLaA5Le8r+GaDvBoHbr0OrNFdYhGV1O
         600NkW3LVf9jnmsa8oddU+xhsx30ZX1T9QmJncOnzqow5xhugPoMor9YOs+yC8q61GaF
         WO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652667; x=1750257467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AXukWCQuh8tn2wAnl2VEUgBuzOqFWDlGEpyKe2E7R0=;
        b=fBmEY515RJR3XHRveqWWKSa7h/zFrbFgWSiYRRgjcuNGAV1CRQHIEfPfrgxOKaXtbA
         +JD9pO/9omFHSZmEOFjx45m9eBTfeJPBAkgSvgvqHfUmMb9aUJrAl6NszHYb53vdXtYJ
         U+PBIsDGYjs5t8kXlcZyYad7er49Jn9lon8x4ssBejfWdLu19jU6QubyxH2jAqmb6hg/
         HSTLCVOD79xhlzxkBS2FIVpvFiNY7MRTMYoa5kDB1zjHnRVYKtshnOa4sNepMeQQjcJ1
         SwQaZ2IR94BYx5lk53zKx14qWcym2f+a07zBY4Kjn/1/Il3LH5++SSkbmRDnzEb5k4/u
         shMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3hpTVKpJJi9n5adsmRebLQD7nVuP6vc2hbcoUfB7vHasbMU2oRAdSr+dVQG5wwDRIDWM/4qzyK34=@vger.kernel.org, AJvYcCWoPtwVJ3XmbmCCWEfwBO9Bp7aohsSuXP8baZ30M8P4+2uaFwjD5WLIxwjTaEUAqi5ADbgxsbeO7sCQmb7GgXZI@vger.kernel.org, AJvYcCXPB6O71+kY//67cZNhk+PF/MNY9YRfiNpRlPLEfWVNvMS9J1gIiGCSxdwqFeSfskkWSCnn7pz0EWNgABa1@vger.kernel.org
X-Gm-Message-State: AOJu0YyhB+7joZ6nS2FbMk4VJIsRLsaYIdlrm90VZU9+5HICTIEFYXkD
	bPVYaBWhQGQZPLTHhTTysiG/zJFlG/8T2DykngeKmdzyd6FCGGlKSM4QPLmoZTHKv2o=
X-Gm-Gg: ASbGncs08xQL3orkp+qyMqM5TEFpZUg4sWOrvV5ENjyUv/hG4pz9hc8MI/wszoChFNj
	S40aBt8eT668hQkk9445CFq+A+haiF05ago3OkSNWitVy5k4KJcSVHVK2wO4w4bsFVk9SgXbLKd
	fYopLTdvQprjAYOj7WyZYuM4Ev36YM/Gp6/sQPKF6cZKn/Ufv3MXOnLdbkVMGEjk905FDIxlUFe
	O9m64xbWPvOJU0Oam7KbzAYEuRXwZCXGj6HOQTS74+4K30PC9fv63mloforCFDvOoVwLfYex1gU
	ys3a477XlSH3m6kdJS9Dasv4DZx5loGaU/9CCiSfPoPKFb3jPOcY5oQL
X-Google-Smtp-Source: AGHT+IFzDewi+CU4QnYgkImp6inn5D5dtRpYExd+TsbaYLkrlP7RSuEX5tDLjdtYuzc7CnEGrP+qKQ==
X-Received: by 2002:a05:622a:1a24:b0:4a5:a4ad:c55b with SMTP id d75a77b69052e-4a713c5ec60mr20160221cf.12.1749652667485;
        Wed, 11 Jun 2025 07:37:47 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:71::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a6f7a786a3sm56838381cf.81.2025.06.11.07.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:37:46 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 11 Jun 2025 07:36:05 -0700
Subject: [PATCH net-next 3/5] netconsole: append msgid to sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-netconsole-msgid-v1-3-1784a51feb1e@gmail.com>
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

Add msgcounter to the netconsole_target struct to generate message IDs.
If the msgid_enabled attribute is true, increment msgcounter and append
msgid=<msgcounter> to sysdata buffer before sending the message.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 813f50abaf9f..34b61e299eeb 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -155,6 +155,8 @@ struct netconsole_target {
 	size_t			userdata_length;
 	/* bit-wise with sysdata_feature bits */
 	u32			sysdata_fields;
+	/* protected by target_list_lock */
+	u32			msgcounter;
 #endif
 	struct netconsole_target_stats stats;
 	bool			enabled;
@@ -1345,13 +1347,21 @@ static int sysdata_append_release(struct netconsole_target *nt, int offset)
 			 init_utsname()->release);
 }
 
+static int sysdata_append_msgid(struct netconsole_target *nt, int offset)
+{
+	nt->msgcounter++;
+	return scnprintf(&nt->extradata_complete[offset],
+			 MAX_EXTRADATA_ENTRY_LEN, " msgid=%u\n",
+			 nt->msgcounter);
+}
+
 /*
  * prepare_extradata - append sysdata at extradata_complete in runtime
  * @nt: target to send message to
  */
 static int prepare_extradata(struct netconsole_target *nt)
 {
-	u32 fields = SYSDATA_CPU_NR | SYSDATA_TASKNAME;
+	u32 fields = SYSDATA_CPU_NR | SYSDATA_TASKNAME | SYSDATA_MSGID;
 	int extradata_len;
 
 	/* userdata was appended when configfs write helper was called
@@ -1368,6 +1378,8 @@ static int prepare_extradata(struct netconsole_target *nt)
 		extradata_len += sysdata_append_taskname(nt, extradata_len);
 	if (nt->sysdata_fields & SYSDATA_RELEASE)
 		extradata_len += sysdata_append_release(nt, extradata_len);
+	if (nt->sysdata_fields & SYSDATA_MSGID)
+		extradata_len += sysdata_append_msgid(nt, extradata_len);
 
 	WARN_ON_ONCE(extradata_len >
 		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);

-- 
2.47.1


