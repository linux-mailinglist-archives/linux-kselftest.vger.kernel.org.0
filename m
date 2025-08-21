Return-Path: <linux-kselftest+bounces-39429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C91B2EBF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 05:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F92D1BC7B2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D72E5B24;
	Thu, 21 Aug 2025 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVy1+VmM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40C4317D;
	Thu, 21 Aug 2025 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747085; cv=none; b=iQPkZzGlwwmxqIXsrNCcjcFA/LcmB7g3APpTV2lTYveOrD80XQ47QE+yKth53J1Z68iqXPp1/LijroO1atodMmSAZfZaDMQuTDALsLsapO7T1Dfw2kzJPuwcibFKxqASHra00ZJKbgp+TUc8qyoi38327OPjfXw4EsgUixP1cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747085; c=relaxed/simple;
	bh=a4YnhyBkuFuirVo+51VQJ8oQdxUJTXBQ9fdqOBz79EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVeWtqamqnnkg6U8WaBRWJSCEsWg+Xd7yAvxt+KPL/m5TsAu07wOI0HxB88vYnGPYswiSZcHQYm59cOWw9XR2R4wxsk/ruht7ESBEAbpx8ydOXhbdUXftS2qvo+g3DxBE2qqPlVo8H3dUlBE0C1fdHZB5vqqgW2qtu4XWAEiUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVy1+VmM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b10c1abfe4so8547501cf.2;
        Wed, 20 Aug 2025 20:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747083; x=1756351883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=icRsK3KTpWigO3BokxIYIH8/TdR1BM20AbZoHc5m7is=;
        b=bVy1+VmMayBrx3BUCOjSWEr6qIfVXvEocsOoFPOTi9Zo8tCv9t8JRtxai0mMU4W3At
         zP/B1X7SQcvnlUPB0LbRqFuajKIj8jJYyN6HXwm3eORMV09rVlg3u7sFVJ9Rai4bxLni
         O+nq1hBIB8VZVu+uNbTehg8vygfzmye4zdaDz5600o7OCwYx//zETi6VlCFy/byIaQhL
         S9ZN5Cs4BDuHlIwJVCTsvHoAZ076in5Us7V76+PT4qklS/vTaxaJ6PI4dNY6tDr3ioCH
         vfvsCqeiFVvvcX2mTv7wtzPEMvbnKvpsA6GYgSnDcmySTnBpiSTiciFxD5u9cXUltGDi
         NnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747083; x=1756351883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icRsK3KTpWigO3BokxIYIH8/TdR1BM20AbZoHc5m7is=;
        b=BanRLsOTYWgAUm63NDIz6Da6H80a7DUT1UxKreG8TbeG0QkmYF+F4qgAXR8vwupTiR
         ynXw6cPYYT0LpXvRDYEmmyoOqHa9O5qR+m1K2tTlHG+hDy0pwdMY+mrBIt7oBKhueygg
         5bHbvHmXbo2g/BFQmcrq6NutMOB6jDdQJzUUCs9H3Iof51Mka95ge1Pf7DAkxu4bWiBM
         L7LzR6J5s2G+9Ip0KclcyjnWiMxSwqdVCqoVrTzoztjJY7FA5PWMdIOoPbPbqM5lShEo
         Ea2ueXsRn9d8bBQRSA4Brqz7KCzmGaHNAenxVlS06Cnu1bWvTXUBdGx/Bzo1oBrTObAZ
         x99A==
X-Forwarded-Encrypted: i=1; AJvYcCUX6Bda3NoFu2jac4XB+uP0LjP03cKLTBw9Nkhmc3S2L4RC+ETAsJl2bX6UXlohbgby/wZMBk5MQvDwN44=@vger.kernel.org, AJvYcCW/e/bsh06dogaINi3CNw6dqQkNYMK1bVajkSznLbwVzW84+21tbQZIM+ilD1myoRrrisphNfRXpSNNREctTT8J@vger.kernel.org
X-Gm-Message-State: AOJu0YweqoaMN+1MkwJK5e/Gp/298RokCatnqgvLF/lQp6s8X7W1g51+
	WzqoEXM1To4Vnim6/TdNjsA1Y3UE1YW28K2a5a6udyMxScqKxH8AjjvviC8s9sDR
X-Gm-Gg: ASbGncuNV2OyC+BtQEgCx9FGkRm42g3VHFtJXtX60USp76f3G853f1LtrfpTdmM8Usl
	LUvUNnwYsBnwq5h5j/K3WekZpI3TvbcuBtWZF4sP9Isx9Fq8EAfLap0QaJmsbUVkBuUIc3VGkNw
	IFcSaY6LlHnJmka6yIOZCtcJ2BFFbLCvLxrh4uQPPBezuNesDB12brD7a7AQwQes0K4eG8GHSsa
	vOTzlpwxSdq3OxHi+3i9sDuhhPs86pLR2YRsouH55jDMVk/xICv28siiXiFYVwXL4yRO6wGGsrL
	BnTQnzkdA51dTey8UMJDB3QiBIf36JxVAthcjS0FST1KsKFuhBir5jH/GK+XI0AoDuguOj9T5Fq
	ZublErOSh24G7dAQv2o1yEgez5WhNWEbRmoRsiQdL9SRcWASyT5ECBAmLqJq1ZFERcC1jZ0Thzk
	A=
X-Google-Smtp-Source: AGHT+IH8BDknIEg8aOY7I0VpUcwOlM1TFgwrml5wA9EZ+EVgHVP56EFvVKYngKbQyG8yEXT2lkgb2w==
X-Received: by 2002:a05:622a:28f:b0:4b0:cb1f:e390 with SMTP id d75a77b69052e-4b29fa53d05mr6498871cf.29.1755747082903;
        Wed, 20 Aug 2025 20:31:22 -0700 (PDT)
Received: from fedora (pool-99-240-65-82.cpe.net.cable.rogers.com. [99.240.65.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b29bf0b493sm11703131cf.48.2025.08.20.20.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:31:22 -0700 (PDT)
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Shuah Khan <shuah@kernel.org>,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc/tm: fix typo on a comment
Date: Wed, 20 Aug 2025 23:29:44 -0400
Message-ID: <20250821032950.44054-2-albinbabuvarghese20@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo 'sucess' -> 'success' in comment.

Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm-tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
index f2a9137f3c1e..ea420caa3961 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tar.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
@@ -50,7 +50,7 @@ int test_tar(void)
 			"bne	2b;"
 			"tend.;"
 
-			/* Transaction sucess! TAR should be 3 */
+			/* Transaction success! TAR should be 3 */
 			"mfspr  7, %[tar];"
 			"ori	%[res], 7, 4;"  // res = 3|4 = 7
 			"b	4f;"
-- 
2.50.1


