Return-Path: <linux-kselftest+bounces-8214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365998A73D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9284B24406
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8F137916;
	Tue, 16 Apr 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VV7QYurP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF613541F
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293423; cv=none; b=q1OtZfa4ch12BULvbN5I4JqO0mXkDD2ojZDQEmwTnu6d4aO3foDhg9U2yBA7fZdmR5ftn0jH3A5K23TT7b4Ok9hUz/hMbsnEKchFV/58xKNTuSnXOW+FAnPvyOoGj2OlhXOv7+m9ff1x89VQzGJwC5uejYPQG1iuGNr04dw1OX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293423; c=relaxed/simple;
	bh=KrLRBto3JssKwlYjlBIyxafefBjA3IrDNNlM/vJJ9hI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GhxIGtAb3ypKVVXhDywH/xyArH9aWuGu1xKJp0C9nBU0knnJuKxpGYUrjUVI97d+ZjYkl4+gKOgzEIG/rfJyJBHh/qIRx/Vka5KKE5De0Ndjjoail7oYxVRMuZLpVVB8if5u5sTeqr3ACcLNy+l/sQdUu8A0TCtfK9kObX7QML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VV7QYurP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ac7b815e5so42723907b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713293421; x=1713898221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=71fCbdfH1vAW84WFTiCdLyvSqDYlBpK8GsY+uanrllo=;
        b=VV7QYurPOp5zTg7ny6efPCKGEtrNWZI7feSbb11SZC4ZxHrZ647dEqDP0PmvYgPrCe
         V+XvbGOWpm2/JXVRMM6uWr4AsKw04ODhBIoFBJXEwwhAknQ4Fk8/iZz+lzY4z+s2am0b
         unw70iZR+6DwU34un3OdJZ6qJePX/QcmkBlpVIZO7xAQM+j+2ikzQpCimYhhkSclQMw8
         S0sj9D6DKvGtGAsTShKSMqnzLBrVAC5ipzPrdizdutuVineV4W5CW1ozoBqA8SieoaTi
         x9y7mDoIKLcFBiVoOC4qoqVj3Cz+++E1hYI0y0w0s4jmFoqPbBwNFWB7/bcuTybpLqbX
         lC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293421; x=1713898221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71fCbdfH1vAW84WFTiCdLyvSqDYlBpK8GsY+uanrllo=;
        b=thODYYXNVuUkOhc6kfs/jIQgo4QEMoLaY/XuSCAiHbfy81z+/kJ5EDfFFuD735sgAV
         ZixSJmGggkJO0jGx/ZfkianHk8DApw5jGt+lfsFE1AcHfXYO3comQaHOyKw4cCYf0t9w
         vaDfwfS20u4ToSEdxmt5v46+02nij3Q0tCYOijb9wI1tIHQ+yNfDyoVxp59xbhvVXuBO
         5NkO5aobZ+ydDEh+m/Y94nrW0hTkZZ6DjZIwfQztlIXToDeGVe0vWCToGKXcWN5Gqd6J
         Y9+cpjc9Dgpiq/szD2VFgcV3wwiPf3VtqUqgOO/2/eRSRy8jKdhuesx7FDcHMKqvgXy4
         BzIA==
X-Forwarded-Encrypted: i=1; AJvYcCXMS/LePuw2Nv5uVw6De+fNSHaYhAYobppjdARfI9PhKKi81o8zJ06snTgEU0QikHEnxf7k6d1QLSwwbQ5BVtS1JVyyxLM02E7eGS4Vtzid
X-Gm-Message-State: AOJu0YwdckOBhRfVgRDOEfJhLxWzugW9NLgJzNRmQNrNYSfDB+ni4EIf
	W8e9iAbyiKIhDYWjsWT2JCYx4KeUnHgWkszR3QmqOQ3sIhQPwKV2saGpUGj3DPSEU+bPnQwjfaR
	btw==
X-Google-Smtp-Source: AGHT+IHgjpuzWhjz2uabzMwzuba3r3n3pXCUudSHE4FaID0UFJjuojA5qYXAZzXF16Fsmgo1kqxASxbfYuQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1081:b0:dc7:8e30:e2e3 with SMTP id
 v1-20020a056902108100b00dc78e30e2e3mr4217093ybu.2.1713293420969; Tue, 16 Apr
 2024 11:50:20 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:50:19 -0700
In-Reply-To: <Zhz8xNpQoi0wCQgL@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZhkhvtijbhxKKAEk@yzhao56-desk.sh.intel.com> <diqzr0f7jbj6.fsf@ctop-sg.c.googlers.com>
 <Zhz8xNpQoi0wCQgL@yzhao56-desk.sh.intel.com>
Message-ID: <Zh7Iay40VQgNvsFW@google.com>
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

On Mon, Apr 15, 2024, Yan Zhao wrote:
> On Mon, Apr 15, 2024 at 08:05:49AM +0000, Ackerley Tng wrote:
> > >> The Intel GHCI Spec says in R12, bit 63 is set if the GPA is valid. As a
> > > But above "__LINE__" is obviously not a valid GPA.
> > >
> > > Do you think it's better to check "data_gpa" is with shared bit on and
> > > aligned in 4K before setting bit 63?
> > >
> > 
> > I read "valid" in the spec to mean that the value in R13 "should be
> > considered as useful" or "should be passed on to the host VMM via the
> > TDX module", and not so much as in "validated".
> > 
> > We could validate the data_gpa as you suggested to check alignment and
> > shared bit, but perhaps that could be a higher-level function that calls
> > tdg_vp_vmcall_report_fatal_error()?
> > 
> > If it helps, shall we rename "data_gpa" to "data" for this lower-level,
> > generic helper function and remove these two lines
> > 
> > if (data_gpa)
> > 	error_code |= 0x8000000000000000;
> > 
> > A higher-level function could perhaps do the validation as you suggested
> > and then set bit 63.
> This could be all right. But I'm not sure if it would be a burden for
> higher-level function to set bit 63 which is of GHCI details.
> 
> What about adding another "data_gpa_valid" parameter and then test
> "data_gpa_valid" rather than test "data_gpa" to set bit 63?

Who cares what the GHCI says about validity?  The GHCI is a spec for getting
random guests to play nice with random hosts.  Selftests own both, and the goal
of selftests is to test that KVM (and KVM's dependencies) adhere to their relevant
specs.  And more importantly, KVM is NOT inheriting the GHCI ABI verbatim[*].

So except for the bits and bobs that *KVM* (or the TDX module) gets involved in,
just ignore the GHCI (or even deliberately abuse it).  To put it differently, use
selftests verify *KVM's* ABI and functionality.

As it pertains to this thread, while I haven't looked at any of this in detail,
I'm guessing that whether or not bit 63 is set is a complete "don't care", i.e.
KVM and the TDX Module should pass it through as-is.

[*] https://lore.kernel.org/all/Zg18ul8Q4PGQMWam@google.com

