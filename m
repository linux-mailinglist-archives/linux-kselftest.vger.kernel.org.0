Return-Path: <linux-kselftest+bounces-40342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BDB3C3DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 22:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9742A60538
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 20:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067CA34572C;
	Fri, 29 Aug 2025 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9xPX+it"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5F2737EB
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499895; cv=none; b=BqRgzj0Gz1o8EPTnOV54xBK8SCu2EPHqlbGzgdClOCjyDqzVEs3S+evk6/aOzkYRHA8k9x/VpVi+ZdjDC4jaSdiFQD32n1i+bZVxuB+nWk4oexohNkC/tmF47Yx0obQm512X5urqnq157WyZr0Vho+3HvAl5mj3mMpXV789To1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499895; c=relaxed/simple;
	bh=TdNF0rfgV0VHRMX8IeG8YvWVl2OWePe9R39tCBmM5oQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cwLr3EueDK8ktDS066oj+ETs5sP6aOyYN7Y+aU/+7RDVBI+NsF2tlQmp44tlU9tk83X6wHDZ8EduBp6qLYBCBHmT3EzYbFiwygb3G6d2nxlZRHh5i0S+UQGBp9E0BcGO85pfAhrDYJx+FiFVNh008g1GX+5mEEUI6oez2TSvFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9xPX+it; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-327706e0642so4077238a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756499893; x=1757104693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd39rUGECk+rHT5205Jy1pAxAHPTjmOemrBZEd3ePt4=;
        b=M9xPX+itjAX4pcjD1NhjP3RlSRpLs5F3945x47soaDOJe2Y6BFfNufZr0xNwPVV4eN
         cGrRsJOT/nTHF44By61fVAg2+e1/3i8N6S39M+qY1dHalhxWa1CoczUfHa6vswkVTvOf
         /uhUSnOvQfcYmvux5LDOtn8FBr9rMz1xjLbh7YzCvhuoMjJUJGt3+Xin7x83yFJyQSL3
         ELXyS+jkTxHizH7KPixgm0WxMOIjZ/YMi5dM3gZTTzJ5AmfBNYLAlC6FHSfcElhANQUV
         dP3k6NkVetxwKogHlzpR29NnSaPUZu4MFnwrOxNvi2Jd62JrCyz6+WJ2Y6t/T+sfrf48
         bnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756499893; x=1757104693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd39rUGECk+rHT5205Jy1pAxAHPTjmOemrBZEd3ePt4=;
        b=U0s0y8wsvTwsboDSRPh84wfQlZs79SCdNz+HAWtDHBg6OXepSMg5jSLLASUhLpX4S/
         +1I8MgmZi8z0WYF6bdrKakT1OtcU4Vz++vsq7tVRI748iS6RyROPIhpyFA//56bZoIRK
         WknkQAcuXEQgseNVjvlZnPhhbQ3P9IwfLc2biah+C3YtuoG9gJLDDFSjit0DE8ftuTs2
         tIGTonM6S5WXeb9UnFUf69eMqsZIedrSyz1C/yDuu7QAAjSdzU3bd43IxPfC2wd2mWF9
         wg+X8vyH5tjWVp9WeF+HryqruDI/cbq56jj0KdKfesGwkM0ZOuF1d7b66r9M9B9vwxPD
         xcDA==
X-Forwarded-Encrypted: i=1; AJvYcCWN6bZrnvuZzrGIg2au67PS5IRona2ufji7dI5N7ri9yGt9eXVal/b+6fPmYevDxoXPC/pKvmoMVIdkIBiNdFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqcE8mcMhaGOKxmvtdu7MW7Aehloou4J3GT8yFr7YtHvm28yG+
	A7/4H7SfYzETcRTKhfPFkZiabVvIix0ivKAMMOj4xVn4MkbzUql/7hzSB4y21xwbnrXVaeiLH6l
	O81M9VQ==
X-Google-Smtp-Source: AGHT+IGbRKcpJtJXxkGfMF7qVHfw+rJ15N7Av9i4B9mmR8F5Rd6/k2vtLv3vdjeoQhg79ZK6pefzoikNRho=
X-Received: from pjbpm11.prod.google.com ([2002:a17:90b:3c4b:b0:327:7035:d848])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc6:b0:327:96dd:6294
 with SMTP id 98e67ed59e1d1-32796dd6549mr14897061a91.37.1756499893148; Fri, 29
 Aug 2025 13:38:13 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:38:11 -0700
In-Reply-To: <20250829142556.72577-6-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829142556.72577-1-aqibaf@amazon.com> <20250829142556.72577-6-aqibaf@amazon.com>
Message-ID: <aLIPs7eqA_i75Bgy@google.com>
Subject: Re: [PATCH 5/9] KVM: selftests: Prevent PAGE_SIZE redefinition on x86
From: Sean Christopherson <seanjc@google.com>
To: Aqib Faruqui <aqibaf@amazon.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 29, 2025, Aqib Faruqui wrote:
> Prevent PAGE_SIZE redefinition warnings that can occur due to namespace
> pollution from included headers.
> 
> Add an #ifndef directive before defining PAGE_SIZE to avoid redefinition
> conflicts.

Please provide more details on what is causing the conflicts.  Blindly using a
PAGE_SIZE without _knowing_ it's aligned with PAGE_SHIFT and PHYSICAL_PAGE_MASK
is far from ideal.

> Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
> ---
>  tools/testing/selftests/kvm/include/x86/processor.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 2efb05c2f..3f93d1b4f 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -368,7 +368,9 @@ static inline unsigned int x86_model(unsigned int eax)
>  #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
>  
>  #define PAGE_SHIFT		12
> +#ifndef PAGE_SIZE
>  #define PAGE_SIZE		(1ULL << PAGE_SHIFT)
> +#endif
>  #define PAGE_MASK		(~(PAGE_SIZE-1) & PHYSICAL_PAGE_MASK)
>  
>  #define HUGEPAGE_SHIFT(x)	(PAGE_SHIFT + (((x) - 1) * 9))
> -- 
> 2.47.3
> 

