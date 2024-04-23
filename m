Return-Path: <linux-kselftest+bounces-8727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE88AF76B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 21:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A805D2898CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B21420BE;
	Tue, 23 Apr 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rFZnJmX5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487811420C6;
	Tue, 23 Apr 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900769; cv=fail; b=kCp2/FOYryWHJwUJeKh7J0bHFq0cYmuQpnf4MDGNCjEwJyEFo6w9unbdo6bXyGi/W8Nw0IwWPrb/cX1Tp0tqCOm/cLTWiebxQl5EWjDbIoAqAxqgDowBHcDPxXCUoenDIQVzK77WP5KIp1b93Mv2RksHeJ5YjqpiTl+vXcQUOSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900769; c=relaxed/simple;
	bh=y/O00YEwKmVuYvOevFM/qryrEZ8z0jS4ii2vRbxHfpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cYc/Z2K9KoUzwujRvP+14+OHVl1THe3srHRDiJ/2Fmi66rEaarE03cdTCzz1v+F0pQynUEWHaADWlOoVza0wUxKtp3txlQtAqeT7264z9lSYnaKpIt5982NQWhAx8UjhzWkAVcRkq1KdYh4np3sHe42Zhp5S00IkcBzd46C5o4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rFZnJmX5; arc=fail smtp.client-ip=40.92.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQUfhUNwE8ts7Y1fAQXqPPNxSf7NR7fU+dr3j8CRU/gZV2dUDGqYw0H/iZQcw/H/YfKYtksQu2YzpnRXrjfGV6M1/zyYXUpcg4ryYAMh+8qE+ZJnD7ACEzn1X9usw1lC8vYpgQnwFt9zZzFTQ99vTrO77cwj4RxzHZPkU4U3yHSy9mT7MG9bWxKX0ErA7ECaBLVgcURidK2MXOF2Q1SK5RDY/epLf+DknPQQs3pv0LQVCuxPtyL4K/wEZzLbnU/NdCcUe/iO76kEr2Qtcrrk54zHEaw+nIppMfohZ7FlU+VXFICZSFSduBP7TeIMIKdLVK110P1g0vwAGWi19JiIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/O00YEwKmVuYvOevFM/qryrEZ8z0jS4ii2vRbxHfpI=;
 b=jsqc/0VwaqwYyZIHnE7yVEZ2FkT+qbzpaKlg7b3syjFPjomWzY3sQGeSQUqxub4akaWtYC8yrd1FdN2xRGR0PuK8Bjq2h3OUVbaX98JSqcOnJowOorO7KJb2kSuQUE8Il9MBuser8GyCQAt1EGd/IVEQgKkxT9NOGHa8FtJXGvzVMwI0AqFKcFBp1jFyqNW4Ij3U5IrIlmmGm+DnP2INZuPgpry4z1TjI4tWJYeGdYyLwe4f2iC8Tr1oki8tShIOCCo7GLpMQrIfrsGWqywfWR+mx+L91Hy8yr5yZPEieTG9JrEHXJHooLDTeskksRGovWv/jN2Mlnn/PIgSvFKBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/O00YEwKmVuYvOevFM/qryrEZ8z0jS4ii2vRbxHfpI=;
 b=rFZnJmX5TfKIpR31t+83W+XK2RLo8G3qPIB349/jaZ//+dXpQ/Nw5FG5f5zx6qUmTmYkScsapUe9lBaaUdd6sf7+cvdSBw+pagG9QJxIjpxp6LOJTsTtN1LcaYLXBZ4bqf4MH14lU8bEa8zlBfGcKUclL2NnZkWdzcBEHivgkePqa0bnnhj/iJ6sbUObRzV6/LmLzZFnDGf5tTVKpkAzW2piFVWwdk5NSgytOT48v1cfT+Epk4IOdJ4Uaja2V9yASc+0RgFs+mEtoJXocQ51eJlT5HLbwBWICOg8yaXIqkY1sdfiBNrLfJRgt5SFuWQN9hJkHWZMQZmbtPrvT7dPHA==
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:32:43 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::f933:4f7d:1a1e:d7c4]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::f933:4f7d:1a1e:d7c4%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:32:43 +0000
From: Shivansh Vij <shivanshvij@outlook.com>
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Anshuman Khandual
	<anshuman.khandual@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
