Return-Path: <linux-kselftest+bounces-27344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C7A41FDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 14:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8487A64BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384AD23BD17;
	Mon, 24 Feb 2025 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/+oUGpR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBE233736;
	Mon, 24 Feb 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402231; cv=none; b=pKpbycOf93GqHok2XTv9djWpPCHpE8JH4vu4YcBYSWM97cDg0A+IpWCWQ9ycRPONPCjw5nZdceAN1VgUXC8MFBTl75Bdo1UQGnzJfWjDC/W2onP657wYdTNkwCBY9MOPJ1o7KMEwcgsmzmEwEAuGJXkSxJxmnK+oLMOXzDdzM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402231; c=relaxed/simple;
	bh=3WH7N5b2mLwHCzKQItZCh++HaF1mtPPWYK1ByZIVs+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWmg8HILJBrOul0CJ93+GMjwm/iMqrR74rxKEHdvI/eKwFHSGlH+R8WeZq798EHno9z5+xI7y2KONiB6cWd+F0dFCD/hC3TsvMBitCGS5ntRTk+0IojfFv8/yr0BMvdwbHc9HsL1+X9PV2FVLSb17kDWMEC9om80nhJ/m4giIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/+oUGpR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c4159f87so59016205ad.0;
        Mon, 24 Feb 2025 05:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740402229; x=1741007029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K2yGA1NhGbMJI9b6zgvWTEkXn51K+UPXbLwr9O6ldtY=;
        b=i/+oUGpRklwRJKad7O+79a+RVhITSlynGN/s0DpPmv9VHTFwqdaL0Yz3TAq7X/n/s5
         TUFhcQNgrs5BmKDROtUHVH3+KesqgZPsjos8f7q9Ixs+kplIP7kvgWODMVBPBkv+WUkL
         4hLTN9OjcO+ty/GZAMmVwLKf3wQYAsX3UQwRJ2A2Cf6gTvcRUT0iyWOD7B4WbsSNED2+
         ikzL0xE2Xdc8dPn/lhgEqTsLNGT2m7YqcF0+SqQCF1chwaIlCXThWdLUA/Hp+x18vfHs
         7kbtPQY1nxuKPBvw74LwHwdjw9WQmXOxtWe8cG83bBrspbsZRMvd0AclWeFfF1gs+I16
         vU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402229; x=1741007029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2yGA1NhGbMJI9b6zgvWTEkXn51K+UPXbLwr9O6ldtY=;
        b=q1c2tccSRDdtqLVaqRnjmFYJJPfAKkPadHKZp9vL/IArONcjbfhutoiWzEVbz3wuQs
         Cwrd7qG8lb9i6PvJscp3d4UFY1RM6KUvGWwRKcBdvTsJfUEsKenbLLzrlbaHB+kyQv8m
         7bI2cRZapv6B7L9miTDrzkeWilc/TARq9nkCJhe/iaetWXC2ZJbSsJq58kxfD3JnTu02
         bwg/8XCTc/Oc6nc+9xdbTTVZChIz2CxDPWj7wODjRib01BsucIpTtqNarAnPTOBjD+PL
         oYsTewpZdna9DNJANOAxtjYGbBCaSp1R14JTmHPRehB7uJQYRHATsKbefmn/cSJxyc9k
         PY1w==
X-Forwarded-Encrypted: i=1; AJvYcCVucUsqPj73vCOD9pvVsLsMcMAr2Vr2Y4Zhv4sALy1ZnQ1OTTq/4kqL2uuBIEBNrtalpVcQBr05rWZFsKw=@vger.kernel.org, AJvYcCWN6bmGIuim0Uw+8j/lBLZF1NURHgA2pEsCj+j8n+SEmwMaPB3i/9yE5N6K5be8pOTqawNUuIoRFFwIsxd6TdFP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9x9bSVkfW/kN+o5prFxrubiDmmhnG1PgcBnFJNe8rSP5D9xk
	EnRL+Tco8OgY+x2hPtVr9+9GhQn1HFFW/YoYl18UDhsdr+jlNjXjzGiVmFjAaFI=
