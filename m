Return-Path: <linux-kselftest+bounces-43157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A63BDC1D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 04:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEA819A2B5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43CE308F32;
	Wed, 15 Oct 2025 02:09:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE325C711;
	Wed, 15 Oct 2025 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494193; cv=none; b=WWBogJKuiUVlX0Z3AM5qSDPjXEoPThOFoHUBTnIybggjvb+WzUARMdyytTlytknhNxdXNb+6b4XR7CuuQzGR1mBdBVVH8Mq4caKLcmsJUFf7WjUgqaAStQ0mZ9SOW215uwS5eE7N9OyZCOmbsZ0gSdSOlE1UFS+pralcU49XhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494193; c=relaxed/simple;
	bh=bc54xO84RzzB202e+ZMmbdyvlYyAFS2WR/CfmHyOe5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HqaAkoj/tKwH1Edu9hEisGw9tWM576pBSFt/mC7SUB6KM+GW82pUXuTl0NI85HTKz2ki/b8Ml36wcSW09XWJO02YRZcn4k2U/wN/0g4JNDZRnS2ZArVSnW4yUuSJDVhQKsm4AfaC/00+M1qxshCwwP1Ivqa4lSg6ETaQWVbF9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Petr Mladek <pmladek@suse.com>
CC: Lance Yang <lance.yang@linux.dev>, "wireguard@lists.zx2c4.com"
	<wireguard@lists.zx2c4.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, David Hildenbrand <david@redhat.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	"Russell King" <linux@armlinux.org.uk>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, "Jonathan Corbet" <corbet@lwn.net>, Joel Granados
	<joel.granados@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, Phil
 Auld <pauld@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, "Pawan Gupta"
	<pawan.kumar.gupta@linux.intel.com>, Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>, Florian Westphal
	<fw@strlen.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Kees Cook
	<kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Paul E . McKenney"
	<paulmck@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, "Jason A .
 Donenfeld" <Jason@zx2c4.com>
Subject: RE: [????] Re: [????] Re: [PATCH][v3] hung_task: Panic after fixed
 number of hung tasks
Thread-Topic: [????] Re: [????] Re: [PATCH][v3] hung_task: Panic after fixed
 number of hung tasks
Thread-Index: AQHcPO9h0grxiWd7ak27/owdD96L07TBdJLA//+i6ACAAVy0QA==
Date: Wed, 15 Oct 2025 02:04:21 +0000
Message-ID: <b7937a55047b44c687e11e219a62009e@baidu.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
 <e3f7ddf68c2e42d7abf8643f34d84a18@baidu.com>
 <aO5Ldv4U8QSGgfog@pathway.suse.cz>
In-Reply-To: <aO5Ldv4U8QSGgfog@pathway.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.46
X-FE-Policy-ID: 52:10:53:SYSTEM

> I would also update the subject to something like:
>=20
>     hung_task: Panic when there are more than N hung tasks at the same
> time
>=20

Ok, I will update=20

>=20
>=20
> That said, I think that both approaches make sense.
>=20
> Your approach would trigger the panic when many processes are stuck.
> Note that it still might be a transient state. But I agree that the more =
stuck
> processes exist the more serious the problem likely is for the heath of t=
he
> system.
>=20
> My approach would trigger panic when a single process hangs for a long
> time. It will trigger more likely only when the problem is persistent. Th=
e
> seriousness depends on which particular process get stuck.
>=20
Yes, both are reasonable requirement, and I will leave it to you or anyone =
else interested to implement it

Thanks

-Li.


> I am fine with your approach. Just please, make more clear that the numbe=
r
> means the number of hung tasks at the same time.
> And mention the problems to login, ...
>=20
> Best Regards,
> Petr

