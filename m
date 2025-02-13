Return-Path: <linux-kselftest+bounces-26556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAE5A344B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 16:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6177F7A3605
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1614831C;
	Thu, 13 Feb 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnsAAn+N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA626B080;
	Thu, 13 Feb 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459203; cv=none; b=cVCtZvSy/mx5KMMkfiW/HTUL70L1zykdzdxoVlU0L654WRb0JFkHfSksPhHl9yatUJbZ5zyH33KG7R53aL0zd4nLe+BOGFbp8XOTz9jiYISJvtXFQFMD4pcA+/jq2NQFNpoMrWKP+901ykD7e6NWZrATfYzT5w81q5+5dzRFuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459203; c=relaxed/simple;
	bh=QRu6YNCJ6CAdbfZVzys1lbmIOv16QxmAy6aoY/mj5ws=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=F0a1+YJR5mTSTE/ez+qTRo37dJpOL2+XtY1eHKcKZgKw2ynZt9tllMWowB9/DPwmSkipKcRkiPvB3kbtagu9rfY72GwfTo/MFCmxgqLoZomzsp5Ko02xW2bvJWQvi9bKPf6yuufIFqqBoV7KFgeHt7l8TrnvN8cmWJtsNEio2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnsAAn+N; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471c8bdabcfso3939881cf.2;
        Thu, 13 Feb 2025 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739459201; x=1740064001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRu6YNCJ6CAdbfZVzys1lbmIOv16QxmAy6aoY/mj5ws=;
        b=nnsAAn+NfSG5ljWRaPYbbYH6BZdtnyN7E7QXqZzAkBISyCsleLB/2j0uyBYegRtI9i
         8huBYDNXTyOJsfCIJUBQIhz0vWxaeQsz5sbyadWe8kcPeYNDwAyHa0qVx4uGI6v+M455
         ff8IKw9rfmQc0WegPMcmV+c+KYJpwSZiEIm0gTdL+TnUBAJvXvb4WQlh7qMQx6ywnhQh
         0C0ppjnqMs88uX1K636b+VDasEt/6UekQwjjdcuFoy/3Anen04TeA7KSZ7ivWqvnP+6b
         jWHISnNMeFLiwfIGytdCyDauzaVgP3ivc14A+izHTmns4908afOLoJymL8W2qZ0nbJfC
         MOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739459201; x=1740064001;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QRu6YNCJ6CAdbfZVzys1lbmIOv16QxmAy6aoY/mj5ws=;
        b=b3Kt9a0rQZfQ2W1eDd6tWZBgci2nc2/G49hfZ2R0ciCSS3II5JAX/F84VHOJsWaB/M
         SgL3scsUUQkNGEnyQ1h/rVOIVCCFlFexKc7nt46hvyGZgFMJ1yFLMbFnjmgDGldZ9QTK
         tldJxDKhlKq7UzPGMjthawcz6RwipWk83NBwVU84lGF5cr8j6LbeZwMJPCCOOZXmFTEa
         gin39x1DQTpDDkWzCSiel9E9pVikWADY1dvnLWapY3SjVNamBfnMF2S1GFOmGHDdXkYO
         m63McVzNs3GSGqxXgMoixHg42/Cnao+A4QreSOTNgpAMwmgGPgs/amsA9tyjT05kvaUY
         dEhA==
X-Forwarded-Encrypted: i=1; AJvYcCWWD6ltDeFW47hERCSrzROl10gXUrZpN/7DJK6F/KggIsaooqpyyAOCte+A2RTbzjmVmdwuXLsARBn9kB8BkLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydccs4JcAg8J9GiGDS2NYIb9+QZ1o74NUgRJkQ0dm1zISkFJTJ
	tjgveM97mBnUF2gB/bNidBnmIRrvW741LlvoX6+JTXLJaznLYFwa
