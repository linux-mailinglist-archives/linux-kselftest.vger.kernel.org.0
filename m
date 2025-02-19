Return-Path: <linux-kselftest+bounces-26930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28754A3B065
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 05:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3233C1895DDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 04:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77F1ADC86;
	Wed, 19 Feb 2025 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCfyH5y0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E51AC88B;
	Wed, 19 Feb 2025 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739939779; cv=none; b=YDcgbNcROEjVsORxi3Rq/rwErxSImcCq2OcSrLgKTLK4wJxux3LAa2wj4zNPy3Z/wz8Wu3IgpcAwPtDxhMGGvePmU4LHCyqBtJJDAd2Zz5+NXLDMDf3FTy2owSeoCaeF6O7jw24iRla8FK8Lo6gqSGzdmOEQXX+yx7t/Er08Xic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739939779; c=relaxed/simple;
	bh=N6t3dNDMECWgfwL5eXsEUs3zUEE/sHurv4seDvxqeLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Omp+ZhIiZSQJYfsG5GGDi1EWFmA+YFth8D8dLQ2i36+c1tOZ3xXS9SWHd2cHrlyrXyh0QvQaGBh8fTu7oo86Krp53+xxNHDjoO7udcxSZKjRHitwN1KJbVTb4q48ceJ4PUjTpMsJijheXKJ2mILeamcMXR89RLKvOZmGLsHsVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCfyH5y0; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471f4909650so22386961cf.2;
        Tue, 18 Feb 2025 20:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739939776; x=1740544576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxHA5MSEJJbIadhKe+0jUlM+MLWwvru75FvGSxIAHsQ=;
        b=aCfyH5y0Yea5YIuOlEXmNeJ/8pl8ij99RaD6fZ/dF9M1jX049YjoWO7CV41T6vR9c0
         aEymPUjogvQjuoS5gHKwbfDdb3OECp8Pj7iBpW0NwplRfzP24wff7bvgXctnlGldY6ZA
         x+fDwNRrRoG27OfZIShD6SAK/Mp6SmuM2zewcHPLlgpNpiaLHALt0rtQhHPclAmfTebw
         Lt1AwHWInLsBnGXFFVPwG4Or/Nv5EcLTAR4hVwuBg8RQeUuqPwTBAa0x27xlqPwzo9NP
         z+hP8U8m/PEbN6M94FoCt5o8iHW3wxzYm2PdyqIXtpCKoZSaOdYwGZBazQPgCHKEILrv
         9B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739939776; x=1740544576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxHA5MSEJJbIadhKe+0jUlM+MLWwvru75FvGSxIAHsQ=;
        b=ax9pFFmy0fzwset6Vj6O6ie8GfDIoLSJpvOEd2VdxRyd9Gi8p1sWQZJ3AN853oHPkn
         3ER5ic3tyVWUGOA0nk9WOjn75nuJ26MD0pm8Uo3cBbbXnwoM/7uVWwnWvFv9wlJ0uVe+
         OxFw3e/n/P+3Grff19T6xq4OoFAoGbtLbPDTiJjjzskdosYX//yAVS2S4UHQUX9LpnJh
         QZhtedmLntUGrsMy0wqAsov4uVJM/Go2JrdSliW2TzLWGdXiixB+Wcs8SxhhqyCkqNoa
         w45kJK1QWDRYbiCuxTZ9w9Ryy6usspBhRIFqLuggQFW+gXDBTt4dReh3nR95wsCuxCZk
         JX3w==
X-Forwarded-Encrypted: i=1; AJvYcCVG74MBftJChyD8t/XYJ5Ao970VN7nEUIEWPFHNWsFqwKxsQuBjlqLkCUyvX7kzaAm8EmY95gM3QlIvzLxozDnN@vger.kernel.org, AJvYcCVs9+0HAeRV6bo5Bu7neHdf6Ex0xrFCTcXAMh1sMVTgT4+4dEqK4NmBAEhtNpfkeEhVvXS0/1bTIK5WzY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiVsxhUY+3qS2sszc6EaMXeAmXCz9ZS40y12KZ0UdGW7fq6SX
	9s2/gEpyeR3n5LqfWW+h1gDVT38Lz0bPLHRe7Bt282Df4pcP9c2K
X-Gm-Gg: ASbGncuow1I9VpMmn6yoTrDmUeI78IYoCH6jzsVh/AQ+VTiwTFLpMT/aoQpUFk3dx9/
	L9z5Z1qmT4O+j65dDS+TzSxSqz3xwMs7a8zdpuAq90oUQWrISRKc3qPp40LWLq4FBPelFxt7Zgm
	k1Gf8Dbdp+xVkfhqsqy0fZ2tzfBg/nNXYyc2exQp8PBCpzZhLIUSB1eSd6X7mPhKPC4FIoTE4U3
	QztZATeUy1m02g4HGX7q8hbjRuQ2Z1OBGYb0pYCKILCDr0t/GxZ3x8d20z5t3UoRYJjmMc0XbNS
	Fluw/lpYWqFbImq4K0CWwKInVwVhlEXFxfvVk6e8oLjcB1/MuutHVETaDvbahFnlbvWWfrP4EdW
	Sfb78cWJ0oxzYU4pPRujtXxSf6WDiDZKeZw4=
X-Google-Smtp-Source: AGHT+IGXwSt2WZVIp7C3EFgkHYoFKJJZ/Tw+F2jXGT4/OkPTvJNwR1rSKtmtsKun1Y4gVglpNRaxag==
X-Received: by 2002:a05:622a:5c8c:b0:472:31:851 with SMTP id d75a77b69052e-47200310b42mr68275561cf.22.1739939776306;
        Tue, 18 Feb 2025 20:36:16 -0800 (PST)
Received: from SystemsProgramming.mynetworksettings.com (pool-100-1-71-214.nwrknj.fios.verizon.net. [100.1.71.214])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47202706a5esm13876201cf.61.2025.02.18.20.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 20:36:15 -0800 (PST)
From: Brian Ochoa <brianeochoa@gmail.com>
To: skhan@linuxfoundation.org
Cc: Brian Ochoa <brianeochoa@gmail.com>,
	linux-kernel-mentees@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: firmware: Improve readability in fallback mechanism message
Date: Tue, 18 Feb 2025 23:35:41 -0500
Message-Id: <20250219043541.122924-1-brianeochoa@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds commas to clarify sentence structure:
- "To confirm look for" --> "To confirm, look for"
- "If you do remove this file" --> "If you do, remove this file"

Signed-off-by: Brian Ochoa <brianeochoa@gmail.com>
---
 tools/testing/selftests/firmware/fw_fallback.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
index 70d18be46af5..cd1ff88feb28 100755
--- a/tools/testing/selftests/firmware/fw_fallback.sh
+++ b/tools/testing/selftests/firmware/fw_fallback.sh
@@ -173,13 +173,13 @@ test_syfs_timeout()
 		echo ""
 		echo "This might be a distribution udev rule setup by your distribution"
 		echo "to immediately cancel all fallback requests, this must be"
-		echo "removed before running these tests. To confirm look for"
+		echo "removed before running these tests. To confirm, look for"
 		echo "a firmware rule like /lib/udev/rules.d/50-firmware.rules"
 		echo "and see if you have something like this:"
 		echo ""
 		echo "SUBSYSTEM==\"firmware\", ACTION==\"add\", ATTR{loading}=\"-1\""
 		echo ""
-		echo "If you do remove this file or comment out this line before"
+		echo "If you do, remove this file or comment out this line before"
 		echo "proceeding with these tests."
 		exit 1
 	fi
-- 
2.34.1


