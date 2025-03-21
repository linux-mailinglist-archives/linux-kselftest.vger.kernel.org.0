Return-Path: <linux-kselftest+bounces-29592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15146A6C527
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 22:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9339189E260
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27142327AE;
	Fri, 21 Mar 2025 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rFDwWK0a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60A231A3F
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592502; cv=none; b=BjhkQW73tCJYPEzBAHVUglzxg4xQ+Ejq8C7z/ELvWb4PoyT0PWfD4r7GFQmGVZSOWQyhiB9ODfqa93WZ06xUGI0wOMvPj9vbf3rq0BmYwRJqj8mHBTIoPNC9M0MIJEggiNT/MTd3bD5hGGfglTjqvIWhmcyyaMXbMXifS6yaZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592502; c=relaxed/simple;
	bh=qXj971FSFP/wOZUPcfSsBiuTp/DvOZnX2IFBROliFJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvWKgg5yi5UVvdIqYyYV/0hK4Vpq8HYyAwurVO7RdIDkTfxbN7LxSVfoAuxTv6qTNrNSeveCrtEfnZI24iAl5MNucsaWRuDOh+hrzteq8hkfT2rGjP8PUfrnCu0VDBos3ea+KFuZ5cweJkk5N+N5/UxRuropE3iLMoOWe3A/x10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rFDwWK0a; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so50295545ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742592499; x=1743197299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXTCW1lYI/NO5ybgxR6jIW3fidKxOfziUSy+malvYvc=;
        b=rFDwWK0avfNl2NXF/Sm0Tagbux0abRnzSNOxgj+WraKAiZfbGSb4JJVF5QP7dqmZat
         /g/aOJHETXEcyx+Vh4kNiV5hNc9m4Fxxh42XDwIKQPrFvrLCyHwXRQblSjNucTbQRnw6
         f08J7WmZ1APGQii0GT/oLDh/wAlOlP+Jz2E7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742592499; x=1743197299;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXTCW1lYI/NO5ybgxR6jIW3fidKxOfziUSy+malvYvc=;
        b=kT77gFz8P6p14YpODBA3/vYff9bcrkDgYAZEiEi+oF7BABm0W4/dHi/ipDYVCHdd3Z
         mrTPo/DZfWBPL9/CFL6Vc8lraOArFedxyms+0pSqCWpiEg2aA+orvsY38iDRubPEohxF
         nUImEyYvpEy5W/pAp48BOJ8D1PVkgFlD90BN0gVkjdDh9Pks5kq1eorf2X0xS0FV/FB4
         UQrlBqiQGMtr13SP1ve8gPZ7dn/ifq8LCqNsBFHOZ4/g7I9hnhwA9APVXpmAbnLHalS8
         diz1Oj7l9H3LcKM5jwFQVVnHdLei49ttEy6cgvxOjP0pANIHv6ur00477Zy16A4YQNJp
         WzDw==
X-Forwarded-Encrypted: i=1; AJvYcCWdmhbm68ZBsghjS5NvvTqKmK4c3Qc45PMtl2nIOH3Je4fsp1NMqNHs/GjkMZx9Saimqr5/ebYMaMQPGVaiMcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZqhG55GUx3/Vollj+HXC7EZ156MlqIh+D22Qld2mtnUEd9nU
	doe1igtadKk59kyTIlyo7MNEUDhKq4uWPVFQ3QwYPnsZQO8rUoRwrpaS4GiLOEE=
X-Gm-Gg: ASbGncuptNgCVqKYZgn46SwiRu0b9JHQKR1SyFStZhDPECJkvSwC7PQbM3aSi72khsY
	mz1V+UDNE72bW5cgkcIKE+A/67GW593CPC5juy0jFKkRugLFy3j1j7jWoOxYc+kwIa5pbB78JKM
	DvB+rYDZNtjpx8WlqcHOnPd5oL3Zj6F31mw43rF42BRzWKTZfgsoOLlsSafRa5cNMkOLB1/jMJw
	y7ilO0JaWifcUEOaSviK0DnIM5F4ZImfAtdnxbXaxYTRoDtuQZgqEMjSYByynx8OXLsrK97qfUr
	ImwhJYJeTGftAEaMYZ34fpvzw0/N5lmwQNp/YPwnj99JSYZ1WZR+ZQzyEVOB3bBBfYBEzg5xufw
	WTuMACMPcXmDir1u5m2C2G2rScfk=
