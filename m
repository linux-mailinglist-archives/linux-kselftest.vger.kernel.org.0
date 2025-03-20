Return-Path: <linux-kselftest+bounces-29523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC821A6AF6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 21:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0318A7AA687
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E526F22A1F1;
	Thu, 20 Mar 2025 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLEjFnIN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52611229B02;
	Thu, 20 Mar 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504098; cv=none; b=FkeVkqRvCMRZt4EeiV+H21OfI6ZawemTDp48uydU3+ASZ2TPqAzL9gjGKhNfbdITY55V/G9palfkMf2xSipD8KIqJZ87aDui0ne7YWM7jLqVe0K2pmAR8tyKW/GnAX00aKIbqFhQot9KSAFmpTyvqX99/BX6LMrdPbkEyqS/9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504098; c=relaxed/simple;
	bh=iXQ18XPUgoYJiSFSxjhg3L0CNHDwv1VsQkAjlNWUKpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUnMqBlsQXYvuil6E+AqtE+OEZnbHCnw8b+3P8MDGEYT+eahfvrwCF+jY0519TL4XsebbiTXwtRiP16/WMLohuZq6+LS82Qx4Y7Qol7BRTFYriPpPF1yXg1dm7Tj1ioVdwVN/W1zoArOQR8nZfRVZs6zzzX1bGVeJAgNL6EeNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLEjFnIN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225fbdfc17dso21156205ad.3;
        Thu, 20 Mar 2025 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742504096; x=1743108896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MmBASaW+GqNY/UJNZ84+vFK6yD9rkYMUDyMz4fd0U0A=;
        b=DLEjFnINDmgSC+TQ7Mi/xe/NWdwJrurCOwPsQHo9DwJSwEbIndYD59AoFxTw/0j4aJ
         xNVAFZOGCqa/kvfXmzzY3sRRqKtEr+SX+Jm/UlP9pv+n+/ZYcvNcG86KefqFTEkb/qC0
         scyq6kvA6EDqIlVuAnqlUCi9jkbEgBssC0/bsngU015mfc5+cH1i3HVDQVYtfi+Qjap8
         xcPo5HlEFBi5f8zP/Mep8XMTesdPy9/0voCEVeKkJG1Q3vmOBNOjFulSV4ajqOboLmxq
         nLo5z5hZTaAp9s6oIrfhrLb2xSnMoLuGBENITPEFDjAD5GiZnCFibjhHnwSjVSYJ6spl
         oyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742504096; x=1743108896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmBASaW+GqNY/UJNZ84+vFK6yD9rkYMUDyMz4fd0U0A=;
        b=o2sK+53lENmd+G9YqEhP2sJYteLqzu6jLWc7eU0q5AT5OaskCzoXzVVNZcoxnLEuUY
         QW96iLhAO3g3t0e+Ihk/LUHqMyIPBwhjXEpkJyXVXHUZK0uCaH7Z8kEVkoWoJNof6ofF
         haPI9ZDm0LQ6GXQ0MbMJ8x0cXrZi2+C5QXmleccHow8aMMxkQyv2mgFtW38wIxlwKQFp
         GO9d48tbVLQICZsLiLdGGaKiRT9Yx+xSVtMB/btvCaxJ7s11xQ7jU1ynGgD/D5hsulDu
         M6/jSblaq654lZuBg5LFyPv0tsZogyKoK3NIi2MiMb+YeLXL/8rlPi1yFQs2+ijburHz
         nGJg==
X-Forwarded-Encrypted: i=1; AJvYcCUe/FGdNQHOP0L+zI3dXVz6opYzBpLsGXRJEKBvqQfV2hjEZ44b1FprA18lh2zPD8r8VH1cLzK2tJiE4vPY4TcV@vger.kernel.org, AJvYcCUqHLKFr7XrgaaNYBBnJv09qu/UZsKfGMGGMaBFOClwgrPoVZ82Zrm5gSegQEmh7VZGhYE=@vger.kernel.org, AJvYcCVDDoOMD3s0QFbOk59XgbT/+t3hBDYdX1NBSRKvf38Ndkg2VRrJIn0sHiKOf8mJDZfAG1pfownV@vger.kernel.org, AJvYcCWLr7uCceM2Elj+AneH0Vcf2Hab7kKyH3SSFR0u5bVj596UFTVpMnzfSX2rmizNNL5xbxOy4GGIAaH5d0js@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDzS4Zkm1FugLguwbXfzd6S2UF4XwTaV6gqw8TNCyZkYazQ8W
	7FKhL0KX05AWuiiJa3UDPGlFDSi0ru4XckBCbQPL6uXnXCNvMUnc
