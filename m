Return-Path: <linux-kselftest+bounces-7099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82320897361
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 17:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B071F22B7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 15:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7D149DE9;
	Wed,  3 Apr 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDvrYiSK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0B148FE8
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156740; cv=none; b=UoUsfkve9KIcKbud+n1L04JzyG/rYAY/TfxXkcfLFDlYj47gZg3P4qIjbmc5oKjU6WXOZYiEZRfjEkdBSfVvGm92SlWSwUO5PZ/r0Yct0P/FJS5PUQ4irP1r1B8Wwly+nnfMsR3xV8aBmP9A09aJnSdP7JKGZ+bBZgAqy2e8w1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156740; c=relaxed/simple;
	bh=deMENPl+c6MSxW2hu/QZ8GYeKyym0U74jnDvIEZWRPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqzDp03Sgy0mnf0O8CmrPJJw8ODuyWhOdwcz5vC4uHNC23O8PmqCiGObqb+G2ke9SR2BBWg0Y4dM1Y8qn36RvVmYmYFslphSA+gvBSYXH2Itoq0EYYD9fVKzUjpJhuSFV6IxAgq00caAaA98pJ5xWzP5+8+p4wiuFE1F/MK5ktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDvrYiSK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712156738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdTf2pSCOIaYn7Otxzx3C9HDo/HSUaFRAsJWaqzhTKw=;
	b=YDvrYiSKp7Br8a3FVMdmAGwDHx842NlZ0CN0qm8azdv2YzzN8Z4JI9InYQr35JPLWj+avm
	N0KHfWuqcGT5tSH1J9SbIxPmvUL4R0wjY7GA9bOW+opUNh8tnGCviMoLFG+Pxt1VuuLwhS
	YevJZBSTZOWqCfXVGHQbA5Wmjo6JzEo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-vxjWNBbPPnOwkeIjxQ0Jyw-1; Wed,
 03 Apr 2024 11:05:32 -0400
X-MC-Unique: vxjWNBbPPnOwkeIjxQ0Jyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3B773822552;
	Wed,  3 Apr 2024 15:05:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.49])
	by smtp.corp.redhat.com (Postfix) with SMTP id B6D1C4073487;
	Wed,  3 Apr 2024 15:05:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Apr 2024 17:04:07 +0200 (CEST)
Date: Wed, 3 Apr 2024 17:03:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20240403150343.GC31764@redhat.com>
References: <20230316123028.2890338-1-elver@google.com>
 <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx>
 <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
 <874jcid3f6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jcid3f6.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 04/03, Thomas Gleixner wrote:
>
> The test if fragile as hell as there is absolutely no guarantee that the
> signal target distribution is as expected. The expectation is based on a
> statistical assumption which does not really hold.

Agreed. I too never liked this test-case.

I forgot everything about this patch and test-case, I can't really read
your patch right now (sorry), so I am sure I missed something, but

>  static void *distribution_thread(void *arg)
>  {
> -	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> -	return NULL;
> +	while (__atomic_load_n(&remain, __ATOMIC_RELAXED) && !done) {
> +		if (got_signal)
> +			usleep(10);
> +	}
> +
> +	return (void *)got_signal;
>  }

Why distribution_thread() can't simply exit if got_signal != 0 ?

See https://lore.kernel.org/all/20230128195641.GA14906@redhat.com/

Oleg.


