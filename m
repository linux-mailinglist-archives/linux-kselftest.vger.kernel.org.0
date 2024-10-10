Return-Path: <linux-kselftest+bounces-19482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A59994F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 00:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5A11F246A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 22:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ADA1E47CE;
	Thu, 10 Oct 2024 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FES7iSty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6519CD1D;
	Thu, 10 Oct 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598329; cv=none; b=c+7X7ckJT0pE5byVtZQb5HHi0zydyUqZgK7H2qmTAitwJfCtQhzZJtT7zjpGbKxKICd9zTCGmXiGFU/4nFyMUpBYTOTmjRK86rp0PUleTdR+QQmBelUQbKEyAEcJ4882nE4pN6aNR4l8msquz+sVwtDsxFDowiqmxUja/dZOleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598329; c=relaxed/simple;
	bh=xRoe/sdYS0xA14i4NdUwQqxxZL9PlWpiEF1UXmi4Lt4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KLRP5hWFQkxRdGWX8TvBmUxNiDcXLkP7LJOy3jjozhumCFBnInl8c/7gzjRmvwcz0d81/Ra9fg4vJNphSejmOvN/qIeOuVAUmRvokTH4o477EoO4t3UMIbpSice9gKerbMXcUrh2JXmBoXM5LpORl08Ml/LzvqqfDSzjCI0iGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FES7iSty; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45f0a0f9687so13059461cf.3;
        Thu, 10 Oct 2024 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728598327; x=1729203127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGedDGDB+Aoa+74kGdBVBsBsvAGyw2bhj1E12n46Ci8=;
        b=FES7iStyyITnPi7w/64mtkyj+5OhMwMYJig+rJD66SwbrSweTCDkGksQ4UIMvTFzRX
         G+77TIzoJVgD4GIjdqvrs0sIotb/0j3zK2glhNFfd31wFJ5Yjq9hHXc4TQ6jRzYuy//x
         mfao2KC6dw7EYeKDJgL8woE5c3R96W6ttww53V+vhYsY98vHzCnmSEEa4IW+/E+wQPOv
         3foU06hCLOTxIdhtn1gJVbrHQVt0Mw4u1MCa4pT4Zk/llz71l838Sa5xrmXciuquBPl0
         3jM/p2ReQTUoMicYCF5+GAQofs6Ft56FbbH+s7mTB0mLOG8M77DpMFX4gY1lUeAYVvQB
         XnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728598327; x=1729203127;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZGedDGDB+Aoa+74kGdBVBsBsvAGyw2bhj1E12n46Ci8=;
        b=E/FwmBqMVa6lLHUNMDqmDg+QLy5zre9LMXP4rxNb8nuwO0sMe0qIXyPP65jNJYVVVv
         +wnnCDqZ/SRoQXcJq1mlScEaX9QIXziTPzRbm38NEcVKafHkaIkzn77rmaiYlC4ENNgk
         hBAdWuaqVkwdAoImxbjd8JhlEuJYaSFyb3X0pnuCYUZX/E7qWghLzUXmpCL8Y5hSJrfF
         ho5ICzE7BAVYBhChXV77pydREeMWbdLOharHVUoaJ29IRcAKQAZ7K0VQdIReQ4CnQuSF
         KMK9Sga9Ex/jWac/5PpHz864Gm0pRjY6PYE+EuY2YVDyUSCBFSSdBIDghCQ/E8IZKprZ
         Ik8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5N2gCq3aIJ2aQ87D2EEptlFnBqBJk6QXbYH5cgk5dvfBI6hJISt0GaQ6BfUm/EOsx0LXEFzc/@vger.kernel.org, AJvYcCWbftIcjkggBuftVlOMNhwomU1zLzES5mk5XnoP+tKEuZNPJYjLkQRZrL9jB1rV3bnQKnkJFLqg6kqXG2qqnC6h@vger.kernel.org, AJvYcCX+9GpmIdecMO8uhuNmTnTvjferBizHqriKis1sahq32ahIlcuLqVjGlQLef4KN2s+H2uB7+4Omm78jrec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/JkgL7Ul693XZ+n3SY6Uv38hbEpyR0W0DnxXGvOefnZAFcKD
	vTnzSDzuDsluA/NtwkHwaO1M/CSrsdCSkXuE5xLGvnX/LkMveGqB
X-Google-Smtp-Source: AGHT+IHV+SccpDGdFVFMotwlP6rtIqTcPQtRb4YFMfdkC5WWjIzHfuQnY7jobCohB9m/o/pHPr9ciQ==
X-Received: by 2002:a05:622a:2cb:b0:45b:16b:ecb7 with SMTP id d75a77b69052e-4604bb962camr7068641cf.1.1728598326960;
        Thu, 10 Oct 2024 15:12:06 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427d50efsm9625961cf.22.2024.10.10.15.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 15:12:06 -0700 (PDT)
