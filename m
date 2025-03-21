Return-Path: <linux-kselftest+bounces-29569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55FA6C054
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5605D189203F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687A122CBE3;
	Fri, 21 Mar 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HZyv9eYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4A22B8D2
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575459; cv=none; b=GcmsAJAloE8aOoCciWD0T4YZFLwuaSaRE05hTuhDjICmvg92rXJORXbFvhXjQt//wQdM+wEkBvGZpFPLzrIt/HRSo6czdI+2XrnNOu49/BvDZO+e43O6yVGlKd8ql/JFEZ0V79QvSZcshDWhx+gWju/nkJ0zgHVUjOq5WDnv/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575459; c=relaxed/simple;
	bh=IMeArOMSvV+SAUlYdgzoqB6lsnXPfljvOmj84MN0ick=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXtAGLgS0s0vkWzBRt5wK8i9Jxr4pOz3OHUEhsTLViVgt0MTCNGLoyrT+MjzIHzHA6YNEm1AMc7ycrF6vWbnyzPw8vczOjosEsGHPxUQ+SIU3Utx5t1PMevPM4SKL+IZ/nEv44oTlUiws6PatQAj2jLSJTLoV+gkDVWSj7v+8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HZyv9eYa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225a28a511eso49907415ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742575457; x=1743180257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdus/fJVv5Uld6yn8oFMkQzJNe6dHC2w9XvJ773goNA=;
        b=HZyv9eYaGfAfS5TzyiAfne7e+Cj6w6knyN1bsuK0l23BH6/C2KhX2L3GiLz0dennJB
         kK9slfnRaJ27l+T8IPNdM9DXo4h6Vj3Dth4GDHOzj+mBDaBhwYD0bkt3x8Lk51JO66uA
         pgCNI/yZ0ZQ4pfX/PqXQ5YgmYZvQHpiDE/zXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575457; x=1743180257;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdus/fJVv5Uld6yn8oFMkQzJNe6dHC2w9XvJ773goNA=;
        b=KuSk37LMHb4gunVc0htk3abBKiMbv7zg40YxLkkg6SejMLmLYzz2QOcDlowVa1mRfK
         hEeaf6GZU31PbwyMdUB/15lz+wLUBu2VChNwP6aES4WYnLyUnmbawGw/wh//juiT1oaB
         mUBfsnhXDyg7BkK2HtsBHb5ulglNoIRev/JcpFrRoyWMfUbyJnU7p9D4IscOz0MFbTGW
         5iWZPTAzKVsL2ibyXShiiTYCoNvZ1ewuDe1AkOIIVIzMuluqP8uYKp6OjAPtx0ZVeWxF
         cKjRx3TY3AlzItTNxAhVC8yZg3FKoKGxHUBeQhWXvvH7LyrniraLp6jhrtU70RyxkmCV
         kI0w==
X-Forwarded-Encrypted: i=1; AJvYcCVvZ1a+EPhyaqLMSxOJOEhywU82+vHe4+dkp2EoG5y/0fzPX+Y+zyC0sHadVchRjLsNbwCFJGc+aXHrBazIlCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxywTRsjrWewYJ/7ZliroNIdTR4lu1boYNVQ9sogJZCb0z7+glV
	TFWwVjRJLWMQDtn3PS82xTgJNFbiJFsIQuNUsoTicTHA7GAnYzDUgmhNn13MNUc=
X-Gm-Gg: ASbGncsGdlZ7XPrKCRXHHbPA/+2WV1AhFZCwiBi76Ts9X1jy+972XyTWTeiejLm/S9s
	5bXZqpnkgst2E57/kwfjBUW2tbgKe6gRwqJbHvGdwPf341IIAwuiEqNDMjFWPJrdpwvwQ8N2B7C
	795DPYGE+I+wnmwxG20dbypbOfZZenrmS7xXEoBUf46YvyTTQpbO2sN2aCRVlsji7wEvi2za5mB
	T18zawuYLul7ZIkVMpt3+fP+89opHpFaxSJ/lJwl+8qkbXH3O3R8OawrQm7d4fMx1gRw9ASi5K4
	DfLuib0zZfVN5TtA5CybWUuSxEXFyS3twCSfstQGsB8QVzuQEir956ESuLnUmg6PWmz80XDA2KA
	UkDgfEUvwnIjOcqub
X-Google-Smtp-Source: AGHT+IHNkHo8pQiFISfzkg8EmthIVkGNH6DyH204b4LoCrS28DjOE/rXN+w3HTspHp5hcO8dxdqoWw==
X-Received: by 2002:a05:6a21:998b:b0:1f5:839e:ece8 with SMTP id adf61e73a8af0-1fe42f090e7mr7044509637.2.1742575456784;
        Fri, 21 Mar 2025 09:44:16 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2843af9sm1984943a12.38.2025.03.21.09.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:44:16 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:44:12 -0700
From: Joe Damato <jdamato@fastly.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z92XXFDVz_5fU2YQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
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
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9z_f-kR0lBx8P_9@infradead.org>

On Thu, Mar 20, 2025 at 10:56:15PM -0700, Christoph Hellwig wrote:
> On Thu, Mar 20, 2025 at 11:23:57AM -0700, Joe Damato wrote:
> > In my other message to Jens I proposed:
> >   - SPLICE_F_ZC for splice to generate zc completion notifications
> >     to the error queue
> >   - Modifying sendfile so that if SO_ZEROCOPY (which already exists)
> >     is set on a network socket, zc completion notifications are
> >     generated.
> > 
> > In both cases no new system call is needed and both splice and
> > sendfile become safer to use. 
> > 
> > At some point in the future a mechanism built on top of iouring
> > introduced as new system calls (sendmsg2, sendfile2, splice2, etc)
> > can be built.
> 
> I strongly disagree with this.  This is spreading the broken
> SO_ZEROCOPY to futher places outside the pure networking realm.  Don't
> do that.

OK. I won't proceed down that path. Thank you for the feedback.
 
> > > Because sendmsg should never have done that it certainly should not
> > > spread beyond purely socket specific syscalls.
> > 
> > I don't know the entire historical context, but I presume sendmsg
> > did that because there was no other mechanism at the time.
> 
> At least aio had been around for about 15 years at the point, but
> networking folks tend to be pretty insular and reinvent things.

Sorry, but whatever issue there is between networking and other
folks is well beyond my understanding and historical context. I'm
not a reviewer or maintainer or anything like that; I'm just a
developer who saw a problem and wanted a solution.

I've read your message loud and clear, though, and I won't proceed
down the path I've proposed.

I appreciate your feedback; this is precisely why I sent the RFC -
to get comments - so thank you for taking a look and letting me
know.

> > As mentioned above and in other messages, it seems like it is
> > possible to improve the networking parts of splice (and therefore
> > sendfile) to make them safer to use without introducing a new system
> > call.
> > 
> > Are you saying that you are against doing that, even if the code is
> > network specific (but lives in fs/)?
> 
> Yes.
> 
> Please take the work and integrate it with the kiocb-based system
> we use for all other in-kernel I/O that needs completion notifications
> and which makes it trivial to integate with io_uring instead of
> spreading an imcompatible and inferior event system.

If you have any suggestions or pointers to code I should look at for
inspiration I would very much appreciate the guidance.

Thanks for your time and energy in reviewing my RFC and responding.

- Joe