X-Google-Smtp-Source: AGHT+IFQHiH1Q74zGSjuGJPSwRB6B0nITzjFmSBxRdVQxaFhw5xJuOEQUfZo/n55kU3kKM/0M7AFag==
X-Received: by 2002:a17:903:2cb:b0:221:78a1:27fb with SMTP id d9443c01a7336-22780c50872mr79615365ad.11.1742592499418;
        Fri, 21 Mar 2025 14:28:19 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2278120a552sm22391275ad.256.2025.03.21.14.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:28:18 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:28:15 -0700
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
Message-ID: <Z93Z73vG9NYUNQtE@LQ3V64L9R2>
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
References: <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
 <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
 <67a82595-0e2a-4218-92d4-a704ccb57125@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a82595-0e2a-4218-92d4-a704ccb57125@kernel.dk>

On Fri, Mar 21, 2025 at 02:33:16PM -0600, Jens Axboe wrote:
> On 3/21/25 2:30 PM, Joe Damato wrote:
> > On Fri, Mar 21, 2025 at 09:36:34AM -0700, Joe Damato wrote:
> >> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
> >>> On 3/20/25 11:56 PM, Christoph Hellwig wrote:
> >>>>> I don't know the entire historical context, but I presume sendmsg
> >>>>> did that because there was no other mechanism at the time.
> >>>>
> >>>> At least aio had been around for about 15 years at the point, but
> >>>> networking folks tend to be pretty insular and reinvent things.
> >>>
> >>> Yep...
> >>>
> >>>>> It seems like Jens suggested that plumbing this through for splice
> >>>>> was a possibility, but sounds like you disagree.
> >>>>
> >>>> Yes, very strongly.
> >>>
> >>> And that is very much not what I suggested, fwiw.
> >>
> >> Your earlier message said:
> >>
> >>   If the answer is "because splice", then it would seem saner to
> >>   plumb up those bits only. Would be much simpler too...
> >>
> >> wherein I interpreted "plumb those bits" to mean plumbing the error
> >> queue notifications on TX completions.
> >>
> >> My sincere apologies that I misunderstood your prior message and/or
> >> misconstrued what you said -- it was not clear to me what you meant.
> > 
> > I think what added to my confusion here was this bit, Jens:
> > 
> >   > > As far as the bit about plumbing only the splice bits, sorry if I'm
> >   > > being dense here, do you mean plumbing the error queue through to
> >   > > splice only and dropping sendfile2?
> >   > >
> >   > > That is an option. Then the apps currently using sendfile could use
> >   > > splice instead and get completion notifications on the error queue.
> >   > > That would probably work and be less work than rewriting to use
> >   > > iouring, but probably a bit more work than using a new syscall.
> >   > 
> >   > Yep
> > 
> > I thought I was explicitly asking if adding SPLICE_F_ZC and plumbing
> > through the error queue notifications was OK and your response here
> > ("Yep") suggested to me that it would be a suitable path to
> > consider.
> > 
> > I take it from your other responses, though, that I was mistaken.
> 
> I guess I missed your error queue thing here, I was definitely pretty
> clear in other ones that I consider that part a hack and something that
> only exists because networking never looked into doing a proper async
> API for anything.

OK, so then I have no idea what you meant in your earlier response
with "Yep" :)

Combing everything said amongst a set of emails it sounds like the
summary is something like:

    A safe, synchronous sendfile can be implemented in userland
    using iouring, so there is no need to do anything in the kernel
    at all. At most, some documentation or examples are needed
    somewhere so people who want a safe version of sendfile know
    what to do instead.

Is that right?

If so, then great, I guess there is nothing for me to do except
figure out what documentation or man pages to update.

