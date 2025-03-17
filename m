Return-Path: <linux-kselftest+bounces-29239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D595CA65643
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 16:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE8B189967D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF02505BA;
	Mon, 17 Mar 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OEP8971H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D324C09E;
	Mon, 17 Mar 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226268; cv=fail; b=bxWS8HPXxZVha283lya4/3IntU70xApwBVo2Pmyj5sFJJBj43qUCzILUsYP2YasLSoSzP+m91ROL6hjEpuTtdRfYQU8KUtfeLk7/VN/xppavbej0c+/oQaWC4DJXATOWLOrQo0gl8B/OpMjtzDw2rZcQX5t2rqyZ1Emymh5OvEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226268; c=relaxed/simple;
	bh=Lea25lKFSmOE5HZLI6Nt1fKkC3UKGFpZXXigE4zf/sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BNVGTQTq8UOh1mRd23Rh+q936P7npke+A/ci0MIxoCie+Pw+N9n8ZsLnD6v7JUICn43CRF3qha2u6m1bIc7oxKXbqdqRTlRQE66k0/XLNaQ8ukz3B0pZwILbYIpywELuApb17YYDlaG3yiotQ67fLj8wxUxpuPkeh86I1RKW3LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OEP8971H; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQpLn/Erel9/sJTa/8MEHIqyhJd/4w8/9i48OEJg5Go0S7F9jV4dnYPAXTDKmzKgu1hd15GoiLs857GOxfByEVay1d0kwwZzdT12r2ZKs3lySkbAHSEXWk2GYU6TywQUV9hzy5S1PtG88W4/x/p6Imr2N9lrp6iMb2dNUXbJUqgnJvSRENnbAe/+0RqabD+rOhxXWL+q4soUoWdbghuLo+bykjrODvn/VZdmZ0r62u1ft+8C9JaxJBOvoTU+DWaZ2CRr3i78LnLnm7IDCITuaVjcVpT45pprGZhF9LHSdWzLSi+MyePKG1V4bYVcKVW6HxQs08L6chW259a/UinOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEcjsd3wijmq3a8c+wEVG39qKMo6JcztjhYTYEyxOsg=;
 b=uByEAb4XxinrhN+2q6HWQRMUY2wuojBnhT4dhnBqtvBIMT3OPPVua7zDj/ZYCUCmZ6x8vU+3YwSy5Gnvr+zPYj90BVMlV8PKdMgF1dJa923uiPRiAaLd76kAVpYZuXWywct35lJ4bkBbhmzAIoXqXRZM1uS6Fe3aX6HYF2t48db8i4XIZQfs1OvJoS7NgcymCc91XH9zOjpvR/KMZ2nQUtILIsejGohMZH6vihRhkPgL2EnkV5BzyLZML/V6L6avsHOFc5kDBNBX6dL92+1B/3Rgelw++chV960hhkZhlG5EWWIWX+1inJVskxtTtjH57aZlfbp+OfrzqrcYD+xu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEcjsd3wijmq3a8c+wEVG39qKMo6JcztjhYTYEyxOsg=;
 b=OEP8971HkLdL09YbxIjwy9cn3+eJdnscfprUJICAX5Lw4aW2HHEW8F9RvD1ygsoePd6lAZVXPhpLdHgKEhWFPtHAjqCwtAd30s9ytNhzb6YYhsVEaIwaW8J4c8aIupx9MGeeglrevvPeDzeylEqUHtiloaUxdafG8Ve97dUvl3+e+C8YNnp1dOchFuwJzdKpNZBAh2DzcGaPwrsg1TFxMgMlSbT8uPiyBm88Edtp410MQbNt5yvKsZXtgG6G/3Rh08ClgC2c+KD1D2YEDFomc83LkQEflT4sUBzhbiZ7XtzAtAaZxBsiFbHC+u0fTUUkWbJDt1gW73oaEY07Lf8txw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 15:44:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:44:23 +0000
