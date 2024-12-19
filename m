Return-Path: <linux-kselftest+bounces-23589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B69F7E1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85982188A068
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4449F226198;
	Thu, 19 Dec 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncphvG1i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2A22617E
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622196; cv=none; b=dLLf1+OEWCYKkpbN47sOv9d7Xm3fDBRgi0ffJhC3mRrvdMAkpJpjzyr9PhLtLuayIrdyBtdc6rAsRF1JxNtXhFzN7O7viM9WbKoTrD6cBaBIioTcG9I7eUHDTGng6ZC+JoCKF4hNeWGhd/6AWLncZGmtrxWNatmbNFb/8le4Kwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622196; c=relaxed/simple;
	bh=LzzYWztar7b02vkDjuYPug/bdBMGRAM6NkSBRRZ0bxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P0pZk3ndqeC+zxtKUjHfVXBCKhgcYOl5F3X76JHF4Ryxj5dG7oTubp08+gGrlcoWpOgjuoXE26Zsdy0a6hq3teqIsDMIDxRmLiSL6BJ40V7zXspytRvbyLGD1XrqBipkO8+RNqmAvh3amO+TQljsvBJTNstOl2C0pBKxK0rRTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncphvG1i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21661be2c2dso7653075ad.1;
        Thu, 19 Dec 2024 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734622194; x=1735226994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbPDmXw6jYJerfGsuZshqvUEgILGJH+W+WazUYideyk=;
        b=ncphvG1i2tDaNW/3oED+KJc2o4R/mpHxrft7FP7DSS1z+9OEsI6jViw8h17EYdQgY2
         nRYtqijcSvOAZd5t2moLu/nkWhIbDaSoA4kejkZwq4ke/IOOFzaP7Hch3hF/a/LQj3vF
         x4z5S3Ogd1L33CV5Z4O9Vssu1B1zybdBbvRVId7wOnfZNm4X3d1E/fDcme9KYoP30J/h
         kmPDR+Ojo84+RREKS15oxE7NZ3VUsS9Sm77uIm5295FTAGWus2DFXRl5UT9jxw+Nk8v4
         6mFnhZpLVf8cwrJYPqKybZg2CpGZneGan53BW7cWn+m1pnSfnwfAHKVAQVQHAgq0Kos7
         qPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622194; x=1735226994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbPDmXw6jYJerfGsuZshqvUEgILGJH+W+WazUYideyk=;
        b=t/nNHxqNHCbc6UKFsGHelkeNn84+RhOpbpSeqY4d0vSPSHLkcmiR7Q1LNGySoTR8m3
         oqtlhLcjKDeqMvSe4BHXGxVwhwVe8dbinkIIElm/4BiG9iwqDyuQIgJIiMiuudq1CL8l
         bKTfOyXhVGALgFwvJ6G3D2VoGpUIWXUxEU1Am8d9oRykWAtjZj6VZYoW0TbIezP7j4Xd
         nDd5+sLs/GURxrHL8Pt1rfPEDupwx2AJdSXBdVjdI5yb7HrmuGLqbqMrRcI0LAQfMCKW
         BxmwApSUM/78oB2Z4pN47GAKgbBsKk1cUtIoDFQ8+KaRhDhzZl/2WF9/t3FN+sMPwnmR
         wApQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR3XPY4pRCWYGYYE5pXUyCiAzW+7nlhaLMOdaJVFzlrciR6mzwnh/yE8NgdHEpPhHQtqpCq7EO7VI5MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEaQKaBqVCiCgxvdMkofzqtjnszoZb0TZ60cGQMKwL1LXhucB+
	HbiPP5+p7huiDBvK12xw8Xm3qZJgBK0igFzrzaToT7yQF4Jw7D9uJ1Gh1w==
X-Gm-Gg: ASbGncsoc4b8So6SgDiAzbPs9DqzK4RXJS7xO/pyOobNprv8EdT79XxTFQ7SWjq6VTh
	q0/N0OtlhUG0FGJ9Ba07he2Thr/J3qz5iSvaWwxDfP8lyI9tn81UkhPRYmwFF+iJ2LBdmPi6Yqz
	B2PEmkzyPiMhzauloXFv18Bj9xAFGawaTTmyiJxYAu6XA4Edr8ayYERhYkaS7cnSzrkmKcIgPo9
	jH737MUg5tLKWx8HLLP8fARyFVCzIdj+tXOv3StF3I3fctLnLlop+3lZDft+7skJtoM2g==
X-Google-Smtp-Source: AGHT+IF9KgbjMsOxh+2HRKZ+JCF2k7g4faFH+AwnD4aPZUKt5OrI9nzt6tZGv9DGnYnUvckTpL8kkA==
X-Received: by 2002:a17:902:db11:b0:216:7cbf:9500 with SMTP id d9443c01a7336-219d9617e21mr54319675ad.6.1734622193996;
        Thu, 19 Dec 2024 07:29:53 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdeecsm13321755ad.123.2024.12.19.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:29:53 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	inux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v6 0/2] kselftest: tmpfs: Add ksft macros and skip if no root
Date: Thu, 19 Dec 2024 20:59:27 +0530
Message-Id: <20241219152929.4005003-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version 5 patch series replace direct error handling methods with ksft
macros, which provide better reporting.Currently, when the tmpfs test runs,
it does not display any output if it passes,and if it fails
(particularly when not run as root),it simply exits without any warning or
message.

This series of patch adds:

1. Add 'ksft_print_header()' and 'ksft_set_plan()'
   to structure test outputs more effectively.

2. skip if not run as root.

3. Replace direct error handling with 'ksft_test_result_*',
   macros for better reporting.

v5->v6:
         - Skip if not run as root.
v5 v1: https://lore.kernel.org/all/20241112143056.565122-2-cvam0000@gmail.com/
v5 v2: https://lore.kernel.org/all/20241112143056.565122-3-cvam0000@gmail.com/

v4->v5:
         - Remove unnecessary pass messages.
         - Remove unnecessary use of KSFT_SKIP.
         - Add appropriate use of ksft_exit_fail_msg.
v4 v1: https://lore.kernel.org/all/8db9feab-0600-440b-b4b2-042695a100b5@linuxfoundation.org/        
v4 v2: https://lore.kernel.org/all/63d5e3bb-9817-4a34-98fe-823a9cac7c16@linuxfoundation.org/

v3->v4:
         - Start a patchset
         - Split patch into smaller patches to make it easy to review.
  Patch1 Replace  'ksft_test_result_skip' with 'KSFT_SKIP' during root run check.
  Patch2 Replace  'ksft_test_result_fail' with 'KSFT_SKIP' where fail does not make sense,
         or failure could be due to not unsupported APIs with appropriate warnings.


v3: https://lore.kernel.org/all/20241028185756.111832-1-cvam0000@gmail.com/

v2->v3:
        - Remove extra ksft_set_plan()
        - Remove function for unshare()
        - Fix the comment style
v2: https://lore.kernel.org/all/20241026191621.2860376-1-cvam0000@gmail.com/

v1->v2:
        - Make the commit message more clear.
v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u


thanks
Shivam

Shivam Chaudhary (2):
  selftests: tmpfs: Add Test-skip if not run as root
  selftests: tmpfs: Add kselftest support to tmpfs

 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 41 ++++++++++++-------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
2.34.1


