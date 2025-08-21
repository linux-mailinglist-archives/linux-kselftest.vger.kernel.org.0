Return-Path: <linux-kselftest+bounces-39545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85AFB3034F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D836F7A2FA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E5283FE9;
	Thu, 21 Aug 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnOkk3xb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B431B21BF;
	Thu, 21 Aug 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806500; cv=none; b=D8yb+OqCIPPMUvAk+C3KXRTuDBKYiOaDynMLir8dpvvda/7HcfAVVyif+TCeJUD4ShOYh1LwxBA9Tmx/ReSK9yIWeYCxs2RlZr7DXO4h3crlq3ucyBvRXdpGuTccj1LgudTgkAA8PuX9BxCr6nmmBn/m9f/sb6B3JlN8i72G10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806500; c=relaxed/simple;
	bh=XMyIeJLm8ezYlEHsz6RdEKqN6MAhCnnVT77tGeihO/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lr80h5/XKt6BKRRGuJe7hlbhiR2kiuiyr/Y71HpcRIfkyt/gEQ1mf6u5jr2N1RQO19t9pfOo7d2BVRn1yz2Zk4GsT0ap3LXt61et5Yl2G2Y8uRmtXHbos2TVYye2/HYmK/Nj7A/dtZ3diBIedPgRCagkNANSqCigRFmxhwOCU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnOkk3xb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so7736105e9.1;
        Thu, 21 Aug 2025 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755806497; x=1756411297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oTMM88/02+mT4NxUBWUjIecblms1GSJIloGllm1Pvs8=;
        b=EnOkk3xbkCJmav/IgObBQooMM+AxB0FMKSaN73s3NcQVoY6ojkiURm8rShvw4nSl7i
         wXzV/AdIl6Q0m8PmK/DE89thmMrIC0KSG5BgxLNkYMjl7KcBNpwbHwLlBbjIV+sOmdsS
         kPmvzui+xlRC0QZ3PSIzcjEFHqc1c4dLTemDpD5qmlhL0+7Xp4XwGBpMwy8pPeNIlFnU
         LyFlIlMwFP5cjWEbSEmgGUJybOmH8cFmSWa7sXsIgZLr0kmeqrydYkfiiT1IxUORuztu
         oencDBtwPkWDcWLKjVLYuHzZJk5GokDZ7dBgJtCaT777njZeGfNNuQdQ0OCdzA1PpFAK
         rhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806497; x=1756411297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTMM88/02+mT4NxUBWUjIecblms1GSJIloGllm1Pvs8=;
        b=oYRGTB49mN03FoJRNtsinARka3tG/FB0rmbv/A11boXaOgRoD3g8IKrJaL3C4gRjki
         F8oTcuMlXf80luN0BBHRwy7noyzTrhumNjcOf4zmI3zFFZjvs+VfWfaVM+DLJYYXe/WX
         dHbZdA5H2/XrPyXzPeo1Sil/tOiy2O7zvYJDYxn+BJGJFhPeesm7JhNb5WhiDlxNy5Gn
         4BZ1S0JTTww48SeTP8YrmIuqKVB70/tLa37kN/o6ggZctqyBMVIWRBJtqd6Q0NO0jKPi
         BWlzZ8RlLTzeAU+TVTJdBz83lzeFAvSH3TNMv4CdAxcjSTU1ZBQsrejekutY8o85D0e3
         +MjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6pShwJCBHP0ENEnXMK9sj1g1vDjlDyKTDi5DehwGWScGdkj2gByM63gDr4/j5c90DW2OMrLsqXyaPvIccTZI=@vger.kernel.org, AJvYcCX0JxWefx0oZQ6N0rG99qZLNklbepHHpLOAxqRYPiCnL7L1IV+fyE71GNKaDI/oXqZjjbX3VujLRymEW8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWgaWEqIACZHh7U/c2dMfxtcON9QknzgN8el/Jz+TW+jQhMib
	/aK6EP8tL6jpE/fMQ3Swn/5fKU5QXrwu4Pvg7mku6wZKotAX2TdI1DWY
X-Gm-Gg: ASbGnctdQmzgYY/uLExcMT/XKh2o7u6mLUa2oFZcFrZyLuS4+kkvf+l9bG4wzW52bzd
	j2AW6rfb77r8X0aM4eV8+ZC4vojEfHfoF2NRUpTsPjtZ/7XmN48RTDTNdu3ODxlE3p5DKE7XJ3z
	3M+1IXcS+c/aUOtKpoiPqjnyOi65c4G87gmB4eKfCpcZmo7QkXvaFPDRoHT9IGQTXDsd7Y+NNLV
	u/jR0fL3gv0hWKygaUNxlcVEK+matt3gAIsBvpYgG3G9xzdASp1F0aeqgjDoDo6JQ7jBGJbr5HE
	6pGU5kIW8r6YrZ7WTj/t1w8E19dJEih6TPMRgi7crMEPLzPL4zCdubI3i5cO+7hS1uYZdE12icT
	Bwgypkmu0oXNVbMvw60BVYxe3hKTx/joFt/EYT9Sl4vo=
X-Google-Smtp-Source: AGHT+IG4Kyto5Gj0d+797jRnzEa0Rw23zyv1XapBHJWTmtoAyXPo2UksJpn3Bru45jvjd4XrOZGqeQ==
X-Received: by 2002:a05:600c:a09:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45b517c2f63mr2370555e9.24.1755806496380;
        Thu, 21 Aug 2025 13:01:36 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b51589647sm4454665e9.2.2025.08.21.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:01:36 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH] selftests/alsa: remove 0/NULL global variable assignment
Date: Thu, 21 Aug 2025 23:01:32 +0300
Message-ID: <20250821200132.1218850-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove 0/NULL global variable assignment in mixer-test.c and pcm-test.c

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 tools/testing/selftests/alsa/mixer-test.c | 8 ++++----
 tools/testing/selftests/alsa/pcm-test.c   | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 2a4b2662035e..e113dafa5c24 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -53,10 +53,10 @@ struct ctl_data {
 	struct ctl_data *next;
 };
 
-int num_cards = 0;
-int num_controls = 0;
-struct card_data *card_list = NULL;
-struct ctl_data *ctl_list = NULL;
+int num_cards;
+int num_controls;
+struct card_data *card_list;
+struct ctl_data *ctl_list;
 
 static void find_controls(void)
 {
diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index dbd7c222ce93..ce92548670c8 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -30,7 +30,7 @@ struct card_data {
 	struct card_data *next;
 };
 
-struct card_data *card_list = NULL;
+struct card_data *card_list;
 
 struct pcm_data {
 	snd_pcm_t *handle;
@@ -43,10 +43,10 @@ struct pcm_data {
 	struct pcm_data *next;
 };
 
-struct pcm_data *pcm_list = NULL;
+struct pcm_data *pcm_list;
 
-int num_missing = 0;
-struct pcm_data *pcm_missing = NULL;
+int num_missing;
+struct pcm_data *pcm_missing;
 
 snd_config_t *default_pcm_config;
 
-- 
2.50.1


