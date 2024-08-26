Return-Path: <linux-kselftest+bounces-16286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C63E95F47F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62509B21151
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473E318FDB4;
	Mon, 26 Aug 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fuKm30YL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4F189511;
	Mon, 26 Aug 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684367; cv=fail; b=B7VKFFPEbq9x7TA6atefiNrgHjA4wPQ5DsleTuRhTzJEAy0Se+h/sQsZpMyMSIvSfMeXC7EJVGp/THg+OoHNmz0cKgoaCVmqdw+0+vjmyUbyJGE3tqDt3UuusAoQUssVyFXjfkINov3/77bQVlIg24NjpOl9elex56wG1zBnjKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684367; c=relaxed/simple;
	bh=z3NMseCPcOj/I2oW1Uw0AmxvyPtp3WYhjfXYeF0OS1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AeWa5XR//vbBpMwz2/WDBHMbz52ucWmHfUBsk0M7WvthUcaXxsK5BX04dSQX7xjVA6RpRq5uH9sobKfBSV5nldJwPkXfu45vm8DrtgBXpvXtFLugMOergl6IhRoZX9zvajPQco2HAHwIeQIVV/hcQwINDLhvCkR9daAu4JBvq5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fuKm30YL; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHkETRbzmpmBB+eH3Hg0Kg557USzKq9998qoZiGTKKKnhti6zHjhxDvWcVoK/Kat59LgnHyfDAIhAmJPmP57/7KhfVOfE++9kEhQwq4TEB2MoLZvDtv6FmIhhl1DPkEXfqQvF6h99cFNNG/2AlOQp4bZSUE4vrJcNwXUNn6W8KzdkMLuN+I6iQANPYbG5R/vtdTPcfN1zsnUbOqWExtityUaJZzqhJ2JpoUyVUqR50KcfJDH/CkeNfnGBlsVhfMJ44Gz4qDZFSSrIF1ihy4vKSJtxQv2mA5/sTUuAjGvmHzti71mZEPiHqM6wLZc++/pDou1UT/UcgsBDn2D3I+7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lQ0glN+HjxhyB6rE7OBZdFNCneXkH2pTfHcoiaBQFM=;
 b=q4Ew7T+AoLsaz9qvFmRVNycV8zllFG9e9wM44qkBqh/vcb50YF4vYoKg7tnhY5oGYi7qdt+SizpJVaYWv+X1HW+T6YnZZTxh+BwA3MEyzxQcdAZ/qEfKb8oROKb2M3OGhFrzDAuZ/6THUe/+Ki/VaQgDSVodZS0KO/SU+Pt2dKiUFm9GtSJMz6zysQP0lMv6v8R2dQVmRH8WudnpQzW7eYN+HUZADu98raLrKnJUdZBImYhNdlk3O6cmacxVTMYqcpA/Bnny2SaGoS8V3m63X63u5+BwrcBAQFHnWsbFlwipaeWocmI59yAZE0W8DFwu2wks1jhcizaeqYnOkuBrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lQ0glN+HjxhyB6rE7OBZdFNCneXkH2pTfHcoiaBQFM=;
 b=fuKm30YLz7ioizIRUbv3hPgJuf841Vc6SldiWXWxzK02mupXVn1vs+NRrQKM3Jyn69H7oPH9Z9WXoNQYeYKw5sdL8YfiKHXtAuJnY9a7hKvc5RfOl6SPQbtU9jYf5cuj2MNKZKLJwjpdLB0sxZZ9W1ozbI0esCw61LiorwHF1x+O90Ed6I4N1HLjReJdagIBDuZBb5WbmqnwEaZR6+je82tGxkMwup5pRkDvIe/qjqq0ooAPvZjb4Qq5coAzXQmq9JUjNi6UZrnWDsdh+GQ4TEzouBM1TqtRFOTCmtw2DLvaPAuzdNs4E8teiEzsPFwc9ibI+QyTkY9LEncW/pQ4gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 14:59:19 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 14:59:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org,
 gost.dev@samsung.com, linux-kselftest@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] selftests/mm: do not try to split below filesystem block
 size
