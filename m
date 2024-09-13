Return-Path: <linux-kselftest+bounces-17896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627B97755E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 01:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5CB1F28E65
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 23:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA31D2F66;
	Thu, 12 Sep 2024 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oKRRuBrM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B81D222F
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183133; cv=none; b=pH1soF2vVEmOhk9bPb0+VMhzhUSKvZ0YDWj5pAkcLTvl9PwcV3VzwrL1RQAEG+t/di98r2ZazCPX0SWO0Q6fRF2KnSIRqtFTuFxMDlLFdlFUI/CvC3kJ7kIdwpkJUYLG1jwRn0K7acVEvS+EPuFkZIRggExuJI/Xj0NUyWMN2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183133; c=relaxed/simple;
	bh=zgRdj0YONQPKz9uVqb30W8yMUxU4lMlcah0QlKExAyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVeNTRd4EIrJt4OqN27MS0cBUn9bfjkvVQ9it+Qg/pkR4zzxpBLYS1y7XVG79YS2XcfX5MXffRdGdpPvD8JafDJmuuMi7ODnoFI4LV640gBDxF5ogj+5U9BN6TrU6nr7NdPMI7r3x09ukdHPwjSeySxhwifB2hOzi2dmFznDt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oKRRuBrM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2da4ea973bdso1267883a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 16:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183131; x=1726787931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRpTmBOo4f9wGNdjTiRRTPN5pl3eVu/w/Wzy47xL6pg=;
        b=oKRRuBrMat28EmzYtecyOaPyFwSCnHWnpMa5lNZkKjsDwCl9SAEcxlF1x+6ZD1w5LD
         4tFhq/Hx3wlGBaXzE/teUoPkf+MqrX4+QlQwnvfdAI3avJgZI8jHY6wS7KJp7FkkXYu5
         Axyo/s3rv64FqG4vWYvqUsFL+RgPAbopoeC5gpdoDS+UHD0FoBjHnv04D3xLqWsVBTd3
         zWIG0ApDnrZe8KaeNULCjaTLYci/AvLVYFaZrBBY5s0g9/RyT+61s6kIq+8dqqmatWrt
         bnAGfYE4RCxcRplMVnQdUYFhjtWcmdyK2sj7vQQV7pFi8BfdP1Spqa06LZR0Ea2XAWYX
         ThYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183131; x=1726787931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRpTmBOo4f9wGNdjTiRRTPN5pl3eVu/w/Wzy47xL6pg=;
        b=B3wAePs5yh534H6CisM0tNoBMQeFVFtcRfauI0U8LxdvZaGJfP+qJLDIBHaYyynK4t
         5vECaYF18XF05dYZ4EnN96T0PCjru+QzJU21b1pDFjm0KRruzzymtnCn70ej96x+XYlo
         105+McLgoGkat4aBMUqoX8UMVz5Kq0zcu9c//J+nqIZmNpQDjSGan0gwoPt4cPvr/rl6
         h3w+23ln881t9BcAnL0b5Cx2CmU8BEOA+o6Xf0JjIL05Jf/jnoLb0OzcEWXJ8R64i/kw
         /PSV7MRUand3IMtkPbzSs2rf/1dKH337MnPQ3SJh8ArWASzx1nIcUcaP2TXSEgoIUv5l
         Ggdw==
X-Forwarded-Encrypted: i=1; AJvYcCWZohD0m1hSLY0/3oWXEBj4N2dP4noeX72Zb7elyO49XmF5q+E8nAK39CC22Thjd5lrQ+tMOVHjdLKN2Bb8+pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIbfA6El9qZ7FAM2E5iZf4+VLlsSUbMQxzlPNLRbZdmy6juyT
	VVayfoDfVSyvu5x+in2sm45weXAL2DY3uqGPe955Mk03ShA6rZlIOsd4FMaYK+Y=
X-Google-Smtp-Source: AGHT+IGSBIHvNtnBIsR7GeLeQfebNSrrsHlC0GHK9qkrAjtXKK+cIqA47d5wbXfoZYS+dksrkXz4mA==
X-Received: by 2002:a17:90a:1641:b0:2d3:bc5e:8452 with SMTP id 98e67ed59e1d1-2dba00681b2mr5466829a91.32.1726183131166;
        Thu, 12 Sep 2024 16:18:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:18:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 24/30] riscv/kernel: update __show_regs to print shadow stack register
Date: Thu, 12 Sep 2024 16:16:43 -0700
Message-ID: <20240912231650.3740732-25-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index f3c5b8f2c869..1a5d70977e5a 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -87,8 +87,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);
-- 
2.45.0


