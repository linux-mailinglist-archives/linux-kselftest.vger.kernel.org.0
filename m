Return-Path: <linux-kselftest+bounces-40352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00395B3C76A
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 04:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE033AB53B
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 02:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9D7082D;
	Sat, 30 Aug 2025 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnMWRfC+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA347F4A
	for <linux-kselftest@vger.kernel.org>; Sat, 30 Aug 2025 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521101; cv=none; b=AHKbcDAuKJ+7QYCiOXeRBdnQ6yGa9dUkpNsWvt9pmi/YyXjYTKmk1Pe8AL/9+9GbThgxivgWMOHe45GgejIXOKmxIALXZgOzepqTQ8T0h24/kCUP1rJ1JWwWTwgVzTgidrLqISeO0WGJ1jAO4d2ty0SAlEgTFeLyWyC38mv2QfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521101; c=relaxed/simple;
	bh=QzpOEpNXxwcHKGXBJUr54+uf8M8sHc5+wYIFC1sEA4I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fZlLvUDZlQu6pa+SGu8aAnaW17mt2lgGtG4aVzkG0nkEzdG0GNBSX0ZVLrUFXv0kLtrObXgvc1PqhYumyzzE+I4vG2Dh7kq9YYKe9OGDRZjKwd2Y4q9Y4csp19Fa8UHxhUvGu1JRFdD0KqVzQsFgB//Io/Lp0lmMosTvwNhJE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnMWRfC+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afead3cf280so352087366b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 19:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756521098; x=1757125898; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aGXXFM8I2ro06weOG3Bjb7Vl3YlyKeRZk613DsglMg=;
        b=HnMWRfC+CDaePZRGNbmlx3gztG0HPfK7Tc5JrB4WrF+I4c/sUFVqpqWFwP2eaBWhAq
         1TNP0LeqqEGbrNJy6sw9aj/5mVajqLq5DLW4mw0U6zu3s+hzfQZXhSELc0jI/bAlWZnU
         I1UkUd8UpmkCZFY8Bu61DJ8CAS+j0Y6K/igJcAwxDev2pYq/mpTTD+s7JycjMk5ThxBW
         6YLdboFzJIgMegBgiVVs/5/XW66/PSDxtMCYWNz5KDkowT02DvsEPMzl0DSirecJzMUT
         cLHdMoIXEuWO1kNIQisuk1LHDjNbcsHh9BbphWHGILRZ+l93Ksdsa5V1Yhcw0aPxZwOh
         +r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756521098; x=1757125898;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aGXXFM8I2ro06weOG3Bjb7Vl3YlyKeRZk613DsglMg=;
        b=ndoMwFl7PNSFc1T9tG1Ee8iL++oy1+aoT8cuceHbeg2p2GNBdh+YQiJItJdI3QOu/I
         J4XcRM45ODzKt0LcrELuh0rYMOk2EEA+qaCLCnLp6BRusXBZANuhVWOeWM2/y67xfKan
         xCocPAfs7z+prCAmERymqZl9I2Crx9VZXHyJnBDrJh1T+KUcqW4br1dJuMtJRA8XvHAg
         zSrXn+hr0vN3Y56sRTLZRcouDqIPIt+ESuToTDVpCZ6MZPkgjA0bYZZDInzepvKqiPBX
         P8BeJkd8HI9hz05kacTypERaFxJYUlxUbNqeOEuy1TFbc02YKC6bt7SHw1pQXs/fLRMg
         bpcw==
X-Forwarded-Encrypted: i=1; AJvYcCWlef/xKU8R0ZM9VQEp/qlFZ1YK6mU6ie+GZoDM+ZqLH1lNT9bDEOjquWurpq3F73hKX+nORUGClfjLDDM05nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWk33GgLlLsxIHjTO/jkxy6t/0GD3fWXhtsThT9Ka+ncN+P+1
	KYyWhUp4IzTI6xQ93TFcJYckJYxdvNPh0vdEx6R7wXhQK21F3HqW+9hP
X-Gm-Gg: ASbGncv6QWi6O0Esne3xwqD4sM26JEuohIBFiX+gA5FWi80vd4d/9xeMvc2sAVz0/73
	Q6lO2V6woD1jSmtaohWvIXQxxESyyvAToiEl33uYaF0eEWUFtV1bdOLf6XK8yqCa70Z0TsehKmq
	Vf8FPYQ8+5/NQrrOME6d9YqgT3AyQqDzI4+GvEFMDjP3o7vGGlcG43/RiTzTWqBsxmM6vERfhHI
	sQbt36CdzbERo+2i1LUkWsA/ZnY02k5MeeHQKcYofWSNU7FRQtQJGrlJTUxEaEQF2CeF1qbyqI2
	G0K/DgLLftj16CxOhyISxEnDuDqIucgqvzuzrbdiSQXYXdOjV6NLRtTTuJeSN4UGgNH1aDSeViT
	RaYaZ74zhgfM5mpH5QMNCntNpBQ==
X-Google-Smtp-Source: AGHT+IEcG/Nz2DmWzxZFbED+CA68DsmCKn2JGjG4o8z1waVfBDDUrhiW98uMhJp3Uel99HOsAPYJwQ==
X-Received: by 2002:a17:907:1c01:b0:adb:45eb:7d0b with SMTP id a640c23a62f3a-b01d8a73360mr67095866b.15.1756521098386;
        Fri, 29 Aug 2025 19:31:38 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc2bd8esm321428466b.85.2025.08.29.19.31.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Aug 2025 19:31:38 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] selftests/mm: directly add pagesize instead of increase until page size
Date: Sat, 30 Aug 2025 02:31:02 +0000
Message-Id: <20250830023102.14981-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The check of is_backed_by_folio() is done on each page.

Directly move pointer to next page instead of increase one and check if
it is page size aligned.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 10ae65ea032f..7f7016ba4054 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -423,9 +423,8 @@ static void split_pte_mapped_thp(void)
 
 	/* smap does not show THPs after mremap, use kpageflags instead */
 	thp_size = 0;
-	for (i = 0; i < pagesize * 4; i++)
-		if (i % pagesize == 0 &&
-		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
+	for (i = 0; i < pagesize * 4; i += pagesize)
+		if (is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
 			thp_size++;
 
 	if (thp_size != 4)
-- 
2.34.1


