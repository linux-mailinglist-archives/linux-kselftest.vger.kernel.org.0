Return-Path: <linux-kselftest+bounces-30320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B17A7EFFE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 23:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70903167653
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77C21C173;
	Mon,  7 Apr 2025 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eh9ot0F3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8671EF39B
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063026; cv=none; b=REns6SICDsXMmZ0yYv7truQoBhDbuME67GXMAJhcheLH9EobnastMAX+6fZuV7+bUMW/8XacB0Y93TRAlDTDO//G0cFXF3M81achpgXzO0R4l26s50EBJAmcwXdkiPZg76vdXxhNVpvdsslkFa75laH0URXfh1Gs+k61TVgZg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063026; c=relaxed/simple;
	bh=AtkF0ZBc+Z05dbI8kojFijCH1tuLsLtL+wuYx+B6p7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzdPQ/yU7Dmpu1arZC0v83lSYb6B+VqKNb1+/jPejI57JCnVOB6fPG2a63ISNkdxoRc7nvvewL0i4+9ETeYUfxGfQq3IZGARSG6rfM1tHfHdCGObeyDWPk4FQiJkHifAuvAB5mwIvyzd/Nl34MmLRkxDwv0132GkhHuYTq6uKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eh9ot0F3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7398d65476eso3778108b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744063024; x=1744667824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OjONuyVEBabQma13n193abZmpu8eJbu2Vov0N/Hvhgk=;
        b=eh9ot0F3jiq8LhMaZ6ne8MoT+yarneDrai1k/0P/nhKsF+rhPTQBfJQZaVLGm+HL8g
         xysK7datB6tVZsQtYjYZkh10/E8UqASto0uwq/ZR+jhwhgmsf7doks/QfS1c0ObX9b2s
         1YlKVlBDcFkUwAKOLtVbj3y5og4nFr90UX+x3+oT+wu6yx1Mg7qIxx/7u3MHiZqrvGPy
         2amQQKE6/YA/6PucttDhz2cs2MA8XSOY9BKgb89hW9e/GsPJzAOaARvjvRE9QUnFkRwr
         KEXQFkMWS1H7GKor7FA9RIbiGm3Gnx0/jSpwezycUeQs9vr8XUR9aZTptdlpY7VUxZoY
         kcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744063024; x=1744667824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjONuyVEBabQma13n193abZmpu8eJbu2Vov0N/Hvhgk=;
        b=ppypxeqGxVgJxgef2V8zMHpwoy92p75SP76AaBl/iPxXlpwARcj6Ubv0tSsLmUPa9K
         gkNzOyHkYMcIxmFteuWqYdr1zw60iScAudUUqwnX5RQs426ltruOvwf+5qgYnglUWb8l
         AWK0OuSpmN1OD+114gThFOwAQSfa+UC8ILhzK704P1na3rMsidP+PnxqPvTe8CkNOfwC
         bkF8k+O8wZRvLU7PKZ69ZzdWRylCaOFfH257BDq75S7x66b3PBqQ+ooJ/cm2o5+429gg
         k3KznlgxEzlPm6aEMjMdq0MSAiLvHGhGFf7gAUwfhLmov/sTl92712S9oSVDvUXmUoFw
         Yzow==
X-Forwarded-Encrypted: i=1; AJvYcCXxHqHeaqzrnNRCbLdFqhdEgjFLojkFZ55wIhYYadwfJogmK+rdD1OQr/qLS1UEnVdg17XgZx5GkYVPH/XNtFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYKPPbqXLQsZdIF1qIxfC4h65NnDH+6lIGEdCvqJcyT89xPcO
	UulGbPegU/0Nv2hOCWiREfVM5y0wH544xLG7sX+w5LVwXveRhzZV5YAwtVUZhQ==
X-Gm-Gg: ASbGncsNTpuk+YnulfTCEcYWBjaS9DKnyshG6S+7fi56LOqYItsS3S0QrQ6FvER5/+h
	ax/0JnjjCVrxwjTH9XjA7pssXQtr3leDaTCj/YQm/a8RWISgbGja7wHgKDmWSNGntfd+yJJIIBK
	YCFXpue2Dc9VvbNNrW7di0ONnjt9RO9Kz0b+KGp10rUNrxhmI6HyQFXjMhDPvpcbm6vaIFXQv7S
	/+Ni77a3XKGcGTnXrdPRvcWklMyzX0CDM4px++lOBw2+eYeBi4q54YljWruY7d/XEJpu6sz2+mH
	aS1CXRUPOvFh8MctSrCC0qr9H4idtpeCPGg+1YYXhEWBsRAUxtX9WkCf+ishJWWZxVeOr+OGzto
	7Q3I=
X-Google-Smtp-Source: AGHT+IG5lEHLJyzIz19sfe8HcprikkgM32nxxTCAttYwDTJ3p2LAnqTiHsS4v+jrL5vhkcABNLAkmg==
X-Received: by 2002:a05:6a00:949c:b0:736:5813:8c46 with SMTP id d2e1a72fcca58-73b9d3d3187mr1735267b3a.8.1744063023748;
        Mon, 07 Apr 2025 14:57:03 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:b109:bcd7:b61f:e265:af16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d19b9sm9016047b3a.23.2025.04.07.14.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:57:03 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: tc-testing: Pre-load IFE action and its submodules
Date: Mon,  7 Apr 2025 18:56:56 -0300
Message-ID: <20250407215656.2535990-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently we had some issues in parallel TDC where some of IFE tests are
failing due to some of IFE's submodules (like act_meta_skbtcindex and
act_meta_skbprio) taking too long to load [1]. To avoid that issue,
pre-load IFE and all its submodules before running any of the tests in
tdc.sh

[1] https://lore.kernel.org/netdev/e909b2a0-244e-4141-9fa9-1b7d96ab7d71@mojatatu.com/T/#u

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index cddff1772e10..589b18ed758a 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -31,6 +31,10 @@ try_modprobe act_skbedit
 try_modprobe act_skbmod
 try_modprobe act_tunnel_key
 try_modprobe act_vlan
+try_modprobe act_ife
+try_modprobe act_meta_mark
+try_modprobe act_meta_skbtcindex
+try_modprobe act_meta_skbprio
 try_modprobe cls_basic
 try_modprobe cls_bpf
 try_modprobe cls_cgroup
-- 
2.49.0


