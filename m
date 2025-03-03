Return-Path: <linux-kselftest+bounces-27999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFE9A4B773
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 06:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F83A2B50
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 05:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399BF1E1C1A;
	Mon,  3 Mar 2025 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="liCFx+bP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5F1E834B
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978582; cv=none; b=E5WB95hsOke56decxWuC5O1QHgwUYcEi8Pa54HOIcvsiHMoye9LOfXMsGRnQiapEDmKwL7F+z4pyI3uE/BVUHYSv4A/hAOm9G+mJZCAKJJ47lbU8n2A85rq13/Z7RMbsFIawT4VTQi/LbFKt0ZZI0pjLQfkpfs92/xO2q628kxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978582; c=relaxed/simple;
	bh=WLzo15XZCOUhn48p1nU5oCESt5AY/XAN1+82zsPI/4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EssG16JPztam5bXTMgGvvcKo7OpXyp7f5Jag2M7F75+X9+Uc8RfR9PtTiiGOjwotbpjxUP9xup5f2yXdSJyjSaW1kV/2+5DV7pXVIp1TUQSJY92lGY9W7YpyzH5TnxC7Zc/mc+L0oZ9mMVjoOB3gWGn4q+SS47wmfFWcX7VCwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=liCFx+bP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dbe706f94fso611103a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Mar 2025 21:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978579; x=1741583379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYjwm8dHrLXGz6gb7qV5M3QfXuZDejaPJfbAmodOPNU=;
        b=liCFx+bPN8LLL5lhssS5CRtivEw4TPdaaCXsWoGTxBu43/B29kAaBateO593VCtUtQ
         d+idFLivxLJqGtcQFj2gjgwpF9L0KmZa5FNp9m1ySOLicnTz0i3GJNQ4kCE3sQeXa5jp
         1seC5xXl27XTCNdX9/z0V+/qHvEUCL/5M5ySI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978579; x=1741583379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYjwm8dHrLXGz6gb7qV5M3QfXuZDejaPJfbAmodOPNU=;
        b=Nct2kuobax12oteL8I7rWMdAF9oWxAeOL9L9yIKMXduT7/bScwWomD/lSSmoPmkhKV
         0PGbask1EnhfQHFc+4b7pFrEBMN1j9xDANk70MtxhLz5aS4bthIbiyBbfK5pw23WVcS7
         c2hIhxpQlgp4baVvLA32GrU4f2ZeKaB4JH9fh/Q69Mbwir1oPdrL8vW+6Kz8uWo0LL5p
         uFiCLITQtCeu7hOcvO73wbyfrZHe1uVAI7Xxbs5/aD0yuq1wf+J9wQrMf78k0gm4f2e0
         T+sKIh+OUZATrcl22Rx8emvvwcVrizpXWfnzmaknIvQI5fNG8B1Yb0waC9kfMTc+tu5V
         FG/g==
X-Forwarded-Encrypted: i=1; AJvYcCVZFgw46TJ1X09b3dUBJiW9Y1qWdYDGuTuHSKUvA+gkLj7O2Qn8Od5qpMDUOzSzDJeoDAlL1N84dpbPZF9KVHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BPYbiXfNJO3xzliVOkIlgm+uD8uXn115nHSyJ5eln6HEnpIE
	d3xHyrMa4jdZg2EpPB/BqqXhMtClKwePoCcI4WUpLikz8O79yDtH8w0uFhBBgw==
X-Gm-Gg: ASbGncs416OzeqG9ml2kFigy8q4rjL0iqYnX/yWhePKnngLOGSSLyHeC8Pn9WQzHT9V
	MT/8msVqIJiw91R8O+y/ixDzSKkSJpqpt3jPguudYvfUy40XFAIVHlDVH18xgVjnflZrqfnj42Q
	0hSLI5Wqjd1zhEucWuwNetcVyYrYouBi9EoRrQK6sjg165vGXWqYd0nraXXaipAm7h/g7Q3wrTx
	bgDU2oRuE3dH5DZySpYVgE57kpltBwThIXOB/qn8uzMS2O27J76D4LEehCneRrrWUDxgYsDF0kV
	RblbJ4aZrPrsdB+zdsSOvfuw8+WXqbum69nK67rsfVc9yJAnWA1aeyXYnGnOZTzFCGi1z4nzqu6
	3
X-Google-Smtp-Source: AGHT+IHtOuKA+9OaPh5jrHwcaVGv4sg/p5d2FB/xdLoG2RY8640XMMB99IsWJcicRocUIUi11DwD4w==
X-Received: by 2002:a05:6402:518b:b0:5e4:d192:86c5 with SMTP id 4fb4d7f45d1cf-5e4d6b85dd2mr4581736a12.9.1740978578724;
        Sun, 02 Mar 2025 21:09:38 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:37 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v8 5/7] mseal sysmap: uprobe mapping
Date: Mon,  3 Mar 2025 05:09:19 +0000
Message-ID: <20250303050921.3033083-6-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
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


