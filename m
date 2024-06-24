Return-Path: <linux-kselftest+bounces-12580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F0915A6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2941C20F49
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0E61A38F0;
	Mon, 24 Jun 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upDGTY+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB81A2C20
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271749; cv=none; b=ritHDO4on0fEge5ANiju1J86LxH1I1iIV4yLwCpnG1fpRSIl0TTOT+HJo/imcUiut0sJkcUBkQ+fDXC2vT8Q6xQPUHgSXaA8UsKKvKP/Whb9nEJ6qza8kkjbU7ctk5v+W3Uu03cl+qjKUlcBm3KJa1V1Pf8IfAHpmPfDj7NIGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271749; c=relaxed/simple;
	bh=xwftBfRu5G8w7ol9IF7MUG9BSiGvoLKlVTWAOAeO/Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d/MoAaznA9Zwfg6KKsnziv3PUS8ABVk9ihM6zwnVAOLtJIx8kpYnqLZ8UQsxgTtFAzhI2rfC6TSxLAtOeLplAonUFIu7WhWzjjiaNs65B47cPuynK728aItGnupfeZXJJ2pdi28LZnhbZfy31Dl+wvQGr+pygEAH90IAaylsMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upDGTY+V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f6174d0421so52226285ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271747; x=1719876547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7F8R5HE+eZyxlB2ebQLwW1FMzverfSOUo2IuXKNmLY=;
        b=upDGTY+VAWxjOiGt1aN8qq/MXQcXxCGhECKCR+u/ehZUHokbQYBzXGPPb67Ib14AYJ
         WS+Icm1jnUp19BMdXpFSNeL98mC+XEUCbkDJQQdWPHozIzclQDGsE2NnJ/l/XJ+h7O1m
         BssvmwEpWtykYwfNxyQEQFmdtvyoEdRIcIsrBkQADycUJB0CmlZmdQklWhhB6zAEHG/I
         qmHXlzQINVs+7F8iOa8zPeFNnGQXynyT4+QVgszv5DndlHQ29J5RjVYvVlGrSXxJBBls
         8ZRfhzFO9fvFPh6hFHx772LXsRysy4ieIYujQB+oSWpQi4Cn3AKoENJq6O/tqt0a8G82
         yRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271747; x=1719876547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7F8R5HE+eZyxlB2ebQLwW1FMzverfSOUo2IuXKNmLY=;
        b=oCvb9VbsIwnTvaKDp8rdY5UENrxKGZ3eXxWHWpaFAKxtls06WSVfarjDQupizgOfLp
         dwe/2V79aavb5WzY1CgyUzqvjONSx+P4gP65y/bFJAqxC62DQ8qim5agovT4DQgIX/x2
         Em84S5IntJydTxGbjRbJmRpTtCxR+UAtsYwMEHxhPcpiMQluriIrK810ZYbh9JA9ImVG
         t2zIbgtwzmjiuPnTSuUnUXTzjjBaN/YnNn8hsfpm7DkA/jUzVlf5GiAFtkplR4e22LQf
         H7MY0nweMhZhbMKvNRa2LvJC9aw2TPcqULzh7obQP2nABSlBboOXU+DGdBXqfEbbCJ1R
         99aQ==
X-Gm-Message-State: AOJu0YzysjfuXkWzQy8Nk0++nwc2GbP4nhUBdN5ICrNqnk8v4D2nmEWn
	uPIp67g9zGDsDx4Aj5lMv4FHy9MKIhdPEZqvJhDmfYM1/+R9O7BxvJhZJYcjNGGvbWSn02hnt6X
	SEOkH42Cd1xi/N8Hua8+RkS41koMlceu44Eg6Hda7Mc8EtgxX88QIamMwFV/mUsPCxfxgClI1bx
	SM4edL5TNxIIwWJxMzMiY+DOUBBfdUfWVF5sU7gImIy/EJ
X-Google-Smtp-Source: AGHT+IFY6zwuM+fBRs+r7yFjUxfbkM+X5No4nRI5eUjSYyy4xzwRR2NKqiye6S+BJr7Hl1+KVMRcw6AW1Us=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f693:b0:1f7:3763:5ff0 with SMTP id
 d9443c01a7336-1fa158d034emr7382275ad.1.1719271746792; Mon, 24 Jun 2024
 16:29:06 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:11 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-3-edliaw@google.com>
Subject: [PATCH v6 02/13] selftests: Add -D_GNU_SOURCE= to CFLAGS in lib.mk
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
	linux-sgx@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Centralizes the _GNU_SOURCE definition to CFLAGS in lib.mk.

This uses the form "-D_GNU_SOURCE=", which is equivalent to
"#define _GNU_SOURCE".

Otherwise using "-D_GNU_SOURCE" is equivalent to "-D_GNU_SOURCE=1" and
"#define _GNU_SOURCE 1", which is less commonly seen in source code and
would require many changes in selftests to avoid redefinition warnings.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/lib.mk | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7b299ed5ff45..d6edcfcb5be8 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -196,6 +196,9 @@ endef
 clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
+# Build with _GNU_SOURCE by default
+CFLAGS += -D_GNU_SOURCE=
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.45.2.741.gdbec12cfda-goog


