Return-Path: <linux-kselftest+bounces-11682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED82903F96
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 17:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25F11C24A80
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876EF44C6E;
	Tue, 11 Jun 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuymG5cx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0138F83
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118232; cv=none; b=Phh4mnxGzA/C/o2BQijccObCFZkG5yXNgjzxzgaJmPRn+owlKJixd5vHC8NNp2/JrsDWjv6sjGHXT2ObtyU5EWCn/uWKo65I5+W9oZ8Wh5o+LgX0zxLg0w+qU0QN71VZkOdidj1pjFO3IFsLZxZ2jdUiW76Ly+txXLu/CWfZM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118232; c=relaxed/simple;
	bh=DxHuSRyS2182VbMMPg8ECusV9XWBUw9c0Ua7Tz0GQfQ=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaX7dom/dbZnSCs2qNEvth8AiaZJyXawtlQaBelHRIxPkvBU9W0Q6hvBCJy4zURwf5CKvPJr8SAsGE++0si+eNxiXgJq67faIjbDGXFY9wE57j7dGSXpRHfrHdR5tEIR9bgXrxtTkYJr8S7de/9u8esrsHFFm8vqJnRQISooR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuymG5cx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718118229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KOD3tvw2yUOuCBwejEuRkcEMN7XtQ6ZYq07uFnoBqQ=;
	b=AuymG5cxKaOvyz314SY3mNHcTZLXKJJymaTtldiI1iISYTRrgM/tC8lMiUh4r4i5b83Bx3
	QsjBmzBmZ5vuRqyMAMbd+wrsRFZXOHvScJGIaH+uc4Xz7m0xGdoYVPBaU4AXteZjguiaa7
	XFubKaOCh6p9oWmJT7bLKWle4fkbZ2o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-45z8Ae_9PWyQX0F43Qg1hQ-1; Tue, 11 Jun 2024 11:03:47 -0400
X-MC-Unique: 45z8Ae_9PWyQX0F43Qg1hQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b06ca589baso38920986d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 08:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718118226; x=1718723026;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KOD3tvw2yUOuCBwejEuRkcEMN7XtQ6ZYq07uFnoBqQ=;
        b=Nchlx73uRUGx0Y1FGe8ABkrUWXjRsV55gxlAN36NKfwxqBxdKj3SCTwym80jJMdcUY
         tZdnjDO8tNX+ksVaB4use/S7Si1ty7HA1cVmFlY+XDhIaEWYWjRYjmhpuUMq3SQkdOCq
         7oBMqKe9dN0oxTYlFkMpfT0fnJznJLT5TOJTqVEA+iPNw394pBdHo2P1a1k6h5poFwal
         R8F/PsWkk776rItAdYUxeD+Z/yN6CJ83DGeq5w8nOXyGRc2YtNxlBmBXA7ni/nOA+RHk
         GSB9woJJv77x5HNZOJmrcp/oJVaucwHV+wPfu8odhw2RL26MqXGVV6qwBwfhP58LsGnD
         yJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8ATwVi1OakK2gf51DbME5GQAdYwFzBbZ0ZvQxjJdgB9tPCQbqk7H4vxjSEJmU1aqpUyPsL0TQLbtZFrdpxGMB4fiEij6k14Za3FOC9qUF
X-Gm-Message-State: AOJu0YyP8g5JxzjrAUJKpS9zJ3svgcmLE2Iag5DDJyPkr3kMrxgeWqdy
	cRa69ZOkn1R4iccZoj338OMAD0aKjURQ2vxNiuDnqjIuyBQ6he7yUaAxB1rsC+rdTJJAGxzQMTv
	awW5RE+ocSs9+lVt3zX8kquFU8HSMFYdFashvBp763D2i9paUlyLYMChmFC8tR9SWNsh29L8lkx
	9Vk6i+xzTyd82aECGmqFBAZ9Eav1faOumHACRCTAW8
