Return-Path: <linux-kselftest+bounces-14844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25989948EEC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AEAB25881
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4270D1C462F;
	Tue,  6 Aug 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXYKC7aV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8251C37B1;
	Tue,  6 Aug 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946511; cv=none; b=fs4zoDHlHzMqQsfiB11wKoKABREI1hr5JD2cLlUnWXKkrC18sLOIiI3V8H1l7TDf+h4HV2cG4vPzgFiNwcQB/DK2h1BAsLiCW6IhFMzqR4bhaI1lRbe3MUiEnxylkxlm1NEJ2Wuc4m+xCZa5DEf/920JMZLmbmAUfWNq3G+eQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946511; c=relaxed/simple;
	bh=cOqmtWfTBK0u1WWQNUtMmi61uipL38EYC87Q8yvgKz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BuJXI/cFsdBCAM+c/C0UXEnqpomHrwU9T1uRILR4iU65wB3KIRLbzaII6OPom5AOur4bHUnoZ5sk5QHkbP8a9xIIQbhTIxswclw1Dpwo/+j8l46lyXEmZxLJ6iO9nIl1UAzYh3jaol0MPvvJonqfyEOr8x86T3hb0amRbmZu69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXYKC7aV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so520809a12.3;
        Tue, 06 Aug 2024 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722946508; x=1723551308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMDVTwpsfm5TGltEcOaTAt25VYKpAYuNcq5xJohq9/w=;
        b=DXYKC7aV0htRNrQY15BG2bdtJoUja7F23k9RLZHWO09Iq+SAYcPqe5HGn6y707RJVB
         e0B8HoW6qj9bjguPgBXCXT1hxHuJV+H+19p1j0wytPhgxztFgTXj3DSPjLihx7xK7j52
         6uLk8krYZN4CNm7329K79EnhwgA0+kwMMobGxHxCPRr2NXOi22uaRO7yBq+8Q+K2YTio
         N/ZvHxqVqq+Lr+O6xeb0C3/rNCviOPzV8D3vw8F8RPXqn+Qv1pY8mcRL8rOv9LKCYZiN
         FErbvMBiHL0foJV4WG8tgTxIkRFTveZmQlt3qquRsNRi5sY/7tdxtPzoDzVTFUfqfZtd
         EX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946508; x=1723551308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMDVTwpsfm5TGltEcOaTAt25VYKpAYuNcq5xJohq9/w=;
        b=NJMNfM6hvocMiK1HU1QAHtoJxxjkbDiuX7Ew0E9dvBhppxPUATt9B1wja00u/DXpE5
         sWSIVd4AF/Lw3iMCwWv7MEzVUh9Gg6bEgq6rSPhVzIl097NYxwbmnQpAqCBRl24YqoYE
         l1dDZ1/sBmMofc8WffdK6ztVwxuYIpOSY6F7Z1JpSr230p4hg1wLF+xlQR6n9MSx70g3
         HbgkQDFAv261njTr+luPfGL1xJl1mf6rS+yT/nGp4u3XmS8RmZrlAe/1QwJrxR8nTvpq
         LLkxshcR83vuu30rH/VU4is+pdweIQyjxJdWtTpzI7EWCaMC1mLN/BtQT2XD1S04Janr
         Fmzw==
X-Forwarded-Encrypted: i=1; AJvYcCWsywle27G7n3nXMXqm7cLhbN+trTicmnTfkVIZfu3KQyLuXA8BaCDHvvBDAj7ZTe73T3xwrJ3bGz7O1z09gsR39qD/juCojqlZR2xJ6z0YDTTcFr29eMDAwh5sFUyQ947JVvjgqMJX8fc3aHI2
X-Gm-Message-State: AOJu0YykTz3Yrl2qp5GWLVg3OhghFqh45DMiojoxs1Zherj56dCoXtf6
	tFJ22fpn7O+BwaXT/PmZEez58reCIH4uNu1jghjDZnw90GbVhX5K+TVV8eSY
X-Google-Smtp-Source: AGHT+IGpZFavK68rPoVc8WkHrwsE4HEGO85Mv1ILVeKCmcZnhT6lTO5Z9xejgxSrjfKxHzLgYoqMIA==
X-Received: by 2002:a17:907:9707:b0:a77:c824:b4c5 with SMTP id a640c23a62f3a-a7dc4de2d46mr859352966b.18.1722946507517;
        Tue, 06 Aug 2024 05:15:07 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-111-137.cust.vodafonedsl.it. [2.44.111.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm405263166b.143.2024.08.06.05.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:15:07 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org,
	gregkh@linuxfoundation.org,
	nfraprado@collabora.com,
	skhan@linuxfoundation.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] kselftest/devices/probe: Fix SyntaxWarning in regex strings for Python3
Date: Tue,  6 Aug 2024 14:14:50 +0200
Message-ID: <20240806121500.51337-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Insert raw strings to prevent Python3 from interpreting string literals
as Unicode strings and "\d" as invalid escaped sequence.

Fix the warnings:

tools/testing/selftests/devices/probe/test_discoverable_devices.py:48:
SyntaxWarning: invalid escape sequence '\d' usb_controller_sysfs_dir =
"usb[\d]+"

tools/testing/selftests/devices/probe/test_discoverable_devices.py: 94:
SyntaxWarning: invalid escape sequence '\d' re_usb_version =
re.compile("PRODUCT=.*/(\d)/.*")

Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from
discoverable buses")

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v3: Reduce changelog lines lengthy, add warning messages
    v2: Imperative mode description, add previous commit tag fix

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


