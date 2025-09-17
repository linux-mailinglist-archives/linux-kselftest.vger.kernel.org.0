Return-Path: <linux-kselftest+bounces-41747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89346B814A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D67F4A0A4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3E12FE074;
	Wed, 17 Sep 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AlZHjY5p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8B2F99BC
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132232; cv=none; b=nwvFjeIq4jU9QstelvCObRg4wpr3PEUDjbFDGu/UoVPQ8C/KecJ0ARIclUUoMHlgP2QJ2BcI0r5m059ZtfHGxKKSxjgBdEYMHD6z4hTCpytS3MLlzVjaQa6EQUdZGZWgWTpzKEVuN5/Jjvpp5TzvJxXZz2jVoKhjissadIKAr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132232; c=relaxed/simple;
	bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dqnup94ZP7EdhCP+Cga3oOmw211MfbRauQurQS5xd/d9FnljQoCJa8KqYhE+rNcZgsWb8s8p9tVpMq6L4Fpm6ZF2TwhB9SCmqEhv4DDgjlBr0td2530EQ+GP238OVoi1z6Q4DTKoeNt/N0V5z0Uz81Zd8qSNm/IFWhD1i5Bd464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AlZHjY5p; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-826311c1774so11006485a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758132229; x=1758737029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
        b=AlZHjY5pLbNMOLakalGc92MW5ePib8g7OHqRT2sEY33nSgBFhY8X7mpVm29Uum3FvS
         Rt3CjHUzM0yRxa9wRBDa2dRvvk4EObjiDQNPwSkvxCeJN0/Ww1xjBACMVLvkZG5hRpGN
         YuRbBSPbTuO7AWeEph1h+d1a0m3lQY9Y9BtzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132229; x=1758737029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
        b=qa3duyz07b2qxcPcY/9U3r7I3lTPDSFmMrBtJSKWbtHE6buxoa2O705ukTQ8ZSNDFu
         1L16pLEWaOSKceeflVA9DfxGPrZSRZ/6nLpRia+vh/J+l1IUg/EOvDBTpRqywnQc+LiD
         YB7VyoNW01vohUcn/TKa3gVvBnB7evSTwrFznexOchds2A9BEWRo/aIZZwP9nae+hlcG
         pt0JLCunNRZw3qs101KuX0AisDHEv62p9R44dUuthc8WXofboB+cwtqhy2vTQOziCGZG
         x51egf5ES2stDr8Ib8dvBEGX1P0SKvbGsvVv0wlxYtMp+fiz6iDLYgFS4e6m7EOskO0v
         cgKw==
X-Forwarded-Encrypted: i=1; AJvYcCUlDJdkeCtYK61n9V0K01lwBm9twdOrto+xzMGhV/ER4aDUFZxbVT58XoQ8YTTdr222vMFk/OS2eda9qxtLNwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIihC2K7TuVzAVieYGoCMDaY7AJIHvO1F0SUJBMchBlyf9FjnP
	C7QsMDuw6SCUFnQs+OPENu0adQxuablIWUuhbx+hOBKNafHL8tCv9o7MjcHZX1/OLMio5lk98ki
	IKOUFfw==
X-Gm-Gg: ASbGncugMC7rlAohJTUc/+iioyy202ifvIJOYeQe6tRz0yAMEDFP5K7GoVKpCqAzSMI
	TNuVME3MDI8rG3qv4fxvO3G5D6KIHjT97QjQYpNY6dikmw6tMnlwlvlYrxdP88kevr3mg+ZdfKR
	zrm+TH81dCFTNFKo1To2UteqEQe19KjRh/lQw6ydqb1CEKjkOqIhcwuXL2h7kG4yGN/Lq3M8l0N
	xFlQobjBpuh2nKraSlK3lE298++rFPbFFs1VyL8l25aLFch7hd8B/AVPvC0KYVHrbSdFClAu2bf
	V8duhdZO0cRQwWEc+Tz6f07YJe0w5VRRBEe+EYSCzZIPVKAgC9pP67zxkId5zTT2dX5Xt3hj40+
	SJZWhQ19O441dkBcsOA5lnL5jdV9pqnMKdODFsw+rIQnzEz3wzCQ1RwVXOpvHzOo=
X-Google-Smtp-Source: AGHT+IFVEPvL4LxVAXFrI5dp19hJe7iagDwmdlY4t/wFQiL7lWY3t9eitQX4BYIzeut9K7PGCG0skQ==
X-Received: by 2002:a05:620a:269a:b0:80b:104:c2e9 with SMTP id af79cd13be357-8310aee308bmr325316185a.8.1758132229224;
        Wed, 17 Sep 2025 11:03:49 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83627d7dd01sm23087485a.27.2025.09.17.11.03.48
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 11:03:48 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b78657a35aso41341cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 11:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmIi1Wk12Po+fI2efWOOD+D7m9GJnE6cyTkKEq8eediMDGOQjjhaWJxNP0+enuaEjFSI69JyfNeyvXYmSF88k=@vger.kernel.org
X-Received: by 2002:ac8:7f91:0:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4b9dd3c17d4mr9004781cf.8.1758132227600; Wed, 17 Sep 2025
 11:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
In-Reply-To: <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 17 Sep 2025 11:03:35 -0700
X-Gmail-Original-Message-ID: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
X-Gm-Features: AS18NWBTH_B8R-w_buHc5fkH54TOh_tt5uj3eXyk2xndepoDoKd89R4ajv-MBKE
Message-ID: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I think the justification for the original comment is: epoll_wait
returns either when events are available, or the timeout is hit -> and
if the timeout is hit, "event is available" is undefined (or another
way: it would be incorrect to interpret a timeout being hit as "no
events available"). So one could justify this missed event that way,
but it does feel against the spirit of the API, especially since the
event may have existed for an infinite amount of time, and still be
missed.

Glancing again at this code, ep_events_available() should return true
if rdllist is not empty, is actively being modified, or if ovflist is
not EP_UNACTIVE_PTR.

One ordering thing that sticks out to me is ep_start_scan first
splices out rdllist, *then* clears ovflist (from EP_UNACTIVE_PTR ->
NULL). This creates a short condition where rdllist is empty, not
being modified, but ovflist is still EP_UNACTIVE_PTR -> which we
interpret as "no events available" - even though a local txlist may
have some events. It seems like, for this lockless check to remain
accurate, we should need to reverse the order of these two operations,
*and* ensure the order remains observable. (and for users using the
lock, there should be no observable difference with this change)

