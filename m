Return-Path: <linux-kselftest+bounces-20476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46C9ACF47
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10CCCB287BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E122C1CF5DD;
	Wed, 23 Oct 2024 15:44:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D551CEEB5;
	Wed, 23 Oct 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698253; cv=none; b=lNllSQ5K8nvmUu/A1W8N2pLQsiBtwAH9YlcYiuomBQYcI8wzjhb4s+SEq9cEYTP13tGZvPZPuHNTdXUw4cvhni0SsvBE8D6sq6UVwtrJ9XZ5x2NxfbE8ZCkx6wjFHKV73Ci3QAArbjfeha4cpXvvW06jg+e8jM7Ku1V/m7dh5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698253; c=relaxed/simple;
	bh=Ie/Ptsq9qO1ESENyDMOnFQ6N1E2e+FpWUSYWB06bdOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVr0ouWVRx00FHjuRt2NvZa1goUDUtxjTMZUAi7qoVOcV4IqSb+4KZ4mWGkbv3NK/L03TQJH0aZJaoJmSCqwQFbFoCr2laiNQ/RWVL1rLw/7u1GZzg4DBo1do6RCabShcsdsYxTD7uZAYcxY8p54efkBgg88Xux1xxnElbNnFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so703a91.1;
        Wed, 23 Oct 2024 08:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698251; x=1730303051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RMY5HztPWF4NWuW1QBTHPrJP1v43bJinxEr3M4sUnA=;
        b=AsWmB2bai8D7Bgl7NXtvCehMecWwe5nX+GB0+JaZWuf4L9hniZb7eBWybfo8LiomWC
         wMtI3SvkJK+89B/WUfHbz12CKuBKqXBroJd2iaClX2ep3977XYVZ1brb0B+gSf1TyU3V
         cTMYpPWKSDm0IUIULsgZDYFZHvX6RFClMbSIBmj6OrXnOG8PdvTU36BIU+R7plvFWYm5
         z+ttKiNJFlhOAvtdYUOeeJNQ7bgE1jhlkL/8SUMe0mOBxl8AWh91c6r7+1DWvsj/nwbc
         pt7galRitvto5CwJ0ai9BulMoZOxfUQfQ2A/axywYUtpu+OGPYFvFAxgDrZqJM1HexmP
         zwTA==
X-Forwarded-Encrypted: i=1; AJvYcCWatheJT2duY5ew1krqPTMaHwcNcv9Rsi70W/cIa9V4KxOi4HwiujMOQ7yMw6IIjULeAOzfGXlPjBshWo8=@vger.kernel.org, AJvYcCWrXE5UTNYLoPvgFwie5bsPHGolbUWJxFTeiM5Vdoik//RWUv2EirJSok3PFDtsRPnZOyng8rzBYpiVf+GJ7PkC@vger.kernel.org
X-Gm-Message-State: AOJu0YyYacp687dumcCi+RUEdBowPRm6a94odjT6drwSSj791cxxOxkh
	mXUc5JLPZr2TtICPhX1dGjt6V7G1p6VHj7ZZqOXx6iLyNLnlB5vlP8CKxts=
X-Google-Smtp-Source: AGHT+IH0UN+JvitaWu3wC6MXLlA89MMB40sRPCiJu+ypghT9t0AYB7k5P7v7OsnfPV5RUjhJKk1niQ==
X-Received: by 2002:a17:90b:4a44:b0:2e2:de72:2b76 with SMTP id 98e67ed59e1d1-2e76b5e0390mr3012412a91.16.1729698251476;
        Wed, 23 Oct 2024 08:44:11 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df6fdd0sm1589133a91.28.2024.10.23.08.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:11 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v5 07/12] selftests: ncdevmem: Properly reset flow steering
Date: Wed, 23 Oct 2024 08:43:57 -0700
Message-ID: <20241023154402.441510-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023154402.441510-1-sdf@fomichev.me>
References: <20241023154402.441510-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntuple off/on might be not enough to do it on all NICs.
Add a bunch of shell crap to explicitly remove the rules.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 8e4a0fe74bb1..697771c1f9fa 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -217,13 +217,18 @@ void validate_buffer(void *line, size_t size)
 
 static int reset_flow_steering(void)
 {
-	int ret = 0;
-
-	ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
-	if (ret)
-		return ret;
-
-	return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	/* Depending on the NIC, toggling ntuple off and on might not
+	 * be allowed. Additionally, attempting to delete existing filters
+	 * will fail if no filters are present. Therefore, do not enforce
+	 * the exit status.
+	 */
+
+	run_command("sudo ethtool -K %s ntuple off >&2", ifname);
+	run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	run_command(
+		"sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
+		ifname, ifname);
+	return 0;
 }
 
 static int configure_headersplit(bool on)
-- 
2.47.0


