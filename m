Return-Path: <linux-kselftest+bounces-25946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3679AA2B493
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 23:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6A016667F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098522FF32;
	Thu,  6 Feb 2025 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lgMqS8Fw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FB22FF22
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879129; cv=none; b=VAG8VYHL6Y3Mm16ZaaUgvIZ1qaMgJO0FTvwbXc5zvvX3z/ArJ8K99vQvMZZRoRayDqqvKYR1amDoaBZB5JENgP83gEoz1a0QMPg1k4blObiuDSX8GYycybODyvsJrB41g15J9lKHgF9Zhkkqi1Aj9TCooc4NPx2BiLJg5fUWGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879129; c=relaxed/simple;
	bh=PVuzEWiWGdU7/bhxXLzVugnQB2A6Ks+SP/VbQvRNZKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmfAgrqjGvKtvjThf+t2xAmeC7rFbcMmuUflcUgOLHXNddqMTvNlpk14vN2vZ25mtuoBjgh6RKQfuxwH7gZQjmZXAkdDoLB5NJWcdVKtNR0CB1yx/EZL2FCeQIyMoVPhES4wRpFncq22MvtEi6EYeWtsCYikXqEQp0qbiSQUIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lgMqS8Fw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f48ebaadfso13784905ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738879125; x=1739483925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9pEwEvQtMTht7p8WbC44bsRYNPMffSNDG4Pb5DVy/U=;
        b=lgMqS8FwYX9xWhM9kSZPql3Crx1UAQfys1VbpOJ3051C/p7QGVizCiPRKApgoLkAuR
         G1uHSk8GqayOBHbRg6VSPC5T/Ohvh5WHd+eQCimgke4rn5AytLk1I6IMf1UPVOyxRmBs
         nlz+hqo2I+H0DyWTcV6D4L5cwDE8aoWwp75bgiYDkHwWjbOpDS7Dbl+SnXeedEDRwUjZ
         9z3hq1QkloPVTh0K7qF8ICV8IrpZb8W+bvUCLsmNYUhKjhfGcSqaOIM06t5ZTQOoPRls
         d0ZD7i9Cpyu5kQRbVYyU246pK4CGvPklWVtDh/zqYT48ER/fGaisttKZ9futu9Tkqm8+
         Zq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879125; x=1739483925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9pEwEvQtMTht7p8WbC44bsRYNPMffSNDG4Pb5DVy/U=;
        b=RbpDc9IB88NDB1vPwM+LGPBNoXnqy+DYE5WS8tfhOtC1iBH1J7BRGFflR3iylAzGSp
         0q+FUMrGkDwmcJm66p5QdUWXUWIh8rRVwvCyFcZvo1EiS05EbXg/9WtZLgRYpcv8wuhF
         geJ5c7L/sqI2mSPn2ms1EHwFqSpWP1N6kRmspj1sCri6qRt+C4gOedCkZvtKR9FT9IF3
         sormtopIoghJaIxHHcZBu6L85fqETA0ydVaVIqeDH2YWMbscg56fnADsvpKc3p18kBzN
         1BljpsJTPbrTQ3IuWInHF4yaJyI8Wl8etIzqPRXELmkQZZIdXW+FfKIRPkPAmyplA/vZ
         7Hag==
X-Forwarded-Encrypted: i=1; AJvYcCX5x6MxJJGkqVNTx1Hypru6VH3PMAO7OPVJaMjw6HpLrJjOBsz6hfmQ07/c9rbozZjRQH4AUS7COMqQ7wfaPL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8jXQ8kfcVBaavmyQbgUpZ+KE1RmMJteJX3Jf2O45qJ93alo5
	XM/sk2BgM7T0wQ++yZ2yCvxtFIRH1wLc3TyRqzhpKO9ShpRfno5xHwZPzD7qfaw=
X-Gm-Gg: ASbGncsE41mGnaBhf418IQpqFAJij8KERX1CqD34nLm+fWMLon9xhIsMG2zPOC7LPj/
	K7PAdbY1eAQvU+zDi3Meon8gMWOF40rTaBRrpsA4628x+8ClC+N+iycGMR2s1icGevvFPunU5+m
	iA4Mc2kG6uJOqGZlocfPVrWe42iVZSqJC5PKf5BHg4FQNbKoCNm+Rk/U5k13JqzrlL6IjD5/rgN
	s0MCMGkQlOkBKSUVVW8Ctqe6m9SsdUXEpuY+hWM4jhyyBKmLL2itKWBI4gibQKK7kxkzGumhkCU
	bJhLAdcYWdS3SsZzRwky/jVXAw==
X-Google-Smtp-Source: AGHT+IEAeZdlOSa7aDkaxgunF100sJqK9vORD3h4QNYuoNX4V7Q49nJIgyQHGUMHbgK5Pow0L8i/Ig==
X-Received: by 2002:a05:6a00:228d:b0:726:41e:b310 with SMTP id d2e1a72fcca58-7305d48010bmr1263832b3a.12.1738879125283;
        Thu, 06 Feb 2025 13:58:45 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7c24sm1765047b3a.78.2025.02.06.13.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:58:44 -0800 (PST)
Date: Thu, 6 Feb 2025 13:58:42 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFT v14 2/8] Documentation: userspace-api: Add shadow
 stack API documentation
Message-ID: <Z6UwksPkdwb5DDcK@debug.ba.rivosinc.com>
References: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
 <20250206-clone3-shadow-stack-v14-2-805b53af73b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250206-clone3-shadow-stack-v14-2-805b53af73b9@kernel.org>

On Thu, Feb 06, 2025 at 11:38:04AM +0000, Mark Brown wrote:
>There are a number of architectures with shadow stack features which we are
>presenting to userspace with as consistent an API as we can (though there
>are some architecture specifics). Especially given that there are some
>important considerations for userspace code interacting directly with the
>feature let's provide some documentation covering the common aspects.
>
>Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>Reviewed-by: Kees Cook <kees@kernel.org>
>Tested-by: Kees Cook <kees@kernel.org>
>Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
>Signed-off-by: Mark Brown <broonie@kernel.org>
>---

Reviewed-by: Deepak Gupta <debug@rivosinc.com>

> Documentation/userspace-api/index.rst        |  1 +
> Documentation/userspace-api/shadow_stack.rst | 44 ++++++++++++++++++++++++++++
> 2 files changed, 45 insertions(+)

