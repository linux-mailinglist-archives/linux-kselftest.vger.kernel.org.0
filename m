Return-Path: <linux-kselftest+bounces-42169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F90B98E19
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 10:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4CC4A4704
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73832877F6;
	Wed, 24 Sep 2025 08:26:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10128727C
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702383; cv=none; b=P8lymkIF4IYpiyLf+0enNlGeMxtaXtA24Q7dfjMEG4q5Y0tOvN+ImUCgF3dt+SehtlBewD3flPk5T1t3w7MmNnGCwBkxxlLfsV1jlKoSeGlReDPR2TBjSi5YnH8zGiEQVojA8aOnpaq3t7UHarHMLzAophFjDoIl3umPDxXwxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702383; c=relaxed/simple;
	bh=+tUrgkxN/lp2KXqz828oyBVZ2yDGNOIKK7iRndNRB/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqiLqjs9HW28HJx6RhzgDDDEFeaJzK5fUn0OhvrEJ3VjQ4Xj4uhA5XoBA1WUGiizN5T1I4pMSrSe4L3f/ggo4C3zlasCFXZDsQ1YcoKpgq6qk+ngpl4dmb8fOltG51Q+MaCf1RDCiStLeGUKaIeaUluVInPXBlguXbm/wUOhb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63486ff378cso522955a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 01:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702379; x=1759307179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZeXGQPLJ237ts6pnuqslfPixY1clqbR+lLUJqF8pM0=;
        b=H0sltXLlUCzeXn0Se11UVnBiyFuX7hJP4vLOKhIJOw4y+LMjZWjUK13RWINDKinvVM
         QDokz26e6IApnRF8xtehrBW+P211V/VmIwylmBhpwb6I04WEPyEWRM4T999t5uTXqzA2
         Lxf6X73UsK/FQD68vUINlfdr6zgQHCRLwJ8XGySVKKsYIjpqGNjmcAfx671u4yMIdBKo
         GIsEiVOsUjOgZsE6GN2O7hVO5MnWsfPrnOqkkFz7EfwJs6QopEMh2yj63oo4A4Xu8TDK
         0TyEh9JtZitwz4pSU9WrvouBsRZOwvzM5haLBOk8aKyG+khAqbEzOSP22Pl7DJ15mFF/
         ktKg==
X-Forwarded-Encrypted: i=1; AJvYcCU2itLCVN1Zc5D9BUV3pcN3JtFMKsS0v9aXi8vs9tgrCZnADUFMFzOF2SSYkNtnlXUmcj16FqhbgT3aTHWU4WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmBGOzKLcoSWZc9A/EFnoBCOWHUy4GNOkGzVgCvEj4AZQH2Sq
	YS5TKJaOLIDns/l+65wlaWGvMD6No4NzIP2QCVtQ5G+aZzIwacCH+7RS
X-Gm-Gg: ASbGncvQUhsQZvnqABlAKAeEr/54QcUTsys9lvoS/DtGnwf3Bzrwa0bSHMDAGEaPOcA
	6WpbJDr2Tc0gdYPvcjD3Ph8hSstf8H9aqXGYIFqgapa5X79Y/RsLKJjpbKXmsXvVQl0EcUNZBwx
	OXlORsuMQe8rNhTJkiRPc9SZARJznaoKA8CjvoweJdCiTkfb4O4pT9RY5BJxoMlE033GLWNySfR
	FengWJXx2l7vu5lLqAxDiQZOANPvmoX6Xhzfes0TZUPficuNBqeNs+ONI2ZHDHMe6hceq3imYNI
	ym0xKC8PLRW87QOVbFxI+wtbSrB2QQ6sBu9jUxs+GsOITSfol78bMcwZUu+eaEaqxUGQc3wGP/z
	IeNqOIClp6/YqVA==
X-Google-Smtp-Source: AGHT+IFvEGn77kjtA6Y8SK5uc34FRU7qFYS3L/ZCPGwLjDFkpKGYZCp8QtLrY/o9FuB9JVbNkzTzQQ==
X-Received: by 2002:a05:6402:50ce:b0:627:f96f:aa7b with SMTP id 4fb4d7f45d1cf-634839a09a0mr1588732a12.7.1758702379165;
        Wed, 24 Sep 2025 01:26:19 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5cfa60dsm12473716a12.4.2025.09.24.01.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:26:18 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:26:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
 <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>

Hello Andre, 

On Tue, Sep 23, 2025 at 08:30:39PM +0100, Andre Carvalho wrote:
> On Tue, Sep 23, 2025 at 05:22:25AM -0700, Breno Leitao wrote:
> > For targets that are set by the mac address, they don't necessarily get
> > np.dev_name populated, do they?
> > 
> > I am double checking netpoll_setup(), and if
> > is_valid_ether_addr(np->dev_mac), I don't see np.dev_name being
> > populated.
> 
> I was not expecting it to be the case either, bu my understanding is that 
> np.dev_name does get populated by __netpoll_setup, which is called unconditionally 
> at the end of netpoll_setup. __netpoll_setup eventually does:
> 
> np->dev = ndev;
> strscpy(np->dev_name, ndev->name, IFNAMSIZ);
> 
> I've confirmed that for targets bound by mac, np->dev_name is empty before these
> lines but then it is correctly populated here. For targets create by name,
> np->dev_name is already correctly set prior to this. 
> Please, let me know if I'm missing something.

Thanks for confirming it. I think this might cause some semantics
confusion for the user, given it is asking it to bind to mac, and later,
netconsole is binding by dev_name.

Let's say the following case:

 1) netconsole is configured to bind to mac X which happens to be on eth0.
 2) there is a PCI downstream failure which causes a re-enumeration
 3) netconsole will get DEACTIVATED during phase 2
 4) After the re-enumeration, eth0 becomes some other and interface (not
 the one with mac X).
 5) Now you are going to bind do eth0 which is not the one with mac X.

> > Should we also compare that the mac doesn't match before returning?
> 
> Even though the above seem to work on my tests, I was not 100% sure we wanted
> to also check the dev_name when we initially bound by mac.
> I've also considered the approach below, which I think achieves what you are
> suggesting:
> 
> if (!is_broadcast_ether_addr(nt->np.dev_mac)) {
> 	if(memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN))
> 		return;
> } else if (strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ)) {
>         return;
> }
> 
> Let me know if you prefer this approach, it would allow resuming targets in case
> even if their dev_name changes.

I would prefer this approach than the current one, this would avoid the
problem above.

The other option is to always populate the mac during netpoll setup and
then always resume based on mac. This seems a more precise resume.

In this case, if the device goes to DEACTIVATED, then np.dev_mac will be
populated, and you only compare it to check if you want to resume it.

