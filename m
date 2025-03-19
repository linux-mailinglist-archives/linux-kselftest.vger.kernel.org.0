Return-Path: <linux-kselftest+bounces-29445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BBBA695DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 18:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E0C19C7DAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349C3207657;
	Wed, 19 Mar 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZudocCrd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56348204F65
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403886; cv=none; b=cukAA7X6jnCFVcfywVEbFnviT4Ue8EzvYZp7oRdI2RtTc3YrdpxVXAj0KHWYZ3gGG2u9DCbM6283ZTrmmFhr+s6e6sG0nKOTRAwxQn9dspIm/ky4sfsWpVixYgksTITH0PQOn+t8gNM8Hmksk9p1iGWedLNz2mknL3QGVNyswNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403886; c=relaxed/simple;
	bh=xHwQmrmdOuIs6PYCDdbIWFozyweG4V+76so2ScsTFCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDg1ctAaN12kLVjhlcN7hEbIRl0oGyAOvgZYbvZD0JAk5PkreaZREi8moUyHYDNys67T+IWIuBzQzz0CePh1zx13seS+8WCPX4EbG4ypak2D1X+jI5rWmr1gJQVaJM5P5RF2RDoRAAwHhBxv4Zzs+Mmdq72157ORTuuwPzHOmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZudocCrd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22548a28d0cso42904855ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742403880; x=1743008680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfTEntrgNFTQ+7NianD/ZW1MCI2896IIxNfsoj927aQ=;
        b=ZudocCrdeIxz5yixaOfaARaArGk6VJ9VnJhm4x+qCMl9abzTplglc3CNQDuUm/bqGF
         9ehjSIW8WA0WcMRxOPNdi6feCFVcC61ljTLsdxo+cemNxs1+WgVGwv6ClYl0X3ep9Tgg
         P4ZPmmXZpGPh5M+6Sd2h2CtyOmsg0IJC9jNMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403880; x=1743008680;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfTEntrgNFTQ+7NianD/ZW1MCI2896IIxNfsoj927aQ=;
        b=B5qkfpN2MYGiNhbNygAACGlo/sb/9IODp4pHnBOsGFYLkofPF3CBZpw3PnXU+zTXMT
         btqx+66sFz5mvjvG7EoFRIXSUrwikQaL7+KzZ9Z92xHCBu1KsZVpVacXUVapceKNR1gt
         mVUmHKBPqCUnxCIcn4DiTtQ4KTqdsvc7UwOEyqyk5GfbuMaJhopTMRo47B4QB10RdXWT
         mbzriM4B2x0X1ZTIJ6/1P6b0Dvqr6XTV9q3yn1uEKFkb4a1qohcv6t11vR3MT0Jotg5l
         J+yhZnDMBRi+EpR0z3cjDUCU2VdJgELMxsy3lRAuR1hHFPw4ec5SVms4OTeblQ/8MXWk
         lIkg==
X-Forwarded-Encrypted: i=1; AJvYcCWPIMniQaTwc0KORRoR8kXGkPApvmMWi8m6XyPC5FevbvFB2SNR9hkNhfccVKwlU9pcKxXbuINMGRTo3C8UrPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqxuj4MHtV7NyqNPWfO07+D4jsRTnau42/8dAVA6tCs/UT7k6v
	XToTd0osTT1vJ4jnotBxEk1ypue6uZ2eaqy4fB7pB9qnumq6VjnuWqwGkeczu0049N9i+bGzyCV
	c
X-Gm-Gg: ASbGncuzTAp23Y9sCvFR+Cv35g8jxZ6w7eBA19J11NFnPUj+dikAHl/0QEaCzEPo/Ru
	AnZ9SkC/ZCKh0+3YVxEckvPGYJFz+Mo7VTngI0hWTb5tpt1BOepmJ06ckw7TSx688ezVG//w7Ww
	PpHByVnklRYOiv9HespvBgQktu7vUC5schkPvKU0fxl7nBPMmu2QBd8xawhcWd3zKsB29XOEkwj
	dGT8buOcgvfgkyMEdP2bePPb7t34ag+PXodEyJFU1isWiTGk4CnL6KDQIwv6SZDex6gan1gb2P/
	9TdMdRvShSOAOqSBEdf3nuAHO60SPnOrrl87Z3ndY5RuzeM0RXebsvu7llvrCz+G+KZohHvNPiN
	O01+oRhUL2BgWGHQW+nCS0K+uE/Y=
