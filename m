Return-Path: <linux-kselftest+bounces-23368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1209F1728
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 21:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6413161A27
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6B1F4272;
	Fri, 13 Dec 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEpVvHA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B891F1307
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120162; cv=none; b=gkecQPtW7cnX1YkV03TSs2dLsXz+SY1YPHXdjSkY7nnoxyj7K9XrY9jUCGq+5svgrnr8v45ea5xZ9XKhZu9+Q3qogD2Gcz8XfX3nUCIFPKT7R6ysp/x3n5cMTxv4yEBzrb/miQLjsdJFk3TdtwPQNlQaMmRZ2v8dKTYnyrHQmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120162; c=relaxed/simple;
	bh=yp16JfYOJAjDMSKK+eOq0yZ2g8bSBzM/k6h3YNYvfjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjlNilOkDuuMTAUB+rQHSKLFmkLQMPGC9D0w/CWmvXPnbhI7PE+ufNJ3ObFIHfAYJoyS11tYuVF/uBBK4mFTQahpncW2WgDLEe+7vj7tk4sj3CRJSGef0jD9m6p413EE3hB16KNEqCI86XkenSVTDl9jotzp18oTbVgVyTFnbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEpVvHA8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734120159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNS9SgQz3yNcrMP28OglAyAB/O22oVO5b3LG+xQhoiU=;
	b=KEpVvHA8oLrnIVZ3tQCqRHG4Aff7MOAVz0pn/YAMRm/7U8UKGPHtrba8gpg8GmMGyNVrfs
	P6S0RovaZ1rmp5KoX0xZGAqBAGI/hMNDvwEhT8PXOKSt11BsXBvRksJNVIrB4rBbC0xTDS
	jznk0bD7R+a81dUAL/7q5ZtedD21eTc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-sUEYFytiP8GX3pEJz7HGxg-1; Fri, 13 Dec 2024 15:02:38 -0500
X-MC-Unique: sUEYFytiP8GX3pEJz7HGxg-1
X-Mimecast-MFC-AGG-ID: sUEYFytiP8GX3pEJz7HGxg
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-72907f58023so1728843b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 12:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120157; x=1734724957;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNS9SgQz3yNcrMP28OglAyAB/O22oVO5b3LG+xQhoiU=;
        b=wHwWJ6/f8Qe3heZJELxOvgRxIUaipjTjMvTW4W3pVc5MAsmDGcir8fUNCtVXiEV10d
         lX6z4wN9b1hnrEmSlh4h2nsjsXjdhWmqMSBkXRYm+0SwcbugnRA5Xm93U9CIY1KidJyj
         WSraEmTqXnc4CajwMQLHN9wi8+Su+MZgbPJkSpb1gKwkeOzvSA74zSy5drrnSGVroGxc
         qB7XzOF2rgvZqWcNhbj2E+BN7pl5sK5vAayDRBEyyd/h3CF17DOGfi8rzDAGiAr4jO9F
         FZMbCiLBDFAAFOGAd9iydtcjSc/becAck7KzQvjqV3rVkNolBklJQhwBQ8xMtwN0Jzbb
         gqvg==
X-Forwarded-Encrypted: i=1; AJvYcCUPLsR7qYOL+5PXWixa75mhEsT3LMs0IBTRXkDlJtDCp198XBC0RZFD1YIMyFu9fHSlg8IIqSmcu7rieNNluxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCCEvF0uY7rwTNA8/5IWddZ5QNxdd5DoKJi7BIa1jAVoH8by7
	S+UhtkaSr4xqEqhg7CpVp+ukfjwZqtbCLh6L15XoXPxZeKM/nI1wIKqjhcNE89esl3bnRuTYHzi
	77BmD4QKjEAk6GIWmFKNfSOBQFVKp2IA5dYL8zdspjrHMqin5y+JujXBbm9s7qSdzXsiTdFEIjQ
	==
X-Gm-Gg: ASbGncvZDJqZY+GRq9H0M5kdNMsBEVeHlhWUmTO3bV54rBGO2bGZ079iEwVnsVdpV21
	vLcaMAOtQEsQxzaRx6kEtWUYOYPYEjUPYTlE1oKuLWWDVlI6eoL2ROaBFM18s9H/ss3s1nrrj2P
	YBeLAhXjM5UciWiBxIedsFkkV4cdFsE0CaA0UKBvui5h0lRcd138s+asnB2oUz570VYsA3joM0z
	hfAIIE/GWGsfj7eIhi66E01tgULfWOfkVPHMU+ebE9L7weOifSMlpOg
X-Received: by 2002:a05:6a00:c8c:b0:725:db34:6a8c with SMTP id d2e1a72fcca58-7290c1b276cmr5406182b3a.13.1734120156908;
        Fri, 13 Dec 2024 12:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMCPOjC5JSWjf3R4QtZ4+4SVXt0a9IhTKiDJkRFHtYQ8JcdI/GjFApb9BSMWlLoMfC40qpAQ==
X-Received: by 2002:a05:6602:492:b0:835:3ffe:fe31 with SMTP id ca18e2360f4ac-844e88489f9mr484065239f.8.1734119798817;
        Fri, 13 Dec 2024 11:56:38 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e03686dcsm37085173.7.2024.12.13.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:56:38 -0800 (PST)
