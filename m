Return-Path: <linux-kselftest+bounces-15090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1213294D67B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 20:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C051F227C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9CA158D72;
	Fri,  9 Aug 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hOw1brWh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3182941C;
	Fri,  9 Aug 2024 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228903; cv=fail; b=LAuQ8Ch8W7daBYGs1ZhI9LZrfzqpuBvryRlwEP1yv7SPxzNxSeZ5j7LRrVFFD9jcgGeUctke60N5+YgJyrbdxTgQMmjEgxGJ3LpktRUl4NOOldWOtmlXeXQ7r3R6+Rufj8HqNJ3a3Lo5s8u3hRwUtroLEyPPOCrNQgX684PO5sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228903; c=relaxed/simple;
	bh=2Pdz8MEY7pdjQsEYlaQWxxMVI0A23aa2d0sF7VsJlps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OU2+SIq3HpX9mBLS0L48hcrREKptezJ4fKlPoJrchvv5ylMLhR/sm3X2jhvJXPwftNV8zwdo8nJG06YqcD+neG+IktnfSKPk5baMelu1XGkg/ZxqVGjmuj2sayPXRQ3kudJZNGoOplbLxxtQy8t9Bd7Zfl6pnaMajqIJ8b9olXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hOw1brWh; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMtoqgkWgDRsy4wuTMgCl6UE/Lo8GTf1xoZt8V0ZPCbJu2tQzNdmKpS4L3arPj2YzYTH50x7wkgi4Q1ihx4qsMVKj6wuNHxdxnpm+aP9AfIVC6Fd5octMmIi7wtTb5bmtyFza+f+cjqtv+N+zRBQ66FjjM4lbvs6asAmKu/Oz2iR4yqNuvoBiWLP0ohPXWp1Q+3ZJaLetprIDsklYE2uAqQZD7HWUnALbr8LmiirZHXYumk5GP5mRAvwgPCnv4urYBzC6sP5h2NnJar3dMYS9gmoIjLN9ivNPgKJVtJXuCtZPF4GmLGQbtseNUVd+iUEWU1ZoqcIuyxogf89SFMTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD2ZZ9wNksvOK6NCCaj46vk4qUQRq3P6VO4KlctB59Y=;
 b=q52RMuxIehBboO+RoicNRjYj1a4u/5tsNTTuedtGnjtnqxI6IVHSPhOZPio2b8EQTUjKdarfN+0rRcTS3LE14pmdjXjKch4OHB7HXrPnjmzuBXJDXzROeeGTSekG3MTuscCp6GAJif9JKMvJ3jsHa9gxre36Gp2dkiUDlIBVfJRdKBQoPUCrCdn1TlGs8W1dZYs+Nv79nzQ72aGKcYomkvaSWdsKe6h3q4BWZhyvzQE/MwYEXsitmzvjC+dN7RJQEqewDlGzPeuH0EOqE7JUO6a1nwclPIQ0Q2R/3Uy7dXmWQYvNnEvUM+H2aPFNyalfEOSLWuBkZgy43nqfi1vJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD2ZZ9wNksvOK6NCCaj46vk4qUQRq3P6VO4KlctB59Y=;
 b=hOw1brWhtXhc3uRekrx3HSxlZbuXDaIfT5LG6tVXWJHDxlahZZD18I4x4Jec4EdI6cvw7vhIE0gYcKBV8cFUjWRjmfwMCdX+Zfxl2hPoHjLD0E0GNCCWFF50CsEYobNAdLxj9DBotsqbg99z04Hxi8+KHt7BOhlXusOulB6ZwRatkKY8AjlMV1YlrukzQa1XTcwnrmV0Z2N3zKUJYbos0i/owgu2uAOdgUY8wLUr07435q4VlM9xstwCCMVLHd0SEYoMbcPy+q9g5VEoh+RbmxYEEs9cQ/QLqVNWofCDbNU/WFOUISx39msKv+Nif1ENfrtACe1PLZFA5FCreWsq+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 18:41:38 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 18:41:38 +0000
