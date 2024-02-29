Return-Path: <linux-kselftest+bounces-5664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C486D2F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 20:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1961C212E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1D13C9C1;
	Thu, 29 Feb 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="v8RjAY7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7E160641
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234498; cv=none; b=LILfaZ/56v7gPNSEhZLv1g3jKGQAWaEPSW4f89uo4CBk/9ypp/4rfX3X6vlx0RuWqo/GuIMtYK9/p9b/Fx9vXbXX9ZMwiO9R15Yzj9cBulKUDdt98pKKPi/cwhkdDTkJmvS030s+VO17YDZLzG+R/kQvjmkNVkoeY3Wwoc/6QY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234498; c=relaxed/simple;
	bh=fGfu0Q3nthw9sx30v36veHsP6NqWca80nHwERt01OC0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Q5edz1rhSQujLdoxhGrqdoYoa/yWbLJtCiCl/jKwcnMuY4iSkLNQCTXkCtwP/ebbmiNx6rB+X8JrZt8eRAnlhO8Gx558uI3uHuZd5Vi1wi/sKHN6PKzm1dELWNLySPjokaS4Dq9ObT8PX18+0ubG69d1CQ0xMxEI1A3uVIHp29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=v8RjAY7x; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e459b39e2cso1885339b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 11:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709234495; x=1709839295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tI0BeeYqM9dH4CtDmNU5Z89KyVB0ENS6fdLlu9zwgwk=;
        b=v8RjAY7xHJQH0QUKntTMgz8W5YUzAB06+2MN51dnCDUQM4ScTGBFlKgSzslq4Huq5D
         RTYJdbxlVZlzzz17XRGgPoq5PlTCyQewympTYvK+Vg1Jhq8yq+xf9ZjCwTU13h+BcTGf
         f//ienXj7Q2szz1vddAewvr2+uO3X7cqVQ4bRFeomLyOV6dNmewFJkYNrJ3C4Fg6+dwN
         sbyGkVBD5B2yMKxmoF9I6z9xqyd1MnUdqMV/CbdFDAV2Bbw+z/mv2G8QInRpsVk8hywY
         WPe7r1J0tUk9nKxGcjaC/hQrz7h9h6lW9zn76cUKpXYDViWXJz8Pul2k8zOmO7zgx0V2
         WcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234495; x=1709839295;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI0BeeYqM9dH4CtDmNU5Z89KyVB0ENS6fdLlu9zwgwk=;
        b=S4bUd9MeZ2hkW8tvMGmDIzyUVzn+dhKkVvheDynh1la2P5C/dXs6zoUQahmnARVnOH
         hAuNhPmLDNAHYSLKtqDlLHRMGv6B4zj4oEZqom/DAtTtTOI7spwakMBzKAf+538QCWMv
         y7ifGCiBSFcQEp4DHwfyywQIfLF1GqWCp0cxUUZR6mrfcH9L+0hPL+I1mDnvouNebfZP
         LIacRXp+O3SI7mhBI2deKNFBdbwvRkwYgkHfF85n2ZI1X2wwKJ079fR08MYNlJGv1pex
         Icg/suSvY8DwJw3hUte6x1pgfU/BX7bYgdFxS1/f21r16NS88+Yp/ReBu184KDqHbayG
         q1OA==
X-Forwarded-Encrypted: i=1; AJvYcCVj935vEVZ2fV1wLgez8akckbp9mHobo99rdy27PS2Se8yCbGZLgzJ6ShJNsXvgr9zDZvknhqXNl26STettVr0P23FWvkA2FfEY7wkPrsAK
X-Gm-Message-State: AOJu0Yxp1DoSZr4lDi8CkP/U+63DXCgPLzH7nQygteovzfYHtSqVXH8U
	hqkjQ7qZRYeEiSu+sfbRvb/ELXvuTW4Ov2z3ffJKcv0jH6vKaxQ/a4DPF40ca4I=
X-Google-Smtp-Source: AGHT+IEb+gGTWSZJgyAaR/j/macgR4G7Qn8rFIkQpEZb0vtMqMn8yLy4/Fk0QWniPKOilz8fvl9fwA==
X-Received: by 2002:a05:6a20:e616:b0:1a1:209e:99da with SMTP id my22-20020a056a20e61600b001a1209e99damr4015579pzb.28.1709234494948;
        Thu, 29 Feb 2024 11:21:34 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id e6-20020aa798c6000000b006e4f18784cfsm1625915pfm.124.2024.02.29.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:21:34 -0800 (PST)
