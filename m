Return-Path: <linux-kselftest+bounces-4600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E99853F0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 23:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C457628CF78
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 22:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEA76310B;
	Tue, 13 Feb 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmnedAhY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8962A1E;
	Tue, 13 Feb 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864419; cv=none; b=K1aEsIc7im9WGFdOutYzbIzSNseK7YznGEUPXVK3Fno/iukk1prHDgWuxeX2vnlDVjZiWIY7saMYVTnJdbbsocsYeL85ZV6z0TEI8HHpF4W8vFzW8hhOAg5/8EZwd3dNdDRAy34y4A9tuQQztEGccPGys+ShuGVu1l2smlDQF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864419; c=relaxed/simple;
	bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdfG6lwwNFP2g00FBCocmlndNhxRn2wFsHSSvkhuyJLI/7qdzZ3ot6alum6QFPGIDbroNYZgWiLMsT/w9MQ+ID9IloFEz95IZx3ApE0qJJUSDxXmeqftBV6iOuXQv7LF8VTFKtd4lfQHxh0wOQEKdK2Ip9am92r+d+PwBkHuIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmnedAhY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3d2cce1126so57642266b.2;
        Tue, 13 Feb 2024 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864416; x=1708469216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=bmnedAhY8AdYQOkl5+J5I4/b+t7BYH9y/AfdMYsd3WhAzAIyRFx/+fSTdDx8aTFTFe
         1S7pKApKRbPh0pR6F7bPpDXEqoprSMt1TrTbhrA0XkvVDe+dnt0z5UQM+v5NAgJUcapy
         G1YsxlJvoJUO0t+YMWccjV/BnZ0Yxpg/sVwg1ZUsoRAQQmBqkzj6ubKRQAFv3Dok6Vps
         Ls6fNMd+qQjJRuptaBfMIjf7Uvk3aLgcMrF2Y29QyS3v1vWDDfDrFmHb1ZbMs02S+jol
         VT5yYJkQ7NpHE3fVQIj3zqf4Exd/dS8i/Bg5kSuVoqrT91iw1+hJko77pHG1rl0WDCc7
         Pmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864416; x=1708469216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=YBCbbfT2vOGJuDdEqXphLC8Q03PtgLe0MXhV4y29jrLZbuXmJmYJp5+XyOQqF9TOdH
         RY7oYObsLw/YLi211dnXAeQWx/iBrQBOvRWPG5j/vVIH9kl50u4uXbPC2M4uN9+5KQdz
         GzmolJHvCZkZYUaXFxx1SqX2pQ6cTgOLbJH1YLLW27myeWiJoOWquZgZMIS7YU7M3XPa
         +WjnRyJsV5Sn4Uf4aOSfngpTMuRpHiQwvCVxMETizAOaWUDcpH27++JRmkaeR7VZF3xQ
         dVF0bWZmajpfqfcjMC5aWrz0KLiH6iwxD+X4GwXvGBIZXA3cYrpoUGT6xCDYSuASGaEb
         +fEA==
X-Forwarded-Encrypted: i=1; AJvYcCXy3RVYdASfaStOmjAhwWKmzMHfYQqVs9XoBj6f1vWfbkrdohKqjHBPl+G1u1EBIOaNyUVwv2yItyG2p6jKEAN5Sgzh6fKVbmelDZE2hZAt
X-Gm-Message-State: AOJu0YwWoD9L5YyCXlzTCmX6WDiY8inLwLDWsnXXHJL1v9xnvcnkvM2f
	FRgIg2gd+5WkbPValyTs83kAwEAiWVqJ1t/4Ogxf1KewRheOavOS
X-Google-Smtp-Source: AGHT+IGDjbSTZVGf6XhPhYYRobLIqjM5KZUMdFhaPnLuHPwzJ+FOpG+mlFwMNBRZNk+Ge4z3+liMaw==
X-Received: by 2002:a17:906:688d:b0:a3d:2406:7bb1 with SMTP id n13-20020a170906688d00b00a3d24067bb1mr435101ejr.39.1707864415721;
        Tue, 13 Feb 2024 14:46:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGbZvO09HFGDdXMwinSY0I2O7u4l5/GFpE8z8Gibi24oPw+o4BEYbTKS5GmBCIrWSfLQyePDgBdl65J5iRpzuesUDL6QM5PzO3xmpcq61Hq+1Zn8cLFkYfuIoxLnizKs6ADSixycoFL72c1cScI8kRlT2cW7vdkQVQZpS8U/7mw+siZEzehdN8/OyMYmU4fDFkoCG6jBBM2L6uo0+IekM9bea2wugmuXo7FcCMDJxySqsoJWPDBUbRKnN0Y7CIkPG/TWIr
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6ae3-bc23-bc27-2247.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6ae3:bc23:bc27:2247])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b00a3cd41b3c19sm1700077ejg.199.2024.02.13.14.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:46:54 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 13 Feb 2024 23:46:50 +0100
Subject: [PATCH v3 1/4] selftests: uevent: add missing gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-selftest_gitignore-v3-1-1f812368702b@gmail.com>
References: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
In-Reply-To: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707864411; l=672;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
 b=eTCCR9l0lVgYuuEidv5Q2RqhEiYnJXGjE94Hy+kQeWaRSBC8PLx4LXPp2owbrLz6Kwg8+XL6C
 CWUPQuVsS2+ArRWIFHah8HmnFyAeXll+G3JqED6x+XEqoAxhCKaKcci
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
2.40.1


