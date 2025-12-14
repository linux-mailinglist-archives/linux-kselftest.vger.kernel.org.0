Return-Path: <linux-kselftest+bounces-47567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7BFCBBD96
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340F530141E4
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F682DF141;
	Sun, 14 Dec 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9hrJun6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EC8261B98
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730153; cv=none; b=WhduLrKgkG2/Iw7h+aNbJkv8izPzFFqs8YIJLM/aG/evz//pEjhLP6TyzbDH934JU48v3HN+9mApmj//gDjFzGmJK9/PSo4nA+FWilx+CmzjKy4k0EDhOFvQsyk/yjbXiCSZD0OqPvRGs011m88csKuDSvEdhd5OYzyqYECYzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730153; c=relaxed/simple;
	bh=XDQQaARGK40hFuueUlB/TBErHoYg3YAnnNfm11ShX2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx9oNm1fV2sw9VABjEGOq1uYqRU40tjY3jVMgtGhlC9tCKaX9byt47h7/4MusHRI1S1KbP3bWjiSm1XJVwzwZBA6hDvpKJ7daaxes/C4D7iFr9PJgW+SDO7HwoJNv6eGUKazJZTVOQhlqkEiIMeLfPNu1B/QyFWZo5EWzLtetIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9hrJun6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5958931c9c7so3330230e87.2
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730150; x=1766334950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSza8k/VWcFFoMSfwlhWsVuvw7zo5x41+rEafb2iuhE=;
        b=h9hrJun62HeUhpQKDsOaQD2IO2tq+IU/Hpzi3JrnPHxU+ecBWYt5C33quixITGa/p2
         4co0qdFIQKSCCzbSrTwXO4yA8qAbYjzkdXv6g8RYi78TH9VCTBQQVQZ/F9y3H5x3kgIK
         o+mrKJnLR9rUPwjCRRwYzsE1uwkp6OzIOeq0+7S3GZ27746uo07tYFCMogzXsA+t9ZSV
         KQtMPeR4mw7n5E2doRBV6fLDL8Tk5k9txjZ8KnwqEpF6W9J0tYuEFxxUTTRMtG0vjaRB
         8H5/+7v9BxTk/m+m8j5ixxIgFfUAmQqI58a7aqXYkTUAviSY6hadLhbM/Tk8lvEPVwxC
         mpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730150; x=1766334950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HSza8k/VWcFFoMSfwlhWsVuvw7zo5x41+rEafb2iuhE=;
        b=cn9indP/71Bw8rdiZd5kLb/kxIEzj++G9Gzu9j6lPWzpS+D7+tpe6Od1CwBidUE3oQ
         KsQrVWvLc9t/3Qx8CDs016jQqXkF0AvqqLE+FF3jB1AWkBAI/bRQZyuTpVymKRGLXnnU
         1vYc0cHucFdZLZ5II+FPV+rdx+SDgUAUEOZ67GQECk8ZUrtED/wZcUiiRhUCow6ua5NF
         7Ox1HDn7E7iq9YhLw7+Km5J35aRV+YtKAM7mmKqw6lQqSc18cI5FCWC0egWrUDlbJKim
         uZTs4TKm+Fa3MOspQ2bpJkyVk0k0LjYVAR18CIiUayn269DmIaFcZANRKpbK8rvCwpKu
         sOig==
X-Forwarded-Encrypted: i=1; AJvYcCUE7gORpejrnMOexoguSoZhIVfi8KcaodacLgDkNzsXXeBh0rch04Z0j9DW/xnINIF2ZdDeIEc86cKE17LDmOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEz/bOkLbZDc6i9KU1xNySUrW8VkiygZlb7gpY41GyHfDJ0sa/
	4nyI/QE/jTIltg+kWyOtlHl3Lz6nUqrGz1jJZOtEWq4vkznx7HNZtK3N
X-Gm-Gg: AY/fxX5W+iECvUbJxPAj2z8SEfbAkwDDlqTc6opbpMadzYnsepYrY+1TVSdft+XIfG2
	0Zmehci1NjahZAhLtL+cz5LPFj11Gwa0Vimym/OtRFYRSVEac5JFzQxMj7LapYbyb93u30xDrFw
	XFhAarlEFfZ0aCp++jAkjsOxYtrazjOkUDna7KkCPswcZ7C9S+1r0dFyeW0lmFxULHBt/Qs1/Bj
	Siu9zeJdHCzXkswoaSKzvwdv2ztqkCyZ6JhOh1uIeFkPpXYDeOvIdt4z9TVAmVlviV4Rl601sVS
	QpoIJTYnoca8BRHHs4rfEA/iPkQP/iqRotiLeTKQVPi9zIWuIrNl+SW40uSfF91GqUuYG5tj2uc
	uzYCFNFGLDCmC4F+5p1monKnwzmjYFkwZ65b7S+PzKQ4x5Z6/jEZdPG8AdpQhUxO/PpRm7wedoe
	Eq6g==
X-Google-Smtp-Source: AGHT+IHboafEprMTLQwXHxj0Id+1cWDu6+3jBn6YkXp7nlFJBpxpKVNyj1NgGkyCkOnkNopnc1J00w==
X-Received: by 2002:a05:6512:a8c:b0:598:e92f:7ec9 with SMTP id 2adb3069b0e04-598faa36090mr2426928e87.6.1765730149812;
        Sun, 14 Dec 2025 08:35:49 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:35:49 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v5 3/9] riscv: csr: define vtype register elements
Date: Sun, 14 Dec 2025 19:35:07 +0300
Message-ID: <20251214163537.1054292-4-geomatsi@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251214163537.1054292-1-geomatsi@gmail.com>
References: <20251214163537.1054292-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define masks and shifts for vtype CSR according to the vector specs:
- v0.7.1 used in early T-Head cores, known as xtheadvector in the kernel
- v1.0

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/include/asm/csr.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 4a37a98398ad..38f16538b35c 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -444,6 +444,23 @@
 #define CSR_VTYPE		0xc21
 #define CSR_VLENB		0xc22
 
+#define VTYPE_VLMUL		_AC(7, UL)
+#define VTYPE_VLMUL_FRAC	_AC(4, UL)
+#define VTYPE_VSEW_SHIFT	3
+#define VTYPE_VSEW		(_AC(7, UL) << VTYPE_VSEW_SHIFT)
+#define VTYPE_VTA_SHIFT		6
+#define VTYPE_VTA		(_AC(1, UL) << VTYPE_VTA_SHIFT)
+#define VTYPE_VMA_SHIFT		7
+#define VTYPE_VMA		(_AC(1, UL) << VTYPE_VMA_SHIFT)
+#define VTYPE_VILL_SHIFT	(__riscv_xlen - 1)
+#define VTYPE_VILL		(_AC(1, UL) << VTYPE_VILL_SHIFT)
+
+#define VTYPE_VLMUL_THEAD	_AC(3, UL)
+#define VTYPE_VSEW_THEAD_SHIFT  2
+#define VTYPE_VSEW_THEAD	(_AC(7, UL) << VTYPE_VSEW_THEAD_SHIFT)
+#define VTYPE_VEDIV_THEAD_SHIFT	5
+#define VTYPE_VEDIV_THEAD	(_AC(3, UL) << VTYPE_VEDIV_THEAD_SHIFT)
+
 /* Scalar Crypto Extension - Entropy */
 #define CSR_SEED		0x015
 #define SEED_OPST_MASK		_AC(0xC0000000, UL)
-- 
2.52.0


