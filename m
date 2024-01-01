Return-Path: <linux-kselftest+bounces-2541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE382124D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 01:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB4D1C21CF5
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 00:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3F803;
	Mon,  1 Jan 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6I1teJs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCBD7ED;
	Mon,  1 Jan 2024 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-555526a060aso4652846a12.1;
        Sun, 31 Dec 2023 16:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704069734; x=1704674534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AYZpP7BCQ/ALzVCtud2dlXfU8iVKtoE185gnWkWNIE=;
        b=M6I1teJsP+e1JXpZ+B1ZZV2x31e0Tt0t2iVaIG/7HhY5xTXNvLuXWJ0PmO+vtMpJuZ
         O7Q3Be7E6oyK+cZqTJxxlW55zY6l0SDwtSR7cVNvjRVs1LLiD9Yklxvi/Gzhp+J0YiS7
         SSaMTOrqp+4KWoACAGk0OKLn1mr0gtxBXXVT+GfS56z2lUGDj4vnxGreugGosbnrhltC
         lyj2bAX9IbZTe5Pl9Eu6MzEdIvIcoP+eB3IQL9QGXRsE5/3NZO7/2/BxAdicIGKqjBkW
         WyShenl14fzSSyOeevPBVLdDCArO2gYVbbdGbhkyNn2I00FwtEq9OuCgXsC7hZk/cX3M
         7+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704069734; x=1704674534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AYZpP7BCQ/ALzVCtud2dlXfU8iVKtoE185gnWkWNIE=;
        b=TyFSoDf9M+4UYfEouymWqFD9TQHl3sdonmU3QqKMtuVVnXFPf3x4ANrALssafM0jys
         5aTCojq0uPy14DMftPiOsnyDpt8WS2EL7AfDGqtaTecRBEPTwiaoy2Bd01iZvc1oQjuX
         YbuVVfww6A5Mu0WqW4qESJazp4k4b3tH0w4XIXzkPUQX8lgwoz6PihaNbb2bOYIGLky+
         SUa2VPEn7xZSd/iOTDMRxijGkiTCdhQD67UMOo6XNbVRGKDUQCK2yaLbA1s/R8naCI7j
         HwAYTSDVORV7//rqDN167+r7UA23zsmtVo6/KR8qxOxKX+gACL0XGAk+NJ4Q3GrzTJhp
         zoig==
X-Gm-Message-State: AOJu0YzvHAM8KsC+eqdfOMxigD6zrG6m7XCOOTG2v9dtgq67mHVnFRyg
	lHwNXymBSe1uUbxXtQWV81FkrN1l8txT9I9v0NA=
X-Google-Smtp-Source: AGHT+IH4MZsnGWbs0MklRI1Z1CEJ8xlgNBWj25xjfXJWgAKmWWpEioUhx2ylgCtXvMAAcuuDt/w9sw==
X-Received: by 2002:a17:906:7395:b0:a28:153a:5e3b with SMTP id f21-20020a170906739500b00a28153a5e3bmr84971ejl.29.1704069734488;
        Sun, 31 Dec 2023 16:42:14 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-14df-0f70-3365-7192.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:14df:f70:3365:7192])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709062ec400b00a234585cc79sm10458605eji.188.2023.12.31.16.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 16:42:14 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 01 Jan 2024 01:41:45 +0100
Subject: [PATCH 1/4] selftests: netfilter: add sctp_collision to gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240101-selftest_gitignore-v1-1-eb61b09adb05@gmail.com>
References: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
In-Reply-To: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704069732; l=733;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=jG0eUz/CvE0LO6+Ucsgfk5PAi7I9oL7LXSQLnNWTZ9I=;
 b=4tkvDeH8dEgV4Af6SaKQoDx8WAWl/1/5R3k9xod/arpC6E3mOukxtKe/J6OPCKZsEs/40bI6H
 BIkPd2SEXicDyAoJOZNy5a5iN4bgPJsWD1AJBcoo62s2Ucr0cA6pTsl
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The commit 'cf791b22bef7 ("selftests: netfilter: test for sctp collision
processing in nf_conntrack") did not add the generated object to the
existing .gitignore for netfilter.

Add the missing object to the .gitignore file.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/netfilter/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/netfilter/.gitignore b/tools/testing/selftests/netfilter/.gitignore
index 4b2928e1c19d..c535754dced2 100644
--- a/tools/testing/selftests/netfilter/.gitignore
+++ b/tools/testing/selftests/netfilter/.gitignore
@@ -2,3 +2,4 @@
 nf-queue
 connect_close
 audit_logread
+sctp_collision

-- 
2.39.2