Date: Fri, 9 Aug 2024 15:41:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Message-ID: <20240809184136.GL8378@nvidia.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da4f216-594b-4c51-848c-86e281402820@arm.com>
X-ClientProxiedBy: MN2PR15CA0063.namprd15.prod.outlook.com
 (2603:10b6:208:237::32) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d779519-0b2b-44a3-5b7b-08dcb8a2e70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TuGGB5F2tISZ3oZmkf/DqA3imhki1QAhq75wqZY72VI7/zz4hkcdkuSD53Lx?=
 =?us-ascii?Q?VaDoydvTwbpl6TM7IMMAgEaODFVAf/8NzOpfcELaZyMCfPWPi5Erg8Tsf6ut?=
 =?us-ascii?Q?BKpo2QkQ4z/j7C0xXuBCxHw/bZP5AgZOgJn+/P8Y6NyBHLXoL7etAnnvialZ?=
 =?us-ascii?Q?ax0/+W1S3r1kbfLOXNw/3Zf77G8Jz66YuLlH7dB4ppLVbcXZA4uB7vbYhDin?=
 =?us-ascii?Q?1dAkSshr8EBeGq3ppsqrgxVGk60vGwNvUcpiZzw2uDNY8pDoizgxH7c8m39I?=
 =?us-ascii?Q?ogpArYltJWDDCwY2I+jOlSTFOn4FhMweqPmhCXoSn8y3IGpS41bpKEzIAIun?=
 =?us-ascii?Q?LoTueRrCmB/GMhTDB4OxTSy9Rdp1XjzQsqxTocEZ/s6Eh4P1+Jo+G3vizMku?=
 =?us-ascii?Q?XyFV/YIZg03k4+XMbfPu/HTMPBiQjiBtcdtKZER8PTxgaFDmi0Gg0B9q2gAZ?=
 =?us-ascii?Q?UAftqSd8d/z7i7xXfW74vgLLNliJQjPE2TFFCUdwzF9doqFuJ3LM/ytvSu1x?=
 =?us-ascii?Q?M8hNigKHC4nrYPampqN6ixPZRo9wuvs8VQQLsSEVay7byq/6NbC93gB2HkCl?=
 =?us-ascii?Q?HaxgjYVz4My7VhIJjuLD/HsrM4ogAlTQKE6BHXMFmTzfCMQGmQSzMwAotIaQ?=
 =?us-ascii?Q?pZWUEEYLustpnHlT692aikkSBJd5VJhAYOAwNPl5BW9L4Ey0I8iXfWIUZ8F8?=
 =?us-ascii?Q?GztWP4DDfIdTUrB01Q3aX54nPEojGChCX5M0LdfTHtasaB8ySVuu/uEIEONX?=
 =?us-ascii?Q?b8gZWW/Haa02i0RtW4kNo/F3cvFm5sYNdJfgHJGlFzT7rzGP66ckqQu1jr0A?=
 =?us-ascii?Q?WdGa+WxRvtUj49rQvQ4lQjmtjUrCUwg9+4USCrgXT98qu5L5x0iRNWuqCxhw?=
 =?us-ascii?Q?RTTamMNC7Lw9Ya30dAaNBoQRAzoo9b/WtwivYIgrxPqvPl8gNVjRxol64Wkb?=
 =?us-ascii?Q?yZ1equKXiLQPTybA/PZP1O/UnVyC6ZtdBNKOC8WnebiOiOkXW8Xoi9n3yL9X?=
 =?us-ascii?Q?esnetRd5inmfnbXsIDkLimlJMr+jtY+qR/dwOtagTNN24A4wGXTZ+XM8ImYR?=
 =?us-ascii?Q?x7JmjSG63o9sr0aTkRiB7S1LOAq4lwf8y9m8RYH520FrZvUkLQGXCnACvFum?=
 =?us-ascii?Q?gRwRaI28U4U+0QK5XLYEjdHly6WnORWWyzYb7wjFv4WeSYQZz5Xi01EPcADr?=
 =?us-ascii?Q?ohetznL1xCRLCCF26LVkLBXxNb/CLOTgxJrWpYwGR2TKN3mOnDIRwddxTppS?=
 =?us-ascii?Q?k28qoMD4x0cMhbjCqPvjXT+1QYBBBNpz4KGI89XaPdvkoWRHQxnL8eVkvyMV?=
 =?us-ascii?Q?ezdQC1qDQK/GNOQFxelrLPss5c7KHY1lT1Rki53dMfe2Wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?twXGdaKs0ItWeiuNrzlXU96EW6U8QOQDHgBEMQMEBKR3X+v9cvdI6lE5BJM7?=
 =?us-ascii?Q?6jEyI/AvHZxCrs/I5fJPOd4n0/RCzH75jJnLshWU2g9alX75SzUJFV762/JC?=
 =?us-ascii?Q?M88iWtwwt3u7xFtsKKk8+yv0QI6dOfF0nwsy3nBLzrLcKOreTfC29MXrBXAl?=
 =?us-ascii?Q?r+VFNtavvfAd67CiWCuT+BNEXDiiZ14vpYx+wPpqd7ohbYkhMXfCumNlOz7z?=
 =?us-ascii?Q?uUM1acbvT6oyxKZQ9G40xcEZyatotS1RTGddZmr+DWSBcDTF+3Q3dEzWOFCF?=
 =?us-ascii?Q?j8MIKFFCRqBAmiSi2snIKEMfRqwNVzPknZiBG2WMT5J0rgQAtEt/h7Ktb3g0?=
 =?us-ascii?Q?CAxuIr9os6d14lbhPA0MZx1y2a+dLjKZRuXfMWET74EQDowkJNR/GH2yngZ2?=
 =?us-ascii?Q?wHkZzIncYtdxKu5Q9FX0rkbZGaXz26jDEVuFxXWxkW63Nz+rPIGYf/n0Aj3f?=
 =?us-ascii?Q?mmdgFqMtEhHhaL74ZZ0lMglb3l88cotyxruR8LWV+tD2H6BgH8WyxSnbiV49?=
 =?us-ascii?Q?8hMWepWesu48f/MTYhidgWOdKt8S/4053+1BGU6P1fyONryaY495eK8fe5Rp?=
 =?us-ascii?Q?UkpBXYNSePRXU+idVa/vO/sKoqIx+xGTRryLyV9MrZBA6jKHVJX1+lfsOylU?=
 =?us-ascii?Q?cHqMMnnLBsiuPnX2/sVti+/t1IDnUzeZ3v8ZyWXS4fG1LDIkDt19YMdy4jgZ?=
 =?us-ascii?Q?XlOfOZ3xcgnB/AZ3699zU6xMCTJQmmanSZztde8kCXecdV+AKNYSJ3SfxYpR?=
 =?us-ascii?Q?D42m0eYlW5zPnzzRjPJsO8J2zC/ZATOqIEuRBNzTUydlkh0wilu4HgsinVMD?=
 =?us-ascii?Q?HLIYGEokmsx2i4LtNx6SUw3VfvkKX5+47yYaOJ+0EoldmSOYLvAmczHDr7TS?=
 =?us-ascii?Q?TXq0p2a0KBOL14bljqD/rU21g1PI3bHPR9+QWSrcChV0SCxdsbnEihNwEPOb?=
 =?us-ascii?Q?05Oq0pt7/NtR5SDqBtauTolyvN3zCigd5jUbCDTyU41UkmW6Fi5fBlhnqvS7?=
 =?us-ascii?Q?Sn1z8skSOuJOVqqkD0R1Shoxr56F5hE+4Wml5to0Z6FVAmx7xMlVAP+vcif6?=
 =?us-ascii?Q?F0hfbnEeJzDQwJE0D5BivkWypJZh5VorjprGUQrADV7dblGsrN6w6I2Ftrjj?=
 =?us-ascii?Q?1+pZ8n62zqzcfooaKZxekJ2RbLSz2gIbZpNGKxytDrW2gv3m2rmPWp0EnTX9?=
 =?us-ascii?Q?CdOFQkKZOyN0j6v0hdjbcyCo0mCjvt7peMmX/OPlnRofIrMeXQMR+L5gS+0d?=
 =?us-ascii?Q?RpNe1QPrzs1Iq//i8cJSnn3mfFX1Mo+JYRL8x22LhHespQHYRiMPs81/FH7v?=
 =?us-ascii?Q?axlhGwnknqVCBoOp+mF9H+ylHjXof/cgiUkB1CCbmPTdIAhktCZlfEcGQdP8?=
 =?us-ascii?Q?ON2pl7TgkGmwsDkmw77vI6NNZJS42uSu8WzyxkwrZ4Ft4e8FzcfHD/oKwYSC?=
 =?us-ascii?Q?ALTwgoDzGswlVT/CC5jVeLjzEZj98AXbxnDZ9HUsE/gldW+EDRLIW1llymLA?=
 =?us-ascii?Q?4pLRM5iSBuv3YRHrd+s4Q/HpKSTyPCk1Ij8SRShLmsWR14sCVOWpPFhmZ7l5?=
 =?us-ascii?Q?l8Gwh5mL5EDKLHw7++s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d779519-0b2b-44a3-5b7b-08dcb8a2e70e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 18:41:38.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpAd990uLnuoc/BHbBctJPhRoB1hUKtm6eP/4CCa6tTPG5OtUfsTe/Iqu3ZYs+2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

