Return-Path: <linux-kselftest+bounces-23742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E139FBFDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Dec 2024 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690867A1F18
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Dec 2024 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D71D6DA3;
	Tue, 24 Dec 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgWgtgJd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2BF1D90DC;
	Tue, 24 Dec 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055982; cv=none; b=qeRLDwLPJEoiMSzYJcmKFOIOViWB+EQe5kuTumoID1PKA2NFexA2nGTO3I/8ogVXVhLXCm/ARAAEWtlxjnDNik1J4UtqHw1HL6Eczq4dLsEDmAroxRVUHJbjXKzNLOzwJeZgqeWBE4KYEmMVStasMHu3ZV07l71lwFIQTUgWyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055982; c=relaxed/simple;
	bh=7DyIlHjFebT6zDyVRgFUxZ6GijPPif5/KWh4Fb844mk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IwPiA6Q+4FhtrVHOZUGjFuP+fEzlTAqkBqU2l/HOA1xu7qv+RWSyVES5bMrTJuhmGaHb5LYF2R3qxDNTOoOQ7Q5LCYsXiaHmAmEEBWnsxmEVqOgri1Wgvp3tyf2D92BkdA4XFhia4cJjWjJkXL0lNczyREqkXdbOT2/6AYscL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgWgtgJd; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8e773ad77so39097026d6.2;
        Tue, 24 Dec 2024 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735055979; x=1735660779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsEj38Wc4+3p/n8Nt86B3Bu1A1OGSpRTG9YDhoxEV88=;
        b=IgWgtgJdEwsajFRnwqZN1Uwo9TZcFyOqyYhbzYsCQN8kFxtFO8jA+aOXfCkYzSDI9X
         fObfGg+9GokgvYeatZsvPxZe2Fo1SGDPNs/Cmjo82iemLUYEZBxlAUW5Kj6hjcit+Qc1
         C8Hsr5RoOE3Eld7Fq1Kin9CLitOyYZVxvyZj8sq9RgqoFHSF9uQVVWfEgxqyyWEeZOaa
         BejFKbgtJ32zlUbLaJ1PC1xug1cUdxIHQef3EJYtu6DNlLoWwaWRGneLNQm7pqrqFrCc
         s6bwx66WjiWgnSQo9Yn31QPrwiGHm6aGc37uikNJfxajpOfa9qJM5yLVKWXHTcYGwatM
         mNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735055979; x=1735660779;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EsEj38Wc4+3p/n8Nt86B3Bu1A1OGSpRTG9YDhoxEV88=;
        b=QWFEYSbeEawFx3vgEnNHMSnolzAyV8iAdizc52wOm/bRvhhBRu/QrXmtONIXhZcbOx
         EdgtqCpD+m4G0exJ2LQAihXo650AM7fs8M8xmCZkmaPFOFdbyjoCmOak4hxy3bNelE0r
         zH50G2hcyOfSbMPtgA2SEuSYYqQng+mrbumVK6gF981SCCIIEHbrH/ugkwRixpuD487L
         hCX9BepSK6TpO6e4ZQpxpmJV6KrCu/t2qHndI3Vz0zYUJ6HG8OydWmHnw62oxmx7e4er
         3GY+TdRUpi7c8l0mfXjjQRII7PL9CA9NdzDiqol89SrhYX2DNC5RoMPy9ygKGmQzBXYZ
         W+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWrvBTmnkIpEn0ZVMJYl1AJNSeFHrb23uKfyMQqMTdGbClOh+YAkrUFVNH6/Zbyq138kYYCDAi89bxWwer83Ek=@vger.kernel.org, AJvYcCXOb/5+tuoT5D251soDcncujQM+o8f7IXo/ASRLnbt8+5LEhZj5FkKM0Kv+MXeUWLB4OuxTTvFe@vger.kernel.org
X-Gm-Message-State: AOJu0YzPP41yOOT5WnSy5pxGioM8wTOlpVO69/ZDFRgS/vBoypsb6AwY
	Ac8KV8Sw0jK9XXeQr42FHMR1+y3/qaPXwCHTulH7SwHOkQKfLl1a