Date: Thu, 29 Feb 2024 11:21:34 -0800 (PST)
X-Google-Original-Date: Thu, 29 Feb 2024 11:21:32 PST (-0800)
Subject:     Re: [PATCH v2 0/3] RISC-V: mm: do not treat hint addr on mmap as the upper bound to search
In-Reply-To: <tencent_3E8D4B7CAE824BDA238EA2B821310F21EE08@qq.com>
CC: cyy@cyyself.name, alexghiti@rivosinc.com, andy.chiu@sifive.com,
  Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
  jszhang@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org,
  Paul Walmsley <paul.walmsley@sifive.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: cyy@cyyself.name
Message-ID: <mhng-67b02dff-5423-466d-bd90-f3ad3a3ab6a9@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 04:10:03 PST (-0800), cyy@cyyself.name wrote:
> This patch has not been reviewed for more than a month. There is another patch that did the same fix but in another way and still has not been reviewed like this. I'm here to do a comparison of some choices briefly to let the maintainer understand the issues and the solutions. I think it's time to make a decision before the next Linux LTS v6.9. As a number of sv48 chips will be released this year.
>
> Issues:
>
> Since commit add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57") from patch [1], userspace software cannot create virtual address memory mapping on the hint address if the address larger than (1<<38) on sv48, sv57 capable CPU using mmap without MAP_FIXED set.
>
> This is because since that commit, the hint address is treated as the upper bound to create the mapping when the hint address is larger than (1<<38).
>
> Existing regression for userspace software since that commit:
> - box64 [2]

Is this the same regression as before?  IIUC the real issue there is 
that userspace wasn't passing MAP_FIXED and expecting a fixed address to 
be mapped.  That's just a bug in userspace.

Is there any software that uses mmap() in a legal way that the flags 
patch caused a regression in?  If that's the case then we'll need to 
figure out what it's doing so we can avoid the regression.

The only thing I can think of are realloc-type schemes, where rounding 
the hint address down would result in performance problems.  I don't 
know of anything like that specifically, but I think Charlie's patch 
would fix it.

> Some choices are:
>
> 1. Do not change it
>
> Con:
>
> This behavior is not the same as x86, arm64, and powerpc when treating memory address space larger than 48-bit. On x86, arm64, and powerpc, if the hint address is larger than 48-bit, mmap will not limit the upper bound to use.
>
> Also, these ISAs limit the mmap to 48-bit by default. However, RISC-V currently uses sv39 by default, which is not the same as the document and commit message.

IIUC arm64/amd64 started with 48-bit-capable hardware and kernels, and 
thus the only regression was when moving to the larger VA spaces.  We 
started with sv39-based VA space, 

> 2. Use my patch
>
> which limits the upper bound of mmap to 47-bit by default, if the hint address is larger than (1<<47), then no limit.
>
> Pros: Let the behavior of mmap align with x86, arm64, powerpc
>
> Cons: A new regression for software that assumes mmap will not return an address larger than the hint address if the hint address is larger than (1<<38) as it has been documented on RISC-V since v6.6. However, there is no change in the widespread sv39 systems we use now.

The OpenJDK and Go people have at least talked about using the interface 
as it is currently defined.  I'm trying to chase down some of the folks 
around here who understand that stuff, but it might take a bit...

> 3. Use Charlie's patch [3]
>
> which adjusts the upper bound to hint address + size.

IMO we can call that compatible with the docs.  There's sort of a grey 
area in "A hint address passed to mmap will cause the largest
address space that fits entirely into the hint to be used" as to how 
that hint address is used, but I think interpreting it as the base 
address is sane and we can just update the docs.

This also should fix the realloc-type cases I can think of, though those 
are sort of theoretical right now.

> Pros: Still has upper-bound limit using hint address but allows userspace to create mapping on the hint address without MAP_FIXED set.
>
> Cons: That patch will introduce a new regression even for the sv39 system when creating mmap with the same hint address more than one time if the hint address is less than round-gap.

I'm not quite sure what you're trying to say there.  If users are 
passing a hint that's already allocated then they're not going to get 
that address allocated, so as long as we give them something else we're 
OK.

We might want to take more advantage of the clause in the docs that 
allows larger addresses to be allocated under memory pressure to avoid 
too many allocation failures, but that applies to any of these schemes.

> 4. Some new ideas currently are not on the mailing list
>
> Hope this issue can be fixed before the Linux v6.9 release.
>
> Thanks,
> Yangyu Chen
>
> [1] https://lore.kernel.org/linux-riscv/20230809232218.849726-2-charlie@rivosinc.com/
> [2] https://github.com/ptitSeb/box64/commit/5b700cb6e6f397d2074c49659f7f9915f4a33c5f
> [3] https://lore.kernel.org/linux-riscv/20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com/

