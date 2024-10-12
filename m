Return-Path: <linux-kselftest+bounces-19607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3899B665
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E503C1C21022
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4D824AF;
	Sat, 12 Oct 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehfwWBXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D522083;
	Sat, 12 Oct 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754987; cv=none; b=ZV6mbMFjYdeYG3HPi/CxF+iP50qCA35WgbX7vI6F7ohFA5C66TFEJ9V1HBe6Z2PgtLRixyzDB+WGOLIoLh9Ut2VTos/WE3xccOzLC2wM2RCJF1vaoCRXNQbRT1l6lWGsFEX2o9pyrifF3UmVt92QrvJMlTQP9JgmK8M0KdlQSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754987; c=relaxed/simple;
	bh=5vxHfxZTSTMr7CN7Egb8q5PbRkCrqQ/rHWP7s43dbOU=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bMduMCIR83BqfxABDzbiEbeEgWUHaMRbMQ9Z/Xsx/x4AYmB8qo9nZh5exKX62KPkfhsCDh6CYUSuO3Jp9z9XWKO88nb1vhU9B7Hdb5rnSfW0s59moiu+TSNRgS/ziQDu64WRWeMfyt4R1GTYKfXUKoYA3j7HjgodlMTrlBWHmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehfwWBXt; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so27201736d6.0;
        Sat, 12 Oct 2024 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728754984; x=1729359784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AzUJHAgi6gs5kZYag+VCdUP/bZ1QS6+6Bi2y+ZtpR4=;
        b=ehfwWBXtDHbMXWuy3Wdgkd+wUczP6bHgfZ3Jt4BKLdO2f0QiCp35sqUYuM8elnZbgj
         9idi/R5EQMoZW2XuE7jZC3nlDjgtB/bfa5ipc4DiQ04pVFX4PyrXt6G36biI5Tpqko5G
         MES31S2Hwpw2+LGDF9lnOzjw1eN0X7IdcdZKoZKeX3+6lLGOP1ZlgxDS6HSfU4gFhwaH
         5JmCIth9rFkvZk5bJ6wpKuWLCjinY572LqKMsD48w7YUudUCfDIMGn36RT8ZW6fu7LE6
         nn6Y7QTyx+Gg5NLq6p9QFaI5GN3iozloLjTV7Wp3QFS4AllKqU1ceI9qyFHOaIf8+4em
         7ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728754984; x=1729359784;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AzUJHAgi6gs5kZYag+VCdUP/bZ1QS6+6Bi2y+ZtpR4=;
        b=tbwz7iILU3GGJKOnVcqx5xQln9iLkXb4SbZIfjRoPnUvCGF9SfTUP6i78keDgLw+4Y
         RLdsgRz/QJMPaaqgQamRxkZEf7ZIrBDvlteX6i6x/q4kD0PMiHHzAdK8ZyYnkH3de6J4
         M002wKWch+s83B+GGQaVm0uE6mcQzJmHqiKUeHTCegALU7rVafV931kHdNvvbbpjF0xb
         zcyOZZHOB1I/cVRM3+EnDF5saXLIdWbL/oGvWXgDfzzbt90x6W475RSu8uKzpxJpPtew
         Qomroe2KwEE+jTfqeDeLqJJxtNhCLXdLXf1rQzYqLH1lpJtk2eNjkKgBuzXyPxWEnW2/
         +RxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKfWSXKSMF3oodboXbV/swaK5SVOdV/rQKIvBkNf2kKkMt15Yua1XHkjgklR6gtzRH4VjfcBng7Rhg9BZK@vger.kernel.org, AJvYcCUriubLRgOfwds4SKV+7ruEoDOoN2Sf5jVzT3ZvahEulTYfQAMehGY8KrgwufAnXP2j3efb13gd@vger.kernel.org, AJvYcCUtTPf4eXMkDYercn9n7Gp77hS2cFMzKLxCVCmdzGZ3POiMtVb3x+cv+8RVasIA1eJnZVtkSCeRAxv1@vger.kernel.org, AJvYcCW9sOHetCZkEnt9jv7Wn54/foey66o3ayFJ0j7bq8hPgmFx/RSNvKiP+7Ssy3DIA2hcUoI=@vger.kernel.org, AJvYcCXYlJysxahvR31wtV+TGL+OFgIOx+wW6iRpNTZSPrS411Msv8AaG/ZoUyMPrxOKwnKzMiRbfpyy4+5mBdOJ29gy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZR5i+yoqPfjvjJyMYxclFwC7SnPWimaS8R/IvVgJ9/rX/F4q
	iAHAN78irSMvA3Vmwn3e4iHPpWz5Wwmx3uNOZhf+yhyz6TH4HsIe
