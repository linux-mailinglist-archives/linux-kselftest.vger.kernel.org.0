Return-Path: <linux-kselftest+bounces-19441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96A0998975
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 16:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7509A281E9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6AF1CC8AD;
	Thu, 10 Oct 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8nEFLhJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99401CC16A;
	Thu, 10 Oct 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570118; cv=none; b=PRxzQZukGJqwGY22KapV4b9aLYtl/7lXS0q4LH7qRvV3o8A8CBQnT29OnW3tsTWcjikU7wrauIrbbfvnQJOMsB49Oov8V/H/8s8ZFZPgxYasKsmI2fdW05iCFsAdt2G4H8GZm82KJCxupA4OQlEVHygzuvKduhyN+HbKQLZOBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570118; c=relaxed/simple;
	bh=2vsd0t36CysrdnUXJ1Tyy2GMPfaxOitsHFsmsVwjl8o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mgDFmS99fbd+w97C7fC8lJCqH27vEZMTQL6s5nCpaTGh4cUiY7YTKNds4Ym2b6t4j2xM3+Nr4OMf71cFYkjfbBmAUx6kxu+YJRav6/ii9BuevdgVxV4H4MFWRMBFaekPpvIUGS+1WrANWTlivhLPyLQVG8HFFl7X9sBoKPdH4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8nEFLhJ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbd550b648so8361146d6.0;
        Thu, 10 Oct 2024 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728570116; x=1729174916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPYW2o7+IDp4rOpsXb7mw7n6T5iIMPfjZI8VNMH0Y/k=;
        b=Z8nEFLhJ0Gx8W80UkLQV5ccTlzWHFk6hDajutTXbdZw1EP4jRrVMv14CEVXx7JHW/J
         zvhV7XMiut6tZARdgNo13eTzouh/m+1gO4iTqKNI0aG9wh+ajSU3mKl2h5Mvx98mt2jg
         q7+AA7mfkfsKiTHQlJVF4pH+eH/3jO0UVVNAi98Zb5gtk/jRJrgiW6Efx2Mz3iJJzykk
         smVye3bBLvSV4JZfxS3X9Z17HLrX1OzcLaO+6jtrgkjkD5D2R8c1hA/6OZbw52JCpY84
         8kl2FrBLY/N4S4kZcu/BGv91nbX7JV4bLo5JnSGhKPB1sEvpmseGGIP55OmAeaZuYG8V
         QD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570116; x=1729174916;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LPYW2o7+IDp4rOpsXb7mw7n6T5iIMPfjZI8VNMH0Y/k=;
        b=uW2yNJD9bomzIKFJSVriM11nOWkl7ldSgiiz4cAn7aRzpfTHaOPcbXRpwRwCvU0Qap
         RyHHSSHMLdcN7IXULYridtqU7dUQoB0Dc9JZqEnQsyBkXs+5yMcdyqbJ3+sv2slb1Oru
         8OpVFyObE0n4eAraVboU+iw0xnUkPoiyQ8eYBWQ1MqoE5GJH3UZcWunDaMsN0wnaHF25
         0SJJ+V0V3HXKqCmor9lzMAvQWxW8DP7PURGZrF3gNUycHbjXutmiLsm+oB0mdi6rymzk
         PfrYVz9c1jqyXEtFbxFx53NUdACK5nT8QRD3yv8OQY8+UJXBw+Lu5AM91g6UObe1or3S
         jc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVylv1NysJNstzY0Ny7eI2ZbwSy9tYPIUkvjMhePG3WW0PiVdl2fhAN3VTgQc7X8EH5Rih1L9cii0POMzA=@vger.kernel.org, AJvYcCW5RHhGKeZMBCDJbXdILYz0y0sUsSS7TSpl0QqawnNOFCy/WLBi1hjJ9qBXd7raQVr1nke1naQ6@vger.kernel.org, AJvYcCXnqW2t/wkYUfCiJu6uQTGUrWXN6hejuyO+mMTE43C8U0XJ3U0/gUyKd4qC/+VqqlfVhlRg6ufsvA9WEyr0LcM0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3AqhSjOuCd+EY2KGwZN5Ysxxs2Lhx2siF/VA5ZJD8A+sxCjZ7
	kXLaKVCKALX4CSoxyJE5r7wJAnGugytSIAGY5z63mN/t6On0ajtB