On Thu, Aug 08, 2024 at 01:38:44PM +0100, Robin Murphy wrote:
> On 06/08/2024 9:25 am, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, August 3, 2024 8:32 AM
> > > 
> > > From: Robin Murphy <robin.murphy@arm.com>
> > > 
> > > Currently, iommu-dma is the only place outside of IOMMUFD and drivers
> > > which might need to be aware of the stage 2 domain encapsulated within
> > > a nested domain. This would be in the legacy-VFIO-style case where we're
> > 
> > why is it a legacy-VFIO-style? We only support nested in IOMMUFD.
> 
> Because with proper nesting we ideally shouldn't need the host-managed MSI
> mess at all, which all stems from the old VFIO paradigm of completely
> abstracting interrupts from userspace. I'm still hoping IOMMUFD can grow its
> own interface for efficient MSI passthrough, where the VMM can simply map
> the physical MSI doorbell into whatever IPA (GPA) it wants it to appear at
> in the S2 domain, then whatever the guest does with S1 it can program the
> MSI address into the endpoint accordingly without us having to fiddle with
> it.

+1

I don't have a staged plan to do this though. Getting the ITS page
into the S2 at a user specified address should be simple enough to
manage.

The bigger issue is that we still have the hypervisor GIC driver
controlling things and it will need to know to use the guest provided
MSI address captured during the MSI trap, not its own address. I don't
have an idea how to connect those two parts yet.

Jason

