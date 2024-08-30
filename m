Return-Path: <linux-kselftest+bounces-16793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD49661CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC7D1C224E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24CA192D95;
	Fri, 30 Aug 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTfdZrgw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E936556440;
	Fri, 30 Aug 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021109; cv=none; b=OP9Ts1YK+fRAi3gW1opJt8ghJq9qc6e/MiahvI6s3zTLUfGE7x6gN4BeuK0VRhW6/e3Ou3GJGbzlIozwMXW17+1jMtyczkExNJB/SXrijbDfSBFwt0VDHxqBj0OHB2HiEVIYk4Ts4L5LRzv+FZYaPX3Cn6lhsurKh/9tkcC3QwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021109; c=relaxed/simple;
	bh=m5Gh38p4UDxwQowc8pKIPA80Tfc5OBdPbIKq5RsI8js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ogp8mNtLQ5QBDxnxkNGi4gmQaevDeW3HG+fqT2ypjVIC8JVRvml74i9M8dlX1JfZYog2zu1+dC1I7v8lCCfGybFVRfzZr7uAeWM/KJaAp5u/k7kSycncU2T+MQ4nPO2nXjyLv/1vuEKleKxKbcAjrrQtGjBBhls8iRl+Ez0N2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTfdZrgw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bbbff40bbso5020535e9.2;
        Fri, 30 Aug 2024 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725021106; x=1725625906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohDjUIiSvToxlJbMqL5nyB0BrdhKvUaZXF1JCyJv4sY=;
        b=CTfdZrgwwUIiCrCWhm3QzRs3zeHmyBvhWYKhL/N9Dh/PrOVcUqJPCeK21v+GRhcM+4
         RLBRrP2hxyuc8i+Ge9v3qfGWlSWIbBFqvGrJOmeNnetlGYiXyqvhi6HvkNmvojoTcnww
         X83iN9rnwdEub/u5alqiyQ+WMJn1s0PM5om6pEYvXezw1YM09/G09KqZMqDMMS25h+Wu
         268k7ln6ib0ABCUElyZnQurfi9FhtBsV2ql0JDsUY1NVW+QAH1TRYBwroTXMjbQJrYd4
         0StTAUelx+hRwur2FuLGMZ/0xxNblzTwna8Sje3NcNcBGJpv/cy2tj3OXxNut+L7NltH
         orNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725021106; x=1725625906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohDjUIiSvToxlJbMqL5nyB0BrdhKvUaZXF1JCyJv4sY=;
        b=UQwraRIi+5K03irU6LkkZZEScayU3iVT6GCckLjFCKuuejeVH3pyhyxjHLbP1Kdqms
         tEx3BrOI+TvUWL55WpyNJgeCdOLqciXfzljP2MFR0Bn7RkwO+GJQn90KToSYFOj7MQyU
         iFWA6flceLqIlQyXGRJ2qs0AedwZBIFID/naLXIlBYwU38JDeucCTzYN8sY+Jjxn9Nzw
         +h9oTT605UD73SyghdxnDvToDmQgda1YAholof5IKJ0l6zb1dJSnpBTUsQnWFXtd+DqW
         Rj0vxMfzOGtjYpu6f5o5ytkNyzC6HaNMdohGSEfx7xLN4/UWloxwuI9y5gsM4xa1+dtt
         1pCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL+8dfheQW19RCuHMIocuD7NwvrALycly9wrtfrJQ6rd3VL4mUU+ZaLQSybZN5QnybrCsOgMVX2gt1a7C2kf4=@vger.kernel.org, AJvYcCW8rI+u3N7536pYR3BBP5MvI3skUgReikLzpbzpmHCwf0mFplupnM1LTCz7ka8YvKjBeZjIcOEDMDv2NHS3@vger.kernel.org, AJvYcCXVXMHeS9aMIIZLg0P6FnXfNnAxVKDpJ8vyFtV32jRZTsmKxNsNKvbkJ3zwk404kpIoLH5o5f2lmr3BTbXxTPY6@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOlM+eOt1A8yaIbXAlnQeNFj4Qsv6QMFffPB+CXwKZvijQ49v
	a9Rv/1mFyX1GMyyZnq3Q8JsaUwlwjavLezfsPIzNEiG3sHY+nZGw
X-Google-Smtp-Source: AGHT+IHmGTbedrMJCDroV7oNwxn3M3Ss6No5PIHgV866gcjj3PkKjQVFejaxDgbKL/toPUYO0S1drg==
X-Received: by 2002:a05:600c:997:b0:42b:ac3f:f5c with SMTP id 5b1f17b1804b1-42bbb436de5mr14103315e9.26.1725021105330;
        Fri, 30 Aug 2024 05:31:45 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:8a0:7862:ea00:1d36:5f53:3f57:14ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efbf406sm3842829f8f.115.2024.08.30.05.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 05:31:44 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:31:42 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy@infradead.org, lorenzo.stoakes@oracle.com, broonie@kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v2 0/4] Increase mseal test coverage
Message-ID: <ixoelxclkikscysvlmfbvciyig7pqjbuwwhhgawk6fy4iookya@kmsjo3oetgw5>
References: <20240829214352.963001-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829214352.963001-1-jeffxu@chromium.org>

On Thu, Aug 29, 2024 at 09:43:48PM GMT, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> This series increase the test coverage of mseal_test by:
> 
> Add check for vma_size, prot, and error code for existing tests.
> Add more testcases for madvise, munmap, mmap and mremap to cover
> sealing in different scenarios.
> 
> The increase test coverage hopefully help to prevent future regression.
> It doesn't change any existing mm api's semantics, i.e. it will pass on
> linux main and 6.10 branch.

I do want to be clear that we shouldn't confuse "test coverage" with being unequivocally good
if it has the possibility to paint ourselves into an API corner where details that should be left
unspecified are instead set in stone (e.g do we want to test how mprotect behaves if it finds an msealed
vma midway? no, apart from the property that really matters in this case (that sealed vmas remain untouched)).

> 
> Note: in order to pass this test in mm-unstable, mm-unstable must have
> Liam's fix on mmap [1]
> 
> [1] https://lore.kernel.org/linux-kselftest/vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt/#t
> 
> History:
> V2:
> - remove the mmap fix (Liam R. Howlett will fix it separately)
> - Add cover letter (Lorenzo Stoakes)
> - split the testcase for ease of review (Mark Brown)
> 
> V1:
> - https://lore.kernel.org/linux-kselftest/20240828225522.684774-1-jeffxu@chromium.org/
> 
> Jeff Xu (4):
>   selftests/mm: mseal_test, add vma size check
>   selftests/mm: mseal_test add sealed madvise type
>   selftests/mm: mseal_test add more tests for mmap
>   selftests/mm: mseal_test add more tests for mremap
>

nit: Please follow a more standard commit naming scheme like
	selftests/mm: <change description>
or
	selftests/mseal: <change description>

-- 
Pedro

