Return-Path: <linux-kselftest+bounces-39152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2CB28E87
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A39458375B
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C656B2F0691;
	Sat, 16 Aug 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU43e3y8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105E62ED14F;
	Sat, 16 Aug 2025 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355406; cv=none; b=R/AddKCXqcSR1mGhd0BnW7BpPOmZohZo4kcHd6EonGEvFL7RVL4EZUGNolhZMgEiEHo3qDjJS4i1qIC0q2V9mi+7fYBqF3/lFl3TTow8AcKXvLwd0OHN1U5MfcU8LkspF19KP71/e08XjU4pWdTeQZiNBSFwHsmHZQLeN2sjITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355406; c=relaxed/simple;
	bh=WosEZ3saSWBJMzH3JyYi4WqLDke5m7nW7duANtVtIVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vnc4geqxijlEab4BE476B7B1kHUuwIM35ZA4bAtgaBOsQmouPmqkZt2D9d3d+2AW8agatHH+nD0+5naHT3sbqvl3g16yi/IqbTge9lx+MGMw53IhHSGGL84fEvtat8RIf2nIXsZr/5bxCBilU6blI/e/a2LARY18NVmnWi2jYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU43e3y8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78ead12so408483966b.1;
        Sat, 16 Aug 2025 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755355403; x=1755960203; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yklf0U5QFdhyrLX5rUnNnZYccDAUmCcCKkGNXA7e/fo=;
        b=fU43e3y8mpjlONmMUXGjWIpcYaHqOIDrgxLq3NhXpecqOeWrmWv0WS41i4GZH5H2po
         YE0QhA8KU5O9aYpQ9PE4vWmbIF8LdKA8lrAt8w+VMKyfXyWkm1zgJtMKtMNm3rGVfjT6
         QhxGwKuUV2dz7cWTzoAIh7HYQzq/9bc8ArP4xABrFtI/zrIZrCLsYCXY2rVBj1NnyCSE
         PEIWHrF9+q/F4TtEoV9rV+/r6vonDxKl8zF+iV4e5trA9cbzPWY9WEtYRUL0dJfFq98L
         gH1SWQvUMOtNwUGevuSZDhMxrjlCmYZoDYz7Wi0+3g9aXBrE848XHPDjQX8Jh545KSI3
         2a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755355403; x=1755960203;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yklf0U5QFdhyrLX5rUnNnZYccDAUmCcCKkGNXA7e/fo=;
        b=qSWCG3DUUZQ5QDhQanRPs3iY4i7RmR+e7/ZQnyRBOD7EJ0wVJVFwWK1iHRerbsKOV5
         a8WIu+ikO/zpRnXNFukrW4FTaTEJtB4Owu58lAEnUueIe3YDK4x0kKg6ywsOT9WMZ7oD
         Ujfl7QScZONzzJdYFWVt8G8uwcavnR6JlV86V66W/kjDAzpbFtGj2Msfey59o4q8tnkV
         zR2ic5cBJJym7Im/itWmL7SyP5MhJp7uzaH7hCEmCNSr7wka2480RPbNa4NjPysLZRSo
         z3Ehmky+z5wc8pVj3VNRZUrjO8k1tYv82pbb68KNtQnCHC2Q0QZ6FHcXJ4y2wJ7RV0qV
         X8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu2EZIYx5VQ+ohTUFE1ZGGFbo9PdyEomnj3v27yNNliYKaWgfLwA47xqVC47FR4UXXejy1UWv238SDxk5aL18h@vger.kernel.org, AJvYcCWGQvHe4U3Ya3iD4rn7JlVMECfP58nmra4hhagxlMJox7cJVcnYQgYYqs3ZkeJdQq9yhC8l+3YxA8wg378=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkTBLy0WBbmG0WAnMfgWhxMi4F9e+2I59+rXy12mIY8kcj73V
	GUYHU5k3y+/xTHmolJ/hXopbRhCgrSzxhoTj7aN3hAqnwWEk2R7ldsXG