Thread-Topic: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
Thread-Index:
 AQHaki1WdjYIu4CfuECqPGqYndfIFbFvNzIAgAAKqq2AABZXAIAAcUwAgAALygCABbyNgIAArHZV
Date: Tue, 23 Apr 2024 19:32:43 +0000
Message-ID:
 <MW4PR12MB68755A569FE893DC72D86616B9112@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <24999e38-e4f7-4616-8eae-dfdeba327558@arm.com>
 <MW4PR12MB6875618342F088BE6F4ECBB2B90D2@MW4PR12MB6875.namprd12.prod.outlook.com>
 <c936083b-68b7-4d8f-a8fc-d188e646f390@redhat.com>
 <ZiKcNJ0Qw2awRwaa@linux.ibm.com>
 <ac4ffd88-2d13-4764-bb4e-18d0c4b9948d@redhat.com>
 <9e73ad2f-198c-4ab5-a462-2e238edd9b34@arm.com>
In-Reply-To: <9e73ad2f-198c-4ab5-a462-2e238edd9b34@arm.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [0992bPp7vLHsioFcpjUUgmruyfBF7DI1]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|SA1PR12MB8142:EE_
x-ms-office365-filtering-correlation-id: 51138879-6609-4900-18ec-08dc63cc2592
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VvY3/4rJK4xr5qYpnQqk9+PDktjmIqITlt8VY8rAkes23rQ9PdNxQcaExtaICXAlA92PYG36OOW8mhtWul9aZo6tXBBXgA1WlZiA0I0kFRHBM9xSlh1fJd29PhjYfysao6aSCAqdke67U6LJPmzJf5SM/l8ARf7Zo60YRfqgAKaX9fozdM9an/tntZybERaEc5RNp5PDoL42ACBqjruTogq8WYHL5d0mgtrq7lE1JWj5UMg2fpQzHH+V95S7tQHNFFZeHifl9qLCOkllSKJyTZ6Pcr1yIP3RYd7s9k3J19cvGCURzn6oM2Ou85DhRKuOG6sGVN5DO0idUsL9AHDSi3Qf8lFUsCke9W1dNR3TgRByGD93yZCPZ4csOZksf5LiS6DIbsr4nxRbtnuLFLdBQ2wrfUlHCUSijolV9Ld9dP6JOjybs1SX6G+27/+0UFfm717r9R4pnuP31SK68SBH+qaP73ZO+vnUan9awl1pVMiGAa2ppDI4OC7Yw5rwyRe54GEjOAiQOByK1d0Z74I6s0TMxGlI6AfgS27eaLZr9yvzvhVqXhEAGTwDP3z1vZ+Szw+pWOgYFOojabl8j/M/NJta8P3h8lnNSjGuZu+i99afxVMConB27s3MEEWC3JcMc5kjVPDG73H0KaKCK00uHX0LTScZb5gUulyeJm5KO9U=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3kkBN1wcjnc3yidbjG1PRKE+HpHuRUqKlUgcMMtcJ/h48oEkqpyEUXWmnH?=
 =?iso-8859-1?Q?aWYALZUBDMN6xjSXkUzDN1MjBhQWji/Ii5iNY4M4+/gPNqIcOFH2apDLPe?=
 =?iso-8859-1?Q?7poipBXTunMfjvrJkoj90krQ3z3wB3BpMsM5XbzcQqPYRSK3pq7SH9ox/u?=
 =?iso-8859-1?Q?5IYMpd4JeLAEFJ5aVty7TY+//ZRlagktXjojAW4KZuw63/VHdSlQXFBEvz?=
 =?iso-8859-1?Q?0XHWQmp49e0zW9wQCbKbBaExgOkefauSyJDz3SvFzMEtj0sdPsSo4zBVkE?=
 =?iso-8859-1?Q?gBfqjK8V3Y1RefC9Y9/qHrwXadHOy7z3wylOfwcm/HErci+WiZ3qPQn2A4?=
 =?iso-8859-1?Q?o6nlfgIwasQ/qfquHoGnf3O4Tvlcq0LKJRGygKxr+FiuIyngKBMIGzK0uf?=
 =?iso-8859-1?Q?+DQvapk2bnJHccw4/Zd11RPYJX2vMPONn9qN9uQ0X0qReZ0X9sIKJjfO90?=
 =?iso-8859-1?Q?nR9g4amJFe1eTA3g1UpAeoo29SBw/m1Fo4rR3o/sIwjrYH3OB+rtTaEHXi?=
 =?iso-8859-1?Q?orpWTVn4NWxw1fphs6cbnZbT/JndsGj6x8adIsQgX+zSKiWRev+ax1RXJw?=
 =?iso-8859-1?Q?lQZ0wiCDnv82gF/JlwS/dwzewkZa4G/QTagKBFKHOagHGS56s1OILNV0DY?=
 =?iso-8859-1?Q?5063JcyF9YaikZHyHAQv3KTg7XDYfYfVEouUcmdT6zG2IoSFSEXj5F3zR8?=
 =?iso-8859-1?Q?w7+hFefHKJTNsUyegvLJFqtaok9KhWb08bMBRwpiPRUhWNJaL2SbQDHoSw?=
 =?iso-8859-1?Q?kp9mIy2bJXoHkEhbAYyvkUT6r+noMZ82HHXeUKvmnItWQqOZQWFbkBbkjL?=
 =?iso-8859-1?Q?4LCM9U5EaXr/ffDTiELcpwn+8WNsAujEV9D1s9Ka40hN4MoMKaIVpRSMB1?=
 =?iso-8859-1?Q?pahU1+RJj63/zH6T0RJjEFvLgNZycJnsXK9kuE65oucS1CKXuU3/UJJR2T?=
 =?iso-8859-1?Q?qcTUYm/04iEtz1+W3CI9qtI4iPGa2y0iuHTJ+w+tDbQk3hUkSZl5BFCh6w?=
 =?iso-8859-1?Q?erN9wb7idY3sXJXDhZC9HnPhOTrXzlagV/jMgoNPOvULQtiiTY6XWdJf8G?=
 =?iso-8859-1?Q?m+HMVHwKNRdfkfErh9CLrT0jqsrf1WzkBO8EdQYsaMNPn7FuyHiKVfbiUj?=
 =?iso-8859-1?Q?aw7pm5gfEnfLMqChqka1UlfchK16uKGLV1qathFisToRVUj/KO4ILCJ3ln?=
 =?iso-8859-1?Q?9q5lBlXT3zqmMVkGbutj7nOrfrR7BUnY2svJxNVPAiajEq01gYE/52jxOH?=
 =?iso-8859-1?Q?k/yGYatOlenDix4+4YBSpI5HFXFsFBjeoX5X+tI7M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 51138879-6609-4900-18ec-08dc63cc2592
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 19:32:43.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142

