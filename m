Return-Path: <linux-kselftest+bounces-41114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABC6B5123E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 11:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B402483770
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 09:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F00B311969;
	Wed, 10 Sep 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndtkMA4h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED63074AD
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495787; cv=none; b=f66ZBlw43aIZr4viAjE+E3QRwzbjJOlXA/rwzSaJ8yQ21/XrKmLAwi4E7Bzpl8nhHvWS9oyHIE7C6J8OPIwM9T8imyIZ6GnqLM6cPLU9PySH4hdVmXyLKv4TjxW1DmZmFJU/5fhFCMazgUZhqiE2N3rZMmw6S/umpQ8j5E1pqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495787; c=relaxed/simple;
	bh=bvFAdg+99Y4GcQvOE7202Ik8vv5RqJPxzNGeUuA6ifw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnpeVhu3sxhQmzeCQEfNv2JQETEiuFfmUkEMG0gJELjq4WWsAgJblkFFcBZyxmbkppQ49vwe5HjdIPZru5pXgMUz6Yhp/0fIODYpOQdTzfPaBg1QOVwZMw03IB+djeV4uaD8OpwVxxwUmMdFfTzJL6vkLdPUmHJk5rRgBwDuJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndtkMA4h; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so7355196a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757495784; x=1758100584; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWoZ3l7726OX3jB4OzkYOebIG9vuSYZtg5rWWfuavnw=;
        b=ndtkMA4hsou/XsyQOtKKH49+K03lKPxnEuotJL9b/WKY/Q0lvkfiVO2wGae5Uh8eYx
         HEsL55cSWda0TD2+mVuOdrjQTXzSLDZUVRpMRZOiRCyFRGMjDBYI/R6vO5Typ8nFaYq4
         ogNjWwci4lV+ChAUG1HXqgePhnC8Chd0udEO/hOWOZD8o+pVR9CEzY2wd7EkHhWtmEpZ
         1SFkFYEOhHUtOaUtxWCigwaLJa4fIpA1/WPT8BzJ0uIRtaLLalSYCtCyrG/prOBXLPGV
         NX12GfpZ5LmoQFBFbPOIMY5omyzWPps3QXdeCqgk7ajGbFk2D0nSNCGYMRODY/wGoeDG
         fWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757495784; x=1758100584;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWoZ3l7726OX3jB4OzkYOebIG9vuSYZtg5rWWfuavnw=;
        b=Tivq4U2YrvktT5a/LdiYM2smGhsOQm5XZPcbnz1FLfc72OuKN1Xpvp8Ur0YEm2sd4L
         lRh8H+BBvM8OcC+DZ44Vi0EYdF3hsyz8v8L7StxDWIti9bOqHEiU66/qRklCfs3Ky8x6
         o1njWGw09ff7bQKfc6MawLRVPCif0YU9hXzfhm/3b+GE8wcJf8XTQlndYH6UkL73wOK7
         mml4HYf+i70iinI00nPtzGABUtID07/v7+SKFij2C8YWFCB49u6UEew2E0lFlZMRQ2BX
         tThJ2Z8d86QDlgSr1PxFAUuuHWtqRhGSmqQTjgZuiQszH5Ftk6/XvBe7Iarr8RnG9mkV
         niVw==
X-Forwarded-Encrypted: i=1; AJvYcCX/TBWAytPn3hCj3xH2XUuJFihGEwzMb6nI4awn4XVqcSAfaUzlfSieozoTzqnV+XddcZA6/dCqd2kTyTdhYsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+SJN7XbZz0uLeI9vQgI5xssTn3YZ1AXMTb6rG6AHQbvf1yhg
	E+xvq4KaPnmVmLtaXDsZja3XZiGA0CE6pzhUiwNk6YExYotbX4wMEB8N
X-Gm-Gg: ASbGncvy50t/N6VQ64T6+Pirgj+P+VfbNFClUoTATvvKvlt/5656sWPM+hsKv+iyYhR
	sOT24SYqR9rGZQyDYi+RGbSvpygCwdKRTChe9NGDuBUZ6ZZfAERwfHT33BM9+Jq+Z+kCMOO78T5
	9wNf7F++3YAKPiUMngaKR7rUOdRbhk4fu4bkYYTGDOr4TGCWczWUJm8QAvcl5ekp/aO5rK8n+Wi
	7doENzMJQJTP3EFucG4D7b3dCocsCx6ZXm3ptOH+qaf8aMSf7pw4pAk5HvI83msUqtuBBDmFnHp
	VEjIOCr6kBwIEZo2VZLwV5mT4EDvMKuGzgmJJFwDaeFP1I5IX/6meyBMflodBfAQyEAoOmXq1n9
	9W7Nuz7Cd9OfNN5ZW3DPEUQELhFu42LBogVsj
X-Google-Smtp-Source: AGHT+IHqqOBwc9MStuYkne49yKfqkD7CJb5YxJGgDsZcBRqDaXnifBZ7VkKR89evu+GCbSRqZYXxQw==
X-Received: by 2002:a17:906:fe46:b0:b04:5cca:9963 with SMTP id a640c23a62f3a-b04b155a032mr1515367266b.41.1757495783403;
        Wed, 10 Sep 2025 02:16:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe99ffc0sm2868513a12.6.2025.09.10.02.16.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Sep 2025 02:16:22 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:16:22 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zach O'Keefe <zokeefe@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: remove PROT_EXEC req from file-collapse
 tests
Message-ID: <20250910091622.n25zvgw27olskao2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250909190534.512801-1-zokeefe@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190534.512801-1-zokeefe@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Sep 09, 2025 at 12:05:34PM -0700, Zach O'Keefe wrote:
>As of v6.8 commit 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
>thp collapse no longer requires file-backed mappings be created with
>PROT_EXEC.
>

One question, what if user run this new version test on old kernel?

Is there a guideline for user?

>Remove the overly-strict dependency from thp collapse tests so we test
>the least-strict requirement for success.
>
>Signed-off-by: Zach O'Keefe <zokeefe@google.com>
>---
> tools/testing/selftests/mm/khugepaged.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
>index a18c50d51141..3fe7ef04ac62 100644
>--- a/tools/testing/selftests/mm/khugepaged.c
>+++ b/tools/testing/selftests/mm/khugepaged.c
>@@ -394,7 +394,7 @@ static void *file_setup_area(int nr_hpages)
> 		perror("open()");
> 		exit(EXIT_FAILURE);
> 	}
>-	p = mmap(BASE_ADDR, size, PROT_READ | PROT_EXEC,
>+	p = mmap(BASE_ADDR, size, PROT_READ,
> 		 MAP_PRIVATE, finfo.fd, 0);
> 	if (p == MAP_FAILED || p != BASE_ADDR) {
> 		perror("mmap()");
>-- 
>2.51.0.384.g4c02a37b29-goog
>

-- 
Wei Yang
Help you, Help me

