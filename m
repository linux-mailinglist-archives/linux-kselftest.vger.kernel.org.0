Return-Path: <linux-kselftest+bounces-40398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD4AB3DB2B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7025F3BDF6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 07:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E726E17D;
	Mon,  1 Sep 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFXggihZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8726B75C;
	Mon,  1 Sep 2025 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712170; cv=none; b=PHLX48fUYMOFqyB/tMcNC6nLxrQDa+NZXcCSH221Zk07uekJur9DM6a47NbUkOz1+R/dfDtyEHYp7wAUHtU/LNoqKpJ8M/UcbXkPpBKe4tcgwnxTxcDiqfrw8YpFtoM//M9t89jE/R4eEH6k9sjT7l+uh029PvX4eg73dcVkugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712170; c=relaxed/simple;
	bh=XtcYQsnlt/MpvhRZweVSIJp4WCI2Wkjt8xxorH7ZWKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KqOIBR0eH7oCFsCMdCsGzqYaRVU4FSs3t5bxlQX5OG7gd2spGLtWvIyxiVu/ut5/Ih2+Lew5GC8Yi+DVNYtXXR34pdpgBGQPacqIIkl7bO77hb8xIHWqoPs9yUaZqCkhv8AEJgXacL6dYgwIj1HL1cZ6G8cnDaXqQ9DkzQs2VYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFXggihZ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2445824dc27so36088745ad.3;
        Mon, 01 Sep 2025 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756712168; x=1757316968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkiDk4VN+vEmKndKCn5oB/XjLwcQPTcM/uTsBqiYe+s=;
        b=eFXggihZcECY3sGtRq3ZlI+Vao5N/G8qQHu2Fge64cIV4vbjelIwCB4easRI/hV95U
         T09VI90RwkSZ6n4PPl+wumm2BgQAJlH9FfqqIC4CQI1eKhe+Uxw/XdGOtpftsq/hPDDI
         xuDecok3viExRqBrYg/q+HJ3HzmfndegouI2oLSd6gobhbxQGmrYrrUWfV9YPfCvMeNu
         HrU6hzP57IjtjxhZxglccO+bFGngX2l4TrCj+BjEUjBMyyGTLGf3eZpjGkReqArWSfn0
         ZVjBnmXKUZ+qcVldpxTDDYLgZuWPmMPXOcMhYCUakOBJLllqGxgzyCAcpHkF3l4WIDhu
         NmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712168; x=1757316968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkiDk4VN+vEmKndKCn5oB/XjLwcQPTcM/uTsBqiYe+s=;
        b=u0KBCLZpqtyQ/T5VXP5xQxy+6d1k5lZtHP07zC0q9Pb9kNtr1Ylt6OkcvZ3chXUNMu
         4IVNWoOL2cSGANS2h0eVogOAcI1g2dB6ik4pqo5Xo7K2mvu0zecNdo8Za9q9ZrOZlHfG
         j649LuBjj1bW2grZJcCFIOjYH4p/iByWj2gBwWAqELr3pSBnNrUYjqDjCXMT6W7pWyjd
         nbVMFHOQDbNgqkoBhG9mgAjHwfD5atvDx9+2RfXJkipTXuhVEbb5OeUgGdMFrftJ3X8l
         vCe9XLo+s2DZ8pVGmuiLW5cL0H1DpAwoqG5aBNrj5edFbrOJ32s2ojIyL4aBjvuk8yEN
         DwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0YSvzR21Rn7qTIwyGJcPfZ76couDtQ9gE1AP0mBisUKawkc8smcZrfXwBs2TcbABHbflZfN5++45IM2x3@vger.kernel.org, AJvYcCVyfX17oyFQ692ao7CtHaUxzdtGo9Ygx1VTQSwpxrHSwbUEjbmvun+SV9+TnnWSBMKe0ok=@vger.kernel.org, AJvYcCWtb5UbgKVtVvspB2oQApdXPfuKtwWxQgaFNz4MpzyeKVEdtVPKafq2LI9RMeYbb8MYgpwPkhB/5I3p6KZ0gz4/@vger.kernel.org
