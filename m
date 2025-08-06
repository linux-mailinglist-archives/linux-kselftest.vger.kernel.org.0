Return-Path: <linux-kselftest+bounces-38345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39454B1BEA1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 04:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EB5162A66
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 02:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA091422DD;
	Wed,  6 Aug 2025 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQoA3dfs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98D1805A;
	Wed,  6 Aug 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754446069; cv=none; b=YVUGBWKrkx4twVpEAsHN5mpUPnUShSUNXrEmZb4/9vD8uDOLeX7r8EJAm01YO+ELEqTPRaUCZR3UqvrwfH/fOCrGvmaYJS331uWr8DArS2djb0ZJdJW0JaJ3gJK06rfIo9Tyr+v4VSSihraZOLqepwWxEc8qNm8Y0gIivdGZLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754446069; c=relaxed/simple;
	bh=7l0/Dm2zXzz4qR2g2FdMQsJ8JL6jl2NAfVPPdO3JFTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG0bfyP37cqDesblbsR+pzdrjSIJmdhvyuGRRnZ6GbxH/XcTpf30B4/+obJN+I5vucFhsFzbyXh3bcemPaeEQfZQBbKtKNSOrZvg7nAn+P0u99QgViHSioxyRRvfk1jEnE1HTIO+gV08fv6TZHDw+h6J4m1yBgjcQY6ECx0G2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQoA3dfs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso8543626a12.3;
        Tue, 05 Aug 2025 19:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754446066; x=1755050866; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpITwhr9A67ffsCSQOPHyjsSE7A1x5MUNzvao45sH0w=;
        b=YQoA3dfsBqG6XRQ9c6FMUcZqxuNQc5ubHU726NsaGbQe1+Flq9WxcC89i8yDlokyVY
         llqmQynIBzkmP55dChlM8wh0vE74tJh2WBMSL3vGXEPn4ZfYz0rHEKD00k1fDudENADx
         zsd84yMCj9ej8gMv16EjJqQL8fjy4F5QJqWWBDMFEM0kpgrgK/vNlPT8f1PihLuC/wWs
         LUcnya9Q3Ia81nnA4zaJ/cOSrMyjOMPdrzAmNGDy0LKMgX/lVmiK7lwUbEyeYk6bEpcr
         bvfoYcZTBSxxglYhNVw25EbbRhkYWzlRESUWLcuEYaMbAMiQbK3FC1DYagAkpBkkANM5
         h1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754446066; x=1755050866;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpITwhr9A67ffsCSQOPHyjsSE7A1x5MUNzvao45sH0w=;
        b=Xmw8FBS0Xu8rnZAMlLCAEyeDFR4+QQOs0DLccI/EXVcVLIhbQud/bNER7HQna0aGwe
         xxtO0TrWxHtRp83SyrFEx6c/UQVN8Cj0XF6h/0EX/iIGlpKK9whpbKYLFQoKgRSA3odl
         /NhwsgqM+Cub9561tqywEhVvyBpvTMf52XXWVHil9iksmIasQpdpR2EFMjJaYt6D75Fa
         /R1tgzSv7vV6wDzUYB4c1K9mHU1sfX/rNotm4XyJomcNih/Cl2XIOkAhTxQKqhbYjSZ2
         BYyHcM+ML3UBUnA2ysxQgwp+E0e5BI2bGFj7SLlvFGD9iSW9VD0uc9WJ7HT5dgvuIMl7
         s28w==
X-Forwarded-Encrypted: i=1; AJvYcCVUw7mbCWc2DFWGhl0U1LZYuhj8mpbfrAJI7JvNbx8+qB74CD48tg4KtrKvXfZtQomUFKKf5N9Dl0s4b2M=@vger.kernel.org, AJvYcCVZf9vwH7cDyuKfFj5o2BoJRRH8mpwJdpqnhsFxULCGoJYgRVacKGOCtjRe+yob8HVbqkYcxfyuQlRV/+44r9fI@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTsG4HIlNUO70TB3w7/BetsvNjMhALqvScbC0gV4OgBFy0j/b
	HTfmkSWfEMlczZ2kfSoPwHnkDXaX2f6grdVeYZuSuEZZLOwUD2UmN5tr
X-Gm-Gg: ASbGncs86tRp4BADrpqWlc6B8uHzTV+kOne/mtMJfadSUm9rc/3fp5nqq1xsga37yfc
	52y4fUcoAB8cZ2Y3HHPuwsL49HTFmmNZ1DxQ6U6g2RtXkqhVMXQdQH0ue3mtqWkhgqFSXoLTnao
	Ta9syoa94Y3qpKTLKH73f8n8EH7mw88XYifrJzbBDyhRRnU8Ne/uEcZcX7NY2bhSGGq6IYsxFyG
	EEEbmzwq8tr8u90HHhMN72+F4CXnf4es84wG/crFjBGkuR06EjmU2T/ddkFwJRjo3xdhtVBmNme
	gk2brfivku8erB0dQ0jKc8WuslP1g+aUd2bUGOfgSrSZ1DwH6Quf/MJ3Z8SAgGVOLiAGw+jkUlj
	bTn7sShnoT2hiiGLSuTmY8gB+spufMgEa
X-Google-Smtp-Source: AGHT+IGzc7It1T9mdNV+lU5ZWtwPMPm0G1+b9g3xgIXNb2r2gdXmdobSRLJxbqy2KZlOabt6uN/rHQ==
X-Received: by 2002:a05:6402:24d8:b0:615:cc03:e6ae with SMTP id 4fb4d7f45d1cf-6179609bbacmr916447a12.6.1754446065519;
        Tue, 05 Aug 2025 19:07:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f00247sm9506616a12.9.2025.08.05.19.07.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Aug 2025 19:07:44 -0700 (PDT)
Date: Wed, 6 Aug 2025 02:07:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: wang lian <lianux.mm@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>, Kairui Song <ryncsn@gmail.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value
 correctly.
Message-ID: <20250806020744.yj2f7z6ntdqnv2ff@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250805175140.241656-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805175140.241656-1-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 05, 2025 at 01:51:40PM -0400, Zi Yan wrote:
>FORCE_READ() converts input value x to its pointer type then reads from
>address x. This is wrong. If x is a non-pointer, it would be caught it
>easily. But all FORCE_READ() callers are trying to read from a pointer and
>FORCE_READ() basically reads a pointer to a pointer instead of the original
>typed pointer. Almost no access violation was found, except the one from
>split_huge_page_test.
>
>Fix it by implementing a simplified READ_ONCE() instead.
>
>Fixes: 3f6bfd4789a0 ("selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"")
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>---

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

