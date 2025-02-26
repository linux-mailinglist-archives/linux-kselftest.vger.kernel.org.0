Return-Path: <linux-kselftest+bounces-27635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C4FA4682A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 18:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0EA1884B07
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC704224B15;
	Wed, 26 Feb 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="shkujR8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0451E1E1A;
	Wed, 26 Feb 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591378; cv=fail; b=EXltJg+SPSRn/L5cpkHaao2R4DoWZpLCBsCduIl8ZQby1NYpf2BSY78lAoeC/f+p9lxMLDNa0eOezC9aNp3J7/flUBsh6B+wZxUdcqblqTJhwVUCXT92FkhfEZheby0Zi6PmDyprzkteQO2rZzRj86+HEcuEEDqQr7qpZKuYNB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591378; c=relaxed/simple;
	bh=0Bl3Iqp8C8XUhaBpNI5QmNIwyK87UbxaEak5pZShxdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YthmsYD7gn1IRO8q5Kz4vauZ9gkdLcya4BBnk/9TdIqhoOaDYJ4pzWsdfgXMSsRpq8EBw/RJkTZedWfyJB3rt+4CmlP4A7172MzBnZ7OVgaampB0+6rKruLef9cD+JzxXBZBdV0RTkZ0ogMePNKFurocnRJTtjbkQjZk9HxHzz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=shkujR8w; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtGB9PIi1ZmxNUDPp0yrAceIwSmUuc+1IA+H5vSwYVBxH6LBc25ia8PwuJpRZe2d+zFtE9SqbfMWtF1b4Uy8TEVETkLNUP1LNocET3Vk0U7YUSc8s0scD4Lw6M0ZfRRGwqBJmpZ+UGWJpxV6W2YW0X1rhHDnvfiLRPvJ0A2gQhWwXJsCV47sp8n+tIDRwTv+IfYcUZuvafTTdI/ObmDK0+6mOskzpFn8zaqurGa/MrEtlpc3WfPaS+erk56sst4303MY6M/CbKJRhdu8E2lSsXDG6jquEk3yZmcpminBMLPEVt5jtuNiqb1jNCZ67PT7NbFZbdXM4m6KKowzuzZa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dJhByED9KmeAfa8cQOEyTQUL3lqj2ilupRNu5JsX0o=;
 b=VPjfJngKalgVyIyJE/+m0AvCMl3kugehCko81jihMlboOHpr8UbLetIgXZQp6+vK3c9U8xKDKWQGbGxWmyIhsT4R5QmWo5DazrN83vj3HYv3GLuIu84Q5JaMlQ1991yb4a0TGwAk6KBPpB84IZkIwu6tMIjTU0cRRkG+oLxjq2AZcI44tdfXFyG3EaG80izcqHE0rxAr5IrlLok4PgYyevTmPJfR7VqQHAIxlcv3Yy8yFNdykZvYGQvYSdp6R+GxSuD2BBEoLc1MuIg3ctMb29rDzUxZTd7TpiKJ+gm8pOKuaHDEHNybb1LBFuyUilMZRgCKk20qDw/CXr8oCpa+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dJhByED9KmeAfa8cQOEyTQUL3lqj2ilupRNu5JsX0o=;
 b=shkujR8w3L/6/VU673vWwODCBnZ0TKO0oxE0ljGM90Gx4GGV3j/7iyqxUTvTv9YJjrUWSBi0EFbqpS9ficiJTw7Rwgv5RmNRbpGvFultLFAleHMHuUi/pzLjqRgNCT5yACNXMUj47qWdus3tkHAKc7/32WBfZqBpM+EMLh/Ic3wnwQtG9SQjN3RjWBHiosrC8MAuF932OsG3SeEXB87wrTcuNtHbqSsywq+OEopRdk3vEMX6d+rTNMD11A+rLvcN0Mjuq9WUg/vNOBK9ujr4wzxKfv3ongKb9dce9QdEb8Ygzfq8BrI8u5/rMCC3hqiSi6T21wjoS7DrIqwm2huGNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 17:36:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 17:36:12 +0000
Date: Wed, 26 Feb 2025 13:36:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 7/7] iommu: Turn iova_cookie to dma-iommu private
 pointer
