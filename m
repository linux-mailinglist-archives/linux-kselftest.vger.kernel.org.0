Return-Path: <linux-kselftest+bounces-4386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A70784F059
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 07:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63E628CBE7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 06:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAF1664AC;
	Fri,  9 Feb 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="KaUBIE9Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F765BCF
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460867; cv=none; b=k/C1b2MHWoP9ZXt6wmtw+l9lMcg/gA3jhRSH3y7zhQZ2fhSKTdeudenvNkh3Hc/DHGh2iGHiicuTfGVtPgslvHCaWRANC3FRKSBHD7iolBflvbe62mg5e/8VNHqoub4jCLgXc1eyd+/uBKHjx9XofVVaC6ZV2yaLQztjb6DteM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460867; c=relaxed/simple;
	bh=6yt58djLr4K/j01BKAd/9T/omJcD7zSGCQ9LoJyod5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6kkIlc9ntt+5jC9y0JGxX8XeUpvlhhwgX8FZcl2CF5KcQpGjTfUzPv0Ptqz67jEZnslOA3LYexo2IqHVtun0uPjyt6NisFqcV2jIUca51hp4q0nv9o7VhOICNPn9tfFavVBHM4SAjljsCm3JPryYMpz8lT6ExiQAZKr1E0TZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=KaUBIE9Z; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3864258438so110914366b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Feb 2024 22:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1707460864; x=1708065664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqv1kMDueOeDBLAFFzoizkbUOaos7eIuqxmLJzXo0DE=;
        b=KaUBIE9ZycXKC6w0BlYJpvU8IW9r9lg3foVfRuwpff1ZVB8lMYQ5/3iPVzmWA7TvCE
         XXGqsFS1qx6kvOJh6POfDh0wQwfRN43FqQaET35DtSfsq9mZYVZmwWDT5vF7fcnM2KG5
         tKRgOHyLemM/xAB7gWca/oDqoo3K8qpyo5f6breWDhsjiBJyYVmolLcq3gwXbT78WqSS
         TqgQwwIhe+O5vfc5xIviAWOVCjfE2TBcmOfTrN8GKWkSJ2YoRV07apANoA/1jdN7Fc23
         NWWdG+HI757tsvniT66AgRV81sfAiQi/blA2vx+6DX5fG5hQmYDdAcOeot/irCrVRAu2
         NfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707460864; x=1708065664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqv1kMDueOeDBLAFFzoizkbUOaos7eIuqxmLJzXo0DE=;
        b=X19RewJLFdYmcCUO8pnvQcsK96LMK4lfmD0CK9acmzFyXxtMoahMOWfsc+GF3IgPdC
         7juZW4D+MJWv3B7gX/2ILHTN3Pyqoq9xO+XChmN6/zlM0XZ68OK8FiBwBGKdS0g87oyl
         c5dM6mTe5Tm3qI94po3fztvGyPY4EicjkwgYVSOESJ++32jPxsShAMMEkUC2SxhDCSMJ
         MXZ3pSmFT1I6KV8KM1PuoRYp5x4oGpo/GWM3RtA0UmP6tHaIAkist30tlZ+EFv+cSSjZ
         cjAnGeqBzlQxeJJM9wylTFY01oArrtk+acJu1Tk3GdY2JJBRrx4CHTa75XpdNtLIgtx+
         xsSA==
X-Forwarded-Encrypted: i=1; AJvYcCUwBuNqQH/a6fvyBhZri+RZN98jDEyAw63IE8dgIk3YrFHjulOWojQ0xsEf/Gq9XpCbHwDenBFXCAbNPeA5zJNr6boGMDsElNz8NWVMKaFC
X-Gm-Message-State: AOJu0Yznqim2NX4sXRxpt5Dm88eyTNxvCDlwqhwTTYcqAh3j3tIrkMud
	3y1jJhOpLrk1Oo2hKw8iyqu35730/iYeogS/UHJ8CLTE6tDrlemx+pTkdsu7icw=
