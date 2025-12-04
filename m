Return-Path: <linux-kselftest+bounces-47040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC1ECA46FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37E9B3009390
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFF834845C;
	Thu,  4 Dec 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GimTvkxD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3F6346E62
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865074; cv=none; b=brbyt5e8RUfEDMCiMSwv+rUFmxAgUU+hlqDSZ8utxPcZaCZWcVpFKbPJtHsYvPpt2RmtfhUJbXU8e//pNfnYZbkKeY6Ya4g76fD7T//LChPiib4ZKjFL4xHjds8ybA+UD5iPvqQrnYXP+/6vrWe7sVksgm48QQTt2LVK6l6KB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865074; c=relaxed/simple;
	bh=hvBzVJ/t5S4W+0QfdLWGGsqd7XL8k70zq4O5nv/Dcr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgZ4NcidVfULQA3AMU03g04MKoGSp0am26Dcr1r2MPAIvyb/aRf7tXATjkScz/vgqblaDBMJdrYlfDJiIlNgBbXQCQlPxhvCb7CGk29fJb3iob5vXHfsFybCREh+7ZeCWWxTWb50D4oGX/9eGEJ+Ld/dv7b9QGsy3Io5g+69/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GimTvkxD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso926538b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865071; x=1765469871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtcDJ2mVgyjaj6aViXY89VVDbVIB5/tZZgz8kR81SQ4=;
        b=GimTvkxDa4GEmS6OaSYR+NRO2eV5nVMVGkuDX6w106taj0O1qrBchWogoZsORUXn6v
         Q0oeu+COkHIhXi6s1vqu4j97YS7PE4v0wYbgMS3+f5r4vOP/y+df08GcUPdtn18y1CNy
         HydH/w7M437Cjcw1vrQLcIdnqBf/DCZ90q39AQ+4uPtnkUHTGPznvKco6cdiYBsYlOeT
         JGdpsBJfyWvCRyYgWE73XxDZuLo4epi8XWXziNUah0dH4tde782c3ZEei7B0VJ6Dibxu
         vlxw/fs+p7aVibauTg6IVlYPZyFLOeBpv3h/8NSyspJvJBWMib16BhzpsbCiOASu367G
         1NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865071; x=1765469871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtcDJ2mVgyjaj6aViXY89VVDbVIB5/tZZgz8kR81SQ4=;
        b=Mjt0ieOdyV1HzZ7+QQ9A2p/X9kYMuG/qvjKTbHx+uSrxhhURVnAvU5fst/ok445APb
         i5QHhW9RZEHBRIwI1foGXhpo8meekBtyvQwQFHeo73aQWL2ruo1/hHlfl4kIkw83zPYM
         bs/nwuWG1fA8JcNR//mz7V8iVIINhabSiJ6+bYWNfLhF9m8jV6Ggk2cO+NRSwtawMoO7
         +8xFZtDUMZeOazjNuU89aj377L6/dOX01EXu9uNN8NSFGE/byOknsr2q2fxcptRPLdHy
         HMn2ezdB4BiSj+wjI4Id09A6aWBqfxdRi18nyDs0iQj8X8+wiGjghPrSWO5b1eMmU56V
         Susw==
X-Forwarded-Encrypted: i=1; AJvYcCVrXm7IuD1+7fNbTezHml+PYYdGuGv1vBftVHSlkikYgxuIAmKUA2LSeD4rF/Za00XBZs8/ZUOY7XVqKFY4WkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoY3j32oWVpuE0IX7IlIGvAK5P23SJgJ1Lrc/ekKWn4l/nAlCW
	8VmQoR+RoSv/VZd+ELh6fjXY8xCQQWRM1Xw8szTFWEXVNNocEHGdK9W6
X-Gm-Gg: ASbGncuJHQTchT2gSKgALjbpKhdEKjGgEi1VExZoowerybi2gyBEmU8szzyPld7P2Hj
	NMD6SBqeTlDMWS462W00DUx9FoWqHJJ0wnEayPLV5NWSV/S3JN45/hmgKTUe/iVXYR7PnqePm4U
	vA74Tr2kS+4wU0piPjY5cfSwCPsSEEzhku/6UfZDKqn9UIguncVe5F3SLfYFt4kWFfSxs1KW1Ke
	vXs80GwCO4fWZICJDs/CrmZL3p+tgSVSlNdDJQiE1dxJbBrWwTVlJVhekNBzGWBneaA8CA0LIWM
	d7gokIvUF+THaWedVBTubgqk3LK8a7CF359xh50VXKH6ewCbiByZMVrpsT0rDXOm8ae5TIHMc+D
	igRafrr549sgAyX65ujId4i6D34c9fiUR+5TInHEWPjXUys/Wo8sr6/rvsoBueLWrpKv5A3Da+/
	/R5GLIrRskYEWpl9fBT+lBQWU=
X-Google-Smtp-Source: AGHT+IELXCFH6Mtkssje8B3cs8uw1+jhPH5HgX3Ko8rfICAbJsoeX6/ZNHe8e/JC9Q9qMDz8dOKgnQ==
X-Received: by 2002:a05:6a00:92a0:b0:7b7:a62:550c with SMTP id d2e1a72fcca58-7e226f2b644mr3780242b3a.1.1764865071205;
        Thu, 04 Dec 2025 08:17:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ee0b3sm2640524b3a.7.2025.12.04.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:50 -0800 (PST)
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
	Guenter Roeck <linux@roeck-us.net>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH 13/13] selftests: net: tfo: Fix build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:27 -0800
Message-ID: <20251204161729.2448052-14-linux@roeck-us.net>
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

Fix

tfo.c: In function ‘run_server’:
tfo.c:84:9: error: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’

by evaluating and then ignoring the return value from the read() call.

Fixes: c65b5bb2329e3 ("selftests: net: add passive TFO test binary")
Cc: David Wei <dw@davidwei.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/tfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
index eb3cac5e583c..0126e600a36b 100644
--- a/tools/testing/selftests/net/tfo.c
+++ b/tools/testing/selftests/net/tfo.c
@@ -81,7 +81,8 @@ static void run_server(void)
 	if (getsockopt(connfd, SOL_SOCKET, SO_INCOMING_NAPI_ID, &opt, &len) < 0)
 		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
 
-	read(connfd, buf, 64);
+	if (read(connfd, buf, 64))
+		;
 	fprintf(outfile, "%d\n", opt);
 
 	fclose(outfile);
-- 
2.43.0


