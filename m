Return-Path: <linux-kselftest+bounces-12627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D828916120
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 10:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED461C225EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A714831E;
	Tue, 25 Jun 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QL/Vv+OH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384414830A
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304033; cv=none; b=XFxCY/qh5DOAmK8t1e4ArBQocQaNLgpsvadh65qLnrez+378ectpwTzX1n3pw2sAX1+1fcc1ZTTTt1nK6sxmxAij/tvEy1rrj+8Xm7HhHrg2Os5nsZCYdronsN90hqNKtrclKLuo5yrw1cO2V6qbsLjVQDyhgqbVrDzd1U+uaho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304033; c=relaxed/simple;
	bh=Bf36SJdFWYRqwTouppv1vio+ToIeC5fqcpUg5pu6HrM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uh4OQjHYRJnn6zF0zxyDq3QNzptilPnQLqFc3rxUiA0QPalr8/dmm66iCITByL1XzyW2fi/83y1HPCykcnEj6gacqUd0/+ZN5nWrh1tZRYPVQwDIZNIN6fiZO3wgNmsizzcCn4PDMr2KSP9fC824iSUqrTtb5jTfPeviYoscJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QL/Vv+OH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719304030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2rUH67oEzrKgx4Wg78wPw43JeCyeHYg+DD1dyGjUu7g=;
	b=QL/Vv+OH/2pa9vm7hQW4mgvmWEJuLg47kenkRyr0WwGG8Ov+gE60gl6TZquPb/eBQxPu8n
	+FmRq3aQkcNoKF0dZiv7BG9BuEtMfzEXUtRWVodZJdUxbVmV/7XUg9+tUMvbtiUHkTs/LJ
	tmVmvpCU2R0bRl+n4Gzp9PQdorJ4CdY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-OzASKdq5M-mCSsBfTuL8yg-1; Tue, 25 Jun 2024 04:27:08 -0400
X-MC-Unique: OzASKdq5M-mCSsBfTuL8yg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ebd69e45b3so5133701fa.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 01:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304026; x=1719908826;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rUH67oEzrKgx4Wg78wPw43JeCyeHYg+DD1dyGjUu7g=;
        b=b4V4S92DF03uyqOqk7QMGC8gr4bV+hmlEqjRpKVrtm++emZw956kNP2u5NWc144J4F
         ZUmMEIRZowRQmxJZAAvJXs/BXv3AT0dJbjry1vSxG8+QjSUHVXSI2knVwfsRW4N5AwO2
         xBdqh/1STzkNrtBz4dFd5VyVAmzNfqtUP186N+XFpvwHC/NcHPRPWfQCQmeNcLNp6FDm
         8JBPhEMoIWIhgwTuxoViiaHjfnIgjWk3NNLVAJFJMvZ0Ap/5OnY3yYEI7UX8c7CQzDgT
         HpimnJPMjLo964hNk0WAcEijURiWUzf0xhfogb/xxGjZiD9tTRKoYLOA3SBdl3/q3+zs
         5r4g==
X-Forwarded-Encrypted: i=1; AJvYcCU9gHv19yxh0SqUgR4Ny+LTmfWK++Sc4I5fVKSMMYsGNDjplzDWIdbyEyki0LoxU6GZs9taVvxRZkscffeR/VjY5L6pWljeZflYIj3/2EeF
X-Gm-Message-State: AOJu0Yz+mAT43btDvQTTaGfwxhkxGUFvsEggqgkAISHS3g5RuckLj3z0
	ms2T50B13Z623tzr6cTBicJRqTUVrr4K8CudmN3eEa3IX//a1R9EWCiHS6/qJnRMUlYJl/Ymy97
	+HUiaowAgbM9c0HdeqSP3vkIwHpfqBueEassGIbEskQ0zVQ0IxNA9trIZd1Dz6bmx5w==
X-Received: by 2002:a05:6512:3da1:b0:52c:9a5a:e16c with SMTP id 2adb3069b0e04-52cdeaa98b9mr5718767e87.4.1719304026487;
        Tue, 25 Jun 2024 01:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjkFPpYUA9yrUFXnomFA34LVWTkBxO/9X31gQM/xKHe8a//5jga86jqgmtqYLFY02jIuGx9A==
