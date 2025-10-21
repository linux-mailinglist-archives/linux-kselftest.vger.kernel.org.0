Return-Path: <linux-kselftest+bounces-43669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BBBF7C50
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D063188E815
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9582417C6;
	Tue, 21 Oct 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r9ZjUYH7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8C1B21BF;
	Tue, 21 Oct 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065193; cv=fail; b=Ze8QxVvGfcrboiiteVQgu/49gS76L9v1i8/UqBS6DPVW272iC90yQfLbQsAXXUQZnASgMZIHgwoeTI27jEcMLgunS0iypvyZhEWPH8K/EWuHr2VetZdYF1m/V12PcrxttHePk2gd5Bgj4l4xywQq9gfAYAln8JeMcMSvQkVFZxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065193; c=relaxed/simple;
	bh=+lpP8FCOWJhD6e9mdMbo0QIGOUBQPcoydffcIgxqTF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rk8I8GWjMVq1pSKqLm1gJaxOTjElYRN5z5gfTMkWOo7CLjq18LjzOGWZOdE5vjEfHpsk5GBGiaSyPOOCDRNvkW/98fQTkNuKiEOJMCj6kmboKcwEt3qmDnlRgDiypXwPlmEwk+guIGkw2pPYn35QLxYTOsV3T4lSHP9Cr3kZhqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r9ZjUYH7; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP41ULtyZj2iFJAYshekEh6vBdGXo2P47psMyUnLTIc6NVpJAx7zEgH8Z+ZtzxlKY6MjdmqvZ8jpO0NXpgxPlx/Iv2pfinEGA8kCDMMBl2d1vgC4us4ipJ5rDrKOL3R4IC+4wU2JGIn6/uLBm/GoFHgaPZ/n1M7j7sRMhDcaoWwHZc3KcGKhBO1Lho+/l2Mt7NaqsI7FLBwzSZVVLpktf8cW3aNqTJ09ELMgKJy8UEay9JMj6BJF2sJhOe1CTIgF+JqS8VZFQkGSwEjq70dR6ZB7jBc5uBsMz1XftbusTMyU8GK887B24vLnIHp2S2ZIFhdn3KIA4z4wCG03hgdx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUsgpUrw8zDgvYSj/bOA82UDpRpoIlc/+JX69KRh47Q=;
 b=ffNEgOB6AMNS13ywbPERT844RVfKRpDhWznA0Gc9HtDhFOM1axZiCQufgItgyOPXQzDB+6e9beudlmfNDj8TDu1qs3b4ZTyJKqx7xl5f7cmX2KnQC5wE288KHiEL2G41kOBUNcMeyRy0Soj9i1yv6nYgTci27EUsGFyIx1OzQ+4zou20/7QFzxmwoxNR1A+iAAGB7hz7PxqpS18Y61Egj/Uxs2mckYNybS3AqtiqV+oXbGXH9nTz8iLfS0Ganuvcquvx8YSrBPs8P/FK9iPT3zQY6Due9MUGWgA9cyrwSBLmepa40F8bLTlhY4F/QOGYDPfpq/+ovum1mify3qlKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUsgpUrw8zDgvYSj/bOA82UDpRpoIlc/+JX69KRh47Q=;
 b=r9ZjUYH7K/fOWtkCOUby3B/Xt4+/L96uUJfq25/96QwQd1NDXwbKRkyq8DgfpJt5K92tA5jBquehW3uZIn7Ikv57LvqOdOVdmc40cWfUZ3oEgNy48EZtbYwJcuYM+ZZ4rwFyd2rdBNCRA/90u2Rlzick2Mpm3VU/W3H+inCfKKcnKYnECuVZ3WyizpmRKSSgfVWlIiKYx0/daD9E22Z4eP+7rJmwHZoBuvwWUOrg+TVSXLvk622SeBElf7UC+YmW/1GIUQs447QJwAkKRSchf6NNSEwaxfZ4ydGi9zwzx9rEjirVSfqLbC4qKl4fDcx+gq3WlhZEaveRKaFbgxUYwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 16:46:26 +0000
