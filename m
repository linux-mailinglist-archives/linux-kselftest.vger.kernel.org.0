Return-Path: <linux-kselftest+bounces-9930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A508C1AAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7671F21629
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B112A171;
	Fri, 10 May 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkjTU/oM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FE8594E
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299801; cv=none; b=pSPV/W3Sa8vF09FAB9vqWziRQqOhygn5MojEJX35UHFHy5rdmvpRFpO8dwjIVHo2T/ZAxURcJA6U7VWpCM9Le0tX6c5p2cV3cewsvFGh7UN7u5sGOT2st0Iy4pcJV5cmTH4qO7C3UlJ1zHoP2lXkc0kVJnAd6nsQumWm/dCbmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299801; c=relaxed/simple;
	bh=NS+QgDPuHwkS/IkUVppos2L/t0CSidNHyGZCykoSTr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fUf0f3epVNGSk/vsqrd1QQwxp6Mt0IWmnsfNI5OXF6ouEN8joaXJjQJjGMN2n0gVYju7DoBHtzoN0j+kpo79OWSeE5BtNSziTffAt/wke30AdIagH2dXi89picOe2ZSt5eGSW//qMU2SzR7ZG4/b1TLQXxZjhrCfTUpIfb9eBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkjTU/oM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f468ae6a5eso1389936b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299799; x=1715904599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6h0yxxJBIGq2jf0OFxRdvAuf0GSm4XtFP+RSMXkmCzo=;
        b=kkjTU/oMzTIc7mJ8xr4qth/mZU3+aOp9onC0D34qbao1Uh3kVh8iMTcDMUIiiGsRWb
         6l8CIxNdRLuKWWEPtkoDKGdoDubagPUAJ45iW5XrKPC4qmgzgzNb29R5tbOSGq8wmj79
         IO7XqGDFwIlJruuGoIQI7Um+Ndpx8Se6L0XjqRNy4BaXFg+pZniFTFXP1U+5XguH3aPn
         HFDpRi2lsjCjHF4v0X08t8cHG87Ej1gYM5ZUufkURLm1qwDexHU51XthXqb65ZKXFBHY
         OgK9Ex9AfuQVNx9382fwCKeaXVrXPBv34DDX6ejtVBO2klzmJTIyGB3VH9rlr931LEmN
         9hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299799; x=1715904599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6h0yxxJBIGq2jf0OFxRdvAuf0GSm4XtFP+RSMXkmCzo=;
        b=Bwirrqrja2yGDzBwwr1ZlsLL/mwcCI1XHWaEX/6NRlbGzx1teAeG5B4KKNHeBzcmnd
         hBZ18Mzp2ezUwAjcHIU9QlWBhquuj19YB8fAbYkvPHsyZzU4AyKEFn+in+emaZePJMWY
         RZOfk+rgLC58F+lhOdcn5X6TnGQG3yDi66fnMQs7phyc55aB3lTg83V9y/fz4TnWk9qn
         vpnz0VWPFZ/A7ItV25HpZQxgeUeS3CWP/EDubJlY1wlkcZMyHcltqE2uidoq+PsFoWOt
         kvn7JjJED9XqB82r9fG0ZYGpxG0vaNKlVpX4Dq9gK7GztaXEa80+kiRLhIde1pu1BBBn
         MXUA==
X-Forwarded-Encrypted: i=1; AJvYcCVQD5ELkez2FYg5ex28znPGw68L9YperhtrYY8NPY9//CsQ5hxOVQg66LBU6vM2fvvUGwklelRrfbSsswSEbyJLuQUckxmM7Aq1Ry8x7EhT
X-Gm-Message-State: AOJu0YwGWPQYyWl7dV2OuZ9yiQcTf5jpZ0BJeaPIbr1KRiQt7Ty+GKRn
	rkb0fTDPs1Uotcg9nVNGZ5BSL9WZQDOKRHnyHTeV4cPfrBgn6qENjhKasQpCU9MDLsj7IwX4GNq
	IFA==
X-Google-Smtp-Source: AGHT+IG39H4pksU0ri/+4ci/+CMifWOpp212NwWMPxr1jqe+yuMoJVZrhw9Tl2uxP+3cDEXB3PYnzZeCYzw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1d26:b0:6ed:d215:9c30 with SMTP id
 d2e1a72fcca58-6f4e0415f96mr2708b3a.6.1715299798449; Thu, 09 May 2024 17:09:58
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:36 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-20-edliaw@google.com>
Subject: [PATCH v4 19/66] selftests/futex: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
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
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 7f3ca5c78df1..8e41f9fe784c 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -16,9 +16,6 @@
  *      2009-Nov-6: futex test adaptation by Darren Hart <dvhart@linux.intel.com>
  *
  *****************************************************************************/
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <limits.h>
 #include <pthread.h>
-- 
2.45.0.118.g7fe29c98d7-goog


