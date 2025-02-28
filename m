Return-Path: <linux-kselftest+bounces-27927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C763A49F7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590A67AAEFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1541E27FE77;
	Fri, 28 Feb 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfL/fe55"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6127780B
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761704; cv=none; b=GSas6JvM3G0xzQFZHPCwmyKGtkhSPq+t8InGZK8mRMi0r3bxzBhZ2sd7bLwAk/xo/1RKdYMV5WuT90p7DS8zPpaIX7XOzte5yn3zVuuXg3DeLXTiREMv30Qa6ujatiYCbq/kq676l1zbRpeLH0/D++SQ7Vyf+c5N+oCr+DeUS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761704; c=relaxed/simple;
	bh=xQVjS8N5XSh2Y3jn2kKQC5d3x6VqAfPh1V0W9E5W0OA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uTcl+mzgzZ26KAMfsJD/a9rJ8clFvA2L2rXpPWfTsHUMfwuwWFSD1KFxcPrApDZxcO8rLKPbrGtv4qXmbz8d4MmGYEqqJ5hsG5redPdANJMh9Y7dUahh4/WkGhWEm5Wb/WJEtU23jrxrJGB8ed9Oh1BGNv09FJPrR33U0euAHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfL/fe55; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4399d2a1331so12268595e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761701; x=1741366501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQTzwm1/YTgiCDgIJd4mGLtlXGG939iT/ah2c/DG9us=;
        b=kfL/fe55Z4g6xKUJlXYJaF/1xZKRgLKHap3wH9qe9ztzljhwS3Ldrxws8hoUWM3Ddd
         5dqIRzhEdxT1YUmb+3AULP9Q2tM/O6nVEyyTnitYO8fumyxdOsjFDiOCQcaR8C3hHVvM
         0iYEAGk+jD7VlKqF/5YDg4jbUiGLQmATwR7UVtR0Qz4Ll+OwMxOiVD+jolJxAx1MkdgZ
         vzQtKuImaDJ7BnZxTmToWr7GQHkCLyC+KsSt1V7oW5Y8fE4cHMsj4A1jq0hLdgng81LB
         9xvqOxLYO4GxhWDL+nLcwswlG3sJmQVDd2cvjkp/3misxrZ84C4ml3J4NENyzVhvzX1g
         gBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761701; x=1741366501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQTzwm1/YTgiCDgIJd4mGLtlXGG939iT/ah2c/DG9us=;
        b=GI3TgoVxpAf+8sc9/f4J+TT3+fDK1kp/hbTnolcqofPwyxz5PniGmSfKVglEwRwWTF
         g2K6e0zghkRnF2LQgx0PVmxFaKdnm4qP/nHuqdooX1tXzkukZo5YnFCCVhAYTVTFi1Uy
         2yJmW5Aq5PphWeAz+hR8Yq/x39U37yr9GeP+sE9wpyJ1baMBi5niXKLps3cna9O0xyRn
         aLJCjkt7wDbIpr8a2oqnQ+BMslEvl4Bq9NRn3ms+zpsMvoPBTiGvgwcmVht0OcVewmaC
         OYwJHC+F6Hi5d0v/Dc8SEGJylhMvl/oD6OfOEaM5Fgxe8bRWGlhtJepuBuiejonYEj0N
         w/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPVCJjJtMFrQblmZ40/95RljUyADbucTPiCmsn1wa8PRbkoB1yTZRToBNzT8mZr4pdmvERDC6TR7fgrAGcliY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybELP2DXG/UCU/0FE8bZsEmi3sVNNUJJRv1WJ9CY8POX/csjrt
	0dxNdbFXT1rxaUVla5kfefuZZAiC5VBX/KoZPxMk5Ur4hRHSUJaCXJCqTV/7+1e9FXDHtUSwzqr
	TiJE8CPLBLg==
X-Google-Smtp-Source: AGHT+IHS4r5KyEGEE1SEHcuK3lpeYK/As6O/YHl7os80gLfqDAlqf9ZMUgi8r5sMn/f3nJljGpIwhadvxYAUWg==
X-Received: from wmbfk6.prod.google.com ([2002:a05:600c:cc6:b0:439:94f1:365e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c23:b0:439:892c:dfd0 with SMTP id 5b1f17b1804b1-43b04dc361amr70383245e9.14.1740761701615;
 Fri, 28 Feb 2025 08:55:01 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:51 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-3-958e3b6f0203@google.com>
Subject: [PATCH v3 03/10] selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
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
2.48.1.711.g2feabab25a-goog


