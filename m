Return-Path: <linux-kselftest+bounces-8638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 620858AD67E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB741B2236B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 21:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E51CAB9;
	Mon, 22 Apr 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5OdWMtw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908781CA8A
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821041; cv=none; b=Qzld9eoKuPTDq2PsxM8HW2mx2zGvrLC/0iWIwoUL3/uAlGbOQQVMca0CEhnO6jzScnRniwtlw+t9LvmnnR4O9DOaLCW7rhgIJjDN5c7AHm7YVuUK+ndURaBo20jPFXHiwqrWrFNHgvR2exaYDFyusvcpmpigj2D1PRzbc3M2NfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821041; c=relaxed/simple;
	bh=IKLpE47qOBMBz0cAqZg5lsOAv2Lseafvdp0sCBMbxdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U7oy/XgqaacpxWRoXut3Pmc47C1lyrwg+Oku+YZ+CgbnYI6PlZn0Cyu3YHNn+0plSW+gYKF41vuJJx10lIWWciKl+TWne3w5uH6V9w2kiHAiDhk804RysVOzatbroAg9josT34jEuh4klKV+FB+jQCr1TSKh6T+h2VBjb4Juvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5OdWMtw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-618891b439eso80775087b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713821038; x=1714425838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uVx/t9/onkYc8i256VPb5hdTG5OQAkMTur1j7RQo/Y=;
        b=b5OdWMtwdKVXMDE2I4Du0g5UBvi8jdS4PAmeDFdpmP3tG/guCHTvf6iDFJupZOkTDO
         QHvEjBvnB+h4Gr9VTSigi95/oUF8GjwLXTU4/S706eb+iqur5g0Cnbwuj8csiOkVyLvt
         ukHsJFBYl2hO4HrJBGoT0O7eKNZgfmeq80ECMyqSgmil9uKqV9IIt3yVCA33hcOeT8Ud
         eJ6C7sxiLnVaR/QZLupHaMBO2dLpcirDxDT/S6M+SWuXkUmKkTuWsS2H8PRrM6bubp3Y
         XL2eK1Ynib5vKpg/b6JUIjBeop0i6i0CgUqMgAJ4u9i8SPn8RMyD7R84zoZTBmTt5jAl
         /ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821038; x=1714425838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uVx/t9/onkYc8i256VPb5hdTG5OQAkMTur1j7RQo/Y=;
        b=j6whCAD7jk5J60CZ8x7Au15s1RoBUnyUNKphv/Wb+EfiAdnoYvJusfkhxGornL4XLC
         ZV763tChZQqahTaPKquyrUVKidRr5Pz/P1LQrZdmUq8BtF9uW0KuHkxcU4iZrNje9ajq
         UhGGQ5UfTy6z+5HnXlR2dLaeqO9+z9JdjVaaTNZ/cWYQFxOPI/uZmE9DoYORVQQTkQ7s
         u7rqKiTl1pODLeHKot7i9YN8Q0EJrTRVgiRzcE7pI9tmSXh6AcTJolsfq5OEPuSkU7m9
         RwYBtvr9QE3i410UHNoJ73GtGxrbtRBI+1CMgDHz47iY+py0MaxvSTyekZ+1WvNag5kr
         XiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWveXYPszrDtM0rHlutnoFi1T+ShNZ3keQzPP+VN06oeJFgC5mEHkStv98y+Lau69uKK3qJWqjGWo3Ux3/aMpH0ylb2eTOi5zzvAHSEOizI
X-Gm-Message-State: AOJu0YxNvLTTVkbvP0srbILF99y55bVf1Pktlde+D3c/R2dZo/tP8vzK
	NBf6BR7s2ds3bwlIt54hh17fTTLgYGMr22MR3Hz8QOewnSfZl0pZxSDQGGBXd1k2QvwLvuRU6xo
	1kA==
X-Google-Smtp-Source: AGHT+IFB76IZsBj/WkAnr4URUhjuMUZMHRKzmaQ2M773fcwMt+w+XUH9UmMi/TJMMkVL4AKbrxpXlaHYu+U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:13:b0:61b:3a8:3360 with SMTP id
 bc19-20020a05690c001300b0061b03a83360mr2745903ywb.1.1713821038654; Mon, 22
 Apr 2024 14:23:58 -0700 (PDT)
Date: Mon, 22 Apr 2024 14:23:57 -0700
In-Reply-To: <ZiBP/j6Ic7hGrbxN@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZhkhvtijbhxKKAEk@yzhao56-desk.sh.intel.com> <diqzr0f7jbj6.fsf@ctop-sg.c.googlers.com>
 <Zhz8xNpQoi0wCQgL@yzhao56-desk.sh.intel.com> <Zh7Iay40VQgNvsFW@google.com> <ZiBP/j6Ic7hGrbxN@yzhao56-desk.sh.intel.com>
