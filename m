Return-Path: <linux-kselftest+bounces-4869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CF4858280
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 17:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF6CB224DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD212D76D;
	Fri, 16 Feb 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3w0mEqj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5A7E0F4
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101121; cv=none; b=t8VzFg2ieEcz1kMFoBhe1Vv3BJmzxJWyU0pRhWVt6TXxH0w2riaOFw57wdpEfHS2M7kmHhWXWi2g4egq2mfEgVjbJ74Z8xRDICqef7ZDGTOpapD+bb6r+JOnWfC/9BSAR+2BNbNnn9tAuHjB5wWdz58F2cx0ZeS+AvclpP2zYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101121; c=relaxed/simple;
	bh=tgliddJGPihHusljN5dVrwBc4BeaA+TNm1BcAV5Glh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBXIlk4cvDh5wjhozjXRSBVaDDW/ftOw723lXY5B7ykKLsp1AZYfQnWcyv6Knyr3u4aIeA1KdIzWSeffyUGi3w9EojYKak8aPo87k3UI7dq5D9H3JJsbT0EOswwfGfOdekPQk1qPuhGzeGMSxqev/8DouExEGSyQK3HZ3cjzSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3w0mEqj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708101118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+NV3H4SWLwy/p9YzJRRYUfX5NB0C57ei7kPnLlc5nEg=;
	b=C3w0mEqje3jIv8kqzmJGaywp2g8R5iS4T+5q5MPurGWfOWLyv5WcyluRsWY/53uDg9meqE
	et/j8yg41DytvLu1dtL5xU9yyXJDpYWd7P1+4K82e9uTjUeA/+qLN8cp+75+T/ZI84/nKi
	y7xgocFAjcdQWIBc7WYPbm17ZbIWDPQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-Lb4Nw90WNuevV_BZSwRKOQ-1; Fri, 16 Feb 2024 11:31:57 -0500
X-MC-Unique: Lb4Nw90WNuevV_BZSwRKOQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3377bf95b77so138175f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 08:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101115; x=1708705915;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NV3H4SWLwy/p9YzJRRYUfX5NB0C57ei7kPnLlc5nEg=;
        b=LdFjr9G1KU6EEOVcFj0dWB/LfnQwuen847Y/VE0aA3caJqnuglrTxkNmGzSsv/q7AX
         xEbt1M84ZVw6+oyRaVhVC5XOqv3D2Eel9nituCHUZ1Pg3ZEzgBeJFqVGyQtsvvcefNMi
         M6U2bwBpUSKvRHg5tTCNUOLwvddtXNhzpVRE4qMt9J+oPXuIthdATEKnxwMo2opSeSDa
         DtT2gJ9E72MGAaXLG/FpMd6TLZ+26ycwJXdIkFbF1kApLrKxC7BYZjRzkVUhR1449w8K
         /cWCVPcpdEF+WroO2S8iASp7fx+PPYgxRLmNhHH7vUXo9ojVwJwuQKjTw/ipv5+JfBBw
         GFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIsLcrCSherjsST5sKpLWiI1jT0CmqaSTC8e1lGGZpq0d9k/Ix2Gx625NmxIHB4lYsiIcyhTrWBwJxM9Woy3tQGBgCnGy9cinCbSnO5ySd
X-Gm-Message-State: AOJu0YyCkuoIEGBa2M4ZX1+4zzxtadLpAga/pwZ2omBruxn6o3ovpFhf
	Of5LrURm9AIpZiq6DCF0NRhlQbx3l0kROIAEDbduBgp5mb3hOG5J037Ubvbc7x+KwzBcI5se0oq
	r7mZO/H7kMxUf1gFyo1O3+z34f2f3JHdqiWVDjqXoG0eYUBdmf+SH9N6oxmIpicnz1Z+hSr2nlw
	==
X-Received: by 2002:a05:6000:70e:b0:33d:2270:8bfc with SMTP id bs14-20020a056000070e00b0033d22708bfcmr1019112wrb.3.1708101115764;
        Fri, 16 Feb 2024 08:31:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMBnoS4SrCuiWsNLBt2N8SpsfwDWgdSoAB6ZLpBJQ2CwBVDl4jFo/szcpQw45ssbmA5tFTPQ==
X-Received: by 2002:a05:6000:70e:b0:33d:2270:8bfc with SMTP id bs14-20020a056000070e00b0033d22708bfcmr1019095wrb.3.1708101115421;
        Fri, 16 Feb 2024 08:31:55 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-239-108.dyn.eolo.it. [146.241.239.108])
        by smtp.gmail.com with ESMTPSA id bn12-20020a056000060c00b0033cda80f54dsm2836773wrb.83.2024.02.16.08.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:31:54 -0800 (PST)
Message-ID: <7f51a2e2bfe1e3ee15f12f655e6d7ab5d9d73b5a.camel@redhat.com>
Subject: Re: [RFC 4/7] selftests: openvswitch: delete previously allocated
 netns
From: Paolo Abeni <pabeni@redhat.com>
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Pravin B Shelar
 <pshelar@ovn.org>, dev@openvswitch.org,  Ilya Maximets
 <i.maximets@ovn.org>, Simon Horman <horms@ovn.org>, Eelco Chaudron
 <echaudro@redhat.com>,  Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Date: Fri, 16 Feb 2024 17:31:53 +0100
In-Reply-To: <20240216152846.1850120-5-aconole@redhat.com>
References: <20240216152846.1850120-1-aconole@redhat.com>
	 <20240216152846.1850120-5-aconole@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 10:28 -0500, Aaron Conole wrote:
> Many openvswitch test cases reused netns and interface names.  This works
> fine as long as the test case cleans up gracefully.  However, if there is
> some kind of ungraceful termination (such as an external signal) the netn=
s
> or interfaces can be left lingering. =C2=A0

It looks the openvswitch.sh test script is already trying quite hard to
delete the allocated resources on ungraceful termination via "trap...".

That is usually enough for other self-tests, could you please detail
when it fails here?

> This happens when the selftest
> timeout gets exceeded, while running under very slow debugging conditions=
.

'timeout' should send SIG_TERM, and the script already handle that
gracefully?

> The solution here is to cleanup the netns on executing the next test.

I suggest avoiding this, it could end up killing innocent alias netns.

You could consider using the 'setup_ns' helper from the
tools/testing/selftests/net/lib.sh library to always generate unique
netns names.

> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  tools/testing/selftests/net/openvswitch/openvswitch.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/too=
ls/testing/selftests/net/openvswitch/openvswitch.sh
> index 678a72ad47c1..8dc315585710 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -115,6 +115,10 @@ ovs_netns_spawn_daemon() {
> =20
>  ovs_add_netns_and_veths () {
>  	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
> +	ntns_e=3D`ip netns list | grep $3`
> +	[ "$ntns_e" !=3D "" ] && ip netns del "$3"
> +	if4_e=3D`ip link show $4 2>/dev/null`

Minor unrelated note: $() is preferable to `` for sub-shells, as it's
more friendly to nesting, string expansing, quotes, etc.


Cheers,

Paolo


