Return-Path: <linux-kselftest+bounces-18663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AD698AA64
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948F528347B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6746319342B;
	Mon, 30 Sep 2024 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SteVKDgc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F8193070
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715394; cv=none; b=puV9DEFEQnu5yjQuUO+OgF80bEMo1vsHGou17luq5aIGBnPEkbchJzd+sF0K9JURThHn4YnSPr9Y+nZO4XdVA16JqQWkkCKt0sFYbodnTPKFrvHPKZCezDfRWIyWh4r0clZ8RDv/vsrE+F7cnQoXbPVOJIMpj7kcKkLBjtxMPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715394; c=relaxed/simple;
	bh=bmuEUyqk2bT1c3O+xO2sNPpOqDNsTNasFyYcsnwXMAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MY2P2tfcLYMlWKQMJX8IQYimWC3ipDn+w4g648wtv+iR1m5DMoTuT4uB1yQuL/XWVOtKYkFwyW60G6oAVrkT+2xiPmQTQQF9SKER/RgwtdKDXYpgS8o6/sX3ezwzn9kCrdReieMm/HnBoWn0ZTxqKEC2VCNl/XYnXHdG65kPpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SteVKDgc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25d62bfe12so6622314276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727715392; x=1728320192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmuEUyqk2bT1c3O+xO2sNPpOqDNsTNasFyYcsnwXMAo=;
        b=SteVKDgc4uqeIQW9aTFTUWbIU6JfB+PItmEUiuqHqPA4Ey2K2rZRC/OjKvoEcC2OZG
         XyHia6vx/s0yDj5gNTQth0RuJT+Uzx5WLRH4hzq9LiY90sKDMU7ynP9Bly7pv/AJCVCD
         hKaX0jXk1NTcpooWAMfaU00LstQwU9esg6MO/e9Bkb2afeuNSvNkVLowG+6fFzA7sV+X
         Qzo9rYAoZVIGLRaTGwZEzt2E90qrgzrsDs+aasGkxXiwlCFswWvygUAzNOy2uQCLdgmJ
         Y8CanrcWug44CUXq1cE/N/6HzevU+F5YvS9vNNFwac7BKdpNZ1miLWVpSrVWedf34oQu
         yi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715392; x=1728320192;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bmuEUyqk2bT1c3O+xO2sNPpOqDNsTNasFyYcsnwXMAo=;
        b=KlUkvV4aeqSPlcoSrlWTX25iSvsb3ar3EPd0wIiMml2KXRjO7O8L6R2P60d5c45X5I
         Szicdhq1f2g4KAU8FEzmYRR5vGZx8u7YhW2Wo4ynEvtJW327+4jNS/XbkqGlWB9mlEY3
         zKQl6IqS0F2m905tduz/7cmUnFpKF22Hf66GmvSAdcnybM4OWLkwyvIF/6YjGxub4QE1
         VzVZEGO8SPMX6hUauV6SvPQky78SpaqRNiM4cBPMREdQ15AtvOaNdEBmzU84PN2OOc4T
         iH8A1PJMpeAmSwcMUjtP+XXm7//N498SP41zvM/efgiYTIdblNj+HxFTq3IJLvU3o/7C
         bz3w==
X-Forwarded-Encrypted: i=1; AJvYcCW2KhmU+/dI8vWFXW4xLFI3OR5AX0pKNsQfF2SFWB9KxC5lBnA4f8+vZz9kMICS+6SeTHjia1BwuBkuP49nv5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywze8uJovQavWuZOCtNx3bdvv+5hZucK2jJsCR6Bm+Ey4dYb2YH
	MUhE/A99gXedlUfU5XlXInvisGeeVBqeQ75F0Jj9ITQj2KALZFlxGRFg3f1JkjPhNUz+u3TKEDH
	Bzg==
X-Google-Smtp-Source: AGHT+IEC5NPofYVzP+Wzs2dXMq4oR3r2G7SGyWOX8ZxrYfWVkpnj7bsqqKMZB753besVJFViOSuQTmArTz8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2e4d:0:b0:e16:4d66:982e with SMTP id
 3f1490d57ef6-e2604b436d5mr59541276.5.1727715391824; Mon, 30 Sep 2024 09:56:31
 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:56:26 -0700
In-Reply-To: <208429ae-d9c5-4b73-86ff-a9b31e68f7eb@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-8-xin3.li@intel.com>
 <ZiJzFsoHR41Sd8lE@chao-email> <ZmoT0jaX_3Ww3Uzu@google.com>
 <feefa9d1-f266-414f-bb7b-b770ef0d8ec6@zytor.com> <ZuNJlzXntREQVb3n@google.com>
 <d65e62d2-ca64-4b29-8656-bb8411fe837d@zytor.com> <ZvQaNRhrsSJTYji3@google.com>
 <496a337d-a20d-4122-93a9-1520779c6d2d@zytor.com> <208429ae-d9c5-4b73-86ff-a9b31e68f7eb@zytor.com>
Message-ID: <ZvrYOj0Nn9m8VIWV@google.com>
Subject: Re: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Chao Gao <chao.gao@intel.com>, Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, shuah@kernel.org, 
	vkuznets@redhat.com, peterz@infradead.org, ravi.v.shankar@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024, Xin Li wrote:
> > > > When FRED is advertised to a guest, KVM should allow FRED SSP MSRs
> > > > accesses through disabling FRED SSP MSRs interception no matter whe=
ther
> > > > supervisor shadow stacks are enabled or not.
> > >=20
> > > KVM doesn't necessarily need to disabling MSR interception, e.g. if
> > > the expectation
> > > is that the guest will rarely/never access the MSRs when CET is
> > > unsupported, then
> > > we're likely better off going with a trap-and-emulate model.=C2=A0 KV=
M
> > > needs to emulate
> > > RDMSR and WRMSR no matter what, e.g. in case the guest triggers a
> > > WRMSR when KVM
> > > is emulating, and so that userspace can get/set MSR values.
> > >=20
> > > And this means that yes, FRED virtualization needs to land after CET
> > > virtualization,
> > > otherwise managing the conflicts/dependencies will be a nightmare.
> > >=20
>=20
> I still plan to send another iteration of the FRED patch set for review,
> however I haven't seen your x86 KVM changes land into Linus' tree, it
> will happen soon, right?

Yep, we squeaked into rc1, the pull request to Linus was delayed because of
travel and conferences.

