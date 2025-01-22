Return-Path: <linux-kselftest+bounces-24911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACA2A18C50
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 07:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4693B3A81E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043A619ABCB;
	Wed, 22 Jan 2025 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZGn0T+4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543E18C936;
	Wed, 22 Jan 2025 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528657; cv=none; b=eCFhoT/6HvYpnqP+gysa7ODtOo5W2Qfg3HCUWsOzQr7s8erZxL73FdjsamTfCZk/71F8mtjdIBf7MPnzH8l5+1sbdjCe0yxCFxFiiUWUTovv8kji6pbrDeNPmM7zSSp6A0P/0g7GSNetI06TIpLd2x98jG2APORdja55tLFe9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528657; c=relaxed/simple;
	bh=ll18vXyJoSZUrCfIEz1sxhp89TO3IMYtZn8Sqx8eEk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSM8+Q4827nNjIda3eWEZNc01Xi4OuejnfIViBBfkcYh+3szBouaWB9slMnJ3vkDpwIKyuHpozXH8s0yHdKhBYGB69QPV3Z7h2CI1z/hDYhzB7rWOUA0CdPzfJPT4axVm12DLXbcMhliwuVc63bY19pAgkumxoq8o3VHb9NjbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZGn0T+4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so5001602f8f.1;
        Tue, 21 Jan 2025 22:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737528654; x=1738133454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmJpaq3a/A5O1jFcLHLDDhdU+j9AgAL9atbgwnpJ+6M=;
        b=dZGn0T+49E7ZMCjQOVvWwHoGcRMIAbRCV/6H6fbz1uitJXqd2Oqv2V1n67hxqarBnt
         N2SpejTWjYVChv7l/DIuglDqPi5xgvKz04A3m4OlHwd15EIhWm7CAASgQPdUs2iqkaAH
         gyTVBKNS3VGCdXgJfNoTRoVUZ7d4Gzwr4iOPXM206Gu+so3vqxwuT+SUBQh/W5Zvlj5v
         WC3ZyMlszkY5crbhqSLGCLdXBnho1otcwxe/9q6whWewIgTp3J+mPeeVDOCJ+FNnssF7
         RmC1WxOMtRF2XKJh7hL/Vf3GJyeT1f6VDp+B6Iivm/Xziv13f9IHmxXuVgmGjS6/LkJK
         aCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737528654; x=1738133454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmJpaq3a/A5O1jFcLHLDDhdU+j9AgAL9atbgwnpJ+6M=;
        b=rKaDUhdpim7Vx3ZZ+2iW+z1fRpeG7TcI4CawOi764UVmO7a/EM/vAfnGPdqMAH36gq
         6b1vkjK5INcbk+0cbotJ0bv76lI7kzxDNE3jQhAdFvkgHGREyKT5gCaX/OHpUh755LKG
         IcsMLVFEveKaVeS8NT6BhwwqVK4XBBSLiiqRULDZMuc1Rxc7+9+V7lucLH8+0l7Lpm7K
         rxiZIqOznRKAF891apOZa92qoqeJpAwJBqcbKnXqqR481gY2u5hdLRuWEEHxmwa2PTf3
         z2AcCtlt+6Xia7pZoOO46IYFMaDPQuL3W/+Y9Tr0oHKtjJpZ0M03Uea6HVtcIkOaIYbw
         cnEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZiDA3WdMZj01enWciFXoTMPe0w13zAjqmFz7dBV634HDL/9k78Vz2YUPa8nyIijnkGHBA0fhHZK1VjZ9/0xKk@vger.kernel.org, AJvYcCWpGhYzPJNxxGHQZdtW/XQ1fTfUt7jb4g4yoIY5l/ti5092igvt75BmSOKVcDv6gn3RAxUQl3cj8RYnKLA4@vger.kernel.org, AJvYcCX7dfvOo6spdIvxFGqrUgQ6V8vef2ey3jYSAm0GUBklNVX8/NbB8DMhUq8MioicDWeAUrpiYeJSO10Z8jKr1eU=@vger.kernel.org, AJvYcCXCc2qjHD6GECqfC88VJKfk74VN0lkdCDBjZGdM/nnx+BcsAr3obfmUzUjF4mMgSR/y7O94jj7KHE1nH3dfF+Jfv5cTHfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Ug4O4xeIWcFo1uYsQrT9MVqsKvWqcpOVhfcg4SW0GIOOfyh/
	Wok6uZzlqat8A3dPvwb2aiVOHKnMfvQh5g0ZMPAyTY1vpmu5LuO5
X-Gm-Gg: ASbGncsqk2n9e5Wpn/omL4IqmthE6kKJ2k2ehDyAi6MPw/KhzfC3zRpDXdKq7Ge+65l
	1CuYJeCls8iwdLWoAZwE6BOWtyOpSFw/xqC0fAq+9A3PM4PZvV5JoHfGRVgULWpYa8DQKnPfFNZ
	LMVHbg6Yz0EYL3BgT27/IPZZmKUTmi7aGFTd0g9GKJCBiOfOEEMJFUvjd8dVaeqOyjO4RJfYlBt
	Kf2KvkqEo/hhg0/VL4Y2FaBy7zYw/H1bhV+OiLIINCBo5QhF8znmsLHQLMwSq3X03unPwMu6df/
	0Y7Ka5qS5oMAmAIaqyOS
X-Google-Smtp-Source: AGHT+IG312keFw5jeFNlT86CChmD/JhQjcJt+ortIX5jqch3dlXYd2FDipBO5tztTdKqHV6NuV5lwA==
X-Received: by 2002:adf:e105:0:b0:385:fd07:85f4 with SMTP id ffacd0b85a97d-38bf5678c42mr14021990f8f.31.1737528654120;
        Tue, 21 Jan 2025 22:50:54 -0800 (PST)
Received: from localhost.localdomain ([197.63.212.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327dd34sm15156283f8f.83.2025.01.21.22.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 22:50:53 -0800 (PST)
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	shuah@kernel.org
Cc: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	linux-kernel-mentees@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: tpm2: create a dedicated .gitignore
Date: Wed, 22 Jan 2025 08:50:18 +0200
Message-ID: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a dedicated .gitignore for the tpm2 tests.
Move tpm2 related entries from parent directory's .gitignore.

Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
---
Hello, as per Shuah's review, instead of adding another entry at
selftests/.gitignore, I created the dedicated .gitignore for
tpm2 tests.

Aside: CCing linux-kernel-mentees as I am working on the mentorship
application tasks.

Thanks

Changes in v2:
- Created a dedicated .gitignore
---

 tools/testing/selftests/.gitignore      | 1 -
 tools/testing/selftests/tpm2/.gitignore | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/tpm2/.gitignore

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index cb24124ac5b9..674aaa02e396 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -4,7 +4,6 @@ gpiogpio-hammer
 gpioinclude/
 gpiolsgpio
 kselftest_install/
-tpm2/SpaceTest.log

 # Python bytecode and cache
 __pycache__/
diff --git a/tools/testing/selftests/tpm2/.gitignore b/tools/testing/selftests/tpm2/.gitignore
new file mode 100644
index 000000000000..910bbdbb336a
--- /dev/null
+++ b/tools/testing/selftests/tpm2/.gitignore
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+AsyncTest.log
+SpaceTest.log
+
--
2.45.2


