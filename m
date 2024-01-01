Return-Path: <linux-kselftest+bounces-2543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF0821251
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 01:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4290C1C21A6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 00:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1771368;
	Mon,  1 Jan 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRfnou4S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E442EC2;
	Mon,  1 Jan 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a27cc46d40bso106417066b.0;
        Sun, 31 Dec 2023 16:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704069737; x=1704674537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vi3Fl/4NbXUZxsn1BAnETcMuZoGfiYvQSkYfvQrRy7Y=;
        b=dRfnou4SMTJWwIxWgVw28iKxvRlwwaH0hgIcNIjHOqVV2aM0DsHS7CiKAxiYOjy+FJ
         LCPPKYJCeax043nS2QPk1FcDdpT2VG5YpAS/BsUOjo6Q/qXuuJ0bUofNjOtVsVCitTzP
         ney+/vz3HX8aGap8KVPXYf/LYpy3YnHInh1TP+lJ7FiZZMeQlLhl/ia5ofTkGIIUMwUO
         iFmYRs5HIVVm8/KKp3xEvKERrVssuEqKA8mUNqFvbzO8wIaZmEH+YTJ+dyHz/7oK4mtS
         mW+KQAEFSwdFd0FrN3esq4WVZgzr1CtxAPCUQF20zvg/If/U3+Vbd4DgoHkeOptoGtRg
         PdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704069737; x=1704674537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi3Fl/4NbXUZxsn1BAnETcMuZoGfiYvQSkYfvQrRy7Y=;
        b=kwZ5m5VQrw7mDHjMbt1Uvl8poWPNS4I62sX6M3gVpT3VJmmdwcas49/YP7W9koGYJS
         zhnA8U354vydegefaf+dNDw2H2vwKlTD75tKpY1edlIVcgQ9MeyTrlOibmK4itAktMxt
         JMQQG9NLw62NZmA/pZqbyvWCa3NrbtnaUzJnnazTLrnqJj5UHtQOWkGW1FxERr9110ED
         yhYXWriGDrqzg5RIX0QA2vZRJZ4bE8rf+3i4zqUAHE06lI92deXmUHf+oJrz+skgENdg
         VvJMVQufRD/IYl3s6yWQWde1FU2R2t7nh4UyTg0BhVE2/UeMjk788+XFxSIWh205Wa/h
         uVUA==
X-Gm-Message-State: AOJu0Yx0IduOBqdq3pZPxhpU2QYiXLH0OeC5VqzzMoSwa4caZI+dDUz/
	zrbuXdz6TcUhFCJEXgu84bsQL6tWXl1sP0etkNs=
X-Google-Smtp-Source: AGHT+IFNcgJ8J4n8Tt28A3s0IIhZrn3P5dx18iHz4fWFwmuid3u2ZRC/PHO6hS4IjNQHw6XvNfk/Sw==
X-Received: by 2002:a17:906:738a:b0:a27:6cb4:c125 with SMTP id f10-20020a170906738a00b00a276cb4c125mr1209087ejl.138.1704069736817;
        Sun, 31 Dec 2023 16:42:16 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-14df-0f70-3365-7192.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:14df:f70:3365:7192])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709062ec400b00a234585cc79sm10458605eji.188.2023.12.31.16.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 16:42:16 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 01 Jan 2024 01:41:47 +0100
Subject: [PATCH 3/4] selftests: thermal: intel: power_floor: add missing
 gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240101-selftest_gitignore-v1-3-eb61b09adb05@gmail.com>
References: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
In-Reply-To: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704069732; l=738;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=8e9A28K0LRDxIY46YsxrUOEoOdMpWfoXGnrNBOqHKtQ=;
 b=dyp48KsQgS65IxrqmISM02b1gVBStcOMStIJCz8l17U5QrIp6WrheElduW2Ycov73IiDzd2LF
 TaeC5Gl8QVQDkXraxmjUyS7LiF7t46BtSk+G5AwSS8yIGJDB7tv67vu
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'power_floor' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object as
stated in the selftest documentation.

Add the missing .gitignore file and include 'power_floor'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/thermal/intel/power_floor/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/.gitignore b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
new file mode 100644
index 000000000000..1b9a76406f18
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
@@ -0,0 +1 @@
+power_floor_test

-- 
2.39.2


