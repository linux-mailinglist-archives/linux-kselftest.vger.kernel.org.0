Return-Path: <linux-kselftest+bounces-12579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30450915A6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629D91C20B40
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70DC1A38DF;
	Mon, 24 Jun 2024 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JE/efsVo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564BB1A38CF
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271745; cv=none; b=RpDfC7RPS5oUJNpkyoq7IoLBx6MR1+j48XRy9owNWOjhrIoKnYcjIu4aCQSh6NYGlmqIV0QbutYmuQ7znPlZHj4AT1BtTcTyQuvBsEyEaRTYvma1YOP7ETyLqfYoVd8xLCgXXpyrEQqHUP2ielSmPLxEMGPFT6QWImQfV4CaYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271745; c=relaxed/simple;
	bh=NqMqA7QWqr9/+mHOdPi0hG2A/sBfX5GGxqySZ84bEFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s+Kiy8+sMOXz+OioCRaMa1By6DVlqEl3WwgVnXxuakV7RBMM2wj65N2ydW0ahtwJWaA1DFQAghNTbYR7F1z2Ro47TeODWg3rn4MGqy6bCa7gi2rGsrCzAqLaG4JOFPJN7Eb72j6lOpBRKRy0iJOa8fgtSZj7dCaxUMvVFvvO+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JE/efsVo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c7e13b6a62so6217266a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271742; x=1719876542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FvMNQZepmevKVYCWA5Mvt/tIAvZEAV28z8ZXGZ1r5A=;
        b=JE/efsVoUwzmWPRqXGSh2dq6vncO+Kz48+MG0piOgvMYIaBUqwQbe2uS7XNoAI178i
         Pn91bpq6kbhDJf9nKlwrp3KIoIFe2XiO6lUnkSFx1NUfp+P1aFRM7R8q2x6Plykc6WKN
         pAmWJU8VwHKBrRywJUaesx9bzK8ztLue2prq63oiSix04IBH65OHoCCx/46EpjJoLmPZ
         HE/siN4yPW8EWWKdxMUf3zlVOxS7BD0v5wX/WGcC0SR1PJeL9f1RhW4Zj4y9CMfA2iRK
         Mc7ZrXbuSgj0Xc1Cc9eTjLb+YnLe3Kc+EDv+x1iR2ZEoMRZK/I7Iz34YMqzIbjNhLhO8
         RS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271742; x=1719876542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FvMNQZepmevKVYCWA5Mvt/tIAvZEAV28z8ZXGZ1r5A=;
        b=OebCBfPb5ZP3LacQVR4KnryB4O2BBH9rWkL4p0KZ8NZ3YJGknaCCuDm1/M4ZuQgby8
         U2QngMYWNk1m9qng3d5PWdjodDU7APadlJY4WZj9lqSmwfDhCzu99o88CHi7wXFbZCYo
         3wmqjJ3tw37Yqs/oVmYNM4XVY6kNGEVn8R0nuzt44yrcBMaTtl7l9RkKADbzHauXlcOt
         Q5P1NiNgBIqv6Zf3OFqlmkQ/sMdNeRdQ/Kb+QZjBRNnGCGU0ZX2XeSXTvLsa8Vg1h9v7
         es/7bE3nN44HhESst+NllkApnSPRNK3SgvwsgA1J+1XfUng87zY8f83t6GPuaqDqWoUZ
         XDiA==
X-Gm-Message-State: AOJu0Yy3Ids7VP1FshZRtGakbKZomYScEXFarKNAIRMU2vM0OxA2VHKp
	fylajhs+B0HNTSsiBFtIRB/ZGK2N9/B46E7fk7PGUYQ3EU4QZO/k6sFgWjtfElX1b4bXnReU/ia
	Psv/XDD2vnA6T6+0lyEf8u9rSu98nkX5Jw52wYVVAUcQnRIeemZE1uElMM/0oHXugCUIIUuBvT6
	lFgl2M6Ige4iWasP8Unx5VrgY8d6X8EPO+GRhnMqvJLbpa
X-Google-Smtp-Source: AGHT+IEk+3lC5zdyxifyt4ii+6a16n1y8uZeO7DOAPkbXtiVBPE0qfgp7g0LpuESyv8BZuXBXF4M/RvaOF4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:4a7:b0:655:199c:eb1b with SMTP id
 41be03b00d2f7-71b5fe10537mr20071a12.10.1719271741168; Mon, 24 Jun 2024
 16:29:01 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:10 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-2-edliaw@google.com>
Subject: [PATCH v6 01/13] selftests/mm: Define _GNU_SOURCE to an empty string
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use the more common "#define _GNU_SOURCE" instead of defining it to 1.
This will prevent redefinition warnings when -D_GNU_SOURCE= is set.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index d50dc71cac32..e4370b79b62f 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -13,7 +13,7 @@
    sudo ipcs | awk '$1 == "0x00000000" {print $2}' | xargs -n1 sudo ipcrm -m
    (warning this will remove all if someone else uses them) */
 
-#define _GNU_SOURCE 1
+#define _GNU_SOURCE
 #include <sys/mman.h>
 #include <linux/mman.h>
 #include <stdlib.h>
-- 
2.45.2.741.gdbec12cfda-goog


