Return-Path: <linux-kselftest+bounces-41120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A39B515BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 13:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB91564014
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD4317712;
	Wed, 10 Sep 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHDpGcR6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212D3128BF;
	Wed, 10 Sep 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503847; cv=none; b=EO1BJRtm1j+6qIj6DUv2BP2MhDdLMwxp/+XHEKj0Og8c1762OOxcBxPodayH9SXU+dXlUA9IedKiwlvZIYXr3HuIVVxjQy1q62I2gY4faSS5DruInOd6hs8Is4aY6AwdEdLz6G2aEtKw+Kj8bYA+OiUxZwDDMGcGZ5ynYnZMygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503847; c=relaxed/simple;
	bh=9ZSLjDe+4Fc/v2AOr41UNDmXMbdnGl8t41vBsqh5l3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M6DB7TGCJ/fPZNkdaGfTu9htLYTpiIAdJsyfU2hvbXezw5thlqdoZjgyWYFkneCsQ2uyhKgRV2sL9KK50xClNgQTG0Iaj/nnQkzU9ETfurb0lSYxW78/3rW1WzXDF7KvA0J5YbbLx+yWjyt37RP6ISkXTkSfJfPlof5qxN1WDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHDpGcR6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so4445450a12.3;
        Wed, 10 Sep 2025 04:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757503845; x=1758108645; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=flW00o4TNs0w7ND8/adOgZPHVUNu6jf50PwpLW7fM5I=;
        b=iHDpGcR6FIek1qNAo4AIJX4WQHCI/MqjD2TvgMy/NfJin15ZANQr84IuIygPgB6mo7
         lq30mjhX4aVoNdCwBrCPsbTvrwfQfMpWMChbjXhgOeIgtaPmHBm8qiLo3PwyMG7HFogj
         JBuzI2GKuBINXZHSkGXdDUMirq5cmWLlWdjaAVXw3b1Ct8DqtfQ3Y9GFtXWwKfrzkO0H
         LstpaaQVl+2G+L+PgtUw6igzzqN0QZx4O1Dd5S+8xoGYk95S3iw2BPt69Wdyxf07iF8O
         JOxpBD0NWKgDNzwbv7eydDjYMAQAV9+eCOclrnHIqRcixgWLplOH4wRXTfd/Nqz/C0Xr
         SMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503845; x=1758108645;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flW00o4TNs0w7ND8/adOgZPHVUNu6jf50PwpLW7fM5I=;
        b=ljPoaZKaJHFDundY+XJ6TZMfW9nfqY/yblhBmsdIR3KT5SagSqMqCjDjud4GL2jd/4
         /dUfmqic5BYqf92dYqmtlwXTibcgrCljKULF9DZbc+8glf1sAye36g2UYCnoEDOp4wR4
         jJk4ijKoSCTARgrX7ivuu2kYHkNKVDn0UjZ3mZYUnb5KizK2+wQmhue1/TEOs9dGRK/V
         3SrG0jRTsHGa25Q/WZh/VVoBRgzgpv6c1TRgxlNfxfIghptHAm/U7VJ5fsIw8IQx8OLX
         VMLQ3smzMkFzobuzkrguLFZtpdG++pT+YeVvkbarL9y56xEw3tW/OT7XFT8qGaJXgnt2
         8KWA==
X-Forwarded-Encrypted: i=1; AJvYcCV3fzeqwNcpnqaJYVZcqkGObqzDgAbLBLFtGhFZRYgyr7atZKYR/ieBxJX6Wjio+P8WcF+a0tnThU9R7sQ=@vger.kernel.org, AJvYcCW4kUUCu7mkC1lsDumjMxSVlIOvOwNwu9zcmlJyZ06jiAiOgjjcv81OZUnJ5AsYxzuka+cdED9N0RzQ4gvfk80N@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4SOe2vWSMtFYQsnqi1NRtX8ZFBog8hjkdG+5St/YMnsLVfmu
	1pxyOOfN2iwjZifZduZcEoF3G+xgva1gKOfX1DfCpkx0REY1KU2NJrC5zDIiqg+O
