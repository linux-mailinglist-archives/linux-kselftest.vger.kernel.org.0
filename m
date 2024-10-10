Return-Path: <linux-kselftest+bounces-19412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7599799B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 02:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D571F21767
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067038837;
	Thu, 10 Oct 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX/V4zx+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6717FD;
	Thu, 10 Oct 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520217; cv=none; b=KwjUKlGs71fohNIEPaR4363D7PM2+y/AWhFEhXFRFZMcn5qGc4IY/ybQtPCpAPmnPkaPArG5lo0bvT5jvTV+siC0kzaWvsBaJ4p31qo+6ig6FsttF72dR3hhQV1YusaWQyMYyT8JA/ef12/HuUMsUHVs9twOsPMwv7eYlYP0u14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520217; c=relaxed/simple;
	bh=Y6mucGzONTsK08EwLcPn6ZvfEgpK2e0x/4SITkeMyFE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dqujLUhclh/T5/bWrzISYIhj4sxDLSlUz3YoS16t2j7lhRg5yIkNfzr/EgKzdM3hIaiePr8kPAKqGw15s3aBYrNYx4V3nT3NRaYPCWR+LuxoYp0uBhcS6m7IQhFx3onV6tE5/oRhFkmE0Up01weoNbhkLIGs7t9NbdLADdWM/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX/V4zx+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso2766486d6.1;
        Wed, 09 Oct 2024 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728520214; x=1729125014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZCm59ZacQ5/yxalW14FBY5YCwiURS4yess2j5b/Gu0=;
        b=AX/V4zx+NDxCYe1JaUis7qXpYlojbCeaQhqTXUcIA+TUQWFpWyoTQEPUyTc2sl7wCm
         mZ0b8xL6hoy2hvI7Q6TLwGXB+rT2fsYKGbzxqJZYCFbyr8My6hZMHCE+jnU2KWwhC3kQ
         sZjk1e/4jMwnKH/HPxwc/VfcIstKqDUpI4Jbt1iY6g5+oDhxx9n4z2XCUm/k6HC/FG+w
         2VI2P9LxfcGYc2zdGcSw7Fltr1M9So76Mj6DXdD3qhP76cZfFVsvadbg1XGlg+BII2l7
         5PSVMC2cFvYxm+lsA6DUaHAil+FwGSAabHKKjM4mPrINUFLxnuBEBtokLhHHdAfvnZfU
         9Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728520214; x=1729125014;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZCm59ZacQ5/yxalW14FBY5YCwiURS4yess2j5b/Gu0=;
        b=Z35YzMObCNOed/eRvuUatEi0CDz281gUEpAICY7Oo6IvY0qA3hxerDTALszE68xGNK
         ZFh9k5pNGeIPWX1D564vbd3fndPcV2hXp75mA0P7qA/tDYxScFJDL7v2z2NS0EP5g23q
         bn6tE0COM4BcNKiL+Qy6KAt5Oc7nG/O/or8N/4H1jbCNwcMhLVJOdQwOryHCIwpTQnlt
         tPGQA/1JjqOUQdEQEt15Sx9fBRnmRh9UslxMWTLUuAfscRc+wUjKvK/4uaPpRwsiIYuE
         Bn99pNOGR1RrXs9puTRGU7x5SskPz/rokP+7B1XiCwjRV07igP735YzQ02O5NA4Aag9M
         99Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVP928FTKyfkODUhRkqKgTZruppSKnHDIk1s8ITocPi0TTYLiucIeTaXIyTBDdUR/+LImD9Gc09@vger.kernel.org, AJvYcCW7bw1Jp1BtHmuyB1nrQb//jtyJPkiOIZ6HqeiXDKDv2OHKn5Xg3m92npzMhjJIkdnryPGXSE/sk2ObHg8Iwx1y@vger.kernel.org, AJvYcCX/8nJLOOdgINXtFShvJv8N7c9lt8Ki/9RQX72FC+L3hP6k9jgacMzk9WcaBlOtZvTiP3ixWPrdcmTyUO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo21sOrJF3Wnw7YWw1iOJC/rfGs5cAevT8QH+PN6BNEv1/eVJM
	QX9LR0GED9nFBh7nWyKAcL9ZOE+ptpnDQHzSxoNUzGz4C6LwTDxd