X-Google-Smtp-Source: AGHT+IEqYoT9P4yGxxV/Ao8vom6ObPUGe8xNfmYsrj9mQrupH69Vmjj5Fc9hQWs8Ax3BJgQO4kgnZg==
X-Received: by 2002:a17:906:5913:b0:a3b:e92b:2a41 with SMTP id h19-20020a170906591300b00a3be92b2a41mr102530ejq.13.1707460864179;
        Thu, 08 Feb 2024 22:41:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqA02Hms1GnUHhoCeUGdttK/loHEZjbx5QHKXwtPOxxttGYOksuXyK3muEb0xliNnRKF6szoFyOSFwsz9PcaJko6qKNjXTFB2fAnAyUpnMoVD+BQG/lDIsKGVkKuNnMy7wzKsP39NZoAmg06wjeoSHXyfFAN5cEbS/6EnYBTKMlzhMZrDk5pfPc0uIXGdiLw/6BaMIhcMFITP5pb19J+1RzF1urgzUtqlh9B3W/WQuGvzEkbSKup3S6Ti9kxG8XeGvyWsAft1kmMY1VJ6TJbTHHR1wRt2CPbV9ydGIIqh/nQ9xc08W/kJCzxUtTilHW2TunSFgIeJzQ3lp9ayfyWx2182k/ndXiSX8IaP8KBgE8qY5GSVV+bdIJ5yQSQN9sfvgp75UBDTSZI2KE/8h2zApaSfOvP1gqYu/l6w5sOHk5uXmxwNtsDKPg/gvNYpxPQv7s2Gux4RWuG/wgzzPenpKcbPz33H0ukQHd5hP61bQyFOi56bWkPzdKg5iSEHJwmX+hUwCtRf1aFZLCk8jDQBfrf6u7hMgQG4Fzd/mXKTkwTYwYGWEuSXv/GdHqagQcbufcOpMEPv8GUrFRZPXbb+AgJhrcf6yK9tzrRxobSk9dGB+n3QindAud8ArE7rKrG9g6aIUWMuYYYRNaST1o7FvBqxYWk3FP3yx7itHhzpZNOWGtzCqfkGtd8D6UmbZdt4aCSQKBYYs0yt3Y4BwVSmaxyAQ8wD7McQfbqmqIViPqNjTuTbrEnVlJxms4USHpISc/HAc/2iE4gnsIRzEnNdlnrvq5C/hROjT2FFt8cZ7PhawJvwaZWx3U3nXNWMQeSN47hTgcGZa24eiYOELFMolR5ikwa245mlzkn2LoKfrnA==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a370a76d3a0sm441180ejc.123.2024.02.08.22.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:41:03 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Anup Patel <apatel@ventanamicro.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Guo Ren <guoren@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Brendan Sweeney <turtwig@utexas.edu>,
	Andrew Waterman <andrew@sifive.com>,
	Brendan Sweeney <brs@berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Hans Boehm <hboehm@google.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [RFC PATCH v2 5/6] RISC-V: Expose Ssdtso via hwprobe API
Date: Fri,  9 Feb 2024 07:40:49 +0100
Message-ID: <20240209064050.2746540-6-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
References: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds Ssdtso to the list of extensions which
are announced to user-space using te hwprobe API.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 Documentation/arch/riscv/hwprobe.rst  | 3 +++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..d881d56eba37 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -188,6 +188,9 @@ The following keys are defined:
        manual starting from commit 95cf1f9 ("Add changes requested by Ved
        during signoff")
 
+  * :c:macro:`RISCV_HWPROBE_EXT_SSDTSO`: The Ssdtso extension is supported, as
+       in version v1.0-draft3 of the corresponding extension.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9f2a8e3ff204..ee6e830abe4d 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -59,6 +59,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
 #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
 #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
+#define		RISCV_HWPROBE_EXT_SSDTSO	(1ULL << 36)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index a7c56b41efd2..9024061e9193 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -132,6 +132,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZFHMIN);
 			EXT_KEY(ZFA);
 		}
+
+		EXT_KEY(SSDTSO);
 #undef EXT_KEY
 	}
 
-- 
2.43.0


