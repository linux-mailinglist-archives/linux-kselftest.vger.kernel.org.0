Return-Path: <linux-kselftest+bounces-3945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52D2845E95
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 18:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81F11C2623A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 17:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B35C026;
	Thu,  1 Feb 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmpgKxQV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574EE8405C
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808766; cv=none; b=OJ4eVQZY6gD2E2WLB3WisMZ3x+hXxuzWVmm4wEtrR8lNTapgQNBGv+SBtzxvFP9+mu62N/g8jwZAc3GTQ0B1vbN1kkfj5qoWAwhRMdp6/str44iV/0bYJRAo558XjWByMa8VTW8jX1nV2EyrPS41VUbwjaQ/jrV8slmSs0C3N8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808766; c=relaxed/simple;
	bh=MYQeElrn6RP0xY9MrtM5r3jpd3C3Jxbd1CwNKrqS/qk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UTR3fmUYH7ZJgc8oP0eO7JTX2FHxMZZKfWF25EO9skmHEBfVO353DvDDsnSGpXcid+x6kLeilnK/Wgkat+V8wNuHWuzgM1CPPvOamJpldhw/LCYdybh1W9kPfWoaakIXXdiSND4VrSg3XsEc/Ndq+5BxwiyqArhpyE7tkOIGnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmpgKxQV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cf962e1fcbso1204204a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706808763; x=1707413563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UD3/+3gzKT8fI1Ep9NTewT3g/cKMHmpNqtb0XSkLImQ=;
        b=nmpgKxQVvdoUqnFo/LTKfILhjMKZXfkEYE2niej15duz6hlc9dksQ6dU/l78O7MWNj
         63KFlkvuf/QY1BNozo/Q6bLZm7rSBekZA4cQ/dTc5Uii51G5A6P00Gg4EGGg4iCPlL1l
         2Wd1VnUqojZG+2nOF139BEge3bxBFX+hwCDmN/SIdAfKrT3wwcGj3MLznzex4lEmnHcX
         CNechPbqLcMNO2TNRzILih5BpjrPYSYRcToGMTu5U8TAow1PhAFqOz2uQLzhwIY1G5Wa
         pHqedtBYyOx22mFc5KOmfvN+inAaUtCfeh02f8n81r+wzif4OfUjcOks2PDtfb7t/MKr
         NMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808763; x=1707413563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UD3/+3gzKT8fI1Ep9NTewT3g/cKMHmpNqtb0XSkLImQ=;
        b=Kb4FU5UohtgVNVgF3urZHhZ5VXK1qorDScQdQ6aAyv4dRlj7r/4G+E9UmA3Tezq0yR
         8K1g7ayonQnFmqW06MtjM//X0T+D3GpVmI4oyYyG++sxofILcWY/UKcD9BNi2nC9Jzlc
         CqBVqtjsiPE6ebmp9t4+mG+C8SCS0oIPpRxmOlgSJqC0v40cZX3KgnX2H995ZBPDasau
         prfUzyypOArqESCst+BXAYjFETyRx2g21JnBsTvBJHnLnNgfBQscSOGQ8RjL/cJ+rVh3
         ddPAVXRHWClWYXwEnSiFDa8gqF0N6woiNMB88Hsi7waLAzdZ5TUPYf8Q8ssTbzkvBPek
         Lybw==
X-Gm-Message-State: AOJu0YzcnuHumyHCCFka20MueRro1kDxOWPpUgEsI2DUKEGrZYgbPe4Q
	pHu6rUGyXcsXpgHtf5ImhC+lfyr7HosQCG+fj8WKw79APS2AFrO9Rht7o5POhk4tpnWo5qiZaPo
	LrQ==
X-Google-Smtp-Source: AGHT+IEafkVK8au1j33821EYsvbAmBAx9/jzn80P/T05OUbLplyNFemMOeZYcdkVNujKPjTr+JBvyfZFE5k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6641:0:b0:5ce:474:352b with SMTP id
 z1-20020a656641000000b005ce0474352bmr12944pgv.5.1706808763674; Thu, 01 Feb
 2024 09:32:43 -0800 (PST)
Date: Thu, 1 Feb 2024 09:32:41 -0800
In-Reply-To: <510f3534-b076-4d23-b4b8-361c1f872d57@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117052210.26396-1-shahuang@redhat.com> <ZbQVRX3V1P-ZE2Wf@google.com>
 <510f3534-b076-4d23-b4b8-361c1f872d57@redhat.com>
Message-ID: <ZbvVuciX3HENjxQi@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Fix the dirty_log_test semaphore imbalance
From: Sean Christopherson <seanjc@google.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 01, 2024, Shaoqin Huang wrote:
> > >   	/*
> > >   	 * We reserve page table for 2 times of extra dirty mem which
> > >   	 * will definitely cover the original (1G+) test range.  Here
> > > @@ -825,6 +832,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> > >   		sync_global_to_guest(vm, iteration);
> > >   	}
> > > +	/*
> > > +	 *
> > > +	 * Before we set the host_quit, let the vcpu has time to run, to make
> > > +	 * sure we consume the sem_vcpu_stop and the vcpu consume the
> > > +	 * sem_vcpu_cont, to keep the semaphore balance.
> > > +	 */
> > > +	usleep(p->interval * 1000);
> > 
> > Please no.  "Wait for a while" is never a complete solution for fixing races.
> > In rare cases, adding a delay might be the only sane workaround, but I doubt that's
> > the case here.
> 
> If that's the case. I guess I should keep the current solution. Except you
> have any better solution, please let me know.

Unfortunately I don't have a better solution, and I don't have cycles to stare
at this deeply to figure out what how to make the synchronization rock solid.
Sorry :-/

