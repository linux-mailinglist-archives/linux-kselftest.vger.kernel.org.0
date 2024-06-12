Return-Path: <linux-kselftest+bounces-11788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E55E1905A77
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 20:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A63E1F22CCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270C183079;
	Wed, 12 Jun 2024 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJ8VDYVu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655A4183068
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215863; cv=none; b=sYRU6YWM4Aic673ic6j+DEMfvrLvSwSRBMxrEW7HNX9WczuAWrMVW5O6k3ReCDK7HafdBBZMO1d6MTNAxmsthnnr3mSCgEianhB8qdaa6B9WUi5HSbgXZKfkiDWYrDTq8/RdyzIFJB4FtAkz1U3+XjiZLw3sj5dCbgcsCtKoZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215863; c=relaxed/simple;
	bh=byfky6BG4g1mjW3Wr/3DNMmcw/qupLWQ0lVzTwpwdZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DGJVep9VD/js1QgDzvWJsDV/+l7v6h+y7OY2PY503nTl7chsUWtIyEenn6wR4eogumMM2WArlQzszFsoutC37T9vjUqDh5rC5E4+jfnHvVZfIPLgrpLjQ9xakUppa7Zpm5AiFKBLgLnoJasyQ8kf4BhZpYVh8cqjBcTy9qG1fcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJ8VDYVu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627e9a500faso2402397b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718215860; x=1718820660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bysuRKx6ASJn7sotbzdgYdmXjsZucWIObzR9RYJqi4M=;
        b=TJ8VDYVu0hwx/RCUpkOjmyYMvNc1yt/sQ18Mm7A2DP1umNdlEPLHYVA8dMxco+PPCv
         PUVhxjfMG5xjrATU6BsdSFri2UNCRSd5A9ljGWRJ3UtIeNO3IQoPEzhkHglXMPdE0qQ/
         k0cy9YMPUG6ssoRVc9AYs9v8n7cQbwSopKc/y72gRbKBBlJx5sSCI55eMb2rn9bSkK4i
         50xlJ/qG1wpeHF75QAVeMCrDB0h4PJ3xQtzSAi9e712GsNmTY4rUd81Ka+3hc0CCg7eC
         6gBCICoqmDuZGCdOPTOTRUFM83L3SolNFqQwrL2kbwyJUWBa91TIv4Jb63XXq9hvKsQS
         FflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718215860; x=1718820660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bysuRKx6ASJn7sotbzdgYdmXjsZucWIObzR9RYJqi4M=;
        b=OEV3D1i5Wz2X8aX6OqSECFUfkp9wBbn7SXq5fvd1dNNO4iQjBl/zDc8Ytz0eZUJvnb
         j1uhRdiUhfVe+boEMfyqyNxqRRngjHuFkUQ/zwgPgAYdGeUjdDre9rBJobFvPmvmZXwS
         btHo8y5ao1VlsY2AFQOJld5BVDiWz7g9SZ+U4/AiWtuFTkfGVmhqEx8+sdOKi0CBeTxi
         pvJI7dSmde0b0xtmBFyjpJp36lVPL2L1ITWmB9kSDCGljluBL/a1/bX9G46vRTViEu/H
         xdLtJkxSmIOl5fwQVGZiv+ShEqoG80ilbl/HZnqj08oWWvwxnXJ521WO1KxdgVBo2txD
         OZgA==
X-Forwarded-Encrypted: i=1; AJvYcCXVZa/5qppZ/5HdRm/xMaYJIbTiXau2rTvTRRq0AqSTT/Q9xB5phBQvLhICIVxv33/AYtS5ehyXX4ytFcl/PT3KmOTUoEqleGz6z1moSKG6
X-Gm-Message-State: AOJu0Yx9cCbAu9wRjBwcS8FWE5zsbyIXDTXF1UZUgsYrySLS2uraYN8s
	O4NzhOZMbN8zd2Gsey7jkYWXnzykyHQAjbRHSXzJRyZXSvpkGSOlGmZQ3MBPiCEbIPJiRKyO+Od
	1Xw==
X-Google-Smtp-Source: AGHT+IFdlsyNfCopJx9MGc/lpAH0uLI55vrBd5uBQ720M/Quh9qtzfjG5LFD+1WcYsruY1pOCRVfaawqImE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b19b:0:b0:de4:654f:9ad0 with SMTP id
 3f1490d57ef6-dfe66b65b58mr79044276.6.1718215860399; Wed, 12 Jun 2024 11:11:00
 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:10:58 -0700
In-Reply-To: <6bd821a3-9dbe-499c-ae17-afce70076299@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612104500.425012-1-usama.anjum@collabora.com> <6bd821a3-9dbe-499c-ae17-afce70076299@arm.com>
Message-ID: <ZmnksmC4u5lP5am9@google.com>
Subject: Re: [PATCH 1/2] selftests: kvm: remove print_skip()
From: Sean Christopherson <seanjc@google.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Anup Patel <anup@brainfault.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Aaron Lewis <aaronlewis@google.com>, 
	Thomas Huth <thuth@redhat.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, kernel@collabora.com, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 12, 2024, Dev Jain wrote:
> 
> On 6/12/24 16:14, Muhammad Usama Anjum wrote:
> > 
> > 
> > diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> > index 4f5881d4ef66d..695c45635d257 100644
> > --- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> > +++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> > @@ -144,10 +144,9 @@ int main(int argc, char *argv[])
> >   	free((void *)hv_cpuid_entries);
> >   	if (!kvm_cpu_has(X86_FEATURE_VMX) ||
> > -	    !kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS)) {
> > -		print_skip("Enlightened VMCS is unsupported");
> > -		goto do_sys;
> > -	}
> > +	    !kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS))
> > +		ksft_exit_skip("Enlightened VMCS is unsupported\n");
> > +
> 
> Isn't it incorrect to delete 'goto do_sys'? ksft_exit_skip() will exit and the
> program will never jump to that label. At other places too you have deleted the 'goto'.

Ya, exiting instead of continuing on will break these tests.

