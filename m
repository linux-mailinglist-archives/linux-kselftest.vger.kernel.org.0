Return-Path: <linux-kselftest+bounces-27075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2645A3DDDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CDA7AD843
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8A1D5CFB;
	Thu, 20 Feb 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qz2lb2jc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DCF204855
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063830; cv=none; b=AbFCOvIkhSjaOxQIaOAEPTpUJIPPl7mvnDRnCmt2UWQ6VyZd98e91bO3jgAfa4twhIEdKEtMmKMtyvK4LxgKtXrkiEPrnkRFDgFvaiZdLJj8Ow1kKt3EYZFfj9V0urHwH33cWy6q7CstIYsbqvzuqqL5rvjeoF4/jGQXaqskxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063830; c=relaxed/simple;
	bh=Se/GydgHH9nLLIGfdGGZR9s2IiE5I/RUbIaLvfmjrag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pis3jzEjofF/354ZXrR/REJ1aX9YwGk2tyFkMaOEO4wlFHw1d1IRXf4U7JCM1mF0ylpU0A0Xkqzt60CaVHcxm7bOj1fe2kYAhHoBwXgf5yppHh3Tt3jfeqyIjaSu42vonQJ/eMhroMPcIe5bxSUoMZogisWJFOKgdj9rtdfWXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qz2lb2jc; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38f62a0ec3fso678861f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063826; x=1740668626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0OlocBh0Rs8sEPgodfZSsh3pCn2jLgGhmAgomJhmE4=;
        b=qz2lb2jcxfwkhdfoOfo9B878dvkifMzWIFPKKRGP8cmDCdnz8WN1DSrdSwM8MEdzXt
         4CTF+SxaF7CpeMY9yolDSYEfH2TY5H0s1QoKk1+roTraYawOhkddRlsmQhYehNfnf0x7
         0pAq/Zi3ltCMA0W+WecLmyQQIjcXIKHY/5cm5Gj94SWVIf+mjIdX7y7+vvWcYlnnT2pu
         gs0w6jdtoU4lvrMrVF4AKHYlrNfLYcStyZM5RnnsAp9D1DLNyPhQ9Vy0s1oGlFR/Vlzr
         l7gdmCE0sKphXNOQXnAQp/E11WLP2/OXfn41kt2Tgaj3AsXQT38wJ9+vebM/IkPEMlQd
         MRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063826; x=1740668626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0OlocBh0Rs8sEPgodfZSsh3pCn2jLgGhmAgomJhmE4=;
        b=EZ/kF1+BMTalDFdU71pfi2baRRQZPOXAlaTKg+N48kdvIVpbaUa40IQhk9kHVqYqQ6
         A85npoDxXuK7beONocKqX2rGi6fsGhAxevsIuqG0se7Xx67OdspfQu4OhS98TPWANfwB
         kiMrKz7b2z2YNAFonFyDBHJep3BYKw8T+2bK25Bi+Fi64J5MXo43+O/RRA6dz+uORp/d
         DhEL2xq0my/k5oEKr+DRY3NTbc7v+3fj0wfsXamRkSkYQBzHSI7n/bxOTJZRA/rliCne
         OMZAZ2T4vWgueRvMwl28U6Evzntj3FvtGEiZJlcj5yH4FIN+vd6A7nKCnWu7DCH45HP7
         Ld3w==
X-Forwarded-Encrypted: i=1; AJvYcCVqI7lyVAoU2s09daMqj1VtowyNcE6dyJ3CoH2/1e5vMmTqJOK40e+LiBNYOwsSIeawbr1EfKCVh4MI71urJhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/zkthpWJkzUJSrgura6EVB9DLl99zOmKBhb9vVBs4Yj1lShB
	TMSmju1t8rQucPhYv2gHgkh/UWMLjx96jV/mkAHI4bhZUFXTDoCnciu1xWKDAVr8BYK9Gw634lV
	f9Xf23ucDIA==
X-Google-Smtp-Source: AGHT+IFsGg82gKlzl8tWzntDHJFghDx2t08uXQ7P5idCDRgaVqvqc920eCUSioT9wAdKGGY50Zw9lE7MF0GKww==
X-Received: from wmbez7.prod.google.com ([2002:a05:600c:83c7:b0:439:67c6:5642])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:47a7:0:b0:38f:4b15:32fc with SMTP id ffacd0b85a97d-38f4b153521mr12347926f8f.8.1740063826684;
 Thu, 20 Feb 2025 07:03:46 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:16 +0000
In-Reply-To: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-4-9bbf57d64463@google.com>
Subject: [PATCH 4/6] selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It's obvious that this should fail in that case, but still, save the
reader the effort of figuring out that they've run into this by just
SKIPping

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-wp-mremap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 2c4f984bd73caa17e12b9f4a5bb71e7fdf5d8554..c2ba7d46c7b4581a3c32a6b6acd148e3e89c2172 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -182,7 +182,10 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
 
 	/* Register range for uffd-wp. */
 	if (userfaultfd_open(&features)) {
-		ksft_test_result_fail("userfaultfd_open() failed\n");
+		if (errno == ENOENT)
+			ksft_test_result_skip("userfaultfd not available\n");
+		else
+			ksft_test_result_fail("userfaultfd_open() failed\n");
 		goto out;
 	}
 	if (uffd_register(uffd, mem, size, false, true, false)) {

-- 
2.48.1.601.g30ceb7b040-goog


