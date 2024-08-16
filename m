Return-Path: <linux-kselftest+bounces-15569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3979551C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 22:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA77286BE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8064E1C4624;
	Fri, 16 Aug 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdANXMol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2E1C2316
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723839279; cv=none; b=nUIe4Uk0nAtXS5xqr41KKuFKbpXqM2JbVStGBXKL8sKdYHTF6uV0IgfczjNnfbWpRbESVd06w8DQ1FF2X3wLZ3viK5tCWQKqlFdmRX033jsHi1XZ6TYWHpiC/8SMMoExxS06ECHigvif2/6BzeDHqYJBgh6hzplP+O2uxoRy6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723839279; c=relaxed/simple;
	bh=GeAnRofml4TZ+kvvmlgfZ55lOxNPhJUBy4V8C/B/ZqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gfhQeKd6TStwiF4l7NNfLXlDd7TdtYctbYroAKO5c6pomJxo9sNB0Gn2AT3JB47S4FxAMvUsYf/B3kj1bJ2yRdCmTqV15FEeAwGKyazhevcnJpSyVwNIYPb4GmMjv90tlyBQeQZknQzxpBWKFlYJLe2adR/maBGcMvAD7uw6vSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BdANXMol; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6643016423fso47753377b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723839277; x=1724444077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+XtCDie/e/YZHW8+kNYaqurEPTj7Ow0w++u4stXh78=;
        b=BdANXMole8Ga1RZYe63zJhtHbK+0JWX/u0ioYHRnH3w2KOe3Ds4Bt5b/SJiMPp7MAI
         xB8ZDO55khvDWxG2u3zkvGe1A5hVECREXxy+aopefjogC87Jv1Fm36PWiPQzdFno/KM5
         Z8717FKq0Y/O4jsVmhXmCKfsOvl5Xf151BEK9mbfVMCAc2aVvE43Yye2x+/SMSPgjgWI
         0hg7fShTGgQqAWRP71BOdPemQRiFtWZq4BMw6G6FP6Ft9FLYqzoz009wzmijcyR0TRwg
         dwRRGp3K/htfItDXvEqYK9qQ8krZVPBiqdIA3WaK487fCiTJHeWbwNiXpPARcHg93Jk/
         QU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723839277; x=1724444077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+XtCDie/e/YZHW8+kNYaqurEPTj7Ow0w++u4stXh78=;
        b=doJ5JWuSQ+wyyd8HR+J9T3JQKDNNVpNm8ymsMYBl9LQCAv9PHQixyhW29oQRpf9rpP
         +KA7PeQPUtuqkTunN8Azfu0Ss/7YTw74v6H/rF+wS52V3xi8rkQDD+pfh1LCfaAa3V8y
         A+Lk7fb0XVHJtmSzoNnn7Or+TtXQzspB5KYWMRdMEmoGJq6OvRYNMhV3HPlmvcQINz/5
         Fum/6xtxhzDO3+fPNyhSkEBKtf8MJ5OLgLcjaA24+IwenAy22sI9LAom4+CAKDmeksQu
         lzFlrs2UCC94cUxxu9uTIYflnLBJGAOupfhEcd8MoLYt2ISDRwtNhcz5s2oNa5YjgcjF
         +27w==
X-Forwarded-Encrypted: i=1; AJvYcCUXwDOnS529YJNTftZW5Bmh3y896a2rSOm4gQj3UpI+feNpyvy/4QDuvfHTiQmts3fQTIQVeufRXQF29LhxvkmG6fqtQECtNnefM9FDxMmg
X-Gm-Message-State: AOJu0YwtRg4x+ps7DHOrnFh58YaQwjQ3PlOMPJ1BTpyqE4luShOA6vCW
	dTYDS3qeNT/TS/FDI6LL+XYeLZMrszL0QTyNSXptn03A6Bl9Cwcxe0BZfBEnad25/FS91sKCi8f
	Zeg==
X-Google-Smtp-Source: AGHT+IEn0xrjMnM4QulWbssX4RrAsftMvx75CGPCnBBwK21YPQG+1/RpR21AOZL1IqoJlRRK/J08+9MhePw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2193:b0:e13:c454:166d with SMTP id
 3f1490d57ef6-e13c45417d9mr15526276.11.1723839276827; Fri, 16 Aug 2024
 13:14:36 -0700 (PDT)
Date: Fri, 16 Aug 2024 13:14:35 -0700
In-Reply-To: <20240709175145.9986-4-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709175145.9986-1-manali.shukla@amd.com> <20240709175145.9986-4-manali.shukla@amd.com>
Message-ID: <Zr-zKxHiaFbnKvw_@google.com>
Subject: Re: [RFC PATCH v1 3/4] KVM: x86: nSVM: Implement support for nested
 Bus Lock Threshold
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 09, 2024, Manali Shukla wrote:
> @@ -758,6 +759,16 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>  		}
>  	}
>  
> +	/*
> +	 * If guest intercepts BUSLOCK, use guest's bus_lock_counter value,
> +	 * otherwise use host bus_lock_counter value.
> +	 */
> +	if (guest_can_use(vcpu, X86_FEATURE_BUS_LOCK_THRESHOLD) &&
> +	    vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_BUSLOCK))
> +		vmcb02->control.bus_lock_counter = svm->nested.ctl.bus_lock_counter;
> +	else
> +		vmcb02->control.bus_lock_counter = vmcb01->control.bus_lock_counter;

Copying vmcb01's count to/from vmcb02 belongs in the core enabling patch.  From
KVM's perspective, the counter is associated with a vCPU, not a VMCB, and so the
count should keep running across nested transitions.

As written, taking only the core enabling patch will mean that L2 runs with the
wrong count.  Amusingly, because '0' means "always exit", L2 would run in a *more*
restrictive environment due to the VMCB being zero-allocated.

