Return-Path: <linux-kselftest+bounces-46946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32308C9FF70
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 17:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77110302DB74
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C303557E7;
	Wed,  3 Dec 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRXTajov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A235581B
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778653; cv=none; b=Qg7gunnG8uJwvuaw734veVMJNXP4tTIcWq9BRMjn1r+AubWsV719LeFltziE6eKQORsfbdabDilMLjArH4RvTsOURZxgi2BJdQNNfvp3SAnr7qTwlQKdRlg0JPMmZPQHVAGXYaJEjZK6AvR53dFJB+EAY9mtrl32lSjD85HW9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778653; c=relaxed/simple;
	bh=m7wvzK8n8mmykCuV2D/oT25NmE4Ik+3Vyjk+3fY7zpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T37Iv31ITKQ1qjIjmnnSe/dUHjb74MOtsXjQVdc63SN8rA/2deyWvJD9haLyCNWjRnDBXBZ1MDgsXe+Ly8Awk2QVcFE0//uo97V2KF5NfZVOyZA9C4PAbbd4SzuRhU3o6D8ftFK0NxBisjHuML/Ok4C4x5RpgK8Omc3BEnRsN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRXTajov; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ba599137cf8so493630a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764778650; x=1765383450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4FWWbLf21dMPxikVgw/00BlP8I6uMMKHQua6OrQ6Ro=;
        b=CRXTajovdAFeU+/k0XtNZPM8r1NvDSP4QqxGhhc4qA3ZJkgNk1QI8LrCQkJcGyNoKI
         qTqatJfvlxsidg87K2HHRCxQ+uycYgaVH+TeaYkv34t086sNEH/O5dRR+g89Hz/t8eVR
         86ku/xb3HCjWdm+brS/ksjTpiPlQFdBTOkKbpS51s+w44hSavIc3UNNwYENHYeAcUBl7
         2LHWPS2kNoXiAHFq8U1juOZhGL9v0TsYIRbyBCePc/9osnlcRYKurj1M6MFDTp0ar9a5
         8h8Y4HltOwJvI2MgbIB6HI+dRjLgIFgznKTJBG3+x2Fy9cO8nVgQrE9gtDk/WpeNr1Gq
         lO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764778650; x=1765383450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4FWWbLf21dMPxikVgw/00BlP8I6uMMKHQua6OrQ6Ro=;
        b=UvipgSDbaMH/jLdKANBSBE+b9c5tnsiUYXpvNE+KUHjNwUOzZnwDr+kuC0qSfOLONR
         erAphjdVRuY8A2dwuCns9XyYZ0qV3gTM9KCsrQHcoY/rQ6qLHKD0clzGG6XHBXQHvyxX
         e+8k7Y4sFQnhkeaYbLZk/Zdyzng0HRlrGBFCwZy1d8vml09iB1VPeY8WAddTW487Z5D9
         FSIcMEv1f8Kkh+MN/3QLNF58lGx73Cd6WcGL/iUv2YCPIOgOa/cZzxOvtmjuDNtNnP90
         N6dsVWWJdsIarXkVCm7U1pljgHZSswMeseHdUghFktflE3cBpHf1/RfxWyHYNkCFM30H
         MqTw==
X-Gm-Message-State: AOJu0YxH4MPH9GSJBk3QFsxQ4XjhvC25po8n2tXm7w9+6ieX1Jmyiekx
	QwXNlCaeOtjGB7UNncs6CIND6u4Ag6HjftvNQBHjuNS7if3hhAcQZQSJg6bhdw==
X-Gm-Gg: ASbGncvrjn62Vf8F3dpNcKZj8pf8TfmdpU3GPocqMEw0M9URcBCFlj+x4UDaOpzVlxE
	NTvO111uqVE/vu7neFP9au/mesafvDdT/ayLU2GcO2C1gJCv/1+p5jVO2bEl3IjhKz7K2E2YxLU
	BVoVYb+wrxtIejy5dtXjkdWpWXPFqVbEkGfGfSz/PL5td8LKoHC/TeKeQqkQRk0KKub8EUmfW8D
	uee4Q+LDqzwzp5p4kCN4IAs7UuD/UvSD2S1EYInnxMtk0BzlHl9SeZKiGjyQE/jf6t8wpbtG87P
	haRVXR42kQsushe02Uk5ljRpCOKhacYSf6wYJPcxc+KQPmRfA81c+FPfkERdWj14Ph5crtvoEL4
	alyVTUnrQhZoPNDgu4+AoTCW99titZXh0haJLuIJI2EWq9mn5k+XUNMeY2bfnfX7l8JRyem8IVA
	sY0yxHI6a9G2yUjJPuA4Y=
X-Google-Smtp-Source: AGHT+IG0wf1CCleit4IgAC/R6vQH2LL9zvgHeUegQMPxsBffDavDd2CxDbNg/AX41E+TrhXK6iC8Ww==
X-Received: by 2002:a17:90b:4fc3:b0:32e:2fa7:fe6b with SMTP id 98e67ed59e1d1-349127fdf70mr3304990a91.14.1764778650381;
        Wed, 03 Dec 2025 08:17:30 -0800 (PST)
Received: from soham-laptop.. ([103.182.158.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34912d1765fsm1117975a91.9.2025.12.03.08.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:17:29 -0800 (PST)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: arm: keystone: fix deadlink
Date: Wed,  3 Dec 2025 21:45:32 +0530
Message-Id: <20251203161534.37414-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binding file 'keystone.txt' has been converted to a DT schema.
The current binding is located at:

    Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml

This change was made in https://lore.kernel.org/all/20250806212824.1635084-1-robh@kernel.org/
and merged in commit '20b3c9a403ee23e57a7e6bf5370ca438c3cd2e99'

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
 Documentation/arch/arm/keystone/overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm/keystone/overview.rst b/Documentation/arch/arm/keystone/overview.rst
index cd90298c493c..bf791b2fc43f 100644
--- a/Documentation/arch/arm/keystone/overview.rst
+++ b/Documentation/arch/arm/keystone/overview.rst
@@ -65,7 +65,7 @@ specified through DTS. Following are the DTS used:
 
 The device tree documentation for the keystone machines are located at
 
-        Documentation/devicetree/bindings/arm/keystone/keystone.txt
+        Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml
 
 Document Author
 ---------------
-- 
2.34.1


