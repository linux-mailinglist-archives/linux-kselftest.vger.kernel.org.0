Return-Path: <linux-kselftest+bounces-45185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F3C433F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 20:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E5C3B3240
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44E428C5B1;
	Sat,  8 Nov 2025 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USl2IoFd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAA29ACE5
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630957; cv=none; b=k6KQdBd5b5/bPNlaFxFvKB6Agp0tl3jgCS4xwJORM8wQt2FcwfdV6e74XT6Rpp6tNvoC/hFwBlvapSml7aIqaAG4h7UMXf/gTiAX78AIeP4367D/MkkB7Jatkv5/zNuqEpvYWnzz1jDdNVONFYny94cAGg0xsGC1twP94RWgVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630957; c=relaxed/simple;
	bh=SszDBRaNUcfYH1qxIpllXW9iu+7P8g2nMtcZjbjjKzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrVN7MaNjjSjphVGbG3mc5azT1vhzTLMOga7AbgPpGGvh72C+LsFQu+WKnhXOfN+pMgk+0ySvILpEDraX8hKezAfQ70M8VKZm6Mve2dyJBjQtE2w6I3pSVjPx28DZyplQnL6cOjYU7hKTYL4f/Cts/fwUryk3Klzmq+YwOKDJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USl2IoFd; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a2dced861so17441401fa.1
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630954; x=1763235754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltV9lBgfXlitcw6NuoPhmSgpPYayy6Pa4t7Popjv7fk=;
        b=USl2IoFdPVfsQ/HvaHZgx6lHDr51d7Fwg4MF4AoLu/h0hxxKnp4Fo/+D7dGS3zyQ5v
         yh1Mm7Tnj63hTlntmvErcrLaFHmU82JkMbipB8OP27gwq7EuV8qJcJkBDKJAkzYMlulP
         9+/vpBVsRGu31cTIaWrmvw6TOfOOdbbSrJsNxzuBf+MFxmUeF/gmhQMqIBfqVRPwevFD
         O5nzmtg0OT/WyeWDIGESBAVIN3eJaanYInn5Vm5fsEcAeZXDL+tQBhiZ6YEUZsB3uZu0
         FvbA5ySGIdKpmpoIPbPnIF4Zp6kcj2VlbNblnGM9XtPrSVrIKc2no1mcrfkcPLGLxqDn
         3oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630954; x=1763235754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ltV9lBgfXlitcw6NuoPhmSgpPYayy6Pa4t7Popjv7fk=;
        b=rzoJkgms0iTUyByFRqrnbRs+BLf9YKw9SBSi+IyWlrPdHuGh6C0y1iAJhFoSYigRLq
         iLJgzGeaH1kI3VPveAi/TPLUAQH/DWYWJCPUj/cgeiYza3v6getH3ft02g7VdrscdeI3
         kc54RTK0/Sf2VoDvBUm7V3yfeWAERXISKgz4GQdtB3JfQRP73qQp3JxAdp1I0TySPlN3
         Kc3t7Ftp0p3fAli7ziB9TyXiaF9onJ4pvcj1U7TcpyUxR4YpZI6XxsBQ4uMlpsfGyYDt
         VxRi2GvQKS14RGxyXR12pXS2o5nC2CLSzp5Cj8gSVnJhs9ViEseHGQ/jRXKMpVySub46
         orUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTmWf6CVZ1sF9u2GhSXold8y7U8wHlsD71cXy0Q1ZJd0rF3IyaCDMMcIM9b8C2EUQopeJLBx/5y+ZLVMw0pI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2vY5/thelOdB6PkEjM5Jl6w6AQVnfsjeWWwVkBe9AvkNls1N
	rlCXa/5UoyXl+aOAi7wcw2f+u8r7ghXtHfrE0bAsACMh46NLfhbaVHwa
X-Gm-Gg: ASbGncvGLYziY0IMjM6pc2GKtyw3hOO0vRxyDy5M9lX3WewQdVLNPX24Ko3avJS20fd
	vyFf9kL62/LlWr0FFikB6X9QYx1rkTcu1H4H/XAU9vRmjVrx1iGk9HboeVKv5Tg2LOMgs3fJNbs
	qo/1piF4h0yKTMJqtNQSLmAdy18GY22PvlTprluKVv0+M8F7SbCjK3zpMXFfjbhgu35QJuTwiHK
	TG5zRYOHxIcVe80oM64ll1iiZmL4+ADhEmSR6TrTU20gATJIHpIyudIqeJE8PzsjYqaeVskC4S1
	Rnjy80lyrJxcMrqsfjPOE9NtVaIZ/dSDjX9d6rfOrQdQj/TAKkUio9mQVNd4/o3nDwMg3MCProq
	9JwP8cwOCRwCHTir+8/ZIl7Wr2bZa46/5CCXFiYvJxrj95AXYOY/e7mx3+YWvQ8tOD7A=
X-Google-Smtp-Source: AGHT+IEnp2oCa8v72xcKOc9ex+oyKcuP8x4+4rtHE2r1uNJigvtF1xOkKOxOtbzS+RRziZBzol+Trg==
X-Received: by 2002:a2e:9cc5:0:b0:377:c556:68b7 with SMTP id 38308e7fff4ca-37a7b282782mr7624071fa.17.1762630954001;
        Sat, 08 Nov 2025 11:42:34 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:32 -0800 (PST)
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
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v4 5/9] riscv: csr: define vtype registers elements
Date: Sat,  8 Nov 2025 22:41:44 +0300
Message-ID: <20251108194207.1257866-6-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108194207.1257866-1-geomatsi@gmail.com>
References: <20251108194207.1257866-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define masks and shifts for vtype csr according to the RVV spec 1.0.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/include/asm/csr.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 4a37a98398ad..4f55dcf86627 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -444,6 +444,17 @@
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
 /* Scalar Crypto Extension - Entropy */
 #define CSR_SEED		0x015
 #define SEED_OPST_MASK		_AC(0xC0000000, UL)
-- 
2.51.0


