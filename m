Return-Path: <linux-kselftest+bounces-33340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6E8ABC5AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9117A12A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC08288C23;
	Mon, 19 May 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuUXCyV6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046461BD01D
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675982; cv=none; b=VQOAxqYaCpXKWMzoGA5xy5UnlxZ3q4qZ5WE+jO6xuW7iaDdOE61t8KcQIp7un1T5Uo4cbzl/5ahTdiKMdOVvd9OvUbaVGgYBneurTadkHwld2oqjHm8+BaMm+AsISSpIx8jY0mtKfAhK5DQjMUfLI3mvIuZiArNd7uYLdwDS7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675982; c=relaxed/simple;
	bh=f4dgfRMtTYcBFr3isa3AuROYQqzp0vO9ur0rnexY61Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8XKKcMjsHmpXL0dESxnfVonZr03VDD421S5pG4NRpASnT1Y9hJvEov7Xk7WdIGp/rrS2zApdPvjoznceQOLV6nEtkmpUu3SZVMIbV9YP1KOb/Ef7zXkqs/L9zcOWhVELNq4mabXbEVK8OEXst5MSEi4QxtbgHt1yABG1HT1lFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cuUXCyV6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-231f37e114eso477775ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747675980; x=1748280780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tcAaZdGQpMjictMPYKyIxyCcVwEKuNN7fh7v7Ym22Y=;
        b=cuUXCyV6qGzXDJwr8AmMAaz21olJquI5M1uyQ1f/7A7gm2nPUPCkNbQh3LwpF11oXE
         FCLsEvNJUG4BLkE+1rjLBOPdjVNGnPUK2dt441bVCKd1PKCCjWelKMUkdORNDsEWP+6z
         gsIJzRaMFoKsiNzVbCe6LFye2nbqA5F9FfkpA646R2Kw5vOiXoJs6l0BJpe10imC0Jpb
         kweDtqVoGP59O+aS992VPEeDsu+lFwwlaAEq5Ol2RTV4LycyRC3sc86uRobpWh86V2o1
         h14JIig+QVjyuB95w0blVG0XSATEBKoj7EnvL4aj+w3NNLudUoJhL8A/a/vueZQbCwg4
         ZjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747675980; x=1748280780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tcAaZdGQpMjictMPYKyIxyCcVwEKuNN7fh7v7Ym22Y=;
        b=suJRkC2CCLXCAcmOlKx2ihMVpEPRkVw09THPWCVgYRsy+65U6ILCmb/Kaxgv7nR+5W
         J+wdE5sCH7K4Age7cP5jrr+iFaDKBtWC7VY96wnY65RqsfXBxleit2WsK/r3SZ2kiqoC
         EF/N9Y8iPrJ5HayTKsyqg+ijrbr2Cr+0Tzg9DmqTOsYeOalSIrlQMderOF1g5pPIVuPO
         bAphEYIEjsTkEgbMUG4ygrqytEp0ARjahpoBuAXg7WsX0uTd75iDzniC2YwqYJHnpK5v
         i0Gk7Dh0k9DMgyzV/gIj75z0OFJ+vKyWzF1OzEv52fdYbQ4/zez6C56iI202iqGUubR0
         2y+g==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ji3E8TDyaFgmQPbAy7I6jLjYSbJOM0DD+1wQABUyAMLSXvk3B2R6wgw0qpXfqdgSQHNlls5aTkjLNN/WXGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEd9yKJtZbQ9acGIS3BGj5JhP+QaPlWj4Zkou9fTR2RxSG0OPp
	kg38FPx90+aCfRnsHi0zM/+1sHtG3ODXqbTQE1K7aI+u36cu6kdRGRPJwiHf8ydqUn3sKrlJDgW
	GUn3ljQy6KULZJy+rAvmr5i03XK6jw70rzCJqCsS3
X-Gm-Gg: ASbGnct9pr9f7tUiQgKM7m/rP8iN10xKLgrlxuambd4UpMxbhsON9j6CpqjkuejuEGS
	iaed7iml9ci0/Yj5z3NHEmUwYNCOuXhyoLkUaa0bjrEy2c61JnKrK2aftBva/9xo9udxspZ/01n
	4wQQGN68rIRc5XGBpARqwjdIYAQ/udh2edpmOk6nveNcxY
X-Google-Smtp-Source: AGHT+IGs+elfCZbGySGmARwysKiN5p4pA5ucWH3hrD3Nt/Z1HRaqMpOBAmn2/ArPLy46knYKJuvBPtRwFmnKGvjEYGw=
X-Received: by 2002:a17:902:d48c:b0:22e:766f:d66e with SMTP id
 d9443c01a7336-231ffd1ac56mr5590675ad.12.1747675979944; Mon, 19 May 2025
 10:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-8-almasrymina@google.com> <aCtQIK-vFm6j6o9w@mini-arch>
In-Reply-To: <aCtQIK-vFm6j6o9w@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 May 2025 10:32:47 -0700
X-Gm-Features: AX0GCFt0iOE7Rccr5An255yF4CJvW76_sgtAE7JjibiHwryZmUnfjp-kmbjPgrI
Message-ID: <CAHS8izOKZBtDQT7zjd81v8X5sAXB0NAsL8iXYg3_0zurwF1WhA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 7/9] net: devmem: ksft: add 5 tuple FS support
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:37=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 05/19, Mina Almasry wrote:
> > ncdevmem supports drivers that are limited to either 3-tuple or 5-tuple
> > FS support, but the ksft is currently 3-tuple only. Support drivers tha=
t
> > have 5-tuple FS supported by adding a ksft arg.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >  .../testing/selftests/drivers/net/hw/devmem.py  | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/t=
esting/selftests/drivers/net/hw/devmem.py
> > index 39b5241463aa..40fe5b525d51 100755
> > --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> > +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> > @@ -21,14 +21,27 @@ def require_devmem(cfg):
> >  def check_rx(cfg, ipver) -> None:
> >      require_devmem(cfg)
> >
> > +    fs_5_tuple =3D False
> > +    if "FLOW_STEERING_5_TUPLE" in cfg.env:
> > +        fs_5_tuple =3D cfg.env["FLOW_STEERING_5_TUPLE"]
>
> I wonder if we can transparently handle it in ncdevmem: if -c is passed,
> try installing 3-tuple rule, and if it fails, try 5-tuple one. This
> should work without any user input / extra environment variable.
>

This seems like a good idea, yes, but I think install a 5-tuple one
first, and if that fails, try a 3-tuple one? 5-tuple rules are more
specific and should take precedence when the driver supports both. It
doesn't really matter but the 3-tuple one can match unintended flows.

--=20
Thanks,
Mina

