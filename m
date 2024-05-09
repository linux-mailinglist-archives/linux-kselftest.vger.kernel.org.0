Return-Path: <linux-kselftest+bounces-9848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7F18C165D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879D2285EBF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C163713A24D;
	Thu,  9 May 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN8esj6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6291386C8
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284920; cv=none; b=gzyj8d6MnF+p6ew96gRsq2yrj/o6BT/QItyLd24EO7ExgP+2wKPkViKzKvU7uwoK/4P5oXi/8xol2tv5XaO1FQuzMXK1J0f/bCo159ZX0Ym1GvZS/k+JJBf0wa0/Xp9N15owiXg2jDQ2etnsgtSw3ntUOH3spVxoKgkdOrFGOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284920; c=relaxed/simple;
	bh=pT+XZwZoOeLRlGPh8pZw/75/DuYvyGsmPHR7OeRuxIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XSTlpHaJcWJYjixu39xseyGT1FvHieMNlfAlfSIPAQ+GgvtWuFEZxtOXGVlsvnyEMK0EDaEInqm07g98lLwhW/7Kmx410GYEMavLq3ymVWtq7dsYn41l6XOvFQKokSUHHz0dzVQp31Im1SsI5yaxU82OEKoAhPdrQWNzB8Bi1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN8esj6P; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de610854b8bso2133788276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284917; x=1715889717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M28n04MiCB7Rki3XUCV56t9NRfCH7Yl0gF/ySSCW1F0=;
        b=SN8esj6PlFLoH9EqdS6xZcr5jJ7OJxmljsN2sEnwZPD4Ri8gxIkGxlumG8n5yBxv71
         KMB/58Wbpqrk4Q0E7z4DToiQCx3Ysdk6inUuB0ayfHUQl1vQVdCk5PhiE7L4fDshm1xo
         VQYr7hM274WrfMkut9AOOFCrJ8BZu+d027DJYZAj/SMuCyGMm7Amx262l57j11NFJm/R
         UCzRAs1gZ3ALQ76uCivG1PnNIZSTzFMDoXRAf2h9fAKsAboPZwOoUFchnivgxqP3pigd
         H2ttxDtXP/O1itgDEIzfgjKUli7Y+PJfPGx+D8yME22RP6gMs/KOpf9CGeXbxkS8xh83
         lFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284917; x=1715889717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M28n04MiCB7Rki3XUCV56t9NRfCH7Yl0gF/ySSCW1F0=;
        b=O4NO4UycTOGmfqj1EX2bapAhL8vcOMLqxqXtNgXEqhEWJk9Inh72fL8sK8JKAVU3oI
         qp1Mq6+jSU2/A3G00LTjrgd3KgsMsouYmJZsRGc7muXp4KbvhVhm3Gldtx6uD/WIUBQu
         VDTVh94thhaT0ohyqbIW6MwBn1UOoF+kTkn3yJCD0juIGyjSrFUtMKGxAv7ocnXcHtZW
         KeDAsc37QOKkyT7ulxODfp5+Ko9EQGdjA8/ZXk2W5V3Km6F13y9Wv+faEnlQ07JVIs3E
         sq0Tkw80FQlAlMaJ5hEUEo48Fz+SZMMG6jIBtyWdFLlUQq3D6SZEhfjxtoa8af7UocKF
         NZHg==
X-Forwarded-Encrypted: i=1; AJvYcCUzrmH/3c4MbZDGpS1MN+Ni1ssV9Mo8GF3pzQmxgqloL2ZuIZIJXKjlkVEyPlC68A1/9HpZqer+vUPiI95pudpuUnaS0mujSij3V6vXgnNK
X-Gm-Message-State: AOJu0Yz92H8Xl2XCpplcC09fypEYlzeTIHRhtS5NN2nSgWbyF7SCV+3O
	KXEF9Z62Pk2tm4u+Nx665OhtoaoWr5/6bG5sqSLaaHz3zF2O4Y3h49SdqjzbWN6KzIJefgRM0Em
	+QQ==
X-Google-Smtp-Source: AGHT+IHWuDbcMQme6+YKWpzBKBlieTWCJg0j/ENyLXdW3EFA6jYO7wvSVmCsFiuxu9QxPYdg7/f2jHZsKVs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:20ca:b0:dd9:2d94:cd8a with SMTP id
 3f1490d57ef6-dee4f4f51bamr60630276.9.1715284917151; Thu, 09 May 2024 13:01:57
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:17 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-26-edliaw@google.com>
Subject: [PATCH v3 25/68] selftests/ipc: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/ipc/msgque.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index c75ea4094870..45aba6aa8e1d 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