X-Gm-Gg: ASbGncuPX/yTL6dMWhsJQhi/O9BsWaw0xfW9bY1HGLj8MslRgdy2U6AkB5UXrcHqmTP
	vOSf1MqKKvo4n8j1KyJ+6D1mTvDI5ZWlfTJuNksySHH36eeffszNrxpSS7rcrdHCoABdyRl+j6J
	gXGINeYiQPJqTIxwD0bqPB30tXHTiU2m4BssIZb8pIo5ANAFMDD4tUSxEWWyL44nKWdfBt5iMhA
	wDJDinOOd27jfmzMgd2NWfzpo6Dr6tmOHG+4Ttb8pxVxYQSOZtVHJ/1tNEVVaQBnAakpm+KTKLh
	cdOtjxEq7A7Hekm0Oa64IoJKDdachDwXZBiBw5BisZzGsc74
X-Google-Smtp-Source: AGHT+IGVYYQZcFd57VZXj1o+MK4h5npJo8HOGu2ixgfY4o0AjAyD4std72Wt6w9yNTxK+u0HMfnPJQ==
X-Received: by 2002:a17:902:cec4:b0:219:e4b0:4286 with SMTP id d9443c01a7336-22780db462fmr12039995ad.29.1742504096349;
        Thu, 20 Mar 2025 13:54:56 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a24410sm340304a12.56.2025.03.20.13.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:54:55 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:54:54 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] vsock/bpf: Fix bpf recvmsg() racing transport
 reassignment
Message-ID: <Z9yAnhMsupaaVCII@pop-os.localdomain>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
 <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>
 <Z9tCnq0rBw+nETfW@pop-os.localdomain>
 <4de119d5-c9c7-4f66-9e31-91c44a92c773@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de119d5-c9c7-4f66-9e31-91c44a92c773@rbox.co>

On Thu, Mar 20, 2025 at 01:05:27PM +0100, Michal Luczaj wrote:
> On 3/19/25 23:18, Cong Wang wrote:
> > On Mon, Mar 17, 2025 at 10:52:25AM +0100, Michal Luczaj wrote:
> >> Signal delivery during connect() may lead to a disconnect of an already
> >> established socket. That involves removing socket from any sockmap and
> >> resetting state to SS_UNCONNECTED. While it correctly restores socket's
> >> proto, a call to vsock_bpf_recvmsg() might have been already under way in
> >> another thread. If the connect()ing thread reassigns the vsock transport to
> >> NULL, the recvmsg()ing thread may trigger a WARN_ON_ONCE.
> >>
> 
>    *THREAD 1*                      *THREAD 2*
> 
> >> connect
> >>   / state = SS_CONNECTED /
> >>                                 sock_map_update_elem
> >>                                 vsock_bpf_recvmsg
> >>                                   psock = sk_psock_get()
> >>   lock sk
> >>   if signal_pending
> >>     unhash
> >>       sock_map_remove_links
> > 
> > So vsock's ->recvmsg() should be restored after this, right? Then how is
> > vsock_bpf_recvmsg() called afterward?
> 
> I'm not sure I understand the question, so I've added a header above: those
> are 2 parallel flows of execution. vsock_bpf_recvmsg() wasn't called
> afterwards. It was called before sock_map_remove_links(). Note that at the
> time of sock_map_remove_links() (in T1), vsock_bpf_recvmsg() is still
> executing (in T2).

I thought the above vsock_bpf_recvmsg() on the right side completed
before sock_map_remove_links(), sorry for the confusion.

> 
> >>     state = SS_UNCONNECTED
> >>   release sk
> >>
> >> connect
> >>   transport = NULL
> >>                                   lock sk
> >>                                   WARN_ON_ONCE(!vsk->transport)
> >>
> > 
> > And I am wondering why we need to WARN here since we can handle this error
> > case correctly?
> 
> The WARN and transport check are here for defensive measures, and to state
> a contract.
> 
> But I think I get your point. If we accept for a fact of life that BPF code
> should be able to handle transport disappearing - then WARN can be removed
> (while keeping the check) and this patch can be dropped.

I am thinking whether we have more elegant way to handle this case,
WARN looks not pretty.

> 
> My aim, instead, was to keep things consistent. By which I mean sticking to
> the conditions expressed in vsock_bpf_update_proto() as invariants; so that
> vsock with a psock is guaranteed to have transport assigned.

Other than the WARN, I am also concerned about locking vsock_bpf_recvmsg()
because for example UDP is (almost) lockless, so enforcing the sock lock
for all vsock types looks not flexible and may hurt performance.

Maybe it is time to let vsock_bpf_rebuild_protos() build different hooks
for different struct proto (as we did for TCP/UDP)?

Thanks.

