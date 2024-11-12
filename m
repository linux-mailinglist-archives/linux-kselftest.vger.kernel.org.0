Return-Path: <linux-kselftest+bounces-21869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C809F9C5D7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61721B395A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CFC1FE0E5;
	Tue, 12 Nov 2024 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh+7tTro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548CF1F9EDE;
	Tue, 12 Nov 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421866; cv=none; b=DnXrgfnJenIol/ue90V8PsS0rPCjfRJyN/fBn/8MXYqma2FXkd6k5LZ0Xdb0bWqUqARDcuTmRZVOZNGDj7qh2GhTaoCHKkzG8BTNL+M0KEX78CBbrecsjc/037yIoEoK8MZoFkjxTdf4pdSWtx00dMInsGs/fikmQMHkC+usIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421866; c=relaxed/simple;
	bh=FKxrtq5k01R8nrZHRpsGFJKA8KdWuOOgePCCOjWHNR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UE61NSM46pcc6I8ORrBYCSKPq9osSHA+mfdRihvfox8mbIcqI/NzYYCYaHfq0s0jCJPbRlSlE6lgARVWv5Us92Lf9VdnZPqeAuykh0mV+udH3riBK1BpE3/+unozTFjRw3D/wcjpUmS46cJeMabQx9L16KZno4T+WmnB2kDyh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh+7tTro; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c714cd9c8so58324575ad.0;
        Tue, 12 Nov 2024 06:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731421864; x=1732026664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4CG0+cc8Un34sMUc5JJuUPk6GZzogDzO5VJIh69+F8=;
        b=Gh+7tTroTqlkdkh6vIA8lAIftVF+xmY7K4HbgkkCx9xzTQ3oFsg7PKg8kvGK90qoKE
         su0HzSo6VUCxcROzEm1BVJGF3TtsdNDO2PL+G4k4gTG59hqz+EpAJEAnoEVJ2q3QnPeO
         O6lZ3B9s1hPb0RJU4Vya2Che85g3AjsOkd2JAmEILruCJ28kKExmvM9vsnw8q4C2fTgT
         YuwSE1k/KLLJYHqeUIS3cW0ADf34QHceVstTtIj9hKQZaMrU+fbscbKFafW0euwZZNYo
         x8eY+Kg5dxUaZeuKQBzTJXVo7J4Jpu/4U7z6+DsJeFWTZ++uJ1kJmHahWRB2LDZBCmai
         mkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731421864; x=1732026664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4CG0+cc8Un34sMUc5JJuUPk6GZzogDzO5VJIh69+F8=;
        b=VkM/bitNvT82RoK5m30S6oh2YT32mubsr007mgMlam7tK4T3TpgGFHPMdRLYirPT+0
         sz92HvqHOFphrwtsJGuRt33OBSUcwrwK5D0JVIYV3gNTRD8rq9gNBs5mtapjIB8Dq1s6
         /yC2OmH+tt+BRzkML4UfhJmhelH9ypGLdGyA2shudViDHIs/oxwXXJZbPATC6wL+hqmX
         tcHePPiABQ2s+J7hdHqes19feNOCgc3kgV9MGLA+xvC2UaYh4FtIiuqpjPrKFHP2iyPv
         NlD7+/gVg133hHUG+auBlT3GF6mTwkjM8HpNbZeD9aqVdC2BxKLB9CdE7fFbjeyK7p+2
         PoOw==
X-Forwarded-Encrypted: i=1; AJvYcCVqFYGeIEWdSqzyg7el7C5PqF5oN7HqdJIcz3P711ZpbTwTYPbm0s46H2xnSbdAo6I8j79h+pw1gkQLd6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xjP7uTAJXTvKlAfaYvsncVf7c98oKiL+U1EoYuYovGj6YBNV
	TR8VqjzsY2toTnroQfDT7m7zQ6rLXkyYZ9uoyXXPMOR5XEuLPCks
X-Google-Smtp-Source: AGHT+IGTrGp+94KmdGoTL5rsvNAu++M+zYZRXjb9tO+a96OGTTtiwrtcNyrm8cl91N0YcC/QN0n7yQ==
X-Received: by 2002:a17:903:230a:b0:20b:b75d:e8c1 with SMTP id d9443c01a7336-21183d10969mr225364985ad.4.1731421864519;
        Tue, 12 Nov 2024 06:31:04 -0800 (PST)
Received: from localhost.localdomain ([27.7.112.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde2e1sm93396515ad.76.2024.11.12.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 06:31:04 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v5 0/2] kselftest: tmpfs: Add ksft macros and skip if no root
Date: Tue, 12 Nov 2024 20:00:54 +0530
Message-ID: <20241112143056.565122-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.45.2
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

2. Error if not run as root.

3. Replace direct error handling with 'ksft_test_result_*',
   'ksft_exit_fail_msg' macros for better reporting.

v4->v5:
         - Remove unnecessary pass messages.
         - Remove unnecessary use of KSFT_SKIP.
         - Add appropriate use of ksft_exit_fail_msg.

v4 1/2: https://lore.kernel.org/all/20241105202639.1977356-2-cvam0000@gmail.com/
v4 2/2: https://lore.kernel.org/all/20241105202639.1977356-3-cvam0000@gmail.com/

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
  selftests: tmpfs: Add Test-fail if not run as root
  selftests: tmpfs: Add kselftest support to tmpfs

 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 60 ++++++++++++-------
 1 file changed, 37 insertions(+), 23 deletions(-)

-- 
2.45.2


