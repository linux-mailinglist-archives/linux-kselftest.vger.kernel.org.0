Return-Path: <linux-kselftest+bounces-7011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022DA895FE5
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 01:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950DC1F24066
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 23:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEDC38DFC;
	Tue,  2 Apr 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSNIr3iH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79D2260B
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099222; cv=none; b=djfc6Qqz36nEPZZRpY1/mIbM/NoqeHRNeaUhAosO32iwTQu5lni3FnI0udmqQn3HdJqaOQ9hAHNGEc4goihIjNdx3bF4HopQHkTM5v257tG062CfTCbB0LPzdu8zqgVZjMiviEqdWmEUsMF+fxjJNxBIb4ZLb9wuMRumica9ykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099222; c=relaxed/simple;
	bh=C+ij29dRhrqI5jcxTxsDaSlvXKcifI5OQZdLLtJKNdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ua6H/cxU0K5e+IL2151Nps+svApdDBVblaod8rtvEV8TAsMFV8/IK1nnSec5FQW683n1NDoJh9KujKdPHNKGGb0Loy2Aq28JjWBKHv95AZhQI2la0SKBIawNKKiMMjqp/EcbXKUnL5ZSNy54kcDhWJS3OOEu37jR3Gs47jhRlGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSNIr3iH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e0a86c9ad4so48625125ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 16:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712099220; x=1712704020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7422aHnKc2YIMvnMd+j0sBwZWTd2YcB6sZqSb8qExc=;
        b=fSNIr3iHUE2KS1JwvAp+0VTuTWOnVAwhzuOjz2jaVuO4SYAPYSfmuGk2d1sSi3FoWz
         YN0FppBeK52vbwjimHxMauvlLlq0BpFuZrmgo32oQ0kYvcl68zXSuC8xxB3sZojNdiVV
         sHxNSQUEQ2/7opU+V3x6cm0/oLWr9FaFNh6IYcCnnqwyYxCRBnbNOJ/2Lcn9jpSLqbo0
         rHMdvLsFi3sP8eKImkxL78yfysEC9oNCPCw25lVlB+JbPvmVAxVY6PoEe7PwJ5uz88My
         xf4Vq+/hnfhLW9XUPdJeVMOo91Fwl7Te6pJOO+ssVSVJbaV+wY/aorXV0z7wEQfyT8AF
         wbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712099220; x=1712704020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7422aHnKc2YIMvnMd+j0sBwZWTd2YcB6sZqSb8qExc=;
        b=G7c6gU2GqDIlLbvfvOhUuzoZWIGJi7iC2m9rKWWxwO1lT0rLl+4rX1FMm93UcppbWK
         bS7RtHH/4HZRRfBcFbJmLD9rTgmjwxj3hDX/+DFIKggnkdtJ8aVVTp0hxTYTtPCJafgb
         69CIzgj115MzzrIfFq1bTtsTkCdd0i03xAUzceBta/RUTnCERaDRCygscMFE17gjdllK
         Sn/xLyNKHIPWE2U6in43CNWnoe1ndOMqUpG9gU/zu1J48Ue7/HcOgVdeeqhNrC3vQO6R
         7hJZ2/YSWhKuoogYk2U5G1JWmhvC4t10dTPz1NjqK8f8l5sHM1g9m6qOw0jYSrByOkw1
         fMag==
X-Forwarded-Encrypted: i=1; AJvYcCWHxrjjLRyg2DRG6TBdVCIVue0m1OgAMaRmc8ZeMGaO/ami1F7nYkjJXi4dviLNn2LtyVGFznLZhk5leS/d8Jc+/3dK4+rODEn9BX7L5GyF
X-Gm-Message-State: AOJu0Yy4G+T47CGQE6s6HXrLh2HsWGk1Eg+xjcuZUF67P+wwQoWEMrRY
	40ALO2BaUIoG3tz80s9VJFMx5asAaea+8ndUuSRWapUh2/kM5fa7jJWrV5quVXB4gPf6Pe4PXjv
	r5Q==
X-Google-Smtp-Source: AGHT+IGRm2VsuXBt3jAN92k0nAeok/Lf4J4zQfP39FSHUoKS6RXRTu02feTnvHV+1X59u3kiSav4RscI6qs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e884:b0:1dd:cc3f:6510 with SMTP id
 w4-20020a170902e88400b001ddcc3f6510mr1141063plg.3.1712099220554; Tue, 02 Apr
 2024 16:07:00 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:06:59 -0700
In-Reply-To: <207d6598c8b74161efc38bd18b476ca8626786b1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315143507.102629-1-mlevitsk@redhat.com> <207d6598c8b74161efc38bd18b476ca8626786b1.camel@redhat.com>
Message-ID: <ZgyPk-1MCqJIXXoB@google.com>
Subject: Re: [PATCH] KVM: selftests: fix max_guest_memory_test with more that
 256 vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 02, 2024, Maxim Levitsky wrote:
> Kind ping on this patch.

It (and patches from other folks that are getting pinged) is on my list of things
to grab, I'm still digging myself out of my mailbox and time sensitive things that
cropped up while I was offline.  I expect to start applying stuff this week,
especially for fixes like this.

