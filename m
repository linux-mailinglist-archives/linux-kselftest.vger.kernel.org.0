Return-Path: <linux-kselftest+bounces-20412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9874B9AB5F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 20:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47241C22FB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE491BD50A;
	Tue, 22 Oct 2024 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSgrNqBf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F313AD26;
	Tue, 22 Oct 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621436; cv=none; b=PKJrN48hIEoDWUOG8xbY2O2Fa43YKPmCdSBkLa4KqWb1PzH5No5gQuLVVc5EHXmDfIeevNEWoyV334lvNHrrPY26MJoewjOy5JUbzOkfs1M/ZpwBMLgzpzJA8EsYQzx1e8YTVhDlGLkioKj1cakJI7Yp1IqJeDVReW/bKlx7WDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621436; c=relaxed/simple;
	bh=BOMAYDW+Igb6QzFLZKO09qOvyXKcXFjsCFi4QDdyGIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kil5tJCjFABDyZadGwb6H6KCnRM2Kfjm+wNzhzfuUa6KYco9fQSaY0ZH+SA/BIWT/eGTEFKMtPVZTAeP+mTwdjt/rjYO2Pps5UNdZakpFl+aA0cwscrRG4ntwE1I0yEtv3jUtS8lXyr68tQiVx4mCYm0+aQozrBk7hk4ylEU6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSgrNqBf; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso61774881fa.0;
        Tue, 22 Oct 2024 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729621433; x=1730226233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WSybiWG6nkcP2XymYOQshi5jKk8nvWAvANTV5h8LSvQ=;
        b=hSgrNqBfzbwBaADRr9/j714DjhwANHTeA3NAzWe6kF8WiOXOsabvJCxlMCuY1zNSIz
         fun6C7WGEt6+Ga+ZbyuVVlHhIjSBlHQ0awzJhkxJHTKkx2R40yXDZQSmOBgjgLbhC5f5
         UOJgOXGUyOQlDOaJphnvyM/oB8ogYmDnhA1lHQK2PB30oPLRFoH6rhPJtyKMxCF2vI46
         gDBk8bCEHM853hwGkuW5cYT2K+aHz97CJdGTJCKG5gPlhkoY6GvJQsOpwnYJTmyhjo6R
         zYwKGmwUuvsIOKAKmEhDrKsADqDsDShJGru/oeZN7dA7Q6onrcVEPNWmbzyh0KXLJTD3
         RvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729621433; x=1730226233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSybiWG6nkcP2XymYOQshi5jKk8nvWAvANTV5h8LSvQ=;
        b=ZzXIULBRWkkFd62tqvRO93IgsQCImBmEvq0sfseja3ytjXBHaWOBj9iSAlPQUx6XPH
         HCd4QkJ1o2L6B7ci3769Fd62VQPZOmdKO2gWVrioFn0i4TIOjjyPKSmTmyHjT+pv023b
         9TAg017mKQUhBm5MBIdKHjDPP51qLhQf0cxuY1G5Fl7jbzfX9f8fjaSMfdc72/IbTwDU
         CMKDnOaDtWegyYiz2uAz63xdxhgdMuZsl6AGFbgD3B1W6f5s7RmJRQb/jdxHeVarSOQc
         NCVG+a7D7EjF+Qo4LruKLrbXImUtzPIzKYW6SEjgESTRuPU6cJJmh//6AwSHTxGZ9NYg
         ZDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuMX/I15SLggEqWP98Jz6PVvdezP+sx64DmPSgv8L1CcxGvSO31+6pAS305Pm0rcDrx9suuPjltp9u/X8=@vger.kernel.org, AJvYcCWJqdNnYGK5Jbp23mi4Oy2uphnheBjn8sKJXKJbidQvT9aUaW5Gl2NoiitH8AELYcUtTyt0C8nQki4Ts1mrfc2a@vger.kernel.org
X-Gm-Message-State: AOJu0YxNKFzp1Lf4UNoOalprJarZHYYqJ3kvQy8IUhMwDdOTcrBZbw8I
	G22Exs9LLhODTWcff8i5QF2WN0kOdADe67y0qj/hHDTYsFIR5DEIqyNk31LEjEatVr1sCrOKNyx
	7evgnSRHbWl6h2/IWStjjZ1jYWJ8=
X-Google-Smtp-Source: AGHT+IHSTWuh+cxuAsDJ11/P+22UZ1Tqj+2WUC5apoHe2/LrdHzloxdsnOAOqkMCPMLoPH3wlnoI8wXTro7nhk17wUQ=
X-Received: by 2002:a2e:9d0b:0:b0:2fa:fc98:8235 with SMTP id
 38308e7fff4ca-2fc9bc46569mr2204131fa.42.1729621432497; Tue, 22 Oct 2024
 11:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022122158.2136-1-quic_pintu@quicinc.com> <20241022140556.GB219474@cmpxchg.org>
In-Reply-To: <20241022140556.GB219474@cmpxchg.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Tue, 22 Oct 2024 23:53:40 +0530
Message-ID: <CAOuPNLg_Y6aNwj8muAWhm7ibcNZ7dp6t57CFKB+oZoV1Ao_xBA@mail.gmail.com>
Subject: Re: [PATCH] selftests/sched: add basic test for psi
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, shuah@kernel.org, surenb@google.com, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Johannes,

On Tue, 22 Oct 2024 at 19:36, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Oct 22, 2024 at 05:51:58PM +0530, Pintu Kumar wrote:
> > There is a psi module that exists under kernel/sched/psi.
> > Add a basic test to test the psi.
>
> I'm not sure this is a valuable use of test cycles. The mere existence
> and basic format of the files is very unlikely to be buggy, and such a
> bug wouldn't hide for very long either.
>
Yes, I agree this is just a basic version to prepare for the test framework.
Once the framework is available more tests can be added, such as trigger poll.
If you have any other suggestions for the test please let me know.

> > @@ -18548,10 +18548,12 @@ F:  include/uapi/linux/pps.h
> >  PRESSURE STALL INFORMATION (PSI)
> >  M:   Johannes Weiner <hannes@cmpxchg.org>
> >  M:   Suren Baghdasaryan <surenb@google.com>
> > +M:   Pintu Kumar <quic_pintu@quicinc.com>
>
> $ git log --oneline --author='Pintu Kumar' kernel/sched/psi.c | wc -l
> 0
>
> Really? ;)
>
oh sorry.
This maintainer was added for tools/testing/sefttests/sched/psi_test
after referring to existing once.
Otherwise, checkpatch was giving below warning:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#51:
new file mode 100644
total: 0 errors, 1 warnings, 134 lines checked

Please let me know what is the correct way.

Thanks,
Pintu

