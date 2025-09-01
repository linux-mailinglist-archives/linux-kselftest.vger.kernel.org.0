Return-Path: <linux-kselftest+bounces-40490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFCB3ECE4
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 19:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C6B4828DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2042DF142;
	Mon,  1 Sep 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="khWdzjmF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E281323B0
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746272; cv=fail; b=W2pnQkYgLBDzTBWQFBONU8LNFIRaxCeJD3L9773kxj/3mUJfjRkf2yhtVwj4rufiQ7gE14SYqeAOSkezdv2dk26dRdLr+jEnkj2uNL6gNPYRj6DZW64dzJBzhyL031jfgqwbMTq0Jx8L+TuPdg2H9u3MZmjgp9PMMCVY41A+H68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746272; c=relaxed/simple;
	bh=f3UeI0tJkMRxiSozVGCyolaftTWW70pT8KWrgBFeHXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=daps4vOTro58ni18lYW/8paysdKtRea/nS8qyHqhRxXvCyb9gpldzoeTDHgprAKmOTJ+dcwzhgZyFtzbW6+emgmuca+uydNHtRAWLDNecHJHJA3aL8IDvIBGipTtzpanv7hA7fSmihOMqk9AXABFZFi0hSn7bSIercW5+Nc93mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=khWdzjmF; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pse1Vv7DagOWXEK2FusO0QJO8zpKcXqWZNLeQip28+x/JyoYtZ8y35Sb54G8BE/Ekg3GrLVGKfI7sjuhaH1oHbyuj69a1c6PHKaYp85gaUowSSpbLFyaQituzuH9z2gS6tzrSYMivuYCtrn8xnNo06zea+bFX9y8JPbt3EQ32NzNXfAmnDWW7Spg5xR4HUSOKv4nerN8PPD40A4NeYSI7t7XispX/wQBs4uFQOjtO9vqHxvyk8x/UM0TrOwxAqvpttEimQTD6UEtSzAv2gCAC5hLWjbqsW9TDaJMx970t+gQdEHmMrcBVrEtTk7vA5Ebb5uWRfDYcT2DwwSPr1M8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Tqcybgn631pMFTo7HnJK5lSXauNfPxAqNbRocBuaQA=;
 b=EXZYAVDt+B9UrqWCfOrlIMd16WYLZgVDDf+t5G+HDKRpudEdoS+HGa/YG2R7CuzfM8GQmQMc/TKiwD8V2kdxN/BxQ60VmgqtFWInDj5cVp0H4bU315GwCta5+d2ABhhOZXsIztw/CjtqPr0VN0KckFNe7FnEPzWlyofr2vXuF0tk/9pq7xEtN2FkKu+bo11Y0tjMFdzdC+5YA6ERNOxcLqHbbBRK7yMQ3e6a+77Rs3eCn9M7X9VObphzynwDybNm/zOBmNG6YvbsYir0UMSulpoNWO0RJcHNniAA/qyXQBL9QopS2GI9Ft4nqwTsf63I8kF00ceR4mjov11pzgWrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Tqcybgn631pMFTo7HnJK5lSXauNfPxAqNbRocBuaQA=;
 b=khWdzjmFb9f0VkPM1GSQnJdsSEXCym2vChJ9ekXo5ZHJIk8FH4Huzk4gtnN/QvxvxYXpHrYuwoDHCBq4CDR7AN3nF1VzVQHA9mvvwpXVwGubrjdAwbpkZ5u6Xwt8RqHzqRwosPnwg0zo6vEso5HtUdInzXQvHlV6+1Hg7I/Bd6+noEPS6cjHDvUFvASpHEj38IalMI26vziDZSPpZToDc8dP5Y/hVBUMJWzHjveXI1jotyLC+cb4teExxC0/Jej7cdrWwpvZ5hjrRa+QP0N3RyX4B0EblWEpNrLkumSsYovgtNl++kEmQ/0dc5Tr6a5fMPVSff4M/+OBUqvaVqy1Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Mon, 1 Sep 2025 17:04:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 17:04:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
