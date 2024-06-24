Return-Path: <linux-kselftest+bounces-12589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B7915A9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE972289341
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115F41BB6A9;
	Mon, 24 Jun 2024 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJ9WdcKE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B447A1A38DE
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271800; cv=none; b=VtpMFPjDScLc6Rt86oXvgtZEiqMng/dQqJZH9wpU5ZU4GrediuKWCuI66fuOlbq7hD4otg8IJdXQk8xweLNOYdWd/jGT1Mr/qN4qWVEkaj9Sa3wqOTtN1EKDw8MohoW70JObZNjJxv6BgeBEFUHKGhgw1996f9/eDUU7/tHYsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271800; c=relaxed/simple;
	bh=VPZXh7x1OhxAHC0bXKoLWNX1SyyNKVGyVHKLwXltTVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NVTAla6zM+TnOl/5m6zTlY8ORdC2LV4JKeuwFt182X9SUSGNIXXtPBhX1/uZnTAPWNm4PFOAVUGjbcfANr15NkGzN0bqmtGWKF0TXywk3xFgzUzxtqROldPfqpG/VeTJQcEeV7em8W5abkgdn+XyWANp3FRQHRDD6If3xUPtQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJ9WdcKE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-718c62ad099so3885277a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271798; x=1719876598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/nRYsPHuTaGMizrWA3B3ZZLI9bMolsQdLa0Lqckx8I=;
        b=sJ9WdcKErgLlS9olxT0s1k6S16PJd9szBIdNYdjRaOC/GOT62iayZaBYpluTrPksy+
         NA7ahDqbJ22MIeo4CR51suNWlSzuw5hock10/A1q9+Pjz4gxXDxicvbQChhVY53RbP2m
         F4xD1JRznMZMPMrgxtAfU8/SysuMLXXAepytvf8bPE3O05jzbsfC1hJjRZ+L8lvqJr8v
         R/rru25Eh1TcBDR5CuafHBz8WaidZr2mJSUlzuMfr//aZiKzC4a9QR1lCQ9f2iQsx46b
         H/PukaRsqKMyQngxEp5iYmy+nDwGO3G1TLV8hcuiWxfZCLKZJp0AYF8otga+cNm/wjX+
         3z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271798; x=1719876598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/nRYsPHuTaGMizrWA3B3ZZLI9bMolsQdLa0Lqckx8I=;
        b=sh+X6Ej+6BcQFtSQvUhh89vOO8O8TRw3Pe16RjvHCJgWUpquwpvXPGxu17dmnoUDXQ
         EfRdm+GOnK9KFHZAmXj1CHr2HLXH+qjGZxYcGJw1KCAeuuCmLNTRWptYofvCxGrAPdYi
         M/plWn2dFBmWd3Ku4Q0576lBaTFDBs+VqYI5W2vv0314Q1HgkQhNglZr8x2NmkuHBKEs
         GxG1RZd9p2xPnuCQaoXG2N7xfbtBWceM1/3ctYCGgsMdDSG2txmCwnFzZC0Xa9dO79a7
         5dF0xYLSklUkzu5Bex1f0SvRNBwZRlQYD7wjQLMY6+zgOZjUQyYYsNJv8+d7tLX8S6ir
         17/g==
X-Gm-Message-State: AOJu0YyaYqbayLaGp1Zsamqn/RbZB6RcRQ4gpRV9t1JGhp29JnywMghu
	dAqsgz8CrUGytorwcFe7ikQ029N1V6iNynSgnipgJuFfAKDSl7tEgV5LxJmlTJOjM1F1jpKu3IQ
	IDHkd2ceLe0pDF70HruwziYh5j3lTNx3mpUbfq8iu/W/fbhDf4j60hvP5Cc4zKxLbndz/5WAkxW
	VYhWw/mizQbo5x8GuWUXEPNuZtMIDO5bBssWyzJKSOp6XD
X-Google-Smtp-Source: AGHT+IFZmU35y+9sHVYjgBtLmkHsjpVEfz9mzouhtaAmWQwnWgKPMl1MuSAOaM0VtiMXYbYfw881ubbrmb4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f707:b0:1f7:3170:5c4 with SMTP id
 d9443c01a7336-1fa1592da1fmr6098675ad.10.1719271797169; Mon, 24 Jun 2024
 16:29:57 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:20 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-12-edliaw@google.com>
Subject: [PATCH v6 11/13] selftests/ring-buffer: Drop redundant -D_GNU_SOURCE
 CFLAGS in Makefile
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

-D_GNU_SOURCE= will be provided by lib.mk CFLAGS, so -D_GNU_SOURCE
should be dropped to prevent redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/ring-buffer/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ring-buffer/Makefile b/tools/testing/selftests/ring-buffer/Makefile
index 627c5fa6d1ab..23605782639e 100644
--- a/tools/testing/selftests/ring-buffer/Makefile
+++ b/tools/testing/selftests/ring-buffer/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -Wl,-no-as-needed -Wall
 CFLAGS += $(KHDR_INCLUDES)
-CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS = map_test
 
-- 
2.45.2.741.gdbec12cfda-goog


