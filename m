Return-Path: <linux-kselftest+bounces-15289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3062951159
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 03:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C4D1C228B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 01:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F5FB653;
	Wed, 14 Aug 2024 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sloy322b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB3AD49
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597426; cv=none; b=SsbZdjBPO+HY6N1QFgoMYN3nDBDBirhkNBqxqv77+48Jo3G5Y+ZObWpGONjJPIG9n/7u9exUPiTLmY9F306LQ319aVG9MLzr7hULyYMaM3m5fdw3Z7Ye80l2W2f3IemhUKu/2dro1pDbngDoLHqa6uk3Tp7mTdqbZAwfkKi3Wm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597426; c=relaxed/simple;
	bh=/l0rXDlvw7NhjD2gM02gSHjD7vmJYerckruLlAuFmaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gqReJWAYXB+D9maWEuO2+6XdEPEF7Y5H7xQMyA3NrukqjS/3xhARzsu8Z572naUoR/G2GSYBImPgFMvpSpRZ9o3+fT5lsu6LKSX3vM3iL00Sl04JXy1MTuxnDB3SljLti8D7x2zbMSHeg+UuZtiP49HWsAKo9HzIFrAB/ZaI1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sloy322b; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fd72932d74so57151895ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723597424; x=1724202224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6GXHPkr3SYkJk/BjQwBdG1N86V9MTczoF7nIyPuYFg=;
        b=sloy322bjPljuN3JUyLo9gt8trnhqIIjr3GV/47Hde1uxkYEhLzWStZsYHSyZEYfid
         Y2awcIQ4KcVRzEoErYf90Q2RfMap6l6CJamS/gUJ2uWCBKS+Fp/ZXJhjZ8ELTzFOshqe
         lVUKqU8vOVf5Y7NjlbbUFtvyio3Uc5Kqbq6wEOQ2eJikVK+o8Yr7iOhnE+Lgv+jCbruT
         1+rVwpXvESAYXTzrkSEfekahRrShqkYKYT6Bn5I9tiValjFo0U8mngoFmIfJKAPETbpA
         9/n8K8Zx/Pzq9xA2CyGrB3OIXcKBWNAGt16j9d0tnyfBXbSwi3+waNr6xRkfg2tZ8RW8
         YKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723597424; x=1724202224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6GXHPkr3SYkJk/BjQwBdG1N86V9MTczoF7nIyPuYFg=;
        b=CB3olxxnHcooXq4H4veJJW+AROmHTLohbeRuE7FeDU9afwvc9hurncNYd4qv18HF4+
         WMRdfV3rZhE5XLoh59k29T6NdnWnlp+DeQ/jqPE1SpzT/dcwujTmMjQy6OwEhYy235me
         eAC8ly+iseCaFT2neidkVnATcOumkSjum+TsFmk3ERM5kg7Frggwm2hXh+DmZqI3rCic
         fGz96Y3UDO0n43MWj01O4ttxdG6mgZWCDK0yMgqbUnLdkYLSjNvw1i3ljpZYquxr+//f
         nCIbgQatzCB+1MYO5JeDGssFPAbiGlGs8TysSqrZYpdQFnLG3A9e+c6zmbT5d3uExzHW
         syDw==
X-Forwarded-Encrypted: i=1; AJvYcCVhJgxFzJd4pEacS/n4sXSD7n8eG5lug9adqYUF5zO33KLw9/lAVXIL3RwaxlylywzHqlwyB5wUrCYh2cqTC1pJRi8GkIvZKsZBSs0+yO9c
X-Gm-Message-State: AOJu0Yz+c/JX2EgyqFZOqOJGRd5p1cliQsXyzF2kmIbMBmJuDwmo4+2V
	jC95y/zGvd2Z/uvhaIPhXfg2emXuGqaZ+TSYtiit7cDB1lnPpotsjaNSLlrPCFdwxTVpWBUPBpe
	EvQ==
X-Google-Smtp-Source: AGHT+IFp+zkpt1P27X4CXq7C4fu6+sC7L/9JCX5CTa8notXBHyrfBfo5f7Po9lUup6Tm8E2ohsfwgwS1+Wk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:da8b:b0:1fd:6529:7443 with SMTP id
 d9443c01a7336-201d64b4f7bmr898275ad.11.1723597424379; Tue, 13 Aug 2024
 18:03:44 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:03:42 -0700
In-Reply-To: <gsntv8049obx.fsf@coltonlewis-kvm.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZruZjhSRqo7Zx_1r@google.com> <gsntv8049obx.fsf@coltonlewis-kvm.c.googlers.com>
Message-ID: <ZrwCbsBWf3ZxAH3d@google.com>
Subject: Re: [PATCH 0/6] Extend pmu_counters_test to AMD CPUs
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, mizhang@google.com, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 13, 2024, Colton Lewis wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Tue, Aug 13, 2024, Colton Lewis wrote:
> > > (I was positive I had sent this already, but I couldn't find it on the
> > > mailing list to reply to and ask for reviews.)
> 
> > You did[*], it's sitting in my todo folder.  Two things.
> 
> > 1. Err on the side of caution when potentially resending, and tag
> > everything
> > RESEND.  Someone seeing a RESEND version without having seen the
> > original version
> > is no big deal.  But someone seeing two copies of the same
> > patches/emails can get
> > quite confusing.
> 
> Sorry for jumping the gun. I couldn't find the original patches in my
> email or on the (wrong) list and panicked.

Ha, no worries.  FWIW, I highly recommend using lore if you can't (quickly) find
something in your own mailbox.  If it hit a tracked list, lore will have it.  And
if you use our corporate mail, the retention policy is 18 months unless you go
out of your way to tag mails to be kept, i.e. lore is more trustworthy in the
long run.

https://lore.kernel.org/all/?q=f:coltonlewis@google.com