X-Google-Smtp-Source: AGHT+IHAHXd8vAzcKkZ8geRl6Uqm1cetC8ltFNNIgXPCMaNQNaiyG1VJw/W9ZIuFbryIz9Ld3ZaETg==
X-Received: by 2002:a05:6214:4a0a:b0:6cc:2f3:e637 with SMTP id 6a1803df08f44-6cc02f3e7a6mr17756766d6.26.1728754984406;
        Sat, 12 Oct 2024 10:43:04 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85bab0csm27174956d6.48.2024.10.12.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 10:43:03 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:43:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com
Message-ID: <670ab5278077a_2737bf294ad@willemb.c.googlers.com.notmuch>
In-Reply-To: <f4501f54-875a-4c46-9e77-802bd81f4230@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-4-f3cf68df005d@daynix.com>
 <67068b632d2d2_1cca3129484@willemb.c.googlers.com.notmuch>
 <f4501f54-875a-4c46-9e77-802bd81f4230@daynix.com>
Subject: Re: [PATCH RFC v5 04/10] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> On 2024/10/09 22:55, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> Both tun and tap exposes the same set of virtio-net-related features.
> >> Unify their implementations to ease future changes.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   MAINTAINERS            |   1 +
> >>   drivers/net/tap.c      | 172 ++++++----------------------------------
> >>   drivers/net/tun.c      | 208 ++++++++-----------------------------------------
> >>   drivers/net/tun_vnet.h | 181 ++++++++++++++++++++++++++++++++++++++++++
> > 
> > Same point: should not be in a header.
> > 
> > Also: I've looked into deduplicating code between the various tun, tap
> > and packet socket code as well.
> > 
> > In general it's a good idea. The main counter arguments is that such a
> > break in continuity also breaks backporting fixes to stable. So the
> > benefit must outweight that cost.
> > 
> > In this case, the benefits in terms of LoC are rather modest. Not sure
> > it's worth it.
> > 
> > Even more importantly: are the two code paths that you deduplicate
> > exactly identical? Often in the past the two subtly diverged over
> > time, e.g., due to new features added only to one of the two.
> 
> I find extracting the virtio_net-related code into functions is 
> beneficial.

I understand the benefits. But as I pointed out, it is a trade-off,
not an unconditional good.

> For example, tun_get_user() is a big function and extracting 
> the virtio_net-related code into tun_vnet_hdr_get() will ease 
> understanding tun_get_user() when you are not interested in virtio_net. 
> If virtio_net is your interest, you can look at this group of functions 
> to figure out how they interact with each other.
> 
> Currently, the extracted code is almost identical for tun and tap so 

Almost here is the scary part. Any code that is not exactly identical
must be called out in the commit message.

What often happened is that one of the two got an improvement, whether
fix or feature extension. Then it is likely acceptable to extend this
to the other, too. But we have to review each case.

> they can share it. We can copy the code back (but keep functions as 
> semantic units) if they diverge in the future.

There hopefully is no need to diverge in the future. I suspect that
all previous divergences are accidental.

> > 
> > If so, call out any behavioral changes to either as a result of
> > deduplicating explicitly.
> 
> This adds an error message for GSO failure, which was missing for tap. I 
> will note that in the next version.



