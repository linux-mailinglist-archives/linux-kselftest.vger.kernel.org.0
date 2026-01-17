Return-Path: <linux-kselftest+bounces-49239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52488D38F85
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 16:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328793018D43
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64420E030;
	Sat, 17 Jan 2026 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gEG2orL9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C2139579;
	Sat, 17 Jan 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768664633; cv=fail; b=kqwkyOFCn1lD+d37f2c/5k1mX5cNKKTRt/EckOrKMkGkcbC1hVcuJCrC2fa8F5hxmAGCzSISLK7rgxBvOGog+zt8siFZ4HJZHF4isxxPHfMk2XWnRD78Hg3Jdbsl50kXNLXgo1z7VxkqDiTSUuIPHs/6yxkKbeewpamk/6Owiho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768664633; c=relaxed/simple;
	bh=4gHEK1LkNfoaPtfIADYBVNmKmvsbDhQ7Mn0aSOtuRkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=piS3EHfdPKdDaPUz+ffgYIF0/4LhTY+zKyWLAaZnWaU48wc73nC+tqRbCuk34PwuKJBQn/Sw5v+QBCFPD1+OxqJ6dqNF5IM3JnKCRqWaW8ipARv1ivURguO1dCYJDrPk4mNR1q5+gQrTlWoQ6Aq5eLLNUpWp6NJJ6Dnx79ef3+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gEG2orL9; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDmZb+nF4E2XPOFAi0rQ1foPs3SO0N0cUsIQhuryPDE4RCdUfnq0Nps4NAsuyfnVkePm4vLGuZwaTeGv0LrbiFz1/GJDEY6e0vHILEqjfWDkdyHkPjN3hQsWQethYRIVNecP9RmsWkRAY7L3YLJmrk0j8PAAGLyElhHoEZJRggRQ6pARI5I29RFe2QgcDRJeDsTpm3GZxxlohYlY6C4G6pXRw9xwZyv+1gFztrgBp3vh+jhP3DF6nGSN7C8sU8KsDnZc6hx/pxJM4clarNlgToht8/GsjqcK//GQjDZka+1ykowT8Droo68iE69BLOEmEMBHmVaZQeMQO6qRqwvcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYch5h5I+JPTNkQahRmSqa+yJQx5X/orG8YXXopMePs=;
 b=vFkLUxk/suF0m04zB0HRafsT+qBhG1TdAaxcgBl8QpxkOdmKcysDOk8/09BiNghil/knBl80tFzPYUQCeBlvfYA5pSR7x/JSSmFh3mrp5Z9XMTV2/SiTSjMQ6YQ6E/MtOlwGOn9/ZfgvR7IeMRzNxenorGbWQ1QjG/frY584stXEX+/6CbUDje+5B6Tkt6wStj88kb3LJaFvQ7zoNsoYq3vQc6G8BcjO/T5DIcAqbsWaSZ8nrOFibVuGkMGx6S8Dcgnj8lq+FWtY/dtOtYjzBqaPEcO99ZMMbrCAkYGgPV6x6ghOdEQJCvtGc0JKj/xZ1J/yW3jihQ/M3o3RGPYPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYch5h5I+JPTNkQahRmSqa+yJQx5X/orG8YXXopMePs=;
 b=gEG2orL9+Qetfm9xfp0XovyMjtq8tX6nWKZ3lK8p+8mrgHVoDWSuCyjDFoE33tLc5TW2mmfuLUXR8vinJgHqDmeodX0PGou2DcaESWgdtMijsObjGg3UtY3+ifqH68BIyf/YHNYFe8Sdtt6mx+bUdnYc2OEfAwLhSXg+xx7MNSqFCYu/5BQsNE3KTU8/xtPo+E/cO7lzpWpgITT4KV3v7J2ZiqW1FTBqPTRv9BCfv69V5QFJd/kN+uFzwYyuHh9VKIhfQoh1gqtKqLg5TqW+80ocZ7Q+dLvCmBbecUoXNEIJHTHFP/kTPKwOCTJbDc6zGWiXh/+nD1YQ3Ksw+61yNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Sat, 17 Jan
 2026 15:43:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.005; Sat, 17 Jan 2026
 15:43:48 +0000