Date: Mon, 26 Aug 2024 10:59:16 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <340DCD7C-8456-4F5B-B503-9DF5903C16DA@nvidia.com>
In-Reply-To: <20240826145344.33665-1-kernel@pankajraghav.com>
References: <20240826145344.33665-1-kernel@pankajraghav.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_50F9E9AD-A407-423F-9EB8-7EDCB43726E9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::35) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b20c17a-8588-43af-d757-08dcc5dfa9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SjjE9dRylQgH8fPWMsElGedZHyl6istH64twwzLYK2P+z/4sLAyE5bjtgcPx?=
 =?us-ascii?Q?b6JQtk8iO7uGnwvUADVwoJchTUIphiN4mKlnQi2EJ7WnNID69NsF9QLRpAGm?=
 =?us-ascii?Q?Vf8amAVWG1edAzlvod02mKVMv8hLnerAPD1z3TFYe91cZMf96VA9JD1KPQu7?=
 =?us-ascii?Q?TTbdyGrrFDKlcyysPkbF05nLhLqubNHGZ1ePS6rAQsyrtXQaEHmgmZ2vAU/s?=
 =?us-ascii?Q?id1xgTBfh+EUXTFExvVAyPq0URxrAEpOSvZI7WuD1PPsq2TAvpU448xpkLuv?=
 =?us-ascii?Q?20byyDZGZX1a0hzPANvOCySCFHgnlzzZjitHXBbZjYUSzo54gccl0Yi10kOg?=
 =?us-ascii?Q?lDmps7mcO/ALhgTkGNGVP1OyP4zvHGZvZxWGLSeVZo1FP4rVqOYMrx5gmg4V?=
 =?us-ascii?Q?xMdAxB/Y+8er3BUlZR7JVt4m/KMnRpuxTqgjgKi0mjJp7h5seI3UADceCssF?=
 =?us-ascii?Q?SJ+mXe0XaQDmTFuf7KOssYdAoh2klFHuHL7kIHYu2X2qbPO6AQ5vggAM0Cpq?=
 =?us-ascii?Q?GksvGaksvL89IeuFTCNrmsuHfLALzYwv36ClHfn/XbX6IcHla386pVYFOI6z?=
 =?us-ascii?Q?tHugFasutYcAyMm93Cpi+8ZIwktKjadrHGgJHcqxMnptgMI2dimPHloLFYCG?=
 =?us-ascii?Q?UUEtnMdMN7Wqjo0nMuSFWpZ+LPJ6Skq17rf4eIf0t/sVkDT9lJtu0QeaUtwX?=
 =?us-ascii?Q?Ef9x5ktjih9wYxLt2L1VXRPF2Bf7OEpJWa90kpE2NU/vFxNM8YpoI+8umnwI?=
 =?us-ascii?Q?wtQi2dxHx6itz4V7A8fLuZ8FERzKtV6VtDmGGojLhZN5WSRSJqjikW2JGKG7?=
 =?us-ascii?Q?RcZsOX3u+XpMqiaKympLTVxgMWbBkSsyrp4qeku5mTWvsFpz7mk5D99x+bZi?=
 =?us-ascii?Q?Pa/6wKJvasjxiPaTDbG2RffVPhy24P15CCikWOyoi6sbl4JClHuvIC6NBUkJ?=
 =?us-ascii?Q?E/YuVlBGt8kt6L7lQAI05PQk0fYB2FZRlNO8A7shiVLOjFk2iTdgVp+h7k/4?=
 =?us-ascii?Q?+YgzeGsECCWvki9wkx1FG/PDoB+PQJVcv2ud7/xNikEdGJMhhN83VOzGUeJI?=
 =?us-ascii?Q?OHMa04+nqMGfJ5y301eV7gZxuG7HHYTpftAX1KFIq5u+7bGtke8HVrG0LzUx?=
 =?us-ascii?Q?nD13EWS+nkxeZ6P9HH/AcpIKpQJF+48Rghm3L+iPKvsALFRzgqtu0QUM5Rms?=
 =?us-ascii?Q?MoVb+z/q9B0yhRMI/SxpHb0FFTEJ0tftoOQhtSBI5c17gFyxG6pp4LFUz5un?=
 =?us-ascii?Q?ODX8HP8AzyPdXRUR/8KnlPgM0pi+lfYuOrKLA13tMKPkkexWxHKQOXm7ueKy?=
 =?us-ascii?Q?oMsXv5iw5bhdz9GABTcXHdEiI0ZoxxXhhDw1xnY8Sf/YMQCcLMDiy02v97Q9?=
 =?us-ascii?Q?8y8AjRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W+FS+dXNJu1Tscgo3jgite5sUh6vqM6dqE9a8GhkP+W1g/NRoSEKnmJDCmkH?=
 =?us-ascii?Q?wON/c1QcBZBSipuyvCM+2TLjAzEvsfLXEshkDSCk8SG5Cguj/pFgWai84zWV?=
 =?us-ascii?Q?Pz6MuRnYgkp8eLDryRDOPnXWimpcTp8bGUm36CUGMpY2xGJvtZRXsFYHD5/6?=
 =?us-ascii?Q?bxBzNMjxtfasFDicfWMPW8oEQQN0+MHBHRB+NMySoLg60Ep92OBZPV+xfavj?=
 =?us-ascii?Q?0fLbl3wg/t+kRG/i7zL/uI46bzBM/xG3qcfkWRJdXIiR+X00uZpnNewfgzva?=
 =?us-ascii?Q?asyYSRUCK2fTdqyzrwDehASkWASIBdrcMIjs2m49KvJ1nDxOiblFmJ4B1XSQ?=
 =?us-ascii?Q?WRfmqww+E3VTCICso9DEL9NCXhl4lGsQ6r5v1T8y/6ppAIarkMGJMSMlzwha?=
 =?us-ascii?Q?H5RcUMjn21yHWSKinI3++yCppI3x+4AOzyPu4YLsCQucseLmFiCnL4xEJKPi?=
 =?us-ascii?Q?B19JGC+zI65jMfvoshMACR1fvcdX6xiuv6FT8AUPmxW9cCSu5OjK17rAMwc1?=
 =?us-ascii?Q?A/d8nytxVxOV1X1eX0Yde7/ct0i5bS00tinAL3u8h1HsCfqf5j19oB9mdY70?=
 =?us-ascii?Q?+YYi6kxPr5NBaMH6FNtOmISElQGq+7F8JB1SdaTDN4HfhsFvRFbRN4MwlsAI?=
 =?us-ascii?Q?pXKpW1gEa8YXHI/1fyLh1LbceysgGVp8px/MXxbCoAuaKPwSPxGeuHB3CblZ?=
 =?us-ascii?Q?RgEpoic5NRCSdkwLLDPOkY6I1WdWtVbrJ7oOvsD6ZxjFh+0cJJ93etgCxvoP?=
 =?us-ascii?Q?fDYXLzJnYnCs8GayBcMIzvE9SexwmU7H53O4M36VSxjcKD73uLi0Kj3pOziL?=
 =?us-ascii?Q?oNhf2stq1ByQXJmelAeQ4ETUpSYUuqHV/LlA3YCFzK/OUJMCteAZCSlAprnF?=
 =?us-ascii?Q?8mX8qrHXDfXvrU9tWApri6h6p6f0XURvsJoSdNdKF1VYjpocDTu0hRkZUP4y?=
 =?us-ascii?Q?UZ5Dmuo7MpezyWcHMwWrS8W7weBdl8isXUjytCcJ0qx5MuIfbat91jyMSvq+?=
 =?us-ascii?Q?4XxGjVnSKb9pFLSpECuWk502fejGN7+x+xXVDGZoS89wTODTtI44IL9TsQYw?=
 =?us-ascii?Q?Wc1vzraPDnKRnM7apDniYQ9uXz4VuUFg/oFtVIdqLNP8iXybVjIar5effhA/?=
 =?us-ascii?Q?/gRb+C9Lw/jyf7LtBuA/a8IAScjwV0ESRcohOgqfpya8qeeSOqHqpjNO4PDR?=
 =?us-ascii?Q?79Da3GR2sYlhgjhOUVz3WD63pqZl0ATVMS/q2/AOqtngVi6toXfYogVXHaOq?=
 =?us-ascii?Q?2h2+/6T/ap3qfBkr4C+2qQI+Z5/D0awrh/fSPQ6TcE1uqGtPs6jhCjghuz4s?=
 =?us-ascii?Q?UpQTPH9kX+/QimizGtaVj/zD/RlWCxMRxEv1yRJyDa4I17f8LSxNBLz10q6P?=
 =?us-ascii?Q?ievmKPIwkVBnJK7xKGSDV9BJmhxpizMDg2tpTG5jw1kkmntOiDCmYj9oZIl5?=
 =?us-ascii?Q?sifh3SnOcK+FBlJpu/EPpHSZTuKHUd+g9Hn+doNG3RQtFKeZanfddJq1Ubp1?=
 =?us-ascii?Q?JPQRlzX9arZ5eypSipE3P2/N6IjeKfH0Y/2jEDS7J8/Ra6ajYBSgErtRki9b?=
 =?us-ascii?Q?HaZzuCDfoYkBLXtO8oc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b20c17a-8588-43af-d757-08dcc5dfa9cb
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:59:19.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKcw2fjujpPEBexQfV5iVzpa7W4y4JfwhETnYK/qsnZq5tv5t+ch7XzxHsWscefl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

