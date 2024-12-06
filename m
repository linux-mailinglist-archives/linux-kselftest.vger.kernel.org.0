Return-Path: <linux-kselftest+bounces-22925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E02789E77CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 19:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FFF1888023
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6C1FECC6;
	Fri,  6 Dec 2024 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hLHz4X1A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F91F63F6
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508315; cv=none; b=bHvrJ/jgQ6LdmLiBbOYlN2f5hfrMfF/YnCQ2/Mtqjy1B/kkso7gXxuQfx3xe/3tsTnH6hdNUX9lUtdxqKDk4shojRy8k1rxbK6rPVADQj3ZUX92gnX0qTcXu/OTBQMYXxjdLC5QbBURWYYOnxqu5zA55pRb8ZBlIVtC63W0fZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508315; c=relaxed/simple;
	bh=mUrDS2bhGOV+ED2691ewuzgAYk3tK8Jmo2Es0NnHTY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UH8HRPPby3mFBvQEURYIt2NYSB3NDMfA6Hp6MaOMNDdRU3AqxARAgnxDi4CJy7uuYnaI309k47kOFsPJgst3+D5/KY2vPohfJCiUdzTjQaF51SBf+tcHLzZ8bOhHOmwODzhh8VO5vKDx5mwpjpC2knhdLnZ64rD6XMf/Jk+aW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hLHz4X1A; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2156e078563so18525935ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733508313; x=1734113113; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNSXOHpFVDvVo7qfkOEInwMhPxiBtaZSe1qpxd+NZEo=;
        b=hLHz4X1AeNnHiFdLcWEZDj/HWW4eS0aaVEiu2O8suERNrIud/iDCqVXS/P0urStCeh
         t3fRJQLVK4yMVsZcnXfoYKe1+ZmEQpGrrYbv6Pl/wIMShXL9+G3A8CjOBsit233sVbYr
         7hHwf6XCFHgEHMaI5pT/dvIQFk9fu1IG5vgkBG2knrEhHLF73zci/x7IBQhojjXibZs2
         zDR/sbYmCB3+vb2RX0BclB/snVpGfnmXmAcdPlcbWhbAo89vuloEQ4487hrc9Fvv5ySP
         BRdlGcgMgsugnosWuFPjbFZmdOhO/nxHx6i9EfnBW2ed0c1gtn+kIOKqYbELFxLqoS/Q
         YNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733508313; x=1734113113;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNSXOHpFVDvVo7qfkOEInwMhPxiBtaZSe1qpxd+NZEo=;
        b=QoczGRrV0nEOjZURPjU2gI5nYBoxpuiG8eAlwS5bguSdzgtKH3bLl+2f8lLUr8m7mh
         /pEV9saqFW9lkVI4vlGlx/e6FvCIPx5NtHZzAy5KOUEjpbI7L+1kMp0Qc8uWipOse/lz
         RCFOAWcdhVtxUwN3Gt/WNQuSPvzclVxFdzYcfCmxQRH3gbguqNONJ5Kz9CQoW5P5teoi
         SamfZes9upIDJ8PjSvT4Mu249yZ0wjjs3fqn6amG0N4FHy2mqjWCD5Wj/UXb/pRIHExS
         UA5N3STcTRwfZIM49DnE6R0OF6AAg9M8sd5fr4VPpDTylKFqTs9Bru7MV5weDPfMDEsD
         XtVg==
X-Forwarded-Encrypted: i=1; AJvYcCUnEvyePZKyl9Rohs2Lzc/OKO3ItlFKkXtZUV7l9AYbgYSHiQUoY9J0uX2ORtxQ9HTkINixYJvaO2x1KAqaqds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4KF/kezrASIgU3mnismuKiWuPGKXN8Ud6xCGvR2F54j81KtB
	5Y8SjnG8fQVm+Ql/sy/gSiadb+mZ0FfmF9gn7smoqRBfEZ5/KDCrWYZzBjA4R84=
X-Gm-Gg: ASbGncvqWD2nlZ0rGsoYDfqBKyBLl/F17zcutX+pr1bmY6uOaUNjlR1+3Xlg68FhNWs
	SHh7QorIIb/o2+IyFXur9llh4u3UfFZQ/hlrh6ibW0VGJ3Ae0Mb2Z0rQxtnuu6uoLMWc9BxpqOt
	3uHOV1tlp2qHW2PyvVQCQNcN7N70RrO0mQlFizpS+ndokqQaom1h/ykb8ryjaVC5+bpWDRgeviW
	x1JYMXSuH17pdxvtuuZNJ68CypMGsTwROUtnb6794JcKRgI1YybMVG7zKpnll3LYg==
X-Google-Smtp-Source: AGHT+IH6K3vxjoHAACo1uwn/G9I0Nj6IP5ZDAZwjsVYIfZAvGf/tBjJZAN9zL2L3pU94t4FY59unIQ==
X-Received: by 2002:a17:902:d4c5:b0:215:5437:e9b4 with SMTP id d9443c01a7336-21614db9f54mr41598485ad.54.1733508313507;
        Fri, 06 Dec 2024 10:05:13 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2161e6d1042sm10977125ad.2.2024.12.06.10.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 10:05:12 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 06 Dec 2024 10:05:06 -0800
Subject: [PATCH] selftests/hid: Add host-tools to .gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-host_tools_gitignore-v1-1-e75e963456dc@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIANE8U2cC/x3MQQqAIBBA0avErBNUIqyrRITUZAPhhCMRSHdPW
 r7F/wUEE6HA2BRIeJMQxwrTNrAePgZUtFWD1bYzVvfqYMlLZj5lCZQpRE6onHfD7pzVvjdQ0yv
 hTs+/neb3/QC+B72vZgAAAA==
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=726; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=mUrDS2bhGOV+ED2691ewuzgAYk3tK8Jmo2Es0NnHTY8=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qwzSXB2zyn6rQaTi5VrXHfFvuq7V926Zfu13cZVNfIs
 wXW8Md3lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMJHM2Qz/vdW9+Y3dw0z+nXWf
 U6sy9XxEoahRvN/uzD/nxbcs8nb/x8jwt5WJ69mbDTkH16almv99v32agHTW45khS70stJfp2nx
 nBgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

When compiling these selftests the host-tools directory is generated.
Add it to the .gitignore so git doesn't see these files as trackable.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/hid/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/hid/.gitignore b/tools/testing/selftests/hid/.gitignore
index 746c62361f77..933f483815b2 100644
--- a/tools/testing/selftests/hid/.gitignore
+++ b/tools/testing/selftests/hid/.gitignore
@@ -1,5 +1,6 @@
 bpftool
 *.skel.h
+/host-tools
 /tools
 hid_bpf
 hidraw

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241206-host_tools_gitignore-8a89f8820a61
-- 
- Charlie


