Return-Path: <linux-kselftest+bounces-6628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D388C4F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8E5B24A02
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8F12D75C;
	Tue, 26 Mar 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYpozZ5W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C89768E5
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462512; cv=none; b=pd5+wzl+ue4ViPIHwm5Z41X7qGX6WwT7213ig/p3oLprLhV1GHEn4IdPoj2lzXKTM9nJ5D1oh994YgXu2jhnLpLw/wcKunIH5Y3yJ4Qj6A9G2i7H33d9GNU4U0eL9IFYrKOePKrmLwIZB5gRDxpCjMCiWzL8r4Nxclf/LSCctCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462512; c=relaxed/simple;
	bh=VJfebqtXkl389SDeTD7YYtNydWpUFmx9bb86pDSusXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvKYOpLXcnyWtB6J96v0e5cjRRH55SUhh1LRZeuvbP8B5E/MZ8zQVHP96STMa1iVMvQH1AdZ14aVSKhJgmXdXHSaP4iQZJ61c6SN5/U9DsnDor9W4zBg0rLN6DZCJishROO6FIksG5RHjtKsudSbOkJZhkUzMlroMxoEszfCLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYpozZ5W; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso8103a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711462508; x=1712067308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJfebqtXkl389SDeTD7YYtNydWpUFmx9bb86pDSusXM=;
        b=oYpozZ5WtSu5jpwmjGNry233tkGvWmCZGnMTsXOshJg7f2xuyDkqX4ioUXEr/V5zi7
         Jkk/4rNN6PeQq0XaOrHfc6RCnnVVRPMMJ9J2deCTv1qTealooa3QBAbbRDqAZDTqAZqA
         kSyTg65m/J3E+6OfmFajm+gxeEJwppcY1tr+yAipufDVQjl4aq8Pc1r1mvt2zXfpXwyG
         q6Q+dUPbNG63Zk6/42yX4U7LjydeqSxgz+uumlvXleas3gjTNQjjrphDepTjrvuD7YMS
         coEzl7ohFFmpJMSI3kjyP9/iSaWbqW+ScUU+jh1xtRqSKAG5DIZdWnCqNjF5QvKJ98MP
         bb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462508; x=1712067308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJfebqtXkl389SDeTD7YYtNydWpUFmx9bb86pDSusXM=;
        b=H3kLmM9lS51+k/GLqtVJTpCPRlI7Dm78+LJ8KYUcWNO07As+Bk8JANi/DHiU9m5JoH
         CuyCOdTUADXsuPNWnixK59McA3vAG3iSAT/ftkvtSlnOL9Ihp1Ph24bk87tyhpk75KNz
         a68NJ4DkAFW8tVPsnhuiHK1mH4kaPhwoccOTegheY4PwXgJYLfldB1rAFXtWDIik5fvp
         tw6Yi+oywIQWs4TiYnfSDjuy2DD79XAqF0bc2FJaMkc1u7aTnSpbpOgqjucEzfQzQ1ur
         SXHz8nrORMD6Qzun3i7kmelo+lJq50CxorGSYMZ7m6evz1cI7vUJq/RGHXYhucPoS9xH
         dP1A==
X-Forwarded-Encrypted: i=1; AJvYcCUhqXoaIzJK7MXjc/kxq5TblTdq4JEe/XmFBqcOsU9s4IrzWstty7Q+ZPvyllxpqm58DWe5tuLr6kpuJgbeUarcO33lJ8PCdD4lgCz6NBTA
X-Gm-Message-State: AOJu0YwaAwaO1hzOcggplO1D3nXuRgjJAE6iTuuSyL+ooIZkSDgvW/hl
	Uf84DPEfeYolm2Dha0UegK02XR0Ne4IW5AtZMG7gRtropKRHsy9aS3rolnz+6acijjNUwqcIOSQ
	kPwTKRxm1ivWnjCvVqvwj8WtkYYBh6Xml6blZ
X-Google-Smtp-Source: AGHT+IG1Z+WPb5y1Nz3VMT4UqqtY4fpc8jx+h3qL2dywCVAyPOrhigIpDt4Vcw3QK9/kLtXuyctPdraZ6ZuleVPscws=
X-Received: by 2002:a05:6402:1a26:b0:568:ce1e:94e5 with SMTP id
 be6-20020a0564021a2600b00568ce1e94e5mr105879edb.5.1711462508403; Tue, 26 Mar
 2024 07:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325182543.87683-1-richardbgobert@gmail.com> <20240325182543.87683-5-richardbgobert@gmail.com>
In-Reply-To: <20240325182543.87683-5-richardbgobert@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Mar 2024 15:14:55 +0100
Message-ID: <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to tcp_gro_receive
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, dsahern@kernel.org, xeb@mail.ru, 
	shuah@kernel.org, idosch@nvidia.com, amcohen@nvidia.com, petrm@nvidia.com, 
	jbenc@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	liujian56@huawei.com, horms@kernel.org, linyunsheng@huawei.com, 
	therbert@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:27=E2=80=AFPM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used
> currently only in tcp flows in GRO.

I think this is a bug.

GRO should not aggregate packets if their ttl/tos fields do not match.

