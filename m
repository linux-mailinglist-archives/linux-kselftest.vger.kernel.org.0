Return-Path: <linux-kselftest+bounces-21625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F349C0CAB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6E0283E4D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B881D126BE6;
	Thu,  7 Nov 2024 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssj7JSI+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3A18DF62;
	Thu,  7 Nov 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999802; cv=none; b=hRdfbiED6yzIQE7A8huzGqWPyOOsFFSKHihS3ZrymI/bhTnl4+EypZii9cf1htGMrcg9LrI9rD+8kvPLk2B5TZgOUh+uHYrBbsWKj7jCIstmqodmPfEUeNpwdLG9J+wCuv89mpu4bMkFjtrrW3NllElK6gmgqucmSRrNQ5ElOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999802; c=relaxed/simple;
	bh=XZbkjuPx0RzD//u+DiwqR938wVtwAzNt9z4kO6M3ASY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5GPtcqu6M5bwNCukzS5jmcHX+HL2Jh8d4IYmGO5ngfF7nyictC4JZtBRMXndwYBIuPAhhN5HQ9OKS19UdaB3u60W6SKplp81CmKS7RtWyi4tr2IoO21kK37Td19I37ny6Ab0wEN8s5tDtpQoaXMDJIshz0d1CzuPid0QYYVgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ssj7JSI+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7181c0730ddso563331a34.2;
        Thu, 07 Nov 2024 09:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730999800; x=1731604600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BTMKweedjZ75OhcudktNfD43GIulRnBzWZ+fUwSHgKM=;
        b=Ssj7JSI+tyxBBXva2Z/OcDTXKOIsmzcMRWcXqDSWBb6E2cpOZphP8iP2W2yKXfNzVu
         PxfNBI3/DN03anN56zsYeuY24Ifnfx3qswxYSkcjziONZR9Es3NzTHSe4ASVZLSofclC
         C6Yit7fWJtBkODdNCz2BL7pUMNf0p3k2Y64aMhQIvX1+0R2QWvAG7hxEhMSePizjw+4p
         mcmnHCZ1SkaH5hf52V1RtIP0OOAAU4IYJiTQmDkeFL1jSjQRWnEA7E6sKm6t2l4vAw+X
         qAzJv1FNm2R7fIsUsEx8+4XbiJp8vwg/v27SW517bpzFOGec3xGeTOsIVq4K/z/gj7xH
         aTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730999800; x=1731604600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTMKweedjZ75OhcudktNfD43GIulRnBzWZ+fUwSHgKM=;
        b=n+NQckmetXvC4MGRr/f4DCMBVjGu6OJ/D5J5MHROkEte+JJJiFESJbklheX00PFMbn
         KpSJzz3zXDwgfpKv4o1XeQnDZiX/O333pdZAEMvoea6RdpkqbgY6a0/DD5G5trdLUBZj
         J0HTBmjcBYCybpIOnmrXNtOIR2b0kE0XFr9wiHCIMYj/N/K7umsIv0FBaLrMkv/90Ivf
         BxIjUOO3bVY1SXo5yAvaaadpCbO5n9SfKC0P/eXv7aYsiJvxTrq58MOONDHa6unuatWd
         vMfwCCrSzBPl50lvfSm175+gSGSNFOV71OX/WKZxaztXWf4K0Mf0ElgXS2XhJG3HpJNy
         fr0g==
X-Forwarded-Encrypted: i=1; AJvYcCX5FxdJI9g96l8Xjt3xloTwjpPi4eWrgfSCeunS3iEZE5wu09NShCOgr2+Z4L1FXcF3QjTnkzGnHnz5Y2HVh4w=@vger.kernel.org, AJvYcCXOJIYUF4mZyZUUgN4wt8Y6HSuGXulOzU8xbAbhHHqN9KnmLYhbTL3fbo615FmxmSYeZvvKoXyp@vger.kernel.org
X-Gm-Message-State: AOJu0Yynt3wWy4iybsoxXjXgMSV7crytmjb8Ss4VYAyeW+wqCz4Ma2hQ
	IaPYJ6JdnKuYrGhOv9eV2SL2kcvmvLgFHOvX/wY1b9tWfACOYC/nn6wpqodDB8ErvFCTiJIUTuH
	PXzXfrhZHfyCJLup3rCtrUeIUJME=
X-Google-Smtp-Source: AGHT+IGtyHeUDDQ8/BFWFeMqSq8NaMTh98hsnESpBxWHLEm8HrqU+pnb2KK/P6JZfEkffd+YtKndmHcCOaM79cUEMR8=
X-Received: by 2002:a05:6830:6389:b0:718:9ac7:27c4 with SMTP id
 46e09a7af769-71a1b3cdf34mr284743a34.5.1730999800048; Thu, 07 Nov 2024
 09:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-8-shaw.leon@gmail.com>
 <20241107080420.6a5a5243@kernel.org>
In-Reply-To: <20241107080420.6a5a5243@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 7 Nov 2024 17:16:28 +0000
Message-ID: <CAD4GDZwOzLQd+FYd0AHr5AUcANWkf731Jgu6aeyix8EjRGXRag@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/8] tools/net/ynl: Add retry limit for async notification
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 16:04, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu,  7 Nov 2024 21:30:02 +0800 Xiao Liang wrote:
> > Since commit 1bf70e6c3a53 ("tools/net/ynl: improve async notification
> > handling"), check_ntf() would block indefinitely if there's no messages.
> > In some cases we want to set a limit on waiting time. This patch adds
> > max_reties parameter check_ntf(), and makes it stop when no message is
> > recievied in that number of consecutive retries.
>
> Looking at 1bf70e6c3a53 again I wonder if we should revert it, sort of,
> and add its logic back as a new function called poll_nft?
>
> The thing is C YNL has check_ntf too - ynl_ntf_check() and it has the
> old semantics. Would be nice for similarly named functions to behave
> the same across languages.
>
> WDYT Donald? Sorry for not thinking about this earlier.

Yes, that makes sense. I didn't realise the C lib had an equivalent.
Adding a poll_ntf() that calls check_ntf() internally will actually be
a bit cleaner overall.

It's then a question of whether we need the repeat logic in poll_ntf()
because it's always possible to use check_ntf() in your own repeat
logic. Either way, I'd prefer not to call the parameter "max_retries"
because semantically I don't think we are retrying - it is a count of
how many times to repeat the poll. Thoughts? Should it be a "duration"
parameter?

> Xiao, feel free to submit this separately from the series.

