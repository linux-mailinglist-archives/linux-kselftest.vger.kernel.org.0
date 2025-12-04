Return-Path: <linux-kselftest+bounces-47035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ADECA47CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CF00301E203
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABA34321F;
	Thu,  4 Dec 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDeuL0LN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD5341053
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865066; cv=none; b=Ghyu5eG21mDaZxrGamhnbzhKsKim/8Mew9WcZAZjBw9ER5U7uez3gl6E0gM5V+eMXK3HL1JtUgsQOTcwxv5HcpoaldVliVjIhClojOh+9P1FfPPVOgRjhps1sXOJijED2JQBeoIcsfxjwbE0RATd9Wyhhvl+d8Ymt3VN+jqdpX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865066; c=relaxed/simple;
	bh=3ygh4I0glRNwV35GaBKvlTRslUW//cHz3CUI6TSCtZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdE/Gpyz3D3mYcg9rlIVHtEhdp3v2e9ROoFmf2yd1CMYnwHIbBR8ZW3ZA9g0W7GNo4J7+OOUr6dlTFLzCuGjzUMzaJzQqznx0JBij4DTPvO7Ev6UOSmvErxqTXqVNJu8XwmmAwvCDhvlmdJtE8WSRTfP2MpeLRszud4lEaH42Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDeuL0LN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2981f9ce15cso14945585ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865064; x=1765469864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkZnCgx9bxJPZq7l/gRW6dYxX2rEKzxVPCSQ60u6+7c=;
        b=YDeuL0LNnKv6Skf8JFXDETnbrmN4u8CazX+kdfLXew/nNZ7V6ZNP/PIB7UjlMR0EPL
         Uido8y8q61vndAul9btZRNmAk7zZtIiiWZ5KMkzZuFnRq49e2ftmfzPEBFFqHOcFt3CD
         DVmRgZCngvCNXzcxB4cSWYQiFf71iBV0WJKQbZ4VxFVbJyWIbFLWELN1mG3lcRVwJld4
         JPbPsApQDRM/EjWohExjcFaZLJvUJBdOoqrm1ehm94FbdJiiyoz/JuiWMJSFrdlOOKvB
         6wkij27fCrWtbq+gAGi9pJwjtjsKE9ZDF8ecm+EckA2kzeAhZws1hC1d0voeZ+4/+jS8
         A9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865064; x=1765469864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkZnCgx9bxJPZq7l/gRW6dYxX2rEKzxVPCSQ60u6+7c=;
        b=ALjbLCwl8gcOKn+fchCEMVVpfvQtwxkHp84GKQIedKeE8q1HVOfUV6mm85oKnzbD5P
         qj3cZVNSC1YiNmjOXlyuRkiZBLZ+DVAsuQMfEd6HX5w2qKq+lMUwI9cfIx8ZkSZQs1xM
         pg0KfYWCB83OlI1RezAdW5KrMunhDnNbwr/Bct5i5RwV24J/j1eYVUtLexHgLbJ+W1kU
         y+lTvfwfSfcu+u1bDVp40Qwj3l9mvA7tKlaOnepCp5PhldUKia1K+ccvwjKTJwno2WgX
         HjD1tSJMNQ7KJTl/IlM73n+dvTyTFvCprF7A7nd+Dbtcnpxkrh1ZBrHVSG+8KJ0dyjg0
         +tMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7BK75v2V1mNiQreyj1fM5joo+YBHMyBUUW7hisXGswhayeg9iEsIcyzaDhxgJr9vml0ZgyCNnOiOJt4U930g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH42XJWDGLphGkJSyqqxlaD287ma0CysLFy4cfzd1Pgl4yvMxV
	L8/nasMditpLrJN1v2h4r/iCFgRe7MerkhQfMabyEnVyjY2dXzzfvUfD
X-Gm-Gg: ASbGnctwQ935TfFEMKRAbmxvLaqIeAIuy0L5eabVLbKmjNIL2jn6cz0f2LuHv+LRxC1
	9ZO7PZ8uszKp//Dpxb/Uu9YEJJNvd3VfnjYT1/px0dlLl7K+cDtxlRM0/qdXIhrU0eTFh3xNAeX
	z2RTtx010TDlIhyB9c428eCrXe/ioRMf5rMJhrjD8Lt7aeGXqu3ckWTdukv3pZMOWHWMN2gqUcc
	Fog8QwETPGpa9oVn9aw+wsYrbakm82diRTkzj9HdAqClKJXo2w5153yxKoedFVzwvOwJpmCQHpn
	1rYjQ29C2YZ/oL7Oc/XujbC/lYFXR17EEttp7Cwt3QZ4QQ+nKaGObp5piEcpsA98ndJouYe899E
	VNVEOSypB8c60gjcMaclPLKHDr1QsZ+ku+pLQbQbie2laBLVdNMDyO4Ko1NlimOFjE5ofWXKlmm
	3jLwA2akflpnH1hRwa69bywq0=
X-Google-Smtp-Source: AGHT+IGvOyPD8rdOIos5LYcmChpa04+Wfxdyx/PwskRd3KR37HKV0AFf3UHo1YnF29GTR+qBDwW4gA==
X-Received: by 2002:a05:7022:996:b0:11b:89f3:aaf8 with SMTP id a92af1059eb24-11df0bd181emr6324640c88.4.1764865064446;
        Thu, 04 Dec 2025 08:17:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm8931800c88.6.2025.12.04.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/13] selftests: net: netlink-dumps: Avoid uninitialized variable error
Date: Thu,  4 Dec 2025 08:17:22 -0800
Message-ID: <20251204161729.2448052-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building netlink-dumps with -Werror results in

netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: error: ‘ret’ may be used uninitialized

Problem is that the loop which initializes 'ret' may exit early without
initializing the variable if recv() returns an error. Always initialize
'ret' to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..f4fc0c9910f2 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -112,7 +112,7 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
-	int i, cnt, ret;
+	int i, cnt, ret = FOUND_ERR;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.43.0


