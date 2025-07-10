Return-Path: <linux-kselftest+bounces-37051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4637B00F48
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 01:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21DA542068
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 23:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F222BEC31;
	Thu, 10 Jul 2025 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLOacKNv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA872BEC3E
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188970; cv=none; b=a/yfm3LjyZU93pOQwn+ZhhQM7Q6Qrhzr5unU0DHvHNEb/I/RRpVe7Qqb0rfHNczXOmy0A/xo+H2eHf+PrcVffOtMDJb6RBY2W/nhExqgKjE54iHI1WFgj8ccp1MCIpMEL1VfitPa3et7JDC1nG9ghlNuqliJFeXL67CArfvH6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188970; c=relaxed/simple;
	bh=hPmoK18pg5iLY83A+rbNr0eXxFJUmHHV+34ar6KDHI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I8M8/1qN2JSVNcWqed/rbRQCnxrpi0TAp26mfZVrJqNiXygTpZ6HibUhk29UF/tnUrkOzhjx5mLmRGTH/qErffnCAkiy4dLDvxeNGDW45istFoqtARpRpv92VC6jq/qapLpEqJzXRkFSSmE1jNfBCbRwnPfzTaZe8mHg5541vpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLOacKNv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so1354675a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752188969; x=1752793769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pTOjUgZ+jlqnvf94jkmtcbiRBK+z9uxeasDSIpxLc3E=;
        b=PLOacKNvVTO5EX6BnPQtnbFFsJ3GjDr59eUiJ6Ri6nmA5aY+lOwUmzFwgn1mvkOAZY
         UtrLtTfAdFpV6ENFKPF4mETpWyq8Su3VzX9elREijDoDx1RgEGwOiA+CE72hfSFcWNbc
         deM5JeHhbIJ63PJt9BJmul/dXYSfma323pl2KjlCWNT6uESfHITz2PZXYzi/6OXmHQne
         SSSv6KBZqseA8kOYNl+LERTsIu/D12ZpEz0Suwlc4huDtPl/MJmN2VxHfhOiUn4oEe2Z
         3KSl8fYEZLMP3VUbWzRpL4nMKlxJwfnrTeEE+czOiGZivUY3mJExkc507jIJ3fwqn64r
         dDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188969; x=1752793769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTOjUgZ+jlqnvf94jkmtcbiRBK+z9uxeasDSIpxLc3E=;
        b=OaAocU7utUK/KDCf8x68dLznCP96TKJVec8mYN0IfLpOEJlhwXJXgQiGEsOE/I0cOv
         YjSDCQZj1OwFUT8flilo7Zcnh+nJ3UJquC/LZgHaGLjgGFuq10c/4zEX51J7jmp7o3PL
         6ooznMH08KAA5UawpELDCOZN6pWaCHlvNx8WXhJhKDeBxa9Em5fDyz4rrr+MlsNDwFAd
         SwdROQ8Xm10qZaj3Oz5EO3fTPwlfQzI8RbiUCDEZ0kH+hDayi5vaB6iN0K+KNbvOkdVG
         VTTxx9vrCPBxgc7kvWayoakHaJIwqzGPSvZZlq0xqgVRNsPBMdU2pTRN++q9lkj/wXea
         58lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoG/hOiiNVxUWD+BGsY9zfQ0LRf6+OxnoyRBSLh/dVFuqBBPdk1h6vWQyxGDcyeR5HihAI2ARg3pF1Z+ykFtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+tlmUKxj3KwhP/d4rMIXKw0vNQtJnqDfEgDmRCW7RqlpLlHZ
	vwaV47y9eRQGnintqr9jNhkVjxLNWaj22grL6URQUiRZFcAPhrj7qrAAj3nYQx4Wj/EUQ+iGA+0
	OJdrgfg==
X-Google-Smtp-Source: AGHT+IE5qplA6OlFk8T7yH4h0UYvRJy0Sx+PveuccgpHAv26S7kZa5gKLhMTgKXx1QLGSTPoNXD53rWofSA=
X-Received: from pjblk18.prod.google.com ([2002:a17:90b:33d2:b0:31c:2fe4:33bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e4f:b0:313:271a:af56
 with SMTP id 98e67ed59e1d1-31c4cdad83emr1515086a91.30.1752188969037; Thu, 10
 Jul 2025 16:09:29 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:08:48 -0700
In-Reply-To: <20250710-kvm-selftests-eventfd-config-v1-1-78c276e4b80f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710-kvm-selftests-eventfd-config-v1-1-78c276e4b80f@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <175218119916.1488306.933221879584328516.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Add CONFIG_EVENTFD for irqfd selftest
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 10 Jul 2025 12:12:20 +0100, Mark Brown wrote:
> In 7e9b231c402a ("KVM: selftests: Add a KVM_IRQFD test to verify
> uniqueness requirements") we added a test for the newly added irqfd
> support but since this feature works with eventfds it won't work unless
> the kernel has been built wth eventfd support.  Add CONFIG_EVENTFD to
> the list of required options for the KVM selftests.
> 
> 
> [...]

Applied to kvm-x86 irqs, thanks!

[1/1] KVM: selftests: Add CONFIG_EVENTFD for irqfd selftest
      https://github.com/kvm-x86/linux/commit/81bf24f1ac77

--
https://github.com/kvm-x86/linux/tree/next

