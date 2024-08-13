Return-Path: <linux-kselftest+bounces-15234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BF595093B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72F72830CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 15:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF65119AD6C;
	Tue, 13 Aug 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onDHvVdj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47577191F71
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563490; cv=none; b=WINZT+67vr6oyjAerFOsCOFW7tqCEcFA8JdcRNbpjSDZXHdtL3t2ZmJPwva/4pIEIDnJ8+P8P/v5uAvclGnu2AXrRs3EXzXBA7AL1rVszW8B5JQUpLlKRiB4Q/0UNOfrp2uldFMfVSqjVbeomtgF+WWAMA5CxN86OhZfJ6aFNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563490; c=relaxed/simple;
	bh=0c7sx9C1jet5WdcmyMpMYsHb/i7UcO2KmcsxAf7KKwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XAZ16R18Ck4oY77SQm5uBZ0PlvEHwc8sTLjiSJ2vt3XHX3p09YmhO8m+h4/dw/falflqrTbHNBtcm6Yg087H1FxhCNLgct04vLDuWFSfAp7PUhimeiQND18sNqCsWNzzQYbSnuaKEq+hhayieJEegc9SULPBl+2QzKWSJi640mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onDHvVdj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66890dbb7b8so127662807b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723563488; x=1724168288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kMHZ1GdUJDWple2nUqgyCrw9nVKP78R5QKQXwtWMxY=;
        b=onDHvVdjonoCqEgmVmdh2AF12EWK0H3RUS03tyRqISJhXVgvoEtnMBOzFkts5KYTAU
         2PEekqYYmaHNuL6vN7ALRhVkIeFGlGfSOrhgX7ESiGEVTSCBHqHBLVpKRHqeRaOvSQi5
         SMUkNz7Yxr7OZ4xOJjwPPxIOP6xvJhSpchWX/LlK6xCEwf27paOVK37O5/3UoMNhWYXU
         1f/pb47N09xK0Ptn1zSi6fn29GqJFdLVAFD5/tNFXp4+SMzPevXfGKhsvTehn/GvbA3O
         VZB068KhSZ87nU6uOPHmP+onBwulaPiKdXht/XxlPUNuzE8WckSay2DiKBN+mM/d7BxD
         kScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723563488; x=1724168288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kMHZ1GdUJDWple2nUqgyCrw9nVKP78R5QKQXwtWMxY=;
        b=tjC+9NKr+gSlK+qUeg5p/91Fm1oJEQmp9QR18t1hnIguQ2ulAnIEyrxapz4uhORTeb
         nYL17Avmb/g5+o3CAjubC0ZSDWQ1ZcIn1tPLt71LOTPWEcAvU72rORvS6Sqr/E/cGqA0
         XYq7QPsWPYpnw4PpBzzSUfS+un8n7925BV5GBgSCMIj171iCrliU6qgDRldsVq5f9p9h
         WT8cFaIbktLVq+zFn8T0Z54okCLCmlMY4MTgVRkyOefvrmG9uZmiDRb4LGiDG4421bLW
         Ct2BVd/SpqBzwGbCsBwESObFgD3wzscv0Y6rwh0AQfHYl8UBYcjZpWETiGv+UKju8Asp
         BmJg==
X-Forwarded-Encrypted: i=1; AJvYcCXV43bTvSOOjlZ6rENGhF8j/ffYHE+WQuMs7a5DudvuiJVed2QaDlIOtHp7nqZssNB8imC9F3sLXfbLuMR5KVR+EhubOLAWvSV5yxx88qo/
X-Gm-Message-State: AOJu0YwcX7jCtEoM39sDxoD5/2tphkRUGaJEazyU0ZfYklcM1gSj2fA5
	u6vpEzcejinQy/ZFBUg/Ggac1q7zimMIXhTtbwbUjSoqd9D8K5f0yb8VtdULyl1+RsOs7xQPz1P
	d8A==
X-Google-Smtp-Source: AGHT+IGOOFdbk3PmOx25fWh05KbLnU14MAEXTZc2fD/h9QtctdaISVEo25EHB58NCnb+Ip+BcGxnuI2+OWc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:eb11:0:b0:e0e:89e6:aad4 with SMTP id
 3f1490d57ef6-e113c907c61mr140833276.0.1723563488277; Tue, 13 Aug 2024
 08:38:08 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:38:06 -0700
In-Reply-To: <ZllzCoYvMQOkMo90@chao-email>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528041926.3989-1-manali.shukla@amd.com> <20240528041926.3989-6-manali.shukla@amd.com>
 <ZlWLupfpODawPX3P@chao-email> <b45bc797-9087-4456-ba18-463c3f638096@amd.com> <ZllzCoYvMQOkMo90@chao-email>
Message-ID: <Zrt93t29X6A0nmys@google.com>
Subject: Re: [PATCH v3 5/5] KVM: selftests: KVM: SVM: Add Idle HLT intercept test
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	nikunj@amd.com, thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de, 
	ajones@ventanamicro.com
Content-Type: text/plain; charset="us-ascii"

On Fri, May 31, 2024, Chao Gao wrote:
> On Thu, May 30, 2024 at 06:49:56PM +0530, Manali Shukla wrote:
> >>> +	/* Check the extension for binary stats */
> >>> +	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));
> >> 
> >> IIUC, this test assumes that the IDLE_HLT feature is enabled for guests if it
> >> is supported by the CPU. But this isn't true in some cases:
> >> 
> >I understand you are intending to create a capability for IDLE HLT intercept
> >feature, but in my opinion, the IDLE Halt intercept feature doesn't require
> >user space to do anything for the feature itself.
> 
> Yes, I agree. Actually, I was thinking about:
> 
> 1. make the feature bit visible from /proc/cpuinfo by removing the leading ""
>    from the comment following the bit definition in patch 1
> 
> 2. parse /proc/cpuinfo to determine if this IDLE_HLT feature is supported by the
>    kernel

Neither of these is sufficient/correct.  E.g. they'll get false positives if run
on a kernel that recognizes IDLE_HLT, but that doesn't have KVM support for
enabling the feature.

The canonical way to check for features in KVM selftests is kvm_cpu_has(), which
looks at KVM_GET_SUPPORTED_CPUID (by default, selftests VMs enable all features,
i.e. reflect the result of KVM_GET_SUPPORTED_CPUID into KVM_SET_CPUID2).

> But I am not sure if it's worth it. I'll defer to maintainers.