X-Gm-Gg: ASbGncsanp0CSdllaCE0qiR31/IudHXbK592snE9u2qhCsAOo/0kFBN+z4KoHwXie6u
	/Ell4r3NKRkP2WPL/2ccCYYhzMnD/hKhdGPFs+Qe2AG53cKcQcAmLJjkw/BbEIDVHP41Mm4TPp2
	m2tSdkjNM1ZiNdkyKpDsaeE4plzj6prprC1unvgo6K5c8FZgouLXZG8Q6czGc4pxXS8nImIDSS+
	qncW3wtSjqLQe+M4wJhIDVWY/TiXILaanVA3dXhRiFrtq0mpSiCDxU7GJhzESvFDOrheps7fccJ
	I5gvU2leeDrEovFe+ngR
X-Google-Smtp-Source: AGHT+IGgDwE3drF3XPiR4PgO0QiIq/gzYst8UaIiUyo9KJCwD6vSvTrQUc35zV8OFRAWRZHDZB7oIw==
X-Received: by 2002:a17:903:32c5:b0:21f:658b:8ed5 with SMTP id d9443c01a7336-2219ff30c91mr211707465ad.6.1740402228768;
        Mon, 24 Feb 2025 05:03:48 -0800 (PST)
Received: from dev.. ([2804:14d:887:95a9:942:b4ba:d811:bd8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491besm180097185ad.14.2025.02.24.05.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:03:48 -0800 (PST)
From: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
X-Google-Original-From: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>
To: david@redhat.com,
	osalvador@suse.de,
	shuah@kernel.org
Cc: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/memory-hotplug: debugging improvement
Date: Mon, 24 Feb 2025 10:03:00 -0300
Message-ID: <20250224130341.10613-1-leofthirata@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Formats testing messages to improve debugging:
- Inserts alignment tabs with printf for testing results
- Changes messages to improve readability and understanding

Signed-off-by: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>
---
 .../memory-hotplug/mem-on-off-test.sh         | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
index 611be86eaf3d..7a2eea366c1b 100755
--- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
+++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
@@ -143,6 +143,11 @@ online_all_offline_memory()
 	done
 }
 
+print_status()
+{
+	printf '\t\t%-37s   %12s\n' "$1" "$2"
+}
+
 error=-12
 priority=0
 # Run with default of ratio=2 for Kselftest run
@@ -184,16 +189,16 @@ echo "Test scope: $ratio% hotplug memory"
 # Online all hot-pluggable memory
 #
 hotpluggable_num=`hotpluggable_offline_memory | wc -l`
-echo -e "\t online all hot-pluggable memory in offline state:"
+echo -e "Changing all OFFLINE hot-pluggable memory blocks to ONLINE:\n"
 if [ "$hotpluggable_num" -gt 0 ]; then
 	for memory in `hotpluggable_offline_memory`; do
-		echo "offline->online memory$memory"
+		echo -e "\t\tOFFLINE -> ONLINE memory block ($memory)"
 		if ! online_memory_expect_success $memory; then
 			retval=1
 		fi
 	done
 else
-	echo -e "\t\t SKIPPED - no hot-pluggable memory in offline state"
+	echo -e "\t\t SKIPPED - no hot-pluggable memory in OFFLINE state"
 fi
 
 #
@@ -201,16 +206,16 @@ fi
 #
 hotpluggable_num=`hotpluggable_online_memory | wc -l`
 target=`echo "a=$hotpluggable_num*$ratio; if ( a%100 ) a/100+1 else a/100" | bc`
-echo -e "\t offline $ratio% hot-pluggable memory in online state"
-echo -e "\t trying to offline $target out of $hotpluggable_num memory block(s):"
+echo -e "\nOFFLINE $ratio% hot-pluggable memory in ONLINE state ($target memory block(s))"
+echo -e "Changing $target out of $hotpluggable_num OFFLINE memory block(s) to ONLINE:\n"
 for memory in `hotpluggable_online_memory`; do
 	if [ "$target" -gt 0 ]; then
-		echo "online->offline memory$memory"
+		tmp="ONLINE -> OFFLINE memory block (${memory})"
 		if offline_memory_expect_success $memory &>/dev/null; then
 			target=$(($target - 1))
-			echo "-> Success"
+			print_status "$tmp" "[SUCCESS]"
 		else
-			echo "-> Failure"
+			print_status "$tmp" "[FAILURE]"
 		fi
 	fi
 done
-- 
2.43.0


