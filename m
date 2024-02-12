Return-Path: <linux-kselftest+bounces-4530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0809851E0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 20:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7D41F217E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1184C619;
	Mon, 12 Feb 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8nGuiqO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8888482DA;
	Mon, 12 Feb 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767025; cv=none; b=QfPhpsQgAn5iBIdsqIqqcCiy9aLgYpJ1qWKYu86XDEPNuC12qDUkIBg8flF5ZWpHF4jV7OKxq5FKnN8tekRRPeolNkbx1e3GplghPTEjJjbdAXUNe20TDNeiY3l6pyinG1HCbefS7XY3xwlqb37mutKqVraqYte9zdowwJYSj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767025; c=relaxed/simple;
	bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5dzHr0qwHmKBdvtTmHdvkQoh/CXZaAjerc6CXHA7vBjxy2gG+WUVHtrkm2glSFPjxV4w14WOuxJ+wkikicJs4EqlGA3hESKE5YKF9MdzTAyY1ktgdrOyneX/Wp5N2phPr8lseobScMyjKtromMaQ+AlYBCGLNMjDRxXBzmZQjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8nGuiqO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3122b70439so464207466b.3;
        Mon, 12 Feb 2024 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767022; x=1708371822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=M8nGuiqOLJ53T2C/4TS8qN1ZLyA6anO3H+5HEHwGZKGQVxnabXw1v2c2boSyn3RxCW
         282kvnkqaUlO5iu+8njyM3Q+IOvI84eJfbcN47Qg7cPI/iBGXPtiNuMWWX9eA8BhoUm+
         ZrASzSfiJ5msal4kFEHDcsgWo/mC5nXI7EAFYPiqJfFXhFy1MM+yjq4vQh9kayGE+9tv
         AN89DZ4xiRptOBGQTgmyBIydOPMHQ6t0Q76HeK8iKNtjIFnztISyDHC2DEtvcnP/WxsB
         pGJP9WdstcBbMD95CB1vV7++htMI4+16b1BRuu3SIu3lRuKVee8WHxiJ6E01jwxS32bd
         7Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767022; x=1708371822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=XcpJdeBDb/NiP3QO0jzFJtoNcEGYUpBGRMpgycHNkmmwI1G2rpL7uewxwyaztc4hs5
         5GINVL7bxPxRO/CRwpeihbCoZc0qOXB/deTEeGsk9VAGDUiiOajZ3IIzZeU/AGU7zzjU
         K/xX7LUbCORv58Bk/pJYeU4IVC8a11M1wjsHudqEAjFXMQIsJtRU25p+jICukdDWACKm
         IPQnD1mNuHjX/ZZtib1K5+h3kIwplasZfnkzTKD8QQaGe3qY5k6Mf5BtIl1fH78lXScn
         yDQAmiNgUITTco2FB85zC9lPBhIu55pfaJEFsFDK6OxeWzDNx/5ZG9kSVehF1yANKIIS
         8KnA==
X-Forwarded-Encrypted: i=1; AJvYcCXG0UaSpGOzuBRZHbgN0XXc0Vf0C5FCB43UQ6Io6VJjHL2ACcFQbRLxX4HLulcBAdraF5ALB6CqrmDVpKz8HsEM2uvQyTrLyWLg1CcP
X-Gm-Message-State: AOJu0YwPLIFpLkOAXXQfuEjV2z6fsDp7pi2CF08NepIotTezdG1cye2X
	/OP3oJ9sA691H1FCSqRPzOrucUl/VxJ0MZCtNi8Oe4baxB2EcPhV
X-Google-Smtp-Source: AGHT+IGQ2Hlg20Ix6udElAAhia7/RYqGaB5W7gMyncHzPWZu9MivVdviuO0XtkfyYBLBr6dfK1jyuA==
X-Received: by 2002:a17:906:395a:b0:a37:bbe7:6002 with SMTP id g26-20020a170906395a00b00a37bbe76002mr4980042eje.19.1707767021712;
        Mon, 12 Feb 2024 11:43:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCd5I8WkWEB5eJ8OYq4fBxYWdA8Rsc5Og7yMBj6TTTCf1OuuFxQ2soRvncTE+4cbggtdeTjQ8nxAlBpR7cyihsReU/phIrdJnPPKDP0is0WE+FqLjB5lhWk1KZUKpL4YziQdymynbqPIklve16cpzXC+8I6Y+GnpofCQ6LCeeJA7EqAwud55ipVgQnvZeF/xVDhmIHAOgrRdNyON9zhdKIXzBdCdzbTEX0A4cBG+gnZA59wwgNGnXaFBxo500UjNXZ
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:41 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Feb 2024 20:43:38 +0100
Subject: [PATCH v2 3/4] selftests: thermal: intel: workload_hint: add
 missing gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-selftest_gitignore-v2-3-75f0de50a178@gmail.com>
References: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
In-Reply-To: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=762;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
 b=g520wLOJGZZbI5OiA+HYqXQ6c0dqGB7oNt8TqHN6f3Avab9z+XsMtJS6mGmfLkivLIvsPO89I
 XcSpV6/A7xhCzTxrlRiq083v20G/kBDnve2MXn2pJI+eQ4keZkHisUB
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
2.40.1