Hey All,=0A=
=A0=0A=
>On 19/04/2024 18:12, David Hildenbrand wrote:=0A=
>> On 19.04.24 18:30, Mike Rapoport wrote:=0A=
>>> On Fri, Apr 19, 2024 at 11:45:14AM +0200, David Hildenbrand wrote:=0A=
>>>> On 19.04.24 10:33, Shivansh Vij wrote:=0A=
>>>>>> On 19/04/2024 08:43, Ryan Roberts wrote:=0A=
>>>>>>> Hi All,=0A=
>>>>>>>=0A=
>>>>>>> This series adds uffd write-protect and soft-dirty tracking support=
 for=0A=
>>>>>>> arm64. I=0A=
>>>>>>> consider the soft-dirty support (patches 3 and 4) as RFC - see rati=
onale=0A=
>>>>>>> below.=0A=
>>>>>>>=0A=
>>>>>>> That said, these are the last 2 SW bits and we may want to keep 1 b=
it in=0A=
>>>>>>> reserve=0A=
>>>>>>> for future use. soft-dirty is only used for CRIU to my knowledge, a=
nd it is=0A=
>>>>>>> thought that their use case could be solved with the more generic u=
ffd-wp. So=0A=
>>>>>>> unless somebody makes a clear case for the inclusion of soft-dirty=
=0A=
>>>>>>> support, we=0A=
>>>>>>> are probably better off dropping patches 3 and 4 and keeping bit 63=
 for=0A=
