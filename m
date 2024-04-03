Return-Path: <linux-kselftest+bounces-7108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612A8975ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E881C21295
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0C7152527;
	Wed,  3 Apr 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icAdKWSy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CAD152502
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164051; cv=none; b=jg1I/o5FcR+EZG7659RwvjJ61MqdmED0WJkjSvEcyqQD08JQLys1drXMCgBUskUWaaxKnw3TOLIncrtUyj8TDE1QkikjILR8R+twGeCq/c/dLJUTL6a7Lh8Q+eB6+dSQ6Lrk6Sd2wrsnxFAm1ZqAEHOlCkLuqg/SD54G1Gbs4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164051; c=relaxed/simple;
	bh=gX73Fd71Hr9LdsAlOuJUtvzibpHcNhprefVg3paVgDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2x9Tm3/UNaw4Ir2DQ0zEpzmzjUQzNtj9FWNInjXtV4b/l2G2VTqZDhbO1rbbSjTVLMFTgdvQ+PHss273BiqGrL1b9k+YVCR4QV7XftzMFtnYTaJ/15SpDow5fdCTXSFnO+zW9k2W4be/cq/+qDz4KPTS78Hofs8P6BZt6/Fe1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icAdKWSy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc8d4e1a4so1116937b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712164048; x=1712768848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XE+PG9zC5omixfQJghjjzCZLVaoeIvGmD0Or6PABHlQ=;
        b=icAdKWSyvRSCf9tjeMZICzYfOPKdz7214hlszOGzL3yil1XhYOI6qzpm+L5C/GlbgU
         HxmMQ5p2emVaMg8FcbzMm6pP7bW78qD+Fq2q7Hz8wV46dD82aR3fxYUMHwPdB8pndLtv
         mC6NW/gk6qcTmiY42o303NuW8am9UoAB6C7b5PSMS/J/NqMXzC2gDiORn3YKbzpc0A1g
         nMmj5abcLp0OPXyK/6TXRpk4juXZl8ITDpsqTdWMHxFiKqZ4A3jzPV8l4a/Y7L1t3vdh
         Ev2jE1BXQzb9+0PXKyzuiMhzEoW6qj496yA8Va49UXaAq2MjZPFEgO2rrqfQbZpb1MjD
         EMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164048; x=1712768848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE+PG9zC5omixfQJghjjzCZLVaoeIvGmD0Or6PABHlQ=;
        b=QGZ+vne+w9APXJUNMVXZF7+QM42/DPZEajNB7eRP7KR3MX1MKelppvQXocTzl2fKfM
         PBNan3+kte//+mXnjzW8RjNPxSW333kqb7sCkbkT0FYQafFJCBAjQowHRyOONz2d6aES
         3wxQ1zW5oSFQ0F7Ay1Ho5hRP37XNqqCU+KhddkNk/Nd/p4EGxC050ZuwqTSEb21Zujw7
         5McNkqOh4EEX5Sh3mR73cNc9lmc0ePrScdaaHl0mPky2q0jWlzsD3CofC1QIbtF3d8Ng
         TWWOkkaaH+AG5bHfcuxK3Tss+qGbdqdWG2Ju1cPkQn5orDdlsDUODhk4lPgaXWsOj50n
         xecQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcd9kG8EzdF0FmtVQtRjhX8vbeG6quLoSqENGg2BqGsF9N7zbwM1Vrdbs9lS/zGWw3P/TRCZw8yI9/UO9WSOnZo9YNK03hBjZNUk/O3DjY
X-Gm-Message-State: AOJu0YypY4KVFICPjjgDXj0PFJ4DxRIf/GjQcBRtJTUD8tISqLmeBB80
	m97j4LwVs8RMSgoHuiLwl8q27/3/Iv9fi3IGmtE61a+MUlb1u73aGeK2G+tBFhjtbocDSG/I5RZ
	dQw==
X-Google-Smtp-Source: AGHT+IGJ6fjY3qPzfcuQ+Uj01adGJDcVM5deoqEJfvQ1/h41CQ3qzBzMvVGNTIzpPWuDCJzxpn4gGWghwiI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1005:b0:dc7:48ce:d17f with SMTP id
 w5-20020a056902100500b00dc748ced17fmr10456ybt.10.1712164048738; Wed, 03 Apr
 2024 10:07:28 -0700 (PDT)
Date: Wed, 3 Apr 2024 10:07:27 -0700
In-Reply-To: <20240403164230.1722018-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403164230.1722018-1-rananta@google.com>
Message-ID: <Zg2Mz5ZcF6cO9Ipr@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Fix build error due to assert in dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Sasha Levin <sashal@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 03, 2024, Raghavendra Rao Ananta wrote:
> The commit e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in
> the dirty ring logging test") backported the fix from v6.8 to stable
> v6.1. However, since the patch uses 'TEST_ASSERT_EQ()', which doesn't
> exist on v6.1, the following build error is seen:
> 
> dirty_log_test.c:775:2: error: call to undeclared function
> 'TEST_ASSERT_EQ'; ISO C99 and later do not support implicit function
> declarations [-Wimplicit-function-declaration]
>         TEST_ASSERT_EQ(sem_val, 0);
>         ^
> 1 error generated.
> 
> Replace the macro with its equivalent, 'ASSERT_EQ()' to fix the issue.
> 
> Fixes: e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

Just to be super explicit, this is specifically for 6.1.y.

Acked-by: Sean Christopherson <seanjc@google.com>

> ---
>  tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index ec40a33c29fd..711b9e4d86aa 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -772,9 +772,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	 * verification of all iterations.
>  	 */
>  	sem_getvalue(&sem_vcpu_stop, &sem_val);
> -	TEST_ASSERT_EQ(sem_val, 0);
> +	ASSERT_EQ(sem_val, 0);
>  	sem_getvalue(&sem_vcpu_cont, &sem_val);
> -	TEST_ASSERT_EQ(sem_val, 0);
> +	ASSERT_EQ(sem_val, 0);
>  
>  	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
>  
> 
> base-commit: e5cd595e23c1a075359a337c0e5c3a4f2dc28dd1
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

