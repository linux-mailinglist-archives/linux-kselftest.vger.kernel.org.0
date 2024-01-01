Return-Path: <linux-kselftest+bounces-2544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539BA821254
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 01:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBC52829FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 00:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FB96D6F8;
	Mon,  1 Jan 2024 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6ZGuOh4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9B17F1;
	Mon,  1 Jan 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2358a75b69so1443672466b.1;
        Sun, 31 Dec 2023 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704069738; x=1704674538; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MIyRqpNg8iU5aNWWXLwieBYTbTtTgQZK6pX4EGC3fI=;
        b=e6ZGuOh4eFz+FWIK6EHOBM/dRiG7Zj4W3JYL9lNJz0g2hFpWuXR3ijqVjGXis2D1+k
         CuFmpdx8pXY1tjaLDCY/hs1x7tYZJe07yCbV+Rvi0DBXoJy+4EJ55jS2DKXlZb9NdAcq
         lSqdFPtHfdjm7S2pf4wR2PUgzs1zZUCG4fF8YGmttutwCYL7+DJc+eV1zb+89daQgtb7
         IjhrVA2oY+pckSe3w3JuraK+aPe7pYlDTVMN0Z4Gjw9fED+dXOU56EvkXipCnowC9mRh
         CfGMEt2Y7mgUn7WhZ8y3G+jwNzHK8Afa59WQZj3WsWhN9maCNDGKcACtW5OgWACrUWMg
         BjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704069738; x=1704674538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MIyRqpNg8iU5aNWWXLwieBYTbTtTgQZK6pX4EGC3fI=;
        b=N8rwZxLaMcnDHVo2+FaQ8COKEUjFxdopNomsyLPzH3z4zw3qAKrjRo/T4QQ7M5sgm8
         ZucHyOA8hjF02nsJNAb5KUNM9MRNBzZxV4MROOT5iZx4+8U10MxiwE4lYUkzymgHwXXo
         Qq3R3ltt35Xokzf8SMsOTub7ue0mGYNrdbDo5WqfDhVEuZNo1mXRwaNtFCB/Re6839lG
         IEjIIRqfPHirnu37Af+hMUFy+Pli32ELj/JFz/iULt5eWqs76nUQUDTQKnKZa/bbiYzT
         HmhZdT61bRRHbi2FCjOmHsgYZgVbU2SP7vfopIyu8MZLuXwvpIlTkPVSjJqzcOH5Olqd
         m5kw==
X-Gm-Message-State: AOJu0Yxy/4fZXkQu4aHnp6/0snkoZosL0OeCsaAkJmEL4qWOwv94EPQ5
	6e9hUGXRdhnbD+PODJYLRnmzPaWze8vrj5LhNCM=
X-Google-Smtp-Source: AGHT+IEY+jEwx+dpz/ZtUC6PKNif0VLghh2jEruW4YUJHre/wus92vy6/HCYolXF1UMtjfGvs9wa/Q==
X-Received: by 2002:a17:906:1609:b0:a25:cc77:8f95 with SMTP id m9-20020a170906160900b00a25cc778f95mr15223183ejd.32.1704069738095;
        Sun, 31 Dec 2023 16:42:18 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-14df-0f70-3365-7192.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:14df:f70:3365:7192])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709062ec400b00a234585cc79sm10458605eji.188.2023.12.31.16.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 16:42:17 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 01 Jan 2024 01:41:48 +0100
Subject: [PATCH 4/4] selftests: thermal: intel: workload_hint: add missing
 gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240101-selftest_gitignore-v1-4-eb61b09adb05@gmail.com>
References: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
In-Reply-To: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704069732; l=762;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=KHCYYPKImTM1I0dOv+4kaN/fmlSwppsnuFFQNBxFKIw=;
 b=r1c/nN+UE9B6tEVCWmERuWGLqxL8+JymbbrHp/E3xn7CjU62XhKPh2CRpIJpy0YgnFfmNMDHq
 x+xPoo2oJtiCGIVhg3TI/STFwjR9j2WjxR7MjXT2TkclRoVctwLJfxC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'workload_hint_test' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object as
stated in the selftest documentation.

Add the missing .gitignore file and include 'workload_hint_test'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/.gitignore b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
new file mode 100644
index 000000000000..d697b034a3a8
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
@@ -0,0 +1 @@
+workload_hint_test

-- 
2.39.2


