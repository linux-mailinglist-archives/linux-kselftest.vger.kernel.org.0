Return-Path: <linux-kselftest+bounces-39539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E7B30142
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 19:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E3917D5CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816EE33A016;
	Thu, 21 Aug 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ7tWN1o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC5338F4D
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798013; cv=none; b=GGbQeBP7xtf0GFuthmXhaRggAsXVl+jiJXDmlt2GD8zzLvzcC9qxG+m74g1PNmtpkMPtxC2RJrmi7Un1Ojsdnog/wwGVUT+tm+dQDFtO+IsG/KQ3qDHHng9fQxWyiRJuZfTMzM7XU31k7Bw2kUxQNRZoUoWo4XhdBFsyd1bkSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798013; c=relaxed/simple;
	bh=yx/sLa3afuwxwcA0I/a7b52/bwZD6SWDxsmTqiq69/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmbeFuvnx/fJRWMTTaZ36Zg0j07Ym6QHt4oQDN1qARZSnsbt5WNDEcUIw2cJyFteot6ZL22qVXwHq8Fx2VcYwjhYxlZzTjNN1AsF3nPLxxQMhwlEs6ntWD2014FsB6knu6kXDgBv5lICZ9jKUc8D8YPsTNgYSWicVDUNanoJe34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ7tWN1o; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so2015185a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755798010; x=1756402810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fy0q5agTDRyofy0fsNfLOTICm7ccThcSJln5HnL5Dwg=;
        b=SJ7tWN1oCYhtZ6TPlphCEDYwxQFTwj/rg6LKj66BSremE4bkvJT+eamlm7vz1yckBf
         z8JbbzncOwtoxYgINY1MSVmuelokJYm1s4xv951nQhr5w/nmrqqD5ykBLqPdGLLg8BF1
         X2iOdJYOAUizs82MsBXnmn65lfvu4hMkRu6hlKZKR5TOH6dD4u1Kl8k6eRW3B8l48IzP
         x5lKMwAxXIrkbl609wWA8hzeh3GyizItg/t3ItAAE+P2yrkNt+d6OubioAqhxsN5TZeR
         trcuK5Ydo13Zez4YcL21qF5jXu5F4k15GbPPFJ+N625RybQpw5JFoe2E8enVyi04HOVA
         cz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755798010; x=1756402810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy0q5agTDRyofy0fsNfLOTICm7ccThcSJln5HnL5Dwg=;
        b=OviFvQIE/ejtUZp0Jffma5sHXVk9g2ZdWw09PJ5Z8e8+hiAApIZP74RnR0AM7qqz5O
         pj3UJiqC9ldRcd/pxh/jmdjWK7OH+dust1qFxOb4vnObaC2Dc/X76roXBUPhLedhbeBi
         Y+u3ebsEZKDe7gEJkcA78fFkPdluPpFBDd3SjOx8MlwaSxVVfA+XrEEURYtEgMUEAUC3
         WQyPRzlfnAveSsAKuAak2rx2/mL34PL4Pjy4NaZE74wck0XCrsknFd0YPqVJIROf2J0A
         Cw1gLWb55gupB+22BxOFoLMP68EzwtRd26x2+9PGOGZK7b4xIF8gERauNB+3JWeTR2nc
         ThNg==
X-Forwarded-Encrypted: i=1; AJvYcCW/BP6QurAR1vLPd7FcqvL34jIwSJrMakYTGYzgszxg+yUHrNKqvKx4daZaT3F6B2q4KBUBou8kRytdiyPzIvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2G2v3hhs/fcRFq5HE4GRqydsz7zJLSr9+JE9hsJbwsbM2dDZZ
	l20Y23sFH/+snj18CV7MRFAwHA4QwGQSXl/Ldza6AyAOXrOmLCBIJ7x+
X-Gm-Gg: ASbGncv6SFq6J8KTEN/zdeC+iWgOOxvSpCfZXMiqjJgym0c+glFki1waVvPMmoCSMvE
	EnNFNd1bSmE14kw/IxcktVIfAWkjzSIdxf80vU4LhDTUErpkYS3cKw8wf6YLBOsyELA9+0cRquF
	KzlM2wxEn9/8GTc/QrEKwtJF0+UpvOdZ0605KRIqZGUh4P9JuKIg5Hw3rJBQmBh7pr5U+mjx9GB
	a/3viSQR86VBRqznWjtLngSmVpUHT/BFXnQjj3FjQ3jG3ivJaYAE81AP7DJqpHvGbfNmK7ihCip
	G+S2d8baIkAU3ZmV0TuvrT7CT4yJZgTn616SVv8H93D7I0ihb/PL+ChTCaAAVYUNjPysJwt+Q7p
	CQAR0sHJ6GixaHktUtM7Vh7hmUA==
X-Google-Smtp-Source: AGHT+IGAy5EZ5DUHnsPFAMnn2L3yiI7i2y2A21NKrB3daSt0oG0Pph2v2JH9rNdO79XTM9hPqHfqtw==
X-Received: by 2002:a17:907:3f97:b0:af9:613b:3055 with SMTP id a640c23a62f3a-afe28f836eamr884866b.2.1755798009985;
        Thu, 21 Aug 2025 10:40:09 -0700 (PDT)
Received: from curiosity ([80.211.22.60])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afded4c9c12sm422705266b.82.2025.08.21.10.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:40:09 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Shuah Khan <shuah@kernel.org>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 2/2] riscv: vector: init vlenb in vector context allocation
Date: Thu, 21 Aug 2025 20:39:50 +0300
Message-ID: <20250821173957.563472-2-geomatsi@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821173957.563472-1-geomatsi@gmail.com>
References: <20250821173957.563472-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, vlenb in vstate is set to zero on vector context allocation
and remains zero until the first context switch. This can expose an
inconsistent vlenb value to user-space in early vector debug scenarios,
e.g. when ptrace attaches to a tracee after the first vector instruction
but before the first context switch. Fix this by setting the correct
vlenb value during vector context allocation. Simple reproducer has been
added to selftests:
- tools/testing/selftests/riscv/vector/v_ptrace.c

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/kernel/vector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 184f780c932d..6ba68568735b 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -120,6 +120,8 @@ static int riscv_v_thread_zalloc(struct kmem_cache *cache,
 
 	ctx->datap = datap;
 	memset(ctx, 0, offsetof(struct __riscv_v_ext_state, datap));
+	ctx->vlenb = riscv_v_vsize / 32;
+
 	return 0;
 }
 
-- 
2.50.1


