Return-Path: <linux-kselftest+bounces-17131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E294C96BF0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C028A03A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA21D58B9;
	Wed,  4 Sep 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5f+WV5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C6D1EEE4
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457852; cv=none; b=hr5YJxGvaXpEBbqnWej9fFOmlxZKKED/Pm81IQdjN4Kg3E/qlkNquR4Dwh1yAPEVgNLI0bvP+YWDZNy/8CFT+nqIKLVdrRgRrEgANTLk+jBtQQpFngRMDkgxlQB7JtlC4l1UzPRv/Ly8nSfIT12NRk2dtQBl8a1gdQxPE87UpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457852; c=relaxed/simple;
	bh=uWrtz3g6TxgzckFRZ4YDiY+UV6EL+/VQKjQ9NqC5RB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j8qJ6yGiEoSgMpDCCcOgcb616+Z9kXjRkII7NgW590Ja6pO5VuTYuRGyCPTbEn9pbY1TrUpj/JHcKjrKLAexvqXI89FmyqA/P/aG+87F0rShF1bp2CL0mpBb+/KqIi6NumAqMOAnItIPZNs0S+/HoRVAMP2XXJ9cEex2OuHEn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5f+WV5r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725457849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YEl6UcNWySWixJDtk3OBM+nYtD0bKQYmS/w9a5H5Rf8=;
	b=B5f+WV5r1GFAvAdwoqcsUl1fY8RyCoANumOCwHybsIAJ6fH/kJRvvOIWAlnpHzt2i8mPwK
	jBG+ZD3YqzD8ARx4vRIirNzhDTthMuqByZrhpvKlLA8BDZREV7CsRVdK7NoiHnOgOIycSi
	NOFbuEEbXaXa1FN8w5HpIwF0f489YCk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-e_9B40lyMieiF8Az2Ti6rw-1; Wed,
 04 Sep 2024 09:50:45 -0400
X-MC-Unique: e_9B40lyMieiF8Az2Ti6rw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E44A1953945;
	Wed,  4 Sep 2024 13:50:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.194.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A77E300019A;
	Wed,  4 Sep 2024 13:50:37 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] um: kunit: resolve missing prototypes warning
Date: Wed,  4 Sep 2024 15:50:19 +0200
Message-ID: <20240904135019.200756-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

While building for KUnit with default settings, the build is generating
the following compilation warnings.

```
$ make ARCH=um O=.kunit --jobs=16
../lib/iomap.c:156:5: warning: no previous prototype for
‘ioread64_lo_hi’ [-Wmissing-prototypes]
  156 | u64 ioread64_lo_hi(const void __iomem *addr)
      |     ^~~~~~~~~~~~~~
[...]
```

The warning happens because the prototypes are defined in
`asm-generic/iomap.h` only when `readq` and `writeq` are defined.
For UM, those function get some default definitions but are currently
defined _after_ the prototypes for `ioread64*`/`iowrite64*` functions.
Moving the inclusion of `asm-generic/iomap.h` fixes it.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/asm-generic/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..0b02c8e38f20 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -13,10 +13,6 @@
 #include <linux/types.h>
 #include <linux/instruction_pointer.h>
 
-#ifdef CONFIG_GENERIC_IOMAP
-#include <asm-generic/iomap.h>
-#endif
-
 #include <asm/mmiowb.h>
 #include <asm-generic/pci_iomap.h>
 
@@ -295,6 +291,10 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 #endif
 #endif /* CONFIG_64BIT */
 
+#ifdef CONFIG_GENERIC_IOMAP
+#include <asm-generic/iomap.h>
+#endif
+
 /*
  * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
  * are not guaranteed to provide ordering against spinlocks or memory

base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
-- 
2.46.0


