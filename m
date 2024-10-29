Return-Path: <linux-kselftest+bounces-20879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 457589B3F0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 01:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA321F2336F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2814A33;
	Tue, 29 Oct 2024 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV2FWtKc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69979F6;
	Tue, 29 Oct 2024 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161341; cv=none; b=rFm4mv52T9HWUgE0iI5dnUmQMzdZbe8L7wMG1Kww/WulAN9nBWlph4Xt/OMtHBeKJ/hIXkYpB7FYPbLR3D36NLpy7Qp8iQsmpF9gxHuJQ3w90yO99yWINJ6JWVfezfy0KFAwPnjJ+KfXA1aoKR2htoXFpMGgr+ZnROrEnRGpnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161341; c=relaxed/simple;
	bh=3WEEoFWaxGq+sKCybK00zkmLQC0BVNy62Aqv424bblk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bwf5Hm+x0M/flUdHSIasYVXrMGU4HNTCUXnTJFRr/RO9UM+kGsChPG5kc7X/vpXId4QMSOFynJ7lKta7eH66sGJtFEOJ2iMX7ZcQu53g4EQSNxKvCHpqi1OL2utbN3yyhPnbEZ7MAEJORjdeus4ZoNoWoDBRn7HgEkubFZSr9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV2FWtKc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so3565168a91.1;
        Mon, 28 Oct 2024 17:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730161339; x=1730766139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bq5SxekQBwmDZwwnedhNJed3DRc+7578EvOxXxIqLD0=;
        b=IV2FWtKcjBA5OiDfxRAhD+FIydgIXVF6H0Z0652OSLCFXx1aiIx4gPvBXWheZ0951J
         WFfY5V3QDbeXNZI3HfylBVz5x2VEPfV6MG0WoaOgNQ/zbqS0ojYqKi6oZTlDXEM2+27S
         ZeRCz8qGKSewQ2kzEgyhv4saMXzpSlTH9rkWj/fsPgxfWJxwEbBcK3Lsc6jRPhyR5DQ3
         dYuHoGitMoNIbCfaQe6MlGUMH2BVtwfewusRGHB2zCdniIG6HlZvNzbfQ8k92WIeJ/+e
         4wHgjKBUFhyfeQvRY/gJydgxcYQuoyR4VUsew4wsDXtL11utMIcQit3TskrheZMzvKjZ
         +8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730161339; x=1730766139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bq5SxekQBwmDZwwnedhNJed3DRc+7578EvOxXxIqLD0=;
        b=qmfKs5zpDXfg6DyLasWRiVe7dJKsCeSsFvUw7KTeNTSTzFhE/dmM5ReolsAOewPAzY
         O/5qNkRd/n3zlb5PiqVYzyQJsuM45juong/aW4Szacb6AZSezsl4r0Raf67k+QMIFe7s
         q3FKwyAehWpElYW0Fnjrj9gP6ySDvqYzCThoBUcQy1G2iyquJn//mHear7gqKLwxLmfw
         SYTrL+adnJNfTIeC+zkMzUT1iRQaIUoG6zhp5nOSnQX9xo9zMRnaV9fKDUG/JKQ8DGLv
         dg4xV9aNrltgUvidcDQvKIAZ6dGoKu/22yVJ1mJ8XC1rLHUa5JjZxdutoGbkFiObRlFK
         A5+w==
X-Forwarded-Encrypted: i=1; AJvYcCUk+tydq92Cw7Z0sJ8Ghp8JA/+m5LcILQftP08aRQcZl28ODUJdotrs4rD2GhDhh/mKaerdAcIb1I3a9uLhDiMUr3LY@vger.kernel.org, AJvYcCWdOKcDs/bRBH0DZCPEgon6Xj2CLAgltim+/CQBS4y2TkO5MYjYqU79r0mGycSe52uUDLo=@vger.kernel.org, AJvYcCWfw8ZEKBDDxsyd6Rz12cfBKxpjhe5jK+nNOHv3/b4zZT7sllKraEuNAFpaLxsKJndDYr2gPB2Gbm/23hz8@vger.kernel.org, AJvYcCWlHV04vnGizr5lRPojJAz6subIYeBV2EXbHguVflJJASnWFEXsJ7HbhdQ3TtOBh/+fB6eRYO3HSfe1/pgSrnXZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzkV8hqc9DeHq6OjEZS6DecQfdsjs3UxOHYWy10pppWvxeygiGj
	y57tE0gy6BIpl9rs2GGc1La1KN8qijAM5nAfGCHBFGwkAsFyO/g0
X-Google-Smtp-Source: AGHT+IEo2kdFUNLvFdAKcRWwfQDnStts3x0mY//DC4mxa5rXin+viUft2X2txeZ/w/B99WyA41VBZQ==
X-Received: by 2002:a17:90a:710:b0:2d1:bf48:e767 with SMTP id 98e67ed59e1d1-2e8f11a8885mr11178010a91.29.1730161338938;
        Mon, 28 Oct 2024 17:22:18 -0700 (PDT)
Received: from pengdl-ub.localdomain ([106.37.77.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48e4a2sm10175507a91.2.2024.10.28.17.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 17:22:17 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: ast@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH v4 0/3] bpf: Using binary search to improve the performance of btf_find_by_name_kind
Date: Tue, 29 Oct 2024 08:22:05 +0800
Message-Id: <20241029002208.1947947-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we are only using the linear search method to find the type
id by the name, which has a time complexity of O(n). This change involves
sorting the names of btf types in ascending order and using binary search,
which has a time complexity of O(log(n)). This idea was inspired by the
following patch:

60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()").

At present, this improvement is only for searching in vmlinux's and module's BTFs.

Another change is the search direction, where we search the BTF first and
then its base, the type id of the first matched btf_type will be returned.

Here is a time-consuming result that finding 87590 type ids by their names in
vmlinux's BTF.

Before: 158426 ms
After:     114 ms

The average lookup performance has improved more than 1000x in the above scenario.

v4:
 - Divide the patch into two parts: kernel and libbpf
 - Use Eduard's code to sort btf_types in the btf__dedup function
 - Correct some btf testcases due to modifications of the order of btf_types.

v3:
 - Link: https://lore.kernel.org/all/20240608140835.965949-1-dolinux.peng@gmail.com/
 - Sort btf_types during build process other than during boot, to reduce the
   overhead of memory and boot time.

v2:
 - Link: https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@sangfor.com.cn

Donglin Peng (3):
  libbpf: Sort btf_types in ascending order by name
  bpf: Using binary search to improve the performance of
    btf_find_by_name_kind
  libbpf: Using binary search to improve the performance of
    btf__find_by_name_kind

 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              | 157 +++++++++-
 tools/lib/bpf/btf.c                           | 274 +++++++++++++---
 tools/testing/selftests/bpf/prog_tests/btf.c  | 296 +++++++++---------
 .../bpf/prog_tests/btf_dedup_split.c          |  64 ++--
 5 files changed, 555 insertions(+), 237 deletions(-)

-- 
2.34.1


