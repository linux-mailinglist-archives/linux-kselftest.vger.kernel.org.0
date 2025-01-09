Return-Path: <linux-kselftest+bounces-24148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C456A07F0A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A1C3A93D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1481F19D072;
	Thu,  9 Jan 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="ECXrcFQi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBAE19CC20;
	Thu,  9 Jan 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444398; cv=pass; b=hKRCjQR+SN2beaGw2eJyZlbI5adfvFAowQ+PL0OJ/+2+YVUkB99Ap+S35hvZTc+Up7Aqk3dJN1ijS2r8fZ8hoAQpiDcA6ADM77cuFrK3JVSjt8c4cFwNrquFXe3xjPiJHqT9fg0lGoqdcRZ6tMNI8q74Ft3O/NjLYfNxqxlIiKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444398; c=relaxed/simple;
	bh=dQGLRo6LBP/A+jdO2tS+HfbLKNzYpYt9Mrgf3Etsg2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6Rjm5w4Ae1bX9Ms2dOmDPErMhuLn50vq90MMDbysl06JWtN+9HzujrYgf1f+HV/D11SxfopXj1MvMPqAz1ofg1q1W7/l2SJTS00rzt/3Gu0tewtm7cgVZTk8xOOUuGfDSMSn4gmDLbWK/ZgkaVV93hjbSB4cdDD89oezi5N1vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=ECXrcFQi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444379; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OCqbFvX5wfA/TmAgcrBar5XSYD1cadtxE6wTnaXMAPBMpIMVYwwCuO+1+EkABkKnNKHezDywRDydrFPPTkFZVNdIJsbbLg2QUFlAFMNn4enNeX239Mpm/ojDCRMxPjcDO+K7X4AIK8rbyIWGAywlTxGzDH6PuzYvZ6P8bQXpTtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444379; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oZBjZaOGgfPGxEQUCi97MIL7c/M2e+noWOX5E6dbvzM=; 
	b=NuH+xeXHYQRy4+zh9AHKOa1kfFon6fejdJuRdRrE9GaEM8hPbENhdhKWMGvZZus+24elDN58igzLqfSdAm5EVMLyG/K/Z5+FVzYBmBJTjvVZ78C2IKHY1rSl2f9G+WtwSmivo6ssVhLFdXY1tRh/TOFn8czNXNvQiZyYoq8anb0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444379;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=oZBjZaOGgfPGxEQUCi97MIL7c/M2e+noWOX5E6dbvzM=;
	b=ECXrcFQiBiP0/jq8OCFeJldeTj49vd3vcwTY4r3jqUoK0xOPzLuedKBJrXAjENYi
	3xcgifqeiKewbARFJtM35wijNH6ioGakR26VK9Zk2b3rvaBlK6wNXRgmhKIEpqsVWYj
	/ZZ7MlDeq31L3jOeet+bzP7iZ8Eb6+RewjgOU5U8=
Received: by mx.zohomail.com with SMTPS id 1736444378245741.8870123024191;
	Thu, 9 Jan 2025 09:39:38 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 10/16] selftests/mm: hugepage-vmemmap: fix type mismatch warnings
Date: Thu,  9 Jan 2025 22:38:36 +0500
Message-Id: <20250109173842.1142376-11-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix type mismatch warnings.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/hugepage-vmemmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
index 23e97e552057d..8d30ebfc9b86c 100644
--- a/tools/testing/selftests/mm/hugepage-vmemmap.c
+++ b/tools/testing/selftests/mm/hugepage-vmemmap.c
@@ -51,7 +51,8 @@ static unsigned long virt_to_pfn(void *addr)
 
 static int check_page_flags(unsigned long pfn)
 {
-	int fd, i;
+	int fd;
+	unsigned int i;
 	unsigned long pageflags;
 
 	fd = open("/proc/kpageflags", O_RDONLY);
-- 
2.39.5


