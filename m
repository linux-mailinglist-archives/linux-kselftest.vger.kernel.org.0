Return-Path: <linux-kselftest+bounces-24892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6BA1854B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 19:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780BF161BA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212D1F0E25;
	Tue, 21 Jan 2025 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ulg/G1Tx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024B185920;
	Tue, 21 Jan 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484577; cv=fail; b=ObQREPsir1Hi8P2SrYLbx30ATlDDbjUb/DGcRiWhlBRF/7W2qjR/bbqkxi/Qk5H9Z+YbNDTxbNMBbm3jGYg1jp7wS68BGmeJZKX2D4cBXTmZ/vB8CtX+db0Y3zqv7MMI7BlV+/waF4JsLPmAbdoHNRj6ADbruadTkZ90jcQoVVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484577; c=relaxed/simple;
	bh=IGzLJTI9N+8c3I/y6seAbfxX+sx3/+ZFsS6QAkL1mFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XFmueBuI8ZZBRiqyTpfC7uAESe0jQk6aAJlybD1R/ojEkyF2MQzxx0+6XigFp+/EOT5EX6OCR4ozT7a5SVdAF+/Ar+YtgwmcDxJnQUm0O7JUS7J0XA28aIdufKoZ9GgGd5qGNpX2lOiBIiLpbTTHMf0GwUzsDkBk67ehD3u52YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ulg/G1Tx; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVQcyra55soRz4maIO04ov/A3OiHQjzp4Z5b1ncWjGfX1Q7vyRGGTRlaR4dE5PK1C5DsGh3in6qAztgWItvJULT6NmyU2rEWw1HTb+dEm3aKPXbRcqgLiXcOp6jqQsTjSpbEzt8/0o12MGYuWuXOOQAJaS/YRKhydFPlCJiNY/rC7CtWh7fhLIaaVLX1RvNGpcaIwmzY8w4qrTpfUDQ51C/fvdSxbwis4C6I7wiHi7sp+jHAwUduWIO00eRUMg2XEyGpXMsAv1HjuCmd8QlM83/QKcv/a+rrpS0DUFIbgkOose90UPa9Fi82plnjFfH2Q02jf1h5rSHre30kyWVX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZBrqwg/O122cP3g9y3vm9d3xz1mCKfE8dEqQNuFVns=;
 b=ve3+qQLnOGJAwUl8KBh7SCzEqtSJO7T9p6avRqDKx1in5NZaCVSvyHjBcLaIn10jEhgkhQGWq28XF1Z8ydfG/oASGJQNovHTt5L2IXA9Kfb+Q3N99wSIKnnptdpFXY2si/BC+m43GV5Pir/aE6Jfy6bjPPMVyx5o+0G92Ufkn0lupGQsRk57vg5O5GNUZ3jXr8oP7mczYaM1UT95dLA0nBFwdVWKXtrEwXzFjkvxUE53lnuEn4PmvjGFdaRRfwPJjziHlZqBTreFjB8DLwLrLIGUsv5QvpAcU51HXgBIicm3FcveGvgeyqjVe7jKfEKS5Y1FR0chOjFtQAGyg+xMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZBrqwg/O122cP3g9y3vm9d3xz1mCKfE8dEqQNuFVns=;
 b=Ulg/G1Txu23aC4qvQI8ScFvkPE6mxI+R8tQBD64emAFYoxBmsSgXbzigqscHL2NR+vyJix5z9JkAkmRRik14VenpQzqTQvwxIvEd3ASBZOWtLGpu40WpvGTLC02JzXetKoxLEL02fk77doBBSpT+gnvG7AO5uIDxKsSX9cqrCb9bKIPrwkDYkyEGEUVUVZh/KM1zyPbqxR/9TSZd37y9/mhTt1ccBOqi8TTR5JEkJjXRKOB8zmOE3i+2b2BJSeaS1EwsjXC/oAWNJKgWJyjXPDSI1vNJlep2lLVjSWAvVfhOAcGth7JOq+mHgYK3XMoXbcrn1tk+Z2BuZQKVGoVLnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 18:36:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Tue, 21 Jan 2025
 18:36:12 +0000
