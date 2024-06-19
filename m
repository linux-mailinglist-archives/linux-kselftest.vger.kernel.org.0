Return-Path: <linux-kselftest+bounces-12223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF7B90E6D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787E81F21657
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE4D7FBBD;
	Wed, 19 Jun 2024 09:22:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD87EEFD
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788941; cv=none; b=oTB8jED84ZKOjf9JG0sRYwdEM2028fmixzVmVSek0wMhmpUt8Ih1em5FOyF0N7Sy3FFXP4XDrDSVrsM4QMJPEsxRKaIM2hNlEje3LQ57RgSyBTzqO1wQl/DdGtxbrjB78G+pZcJ0802qG/F55+zYpr9NDk7gX4b0Qo6d0Z9FRBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788941; c=relaxed/simple;
	bh=Ssh4FL8rF5cQZRcv5OFI6cJooHEaM1fnEEOA7VAOc8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=CxKleYD7Nb2PBJEwzjyK66p8b5t6M7GqK0y0jKGchfOaEPw3xjV1CjCOXpU21qMVbcru8S/gehpXQJX5HjFvw7p86IMkN4fPRIsCrvNqnZ8t2ByQ4DsWWpiN9+TkwKbDW+F0oUA/BwXoG/YbM9RSdJxZ5v5ULxMLsSSJ/NxoEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-115-rSI3uHCePwmmyKNt5F40lA-1; Wed, 19 Jun 2024 10:22:10 +0100
X-MC-Unique: rSI3uHCePwmmyKNt5F40lA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jun
 2024 10:21:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jun 2024 10:21:35 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Simon Horman' <horms@kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Aaron Conole <aconole@redhat.com>, Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, Shuah Khan <shuah@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dev@openvswitch.org"
	<dev@openvswitch.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
Subject: RE: [PATCH net] selftests: openvswitch: Use bash as interpreter
Thread-Topic: [PATCH net] selftests: openvswitch: Use bash as interpreter
Thread-Index: AQHawKLiJAFnY1V1Jkm3NW1AGN/wlLHO0HXA
Date: Wed, 19 Jun 2024 09:21:35 +0000
Message-ID: <6084a57c191543568e6ec1828ec0efe4@AcuMS.aculab.com>
References: <20240617-ovs-selftest-bash-v1-1-7ae6ccd3617b@kernel.org>
 <594b79b7-452c-488f-8a7f-4ee95698bff2@intel.com>
 <20240617103337.GQ8447@kernel.org>
In-Reply-To: <20240617103337.GQ8447@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Simon Horman
> Sent: 17 June 2024 11:34
...
> > sidenote: I like very much the idea to use the least powerful tool, lik=
e
> > sh vs bash, awk vs gawk, but it breaks when we forget what is outside o=
f
> > the scope of the former/standard.
> > Perhaps for shell, we could convert all the selftests at once?
>=20
> Thanks,
>=20
> Now that you mention it, I have the same feelings.
>=20
> Do we ever expect to use the minimal tools, when other
> parts of the test suite depend on the enhanced ones?

Certainly trying to avoid bash-isms seems like a good idea.
Especially in scripts where it isn't really that hard.
OTOH avoiding posix features (so the script will run on a traditional SYSV =
/bin/sh)
is probably excessive.

I'd use "${foo%"${foo#?}"}" to get the first character without bash-isms.
But, IIRC, one version of ash/dash made a 'pig's breakfast' of the nested
pattern match.
(Most syntax highlighters don't get the quoting right either...)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


