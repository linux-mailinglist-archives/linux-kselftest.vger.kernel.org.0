Return-Path: <linux-kselftest+bounces-18603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2595D989F10
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F6E1F22E40
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35B17C219;
	Mon, 30 Sep 2024 10:01:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1657F14A636;
	Mon, 30 Sep 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690480; cv=none; b=HiNU+RzTdzhVbbG1W4gSCjnps1Rso+nhCl5ilZfPYeGM65AziAd3wVWe+zFacbjjT91YfeA4HBlA58iZijjh1z1/9PfHCGPbxO8T+fd3DFEeb8AyWNO8vjrZBQaki50sRKVWv1mnYdznFEuWobHD2bDXc/1U+i4Xre1q9ICQzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690480; c=relaxed/simple;
	bh=ADNHjB1rkJ3sb2ung7GlNLGz1AEYcccjtTnHyXspNuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo+wdNrjMtE+ffAEcMdHQT3AQ8YmnjtGdcR2Yirsbru9JARsz8XRMyiLGtggkIQF6wunGkk/R3rCFkQcnHH40SuoUw8z1NgrP4M8/1Nru+nZlPKKGA6X7MSrejdYQ5k+4eot9D5yHuDd7U/TzA2F8iKtYNGqzY1ZlS/Ymt0i294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d56155f51so532911766b.2;
        Mon, 30 Sep 2024 03:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727690477; x=1728295277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz1ZPwD+OFOrMlNTUkXUde4zQolmtMFgXnEyYHIosvo=;
        b=tj/7ntogWd1jkL29QcMkSkhtvUPQVc7e0s9+PtEyRrQs58/lzzTYQrW9KJUFHJ+qPh
         RwGlZeJ/1BglVp96U1pkHmw0rtz4UIhv9YdG9kpaXhm3NQOlwREuXPshlXj19aTltUwp
         TYXnlgECN8dDLIxMAZ8x2o80M7b+ELcvhsOZQHa3og7/PiVU6pG7gvzhHCKFrzdtX6/r
         aXnZTPXEuh8vUbFXTQ+B5+OyDvKTwV6gyvacEY1KhKwdig+B38xrEbq9tL7mMBAQPJT5
         yboaQ5SVCVFxWVsvFJ9Dfl+jcgNhIvsHvipvx4o5xaTZQPTpC24bWJoBX4oQ6slGIkx3
         IxYA==
X-Forwarded-Encrypted: i=1; AJvYcCUSFTHIek1E8chZnnVhGvAT1BG45fa8t0kH/H1ArHzY9Pb3gnEgN9m2lSoleu+3x9h9ONEhsDmiAhFjCdLUjWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7EToVv4UP6QXCKffp4xiZqWTeOnPjo8RrmR1ukj8jODLYufK
	gBaysEVh9vHR2xNazudebsJMsvAeDPhRANVPQElklstXjFa9ZCUD
X-Google-Smtp-Source: AGHT+IH7sUn//ezn3oq6CKzmNFo6XW+V2Xva71KoBqYZHEiIz4n/WorNlpvjGnLoDscqtA2AaiLpwA==
X-Received: by 2002:a17:907:7e85:b0:a77:f2c5:84b3 with SMTP id a640c23a62f3a-a93c491f380mr1022495166b.22.1727690477266;
        Mon, 30 Sep 2024 03:01:17 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bb8fsm514708166b.176.2024.09.30.03.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:01:16 -0700 (PDT)
Date: Mon, 30 Sep 2024 03:01:14 -0700
From: Breno Leitao <leitao@debian.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v1 1/2] selftests/mm: hugetlb_fault_after_madv: use
 default hguetlb page size
Message-ID: <20240930-burrowing-quokka-of-serendipity-f35eb4@leitao>
References: <20240926152044.2205129-1-david@redhat.com>
 <20240926152044.2205129-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926152044.2205129-2-david@redhat.com>

On Thu, Sep 26, 2024 at 05:20:43PM +0200, David Hildenbrand wrote:
> We currently assume that the hugetlb page size is 2 MiB, which is
> why we mmap() a 2 MiB range.
> 
> Is the default hugetlb size is larger, mmap() will fail because the
> range is not suitable. If the default hugetlb size is smaller (e.g.,
> s390x), mmap() will fail because we would need more than one hugetlb
> page, but just asserted that we have exactly one.
> 
> So let's simply use the default hugetlb page size instead of hard-coded
> 2 MiB, so the test isn't unconditionally skipped on architectures like
> s390x.
> 
> Before this patch on s390x:
> $ ./hugetlb_fault_after_madv
> 	1..0 # SKIP Failed to allocated huge page
> 
> With this change on s390x:
> 	$ ./hugetlb_fault_after_madv
> 
> While at it, make "huge_ptr" static.
> 
> Reported-by: Mario Casquero <mcasquer@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

