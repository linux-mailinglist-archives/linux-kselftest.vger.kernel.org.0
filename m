Return-Path: <linux-kselftest+bounces-15938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C349B95A865
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 01:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806812830B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CBD17C9EA;
	Wed, 21 Aug 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d25XIGov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F616A94F;
	Wed, 21 Aug 2024 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283463; cv=none; b=dtKwbdpS4qwn/gXrPRYd5etMNHxsIZayW7NQ+88ueTanwKERL+HkgXk5YU2gGThOJ8uNPtEzyizBQbbfrfIuVoz/bPtKdwLIG9lVidE+DvWkjonMoWzGtTarUfaYQLYsSEwoKlWWmWUCNIuFwP1Elyc48RK/u4SLbh8JkIrZAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283463; c=relaxed/simple;
	bh=tyZb0O93zOtM/1WNDk4/z7mxHnvixg7b+S63+1z37ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vj2C2C089vSQwe0zjbwIMKvfRrsCtFs0sZvRsKpl3x0Qq8I9UQArKpEPIZj/WyGgnnCE+gDwehBI7gMoR0OtmDb7qauWNTXjDUFNukuunlpaOvmLZSb+ESj3VlhBDyiV1PBf0gadxLYOVap4CdGYDZEmbIHF4PAFcXVydCri6k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d25XIGov; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so67486f8f.1;
        Wed, 21 Aug 2024 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724283460; x=1724888260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oB5w7fxcaYwmfIUWiN1fWC2Q932KuuOxyBRyR9Q44aM=;
        b=d25XIGov9Rzcr+gW3C4mV333qPhw8Oh1ZNJ/nsT2V4JjJkEp44lPTMV9/yMPzhTaQ3
         m+qJRj1ouHKNBDeaFmOsunw8vSiy/K84GOn6wA9a6Sn+ZG8AaplTpA8rKKzBJ6rOpkDC
         gVbqTvmj/00WGSoPK4qRDxghUPrEtiroV9n9/ah/E/bmRepdfEKtuOzawaCzRBAphji+
         IYX4wQawioLS6aDSMoXwflosug2A31vTMjrze/Lrzrn/lEkP9uAvABdurp4YAGm0hhYP
         xwkOE67KOtsQ+HxKJRT1Tw/tIV3OTPhKlNRBSWLiTmIeGb2yMe9/Xi3LutRqH6IwlOtS
         QJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724283460; x=1724888260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB5w7fxcaYwmfIUWiN1fWC2Q932KuuOxyBRyR9Q44aM=;
        b=o8hzjakJv2jStJ+m5c6TLjsH69vsSllM6iMNhBSiUC+6VgXZee6uKxF3tpWxaieKw8
         I17XwDNi0dQsyPDYmnqlttx7OtjNFFPuv3r96rRsY7o1ZWAOW79EDS8c64rtFtM+74J6
         WACFr6Y7xG9thw2iDSEQ4nMbLP2CNGx0caBPL1Kb0jFQ1W5cFFV6cPd9FKlI2goti5f4
         YBuLRaV1cBES6eXdSSll1MwHBXQb92OO8qHFD4IOfrLLnenGQWx01XVFgiwP3IcMB1DG
         HPzPgKRxKuKT9AnxoNSBDNjLZT+9+0FlSLh2IP8El3M4savMx0OoA2zKXat6E9QoglJd
         AZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh06qqKEBZLFH/ahFsVwT3YL/3IWt0Gsws6jQrk0jJM6K+PnUMCF8qI39wJJeNZ72sgYc0FKmXZW+Gtpo=@vger.kernel.org, AJvYcCW+S+l4oIvTvTjAe6OMaWrJOQjlkJ6Vz1PQ2Rge/B7uSQspOz3KqlWZFiLmbP3rE8cvCvevz4yVryTjEu+F6+uk@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZAehj0q9w204oBdgIwCSYZvdxEbNcpM24NkZ6bcx8aiMWFIH
	ErGBxJ6K4tkkQWyUebbhfa/zXjbX0XZxQW0f0t/wv6mBiZwtN53f
X-Google-Smtp-Source: AGHT+IH+O7XxV5K69cEPSO5P5QE+aYeT/WJm7JzD/L1TBAlnJ7EuqWVvc5svqtwC7BmEqbC9U7tIKw==
X-Received: by 2002:a5d:4282:0:b0:368:584f:9e08 with SMTP id ffacd0b85a97d-372fd590e5bmr2387727f8f.22.1724283459421;
        Wed, 21 Aug 2024 16:37:39 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813cde5sm191184f8f.40.2024.08.21.16.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:37:38 -0700 (PDT)
Date: Thu, 22 Aug 2024 00:37:36 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 7/7] selftests/mm: add more mseal traversal tests
Message-ID: <vc4czyuemmu3kylqb4ctaga6y5yvondlyabimx6jvljlw2fkea@djawlllf45xa>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>

Andrew, please squash this small patch with this one. It directly addresses
a problem found in review.

(I was told this is the preferred way to send small fixups, and I don't
think anyone wants a v4 over this trivial issue)

Thank you!

----8<----
From 614e5dc27073c39579c863ebdff4396948e28e03 Mon Sep 17 00:00:00 2001
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Thu, 22 Aug 2024 00:20:19 +0100
Subject: [PATCH] selftests/mm: Fix mseal's length

We accidentally msealed too much, which could overrun and try to mseal
other regions. This seems to be harmless (at least on top-down
architectures) due to various reasons all aligning, but may very well
cause spurious test failures to e.g bottom-up mmap architectures.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 tools/testing/selftests/mm/mseal_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 0d4d40fb0f88..0c41513219ae 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -783,7 +783,7 @@ static void test_seal_mprotect_partial_mprotect_tail(bool seal)
        FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
        if (seal) {
-               ret = sys_mseal(ptr + page_size, size);
+               ret = sys_mseal(ptr + page_size, page_size);
                FAIL_TEST_IF_FALSE(!ret);
        }
 
@@ -1036,7 +1036,7 @@ static void test_seal_munmap_partial_across_vmas(bool seal)
        FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
        if (seal) {
-               ret = sys_mseal(ptr + page_size, size);
+               ret = sys_mseal(ptr + page_size, page_size);
                FAIL_TEST_IF_FALSE(!ret);
        }
 
-- 
2.46.0