X-Google-Smtp-Source: AGHT+IFtHx+Y48SrwfQzVNGdaSh+zzW2eBWVJNK97GlbOf3Y5EleiQkbNLJUzRbRsQUpy0dZmeib+w==
X-Received: by 2002:a05:6214:3292:b0:6cb:387a:dd44 with SMTP id 6a1803df08f44-6cbc9549987mr66121506d6.40.1728520212641;
        Wed, 09 Oct 2024 17:30:12 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8630ab2sm475646d6.121.2024.10.09.17.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 17:30:11 -0700 (PDT)
Date: Wed, 09 Oct 2024 20:30:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org
Message-ID: <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch>
In-Reply-To: <002201db1a75$9a83b420$cf8b1c60$@huawei.com>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
 <20241009065837.354332-1-gur.stavi@huawei.com>
 <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch>
 <002201db1a75$9a83b420$cf8b1c60$@huawei.com>
Subject: RE: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket
 is not RUNNING
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> > Gur Stavi wrote:
> > > >> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk,
> > struct fanout_args *args)
> > > >>  	err = -EINVAL;
> > > >>
> > > >>  	spin_lock(&po->bind_lock);
> > > >> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> > > >> -	    match->type == type &&
> > > >> +	if (match->type == type &&
> > > >>  	    match->prot_hook.type == po->prot_hook.type &&
> > > >>  	    match->prot_hook.dev == po->prot_hook.dev) {
> > > >
> > > > Remaining unaddressed issue is that the socket can now be added
> > > > before being bound. See comment in v1.
> > >
> > > I extended the psock_fanout test with unbound fanout test.
> > >
> > > As far as I understand, the easiest way to verify bind is to test that
> > > po->prot_hook.dev != NULL, since we are under a bind_lock anyway.
> > > But perhaps a more readable and direct approach to test "bind" would be
> > > to test po->ifindex != -1, as ifindex is commented as "bound device".
> > > However, at the moment ifindex is not initialized to -1, I can add such
> > > initialization, but perhaps I do not fully understand all the logic.
> > >
> > > Any preferences?
> > 
> > prot_hook.dev is not necessarily set if a packet socket is bound.
> > It may be bound to any device. See dev_add_pack and ptype_head.
> > 
> > prot_hook.type, on the other hand, must be set if bound and is only
> > modified with the bind_lock held too.
> > 
> > Well, and in packet_create. But setsockopt PACKET_FANOUT_ADD also
> > succeeds in case bind() was not called explicitly first to bind to
> > a specific device or change ptype.
> 
> Please clarify the last paragraph? When you say "also succeeds" do you
> mean SHOULD succeed or MAY SUCCEED by mistake if "something" happens ???

I mean it succeeds currently. Which behavior must then be maintained.
 
> Do you refer to the following scenario: socket is created with non-zero
> protocol and becomes RUNNING "without bind" for all devices. In that case
> it can be added to FANOUT without bind. Is that considered a bug or does
> the bind requirement for fanout only apply for all-protocol (0) sockets?

I'm beginning to think that this bind requirement is not needed.

All type and dev are valid, even if an ETH_P_NONE fanout group would
be fairly useless.

The type and dev must match that of the fanout group, and once added
to a fanout group can no longer be changed (bind will fail).

I briefy considered the reason might be max_num_members accounting.
Since f->num_members counts running sockets. But that is not used
when tracking membership of the group, sk_ref is. Every packet socket
whose po->rollover is increased increases this refcount.

> What about using ifindex to detect bind? Initialize it to -1 in
> packet_create and ensure that packet_do_bind, on success, sets it
> to device id or 0?
> 
> psock_fanout, should probably be extended with scenarios that test
> "all devices" and all/specific protocols. Any specific scenario
> suggestions?
> 
> 



