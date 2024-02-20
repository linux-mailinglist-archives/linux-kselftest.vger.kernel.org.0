Return-Path: <linux-kselftest+bounces-4992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A109A85B0B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 03:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521881F2290B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E33374EB;
	Tue, 20 Feb 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Suls8slr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686563B2A2
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394631; cv=none; b=UfGmqVR/wFTmQYnIxgaRydNJOx6egOwptzaX1cxbRIDQBrPiKw4KNXzuWWeGa+Lqz+ktuMgQJf6Qs2qvnU9RmO6jc+hr9iyJbxxVha/pNXg+rdIQoyrc0LeWJj2QYwPhkEjuUtklLW3Sbu1fVmHJtQ+mlC6nRbIbZ310/Y77Xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394631; c=relaxed/simple;
	bh=tl0G24XOjbGzUHwVuSKAML2L5w2w/ukL5jhI0xL8Wbk=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0GXdL/PGx5hIROnSNdFoJe4Cf22FVFo9CYuIDr1pMCcNSBEwSx6v/a2QxfjDZsQwQArN0ysWJxxbwryuN8+ELxoadgxr4QbgZEbbt28xFG6Qo01rRIkyUgwRPpYYpyqA6vaVBNizqHh44NetBq2I0gMPQJc3W+VHqck8UmtT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Suls8slr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7232dcb3eso26222155ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 18:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708394628; x=1708999428; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut8HYrvCDFac0esrbFqk2cfgA544kkLlPQaAT6Wttz0=;
        b=Suls8slrlKu1GWrkWeiJyMMq8d8OmJjG4HQRDqGKkDxCGvnQXj3NkpLK8YeFHW7jhR
         AAgjw2yso4yD4zEgGmYJfcDHbqiouKzolEOKeB9Hpxwi19d8pL2q8lCXZca3vncoL3SQ
         k1hTGX6ajH2IjdKm0iQkpPvFirt5Q8PlGudv6VB60Whz+Po+CFzEzUCM9fOo5UdvTl46
         /WqgZXqtFBCVds2NvymzgcVNOQjTg/hfB6M8TJj69Kh9PyDrR2Elmf2U9h2Hl0j/gZpQ
         F6wCGVVpNXxcahTQO8wAAuZ+Rk1Z1zsipM4+hqxCKo7TiqlZofPkHZXHt+ViOklVfoLN
         dfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708394628; x=1708999428;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut8HYrvCDFac0esrbFqk2cfgA544kkLlPQaAT6Wttz0=;
        b=diGCFc7QCgZ4U5RRIKNNJDScQivL6g4ecl2i1g9gNDtQK0R+1fqmOtDZuRmHoebG7g
         hwnKK2RFU6arJSjXZ/98v3StTbUHlx+goT3q2FnOeQDzcT/T7SqHDQiKiguM4uApft/6
         L+a/jpXfSZOQvMi7Jg4/1STQqlLZpDLPr0ky8+BZyIrhnnDTGkIws30E+KxvvH2O+It/
         cnty1zwTJeZEwytIStW29czc561RdYkk3rZAKyGb5dto8rfwKmYNnStHwm8XvLbzFopn
         UDKfqFAMbEFSSRet/zHWfnm0rdlaOvPIc+JQqrevg4Q+zbbw4by2FRq4LZ1/PGURGBV2
         +Apg==
X-Forwarded-Encrypted: i=1; AJvYcCUzORSZjPpKQ9i4jtRBw/AM9g2ihLGdZnBKUg9IKscQo/RJJYYhq9OsnnRDIA1Nyr4Zg1VxVGIff0DhkRP36wSnrk/HWVgFqw5wtsmqOP7M
X-Gm-Message-State: AOJu0YwtEVULraOBUXBgSfNa7HoohD+gww6ClVk+xFbsLYoLl+kwX6JD
	hIshXVBe10sgr4ELVv4Pb7X/dTq3Aa3DnJb6uQMvOk/TCotpxIgUJgUyAloSTXE=
X-Google-Smtp-Source: AGHT+IGPIHUy8hPqScHiSoGgxRjrCJE9JJnAWETOMrecbYtciaMsbgwu6AZ9cPzFGRlUwvHmQwNF1w==
X-Received: by 2002:a17:902:e5c3:b0:1db:fcc8:7d96 with SMTP id u3-20020a170902e5c300b001dbfcc87d96mr4258933plf.14.1708394628501;
        Mon, 19 Feb 2024 18:03:48 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:a328:9cae:8aed:4821])
        by smtp.gmail.com with ESMTPSA id kg3-20020a170903060300b001dbbd4ee1f6sm5058425plb.11.2024.02.19.18.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:03:48 -0800 (PST)
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-23-c9fec77673ef@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 23/38] arm64/signal: Set up and restore the GCS
 context for signal handlers
In-reply-to: <20240203-arm64-gcs-v8-23-c9fec77673ef@kernel.org>
Date: Mon, 19 Feb 2024 23:03:46 -0300
Message-ID: <87zfvv7uyl.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

> +#ifdef CONFIG_ARM64_GCS
> +static int gcs_restore_signal(void)
> +{
> +	u64 gcspr_el0, cap;
> +	int ret;
> +
> +	if (!system_supports_gcs())
> +		return 0;
> +
> +	if (!(current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
> +		return 0;
> +
> +	gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
> +
> +	/*
> +	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap...
> +	 */
> +	gcsb_dsync();
> +	ret = copy_from_user(&cap, (__user void*)gcspr_el0, sizeof(cap));
> +	if (ret)
> +		return -EFAULT;
> +
> +	/*
> +	 * ...then check that the cap is the actual GCS before
> +	 * restoring it.
> +	 */
> +	if (!gcs_signal_cap_valid(gcspr_el0, cap))
> +		return -EINVAL;
> +
> +	/* Invalidate the token to prevent reuse */
> +	put_user_gcs(0, (__user void*)gcspr_el0, &ret);
> +	if (ret != 0)
> +		return -EFAULT;

You had mentioned that "ideally we'd be doing a compare and exchange
here to substitute in a zero". Is a compare and exchange not necessary
anymore, or is it just being left for later? In the latter case, a TODO
or FIXME comment mentioning it would be useful here.

> +
> +	current->thread.gcspr_el0 = gcspr_el0 + sizeof(cap);
> +	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);
> +
> +	return 0;
> +}

-- 
Thiago

