Return-Path: <linux-kselftest+bounces-15577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA05955425
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 02:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693DD284D67
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 00:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C9F4EE;
	Sat, 17 Aug 2024 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOpCB0Ip"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACDD528;
	Sat, 17 Aug 2024 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853935; cv=none; b=gqM6YTCiK5NHLDzNrs9Q7OW3G91NEVPnkNpP20o5QX8NA1EAyDd5c6zOGkXQKKMYbJTt1ddvFYbSFC1bv73RhG2mnvrmfHJjiq4i6+rQTc4geAxi3qnD4RDAIZRDD72BsXwVsWvZdwApiRRG8Abc/92bCx07Gm0nsckBr/3FASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853935; c=relaxed/simple;
	bh=PPVtoGfH+n/uXz0XuV6YOIVjCU0QeGSJrXMAVw/dm04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnGNksFKRwltTLiIQJbl2+WIewNOboQxqzkB22V9LNIepr7KDJBpgoSVB9WfsSHKZj4D2GfilmnVt3RsjrJ9xLNEJTQJDMDEtTrOSJgxKXbFr3gvJHDQbiyyPz7QLIikvIIy94s43Z8uYlsUIynJdquW/Z7Me4cFoT4nC4JOQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOpCB0Ip; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e3129851so18558585e9.3;
        Fri, 16 Aug 2024 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723853927; x=1724458727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVSLpFCNCxLphAVPpePgVTrDRTKaNng95YGqfZlpIJs=;
        b=aOpCB0IpmkuI6bIUJviDnPvryY4GnxPru1q4dFEEeCDpeFRIKOwMSmrWBALoBCyNx4
         K2fuuVo914vKFCZrO1espBYK4m0B/Ph1ilERhJItl8JOHPBa7TCgbR5icbJAcLbx++SO
         0BFOqrt/x3OOmtph6eJ4l9HAiwkYS0CUDsVWFVSIkbzNUSp8Me25Dqg5yOaToW5YwTvN
         6qjf6Chl3UuLsPjhN4RphvBTqZ34Lb5X0Fn8XElVoz7TuKHzzgiZS4ELjRPFnM45uyZa
         afmu0BIjcNCdw0MllXOE1p8LrVome8O8yYmClNzUtKZZDslG6ni9NRM9GkgsC1snSJOB
         yNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853927; x=1724458727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVSLpFCNCxLphAVPpePgVTrDRTKaNng95YGqfZlpIJs=;
        b=AdDA3LK/IcyoTQdmpvN0XCJSDMi9uJU5sBmQ/yMRFF3XippdJP59kzPiTcIa+EC22I
         4SYjkUQudEB73uwMZh8yUMHUO+An6HMRPfl7VaErL8rjSVvaFJxjT6CuLOa8WJ2xorM5
         mqhBAbEh9zMTRolXNDEEq3OyQXqpaTiE2eTN6Rc67bdAyvSZsTyRpHuZIHj8CcwvYlrs
         8DblhlTBBAuQSggMyGIyEhWicPqqvizXiG27dTrNS/6RyfhGMahgXBBTj0tHUfNq1hoS
         re6AseehyL0ENydWOPzQtpkPJ+fpyobOvWOPyZw/W0KDgHhsPO0Yz1fbeAVUDTSCLWW+
         //Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUnf9atiMb+SObz7id57cTebBMZf9XyGVM+oZMKIyD5ChKqRlUDl1/dEmDvLzAd7VXWI0nyTB3wI37MCsklImGaLQdTp/5SItur/V2ZHt6fuk5ODlihIUnrKD94nyOxRbYqNfOzJYyQzgmuXPJY
X-Gm-Message-State: AOJu0YzCfDVRzuXyBCt19q2zBjFx5J/Ezfr5yGovMSZm27+OMzX+oda6
	7pp8cLHHxCNU903SvY60FVk5tG9UyCgB40Fxu/ntR33pdk+aMqJ9Uw0GBoe3
X-Google-Smtp-Source: AGHT+IEF/45IWEnY8seUwWDHiPQtCFESvI6bebHfacPqy451180xkuSrsBTLSGa9GQqBMGnh8DYNYw==
X-Received: by 2002:a05:600c:35c5:b0:428:1a48:d5cf with SMTP id 5b1f17b1804b1-429ed7ba070mr33189155e9.9.1723853925945;
        Fri, 16 Aug 2024 17:18:45 -0700 (PDT)
Received: from [192.168.1.91] ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm104842055e9.0.2024.08.16.17.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 17:18:45 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sat, 17 Aug 2024 01:18:33 +0100
Subject: [PATCH v3 6/7] mm: Remove can_modify_mm()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-mseal-depessimize-v3-6-d8d2e037df30@gmail.com>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
In-Reply-To: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
 torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
 Kees Cook <kees@kernel.org>, Pedro Falcato <pedro.falcato@gmail.com>
X-Mailer: b4 0.14.1

With no more users in the tree, we can finally remove can_modify_mm().

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/internal.h | 14 --------------
 mm/mseal.c    | 21 ---------------------
 2 files changed, 35 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1db320650539..3b738b0ad893 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1361,25 +1361,11 @@ static inline int can_do_mseal(unsigned long flags)
 	return 0;
 }
 
-bool can_modify_mm(struct mm_struct *mm, unsigned long start,
-		unsigned long end);
 #else
 static inline int can_do_mseal(unsigned long flags)
 {
 	return -EPERM;
 }
-
-static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
-		unsigned long end)
-{
-	return true;
-}
-
-static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
-		unsigned long end, int behavior)
-{
-	return true;
-}
 #endif
 
 #ifdef CONFIG_SHRINKER_DEBUG
diff --git a/mm/mseal.c b/mm/mseal.c
index fdd1666344fa..28cd17d7aaf2 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -53,27 +53,6 @@ static bool is_ro_anon(struct vm_area_struct *vma)
 	return false;
 }
 
-/*
- * Check if the vmas of a memory range are allowed to be modified.
- * the memory ranger can have a gap (unallocated memory).
- * return true, if it is allowed.
- */
-bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
-{
-	struct vm_area_struct *vma;
-
-	VMA_ITERATOR(vmi, mm, start);
-
-	/* going through each vma to check. */
-	for_each_vma_range(vmi, vma, end) {
-		if (unlikely(!can_modify_vma(vma)))
-			return false;
-	}
-
-	/* Allow by default. */
-	return true;
-}
-
 /*
  * Check if a vma is allowed to be modified by madvise.
  */

-- 
2.46.0