Date: Mon, 01 Sep 2025 13:04:23 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
In-Reply-To: <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS2PR12MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: b5093016-7174-425e-d995-08dde9799a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o2X6UJQTNXFZenMsgw9wle3flxxiXfdBRSodsqVIvGs3nxWshedXjiPP/zgm?=
 =?us-ascii?Q?zPea133O9k37cQZcvDbnytkDwaoW+Fzq+BS26WWmku9bHCnz1q4E8RO+7GiB?=
 =?us-ascii?Q?3ozpQW7QG6w35RJjh5WtKhk5ykux45dzzoe6yHgrmr0Izl3bqc70BlAB3Koy?=
 =?us-ascii?Q?7wT/He5rm80fYtJ+Zbb9B6GfcBxqU3y1XKgWT+5TCCgUpG1AoHeEfwJsscPA?=
 =?us-ascii?Q?07Lykx9eiBNDQJD2e0xnKFssYc2JfhNox0+zEYuU1XW26lLQpTp8XuyImQWa?=
 =?us-ascii?Q?SgqJ/6VcLmjXsaXYwd11mfllSXOfxjQlgZsxIy9IUCgwp7j1JdbnCRI4zlNJ?=
 =?us-ascii?Q?8YhZNuCwZ6jGw2qI2Q46nRxZYhnPlrJMOwzDm4qJ8C4aBpsXBS5BgY/QmsbJ?=
 =?us-ascii?Q?sAiJ1J8SF1Hmxm+YSbOTJx834XRBpkdocmjahbFrgzVnrS9PGgNQ1CRJKd3q?=
 =?us-ascii?Q?WbqFbkR9kleKQUEbJbl9BCz3B3K9xa82PMRxkLlNvnyvzFmKKjhIzfeTqEpt?=
 =?us-ascii?Q?aaZOxb+fUeFkQKM7SySq/PGvt6oO9pQfSAdrtP6+bzcMiA9DVi/PnzVf/r+G?=
 =?us-ascii?Q?tvtldZ77o1plODjvUDzeGTMpjx0n1cTF0KqpxNYjeMRPWFqK61FWDtn09lnM?=
 =?us-ascii?Q?EnqZeUBC8b4EfSQVNcnHMDon9qWxYxSqLpMW1xMEeUQ5NltgChxcg9ekcMjh?=
 =?us-ascii?Q?OXS06HqRPo27/5oxKo+7LkeQPQRJ+qpdhGAaw4LlB9CmTjtnm0DkqPvwFTBc?=
 =?us-ascii?Q?0ZTmiO8U4OxaYXiDgyb4NgfG5LIMRvoohJazRPE26uw0eIs4bsl6z3dyd/th?=
 =?us-ascii?Q?DNu7fdnf9J17OPk2zzmDpyg8wqLStPgi+Id1G1UaLdXIUp2fqKy173kd6G3N?=
 =?us-ascii?Q?vq5e6l4/rEaX4LcHdbF3M4ElI3YINQIX/eQ8yPgsRnsxXBCw1Va6e4LtI7ap?=
 =?us-ascii?Q?6URPfKnt4VqBqn8ovzE3C9b6Fxc+rHPpzSkbBaUv/FAwKUrpDoao66AE+jOd?=
 =?us-ascii?Q?eP2NS0sUm+rAQQAo7PteUUTjBg/vbaotgHy3oR04CS3Rt+OuItXEl6IXdxIO?=
 =?us-ascii?Q?qQVDsmdjbb+iG3BNsZxc1sKUYALUGIBjmPWezjPn9iNiQJL9dqZ+qSC0sYSB?=
 =?us-ascii?Q?v9+M5VQl0sHQjRXjcdx7fsFupk0bgNe+wmcqEPSdhLE20kj3uRDqsA0XSOuR?=
 =?us-ascii?Q?laYfAWMN75mwZ8KoGaAzJ70r/3tcc3hoUWpfir9tfbE8dIQfn9c9oKoBCHBZ?=
 =?us-ascii?Q?y8ElZNTFFomiq2I7aPjY2w8DNql3yw1JaoWe7zaxDi6ErUUfxRqJtIL74PuQ?=
 =?us-ascii?Q?6t0eQqcTXupq6gMLre3ov9bM58r9YuEluaJRDAX4yWAAhY86K213i6E3zqQi?=
 =?us-ascii?Q?IHqbhszfAMA0WnhuIDc7ZcrTgPT/MBNsQYX8d3Eg9cIGCgzlh0n42gbx34kK?=
 =?us-ascii?Q?FsIB3UszeVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9b6k1GBIp1f9uO3vuZLCiPLnHCP97spTINCGc7DZm5OVRgvPT36OlqYKOwBk?=
 =?us-ascii?Q?YWPaYen7cTCkKKZ7/zA8HNvst2J3dTZ3HRejWSdoku8+NtJnwfwwPhqLYVO3?=
 =?us-ascii?Q?nnCaIv+g8+8/vnru7FxjGNsq0SkdcUUNywi9plE/USPlvkIImCfpgDfgBG92?=
 =?us-ascii?Q?wEuCjXcl5+ysWWtKdeJRWGcLuxg9LZPUsYvy/fWs+wh2Qf3BmZUYh1+/st/5?=
 =?us-ascii?Q?xzNBveLZN1irpiJOiMue7H2x2gCF/oqo+FgdgjFa4i3LvcIsO6keMt34gNmz?=
 =?us-ascii?Q?T5y3dareuiOErPc6dyDjyaSTe3F9NBJr+5FEtpFFNN18AMEqT+C6PoiYIvBI?=
 =?us-ascii?Q?jDxqukwZWYhyzabXCqXuRh+Va9ItotlU+Aonz/QeUDPqy/vrHOWz07RF6FMI?=
 =?us-ascii?Q?izPPJ1SAQEDLuFfX5nkYHAg9KOfU6X0hZcPxtXWXGpOcGOeilAkPDw8UTkpJ?=
 =?us-ascii?Q?fQ/K/eHwL4w12qEAriPY/RvluW4A69QRhXBwjKI2sKQXrxRvogWhjglOt2+N?=
 =?us-ascii?Q?Zyay5sjP29GgllwmLHfNem+LeItGTaqWUiMN0juMOn3F8jAELL8gXXS6KXoq?=
 =?us-ascii?Q?G2DjG8daH0bdYViHYUV186hYiz98fQHMK9CU3xYa65Z86fvVFGSOOqrBPEHi?=
 =?us-ascii?Q?fhJgGXpcIT5HAFNVmih9nb2AHXFRWSURKK03PPq4v/cRQR99nVTWKSrlIbf+?=
 =?us-ascii?Q?ZwZhdt36/DCOPOaVKKxk5807xumyT4i/eHvSAleF57NdHp7w6JTOEKzeCjkk?=
 =?us-ascii?Q?rZ/SzLOcvdns+brJWiRaUEbJTqEsuk4VDz9GeiLgJKeQdRgkDmASiovFSNLc?=
 =?us-ascii?Q?ureXILk7eYxI8h0xMdAHpdl12ppRFdjeshycdjj5hc1PY21q5SfMmEXOeOYR?=
 =?us-ascii?Q?6oqWTX1LqkPe9gX4gsAwLEs4IyJAXV/2mvlu0KVU6RUoHuZjYytjohCfrVu3?=
 =?us-ascii?Q?9Cqa1T8H7qVApgchSPDOUE+NYs5c3Kgx1Zq9OdekggDc29eCglDg07CSR9wN?=
 =?us-ascii?Q?L5NVn1dedcdrmQRPUnPYQa5hR72G2hhmKmXenP1RNZioNq3ji2e5j1vNrucB?=
 =?us-ascii?Q?mLq6RNYwSWzNSHSgj2RCIDV1qJfxJU0GiT7EHTKGpc3YYJwDTBTMrAtx28yz?=
 =?us-ascii?Q?AM0xch9t4czidI+McIQ/iaXfjE8tj72eK911RSCpl4kdX5XU3EWMKnFxXpEZ?=
 =?us-ascii?Q?bvg5ee8UZSoFpUmgKn/p/2qkDpkvs4esvGJgMxOGfQHa5jIeeG4TVeHNsI8W?=
 =?us-ascii?Q?qsU+hxRZngN+qgCfMNfhtSNfI0Eszb7C2jZb+jdOydpLHhQ2c1PseRcc/7yM?=
 =?us-ascii?Q?spNj/VUW28E4Q/nyiNW3AH+LMgMiZBNbcPdR8PACT7C30Om2lTaUjnNrO/iX?=
 =?us-ascii?Q?Xkp16KmZGZTzXBJ5Nzk+Namautj2etEzU5KaS2sh389dnV4MJTMh67DH4iPj?=
 =?us-ascii?Q?KZL1jDxADiZ89Dpe77WCnN+UP4lRPzPFSp4yz87y80mRgSL5VCcQsAG+0nQI?=
 =?us-ascii?Q?u1iZ7KzK3GJhAno8XeU4JC2NbTFOW5uZ0ROIpF6Z8IeAewrgNbPXwYjh/cPz?=
 =?us-ascii?Q?8JkNPp8f0rWPNNSkqpOqXoUFV2xxz40xvaqdabat?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5093016-7174-425e-d995-08dde9799a7a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 17:04:24.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7vvEQIpT3cOGl8n8CnslGEhlc7aGbo6E0BT0uMMQmhsrySZRESKCH+rbZm1rvLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9712