X-Google-Smtp-Source: AGHT+IFszecyh01yRjn3IjHo2xSKpUGZZUn/kb84GZw7t3EC/g+95JBcJwuHw+JiRcZY5AMyqzPYBQ==
X-Received: by 2002:a05:6214:5684:b0:6cb:e52c:c8dd with SMTP id 6a1803df08f44-6cbe52cc95fmr44852066d6.53.1728570115612;
        Thu, 10 Oct 2024 07:21:55 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8679d3csm5669956d6.137.2024.10.10.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:21:55 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:21:54 -0400
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
Message-ID: <6707e3028d844_20573a294f0@willemb.c.googlers.com.notmuch>
In-Reply-To: <002701db1ae3$368d9b70$a3a8d250$@huawei.com>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
 <20241009065837.354332-1-gur.stavi@huawei.com>
 <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch>
 <002201db1a75$9a83b420$cf8b1c60$@huawei.com>
 <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch>
 <002701db1ae3$368d9b70$a3a8d250$@huawei.com>
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
> > > > Gur Stavi wrote:
> > > > > >> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk,
> > > > struct fanout_args *args)
> > > > > >>  	err = -EINVAL;
> > > > > >>
> > > > > >>  	spin_lock(&po->bind_lock);
> > > > > >> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> > > > > >> -	    match->type == type &&
> > > > > >> +	if (match->type == type &&
> > > > > >>  	    match->prot_hook.type == po->prot_hook.type &&
> > > > > >>  	    match->prot_hook.dev == po->prot_hook.dev) {
> > > > > >
> > > > > > Remaining unaddressed issue is that the socket can now be added
> > > > > > before being bound. See comment in v1.
> > > > >
> > > > > I extended the psock_fanout test with unbound fanout test.
> > > > >
> > > > > As far as I understand, the easiest way to verify bind is to test
> > that
> > > > > po->prot_hook.dev != NULL, since we are under a bind_lock anyway.
> > > > > But perhaps a more readable and direct approach to test "bind"
> > would be
> > > > > to test po->ifindex != -1, as ifindex is commented as "bound
> > device".
> > > > > However, at the moment ifindex is not initialized to -1, I can add
> > such
> > > > > initialization, but perhaps I do not fully understand all the
> > logic.
> > > > >
> > > > > Any preferences?
> > > >
> > > > prot_hook.dev is not necessarily set if a packet socket is bound.
> > > > It may be bound to any device. See dev_add_pack and ptype_head.
> > > >
> > > > prot_hook.type, on the other hand, must be set if bound and is only
> > > > modified with the bind_lock held too.
> > > >
> > > > Well, and in packet_create. But setsockopt PACKET_FANOUT_ADD also
> > > > succeeds in case bind() was not called explicitly first to bind to
> > > > a specific device or change ptype.
> > >
> > > Please clarify the last paragraph? When you say "also succeeds" do you
> > > mean SHOULD succeed or MAY SUCCEED by mistake if "something" happens
> > ???
> > 
> > I mean it succeeds currently. Which behavior must then be maintained.
> > 
> > > Do you refer to the following scenario: socket is created with non-zero
> > > protocol and becomes RUNNING "without bind" for all devices. In that
> > case
> > > it can be added to FANOUT without bind. Is that considered a bug or
> > does
> > > the bind requirement for fanout only apply for all-protocol (0)
> > sockets?
> > 
> > I'm beginning to think that this bind requirement is not needed.
> 
> I agree with that. I think that is an historical mistake that socket
> becomes implicitly bound to all interfaces if a protocol is defined
> during create. Without this bind requirement would make sense.
> 
> > 
> > All type and dev are valid, even if an ETH_P_NONE fanout group would
> > be fairly useless.
> 
> Fanout is all about RX, I think that refusing fanout for socket that
> will not receive any packet is OK. The condition can be:
> if (po->ifindex == -1 || !po->num)

Fanout is not limited to sockets bound to a specific interface.
This will break existing users.

Binding to ETH_P_NONE is useless, but we're not going to slow down
legitimate users with branches for cases that are harmless.

> I realized another possible problem. We should consider adding ifindex
> Field to struct packet_fanout to be used for lookup of an existing match.
> There is little sense to bind sockets to different interfaces and then
> put them in the same fanout group.
> If you agree, I can prepare a separate patch for that.
> 
> > The type and dev must match that of the fanout group, and once added
> > to a fanout group can no longer be changed (bind will fail).
> > 
> > I briefy considered the reason might be max_num_members accounting.
> > Since f->num_members counts running sockets. But that is not used
> > when tracking membership of the group, sk_ref is. Every packet socket
> > whose po->rollover is increased increases this refcount.
> > 
> > > What about using ifindex to detect bind? Initialize it to -1 in
> > > packet_create and ensure that packet_do_bind, on success, sets it
> > > to device id or 0?
> > >
> > > psock_fanout, should probably be extended with scenarios that test
> > > "all devices" and all/specific protocols. Any specific scenario
> > > suggestions?
> > >
> > >
> > 
> 
> 



