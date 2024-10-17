Return-Path: <linux-kselftest+bounces-20045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546BA9A2DED
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CE91F21052
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A72202626;
	Thu, 17 Oct 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR6IixGD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B91DE4D3;
	Thu, 17 Oct 2024 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193868; cv=none; b=pyCGkOlbfHytK4qT5b5FEI6P4LcJMQtkU9aoxd23ONFyPAvtx3QvYIGxfyjRJoOK1TRRSBnnQIPRczBnEDvl9FO9O5TtBgl+c/OiKGSQZwSJlbXE4qt88hiMf0iDVI82gK3+deg1ax/i2jEskmOwNuDUIXDH1xQXIACX0qoCb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193868; c=relaxed/simple;
	bh=Sm6IlIRGd4fjZ3/s15FJf3qVsQozMCTKzEfJAn6ZE98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgwYOtZUt8qA1REdxoidxsSL/IKEIjs2mNOzPSjVUdz/atfk/PbvcU1vZFEeyi+04OshVnUZOdBZSELTumUYzhbhZ4DlQ8+Dwax7HLrF3HeHov3+ObA13wDzCS5ItUv7NDI60o1006b3vRqr4Rwd/HIYWbz/LPt4H2iLtgljf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR6IixGD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43123368ea9so12076715e9.0;
        Thu, 17 Oct 2024 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729193861; x=1729798661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8h/rSuKMBhpDA5BHmrBSxjpD19Vv1E+3fuCAtBFbBiw=;
        b=iR6IixGDt7ARSLl78ZMqvdl9nmiM66VQBx11hWzGPb07AVRfaODV+dM6mjLvM7blOt
         QY+Pd9z29cayvfaKmp1jpruLBw+5+3WVJMpWRmIMG5Cx0fPyiHy+15fBcRX2oEIebihp
         Zz4QubiFUZDz9rl538Zkwv6E2B44WqKykWeqqXdXvdifaFzgdHVrCTVGO0lXNzuwRLMl
         WwYEgzcFOYk6fZF9TGZ6MI8THf84zOuURH/pfna95yIETfM1pJbgQwGrydqddznHDPTR
         RfyG2KuT2+/OHrfiUeND4wLYcbnlhKLslbGE4CVjfBeS6HNjryxJ8tzIqqvRrXv++cWn
         Jxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729193861; x=1729798661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h/rSuKMBhpDA5BHmrBSxjpD19Vv1E+3fuCAtBFbBiw=;
        b=FhO3Praycw3JnVHG/f2QVt6nqBrklocW7oow4K0SsvnAcuT1ZNY/GBhcKwEYGRryR5
         RbgEBQ3l4STeP8sQWsogFoLbsAyIe8YcQjEfFkFOPGLTSYKF86fnoC+PKKKg4JYMBzqm
         psyB0KsYKzpr78cyydxBDhByfbTzptqxDMSuuNCuyFrsdjgqP1eQP7m2AOVrwOuk+ERb
         7ntwojYhiAQsR53nqsht5+EQLNC6mf8ukLtsaBIeW/Uy5nBLGwIgPTjKtKsW7CIbD3si
         EnMeYKuOVqLTSCMVk0C5J85QKXpFMLUNg2E1NIf/ErLzFeFESaYm5TEbkCV6RhzRnDXK
         ewxw==
X-Forwarded-Encrypted: i=1; AJvYcCViJjBijw3/1n8wKkrgwfOHdGbQi95F82T8pCIAM/BnJPHoeezb7ncCi1rkRMealiRpTSs4m0Rf@vger.kernel.org, AJvYcCWmMX2JVkVAdE7c+EmEskptn6ohsJM9z+JKJ8cPnaiN2Kxa4WgZvVgQrX3V/sGW3D6XUqXLmNRw/FKsVEZbMsw=@vger.kernel.org, AJvYcCXCnyN2nlcPt/PuXNNsJd+RdGFTGieONpdDzBZBPi70Ogr2ZgAIDR9xOW5zyMkYk+Zx+IcrEqFAIJRz8+o7p2GG@vger.kernel.org, AJvYcCXNUnSQ8455ligZzT6ZeJ0XWRiOfc3drYoiS1saJ4Ehz0ftQw4WFW0bWkNp2azNGuWJJi7ZjmOETT7EcJLS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhd7CBB15CLNvJE4NjjYaWwVtrF7m8g6ZDQsw/dtpgC7JDQ2fG
	FiF6NNCGjrGtrpk2e8KxIY0m+kvUnh3nIJj6l6ClxakXoh3JUZLK