On 1 Sep 2025, at 9:03, David Hildenbrand wrote:

> On 01.09.25 14:56, Zi Yan wrote:
>> On 1 Sep 2025, at 3:22, David Hildenbrand wrote:
>>
>>> On 31.08.25 04:27, Wei Yang wrote:
>>>
>>> Subject: "selftests/mm: verify page content after remapping PMD throu=
gh PTEs"
>>>
>>>> After mremap(), add a check on content to see whether mremap corrupt=

>>>> data.
>>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>
>>>> ---
>>>> v2: add check on content instead of just test backed folio
>>>
>>> I'm confused, don't we have that exact check later in the function?
>>>
>>> Your v1 might have been better, unless I am missing something.
>>>
>>>> ---
>>>>    tools/testing/selftests/mm/split_huge_page_test.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/too=
ls/testing/selftests/mm/split_huge_page_test.c
>>>> index 10ae65ea032f..229b6dcabece 100644
>>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>>> @@ -423,10 +423,14 @@ static void split_pte_mapped_thp(void)
>>>>     	/* smap does not show THPs after mremap, use kpageflags instead=
 */
>>>>    	thp_size =3D 0;
>>>> -	for (i =3D 0; i < pagesize * 4; i++)
>>>> +	for (i =3D 0; i < pagesize * 4; i++) {
>>>> +		if (pte_mapped[i] !=3D (char)i)
>>>> +			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>>>> +
>>>>    		if (i % pagesize =3D=3D 0 &&
>>>>    		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, k=
pageflags_fd))
>>>>    			thp_size++;
>>>> +	}
>>>>     	if (thp_size !=3D 4)
>>>>    		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
>>>
>>> I'm a bit confused with this test in general.
>>>
>>> We do a
>>>
>>> pte_mapped =3D mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
>>>
>>> which I read as a "NOP".
>>>
>>> Questions
>>>
>>> (a) Will this actually do anything? Also, maybe it does now, but can'=
t the kernel just optimize that out in the future?
>>
>> It remaps each subpage of 4 PMD THPs into a contiguous 2MB vaddr range=
 and
>> perform split on that range.
>
> I'm afraid I am missing the "why".
>
> I would have thought that a "split_pte_mapped_thp" test would want to p=
te-map THPs
> to the see if they can be split.
>
> Why is the mremap required? IOW, what exactly is the test trying to tes=
t that
> exceeds "split_pte_mapped_thp" ?

IMHO, it is an interesting test case for splitting a THP when only a subp=
age
is mapped into a vaddr range and in a contiguous vaddr each page comes fr=
om
different THPs. The mprotect test case you are mentioning would still hav=
e all
subpages mapped by contiguous vaddrs.

But if you think both are just testing PTE-mapped THPs, feel free to repl=
ace the
existing one with the mprotect test case. In addition, is_backed_by_folio=
()
can be reverted back to its prior version, since it no longer needs to ha=
ndle
the case where subpages from different THPs can be mapped into a vaddr ra=
nge.


--
Best Regards,
Yan, Zi