X-Received: by 2002:a05:6512:3da1:b0:52c:9a5a:e16c with SMTP id 2adb3069b0e04-52cdeaa98b9mr5718748e87.4.1719304026011;
        Tue, 25 Jun 2024 01:27:06 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:da10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d21226asm204839415e9.47.2024.06.25.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:27:05 -0700 (PDT)
Message-ID: <e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
From: Paolo Abeni <pabeni@redhat.com>
To: Aaron Conole <aconole@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Stefano
 Brivio <sbrivio@redhat.com>, =?ISO-8859-1?Q?Adri=E1n?= Moreno
 <amorenoz@redhat.com>,  Simon Horman <horms@kernel.org>
Date: Tue, 25 Jun 2024 10:27:03 +0200
In-Reply-To: <f7tpls6gu3q.fsf@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
	 <20240621180126.3c40d245@kernel.org> <f7ttthjh33w.fsf@redhat.com>
	 <f7tpls6gu3q.fsf@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 12:53 -0400, Aaron Conole wrote:
> Aaron Conole <aconole@redhat.com> writes:
>=20
> > Jakub Kicinski <kuba@kernel.org> writes:
> >=20
> > > On Thu, 20 Jun 2024 08:55:54 -0400 Aaron Conole wrote:
> > > > This series enhances the ovs-dpctl utility to provide support for s=
et()
> > > > and tunnel() flow specifiers, better ipv6 handling support, and the
> > > > ability to add tunnel vports, and LWT interfaces.  Finally, it modi=
fies
> > > > the pmtu.sh script to call the ovs-dpctl.py utility rather than the
> > > > typical OVS userspace utilities.
> > >=20
> > > Thanks for the work!=20
> > >=20
> > > Looks like the series no longer applies because of other changes
> > > to the kernel config. Before it stopped applying we got some runs,
> > > here's what I see:
> > >=20
> > > https://netdev-3.bots.linux.dev/vmksft-net/results/648440/3-pmtu-sh/s=
tdout
> > >=20
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv4, OVS vxlan4: PMTU exceptions                            =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv4, OVS vxlan4: PMTU exceptions - nexthop objects          =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv6, OVS vxlan4: PMTU exceptions                            =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv6, OVS vxlan4: PMTU exceptions - nexthop objects          =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv4, OVS vxlan6: PMTU exceptions                            =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv4, OVS vxlan6: PMTU exceptions - nexthop objects          =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv6, OVS vxlan6: PMTU exceptions                            =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv6, OVS vxlan6: PMTU exceptions - nexthop objects          =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv4, OVS geneve4: PMTU exceptions                           =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv4, OVS geneve4: PMTU exceptions - nexthop objects         =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv6, OVS geneve4: PMTU exceptions                           =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv6, OVS geneve4: PMTU exceptions - nexthop objects         =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv4, OVS geneve6: PMTU exceptions                           =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv4, OVS geneve6: PMTU exceptions - nexthop objects         =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > > # TEST: IPv6, OVS geneve6: PMTU exceptions                           =
 [FAIL]
> > > # Cannot find device "ovs_br0"
> > >=20
> > > Any idea why? Looks like kernel config did include OVS, perhaps we ne=
ed
> > > explicit modprobe now? I don't see any more details in the logs.
> >=20
> > Strange.  I expected that the module should have automatically been
> > loaded when attempting to communicate with the OVS genetlink family
> > type.  At least, that is how it had been working previously.
> >=20
> > I'll spend some time looking into it and resubmit a rebased version.
> > Thanks, Jakub!
>=20
> If the ovs module isn't available, then I see:
>=20
> #   ovs_bridge not supported
> # TEST: IPv4, OVS vxlan4: PMTU exceptions                             [SK=
IP]
>=20
> But if it is available, I haven't been able to reproduce such ovs_br0
> setup failure - things work.

I'm still wondering if the issue is Kconfig-related (plus possibly bad
interaction with vng). I don't see the OVS knob enabled in the self-
tests config. If it's implied by some other knob, and ends-up being
selected as a module, vng could stumble upon loading the module at
runtime, especially on incremental build (at least I experience that
problem locally). I'm not even sure if the KCI is building
incrementally or not, so all the above could is quite a wild guess.

In any case I think adding the explicit CONFIG_OPENVSWITCH=3Dy the
selftest config would make the scenario more well defined.

Cheers,

Paolo