Message-ID: <ZibVbYawGJFcJqd1@google.com>
Subject: Re: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error test
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, sagis@google.com, 
	linux-kselftest@vger.kernel.org, afranji@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, pbonzini@redhat.com, shuah@kernel.org, 
	pgonda@google.com, haibo1.xu@intel.com, chao.p.peng@linux.intel.com, 
	vannapurve@google.com, runanwang@google.com, vipinsh@google.com, 
	jmattson@google.com, dmatlack@google.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 18, 2024, Yan Zhao wrote:
> On Tue, Apr 16, 2024 at 11:50:19AM -0700, Sean Christopherson wrote:
> > On Mon, Apr 15, 2024, Yan Zhao wrote:
> > > On Mon, Apr 15, 2024 at 08:05:49AM +0000, Ackerley Tng wrote:
> > > > >> The Intel GHCI Spec says in R12, bit 63 is set if the GPA is valid. As a
> > > > > But above "__LINE__" is obviously not a valid GPA.
> > > > >
> > > > > Do you think it's better to check "data_gpa" is with shared bit on and
> > > > > aligned in 4K before setting bit 63?
> > > > >
> > > > 
> > > > I read "valid" in the spec to mean that the value in R13 "should be
> > > > considered as useful" or "should be passed on to the host VMM via the
> > > > TDX module", and not so much as in "validated".
> > > > 
> > > > We could validate the data_gpa as you suggested to check alignment and
> > > > shared bit, but perhaps that could be a higher-level function that calls
> > > > tdg_vp_vmcall_report_fatal_error()?
> > > > 
> > > > If it helps, shall we rename "data_gpa" to "data" for this lower-level,
> > > > generic helper function and remove these two lines
> > > > 
> > > > if (data_gpa)
> > > > 	error_code |= 0x8000000000000000;
> > > > 
> > > > A higher-level function could perhaps do the validation as you suggested
> > > > and then set bit 63.
> > > This could be all right. But I'm not sure if it would be a burden for
> > > higher-level function to set bit 63 which is of GHCI details.
> > > 
> > > What about adding another "data_gpa_valid" parameter and then test
> > > "data_gpa_valid" rather than test "data_gpa" to set bit 63?
> > 
> > Who cares what the GHCI says about validity?  The GHCI is a spec for getting
> > random guests to play nice with random hosts.  Selftests own both, and the goal
> > of selftests is to test that KVM (and KVM's dependencies) adhere to their relevant
> > specs.  And more importantly, KVM is NOT inheriting the GHCI ABI verbatim[*].
> > 
> > So except for the bits and bobs that *KVM* (or the TDX module) gets involved in,
> > just ignore the GHCI (or even deliberately abuse it).  To put it differently, use
> > selftests verify *KVM's* ABI and functionality.
> > 
> > As it pertains to this thread, while I haven't looked at any of this in detail,
> > I'm guessing that whether or not bit 63 is set is a complete "don't care", i.e.
> > KVM and the TDX Module should pass it through as-is.
> > 
> > [*] https://lore.kernel.org/all/Zg18ul8Q4PGQMWam@google.com
> Ok. It makes sense to KVM_EXIT_TDX.
> But what if the TDVMCALL is handled in TDX specific code in kernel in future?
> (not possible?)

KVM will "handle" ReportFatalError, and will do so before this code lands[*], but
I *highly* doubt KVM will ever do anything but forward the information to userspace,
e.g. as KVM_SYSTEM_EVENT_CRASH with data[] filled in with the raw register information.  

> Should guest set bits correctly according to GHCI?

No.  Selftests exist first and foremost to verify KVM behavior, not to verify
firmware behavior.  We can and should use selftests to verify that *KVM* doesn't
*violate* the GHCI, but that doesn't mean that selftests themselves can't ignore
and/or abuse the GCHI, especially since the GHCI definition for ReportFatalError
is frankly awful.

E.g. the GHCI prescibes actual behavior for R13, but then doesn't say *anything*
about what's in the data page.  Why!?!?!  If the format in the data page is
completely undefined, what's the point of restricting R13 to only be allowed to
hold a GPA?

And the wording is just as awful:

  The VMM must validate that this GPA has the Shared bit set. In other words,
  that a shared-mapping is used, and that this is a valid mapping for the TD.

I'm pretty sure it's just saying that the TDX module isn't going to verify the
operate, i.e. that the VMM needs to protect itself, but it would be so much
better to simply state "The TDX Module does not verify this GPA", because saying
the VMM "must" do something leads to pointless discussions like this one, where
we're debating over whether or *our* VMM should inject an error into *our* guest.

Anyways, we should do what makes sense for selftests and ignore the stupidity of
the GHCI when doing so yields better code.  If that means abusing R13, go for it.
If it's a sticking point for anyone, just use one of the "optional" registers.

Whatever we do, bury the host and guest side of selftests behind #defines or helpers
so that there are at most two pieces of code that care which register holds which
piece of information. 

[*] https://lore.kernel.org/all/20240404230247.GU2444378@ls.amr.corp.intel.com

