Return-Path: <linux-kselftest+bounces-8413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B98AAA3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 10:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0FD285B1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 08:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32518DF59;
	Fri, 19 Apr 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Axt4peLv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2015.outbound.protection.outlook.com [40.92.42.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94F4C8A;
	Fri, 19 Apr 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515608; cv=fail; b=hwHDfboewY345s8gfnRHBQfiFBeF/VaCHvfbAGC5XDnqRUrJz6q/mcO3+CPImd9izNJ6S9Yafie0Gu+aHizxvGGrjcN5H50pKtXUD1CWwko7jcKfRmUKbGr0q1HgbWiJUU5MGVChBriWde00zB2rDmrnqqC0ts8fONF8+34nxfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515608; c=relaxed/simple;
	bh=9/yWMAlKbhCK7wX0dkVSjffyCRb1RRzV/+2IWYTsHc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4sVUmSQcT9I20YlhTfA2cGf2C4bVA1kQlk372kEqjpU7w+IJZZCLMcvntXgN1oGzOKwDHgVqchR/gHc5KU4ktm1iOPOPjJoqdYUh4G/iEHPHgw87/ceTrpFqV2zZX3Xq7n2gFMe0QZGRfXbzBnXqj2/2D6te3o89XaaZ6rZrtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Axt4peLv; arc=fail smtp.client-ip=40.92.42.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX4djUOg4RcVcZ9+AWxwXYFHCRp6LZ7QHdn2l42fkDMdaPKWU0PChpeFBTvmP4V/nYN/31YXJmnzFxZ3AzyVi8/9H+fBs0aEweEi0JcQGjnsKHMjSHPSnjlTKfLMN6qI6mJzrMDh/v4Q23SIVW0L/Qc4w9BoDAZvKdB078CNz8p5iNYWROckWFsCiUz13wts3WCF+fjcVUe1XIsiQVEtw/kjn0ZOrlhFZMGcF+Wkqtr451xOnWWHaQ/IUNsTPAhGmc//E/qxbUn7wLRmluX5X20pd5ohY1mcmnylZBu0L1pzXr/Z0LPwwBCg/cUxV8RWt2MrtIMhIxsn/XGh2y8eAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/yWMAlKbhCK7wX0dkVSjffyCRb1RRzV/+2IWYTsHc4=;
 b=lWWIzNRtbVmXaWD4KCplkdTQQlIQa03EOj0e+wdcXoES5+a2sVwA89Uq69ycC+yrOe9er0g5+Vrmjh9N4Gcn+WXjNhph2lHOFMt3qjmlR5R3Lz7745j435srcNVHRJMT4p5WOcCns3Jt+r/3uJHpXkbixwiZ5xUi8Ha/QtnhLs1xtu3pWrISPXHn2eUssspXtg1QbMMYH1mrdN7gMcoi/7m71OMwzSsRcrcJzlTrW3/MerkzZNTjkb5H4xkL+vocw1oL7sQCRpmYe+3a/Ntyie7OecxkFWiPiSSWl9d+9THxggHH2ynaDars11QXFpsia6/kF4OWXt1df1JE5HALpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/yWMAlKbhCK7wX0dkVSjffyCRb1RRzV/+2IWYTsHc4=;
 b=Axt4peLvqlucOf9ji1/OE3zC20MO3mESRBmYnvldgRGSYKIqDFlr9VsbEaFtRRHjyjrwxlVUCBMD5CR/hmusMc4eXtRnq7RM4kETCrub8GuY3AemYa4nMvnHhLTjCo4n2VY/xhguCiItkEOOncGQRgsQhgLHE0fy8BWty4U2eHkyimMHpJWVT5JRnUP3q/ix24QlA60rfiHn6u6v++Fa1znZmiMmAjzyWtEf0X6F0KK5XZflFmtb9VVHvaDVfS5Z1o+FIpjstB+5vZzpU0UDpvPUjn+Q8H5ZWsO265Vx5muu2ia7epTCDOxJ/HKAhtc21EQ1NIY6cMZnR0PndNSdZw==
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 08:33:24 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::f933:4f7d:1a1e:d7c4]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::f933:4f7d:1a1e:d7c4%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 08:33:23 +0000
From: Shivansh Vij <shivanshvij@outlook.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Joey Gouly
	<joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, David
 Hildenbrand <david@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
Thread-Topic: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
Thread-Index: AQHaki1WdjYIu4CfuECqPGqYndfIFbFvNzIAgAAKqq0=
Date: Fri, 19 Apr 2024 08:33:22 +0000
Message-ID:
 <MW4PR12MB6875618342F088BE6F4ECBB2B90D2@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <24999e38-e4f7-4616-8eae-dfdeba327558@arm.com>
