Return-Path: <linux-kselftest+bounces-35110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2D3ADB6C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8241017349F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21572286421;
	Mon, 16 Jun 2025 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyzKuB0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965562BEFF4;
	Mon, 16 Jun 2025 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091139; cv=fail; b=m6H3wPZ/Ec5rdzNCLnUNZTYPimm1Pdo6rD1VRlIf6SSud0F3cHl10kOtKUvFAE1k4gvXrQYjoB+TNVC/+DaHI5DERqkyKkfD0eeoSrFi4Tj20JQIQltKVOl5wz4+f7rkgnIXAU1UFZJY1QE/gXXZmkpUo3afuqUdCXu097iJVsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091139; c=relaxed/simple;
	bh=PMeBlFohotXRWhelz7sI7CzyqGH7VE+YsmIku43H+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YM8CU36vXo2LdYJ1aoHtiL3QzLT1OiMo9BvMT8qVyNJnY+16Hg3uc0IpMG9nlI/C/MWUWRoypfhEYx3bg/5y82vDWXjnqrgn2Nw3mzxTee7prhCmfGICEvg689xX0QABdpHinHdyRsMdjPAWDVepGRLX63ZtBv1VtyJ3u/Thu/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyzKuB0O; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ltwk3QQRtlO+sWX3O9ohp8qNTmSgafOX4rUXLR/0I1iBe+Yi0VJ8Mtyp+hKbwRGO4WdijHrEBQqUoo0iOzd6mrVIG5hGIhDoSc9fhIYGLnzpv8pdIgMo04Ptq0YGkMDkUyX11JvW5l0wzQHdLL2rgYx7/gfkImaiDjc6bkjpoWG3aRYWkVWvy7il55cMLoh3au6/bJ6j46Z97NQEy36mzBBgOxyprhds/ZRdjRElaIo70KiaGbRHX+u5SDu0F638I3Alu3wL/cM1qIclrVE/TZCh3QWnlaDDi7QbC4FiqLtW0nbFXSk8GWWSkeBap4JcuJXIOIxO19YvnnA31Owf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/isgMVh4QIiJbiTBBybd0MML6du5Z/3kW3BjS9xsqQ=;
 b=U85TNzsdKepWTf9hdhotjiwXU7UTCx3E+OBn8GosTNRBdUzr1j4XUcyMhNyfISg78kK50dWzIo6/I1eXNQ/wVIDSv1pw1HmUYBdSVoTFVbAk6OVPJxT3rd/fKN4drrQh7yezgPKOZ4OPRu9OorDHC49rIgk7uiA/iKUtVmrHP0hD9GreqHx4CQnNI72J48sBDwlo1aNMAYYsKbyjixYYRle7u+Ew622S9no9s52aQzhwmimVCda6vCZzsASyFExTq3giUuFuUYUpWpcSljjCzVYxwc0wcEkec6yf1kzzVLZPvrxGAp5IKCj4SfH4J+fVbhverYBTgg9dqXQN9uGXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/isgMVh4QIiJbiTBBybd0MML6du5Z/3kW3BjS9xsqQ=;
 b=fyzKuB0OzUGOMF1FWGW8t5zTPSte++HCbhhfkN6a83Y54nEcRaaSMaO/+FrDSJnheV5nFzTV73gqlki3xvzHlCDxPZ+yGkgf3kvm2H9gLF1/S2qkwuZFpQQIvsFdPClw93jMFgMyESuZEXQO2OAnu6guCQXenmfMGVWq6HSukW3EMB+/qWZ0KDCHQOipAd8Ql2kBprD/48IJbGkcbULwzSU5N6bzCM8DR4JtfaIkwVba3XB/lUf8w0x2g/5XIJarpPW6NygulPZ9+HPYo7K7pes/8yhT9yePQxdlwN3z7c8HjWIIgNoTR7FF414B7zxIYC/AQRb37yGKlTYG9sFXHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Mon, 16 Jun 2025 16:25:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 16:25:33 +0000
Date: Mon, 16 Jun 2025 13:25:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, joao.m.martins@oracle.com,
	steven.sistare@oracle.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.weissschuh@linutronix.de
Subject: Re: [PATCH rc 2/4] iommufd/selftest: Add missing close(mfd) in
 memfd_mmap()
