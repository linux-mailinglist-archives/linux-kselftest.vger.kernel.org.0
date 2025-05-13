Return-Path: <linux-kselftest+bounces-32898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3390CAB5102
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30E94A3D44
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95D24167D;
	Tue, 13 May 2025 10:02:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6923C4EC;
	Tue, 13 May 2025 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130563; cv=none; b=UVrVdWWLPoSMujUZ3kX1ei5yCx09FR4uPINm03DyRxzW3dZBRCRKHvREbGElXvBau2ZsTIA5wrbk+zSGGDRIxK0+4tzcZQPyRhOLpqK/4dgimh3qTgQRiHPy2YETF/cOSS44XSqLt5uZNzmmJ+OTUKsGbNYL0PYj7bvoC0JiRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130563; c=relaxed/simple;
	bh=XOaSi5B/2MPi0ZolAxQSAyMx/S6PktLSRWiUKfgAWAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Is64wTLO2t0FTVU3LHCeeAFD1GamnE4niqeaAWWCPLhkSu2A3QwRI2kjNUjJxs/u1S8MxnvZ698+5PPfeY08rO8SVnB7kVpnDnd2Q/BSK9Mx6XqcmEyhuGCPH4zUsFgiiSdV3sLUiWQ4h2OExw4wcuEWa/Kc6Mdt6qwVmK4sdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f6dccdcadaso4270526b6e.2;
        Tue, 13 May 2025 03:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747130560; x=1747735360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLPcK3M4fHFXSHYEvDg/pvJ8s0/A80A92TKsHDLatZg=;
        b=W2H7HCQVgzq3KEY5wCA7bWm/PyjW7alnZFg6HJfMs5bFjlqm1tH3Shg8bdejw9qnYc
         TxEAxWrI+XfNYfk0+I54S8IVLpk8UJyzlBuV8k51PaW0tiiub3nfY+WF7FMEcn+DHwjF
         glhi5Kim81WYsDv8a3RDXhN8v257iZJCCisbzhf3eF4gfFmY31F52wQPsFb0QILZzV3m
         k402/puDWT2sEC7S3jqk9recKTpn/iqNQu4oCmZ1iZZcM8ILouOcmztqtnV+iVK+xene
         gqIDmD7gRzXDYEVfdvXoLjRRAK2r7O//cc79DUxCAjeQaPgpyGVlPC/VJgN+EaAejC7Q
         jlcg==
X-Forwarded-Encrypted: i=1; AJvYcCW6bYwTrTOlBQkHf2DagPpLNiVsohMU8MPiNMGFJvlyCFyZYdDD3KGnLqlMx7F7wje4+SiAScFEeoX1CZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWgDhqTAyGArbJz/mL0yYkmhtmXwszXnsm/EhkRWbu4fwPcLG
	bhYkmwTUwMthf4mag3kpF+OayqUWIflb9EY2xnGpud1ugoF3naz7GzvP7CfEbgo=
X-Gm-Gg: ASbGnctXxU1towyPixl38Gy1glyQYLkt1+uLs/KkEV8LIHi/LwOq441ic4gHB7RcrMh
	KUpEG0xsgsAabnObOXD+3DcTPVrvpD5LHubwnzW6SsQuaKVMR4l3EvsoLEiwYUZujRYmpXxigp3
	pLdpnUb1G/mu7dVdCKq3I82FzmryLZu+qsnZV0k4VF7TybMIuSly3jiZmwbR0qwZpbrZyIIr1vB
	mh7I74zU39cyaYY7KvJLlNDgSb45WElhR6bQfRpz5v+wtOb5JjSlRGFjpibRh75PIXOjcaMSfkB
	b7H5etHjYA6CIm8s0+zJjSKPMjpAE48nn9OiC/n1dyKPuAcKQDbfnA9pAqD2e3ijPn64r9+9ibb
	y8IDtlqPVOhU=
X-Google-Smtp-Source: AGHT+IFZ6nxbxPUXjKqsIZBUU0IJ9Oh3xgAmcnHaYyaJ8aGDxxXT+yXc7ObntfPZRIdH/Lqxwn7X4w==
X-Received: by 2002:a05:620a:1988:b0:7c5:3da2:fc75 with SMTP id af79cd13be357-7cd010f78ebmr2161247285a.24.1747130549798;
        Tue, 13 May 2025 03:02:29 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00fdc5f6sm689922085a.72.2025.05.13.03.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 03:02:29 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Suppress unused variable warning
Date: Tue, 13 May 2025 18:01:53 +0800
Message-ID: <20250513100207.114000-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running `make kselftest`, the following compilation warning was encountered:

mount-notify_test.c: In function ‘fanotify_rmdir’:
mount-notify_test.c:490:17: warning: ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  490 |                 chdir("/");
      |                 ^~~~~~~~~~

This patch addresses the warning by
explicitly suppressing the unused result of the `chdir` function.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 59a71f22fb118..de847e2b12017 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -487,7 +487,9 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		// Suppress -Wunused-result
+		// Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425#c34
+		(void) !chdir("/");
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.43.0