Message-ID: <20250226173610.GE28425@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
 <20250221143959.GA272220@nvidia.com>
 <Z757lz6ucDE6Otix@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z757lz6ucDE6Otix@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:408:fe::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: d6644acf-5a15-4a5b-724f-08dd568c0fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tclUH77wq0JGtuqxdLshUyUZ60AwL/avN0TDUMK1zhA8fPWbwkIcYsGhlNTW?=
 =?us-ascii?Q?esLKx4Sy2Fva9bBvevBam1AH75zOSccYJSPRXT5QtDkT9h4vPnyEAg4HDk+q?=
 =?us-ascii?Q?Q9V8QPiEcQdqe2r7NHq+CS6B1GsD2Mq2fn95prSeYGrZjzrZioSx7X3r7BF+?=
 =?us-ascii?Q?M+SYZ0N8v2kr698k88q6GX/UfTRYFjt+KkSP+sBqBqpHxoDpSkOXbRlKT9VQ?=
 =?us-ascii?Q?248ykMzyDRe3Q561A9FO+NhbfwxTwzmF+phpR7kXd4jCXabImvtncKVIKdYH?=
 =?us-ascii?Q?zjZDqjEWJFyFwVCGbrVyoNI69uYm5LGOmZtHF7BkeeM2tzEI49NlH/jgWZl7?=
 =?us-ascii?Q?QpI9gAJZr1Ut1E4UMyBA6SF1Flz8Jwk8ZEw4KdC6uNcBcyZ1cwb0O2ZTENoj?=
 =?us-ascii?Q?DLEed9j15x8jDWLF0Mfk6VWD8TCIMNecpGdux1rs6+dq9SQ/VSx+UUaw3jdl?=
 =?us-ascii?Q?Nd1yxRIF1qY6uDaqEjyreTXiaMC45K7QS+kWyaw8HL/58pcwpIfc6zWg8Ow1?=
 =?us-ascii?Q?UjIEHd2eY82NfM9jOUhq09m8T5R+E0KEAXoO7Cv5NSs7KI6JXSLF4MNzPorm?=
 =?us-ascii?Q?EsDu75DERPsGMsWHBvd1wi+/2EV9fgoiYPwQ8ZW/VZNeolrTIbN8vg8mxu19?=
 =?us-ascii?Q?GlcauzRFQn2VyrNvk9YuTnjg4tu3tmmvaESeyrC0GFbyQxwAGBPZfmP0sxqR?=
 =?us-ascii?Q?exmr+Rm8lqQDWCUKDSrHdR879tYugOHQuGIxJx3Xzohv/pP37BLAZ+y8E0Jf?=
 =?us-ascii?Q?Ku/r/M12ZMfoXJuyacuji8r8VQqLq3x3aLcFOKN0JZQWW7U/MTu5dPpE6qy/?=
 =?us-ascii?Q?5rpj7Hw7+PLarQ5gmRHgkJKVL7rtbXtcAsBjx44L4Wyxp8bMU0qAPfQJUpUI?=
 =?us-ascii?Q?nsidBZsRpnmQA0y9AvwVM+cseCIgX0ly/CPZDt2AqRlUcXyhLwJ0AAm98amu?=
 =?us-ascii?Q?qbOjwd2zL67ZIIuj4Fj4kdhNPEHfN4jVPVTbN/T19yIgS5yJkbZ7cCIdentW?=
 =?us-ascii?Q?jee7aPx8VG6y4AAkPpKUqOJmcor7UgkN19oi4KmQQ2cl55QQLhTONgG+42Cu?=
 =?us-ascii?Q?sH/l6fVEKWk27k15RQ4p2xbLYz8xdhHFlxp23dISIUESk0CCA4aiQ0rJ67an?=
 =?us-ascii?Q?KC5egv3+C86LK+ID/GcW6jFzHX4IsYhneRf6Dqegps+o5Pp5L/6R6SqpEVAb?=
 =?us-ascii?Q?Ea5wF7xrkIbMV8iPIlVYI8Oy/YZt0/qnTQfoKk9uCid74QYA5I2n6gIUENzc?=
 =?us-ascii?Q?yPsUDmWZgj7LpHpjrsi6s/lzgVyFrKeXVgVAShknmOPj8kGZOa2BlEje8WLZ?=
 =?us-ascii?Q?QQRjyx5ipjtld+wStvluc06u8Iqq3wDyxgICx9ud6RgOzJOoXigdeveQGbTe?=
 =?us-ascii?Q?/RqJfEmzmGPwPKRDvZGeRGRPuUIX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?51ACzUF4Bn1uPX4jrcm0ia37PMoIngLep6DKn1cD8flEQblP0CXENR5s4ABX?=
 =?us-ascii?Q?MviL3BH/9OMSmPh6Wf3lFFvqT6Qrtms+SaT+q64F4FxrKfJepv1934VsiZSC?=
 =?us-ascii?Q?n11wxeccUU2vYbizq/UGUz7GMR7tcUrkQptWO0qV6x6MKhETq1rEGwcu/9iS?=
 =?us-ascii?Q?aQruYuWXqZ7S0U2pJBVg83UDDbXUCl+rVFnjhyAniBwObN8NdSXsm0lOAkKk?=
 =?us-ascii?Q?fCX44vk2BA/pBRUI82QrZ4Eqsb6ZW24q7MjwK/ihjGHhttoE9k6gCmynZ+HJ?=
 =?us-ascii?Q?TQoxrNSaJntoaZKUweLbqYkc4AoTzkqPUPvheAx66DEFFxZahr7DENt8SR48?=
 =?us-ascii?Q?9wKefPBKDAim0/eICQwG7XYgfkUnp1SpctA9tQV09Xl8eAWgt3MjsPYNq2MI?=
 =?us-ascii?Q?Okx7VQjIo+JJGWQzCHY58oW/U3HGGW3nQ2Q0xffh/qGeB7JF2iSKOr2FQIKi?=
 =?us-ascii?Q?qdhIiZ9FvOQtLaVWJKt9lC1h39U6UsVLmtWYObT8GBX/UytbuV+uFJbTFEYj?=
 =?us-ascii?Q?gQxsVl+fPlZa7V6hbZIRIxZCJ11unszY64skKs1Jhrly/b5N5sezlbh8Fpdj?=
 =?us-ascii?Q?gQ3yYfHvgHry1JDwDVPkSejdKqZipIeIAeccJPoHtBDkApYWv1dH3Dqg6ssl?=
 =?us-ascii?Q?23d9YJAUmn3F3Lk4u3RHAlgMuLcH0g1wA7C5qs/mfh8whPPRxjBE2uykRK9c?=
 =?us-ascii?Q?FSuTiIHJ+AW+Dt0asbkbj/5WKurHJ3FoY/Wd6X/IBtEgZXun47Zur8DG5bkM?=
 =?us-ascii?Q?FoBNlzE0MSJcbBu2naXLAu3szXMAjFbyEl1GOIh4RM2EMwvzW/hxvo2Qfmh+?=
 =?us-ascii?Q?2QMbZCK//11CfUuoDALU3S7Sauljf4YDLhyOS8swm0H4RlkkzgAuQ+Ud4JTi?=
 =?us-ascii?Q?b6PMzd1xOsJQFCHL/tMupusRr1oCYFtEFRNdPd429yjbWI7v9u/jWfdJrfNR?=
 =?us-ascii?Q?xrq+Hcpnn2x3dIsth0RHt/QJXS75jX2LhMSsapcZaGHyQesHpadUwoEhHYaA?=
 =?us-ascii?Q?yDud6D22teZAqp8wm0zVB79X8JUCp/zr/WTNX+qT1AXN5Nweto5JY90K08o6?=
 =?us-ascii?Q?HpKPSilPqaA2CemIYtenTF0yihZSUCuF7tDMemPO4le7FLb1qd2g2yktQtfs?=
 =?us-ascii?Q?XnyP06yStV6gYGWLlHryAGcvzLLHdnrR4Rhhox0k7rX8JuAW49Ue0yAWSPz8?=
 =?us-ascii?Q?yHaCPa60XSld1TC77wO8JyA3oE1wcRqgGUFB2vYSl7BWNOptmyQGMsoAdOAU?=
 =?us-ascii?Q?wWL1rlsRnJ+c1JHvHa5h3uFLhN+aIBLQQZ12QmcH+GNiIK/N0QGtkt9FNWoj?=
 =?us-ascii?Q?AGmp27/VxGDi9DLHBPX+F5g8WSF0C9h7CcAQUGKQBsk6ZoCY4+ZShrcwcpiT?=
 =?us-ascii?Q?PbAXoQx67DPj6fD1+QBrd+m7u5DfnXvpEMDYp+2uuXQS66bNgDrFs4d6K84P?=
 =?us-ascii?Q?ekFlhZoQlKUzqn92hjUCEt56Wu3Ow9jplp1Yl4yePFN+CcxlcOJ+bbvvw6Zq?=
 =?us-ascii?Q?+sFSAwxP9YwMTRk9uZ6Y28aLKwolG5XrEb4+rez0fU4oXbGv4NDDWtk0TDJB?=
 =?us-ascii?Q?IIyxKJtIDvlqjuOTXjrgMk9Qb2jFxvrMIOUIECwz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6644acf-5a15-4a5b-724f-08dd568c0fea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:36:12.0949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlaaHI8f/4WltJsliUTuAiHjM/mz0UliRglQ2hESHWvDvS17axBV6uRtBQlp3Ux+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

On Tue, Feb 25, 2025 at 06:25:27PM -0800, Nicolin Chen wrote:
> On Fri, Feb 21, 2025 at 10:39:59AM -0400, Jason Gunthorpe wrote:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 99dd72998cb7f7..082274e8ba6a3d 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -1534,12 +1534,16 @@ void iommu_debugfs_setup(void);
> >  static inline void iommu_debugfs_setup(void) {}
> >  #endif
> >  
> > -#ifdef CONFIG_IOMMU_DMA
> > +#if defined(CONFIG_IOMMU_DMA) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> >  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
> > +void iommu_put_msi_cookie(struct iommu_domain *domain);
> >  #else /* CONFIG_IOMMU_DMA */
> >  static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
> >  {
> > -	return -ENODEV;
> > +	return 0;
> 
> Should we keep the -ENODEV here for !CONFIG_IOMMU_DMA?

My feeling was if the system doesn't have an IRQ driver that needs
MSI_IOMMU but does have a IOMMU driver that reports SW_MSI reserved
regions then iommufd/vfio should not fail.

I don't think it is realistic that we'd ever hit this return.

Jason