--=_MailMate_50F9E9AD-A407-423F-9EB8-7EDCB43726E9_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Aug 2024, at 10:53, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> There is no point trying to split pagecache thp below the blocksize of
> the filesystem as that is the minimum order that pagecache needs to
> maintain to support blocksizes greater than pagesize [1].

But the purpose of the tests is to make sure all cases are properly handl=
ed,
right? If we do not test splitting pagecache large folio below the
block size, we will never know if a kernel change breaks the handling.

Just my two cents.

>
> Set the lower limit for the splitting order to be the fs blocksize
> order.
>
> As the number of tests will now depend on the minimum splitting order,
> move the file preparation before calling ksft_set_plan().
>
> [1] https://lore.kernel.org/linux-fsdevel/20240822135018.1931258-1-kern=
el@pankajraghav.com/
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  .../selftests/mm/split_huge_page_test.c       | 19 +++++++++++++------=

>  1 file changed, 13 insertions(+), 6 deletions(-)


--
Best Regards,
Yan, Zi

--=_MailMate_50F9E9AD-A407-423F-9EB8-7EDCB43726E9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmbMmEUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUDQEP/1Xp+pKxzklw8OHsd6P8gY+uHaSQfYIKmlIB
/TyfAzG9kKBu+6lFytIStOPuFiY/8ZR2Nv5B3HcXVYEJ9Y95rLsSg1o5Wx0t5gjE
dTMIrZmZxhIR0fQS31w2SIHKMcdkmpkx/Gf5Es58Ka7JnuM/7VDG1iaxR9N9MFfa
QN3lSmUvsc3aMuKsRlmQ1vDoR6v0he75Pct0DMuU5O7zfmmRCJlKOXPBSnmixCdw
+RxAhjfLrhCn7Gb+kZg0u0C0TtUgCXddRwA9h7CUIQ/TkPHuHxAp9TBttL1rSFbq
qQX9epuZ7thRiMxyqUcMuPDAPegzw7w0pq6Xmu4zctvxtmW81cDyE3uz95nEpqEj
g9tBLAeMo4qsdXZsLQxCzTaHfxUrx6MRwfDDpQ7V+JQtZMMptcMVYj+jTdqiLtNj
EyUCBW5WP1rQe2EZui/6zyBr9Qoh0NeGioBpZ8gDGvfZd6R+FMyjVOeUFdXWyatr
LA3nRMmJlAJU9128epleP+k+rh66NEDAKj2wNgEnki860ivtZald5HmbaB42Le6g
SMB6eIiBjvkBGEd1cb1ORTztM5fbjm9G2EdUZiv2kBy3GrDvzieIOgL9O2tMKoNV
toAC7YPAoi0raEa1F3qYNOi1lLD4JQutU8rfKrh5jwVZf+ityJsdveSLCvGPRhaw
KHt5EEyX
=mSor
-----END PGP SIGNATURE-----

--=_MailMate_50F9E9AD-A407-423F-9EB8-7EDCB43726E9_=--

