Return-Path: <linux-kselftest+bounces-30495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2946A8501A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 01:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F554A81BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 23:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0BB212FB0;
	Thu, 10 Apr 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxAOJadv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEFB212FAC
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744327552; cv=none; b=ZmEBRB7WtZ9/8U/p9xZ0eV5s8oVvTwpvoGHUmv5qf/n3a13r1uSnNu1IAfGhj8z1Z+gEA/q2y+ukv6qaPShfRwuryDDc1Bh/eivBSDBIn1lk5ErkqZElclXD0N0FO+As3xr0w/umsWnHJ2iawaoqHoPeSPs0D0BcLfeZUZ+6LF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744327552; c=relaxed/simple;
	bh=H3TsOvV/0/nhWyZg2M7TYMQ+w/e4B+1Zkq90CxwF9W4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nqK/KCEvF8Zc45M8VdzMQzBI3smE7YN8s6/xbg4IgTzAPb+HBAslUOLjqDxQdoOOyBK2FfflMrpD5X0NDZdpt8EwT1hmfJlhCTv1aWL8CLQLFMezEXilobyVmdh4JqBXLI92xzde+9nXZq5h1hyOKx6blkplHcNl7yaTsgos6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxAOJadv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso1907569a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744327550; x=1744932350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=45GeH+UPAzqkTZWqY2D6RQOKWswLealJ3SJB/kaSl38=;
        b=hxAOJadvxY/o6qSJUrY3SgYg1u0rSD8gZ35fL/bINs3GQ3oJg19xhQdXxwhbzzEKXy
         Xuaol3ricT1ucLF8LwpHkksv4iY4awJ1fxlrXGAOtxRgyRbIQg8f1RYx5lJWHfOfUgjb
         SayB365bU2paywK395MkdqZTDpIbtr8f494ropcnS8aS+mFYMipvUcjV/MdLbrF5uVOr
         RhbtFatq/zf55Czy7Q/oyckcyPRTOOsOfntl0h7ZK3FJrB5AQ7nS4Z+K1hCeg6GvvmUv
         EMwiqLZne1ArWayDpPeKtK9LJfe6Q42doPQue09fO8C/gbz7eK6e1+9Ncq+D6BSd7Kqs
         U4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744327550; x=1744932350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45GeH+UPAzqkTZWqY2D6RQOKWswLealJ3SJB/kaSl38=;
        b=tplpgG1sEt02NkWeLvBkGcukExxkpDLVmi4T1uHTaWjKm9Jj4XSiTQQ4QaTCwNCh2/
         xigHek8VzyushUDyvnNxzszhF2NEvRB6wQ7LyNYGVM97ylDJJ6AhJKtiulxbrxwraviT
         fZgU1PYNZ2vm1eap4fYPaDMoEGruxGBJbvEZJ8EB8ijg+BnWzNgE1haGgvFJa2YZ5Nt1
         1qORR069tu323fHccvB/6KMygYQGU0mzYmmNP8ezYutTde3hcLGDyJ9bw5XdO7danOMJ
         gHfhVQTfB54tmLQ/PDY+HWfA6Pr7luEIq/rPTqEEIj+OfCc6sw0qFCq8+h6kt2TJUaQq
         Hj+w==
X-Forwarded-Encrypted: i=1; AJvYcCU5v52PTuj+1fefReU/vOXfhnhqkGJOImokDReYHp0Z5U+DysfxeG/huK440xfp6G/nhEubm9k35eHhpyGGQo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYoZih2TAWVWln6ZfxGDO77xZhLJmcG47Kl2CgA8/9+odINVkX
	sYT5UXetcwR9FNObIqmLXDdET3zW4FNr3XyRsRC4DXKNFhgAKl6uIPvI2EkPXrLF3FR2Lp1jjWK
	0Jw==
X-Google-Smtp-Source: AGHT+IEZ5sbPrSHp5oZ7gTc+BwY7HnP33HbH3PjY0vlVaCfeHGvod6/yAfGEhOKi6txlF/yqz03B5IxKNWI=
X-Received: from pjbsh4.prod.google.com ([2002:a17:90b:5244:b0:2fa:2661:76ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2543:b0:2ea:bf1c:1e3a
 with SMTP id 98e67ed59e1d1-308236343e4mr1425746a91.12.1744327549848; Thu, 10
 Apr 2025 16:25:49 -0700 (PDT)
Date: Thu, 10 Apr 2025 16:25:48 -0700
In-Reply-To: <20250409092147.GAZ_Y8K52Opcw2X-tg@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-3-manali.shukla@amd.com> <20250324215627.GBZ-HVC-KmZiTMxPr3@fat_crate.local>
 <55986a72-1be4-4e96-809c-dd004291df2e@amd.com> <20250409092147.GAZ_Y8K52Opcw2X-tg@fat_crate.local>
Message-ID: <Z_hTfFupiBFPHwVe@google.com>
Subject: Re: [PATCH v4 2/5] x86/cpufeatures: Add CPUID feature bit for the Bus
 Lock Threshold
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, nikunj@amd.com, 
	thomas.lendacky@amd.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 09, 2025, Borislav Petkov wrote:
> On Wed, Apr 09, 2025 at 11:30:56AM +0530, Manali Shukla wrote:
> > Do you have concern with the decision to expose the flag to /proc/cpuinfo?
> > 
> > The decision to expose the flag to /proc/cpuinfo was already discussed in 
> > [v1]. As suggested in the discussion [v1], I have added "buslock" to be
> > enumerated in /proc/cpuinfo.
> 
> If you mean this:
> 
> https://lore.kernel.org/kvm/20240709175145.9986-4-manali.shukla@amd.com/T/#m1dc7e08c54dd91d53a6bc5b1ed0a6721b356a756
> 
> I don't see any conclusion there.
> 
> I see Sean wanting to export information out of KVM to say what it supports
> without adding user ABI and I don't know how far that has come

Not very far :-(

> but what you're
> doing here ain't it.
> 
> Just do:
> 
> #define X86_FEATURE_BUS_LOCK_THRESHOLD    (15*32+29) /* Bus lock threshold */
> 
> and then later KVM can export this however it prefers.

+1

