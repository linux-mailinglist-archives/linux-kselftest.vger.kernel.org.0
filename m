Return-Path: <linux-kselftest+bounces-28271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E869A4F491
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F7D168EC0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D83190688;
	Wed,  5 Mar 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/Vh7wRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37418EFD4
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141051; cv=none; b=IhQ9jeRrfZ3HpBfU+yxAmuof4ahp0eZlqSK325F5EIvq5BNy/lG3G58fFpGcDeizHrUuEguUt5Zr7EFNoehvLHSJfQlJXLhsJ7Zqg1wl7OREZQqkSjaxKNCegggcxMKe4J4NviVLrIqvH67t9N1U9uNpfuDLn+LZ4Z5YLR4Dalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141051; c=relaxed/simple;
	bh=92tjd51ZxlOW6iKXAPr3x72R2NqaT4p+LyMw3QPXUtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0gK/juf/z4idECEtMtseILEVRI+F+GOU8tYMGWZdajm2YstMQpkL1VkvMdBUPwyi5l1XDvASKgk4KxqNi0Xf7u4Kr634jZ15/PtRZR5C+dIFOMvdA16g9XWD0VtHWoBFTEiW9Cjq2hvlBF6DAz8tBeImWSAa7F5eSOJMbwFU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E/Vh7wRq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4c2eaeddeso756958a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 18:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141049; x=1741745849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GUuWdJKxZ3/BvY94DN0LEqc9J/B6h1FHzMtAHgZb/M=;
        b=E/Vh7wRqVxkMZ+wUn6gWYwv21ASEkrgMxBDITGLZxksCXvscZbl1VNBLnFimoZshcy
         LM5947BkIiIXZ1q5QiAIQlGKZDg2Us2953USRmBhaTr72Iy71NvBaOCRrKH5sZcKK1AL
         j8K3mvAxXObXdl2X3dxed6jrWpmQxDj4/Vy1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141049; x=1741745849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GUuWdJKxZ3/BvY94DN0LEqc9J/B6h1FHzMtAHgZb/M=;
        b=aCY+eQou2jv8M/ZFQ1QCFGOGJ5+gGQIpBMYZUn7+7ahEnhHlFPJREksu/1vilUK1d0
         Q9t4FT2qpgAIrh285x4VCP4y/A4B7hu+OLhT7WlblVvs8M07vSLCYLXGIBFTQw7cPqX5
         /FsaYU+2kKOQDWS8C4CdjG6VTj80TAWlFqEl+NECOksN4rJTB+mvMMSkAu1dga5I6Nvu
         sxpCxWC6/DnwdbPoRgTF2e+KVQX6UqvhNJBSVUy8wPFHITBEPcFHlfgFIEKqXBsK5lwb
         ZxaOc3ck/YPIlpKoz2ztCHwOmp7ZEf8xnwmfKcRtNnz91ewTRVumuYDWYnax7U02OdbY
         tIwg==
X-Forwarded-Encrypted: i=1; AJvYcCUelHWlTNyF57OaKRmYAomL2MVryzpC2DYRjGQPjd4/ipz+PkgN3qa6YbG2/d6KDBSW+YlTz7s2iDLr47ic4fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFVxVMp2DqfCJDrxRRtJn8nLNDv28EmCEi8CO5ghQVXwqWGS/
	YAS3wA5qgyO26VPE9yDcbGPoeorhyyCOI+e/9dOvH8IYLis+tO8lun1I7htLjA==
X-Gm-Gg: ASbGnctnlwk9tqz9dPLx/QUApJuPebnZKpxEcD15km/mHNzWUDbiFhP4jfcpNhiwKQ6
	fDkicAzGeJs1ecII2nA2530pKlmDSKb1LDC+GgfHwjrjZQN/ZSF+Y8BXNPyn9xof+J2J4slsH2o
	0IJ1yNySsvhY36N15ReN1HOk2+fryBwsS0kimvLjC0Wwvn8Rh6dv+vdu4U/NwHIspqmnTHL1hMV
	Sl4Uh/0h9+5/pFp+RLJmZkcTqcUFeiumwV0syTf8fRg+mRqVa0dNdwrSKh3SmQ4X9l5SggcEnc3
	vbhBWcveBGbxNVwoSE+LlP6+nLQ96eVCkv4bG3yS6BKToGNeyVSAXDlIPojNNB++5FkzcjBoPva
	+
X-Google-Smtp-Source: AGHT+IES9/6N/5toY1Cf9aspTXKgI3/7p+xl7igipg0af9FRFEO+OX7pUZ04JGOESjzxfe8IxQnMgQ==
X-Received: by 2002:a05:6402:51d4:b0:5de:cb8d:1c82 with SMTP id 4fb4d7f45d1cf-5e59f3a84f8mr383796a12.4.1741141048576;
        Tue, 04 Mar 2025 18:17:28 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:27 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v9 5/7] mseal sysmap: uprobe mapping
Date: Wed,  5 Mar 2025 02:17:09 +0000
Message-ID: <20250305021711.3867874-6-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support to mseal the uprobe mapping.

Unlike other system mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime. It could be sealed from creation.

Test was done with perf tool, and observe the uprobe mapping is sealed.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 kernel/events/uprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bf2a87a0a378..98632bc47216 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1683,7 +1683,8 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
+				VM_SEALED_SYSMAP,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-- 
2.48.1.711.g2feabab25a-goog


