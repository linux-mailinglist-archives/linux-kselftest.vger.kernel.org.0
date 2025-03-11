Return-Path: <linux-kselftest+bounces-28739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636CBA5C245
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48D8162E8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3D91C5F39;
	Tue, 11 Mar 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsN2Npuv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221B1C3BEA
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699107; cv=none; b=oiQS1qbC6PwfYfDiC/O0IG3qh5Gxw0f9h9MiixbdFNqHF5RJg81MKhksFbDiAbGNGpYO+0sPDeI2DNUetGWG/4uptDRqEJ/n7l3EgSfIvYJ0Crrp4Ro8CL6O8TThpcAwFAt6OWpM/ORJePn5H1jN6QtXy7ww963TKgfE65v8geo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699107; c=relaxed/simple;
	bh=YI+QfZYo+Ua4IptGRz3TLf+pOBqxcgMjursiHKuuqQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nuX+3dq64WD5qXLLjPH7aT1Fs1bSOKB3cJq8M5UD2FJnbdH1B7ODgn5GoXjWvM2BdvzZFt3Fqir4B2lobDMBFai7Vm6Pud3n3tMKcGFd2NdRnCqYi5TWqQpY/l3zRkO5HWNFLu6vbXwOkaKvdP/8OO4NSjqehtjrDheJdinfZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EsN2Npuv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43943bd1409so37916685e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699104; x=1742303904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mU0cRsNzbsuSP1E5sjoXt0xKYtlq+gxz63wOE52l3IA=;
        b=EsN2NpuvnZRBWPwHVjVhZUlAvWVacGYo/2PJwIenfRAOgHz1eyNNJMdMDLqHzqyvA0
         aU469XLW91EJUqiyViSiO5yqrPIHoVG2eir/YAB2TkteKxe5xEFRH9Hhzbd+vcsVVbQ7
         lr9cqyBPkHCSLnCzR08Fb/BDQcZarXiwL+iU90qkbMGeh3LYivhVc+BwbexhFUN+SvRz
         u62+uvLEmD/0hHvoO5Amfh99qGA6z4JU+zdeEFCTKfYmYvKk4NyKA0NzHMjPTCSU1ZaN
         BTXKoAJUkvsfUL16UdFuJeQH9WBQgwo1ZeCcTCdwqO37+B1ZAHsqkXSeqfB59Tfwi9TK
         dpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699104; x=1742303904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mU0cRsNzbsuSP1E5sjoXt0xKYtlq+gxz63wOE52l3IA=;
        b=laqzFSWdFYYLn49n1WWBLMvUTQT+v5bOJY25rn5rRZDveig6oLRy/Udk304Z+K9gVb
         O3kiowBoc+iQz2IXBxDM/ASwNFyuh4kq7svPzxcxBrcklmlX7t+BSp8vLxZEyGAuZlSp
         g3nwumknmXKN8cq1Fi1X9F4MqC6ZOsQNQSVkhHVOGbL8ogK9jCitckHUEpTwAcQX5myE
         +wIIFpbmK8f0LjKq/Tv240/TB1YfUG8fT7geo9aJ+iCIBeVDZ6HtwywL49cVju/m+rfv
         z2xkpwQD59yUstx7OGE24qi5LebKoNa7225K0iJo/Tzdnn/P20tJrMWwdRbIsUBa+9/Z
         Wetw==
X-Forwarded-Encrypted: i=1; AJvYcCXVRBg7mSHMN6BskkPff3wnWsbuoWvrYtqds350888/WOmx0TgEUN04tG9dj3raTz2YwSRCst6aGiwiN3biJ/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyfrF/5wS98ynYIkuK4YCDNqlUANuquhyn3uRzXrC6TCwCYlr0
	UaH64k4ZKz4Y38B9xiLLqNEx4AIc0j+RiP/B1IaHDP/hQp7JrRRqh3wUi9LPo9kosX9tYF2bhOG
	a9qP/lXxfRQ==
X-Google-Smtp-Source: AGHT+IGSV21QBYLlvs34tFS6Vj4C4TFSxgnu4bOOKFjZdG2VcNI1hO3z4RNOQPjlkVLg4FfQFOtvmKJGtJlrQA==
X-Received: from wmpz16.prod.google.com ([2002:a05:600c:a10:b0:43c:ee49:c14d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cd:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-43cee3f0578mr100814485e9.7.1741699104325;
 Tue, 11 Mar 2025 06:18:24 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:14 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-3-dec210a658f5@google.com>
Subject: [PATCH v4 03/12] selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It's obvious that this should fail in that case, but still, save the
reader the effort of figuring out that they've run into this by just
SKIPping

Reviewed-by: Dev Jain <dev.jain@arm.com>
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
2.49.0.rc0.332.g42c0ae87b1-goog