Date: Mon, 17 Mar 2025 12:44:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, kevin.tian@intel.com, corbet@lwn.net,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	praan@google.com, patches@lists.linux.dev
Subject: Re: [PATCH v8 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <20250317154423.GI9311@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
 <20250311155714.GC5138@willie-the-truck>
 <Z9B2LMIi+88hlfza@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9B2LMIi+88hlfza@Asurada-Nvidia>
X-ClientProxiedBy: MN0P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 86188aee-f6f7-43e8-20c3-08dd656a9760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e29XWDx+sMc77zi47XenRjQ+odk++NVgjR3VB79ZgXthMqeLX+zgoJPwn55r?=
 =?us-ascii?Q?BripOkeHjiPP1DLJlBHpKlNew+rD+5MM781Pm2+eAmdSFpIBsXt5nSR38SZV?=
 =?us-ascii?Q?x/2AG0vUMuCYm2Ljm1dockctDknZCX+6ky/jBwHyA+1GMx6XINXiBWLSEAcA?=
 =?us-ascii?Q?0azYw5d9wszDG+J7xM1hIq1rB5odq5fk5enOJ8O3HxpEFF5Kdt3pSnQ2TByI?=
 =?us-ascii?Q?XiwUZVL9AjhuzQ8giYiEiRpqbj1/Avthg0/HylKhJhWMNGwHyUp9adVdhiW7?=
 =?us-ascii?Q?YeyVeuHO6ilLh9EVmrmhWZYlaouzYlel89m4YrxSoeofPGVSu/N99AayrsR/?=
 =?us-ascii?Q?Zbvc6JwcYaoiFlI10RlRlzZNPyNtKlMYlfUNL3A2rHMmVNZb4wpbbpwbEXAN?=
 =?us-ascii?Q?E/vHt/VW5AVXw2nVJieeF0RQPdP//16kubO2FpoKhqHpprfyrXN7NLtjfXf+?=
 =?us-ascii?Q?lyh1OwzcaiIhLHFMbggsjasonEeZ9LzJtZ4fpoaQl3Tjo0082k5DdVV/RClv?=
 =?us-ascii?Q?cDRWtQN002dfYHZ6x8HiKCBezplK8+ftJ0PD2WsloE57UnKT3907hNTqnOXH?=
 =?us-ascii?Q?YSomaezXriK/+FAK1WmzCE2YJdrq9kvRjgYjUBUw7twfK5GV3mfldEmyb3iM?=
 =?us-ascii?Q?ho1TnmCrgnWpeqokBWdUVUjt+QY4K+v1DlZqZ1b03rMsIOtMMbzjdIUOw5Zv?=
 =?us-ascii?Q?LJQq7Oa1IrWAtVv5xTWefvySYi3sSync2DDTr4J0oUrI9mqqunlm8bjRwqTq?=
 =?us-ascii?Q?b/IjBPyHkDp43BAjzkfXq6Z7vz+Q3lb481A146n9KZ0Dkf8AfDXIVbBJdleO?=
 =?us-ascii?Q?pdLNccjwNTkY8CwrjEV/K202yBdKH3H6OSD5R3D2lDc0cvY08WMuFvJNdhl/?=
 =?us-ascii?Q?9k083Unasv0UqBg4qm0jLegYmQ88OmqTuW5NE912qDN4lvqYuZeXLN02oFJY?=
 =?us-ascii?Q?ZNt+XmdnIfv/ynQ85l1CGxOq8Ir33nRmzZDe4RWXGD9C+4GC++M4ZsIFLuDY?=
 =?us-ascii?Q?g6b+dAa1gT/Z7BBrJkS4wLt5XaGEIgZTixBmwftaW4SsHuQz5+J3W/2VJA4q?=
 =?us-ascii?Q?AGSpV5EMCWX370vwcrKmmCMAljx4YHF0J3GGe4pKyB4CJJAIXxEJMQm2H/m1?=
 =?us-ascii?Q?2jVNYQK+e80hzqQGnM4zOtgmQJqOmsNB7knrp/18iTekLHIIkGbdzOidE711?=
 =?us-ascii?Q?mmTlE+l6Uf9lHylioXnBzDbf9B5CtdmBWejZJkV8WvDUZPj7dgk8wyhkfGaW?=
 =?us-ascii?Q?khSeNbO/aLL73xkMxOWVNQIlCvnf3FfdJPtMMmDzdydl5sggSaKmUau/Rn+B?=
 =?us-ascii?Q?LYmusyRkwx09HUFUMcs9tDS0dhW+NH7wdefoae366sl686Jf80l12Y/TiK18?=
 =?us-ascii?Q?bvFnc6mjh2H//D2Za7ugeaEmSIbd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WA6SxbOAzPvfQMGNrOh+4/tlVH2ZG+2Liegxmoc1hcOQ9eWKsuRtcGQxyCN?=
 =?us-ascii?Q?Y7f7OxyiCYuj9oYlF91rCk/XLWxzkOKSBnv2swQeRh73zrgoHH2LPqGwT1Fi?=
 =?us-ascii?Q?V2dXPEZ1fTeW2GJcoFx2eMKdhXQfu+perabAkwS2fkk6dgrOmcqaTyyk2Kkr?=
 =?us-ascii?Q?86OgHrdbz2KyGo10iL7D0m0B5Qur0NchY4p0iG+rWulDXMBOXWG3LTpktODS?=
 =?us-ascii?Q?00R8vi5STQpY52OZyAyDOguHKTJGTUQlvow17TCeZRg170Y42diqPzknLP2h?=
 =?us-ascii?Q?l9dRcO9vWhro1fcubBtp/i8FDjp1CBTG8lrVo3onO9JMPZB4AUpUjmZdkKOx?=
 =?us-ascii?Q?+pXmzEuzPGVdXuPsQQ5crDjbydQQD92vhG9WtmnDRdmvelbnT+UwwAMcFQNt?=
 =?us-ascii?Q?JnGOfjazLKmVVnT1HjaGMCTycJiq5A54tWxFbc8hFBXurtC3mNhCzbRe/lCv?=
 =?us-ascii?Q?maW05J8QPTi/W/74T1wpLLEiSkK86VxdAJNarshbjDeFgA+CZ7X3XraMqxV1?=
 =?us-ascii?Q?3R1iTEw/M418vdHyuZSZO3Ka100c2xtWEJRkPoWQCFDqf29vcFrfqthuudMa?=
 =?us-ascii?Q?AImRdqv/SWO93EEPP8zYcWTRQutLf6DzZoAJvh/a++iwxLLk57/OWIScgQZ6?=
 =?us-ascii?Q?nv8i+zBVBV/tIXMNS/6yLSFhIECxVAxUnyn65Q4blDdO+zdCGk54TC7WVpvz?=
 =?us-ascii?Q?/PC9f8Udf6yYR3zqrPiAh1G2BWZgSQkhwf3I8jqdo813U7EDXC/B+tsL1b3B?=
 =?us-ascii?Q?Cy3tjRlYv/MWgWtpqzqRW+uJjEOhHBgDvMleC0kVUTOwTGjuLzkmEubYkLmO?=
 =?us-ascii?Q?8zuJH/U0gWx8p5P8gsQl5Cj0hYEqIrtq/wIOxVoDKbRI0egYFIqxNoRVZdf0?=
 =?us-ascii?Q?EzCtR89Ek/rbWN7ABgDUQ6A753QOxL679mRmFZUO57ttAuipPKxr1/zWiA9X?=
 =?us-ascii?Q?LBjnlvYfGm+Giaen1qXr0TmYZtgYmmNoegUXOiQMvIfEEZ8AxafafS5Zlp1d?=
 =?us-ascii?Q?XkP6Gji+nOXHkhlnafwYjWQsQN/61++yyaqD332kZme+TRcgwrNz8mzrjT8O?=
 =?us-ascii?Q?Gjwoizwd9q6rXJvIFbaR49GpcJbxEQ0/DJj1QRIg30Vx7lgzkT+tyfYhP47v?=
 =?us-ascii?Q?TADUopxOFsdHVuylDm9S8xlT87CQoJx7IJnION95IckFhSZu6FFdkalA5uYm?=
 =?us-ascii?Q?VqhGtpxKGv4XOyPg5eei89WFhzWKfKa3qzlQBPlVuawUNxqrs5PZ/Hwt+46s?=
 =?us-ascii?Q?1ZY234OgHsVo6X6fQE0cNorcljxen6aH5Y1xwmJVE/doBmK1JwEprriAU4ZM?=
 =?us-ascii?Q?rdWebPYW1g5Nca4nuYHtwLLc8mr83BGhVYEF7xtDc3o8Om33rKrxXgBKz8IS?=
 =?us-ascii?Q?MvFpmnkItdnNkRwZXi8VXNCfy48Vdgl14VHzXmZ2HLix9xM/zYQb2M3HYk8E?=
 =?us-ascii?Q?HExYAgDW1z/8aUZtlqLbD0hDLnCra+oTYEI6uZYT80OOLfLjM7KK7eWbaeTH?=
 =?us-ascii?Q?0kcB9gciU3xatul4a3bJm3+VU6lbQin2rsGS9m0XpZN66+9pYzGajWniusL6?=
 =?us-ascii?Q?2eOe1y4VqXTgIqgpvNBS2OZQrmh0Gsr5zl+SqVUH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86188aee-f6f7-43e8-20c3-08dd656a9760
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:44:23.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYnyYQOGovTwJ2XMAeGRjxZhCbLHBrPyypr7TJKt1W9I2/nsamT9oEbeTZy3nEjy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316

On Tue, Mar 11, 2025 at 10:43:08AM -0700, Nicolin Chen wrote:
> > > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > > +				    struct arm_smmu_nested_domain *nested_domain)
> > > +{
> > > +	struct arm_smmu_vmaster *vmaster;
> > > +	unsigned long vsid;
> > > +	int ret;
> > > +
> > > +	iommu_group_mutex_assert(state->master->dev);
> > > +
> > > +	/* Skip invalid vSTE */
> > > +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > > +		return 0;
> > 
> > Ok, and we don't need to set 'state->vmaster' in this case because we
> > only report stage-1 faults back to the vSMMU?
> 
> This is a good question that I didn't ask myself hard enough..
> 
> I think we should probably drop it. An invalid STE should trigger
> a C_BAD_STE event that is in the supported vEVENT list. I'll run
> some test before removing this line from v9.

It won't trigger C_BAD_STE, recall Robin was opposed to thatm so we have this:

static void arm_smmu_make_nested_domain_ste(
	struct arm_smmu_ste *target, struct arm_smmu_master *master,
	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
{
	unsigned int cfg =
		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));

	/*
	 * Userspace can request a non-valid STE through the nesting interface.
	 * We relay that into an abort physical STE with the intention that
	 * C_BAD_STE for this SID can be generated to userspace.
	 */
	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
		cfg = STRTAB_STE_0_CFG_ABORT;

So, in the case of a non-valid STE, and a device access, the HW will
generate one of the translation faults and that will be forwarded.

Some software component will have to transform those fault events into
C_BAD_STE for the VM.

I imagined userspace would do this, but it could be done in the kernel
too. Regardless, I think Will is right and the the viommu should be
set even in this case to capture the events.

Jason

