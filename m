Return-Path: <linux-kselftest+bounces-31301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4D3A96D96
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3413BFEE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD252853EA;
	Tue, 22 Apr 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F12AWa1h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421228136B
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330193; cv=none; b=uY6zxVz9nP5g283ttxaBUZRAVSQyxgJU1KanwkYQHoz/TrN0zstHDbAuK6d34N1dEa2TtRPveRBYqv3eCa3/LPZ1DoxS6qoSkEW/eE9HBN7/VsSjKZU0mlmXLXL5sDDZeAXGQlF2mO45DkpcRrajmpbU5iTZIe5WWUdaBBW/BZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330193; c=relaxed/simple;
	bh=5UhTPLXTy54HSw4bbuMVr6NHCHxgfaB24c/UygOGD5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwhSHtDU85GCHR9Hqmd9mrPkkoWCTXqh2CGhglEempSc7iX9MEzQM+buRD/4d/E5txHy2z/I3oUUpuTopDf1WH4mg5T/TzKFsMsdVZaYgLN0YjJ5G8UxDMJ/Yw64oAiCYNJJZkkSgALbcLLDBplGOWgv8kwKYKm8ItlTl+7inFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F12AWa1h; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso119025ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745330191; x=1745934991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UhTPLXTy54HSw4bbuMVr6NHCHxgfaB24c/UygOGD5o=;
        b=F12AWa1haXcsCudCgDYHjn2nNfZXI3lbEma09OMg5nCnR7GzJuX8RBzTsy+aLZxnlP
         G3KDr+MgQbOHQschhs2yKHUMROZvYMDuvkA2dOkccaWcJNess9Hp4TfbIqXjoGqli4kI
         +U9yYc2mKurzkivWGlJqXif6GYJ28rvsIfCD8cvv2EBltZDLmnDViJWWOYnCPSJ5BWuB
         strzglMGQBpP7YIbUEyB4vnYUBvjCuH11iIdAWWRCHUyZW75wzZPWGy2NSd8M+g+HmdR
         NoRgXS6T12hgTXSfSz24ARES3ZTJvZXG0GmbkKSy5ko8M/v0HdSGZMmYcx/neG7gmt9c
         YyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330191; x=1745934991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UhTPLXTy54HSw4bbuMVr6NHCHxgfaB24c/UygOGD5o=;
        b=vZVipR5k5SJCY6YQbpXofSSOBrbak7GTS4mb8zYg4KvSb8q92MBJ5peps6Jg21oKTj
         UXf7KG6XAycHTVWM1tIB+6nlZqtmTVOzIkLyzN9XYQvdqAHbS0cgFa43jJ5wQ+24SuVU
         3uBQdhSNgQedlu+KPRi/ME/YWGSUhIS0bld8uJkbzTANjKuWPuezLnIXwSHAs+fEfDID
         mBLxq9qa7yBr5OnpffQqT0LvJgBh/Ay2quxYYrZZt6EpOUeGG0/OwyQQ3qd0y/6xhW6W
         aCykQ6mUEWKU/oVtevou44yctt+DdvWnjC5eCgGnDCqTuaoF1bo9IMhA/Sx/9JivFYsm
         SzPg==
X-Forwarded-Encrypted: i=1; AJvYcCWhQZtIbFEacNrfWaOLiSyKHQXzKNmEvmTbOlMXgMEJIgZDyvwUiIHRBAnUcK9vl7gtZVW/n0DrDsW3SOQPNzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPuSbrgmlSTVBPE7EnqLAgYgeQQrTpINRqfNTlRo3WIXB12LO
	j07ccum7RQ4GkV30r/LX8Uu5wmdFrJAZjOOpBEiqTa9bHLS/GWhiG1kOa9p0E49VPH+tHVtVMqY
	591ULBcJ6MfbIQ6qwVBqKYGoxIzL0YrJVyMhE
X-Gm-Gg: ASbGncuX0JYOl8j0fqyNsqTx6xbT8k7UdoZGhdlW7WqlQLWM6O7tI7/nxOjjAZuhTxJ
	qtNlctbPeXZsyIqQqlzveIR6/rHFkhULFkyV6vUK7SuMo+cce3nE7c2uq+fW8Gyq+brv3o6K5CH
	Ga5BS5w6izrS7SFpSI8AxUz7Q=
X-Google-Smtp-Source: AGHT+IH/hAru3MKmJ60Z25FXBslSMx5hLypeOWFuJfnaTmWFJ711/aVQCwonng9BnnPokRail3ZgA21iLnH/6NJDRM0=
X-Received: by 2002:a17:902:ce0a:b0:220:ce33:6385 with SMTP id
 d9443c01a7336-22c54797b1bmr9643675ad.9.1745330190914; Tue, 22 Apr 2025
 06:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-3-almasrymina@google.com> <484ecaad-56de-4c0d-b7fa-a3337557b0bf@gmail.com>
In-Reply-To: <484ecaad-56de-4c0d-b7fa-a3337557b0bf@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Apr 2025 06:56:17 -0700
X-Gm-Features: ATxdqUFU-Nv8GeoWu8ltonWAw6xNaP21dKReuqOOxLDIWBd4SeZRRiQwqzNABOY
Message-ID: <CAHS8izPw9maOMqLALTLc22eOKnutyLK9azOs4FzO1pfaY8xE6g@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/9] net: add get_netmem/put_netmem support
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 1:43=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 4/18/25 00:15, Mina Almasry wrote:
> > Currently net_iovs support only pp ref counts, and do not support a
> > page ref equivalent.
>
> Makes me wonder why it's needed. In theory, nobody should ever be
> taking page references without going through struct ubuf_info
> handling first, all in kernel users of these pages should always
> be paired with ubuf_info, as it's user memory, it's not stable,
> and without ubuf_info the user is allowed to overwrite it.
>

The concern about the stability of the from-userspace data is already
called out in the MSG_ZEROCOPY documentation that we're piggybacking
devmem TX onto:

https://www.kernel.org/doc/html/v4.15/networking/msg_zerocopy.html

Basically the userspace passes the memory to the kernel and waits for
a notification for when it's safe to reuse/overwrite the data. I don't
know that it's a security concern. Basically if the userspace modifies
the data before it gets the notification from the kernel, then it will
mess up its own TX. The notification is sent by the kernel to the
userspace when the skb is freed I believe, at that point it's safe to
reuse the buffer as the kernel no longer needs it for TX.

For devmem we do need to pin the binding until all TX users are done
with it, so get_netmem will increase the refcount on the binding to
keep it alive until the net stack is done with it.

> Maybe there are some gray area cases like packet inspection or
> tracing? However in this case, after the ubuf_info is dropped, the
> user can overwrite the memory with its secrets. Definitely iffy
> in security terms.
>

You can look at all the callers of skb_frag_ref to see all the code
paths that grab a page ref on the frag today. There is also an
inspection by me in the v5 changelog.


--=20
Thanks,
Mina

