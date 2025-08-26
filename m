Return-Path: <linux-kselftest+bounces-40007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370DB37474
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1748361444
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C05221282;
	Tue, 26 Aug 2025 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIwnczoE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BC30CD86
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243909; cv=none; b=p/TdTQmLwcNqWrprOn3hsRYlHb/ifO5FPBBRz/k2C2jEgBZ/su5oywJbmsdxUSVPucG1FtsxJbyULkXxSoR7KsOwEcf5vFmX+6KvOj94tGZeQziYD5PjUJSe6qH8qkeBP4UtQwa11CPpx4dgKnFXj5sCljda584N1/a07AnVOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243909; c=relaxed/simple;
	bh=CTMJf0x9Y4lC1Yx2gqC2G9l6CWMNnCXR8J8HWYvhDRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VBA4M/hxHzf2Bfb/E45iYmiQ6RydPSxud7eg/OBWeoEhBvMC6UAsnHHqWdIYdT/QOs9VmiqYOq+C0YWb1KbSwmVDvGIYb9FNzja8pb0JXsFd81OtR6UMtTN9tSrMdYW38OJZ7OWma6tdrY3hKKEfab6GTWJxm0+X+utrEcPgsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIwnczoE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32515e8e4cbso9274468a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756243907; x=1756848707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6RSfBZbzjlqDZ6g2evZXhO4UN2s2ZcsLX6EZtN8OCU=;
        b=GIwnczoE6vSGbhKx4pPHdW8DNcPb3hE6jiRj62WriJ857kfOANSbhmPAF6HieYtuNI
         Tr2WkTcq37maHFsEa2qEP5g5kpcuPT4ZY80bw3b5BtYDAPDVg4xTgogJlJXNyy76CrCB
         e4OC5Ena8bY/e39VHQBBRc1v6xpGi5fdiLdVPL8fiqN3Bjm7AgCu3rZewVjXE/+EWyLq
         uNX8NcSa9kCsY1grxTm4uG+Miqr3IN3/jGixsr3BdKB7dIdn6EhlbCf3qtEbFmS1wLFi
         qHyCMKj+i+DtgQXCpNKHeavEPWSNVJt9ibQ/W7Zfuvaf/8esHb07ZeO6xVCfXe4856gs
         7rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243907; x=1756848707;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S6RSfBZbzjlqDZ6g2evZXhO4UN2s2ZcsLX6EZtN8OCU=;
        b=R0/0+YhyD1n4XfsNTNTsobzhm0iuNaIca6ejaq2KitI0qHoLdMdN4cfHYm6S8+Bjrp
         Omu9b/b6uY2fYVU1shf1WN0AsQA0W8ZqORmdmjZZCb9LBD0vJAZjgpTl+EMxo/Sf0i4X
         CV99RzES/ruqPSpLXVPY/su3krVTqdEobZ88IwLqQ96YlDsByBrJGKaKXwmMyTFdeywb
         kE6xng/ygPfH1D5tzPbzr92pcrnzhN038w4pAZbokMyij4IZuhGuGw7tsBf/VptrV2iR
         W3751bwow2ixg7otvrAdTD7jKrKFA05RdPZz1AaHbGxY86x568N2OQ3ORMVpf20yMR61
         lZyw==
X-Forwarded-Encrypted: i=1; AJvYcCXb6SJC8wtS4Szsm2lLMXFUmIjkPtz78qhWhAW7mfmviitVzEHz5YVfmDzmmkdOoDdO6TjGXI7mHR/xflKoVIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOprQO+LcHnPeOUtdjUoFOnuVlH2/Hx59k3BjeoGseyhiezpoX
	MPHvnCR5Anr/mlZsF6CNF0aqD8myegjj3logPJNQfuE+1EucY3Qn7aOhisBDzDDdVjkBU1boJLR
	asbowcQ==
X-Google-Smtp-Source: AGHT+IEySkuuhaynZ0m/cSLC1ikqBNNsZdkfvVXazMWOeEnEUTq6/sJ6HZtbncnv+ik+NswQSWFlZWAaBAo=
X-Received: from pjbsv6.prod.google.com ([2002:a17:90b:5386:b0:31e:d9dc:605f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d92:b0:324:f6f8:7701
 with SMTP id 98e67ed59e1d1-32515e225a5mr23486092a91.4.1756243907485; Tue, 26
 Aug 2025 14:31:47 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:31:45 -0700
In-Reply-To: <CAAhR5DGeTQ4G-w2o5YCvNWkZZWFcXe=6rro+RcfhR18-4sT+PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-16-sagis@google.com>
 <aK3vZ5HuKKeFuuM4@google.com> <68ae1604a387c_300e8f2947e@iweiny-mobl.notmuch>
 <CAAhR5DHPMPOb2XCJodyNMf2RTQfTZpAaCGMg6WeWxSWPLtkO4Q@mail.gmail.com> <CAAhR5DGeTQ4G-w2o5YCvNWkZZWFcXe=6rro+RcfhR18-4sT+PQ@mail.gmail.com>
Message-ID: <aK4nwZ4FE1r8-GYd@google.com>
Subject: Re: [PATCH v9 15/19] KVM: selftests: Hook TDX support to vm and vcpu creation
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025, Sagi Shahar wrote:
> On Tue, Aug 26, 2025 at 3:29=E2=80=AFPM Sagi Shahar <sagis@google.com> wr=
ote:
> >
> > On Tue, Aug 26, 2025 at 3:14=E2=80=AFPM Ira Weiny <ira.weiny@intel.com>=
 wrote:
> > >
> > > Sean Christopherson wrote:
> > > > Ugh.  IMO, this is a KVM bug.  Allowing KVM_CREATE_IRQCHIP for a TD=
X VM is simply
> > > > wrong.  It _can't_ work.  Waiting until KVM_CREATE_VCPU to fail set=
up is terrible
> > > > ABI.
> > > >
> > > > If we stretch the meaning of ENOTTY a bit and return that when tryi=
ng to create
> > > > a fully in-kernel IRQCHIP for a TDX VM, then the selftests code Jus=
t Works thanks
> > > > to the code below, which handles the scenario where KVM was be buil=
t without
> > >          ^^^^^^^^^^
> > >
> > > I'm not following.  Was there supposed to be a patch attached?
> > >
> >
> > I think Sean refers to the original implementation which was out of
> > the scope for the git diff so it was left out of the patch:

Yep, exactly.

> /*
>  * Allocate a fully in-kernel IRQ chip by default, but fall back to a
>  * split model (x86 only) if that fails (KVM x86 allows compiling out
>  * support for KVM_CREATE_IRQCHIP).
>  */
> r =3D __vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL);
> if (r && errno =3D=3D ENOTTY && kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP))
>         vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
> else
>         TEST_ASSERT_VM_VCPU_IOCTL(!r, KVM_CREATE_IRQCHIP, r, vm);

