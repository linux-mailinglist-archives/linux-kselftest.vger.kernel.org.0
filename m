Return-Path: <linux-kselftest+bounces-23916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62821A018AE
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 09:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D767A1A08
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD128224FD;
	Sun,  5 Jan 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF1ifo1o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A763A9;
	Sun,  5 Jan 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736067187; cv=none; b=SaBEmtwiOmKg+Syhq8ZiwNO2QXye2Hd4gAglxpCCHHcj29k2TaSXoUAn/Q1cei/pkx+DJ66cxBeinRlholX/a4SQFwRIIW2nDcMyCTNMCa67MXqnovj8rRKgqUWtMlj+HuhSJwT1Y8HP290Z0UU/VG0xCS4R3jFpJ40GuWWQlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736067187; c=relaxed/simple;
	bh=nC41c6p46azV56wvtYnfzUpbHtVL228SueX1FtFIeYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hc3e/+sN6mmfcYjWjhky7gks76LtcIl8HFCZyMabdn33IXmK7hu9F9XntVZ7Ec8Lq15sDOAhBYRZ+Zmfr2BZCFsB77PZL2bOvHytCtVZAV8xyJCBidlcGMFBW0o0UvBFCUfzvb++4nR7pTZRpTZ6/zC1BWeS9b1phn27L72nD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MF1ifo1o; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so17069464a91.0;
        Sun, 05 Jan 2025 00:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736067185; x=1736671985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mT3HEEmzgr+6EmySCuHGpLhF8Q7HPAz7YI0Fjqhy7dM=;
        b=MF1ifo1oP37JBCSn/6bG5jFHvpKo7+MChW+MN6LcUlGPzPlmrdVXmFY1Z8GNQrGvE9
         Wi3DuJ6GqrVJtZ+Lyy1ZBMOW0mzy9IHfrUaW+oJJRLSwzEA/lpFF20ZVgr3XVa6jMf3M
         khWUf5CZutSDYfQhrGj82Gk9GUAZr5i6RwUVNZXH+N6Di/eAsecx9UqdJc5BzTnahfNV
         UV7yOgNSLpwaVX+NM5R/b8mD/5oP5U53/Rn9MkUR6oUnTv0xe/p91mSuV0eB4btTY6/C
         oIKaDQSrACuiElBVc0duaLh7l1jgKE6j1Ahq7uMIb50NwwwAAIuVxKErmKno3tyoEYYX
         6JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736067185; x=1736671985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mT3HEEmzgr+6EmySCuHGpLhF8Q7HPAz7YI0Fjqhy7dM=;
        b=GtepJUhFZ/UjB9QvS4rSH+Q629LQkUYypJVIt4b0iHNxJrxsbfeSKHLegY9MdVw7/O
         i1TcDkKBOuoBg4MlBtoyI2J1aZkuRIKIfCHzS8tAsNvrd+5ZrPfRAArSas2OJJABxD0U
         W0ZVATOnGK3Dmilr6hhEm0bU+vg87eXchw+kO+lQoJOeE7i7jo/IB9DUlpZykLRTMO5k
         HnPFSH+6VZoZcZi+IyFyotfjvvU5Eqs8jZmpxulZBKIrm76gNMl2ggBWN+Ju5TIVSLnJ
         szT7bzN9l0A4gvYC7hx0rfzC5/R4IXYYe3fq5K33nz0LgidKrnU7i6bKHdh06HELNG2m
         tMOA==
X-Forwarded-Encrypted: i=1; AJvYcCVvkNuU+Jd+hQVrwJnRLUbS5zyM3Eet085L2vxZMq2NbNXWHgPe8qYQPstuuq4za+FkKAdDNtiCDo5gxIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2bwT48n7LMre5IxEvP9Rn7hhERxeT7cEzFNOv6IUL9klFo9jY
	wFVu1Y4uJTvW2eWNfIoDik+i+7ljqT/ltZs8uCdPHtKhMjoHsLnbYU5SYA==
X-Gm-Gg: ASbGncvq038ZylWe1J9F9vvcpZsCcCkYKtxv10bzX0SHS2IebUQrxQzQNDaK5JMsAEI
	DOl1uTvRrEDsQ3TcIcYvR8JZID33IZdlo1ch2+vvFqR9vkBWmeQeeFgE4caEUJVDTt1aXKsq4vD
	pk/0o1BtCOOFP4SEJuX07LOl5stZ6If3kMSprPz6IjHk1RtLtH0tFD94Sa0bBnbqSYDxA7hXyAO
	1O2ws7sSRAPF2/iI68yUFocLZw/BTw4WtS2xuXEqYKCynL1BzOUT0dujVYGhA5Y+FzG3w==
X-Google-Smtp-Source: AGHT+IHn0vXEO9T6ayPD8aPdeoQvLX1Ig7x+E3R7n2pV1uCz7nL7Vd9Wgrr/l287q17fBXp90uUoZw==
X-Received: by 2002:a17:90b:3bc3:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2f4536ee733mr76752695a91.15.1736067185399;
        Sun, 05 Jan 2025 00:53:05 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962c53sm272600815ad.54.2025.01.05.00.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 00:53:05 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v8 0/2] selftests: tmpfs: Add kselftest support
Date: Sun,  5 Jan 2025 14:22:53 +0530
Message-Id: <20250105085255.124929-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version 8 patch series replace direct error handling methods with ksft
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

v7->v8:
        - Remove extra Prints
v7 v1: https://lore.kernel.org/all/20250102100459.1291426-2-cvam0000@gmail.com/
v7 v2: https://lore.kernel.org/all/20250102100459.1291426-3-cvam0000@gmail.com/

v6->v7:
         - Improve the handling of failure macros.
v6 v1: https://lore.kernel.org/all/20241219152929.4005003-2-cvam0000@gmail.com/
v6 v2: https://lore.kernel.org/all/20241219152929.4005003-3-cvam0000@gmail.com/

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
 1 file changed, 26 insertions(+), 15 deletions(-)

-- 
2.34.1


