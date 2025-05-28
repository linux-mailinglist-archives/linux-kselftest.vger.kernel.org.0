Return-Path: <linux-kselftest+bounces-33914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC1DAC612E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 07:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3088C3A65D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 05:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70641FBEAC;
	Wed, 28 May 2025 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="fTk616/k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA161F582E
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748409822; cv=none; b=kfuG0BJitVI3Aoxzl0Nre3BOW07RK/UqB52Qi77jxZSCjf8ucn/NH6s9UE6ePHo+qTrLnJ8uFCPvOVs+Y/qA2pAtKCa2RAuwVDrYEEYX9gv0WBzQlrArjWUWcH5sCr5V9f1jzNlslcUHEOORe2LdWHnjdgfBLXopQdkZZ9QUtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748409822; c=relaxed/simple;
	bh=OMnGfda8KClSL9GGHmUONx3gMKPVl27s+0O8Uijwykg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOzGONAflsc/6Fz0sjBn++GcSVC5TFvs2z67UcRZvvIx8Iys86lqZudvsZTUQIWBWbjuE0ZflgOXuyNIG68qnhy6DwrFAdk9qiyHuYM715h6WXO78GxIXRg+kuGIS+xpT+U9mY4vn+IvFW362IAPCE/GdlWRVSoGlvWY/lfd7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=fTk616/k; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86135ad7b4cso91091239f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1748409820; x=1749014620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wenxtdrBK9XwmMmiCLqhXCe+oFW2gyHDArCJgDTJFDY=;
        b=fTk616/k0SSUryAJYv3t9JEW/72IgkgqzQLEWE4QFoPdMGeOAuI/Rpa8A+zGJ8ZlI1
         gX3l3gOFCCw46Be2GFUzz38tqRiYYm7LqAs6v2PR29DUFSbDb/z6TrSpy16REsuR/Xyw
         s9m9VNANFayKQ+d0syTWVxkT9dyd3vLegF0PEpikXOnecAJAVuRDSB8/c97uPWRX+RBb
         4bRdIVY2x5LlSGvJyFQw/7EyOTBMp0v+hrGHu2pF/2sl5nN0CZIl081DCem7Ri1ob+yU
         jPyLyuP6jJWkErDN3Nhf3LvHQRFukFirM6sxPMKKQziuKsk2SCLU+wxTFId3D6OM6F99
         1AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748409820; x=1749014620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wenxtdrBK9XwmMmiCLqhXCe+oFW2gyHDArCJgDTJFDY=;
        b=jXi/ysn3ZqN3x+hxKEd9dJLYgKGcp5p1Aey2Oeb0ZHCphUtQL2TuVvsa6vp75NWBDO
         hNAilgZloNMjVfUxOsXPGfaQGhnL8+P0ZHJx4dwrQ4rWFc9hUN/fSZQT0NSJWyrEOjBX
         tuGe1htiDSVBXjO4DVa8e2zz7BjaeWcw94hJzoc7V60GbXRDIPyWMXDEgiCOjpfDubEa
         eHFEPkY+ZrPjTa5MTRTijxY1hUZzsQYel4QVemyxvLcpoVloBerKkuXRip8uwIu6ljLU
         jP0AFnG/SZhE5Ds78TsUOvquHfC1lto4x4g+rvnz4TA87PEXwEGiN3Y7v3V3dXj8GMnb
         9YOw==
X-Forwarded-Encrypted: i=1; AJvYcCVmG6qZSK+PA+3I8DPazGTAjlb/YhvJ3k3fU/sWEqL4i9JgR2naY38Has6pL7Rdo10AzwLuRnh54aRPRhBzUFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxir6Q2Wml8X0pQJNbzUbhfoI7bXsQeUBkGEnhqdYSGhhIrSmR
	D8RjdzcX6NXKkYTF9sk5p9vUDzXqQOY5jmerlVQWrZY8awAt7VYYvaKAbAteV4VX+K4=
X-Gm-Gg: ASbGnctHHcC+b9oyq98SRxRTOJm2JREqe9aAcPCXWB83gZdLZySWMeJP4qwCqoWOT8b
	C3ZlREdzCs5LcxT+3boettoff/mnST03LoyhCstX9qgZKVnqoUs12ImPvOsYfX0FxRj91gAE3y3
	qSNRIe9kmGNKlfpsGI0m7lbNLW6VImQrz9KtGGEJzb9VjSt3WdZ0nY4gj8ytOHjbmo/uV11UFP1
	PuzuUXiG4r7mgqT4gokBoFfAGTBhPPtSBnJtlLEqfsADtJJPIafywll30BAl9D+NI6NuH0YK6Zz
	ipoO76SAg/DQgztKbykKgI1oPbjwHe0LOjEJYz6TGyQ4+0orB0meXZRrDSatbRqUh2Rzu1vlZly
	SOBT3wlM=
X-Google-Smtp-Source: AGHT+IEg/+dDIFunsDgQZav8rM0OV0IRgirnDBMEGzWGxkPG5lDOpWmkE4qjIJg31NM/Oy281AN8XA==
X-Received: by 2002:a05:6e02:2482:b0:3d3:db70:b585 with SMTP id e9e14a558f8ab-3dc9b72443emr180381485ab.21.1748409819889;
        Tue, 27 May 2025 22:23:39 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdbd5c2e27sm73730173.135.2025.05.27.22.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 22:23:39 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v3] kselftest: x86: Improve MOV SS test result message
Date: Tue, 27 May 2025 23:21:05 -0600
Message-ID: <20250528052105.2657582-2-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make test result message more descriptive and grammatically correct.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
No changes in v3. I'm resending this patch to adjust patch format
suggestions made by Shuah.

 tools/testing/selftests/x86/mov_ss_trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index f22cb6b382f9..d80033c0d7eb 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -269,6 +269,6 @@ int main()
 			);
 	}
 
-	printf("[OK]\tI aten't dead\n");
+	printf("[OK]\tkernel handled MOV SS without crashing test\n");
 	return 0;
 }
-- 
2.49.0