In-Reply-To: <24999e38-e4f7-4616-8eae-dfdeba327558@arm.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [h0XkEBLu0XIa893tZci+kZDvrr4T3Siz]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|BL3PR12MB6619:EE_
x-ms-office365-filtering-correlation-id: c347403f-6cce-43b0-8e72-08dc604b5ffb
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WGfFW2mAECQ7QWdJmjz3Jk+ddBtuyF/mjegemgBWmORxoXrdAXc4QQ5EbrAfbTVcK1QG+ss1Jz0Y4TW1i+srDWeyMXCxK7wYGHK1SiK8f3IWURhYMY/rt9IST5z30Fs1Eq/i8MPBkpEXsJ9CzmKr5gBmS0DnXliT+hxBQjc2qVe584b0IQ5nalQbIpA8JDWfGNItk/1B6Sq35DaUHS+d29xiZyED3Zm6+JJ0SDmC4I18bwqw/nkQyXsJFeYMsEDc+uadkFtfcKAmJL/KPrRATcw0xbfstTLbDx1y/+Y4/iBOsuPOvLMQrzcXn6x9QLBEC8JWJ+Sb1uDdZY+4DPKa1Lnby6dqfSHqV0nszBj0+9M5ccD7kGcMVDItKssma+5WWema+7ScGxJ5Pd6fKF2uUeoboK2HBkA8JvF/Gv6VN2wf/mpnsgxqWp75O8umHqAMNLF8tgJ6FCk33ozid4JCm2V2yBJnjEbjDAQi845pNwEZRJjMnVrQiUjvzESyyROtSkI3LduLwOalI6IuzUmzq6pmSJzDfZHU5NJ0DtrWUHMVwcFFdxEDl5/mjZyGwedA
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rQCGhrB8V8Hg7mW7ldhuRxVunUALaNJY5zEaIaibuFb1ScLNVkDYB33YzZ?=
 =?iso-8859-1?Q?+im28LD3bYK+chApjn3dvUTsx2qplY+GmRyqdx9ZWNvbeKPcSpYUunOE71?=
 =?iso-8859-1?Q?BFahHrtwGyrpFDTxh+eA/2Ymw9AWBpxLUnF64IXBMthmR8NrisoDKZhksu?=
 =?iso-8859-1?Q?jsLJn57meRh6+IaCDDif8BihYOJ+OjWAMmDirq0IlGNeyFF7CFYDTnw/ci?=
 =?iso-8859-1?Q?1gH5mctNDmAdv8j+dKMqwKEzhZWQY+lfB3TpBNXGxjEELcg55KniQDTMDl?=
 =?iso-8859-1?Q?W6ctoQv5VDVbFbWmNGsgUIcRD7Retbtq1w31pyMThEA/HJUxfnpWyd702v?=
 =?iso-8859-1?Q?A7OnVtvO/e4dpa+4UUoz67pysnWM0en+bk61YbqqOCbRLOmu7PVZPzPRI/?=
 =?iso-8859-1?Q?qB4K2FXrM+5Ec7OxSMbyve7Muex5vWbV75JaSvu009S9jEvRusmzVika8H?=
 =?iso-8859-1?Q?unerHG2LG/2T8b4jxMgj7IATwpE9epPsMJYcymgN/9uhartDrjXMRK4Rli?=
 =?iso-8859-1?Q?JC1Wbx5PiCYM9AEX/F3tCyg1fLsLAvXlzJZwQvui+WcwBKqBwJTT7fst5J?=
 =?iso-8859-1?Q?b/i+4gvaGS7CSWTZmaNLEjf02eDn8vS3adJCeOgKt+YflRtGrNHM5pEJvv?=
 =?iso-8859-1?Q?adVjdFa+CXZyHSfLmJnULfRV287BH/QGXQljOctZ261I2uZXRZeR2UqMjd?=
 =?iso-8859-1?Q?L2Cvjq5DEj9clwtP73lVWICNAbWtNNF8yGf5sLs+7eWsi0WAEfID+SkmLT?=
 =?iso-8859-1?Q?aCpgyRCBmYUQwHLm3c4MAjPWrjlQhtXougV2PzttJEdHswdV6KNF2fqkEe?=
 =?iso-8859-1?Q?AFGR6tUr+vQ1AVeMWblnqbYkMk/6xwFaiF9B8yawQ/Wc12DPgU5q3wIC4V?=
 =?iso-8859-1?Q?SkfP3AghiJ2FzCZNWTD/QPl/cP6h3LezKVqJcJ/ImE5IstE6im5KcyFF8K?=
 =?iso-8859-1?Q?i51wR+kGyl6sMRGGcdJ2SPLUtiCkPOASjBYkj7EjZnNpiGKmw7+n86qTFf?=
 =?iso-8859-1?Q?5YYzMb/IuS7Qub05tgO3B6rkjgebNkLPP0D2iXDHcHVenccykSzsNaOJ/F?=
 =?iso-8859-1?Q?s4n9ISdPR/8UujrBrh5mrRUH76IqRT8R06jyGtCd6AYyZUn/KINm7/07BE?=
 =?iso-8859-1?Q?HpRQIsNUuKJBwJgqUtxzDITP6mi3B7qo5YftLqiNkLmVXk9iqVnzoQ41dj?=
 =?iso-8859-1?Q?2v1U6QbMWpPQ4+GY2KW8B/uod2ZXlD1vNaKUWeD1d+fYMGJS1oB/U6aSjr?=
 =?iso-8859-1?Q?qS1l/RtImIAUlorPfVTKa7lysxAY5rpdnkj6R+o/M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c347403f-6cce-43b0-8e72-08dc604b5ffb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 08:33:22.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619

