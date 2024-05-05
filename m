Return-Path: <linux-kselftest+bounces-9484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E9B8BC3D2
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 22:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC73EB21527
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F33763FD;
	Sun,  5 May 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ljDHhCt/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA1762D2;
	Sun,  5 May 2024 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714942682; cv=fail; b=EiW8M66ce5QsI/QqRgIRevo0AQGUYiI0D+xWGSQgGabD0UVVYGc0ZsbZ9mAN9S2QHTaUuMvCZaRzL4YW7VTAmH0yJHtmET6RXjpk768uyLdsga3H+BHhWfgyYeuIhXcppPuaaSEVNAbQyIG5qWm4aeyPgWvkSjXdHOmFP0U+D4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714942682; c=relaxed/simple;
	bh=qwLFyjcQb/7Oa+617wi+8mPBHq237ecKhl9bMMWeYxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KqsycnXkRQtaMghRBQCaAYQAecUvjK8KmWz8Ub3rV61F0hlIyg5PMJ4ocmhj7hz8kvKy+MwFuX2+pa+YbqJco1/xcfqIoT99ZLswWovka8OvtXTcFxxL0HjTVbNxApWJmv/ZslofIFVUMDUHak+SX3tQJuubbe86GO4NBl2462s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ljDHhCt/; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faiG/vvajdi8uP+M1QtE7/SHScie/FEkeQ5gNZi3re0aE642FhirmmeN0kEGKW56xEKOirBYHfwq1hFbXgPUoEIvo+/sC0RitLt+sEQHoGw6WVO/Mb0td8XLfoFuJivhT+REZ9f9qgJsW3NL/ubI2i+HNrGnp3QHYA2Ro78pHWiRoAfSC5yO1u3MpcNQq5zVvW5SMhts2jr/Ul/D6Isow8X09gPZuKb8JoM6G1MQePtaVsySp6S9tzQ/IxP9QNwtKzZsA1KCosnVMthdBWj1a92xRsZBuxknzurXx9Mb38Vd379yJdUY0Q//NLt2ENh2gi5/alYqVgiXQ6vnj2PEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54zZt3o4C0CXb3aD4hvd7Y+aNMuaPsYBw7s37jV6JZk=;
 b=EJ2WpVt+9MPHoNLZe4uqGH9mVWK/troqMQ7T3eLLagKhUtAx6lOqmFucPERI/DtMtDkKudCAujWn1XjSHg7DeGme62LRMcHdrbMmOajvJL6wzIseC2BAHppM78SmF0LAnFMReRlZM05GEzcEcX4D5XUeryiHXbaLBheIWoP7V7zmzjMrV0GvWlvTGqtDxc4F5y/tALeyaccysTcfoPHkOleLu1+ZDZyOAibFmFB7EphVkMBsjgUAbaFLvyUWX+QbX8F0KMBQwF7hVzzEiNUp9OnMyc5Jkp2YyiZ60eMy2PdQQSMdMEjABAecdrvoSBAZ7pws/ikqN1jklCl0NaF/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54zZt3o4C0CXb3aD4hvd7Y+aNMuaPsYBw7s37jV6JZk=;
 b=ljDHhCt/4NW7uWy6c6BfXU+x/ZJLlmr+oyFs1FYO/IL291o4cf8s/m+sVZyQcLOuxdKCILv2+PEIiYo8f4Kdc+n0y09xqvTGS7v2GyPX8T/rfRE6hBfFlGDyJwbP8YFzTy+KWCWHFsk42UKg+mWKpfDbnY8l3+hkFopdqgtWVLiHxrASD+/tT0mrKt9tU0ISF7k81DW1nTqdQvO4N64cqWgDDLHWR3nRH/4fo0UCIEBdShGftpGka+/ZJJKoefBCX7N4sMf6Nlp4npkxCh2KNiqzXuFCAXc7cKL+WqeE6E19KYiw80GC2W7dev1/OhrVp7VDltXvIHWsi6oAW4/wIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 20:57:57 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 20:57:57 +0000
