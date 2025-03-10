Return-Path: <linux-kselftest+bounces-28642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBE0A59987
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC3A7A70BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D5222F177;
	Mon, 10 Mar 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Nvg/ZGFq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098822F166
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619670; cv=none; b=uhBP4OVqajTP8D9FAvrfh6T+cXHusTvn24H0aKIJwHnJtZC6znYlXJjxQu2qHf+XDH9xTbcGdjbAGRYUw/HDDa/C7Kdd+0wb105q7/6OpDzzLrRjslENFuMpkcRdw0MutcS5PZSaqrVg6wYFlt3IqtXoKZHHGURjnwhiUGuGlNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619670; c=relaxed/simple;
	bh=4ctq2Y9j6Ai2zXepSDGwSaGD5sKanUbwQl6UjhiXbqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgJbkZdKHGnBtFG/DeNWb5WlrUsO7lM8sBUY0MXFTzWiP1XAxVdBz9SYASkEqcEpaLBCp8oMpR4/A+XggiWOerNQfw3X02ipo5s1lI6/yMhM1ZoNmbA8idhTFGFF/HhIY9lRAfhqDDSu9mEagmMeMCe0oPdmGSTqvh9il+s+C+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Nvg/ZGFq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22438c356c8so47844035ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619668; x=1742224468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZ6ZtCFLM2HDQCXfIF+4ZGwXAoERFl4mcxOr8+ok9D4=;
        b=Nvg/ZGFqrNZtscVsbTYfAORJvCoMPMZJNwv92/JsMTCYz+mOxmmnQzUHnWJyUE/D08
         WvTXFpKackj8JbpaDjjdHXcXBAPEw0Krm81RTLUSvpESA7PURwp/oOqooMrcj7g2nJNO
         I5Yo+ATYJUBXbDeKfsxB+jdXwADm60moLf2ySHWDU3mIWK7tj3lznTKEvV5yAlXa2CPn
         fI7rZswSfoFmBmDwsIc/rt8ei3COabFx0FwCoVD6V3Y78Y7XyL1KJNsg00lG26NsL3Bq
         uzKJgZl5TzJMDD3cut2mPIcFLW9HBPsdffI6M/vm/m85BW5NlxwKJ3cyQSQTLr4tHtKD
         0U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619668; x=1742224468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZ6ZtCFLM2HDQCXfIF+4ZGwXAoERFl4mcxOr8+ok9D4=;
        b=qO4+FILgdXj0Cix1yKwLObA9oqldz0FoPDOq4DTiiJDoQXhRw83lr+fDEOIxqChCfn
         PL1XjKB2++rB2Mq6jE4VDneOoiEraVuf90PX0T9MomGYDWvuVXh6ILvZnwXX53hHzX26
         SHv83LftAYbfSMgXTiUxyw/I3TNE6RoI8f5xw8ZfRYqJfKWgkKA3J0o6ctAeV27WOcLc
         U8EyqqgMcGaS+EmAvqGbbkKXeeu/YBh58IRpx3uOc4Xy49zxRrUGrxU9tvCpQjbRMe97
         dAFBSwKWZjQWQ2EL11Rg2ggDNzhYTW8BUB7br4sLz5dTE7T5dseSuFpKIl09hRJdLe5k
         m+aA==
X-Forwarded-Encrypted: i=1; AJvYcCVDA+JZlYk7ycsxW51hZUd6oC+GVwcPI2RYs3/FLaOG+UnPBalrOCMNKFndFigRsOysFn9Hgya8WTlYE0RVdbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbiCFrJQLp1TKzLzHOoTZKB/xnwLQFJVYoxuY4+FcRBniIBZTt
	TLiHl9To3d7paqHJtEI43PTkyYsNAyvoz6jV2n89eExN8IAJiEPuY68FxdKA4Ig=
X-Gm-Gg: ASbGnctdOFSsSf3s7k9YP7Qov3PBikEL2EUE4BilyVfyCceQzoAAptLia+p/w7HwQdz
	+vWj/AkkCAepRgdYEtrzQE045S7DKM8erJge9PR1vgGRzLxqp2+dho9H6O3YPI5skCf0T7tVEgR
	v76cJuWocTmhljiamCdLJXN+SNGnrfZ/m//wF2i54zi5aE6AFPZ6zbgcd2PguhEHnqfjK4CYZjq
	tMwNWcRdhVU/KMQ+XAu4A8TV7vyINVeyMTAxfkeTOkivxkXDu7/sFLQ11u+eEScn5MnBm+ns+Vy
	XFrLqV32Ks4LgQ0N2+WhjYxYu/S25+spgdWY7twS9vcgPw==
X-Google-Smtp-Source: AGHT+IFtA7ejSY4XIE1Y8FAoh6UcQJS/Qm4jl+kbYc+4FdTVNJHdwGd9aRrsWNeD8S620FnvoI8t0w==
X-Received: by 2002:a17:902:eb81:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-22428bd592amr282068535ad.40.1741619667997;
        Mon, 10 Mar 2025 08:14:27 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:14:27 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 12/17] Documentation/sysctl: add riscv to unaligned-trap supported archs
Date: Mon, 10 Mar 2025 16:12:19 +0100
Message-ID: <20250310151229.2365992-13-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

riscv supports the "unaligned-trap" sysctl variable, add it to the list
of supported architectures.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index a43b78b4b646..ce3f0dd3666e 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1584,8 +1584,8 @@ unaligned-trap
 
 On architectures where unaligned accesses cause traps, and where this
 feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW``; currently,
-``arc``, ``parisc`` and ``loongarch``), controls whether unaligned traps
-are caught and emulated (instead of failing).
+``arc``, ``parisc``, ``loongarch`` and ``riscv``), controls whether unaligned
+traps are caught and emulated (instead of failing).
 
 = ========================================================
 0 Do not emulate unaligned accesses.
-- 
2.47.2


