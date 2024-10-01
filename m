Return-Path: <linux-kselftest+bounces-18802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDDD98C39A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E95284775
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BA61CB520;
	Tue,  1 Oct 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZ3XCU+u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167FC1CB505
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800890; cv=none; b=S3lpnCvV6pJ2GzZ0QyriqSKvX3zy1rIjSri6g3jRK1ix6kym1DgwSxjB2f8XsUCLxoQaiT0nxX+e3HOiNICkU2EMXSJknMzn/PwjctTCGDfMDFTQGCBJ0HtaMmbW44H1hjQxKoOe71pXAINZeg7sJI0+JvdV6lj3d7SecRpAAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800890; c=relaxed/simple;
	bh=+jkyghh59xKMjZU+NbWVLGYubWbREKsEtCY/7RDZWJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kCkdKt6uP1ana1GQqcAuB0+2a2XPd2YWZMdKkZprNf6LuW+/KoxiexSjb9OQHz4IWgidxpXvj7nbPWRqq14bORP+rB2bT0WbhX7GB7YYeT0GQs43iFpxmXRSOYn8aZfpyd6xTfmBwq4JPCWB+gSTPILok3bY/+O9shUK3//IIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZ3XCU+u; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e230808455so66489707b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727800888; x=1728405688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SgvFUZ0l32mNtnLi+B64uXI+aFBZc2L8UZwkiGU+28=;
        b=gZ3XCU+uYa+SYRI3cF9x2LMUbO6QXzCSbfPZIfT9MD8tsAGF8No1QmLiX66zCBumte
         r7X71G1ldpoL27sCo2bgPLttQrWYb+UX28G/uRajM/IQjDvdasWZgjbD1BM6b/X1oQLu
         aiPDNnC+GlEHruwo4mRtdKp+MsKQqnrjO2ZqLeL9leiH1A5Ecq6TxtY7vMi/RsIGERYc
         XJ4GSPB6EHOpKVMtzumW3ZjdC06cT+Xv+DtlR+IBf4Ez+2f3VcXO0AeqSU2F4qLG4gVQ
         ey0WZk0+D7jSSmJJNNXLFDhQfzxskoXhFYjJSue7wM0Hzq2ciLuyTNbyRR1dz74Boloc
         IM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727800888; x=1728405688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SgvFUZ0l32mNtnLi+B64uXI+aFBZc2L8UZwkiGU+28=;
        b=sT0gjcAZZkOUk3Kq4pVu1PGQXoaV4U2VF4D/yMRf1MWP9ngTR/1zw1bnx4IXGfXrs+
         gEC3OGFqAkDhk8Q0KZPOxbxJUfX0NCzbyu4aY8RvqlKZRTOWIHtY3W3LiFF4e+sElw1F
         BP3FvEPXL5Gbu5qQDVvSA+yjDUmI6Ccolg4JzMVkwLEKu+Qhd78vmkdhshQppyX0DM6h
         r808XFnrlmDGzui+rZ1Gw9z+itN5Y8XVQVrLwqarIMZQYcuU7B7zlrngFahOzn3sWxQ+
         v/t0UWSi65NU+anY+VqbbZFo35nZq9M971/BQSCrTNnbm71czEZbPbRgW35kU0ltOe1d
         o7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUkpR5dQ/Yr/N+o3o4sQTKAVKRTPpPq7mafgXgtOxDRRLc1LndUw41lcs5Ul8beQPw22SkiSM0VSC24Hhnocfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWoZTaUWIRBbgyi1zkSN7yJ69tKJs4wQLVxLIAtM7C6uW1msO
	ENIYgh2eztwOcSC8XZcOzfrPowhTvArCkrnzAENYKAbbhz5+TPb4Q9s7bTC9FaQ04NnV+DnQuxA
	Zlg==
X-Google-Smtp-Source: AGHT+IHmFdl+55S7IDy0xeVjWu3kw9xgQ6F6bPYxyY0wCyWqpm+n/FjY6pMqElJJTCVMRNqkjSGzVAZMI9g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:fd4:b0:6b0:57ec:c5f9 with SMTP id
 00721157ae682-6e2a298509bmr85077b3.0.1727800887949; Tue, 01 Oct 2024 09:41:27
 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:41:26 -0700
In-Reply-To: <20241001063413.687787-2-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001063413.687787-1-manali.shukla@amd.com> <20241001063413.687787-2-manali.shukla@amd.com>
Message-ID: <ZvwmA-Z_T44zcSJZ@google.com>
Subject: Re: [RFC PATCH v2 1/5] x86/cpu: Add virt tag in /proc/cpuinfo
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 01, 2024, Manali Shukla wrote:
> Add support for generating Virtualization feature names in capflags.c
> and use the resulting x86_virt_flags to print the virt flags in
> /proc/cpuinfo.
> 
> Currently, it is difficult to check if a feature is supported in _KVM_.
> Manually querying cpuid to know whether the feature is supported or not
> can be quite tedious at times.
> 
> Print the features supported in KVM hypervisor in a dedicated "virt"
> line instead of adding them to the common "flags".

First off, printing flags in a separate section doesn't magically connect them
to KVM support.  E.g. if you cut this series after patch 2, BUS_LOCK_THRESHOLD
will show up in "virt" despite KVM not supporting the feature.

Second, deviating from the X86_FEATURE_* syntax will make it _harder_ for KVM to
manage its configuration.

Third, this is completely orthogonal to supporting bus lock threshold in KVM,
i.e. belongs in a separate series.

