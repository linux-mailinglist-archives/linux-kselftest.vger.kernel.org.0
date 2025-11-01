Return-Path: <linux-kselftest+bounces-44574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4EC280EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 15:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3621E4E963C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7122FC874;
	Sat,  1 Nov 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YwXgG61n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8327D2FC009
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Nov 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007030; cv=none; b=OTWwfLZkpUVS1PFYYqip+f84MBUW2xAPqn5nQIWUTUxyKWDe3S73PdgkPvtpJ8iYNQy5dmSKDJ86eFz02l+Hx7Ks8QfmHzdYPKrFkoGgvwFPrex/f1H8jyp+u7CTk8LSBb3z1FbvR5vvel2/WLeOY77Prt5H3siVrtUkvPZaD1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007030; c=relaxed/simple;
	bh=KY8qnH0TrVjhNGmZIwNjdy8NbnBQP/+RCC+BIUEXvo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSnNl1b3cUZLqobbJcWcE4lPUbUtg1oY7yL0fKOUaUP9YMMqT1Ui9XETml0IMPHHVTIFb413YJnnN98rYlNiVDOzS/AoU351JweoLtzUW8FaX1XqRtMs4lapSFVQBDQok1v3mDcWLhiB5OmAKAppinuAh4pNXQ6YqOh1SVE9+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YwXgG61n; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54bbe260539so181261e0c.0
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Nov 2025 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007027; x=1762611827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSrsMv9vHZViaOOimguQYKUYT4fHRN671HybCTbnJQs=;
        b=YwXgG61nEjNDMKgQUO/WwJafAZP9oLDVnssvz5kckyJakhbeoqAw4e1oXInPAoykhh
         MMzm7Ox0VnhP59uv9V/pf8SYzXRicZ6lq1TSosc92JoCSzePSMvDjN8RBHABXyu/MuTJ
         g1Le0wvH2q8gFJkHDDplQ/eUassc1F0XVGjekJKM9/V0n7DNLXg3iKWRZYEahMnJOku+
         MPycTsueCojkEfApi/zfEQXvggAl+/mkCZ0yrUpVc410G5ClHs6XX7PBjm9ISuktgBI4
         5gARohsJGqi5qm2OQMYhnZERkNxBh2Z88SkDmS5u9okDRZxGXZQthbaIpoh6DpJygvyc
         F5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007027; x=1762611827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSrsMv9vHZViaOOimguQYKUYT4fHRN671HybCTbnJQs=;
        b=Y4THOtRc3RsdWE0axedtaVrPQ64cRI1dRPBakErYJkCq8+1AMjMsmkAQf+GIn03lLZ
         EykGDwpsYuzqKag5eOG9azfq9rdefB6fnvsHaawKkF1tfNuCu6/ebS0biIxVfyRJkg0y
         hccaquxuEBmNOBmvvUr8SUfFi9Z+p/8HGkq/yXXT033zAfKn419trCpxOJMFT5rypfeB
         Fa3bJGnO+PUmv+nqL6OtItXz5v1CJHuZktpscWdFvTFlPZeFVj2/b93Iz9kGI0pGsW3P
         pxSsveCc2SKbrCyumM5phyFzDu1LQhcTmdj0J6vxuCeF0ktxP+adeYupX73lkM1xi/Yk
         u+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXxmc4Hrn3rCTlXd5ozrNzoyN7wXDiUbvysM8By15U1vQYrKx6si+0obvF1pYA9N1bwvW27PdwaL7/StU8kev0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/PUEej+Ar3L1Cxsg6EroP+mfw4PsCJiwcsWN3ouo2qmsWlxr
	xPd5bcrvc7F6owp2V7/Ot5ab3J/02SSgl464lM3d/uHaYFa1/dYDAbW51sT4hY1Q+De6qk2hFJr
	4FB9v
X-Gm-Gg: ASbGncsEoHabvXAKKx0FvJBAuNcmuFYjJK1o1/ZSmkrP2SsnaHTI9C39ddX5gSL903v
	OAm3BQ4/dIKlfJBSdSECDbHdlR+XwtjveNkVZrUoLu7fKJI9aVlHd/nQ9jsjIVXzgrinN2aLK5p
	73ME7q/4HSj/x1Un2HUaeFfPYLRKRUmcTi2WHzpngp+c73FNqpoZSUL1me3LoTtAU/saZismrPw
	Ywmw3DND5EdRPo8k5vY3feaBeoNBpLmIcwShyWNNSDgbih6SvTSBunsabugi5W8w1dA0zbzTGoN
	FQgQdJqXeRWez8zIq5Kg9LksjzOVHL6iUsqoJuhm4wfF+8NWmt7RpNa3ncOGuOIRK1YCnZLXj4c
	+P7sjN6UO/IKB7MfIbAQhBoh+pPOjIqAx5o8nOY73dxPB4fth01gFhCPEvTkc8lyG9+tCBH+mhc
	3HkeQUiqjPTbzWPY47T9SbHJhrTGTKQzT/Eb1Giz7QHNJiknWBXn4ZZX/XG5MC
X-Google-Smtp-Source: AGHT+IEQrc/UahYLt7ANSOW5+mMj6ZVaZ8HuruQYEbIlio2ExuETGUVUCqnEvcl9P/bAjVq8vDxMwQ==
X-Received: by 2002:a05:6123:2e9:b0:552:2c5a:c057 with SMTP id 71dfb90a1353d-5593e548e2amr2464325e0c.13.1762007027406;
        Sat, 01 Nov 2025 07:23:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:46 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 8/9] MAINTAINERS: update KHO maintainers
Date: Sat,  1 Nov 2025 10:23:24 -0400
Message-ID: <20251101142325.1326536-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changyuan does not have cycles to commit to the upstream work of KHO.
Remove from KHO maintainers.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 764df916fae7..6200de2027fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13788,7 +13788,7 @@ F:	kernel/kexec*
 KEXEC HANDOVER (KHO)
 M:	Alexander Graf <graf@amazon.com>
 M:	Mike Rapoport <rppt@kernel.org>
-M:	Changyuan Lyu <changyuanl@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained
-- 
2.51.1.930.gacf6e81ea2-goog


