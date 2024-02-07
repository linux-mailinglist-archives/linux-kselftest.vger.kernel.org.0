Return-Path: <linux-kselftest+bounces-4273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B51584D0E4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7991F21F1C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DB612838C;
	Wed,  7 Feb 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRmnYruK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523883CA7
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329088; cv=none; b=qG1zt9KpmwhIwrui9Qoasoh34yLigBVFN6nMorjv1R9S9Gqdbm82ulE9GD8LmhyN1ouGp5lacwhIHaxJgfGLrtV6Jblex5ZMkDc4Je07PPcrbwv+soqc36LaNL02b67E99IM+y6ov+E7ZnIFKy389yHaWNL7o5oZ+zw7QYr9yTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329088; c=relaxed/simple;
	bh=MxlJu+J6TLx8yj+iNOuTo7euy0CLu6uztwIQApSEcdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buRhd8NPQFlrmIMylkbZeR9YIyZ0MwhSgVPuPDEYxxFsoAslQ+SPUQMH/kQW414lQBgoqAizlWkwN3dMvHHSY+/KMuF7vWWmRoZobs/CZE42V8uhD7wBhFQK/zsvPrNz/EJJgRR8nvBGV8yanerHzvx8hJFb+y844q/ocYml2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRmnYruK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so438a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707329084; x=1707933884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxlJu+J6TLx8yj+iNOuTo7euy0CLu6uztwIQApSEcdw=;
        b=ZRmnYruKBuH/13Moea6Bi7TOWWw2+RIYKHX83n+CP0a1BtX8LtX1H3++iDshWmCHmf
         sOPywdnCcDKSKnESQho54iOEpihxGvtvJPUa8hI5UcCDVv1wETlrVCNSxeCdlMge1JqN
         mP7H/PS9ChFRJDQ86N+YgZi+Ves3pAkpcfBl/s76A5eO444zUO6icpengm9MwHuwR7H3
         iKdI3p7ymYKMLRC+urrcmiRUDEG6eed00PPr1FIEhxE5FgJsvAOLRl++eCy4JA0TiQy1
         FLOenSnxUanj3+zSOtI/0GKPe34hqcdacWdl7t9V/twmO+TjypxPM1Wpt7HqC+aEV+L+
         YSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329084; x=1707933884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxlJu+J6TLx8yj+iNOuTo7euy0CLu6uztwIQApSEcdw=;
        b=X35X037TkksW4lSWKgwwBSxnT4mikwS8ckI8VCbJsgmHUecswyVm5ZIu9mMABVcMm1
         WwQo3o3EUd6kypNJbbLf316bkBnEXtsiyw2QbTiDAQCd+e06rzIo85qoRLNR1etU4VRN
         Gy3IVV7GKvo0Q//4mf5N6UiAZkFA9bCgXS57zhxQASpuCtUDOpKTnZvYsk4WKJuMcfMP
         QnIUvYiwmHYTkgMNBkO/IsooBij4A8yG/8Y6Is/fX7PE1cgrG476PHMoREScMhNf+Cdy
         evcnqLp2tlryZDcie6i4WADbkr48XFtQ++uGhySPN05SlpIwdkwwx9e8Yxo12Sp9awiQ
         TN2Q==
X-Gm-Message-State: AOJu0Yz5p8HMDrnZdTDs0mQrn5+DaloIZVERfx1/N20hz66QCH7ng5lV
	JSvBqgLE1jI8tCb9ofoevaQk/HkybMLY3BNTjbH9wI0QA5m5TCZXm4jI2qoQOOD3Nf1qSmTyZCz
	WQDeTK578mQSEWH3lLr3OIn7RURqKo38XW/VV
X-Google-Smtp-Source: AGHT+IGI0Nj8OAAEvuNW0mz5/CZNiXvVPMS0pCsSld6e6qLsiP5wS+LBjIVJBP6jozn13Ag77CnMg0Dgf+o6GhL9CpA=
X-Received: by 2002:a50:9fa7:0:b0:560:f419:71ea with SMTP id
 c36-20020a509fa7000000b00560f41971eamr51348edf.7.1707329084080; Wed, 07 Feb
 2024 10:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38d3ca7f909736c1aef56e6244d67c82a9bba6ff.1707326987.git.pabeni@redhat.com>
In-Reply-To: <38d3ca7f909736c1aef56e6244d67c82a9bba6ff.1707326987.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Feb 2024 19:04:28 +0100
Message-ID: <CANn89iLi7J0Hi28k9O6S3RnTt-opj2pNV6cEw3oyWUV_CiRPZQ@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: add more missing kernel config
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 6:31=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> The reuseport_addr_any.sh is currently skipping DCCP tests and
> pmtu.sh is skipping all the FOU/GUE related cases: add the missing
> options.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

SGTM thanks.
Reviewed-by: Eric Dumazet <edumazet@google.com>

