Return-Path: <linux-kselftest+bounces-17802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C6A976187
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 08:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00291B22223
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C28185B7B;
	Thu, 12 Sep 2024 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5/rRESD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7B2F41
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122687; cv=none; b=HWzVKTNt68owA/d/d/4hSjEuz2hDyyhYJIJ4mrAtpnnNLmRDnalcB9iFVlyQo/Mf0iy0L+O9YCT2nPOqdRH4NiIjo0OTb9NO7BgLuZIMJRxcQAUmOyo2cB3Qlvw/8AIhxJofcY/epCyskbDJJkVQmjLK1SdTnh7awAiMJDRBFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122687; c=relaxed/simple;
	bh=rICUziB6M1nqe34g/DSkBETJu4TjDQ+3xTSrisT8cOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFPFibKeYTRAo+Np1rN5aMCnvNgXhX5BPJbAK8hZcSzsOhB92nsmY+KCmOOsECeYTO/AUX3oZTXGnz2sNWEMyW128rwmRbnZuu6/wW2IAkqIf3nkkEJLKKkf+lR45iCBIndSRSI++Q6wC1wXHXhx4yq6g5wgYk4EYjy5TFKLneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l5/rRESD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5356805847aso106821e87.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726122684; x=1726727484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KomP7G90w5XiTxBfY5n2KIRLtbQEtmSrnwcuWwZeCTA=;
        b=l5/rRESDP9LjCFOV6e4nNL8rXBt5/TBxWtzc35Jf+APqTgSISCfeSC5hdNwAmqcNoq
         UdqVFfzqkRhlRJ7MdMwBr+Ht2Y1VtPCZoRuSW/sHDS0h/5uhjNAViMMJ66hX1xEEDbd5
         2OAKDcI+hzW3WeFopfyVGXOtbekfodjvqfkttOOczVPOdw6a5sfLUhCrH0a/LSmoVlXo
         2OSak9tt+xWPg9TOQIkAErH5IVCmECLK83VCSLeYbTaMbowPGLPaHdn5biXpXSHbvmDS
         sq1cz2W1v30CSku2YmjQ0ZLUbjvqNqM1zHLD3YTbgZljEXVo3iMk5Gr07qP7Ocut9Dzn
         j8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726122684; x=1726727484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KomP7G90w5XiTxBfY5n2KIRLtbQEtmSrnwcuWwZeCTA=;
        b=ZcayZzK8cR8L9462Mtetohhd6gPh/ajEr8VVo0HU9vkdSLWaCF90bKisi5pwrMMjg6
         BgAhwGybAt2E1vSBiYtbQnsRI7fAU3Af8wJIa7ry5l08/0sc3nIPlUC2hdjbVAExJ2vv
         qCcZN4f/dPwkTWyDUHQ0JbSj9jp8IXRauNJKz/yES1lyy20dARxHW2HNiJZcoVm8z0YP
         wuNi7sRKch4h+OHfubLTrO2hduiIkVjC4DRX4zgCcoTjjBCYhOrI894oPa+ApvKNHac4
         hV3OciWGA4A5yb39BmmSUhIXb+LkbWhAQwAf7VImyaatU4linQY7oXP5ZW5BtEVRq8oq
         T3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXv29wi1UWDQYkRS3lA7AY4FX9OqCkqQ/El6JeTJJGpaUBS43Ya/ex71LnlA/tm6CjvfXE1KIGvnIim/dgslk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzWSAEpUeBO3uBkzrPrEC6I3H6JfGgwAjEGCG/JCFvl/ii4GCy
	HSQXKhlKkd+OnMEs8MPBkuJDH2icjpVBBU9xWw7mQCLmi2cHqobu/6H1EmV07+U=
X-Google-Smtp-Source: AGHT+IH2hkCTeR/X91NdGpik4tEsXEvkiIUGn0c4AHSX61UnYwePZRohOaArIFwge+uJMjMRc6ltPg==
X-Received: by 2002:a05:6512:2828:b0:52f:c337:4c1f with SMTP id 2adb3069b0e04-53678f5988fmr268684e87.0.1726122683861;
        Wed, 11 Sep 2024 23:31:23 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f870c3csm1869347e87.104.2024.09.11.23.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 23:31:22 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: willemb@google.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
Date: Thu, 12 Sep 2024 08:31:18 +0200
Message-ID: <20240912063119.1277322-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b7df5477317..fc3681270afe 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -64,6 +64,7 @@ TARGETS += net
 TARGETS += net/af_unix
 TARGETS += net/forwarding
 TARGETS += net/hsr
+TARGETS += net/lib
 TARGETS += net/mptcp
 TARGETS += net/netfilter
 TARGETS += net/openvswitch
-- 
2.45.2


