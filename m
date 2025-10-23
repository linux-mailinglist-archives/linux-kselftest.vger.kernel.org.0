Return-Path: <linux-kselftest+bounces-43833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EEDBFECA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AFBC3543B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2242926F28F;
	Thu, 23 Oct 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0kpUtE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EEE23815D
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181236; cv=none; b=VsteVOtpxEyIdMxrfhuhCaUAopSkXnuy/h2xBmO+AvK+iy1iVooTN+4gYrVaxyq6rMw9RP8Jr6igFUwbyaqMnzP7s6/wooToX8R2mclVdCfZJmEaQiQxoGazfS5YRSn2E9xGy0Mm6vwjMldcKXod0GaMtJhI76sSc1o1tr+D3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181236; c=relaxed/simple;
	bh=A7Pia+kzD9m0J27kf4ph64d7fzH2Tfv7wW9zOoywfI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HH5ZDkFgSMBlHA3A8WKs5ATKQ9tjQ0YP/4AOH/LDusaBv3sfXJ7PDcG2nvk7rZEcQhHHHMGg4FpnrHvsK/bsxBCf80bovl58aeg+1l909z/am3p41BhIWSnBGtsvy7jewIY//QeuMC6o+gaibX3WEgUt3D35dknJcqgbnOYdwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0kpUtE+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso232798b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181234; x=1761786034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHVaMWRrmEBE/SxfIGFnLx0j8jRM6x/KUMvxwGUNtCA=;
        b=R0kpUtE+4xPX+wPqgen1bjgNVxcgtTj69D7Rjudq5oeMR3J07j7dqjIZJ3Q4E6w9X3
         vxgiT9sLvpbMjE9kt0MbO6dhkeaUBZ0cwmExCUMa1Zaeumg6ErwTP/2DwyFNatfWoWNi
         //SOtiIKYI/zFdcxuYzd8f3UTQmpvKeZ8UMPNofw2VxlOxqEOYg91/sxbs4lZJG/H7KT
         0raKiLZmfMmG3ON/ONu8zV9G76Hc7nnVVt2svrQA8tUeTig72vN4OYeu1hk+OBIc/4IV
         SduR9PA0tLVmF0Sq2zLAVJUecLj/UAwTeojbMNKEEMbQQBfEAnwN8Y9kyop0kFHjmUup
         Pc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181234; x=1761786034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHVaMWRrmEBE/SxfIGFnLx0j8jRM6x/KUMvxwGUNtCA=;
        b=KjWsF0m8VNCPowO8YlNXKFtsftKrAvDSudX2POje84pT+WQLEF8dAbdX1geQ77BnbK
         Yg5e+LKUNz9Fyt+m/SkFKLvljQUXXAMy8dfKc7WtSb+vF1inwaulJwa6g21o5cbk9pPt
         vQa1905dCo54EMPA1NMPllJosDxLoZShSUbnZpSkmAcHXRBZ4kp6Ov5G6mR835g+Iz0E
         lhOdXNNMQSv76LYG4TP44t+JeQfLTszSq9t5ZTxUiaIp2Yt13Pe2OYPCWVmZnKdSqMte
         T/rdkt0yReEMC0VCIGBftNtSbu03UG90q2ZY+5ozxBpOar7fRc4mFxN7kydPtudLcEaN
         G2YA==
X-Forwarded-Encrypted: i=1; AJvYcCWvKtYaAZjT79zF2tehsy1JGO/De+iNekWO5LFoq2S2fKJn4sWKooKDyoiHRV7i9x1CwJJZ6QZ91AQfxIfvM+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynkOIQIkSuHNliTdrhEkwax7uwnSbtnvcKw22hOLUuXpkd8Miv
	3xsovivznQS0E5b0F4k+OBLxbc86vyQUYO1wMG1ESWtZt/Mvks35IrJc
X-Gm-Gg: ASbGnctwcTjLqDCfR+Cue7iWzqN9yeN4VfUwlVhb5oc9yK8kx6PorXW2iKE6jhSoTOn
	sFkpYhp+mRkS2ud77pELrylcQbxtdh8tPBt6roai7ixZc2TAFxNUOZ9itqiKaC+oG0EAxZOP4QL
	AfNuWnVOsGDpvazTRrXnNoi1nJA8wNMe/65bN+ERBa+M1Zb6GIJj7orSZq2y9bTBs7La8Esr9X3
	RxwuVbvdWedDKKTCbZyErntMrv0eDzOnW6Z0i7R6uU9kVbu7IfqQMRda2Q+cbnHuhR6DwJvTy0z
	1l6FgZQVrkbtuSscZWY9AVskcFwGuo1YPzSxNAy2rHvKTdITvIPyUETztjo9hQnM4hDzj/WoV/k
	kWFSjogFIanq67mHya0ATILp/gsn2+ioP4TFhlD2zHBNEmO/wwij+KpFEFUnX4wyKoHonp3575V
	ImIo4YhTc=
X-Google-Smtp-Source: AGHT+IF9GCZ5yEahtQVlZaXsqCeQjg9YU+w5E/EIvNEWA8qffUUmtOI33IKw7GAAlLb31mw7tG5+pQ==
X-Received: by 2002:a05:6a20:cd92:b0:334:a916:8b4 with SMTP id adf61e73a8af0-33c5fbaab59mr766832637.8.1761181233861;
        Wed, 22 Oct 2025 18:00:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c0e4e6sm362737a12.11.2025.10.22.18.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:33 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:13 -0700
Subject: [PATCH net-next 09/12] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-9-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a728958c58ee..a312930cb8b7 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -541,6 +541,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


