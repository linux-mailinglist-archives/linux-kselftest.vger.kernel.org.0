Return-Path: <linux-kselftest+bounces-2542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1FA82124F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 01:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4E71F2269A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 00:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1401378;
	Mon,  1 Jan 2024 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJFuefE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3B7FD;
	Mon,  1 Jan 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so10195118e87.3;
        Sun, 31 Dec 2023 16:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704069736; x=1704674536; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNayAcyeSS7UzEfvEIsyAKjy82p2vcQPeNI/yIuxcsc=;
        b=ZJFuefE+Tw4GZKawJPUq1ncMb1tKBq9lpvkoS9yvMF69ogO/bvhZ82fvD4E/WSGz4h
         42Hf6z0xy5s6wGrQYeric02UC1DS8UnNnrf96ChEj+GIHg7zlZHDG91GkXr54DVrnLKK
         yPOj0+GbVCY2Dl5a59+G+3M3z0MEHXYzr5akRs+2iEL0iZzb5q0jvaznfeF4O01CsPT9
         Ch8jo0gYi4shtHwXnEU8J3094r8U5bpSuwHSXDG0cScQupTGv19ex5uOmX1cAU9ye5Nl
         QRWY8vprNJG7tC25rLS4tCEev1/QirMi5FLMxyjNKMjv+nI6Uipyfxf4txsOMLuWHF97
         +kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704069736; x=1704674536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNayAcyeSS7UzEfvEIsyAKjy82p2vcQPeNI/yIuxcsc=;
        b=VthBPM31jBBm7Cn6jbqi/s2MvYyqymH70ypZ48od/8VdhJjLIwXOospxIREMTTW3zB
         IvV+DiCp3P4+1WB/n22Ic/3e1u5FWmBJ0KCUvcT5z0jD0Kxx8swRV7MBYiuhlPwsSzvm
         3bZBZwgbaAx4fr2y935cfjI6rI80H9WZuRFN0sPEKUkswK3fzySQ6cIgVFVVkYR1CM9I
         F8tQZiGCMxtG4o4EjY4b4/sgBM21AEr6U8phZirj66Q3NBqws9rmAbkiLobpA/0BS33I
         rjGZ3slpt7FzrW3piaV3fPhwMgmYSPTmIeFhG6ts8PFBcXBIiXdTwdjCmDLOtHczu7Gq
         7nEA==
X-Gm-Message-State: AOJu0YzkMTnPxUE/D2jKAEImTN2czoqdVmbhijqq9FDjOWY4uA9vJt1B
	SFIL4nXpi8SWqRbXZaSKRw1dse+GlAmm1pG7GRA=
X-Google-Smtp-Source: AGHT+IFQMcMdytTspEdQ52pzfAN2w7M+KjpTt40fMNDotNtbcROmSTJFTwZ6fISgCmvmjYfBFK1sPw==
X-Received: by 2002:ac2:5eda:0:b0:50e:7b04:7bc9 with SMTP id d26-20020ac25eda000000b0050e7b047bc9mr4598454lfq.23.1704069735711;
        Sun, 31 Dec 2023 16:42:15 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-14df-0f70-3365-7192.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:14df:f70:3365:7192])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709062ec400b00a234585cc79sm10458605eji.188.2023.12.31.16.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 16:42:15 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 01 Jan 2024 01:41:46 +0100
Subject: [PATCH 2/4] selftests: uevent: add missing gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240101-selftest_gitignore-v1-2-eb61b09adb05@gmail.com>
References: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
In-Reply-To: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704069732; l=672;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=FTideY+2Ty5z2BmysJS8/MTPbWQQN/7KoeUf+uWDGbA=;
 b=73tLtuXTnTTyvZMwhqVg1PLdmClRCw0jFcfm29BAWBtCgwA6E8qiTTuVedx3dymWN36nTPyex
 lPC5i/6qJscCodOOfo5ZisMdfNq9IcR31XpaPCxZbL47iPikfOotFSS
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'uevent_filtering' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object
as stated in the selftest documentation.

Add the missing .gitignore file and include 'uevent_filtering'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/uevent/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/uevent/.gitignore b/tools/testing/selftests/uevent/.gitignore
new file mode 100644
index 000000000000..382afb74cd40
--- /dev/null
+++ b/tools/testing/selftests/uevent/.gitignore
@@ -0,0 +1 @@
+uevent_filtering

-- 
2.39.2


