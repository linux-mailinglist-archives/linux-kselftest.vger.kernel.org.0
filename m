Return-Path: <linux-kselftest+bounces-13099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A9924D5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 03:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CE61F2248F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 01:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461121DA333;
	Wed,  3 Jul 2024 01:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3CUBSsGX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C411138E
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jul 2024 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971698; cv=none; b=rXhRkUwqQSiMVFALvovg34P255rOyOAjqdldhJDo+DXhvwK5YvaBoU4t+GwZuDoCWqmCte+KtpgSk30TWBTkITo6UNal6LxKXLXLx+msN92BUkfWDd7jEwx18cF18FJ0/SFCVNESZCXzbw5NITr0Tj5PXtHD2Gn1MGQksrN3WKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971698; c=relaxed/simple;
	bh=p1H3bMXP1kaxiJKEHWQp3wxLk1lndgbgCIxUehTD7eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F1ndOO07B/u4fW4KbKrSezWXqQFMES2NZ9UIAWGwp8D46n9UPEBR643I2v93qn+nuH7L5YLLCH7OKd9zt9lOXvJVjTtGn3F0W2WASeWFmznt7NsoS0GfAtbb7cNF+5qcIAbv2d0VIFD59uw8iIxY/C7ddVLPQr2MeiXiuGRQJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3CUBSsGX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-718354c17e4so2997485a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 18:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719971696; x=1720576496; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHnHE2GTnxtpKeQVqGKu23WsWDVRXJprmZQx/8LwZ9Y=;
        b=3CUBSsGXjvkopxredwBGgF3tj7cNZEfJOrbuB1H+WSMx8Pn+2ZbaHW2VF2TjQdIYSx
         tEh+xxQxxKaE7KX3EzBHJtK0vSB8NtNPP0xnc9E7hZpJ0zvC5C0y2xWAoZcl1d/XkCAv
         0axEEgqtelOW6rE27YnBgQzxKJWt1MNmFWlnI8PJZ2wr9Xdpl8yFPwIMGxiWImxEkqLW
         zgMHhlXouA0tG45KDQ6N3rIGIvXcLyMLUjdvFn9RXuazOw5Rg09RGhhDPMzHzLGOEroH
         tExbjEYDEd/O5XFW5U85XBpjRlo1FAicNv/XacGVb1HZWpCtgZV3YUf6WV2ELA+6OIst
         JbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719971696; x=1720576496;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHnHE2GTnxtpKeQVqGKu23WsWDVRXJprmZQx/8LwZ9Y=;
        b=EWY7jo5h92sHrGVbmg/xO9QerbCQ3Uczs8C6RPkwrHRO2JZqmT6GOSalH8/tYuiVCQ
         T8hsq/jOcXjdu5OmPbBhwZF2g0eORzycUKiaxgc251ZWSGChtx5AYnFfhL49sOjknk5S
         8sxkM8xLiTYNqF514V27ODh0sU9SwkwiSaAX04MeJGZJQ2Sp7lWhveNELnusHVgewY2h
         SHyzng3+C22kWd+ZvEV5hs/s65Kk4XOAmI4ISRMTlLoA5wnsGcz1DikoqIVQNgcD+oBT
         MPfCaQziodhicI1nSt1NbARnBRz026eW2dv/Wo21eXzNCj3nm+vaomBsuY3+YfMx1JGO
         NTdw==
X-Forwarded-Encrypted: i=1; AJvYcCV71/ilne0DaJm6A+Jf9h653MqnIzLI2kaImdiZqFmpkyHr3jK3ERXidY2E224jf2Iw/NnXGGPRUagMF7gU5RwVYUqDINYyr6zVdJryJlSR
X-Gm-Message-State: AOJu0YzmmdV1fm8wOzc/CTU3SKkjTR42WYu/YhLqbwaw8EzucJ+qerhB
	NIbkpy9YY8DqZ1S1S882Q1/YXsCvxx0dbyEu9vm2DuBo6/Jkd2y2u/wYdF2AdCE=
X-Google-Smtp-Source: AGHT+IHVaTNrEQj0UhlgCk9T6SwsM+7KULs8BJil9oMO9HLDbJD9EPjpJtrlGWIGB2o/chZZ3qmuiQ==
X-Received: by 2002:a05:6a20:8922:b0:1bd:d7:6942 with SMTP id adf61e73a8af0-1bef627701amr7103130637.60.1719971695758;
        Tue, 02 Jul 2024 18:54:55 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8a70sm90881235ad.118.2024.07.02.18.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 18:54:55 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 02 Jul 2024 18:54:48 -0700
Subject: [PATCH] riscv: selftests: Fix vsetivli args for clang
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-fix_sigreturn_test-v1-1-485f88a80612@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAGevhGYC/x2MQQqAIBAAvxJ7TtAKjb4SIZGb7cVi1yKI/p50H
 JiZBwSZUGCoHmC8SGhPBUxdwbLNKaKiUBga3XTaaaNWur1QZMwnJ59RsupccNq289KjhRIejMX
 6p+P0vh+S2H4YZAAAAA==
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Chiu <andy.chiu@sifive.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-kselftest@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719971694; l=1692;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=p1H3bMXP1kaxiJKEHWQp3wxLk1lndgbgCIxUehTD7eM=;
 b=THxzHTU66KhNxRU98J3d0MKiSdJbtlJEQVuKgH/hJ0MUkrz504ey4G+CHt1Zj7NvRbhmk2SXm
 6JUG+aLMJ25AzycCjlzsfdAzISKI0z2xA994yPLwJ3CwbrrRrvPdDZ2
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Clang does not support implicit LMUL in the vset* instruction sequences.
Introduce an explicit LMUL in the vsetivli instruction.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 9d5328eeb185 ("riscv: selftests: Add signal handling vector tests")
---
There is one more error that occurs when the test cases for riscv are
compiled with llvm:

ld.lld: error: undefined symbol: putchar
>>> referenced by crt.h:69 (./../../../../include/nolibc/crt.h:69)
>>>               /tmp/v_initval_nolibc-5b14c8.o:(dump)
>>> referenced by crt.h:67 (./../../../../include/nolibc/crt.h:67)
>>>               /tmp/v_initval_nolibc-5b14c8.o:(dump)

This is fixed in my rework of the vector tests in a different series [1]

Link: https://patchwork.kernel.org/project/linux-riscv/patch/20240619-xtheadvector-v3-12-bff39eb9668e@rivosinc.com/ [1]
---
 tools/testing/selftests/riscv/sigreturn/sigreturn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/sigreturn/sigreturn.c b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
index 62397d5934f1..ed351a1cb917 100644
--- a/tools/testing/selftests/riscv/sigreturn/sigreturn.c
+++ b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
@@ -51,7 +51,7 @@ static int vector_sigreturn(int data, void (*handler)(int, siginfo_t *, void *))
 
 	asm(".option push				\n\
 		.option		arch, +v		\n\
-		vsetivli	x0, 1, e32, ta, ma	\n\
+		vsetivli	x0, 1, e32, m1, ta, ma	\n\
 		vmv.s.x		v0, %1			\n\
 		# Generate SIGSEGV			\n\
 		lw		a0, 0(x0)		\n\

---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240701-fix_sigreturn_test-47d7063ac8e6
-- 
- Charlie


