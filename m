Return-Path: <linux-kselftest+bounces-4221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6366584C42B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 05:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FD32860F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 04:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E243015E90;
	Wed,  7 Feb 2024 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gys/lQW8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4803F9E4
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281251; cv=none; b=TOrhHSpW0tHcu6VJ8FU2Ax/gooqinqaJsaJP6ORcMq93QiVa1nGJT1LCqg5cSl3ybZspRCDrZqIztzs/IgwRaA0e4LnIOeTyuaKEn3MkpYSYT+jMtL7c9n3LHu/T3Mhv9ah03UW+ad78gw9iKXScKdX/BPkaJk5zpZvf6krV1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281251; c=relaxed/simple;
	bh=zVn982hH7Ke/vzoOh5ZD3uQcFpFgpzxTNq2oZsY6+R8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pHrw1y/qW35LxDu5kmVsy/utZpOPayOfXm67BOw+95qUvc2tOLDZExNEPBFbsAmnQ0pu6S32nJwspSmvLIVeNFS1ROpeosJjppxRzS3lv7rL+ywrAgyTRBz38rwNexK+tPgRm19FSZeMtG11/UMA7ddfoPlzhn3kWdOq3VCjwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gys/lQW8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e05f5ca521so298888b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Feb 2024 20:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707281249; x=1707886049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hce16hi5r9jaUuXKSD0hh20zF7wxE3dX5YfP7OrTZb4=;
        b=gys/lQW8YfQmrkLJoBp86Eum0xZhgZ+v5OncAqSztvsC5khBy5v2RGB4aUEzFnIgk4
         C9HX1U0WsOd45rhXGydJ56F81M3L6267g2cXzqPJSfkofk2natin9TgBUFpQF/w1hYoN
         ctthTQt58/hAii2J7YVdIXrD10HHIwIQinU2dkB9+BgNA8mdlcn6OaYbNjcmYDb1/6j/
         VmFSm7r0U2YWWSmihZLk0sYGHK7nJKgxzJQrGrGPA+xOLWmJtFxBPXnXRKXhPogVWfMW
         0SnsdjQ5NAYiSz4DwkiA5ZMtZ3zMdEW0wewtT/MNJyf3oJQxThQ+dtuxYD2QdxxUKfFX
         dOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707281249; x=1707886049;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hce16hi5r9jaUuXKSD0hh20zF7wxE3dX5YfP7OrTZb4=;
        b=K7PjTiFW1Bv1gPPgbr2/Jv8Pjs6ZI6+Hkq4RmNus0rPhF/q+simqC08qsmc0Fm5uHQ
         6yRhV5lLvbKkAWDwR7KyUJ1CjWufGTIAb+v2CrP/A5HvjCqBRVFKDAbfYopEc+hSKY+a
         vsUBsrH7xOdATnn6ShQkh/M+2YX4tw+zZHvf/ESzYlZRlMzSil+rNfv/DJAUCbb/9+X+
         EVNWn+mPHvp72YRFVwOdv+ZcrJHmLl92VUuL40ASqNLqDZvv7z7+sE3FxqaiLXjLG2ag
         kCryi0A+W9Znk7NTf80WS7y/EmKnGoGnOEJls0fihoqsrxVRZ0c9MYcMY+OX2T6+FKzm
         Bbxw==
X-Gm-Message-State: AOJu0Yx/e+swI79FwDEIGr+bVn8bIRJ10KylzyepOkAGyd8QioKrszsC
	zbqq5DSmenDK3MbRYjqdCstfrLMIgZkomBraQtGQbAIB/WJxXoiZ9i5OCHypgxj2K43JbpUFUft
	Skw==
X-Google-Smtp-Source: AGHT+IHOtCRehbZtHsAa7NpCRjLddtbcXtsuH9JvGtC84ZtFgB4Ud45nzb/nMv0+xQil+doHPtCdJSM5upE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d8a:b0:6e0:610f:33b3 with SMTP id
 fb10-20020a056a002d8a00b006e0610f33b3mr98869pfb.1.1707281249550; Tue, 06 Feb
 2024 20:47:29 -0800 (PST)
Date: Tue, 6 Feb 2024 20:47:27 -0800
In-Reply-To: <bbd59a2c0897d8ca642ea8c4787b829190e75a4d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-19-paul@xen.org>
 <ZcMFb1epchA7Mbzo@google.com> <bbd59a2c0897d8ca642ea8c4787b829190e75a4d.camel@infradead.org>
Message-ID: <ZcMLX5Omum3riZe8@google.com>
Subject: Re: [PATCH v12 18/20] KVM: pfncache: check the need for invalidation
 under read lock first
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024, David Woodhouse wrote:
> On Tue, 2024-02-06 at 20:22 -0800, Sean Christopherson wrote:
> > On Mon, Jan 15, 2024, Paul Durrant wrote:
> > > From: Paul Durrant <pdurrant@amazon.com>
> > >=20
> > > Taking a write lock on a pfncache will be disruptive if the cache is
> >=20
> > *Unnecessarily* taking a write lock.
>=20
> No. Taking a write lock will be disrupting.
>=20
> Unnecessarily taking a write lock will be unnecessarily disrupting.
>=20
> Taking a write lock on a Thursday will be disrupting on a Thursday.
>=20
> But the key is that if the cache is heavily used, the user gets
> disrupted.

If the invalidation is relevant, then this code is taking gpc->lock for wri=
te no
matter what.  The purpose of the changelog is to explain _why_ a patch adds=
 value.

> > =C2=A0 Please save readers a bit of brain power
> > and explain that this is beneificial when there are _unrelated_ invalid=
ation.
>=20
> I don't understand what you're saying there. Paul's sentence did have
> an implicit "...so do that less then", but that didn't take much brain
> power to infer.

I'm saying this:

  When processing mmu_notifier invalidations for gpc caches, pre-check for
  overlap with the invalidation event while holding gpc->lock for read, and
  only take gpc->lock for write if the cache needs to be invalidated.  Doin=
g
  a pre-check without taking gpc->lock for write avoids unnecessarily
  contending the lock for unrelated invalidations, which is very beneficial
  for caches that are heavily used (but rarely subjected to mmu_notifier
  invalidations).

is much friendlier to readers than this:

  Taking a write lock on a pfncache will be disruptive if the cache is
  heavily used (which only requires a read lock). Hence, in the MMU notifie=
r
  callback, take read locks on caches to check for a match; only taking a
  write lock to actually perform an invalidation (after a another check).

Is it too much hand-holding, and bordering on stating the obvious?  Maybe. =
 But
(a) a lot of people that read mailing lists and KVM code are *not* kernel e=
xperts,
and (b) a changelog is written _once_, and read hundreds if not thousands o=
f times.

If we can save each reader even a few seconds, then taking an extra minute =
or two
to write a more verbose changelog is a net win.