X-Received: by 2002:a05:6214:5889:b0:6af:cd13:3adf with SMTP id 6a1803df08f44-6b059f15a02mr146830936d6.41.1718118226686;
        Tue, 11 Jun 2024 08:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8Fk310YG6KaykuurRnRYjKcqZ4xXhNfdb+Ut2CJiNwgIs0lhWrDGpn077i7CC8byIrzT0pPeZlUrEsg7upM4=
X-Received: by 2002:a05:6214:5889:b0:6af:cd13:3adf with SMTP id
 6a1803df08f44-6b059f15a02mr146830506d6.41.1718118226132; Tue, 11 Jun 2024
 08:03:46 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Jun 2024 15:03:45 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603183121.2305013-1-amorenoz@redhat.com> <20240603183121.2305013-2-amorenoz@redhat.com>
 <f7t5xup26jt.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7t5xup26jt.fsf@redhat.com>
Date: Tue, 11 Jun 2024 15:03:45 +0000
Message-ID: <CAG=2xmN+fp5B_b1KQq2T9DKrTQ_+Kqr6WbmrY0Gk1j3zZnY1YA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftests: openvswitch: set value to nla flags
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	dev@openvswitch.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 03, 2024 at 03:02:46PM GMT, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > Netlink flags, although they don't have payload at the netlink level,
> > are represented as having a "True" value in pyroute2.
> >
> > Without it, trying to add a flow with a flag-type action (e.g: pop_vlan)
> > fails with the following traceback:
> >
> > Traceback (most recent call last):
> >   File "[...]/ovs-dpctl.py", line 2498, in <module>
> >     sys.exit(main(sys.argv))
> >              ^^^^^^^^^^^^^^
> >   File "[...]/ovs-dpctl.py", line 2487, in main
> >     ovsflow.add_flow(rep["dpifindex"], flow)
> >   File "[...]/ovs-dpctl.py", line 2136, in add_flow
> >     reply = self.nlm_request(
> >             ^^^^^^^^^^^^^^^^^
> >   File "[...]/pyroute2/netlink/nlsocket.py", line 822, in nlm_request
> >     return tuple(self._genlm_request(*argv, **kwarg))
> >                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "[...]/pyroute2/netlink/generic/__init__.py", line 126, in
> > nlm_request
> >     return tuple(super().nlm_request(*argv, **kwarg))
> >            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "[...]/pyroute2/netlink/nlsocket.py", line 1124, in nlm_request
> >     self.put(msg, msg_type, msg_flags, msg_seq=msg_seq)
> >   File "[...]/pyroute2/netlink/nlsocket.py", line 389, in put
> >     self.sendto_gate(msg, addr)
> >   File "[...]/pyroute2/netlink/nlsocket.py", line 1056, in sendto_gate
> >     msg.encode()
> >   File "[...]/pyroute2/netlink/__init__.py", line 1245, in encode
> >     offset = self.encode_nlas(offset)
> >              ^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "[...]/pyroute2/netlink/__init__.py", line 1560, in encode_nlas
> >     nla_instance.setvalue(cell[1])
> >   File "[...]/pyroute2/netlink/__init__.py", line 1265, in setvalue
> >     nlv.setvalue(nla_tuple[1])
> >                  ~~~~~~~~~^^^
> > IndexError: list index out of range
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
>
> Acked-by: Aaron Conole <aconole@redhat.com>
>
> I don't know which pyroute2 version I had used when I tested this
> previously, but even on my current system I get this error now.  Thanks
> for the fix.
>

Thanks Aaron. I'll resend as v2 with your ack as a stand-alone patch
since the other patch of this series will be fixed by your soon-to-come
series.

> >  tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > index b76907ac0092..a2395c3f37a1 100644
> > --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > @@ -537,7 +537,7 @@ class ovsactions(nla):
> >              for flat_act in parse_flat_map:
> >                  if parse_starts_block(actstr, flat_act[0], False):
> >                      actstr = actstr[len(flat_act[0]):]
> > -                    self["attrs"].append([flat_act[1]])
> > +                    self["attrs"].append([flat_act[1], True])
> >                      actstr = actstr[strspn(actstr, ", ") :]
> >                      parsed = True
>