X-Gm-Gg: ASbGncsmP43vjlj9dNGG6z6JR2PCVe7lkKGh5jdjUIGZULPVhDoiJlLvUNNrGt4K6ZZ
	+jkgIgjPJFmRmUdzkD6TfRhjRUjX2fP7BKCh+CrnmYrdyvSsVDRA6HGmpFeroHwM2rCprOgPoMu
	H956Uf84AmVUUkrQHX9AEEaC6z2B5Ym1rb/pAyh7XmfIOvcYOCG53CqcNt69rTlo9EoYmgYIFft
	aivBBsVZ/woG9w8qV2l5mXPT9PNYUFbspQDzz80ResExfkzvAbutlPZYK7HMkYBG/wq8k29Ck+M
	DJ8nfO9HSH0JADCpz634zZ7F2uO6lF398w==
X-Google-Smtp-Source: AGHT+IE5mT88U2Wl8oS8QkxtmWuijssZtkB7o5MwrCcB3QQmeGdC1zJ3aGAay9In5k9TFWdV3VSZhA==
X-Received: by 2002:a05:6214:2242:b0:6d8:fa8a:af7e with SMTP id 6a1803df08f44-6dd23337bc0mr255685596d6.12.1735055979477;
        Tue, 24 Dec 2024 07:59:39 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181bb525sm53931386d6.97.2024.12.24.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 07:59:38 -0800 (PST)
Date: Tue, 24 Dec 2024 10:59:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Soham Chakradeo <sohamch.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 linux-kselftest@vger.kernel.org, 
 Soham Chakradeo <sohamch@google.com>
Message-ID: <676ada6afb03_a069c294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241223085033.5926d1a6@kernel.org>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
 <20241218100013.0c698629@kernel.org>
 <19df2c4d-c40c-40c5-8fec-bb3e63e65533@redhat.com>
 <676474a0398f0_1f2e51294ad@willemb.c.googlers.com.notmuch>
 <20241219180144.7cf5226c@kernel.org>
 <6768dd1289ee2_3cff202943a@willemb.c.googlers.com.notmuch>
 <20241223085033.5926d1a6@kernel.org>
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import multiple
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 22 Dec 2024 22:46:26 -0500 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > On Thu, 19 Dec 2024 14:31:44 -0500 Willem de Bruijn wrote:  
> > > > All three timestamping flakes are instances where the script expects
> > > > the timestamp to be taken essentially instantaneously after the send
> > > > call.
> > > > 
> > > > This is not the case, and the delay is outside even the 14K tolerance.
> > > > I see occurrences of 20K. At some point we cannot keep increasing the
> > > > tolerance, perhaps.  
> > > 
> > > I pinned the other services away and gave the packetdrill tester its
> > > own cores. Let's see how much of a difference this makes.
> > > The net-next-2024-12-20--03-00 branch will be the first to have this.  
> > 
> > Thanks. It does not seem to resolve the flakes.
> > 
> > At this point I think the best path is to run them in debug mode to
> > get coverage, but ignore errors. With the below draft patch, error
> > output is still logged. For instance:
> > 
> > # tcp_timestamping_partial.pkt:58: runtime error in recvmsg call: Bad timestamp 0 in scm_timestamping 0: expected=1734924748967958 (20000) actual=1734924748982069 (34111) start=1734924748947958
> > # ok 2 ipv6 # SKIP
> 
> Makes sense. Can we make this XFAIL instead of SKIP, tho?
> Not exactly accurate but we try to use SKIP for reporting env / setup
> problems like missing commands. We have FAIL_TO_XFAIL and
> xfail_on_slow() in the lib for netdev bash tests, already.

Sounds good. I'll add a ktap_test_xfail() to stay with that API.
I see no clean way to make use of xfail_on_slow directly.

When net-next reopens, unless the noisy dash is annoying.