Date: Tue, 21 Jan 2025 14:36:11 -0400
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
Message-ID: <20250121183611.GY5556@nvidia.com>
References: <20250110195114.GJ5556@nvidia.com>
 <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
 <20250113192144.GT5556@nvidia.com>
 <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
 <20250113195433.GV5556@nvidia.com>
 <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
 <20250114134158.GC5556@nvidia.com>
 <Z4rVg1Xg5TCiFlSb@nvidia.com>
 <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z463eXfgNArCOfPn@nvidia.com>
X-ClientProxiedBy: BL1P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: c31764e5-a42b-4f2c-9f22-08dd3a4a7af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5yY6/SXo+OJ+2zTfqWgss9sGWX+jdvaNivNXs5KiEYI3hWcwgadFeZVLgBWB?=
 =?us-ascii?Q?lRLvqV2ixT0iIWZB8O6Y9fgm/XglKe9GGwVnvSGqfXYavTVk7yvQSpAREPIf?=
 =?us-ascii?Q?sam5KifZrq9VZZ2MVq/3oTtkU+O8d1fUYnklgNFoeiIHaeLU+DTG3ZGO1m3a?=
 =?us-ascii?Q?j449m/gqyscGCgampMdKMnO0XT8l9QuTXWybk+4vBYs1PUPTMqq8ilPUq66d?=
 =?us-ascii?Q?NxcWxnwmbNxZwrcYhQnWAmRXdmTiPpRQINX9OzgpgpxOZvPUw9ke60VHbTXa?=
 =?us-ascii?Q?WP19LwoN0XS9DKhbycWbWz64f/ykD6cCBbszR8DK8PJxCjTzxaxx7o82x0qn?=
 =?us-ascii?Q?n40C9gwzmHecX/mwKrwmw18Nnjmrml6IKUN32wsrp41LeReIXYSLjRvILanH?=
 =?us-ascii?Q?n2U+xqotUEjN+LEk2Ayq9eiTEkvrVA6D7SOZxbiNgvetVYSCduo+QONCPtuD?=
 =?us-ascii?Q?GLHhd7BnB1nwcUywkA1M+Hjv3TDeGqkCy3UeOuaDdKH1Xo9QvyoJ+enjFDis?=
 =?us-ascii?Q?SokS4aikX6T//cjtNRQa3+11WzeZ2blDJ5rKFdeWrKHCOI8zC9fVerejtyAY?=
 =?us-ascii?Q?4X+54jyLNFsCtspCYFX8lLYA3bhsdqZQYoys2oZdcE+afAc6/XFFISTExSIT?=
 =?us-ascii?Q?jcWFB/a0PAk7ixk6GYboNUwKKjNpBhFusA4PxmAagOCVjM72OMFjEUfvVXon?=
 =?us-ascii?Q?vDEuF4RY20iaTJXGZ0ycqgJtnkPkiOTjn+eWIEu1a8r8hlmfei/NHh4XmT/Y?=
 =?us-ascii?Q?Ja5IDOaWVWX5rfvorEJ9pRzbxdkEc1UpoqCUJRhV0aPOY9jpBV1QYcLEPMM5?=
 =?us-ascii?Q?TNyhCgoyuIOuBMAkxDYX8iywvF7+q3rG1OSzVY7tqLy1gxDaXB5R43hQ6vh6?=
 =?us-ascii?Q?6vISMCx+b/nxY134xT6hbz/KzG88rdYKhe1sEIC+LjqmmGhEJDXA/cV7ozHy?=
 =?us-ascii?Q?UaVONPxP5ZyEfiKHcwKOxrCY6wvAl8uRd2UYi48w9r4EvJRxz1mA8bhaJ+Xm?=
 =?us-ascii?Q?plUjLMpvYxMkmX8Pyj+WJ02xQgDsSujhjKO6PNr6skQtrAiWcIPupuvrfiEA?=
 =?us-ascii?Q?wi1GB3vwyqKJSsLuXb//gY7fA+FSlD2YOK7Lrq9JCL/mBtuKQ0sTuZUgHsZO?=
 =?us-ascii?Q?IrG/PYFCuHDtYHuh69W2Z8XU/Otf9dtBcgV8jlu9/nlTvu1DFFNvvZUa5XZz?=
 =?us-ascii?Q?V9bMrwG4ThBc/955GyKZodAfAAA9C4mPSJmeGPen4xHpEK31O4UHBiB0vhN/?=
 =?us-ascii?Q?NoTl0oCJtHdica6HpeHtFlxgGtuprKRFqm2fJSmffayQrALfPR/eSjXMmNM8?=
 =?us-ascii?Q?qBy1bY52i2oOgVzZQWNWXHTDVxZzBMfkuxPl1sziyZCcr5k1XrECsTm6fS9u?=
 =?us-ascii?Q?F6sLCQZxtnJo8sPcFS7dORcP0wuH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TzcOrs51N35UnsdjyIc+q6y29dcxk7m/lR8gPgTiDHS3A/kvG+5LT8Wdtwf3?=
 =?us-ascii?Q?ObH2n0R1w2BmANbdVsH7mibZXOMHXgtb5usxcqSBsTh8A3rW3XrnA8DchyZQ?=
 =?us-ascii?Q?wE8AY9SLZCggGDhf5DWjWUtxEI6WKQl5C2JfgRTB+l72fJGvGl06oXFznCJj?=
 =?us-ascii?Q?z12n6oIb9/qLGzlAo+qcdGBbnhOuM+VQwFDYFiXFR2LZH3ApeEKGmhNgqYzE?=
 =?us-ascii?Q?eEas0YUqIOYBM1iLbjEhNVp9sqcymg/7ft/t/XxK2Ap6r/CPzAMvFEgjk9VA?=
 =?us-ascii?Q?W5UzM6EK0p9qjNuATRpmJW98pxGYlZAx+JkcAnbE5+wFZFmvIhPq2tyxW8/b?=
 =?us-ascii?Q?8dQkUb1S9kL3sV0qSiQ+DvcN6Kl3Tcjp54jtClfu7sF0KCfjxGU2yiEJ+mro?=
 =?us-ascii?Q?RF/TI1l63Xt7HNRXJ3eOuNnL0rLjG8bN4Y6wpFT2I1luC7NHrM1N2hq9HuQU?=
 =?us-ascii?Q?4HFn96RiGT7vk6Udc1oZky/OthVxcSyvbiZuRq5SxgsMG3NGJrRnUIuIZlUx?=
 =?us-ascii?Q?Bv0PEbx1VYdf0wjs6bB5J1uy5pNHqJ09zii47qnKbHrdizdBZw1kmyGb/jeD?=
 =?us-ascii?Q?O4w/T8JrYjBslAwXNT0qYlOwQ9xsxY+jGOUWOh50QYjrfWm/3sV9rzI5rERX?=
 =?us-ascii?Q?vfHIw1AI+Rn64gKmET1fcEOuKSZa2Raz1QUt2+TFI6vEM2za92G5aVhhrkUi?=
 =?us-ascii?Q?W6qFqn/p7x0X+/I7mQdq6DlJTL+xl8j4hL3NdSdRfdcEZ6hAnLP7gLyK/wqT?=
 =?us-ascii?Q?LGmj8yJGa5Uua1HywzaIOqtBD62MVuh3xz9Ol8tacfcb0N9U4ERsGTCpU0zA?=
 =?us-ascii?Q?X6+nT9JEXr0mpZ5BupjiecQn1keHJfIg5b0VGva9+/yp6n2Iu8UCSXWc84hR?=
 =?us-ascii?Q?4/voG0BYEk7pdVr480FYR4AbNe6rks8TKOI/EoldHo4ifGka8RLFjXTH1Owr?=
 =?us-ascii?Q?tR7GYURS7Ab4GnXAnajIudNVn4dCP60ZDd1yt18owsNqRH8PESBn0MscBJYK?=
 =?us-ascii?Q?r7/Nk1FjdHjmMXHnLhTfEi6K9fINmRyMIRt5q8K7XTX7NCiOpLT7elNVDciS?=
 =?us-ascii?Q?SX3aUBh1q7ocQrFITDVZnVqQxwVRYRRGvQ2d0zwzCs1TWiPMPZjvyOnBV9pQ?=
 =?us-ascii?Q?991rJ6RlDOx+KUl5y3OUxvteiRSU38T2aoJK4IGuzirQ+SbcBvddhVypXoWp?=
 =?us-ascii?Q?ttVKGjwWIBBT4pbm5Tvw7kqLYISMwLis+po4DO7gLPisqaPvwSl229qreFJD?=
 =?us-ascii?Q?FXEQhExqkVidjKqU2AeMWLGUV2G7iGp28W4AdcOWKmDX/54aagha3vbp+hXa?=
 =?us-ascii?Q?ob9fRlq/WMEN3oRsiTxfg2NHdW3R/4AsY9WW7PuXGeODNh0Piae4xKtUawGj?=
 =?us-ascii?Q?HaIZz0uPw7yGVxv49C/Z7kWp37PWYJwhq7MvuJhpKzTHUrWva2kOb6FeZJEa?=
 =?us-ascii?Q?C7RluqGrkR58HlM8TFiXUSkdWkvy1WozTuuAIkbXRGwCHkPBDw4HNbaXZKkN?=
 =?us-ascii?Q?hFyiuZy/G9Tc4ojS96ZbzbvvSg7VkPG2O01/2aFuUoZHq07Xfy/sXrI5/kfq?=
 =?us-ascii?Q?3udPsQQhcQhpsiN4A+zX2MnN/nWCRrTmOa1JkupM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31764e5-a42b-4f2c-9f22-08dd3a4a7af7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 18:36:12.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2lMR73iZZYxhDKUyjPKvhq1YgsIToGFz2vvDK2pQMUVZfBZ+wPETcZlvR/K9Kh9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

