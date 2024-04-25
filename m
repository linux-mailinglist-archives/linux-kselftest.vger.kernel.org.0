Return-Path: <linux-kselftest+bounces-8867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DF78B265C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07CB2815D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC66814D2AE;
	Thu, 25 Apr 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j934Hiki"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06814D294
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062362; cv=none; b=jiB4pIlXfA+9fVG3MFasVt4+/r3nX9CfuluIm7W0wyVdruZnk2A8Zqaiod7hTIddy8Fh8GlOrnm/U7cSF/Pz7d2LK6N/LdJ0aqRjWNWEhiJYU6T7ED78J6wwCCb9+r72naqWWiGCMCs6N9xTJ4UM6gVUMd5msK621gvIgmMZsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062362; c=relaxed/simple;
	bh=Wrp02xIa5F+jofcD0a3nI2LJ5ugmaidOo1ZiG5tjSKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YzJt+WNDeml/thZrmELP5MwAPkjRbXBeM+rdce2pvvIZeonQrVlXxX/JlZtVOKV/D/jyIG96ohmaGkfxwrFQ8dAH5fzytlrE0rJegyud5cWnjD78OfD8g/bRhCt04USTy36bNBLwvpBWOeNA0qC+QadAhhi23oNX7sAxlrCk9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j934Hiki; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so1955768276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714062360; x=1714667160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDuopDjXfunZvdvHof7XCisSrwKL98dOKzOYyljZ3x4=;
        b=j934HikiskWI9FzAuCV0l4fRFCKeEc8A44gBigsUOWIZBXl8drAZZ1jdnQhLX6GWMH
         xI74oB1ConEdZp33R79AlkXf56kqVFZS7oJozQklwFosSMqMYLtiMJIQdWouxmHks4QN
         LP2xf9pT/uD8ug6pg15BH9+RWQ2O9xI28VNHCetLqM1/MzsqORAuuoznA/T3HgJ3sITs
         fHg9t6dOuiVfmzDiYvrhfKL0z1hoIBkghUkFY5SHX6Yp801eRvNxRNfls6Kusqjk7x62
         64qb7p8dTLInqSJrNncX2cGGudC6TGv3i5zkQjMLnBMhV0ENCr12sI5eotAIZVfoKZL2
         7IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062360; x=1714667160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDuopDjXfunZvdvHof7XCisSrwKL98dOKzOYyljZ3x4=;
        b=nMRjO91H9YyUNlNckniIH0erygxJHjq10kDQqNbOB4U1d2fMz9amRFhXvElxgLCwuA
         H1+jomOLId2f/hdkRlGK96cbBchg8rOTEGSCWBYvToWcrxdxPrU6psbM4Q9SiAnnjmcv
         DFVAAatCGs1ChWYSsbAQai2hXFnxub7x9G7DHPMnnN9asj3888m3nlsUvAfDnER06bZe
         B3dKb6xGovEYWWeAn15Yt8iSkJQzLLjD9jZCBXGgiFG3sYtIXxJlRhzgzzJAQcGmRDTw
         SwnqWIStd59/F2oAwG/isLkRuk2A3mwpki1m+wNwdfA0hJKlzexbMqudaBTZ7mQXZVA6
         /RDw==
X-Forwarded-Encrypted: i=1; AJvYcCUyQljHw8VQWe11BvqcPoBMUD9IdXZjUYm0KapLbm5s+vL/uxK9WszEcKhBeD7qI73CeXCfiFU+3WknHvdSSTTSAgHP3OqBGp3AL6l0O06O
X-Gm-Message-State: AOJu0Yx3F313yYRzmg34va3fSNmCCQxxd6emHI/XvMFA7U4SdWixbGIt
	wqAcL0yA8XUu3eip4FnmwYdTjYPooLmPis9A+LtsFhXDQmqVOHJNu+zBSDaFKggHGHqPMXYP8V3
	G9w==
