Return-Path: <linux-kselftest+bounces-16156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8C95D031
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED9AB2C3FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F139B188A07;
	Fri, 23 Aug 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyXscExh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769981885B4;
	Fri, 23 Aug 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423250; cv=none; b=XPFbY30fwh2nqJsHq/UrhSX4zeNhI+okbNV8VxzyqQyKvDDve8i2xbt1YHrDsmT09UqedeV959GeTUmope4b/89w/dnJioQl4WR5a2wd2YPJU8tPMQCl/8GplylaS7WzifMGxL1uSccEEZK/YiQuVuf/sPJZV8HfQbd17L3Qdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423250; c=relaxed/simple;
	bh=vrHfFAtyTYU/vEWV4sr7xgTlF9qhuKM0/WKOzmuISPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSfA0HgMmzuKZnTEoigP5i5B2n3XjT9sNDtMJG3x7E4TOYc3CninlRtZQZdVJ80m5wKJfbVOr1Xr11JAdqtcwaAeS5XsXQ8HsUxcPDNMosPTpArpgZ07Yzo5dLlbjuC4DD6ffsz81re5KOc5rAOQEB+KmrT/ore5F9HuVNRqLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyXscExh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714262f1bb4so1708808b3a.3;
        Fri, 23 Aug 2024 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724423249; x=1725028049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KacMsRbnjBEszE7BgUys9UOYH47mgd4u1o+yN5SyyKc=;
        b=AyXscExhzfWQgSV0vEMKGw31svUVHYguCE6Ax408d5gfFoyVRPr5t4flNpNzfqlFG5
         3qkeeut142vhNuOBdEaCelYulj/BH0/n498mzTGWxj9cEh1nXcgpUx43F5X2H+uIqkbj
         xoonqEo8vgZ/2qMo+yVWzGQBgjMCs9+zp8wk9rBc+i0jidbJqdnyvgp5Vr5IGWHpk9py
         yFGkuQHHfi+fozDbCdVgkgLHNB3czB5udye1AXXPQO8+Hu3kz0hVkcSiavJPDt0qL1Z0
         jBQOQLTVuUpa4quzfXcU/lpTSg7xV0XKie1mI1X7WQFncVqJtfiTPNH5yHt13scNkguR
         9isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724423249; x=1725028049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KacMsRbnjBEszE7BgUys9UOYH47mgd4u1o+yN5SyyKc=;
        b=rhbTKeindflSGZYwnMlJ0vMdaW8drISWGalRdh0Fs9+T68i8nVvFuUSXSIBI0VL3tt
         ganeIF+uUUtxaKFYkFkQU8Xx0ivd8Jl0KK735hiRbyHiBkHsUdbhRd0T7IP7WnV+L0CV
         yAS55d56ndAQrfOb/gF76FagEkrqUQTxShCsolT6lAVe/6BB4Plhwr6e02bgc1gG/bax
         ZXWmsf8qmY+lvoZ4I0Wa2geBDs9TJzThF1AztjB5BkKBCiRp3rN9KOVf9gOwe17c3VDl
         lCciFKA2ZC6+c8j3nlzs2gDW42nwetHXcEJRlfQlOjG0mblx1QQHdw1eOlyLf2Jkx1fX
         kuJw==
X-Forwarded-Encrypted: i=1; AJvYcCUCdHa2PePUWZKDuEuyeBxfm2pmSZ4/qynzVn7U1s+RtxKAK+3d5xFh1MayEX+ytrLcC1cgOsf5TEcs83A=@vger.kernel.org, AJvYcCUeUcCSbMqPtCns2o+R1FQgIcq3XJDKhgkdU892ny96xYKEotl//AEKYRQt+VHsBUlTZbTPHm9u@vger.kernel.org, AJvYcCVthmPYpMzhUW9kMXO/1MIwZoTvyZPrtfKMubh2LUbKbZ7WoWbBUxmVVxeTUC2A7PC1ncyK5ZOks3PlZ/RsJsyF@vger.kernel.org
X-Gm-Message-State: AOJu0YwiROmbn4IEaTwR9knqOCgNlBKsWnu4vXZOfGpKlmBg1+KYAWLE
	G8Qe880yRFvzjaonr3Ehh29gRJXC7DVFbypHtWZEHhuigys0WvIOwltaRURyr3cjmnZSAro+ys/
	5ALC6jALaOcvYYYSocHnySu39ITw=
X-Google-Smtp-Source: AGHT+IHXq68Af02NOud52gJvvYvsRbnAv54cUYzs+7St2Zt30iiL39jJ9aR7NzlzY2ozsTN/507wCWIs2TdibOUTvs0=
X-Received: by 2002:a05:6a00:10c1:b0:714:1a74:9953 with SMTP id
 d2e1a72fcca58-71445d5b1acmr2630636b3a.16.1724423248623; Fri, 23 Aug 2024
 07:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
 <20240815-tcp-ao-selftests-upd-6-12-v3-2-7bd2e22bb81c@gmail.com>
 <20240821191004.GF2164@kernel.org> <CAJwJo6Zix_bkE38RmDW6ywojvmzeOuPVtwH+Jqqz6AT=6jmh5A@mail.gmail.com>
 <20240822101339.GI2164@kernel.org>
In-Reply-To: <20240822101339.GI2164@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 23 Aug 2024 15:27:17 +0100
Message-ID: <CAJwJo6YFqhS6KS2fArzg8ovDbWgysDvwvB8KmO-gJoPdWOBw9w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/8] selftests/net: Provide test_snprintf() helper
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 11:13, Simon Horman <horms@kernel.org> wrote:
>
> On Wed, Aug 21, 2024 at 10:35:10PM +0100, Dmitry Safonov wrote:
> > Hi Simon,
> >
> > On Wed, 21 Aug 2024 at 20:10, Simon Horman <horms@kernel.org> wrote:
> > >
[..]
> > > Hi Dmitry,
> > >
> > > Some minor nits, as it looks like there will be a v4.
> >
> > Thanks, both seem reasonable.
> > Did you get them with checkpatch.pl or with your trained eyes? :)
> >
> > These days I run b4 prep --check and on latest version it just gave a
> > bunch of fmt-strings with columns > 100.
>
> Hi Dimitry,
>
> For networking code I usually run:
>
> checkpatch.pl --strict --codespell --min-conf-desc-length=80
>
> Where 80 is, I believe, still in line with preferences for Networking code.
> Although I'm not entirely sure it is applicable to this patch.
>
> As to your question, in this case I think it is the --strict that causes
> checkpatch to flag the issues I raised. Sorry for not mentioning that in my
> previous email.

Good, thanks!
Now I can see/fix them :-)

Cheers,
             Dmitry