X-Gm-Gg: ASbGncsjBmX+WvG9m4G0XAtH/6WUPPwjAdrPHoaSgeefew8THabJV9WrXwVhQzbvFLV
	2BdGo8BctZfhQ7Qdv3ibKufVHze72ViaVJi+e1/rm0HO/OL3xUfyDeP35NxiCCPsUpzWsxtzF8u
	ayG4sWlS8uPiNj8L6W2hiNuXpDAZ3kPpogw0935mRE71GGSxJp7Fhgvk3eHhHEdeSXmGPxOEoRd
	sHgEy0z2yZRBsL6LfakVKBdFKu++T8446LZIda2L3Cavt77sjtqHpJSJiygawLcLmCNH9N2JkST
	BawlGzIb15kph8eLo2CLfO22WKSFvBtNghEVD+3+aqkTCQ4CvnqkDpOz2SdFvT8CuiM2UfEPUGm
	RV4qm/ncx1VVkwCi6FXz7Eg==
X-Google-Smtp-Source: AGHT+IEGqVbAIDII1mY1gCF9jBAvWgrpMrhi6faWvY2jr8e0MUYDYVLLmVWONSAn0yE+VDd8vjzzzw==
X-Received: by 2002:a17:906:6a0f:b0:ad8:85df:865b with SMTP id a640c23a62f3a-afcdc288daemr532008566b.33.1755355403259;
        Sat, 16 Aug 2025 07:43:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53f5fsm393726666b.2.2025.08.16.07.43.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Aug 2025 07:43:22 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:43:22 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v4 5/7] selftests/mm: fix child process exit codes in
 ksm_functional_tests
Message-ID: <20250816144322.nh7qwwfiuhnjp76g@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
 <20250816040113.760010-6-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816040113.760010-6-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 16, 2025 at 09:31:11AM +0530, Aboorva Devarajan wrote:
>In ksm_functional_tests, test_child_ksm() returned negative values to
>indicate errors.  However, when passed to exit(), these were interpreted
>as large unsigned values (e.g, -2 became 254), leading to incorrect
>handling in the parent process.  As a result, some tests appeared to be
>skipped or silently failed.

This is because "the least significant 8 bits" is returned to parent, right?

>
>This patch changes test_child_ksm() to return positive error codes (1, 2,
>3) and updates test_child_ksm_err() to interpret them correctly.
>Additionally, test_prctl_fork_exec() now uses exit(4) after a failed
>execv() to clearly signal exec failures.  This ensures the parent
>accurately detects and reports child process failures.
>
>--------------
>Before patch:
>--------------
>- [RUN] test_unmerge
>ok 1 Pages were unmerged
>...
>- [RUN] test_prctl_fork
>- No pages got merged
>- [RUN] test_prctl_fork_exec
>ok 7 PR_SET_MEMORY_MERGE value is inherited
>...
>Bail out! 1 out of 8 tests failed
>- Planned tests != run tests (9 != 8)
>- Totals: pass:7 fail:1 xfail:0 xpass:0 skip:0 error:0
>
>--------------
>After patch:
>--------------
>- [RUN] test_unmerge
>ok 1 Pages were unmerged
>...
>- [RUN] test_prctl_fork
>- No pages got merged
>not ok 7 Merge in child failed
>- [RUN] test_prctl_fork_exec
>ok 8 PR_SET_MEMORY_MERGE value is inherited
>...
>Bail out! 2 out of 9 tests failed
>- Totals: pass:7 fail:2 xfail:0 xpass:0 skip:0 error:0
>
>Fixes: 6c47de3be3a0 ("selftest/mm: ksm_functional_tests: extend test case for ksm fork/exec")
>Co-developed-by: Donet Tom <donettom@linux.ibm.com>
>Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

If so:

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

Thanks, I am afraid to make the same mistake if you don't point out.

-- 
Wei Yang
Help you, Help me