(Sorry about the previous HTML email, accidentally used the wrong email cli=
ent) =0A=
=0A=
Hey All,=0A=
=0A=
>On 19/04/2024 08:43, Ryan Roberts wrote:=0A=
>> Hi All,=0A=
>>=0A=
>> This series adds uffd write-protect and soft-dirty tracking support for =
arm64. I=0A=
>> consider the soft-dirty support (patches 3 and 4) as RFC - see rationale=
 below.=0A=
>>=0A=
>> Previous attempts to add these features have failed because of a perceiv=
ed lack=0A=
>> of available PTE SW bits. However it actually turns out that there are 2=
=0A=
>> available but they are hidden. PTE_PROT_NONE was previously occupying a =
SW bit,=0A=
>> but it only applies when PTE_VALID is clear, so this is moved to overlay=
 PTE_UXN=0A=
>> in patch 1, freeing up the SW bit. Bit 63 is marked as "IGNORED" in the =
Arm ARM,=0A=
>> but it does not currently indicate "reserved for SW use" like it does fo=
r the=0A=
>> other SW bits. I've confirmed with the spec owner that this is an oversi=
ght; the=0A=
>> bit is intended to be reserved for SW use and the spec will clarify this=
 in a=0A=
>> future update.=0A=
>>=0A=
>> So we have our two bits; patch 2 enables uffd-wp, patch 3 enables soft-d=
irty and=0A=
>> patches 4 and 5 sort out the selftests so that the soft-dirty tests are =
compiled=0A=
>> for, and run on arm64.=0A=
>>=0A=
>> That said, these are the last 2 SW bits and we may want to keep 1 bit in=
 reserve=0A=
>> for future use. soft-dirty is only used for CRIU to my knowledge, and it=
 is=0A=
>> thought that their use case could be solved with the more generic uffd-w=
p. So=0A=
>> unless somebody makes a clear case for the inclusion of soft-dirty suppo=
rt, we=0A=
>> are probably better off dropping patches 3 and 4 and keeping bit 63 for =
future=0A=
>> use. Although note that the most recent attempt to add soft-dirty for ar=
m64 was=0A=
>> last month [1] so I'd like to give Shivansh Vij the opportunity to make =
the=0A=
>> case.=0A=
>=0A=
> Ugh, forgot to mention that this applies on top of v6.9-rc3, and all the =
uffd-wp=0A=
> and soft-dirty tests in the mm selftests suite run and pass. And no regre=
ssions=0A=
> are observed in any of the other selftests.=0A=
=0A=
Appreciate the opportunity to provide input here. =0A=
=0A=
I personally don't know of any applications other than CRIU that make heavy=
 use of soft-dirty, and my use case is specifically focused on adding live-=
migration support to CRIU on ARM. =0A=
=0A=
Cloud providers like AWS have pretty massive discounts for ARM-based spot i=
nstances (90% last time I checked), and having live-migration in CRIU would=
 allow more applications to take advantage of that.=0A=
=0A=
As Ryan mentioned, there are two ways to achieve this - add dirty tracking =
to ARM (Patch 3/4), or tear out the existing dirty tracking code in CRIU an=
d replace it with uffd-wp. =0A=
=0A=
I picked option one (dirty tracking in arm) because it seems to be the simp=
lest way to move forward, whereas it would be a relatively heavy effort to =
add uffd-wp support to CRIU. =0A=
=0A=
From a performance perspective I am also a little worried that uffd will be=
 slower than just tracking the dirty bits asynchronously with sw dirty, but=
 maybe that's not as much of a concern with the addition of uffd-wp async. =
=0A=
=0A=
With all this being said, I'll defer to the wisdom of the crowd about which=
 approach makes more sense - after all, with this patch we should get uffd-=
wp support on arm so at least there will be _a_ way forward for CRIU (albei=
t one requiring slightly more work). =0A=
=0A=
Thanks,=0A=
Shivansh=

