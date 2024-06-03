Return-Path: <linux-kselftest+bounces-11099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F58D7EDD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 11:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE047289790
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 09:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D19129E95;
	Mon,  3 Jun 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afg+mk2v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A511129A7A;
	Mon,  3 Jun 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407046; cv=none; b=D2Bh+AIQVz8RxYqMLevBkx0ujO1m0TMAzdTo9QPa0bVtnoSo5MX4FJzZZ71QK2YHMXAJ7IdbMLDAO6aoEVq+O5IsPu1KBL+LanuKDUEQUtZYp9PwGjmERLTlKlNUJVAPcBRatNQO7DvLjcIRZR6EM543y3BGpJWr5sjKOunlLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407046; c=relaxed/simple;
	bh=PlGq7u0Y2WD+2rPxC0bqOy2yBbVouV51QHxitKWWfYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1ZRdZi63CBnWNOd6mKd1R6tqdkgtfUZLdZXHLrlYBbSRiwd2miihi8muIrFoWq2Ra80s6a5CbuyBXHWtuuUbss4yDOI4xth2RR4V/fdpqU1N5GEVIrgxGbmbZ6ttw2knmP57nfaxOheQjOCVgls2/gYQVMS5DaMQut32hK6jXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afg+mk2v; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c1b9152848so2697769a91.1;
        Mon, 03 Jun 2024 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717407044; x=1718011844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pTfg4W7hBCVeAcgxRuU+2sIqAsGnPVdsC6neRJn0WXo=;
        b=afg+mk2vaTpxEL6dIekCkJgKNAg+9hF/wdoLXv0fajDC6lttD5E4CsqoesSMzTWARR
         yNGBmZEyDjt7lib2/zxXcdMMu0i8OPmKBP8EKbZyzcUsuSct6ugYrbYvcyi6oefxCvKQ
         ETfGc/k+vQS6ENx9qMJw/etJpkqEceJhr4f1yIrBwKRtpPrzTpGikRo4L3vdhkC0/+bK
         N6y5xVw76djuaHdatrC+fNKcys6B9Ly9iUcsgH//RvsHXSuQLvDl5lycPPlH6E4nnNda
         4L9nrkZ2w0XlLP2qbSfMnodCFSDE+/d41n5B5kA9CO5l4jahc5PWz3twRkPzW4GlkZg3
         60JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407044; x=1718011844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTfg4W7hBCVeAcgxRuU+2sIqAsGnPVdsC6neRJn0WXo=;
        b=AKqPZUPNXt/W7HLPnJEwLcvmBAqXEULrTaOZ142vbaS1vCizlo2Ns2JJDt6S8cKY/m
         Pi6m+hL52G+RCZp6ULtJ+4+rw1Hb9kK0QMETr+JIiXT2ivQGVzx95rPx3ahSn16GtwA1
         lWn326Kuz4n/Q20z5XGmWByMBUBK3Nc2W18OETOOphvQGD0c7oKLZYPYBzlVr+j/kPnJ
         nTbIiRHBVZTDsJWN/jJYqStyJYCoG1QHG7EQ9AoyUW/dtme1qFRf30KpW/nuUwiomQKa
         Xw8Yf+3Adi9R79UmpvtULVX3Qwr/lmnmRA31KGdNr4OAIgaE+FMiHZrzYqe8Q9E7CaJn
         ou+w==
X-Forwarded-Encrypted: i=1; AJvYcCVYGtXM2pAEPbtn/CFIwD0beOyg26iSjQbhlb4mc2/Q5Dbt6pYwCEMSn9Lm2s57CgQjPqKckeM1RrSionJpB7LyPGcvg5+QJXXBrq/u57i6
X-Gm-Message-State: AOJu0YwLLENmSwwN2YsxxdnULRuiySp2jdQG910QA5niGUi2sZ0VsWAg
	ml1Com/44Wi1IDYdhbNYwUyuEVQet25VFakGa/CUQp7oQ7LRNDRoAGXL6eIcFdp3Og==
X-Google-Smtp-Source: AGHT+IHNshtVpxw2GSYIJLcmEx5FBtoZtIwmnPKolXjlWNGSHOkknjnUXczc8WB4BN7SMJLaAvFH9w==
X-Received: by 2002:a17:90a:d987:b0:2c1:a58a:1146 with SMTP id 98e67ed59e1d1-2c1dc560848mr6665451a91.4.1717407043812;
        Mon, 03 Jun 2024 02:30:43 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a777d2f9sm8000429a91.27.2024.06.03.02.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 02:30:43 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: hsr: add missing config for CONFIG_BRIDGE
Date: Mon,  3 Jun 2024 17:30:19 +0800
Message-ID: <20240603093019.2125266-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr_redbox.sh test need to create bridge for testing. Add the missing
config CONFIG_BRIDGE in config file.

Fixes: eafbf0574e05 ("test: hsr: Extend the hsr_redbox.sh to have more SAN devices connected")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/hsr/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/hsr/config b/tools/testing/selftests/net/hsr/config
index 22061204fb69..241542441c51 100644
--- a/tools/testing/selftests/net/hsr/config
+++ b/tools/testing/selftests/net/hsr/config
@@ -2,3 +2,4 @@ CONFIG_IPV6=y
 CONFIG_NET_SCH_NETEM=m
 CONFIG_HSR=y
 CONFIG_VETH=y
+CONFIG_BRIDGE=y
-- 
2.43.0


