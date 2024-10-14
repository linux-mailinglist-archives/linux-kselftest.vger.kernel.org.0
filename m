Return-Path: <linux-kselftest+bounces-19655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8EA99CC68
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 16:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2EFB2246A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28A1A4E98;
	Mon, 14 Oct 2024 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/k8+3v9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67C4A24;
	Mon, 14 Oct 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914970; cv=none; b=UbW27VjuaLek96BDv2sArNvJczUEgiWgYEo/Hz1g6yJW2zgEp+g7Jpqnqttes6RqS/5bDRlO7zPuGf+KoBGcBySdjwucxaP2yiYMzaGTwLVxL1/65pJMvoBz++kKe+9fDr5ijTvBCt/ZDoV3+rU52IzC+FciT1FmGF9/PGLr46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914970; c=relaxed/simple;
	bh=1SU2fvWzCnN8mP5nuAb/VzX/eDrMLJDuoZFgjt3DNYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+iajDhMZL9BuL6MuMBtIvy3CfPidTaKOuP9uwOFUI/sHHld+EBE6v3Na03RiI23Y1sLc0gPtc1PJQZwOpXLBqHnezerXo/WB6vyJxZsHaytPQ62GNl9UCKV00PnnTwZbHa1RH6uQBtVKB3OR5p9GpFuBbNbSkr6rvjVzgS+E28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/k8+3v9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4612da0fso3118107f8f.0;
        Mon, 14 Oct 2024 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728914967; x=1729519767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2sWdiGLEajrXvsWKVLMxH+RH4SJuX1/ojX5Ya41gZM=;
        b=P/k8+3v9Gm4FSFxttI8lKs1jO3CYvUsjxFooNMDqClNf6g6ByxnOQdsINCv+isW/am
         NbC8WsrytzWHh99Byu74+2UPVn2gsnuEYp+xbDdXtP2Oqo5PnWbc/QreWsOaG9EA9IGa
         c19wUNaqXnGr6Jkd50aLSlSNaqVhR9r9RCEUJJkNKOl9PstfW62B1PRy4eVnG+xEc7BJ
         GU+B7ZoZhqw8Dx3Ps4MIA7b3gwTuNjaoHkkUIjEIOLqCenVHVPhKxfhdtFzCSwoZaVjn
         K1Y/AZEbn3MXuLGoTB3L1oAr1stW8zteY1TkgMIprvvOQYuTDCvLQcNqmpmCQSMKjTce
         xXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914967; x=1729519767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2sWdiGLEajrXvsWKVLMxH+RH4SJuX1/ojX5Ya41gZM=;
        b=o2SyojxqMyNfoEmOV++l3lPreHV8AoGX2G3BQYTMvi5Y+PE7Vinij1xcJ5KTbRM5jx
         Kj/ORgAap8mC1/jcz/8U/e1aDOwoFP7DxQ6+pWK+n8ZP60+hD6ni1AJW4bbGuzmyEB2f
         p62k6ZewYI3CFAQIX4IssR4awBB0I90DCNQPaTcL5wzkC/iLZH2C2TuIYeNly0hBihpB
         F4KeraJVngDFhgzYxE2Y2tfmGZrJKKBCEzSiZip+EGEbu3OdFmm2+0k3cjOzI1hf7yJs
         KWOPrrGdDIUq2849fk+CELe9sF1OJIsJWiWi1O8wvFnTi4OdzUqdUQD1HpFgGt54Vk0E
         u15g==
X-Forwarded-Encrypted: i=1; AJvYcCV+CYzoNgMtf9QoywlYEkXIYJXC/wU2iEQCV3CCJLlzaScKaVWHAKNCCfdYInaprC1+xQ7Opo4ozn+qW+4=@vger.kernel.org, AJvYcCW+jXn3y76LLTyVMKyUG/a0nDvw2fxOuxYF4lZRVsK8JQ1f1w+jd6gGsRUTEXbXhRXmPP6GKHNyaxXkgEng7d/4@vger.kernel.org
X-Gm-Message-State: AOJu0YwMquk/q2KUuCjrHMelVMAGuTSB9ir1s1cGsoAqOH2Yi1fosxK2
	L3s/aOzribTHJBq5WEbbq+yjauIw+szAjAouuQoAApSv+rwXRQk+
X-Google-Smtp-Source: AGHT+IHL73igSPgJNMEa1ZcU0KPX3w4X3li3AJtp93zOeIo+/6CQmYQrmftgaIgqeYYpsmYXPag3yg==
X-Received: by 2002:a5d:5108:0:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37d552d4a14mr9053901f8f.29.1728914967216;
        Mon, 14 Oct 2024 07:09:27 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a87desm11478455f8f.5.2024.10.14.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:09:26 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] selftests/intel_pstate: fix operand expected
Date: Mon, 14 Oct 2024 16:09:14 +0200
Message-ID: <20241014140918.229922-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix solves these errors, when calling kselftest with
targets "intel_pstate":

- ./run.sh: line 90: / 1000: syntax error: operand expected
(error token is "/ 1000")
- ./run.sh: line 92: / 1000: syntax error: operand expected
(error token is "/ 1000")

To error was found by running tests manually with the command:
make kselftest TARGETS=intel_pstate

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/intel_pstate/run.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index e7008f614ad7..39130a359535 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -87,9 +87,11 @@ mkt_freq=${_mkt_freq}0
 
 # Get the ranges from cpupower
 _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
-min_freq=$(($_min_freq / 1000))
+min_freq=$((_min_freq / 1000))
+echo "min_freq:"
+echo $min_freq
 _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
-max_freq=$(($_max_freq / 1000))
+max_freq=$((_max_freq / 1000))
 
 
 [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
-- 
2.43.0


