Return-Path: <linux-kselftest+bounces-41950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37FFB899A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C689B623DBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB82F9982;
	Fri, 19 Sep 2025 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Lv+f3nZN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013330FC3B
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287208; cv=none; b=qs4O4vy37BSVTU+yl71Jfoo4xh0wS9u+KzUoDgDz81JBHZLiNtb8UCe9vovSa1ptswfoAgwxl53kfsLcC0KcWrsAvL+RGeqUDaXW1BhUVAaFwouvqDJEBcBXro0ZJOfCAA9xzNubZjJ4d1G/MoAP29w5veFirfWzrXdYlqszLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287208; c=relaxed/simple;
	bh=zK2ErpD/lYmYPzqN8aF+TKv2E5RRqIF06vvCc4CNo18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ue7XuHXnXx5GnkQyHc94pbb5URcce/m3Jcb2j1tKymMdlok+jCmLlcTiunq/1n5sLJJ5lIvHJVGdgPTtgPlt2Sa7WjsHHf3AYNrQEXb/F97ynhILl3ijA5WAt04hEMxUBpIjU35CH3FQgZr6+WjC6lzIkOBaVDmKZEE2icyPSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Lv+f3nZN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26e68904f0eso524665ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287206; x=1758892006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D2gBtzp3mLNn7VCJeOcGuzlcq9LYd+KGJxoAWDsv6A=;
        b=Lv+f3nZNjMu0FY9ifpGj/EONH9QS5niDii6AjW4LqIyjGw6XFNnujfmWlIidsTNgRM
         fXoLHsFJDS3u4eSZi5n9qk7C7Bd5KBBxr8zxT6Jc7dL6AMJdrFpcP0CRej9CZButAd2/
         fstiYUBwNa2cGbpBHP6yDHa2KawTu9FqqLTb5RE824N1tWZehZH8JA0vnt2wssT/aPbO
         efXt1RLj900BI8usiLmvhAcgsegBOE84lwrFbL0JoWafkD884ew07+6PQcjQ2Ne9KRmU
         4Z9pPwjSL6SzRVznQUxe3uH4Nvb1bfT+db7XuZgnGWe/Re0gd2m0G+mJVC9SwI9wI6kX
         so8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287206; x=1758892006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D2gBtzp3mLNn7VCJeOcGuzlcq9LYd+KGJxoAWDsv6A=;
        b=s2U7p0Qk6//+9AHOLftsG5h06+r0q4XZQckLYqTpmmKqvgZASadehwcHhC36TLGdst
         wJ+WfFbLHKvf/uMi5pZnHWIuCQ7nJ03NA/dmX0p8S4g9oRXdv3WHaciphsFgcxJ4IcOT
         6RMQlgvfIHjCbpbiM91pLtjXzE38Bwd+1WCjSh6td90gEgXT7aEVB/+8SJij76foyO9u
         dVlAN5gJCtPivN/OvHBNEn3NhlY62DWS2IXQenkYrjxIChGNu1MxKFk2do0690bFS/nY
         ACnneVx8xQrZkBQF914i5pasREtySedn3Zeos/XJmsgA+a3t6jZ/x/D8ALo/fJ/oun7h
         /lzw==
X-Forwarded-Encrypted: i=1; AJvYcCVukHw0fxtG/3sB9Uwr4UTxmpWQHt+A6+giZHUld1ov4fSimQUkcxVCt/O9VQRiUKEhGghnjah77tiUQWpFxFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdmRdaDFrsrK9ZeqpZsr2Do7p1yKun0dG8G+nA2QbK3SWVJGk
	3GjlapkqVBnWrJ7ex8OpZs5Vis6DH83DTc9PkHmoFyssf2y+N3F+/a7fVunCwVgckxI=
X-Gm-Gg: ASbGncvvyZdNOSbZzEQn9NnhNs8OVPlv1mkjOPCF8O1Nj8AQAiUSq6VuLYbHzZqLsXl
	OXageY7bsGO93UXNwLMZZK8j3QGgH+djYiiQx2aWV74r4kQbI1FcHKvkqiwUzcaXMbQad1LClrh
	ODOiTyIcpKjT5meWNJWz8glv5KlLH0sQjDs0YseNQEkyHWW01mNxbV1SK+PuPa81S5/kEoEdOOc
	O4osiZQPgjSOUFiLvPBsFFuGaLtHOLbxdqX8Pj1rIAFdH+E71Zl/rt3cieMs3bFux/fcwMd/UV3
	uhiDuCGvAZ4pzomwBDYotG0eKq0V+9kFk6H7hxVHHlGsyPJB5K7BILiAPjvxdDLTKyTrDqSm/rW
	1bVmYAY2rQPM445FYkr3zS6MgflIeFXFo8fqfWGdYPRUunU01iCrQYNIAyw==
X-Google-Smtp-Source: AGHT+IG7fMWI+kljj0ibuMWdDKEsXTDgf6PpZq6UXhyPEeUouJT4wes4hsUgSHy9QJ4Nl57jS05FAw==
X-Received: by 2002:a17:902:d2c8:b0:249:1f6b:3268 with SMTP id d9443c01a7336-269ba44c38emr56802445ad.18.1758287205777;
        Fri, 19 Sep 2025 06:06:45 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:45 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 5/8] mshare: selftests: Add test case ioctl unmap
Date: Fri, 19 Sep 2025 21:06:17 +0800
Message-Id: <20250919130620.56518-5-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case aims to verify whether the guest VMA will vanish
when corresponding VMA of host mm got ioctl unmap.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/basic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
index 54a132a8116c..043d1f3e1e3e 100644
--- a/tools/testing/selftests/mshare/basic.c
+++ b/tools/testing/selftests/mshare/basic.c
@@ -86,4 +86,24 @@ TEST_F(basic, shared_mem)
 	ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
 }
 
+TEST_F_SIGNAL(basic, ioctl_unmap, SIGSEGV)
+{
+	char *addr;
+	int fd;
+
+	fd = open(self->filename, O_RDWR, 0600);
+	addr = mmap(NULL, self->align_size, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	ASSERT_NE(addr, MAP_FAILED);
+	addr[0] = 'M';
+
+	/* munmap vma for host mm */
+	mshare_ioctl_munmap(fd, variant->allocate_size);
+	/*
+	 * Will generate SIGSEGV signal as ioctl has already cleaned
+	 * shared page table
+	 */
+	addr[0] = 'D';
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