Message-ID: <88706b97f374bd425da82e78789e6234cb6baed2.camel@redhat.com>
Subject: Re: [PATCH 1/4] KVM: VMX: read the PML log in the same order as it
 was written
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Peter
 Xu <peterx@redhat.com>
Date: Fri, 13 Dec 2024 14:56:37 -0500
In-Reply-To: <Z1vR25ylN5m_DRSy@google.com>
References: <20241211193706.469817-1-mlevitsk@redhat.com>
	 <20241211193706.469817-2-mlevitsk@redhat.com> <Z1ox4OHNT6kkincQ@google.com>
	 <a3e75091f2b6b13d4907ac2fdf09058ab88c4ebf.camel@redhat.com>
	 <Z1vR25ylN5m_DRSy@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-12-12 at 22:19 -0800, Sean Christopherson wrote:
> On Thu, Dec 12, 2024, Maxim Levitsky wrote:
> > On Wed, 2024-12-11 at 16:44 -0800, Sean Christopherson wrote:
> > > But, I can't help but wonder why KVM bothers emulating PML.  I can appreciate
> > > that avoiding exits to L1 would be beneficial, but what use case actually cares
> > > about dirty logging performance in L1?
> > 
> > It does help with performance by a lot and the implementation is emulated and simple.
> 
> Yeah, it's not a lot of complexity, but it's architecturally flawed.  And I get
> that it helps with performance, I'm just stumped as to the use case for dirty
> logging in a nested VM in the first place.
> 
> > Do you have any comments for the rest of the patch series? If not then I'll send
> > v2 of the patch series.
> 
> *sigh*
> 
> I do.  Through no fault of your own.  I was trying to figure out a way to ensure
> the vCPU made meaningful progress, versus just guaranteeing at least one write,
> and stumbled onto a plethora of flaws and unnecessary complexity in the test.
> 
> Can you post this patch as a standalone v2?  I'd like to do a more agressive
> cleanup of the selftest, but I don't want to hold this up, and there's no hard
> dependency.
> 
> As for the issues I encountered with the selftest:
> 
>  1. Tracing how many pages have been written for the current iteration with a
>     guest side counter doesn't work without more fixes, because the test doesn't
>     collect all dirty entries for the current iterations.  For the dirty ring,
>     this results in a vCPU *starting* an iteration with a full dirty ring, and
>     the test hangs because the guest can't make forward progress until
>     log_mode_collect_dirty_pages() is called.
> 
>  2. The test presumably doesn't collect all dirty entries because of the weird
>     and unnecessary kick in dirty_ring_collect_dirty_pages(), and all the
>     synchronization that comes with it.  The kick is "justified" with a comment
>     saying "This makes sure that hardware PML cache flushed", but there's no
>     reason to do *if* pages that the test collects dirty pages *after* stopping
>     the vCPU.  Which is easy to do while also collecting while the vCPU is
>     running, if the kick+synchronization is eliminated (i.e. it's a self-inflicted
>     wound of sorts).
> 
>  3. dirty_ring_after_vcpu_run() doesn't honor vcpu_sync_stop_requested, and so
>     every other iteration runs until the ring is full.  Testing the "soft full"
>     logic is interesting, but not _that_ interesting, and filling the dirty ring
>     basically ignores the "interval".  Fixing this reduces the runtime by a
>     significant amount, especially on nested, at the cost of providing less
>     coverage for the dirty ring with default interval in a nested VM (but if
>     someone cares about testing the dirty ring soft full in a nested VM, they
>     can darn well bump the interval).
> 
>  4. Fixing the test to collect all dirty entries for the current iteration
>     exposes another flaw.  The bitmaps (not dirty ring) start with all bits
>     set.  And so the first iteration can see "dirty" pages that have never
>     been written, but only when applying your fix to limit the hack to s390.
> 
>  5. "iteration" is synched to the guest *after* the vCPU is restarted, i.e. the
>     guest could see a stale iteration if the main thread is delayed.
> 
>  6. host_bmap_track and all of the weird exemptions for writes from previous
>     iterations goes away if all entries are collected for the current iteration
>     (though a second bitmap is needed to handle the second collection; KVM's
>     "get" of the bitmap clobbers the previous value).
> 
> I have everything more or less coded up, but I need to split it into patches,
> write changelogs, and interleave it with your fixes.  Hopefully I'll get to that
> tomorrow.
> 

Hi!

I will take a look at your patch series once you post it.
I also think that the logic in the test is somewhat broken, but then this also 
serves as a way to cause as much havoc as possible.

The fact that not all dirty pages are collected is because the ring harvest happens
at the same time the guest continues dirtying the pages, adding more entries to the
ring, simulating what would happen during real-life migration.

kicking the guest just before ring harvest is also IMHO a good thing as it also
simulates the IRQ load that would happen.

we can avoid kicking the guest if it is already stopped due to dirty ring, in fact,
the fact that we still kick it, delays the kick to the point where we resume the guest
and wait for it to stop again before the do the verify step, which makes it often
exit not due to log full event.

I did this but this makes the test be way less random, and the whole point of this
test is to cause as much havoc as possible.


I do think that we don't need to stop the guest during verify for the dirty-ring case,
this is probably a code that only dirty bitmap part of the test needs.

I added Peter Xu to CC to hear his option about this as well.


Best regards,
	Maxim Levitsky





