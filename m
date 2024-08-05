Return-Path: <linux-kselftest+bounces-14791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DEC9479F5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 12:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CE71C20EC5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B451E1547DB;
	Mon,  5 Aug 2024 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqxfVvDh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7B13CFAD;
	Mon,  5 Aug 2024 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854281; cv=none; b=uaKiaLVVZJsZSMWdhJ3zUx0KcLUbjs+bExoBkXv3j53xQ3So/vmxgQJRdjRLau0BMr0K/5B7j+rq7C1S+YaNa8vi7RektjYpvKFXj4rQvwh+mMBsGGLpZrcRSuf4CBU+csWKZoYUbuDv6JYaSfYEtBxEW6tLq8LvjA0o+b7KPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854281; c=relaxed/simple;
	bh=/L+U9FbrdikimI3DRTL457yT/JB6HgXqIbnp6SX/S6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mVvDD2tEf8rnH+irUcgcA6I792evVtkwsnCGBtx/xDF6nTQP6bJaXBZ1xDf3iFKLMrp1nlzE2pRaHTn14n2yy3qfIiat7+ZW7Wv2gzGbGAXO/a8vu8v5Cbsy3nECkp7bhsgTYf+LDW3NiJ0nehYHsf5WSS1aCxQf/yeUhESGwpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqxfVvDh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so951801266b.1;
        Mon, 05 Aug 2024 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722854278; x=1723459078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0KFjt2jSVlj6oBnjiTQlukHgWUqVqy0s7ndwfYzMwY=;
        b=FqxfVvDhXZtla/CcvK9NLTwqu03J/BvrvW6qN4583JIw2javp0Lfc638zrrDymB7r/
         pLyaTgZa/ashW3X1wH3PbKyQWMKSKgFAO/rGfPYrKl+RCjVCM9fHhJPc3V56IWMf5zwG
         ZBOGylaZvBfp1UiGRKNoLOnWrh/Wu7VikLfL4MM+GscgT7VIdoBc7jco0hipt563alJ7
         u3bBnSBt+f7c7AHpB58PcUNT1QRZ7YHyC3iu/ilMGrfpEPlFWGufVWFA3c35GdDT2ueX
         wloJhcQvyYNY15q1eIf9KNFfMtZTeFTfIguEtX02dFHIbNBQX55EFWO2OkWPPQR1PRoq
         a47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722854278; x=1723459078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0KFjt2jSVlj6oBnjiTQlukHgWUqVqy0s7ndwfYzMwY=;
        b=LEkaKhEX0+QSjdfchexFFtJdeHVxCrCrpv1/Wvu+uHCIWbU6tjjbJSn2guavcK0SL3
         WSUZVb71mdiUT6gXqiK4wje7cHzPinZoYnaU/AyYOtqO8MC/jJQmvBo5PZCWuqDlhuEF
         k8aH94VEYGFJaEeIrfZ3AvsxmJI4nScWGV0BvW2BvABMXAxygSocbGu6G6Z/0sSsg0Rk
         jLCZ1JaxqkSuXuOLPOW38UKaGcOzRU6OYuvFWrEQGqJOytKuE9OYOGox8yxt79aF7aNq
         WjdfXxHr2C9g+GaSTUKNFk9+XG2H3zq3y1jyxPGOFYXZRjh1/nDLtAa1ZDAe/9UEv9/+
         ncTA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ8iL9rseKwtst0+NOKpT73DrnwRIIadPBDtIFkcXGcLFtdsYegNwjKGLtw0n6DcDYQ5ILAz2Ern4iiJXkhe07JBxaAAOX5qRNf/iLdFiz3nfsR6jVhGn1q9819qT3I+Hbnor3gPOnkvp1l7VW
X-Gm-Message-State: AOJu0YzGxbcjaT+MxgtLxEwAEZIZqmwLknp0C1QWNgGCwdzTo3ZRaTOF
	/X4uahq9WS11YY1fU4NGRgnL6tm/kt8BwKnXFLTJfqEmyozxu6ww
X-Google-Smtp-Source: AGHT+IF9Lu1Jxzs3cJgtMaUfd+K3om2rFfXNQPcCN/rXeTlClGg8Vq+ijHaiD8cNXiSBiNeSZp/YPQ==
X-Received: by 2002:a17:907:94cc:b0:a7a:a960:99ee with SMTP id a640c23a62f3a-a7dc4fbac60mr864480266b.32.1722854277845;
        Mon, 05 Aug 2024 03:37:57 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-111-137.cust.vodafonedsl.it. [2.44.111.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d42680sm436635966b.118.2024.08.05.03.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:37:57 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org,
	gregkh@linuxfoundation.org,
	nfraprado@collabora.com,
	skhan@linuxfoundation.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kselftest/devices/probe: Fix SyntaxWarning in regex strings for Python 3
Date: Mon,  5 Aug 2024 12:37:37 +0200
Message-ID: <20240805103742.10844-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Insert raw strings to prevent Python3 from interpreting string literals as Unicode strings
and, consequently, '\d' as an invalid escaped sequence.
Avoid the 'SyntaxWarning: invalid escape sequence '\d'' warning for Python versions greater than 3.6.

Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from discoverable buses")

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: Imperative mode description for the inserted changes, added previous commit tag fixed by this patch

 .../selftests/devices/probe/test_discoverable_devices.py      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/devices/probe/test_discoverable_devices.py b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
index d94a74b8a054..d7a2bb91c807 100755
--- a/tools/testing/selftests/devices/probe/test_discoverable_devices.py
+++ b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
@@ -45,7 +45,7 @@ def find_pci_controller_dirs():
 
 
 def find_usb_controller_dirs():
-    usb_controller_sysfs_dir = "usb[\d]+"
+    usb_controller_sysfs_dir = r"usb[\d]+"
 
     dir_regex = re.compile(usb_controller_sysfs_dir)
     for d in os.scandir(sysfs_usb_devices):
@@ -91,7 +91,7 @@ def get_acpi_uid(sysfs_dev_dir):
 
 
 def get_usb_version(sysfs_dev_dir):
-    re_usb_version = re.compile("PRODUCT=.*/(\d)/.*")
+    re_usb_version = re.compile(r"PRODUCT=.*/(\d)/.*")
     with open(os.path.join(sysfs_dev_dir, "uevent")) as f:
         return int(re_usb_version.search(f.read()).group(1))
 
-- 
2.43.0


