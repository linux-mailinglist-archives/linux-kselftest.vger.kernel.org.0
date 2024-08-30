Return-Path: <linux-kselftest+bounces-16755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1159B965682
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 06:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482321C21F03
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 04:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0114A603;
	Fri, 30 Aug 2024 04:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMW8dEAt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433313E3F5
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724992964; cv=none; b=LkrdLr8cenHgzvz7UlQHl47sbxvbIOxm246TcXpe+PoE9cn2eYp9HZz7EJuXZR7ntWgAwXnuQ3MeEe3mOUve8TBhlPxUkRs0Gy+oSQ0b9sJMQ9zQtypI+h06KY54f4cdo40O56ZJk0Dx96c1zNEaj0XJYoXtfDHqVw/lmjLXMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724992964; c=relaxed/simple;
	bh=qVZiTEd3P+CV2R2j735WaLbeS9pAFr9F9WZnKfAB2gY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NA5jY9Yu/xGBQAfPL64wH4vHHwlOB/RhC/jHIlrmgve5XfdwNl/Erz+XNCy0GTTy6Ewv94Pesp2u6dLjX7JhutzdwcWsu4TCpbIhwIELOq0Bpo3oCMw7oceASFA7PD19BmZtv1Gk5EpmqfovJKIeK64w1eDDURVHrCND/LIbDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NMW8dEAt; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7c6b192a39bso1167971a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 21:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724992962; x=1725597762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuwDmeiQxcz3+jOCRjgsCebKb1su6LiEDyHBdI6Iy3k=;
        b=NMW8dEAtn0TQYHb0EUZ55Upri64D2i38ahABLdWJNEzKbyu3/TwwSyOEgZ6UpZSbas
         OmbJhRJMr16QN1wAk9DrBLz71Aqw5iw90WW22bL9klOjH2E2s010GtmLFfK8VbzMdUll
         T/KDS+etA9akfFmt2glCCP+jyqHfEdRQsnPe1OxoLquADJV/ELcFDaeRjHZWp5ot4tbC
         VhzY51908dOUCwhRtfbY+UjLFV4I7Nw8chsHO7zOJqs6M3H4TT6mSO11P4XyU0hAczz8
         5ecHNunTB/gh1uYbx/H1ugfohjQ0fsDQMHL10imJ7VqUC/yfUB4iO4vmeb5BffZQQrUm
         RYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724992962; x=1725597762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuwDmeiQxcz3+jOCRjgsCebKb1su6LiEDyHBdI6Iy3k=;
        b=Coansa/6xatB8DJSj9e2weWuMzrvfJAzaAFsjxKy0Mw+JwW3AqZ1jutJrIMmMFa5Kd
         dvU8dNDY8CcZ0dpiMKIfQKGBPQKPMvSlZ1l4a51Jq6sStXAF6HIHy0st7T8T3WZy/U9n
         ufhmWOGUh1VNLyvciRE+GpXJCTSd3fXFXhSy2d5qp1f8rBSQxWmvyAc1GkqeX8rZQvpq
         Sqk1pHO3tda2IwXGEZ5otUn5NcISuNCFnijqLj79oayacKn672AmI7g6OeEGalJUbmm1
         6JfhELLA0mQhwTDHY58Q24SuR6Q7Zf4X8OKjKgnLwjCcQ/Ryzf99+UbeokAwkFog/l+b
         bQPg==
X-Forwarded-Encrypted: i=1; AJvYcCVP1UNN07HOnQeuZCWDDedSc78ml7G3NSyf93dXb5QtpghD4QbQ7l1g5rDvaZx9Rp6LF4GNY7mhpHitKny/Qvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGGBKYafPwZxUjH71q3CaZf6BpjHjM5hS8anD5YlJzJSXB/Ns
	pX8n0bjAx2mnvEIqMTXRCO4/5MMSWc/3ZlSx+P5PZK/xQMZUFoVyKB3eQKyoC3bHufMBlxICR+6
	WoA==
X-Google-Smtp-Source: AGHT+IEpfw0PKgJgqNKTHlMpWyrEsh7CSlO1i5Ro+hb2kbU92lKbF7kt84iFY1/jKRx5JiFvuUhbBUgOPDs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:d70c:0:b0:7cd:8b5f:2567 with SMTP id
 41be03b00d2f7-7d4c102e561mr1812a12.4.1724992961954; Thu, 29 Aug 2024 21:42:41
 -0700 (PDT)
Date: Thu, 29 Aug 2024 21:42:40 -0700
In-Reply-To: <20240829064811.GAZtAZqzWkmF79VOs7@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709175145.9986-1-manali.shukla@amd.com> <20240709175145.9986-2-manali.shukla@amd.com>
 <Zr-qkJirOC_GM9o6@google.com> <20240829064811.GAZtAZqzWkmF79VOs7@fat_crate.local>
Message-ID: <ZtFNwOG5oPwNF2bU@google.com>
Subject: Re: [RFC PATCH v1 1/4] x86/cpufeatures: Add CPUID feature bit for the
 Bus Lock Threshold
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	nikunj@amd.com, thomas.lendacky@amd.com, vkuznets@redhat.com, 
	babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 29, 2024, Borislav Petkov wrote:
> On Fri, Aug 16, 2024 at 12:37:52PM -0700, Sean Christopherson wrote:
> > I would strongly prefer to enumerate this in /proc/cpuinfo, having to manually
> > query CPUID to see if a CPU supports a feature I want to test is beyond annoying.
> 
> Why?
> 
> We have tools/arch/x86/kcpuid/kcpuid.c for that.

Ah, sorry, if the platform+kernel supports the feature, not just raw CPU.  And
because that utility is not available by default on most targets I care about,
and having to build and copy over a binary is annoying (though this is a minor
gripe).

That said, what I really want in most cases is to know if _KVM_ supports a
feature.  I'll think more on this, I have a few vague ideas for getting a pile
of information out of KVM without needing to add more uABI.