Received: from BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f]) by BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 16:46:26 +0000
Date: Tue, 21 Oct 2025 13:46:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 01/15] genpt: Generic Page Table base API
Message-ID: <20251021164623.GG712833@nvidia.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <1-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB5276C2E12A8DE1BF73352A9C8CE8A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C2E12A8DE1BF73352A9C8CE8A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SN7P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::22) To BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c4c390-41b5-4360-e44f-08de10c15fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tSPPNHUzQiWH295yAqlJiQcc9FXvCMlCVc2k1LnG1tdZJPSgQQ0ZUbdq8OM2?=
 =?us-ascii?Q?wgzDn62/5vTuM/XxBqGlg76+jjSnr44KCFrpZdB0xW9BRgf3L+Tk6pFddkGq?=
 =?us-ascii?Q?A9g8EXLCW5InYVfw1/3tCNc1aRYt252Zb1Pfvik9dlTU2aRP9O/5iVz7Ei6b?=
 =?us-ascii?Q?mICpsaLNhSRn1923AnSkC28J7FniUcG8BQ91hnWN5LRbCQ9pPEViru9S5lzV?=
 =?us-ascii?Q?vVHzPoBunG9JjWwnYejti3Z9jdj/b3xQB1whvvhO3eE+Fw8EeGf7+Ery0IxW?=
 =?us-ascii?Q?SaShTEcriMiUqCWvqr0UR3yUfKAK1YFttEhxv8gxRb2TY84IdH/kbUtD7T/4?=
 =?us-ascii?Q?KC7r0QE5sALH27O3Zglb+mH1Igexucr1z8wlnwRrkXaOMMHP6cfpsSjM+e93?=
 =?us-ascii?Q?ySUjgOhMINyHsxnTEe/yTvN4Z+3Hwa3+eWeuLZYNR89iLz2uhZpiAt6jNG66?=
 =?us-ascii?Q?/l6GlRfRokzPwls39zp4A+lcg+bPaEREWzvWznkf8JLtif/IeWOIcWK9L2qD?=
 =?us-ascii?Q?1inDAKA1A3wBzvbe9G1m3DXo0k36JQflsQ/mlsW10Ua0/KdogU6umKTYe5U2?=
 =?us-ascii?Q?F8YVyCzX4GtGW8hQ2b2QwABfxR3wYjH4c9iKJef8tBhBXNjPkev8vuLxOmxt?=
 =?us-ascii?Q?93PmujPN5IK5e8FWMISLD1IHUZUDIdRHuCnT/2nAVBWudwAohz47jmSJVGwS?=
 =?us-ascii?Q?zRP1eq6wr2cVZvbCw3mLET+0it//bXt3DQDWSNIx/VNZaT5FY3ZLxm0sRYSP?=
 =?us-ascii?Q?j1uaNd/qMyi2nmXIHD02LDj+WuKGP6RBbSPgevGfhCvn0GbE2QM1ym4bcG2S?=
 =?us-ascii?Q?LBRpg1JxbGSZhDHiHPO1kl3K+CH3IKjPiJG1Vt/XjxTw3lt+wG8HMkCERHeO?=
 =?us-ascii?Q?WS3S6tjdaBqYXPjI2HRCVG+GFUh9pnY5LO446xbwnzjb68lOGEvXVRbufAYK?=
 =?us-ascii?Q?Qa3AlNjTRPet29/Mi+xNCPiiYKzL8UORx1G7svdoAXWFiADDeQKFQMBkKHAZ?=
 =?us-ascii?Q?Yf5fIbaCNin3AJ1xjHFAiNJDqwGQjtyzZj+mR2iRwnYhacfP/f/8EGEQ36a4?=
 =?us-ascii?Q?yb969X+TwpXGf6IyuUpPfbaVrytvxYLXskUWfEeHlUsDLOiiZ5jLXiVDhcCI?=
 =?us-ascii?Q?mxS6g1NF5xIEJOiXU/erk6ezSOkjBi7yFLxUA5muOXpJt557OhBnEzcxM698?=
 =?us-ascii?Q?JyE0QzXvfLDlgCYGRhNKsLMYDlArYWF0wswEAzpB0oVvG6LFlZc4Lghee6Re?=
 =?us-ascii?Q?cgPpmjHvGIsrhJWcUcRyMGuaGb/bxHjl6gMve3on6B8fqKXJpHzIbk4jTuuO?=
 =?us-ascii?Q?LEThpkEEmWexjNs5Il8+r6SgnMvvpfyLgHdf+IrQjZNt2b67iYlXJcKansq2?=
 =?us-ascii?Q?RjJlMIyd8K4JVRFVpCZyIAa8eh/fGArRUwZpe8KjMejeXpnUoJi+GUjcjCY1?=
 =?us-ascii?Q?1ju3wTGNaf6IIYE1YlQfee8rIB/CbTYn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQiFvRpGpNE7kIEhvfkYv7xda2NAhcfoZaeGFcXYSWleBMixe/ZiwW8voWEx?=
 =?us-ascii?Q?A2342m7uvgKI7P4ABo7/ktUnWz3PbV3bzuUpJZL3TnN3vVIAOUkmzm8ML1uh?=
 =?us-ascii?Q?PpFIYR/Kb5q3hcodRe3YmpEDQeuextKNgSPBBbkzkAM2WRDzcDyIM6o6Yvgh?=
 =?us-ascii?Q?+yzoDGJdTI+iE8gyJwREGOVxOiVLuhAx8+CPjiDnrgsj5qoRWwF8gdWAcyhi?=
 =?us-ascii?Q?l23UZP/hreNKr2ZZJYf92iMEeQ2O4ioyFYfp8r3mwMptvoZgETNDlC9Hj5RX?=
 =?us-ascii?Q?fBXhzHTtEfhWuKG1Ci57KI1bo0qTnRzxGbYD1buenbgc/TzOixd6okavil3t?=
 =?us-ascii?Q?sZfooN/pYmylkDP1apLZ2ioIXle4XSL66eTfSDnWNgcs6P29SEkAFGKfGok+?=
 =?us-ascii?Q?/lSwzAtL3nBikpevWgr5u5SP79Et6qTCLYaCcf5Yi9D/WuTzkJLH5SMlkWDm?=
 =?us-ascii?Q?fioxeF1zqkTiVj+1QXOw9csTntXyt+MPrRsM78ir3LD9GI7Os11maZdRw5qh?=
 =?us-ascii?Q?KxieEzaB9uNRLGvT1npuuxdSY5VbLzcVtMo25NQYqYcIJqZ+ZHeZYuae/bzj?=
 =?us-ascii?Q?Q+18jNdnmFzonVGFQWak5aoWj7rOSh+BcxB7zre0Sbl6tYCKvs0iQ750IQgA?=
 =?us-ascii?Q?dOV6XNJ+OUN+exlTXUUwXc3FnLkMJSCAS9VyhuMh0wyLIjIeF1ssf/oGsSu/?=
 =?us-ascii?Q?6gcAMzYjIoQsQ39K6ZelXpO/OavcIEVopx4tN0dy+LVyoo/i5qvf5pW9aPX0?=
 =?us-ascii?Q?TZqKrnnl8I1HrL4MkmOrPptdRXvJgaNVHJyYwLbb1q2UWUqruCR1uJVysiid?=
 =?us-ascii?Q?TcwGrBmxWLAHU8pkPWLryLF3N8ajKeOP7GBbXoza0o5hkqfXjaz2iPl79j1g?=
 =?us-ascii?Q?EaQAH8mDxakZLID8lkzilCcRXWH0+gkq0mjLVO0RqWCrM6tqqL7nTXM7JBLI?=
 =?us-ascii?Q?/sCht8Cznu+g/SD8NZP9nD0AeTH+y5ImUnKkG2t8Bx6m3DHpbQUn5hepZ84a?=
 =?us-ascii?Q?jhYFlaNikLD2Oc6OGOv3rMrYYzKYNDfcFKlR9j38wLHy04/rY4tva6wHIGO5?=
 =?us-ascii?Q?6nBKtzt+vbJSsmpJ7yzNjLRAh43WnMe+V9n0Xqiaex9EEN3+LHb7ZxlZ7WZ8?=
 =?us-ascii?Q?jE6FyT62SSpu/zGfPfoR0mmEwCE0rxBaXsRfCK5f8U2kzJYpevodAo4ENo+t?=
 =?us-ascii?Q?7SsRnSd5+ow/GyUgIPYH2d0J8JIwulzhwAcWGHItcv7+79Cy0J/ZERDrOjOH?=
 =?us-ascii?Q?zDnLnkdytgwfy8pOYomi8W1q5UA28gig0093DDt0tOdni+rvHOuVjwZk1Xgf?=
 =?us-ascii?Q?+OZQ/JO5BFijIJoFL6Wojf0zyo+FiYLpI71lzAKANhg/z+7hBUQ7xfTVWmD0?=
 =?us-ascii?Q?N9kcyzfpYx4ybofMhID1hfduGG9MNgwoYHEDkc0vPEfPBmIOnDszoPecBsXN?=
 =?us-ascii?Q?jSnN7NbuFfTJ5nczPW87wmqFJv11T9RiIyI1WV6z2exwC/G5ZTzYDYbBGOTI?=
 =?us-ascii?Q?iFScPQBxE6bfzs6OhNEO0ww6JHkZWiYicveZodxsjEyCTYtgTaJTatcX7Xf+?=
 =?us-ascii?Q?lxQdcPgjWB0NSCAjSlmfrJjs0wbQu3Dpa8vKSKNl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c4c390-41b5-4360-e44f-08de10c15fa4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 16:46:26.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFc1huKmIhYsW4GY2Lz9SK/4RKlitPLhsvgPCRPbyXVKpufzkBGNERBEZP3NcxGr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345

On Wed, Oct 15, 2025 at 02:03:17AM +0000, Tian, Kevin wrote:
> > +/**
> > + * PT_MAKE_LEVELS() - Build an unwound walker
> > + * @fn: Name of the walker function
> > + * @do_fn: Function to call at each level
> > + *
> > + * This builds a function call tree that can be fully inlined.
> > + * The caller must provide a function body in an __always_inline function::
> > + *
> > + *  static __always_inline int do(struct pt_range *range, void *arg,
> > + *         unsigned int level, struct pt_table_p *table,
> > + *         pt_level_fn_t descend_fn)
> 
> s/do/do_fn/

I got all these things, thanks

Jason

