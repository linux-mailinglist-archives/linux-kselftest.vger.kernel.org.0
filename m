Return-Path: <linux-kselftest+bounces-39745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE69FB3244F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E42B6790E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8434DCCC;
	Fri, 22 Aug 2025 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcTtXh3N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AE335BAB
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897991; cv=none; b=M6pPdPxMf18w6ESPFa6Rstmlr7suYfhAA449Y3FpslHrN+PkWnatyy4d/5nc2pA78RQMpYAx3BRD2Iq7rdN0QAmriRFZmdm+VEkRtqRG7aSLCmXK1f0uBds2RAraVW/Jbwegts7pBtWwmcLXVed2xLxwAk1BR6KW2pNaJmWjjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897991; c=relaxed/simple;
	bh=uMyJfe5cHwoUtUwoSSJJxuZnY3O51Hz2lKNXSSEJX5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ny7FGbRoZLqnxpEJxhyvq2BQ3hEsAz9oHKK/eqWFe0nH+ZvLlCAAn7I1pPg1EjrZWSBIPmynAOWvWXPxjbb+Zllp4C59tA6pGPRjuB2jxXnS0UXpZ+tMAjFzJQUXRNyznD0IJR8P5QVc9DcrBr3lFCyaVHWvzA1wB6IMKTx2evc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcTtXh3N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32505dbe21cso1536175a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897989; x=1756502789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5UhKJ6F12rtNHCKzpg6zduHrTeo/I78By+R2Nt+rNA=;
        b=QcTtXh3Ncn6hGQHQ7Fa7qUKp7CDSiou6IIEG4jOnT9R+wfiaifrBnmEy3IjbI84lzu
         4Obvc2zaZEpUh5PTjp6ewIbyrgGdzvzplgVQeUSSE7ahmdSntJEE0xUpHuR67hHhE6fe
         m5ldT3YEcVcNLxGrASXvZU8j/HgHrMMYopCk/ba3Jlsq+wzGOGRvJ+gr0NOZPzuvhpie
         p6SIJzWCkXZNQxiMpm7b5g7CTu/ptFkEl1j8cdrjKO8leLFZzhZZt/6U4Xn4m7py2u8v
         d8KJEw7/843E1qq4bHc2lyMTz40CTOQc7jyx52uF+DDClNX6v9VwuT2fixiG0IvYF8aW
         yoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897989; x=1756502789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5UhKJ6F12rtNHCKzpg6zduHrTeo/I78By+R2Nt+rNA=;
        b=LYFCwLIwMzZ/oxzpP167vArR2SrA/rMhcLxZhqYvCo/HYxRFzs8H1/bABsPZ9F9rQb
         PfZsn/jvzBhhuXHheNOpJicU0L3oXDXCPXXQWFQHJnLhzfsBDbMA+9sDCDg/wTu61W/P
         le4O18HYFvzgnT79S3JRdQAtli1crshYVriFH3X43zy8zpjYdJ4I2QUCxVfR7PvMfhB9
         7dm8YNWQuvnTmKdOPBxbNU5km9WUpqjwPBPNR1u5g3HYdlwz3ZUuJy7sVJeHs7NhjyS+
         eOlRP14JmcnjVrEiusS6o3c5nmS86NOI95WIYmy8n5F4fw1u4nkUTVG+Y6VVwahhuHri
         XsWg==
X-Forwarded-Encrypted: i=1; AJvYcCVL3lnT84xQZtG6A2rpwpPIoXLLQmgp1+/x2av9FqQe+a90GersA3C9J3PRSfEjyrla/+uUki1i33dLPpXLL8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD2hTmdfxln2FOlhEsUitIv/cvS2XdEsj3nUjjBvAJrt3EJBiP
	EwCEkn8am37CQhDUSfLqSQ1V/lOKEnBO7zikCpY2FHLdow+JvH2BSWQCmYzFt2iBLcFTthC1why
	REr2sGZGCIn6Mrw==
X-Google-Smtp-Source: AGHT+IEafPkrBr4+mLCngelo8B55kina4L8UtVUPhzbE3nVdn6lVhhBL+/FAVN50zPoEXWhXMkUNyPITU41DQg==
X-Received: from pjvf11.prod.google.com ([2002:a17:90a:da8b:b0:31f:4e21:7021])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e707:b0:31f:150:e045 with SMTP id 98e67ed59e1d1-32515ed147emr5857491a91.32.1755897989270;
 Fri, 22 Aug 2025 14:26:29 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:01 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-15-dmatlack@google.com>
Subject: [PATCH v2 14/30] tools headers: Add stub definition for __iomem
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Add an empty definition for __iomem so that kernel headers that use
__iomem can be imported into tools/include/ with less modifications.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/include/linux/compiler.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 33411ca0cc90..f40bd2b04c29 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -138,6 +138,10 @@
 # define __force
 #endif
 
+#ifndef __iomem
+# define __iomem
+#endif
+
 #ifndef __weak
 # define __weak			__attribute__((weak))
 #endif
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