Date: Thu, 10 Oct 2024 18:12:05 -0400
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
Message-ID: <67085135e4fe2_21530629429@willemb.c.googlers.com.notmuch>
In-Reply-To: <000101db1b2f$7410c2f0$5c3248d0$@huawei.com>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
 <20241009065837.354332-1-gur.stavi@huawei.com>
 <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch>
 <002201db1a75$9a83b420$cf8b1c60$@huawei.com>
 <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch>
 <002701db1ae3$368d9b70$a3a8d250$@huawei.com>
 <6707e3028d844_20573a294f0@willemb.c.googlers.com.notmuch>
 <000101db1b2f$7410c2f0$5c3248d0$@huawei.com>
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
> > > > > > Gur Stavi wrote:
> > > > > > > >> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock
> > *sk,
> > > > > > struct fanout_args *args)
> > > > > > > >>  	err = -EINVAL;
> > > > > > > >>
> > > > > > > >>  	spin_lock(&po->bind_lock);
> > > > > > > >> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> > > > > > > >> -	    match->type == type &&
> > > > > > > >> +	if (match->type == type &&
> > > > > > > >>  	    match->prot_hook.type == po->prot_hook.type &&
> > > > > > > >>  	    match->prot_hook.dev == po->prot_hook.dev) {
> > > > > > > >
> > > > > > > > Remaining unaddressed issue is that the socket can now be
> > added
> > > > > > > > before being bound. See comment in v1.
> > > > > > >
> > > > > > > I extended the psock_fanout test with unbound fanout test.
> > > > > > >
> > > > > > > As far as I understand, the easiest way to verify bind is to
> > test
> > > > that
> > > > > > > po->prot_hook.dev != NULL, since we are under a bind_lock
> > anyway.
> > > > > > > But perhaps a more readable and direct approach to test "bind"
> > > > would be
> > > > > > > to test po->ifindex != -1, as ifindex is commented as "bound
> > > > device".
> > > > > > > However, at the moment ifindex is not initialized to -1, I can
> > add
> > > > such
> > > > > > > initialization, but perhaps I do not fully understand all the
> > > > logic.
> > > > > > >
> > > > > > > Any preferences?
> > > > > >
> > > > > > prot_hook.dev is not necessarily set if a packet socket is bound.
> > > > > > It may be bound to any device. See dev_add_pack and ptype_head.
> > > > > >
> > > > > > prot_hook.type, on the other hand, must be set if bound and is
> > only
> > > > > > modified with the bind_lock held too.
> > > > > >
> > > > > > Well, and in packet_create. But setsockopt PACKET_FANOUT_ADD also
> > > > > > succeeds in case bind() was not called explicitly first to bind
> > to
> > > > > > a specific device or change ptype.
> > > > >
> > > > > Please clarify the last paragraph? When you say "also succeeds" do
> > you
> > > > > mean SHOULD succeed or MAY SUCCEED by mistake if "something"
> > happens
> > > > ???
> > > >
> > > > I mean it succeeds currently. Which behavior must then be maintained.
> > > >
> > > > > Do you refer to the following scenario: socket is created with non-
> > zero
> > > > > protocol and becomes RUNNING "without bind" for all devices. In
> > that
> > > > case
> > > > > it can be added to FANOUT without bind. Is that considered a bug or
> > > > does
> > > > > the bind requirement for fanout only apply for all-protocol (0)
> > > > sockets?
> > > >
> > > > I'm beginning to think that this bind requirement is not needed.
> > >
> > > I agree with that. I think that is an historical mistake that socket
> > > becomes implicitly bound to all interfaces if a protocol is defined
> > > during create. Without this bind requirement would make sense.
> > >
> > > >
> > > > All type and dev are valid, even if an ETH_P_NONE fanout group would
> > > > be fairly useless.
> > >
> > > Fanout is all about RX, I think that refusing fanout for socket that
> > > will not receive any packet is OK. The condition can be:
> > > if (po->ifindex == -1 || !po->num)
> > 
> > Fanout is not limited to sockets bound to a specific interface.
> > This will break existing users.
> 
> For specific interface ifindex >= 1
> For "any interface" ifindex == 0
> ifindex is -1 only if the socket was created unbound with proto == 0
> or for the rare race case that during re-bind the new dev became unlisted.
> For both of these cases fanout should fail.

The only case where packet_create does not call __register_prot_hook
is if proto == 0. If proto is anything else, the socket will be bound,
whether to a device hook, or ptype_all. I don't think we need this
extra ifindex condition.
 
> > 
> > Binding to ETH_P_NONE is useless, but we're not going to slow down
> > legitimate users with branches for cases that are harmless.
> > 
> 
> With "branch", do you refer to performance or something else?
> As I said in other mail, ETH_P_NONE could not be used in a fanout
> before as well because socket cannot become RUNNING with proto == 0.

Good point.

> For performance, we removed the RUNNING condition and added this.
> It is not like we need to perform 5M fanout registrations/sec. It is a
> syscall after all.

It's as much about code complexity as performance. Both the patch and
resulting code should be as small and self-evident as possible.

Patch v3 introduces a lot of code churn.

If we don't care about opening up fanout groups to ETH_P_NONE, then
patch v2 seems sufficient. If explicitly blocking this, the ENXIO
return can be added, but ideally without touching the other lines.

> > > I realized another possible problem. We should consider adding ifindex
> > > Field to struct packet_fanout to be used for lookup of an existing
> > match.
> > > There is little sense to bind sockets to different interfaces and then
> > > put them in the same fanout group.
> > > If you agree, I can prepare a separate patch for that.
> > >
> > > > The type and dev must match that of the fanout group, and once added
> > > > to a fanout group can no longer be changed (bind will fail).
> > > >
> > > > I briefy considered the reason might be max_num_members accounting.
> > > > Since f->num_members counts running sockets. But that is not used
> > > > when tracking membership of the group, sk_ref is. Every packet socket
> > > > whose po->rollover is increased increases this refcount.
> > > >
> > > > > What about using ifindex to detect bind? Initialize it to -1 in
> > > > > packet_create and ensure that packet_do_bind, on success, sets it
> > > > > to device id or 0?
> > > > >
> > > > > psock_fanout, should probably be extended with scenarios that test
> > > > > "all devices" and all/specific protocols. Any specific scenario
> > > > > suggestions?
> > > > >
> > > > >
> > > >
> > >
> > >
> > 
> 
> 