X-Gm-Gg: ASbGncsx52DvmXbzaIdL/Tt0+UB+eYcyky130w+PnBWvwVZ04kO8mzYnL0gSnqcGPy6
	ls3z7zCWHReT+yMubr1F3hWsYHujcIXS1G/jrqTm8MUxkLImHpgwc//3ex7wrGLH7pekZK+K20p
	MNxkm3obnlybs88Yj7xzQ91R5W8czCjN7I0Sr8EMFNl9hTk9FQhtTTC8aNjqmyIMoFPm49upuuz
	ofTArWcJk/RPupuwTUiR7KR+q6oCOtSZ57/HM4l+gEbWU60CcYdZ//s4m3127HF7oB+onHQ4Oa7
	7AhLXoqYpJr/vOIzHJlvBo+ZgU5svs9mbMmQln8iJOS6BK9T+rE/xlBHHtS87P1VyWfgPWWfPQ1
	6yItLVrw1aY+o69CKHbeXemPuZ3H1Fx66hmUXoe6tWu0c+D3UzJbr5NjQp+k6AuPCRZZ4xprZ0T
	BnjF7XG3JsGaLImh/p
X-Google-Smtp-Source: AGHT+IGc7SMnCypPSiItYXmc89F0gz9NLoFugqdvp1jo9HA+2pBLrXEE7CO3WouVUiK/9GqKXLS5sw==
X-Received: by 2002:a17:902:dace:b0:24b:11c8:2cfd with SMTP id d9443c01a7336-2516ce601bbmr241491715ad.7.1757503844712;
        Wed, 10 Sep 2025 04:30:44 -0700 (PDT)
Received: from localhost (2001-b400-e28d-0ed7-4d5a-39b4-7c51-4c71.emome-ip6.hinet.net. [2001:b400:e28d:ed7:4d5a:39b4:7c51:4c71])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25a27df03a6sm24841345ad.56.2025.09.10.04.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:30:44 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
Date: Wed, 10 Sep 2025 19:30:32 +0800
Subject: [PATCH] selftests/Makefile: include $(INSTALL_DEP_TARGETS) in
 clean target to clean net/lib dependency
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFdhwWgC/x2MwQqDMBAFf0X27EJMkWJ/RTzE+FIX0yhZkYL47
 waPwzBzkiILlD7VSRmHqKypQFNX5GeXvmCZCpM1tjVdY1gRww7dlX9uQZAI9hEusfc2jG+DDi9
 LJd9ysf9n3Q/XdQOYbgM9agAAAA==
X-Change-ID: 20250910-selftests-makefile-clean-cc2fb70e9e32
To: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 Nai-Chen Cheng <bleach1827@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757503838; l=1181;
 i=bleach1827@gmail.com; s=20250730; h=from:subject:message-id;
 bh=9ZSLjDe+4Fc/v2AOr41UNDmXMbdnGl8t41vBsqh5l3o=;
 b=kXMkH0zAKLkWvP+pZoQE1+O8Jn6o+7/9bPAhRss9NYSh6eI3XM3RkVxIOhufhacf0MniUQ/EC
 1hRfpU4jD4BDaAWHTm5r3e2zPbYyYvBM2wW5bj4bUWA52A4GsHa6243
X-Developer-Key: i=bleach1827@gmail.com; a=ed25519;
 pk=jahFPRplw20Aaim8fIt8SxlFMqkHbJ+s8zYBGbtHH5g=

The selftests 'make clean' does not clean the net/lib because it only
processes $(TARGETS) and ignores $(INSTALL_DEP_TARGETS). This leaves
compiled objects in net/lib after cleaning, requiring manual cleanup.

Include $(INSTALL_DEP_TARGETS) in clean target to ensure net/lib
dependency is properly cleaned.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 tools/testing/selftests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 030da61dbff3a7e4a22d61ba3972e248a43d374d..a2d8e1093b005c9af3570246dd8b10b59e44b46b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -314,7 +314,7 @@ gen_tar: install
 	@echo "Created ${TAR_PATH}"
 
 clean:
-	@for TARGET in $(TARGETS); do \
+	@for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;

---
base-commit: 9dd1835ecda5b96ac88c166f4a87386f3e727bd9
change-id: 20250910-selftests-makefile-clean-cc2fb70e9e32

Best regards,
-- 
Nai-Chen Cheng <bleach1827@gmail.com>


