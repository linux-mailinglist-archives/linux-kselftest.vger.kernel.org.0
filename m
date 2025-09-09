Return-Path: <linux-kselftest+bounces-41070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2EEB507E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F66B4E4B29
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923825D540;
	Tue,  9 Sep 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYjPMnwK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907425A62E;
	Tue,  9 Sep 2025 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452369; cv=none; b=qfLO5K07eUrbnaClDPvmvy3bd2lKz55+ZhtmfMcpC/Qhsb3TaAiVbV0Sx24CqbHKTQ5cKZfotHhRR8WFvJz+PSLksslP8d47Aib/nvB5txCZyo+TpznSj7qfX7TR8Kr+VE/gE0BzRykftJuMKcOFZ4Ylilyr4kn94mSHPhLKlaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452369; c=relaxed/simple;
	bh=5mhr6jsCmNwNcnFO+5SOJs2r7HZGP3JEvC2ipj5IjA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzYrtC3bSASn1pvWT9hZO9QS6ADzujpd7HoPUGbnFq4ljPx2UDWFtdDbqynYrFNDRDYXmYXmD0EzQU3SWm5O6yT6rU37XkPpV9FnC71NgsecQ6oc/TNrFfGYNZQTVHaTnEOOwimG/yMcsTDzGQeWUgdoYSQkwD5K0Pu/SRi9blo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYjPMnwK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso6231147e87.1;
        Tue, 09 Sep 2025 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757452366; x=1758057166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIdf/p+W7Ujz2zhxctFos5mKw5BeHeIDmEYf9Zo81XM=;
        b=SYjPMnwK682ZuA2TcnyPLms77IfgjBOpZZRuab/IdwxmcOiDzhM1+0Nsi4tFWEQ38p
         /RLUZa2CuGK9qtHWXFfftIWgKHbMxjvvmrkJfEry6Q+or1XvsX2ebPhbWCtpjU5hYEog
         +BeP7k+X1+pqXET85jhGR2uRA3n/sJhavgchQ8TN1xvKLwPGVKG4HbMRTYDiaqL7Y7es
         V2PLAB4gpZr39D9BBfWpbO+IZH0RKZq5hsrhflQ2BDeBIDX6KPZRspCvHPZvyP/LNJmI
         v45jOAMqJ0rvTXHl9YG7Tbx+5ejshPsDixpeEfJuJgq8QmfEvMk8M7hsDih1gsHGdsuf
         JoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452366; x=1758057166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIdf/p+W7Ujz2zhxctFos5mKw5BeHeIDmEYf9Zo81XM=;
        b=xHLw+xE4buBIxTIZCkplp6xBBJdADcSlaZPU6p+G7GmyYFQOI7DW95VqtNWYAo0DTG
         Q1U6Fve7vS04pqggP93Iyp6u9aSJfVwlTmzC7/I2hzCg4+Ebg3KaLKoVHZNVX682E4Um
         DDC/NCKYQaUrRJpIPEKKEeusM48zJCUpJWuSrybDwKvkJPiHgLpX2WA6BKL5vDbJE01E
         7CARw9Yz28b/vbWSV4PTn5y2ozZBfIeWH8N+6PzpvccggnXzT7Fuzd8AbzSTA/HvUSqN
         ExmhjdWah+ZUcRiHmQfPAWICPCDBcq/rL+sfaoHeQ5IS/YhVbkjqEoC5y71+jIFI4mlV
         oQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh2O+y5XKINbeENo18fg1QjW/ndIjdTkURYBBMRcbb5FtT7wS0QKI6dLAe/VAo2LP5KvJxakOmPzF86YI=@vger.kernel.org, AJvYcCXSdjFimwlh6sBH2dV2LbyBkrVUNmDC4eg+MTToccHDh0FthVAKsAVkWkrlSiEZd2fIAgZBpuJe3Jq4CkFQ3SCM@vger.kernel.org
X-Gm-Message-State: AOJu0YzMaik/826w3GTNnlFNSmhC8UNU72OxGuQsN5KT+Y2VuV0fHspG
	KQPDzemF4i45OCnjh4quxbPxX173mUTpcbL4zmU/UBLhkw9viYzG+LXo
X-Gm-Gg: ASbGnctTapnAFdCF9KmUKbA/f8VrTU8UcNfQgDgL7xmsQV4JxxR57o+7Z+eTuOD89xn
	ml1KZjon18eV47E0Gmri1aqGcTM//vFMuNLpI4ZaLY7qn3y/y1Xoiz6hoF9LXb8oHQBnTC3E3kG
	bqo4YYR1++u6gCp3R/9dYAsgQ8DY44GEBaoZL++2n20XoableTn6lBZQNuvm8wLSVXQQ5tQCHRy
	Fm686yUZLCqhLLQG+W6V6JfBk+Jd5wcXYDr5i7Sd6S6UtaoXRr5DLmZ/VniPGrS4fgtTTl+d7Z9
	U4Qe0AGw2UKSUz9IH2O+Y0ds0/+A1bmO91D3hjKmk5i6xi7/lZ2HWyOyDosw9odAg40peFOEKEl
	50YS3cxYuTOtp56iUD5FGXz9e9p0=
X-Google-Smtp-Source: AGHT+IGkS8M26oiTUzvMr7ORIYYPv/MeKzCIZU5cLq+2zoMS0nEwouvNC7V9RVhOpu4yqOc0tVYHvA==
X-Received: by 2002:a05:6512:3b0c:b0:55f:63ef:b2bc with SMTP id 2adb3069b0e04-562603a1050mr4195005e87.8.1757452365319;
        Tue, 09 Sep 2025 14:12:45 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fc9sm757025e87.9.2025.09.09.14.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:12:44 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Tue, 09 Sep 2025 22:12:14 +0100
Subject: [PATCH net-next 3/5] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-netcons-retrigger-v1-3-3aea904926cf@gmail.com>
References: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
In-Reply-To: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757452359; l=2084;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=WsXzbr4oh2tgdkoPqzROUayYBAGNEehpMnq5WhfJccU=;
 b=vpgDxwm731pl/VFL86I19YSmMCpS/grtOYL8otH5BwuOPXYutjtSvN4NzDi//Eo+clm+XKdzV
 MmGITkIhGMPDLPu7a7hSnbQJQ0LWZ/8lVhV5TPmnutO2yAd85PfOPAD
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.
Mark the device that is down due to  NETDEV_UNREGISTER as
STATE_DEACTIVATED, this, should be the same as STATE_DISABLED from
a code perspective.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 688ed670b37b56ab4a03d43fb3de94ca0e6a8360..59d770bb4baa5f9616b10c0dfb39ed45a4eb7710 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -120,6 +120,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -575,6 +576,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1446,7 +1455,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				nt->state = STATE_DISABLED;
+				nt->state = STATE_DEACTIVATED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
 			}

-- 
2.51.0


