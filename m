Return-Path: <linux-kselftest+bounces-37353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59815B05ACE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 15:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77527B069E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 13:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB72E1747;
	Tue, 15 Jul 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9T7JbZy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC72E041E;
	Tue, 15 Jul 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584820; cv=none; b=Jz9CiFSRw9JAX5Qd3z269Vpu3q/9AxNKvyHw+gDkZNFyK/Y+TEpVFgZGoIhJic7Y3jr2oGOc+uwPEDIsdIolk2lkRPc43NQirNvkUR69UJyGpCMMxzd/13eaC/AfenISkOOLEj99qVJ6C0TGb8V8iolqYmMbDqbrAuaQszNfclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584820; c=relaxed/simple;
	bh=+4BPq8Ag7u6VS3ATK8+Mqx9MTCxg3lq+5av2VYhAJvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I1knAFGOoEieTIgwFUKqZ+HoaAa1QWBZhNemt273R4UVLib5Ujh+jus/AsMAAy0hsz976UtSKU/hIV5C13qBfH4luIAdenR86ZT8vRfJC1Ge3CywViFhDVw2oKvTI9cQtrbGFXyZj9itL68co0bN9JhHX/ogPFfuu359Mf+ZVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9T7JbZy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a522224582so2757020f8f.3;
        Tue, 15 Jul 2025 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752584817; x=1753189617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYAnqRvooyPTpqznSq8Nwhoicrxrtb7Od8bN3VBbdQY=;
        b=b9T7JbZyKW2uTi8NTvYDN5YZ+E2N6C/KdV0mOukwIaaFrL1tON+kIZNRvuHdXG5ESf
         lTlqICA23WGzk6qzVNyYclrB+5Nf93hS100wLXx2fUtdcUtUWVmbwRYH9hUE14rg9n68
         8UbnLm9LolzDgyRZhwKGesVH4tsk/DbllYFUGmMj2WqQQjn/9DAzLMT3sW+8rs0a6TfR
         KMsFKcAfO25CKpmXiIdCqbUF3dU4U0ZzYF58OH1Jf4lXzjY9dYBxAkkCXcce/gD752ip
         4svP+3G5i8CBvAYzvabuPbSEYBR6KMIcxpzCZQFFQUJRbMUNiBHqJ56MxmPX/7CMui0W
         Wkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752584817; x=1753189617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYAnqRvooyPTpqznSq8Nwhoicrxrtb7Od8bN3VBbdQY=;
        b=U1p/89E2OcWEuyf+fCIoT1gb8pfmi86srxX8UyTTj8OLwKSweG9NnHb4sdJxt3pS8h
         q/yr92KJW8Uwmq0FYtv1fjuEilLKo6R+pwC5wqQIX1h9KXztgh9jdwFIWej1yLSQSr+S
         uV25mDC54AOdwmAiyxThtWDVXO66y+ygXUHEr6COGVsBsAdDUjAXXt5b/NwOHP6nBYCD
         ZKPBujxT/4wCDJccTgxPH4iUm4yhYg/1O7awOsuFRF1L9mewpN/EvQbhZcr/Y0ClbBiW
         rxTyXCS7nKroqL1Z3ux2Q3Muw+sBT0JOgealKyVi9+r3HDtSPXdWpKcjm0iNb2pG4or8
         HQMw==
X-Forwarded-Encrypted: i=1; AJvYcCWZA+gZSj4jELsGaKHQwiobuPi7BtAjzmoneT4zc1ThtCwhghPb1xnJ0oVOr8IKRRX4HbbV3JaA+gXWVOk=@vger.kernel.org, AJvYcCXoGNsqpnaVa3MkL2GLrITVF0yWqGlLN76SPDhc/irKYRD1qUnN5rcHVEsjsrfPoQkVi4gM8DcY5R3eOe1ZvHiV@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/icDS12FGH3thxt1e5jQXjqVG4wFrPWR8HvTHvnRXX5DN2+t
	4Ur5M/5KMkS0jfeU7jBX6Df5k0oZ1rF/kUOVM39weJsQvcr6MjGv8XSj
X-Gm-Gg: ASbGncu6+0LjLvJs7PV8ymOC2xXIkKG+da/Hbi3g//XxedxxfwITwiJvGwrc4iBFCEK
	y3xaYP7A7Rr7mQIBN2igVcU95ltQDWRNYkSuqxH4XlXqugfo9eq3Ue6XgFd9PxLD2ZgFBYvrz7Z
	OvokSsQHg69G6WgLaAWNkkXCSWW3SpiWBRk6TeWG2P87WtopwDjHnbmfRghWqhwtItWE/o1fUqa
	nwLsWLTiJFztCkRdCYqGEpFqkSVXb4UgHlya6yyDBn2Xf3MrH9/h+BNAgI/+zsOccuau9E0Rpdn
	nwKcpur52mc7TsCEZjNUVJD3Uqm5gjT+x04Nogx3HdF5DHJ2iQkTV5xXo2YYAhtuVNftjEogIgU
	+SMWcNDYBA9NWoe57ABaR
X-Google-Smtp-Source: AGHT+IFT4HKoMD6ksFU61owSdxSR7HkGowoofRdIoqF/Y7IIpvsS/v01MDu6B2/BRiHPFTciAUcNKw==
X-Received: by 2002:a05:6000:3103:b0:3b5:e6c0:1241 with SMTP id ffacd0b85a97d-3b5f351dd51mr12523792f8f.9.1752584816206;
        Tue, 15 Jul 2025 06:06:56 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8e14d12sm15233822f8f.70.2025.07.15.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:06:55 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/futex: Fix spelling mistake "Succeffuly" -> "Successfully"
Date: Tue, 15 Jul 2025 14:06:26 +0100
Message-ID: <20250715130627.1907017-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ksft_exit_fail_msg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index a9cedc365102..aea001ac4946 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -122,7 +122,7 @@ static void futex_dummy_op(void)
 	}
 	ret = pthread_mutex_timedlock(&lock, &timeout);
 	if (ret == 0)
-		ksft_exit_fail_msg("Succeffuly locked an already locked mutex.\n");
+		ksft_exit_fail_msg("Successfully locked an already locked mutex.\n");
 
 	if (ret != ETIMEDOUT)
 		ksft_exit_fail_msg("pthread_mutex_timedlock() did not timeout: %d.\n", ret);
-- 
2.50.0