X-Google-Smtp-Source: AGHT+IEueksUXBjAKQcNj3VhWfV1THpBLxF7hLqyCecDq7YAGddkNADabgO+qWlOA2ka1zPDDwfS9Q==
X-Received: by 2002:a17:902:d48c:b0:224:1074:63a2 with SMTP id d9443c01a7336-2265eec4454mr1110355ad.43.1742403880606;
        Wed, 19 Mar 2025 10:04:40 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68885a1sm117239265ad.13.2025.03.19.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:04:40 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:04:36 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>

On Wed, Mar 19, 2025 at 10:07:27AM -0600, Jens Axboe wrote:
> On 3/19/25 9:32 AM, Joe Damato wrote:
> > On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> >> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> >>> One way to fix this is to add zerocopy notifications to sendfile similar
> >>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> >>> extensive work done by Pavel [1].
> >>
> >> What is a "zerocopy notification" 
> > 
> > See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> > sendmsg and passes MSG_ZEROCOPY a completion notification is added
> > to the error queue. The user app can poll for these to find out when
> > the TX has completed and the buffer it passed to the kernel can be
> > overwritten.
> > 
> > My series provides the same functionality via splice and sendfile2.
> > 
> > [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> > 
> >> and why aren't you simply plugging this into io_uring and generate
> >> a CQE so that it works like all other asynchronous operations?
> > 
> > I linked to the iouring work that Pavel did in the cover letter.
> > Please take a look.
> > 
> > That work refactored the internals of how zerocopy completion
> > notifications are wired up, allowing other pieces of code to use the
> > same infrastructure and extend it, if needed.
> > 
> > My series is using the same internals that iouring (and others) use
> > to generate zerocopy completion notifications. Unlike iouring,
> > though, I don't need a fully customized implementation with a new
> > user API for harvesting completion events; I can use the existing
> > mechanism already in the kernel that user apps already use for
> > sendmsg (the error queue, as explained above and in the
> > MSG_ZEROCOPY documentation).
> 
> The error queue is arguably a work-around for _not_ having a delivery
> mechanism that works with a sync syscall in the first place. The main
> question here imho would be "why add a whole new syscall etc when
> there's already an existing way to do accomplish this, with
> free-to-reuse notifications". If the answer is "because splice", then it
> would seem saner to plumb up those bits only. Would be much simpler
> too...

I may be misunderstanding your comment, but my response would be:

  There are existing apps which use sendfile today unsafely and
  it would be very nice to have a safe sendfile equivalent. Converting
  existing apps to using iouring (if I understood your suggestion?)
  would be significantly more work compared to calling sendfile2 and
  adding code to check the error queue.

I would also argue that there are likely user apps out there that
use both sendmsg MSG_ZEROCOPY for certain writes (for data in
memory) and also use sendfile (for data on disk). One example would
be a reverse proxy that might write HTTP headers to clients via
sendmsg but transmit the response body with sendfile.

For those apps, the code to check the error queue already exists for
sendmsg + MSG_ZEROCOPY, so swapping in sendfile2 seems like an easy
way to ensure safe sendfile usage.

As far as the bit about plumbing only the splice bits, sorry if I'm
being dense here, do you mean plumbing the error queue through to
splice only and dropping sendfile2?

That is an option. Then the apps currently using sendfile could use
splice instead and get completion notifications on the error queue.
That would probably work and be less work than rewriting to use
iouring, but probably a bit more work than using a new syscall.

Thanks for taking a look and responding.