X-Gm-Message-State: AOJu0YzTIe6twhRz0DpzW0m1jY/tOhWRuxAs9R57TLXR4Ck7ApI8BjcC
	rqBLCa7eGd5HVgciKpRTKqJ+YdIjiddFj/r9u15Bx+izt/YQOID+C/M9
X-Gm-Gg: ASbGncuf0AkO2GfRc5b+aBYmgZt9wFKEQnVwuU3xcGbUtJ5EcwA3yHHznvF8vRquJ4w
	C8D0XwmanhZ4+x1OhP4yFD/LkYN9qRid6G6NpXxfq1f7u5mRJDXjwNcvFZZNRqIS4KMo4d3G7dh
	AwvQguwjEqx0eWfzRboVoQSk4rNVzmSQmpzV5BN7JjqQN8nOebW4DO0gjxDR6zMXwMWtr3KRHWG
	D910RuXElPjxY00dR2tpsZGJMoF/L/0gVkz+u+/kp+7EDm5BV4PAyBmHaie8VgLWXqas5iFVPk/
	jxop9SNnlMv9znOlD/S2609bFUECkaSTkwmVOGKzRl9hEfMEq1K+/vOGmx9d9Cqimpo8EntO0nE
	SlgOo+u0+QWLWtZDI2wNG
X-Google-Smtp-Source: AGHT+IE0fxda67lxyd5c0ekaSqZeGDPb708pPB9HUQ+wDEYZYnJ70slNseJr2MZAIOPmzUcG3kkICA==
X-Received: by 2002:a17:903:2f8a:b0:24a:e25d:c704 with SMTP id d9443c01a7336-24ae25dc9a2mr14677165ad.47.1756712168294;
        Mon, 01 Sep 2025 00:36:08 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([2406:8dc0:6008:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903737b05sm95867045ad.49.2025.09.01.00.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:36:07 -0700 (PDT)
From: dayss1224@gmail.com
To: pbonzini@redhat.com,
	shuah@kernel.org,
	anup@brainfault.org
Cc: atish.patra@linux.dev,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Dong Yang <dayss1224@gmail.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 1/3] KVM: riscv: selftests: Use the existing RISCV_FENCE macro in `rseq-riscv.h`
Date: Mon,  1 Sep 2025 15:35:49 +0800
Message-Id: <85e5e51757c9289ca463fbc4ba6d22f9c9db791b.1756710918.git.dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756710918.git.dayss1224@gmail.com>
References: <cover.1756710918.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quan Zhou <zhouquan@iscas.ac.cn>

To avoid redefinition issues with RISCV_FENCE,
 directly reference the existing macro in `rseq-riscv.h`.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dong Yang <dayss1224@gmail.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/rseq/rseq-riscv.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 67d544aaa9a3..06c840e81c8b 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -8,6 +8,7 @@
  * exception when executed in all modes.
  */
 #include <endian.h>
+#include <asm/fence.h>
 
 #if defined(__BYTE_ORDER) ? (__BYTE_ORDER == __LITTLE_ENDIAN) : defined(__LITTLE_ENDIAN)
 #define RSEQ_SIG   0xf1401073  /* csrr mhartid, x0 */
@@ -24,8 +25,6 @@
 #define REG_L	__REG_SEL("ld ", "lw ")
 #define REG_S	__REG_SEL("sd ", "sw ")
 
-#define RISCV_FENCE(p, s) \
-	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
 #define rseq_smp_mb()	RISCV_FENCE(rw, rw)
 #define rseq_smp_rmb()	RISCV_FENCE(r, r)
 #define rseq_smp_wmb()	RISCV_FENCE(w, w)
-- 
2.34.1


