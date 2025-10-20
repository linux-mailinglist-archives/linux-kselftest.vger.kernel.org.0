Return-Path: <linux-kselftest+bounces-43521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFCFBEF3CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC51D4EA95A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 04:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA92BFC70;
	Mon, 20 Oct 2025 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fy+PcwA7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9482BE7D6
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934081; cv=none; b=uabYwHwnwyDAxFXvoU0GNDOa4Wrb7ng8UAfA46iYbfP0vubTbLbOFdcz2w2rd6wVEhFEnJh80UK7zB6yotk263WkMa3r5iZzGkQcza3FmNaWK8wlZFgc1wS+XFbGTl2rdGUCvuBQ9guGIMH5ILNTNWxpAkjPF9qdddQZXB6N6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934081; c=relaxed/simple;
	bh=AHBUSWC6NQwt5gipootBG6lu9YU2EyCEcBy5+RZx010=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzVejydOH0xgn71I88EvinkOgi01qt/Y5TKRP5gM8h0zekOxlNvN1NoXHtIbNaQwm9oOy58PkH4aCzx0c7BSqslWRVaSqmvD5Mmao3iTjsT5tlVYj8FPjSOHN3iK4Gpv5U0ajcx1l1IScZ9Ynr90bG4ZPX9Ctvk6rwHKswkfxGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fy+PcwA7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-782e93932ffso3290374b3a.3
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 21:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934079; x=1761538879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4l4TBk/LGXRpjovIOSrhrLfanQNTxjIirl6+Uo+sE8=;
        b=Fy+PcwA7DJKVPgOFHkiOwNGCplaBhivkMWy6/hJY3vkJxrEQDOe5fH4wdDZxQuxdxM
         ODhGgX0SoHcvmHlc2xHQt6Ti199e3tpoU9wbX/omO0rb5AD4ULCVDe1yIrySnt9U5JuI
         EhUASxzV0eiUJxqKzxDLCL43n0DYeH68u/kr+PXngWRcm4yuNyVX+3WdsAZQ9QKCJPv7
         z/T2U4ZV0LspgeS6txCi543sRWb6EONfCRvdw8z4brMix3bYh/LSfJBe34RnvGkSLyJz
         OSOoUb07JHJQI+E4FWmc+xDzS6DfCpvwoYayVwcD9wF8WL09hKsrRM2SxQ6qjjDrHo/f
         7oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934079; x=1761538879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4l4TBk/LGXRpjovIOSrhrLfanQNTxjIirl6+Uo+sE8=;
        b=tUiwpz+uFOwoamqqkw6uJnAhhz/2Zw4QEpXmst7TGoq1KDRgn1PcJuH4S3WnKaUOqy
         URnYmriC/n4Sd64sdVwvdVDiJ2l1VXP+siKrrKa7FmaXJBiKvoVsCZTLKpxaagDITTJp
         CiLFlVosQ5O8JHvMOqbmkGCDy6LAd9O+Fka23ShAo+z62YqF5MZsZYnvddZgK7wVZXB9
         MMZMqMoQRFQvv+XhfhB7bZe2nvI3GvthGgsmOOALcOhtgkQDWbDaN4DvLoEQH3bH6CUg
         Ba4/Cd95c4sk1lJsl5wY1gQNT9Ryp3y3o1Q8BsQ+kx+jzKsm6b6HNCS7qZsLc/mc0yYI
         F4DA==
X-Forwarded-Encrypted: i=1; AJvYcCVjHoeOe+OvaMmiII5DjEIQoViD3Ya1e+xGXE5wChMhA8ZUyBsA4VGmHxkSyXHL/fxJgOFyhp2Bc4QY8GDJW0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkM51hDZZx2jZO7PiC2nbKBZfaW+2X1+ii9AA9z5zSrQJNWjI
	qRTSik7XIrgZUZkMMuD+f1VRBR2Jniqt8S1CNFhqzUv3BLrBuKd6HongEAyOcjJ4BxY=
X-Gm-Gg: ASbGnctNhodoH2b3R5Kxy/Ll4ha2I+UJp/qmbe35u8N0iB+hu7QtGwpbS/9qDLQVe0Z
	QoNNl3n4losCw1DU/gYSgJehxU9QzCYeErREeQOonidX09TBpkNNSLWv+O+Ot9BvmVxp0njz1tn
	HdCS2wHMWu/Yx33mQTLe/yYnrE5xgWeuFBgW6+uj7Soz2HxB4jKXaVo3Yja1YK4kuvP7ryLV9YB
	PN2inaSP1EXuLLhg5m5q2sfNtxeQQKlj1sVcmZlwtHER0xIiJQMJLD4BhDmCx5A9yxHbhfN0zpc
	zuQF4RmtwO4riBvzNQE4Jm80m2cracRLufp1rXpe/x5dV0eUy1+f7pUevOI2+kFNw7UYMnE0RtQ
	rVozKmkylm+g6gbDLidJfO1/aZKgVu+luqKuh3ZRLEWONBdk4IwPBOtkZueNLHi7t5w3+0ofgyd
	IJMJuwmkVmpokwM/W9HF1mjXWgZaS+1cnha+hhlPCSFmCyymKe8bT6yPOB55q1so9HcpY7iF2Uw
	l3raHoKS5lH
X-Google-Smtp-Source: AGHT+IGSr6CeYbnbhFqLb/PEPw/yfGu/4coKFj18cuRK0sGNHLwIgZvYXiVeS+ZT8M8+GdgG4XcYZw==
X-Received: by 2002:a17:903:120b:b0:290:cd5f:a876 with SMTP id d9443c01a7336-290cd5fa92emr146909545ad.13.1760934078867;
        Sun, 19 Oct 2025 21:21:18 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec14e9sm68762035ad.9.2025.10.19.21.21.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:21:18 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	guoren@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4 01/10] riscv: Add ISA extension parsing for Zalasr
Date: Mon, 20 Oct 2025 12:20:47 +0800
Message-ID: <20251020042056.30283-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020042056.30283-1-luxu.kernel@bytedance.com>
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parsing for Zalasr ISA extension.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a3..ae3852c4f2ca2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,7 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_ZALASR		100
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572e..bf9d3d92bf372 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -472,6 +472,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zaamo, RISCV_ISA_EXT_ZAAMO),
 	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
+	__RISCV_ISA_EXT_DATA(zalasr, RISCV_ISA_EXT_ZALASR),
 	__RISCV_ISA_EXT_DATA(zalrsc, RISCV_ISA_EXT_ZALRSC),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
-- 
2.20.1


