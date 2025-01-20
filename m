Return-Path: <linux-kselftest+bounces-24804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE52DA1729E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8DD3A1137
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62F81EE019;
	Mon, 20 Jan 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1tyBjyh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D47DA82;
	Mon, 20 Jan 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397139; cv=fail; b=VBEzI81ZE6rZuKyAS8AcFjX5cKBLZ8B4CnETgLxq1tpNRYuFjmlYJoDOK4wjCZ0ASvsiadvnGq4HpnFSk69Mpf2Jd1zYy37SB775EX4JPREi7q9+5ehQWMZX5a7iX2AHHBSJbA3+lQuEPHgIB8/SaxQDn40U2LH935MCETk9dDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397139; c=relaxed/simple;
	bh=zTz6F8CFeJ8Ibd22b16qetje7wvbdQlkc/SFn2QFUTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hkyzvw/U6qPYKaZgTwbqIKPpCquJoqO1kFGvq6EprjFJceRL4nw69yxVg9if49jWFXEHQZACcQJtZ2cWCusPU91T/ICqyzCo3ZL9L9hHN9FcLSOTNBF+xt0psMkfeA12z5K/emG9KjCHTQmaj03KYnEJq9zGEyZlcfNx9U4qUJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1tyBjyh; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK0cjPIb03fJ7gM/eYy1aDKSVzWJI1PQ0fGAQOl3Sp4NUDroJ2sSJoBNEwxX4PO+0sSecKwIEb4Tn38wYNQAAuSMzChEpLmjKw+OJRLRGy/xxHYrf80ZpyyLoDjwzmmRYN7GuySOwtgvX1Lm7snP3qJ+6ZjETUny+zjBu5eSdJHs/m77anes4c4o/eHeN4HLkCq8b0Af3UJ0pULYkwQbBGh5XloerB2TWrbAJ9GUBkplp3x9akSgXe1JkHN+C4Ci9X0DCl7sHWsyvxu0a4u6JRNZKjX7CmWbN49G5qRHMkYnjzL6Fcm90PMUFIUeV9A45utGpWvuIa89cPSLT8+sLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLQwrNXXeysxdkOBjP+37j8bw3d4jICwNqDgiW7iaOI=;
 b=aPkcTgkpk2dyqMrbq9tmmfIFXzegOGBPwWmT+HH5nCqlUBTF7YrlWbXC9Y2G2vBkV7odfCP1byhVlcd2cLqd5a0v/oIyhMHMiJ5kMXWxVELCHt64xblzqKTlgLzCw8yboFJYXbnWhyVbQOMbeg9ptL7Jhm+1xWdUDcWsCJw4q95iS6t0iVN/QzTuIL3DUOCjdDWjD/4J7W99wpAYjkkAFvlfabr4CEULbL9RNp00bPeI6uDCi01Y9ATeg55BTAd7dYTu3hBgCtwgLkFN0T6vXx31GXkUCSdnMjqhP5M8X5jybRkZwgYig/S1aMezjqByi6AwiIId7aGk0FzAfnDSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLQwrNXXeysxdkOBjP+37j8bw3d4jICwNqDgiW7iaOI=;
 b=b1tyBjyhwZGVGP1I1KD4YBaAQrUsqMQTFbRQCExpWke8ouhGpG98f1nbfT7JSf+be9VK96dzNp/Q9Rn56/ORtcRQzGzEsX3JGjyz60zpf8SsC9qDUXmAUpgS0JiFWrYwE4ZrkqvE6TQa5se+L3D615yW89FYRnUg4xGCCDOAfmR8PYG0ndIi7ZY/r61eJJ8t0yOridj2AGHtav+ZUaUd8d0KZTDN7rZdfh9lrqDqZBKFDxcAFHDJwuf93qrgjxVpUXhjEon31YhP5VtoimXcovbfgSL0WXvTHl6QmC6XS/8UpFU5jPhtvC+fUB406fSqO79KGSL5NhWeI/WZwY6cgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 18:18:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 18:18:55 +0000