Date: Sat, 17 Jan 2026 11:43:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 07/15] iommupt: Add map_pages op
Message-ID: <20260117154347.GF1134360@nvidia.com>
References: <7-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <fc4f0354-4e6d-452d-abfb-fe24e53253a2@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc4f0354-4e6d-452d-abfb-fe24e53253a2@amd.com>
X-ClientProxiedBy: BL1PR13CA0409.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4b01dc-1a10-4242-911a-08de55df349c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Ooo152aCdKdA45rCC0bPAYOwShFVT9+qmA45XPIQmgDjspYNvkCga5EAn9W?=
 =?us-ascii?Q?eqaMciLcdRwxyqOZyEbYYyq8HuhvwIJvlIZggyyDtHaND4W5nXmiZGuyeUmL?=
 =?us-ascii?Q?ARrVvAw3lx74GohQ5O6MUPpcdhv682b1id2QVAC0fH8TNX7LUahU43D1V3Us?=
 =?us-ascii?Q?57bwWuc1egeNMZSm8ny5UE4tums/3FSqXLebbAAwJSDN2VC4AfN+Jbr6Gn3g?=
 =?us-ascii?Q?/MiSJ33rx5UWUNSraoHHiE+WDaHnSBw/9+AXgEpF5SRDPe017cSzrxTSJ6gJ?=
 =?us-ascii?Q?CY6+wBX2GKignSsOd7Et/7Ao2DvOBH1PNhGt6ECXK6gnbB5RccM9Ii6KKfSw?=
 =?us-ascii?Q?v4GcQn6f72yh80gx7Hr70pZ5wPmcXfXdnP68/VpavQNVSk2gutBCSJHIZchQ?=
 =?us-ascii?Q?cF8eD4peRv3GVflybjcxINcydtlFYh3P1B1iEq1bUGJMYUp4y56pn4Cqds9v?=
 =?us-ascii?Q?Wg/gCqJfAoudp4eRMczop7vw2DCtzG7/a+00UY05eiWqrt2R5ktGf6iGwAlh?=
 =?us-ascii?Q?sd0PETzYov6VHwE2BhZBSsbyBl96GvVCPibejai0kDbW2KzOM1e//Xp5OEhv?=
 =?us-ascii?Q?WodHWZb49CWS08ynC5yMHLda2pemBgN5qOhFbGrQtVV0gT8M01ttDZGIr+Ca?=
 =?us-ascii?Q?FkWvYLvPGKG/Pu9Hfx7EN+P84y3wXia8qBKPi6syV5C/SMSsR9/C9FBaK4hS?=
 =?us-ascii?Q?3FScxoxaMmyrndSLIGnPvzcB9VOAyt205k2irZzOZgqPr9I2e2MhJneuTSkD?=
 =?us-ascii?Q?RkXEIbfpLhuRwEh6p5cY9K70YuQfxENvfGcyFN9chAijWSSQXgHFquN7dE6J?=
 =?us-ascii?Q?02KDMbAVwRktMHNLoXMsZUStHO2h3SB2VmSvb7TimzqllzrJs48d1mlT+hkb?=
 =?us-ascii?Q?ip0T6x2p/dQk5KSTsTAOofvXTa+7WGTatzBo63lXKAco9Zw4MPWJO08rjjFC?=
 =?us-ascii?Q?3rScG8cunWLWLcT4I1M6eIuOvKpFfTBklSAQHAtRj543reNpdLTTGwyt0hux?=
 =?us-ascii?Q?9Vk2x5TkI6iq/V5m7MT5ZnmsLZiURjDl/P756HR2CgVVw0Xdk9RQ+li5yylk?=
 =?us-ascii?Q?LIy+A9/+UiftjEQTXrDlCwKOGBh2C8ZMa0nmtSObxkrDaOVJsVjgVD7SAmRd?=
 =?us-ascii?Q?SwsWcj2CCMcIpVeSC1PM4x48zkQjYD2eqESIQFJcF7l6U55xqw9XBFlz2cAr?=
 =?us-ascii?Q?xTOTPmcXNrzS2k4X2eKPwrBv6ZgKjFRKXrBc4d0OrRrHME13JwXdp3TP9I7Y?=
 =?us-ascii?Q?UCvZ1io+h0saDEr9NDWI5gW/meBW7smz1la5HyrVtkwi7RHKC+GsMgyHpjAa?=
 =?us-ascii?Q?QUK91ASyhGiGRi09QU/OhcSCAplfF2YyJENrDjrtNFkefcjEUkMz2s239o/y?=
 =?us-ascii?Q?atALdMkZyX9VODT7Hk5TXzce3sOy22B7A52q/ErYV7pUSN07TA6eGnT6CKnI?=
 =?us-ascii?Q?Dr6nTEBvEDHQrU9zKRLiCF0FX2I6jRHnQSbGZykgTCdri2r3G5lFIfmSV0UL?=
 =?us-ascii?Q?f/pN7MMBp1hTE8y+/W8oSW5jH8OzPX/pWd44uMspPxX3v/m2N/ZJmAgLDP8M?=
 =?us-ascii?Q?DjwpED+uwWjFx4sro+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lNe2nZ/YQXMagzNihui9HtaXUJbMWSo1wgIQQb+XPjENdeodLUa9a798dIBu?=
 =?us-ascii?Q?vDV+XwBpvbWiVRQ/XpY8vvIxOxxdZEppdfEitkNf4AidIhL05bpoq1EqQgE3?=
 =?us-ascii?Q?v6NYzQ4b7I3ReRmKOst5P8SAJfNidplyIPdBZZcKjlgkOzl3QaWvxrrjd19Z?=
 =?us-ascii?Q?Kl8geUgJldm9u5fUgHWI+JcIAhwshsysF/sxcHhVSRJ79KU0K3mnx9P9GTDN?=
 =?us-ascii?Q?7pINcVY7Xi540WmigdUJjA4lZOUYCHDvSNSxUc9apHlP4NcG+hUVbujU084e?=
 =?us-ascii?Q?TmxAbkUFyK2jmilX4GnUHbSPmVJ0zWvW5i8haP+6ifnwlF8diRAtdeFmAEb2?=
 =?us-ascii?Q?mFlaAN0MwdLP0dLCfNKEfUZWKOH1nvcjc6h8xOFCE2pmMyJC0Nx1OT6uzvAj?=
 =?us-ascii?Q?MaqOvoUnLV0d08GSEmhAosYoleLE93vLv1/3rvpiRdHlzqjiBymOIiaQ0Y6L?=
 =?us-ascii?Q?bzvbMsUHlKMW2TdrKRTBDPC8Yn9eq0uhKqdGoFIiGbo2OT3qzkXRoGtTyxmU?=
 =?us-ascii?Q?k9fc6mEYunCNYKOPRmQuapNGeYRLUFbatFk75mRrndrpsLYUtLQK/KZW+crq?=
 =?us-ascii?Q?dHduAxeTRQnN1/4EDjmhQFpczaf0XBzvG31JibmPAMReKyAL4fOFqKf2UBks?=
 =?us-ascii?Q?OmR7i/s/NsBZi0hs0sKVCKmG5GDdCkRD/dlifktJSpckKsQMxDNJjugaD1SP?=
 =?us-ascii?Q?z6Rz7XghsT5uHBS2GMj5PAC3AZjft1bATfkebCIEF2VwGKWUkerygLCeUvG7?=
 =?us-ascii?Q?4yepioEZ/66ABtmXcZ/bIngBAJMTzmx9I+DlrModfSyiPnLdB4ES9qvI/JbF?=
 =?us-ascii?Q?q1o/chtpkCAZmmNYTCO3JYVH6g1v+G8/hkKoNyg+1Sp1soVFHSFzuOo+pPsN?=
 =?us-ascii?Q?QC+MBfNQ0RHQnrzqPKM8Tj70weY8/hzhJE2DZYPIE5JDCOB6fXGedKBoVpDX?=
 =?us-ascii?Q?daV0ufKwwNzJARTPgd/vrwH4yTy9nzW1ZdI/fxKyoLDr3QcMPsfNHpsfA3z3?=
 =?us-ascii?Q?qkEMcLvzclQEWVhl2/nehBH7/2MQuiOi/gAPghJ8DeCRpNK1gvkMt4oTL4Ss?=
 =?us-ascii?Q?0NZQlaOWR7b886VVJof+c2wl3m8IMWXRzdaIXO7egfBXDXoDggoihjnr+Vly?=
 =?us-ascii?Q?e8YVXfz3h2I8lgKa/q6/ULOzyzR41xCKyFLIi85asAttvp2kt8m3ABlXYRDU?=
 =?us-ascii?Q?Tx1guhaahppnLO5awtPj6jhIL2Hh7hrO2W5I/T/vwdHcurwHGT2INZNAZCxW?=
 =?us-ascii?Q?Pa+U0w6wO9d7doarZCUOYINi03/EcDR8/Pc809G2t7cLRJtRe5ewLQ6ndVsj?=
 =?us-ascii?Q?SNyCaDNwBOUfVL9RvB0m/Fa7Wf9zb0gMRu+fGqnYajJuRAPYIvN2aTDNJc5H?=
 =?us-ascii?Q?f8GDk1+Ns5tdO1pwKLuBXx1jqPsgdPfJPKpDn1KBreQRKXaEoqsioxe5svV1?=
 =?us-ascii?Q?CJLUxoQitAukuNsft53HkXlpyt404Nlv2Aqs48l0qsmrjYbf8iHgJuZDkHIO?=
 =?us-ascii?Q?Oe2moq13daCPrQgZ9TdP0FWvZK3hLjeHxJXl35rQ+E6BRP4x2AW4tBbz3sZ5?=
 =?us-ascii?Q?AdAwncmstSLpkVDTTBPr+8jycPaVrhacTDtJIujP5ugkolQWWetvkgkbNNaK?=
 =?us-ascii?Q?BJcgQr/Vu/GhzduF7urbXaPVfDIpDtySxuHA8qV3Z3cCAd5r7jPLGRRX3rmM?=
 =?us-ascii?Q?GAEnD1k6rHXt3NPeT/iuEVmCCsoEkIc5+yOWZtB09YmBRcKPnjxff0LbXfYj?=
 =?us-ascii?Q?ifLjtEe+nw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4b01dc-1a10-4242-911a-08de55df349c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 15:43:48.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZAtciGKEtkQ9P1QwfpBoDdX6NhrgaOYOS0M7Edei84J9/RIlDRxcYVkyD3FsNaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560

