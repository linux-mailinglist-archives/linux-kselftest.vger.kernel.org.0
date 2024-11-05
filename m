Return-Path: <linux-kselftest+bounces-21443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A849BC513
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 06:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA5B22096
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 05:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937561FE115;
	Tue,  5 Nov 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+M44il+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807D1FA275
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786132; cv=none; b=DPc1B17lgT5VoYV0/yrog/nenP4RpKGyUfQ1b6MUoUZsGp/UjFR8jcHmcud5m8DchbGPSrVndNEhlKx+mPP22Vb6DJavIpMannzY/ih4ygaVDddRQnNBWBCXQ0PhInHl3jKzLu9xd2cHjOBHFZEERtt1pQ/JmRuwr3OQoN2XmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786132; c=relaxed/simple;
	bh=EM+nXUdvDCm6N3UmMRTXiFNomsft+6ngsfGryxa8oRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SkQSl1IcrWmf4e2OO+CyrZ3tb1m08TLuMwMW47LMUnXoqpOfE7VquuU8YMvIh/uSTU3pmLw/7Rxa9aZ2G5icNIODCh+6u5MktiCce3yaZGs8+8jw904A3JQ3t+eS89OBE1iy0lbLTIEl2AUBlW0A6CpdOZIh78GR/bAXzex6RIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+M44il+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20d54663b3fso51906915ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 21:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730786130; x=1731390930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwQ41DxPwHg/LBZhq9U/e3vXFnxJog0O/oye+eR+OCc=;
        b=e+M44il+sxOWb3DmRtN9R8gggYSFTLNOR+lm+ljnfO7pl9eMdZH8lVD22xu0zedewA
         gJ7p7C/zI9b2eWUBX/VgyyUY/tBFqldpZlyCZLPC7cs/l88LAOpv6at9uWm13EMgaSgQ
         ZE8i3YewAFOTqgVVYmrwqlCYS/LRmhii3/IGsL/W4nqc1tH4jGVrcIm+9ovWcJ+5sW1m
         vQC5X3+xZtatRbZ0+2obNGtKcLsDMAnS9JlPDHosx+egc/WAdO5WN8Hxe9wA2i3WiX9J
         7UWzUgawIdn6XaFN1K/YD09h2bnYGs3mdS7BZLB7wv6QVqozNYiI4p0V/KZAhVu9oCUA
         tIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786130; x=1731390930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwQ41DxPwHg/LBZhq9U/e3vXFnxJog0O/oye+eR+OCc=;
        b=n2SknDsjQo/EnHa4x+NmABj3kL52vuWEUYXjN/uJCxO/3YKZ/deNsfzqdxY3Fq3ecP
         zpYk7AlMtsM+S+xdCMXHijNTcooPWBb0muTxCCjxZe5vbKRK6zqtGyKGt4NV1bV3NaZ/
         vbq3/7Fz9pKiiDvNdrz57+WjC3GZrl4O0uP3z8kDB+6UwmSaLSGJtc4+dk30kn9woLT+
         i91WkTMDoGraazWPg5Jc2cnxFOJCqmini8mzZCaqLXCjDyvDsaww5UWfC9Zv0r6RgVzo
         p5pN7OfSQ/HLOKajkFG0FfMLMc5YdkYFSbOjm6Rvx4QaBAN537Xr4d8i9JGArTx7E44S
         NPUg==
X-Forwarded-Encrypted: i=1; AJvYcCVkQynAcYbVwQVogUndFCtXT0OqfvcMdy4Zdkjg+Av8Q9oo76xMSFw/gECz168CiuU/Tjuw8XnEK4Ammvdf3s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxoCCtQzrRwCx2Xdl6x10T2VBPsvaiPIsf9/2MC+r/iFGZSdg
	VUNcVMJuyL/9HADwgukVFk8sxCEL4ElMrB5mM999xVYZqx1bF1cEbPhr5BwskGk4BzzxhnK3BZ6
	rFQ==
X-Google-Smtp-Source: AGHT+IEuUBIfr0pmpR1vDVKnUKE8uRFFxdiJcuGz5MS7Q3zeXILMN/DoM1JZEMxM44JWZ8BW2DwV5M3g8tM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:f681:b0:20c:ce1f:13b6 with SMTP id
 d9443c01a7336-210c68cf3b0mr1015755ad.3.1730786130327; Mon, 04 Nov 2024
 21:55:30 -0800 (PST)
Date: Mon, 4 Nov 2024 21:55:28 -0800
In-Reply-To: <172848588854.1055233.16718265016131437325.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004220153.287459-1-mlevitsk@redhat.com> <172848588854.1055233.16718265016131437325.b4-ty@google.com>
Message-ID: <ZymzUI3HnkYMxyjk@google.com>
Subject: Re: [PATCH] KVM: selftests: memslot_perf_test: increase guest sync timeout
From: Sean Christopherson <seanjc@google.com>
To: kvm@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 09, 2024, Sean Christopherson wrote:
> On Fri, 04 Oct 2024 18:01:53 -0400, Maxim Levitsky wrote:
> > When memslot_perf_test is run nested, first iteration of test_memslot_rw_loop
> > testcase, sometimes takes more than 2 seconds due to build of shadow page tables.
> > 
> > Following iterations are fast.
> > 
> > To be on the safe side, bump the timeout to 10 seconds.
> > 
> > [...]
> 
> Nice timing (lol), the alarm can also fire spuriously when running selftests
> on a loaded arm64 host.
> 
> Applied to kvm-x86 fixes, thanks!
> 
> [1/1] KVM: selftests: memslot_perf_test: increase guest sync timeout
>       https://github.com/kvm-x86/linux/commit/7d4e28327d7e

FYI, I rebased "fixes" onto 6.12-rc5 to avoid conflicts in other patches, new hash:

[1/1] KVM: selftests: memslot_perf_test: increase guest sync timeout
      https://github.com/kvm-x86/linux/commit/2d0f2a648147

FWIW, I am planning on getting this to Paolo in time for -rc7.

