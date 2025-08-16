Return-Path: <linux-kselftest+bounces-39153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A4EB28E93
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 16:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9517FAA6AF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF9298242;
	Sat, 16 Aug 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqS7tCzI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655E244665;
	Sat, 16 Aug 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355567; cv=none; b=gIsHvFR6IUlX2TjWtaMZxyDSLib1GOthDack5nGR+UMJXNlDm6GtRqLC56ApfwUjUhTwvIlk7vpwrQW4OWZ/E8CIVHuuxcEAeePHvrNt3Y74cc21gH2uBZcQxMg6tf9w3Kx5vfkhwj8l6yCOdSwPeD7y0yWeot2a0z6jsEfgXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355567; c=relaxed/simple;
	bh=U4yYqMFLjTTXeoOCwXF/eSK9VRKbP6TnS+0s9e9+8ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ4zx7PTXtPvYpSxY+Y8Jp6GSEM9RQbt4S10Jvgfsi3bBZml7XBn/OYuZKFFcJLTOj1s8CjEB5vscTFVIrSKr82yBKuDKW2a4PMGAxoknZF4hnSgcwJU1PMPSKA8N36oBiAokJYxPE3YuV0z/WzRYBoIf5NglI2u26+PqCJaRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqS7tCzI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb79f659aso428862666b.2;
        Sat, 16 Aug 2025 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755355564; x=1755960364; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj2xlwN8FaYSBmnA8nJC1cMfqZAxHNyF4eUqmUL4BG4=;
        b=jqS7tCzIHjnrg7UkXOG9e6K1PVIUlenKk+h8oK6hKKHPtFNafUWsYH6IN8gMAx7gPF
         kePxg23ETzsyqKGzxp98HmJvrztdpBKCX7UtZPuqkoET7sHZy++rf1zSEtcul7ln0dE6
         G66x0KSyMzUqX0uXppSUgNdyOfZ1UVH/Mf2nDuyOl4pcxcYZUz9h2awwbbCdGr428i1F
         WEqpOFxPyjPjNk23a1hz+ZzMVeRGyHtW8G1KZ+vjhU93KYp4Pb0ooiBovBW/0lokAddL
         DZM6Frb1y8EyPwPeA2lG30O646mTNFZkaX1K4wvouQUsAr004v8+UNnQs1Uj1BpCuUUs
         KMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755355564; x=1755960364;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lj2xlwN8FaYSBmnA8nJC1cMfqZAxHNyF4eUqmUL4BG4=;
        b=PP2Jf/NEZz4/qrhDdGpkIy+SucItkEDWKDD5dStY8FAcLscu5Xg+/Qumc2/w2x+BYs
         vacxaH4NB2srSSKQBamRO9xAEktTMNDflmTPhLjMeXvMUK77pOO9IVbJtTpN95l7LT/I
         Bq1O0588qb+/qehFcFW4sEXE2Otfb/J+8z80jHjKCZefNKu0B/wiPIfHc/TuaZHiwbOg
         dPa9gJP53iDT+KxMFS9cFWS4gh/MAeaQyWDmVKGTPkjF3FLE33YWZr4RDdUFVhD3oiTK
         YXud6MkgOxaKQh11KmonpfnRdGBpVGfpM+WjYVdEbjdUSu3fHLqORtT6KclhDVz6dD6b
         jffw==
X-Forwarded-Encrypted: i=1; AJvYcCVhxTMT3Aovf18DF8XIT801RiRnn/0jYhdLf9NUQQvjX7w41GB3eWgTCcU4jTdHbWuMjBY1BxEWcANXT6ecjEVt@vger.kernel.org, AJvYcCX7FvsOzwyBJU7jezF/w1FG7BJEMMoSqsGnC56gskGujgVmXT/mIcYh2ZoRR/ZCQm+ECwFwpmsBX8HcJiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHCU6NeYh0iGnmemirNfmL37jSvXihD3XzDY3ZpJ/wBvsiRJ4
	0Q5upclC4vXT4VW4mcyXg6xw4rYzEQIu6NrH08LAxzebtjudSdaxP77x
X-Gm-Gg: ASbGncu+uWK9gRzqRzZUZH0qSOSbsMxUZVQ0IQXI7sLqqBRKgyh378RLCUEfb+HJ86M
	ImNU6tVMyl5o2kOL4IT5EJc3E2F6RT3zA37wGBzHQjd3SyoNY4eWu81Nrff5kxa6q3iFYHmfMnJ
	iWwecfBlRS0Jmmr2NuK/BZFchfGQXAzpZx59mxRBp6t9TxVOzRUPgugyGvAT/aOZtyydK434m4i
	054o1JFmvNJems6Z4HIN6nxQ7J1BVUss9W9uVjjXrfXfFDCF0fMTE1lVfPqLXMvAtVA37NGkfp2
	XkuePXUq/lbpRHk7x6XYzXgW1t0fNzSw1Ow+pAABHcVJ4grhFhtz0HbZz2f6Gc/bSHcY473Xem+
	f7rLo6kyPGI+3kS3WQI6gQg==
X-Google-Smtp-Source: AGHT+IHYzSam8oaaPBGoeoFOYde9ZA5LUMifw8sPAmxG2jXP0i4Znt5bpM3wACSxr0qigpThqDMa1w==
X-Received: by 2002:a17:907:980d:b0:afc:d3f5:c40c with SMTP id a640c23a62f3a-afcdc362bc8mr521879566b.40.1755355564222;
        Sat, 16 Aug 2025 07:46:04 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccbebsm388692966b.59.2025.08.16.07.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Aug 2025 07:46:03 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:46:03 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v4 6/7] selftests/mm: skip thuge-gen test if system is
 not setup properly
Message-ID: <20250816144603.43nxd74hz6nrockz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
 <20250816040113.760010-7-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816040113.760010-7-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 16, 2025 at 09:31:12AM +0530, Aboorva Devarajan wrote:
>Make thuge-gen skip instead of fail when it can't run due to system
>settings.  If shmmax is too small or no 1G huge pages are available, the
>test now prints a warning and is marked as skipped.
>
>-------------------
>Before Patch:
>-------------------
>~ running ./thuge-gen
>~ Bail out! Please do echo 262144 > /proc/sys/kernel/shmmax
>~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>~ [FAIL]
>not ok 28 thuge-gen ~ exit=1
>
>-------------------
>After Patch:
>-------------------
>~ running ./thuge-gen
>~ ~ WARNING: shmmax is too small to run this test.
>~ ~ Please run the following command to increase shmmax:
>~ ~ echo 262144 > /proc/sys/kernel/shmmax
>~ 1..0 ~ SKIP Test skipped due to insufficient shmmax value.
>~ [SKIP]
>ok 29 thuge-gen ~ SKIP
>
>Co-developed-by: Donet Tom <donettom@linux.ibm.com>
>Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>Reviewed-by: Dev Jain <dev.jain@arm.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