Date: Mon, 20 Jan 2025 14:18:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250120181854.GQ5556@nvidia.com>
References: <20250110174132.GH396083@nvidia.com>
 <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
 <20250110195114.GJ5556@nvidia.com>
 <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
 <20250113192144.GT5556@nvidia.com>
 <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
 <20250113195433.GV5556@nvidia.com>
 <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
 <20250114134158.GC5556@nvidia.com>
 <Z4rVg1Xg5TCiFlSb@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4rVg1Xg5TCiFlSb@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:91::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2812af-6dee-4d8b-04d2-08dd397ee662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nyC0QfVPL8nlkwpFcu7VrVroohzBBYuYG4570hcO+CLkv87d54eIVIztDjo1?=
 =?us-ascii?Q?XFmjEW2S6TOrg6DIHJbpEwg+faFkXCz4V+ujOVclKfSGQCKEFORnI3zoya51?=
 =?us-ascii?Q?Dg7WLH3ROf+MdfeUnOdoRmAP1WO2q0Rk5B1uZJVrB0hgzPn9VvNI3nIHd68x?=
 =?us-ascii?Q?m3ukjQaeTLEH2DQ7nVyhbFqu6h2F/oCnYxGsr6hnkog9M9z3ngSqMVVfZ6p5?=
 =?us-ascii?Q?po6wg4teNOadtsZnyRJxfnh1uQvqzsIDdTGPTevEXGNjPCAu0zqbObHxElir?=
 =?us-ascii?Q?QNWEbtDZc/LgG0kKefIuZM0Or0XfWpB6CeoVQP0Vtirl37yK7egCE+BEz8BF?=
 =?us-ascii?Q?GbPOzVHlcU7BOvx50FJmBpeIuL7MxbV2LlusSII4T/gtyaqUBewYgyeYA/zg?=
 =?us-ascii?Q?l4E4CEj6i4PNJG2W02kqPE6VFnShVHyWwDJBkgIcpG3q2sAkZjJJyPjwsBFv?=
 =?us-ascii?Q?eJm9xvn3w8yAaU8Uha0EkL/spSfekxIxHke1IUWJqnKJukwGZtE5GD7RmV9h?=
 =?us-ascii?Q?JN1eyGwY/qo7gEF/NIC8lQ9iNmhupjF0MioOUMxUE3F6Umst1pBB5Y++491O?=
 =?us-ascii?Q?htve2Oe25EXWlFOBW8UnddbnxEudVPjzynvVlsBk9vr2IMzM8Qbxb5LLChdI?=
 =?us-ascii?Q?9NgFKpy2nIqzwBYWJraFlmK4jKn5dHLtOOrTKmcAk7UyrVDM3huroMHt0so9?=
 =?us-ascii?Q?wqzvlY8Xhphj6vY/9PWl2xAoBt3wBj/9sbcPNWwrxEPixucUq+cAiXq7F8AN?=
 =?us-ascii?Q?Jv+3cTOmVAlyG4PPk838w5RTWNmVn1eLu80cxHUyVfr1TfWLa2m+R5vSxC3J?=
 =?us-ascii?Q?n4h7dJzRTqDdVAmYaP5E0ZqMBKqNzDnjPi78XcUIR70kYgEJVE/jfkzxm/lq?=
 =?us-ascii?Q?GBXBrAiGc1zXlPSBzb3C+imw4STACXX7d2YVaoxbzhVEb01fo4n5Csr29fl6?=
 =?us-ascii?Q?sUmd4w0up4uv+VmH9hqfJGmUjciELaRXu33fiH7RpynWgyegpDE4iueFdqnb?=
 =?us-ascii?Q?pr+xdIlsCaUvxjSiXr6vk76/f+zE4+xQUXDYfsEBDlmMOeL2epKL5+QwEzP8?=
 =?us-ascii?Q?51hEoo4jRfWvmUddsc6+z9vy0nUUIbtX9rgROAH9D8UJpSyEJDu8HqvQLREd?=
 =?us-ascii?Q?SaMrffgeZVJpwpXo08g73ipRYsCNJrQvsYC5ict1zunPEbmHz55rgLknwezW?=
 =?us-ascii?Q?aqGwdOB4iWpkZXcjfIgblk7ZDyByTPkEGw4TQAvci9bIrydwSC2VYEMG8+zX?=
 =?us-ascii?Q?8TJUdO6sxczi5dsCvUNVB2BeVEa1pyLFgg9LNPSTUOsrGsp0iHb1OnRuLX9C?=
 =?us-ascii?Q?pdvryRsuPb6rj6FyPfcm46rWRfqXzlhL20pRSDyk+lRf77ZXJ8boYHEDBK0n?=
 =?us-ascii?Q?mPYO3+9xn0FnjuEI3deUp/YPDqiJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pL9RoUl593V+3+d9T2YiV22GXy3fBLgFsnZEby8RnV9wIREG5yojI5A0Kl35?=
 =?us-ascii?Q?fmUSYxVazGGCurxLU9YbUExPmlM96A4EufSHpo2JL+CTouK4m3USbKm2yBQK?=
 =?us-ascii?Q?nihmXVXEdhdKIDWvafst3AjMaMOeKBEXW22s+ozJFP96OY2OMRsBhhWIuICn?=
 =?us-ascii?Q?MxroDWmWD44Su6lFnTRQ++rCLqmbIUHZFzzypYW3NqNlMcJc3rM+ANBe4HEn?=
 =?us-ascii?Q?q8n1kQXrTAn2pwHFQ+A+BolT9qwc+RS2pU7R0TBtspPpMadGx9MQXT7o9YBc?=
 =?us-ascii?Q?ZUQSY+IJ83OHV4ZqTwf4gRH1U19idNUV4WmA9o4oXs5oUMoZo++Znbxaq6ML?=
 =?us-ascii?Q?K1praNSGIPsmOkp1LLIzYqMNzWo1c0vGQYpf6ngomv5CjXxUwlFi2m286Foi?=
 =?us-ascii?Q?qnHgAMBd/9rlIgFrbaF0uoc66gcLlCV/2unkK2uX9aPA5Ofb/WOENMyO3P1g?=
 =?us-ascii?Q?FBIkKaN9qYECQf2fIPbTmY3EDifEnayQmV3e2cNzNRDGjwPEmVeDX/CSvzvG?=
 =?us-ascii?Q?I09KYDWyZJ+mFWWQYwofe86Dc4oH9K6hK2ufywfXoJKAHzw9b/jiSDwmGdmK?=
 =?us-ascii?Q?4hUlzz+RDvm69HF2ERituitlDWMDxxDU9VBQzPmxD4oaC1FMB76t4Xb+YrDV?=
 =?us-ascii?Q?aK4oyIwB5MlTdPwJ8+YPUEDOFl+98qgXX1QrkH3Igh2UKYuYCbqGcliqaYeL?=
 =?us-ascii?Q?9UA0wqL8/3Km3x/64+AUmc08gBDMRSDFURIYskSnYMOaRjCoxhWfHedhafHF?=
 =?us-ascii?Q?lETvaoaYBoY4NGQX8SJD+qWtFTNfj0QwlyHNTMKHOKBFOXf/qbPOf+5FU59T?=
 =?us-ascii?Q?mDYOJPbvyIdmnQN/ArLE/UOC5GuIDMpgokDJCrwQuISKB+FV/IjLU01Uk+PX?=
 =?us-ascii?Q?SiuQH5PAmwFt1m5NBdYhZdANk91yLy8cLAkK2H9E9UR0632PYaVeMunOh0/1?=
 =?us-ascii?Q?eyJJ0wY8tIqUNmAd8LHiavcMUkAqMnYhedFe84n7hlj8E5Ws2gAI/668FCzh?=
 =?us-ascii?Q?H/y3T9Qgrovhd2pnn0zYv2SMP1BkXHszVwHtomY1wMzlJwu/RjbR6d5h/Ans?=
 =?us-ascii?Q?nV8QMxp0yI/xKMjeSTdKL8EM73TTDJNw+ukszboa15c9B0k0cDSrGPxza8la?=
 =?us-ascii?Q?6PTe792OkFicLrimjA9wsAX+YHDarPDQ1uS8EO+UVUWHKUZ17OYIhxZAxMpL?=
 =?us-ascii?Q?nqjTAQF+VgSU1wrZUfTZ+UVazo+uXMOA8giY9Hq1byG0Clo16kdbs4IN7Sxe?=
 =?us-ascii?Q?cXMBPfUuxwDrGWo3NsoClOu/skTU5/bALM76vadpXi3TTjaeTANGQU84ycWT?=
 =?us-ascii?Q?AxR92jFcOGMFbw0M0fvGAbih/3uFF3dkwjwX+5cKqRmuiE8CBjCTgOdKhvB+?=
 =?us-ascii?Q?Qf3WSYnXS+1LiMLnuFGjtXnNjE0eHiskHJXJeEo3m0F9BE7jkYJrKZ1bxnbx?=
 =?us-ascii?Q?Lk9ngOM4TKOC0ddmNMe2H7YIob7Epz5aJjlh4v1fLcbHxkVBdzvgL2EGa8Yu?=
 =?us-ascii?Q?JrpjD3Gv4rJh6VCV6zKAtLv1fC/f+RxLUCp67hpVM4HWleSxVYje9h65x7JS?=
 =?us-ascii?Q?h0M2feZRsFd2M9PJhyVoA+uIUsw5FuTOxNUDJUWg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2812af-6dee-4d8b-04d2-08dd397ee662
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 18:18:55.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ar8gjdFEGVh6/HuUQtvRXaDdwxuwHucdwLZ9I40AB0V93w5eHndQ4YQj1NI20oR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

On Fri, Jan 17, 2025 at 02:11:15PM -0800, Nicolin Chen wrote:
> +/**
> + * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
> + * @state: One of enum iommu_veventq_state

I'd probably just make this a flag with overflow as the only current flag?

> + * @counter: A counter reflecting the state of the vEVENTQ

> + * ----------------------------------------------------------------------------
> + * | @state                       | @counter                                  |
> + * ----------------------------------------------------------------------------
> + * | IOMMU_VEVENTQ_STATE_OK       | number of readable vEVENTs in the vEVENTQ |
> + * | IOMMU_VEVENTQ_STATE_OVERFLOW | number of missed vEVENTs since overflow   |
> + * ----------------------------------------------------------------------------

When I said counter I literally ment a counter of the number of events
that were sent into the queue. So if events are dropped there is a
trivial gap in the count. Very easy to implement

IOMMU_VEVENTQ_STATE_OVERFLOW with a 0 length event is seen if events
have been lost and no subsequent events are present. It exists to
ensure timely delivery of the overflow event to userspace. counter
will be the sequence number of the next successful event.

If events are lost in the middle of the queue then flags will remain 0
but counter will become non-montonic. A counter delta > 1 indicates
that many events have been lost.

Jason