>>>>>>> future=0A=
>>>>>>> use. Although note that the most recent attempt to add soft-dirty f=
or=0A=
>>>>>>> arm64 was=0A=
>>>>>>> last month [1] so I'd like to give Shivansh Vij the opportunity to =
make the=0A=
>>>>>>> case.=0A=
>>>>>=0A=
>>>>> Appreciate the opportunity to provide input here.=0A=
>>>>>=0A=
>>>>> I picked option one (dirty tracking in arm) because it seems to be th=
e=0A=
>>>>> simplest way to move forward, whereas it would be a relatively heavy=
=0A=
>>>>> effort to add uffd-wp support to CRIU.=0A=
>>>>>=0A=
>>>>> =A0From a performance perspective I am also a little worried that uff=
d=0A=
>>>>> will be slower than just tracking the dirty bits asynchronously with=
=0A=
>>>>> sw dirty, but maybe that's not as much of a concern with the addition=
=0A=
>>>>> of uffd-wp async.=0A=
>>>>>=0A=
>>>>> With all this being said, I'll defer to the wisdom of the crowd about=
=0A=
>>>>> which approach makes more sense - after all, with this patch we shoul=
d=0A=
>>>>> get uffd-wp support on arm so at least there will be _a_ way forward=
=0A=
>>>>> for CRIU (albeit one requiring slightly more work).=0A=
>>>>=0A=
>>>> Ccing Mike and Peter. In 2017, Mike gave a presentation "Memory tracki=
ng for=0A=
>>>> iterative container migration"[1] at LPC=0A=
>>>>=0A=
>>>> Some key points are still true I think:=0A=
>>>> (1) More flexible and robust than soft-dirty=0A=
>>>> (2) May obsolete soft-dirty=0A=
>>>>=0A=
>>>> We further recently added a new UFFD_FEATURE_WP_ASYNC feature as part =
of=0A=
>>>> [2], because getting soft-dirty return reliable results in some cases =
turned=0A=
>>>> out rather hard to fix.=0A=
>=0A=
>But it sounds like the current soft-dirty semantic is sufficient for CRIU =
on=0A=
>other arches? If I understood correctly from my brief scan of the linked p=
ost,=0A=
>the problem is that soft-dirty can sometimes provide false-positives? So c=
ould=0A=
>result in uneccessary copy, but never lost data?=0A=
=0A=
This is how I've always understood it as well.=0A=
=0A=
>=0A=
>>>>>=0A=
>>>>> We might still have to optimize that approach for some very sparse la=
rge=0A=
>>>>> VMAs, but that should be solvable.=0A=
>>>>>=0A=
>>>> =A0 "The major defect of this approach of dirty tracking is we need to=
=0A=
>>>> =A0 populate the pgtables when tracking starts. Soft-dirty doesn't do =
it=0A=
>>>> =A0 like that. It's unwanted in the case where the range of memory to =
track=0A=
>>>> =A0 is huge and unpopulated (e.g., tracking updates on a 10G file with=
=0A=
>>>> =A0 mmap() on top, without having any page cache installed yet). One w=
ay to=0A=
>>>> =A0 improve this is to allow pte markers exist for larger than PTE lev=
el=0A=
>>>> =A0 for PMD+. That will not change the interface if to implemented, so=
 we=0A=