On Sat, Jan 17, 2026 at 03:54:52PM +1100, Alexey Kardashevskiy wrote:

> I am trying this with TEE-IO on AMD SEV and hitting problems. 

My understanding is that if you want to use SEV today you also have to
use the kernel command line parameter to force 4k IOMMU pages?

So, I think your questions are about trying to enhance this to get
larger pages in the IOMMU when possible?

> Now, from time to time the guest will share 4K pages which makes the
> host OS smash NPT's 2MB PDEs to 4K PTEs, and 2M RMP entries to 4K
> RMP entries, and since the IOMMU performs RMP checks - IOMMU PDEs
> have to use the same granularity as NPT and RMP.

IMHO this is a bad hardware choice, it is going to make some very
troublesome software, so sigh.

> So I end up in a situation when QEMU asks to map, for example, 2GB
> of guest RAM and I want most of it to be 2MB mappings, and only
> handful of 2MB pages to be split into 4K pages. But it appears so
> that the above enforces the same page size for entire range.

> In the old IOMMU code, I handled it like this:
> 
> https://github.com/AMDESE/linux-kvm/commit/0a40130987b7b65c367390d23821cc4ecaeb94bd#diff-f22bea128ddb136c3adc56bc09de9822a53ba1ca60c8be662a48c3143c511963L341
> 
> tl;dr: I constantly re-calculate the page size while mapping.

Doing it at mapping time doesn't seem right to me, AFAICT the RMP can
change dynamically whenever the guest decides to change the
private/shared status of memory?

My expectation for AMD was that the VMM would be monitoring the RMP
granularity and use cut or "increase/decrease page size" through
iommupt to adjust the S2 mapping so it works with these RMP
limitations.

Those don't fully exist yet, but they are in the plans.

It assumes that the VMM is continually aware of what all the RMP PTEs
look like and when they are changing so it can make the required
adjustments.

The flow would be some thing like..
 1) Create an IOAS
 2) Create a HWPT. If there is some known upper bound on RMP/etc page
    size then limit the HWPT page size to the upper bound
 3) Map stuff into the ioas
 4) Build the RMP/etc and map ranges of page granularity
 5) Call iommufd to adjust the page size within ranges
 6) Guest changes encrypted state so RMP changes
 7) VMM adjusts the ranges of page granularity and calls iommufd with
    the updates
 8) iommput code increases/decreases page size as required.

Does this seem reasonable?

> I know, ideally we would only share memory in 2MB chunks but we are
> not there yet as I do not know the early boot stage on x86 enough to

Even 2M is too small, I'd expect realy scenarios to want to get up to
1GB ??

Jason

