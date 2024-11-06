Return-Path: <linux-kselftest+bounces-21504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D09BDA18
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 01:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9CCB2220C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 00:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CBB36D;
	Wed,  6 Nov 2024 00:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nULiOJcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8B173;
	Wed,  6 Nov 2024 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851995; cv=none; b=hS8jN/7A6B/WAJCR8ZbRV3V4kAUIgZ6t5dQvftZhupky4BnEhZg2Mt4huamVTZ/bg5jR/AQ1cvcEkPm6ge1sWyaGzHS7JzuD5oUkz2p97bAiONyfVz3EeK27asJ/c0D2GbirZxTScoHstlMg0Jf+3e21Q7W6X47Yun6kTzl7xXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851995; c=relaxed/simple;
	bh=CNR2huwrYRnkZkg1Y2KQ6f/0LqS79jl9D+/e9mWZXtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHkb57SxCafphCvjSd20m/w/rW4zPfmfPXbjYUmt101P3gX5hA0eR2gVZCIIW3c73ryLThj01gVy5yF+fIHZGWSkMGzOMSlhrUf+ksTA8AYYs+IUeJg+Yn34sRyTITXEKKQQvZGWfTvRaQKvXNaOsGtK5wMos2aqan42eZs+wTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nULiOJcC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso215566b3a.0;
        Tue, 05 Nov 2024 16:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730851994; x=1731456794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hSHh/lcKGOgr8zxmK/zCU2mZe0FLf7CPP8bNcIOgH7Y=;
        b=nULiOJcCd6MyTxBgXNLxKFc34c2sm1t9P8U19LbUJnn9R/6sn1jKlx0BCwWmWMBusK
         aJ2icPgi0YWUFTyHKlT3ROR5/cTA+bgeCBPijh0/0q/7hA6bqDDQV/WmzZdt+Zyjnff0
         b/ZA12sif5nC871dYPmT7T7yrym18C0Hu6KyONz3mumY2xiGuffeslgrvnH0H1klacss
         PvdmFgKx7stDr8gg1fcgInoqzeW6Et6l0I2NYYaLOBft7TYoL38n89b1eVirR814J5QV
         HBmMLjiFkbhMFT9mf5I15/M+4CVQH98inXcrjAf+66VUyHOZKoHHAGakX0gLGEz4EZRN
         npZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730851994; x=1731456794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSHh/lcKGOgr8zxmK/zCU2mZe0FLf7CPP8bNcIOgH7Y=;
        b=j+qW76gTNGGEVVSvH6w0HVLp+KahTaapYu22831BOh69dOIB5IFSHnRnLoCMXBCFvk
         8S39wWLedFFzv1d/WpiNf5M41GoGbkZHRItNKi+W5RiQsjJzKnZ7HubwMW6AMPCDw+BB
         LprnzCoBdgBK7YP8znnJ1BQsapfuNNCtZsMqPHbbYrQz3IhGq431YSfgs1Z1CJz7v0Te
         iAtDB93AZKDuYo+EDh9ZF8RfMo6Ji8cknw2g++q+nsV9yAN8yJH/6u59Slbh9L96vgKv
         jNOfN7UHejWBnIu5ZPKvAO1KMObof5JMzLafCKcOu/bp+yxr0ctNE+8Z+n7BP6vNquuR
         hjDg==
X-Forwarded-Encrypted: i=1; AJvYcCUAf8jxo2XfqNMJzlaRXXyU0hWsaDgLU8Vu/DHd18zJ3xxIIEtLCa4WhzS10fP00QB9HihE+fwnAdVXW6k=@vger.kernel.org, AJvYcCWYprl9thrdL9E1CqLrASe7PFsdJ+NfYD1mWgZr8BbvysiigjSjSG6xdpxhczqRbBsuQ0AtiYoXyDt6et+O0T+6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4MnXvYdFdB9C8TqegTSMo5pUWFVw14Nlw+yyvir9C0W7GphE
	kBI8dAqfF/c4Z5fZH6luKyyDEJLaPdYk/boReREIpBZuKDqgCI0=
X-Google-Smtp-Source: AGHT+IGmPWhJM7VO0SLjP2BiRkNrCtx9Le577yZKZryuMH4iFiui4HVC7vlqk2UJzw4Q2xl8R5JU7w==
X-Received: by 2002:a05:6a20:4322:b0:1d9:dc8:b80d with SMTP id adf61e73a8af0-1dc03386112mr883285637.20.1730851993392;
        Tue, 05 Nov 2024 16:13:13 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452991f0sm9704517a12.13.2024.11.05.16.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 16:13:12 -0800 (PST)
