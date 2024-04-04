Return-Path: <linux-kselftest+bounces-7202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FBB898B51
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 17:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42623B313FD
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485612A166;
	Thu,  4 Apr 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDIwCxM1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28C1C2BD
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244352; cv=none; b=mzNl7gHNMVk6UBL1tiaddTjwMiXhSRafKvbjMEEoC79jP7e5H/lRAv2wsTNkuHleRuR/zqRfM7aS0tg0b6Wu9KiFym7MY/1cUem4YjclsCjITm1DFI4sflgA1cw0QbAl00evVDPMbE5saOusU05MLkecWB9nuSdJPjpSMFGL4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244352; c=relaxed/simple;
	bh=EyANxchTUq4vCZ8B0GlMj1ALpGGfgcRd78F9nkanEmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2PSttprpYjhPE7rXpAimvmAthgzJJDcENXXWvnN/nbr5ottoJZU5asheA+PBymneHq+8ih76MwLyrHtgJqBV3ao0wMrC9DkFc0mY4WUcnaApXyHj53TzFNjyIry/v21C+kFlgWNUDdPLK0bE/HM7it9hQeUFD4ogekX+H/3Gdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDIwCxM1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712244349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyANxchTUq4vCZ8B0GlMj1ALpGGfgcRd78F9nkanEmk=;
	b=HDIwCxM1mlIhWSQnnvgRtHGY+2dM2SrmBPZXnh9IHUzPZN/YyVZiAvG5d41qZxXMuw0LAk
	Buq3v7AFEOVr95CMVXUUWCpW3eiQK3krlLfS99VEANIhRFfblFi1pMi0X62SVxHstqCNjz
	cULxz3w1BHBMZJCdWBtPlYDAMGVbkLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-tUm63H4bOu2bbGcK_ijisg-1; Thu, 04 Apr 2024 11:25:46 -0400
X-MC-Unique: tUm63H4bOu2bbGcK_ijisg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE27680C76B;
	Thu,  4 Apr 2024 15:25:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.21])
	by smtp.corp.redhat.com (Postfix) with SMTP id BAF1D40735E2;
	Thu,  4 Apr 2024 15:25:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Apr 2024 17:24:20 +0200 (CEST)
Date: Thu, 4 Apr 2024 17:23:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Vyukov <dvyukov@google.com>, John Stultz <jstultz@google.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20240404152356.GE7153@redhat.com>
References: <20230316123028.2890338-1-elver@google.com>
 <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx>
 <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
 <874jcid3f6.ffs@tglx>
 <20240403150343.GC31764@redhat.com>
 <87sf02bgez.ffs@tglx>
 <CACT4Y+a-kdkAjmACJuDzrhmUPmv9uMpYOg6LLVviMQn=+9JRgA@mail.gmail.com>
 <20240404134357.GA7153@redhat.com>
 <87v84x9nad.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v84x9nad.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 04/04, Thomas Gleixner wrote:
>
> On Thu, Apr 04 2024 at 15:43, Oleg Nesterov wrote:
>
> > And this will happen with
> > or without the commit bcb7ee79029dca ("posix-timers: Prefer delivery of
> > signals to the current thread"). Any thread can dequeue a shared signal,
> > say, on return from interrupt.
> >
> > Just without that commit this "eventually" means A_LOT_OF_TIME
> > statistically.
>
> bcb7ee79029dca only directs the wakeup to current, but the signal is
> still queued in the process wide shared pending list. So the thread
> which sees sigpending() first will grab and deliver it to itself.

This is what I tried to say above.

> What we can actually test is the avoidance of waking up the main thread
> by doing the following in the main thread:

Hmm... I think it can be even simpler,

> I'm testing a modification which implements something like the above and
> the success condition is that the main thread does not return early from
> nanosleep() and has no signal accounted. It survived 2000 iterations by
> now.

Yes, but please see a trivial test-case I sent you few minutes ago.

Oleg.


