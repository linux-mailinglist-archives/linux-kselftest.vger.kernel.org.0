Return-Path: <linux-kselftest+bounces-27785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0844DA484A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADC53AF009
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7C51AA1DA;
	Thu, 27 Feb 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPf5znqq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218C1A5BBC;
	Thu, 27 Feb 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672857; cv=none; b=q7aSxSjTjN5U3YobXLIjel/Yrz9tN8PpHDT2FqQ47wwG+7dp5jg2t2yyS4pBR7t1GObcspkpIXjl4waqbMFAyPiSledN1T5KjkihM48BeqP9HNG0iKeR7HhjwiwP+I1ndW9NeJBEqx+7d296ml9o+amkM7IYOud3mt9Vp4e4BHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672857; c=relaxed/simple;
	bh=xjPwITNH7+ilrCrjqvms3FCSS3zQDyqwi+pfjCjZKy8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KS/RrwQRtw6GJIAGtDY2hwDzm3QXtcz4UJUzmr0fMitQ3B+5/AJa9SDcpOZ/gJjdaws+wpEcfPWPWwBeNL3g9bxR3j7oJUJCOebWdTMp+i7KNxJoqabPT/YDL8fGPMOAN8gEUU7LZRDa+6K8I//XA5KXTO6bdzP6ZgkRobt0G6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPf5znqq; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e41e18137bso8802996d6.1;
        Thu, 27 Feb 2025 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672855; x=1741277655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24tBlE0SjiGtrbKYq2EJ0HJHTRtUk/7GcqOiEwUKJXc=;
        b=NPf5znqqhyeUxcGNp6rUQhej3Jwu0py7gcZJWoVDF7CTCsRKXHj2QXL+tiTlMDObSH
         Bz+9vFEreoBSarHX3Z3b4EYuwmgqXhZQpRfPc7xLj6nhRJ3Tk45pTrxDh0VnIbFsxest
         caPSMJJb4dN45qw2MpDXrAPaH8L7xmWid4oNprk5gLT1ACBUdV0ZUmsqYj74Grb3lN31
         0IpRLakYdLuhZH2XpVp4DPIJwklDhBY5Kz5vJw79YFLxtZEbDMHIagFYKkVdVmIdO9yb
         KJlnQwWhNrvQHc4R6oTb5q1CeAW/L8PbtslT6ra1AKGW6Y9cQ4t7n1FdTvAb+xdAEsUT
         EKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672855; x=1741277655;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24tBlE0SjiGtrbKYq2EJ0HJHTRtUk/7GcqOiEwUKJXc=;
        b=RUjBhLi691qBbat1M8VrHRPzf2k+8BlOWwk5I6+hDBMZv5EvP0BCbKbE3PCZriIKO9
         JIEdAlNalT66yDutMSBuCWBODOTqUV0uzjsi6gvbkWk/J6zVUz+Z0jmUhVCmhfmo/4pW
         pu1VefL4wwiXEWCW9dVPQilp70HwBI4MEsdoviVJILUde6b4qXdtQG35F2IBCNWEzX69
         j1+aWGFs7CxjOvqSoH7FKkLrVoi5nv0UoBTMYHNyksh5X+4tVklm8cU35wYASJRgV3nQ
         TxtuEC1wu3jmDThYL2rg2kurcbs9k6lvIojuv8AXA0DSlke5rzeOLEyQb4vzbsRSnB3x
         mxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPcm7nnE7pIFwAnuNgO6CL0dlNyyvJMtgXMQ4aUY34rVPMKZfJyQjq8f4YX/VuNEt4cNJmjDZc776uhzc=@vger.kernel.org, AJvYcCWS4/gONKPZ+zGXfBCJdLcYiBZpDjtBW6Vfqsy16NB53ekWZ1JLMjfIMlrTRLKTVL1cSdTaddwkjzzlo285n1Zy@vger.kernel.org, AJvYcCXXrw/oh2zQ3cOE69/lsv4uPI9GX4ip1Feo1sa9hLdasMMvq0LpdoLZYqMa5jqY1Xo2mYDOcUX9@vger.kernel.org