X-Google-Smtp-Source: AGHT+IEedOG1ITFc/zgbrJigM9ClcijuGO4cXZcDhUXtjDilAJ+Dx8WyZUgqdGJWoCWT3uPPGbY93RgXIEE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8052:0:b0:de1:d49:7ff6 with SMTP id
 a18-20020a258052000000b00de10d497ff6mr4364ybn.7.1714062360352; Thu, 25 Apr
 2024 09:26:00 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:25:58 -0700
In-Reply-To: <Zik_Aat5JJtWk0AM@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423073952.2001989-1-chentao@kylinos.cn> <878bf83c-cd5b-48d0-8b4e-77223f1806dc@web.de>
 <ZifMAWn32tZBQHs0@google.com> <20240423-0db9024011213dcffe815c5c@orel>
 <ZigI48_cI7Twb9gD@google.com> <20240424-e31c64bda7872b0be52e4c16@orel>
 <ZikcgIhyRbz5APPZ@google.com> <Zik_Aat5JJtWk0AM@linux.dev>
Message-ID: <ZiqEFqomGLmDR7dg@google.com>
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in test_vmx_nested_state
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Andrew Jones <ajones@ventanamicro.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Kunwu Chan <chentao@kylinos.cn>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kunwu Chan <kunwu.chan@hotmail.com>, Anup Patel <anup@brainfault.org>, 
	Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 24, 2024, Oliver Upton wrote:
> Hey,
> 
> On Wed, Apr 24, 2024 at 07:51:44AM -0700, Sean Christopherson wrote:
> > On Wed, Apr 24, 2024, Andrew Jones wrote:
> > > On Tue, Apr 23, 2024 at 12:15:47PM -0700, Sean Christopherson wrote:
> > > ...
> > > > I almost wonder if we should just pick a prefix that's less obviously connected
> > > > to KVM and/or selftests, but unique and short.
> > > >
> > > 
> > > How about kvmsft_ ? It's based on the ksft_ prefix of kselftest.h. Maybe
> > > it's too close to ksft though and would be confusing when using both in
> > > the same test?
> > 
> > I would prefer something short, and for whatever reason I have a mental block
> > with ksft.  I always read it as "k soft", which is completely nonsensical :-)
> 
> I despise brevity in tests, so my strong preference is to use some form
> of 'namespaced' helper. Perhaps others have better memory than
> I do, but I'm quick to forget the selftests library and find the more
> verbose / obvious function names helpful for jogging my memory.

Hmm, I generally agree, but in this case I think there's value in having the
names *not* stand out, because they really are uninteresting and would ideally
blend in.  I can't envision a scenario where we don't want to assert on an OOM,
i.e. there should never be a need to use a raw malloc(), and so I don't see much
value in making it obvious that the call sites are doing something special.

> > > I'm not a huge fan of capital letters, but we could also do something like
> > > MALLOC()/CALLOC().
> > 
> > Hmm, I'm not usually a fan either, but that could actually work quite well in this
> > case.  It would be quite intuitive, easy to visually parse whereas tmalloc() vs
> > malloc() kinda looks like a typo, and would more clearly communicate that they're
> > macros.
> 
> Ooo, don't leave me out on the bikeshedding! How about TEST_MALLOC() /
> TEST_CALLOC(). It is vaguely similar to TEST_ASSERT(), which I'd hope
> would give the impression that an assertion is lurking below.

Yeah, but it could also give the false impression that the macro does something
fancier, e.g. this makes me want to peek at TEST_MALLOC() to see what it's doing

	cpuid = TEST_MALLOC(kvm_cpuid2_size(nr_entries));

whereas this isn't quite enough to pique my curiosity.

	cpuid = MALLOC(kvm_cpuid2_size(nr_entries));

So I have a slight preference for just MALLOC()/CALLOC(), but I'm also ok with a
TEST_ prefix, my brain can adapt.  One of those two flavors has my vote.

