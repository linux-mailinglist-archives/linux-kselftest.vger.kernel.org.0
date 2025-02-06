Return-Path: <linux-kselftest+bounces-25934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF434A2AD34
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 17:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784271889110
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF1151992;
	Thu,  6 Feb 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQazfxK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDA1F416F
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857683; cv=none; b=Yy4CQRUlI+U04u9T+IIbcViRBNCpR4dk0fe0eV2Z09CJ5xs2ZxoYu3i1dwN+E5dTu8dCsAdwarAGZgYEw9hoxs6v0d9UOfvm7+9+Uc/Dn3wkw0oqFB8kATaMsVxGPU5AawdC4ncnioC7m1ogKAstXi6BE0HAeRDBNXA0/aPGZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857683; c=relaxed/simple;
	bh=cjrvqKwflKGDwidBjxOl4fQeR+OSK3UfDfYbifKFa8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmjkaeNHMgSM9tvgnyGbTBBXAares8Y/B1ktfgp/GUBRHmtRO0+qoQlq9BRfvFZw/SLRq4qggssHgdgOup0ACE0Yf4moCtUog5LMAFEezLbH/zFuMeS8dnqP/OgpmsRP6lzCYOlQbKitcf7C530NnPA83/q6EXXUdze0b6Yo+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQazfxK5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4678d6925a4so181cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 08:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738857680; x=1739462480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjrvqKwflKGDwidBjxOl4fQeR+OSK3UfDfYbifKFa8M=;
        b=rQazfxK5f/miH9wKY5Hp0n/fuHCKezbsc0SOnBArmVsnQ2p06h2JxqXCFNDwgFZ4qM
         3RZ0hXNz/lP+OpOqQmFA0gxov75ezsEGIC2cOoMQfLnPtPOgQxa4IgGm4Hm1vQixs/9+
         dQiaWdPBUE5N0tI0dy7DsLGEELVJDloKOg18ghFqWqU+L1FXkFxJ0bqOtYMEHIb5q61e
         XJWSkRSgKVH9GTylJC6aBR8y365Umz0uTlEHcU98mpxzTL1AuENGGCMNcaBfHX/7bmgB
         mfcKSH7+BCjZVDsXmcM/kQBFy9UjJNyOP7MJ5iwBbEZWH0E9xTwM8GvjyqYx3/FTBW+Y
         7GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738857680; x=1739462480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjrvqKwflKGDwidBjxOl4fQeR+OSK3UfDfYbifKFa8M=;
        b=MJpHOFiM+1TWLbwjlq/mltqfiWSJbjpXoFx5hL/cYcHfk+gZ17v0kLnvnwZIJ+EXjG
         QzuRkjXWiTiwoZg9orNhDhHDbeNShsS9PFQXtb8gsPnGlXAG73OFmDOnUidI6QhQ2785
         knE3ql76PNh8FbtXRx3CH32Qn9RX/PQUheGmPUuKFCRcBUOqPNZeTGIBEMgwu3a8jlSD
         ulWToa8ZyF5B4XTAlq4CjQ6enJHmonS23sGP/zGzf3nuWs0eYGy65vP20HU6gCAUhZ90
         oervtFr4sYKbut8BpjG21RPQVt5CisXScJ8JBvn9zm9ImOoK21OJFHUWvTiWTdbXqzUe
         EACw==
X-Forwarded-Encrypted: i=1; AJvYcCV22WO8OGJKgg02APR+w2BVf02CwNZ+ho6vrh/DIgAzz+x/M5+djB+s3WnNCm4oRWQZ3k9vVKww0AtQ/1f4aAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCvv+jV9W5MBnnpHYyfn5mW7Q0MliZuKSOzU6k/6ob9Xq+EmK+
	wxSzP9/OWuA8UuT3q7l+juPBV6BupxvfmL0XRfxackcjsI6J/zUMhjTwGNeUfbHnLT+cPYyhqZN
	RjlD91su99mecxmuApEGqvyZlcdJHzIuqVW3Y
X-Gm-Gg: ASbGncvVgPyOW4QGNckP6kRLxUT3bR2s372a258mAKHbAY0rayW9II6bxhBiLKyfE1+
	q74MuiBVEDQKJr9343M9lZ5I6x6omB3ytgdE0mXSDpnm3npQ1d6AxSbIcaSDV5ZyldwE=
X-Google-Smtp-Source: AGHT+IHjB+F8/fZHMMhgSaAE47vlW3DeQZTVy9zE6ENZIrdv7ci+SVjgVYdT6IJkDJ7qIU2CbsI9uq24EaoX1d8IAqE=
X-Received: by 2002:a05:622a:6119:b0:46e:bdd:64a3 with SMTP id
 d75a77b69052e-47165943ec9mr108971cf.0.1738857677787; Thu, 06 Feb 2025
 08:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204091918.2652604-1-yuyanghuang@google.com> <efd3dee8-5a2d-4928-ba1d-ddccb2f29fbe@redhat.com>
In-Reply-To: <efd3dee8-5a2d-4928-ba1d-ddccb2f29fbe@redhat.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 7 Feb 2025 01:00:40 +0900
X-Gm-Features: AWEUYZlBPEi6CskLDdUiEXDiby9O2raxQzVoLylqLV5g0ljIatLjaaRQmQ_o_mk
Message-ID: <CADXeF1H32H=SsMUM7DgA=v9utzhnWfpPhKu5wouriOkTCtVUnw@mail.gmail.com>
Subject: Re: [PATCH net-next, v7 1/2] netlink: support dumping IPv4 multicast addresses
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>I did not undertand you intended to place the new header under the
>'include' directory. I still have a preference for a really private
>header that would under 'net/ipv4/' (IMHO the possible future divergence
>of inet_fill_args and inet6_fill_args is not very relevant) but it's not
>a deal breaker.

Thanks for the advice, I will move the header file under 'net/ipv4' in
the next version of this patch.

Thanks,

Yuyang

On Thu, Feb 6, 2025 at 11:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/4/25 10:19 AM, Yuyang Huang wrote:
> > diff --git a/include/linux/igmp_internal.h b/include/linux/igmp_interna=
l.h
> > new file mode 100644
> > index 000000000000..0a1bcc8ec8e1
> > --- /dev/null
> > +++ b/include/linux/igmp_internal.h
>
> I did not undertand you intended to place the new header under the
> 'include' directory. I still have a preference for a really private
> header that would under 'net/ipv4/' (IMHO the possible future divergence
> of inet_fill_args and inet6_fill_args is not very relevant) but it's not
> a deal breaker.
>
> /P
>

