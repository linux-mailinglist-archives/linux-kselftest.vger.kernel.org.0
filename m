Return-Path: <linux-kselftest+bounces-18618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97E98A119
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491DF1F24B8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F226518D63A;
	Mon, 30 Sep 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkwm81XV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9811E87B;
	Mon, 30 Sep 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696964; cv=none; b=QNUIaaVdYckmERWIoWJ5pp/gAdeAPCWRxfH/If7XHRPwG9tJTfqZSa+RgeaS54nukhR4x+2KscTwpQJWzAYm6tF0QphazcQs76tKXimR5azRNww88c0IvHZ90bYlBF2MnJpHDzivWN0QkZHdo6kXRBSDa9leUAW95hxT3K92DC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696964; c=relaxed/simple;
	bh=dV01gujH/B64uv2r3404PO2MsRllqLGH4/usAsdPCx4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LMrPox9YTLrC5P3RMSPlJSocXxtsh7GL/Njo7oVFIgnRa2W+x/Ka0xbiURi6YiqN+HvMXWNNBglOaQFSAQBPDbmtDR7bP5VXeeGxRdSdCr6MDHg35xz6DcD5G3aUHWQ6c8jn650Yp8T8YQhoWcO/Z0OWp9lKn8KGinQ6AD1Ch5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkwm81XV; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb2aac40faso38377076d6.1;
        Mon, 30 Sep 2024 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727696962; x=1728301762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIkfDWwMUEDd7Uebcbfthdgy/uHUylx5rO59fmCE2Xg=;
        b=Bkwm81XVYW00RVjwSvo/aK9nozavq2Ua4FqCKTe9oG2Dn37etJN+KNtOSvv99Khewa
         A7cGEekwKWCXwTf2f8EvRdtsMU7725dIpf8/M1wtsMCeXNdGwWf23YPzeOYLgMQgyn1d
         tMsNlLxggAVvGC+4CuZvLFDvYhmuLkhL3O2q6btyGoxYYb+tUY153E+ALWChp+E4Qh6I
         l1iWJQJlo5gewNMQZYQVZJuKSVMFoL/SjCG/8zIskjwiQ2jCW5pv+B7orCfQ66l3ctYb
         L8U/befEcAW8UzylCepdD5V7M74AyxLfpqb2KKl9osfKEIK0znN54WZkr4mPD3qclooy
         AO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727696962; x=1728301762;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oIkfDWwMUEDd7Uebcbfthdgy/uHUylx5rO59fmCE2Xg=;
        b=if44sdtgpp5cbpw3yQNLvhA0vsnHA6fODsu4wbvygBeqyIYB6Mu90iHOHnyNpjoZpk
         xEPDP0yIFLHsXdnDiN+4Mie6eL5ERSiu0Yx7k7nOkMAtrSUDkNILUTELGLWAzpMVwvYR
         ljExHkbfMUJh/ykv0fUOrGerbS/ZAtc5HOc3h2HOXL6fI6GyFf3SnKj3Id1E/w0ccW56
         RlH6oGzL9JaoABfbRzF4QVnhpFuZxjlec7bkmmfCekGcB+BZBsBzBzbeX7+sxrZAvc+f
         +TFUb0MaUorFMT/wWqQkdeOYW8jZvCllWYsEQYHb0qiey69Vp8U/TslYx2vMLlBePtKu
         Zxdw==
X-Forwarded-Encrypted: i=1; AJvYcCUpXBjHlpVSKkArXwvl5MSNqRwgvKEcrrH/ON3EgI7prDDOro6v8h2BcB32kDCyLYyUdwA36RAsD3MiyEh2PZM=@vger.kernel.org, AJvYcCWF476u7nhlUONMcCv5vLgRZM73VFUYcHqYOUVJrkbe5/hUEoV34RdtAKDLpOTDl8osNibSy4i4@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtIbW30ZgDmvxz0/n1s3Z5YBAf3wgYcgtl45M0Z5PWuVj9n2E
	JXdpAP+rvNQg9cH+hYPt8Rx8KIhZ3wfxpm25zwCnOlJpzDeu1Edf
X-Google-Smtp-Source: AGHT+IH2UNeV8WA4/DyRxRYxeH2DpmLMzo1WXjCAghqGcgffv09qazmGAQeiWj3HWZuFpinewl6ZgQ==
X-Received: by 2002:a05:6214:212f:b0:6c3:6477:16e7 with SMTP id 6a1803df08f44-6cb2f283867mr268349326d6.11.1727696962062;
        Mon, 30 Sep 2024 04:49:22 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68d808sm39166066d6.130.2024.09.30.04.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:49:21 -0700 (PDT)
Date: Mon, 30 Sep 2024 07:49:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66fa904185c3_17cd892948a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC+VEs1UusEKKVhutw+e=uyEqoaBhRTUV1G4HakM3JVYQ@mail.gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-2-kerneljasonxing@gmail.com>
 <66fa7fe46392e_17948d294bb@willemb.c.googlers.com.notmuch>
 <CAL+tcoC+VEs1UusEKKVhutw+e=uyEqoaBhRTUV1G4HakM3JVYQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net-timestamp: add strict check when setting
 tx flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Mon, Sep 30, 2024 at 6:39=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Even though this case is unlikely to happen, we have to avoid such
> > > a case occurring at an earlier point: the sk_rmem_alloc could get
> > > increased because of inserting more and more skbs into the errqueue=

> > > when calling __skb_complete_tx_timestamp(). This bad case would sto=
p
> > > the socket transmitting soon.
> >
> > It is up to the application to read from the error queue frequently
> > enough and/or increase SO_RCVBUF.
> =

> Sure thing. If we test it without setting SOF_TIMESTAMPING_SOFTWARE on
> the loopback, it will soon stop. That's the reason why I tried to add
> the restriction just in case.

I don't follow at all.

That bit does not affect the core issue: that the application is not
clearing its error queue quickly enough.
 =

> >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/core/sock.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index fe87f9bd8f16..4bddd6f62e4f 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock *sk, int=
 optname,
> > >       if (val & ~SOF_TIMESTAMPING_MASK)
> > >               return -EINVAL;
> > >
> > > +     if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> > > +         !(val & SOF_TIMESTAMPING_SOFTWARE))
> > > +             return -EINVAL;
> > > +
> >
> > This breaks hardware timestamping
> =

> Yes, and sorry about that. I'll fix this.

As is I don't understand the purpose of this patch. Please do not
just resubmit with a change, but explain the problem and suggested
solution first.

> >
> > >       if (val & SOF_TIMESTAMPING_OPT_ID_TCP &&
> > >           !(val & SOF_TIMESTAMPING_OPT_ID))
> > >               return -EINVAL;
> > > --
> > > 2.37.3
> > >
> >
> >



