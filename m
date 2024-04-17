Return-Path: <linux-kselftest+bounces-8274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1A8A8EDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 00:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7780B2179F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 22:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0493383CA0;
	Wed, 17 Apr 2024 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXIhwSN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D017C6C6;
	Wed, 17 Apr 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393043; cv=none; b=HIZthqj1ma5Jlfj9tPnIKkVZuddr7XStvB/jPhYlhUWc0uwG3G24vDqQMxPCFhVL3hnlvO80UOa5SNoSV31DdImb7is1GyZlOQgRGLO4Anb4UP+0Iv19Zip8MWKbh9TWBMDQHdk4MBMjw0kSwsKgmR5EdiIxv0xGehboYGMf3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393043; c=relaxed/simple;
	bh=go4rXzn30HjFjmyvddvUsnhccgo8cwdfzjUyWgFOz2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE2DUThPOqMiugTf36lZhjP+ywU6hinvvJG3KNyFZ420nnCP3gd8llRZ/wt86Qt1Iu0vO3ZATipKG6qrZYt02fum76YdwA3snPppl2g3FBVWQHnh9B+aO3z7+rjHUo9xh5dj8QiSfjysjAdfeit0135Kvjwt6Q9obaEk/oPQzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXIhwSN1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a2e5d86254so978701a91.1;
        Wed, 17 Apr 2024 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713393042; x=1713997842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q+gf/XCxYwLyR9ufpAByfaftVWu4p7It7YbQSgc9fYU=;
        b=KXIhwSN1jr69nsGVY/TpJewW0Hfl5FWSBW0YecRyNULfXpNhaNV4TVWyvRvZ78yMWs
         JPVOqQ0zq+PJ3ommPGT8y+RFbsQFSvmGtlvgotzWqwlH2cVslAZbJZbV+9PdMmorEtq2
         U9aXrOWwTv2732cSYqjFK+ROvZCd7dDWgVMmHzXHZJfJSaRwul9Z5LeIabqcBysBAZoz
         jix2vnaocP8DebH2zoOnrNnuDM4o921zvdZMeMleK2dUUxM8KG+FzXuTm4Vx+6XhpERt
         CRW7RN5JjEBjAIHW1V0QYVal2+DBVW12NwtH9CwRIRCMaVf/b+jLsaGsvGbu7JufBkUj
         4czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713393042; x=1713997842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+gf/XCxYwLyR9ufpAByfaftVWu4p7It7YbQSgc9fYU=;
        b=QnzTCFRslBmLFhquVp8xvBGBmp+urnzcmUpHKnwyiE0PkZbOLedI9U4S80aPjQ9ji/
         Q51/4EDwvn0uqEXf6/eS5WFu+lqCr7DA8Sutj4iL0u9oPJ0mpyvvLeP5JSk7CA3zEV3M
         k+RxMtZ43pBNjzaUV97G5FW6StRMsEdD1jHTpuWmMcS6BOEOjk2hOpCcZ6BrS3U7wDg4
         jhAZErhbWeT0U/FTNBR07OfkRdgDBr9Pig08O8iyKw2RnXW+UJqvOYLVcoK87BEpEFvo
         zNcFAO6edlgee0qG1202JQQukE1WdHFBbTKiJjvOlJXbZS+yTmesfM7zM3wR9RC5aOSg
         MqWg==
X-Forwarded-Encrypted: i=1; AJvYcCWM2ZKj5qVRX4mTYI4wIneizvMSBvHpPs2oNHcYG49tfwBkaVG3XjniOHfsmWcAcrsBBJtsc/LbhnySUQLmumoL+7pWT4fRlai68lelp4SemkbRJ9S8fMmr4/pg/p8FHeqboaRbx8l9P/dd4Z8CW0LOu7T8AfU6ThA0Gh75fc0vhF0F6qPV
X-Gm-Message-State: AOJu0YyG/Z12/hMHljJ9bKPdVSSYT2YvijoozdB687HQzFhc06RsixSu
	dhVR+U6mUHqz40Z/2MiYZoYN2rg66CrTyO8f8fmgqeU4LATZVmzeZtBB1nh4Jurwi5ps6b75wvo
	TPURxEGHAMaOkOY+I75rNbWT6l00=
X-Google-Smtp-Source: AGHT+IHCSTBVrPAHK0lZoXXj7dEZN7R8pA/Yna1VOwZAkttLIuRGJGk8KlHUmOvSEnjjlcNVZk3Wnd8z1stY4zVb7ZY=
X-Received: by 2002:a17:90a:f484:b0:29b:d747:f7ae with SMTP id
 bx4-20020a17090af48400b0029bd747f7aemr657518pjb.14.1713393041590; Wed, 17 Apr
 2024 15:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
 <20240416072809.3ae7c3d3@kernel.org> <CAJwJo6Yw4S1wCcimRVy=P8h0Ez0UDt-yw2jqSY-ph3TKsQVVGA@mail.gmail.com>
 <20240417134636.102f0120@kernel.org> <20240417142843.27a221f8@kernel.org>
In-Reply-To: <20240417142843.27a221f8@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 17 Apr 2024 23:30:29 +0100
Message-ID: <CAJwJo6agHEsWjhNzAstwU_+kQd4er3QsNZebkCOCDGBGh4SiMQ@mail.gmail.com>
Subject: Re: [PATCH net 0/4] selftests/net/tcp_ao: A bunch of fixes for TCP-AO selftests
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 22:28, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 17 Apr 2024 13:46:36 -0700 Jakub Kicinski wrote:
> > > I can spend some time on them after I verify that my fix for -stable
> > > is actually fixing an issue I think it fixes.
> > > Seems like your automation + my selftests are giving some fruits, hehe.
> >
> > Oh, very interesting, I don't recall these coming up before.
>
> Correction, these are old, and if I plug the branch names here:
> https://netdev.bots.linux.dev/contest.html
> there is a whole bunch of tests failing that day.

Hmm, yeah, I was looking at the history of selftests to see if there
is anything else interesting:

2024-04-11--15-00 - lockdep for hashinfo->ehash_locks vs tw->tw_timer

It seems that you actually reported that already here:
https://lore.kernel.org/all/20240411100536.224fa1e7@kernel.org/

2024-04-04--12-00 - lockdep for p->alloc_lock vs ul->lock
(rt6_uncached_list_flush_dev)
2024-04-04--09-00 - lockdep for p->alloc_lock vs ndev->lock
(addrconf_permanent_addr)
2024-04-04--03-00 - lockdep for p->alloc_lock vs ul->lock

Was reported as well:
https://lore.kernel.org/all/8576a80ac958812ac75b01299c2de3a6485f84a1.camel@redhat.com/

2024-03-06--00-00 - kernel BUG at net/core/skbuff.c:2813

Can't really track this down to any report/fix. Probably as it's month
old and hasn't happened since on these tests - something was borken on
that particular day.

> Keep in mind these run pre-commit so not all failures are flakes.

Thanks,
             Dmitry

