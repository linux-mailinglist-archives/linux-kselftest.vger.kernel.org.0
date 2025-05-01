Return-Path: <linux-kselftest+bounces-32063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23712AA5AB7
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 08:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E03466236
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 06:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03ED1E260A;
	Thu,  1 May 2025 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkL72EOG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9D32C85;
	Thu,  1 May 2025 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746079422; cv=none; b=CqBUF4LBBJferKaLvFGL+2V5s19EQogXAz3cJzq7F2ujdGTrcgXW0yeTjn6E3cJXG7SdPL6c9OhYy2Qur42yNR2vfnMMcfpjVABhdhocm7x75q/MxeBIXVQjYcdRAw4BxQJARlyNfMVluHem2Xae5vCmKJjXEzy4IcU1ZRgm3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746079422; c=relaxed/simple;
	bh=QdEOV5Pvru1jHHk6ci8tH+dTcY2lMatZVsfSaT2A64g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thcXCMwxwXpAzSqOmoRrD8NCtbH6QIZM39U1iTOeZJLcs1Jiz3MqoR71/9MY/GQxxxSMgWMMaWzOPuMvhfW/Y2XUqSelRbZcIoeFJkad0b+xsmsi9mfC1dmtqZjQKm7BZkmYRafdrHgQEURHNY09QZS4PZKfXd7eC1dDshgb/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkL72EOG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so667236b3a.0;
        Wed, 30 Apr 2025 23:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746079420; x=1746684220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cs9IXrE62ETOAPmRdDzYqt5zC7Fy7UCTTkkCjs/8jnY=;
        b=GkL72EOGRPKuqKd9iHMwrHqe8fG317Fy16mS4CK1eyULQQH1vIF3B1tvAb/Js4spJJ
         UsHeb5kp+RKPHQZ/WWJ/g+jeC1goZEcSXRx9ypAijM6Kqz/5EqdEwQ0S4IUhNNsZrqrT
         4DcGkCbh4sgJgwDHAz1kdkrOHVzbxa6o3TzanDRxWh4/6BWEuurheg+gjtx72pHM/0oY
         36tpi3WKKsINabJBnvruCmhgH2P8YDLu4emCfNZQM9HVsOc+kJu1Kbcr/aR+1uPzRD3C
         eVJeO7VxkZwVNHA53fJLeuss/kml7YxUHXEyEFmce1H+biozdz/Jf2ymURYb0SN5UAjx
         vvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746079420; x=1746684220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cs9IXrE62ETOAPmRdDzYqt5zC7Fy7UCTTkkCjs/8jnY=;
        b=blOTfstJZ9qzvvUEnmYrt2tQRgQeIfccNBtGmR/MUXIIa0LzP18H6Cvk4USsrL8IMG
         0sxibKXvWisyyuFlOG9VOgy7ANmjj85HoMoW7ngIATwDjjLwFGR1jsKwrMpCUqByOUSC
         PmDfu57ULMYeCsPfHGemVe8ccxs2FHszLmJD59W1u8qEG4/9vEALxsVAJ/qgtrfWk8F6
         2adrxMUhGJ0ivt1QfYMvs61GAHq3ttvRANSa4MoyIgK1NqEoyLSIjXnsgOnerkyPBlEp
         DQueOSXApvcWJvEOrj49XpdJX3iw4426gVpezgIjQSisfAoEkUtsAB3YL0w49MoLdKMo
         mKGw==
X-Forwarded-Encrypted: i=1; AJvYcCVp+yT7btStOxTxPq2q2nm47sZNxrTmiNHQssZ+xA5gvt+ZfAjExDt/jfyx2CKso1Y9YubHsctDZ/edI1Yd4k0=@vger.kernel.org, AJvYcCWb/VTVUcEC31CshVAQnSts8eW2i58LAOKWRAJbpzNdmBtLBM4gsq5Hf4lc6gDXN/RmQEkCgeFp+i3HDGW9fho8@vger.kernel.org
X-Gm-Message-State: AOJu0YyeVw2oL/un6Jd6CKqtU2/HbZEeb+EzXZFyxSN5sEVauPLQM+Up
	Yq51mTqg4v4dJC56PiltPZJ01V+bdh9fJj385sfVd6b8X7IqsmpO
X-Gm-Gg: ASbGncuT4YJQQ9QP3HVVyp89lrVJW4aXLIRhuhM05F4IGFIaI5T3Z2siIUSoIGfQTB1
	b/2IERRH9yUFEx0a9UjyURdxiCQgFlQgNAPvERaA6N7r6g7IHbX3WYBXlJyuHYk2tTI8WoEgEF6
	lSAitomy5Cta1iQY00C3eIp93VtIeFYCa/jAGx/Mu5RG8Ynt3+G7Hfak+uXaWrai9Wvl5v35EIz
	5BGzl0NLXQYJlELKXc+qTgHtwvr3lIt1y6zhO0fVF58g6/4WNUcGd7PmsY2PslO9Fic7lPxcQpn
	HbXLYbdFfbr5X0/8jMJ6jz8IZWX/s1XeZcth4lSfmOeiQwctQSfYrvwr6XQ=
X-Google-Smtp-Source: AGHT+IF7I91yRefEnmOp0LueYRZIfStQCvLhkfwf08/5KNWA+VIgQkH5BIu/Y4c/cmm/+rrivYYIww==
X-Received: by 2002:a05:6a21:8ccb:b0:1f5:591b:4f73 with SMTP id adf61e73a8af0-20a89325382mr9809228637.34.1746079419723;
        Wed, 30 Apr 2025 23:03:39 -0700 (PDT)
Received: from localhost.localdomain ([103.77.0.13])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7404fa1f88bsm72337b3a.134.2025.04.30.23.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 23:03:39 -0700 (PDT)
From: Ankit Chauhan <ankitchauhan2065@gmail.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Ankit Chauhan <ankitchauhan2065@gmail.com>
Subject: [PATCH] [next] selftests/ptrace: Fix spelling mistake "multible" -> "multiple"
Date: Thu,  1 May 2025 11:33:29 +0530
Message-Id: <20250501060329.126117-1-ankitchauhan2065@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the spelling error from "multible" to "multiple".

Signed-off-by: Ankit Chauhan <ankitchauhan2065@gmail.com>
---
 tools/testing/selftests/ptrace/peeksiginfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
index a6884f66dc01..2f345d11e4b8 100644
--- a/tools/testing/selftests/ptrace/peeksiginfo.c
+++ b/tools/testing/selftests/ptrace/peeksiginfo.c
@@ -199,7 +199,7 @@ int main(int argc, char *argv[])
 
 	/*
 	 * Dump signal from the process-wide queue.
-	 * The number of signals is not multible to the buffer size
+	 * The number of signals is not multiple to the buffer size
 	 */
 	if (check_direct_path(child, 1, 3))
 		goto out;
-- 
2.34.1