X-Gm-Gg: ASbGncs7e5XUdPqt5Gx0SI5jgXjw1+GkVfCQY9p9gi+Tmb9MIVtOYVBY7sAGIsQs0m9
	c9DVs4GaG5Hj4q4LEwI1vgAP/s1db8piz2pjJwTwN0hon26lhkeW5GRBNe0uAEX889RscLzdwMk
	0+bxTuEX4qyQ9GSa8KtWbtEC02pu7ZGddROygrMEuqpWHrPPxGe5TxWJNku2d7hzujyrljw1gAX
	cPA/Om9TeoDgy8JlM0le4rwMOZU6hXm+tFzDGj2tE4myoUSiuX90IlvFodCSjz8F8zbVIDISAHm
	yuZy0nfUO1YbuJEuM2wZeAWPhHl6mRVZWP+5GtsFbuVBivdLEng+CP7s0hJBfds=
X-Google-Smtp-Source: AGHT+IE6bwqcfU1yJ3EL4ucljVAN/H74late+gSRNOZLXFyhy2eyNgcBcdloyAJPE9jkyWHrOjvYPg==
X-Received: by 2002:a05:622a:189a:b0:471:a693:591b with SMTP id d75a77b69052e-471bedbc6b9mr51581381cf.51.1739459200843;
        Thu, 13 Feb 2025 07:06:40 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af37d2sm8594831cf.63.2025.02.13.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:06:39 -0800 (PST)
Date: Thu, 13 Feb 2025 10:06:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Nyiri <annaemesenyiri@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 willemb@google.com, 
 idosch@idosch.org, 
 horms@kernel.org, 
 davem@davemloft.net, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <67ae0a7e9b5f6_24be4529453@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKm6_Rv4LCpy6KaV84gOi7wW7OKdasbx2zqfFwFG26=L6rkhgA@mail.gmail.com>
References: <20250210192216.37756-1-annaemesenyiri@gmail.com>
 <72634e76-7bb2-48d5-ab21-9d5e86adee9c@redhat.com>
 <CAKm6_Rv4LCpy6KaV84gOi7wW7OKdasbx2zqfFwFG26=L6rkhgA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] selftests: net: Add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anna Nyiri wrote:
> Paolo Abeni <pabeni@redhat.com> ezt =C3=ADrta (id=C5=91pont: 2025. febr=
. 11., K, 12:19):
> >
> > On 2/10/25 8:22 PM, Anna Emese Nyiri wrote:
> > > Introduce tests to verify the correct functionality of the SO_RCVMA=
RK and
> > > SO_RCVPRIORITY socket options.
> > >
> > > Key changes include:
> > >
> > > - so_rcv_listener.c: Implements a receiver application to test the =
correct
> > > behavior of the SO_RCVMARK and SO_RCVPRIORITY options.
> > > - test_so_rcv.sh: Provides a shell script to automate testing for t=
hese options.
> > > - Makefile: Integrates test_so_rcv.sh into the kernel selftests.
> > >
> > > v2:
> > >
> > > - Add the C part to TEST_GEN_PROGS and .gitignore.
> > > - Modify buffer space and add IPv6 testing option
> > > in so_rcv_listener.c.
> > > - Add IPv6 testing, remove unnecessary comment,
> > > add kselftest exit codes, run both binaries in a namespace,
> > > and add sleep in test_so_rcv.sh.
> > > The sleep was added to ensure that the listener process has
> > > enough time to start before the sender attempts to connect.
> > > - Rebased on net-next.
> > >
> > > v1:
> > >
> > > https://lore.kernel.org/netdev/20250129143601.16035-2-annaemesenyir=
i@gmail.com/
> >
> > Unfortunately the added self-test does not run successfully in the CI=
:
> =

> I think the test is not running because it is added to TEST_GEN_PROGS.
> However, after reconsidering, I'm not sure it should be there, since
> this test does not run on its own but is executed by the
> test_so_rcv.sh shell script.
> Wouldn't it be more appropriate to add so_rcv_listener to
> TEST_GEN_FILES instead?

Yes,

+TEST_PROGS +=3D test_so_rcv.sh

is correct, as this needs to be called from kselftest.

+TEST_GEN_PROGS +=3D so_rcv_listener

needs to be TEST_GEN_FILES as it is not intended to be called directly.

Documentation/dev-tools/kselftest.rst for details.=

