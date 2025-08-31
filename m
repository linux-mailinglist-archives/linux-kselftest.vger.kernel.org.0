Return-Path: <linux-kselftest+bounces-40373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1C9B3D0CB
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 04:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63111A8078B
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AFA1DED63;
	Sun, 31 Aug 2025 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMuoyTOX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47F1A7253
	for <linux-kselftest@vger.kernel.org>; Sun, 31 Aug 2025 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756607230; cv=none; b=aKJEPa9fUudByDX7arZ977ys6eS+whw4gT5tc2pmFQ4hz+Lv+O9TqRs1GqrYl2cvSPw/M5LxQw0qTDqdEU0VpIYvn1ULYzJwY7HFwbr6BNJ4VQlFUrx3LEIyU9EorVsSq+hrTsp54E5jnu/YEgK1Z4QgmIX1GghPMjo+AMtCvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756607230; c=relaxed/simple;
	bh=FuTzmWh6EwBqUd91xLw2nUrpj5PU3M+KaZk97ellh2A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=agFzuj5ja4cCAV2eOvS+hQ05I0tJhzAzjijMNjw9vxGnAIxMu+qEqqTT6/l1LfvsX45Df/DH+ttLqZPG0O1TO1zbQLKZ9sIW4XEWlddEpLVt/nMSbHnyJTaLUlSMrGhWkcd/MQp8NhXD2Mw8UasOxWEIXr4Uq/C3aSbMQfjnoig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMuoyTOX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso5068191a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Aug 2025 19:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756607226; x=1757212026; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx5oAXDKVN11+SqKhk6XnmijMtN6s+BtalzbMhItzec=;
        b=TMuoyTOX7D8XvJLy3d9QNb0iYfULpqiVtw4RnNbaGDlaPcDZiukUfiq4c2SM9iHpD5
         q3Uydqmtl/tJAL1zzUMiZ7INI51b5iHy1547OLTmw5OTM6TULLGBAINUyid79/uquLPm
         KYW8soORajS8BGRdpW1jtFttw94xo1N+eK8GC3zg/lSwZjz3Dr5N5+X+wnQOtXWmHcbG
         6mGmlmCDn93di8RU/3MmeAoYEANUaFN4TD1+H0yUjCvx3LEInq7egLaBIO/LYrOF6KLZ
         P9bYWVW3YAWsQjAjjvav4ZTs3fhBBiGb6o1OMTbWEP2qlO6J6L1trbMwcJD2m0coDYvW
         FdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756607226; x=1757212026;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qx5oAXDKVN11+SqKhk6XnmijMtN6s+BtalzbMhItzec=;
        b=XeJIK/Bjn2ckXcT73DOKP2MauS2vqz+fpQpWZHmhRKTe1eEmUn7VWzXJsvWC0TwRnx
         c8SCUVjqr0sQT3mMeGJyAI0JB3FDuMvCnRFv85Nz/gFzlCbsJYR5szSCUNfC5NmpOy+O
         /dIyZHZcQ6k6ikQwlYiZzSvE/xSqmjQw6l4fkPq0D62i2qvpTu63ERh/rEhjB/gebNp1
         uEno6RqYUpJBya4VHObGe9znKrmqeh9Fl2O5p/vr+N3aidiEk642GTUnLzd+sz5Xz+yI
         81YhvHm4bA5sRCYcQgnKgkqk6Wvrm9oORrz13C+xOfql5FPV1KIVJJBvTjXh7qScvdTJ
         D1DA==
X-Forwarded-Encrypted: i=1; AJvYcCXMlowl6WxDWUaNjyx2PuO8xLrd9YmZ/a1PaL6bInojf5Q1gyuHYehaUnyc0lWPUUYTdsXp0cJFWUN4fwKY994=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsynp74W5pj2pga7KU5f1NAFCEYNpN5NHvYcnkKA04vK5PKVXJ
	/lwlfiswOfQFJfVzi4jO6a2G+Epj80hZxl8Kf/Pe75u4Q5bdAMInUQyE
X-Gm-Gg: ASbGnctgSV28qDqoBG8HemT+SPMJLzKJ93aNGkVbeJn/eFZmMCwDCuz+6ii69jBtftf
	UTxG1O+0Ku1GXdJVpJ8ncuh+Fmy/o7w1aM9AkAe3roDlwnGZRPaflGrfXLskfV/NEV+Uko15oXY
	qeBk0YKdCktAb1rlufpg3i8xZ/DG3N3okyPWNEhjgdEjd5emPS0BdIoDj1BhUB2uEv0TlbflhHL
	1/z/P+7M86fwu+kRlTghzbckpm3Xsj1T7UIrhGdLA5L2lF750/zzFx3BC8zgaAK3j4bJRHpL300
	9ljreg0qwX0Hm6crXIp0Nw0QHOb3ynqOGQNTlnWab4GMmXuejsjrSjOFKXu2QaeA4yDmmrUz+aV
	I+Zhv0G/yILWFBw3YwCl4a+YdZuXP2DcvqWys
X-Google-Smtp-Source: AGHT+IGfcvjO3j3fIFIuIdn+jDiKXtrzcTeW6OXMfOiNJFGbP+eAQpnIa5i6CJs+MOMzNMFoo3pbGQ==
X-Received: by 2002:a05:6402:3228:b0:61c:cbac:f6c with SMTP id 4fb4d7f45d1cf-61d26c33cc1mr4121687a12.23.1756607225676;
        Sat, 30 Aug 2025 19:27:05 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4bbc6bsm4495215a12.29.2025.08.30.19.27.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Aug 2025 19:27:04 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2] selftests/mm: check content to see whether mremap corrupt data
Date: Sun, 31 Aug 2025 02:27:01 +0000
Message-Id: <20250831022701.2595-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

After mremap(), add a check on content to see whether mremap corrupt
data.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: add check on content instead of just test backed folio
---
 tools/testing/selftests/mm/split_huge_page_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 10ae65ea032f..229b6dcabece 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -423,10 +423,14 @@ static void split_pte_mapped_thp(void)
 
 	/* smap does not show THPs after mremap, use kpageflags instead */
 	thp_size = 0;
-	for (i = 0; i < pagesize * 4; i++)
+	for (i = 0; i < pagesize * 4; i++) {
+		if (pte_mapped[i] != (char)i)
+			ksft_exit_fail_msg("%ld byte corrupted\n", i);
+
 		if (i % pagesize == 0 &&
 		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
 			thp_size++;
+	}
 
 	if (thp_size != 4)
 		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
-- 
2.34.1


