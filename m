Return-Path: <linux-kselftest+bounces-14971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87694B17C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8331C216D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B254145B29;
	Wed,  7 Aug 2024 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjeZ3v7i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733792A1D1;
	Wed,  7 Aug 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063058; cv=none; b=tDj0tXxgeBeGb0u6rxENGlts0vYVmiOjUgh4AA/8STEOtT0zLoag+4izxZG+blawAgL714EVIBLIYT0gCf8CSE6yjJjCL+Z8GWFM8LCZQJ2JD/SStYeyYCsDNiK7+IPFd0abieUujCrUL1lbWjBBUIziRLscnvrK9YYhCujZH2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063058; c=relaxed/simple;
	bh=XppvwH6P+YroeBc9mNU+12vhKV+A3Jx4a4pnvsbgqfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2d9TTo/rAbwWuzBb8DXgWJWQZDsRmVn2TBec0bG7tUH/EcMB3whSFqFk5MFPRzch9djrxasEHwjnCif3E6FombfvrOF1aJhCqKv88BMLnEn2SxdcxSRDDg7zxpIJkDaEYcVcW6YuSa68ZrISTvLLptyf3Iti9KQv+3KrHV8tVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjeZ3v7i; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-368380828d6so126507f8f.1;
        Wed, 07 Aug 2024 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723063055; x=1723667855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MmaFumpYxx53X7+tTMs8NnH+I8o6dRYOWw21OJtXhs=;
        b=KjeZ3v7i+QZaYAk6R8XcuKJ6Bm6EJAPNPanFI5mSaN/7uIkf/vM7pMv0hvOj9IMaTg
         kghRJIcJl7d+5Ps0kLxOGNw74byei+sk1qb1JCjpRFBOAL9ggZqaqkysKi0NypG/XmJg
         uytHBgiqbQIq1lUQeTLqARUJdYLZ9XgdSHj55nplqQ0PW1jyZ7mx//BYEtaiwA3fbf1q
         dM02WQgbGLOoNN0ZUOUQwWlmxcE/EI5/nijtltezlk40vW4FOX8Xkt4MNtWGqefkzZh2
         ySKLoJ+V1qe1rR63mE1e0b1GADz255mmF4DiP7Tmc0fcdaYu7UAFAQYbBuhPMaRlbHv6
         PXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063055; x=1723667855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MmaFumpYxx53X7+tTMs8NnH+I8o6dRYOWw21OJtXhs=;
        b=pgGFh6Y11PD5/F4Ll9phcNe+I+HE8677jvoUivh/XAr0fyMuwSgUP4oAtZBZ/I50ia
         ZRjg752nuRnky0wY+HvE9V9AiS2g74i9p7TArUfO6XOjC2CavTO3xobNA6rdf2GNBWx9
         ZcxTj2TpAKkpKnP/i1MvX+DZCpFRD/5RqZPAN1OI2Jdfl2nhEsBRNUP16xW7S2HqnwvX
         mhqtO+5Dec852PSQYr0rLeLfejQvlbL7u+ZixE2FH7gOlKE+aEGDEawX/rX0OEYebSPG
         4hjzDM6WOPeQANcDp2L7y0zasxPt8UuZ0m5Ynlw2ir8+lmIOWt2szTek6EUSZEMrFp2p
         lP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+oDUVCBGoE+tQIw5jQDIMoQh9LmcFfjYSQh+IqWVjCj4RYEL09GjQ4rMQN8asZvjSk0hwpHe/QXCqGmLREYZNmbSKRwib10iTg35G18k5Th63waU2jJ7Rdu3/GVx0JNWgtXrjQmqpvqfhwnjb
X-Gm-Message-State: AOJu0Yw+TA12Dn0vZnJ9sZVEqaQlpSnr/MaIAviZjaQPE/0RkPwa+CEe
	c00sJ8rBTRxNkbqP+mcf9Jd8BflRhhtn1EWv4MF13Br7gfUWx8yz
X-Google-Smtp-Source: AGHT+IE61kFXwqm9Rh8xnuvCuNL8UJuGX36F/y+p9CbI7arO4EcDSFiG1ZFM90I06yh52+467O3GJg==
X-Received: by 2002:a5d:4e90:0:b0:367:434f:ca9a with SMTP id ffacd0b85a97d-36bbbffe12emr13325706f8f.0.1723063054378;
        Wed, 07 Aug 2024 13:37:34 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e236sm44492585e9.22.2024.08.07.13.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:37:34 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: pedro.falcato@gmail.com,
	akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
	jeffxu@chromium.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	shuah@kernel.org
Subject: [PATCH] fixup! selftests/mm: Add mseal test for no-discard madvise
Date: Wed,  7 Aug 2024 21:37:24 +0100
Message-ID: <20240807203724.2686144-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807173336.2523757-3-pedro.falcato@gmail.com>
References: <20240807173336.2523757-3-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the mseal test's plan.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

---

Andrew, please squash this small fix into "selftests/mm: Add mseal test for no-discard madvise".
Thank you!

 tools/testing/selftests/mm/mseal_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 2dcda7440eb..7eec3f0152e 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1775,7 +1775,7 @@ int main(int argc, char **argv)
 	if (!pkey_supported())
 		ksft_print_msg("PKEY not supported\n");
 
-	ksft_set_plan(80);
+	ksft_set_plan(82);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
-- 
2.46.0