On Mon, Jan 20, 2025 at 12:52:09PM -0800, Nicolin Chen wrote:
> The counter of the number of events in the vEVENTQ could decrease
> when userspace reads the queue. But you were saying "the number of
> events that were sent into the queue", which is like a PROD index
> that would keep growing but reset to 0 after UINT_MAX?

yes

> > IOMMU_VEVENTQ_STATE_OVERFLOW with a 0 length event is seen if events
> > have been lost and no subsequent events are present. It exists to
> > ensure timely delivery of the overflow event to userspace. counter
> > will be the sequence number of the next successful event.
> 
> So userspace should first read the header to decide whether or not
> to read a vEVENT. If header is overflows, it should skip the vEVENT
> struct and read the next header?

Yes, but there won't be a next header. overflow would always be the
last thing in a read() response. If there is another event then
overflow is indicated by non-monotonic count.

> > If events are lost in the middle of the queue then flags will remain 0
> > but counter will become non-montonic. A counter delta > 1 indicates
> > that many events have been lost.
> 
> I don't quite get the "no subsequent events" v.s. "in the middle of
> the queue"..

I mean to supress specific overflow events to userspace if the counter already
fully indicates overflow.

The purpose of the overflow event is specifically, and only, to
indicate immediately that an overflow occured at the end of the queue,
and no additional events have been pushed since the overflow.

Without this we could loose an event and userspace may not realize
it for a long time.

> The producer is the driver calling iommufd_viommu_report_event that
> only produces a single vEVENT at a time. When the number of vEVENTs
> in the vEVENTQ hits the @veventq_depth, it won't insert new vEVENTs
> but add an overflow (or exception) node to the head of deliver list
> and increase the producer index so the next vEVENT that can find an
> empty space in the queue will have an index with a gap (delta >= 1)?

Yes, but each new overflow should move the single preallocated
overflow node back to the end of the list, and the read side should
skip the overflow node if it is not the last entry in the list

Jason

