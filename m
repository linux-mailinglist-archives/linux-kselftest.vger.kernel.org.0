Return-Path: <linux-kselftest+bounces-47125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F215CA89A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 832A53096CF8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF4F34C815;
	Fri,  5 Dec 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfQwJsZZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C342346762
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954764; cv=none; b=eHVWIKIuhJ3w1FaLJI0z+NSNLUvXzrQvOc96e6PnajoiKQU18zkUcqC362WPwXxq6ApTHN3M7FbVJ8X9U3NPm0L40E4DOCcZelcfBz52RrDN2oGER41LtzmA8BAfRi4yt9qSfXVROOYBopzgzTAL7pltx6W9aJRNvLrVAWw9LGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954764; c=relaxed/simple;
	bh=cB31pmWNA2px7ozTCQpqrnxwkRY3wOGmMDqxO5JNm/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5Z9yvb0D1tbZS4FaN9W4GQNDQMchyVL7T8flyaUAbD3KNeKTs4pErXOBcd8ho1iXndqL4KWsElE7wLw3qH/NEj+6PELbK+fidP1BKfKlUAeeNDD7Xmmowqxm6U4/SyiK11R0//fj0vQ4R+MSBtwwQrhG0nKXrO90PCc4xou2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfQwJsZZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso3755883b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954748; x=1765559548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svZn1kMXxy5/37Gn195RmY55SpZYbLuXKcgjq6f2gyc=;
        b=YfQwJsZZt8EeG5RqAGBuA5u5gBhg1ugiIn9F3uGvTiQMKOFqclk1jo2vOeJAOZKkXI
         /Zqq60gioILstAST97YWja/cjbCeuy1f59u+bGfbeek56t42pwW8rSMa4XaLJFiYI7qi
         toLn2qqti9jPuSz/5asy0JN3IVomPfBRFgkDEshrrgurJ+cgIoQFZtW/bn3rGd8eCI/y
         2i14X6a+bKdra7M5ZQJOaGO4YTawkah4oLdtf8gcR2fTrMjsg+VAz/P8A0u4NxYCWBeQ
         UVvpsIjtJSGDE4a7FGsg3aXls3BNqZS015JmwB+k+WXmFDZcqHKNGDYad8BY3r6idv+z
         Ud3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954748; x=1765559548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svZn1kMXxy5/37Gn195RmY55SpZYbLuXKcgjq6f2gyc=;
        b=qvCKKbYr7BbEJRX7Hq9qPr4IRx0PlxeH7E7YZoYsj3MUv4uStTIfHIVamCKv8JmmHg
         mRu4DXmB4xVJJXd/hFr/ew2UwZPz9Bwb1wlylQApDck9RVC6zKWMgQneH6DLPS0KUjZD
         V+HdlZ8V8XT6ETcK635ydPwNneiKN27MXJuWENWd/lVRf16MuxJ5t9SppyZ2ALhSanUD
         76Ec5iegZGmaNs2j+9l7j8XIneFWSi0i/2fi6J1pgm8uqgOhQoEwz+NG1jjmM3r4wta/
         5fLNSDzrh/FdteHhJHwPELugt+MwpC5Fdc0SA8LjOhREqcGUuv2Mgt44BAszJQhbce6r
         HX5A==
X-Forwarded-Encrypted: i=1; AJvYcCX9u2Pc41IMdA62xL097kiLjCf+J7fkbBb7IivdofUcU2p32BnUYfV/xS74hSJrYDv832kMithCCyK4uqZqGzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+66muhO50wKZ8ob5ZKkcfSh0PPenjb4F3NU7RBtFKixpBpkmm
	ODmPKhXmZgxGdNcY1PpGgEOYSI7nLhHwI0HFJ0wXWbIjVWOK0Xfunr7y
X-Gm-Gg: ASbGncup606+zudvPdzRworpF7nKmTHOJ/WPYe4gt7FcSRlcr8AUwZQicSObVnAxy5B
	nd5CZy13Q+6r75LAR8DGttK/0ocPPsexShbuaUTE1YXwmiv3C64xC9+XSVKq1BSCwrzCadPIpzN
	vJgjD79HIsqqVME0lMzrXCPuvNYQgL9Plol7G6vs0rN9kl1zFrA7/gVaOzc4NWNerkzF+TCdtsr
	mO05GGN+Jr6LtbaxCdjSBZd7O3gOvGk17wg1AqQyBA08kWXkdB+s/T54g9Qip69b56Q/PHNND/5
	d5ERJ1vMIaICAiuUhRyNhopwZdre/hUVBw7G0De7yhbTkMuojLRnvzSHtIVhAtsghl+LstFG4eC
	AMzzgDBbp0RqpclrJjUsUF63tTlAm8igq17cICGaWmM8nUB3yQHQRKQDHu6uue32uNd0k8OWRA8
	RXkhmQfAKRLkZW5LozEgzjEUY=
X-Google-Smtp-Source: AGHT+IGHDjpBTcigzNC5fmT2HMSl2OIXJF4Ntvq8YICmSN0m9lTSarMT6qdvBRwyf5R5o7dnkTdLEQ==
X-Received: by 2002:a05:7022:6988:b0:119:e56b:c758 with SMTP id a92af1059eb24-11df649fd93mr5077082c88.29.1764954747801;
        Fri, 05 Dec 2025 09:12:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7703bd7sm22124088c88.10.2025.12.05.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:27 -0800 (PST)
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
	David Wei <dw@davidwei.uk>
Subject: [PATCH v2 13/13] selftests: net: tfo: Fix build warning
Date: Fri,  5 Dec 2025 09:10:07 -0800
Message-ID: <20251205171010.515236-14-linux@roeck-us.net>
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

tfo.c: In function ‘run_server’:
tfo.c:84:9: warning: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’

by evaluating the return value from read() and displaying an error message
if it reports an error.

Fixes: c65b5bb2329e3 ("selftests: net: add passive TFO test binary")
Cc: David Wei <dw@davidwei.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning.
    Use perror() to display an error message if read() returns an error.

 tools/testing/selftests/net/tfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
index eb3cac5e583c..8d82140f0f76 100644
--- a/tools/testing/selftests/net/tfo.c
+++ b/tools/testing/selftests/net/tfo.c
@@ -81,7 +81,8 @@ static void run_server(void)
 	if (getsockopt(connfd, SOL_SOCKET, SO_INCOMING_NAPI_ID, &opt, &len) < 0)
 		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
 
-	read(connfd, buf, 64);
+	if (read(connfd, buf, 64) < 0)
+		perror("read()");
 	fprintf(outfile, "%d\n", opt);
 
 	fclose(outfile);
-- 
2.45.2