Message-ID: <cf87f691-c2db-4a24-bf33-af26adffcafa@nvidia.com>
Date: Sun, 5 May 2024 13:57:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/alsa: fix a build warning: return a value in
 all cases
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 linux-sound@vger.kernel.org, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240504021330.33429-1-jhubbard@nvidia.com>
 <ZjedcAW6ITmo9pXp@finisterre.sirena.org.uk>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZjedcAW6ITmo9pXp@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e8170e-fde8-4e5c-74b0-08dc6d460a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGwzdUhRSVgyZkVpakRBN25NNFk0L3JRMjBoNkFRTDhyVWNiVjNPRDlCa1Fu?=
 =?utf-8?B?bE5scmU4WkpXQW9HQ3o1RFRCTWdvaVR5bHdTZUVTcXgyK09rQkVlT0x0emoy?=
 =?utf-8?B?N3drWE5RWFZWdTlZUjd4RFJJWWdiQURLdUhKMCttRVFydnEyMWRQamhZRURJ?=
 =?utf-8?B?YS9TUnZIb2hkZGQ2cTNoQmRHZTdSc2NEbXBzWjZyYkRZTXpjell1bC8zZTVB?=
 =?utf-8?B?cjVySWhYeXc0MGFuVGV5VnVRdUhXVGVwZHdRbmR6UU1yK0x1dXhSako2anJU?=
 =?utf-8?B?aUl3ODRQd0tjUzJhc3Z6L0RmclVIWGE1ZWg4eGRTbkRadTJTeVorSEliSjU2?=
 =?utf-8?B?Uk9EY1JOakY3dllJekdSYi9xKzgySHJUcVREaVA4dUtHV2RSU3hZUmJYd3pG?=
 =?utf-8?B?Nzd3anUxUGdpS2MzY1pUUUVNdDhMSGs1c004SkoxSHlYNEFkUlM0blp0TUJv?=
 =?utf-8?B?d0w4MS9wZURydnJEZnlyOXdZMkF0eHVwTWRlVVBOazdydXE5OTZONk9SQjlh?=
 =?utf-8?B?Y0V0NW5TMkpYUXZ6cFZQR25UcVIzK0gweXp5eHp4ZXRreTdhQlpyR292TUZ2?=
 =?utf-8?B?dzZPQWxqaitlelZ2bUF6VG11MVYzL3JOSjIwOVZENXM1c0h6dGZoYXcvZ0M2?=
 =?utf-8?B?QlF1MDFhR2NxZGtrZ2ovVGJhUFdtWG1uTFNtdXZWdkh4LzlRSlRmVERSTTcr?=
 =?utf-8?B?SGNHZkdtREVDTkVoU0Nkc0xPdEExcDBqNGRSaXhFSk9jMXZFdFZ2MmlKVVdD?=
 =?utf-8?B?MWFFVzVjcHc3N2xkR094R1BTWjZRbndRNUhXMU9qak41ZTU3SUxEZ0xhdlRQ?=
 =?utf-8?B?WWZTUGl2UkhoZnF1TVYvQVlpNU4wcllJV29uODZ6OE9ZNW15WUlnSk1ublI5?=
 =?utf-8?B?RUhYaDNiOFhuMkJ1SkRqcHIxT3pkcE9TRXVGdTJ2NXNQNWdlTDV0NFdKNnF6?=
 =?utf-8?B?TE5NTFd3akY3T3ZEOFdRYTZXQ0xWK2NFL2w0SXJpbHdjYWJjU1ZSVzJ2Mzly?=
 =?utf-8?B?bWZPV3JoR2w1aVZqaFJzdmVBWTFYV0lNK2lSWG92ckVyZCtBWS92OTVFNUF1?=
 =?utf-8?B?Z1N3aUR1aitGblhTNXBOb0RYcVphd0hOQmFkK29BTVlsaUpVV0tlNWZtbVI0?=
 =?utf-8?B?VlBscVJ3MWR2dzIwc1lwUTVPK1NOS2hkR1NPTXRiYzJQVTRYZERLbVhpbGw1?=
 =?utf-8?B?aDJVLzBmZ2J0SnJuR0FmMTVWMU8za244YlJCZXphVUo3K0lZNWU3ZHBtWDlk?=
 =?utf-8?B?aG44SjVKNEdmNkk2RTI1T3gvZEhtdmFkVVlJcVdHbXg1VW9ORGRQSVJlTXNa?=
 =?utf-8?B?ek5xL0xkKzVDL1pXZUNWRWxEcklGVDZVQ0pKb3Vjdk5EZUFiK2Q3QTNOWWxG?=
 =?utf-8?B?cXRrek5uQUNBSmFnaTdwdjJmK2hsbmdVU29MbC9CTU9sUG5rK2FVV2ZZcElF?=
 =?utf-8?B?em9nWndxMHZQRUUyYUpnb3p3QXFJaDBzUE9QWWZEaFF3N2VSVVRWemdVTkFM?=
 =?utf-8?B?by9TSFdLWnRXUFQ5Q2ZvY2xldzJVSEdKeFRJTm9lTm85aXpuRDY1dHhFT2Jp?=
 =?utf-8?B?Y0ErbWt6ZEZycjZ3Z2c4ZzhpV1MvL0VhYVVDVCsrRnJHL2g5cnpOa0tibHRi?=
 =?utf-8?B?b2NmSzdQYkN1NU1UVjZ3VUJHdkJUclZHeGhqMkd4OE9TR1Uva29uUUFBQllX?=
 =?utf-8?B?SG10VGRvOFRnM2U5ZGhmYS8zbCtDZS84S2Z3dWlYcGRPbWloTjQzM0NBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGdJWGJJZ2k3ak0wTkQ0UWFENzVmdEdoTHo3bmIwaUdUeEZ1dWZ6R1FlRnRW?=
 =?utf-8?B?WGJjUXFyMkMyS3NaZGVXYVdlazMxMThRT2hUOFF3NXVtTXJIc2wzMTZIR0ZT?=
 =?utf-8?B?cDBLT1RtYWFkRks3ZUJlOUM1eGxna1FWRk93cXdVUHNmR1l3c1Y5ZFllNm96?=
 =?utf-8?B?NjJLbDYrVi9rQUVoVW54cmRjTXVNVWZOQjlZcDZKSGsrV3NUOWJsTkNscTI4?=
 =?utf-8?B?UHBMb1FsQklJRThGRFJwNUFsVmlUN1VIbzhsK3piMnRCYnpNVUZROHl2czRi?=
 =?utf-8?B?cFNFaTRZUmZNbVZiVXFYVFZJMEJkV09uYzZlT0hyamQzRmFFalVjTG8rdHJq?=
 =?utf-8?B?LzB2TitYbHYzYWREM1Z4b3QvS1Z4VkU4RHVBN05IbDNHMlNpc0VpK1FRcmJw?=
 =?utf-8?B?Qnh1b1UrQTZwRGI2dzh2RDB5WDdpY0ZuTlJ6cTQrajRBYnNTeGo2VUZ6VFdK?=
 =?utf-8?B?RzdzemI2aEprYk1MamxuYXZrNStxQTVubWlrSlA1cXdjNGxEYy9HYlFWR3VN?=
 =?utf-8?B?bEhNbmhIUXFhbS9pNmh1UWVSVEtrK1JXTmtWVHFNQXpjWjNLSzU0WUUySjdl?=
 =?utf-8?B?L0xJbjNSSXBsc0FNZTMrT3VTaElNK3E4ZkxmdklzN2ZGQ0pUSFV2RStidEYy?=
 =?utf-8?B?Vk1peWlmL1RncVZHakdYT0hwSVZkMHR5Sk05L1BLUDlRWW1WWWcwdlp1aWdz?=
 =?utf-8?B?eXVPYVRBZ2xkdGRGL3d2dlVjYy9CdGtmRjBCMWlzMzJFNWh0eWtIMUM0Z1RR?=
 =?utf-8?B?cTljalN5SG9ROGF0ZHU4R3RmRjlNOVAvNng1UTFkNW53b2QwOHQ1K1lPL1lw?=
 =?utf-8?B?MSt0dU9CM3NOdFhMa2s4Ym5YNk82K0FjTTBaRFZKa3AxSHZRbzRVSUg2aUkv?=
 =?utf-8?B?UC9vQnJLaGNtdmUxS3UrZ09SNDI3ZzZRdjZ1RGc3T1ZWSkc2S3Z2L3lxVGQ2?=
 =?utf-8?B?ZWFtUUo0RENJSnhWQlBXbllOdFdmcUs3MHBEeFJjekswaW5MYUpkM3lhT1c0?=
 =?utf-8?B?Si9TVzFoL1dHVHpRc1hJVXJ4OUlnQy9ZUk5rQmtuL0hMb203aXlHY21IRk9P?=
 =?utf-8?B?RjlnMktOcWYzYVdjS2htTC9YUEZwWms3ek9VYlI1V0hWM0RWTU1rUjdmZm5a?=
 =?utf-8?B?WkJWNFBOWkZSbUFqamFJNjkwU0FuelNLNG1tak5ZcUwxQU5HQjJkdmVKKzV4?=
 =?utf-8?B?QkhZaE94N3c0RDE2YmZGN050L1p0VTFVampRaGRSSzAyMTZHRHFmbUpEdHhB?=
 =?utf-8?B?WXdLNlVyRllkWVNBOGRVOU9FQlcxcFNINjRuajMwbUJTV1ZyYkN1MWdicGZo?=
 =?utf-8?B?M3FiZzJmbFE4bGlzYy9GdExDZFN1ODNjMlI4VHA5RFc3NUthb0pJSkp6QjMv?=
 =?utf-8?B?MHA4WXE0SzNXVXdvd3pCZDJWZDdjNWV4d3N0c1ZjUEdkVklBcjUvVlNQRXJZ?=
 =?utf-8?B?ZS9XbU52cDl0QnRxbXNOWkkzYS9OSVpxK1FwY0xpYTl2SGdiYzRJSlVabjEx?=
 =?utf-8?B?QktnQUVPVkRzY0prZU5Yd0xjOG04SUcxcG9KMHJWVWVPVTM1RXpJeVRKdnFZ?=
 =?utf-8?B?bWc1MTZQcUpoSktZdUI0djFGckJERm1qQmJaOU8vOExuVTM3VkcxZnJuRFM0?=
 =?utf-8?B?ajdpa0lXU2Y4S1poL094akhybit2azdVVmsweFIxdFU3NXQ0Qm5HRGt2elNq?=
 =?utf-8?B?ckNWNE5PZXF3dmRnYkVvMlJqUjAxN29SS1NvOTNTZUZ6dE1yOG54VlFQTUd2?=
 =?utf-8?B?d0pmYnpoNXc3WFlvLzVUYUpQSlBlYi9CL05JRmRLTXF5VHRacmZ1S095RHhi?=
 =?utf-8?B?VjI2aGxPTGNmYlpHOHgxR0J4b1VkNHB0YkE4eHE2VXpyOXVqY1RBODdReVpR?=
 =?utf-8?B?VE0wY1REUExpUjN4ckdqYWFvTTJtbWI1ZHNHZFFZQnIzbUE3MEhPVzd4andI?=
 =?utf-8?B?YlkrZGlmdklOMnhLMWtuSEpUQXo1NWViQ0JjSmxnelJoZGJ2RU9vZHZCMlFo?=
 =?utf-8?B?Ky9YbXJreXRUNk5TbEJrcUpsby9kNS9rQlcwaW9XN1d0Ujl3SXZoeFRLOXhl?=
 =?utf-8?B?VThzVi9rMW4wcU1DRmxpYzcvb0dmZWVzWUs0Ymd6SlhNaTR3eDBKYkZXSXhO?=
 =?utf-8?B?RTNEdlZDZVpPSlgzeEVIM0VRTjJoemFoejFIL21FMlZ4ZHNlUzlUYkFUbDNY?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e8170e-fde8-4e5c-74b0-08dc6d460a9e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 20:57:57.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6V6pMa7FfcEAo5MiE+3wEjQv2sIUzBaDG4xHY4uQCgQ7XPZDpVRYZju1zCR68sMuRt6HHEyhWdL+YCttBDemtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

On 5/5/24 7:53 AM, Mark Brown wrote:
> On Fri, May 03, 2024 at 07:13:30PM -0700, John Hubbard wrote:
>> dump_config_tree() is declared to return an int, but the compiler cannot
>> prove that it always returns any value at all. This leads to a clang
>> warning, when building via:
> 
> Though given that the function isn't referenced we could also just
> delete it.

Even better, thanks for spotting that. I'll send a v2 to delete it.

thanks,
-- 
John Hubbard
NVIDIA


