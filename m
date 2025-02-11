Return-Path: <linux-kselftest+bounces-26306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC54A2FF9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355BD3A7BCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526FF1F1530;
	Tue, 11 Feb 2025 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EAKAP+gH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F81F12E3
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234504; cv=none; b=SYvrCoT41qYnDz6o9U2d5h9bDPBsWICFTcaR0NrWpLmDeUJTKfmjCVvnfRVk1/5YN1rPlOBTR1RlJAqdDIB5n9EKKIb0Vk+KVXRK5u6OHWlWIBGT2FeOqMdFjtO2nm2KiDsxE+kw2fQVVJtF+8hzZFsx3OPDieOc4iJdmXMjFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234504; c=relaxed/simple;
	bh=8xMoMq4/HmCsbbhmmUU+CjrB8VVYxxsj4UGn48mpUmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBJnzDTJej8Q5aRdnVJ7p2AiZU74gLfhAbLuLp8QUCgBj7dpBh3zUDJaTmsRhhI27jv06mzzgR+mRtw6ErMYRLvnpVe2aY4zoP9WGrrIv5ABz3wMUYeOajXHE27S4k+X+EoVnLcMQOQ+pQCRsFHDhIHa2Q4ouoehmw72F4kGb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EAKAP+gH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso34187405e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234500; x=1739839300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0H4op0ePLiNdUHXM7R2dSoMw+sTN1l4LiLoSsD6CY0o=;
        b=EAKAP+gHFnbMMSaAc4suj0odDs9wwUwRke7rSkY5idjAOB4lCgqDmWx4YEtmairfaS
         boGJwprgoyeoygwhK/EUACs/hHMRPI284N4n5RPg3S5UUu4edNWkdogW2sZ1jxYRrUTX
         18ufbME79A/vHkFokyaVEJYAucAlAj/04rEHc134zsAXRBfmCktLeyvI1bdLWDZ8Jy4u
         WnRbRPBse0BhJuFeQJHWBqb2IBM09MHOLKuyzMZpyVtiDu6SvSQgfxnSOZBHbEardpbe
         W56M7VdQlnnYwG5rfOzPp58/L3pMNPEvjOJbCgWniAowBy10I1YctVQpNA2gPEUQ/NH8
         Lmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234500; x=1739839300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H4op0ePLiNdUHXM7R2dSoMw+sTN1l4LiLoSsD6CY0o=;
        b=lUg8oIz1lltTq0FDxzJBvhjrt5GT/sp7igLCZSd7AsXHB42yNFMdC97MikL+LMgHrR
         m2dWsBZyqnaSwhoYezecQTezUSL/Vs2efnH3neL9Hmww/W7F9k+0/1ckYw0QuiDLoceP
         YF//rvR5+JFbHGCJIgf9YcsUZbAROc9QVAgf0EgLPbAZq7O8e0z/Y/ehV010scmnv+fc
         eQLyGObbTE8qnRzljfSxtG+Ow0jdibvzHzS18ZeJOMeYXrHzOpjk3R0TZ8kv//PGULHO
         XGb9oAC/gW47no5fWsdXNdKj/C+otb97yenwtkuM6sPEND767dbDg1WxCiC1VNa+zmTC
         uGGw==
X-Forwarded-Encrypted: i=1; AJvYcCWO1Z63mRf8c/Jk0CRLIxPTrd78UUhk/0bJukoFozQrN2XqAJcFyAKQyAOjsBG/NCVxzt4iaBZqdCZ4FXPTCyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbX/RNHOIGZWGMAq88P3ftY8vf3CKWAXedZTSMHHr3ZoyjY/k2
	d0O5mSt700pAqFBDwXCUUFs9uzMDFfd0DkxqLI0mwlAyBk4hUIP6MkN2+xhqijg=
X-Gm-Gg: ASbGncvWSfQYLXlI388FcQjCrLfh/QK7JE+raZdDEdSjZAKFSDTzzGIVyjyjB9qyNhe
	f2EgCDtyGWEC1sAwLSrZJEIPNOiNs/yI40h1akhhu0KcGuBBjtA+09bGNTgM3NunLmxDtwqGKcD
	X7Mx5DY22HvfxnLBxeu0WEW3CRXJsnt99dJy0f4LIIloxybNYOEkTs4iJpKSawPukA0o2qo3lD6
	qakpNlYOECkqtswBrJLyYeIslKCY9cHeOPXZ+7zR/AeeYP70hsq74U9Y0uqWtUIPPhBXLUUsdXT
	i/ltFYURIj0X2W10/FXc6JjgD7I=
X-Google-Smtp-Source: AGHT+IHjHENWeREsEhAJYoT3TQ2FFR8LSRFgAVO/2HRjTSK8uZkQIeJT/gCfk0HOYKp+KwyLvV3/jA==
X-Received: by 2002:a05:600c:1549:b0:434:f0df:a14 with SMTP id 5b1f17b1804b1-4392496ec4amr124415175e9.2.1739234499835;
        Mon, 10 Feb 2025 16:41:39 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:38 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:19 +0100
Subject: [PATCH net-next v19 26/26] mailmap: remove unwanted entry for
 Antonio Quartulli
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-26-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=8xMoMq4/HmCsbbhmmUU+CjrB8VVYxxsj4UGn48mpUmA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyPvVsBe5Cp3g3R9CiRk7YQ+2PHwNnzZlA1Q
 0pnAm9TrPSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjwAKCRALcOU6oDjV
 h0aWCAC5uaeXlErFy1AmTjZtoAcj6luKEQPtxVbrLDJsiviSBdiwut1GgVdTkBDCil4TEcwZom9
 jOCIdcc9Ht7m3jWSRLxy5doFfUq71IVnVIRMOux/JzLd1chD3WBtZsX0ygKE03TMyM28kJjDrzX
 fx5V9/rHYb3aNjqZI1VEfNtBDxMWOrmd7Cot92HOOtzs6B3UZOlzU2zUfK1ESIeOASPlMAYR5Al
 h7ufHlD67uFoa1abb9kgLFHR9rdyIij8NFXiqmksKnYU+CRfUJMN73QaQg4PWJInRiFtb/tDqiK
 eS60/cTK1Fg7hSyJDYeHXQQkwrJaQAOIYfBJ9qHv17feug3Q
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

antonio@openvpn.net is still used for sending
patches under the OpenVPN Inc. umbrella, therefore this
address should not be re-mapped.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 .mailmap | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index ae0adc499f4acba5b6220762c1beccceeb5e8ddf..9877cf1ebf5480b80bbb9df73e1096147fb256a4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -88,7 +88,6 @@ Antonio Quartulli <antonio@mandelbit.com> <antonio@open-mesh.com>
 Antonio Quartulli <antonio@mandelbit.com> <antonio.quartulli@open-mesh.com>
 Antonio Quartulli <antonio@mandelbit.com> <ordex@autistici.org>
 Antonio Quartulli <antonio@mandelbit.com> <ordex@ritirata.org>
-Antonio Quartulli <antonio@mandelbit.com> <antonio@openvpn.net>
 Antonio Quartulli <antonio@mandelbit.com> <a@unstable.cc>
 Anup Patel <anup@brainfault.org> <anup.patel@wdc.com>
 Archit Taneja <archit@ti.com>

-- 
2.45.3


