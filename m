Return-Path: <linux-kselftest+bounces-14729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 857539461A0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F28D285ADC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4581537C7;
	Fri,  2 Aug 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/pvVRze"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACE1804F;
	Fri,  2 Aug 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615227; cv=none; b=ELH0Od8jbIOJVRIX93WK/jK/3fz2bsBuxRkpnuoANfFzBDOBncYq8gq9yQZlgPXDOGTTLJMxkMK5XN07rUpkzLfSe7XUnzSHl12skxHDBwa00UTqM6Nolt4ceYU1571OM+8T52930adolH8K7dNobOjeTSnRbicNVaXLIJ2EQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615227; c=relaxed/simple;
	bh=j8h7XhCKyEteM6lDe6poqdqPgBrFlH/RdQyOCg77Y8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1M/E5Rzov+w0QeX8ExmR7vZJstHPv3dV6KkZXcZJi7/z/9kiTi8zen7QNKn1r8x0xpkUXHkIqcr9WPgmZiWqxROzxV2wfk992Jo7moF/eEQWzYEunCwXDL0Hedo0NnaznV0d+axrtCNm+L6xBswJD/Dp91tbESzZk34+jKU3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/pvVRze; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428243f928cso33670745e9.3;
        Fri, 02 Aug 2024 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722615224; x=1723220024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0JpjSsDUZLlnrHPxd6uh5wY0N3Kc6o+T3hxT/GH7/Q=;
        b=I/pvVRze+gL76VgziVqKDlrwobJVerV9AM8IgpdIGG177gEPm9lvXnPOjrWfrwat6A
         QM/+SXA95ZGwg6ZS7ZgoBf/t/rByA4XFvzbhcNgab8W+HNZxxKW5Al3EpzXiOU0pbqag
         yeK1IykVGmxEwq10BnKWVyidDrIjwVgT/4pt71nlK0evXTBbXbpd7F/JUAtW2HFJvCaJ
         1p1k/Fizqu2/vDBXaRULQR7/XNgrmFxxhwDaZ/9U9GWs1O6U16XCJPsGmePau1edQ9om
         ICilrfij4yI8I6e9dtXNIW49nw3eRkAgkBSOhBeC5oPuZQ2LIDumFXpMTJZmSBkkiXjV
         nVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722615224; x=1723220024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0JpjSsDUZLlnrHPxd6uh5wY0N3Kc6o+T3hxT/GH7/Q=;
        b=l7ZKrgc3JWsEtpO9nt2n2QibjMEgRGDJG+iCY5sTWS+37dpbUyW6WxiZ1YgFz1HWUy
         K7Ndtk+pR0e7nsDFvr+aWDIO5kLafW6ZN+fXxBqrGK+PONARkDNlQziYx9VnBIr7tS7k
         Vn3GZC2PKEpKgW+XZmJiGPED9WchAOOGHCZ5tH3HSgO5mWQpn96ZHLksnIf4QuhkwBdz
         N1uTOOaektXdwyhkGE6B1gVboOflqDoAyY+D2t+0zBGcTaOhsiBfIvagfN/z1ViShcUW
         L7bYmNweCI7O9e92xxB2c/CjbRRH+jU0T8EN96CGyO7ZlgQvxGYFqyeb8dZ8puo3B5cz
         WVrA==
X-Forwarded-Encrypted: i=1; AJvYcCXCPfoCCedqvRKaSpYEz2qsVuote5Dbb9wOx/TWnY0PJviRCLtjLlkOTSJmrF1XAnVm3hmQwLcM/MLCItZ8IXmrV0gUMjDKq0jTnlM85qgKMrP1tJ230dRqGWyITzyex5QoWkT5e5H4twmxCYOF
X-Gm-Message-State: AOJu0YwmR40DQ434NzqFYRbFJ5O9s4E7MzvsnndXUXiUgfY7cXeMQpqa
	5joR0fhoC7/Ms3xsYLzKngZQFojrquScPKRPfuAcMlnCsWeh12Tv
X-Google-Smtp-Source: AGHT+IF7WRa+dVOmLMx2G0AjZOsSe/2/iTY/ycILqZasr8IAzUTvC+Fm6O4Wl+t9bljTCCOSluP02w==
X-Received: by 2002:a05:600c:3b94:b0:427:faa6:5648 with SMTP id 5b1f17b1804b1-428e6af2e25mr25443505e9.3.1722615223579;
        Fri, 02 Aug 2024 09:13:43 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-111-137.cust.vodafonedsl.it. [2.44.111.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64952sm100812975e9.37.2024.08.02.09.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:13:43 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org,
	gregkh@linuxfoundation.org,
	nfraprado@collabora.com,
	skhan@linuxfoundation.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] kselftest/devices/probe: fixed SintaxWarning for Python 3
Date: Fri,  2 Aug 2024 18:13:37 +0200
Message-ID: <20240802161339.103709-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inserted raw strings because Python3 interpretes string literals as Unicode strings,
so '\d' is considered an invalid escaped sequence but this is not the case.
This fix avoids the "SyntaxWarning: invalid escape sequence '\d'" warning
for Python versions greater than 3.6.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v1: inserted raw strings to avoid SyntaxWarning in Python3

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


