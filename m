Return-Path: <linux-kselftest+bounces-39360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA7B2D661
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 10:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98F0188355D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF9B2D8764;
	Wed, 20 Aug 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdj8sH49"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0492BEFEE;
	Wed, 20 Aug 2025 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678522; cv=none; b=rYLArvksUglQ783GjEB7GpwEgdPJkoDtp6Sc/miMKRbu4sCY2fia3jtQbbzz27sQJ4Crg0u3Flo3Yr+FFAm3NRf5wksdkyQokkJQyhPZ/FNIpptQeApK+6MsV5tA5PyftvLTHmcnrHlfBdK3849NDmuki3A5mQtYaAgRTmn4pv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678522; c=relaxed/simple;
	bh=je5AHg/youKOa+xhCXnHlhnCi4E0rhPm8H3bXUt+7zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scoYrfz/MT4IS0U/7cK7FIAMBj2IfrYMqAQckO7YZ6X9lluWYnGF78debsYRaLwEvVGqkXysJ3AwZo1w5R9k4I/4dm7mJrWDFAOWEIPKwhWJW1dJbXVjd0V9fSuxcPHgilXAV6b2QbLwzJ7gJ9UgtZRuqTxj1TckemifXocdgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tdj8sH49; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2eb09041so5318370b3a.3;
        Wed, 20 Aug 2025 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755678520; x=1756283320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=Tdj8sH49pWraE+YC30pEW4X9wGXsu6j1F7iWlJ87X2mR8IomhaX9QzlgTFmkLeue+u
         5IKfgIcKpDi3djPNszMsUVRkfi7soEVix++gtNY7cZV1y0y52yMXiKf+BlbB7k/KApXS
         Cc0LWGh+zwaNm16G6VJo67hTy8dq4sHl4PjWjofdvJOdT3h8dUE8qGSwvPrbCdmGOwvr
         WKur0QjnJ3DAqREg2CayYYD0OlEiupwqJFl/cYk4hWNOlmUyMwmv6KvhGx4lT2plM29x
         re/GhXo8Yx6arpM3Ub/9PpREw/9UrNVYTbxZnoZjiQSxsMIMK3qumzaPZdrkxGT8aTqa
         R/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678520; x=1756283320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=sIoMKb5BJo6XDe3yIqka7H/Dw8ojjtBv0hSdK5GxfPQAyve3loo77RlHaaN5F+S6zy
         6I8g9LH01AezPkzKPstxujyf2vG3JytE8hhBfhcKbhCyO5zzO40SFajuX6l5PP8E5byI
         I5lwuGywrReB6jwVISXqD1g5cAlWNNNzHSyPacMDDvxiJTFIYHLTqm5C70IKNCtB9QNM
         f34FFS3M71MrFqj347cyh/sCnz+bhirWKVD1diheKHfUh1WPHAABGQXPmYV44o3ol3Nn
         NSyuZqJ0r+6mIdwb4hcl0uWkqilTEnIiZ4x5qsgQjN3KTm47JWYraK259PmCou8vzUVk
         CYvw==
X-Forwarded-Encrypted: i=1; AJvYcCVBJwqK5ZQiGNJy+xscS0Xa3nAA2UIKTesaT4jIZhMDieTwiChwjlp19kuEXtknp6QJEQcYQd8h6kW+My4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLrtc5doIZXdCKlcCAqAXdNduVpXKJsbFpc4i3WoXCvyiy4EY
	1+KDGC6b8wlzamokQJQG0P2IaYZlSwMJx4a70UAnWj8iX3c8cNyjBKj3IiiNMw==
X-Gm-Gg: ASbGncs7I2uJqyFxG+EPPcYPTXeOWFe2f4igBuwQ/xdPqBKuBRU4eswlbtK6dLO26NI
	BuS/XXClylFCV9E4X54If/MCFp/svD3ID2N79ghBwKC/wpF9LY+G+Bs4aMnke5n64A/MyfjAb5A
	R8oUNNZ5x7y4QhhQRmwkIZ48u/d8G2EjyRlL100tW7nJVR2kDz0o1YSe89Gcytt+IieuTqDvfrr
	VAKMZ7oaxaYJBR/kjmSKib11/hfN0x0O9L1nCuk/KQZboH+uVMPeJwKEFB3lQod74nYg7c6n8P6
	vkSnpd5EDZRaRSe6UZaHONHAv4RbA+muP0D3xdZ6la/jcYV8aNzxYBirzugO+ugEugIAJdpUIB/
	WycoCksJjTEY+Kku0V1Rg253jaceh2k8mwavDR1qCNET5
X-Google-Smtp-Source: AGHT+IGrhpBuodfn78QGSXcn1nLUN6xgK0n4xMWBXhS/Db7MZ7C4gboL7DmRJl+S7I+kXUXvoGA36g==
X-Received: by 2002:a05:6a21:32a6:b0:243:755:58b8 with SMTP id adf61e73a8af0-2431ba737b4mr3328765637.57.1755678520531;
        Wed, 20 Aug 2025 01:28:40 -0700 (PDT)
Received: from OSC.. ([106.222.231.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640d0be0sm1647057a12.51.2025.08.20.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:28:40 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: shuah@kernel.org,
	cvam0000@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] grammer correction
Date: Wed, 20 Aug 2025 13:58:29 +0530
Message-ID: <20250820082829.10292-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

corrected a minor grammer mistake

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 tools/testing/selftests/acct/acct_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index 87c044fb9293..ee2894e4f7bc 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -22,7 +22,7 @@ int main(void)
 	ksft_print_header();
 	ksft_set_plan(1);
 
-	// Check if test is run a root
+	// Check if test is run as root
 	if (geteuid()) {
 		ksft_exit_skip("This test needs root to run!\n");
 		return 1;
-- 
2.43.0


