Return-Path: <linux-kselftest+bounces-9874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6722E8C16E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CFC1C220C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2492143868;
	Thu,  9 May 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/1OkajL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D114374A
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285000; cv=none; b=eXJixnBlHhwy+HryDGvfit1HLJHQcRXW6a3V5z+cmkBcEEmELrnjYAmyRH7Bjq/0Cf97RvpJcJNGBdYtEDmcx3H9kUICDIptngxaa8hKsesEEDLMTGZ5JWu9sPbZDWZHvP5ntDbpqRSaBJNCaytYBfbUQAZMHLiLMDj8b2KoWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285000; c=relaxed/simple;
	bh=1k9pJ4Bc1nKNaedfe0Z+6a7iznCVlqHkWeOluNZawro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYUeJab22Gsunkbkhw145VUBupVVplGF7nMDPMsP+sKs3Lz5pf7Pb9EKyIvcEzXjwUHwOkYjIeN1Jcd6U3BlARI/A8PBgRqVBlKMj9Z6a2clpvsXnF1E82HX1OqDcIcUyQ+XXa64hj7BOe2u7dE7K7Gc8GYWvcle8L1oJuvfDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/1OkajL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f449ea6804so1290739b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284999; x=1715889799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HIud3j7hw+SCl0gZCLxmuOdO359mwG6ZPGgmENMsjY=;
        b=L/1OkajLZpRcATHRdh/Ju7zCrJSdP32/LXyjZTZchsekpWkEOn8eCAR1ncrpuRj+Lx
         MmlfP/x2NUAjBokOhLqkkVSBhm7xFAit4irlhZBH84L80tZAT+yojCImDe2VCrtquVsJ
         vkj1CN8KmmHbqkSUCeLtzOCP3VPM9uayn//Bo09YVZ8q5JIbjpPoS6e2NeC1Is4GBEN2
         87XnIjQkbzZMGABVDtBJmIRO0leRsxJpIcGVFWeMxFYGfjnXHx1YJ3qAeX9gHw5xd9lF
         zLAyk29DsBfuiLbY1pvGdBygGSVsSPHODwBoORCb8qcRWva+JfErzslJnETTwtz5/YFy
         A6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284999; x=1715889799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HIud3j7hw+SCl0gZCLxmuOdO359mwG6ZPGgmENMsjY=;
        b=UeOlPasD4Qe4lJIIcPdrRdPCD7b9UtCPfh1tdVWR5cuUM3acT9IuW1L9/ELGvrrlQf
         pRmrsNE6Zb0f1ishAD9nura5K34Z5rmapMMGbF1Spad+XTJd6xRJKHPirdqFEUQA1OXS
         nrpqYFei8+25JRDImQNc93UiVm59GhHZn0yZL5DCAuzVuj10JdhgXaX621rPS4kW2CHF
         3bXIUWBWq4slGiXpxAstlfUfcmHj0I8suOcUSrBqUhMYtR4Hg7hSDoKIzaIxwkFeH5xb
         Zs2uoEvsGEq1ID0ZvniIXBrx6DVt+SIUX2uTwQvccpbNMsY3mx77dkZJxO4BmILCkIsT
         MpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX96b5T6ajhvXebGVi0tXbsrh6jdu3kreWRfDOE4Ms5D/fgjBfPPwJDtN+eJu4ACKYe2U4PdRUH+HEqzspGUBl2MR7ivwSO3csCHiBpvs/X
X-Gm-Message-State: AOJu0YwYSBCVE3IhOaBH8HGuFNT0pl1ljj0ivHYXZssvFO64FRaiI6AH
	zpOqCtEMkvKNnT4M4VbidQbQeYQNgGcwjUc42cOPveNw90PG4dKBHj+EgnZJJhzySI2O8C6pbyW
	Lfw==
X-Google-Smtp-Source: AGHT+IENgmr10+nzjNcMdhdNDTzER9b53y/mst1FjhAtj1Qm1Boi+WgJ7sFW+pHzHKduriFjFIhfQXMw+Ho=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:a91:b0:6ed:ce48:f194 with SMTP id
 d2e1a72fcca58-6f4e0296348mr32533b3a.2.1715284998656; Thu, 09 May 2024
 13:03:18 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:43 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-52-edliaw@google.com>
Subject: [PATCH v3 51/68] selftests/riscv: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c        | 1 -
 tools/testing/selftests/riscv/hwprobe/which-cpus.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index a40541bb7c7d..4de6f63fc537 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -5,7 +5,6 @@
  * Run with 'taskset -c <cpu-list> cbo' to only execute hwprobe on a
  * subset of cpus, as well as only executing the tests on those cpus.
  */
-#define _GNU_SOURCE
 #include <stdbool.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/tools/testing/selftests/riscv/hwprobe/which-cpus.c b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
index 82c121412dfc..c3f080861c06 100644
--- a/tools/testing/selftests/riscv/hwprobe/which-cpus.c
+++ b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
@@ -5,7 +5,6 @@
  * Test the RISCV_HWPROBE_WHICH_CPUS flag of hwprobe. Also provides a command
  * line interface to get the cpu list for arbitrary hwprobe pairs.
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