Date: Tue, 5 Nov 2024 16:13:12 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>, Yi Lai <yi1.lai@linux.intel.com>
Subject: Re: [PATCH net-next v1 6/7] net: fix SO_DEVMEM_DONTNEED looping too
 long
Message-ID: <Zyq0mBCJEBQ2s2Jm@mini-arch>
References: <20241029205524.1306364-1-almasrymina@google.com>
 <20241029205524.1306364-2-almasrymina@google.com>
 <ZyJDxK5stZ_RF71O@mini-arch>
 <CAHS8izNKbQHFAHm2Sz=bwwO_A0S_dOLNDff7GTSM=tJiJD2m0A@mail.gmail.com>
 <ZyJLkn3uM1Qz6NZn@mini-arch>
 <CAHS8izMWbcKSr3uOVWQDmo5=aQvFdcD6o_myz1bw=a1rzrJE_A@mail.gmail.com>
 <ZyqSHic5hW_vi47l@mini-arch>
 <CAHS8izOdqnXytOOyg+EATHg5ON+eBDn4qe=L3a3YKd5tzdqV0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOdqnXytOOyg+EATHg5ON+eBDn4qe=L3a3YKd5tzdqV0A@mail.gmail.com>

On 11/05, Mina Almasry wrote:
> On Tue, Nov 5, 2024 at 1:46 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > > > > Also, the information is useless to the user. If the user sees 'frag
> > > > > 128 failed to free'. There is nothing really the user can do to
> > > > > recover at runtime. Only usefulness that could come is for the user to
> > > > > log the error. We already WARN_ON_ONCE on the error the user would not
> > > > > be able to trigger.
> > > >
> > > > I'm thinking from the pow of user application. It might have bugs as
> > > > well and try to refill something that should not have been refilled.
> > > > Having info about which particular token has failed (even just for
> > > > the logging purposes) might have been nice.
> > >
> > > Yeah, it may have been nice. On the flip side it complicates calling
> > > sock_devmem_dontneed(). The userspace need to count the freed frags in
> > > its input, remove them, skip the leaked one, and re-call the syscall.
> > > On the flipside the userspace gets to know the id of the frag that
> > > leaked but the usefulness of the information is slightly questionable
> > > for me. :shrug:
> >
> > Right, because I was gonna suggest for this patch, instead of having
> > a separate extra loop that returns -E2BIG (since this loop is basically
> > mostly cycles wasted assuming most of the calls are gonna be well behaved),
> > can we keep num_frags freed as we go and stop and return once
> > we reach MAX_DONTNEED_FRAGS?
> >
> > for (i = 0; i < num_tokens; i++) {
> >         for (j ...) {
> >                 netmem_ref netmem ...
> >                 ...
> >         }
> >         num_frags += tokens[i].token_count;
> >         if (num_frags > MAX_DONTNEED_FRAGS)
> >                 return ret;
> > }
> >
> > Or do you still find it confusing because userspace has to handle that?
> 
> Ah, I don't think this will work, because it creates this scenario:
> 
> - user calls SO_DEVMEM_DONTNEED passing 1030 tokens.
> - Kernel returns 500 freed.
> - User doesn't know whether:
> (a)  The remaining 530 tokens are all attached to the last
> tokens.count and that's why the kernel returned early, or
> (b) the kernel leaked 530 tokens because it could not find any of them
> in the sk_user_frags.
> 
> In (a) the user is supposed to recall SO_DEVMEM_DONTNEED on the
> remaining 530 tokens, but in (b) the user is not supposed to do that
> (the tokens have leaked and there is nothing the user can do to
> recover).

I kinda feel like people will still write code against internal limits anyway?
At least that's what we did with the internal version of your code: you
know that you can't return more than 128 tokens per call
so you don't even try. If you get an error, or ret != the expected
length, you kill the connection. It seems like there is no graceful
recovery from that?

Regarding your (a) vs (b) example, you can try to call DONTNEED another
time for both cases and either get non-zero and make some progress
or get 0 and give up?

> The current interface is more simple. The kernel either returns an
> error (nothing has been freed): recall SO_DEVMEM_DONTNEED on all the
> tokens after resolving the error, or,
> 
> the kernel returns a positive value which means all the tokens have
> been freed (or unrecoverably leaked), and the userspace must not call
> SO_DEVMEM_DONTNEED on this batch again.

Totally agree that it's more simple. But my worry is that we now
essentially waste a bunch of cpu looping over and testing for the
condition that's not gonna happed in a well-behaved applications.
But maybe I'm over blowing it, idk.

(I'm gonna wait for you to respin before formally sending acks because
 it's not clear which series goes where...)

