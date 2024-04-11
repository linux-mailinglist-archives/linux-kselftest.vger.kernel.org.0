Return-Path: <linux-kselftest+bounces-7711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1858A1B30
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 19:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27438B33731
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED054BEA;
	Thu, 11 Apr 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjwyaDQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B72BB1F
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850755; cv=none; b=j3Xz6ptp7h5K6Jxpa2Ov7gN9dvHKv55ThUhmTVeeYCICgpnxpkjnpwuld+Q5oJuChNNZP0jqYxaT3wcPJR6VhYKNIdudtqO0cF3uY4UUItyJX8buxnoH5uASP1jc78HLGDBrJBFKk1Z9f5VD7ROQuPAVWuPZjacVu5+ckM4TMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850755; c=relaxed/simple;
	bh=nDZMCq6OOx0OiVELF/ddgdMVhELl/RKgZdcDQsB7ojI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnYR91ERXbcY0z+rcHNZw+Cpnt3uYtAidA20pqCApF3Eqicq/z+W3klJpAniHIFocOYyt8Xde4eVeaLD3yaQjzkRfJ3VoWpx26GuJmJHN3pzlvikcgcgVwAMKZAdLMvnFuFZTymP1MY7tns9SAv8WnazyO729zFbI1+ve6ZiybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjwyaDQ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712850753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QCBZYuEx8E6Ilt7WeXhmEcjbf72dLVjaYQUFG/SF9i0=;
	b=MjwyaDQ4zMwpLwQYMH3YA2/XdbwZ5AmUA7LgsVuJZl7g8ZMop3A/zmalt6BM0Tv6JnIoZi
	5c+779DfJiSTbOl6xdP6ofwY6FEyNqmy4WyukL0eX871cWSszAq/+BvMefzZe62oPMom5A
	Y7vzIxF9vmrm74BqJHUeX4qaZDyUgTY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-0IQtr4SfPViOJ6MMcKm6dw-1; Thu,
 11 Apr 2024 11:52:28 -0400
X-MC-Unique: 0IQtr4SfPViOJ6MMcKm6dw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D84DD1E441CD;
	Thu, 11 Apr 2024 15:52:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.235])
	by smtp.corp.redhat.com (Postfix) with SMTP id BCF632166B34;
	Thu, 11 Apr 2024 15:52:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Apr 2024 17:51:01 +0200 (CEST)
Date: Thu, 11 Apr 2024 17:50:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>, John Stultz <jstultz@google.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
Message-ID: <20240411155053.GD5494@redhat.com>
References: <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
 <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
 <f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk>
 <87il0o0yrc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il0o0yrc.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 04/11, Thomas Gleixner wrote:
>
> On Thu, Apr 11 2024 at 13:44, Mark Brown wrote:
> >
> > Further to my previous mail it's also broken the arm64 selftest builds,
> > they use kselftest.h with nolibc in order to test low level
> > functionality mainly used by libc implementations and nolibc doesn't
> > implement uname():
> >
> > In file included from za-fork.c:12:
> > ../../kselftest.h:433:17: error: variable has incomplete type 'struct utsname'
> >         struct utsname info;
> >                        ^
> > ../../kselftest.h:433:9: note: forward declaration of 'struct utsname'
> >         struct utsname info;
> >                ^
> > ../../kselftest.h:435:6: error: call to undeclared function 'uname'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
> >             ^
> > ../../kselftest.h:435:22: error: call to undeclared function 'sscanf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
>
> Grrr. Let me stare at this.

Damn ;)

Can't we just turn ksft_min_kernel_version() into

	static inline int ksft_min_kernel_version(unsigned int min_major,
						  unsigned int min_minor)
	{
	#ifdef NOLIBC
		return -1;
	#else
		unsigned int major, minor;
		struct utsname info;

		if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
		       ksft_exit_fail_msg("Can't parse kernel version\n");

		return major > min_major || (major == min_major && minor >= min_minor);
	#endif
	}

?

Not sure what should check_timer_distribution() do in this case, to me
ksft_test_result_fail() is fine.

Oleg.


