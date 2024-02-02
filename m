Return-Path: <linux-kselftest+bounces-4053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A3847BF6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 23:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162881F2565F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA3483A1E;
	Fri,  2 Feb 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egDhDP92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402383A0C
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911434; cv=none; b=M7j06ZzQImlFRahcMnKhVnO4MNEZsiWZUOghEcQW3qfgv/qqaK4XoHgivnlyCAidGXRddU22QyRzfQVC8LgbISwKOnPUtIpKA5025fyHG1NT0LChgWiKMdCgbheqU0bedDVxCdCeIQoK4V+KIb6RfCHFe3Xex5lW8ybS62suJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911434; c=relaxed/simple;
	bh=mS6RlgWUtAgL4Hsb+bdLT8pfZr5Df9vOrkPpbDxrTGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KWUJo3znHtL0RNqYBzzhVJp2VN68j2q/gIEjvwxOGudnIWQObyz9pLErFVe4SuHiSNrJ+Z/oDK5HS7qHpGVxaH4SclWGhtQYYOS/Y6UrzBuakiXKvtJDaWI5uFt0BlhqKY/by1yE+Vz41pXrSAz7yAw8+TLvhjUvmy4iRlzPM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egDhDP92; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6df2b2d1aso2736258276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706911432; x=1707516232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fdyvAj2ceAkBq1V2vAT6+dViND/2+FyBMSAlIkBp4A=;
        b=egDhDP92CkyEhLQMUUJQi9i54Ya2Ny+HXpOSHFmGZj/bBitBTRKQK6FTgQQOIeprBa
         wVSkrmgIdjsK492V/2UgFf/EGiImq0/MC3/58OB9sVpOY64GOIHl0IEh7bvdHRZhIO7D
         ZLM0DFATGFLGS1Y8i0q5rmb93QzjeTOckrxS2BCXyE2lIG+nDXQSVm4pLmhWyOaw4kGr
         Dw8lks+mo55zrnYIcTQfHvm0Zc2+csjjjv8JOB8qDCPw3BE31luqS9LDsTJsz4+alIVK
         cIjN5gdCwqps52HwV2+JSGNjrC9AFrWNlv18dg2sSBQ6rxmUfO+9b3CXfBYDeVOtPHD7
         PCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911432; x=1707516232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fdyvAj2ceAkBq1V2vAT6+dViND/2+FyBMSAlIkBp4A=;
        b=q9UCTFf4GpC5aeU06hY4OR+EaECAkOt4qQvxjOaApdK0NLyma08kFlAWbl7fnW3jwG
         WlAS3FVHjwX8CMQb/Er9CZO046vXlr3NZh2gxS0gmYNV0dLOByx3QjT88crS9EX5DLbM
         mxLu9jJxtr+cxVw5uO36zCdLT1c6UcPeqpWpARfTe53RiDlLzmhm7aKTAGxQEu20MSrn
         0W+x1WkZndZZIneuHhmARJzYeOkOcW7c6zyOKXY2c3lRvnhA6I3eob1HnBLgoXBO+IAT
         HQPLNI/CfOE7EtQm/axZVIV2VJtB9iv2muBFasaEMBXOanfQy60lGv8UA4mMVhVUnyAS
         Gr2g==
X-Gm-Message-State: AOJu0YyeHysG9mXYmg3xK+2CG9+hayBMj4iCW4T6xMly42ZWjtwiIsfM
	qTJnk0JXblOecoDd0XB4oDiCzMgUFiiLlvKxfMo7yPcg9JTLp04QiMP4m/XEq2YxceNT+aaplTP
	UCA==
X-Google-Smtp-Source: AGHT+IFpPBhkfQUEm966eS1GQX2rrTrFBtCY3uv3k+mXuiT5na9D0Sj1i0Fisqxp9eDGDSeUa0YKmeBQquo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:240f:b0:dc6:4bf5:5a74 with SMTP id
 dr15-20020a056902240f00b00dc64bf55a74mr297595ybb.11.1706911431732; Fri, 02
 Feb 2024 14:03:51 -0800 (PST)
Date: Fri, 2 Feb 2024 14:03:49 -0800
In-Reply-To: <b45ee6cf-fa51-49eb-93ba-a54f4469470e@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <2b4d020c-08ba-46ac-b004-cd9cb7256bd9@xen.org>
 <ZbMIu84Zi2_PF9o4@google.com> <b45ee6cf-fa51-49eb-93ba-a54f4469470e@xen.org>
Message-ID: <Zb1mxTgzJRWLtofw@google.com>
Subject: Re: [PATCH v12 00/20] KVM: xen: update shared_info and vcpu_info handling
From: Sean Christopherson <seanjc@google.com>
To: paul@xen.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 02, 2024, Paul Durrant wrote:
> On 26/01/2024 01:19, Sean Christopherson wrote:
> > On Thu, Jan 25, 2024, Paul Durrant wrote:
> > > On 15/01/2024 12:56, Paul Durrant wrote:
> > > > From: Paul Durrant <pdurrant@amazon.com>
> > > > 
> > > > This series has one small fix to what was in v11 [1]:
> > > > 
> > > > * KVM: xen: re-initialize shared_info if guest (32/64-bit) mode is set
> > > > 
> > > > The v11 patch failed to set the return code of the ioctl if the mode
> > > > was not actually changed, leading to a spurious failure.
> > > > 
> > > > This version of the series also contains a new bug-fix to the pfncache
> > > > code from David Woodhouse.
> > > > 
> > > > [1] https://lore.kernel.org/kvm/20231219161109.1318-1-paul@xen.org/
> > > > 
> > > 
> > > Ping?
> > 
> > Sorry, I have done basically zero upstream reviews over the last few weeks, for
> > a variety of reasons.  Unless yet another thing pops up, I expect to dive into
> > upstream reviews tomorrow and spend a good long while there.
> 
> Hi Sean,
> 
>   Have you had any time to take a look at this?

No, I was hoping to get to it today, but that isn't happening.  It's next in my
queue after David Steven's "KVM: allow mapping non-refcounted pages" serie", so
hopefully Monday or Tuesday will be the day.

