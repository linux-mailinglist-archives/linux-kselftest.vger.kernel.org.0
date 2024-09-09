Return-Path: <linux-kselftest+bounces-17472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3014970EC8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFF028275D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9369E1AD9FF;
	Mon,  9 Sep 2024 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOb2shye"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5D1AD9F1;
	Mon,  9 Sep 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865700; cv=none; b=HAXBYKOQ56G4AoU0UuG63ZvG1hO5nFQxtR0XI0cbqDlQEpkUgIi87sLDfxa/mzQQ7p6OqpSjge7xf/XEWP2qZmiTww+KnRmfgbe3AEukJnJpv00QkNXUcdiQkdMapKwg7hVN13FPBYL76hRoto3WBxVmxKgGaA3FVsI/ykVCHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865700; c=relaxed/simple;
	bh=vg8RVh1QVSzklqVo21bOPOyAtUZ4RZO6cEL+S2fGkkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHbLOOtJKYyaUnd16ZcJjrwPWgm1+YxMlVNq5Nzm9Vd0V59VY5P4OO5S5ZcXPNbx5UQEGZ9THjE5FPq2QLXElILX/81uqwO2wGl9b+jozglW/zd3uPeDMpnnLhxDuh76Nut+rzfrXO9vQlT5Vg9diZHCUQCR/MpUsrXjgsyyQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOb2shye; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so2573496f8f.1;
        Mon, 09 Sep 2024 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865697; x=1726470497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B7BVoErPcOoKPxSdUBz41r3SRVlI1m5+I4zzu3vMfI=;
        b=hOb2shyew6VcFuElGULlrfNIjky0KF0Pr8T+bMV1osEqJEDlb4yKdZjqIR5auEz/QI
         Ao+qeWQhCNiM6qLB3/yvXiTiKTHgInbDjkJq2fcDoJCxGj4w4lMMDaCdjBM9xD78Tw1H
         gyr7BmoR4Z7u6rttdffn/l+5T6OUwfuRb6GWiKCdBW+17g6mrDUdWEWjHWtgAuzcDgXP
         8OxxvAP4w4+/+18QO6Ub1cckD/UfePT5ICMBDszAIhXtUJ1fTejrjKMY5K1nY2U3J3pH
         QKJZPdn1NYi7PJaTKV7bnRCIwNxVNYFPrz7ikzMdUgXCycdgb0OHNeyxhcVzQRGSsl7H
         xzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865697; x=1726470497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B7BVoErPcOoKPxSdUBz41r3SRVlI1m5+I4zzu3vMfI=;
        b=KuTVlD+OrDDyGjdlsz7wdLJJ7NE3bo5z701VI4bIxL9S+Gds7cjWfVeD5C+uSTqWdr
         GQElE0Q3P6X3usMjHkksNRjZNpDceo9Gb3lzwEeOhfeWS+gIY1+AwuodB8g0s9v1qdyW
         FAUFgbc6ap2IRfEit5KfvTU1cORFkPM+f0noqqyBGhYbMTYQsHZn4S7cMOmENyVhSwCI
         FqFVzoNqAa9a5HBQrFOZ8cLMAXHtFcSghhKBDSstAEh06PN/3oyVE+9bjcL5LampSJnQ
         +zRSuoXUZmKg3joyDpzHgLasv5+E2lWeB4RAGzPcdWprJR3dKOFbHV1aOJWpQ0N+RHYF
         59tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQb25kQyBmaNG8nJUwedggVSTMhgOMmF4lOQeJagL9jJgn0TnVLSAxV9H735nsVp3B2PtEJmN2YG3kog==@vger.kernel.org, AJvYcCVOCYj5tV1FDDox2p1WXj9JkZS8yq1w3J4vhJe6q/JQDBnfSDUKi4QWI6N6vY9nSs7UT3E=@vger.kernel.org, AJvYcCVbNxPujFfFnPkeeea7zLgaA+3+5kP7IrbmRgMQqH0/qaZs85USjJS3cuAG8XZ0ECM2tMNfSqUkzoT+iAU=@vger.kernel.org, AJvYcCWmbfcje/Y9okhRxV7YH++yIFDmU3seqdu07VdhnwrJVZ8bTIqQwm4yHO8L7dFVpk7IjRx/i0tcCxc3+OnV@vger.kernel.org, AJvYcCXGfiSt1lDTVmlSjMH6he3HOJlBo9fw43YP/S2arzjHvoBh8rE4wFkDVZp6EqrRXTRTk7k2TB+8IBrq1N7LswsN@vger.kernel.org, AJvYcCXVDWg9NES1B9EcvtKqq4BCOq/PImnMpEKo6oN1J1C259+zHCFw/VAbkhdSI2EYgoD/Rfo72fxuU9WuKbp6/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4C7kuOXhPPEWOtcnDSKVD90Zu291hOy3qxy8Sauq7BuY6CqQB
	LciMcPXayyKQiLzZQxsJnGYpFr46FSjUQZg2rTXHSgJckJIFbemr
X-Google-Smtp-Source: AGHT+IGYyMu3Vg6t0QKAaHpT+Zfos7iWqitbr5XWvfDWFMrJwqorNUfbV12tuLSocQgEo0BB8LI95Q==
X-Received: by 2002:adf:fe84:0:b0:371:8e3c:59 with SMTP id ffacd0b85a97d-378895c2578mr7304772f8f.5.1725865697132;
        Mon, 09 Sep 2024 00:08:17 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:16 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 01/19] x86/kaslr: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:15 +0200
Message-ID: <20240909070742.75425-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/mm/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 230f1dee4f09..e17e6e27b7ec 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -22,7 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/memblock.h>
 #include <linux/pgtable.h>
 
-- 
2.46.0


