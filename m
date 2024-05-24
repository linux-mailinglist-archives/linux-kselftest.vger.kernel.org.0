Return-Path: <linux-kselftest+bounces-10657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E48CE12E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 08:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A001F21FEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5A03EA66;
	Fri, 24 May 2024 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUhZv0o6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4AC749C;
	Fri, 24 May 2024 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533577; cv=none; b=Pi/nnfP+fB/fw1npfSFeEveahTsj7J6045P71fI/ZpMzEyuHGqT0lW3bJrwpkJ8doGD65apxfssaUHww+ZsQx73OtMzAF4vYiyi+gCgj1bcGgaUyassI6YIBB466EYt8T0fkJMJSznjDJHyTm3681W6kqgmHq0qyJJwyAbmvYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533577; c=relaxed/simple;
	bh=IcA8areGBmtYySpKsN1vV7VjabAeCliqI9BnabnxYUw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Kr9XpFB8k+ek9S/yFC07R282KsgYBlLPKr9C9Z8Hcrw5N360txGZSXuwx7BubjAs1SmlCO4TKS2TdoqLuXZoMu/SaF+ajO72QbdICfW3o1d/H4iqFtj5tstes4dxAvVyyc/vth6qqPpF1ptlbmZZsd/Ss9tGUeRr3QdZaUpLIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUhZv0o6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f8edff35a0so467509b3a.2;
        Thu, 23 May 2024 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716533575; x=1717138375; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ykVoCzYAXxgYfsHCRKZ4/jVPW0FI1w87SrBVTf97eqM=;
        b=nUhZv0o6ncGQOriNb3/F9yu/80UgAqCL+KA625jf6q2izZyg8nYAgnfLMkoEpHnnda
         RpEw8AlfkLzP/bLTG9jhaRaZmpgesUhG7Nf8PUMcEeOJ3yWJNce/kRSONrX1gt1SKdNF
         fQ/3ZmTNl0OyLT8irj9tUsfYiCOQwmRqjxCW5vl3EgShfbXsyMDMntjE4lENm3owSqWV
         fxsvArUPX9a4uoCTMOEauryrhRfeVchS/zLajs5xIw+v2qUdB3gtveG0K5aZCSNDhOjs
         73QsbA7JB/RfZU3gi4GmbVMuUj/QVi+CfvXqHIFdQcxPB6pgillNbWaQgmsjTyBblwdc
         rGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716533575; x=1717138375;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykVoCzYAXxgYfsHCRKZ4/jVPW0FI1w87SrBVTf97eqM=;
        b=cnv4sfnH89PDtAxdZxiCO7MzvXPrnjX/v1ReGmY/tlukb911hhETdL0KokUswhTeZG
         QMeCpQyYWH2WaoHxzfZFMFgL+2087us07Ns6rlH2vxvxOVh0qJu02dOvPVY2fFUrpuRu
         pE094i7IEYkiZZXgjnr4cXOsnz+iNxv757Lk8GQOSjTkRSumCnzdzNXf1Q5TSfHSpbhy
         KT9fDv2lkHvcFFPzEjUiX+ZPuiM2lIjHptYG0+65UU03u3gF+cEHEgC/tDwgTStbbx1f
         fynUsvbnqB+61JfDnhjGmaLqXOZPe9eQR4+X35oDejTx51wPkXcwzj7O24OGkygIpzbE
         XQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCVFOIr1ZocP9CA/OYGCtfrMllj00sSXwrGYeuT+aFQJqqz4IT+eb+95XrLUUYznm26z3lYzJf6bD+/LgOsvqCWiYoA/SU/BLrr7f8b1W3k1yVVNPEG+utGkYHe6B0cfiI/bU7nRwbrEJCDXE4TU
X-Gm-Message-State: AOJu0YwqDyhqTM0dhxsi6eN62Z9D6Y10Z4OMe4WYirf1yoNS95SSDKsF
	f3TjT5w04QdaKA4MmC8PHizuKTDzNWYMpy/cKDK9oJqeVQU0AKC4
X-Google-Smtp-Source: AGHT+IFeHmKmJv50+uxoFGpkU0wNY7hJ3X7HEEhI+59tWnSNxwwR2DeReAt6XXA5R0PCcd9vrR99RA==
X-Received: by 2002:a05:6a00:418a:b0:6ea:df6a:39e7 with SMTP id d2e1a72fcca58-6f8f2d7247cmr1513112b3a.13.1716533575418;
        Thu, 23 May 2024 23:52:55 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc053bd6sm582396b3a.45.2024.05.23.23.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 23:52:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Donet Tom <donettom@linux.ibm.com>, Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked during __bio_release_pages()
In-Reply-To: <7792c8ba-39e6-47ee-9b43-108270325c15@redhat.com>
Date: Fri, 24 May 2024 12:13:04 +0530
Message-ID: <87o78vsoav.fsf@gmail.com>
References: <20240523063905.3173-1-donettom@linux.ibm.com> <20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org> <d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com> <20240523195734.bc03a8822a34b1a97880fb65@linux-foundation.org> <7792c8ba-39e6-47ee-9b43-108270325c15@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

David Hildenbrand <david@redhat.com> writes:

dropping stable@vger.kernel.org

> On 24.05.24 04:57, Andrew Morton wrote:
>> On Thu, 23 May 2024 22:40:25 +0200 David Hildenbrand <david@redhat.com> wrote:
>> 
>>>> You have stable@vger.kernel.org in the mail headers, so I assume you're
>>>> proposing this for backporting.  When doing this, please include
>>>>
>>>> Cc: <stable@vger.kernel.org>
>>>>
>>>> in the changelog footers and also include a Fixes: target.  I'm
>>>> assuming the suitable Fixes: target for this patch is 38b43539d64b?
>>>
>>> This adds a new selfest to make sure what was fixed (and backported to
>>> stable) remains fixed.
>> 
>> Sure.  But we should provide -stable maintainers guidance for "how far
>> back to go".  There isn't much point in backporting this into kernels
>> where it's known to fail!
>
> I'm probably missing something important.
>
> 1) It's a test that does not fall into the common stable kernels 
> categories (see Documentation/process/stable-kernel-rules.rst).
>
> 2) If it fails in a kernel *it achieved its goal* of highlighting that 
> something serious is broken.
>
>> 
>> I'm still thinking that we want this in kernels which have 38b43539d64b?
>
> To hide that the other kernels are seriously broken and miss that fix?
>
> Really (1) this shouldn't be backported. I'm not even sure it should be 
> a selftest (sounds more like a reproducer that we usually attach to 
> commits, but that's too late). And if people care about backporting it, 
> (2) you really want this test to succeed everywhere. Especially also to 
> find kernels *without* 38b43539d64b


Sorry about the noise and cc'd to stable. I believe we don't need to
backport this test. The idea of adding a selftests was "also" to catch any
future bugs like this. 

I am unaware of any functional test suite where we could add such tests
like how filesystems have fstests. Hence the ideas was to add this in
selftests. 

So this begs the question which I also asked few people at LSFMM,
Does mm has any mmfvt (mm functional verification tests)? Should we have
something like this? Was it tried in past?

(Sorry, mmtests name is already taken - "MMTests is a configurable test suite that runs performance tests against arbitrary workloads.")

-ritesh

>
> -- 
> Cheers,
>
> David / dhildenb