X-Gm-Message-State: AOJu0YyGjLk8dilo+A+lT5+2TP6MHH6hr5KivIyY8QGYpesRYP2fQD5/
	OucYNYSZ95yCpngLewB/OsyM6w383NdH/okSL62rKuwso9TGIdIe
X-Gm-Gg: ASbGncuc0kcRjamzrkgynQkgZw0986F2gmpR704Bs0Cq85WsoXbFj6OT5717Eb3i/it
	8KGLzlwCM3fdJAAcpFs8UZbrjM9DMcm9kA3gxFZuFlJCe83djNKQAc5ZJZELkMEHQAxqZDTxHFq
	Cl5BzMOUuIhktcZJLkM933Fr3zCrotiag4F3aKJ0uHlLCv49a6TMM2/9fl3tNOxZklFOur4bsK0
	DBKJ9FLYe8zz/nurQuuGdaQV2Liu22LWEp72T7LpthoPgc068cBPbApeB9Dq9VmP9fXFPg0bf60
	EzyaDMavMUFqQST+PwTW967dj0uqWmJ8M53bOskYnOKnZEVzehg1K0BqIUGXD8ryuLfu8NrWLZp
	tODw=
X-Google-Smtp-Source: AGHT+IEJu4vloD9rj2kOOUuk3C/htCmuMUCZeR17Cj5CrXzt4cKMVQSg8k/DVcyp3lCVS27qzQf8Iw==
X-Received: by 2002:ad4:5d4b:0:b0:6d8:b371:6a0f with SMTP id 6a1803df08f44-6e6b01adbb2mr356197126d6.31.1740672854455;
        Thu, 27 Feb 2025 08:14:14 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec3absm11206356d6.122.2025.02.27.08.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:14:14 -0800 (PST)
Date: Thu, 27 Feb 2025 11:14:13 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kevin Krakauer <krakauer@google.com>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Kevin Krakauer <krakauer@google.com>
Message-ID: <67c08f55b0ae7_37f929294b0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250226192725.621969-4-krakauer@google.com>
References: <20250226192725.621969-1-krakauer@google.com>
 <20250226192725.621969-4-krakauer@google.com>
Subject: Re: [PATCH v2 3/3] selftests/net: deflake GRO tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kevin Krakauer wrote:
> GRO tests are timing dependent and can easily flake. This is partially
> mitigated in gro.sh by giving each subtest 3 chances to pass. However,
> this still flakes on some machines. Reduce the flakiness by:
> 
> - Bumping retries to 6.
> - Setting napi_defer_hard_irqs to 1 to reduce the chance that GRO is
>   flushed prematurely. This also lets us reduce the gro_flush_timeout
>   from 1ms to 100us.
> 
> Tested: Ran `gro.sh -t large` 1000 times. There were no failures with
> this change. Ran inside strace to increase flakiness.
> 
> Signed-off-by: Kevin Krakauer <krakauer@google.com>

Nice! Thanks

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  tools/testing/selftests/net/gro.sh        | 4 ++--
>  tools/testing/selftests/net/setup_veth.sh | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> index aabd6e5480b8..9e3f186bc2a1 100755
> --- a/tools/testing/selftests/net/gro.sh
> +++ b/tools/testing/selftests/net/gro.sh
> @@ -18,10 +18,10 @@ run_test() {
>    "--smac" "${CLIENT_MAC}" "--test" "${test}" "--verbose" )
>  
>    setup_ns
> -  # Each test is run 3 times to deflake, because given the receive timing,
> +  # Each test is run 6 times to deflake, because given the receive timing,

Only if respinning: this was always imprecise: it is run up to X times. But
exits immediately on success.