X-Google-Smtp-Source: AGHT+IEtxhKwkjiDOlpe66PvkClngkn2lHQGqPXQiW+OMdxDPk+q4H51x+PeupG9zfJTkn1htd/7eg==
X-Received: by 2002:a05:600c:5118:b0:431:5f1b:a7c6 with SMTP id 5b1f17b1804b1-4315f1baa8dmr12646175e9.30.1729193860904;
        Thu, 17 Oct 2024 12:37:40 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:a118:25f3:b27f:9f34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa90c60sm8286800f8f.62.2024.10.17.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:37:40 -0700 (PDT)
Date: Thu, 17 Oct 2024 20:37:37 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, sroettger@google.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, gregkh@linuxfoundation.org, 
	deraadt@openbsd.org, surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when
 sealed
Message-ID: <5svaztlptf4gs4sp6zyzycwjm2fnpd2xw3oirsls67sq7gq7wv@pwcktbixrzdo>
References: <20241017005105.3047458-1-jeffxu@chromium.org>
 <20241017005105.3047458-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017005105.3047458-2-jeffxu@chromium.org>

On Thu, Oct 17, 2024 at 12:51:04AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Two fixes for madvise(MADV_DONTNEED) when sealed.
>

Please separate these fixes into two separate patches.

> For PROT_NONE mappings, the previous blocking of
> madvise(MADV_DONTNEED) is unnecessary. As PROT_NONE already prohibits
> memory access, madvise(MADV_DONTNEED) should be allowed to proceed in
> order to free the page.

I don't get it. Is there an actual use case for this?

> For file-backed, private, read-only memory mappings, we previously did
> not block the madvise(MADV_DONTNEED). This was based on
> the assumption that the memory's content, being file-backed, could be
> retrieved from the file if accessed again. However, this assumption
> failed to consider scenarios where a mapping is initially created as
> read-write, modified, and subsequently changed to read-only. The newly
> introduced VM_WASWRITE flag addresses this oversight.

We *do not* need this. It's sufficient to just block discard operations on read-only
private mappings. Sending a possible (fully untested) fix. If you like this approach
I can resend properly, or Andrew can pick it up, whatever floats people's boats.

----8<----

From dc5ec662dcb79156f4bdc1cba2a2575dce905ffa Mon Sep 17 00:00:00 2001
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Thu, 17 Oct 2024 20:21:10 +0100
Subject: [PATCH] mm/mseal: Disallow madvise discard on file-private sealed
 mappings

Doing an operation such as MADV_DONTNEED on a file-private mapping may
forcibly alter data by discarding CoW'd, anon pages and replacing them
with page cache pages fresh from the filesystem.

As such, this somewhat bypasses the mseal of a read-only mapping, and
should be disallowed.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
Fixes: 8be7258aad44 ("mseal: add mseal syscall")
Cc: <stable@vger.kernel.org> # 6.11.y
---
 mm/mseal.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 28cd17d7aaf2..d053303c5542 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -36,10 +36,15 @@ static bool is_madv_discard(int behavior)
        return false;
 }
 
-static bool is_ro_anon(struct vm_area_struct *vma)
+static bool is_ro_private(struct vm_area_struct *vma)
 {
-       /* check anonymous mapping. */
-       if (vma->vm_file || vma->vm_flags & VM_SHARED)
+       /*
+        * If shared, allow discard operations - it shouldn't
+        * affect the underlying data. Discard on private VMAs may
+        * forcibly alter data by replacing CoW'd anonymous pages
+        * with ones fresh from the page cache.
+        */
+       if (vma->vm_flags & VM_SHARED)
                return false;
 
        /*
@@ -61,7 +66,7 @@ bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
        if (!is_madv_discard(behavior))
                return true;
 
-       if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
+       if (unlikely(!can_modify_vma(vma) && is_ro_private(vma)))
                return false;
 
        /* Allow by default. */
-- 
2.47.0

