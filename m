Return-Path: <linux-kselftest+bounces-14709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE68D945E09
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 14:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05381C21A72
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC51E3CC0;
	Fri,  2 Aug 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPMpFxpQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0991E2889
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602744; cv=none; b=PkZEa4xfgtxfroKfz6IuSMK9RuE+S6ud0f2bHRRKL/fb0qJO1ZIdkIr4uxy8TbaC8NUw8CGSi1Sy8G2jXGp9srSH/nelBw17Z657ulzOOQYgwk8IIIKjrNjKguAaewpQgeLralkwJEzCK1iPzFAinRU2aOe61TeKLUJ/BU1dlYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602744; c=relaxed/simple;
	bh=198IHW7p/T6PhidWJlWdPVwESeg8JNSFLNq+O29lKZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0xioYkraNdH1vs3dgdQlK1R48E0t/14TjvL0CLqm0vNsuaIEGpzxQcd/lxhsX2EuZGCCQTiDGdhDm6h9WpBAAcMAomk1zV4VwRRkw+fGMd/kTFL7s8IaqY5PI5nXIvFmWeTIGj2nw5WfMvx59JaIwbpy07s9h9oIMGZRXOMji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OPMpFxpQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so11753495e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722602741; x=1723207541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzvUY6CqajngImU9C1U2y4kXw0+36J578NUjQngUD0U=;
        b=OPMpFxpQ+X4l6hURXeGCnLy5Wre29BWhsKB3WCVv+0Yos54XQ3a1DXaAP1kkrRnRGp
         xBJhRtn4gnMcZoyrZ5k4GrWelkPczDlioxsvkspdBaxPqYWUKWyQKQOXGSSLkOXk2Wjk
         7Du66R+SFH6HFtAOaJH2NKTWkCy002aBBv/mMBNVfxKJdsjpnWnfrnqj0QGHnzxhk+NZ
         rXh/CVyXsJB86qI5GhaaBQdHiv+iJ/2t5Dc8TwR6bBWi3AFFpV6/g6cSaClLx9fr5Alk
         z1hA+gWu90zseR/Ecw04tjUxJw3EdsyzYED/iGLVPfsh8Ax8nHpHxnAlh+oEp7SJc8Lt
         9E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722602741; x=1723207541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzvUY6CqajngImU9C1U2y4kXw0+36J578NUjQngUD0U=;
        b=FtEr7bZQuPUlmsOGIzEBmo3UAhtECOdYE+NJImqmNGO9vI67p9QYYORj9ydmENiZ0B
         AmA33/X60iMZBRCEdqV2j5pzJR+sWl0kPULWm4T+CzTdKdiCHHKRanpnJZSQL5BQLE8I
         joB7iz4oyqG5nQRis0RMq+nuPMdlKkJ1uEwHj1fSxrXNLnmj6K7ShdnDOBfLMA3gFNEU
         0o5JsBV2cMS25WEtM64LFKVgLuOb8y9Uih0o/HWUGM2M8ZLorNuPJIuQxw3uv8SWR5eF
         exedtIAI55zGE/m1ayO+L8x2j/f8mX+1+u9dujRlIzqOlLWfXUSAzIABTCu7uamZZSpA
         qfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuGUKiH776nRGHcM4eDbxggTtnVuVkVJP/lX6LG60T8MZ6IZ5V61thgO/3/XCs3YV58TX23GN/9cOrt5+Pweg2RN7oDPeNygkmyfdmVqrf
X-Gm-Message-State: AOJu0YxQG1jIH+s1556zzp845grVzQQnBVyCUs6q5w5N4SBmS9pv6ElF
	tz9i9mbK1pJKsb75gWc+26XsZXyWnk0hix1VElj9LIh7BM0mZcl7I8O12HdAOtk=
X-Google-Smtp-Source: AGHT+IGKqSCamMxPEhPZg2DpP7McBM0k60aQHtIDoeS9/S1zbWrD4kLItzjJHFXfCo7lgU/gypkFzQ==
X-Received: by 2002:a05:6512:114d:b0:52c:8a39:83d7 with SMTP id 2adb3069b0e04-530bb3c7d5amr2168649e87.52.1722602741057;
        Fri, 02 Aug 2024 05:45:41 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba3ccb0sm216230e87.255.2024.08.02.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:45:40 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	shuah@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] selftests: rust: config: disable GCC_PLUGINS
Date: Fri,  2 Aug 2024 14:45:36 +0200
Message-ID: <20240802124536.2905797-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802124536.2905797-1-anders.roxell@linaro.org>
References: <20240802124536.2905797-1-anders.roxell@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_RUST depends on !CONFIG_GCC_PLUGINS. Disable CONFIG_GCC_PLUGINS
in rust/config file to make sure it doesn't get enabled.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/rust/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rust/config b/tools/testing/selftests/rust/config
index fa06cebae232..5f942b5c8c17 100644
--- a/tools/testing/selftests/rust/config
+++ b/tools/testing/selftests/rust/config
@@ -1,3 +1,4 @@
+# CONFIG_GCC_PLUGINS is not set
 CONFIG_RUST=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLES_RUST=y
-- 
2.43.0


