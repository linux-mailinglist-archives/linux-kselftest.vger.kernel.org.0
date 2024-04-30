Return-Path: <linux-kselftest+bounces-9170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 411748B8362
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 01:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9173AB202F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 23:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599D2101AE;
	Tue, 30 Apr 2024 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWHplws+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19AC210188
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521117; cv=none; b=V/IwqRsPw01XNhVXJdrkrAPwlaCMFiRPKEaizSyeirsGTtdgbQhQ0wMgLwKOp9pIbb69njCZJ/fmSl+iE+csd/Gptiqf9UY40NxJsd2HjftlrMXTP8YBesmWCGSaoZSHx+wgRR1/t/LfMAgieBYwcLS76Besky4gfiFjFawALDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521117; c=relaxed/simple;
	bh=q4hPe+xh62Uhmba9PSnhrp62is8QeTzw3cIQCnwAJEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LWXjp+qzNYUficZ2v6rIJwK/BE6x8wUFP2Fmnlgf5lvyvTm6ibXsp6VlN+nxdnMNIo4FoSR0fcraJxIeJeRBXE+BXovrk4vc4dFCqE9Y3uIPmeUyM9D4BKgOHjq0Im802hHBoi0BuyYO6EJT4b/ayvQ7R3HAxel0ana0Kv/CHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWHplws+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f3f28d6492so3974497b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714521114; x=1715125914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4hPe+xh62Uhmba9PSnhrp62is8QeTzw3cIQCnwAJEs=;
        b=fWHplws+HuPMbth/LpVBuYyCKV3VezSbPCuMynJ43py3TiLLFXs0XF6Zy7+UAKBkcL
         L6xvJNDKll/sKysPKHifQgWCRNbdG2S9fAFMBoQ1RiM8q7kEGKLo9/g9VfwA4up+ccU+
         JPI1GPoNCpiP/Q/NNHke0c/iScOO1zickkY5GCKqyuioIv48OVzJICbW3OPGqolkl9CL
         GPvycfDVQMuGRh3q3I3/O8leXrGeMdvQSwX4ovya18su1I8vgWwUfXcZivIXRuV7jXlP
         GQKv+NkS/BPF/K6sfmc4mFoF3TkE3N5k48KyKFCzUpLDTrmxRIbBuTcwBA62o49TM2oF
         lVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521114; x=1715125914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4hPe+xh62Uhmba9PSnhrp62is8QeTzw3cIQCnwAJEs=;
        b=Kr6E353W0rr66IhEIh7t66bT3bBQTu/UShdmB2u5D2xShJR5NMwoeSGLCoTBjuu9Jp
         7ZjXBhQtDhzdM1O2P1LKc/woq0WHbKzJiKG2CFXmNy1+Z9B3gInZp/Q5VGWPRGpoeaOs
         9h9w/EpT0uflVvpAwHxeEuh1lkafToOXNXZt5g7sS01a0oqcyANXCBMA9FrvJIIsLZyD
         KkogNE9/khrbncR29Z+Mh50kLTTo3hynDXhQLy4MrZ857b8FdRmKsDvxXJYadOwlKLcO
         XBkWSqmRwaRIlYMAD0AW1UfF93NMn3ANflEgJtS0EBXCbl+QH+tek1/odv62c3dp8Na3
         yKNw==
X-Forwarded-Encrypted: i=1; AJvYcCWoQ3PdyBFZ/q/wV5rUEO9J2xzHYNv0Nbb3N9qwPoRzOQiS9Dk13EJ6NsxHC3ghC5nuEVjZ5wxGK2E00ZNrciJIXvwoLejLoz8U0WMJIlg9
X-Gm-Message-State: AOJu0YxSoPTJ+ezQl7dU8IjdYVFyV3EJnqb2BcLUF+rAdvc9sB/wJFiY
	6EKlkO0rF+kgS85B3ARMF72N1Rc6tK/N/NmEYRKG2vxmVcb6IsVm+ayYmj+CsPm3nRxSC+YukOn
	e3w==
X-Google-Smtp-Source: AGHT+IHPv5XeMbDkvtBTnEts/QdkOCkwWDd40+iQpyVBsIIp17OfrlSk+SNOnAl1YwhsfOoviBzkyHBxHOU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:13a3:b0:6f3:854c:de57 with SMTP id
 t35-20020a056a0013a300b006f3854cde57mr83407pfg.3.1714521114135; Tue, 30 Apr
 2024 16:51:54 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:50:17 +0000
In-Reply-To: <20240430235057.1351993-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430235057.1351993-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430235057.1351993-9-edliaw@google.com>
Subject: [PATCH v1 08/10] selftests/rtc: Compile with -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/rtc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index 55198ecc04db..4ef7ee969003 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -O3 -Wl,-no-as-needed -Wall
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -D_GNU_SOURCE
 LDLIBS += -lrt -lpthread -lm

 TEST_GEN_PROGS = rtctest
--
2.45.0.rc0.197.gbae5840b3b-goog