>>>> =A0 can leave that for later.")[3]=0A=
>>>>=0A=
>>>>=0A=
>>>> If we can avoid adding soft-dirty on arm64 that would be great. This w=
ill=0A=
>>>> require work on the CRIU side. One downside of uffd-wp is that it is=
=0A=
>>>> currently not as avilable on architectures as soft-dirty.=0A=
>>>=0A=
>>> Using uffd-wp instead of soft-dirty in CRIU will require quite some wor=
k on=0A=
>>> CRIU side and probably on the kernel side too.=0A=
>>>=0A=
>>> And as of now we'll anyway have to maintain soft-dirty because powerpc =
and=0A=
>>> s390 don't have uffd-wp.=0A=
>>>=0A=
>>> With UFFD_FEATURE_WP_ASYNC the concern that uffd-wp will be slower than=
=0A=
>>> soft-dirty probably doesn't exist, but we won't know for sure until=0A=
>>> somebody will try.=0A=
>>>=0A=
>>> But there were other limitations, the most prominent was checkpointing =
an=0A=
>>> application that uses uffd. If CRIU is to use uffd-wp for tracking of t=
he=0A=
>>> dirty pages, there should be some support for multiple uffd contexts fo=
r a=0A=
>>> VMA and that's surely a lot of work.=0A=
>>=0A=
>> Is it even already supported to checkpoint an application that is using =
uffd?=0A=
>> Hard to believe, what if the monitor is running in a completely differen=
t=0A=
>> process than the one being checkpointed?=0A=
>=0A=
>Shivansh, do you speak for CRIU? Are you able to comment on whether CRIU=
=0A=
>supports checkpointing an app that uses uffd?=0A=
=0A=
I do not speak for CRIU - I'm just a user (and hopefully a future contribut=
or), but not a maintainer or owner. I can however comment on whether CRIU s=
upports checkpointing an app that uses UFFD - it doesn't. Looking through b=
oth the implementation of CRIU (specifically how they restore memory [1]), =
and at recently filed Github issues [2], it's pretty clear that CRIU doesn'=
t support processes using UFFD - that they do not currently have plans to [=
3].=0A=
=0A=
[1] https://github.com/checkpoint-restore/criu/blob/criu-2.x-stable/criu/me=
m.c#L683=0A=
[2] https://github.com/checkpoint-restore/criu/issues/2021=0A=
[3] https://github.com/checkpoint-restore/criu/issues/2021#issuecomment-134=
6971967=0A=
=0A=
>>=0A=
>> Further ... isn't CRIU already using uffd in some cases? ...documentatio=
n=0A=
>> mentions [1] that it is used for "lazy (or post-copy) restore in CRIU". =
At least=0A=
>> if the documentation is correct and its actually implemented.=0A=
>>=0A=
>=0A=
>Shivansh, same question - do you know the current CRIU status/plans for us=
ing=0A=
>uffd-wp instead of soft-dirty? If CRIU doesn't currently implement it and =
has no=0A=
>current plans to, how can we guage interest in making a plan?=0A=
>=0A=
=0A=
While I cannot gauge whether the maintainers or main contributors of CRIU p=
lan on using uffd-wp instead of soft-dirty in the future, I can tell you th=
at there is no currently open issue to track that work, and whenever anyone=
 in the past has asked about ARM64 pre-dump support to CRIU (which is the f=
eature that uses soft-dirty/would use uffd-wp), they've always just said it=
's not supported - but that they do want the feature [4]. =0A=
=0A=
So in summary, they want the feature, but no one is working on implementing=
 it (either with soft-dirty or with uffd-wp). =0A=
=0A=
I doubt that CRIU would have any issues with adding the feature via soft-di=
rty (since, as shown in [4] they're interested in it), but as for using uff=
d-wp they definitely haven't shown any interest thus far. Based on the fact=
 that it would be a very significant amount of work and it would really onl=
y be for ARM64 support (which they're already fine without), I'd be very su=
rprised if they were interested in pursuing it.=0A=
=0A=
[4] https://github.com/checkpoint-restore/criu/issues/1859#issuecomment-197=
2674047=0A=
=0A=
>>=0A=
>>>=0A=
>>>> But I'll throw in another idea: do we really need soft-dirty and uffd-=
wp to=0A=
>>>> exist at the same time in the same process (or the VMA?). In theory, w=
e=0A=
>=0A=
>My instinct is that MUXing a PTE bit like this will lead to some subtle pr=
oblems=0A=
>that won't appear on arches that support either one or both of the feature=
s=0A=
>independently and unconditionally. Surely better to limit ourselves to eit=
her=0A=
>"arm64 will only support uffd-wp" or "arm64 will support both uffd-wp and=
=0A=
>soft-dirty". That way, we could move ahead with reviewing/merging the uffd=
-wp=0A=
>support asynchronously to deciding whether we want to support soft-dirty.=
=0A=
>=0A=
=0A=
My personal preference is having both approaches supported - especially in =
the context of CRIU since I doubt they'll be willing to rewrite all of the =
dumping and restore logic just for ARM64 support. =0A=