Message-ID: <20250616162532.GO1174925@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <ee5186412a875a958f9e77a5e6eb26a1f35c7c83.1750049883.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee5186412a875a958f9e77a5e6eb26a1f35c7c83.1750049883.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0267.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be7d81b-bd93-4419-c6c4-08ddacf26afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BFlrK32h6LeLJ86udCzyD4ERf4kox2qed0ZfKbGJs96K5fB1cQokoJnOF1/9?=
 =?us-ascii?Q?4IKgeSG9V48A0vqYIPRIvfR74tOrzD/Mi1wJRhbjCzoA0GXVdUW45UnfqA2D?=
 =?us-ascii?Q?/wqrw2o7O5/0p9vjeGpa20gurkS9DglTf1bSoFFscxY2oINIDv/2L9rS925G?=
 =?us-ascii?Q?cQHVOZFJtUivqwIzEzVM4hJgEz59gB2jKhejlQvAmTR9L/kInukSOj0iTCq0?=
 =?us-ascii?Q?lQVgzu+7/l4Ai/zif36JZL6l2xFhQi/asq0cBFkwgHmMOisTH+nZtBbu42g5?=
 =?us-ascii?Q?G5FNPZVOVIp5ejdUzcJJH2Q8tISr6kR1O153Z0/jqcmJF0/R3oCvWQIX7vSW?=
 =?us-ascii?Q?X+xM3HYHXB2E6bIeCWdq+BlxoLzuY/uRrvcWJGe812fTIk5UXD5zzlai/wMk?=
 =?us-ascii?Q?t65rO9qlpGIekQLnGMvb9o/htF2HKT2aXBvGi0BcLbwH6oCc5ncpzmblwNXt?=
 =?us-ascii?Q?O9bzbGTGvklk//Bu4pdN0jQiahKl0AUTkr6AicQGcXWx1nbPRVkLI0cJH4gK?=
 =?us-ascii?Q?rwcSgGjiJ7xjeQp0bUFByfD6UNc/bLzpz2MST+CgYSbAjhP1CBJLtq8Rl9Nq?=
 =?us-ascii?Q?N+AZ+p+9na8K4ICAPOyZLqfj7XKTgg050s6kpw0KAAlOLDYP03gtyBJK8rvv?=
 =?us-ascii?Q?CnJdLafrewwQvLC3710h4gDF3zGo+EBrYiajc6G3B1pQmAm0zTf7+g+6L+AH?=
 =?us-ascii?Q?F7QpzjV1q7Ww5ylqlON9ZQ2ea2qtCHdjcJoYg4htHFU+CAqViCR61PWBCd+i?=
 =?us-ascii?Q?6GeoMW1INFHLLXnPlAJJfD1PEyPSHoTYnx8B/o0WxeprC/zuC5KmWMsenH15?=
 =?us-ascii?Q?HiLomQ0RANZcXTMza7rGjoKIpyo0Q1UNBpQTiRd7ExnDTzLtjrjAk5OGP2JE?=
 =?us-ascii?Q?uwiMGi4+f+VYucA1zY5KJpZ2pcjv/b7sch+Bqhtm7I9IzMhZGOS7EXTIixjp?=
 =?us-ascii?Q?OIxvnbMk9T+fbqSU1ZJyRanz9YWRIPRsEKdFMBmSHjfbfbac8gmBz0EnWcQX?=
 =?us-ascii?Q?md8sK4faraMa59iuHcEHK01gl4x4thHhKwy/t/OKDovTK5BOUbjQZGdS8Hav?=
 =?us-ascii?Q?j5kVckP5O9olg+is1Ne65VBrRv4fKBPvAGNMVmxKd1P1G8P004rezjqDpAcI?=
 =?us-ascii?Q?EGHkaaQ8P2/qMAQ4i432tgXCfVTKuX0JpaV6tzlm7S9cYNtvVJX7WdSX8zc0?=
 =?us-ascii?Q?SNAgikBKGFGF9dPJUujGuV01sSCnwWqUe6+r6SxEm11fXlyuR/xJjHU0dbJY?=
 =?us-ascii?Q?OQCdieh7F4DYdMlplu2P37jb8FciulzY8HSjn3m6ELELaX+2fP4mzmYqSLG1?=
 =?us-ascii?Q?OBxs6qlg+PZSbzvEVPvDMQheltVH1jX30P2Us3woUNRSYoAgHg+EOFtd1xd1?=
 =?us-ascii?Q?PGN+/o5cbW7KqliGs80NPYZCZ4V8UL6Jasi3zOHupNJkZRPcyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LLtT22TPuCb12GTpAwHkasOqJE41kET3busvSuqzqMY3UCxpTDVwGkrjYZWj?=
 =?us-ascii?Q?hfS5Xaaze3fZoUSqi7zbb/M2VO2WNF3cuqiYD2ArrpQCepqtBEZEPQ9oWLtv?=
 =?us-ascii?Q?o/o+9VGXJ7OYFaM0SU4XgcVXtMpk5I3qMLqqbCEHfojMgdeSsYOBgXPNO6e5?=
 =?us-ascii?Q?10JE8dZFLjwCZSwOyIjq5cnN55hwCVRj2u2UZtPhGn59rMg6xZlTZftytT5Y?=
 =?us-ascii?Q?PIfSh3+BcxNZtOQMtyql4+fiOlqCosWRRZBgJ1pGMtvxhGSGS5DoSmEeXNEo?=
 =?us-ascii?Q?5SYB8Xk7yabkMjTQh7wutpWOY3jdBoA4/RqMtgQ8T8istAMO+rJereAX1Bv3?=
 =?us-ascii?Q?OABpDRia9M5Qc8TJaMQ5E5O3vZKuKGeHXab5mx5eW9UNoAG2RA+XHTFx72mW?=
 =?us-ascii?Q?yT0YDwpcb0vqTIQnAGRuEE3gSZ/xC7gexw3Rkb1bjwQP9An1/PKZNVVx9GYW?=
 =?us-ascii?Q?hDBSNP7FThWVH5OLEi1rJ21fvO6fMZ9c+ksMFJYUty6L+OQ2ZqsGlCed9Euu?=
 =?us-ascii?Q?8zXEBZl8ZSwgSc+m55sJd0bYw7nQmBm1UAe6Z520OP/EeREjMvGUnanRWFGV?=
 =?us-ascii?Q?opdB9hw0yjh35LTawNos6K4uocHzSN3L4ng8OXBUV5vTG/kiZ4iudyn3yWH6?=
 =?us-ascii?Q?W1B6HdEsZ9n+Kt5eAOMkosuRA7YGCi1uRZgJnkJuHc3fT34BeJpxAV2mqpf7?=
 =?us-ascii?Q?tllk/TLAFn2XIFR6UKIt2tuKCYN6Bj4j7ZKLXJqxgYidVw/Cu9yCBQr3dE0Q?=
 =?us-ascii?Q?ktbJZlmHSuXMGfukds3obCwRUyjIkYQWPCc5vsxbyGOf8vGQI4aWJ8Sjf0zy?=
 =?us-ascii?Q?zD2j/eqWx7wDYikmC2rYOGktWH0+vvzumcMLV43fyn1WHWdKfYpd92Ql9tFh?=
 =?us-ascii?Q?pgOEsZttMFSy3552Eu5tJFk+Xu7h9IwGRyO/fEiAvj5hOesqnfNsPaa1DKsJ?=
 =?us-ascii?Q?Jd0FzulF7a6bJadYl2j6EAGrEubr+qb855qYa4tvi6xfD2Lj8EIRUB/YHVdq?=
 =?us-ascii?Q?PYaO7dji+4U4/m7b3Ehb3kOdVozOyHigPSWTWJHZqCOHcVpedRkIRCOeIAfL?=
 =?us-ascii?Q?c3xyiF2PNSqGU2zLjo7c7tF2n1AkCOJyBW7Sv2TXvMNy/hJIrHlDKvw7lW5I?=
 =?us-ascii?Q?MUHffZAuNOg5oXcNSWsdbNSz/JWSjeFff7G977844MQW5ah+9VEcAy1KLDqf?=
 =?us-ascii?Q?qlNgRXYYbcLrcXuNPWMIkuAbK0meUsxzJdE7z1HlMl/RZDxzgsJ/W/ZlnqB+?=
 =?us-ascii?Q?yYBhWO/JLhk76bLvcg16kZyYVxuH3gZpeMfKAQZKPAGI5l53FISnzuP3hAWe?=
 =?us-ascii?Q?jZSF8kyAO7SFAcmFI8Jc44DybMGR9kSCXJi1mD9+3IHxR+YTI01T1MK7X0qQ?=
 =?us-ascii?Q?ahsej8tLGcJjs0bMMNqq0TctItijveaZNxYZjskv113yDz7u8vTi+edxw2EG?=
 =?us-ascii?Q?GDRgfvHNGHNZ9BxvVtkQHIHQNC/PKLoe0D/pE0jVqkWHbHXd7LEbOqJ1n6kg?=
 =?us-ascii?Q?W9WwQftueA/dbZcO79RRuqqXO8ZxqhP7jEy6P9F7VVbaQE/C2fn+2Euh9JMe?=
 =?us-ascii?Q?tsrpIW/v4vzcqJLmfFxWOnYoJoPlr5CD0nIhy8tc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be7d81b-bd93-4419-c6c4-08ddacf26afc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:25:33.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A6kIlVsuYuaJbUHewrK4IV06eaXkr5z3hE+p5b0/KpLEicMEwktRRsgDYP24aY0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557

On Sun, Jun 15, 2025 at 10:02:04PM -0700, Nicolin Chen wrote:
> Do not forget to close mfd in the error paths, since none of the callers
> would close it when ASSERT_NE(MAP_FAILED, buf) fails.
> 
> Fixes: 0bcceb1f51c7 ("iommufd: Selftest coverage for IOMMU_IOAS_MAP_FILE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

