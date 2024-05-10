Return-Path: <linux-kselftest+bounces-9974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D98C1B8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA68B283D41
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9A0141981;
	Fri, 10 May 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZyOpCWS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4F1411D0
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299925; cv=none; b=TnvWezEKdmU7n6wgks8CLj/ZYmFE6qNyPmKZCFcgGYB8jA0sB/VPJJURKW8G3XytSgUYFlZ1m0R2UpuX7XELHj8L84HONV5ResYdQvNfdcvIhl7U68NqpHytxxK8VG+b6UmWQVDdRupfRhZyas8fYqReY/Cg94ZyJbErlx2BR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299925; c=relaxed/simple;
	bh=3eJI5zSrDuIzjnrtml0eoF0GxHt+dGhxWnDnqgmi7+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKaDy1OWFTw4HbTVSrngJFFR6iWx8H+QdYdYl4P2qICZIE48xyumIKomis+5DFmolPYOyp4F98pHKKt/WXhNQyPBhyuuOlOG2IBHZAXGVnN4LGyO4MBzX0tzDnzxuYd8oLUJOM6LQRtZjW84LbIfeasnV2S3RbquvSrzpaRZ/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZyOpCWS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec3c838579so13799675ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299924; x=1715904724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AuBb56Ya/JVHt3ZPygn0bw49ZbbB/FQ8kpaCbLZgiyk=;
        b=wZyOpCWSM3WHSJbn8sAaw/WuEzI1DaK6M/RaXSSQroIRnVDlLc+s30ZCoxG54pylQ2
         1KI01vnfWorfbKiC5B/Tgv8/wy4mlBZ3TVVX7zR1JRDW1wC/bet3UzTOaATdd0izyZBm
         UWCH+OzypJY1oKVZZDCBO0E8rPw/1t01Bh45bQ4eezMk71syvGhh3hdvPndU7uulAyuL
         oF/cLbhEeHfjMzvL8oh0Ovij/iWJeX34AWTFz0foQG/Et7ml5UwR0pEJctwt/NgNy8MQ
         zs+9hYS7nUaYXERBR+RZDzymxmDi/iAdcArRfxbbOOM0UgmT8P4VlK31nhTbi7sf66Nr
         HwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299924; x=1715904724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuBb56Ya/JVHt3ZPygn0bw49ZbbB/FQ8kpaCbLZgiyk=;
        b=oe57rMa2AaTRQJvB2NWGcO47ZHFpFNhj9bwJE+VOzKKd/+6a/M0c79bb+bCWfvgl/D
         cLpwvvLmDXVyKeeb3Fg4FD60NC9DJ06vRQYDfITc9HNE19dibZXTQ/Ay1bxSMykfhzOF
         uLAYQNtLNM5PyxDaTdZmEp8s2hfzpdCxK6XuKAKPZfkkMzBx0VT7X3TYdhnJaiITcOfz
         Ku6pOTwIkwRRp7ncuNTm57++fjG7izqj+woNIVb8fKP+1OQxjA/EVs4JfcUAdsg/UaTs
         us5G7aMV2a+YeEjIoWWUik01nbJ46HxQXezbpGcUv5yjU8V/V2h1Ewm/V1dQ+rYgGHu+
         4rSA==
X-Forwarded-Encrypted: i=1; AJvYcCV4jHbMpFQbennkgHS8eR1aHmOU/o8P5Y7bRqvrP4TM72y02UB9J6h/zGaC43HflwiOXXKctr2LqG1N4adLYuu4+vEppMhy10lhmktL/22Y
X-Gm-Message-State: AOJu0Yx2Y5zNVa44hiTnIxxWyVdyRMDh5ZXXGDaCYQhc1JqbsEPCYZiZ
	btjyxjOajZQu70SSDvd4tO732myx2WqzUIIZa/UtwJXGDOPHNCwat2/HqeCwayubypCgPJhS6Zc
	egQ==
X-Google-Smtp-Source: AGHT+IGDiT6r5MtSiTKtFOeh1TnvuA8iW3sg04Hs0Mp2HYr3hoUvchEofnYDdFYeElPPK8QwfKXlxZAkHMU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:32d1:b0:1ea:2838:e164 with SMTP id
 d9443c01a7336-1ef43c0cafdmr333715ad.2.1715299923621; Thu, 09 May 2024
 17:12:03 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:20 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-64-edliaw@google.com>
Subject: [PATCH v4 63/66] selftests/user_events: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/user_events/abi_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 7288a05136ba..a1f156dbbd56 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -4,8 +4,6 @@
  *
  * Copyright (c) 2022 Beau Belgrave <beaub@linux.microsoft.com>
  */
-
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


