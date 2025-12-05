Return-Path: <linux-kselftest+bounces-47120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B2CA8828
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B4C9303F013
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE003491C2;
	Fri,  5 Dec 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgLQK5KO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FBF346A19
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954752; cv=none; b=MoRuj2geP3+U6EYUGOplWy1kR/W0ebWEGPPgf4aHAlY4DPPqASiuUMYJznzj+P+YvnVjBtMOUnKdL3ECiEhFSrP9AulMcd89ugOS/ydj8sSmcKEArtdwfu3cyBZDovbX7MDZj9jS11PdDfyB8tBaUqBEYCh6pDfJ/RNhPtT8svU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954752; c=relaxed/simple;
	bh=yuIIgf/alWIG+QnlbE0mlEBwwSslOpyY/5j2tQg/iS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKrhXzVeA0FO3Cymi6XJBuCwNolKCKWB2rZLTmlOnPXM3I6YIIRLuxvBOdhKWXZHbA1PLlB7yg1ry+KTt/tks03WcAFxsCoRo6iV2woG4i79n5NuW7+RH4U87beiXUmWJ4ZuM3OfIWX78piI+uJWgth+OajM41JGSpoMUvU11VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgLQK5KO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b80fed1505so2615097b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954744; x=1765559544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld7Zfx8+1mGBDI9kHG+7ggDCtFZChlITAxT8Fla3YiA=;
        b=HgLQK5KO1PT5LLG8pa1wfajjkS3nhaQVsSlNLlmuAp7tLqBCnx64dM3Nqr/H/dQKRu
         1bs3e6eJXb10j5mBn2YJPHLC4vdf9keDT3y3jFI2+k88UXm2CFM/S9Y0gvrLtAr3brDR
         Z2sdrXHDlj/3+VOVBOist5mCdzbnCZFVjlknMYK6N3KrbM3tYO17YQfhxg5exdA/0Gb0
         qZ4ABMR+iDEz+sowXHc0Szym3OAOuWm9bII03Jn0e8pRCOcD/LgqGvSg7X6uUQDlXShK
         vIxuIaDa9K53v/02iFIEU5XuQe+5RXz6bgrYhXNMxTnNYkn1bG6THXdUnLPTVukCBoV9
         Dp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954744; x=1765559544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld7Zfx8+1mGBDI9kHG+7ggDCtFZChlITAxT8Fla3YiA=;
        b=hxsPE2w6ghCO8Y3SLTuDjcLn304vJ0/Gr0mzHEfxbLr478gWIzrZIx6z5l5v29rziz
         NtSxW1Hgt+Jp+KTnndeKxgNNsI35Hkvkl/MTnyYQ5KlAayC+ZTfg65t13Rm7IJcbVkza
         UcgiUlYvpVZ1B2pzVjRp0X2flz+GSFUOR6SkLQxJ+J7rBY/7Yv9C1vFsppyQfmOBJroy
         5JSp7fZv5VdFQ3bqaBR7kp7KSnYpLaffA88CDdS35tt4Fe4P2awinuspmMDwkiXJOUE8
         47Tnhaoo5nd0u9d5wP+rd1YN5Vo70Brx/7G3G59STJvqDppdaspBQQEg9KPd+nQtQjrj
         Pvog==
X-Forwarded-Encrypted: i=1; AJvYcCWPuJk7kM7SwwH9KTwGIwEz2V8vzBvc5j1puJBCsdmJNNp1TX9cUhLmneQPMy++JzzVeyaSfB6nFphL5xmllhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxacPBAOWbiQ+pBE5julMiX32JMhx6IPjQP89RGbcev7CfFToTa
	2Mvn7NoxIZ0GWcRV66MRjxYvKCNbsFV0zcVABodxg8CFakW5PGLdy8tN
X-Gm-Gg: ASbGnctSuDq6Fc9XefQf2rT5eFDvaQXQrnsCKQ4uJcPsGP4T0AQjtkREkBEeQMpUgq0
	wELdVpQELYo+gRl/0bRRX/uuoQ3Rz/q7hvZ8Qe2h9sq1rahnfxMvqbrrlKxEbSmgjWLnJJXuqh+
	zGRwDuLn4NEq9+57nM2+eDY5WjZ5CtK06tnKGWkesdhJB/GSb+Zi64S7mMhrBIiQ5wFmVfFiFoH
	+oJ/WLqH4omfGF/KFc545Vx1N7ZHK6HliLpXS9G1lrl1aNPNMwgBJRXWmqfq49b5fjaHEFU1tSj
	54Wsp3tyZk3TnRLlAkTTp7tE0munKXiM3HJNPooyVzLTMwn8CpNs0bL9QkOy+Mx9aDxBCCj1oDB
	QX99u2U6SOjwd9u4cGBMNuD17aCdD5BpbewjEKNh8Az6x2kIcK7T4iA8MctR0yiG4Wl9hlWQt82
	fx9CP283jvEXJlEkEDqEBoDsA=
X-Google-Smtp-Source: AGHT+IF6pVDWfDwXkq4xnlvBOGGFZK9hjfQ59/B+jw1lZUA9k+IMOEvrgSx0HezsT2H83Dv+hHEutg==
X-Received: by 2002:a05:7022:4191:b0:11b:8161:5cfc with SMTP id a92af1059eb24-11df0cd9712mr8471296c88.36.1764954743550;
        Fri, 05 Dec 2025 09:12:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7576932sm20210155c88.4.2025.12.05.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH v2 10/13] selftests: net: Fix build warnings
Date: Fri,  5 Dec 2025 09:10:04 -0800
Message-ID: <20251205171010.515236-11-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

ksft.h: In function ‘ksft_ready’:
ksft.h:27:9: warning: ignoring return value of ‘write’ declared with attribute ‘warn_unused_result’

ksft.h: In function ‘ksft_wait’:
ksft.h:51:9: warning: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’

by checking the return value of the affected functions and displaying
an error message if an error is seen.

Fixes: 2b6d490b82668 ("selftests: drv-net: Factor out ksft C helpers")
Cc: Joe Damato <jdamato@fastly.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes build
    warnings.
    Use perror() to display an error message if one of the functions
    returns an error.

 tools/testing/selftests/net/lib/ksft.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/ksft.h b/tools/testing/selftests/net/lib/ksft.h
index 17dc34a612c6..03912902a6d3 100644
--- a/tools/testing/selftests/net/lib/ksft.h
+++ b/tools/testing/selftests/net/lib/ksft.h
@@ -24,7 +24,8 @@ static inline void ksft_ready(void)
 		fd = STDOUT_FILENO;
 	}
 
-	write(fd, msg, sizeof(msg));
+	if (write(fd, msg, sizeof(msg)) < 0)
+		perror("write()");
 	if (fd != STDOUT_FILENO)
 		close(fd);
 }
@@ -48,7 +49,8 @@ static inline void ksft_wait(void)
 		fd = STDIN_FILENO;
 	}
 
-	read(fd, &byte, sizeof(byte));
+	if (read(fd, &byte, sizeof(byte)) < 0)
+		perror("read()");
 	if (fd != STDIN_FILENO)
 		close(fd);
 }
-- 
2.45.2


