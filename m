Return-Path: <linux-kselftest+bounces-9164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413328B8336
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 01:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709931C20DB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 23:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C75D1C8FB2;
	Tue, 30 Apr 2024 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODSADp1e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE21C8FA0
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521085; cv=none; b=isDdYjsugg2AyS7CWiSP8AgaJzsRoYWZCBGUox+z4/UgOnz+/o4zjH2cm+96QZuFNy74JmJsheS6IrhPH0JUHk/rH4ShwWkNMAwk8gcB+dxTNyYViMeWlZHS6NItyfa2Qw4G2U/YIW/gfLRxP+tc6MGNX7laz47Ru5nBRuKejo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521085; c=relaxed/simple;
	bh=sTlQvY8lGvZPuHB/3EseuBYDvbUHarzxjj1L20e4VZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DciUGJ665gDO/3pjujq6vGZ8SNEh5d0YSehR7fQvCsfmedLL1Z50iRL+LMQWEecwR4swwej39QbpUhHTXMIwHJ45gPe2Kp4m8Msys9WgWjJ9BqE0XFE+DF2bLQCqVZRN9eqUIAT+JgAehjGSiDVuLBye9GvvC1HR58giaBzCDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODSADp1e; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e612376so9846924276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 16:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714521083; x=1715125883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTlQvY8lGvZPuHB/3EseuBYDvbUHarzxjj1L20e4VZQ=;
        b=ODSADp1eQFRbLl7nhYE49t5GM9KuSLfgYomKkoF9iWuHEzWau6DhGOjqNHOUpQZGM2
         NWtqQgb54VX1JOivCc/iUQhtdarwuM/7QtIihGsvxBhlf/4hrMAmcL9gsw2R8BFol3cy
         2h/lsq6jdaQL3XSHKvpbWXNB5vYpnRqXR61wDBDDRBZfEpDEIrXkVxXDFcA5z0aJnANY
         4CmmN+eo1ilWwWzJKNdUsoC+D6ORCV3/dMVilJOc3QJCpfze0Rd6n7X8tjbBsfug9x64
         OPDdDKB/6P8jGdO1kglkHg+mnRDnpJ9bSHdFxznGnqosvzFr34w4OQGU3MxPW18oyqQd
         LzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521083; x=1715125883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTlQvY8lGvZPuHB/3EseuBYDvbUHarzxjj1L20e4VZQ=;
        b=C1pq7Hs7BExmrxTcVCyHoMcALFLD2hKn1/1xtl4dyrVf613Bd/kepFOTx3OPRPqzlP
         s/ulUI9dNN0BUJ+MA0fs2GtRU2ZqPzgREw2C8uQM4hx3m4fZaXEuOy7YL3tjapCFm82t
         4bycuF3ORsipaaIKl1CMAgdgjsU3ikSevT5nu4L6snHsb3QwXA84zm0erqWS73X9647F
         TimMr+sRPzLCC1o2lWiHxMnW6xcmtPfz2syocjxjH0ICbWAEwFva+ICuEHHylwT6kAJG
         QiUhPJTa7XtKfDO3l64jtmIsQxMgAqS6zt3ql0P7HfEBhEcYzvC1MBw/mRzSswjypoSm
         3ngQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQC/mbKnchQ52JjeD4isjDkiacyExIXZGevRb43I8GGK6U3YXF/ZZ0uKXxIn/j6ECftcHTptQxYxiRbhGKaAA3XMESjC/2NqzGk5UjuvDG
X-Gm-Message-State: AOJu0YxW6OCz8g4T89ZTmbG9hIPs1LwWBnuKe0/im2+1rKKYPNeQuJdP
	1vptI5VnBr5vy7k7Hpl1bg2SwU/UXPrUKtexoVgcRZZ8sCUrp0yy9sqAi+mdSr/d60Mlk8/BhZp
	ghg==
X-Google-Smtp-Source: AGHT+IHawjnD3ivyqCv4ps9nkMuRCo5h/TV1o9YMssrnDwBNMjv0tpGZfKkbqtk/WfPC4jw/0Gs09BBrmvI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:2b8c:b0:dd9:1b94:edb5 with SMTP id
 fj12-20020a0569022b8c00b00dd91b94edb5mr161630ybb.10.1714521083148; Tue, 30
 Apr 2024 16:51:23 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:50:11 +0000
In-Reply-To: <20240430235057.1351993-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430235057.1351993-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430235057.1351993-3-edliaw@google.com>
Subject: [PATCH v1 02/10] selftests/alsa: Compile with -D_GNU_SOURCE
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
 tools/testing/selftests/alsa/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 5af9ba8a4645..3a0fae2bea39 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -6,6 +6,7 @@ LDLIBS += $(shell pkg-config --libs alsa)
 ifeq ($(LDLIBS),)
 LDLIBS += -lasound
 endif
+CFLAGS += -D_GNU_SOURCE
 CFLAGS += -L$(OUTPUT) -Wl,-rpath=./

 LDLIBS+=-lpthread
--
2.45.0.rc0.197.gbae5840b3b-goog


