Return-Path: <linux-kselftest+bounces-23828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF7A00030
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 21:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36F03A13B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B71BC065;
	Thu,  2 Jan 2025 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bh7Lpikh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF721B87DA;
	Thu,  2 Jan 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735850718; cv=fail; b=BLBD1ZEmFBimSUYKySKsqiPXXc2N4uaVotPnpp/5Fp9uuKyqtmWjwtyWy9K+WuUzxe0G8JRZ8Ao7OXk2W7jcGHLXuWeewG9iWOptVnA7l9q2YPrR2dDNlPvCvbpBDd8OdAPeMx7iq4bs3Y6IiyN65ms2Hy4q6KI6yfc6g6Mp5IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735850718; c=relaxed/simple;
	bh=oc+32OvA6CFBFFfEP+heh70YfzUIQ2kK+joxqUIpGag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=boQVz4AmetRhD7VmKzqwXAuwpx81EuPuP/9n0tEia9lq+C4l/S/nmf7/G5Lt/Sly7v56rJdfNoEpca9THb3aAu8ZLkGnja9re/EUNwVwllxkl6nv1nPeA42tVh7anwLUOUA03bF7Gqh0v1j3daDgmS/VCFJSdXjq1SjtvuwiNT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bh7Lpikh; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQVHKnCyZurFu2Bnvgf/VYA/l9UBPyiir2Q/bS9iyapNVZZq9Lr7BSV1m5S3vff20vzMyqlwJjH/ej9XTgDfwp0FTA1CNg6l5t8fbEnCecZOh0I2wWzsoiE/aNzPs8wyfO6UuD0HqeCl39+sal5gid2rEPyJNqOStnCxV/PBEl3XZRZJlktT4d10UsTCdHcwhdBvk3WS/uLAjul8HbbyhM5twDH8rTSazQNL2DaYqufMhgNQsK6Y62m26kA65cRLGRoiUlWxy24LLIw/SDLeKR3cfbpmHANaZtbaO+SPzQ/12gn6cdpQYlqoPjUmE05D9yA8k+F09RTNKegp6Yvnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc+32OvA6CFBFFfEP+heh70YfzUIQ2kK+joxqUIpGag=;
 b=Hw9Db6iMkXEGZbGgv8pK3zI7m60VGwcP3vjt6X2DiQ7Ar3V13zdlIpMo+h6hhRdIjC8/vSLcLkozEgwwFJM/NBvS1A36XHp3xWPIEU0MY2cWW9XIFZoodYX8FZyK0KLd7yROQMu1mZvFWLrYwKAPd+oCdnptrecQrxzXx00g+f7TFPDaTrtlaWuTEl5ZMRAH1nwsAwslcbXBAT5bs8YI9hgpuuJeGumFjcF6QLQnMFvWIWxU1WZbo4HqI3orJxewJo5uCi3yvzeFchDUrPwspzVYE9Achhsiiv/X+y946pWqFLiIO8N8I3GGxttTSDgm088XHiRUaRLcTs4zduoSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc+32OvA6CFBFFfEP+heh70YfzUIQ2kK+joxqUIpGag=;
 b=Bh7Lpikh2gJiz9rJrChJZDvmCKtgSXvn4siXW1j1SUinjNNTbnOQtYBlbemBbxArUy5TfRoH/pfVflNFsco9MNDeUMGbWazEAnvBoEiFrUY7ooP79j1IbCCDjHkcjNXzIVJiLUX111meJhmBbFK9tmtkLJclFy6OnO5d9slci+L7YspPk2AW86IjEwf6orxo6R0cZJ4yjcUnBpChTVyVjXUJD4Lait9vDGSKzRo2Hhvl4OgAi4sTllWA1V12eA4ade4S26SY3sj0tT3fDjSxDLNhR+6kvB3A+SMj1ISYfqV8gwhhtmc1OX/ZktrAXxk6MYqJNIfAgq48ccn50G7nQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 20:45:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 20:45:08 +0000
Date: Thu, 2 Jan 2025 16:45:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v3 06/14] iommufd: Add IOMMUFD_OBJ_VIRQ and
 IOMMUFD_CMD_VIRQ_ALLOC
Message-ID: <20250102204507.GF5556@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <dc1252de7ff06c944cb7d91c91b4f61c25182f91.1734477608.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc1252de7ff06c944cb7d91c91b4f61c25182f91.1734477608.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a09eb4c-5189-4558-1db5-08dd2b6e5858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uxc0mfIBerCuz5ViEbXVq9KC+FfOpoAXsbllcvwoCCIQb2aU1IcW3mw3bCuw?=
 =?us-ascii?Q?P5A2wV9cmllOp1keVXPNNQz07K4HbPwRtWCwjQOtiF1v/eK2UacpjL9cyJ/3?=
 =?us-ascii?Q?QFNd9LPuMXBpksLrYlK3hjV/1YRZ9CHkyjg5M+QO1mYtEk77AgIlzQj1SE5z?=
 =?us-ascii?Q?F3V5++AoP8P+QqsIc6kgeBZIQY6zjthZH9F73k9edIjKSbVpXj242EAJ3cro?=
 =?us-ascii?Q?cc3BSCTKFXbHjVHVCGQvd9nNFwUrNEi7xEp3GEOvlLYF3POdS4C2bQEKS490?=
 =?us-ascii?Q?/XTdNoF9VKao36EsGAh+vFPKuo0z/+UW/FQpOXvSX4COeEySHK0++g0LWoab?=
 =?us-ascii?Q?DZ2odo/eWvirZJVlt2Cm9x4x7LC4rAmTsJddAodZS19jdVl2FxG8uO5Z9YXW?=
 =?us-ascii?Q?gO7+yXgtXtD2ocUoRkcxOf/hvTn0aSS5e5iWbx/mcuQPdYq8hMI0n3iHUfR5?=
 =?us-ascii?Q?QTnGIcwvJ7XItNgogO4E2bSrNqTBmFg7pKRXUwyhngukrQnwTl2ykGQu36Y6?=
 =?us-ascii?Q?R2dqYWuUJTK1gxfWdHG7XU0Rfx6aOMKFEWht6mKENO4UKS+FmSD50Aqlxpcs?=
 =?us-ascii?Q?rDKhKARWGdpM4Vhl0XmH8cIMDqG3VN3QBLFSoOIQW6iMV1ASlTWOOnQm5znw?=
 =?us-ascii?Q?9Gprp8CYkqC2xrRVtKgsRcy7HYcGAiQaKsZRcR1D+6qiTSCE3c0hMzk/ko3n?=
 =?us-ascii?Q?6YCUwVcKQgubdE+sm3uzqs5R/ntL28NArETidgIk/VNhLRU5D20YqpQlXoVe?=
 =?us-ascii?Q?uq4wF5P4qCoBNX77sm29SQogQbEZ9P1pTwoVUnWkLdb/RF1Jj+dpYR0f4Y9x?=
 =?us-ascii?Q?FGL+dQwRM8uX+KVy4oWZtHpq3R/JIx/W2H4KOiFizo70NQYxxjcLg9CWxicf?=
 =?us-ascii?Q?MGGpD9rEYrqII6Q+4skhhqIFAgOXQOpjB04r845cifpJuRHjyLJePMFzY+ma?=
 =?us-ascii?Q?lQUQksQiHdmEaW32aWgU2cTfuxZrk02zMgY21m9iJOptjJZnTA8ySsbG0ajx?=
 =?us-ascii?Q?no8XMa34t7BZlLCeSlLYiMBQ55QOWICoSH5J4BAlfNzINS7BvTSwImju7qKC?=
 =?us-ascii?Q?vS3UgVWxL7EffyHzII1XRXg4933O0bJRJA3of1ShH4e3qQXbtol9PIve4q87?=
 =?us-ascii?Q?nSO+LI67WrBv/GM2EwWmpP9qi6Eb+ek20OTXm9lr4xQPL+HgN6LFVzl9S77S?=
 =?us-ascii?Q?8ZPInOFlnZ+jnp+R4OoD8V+bJonKKKd7EGuZNriq+fHX0E3ssOec+K8gQWx0?=
 =?us-ascii?Q?lLn86YVq1MGnzwx0YT7wde+pJiJHSRgWdGY6+Iu6tWoQ/Fv2GxVY5B36738X?=
 =?us-ascii?Q?Fi+Y+W7ef+3xiy6MYG77BZggDjO6tRRkO8MrahDp0uGJFtkqBhvW03GYkR1e?=
 =?us-ascii?Q?lYOYhaNPFcXQ8VLP7oKJRR7syRn2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DKjV6pRnzOCaJQJ9oQIR7YQn4kTKEnW/rRzZcPyZcJ0HsTb346CWMJ7OdPKm?=
 =?us-ascii?Q?uJbzdD4X4uNM+HIzHDNgQBsZfkLqABnmWxUKFZzKXVJtonu+5QIjjkQP9qRG?=
 =?us-ascii?Q?Rs92BC8p6Tz9CGP1Pd2R7QRmot9HcVzxGDTvVVit+34cP/WCjB7xjrTNy1aX?=
 =?us-ascii?Q?QkahmDiOjKBg+mh03+EERRWmjDd0D4fx8e0zfP2P/uj5rDzJ3h/w15brXDHe?=
 =?us-ascii?Q?yM+QttZgmpTSvDLXL+ov3N7QDmIk0ruiRwpy/b3BUS2VxUTMe7m/A/tB1BF5?=
 =?us-ascii?Q?Eki9nOLm2sNK8MohFBQFYm41MxvYMtdPf929+4k0iRH1aYJ7Yiw2Rw3pKWS5?=
 =?us-ascii?Q?lYdcjv1mTbDy9s4bl/SBAchpfAeRrBccEsrsX9mEpgneiFGJdOEQUVD4MYm7?=
 =?us-ascii?Q?cHeT/rdqir0mcl2EfsaIdVAeKHJaw19q+l+8Z5M/uqhMLdVeUsYWDiG8Dnxg?=
 =?us-ascii?Q?fB1lT2LhiTSLd/rR2lKKmcxS72+erOiW3raz9+vI0SrrndIvyMWyYSqZj3v1?=
 =?us-ascii?Q?1kUR1hNxpomQmfNqqLK2bNNYatksE8feoS+vy6fcts3w1DZ635OqQ3iiqWye?=
 =?us-ascii?Q?4e/VtNJpr61bnsYr1WxwUY9papKdmnOlgLS+cFHVmbwEj7H31EBDXjh/IUcG?=
 =?us-ascii?Q?hUvF8Kg/KMuh5gcCZm1YLpJY4bh30nfUxcNaEdYT8Lirn8x0G9cIF6TS/znj?=
 =?us-ascii?Q?uRNOSYANEsdW8aqBRwTKiLtdERnbaifCznUBXSghwJotCYlLcJLGY3fv9RsZ?=
 =?us-ascii?Q?JPQrygTVMg5mFSdUphNCSbt0z4YTLxXybT9Z3SnWSsAA0zmqLCCje4Q5RbEO?=
 =?us-ascii?Q?5MDukNq/gPFZKCdwIH9tawi7+RBh9uBSE3Ld+SSfj861v1KQYhatLjZy9oe4?=
 =?us-ascii?Q?INJjT54xOVouHuYdnb99iwGBNktDXu2fsn1Bl9AidmjkjZgAwF4ISHPCFB3g?=
 =?us-ascii?Q?Z2Lmanj/kDPIvG70bOLX21feFWxTbRu6Err+L+fxQilTGtModynH4W5Whz/n?=
 =?us-ascii?Q?jloZDlpTfxbNEoQKCMP6B7KG6fdnDsIpWl+2g2u0zPPzQzOtm/FyCf+yIdiZ?=
 =?us-ascii?Q?LVrg8fWfvgMVODfxVoFw6KqghOFO6FoaVXMB5wdMBSUp550w4c/f1sZPhyMn?=
 =?us-ascii?Q?HUlGtMUpjllMdD17lkznfOkTbnayQ/ft50Jt3DcySg14AfTh/OzxP7upju2t?=
 =?us-ascii?Q?oBdVcIG5mJbf44HRm66kbpABRScKzaXoIldM62TrztVYU1Glejj/owQWHSTD?=
 =?us-ascii?Q?GmSHJz7aLumv/Ty4jtdiOm8OT2/Y2wQP3KDW0jJdXva0e3B/tKvsUDhxHLa/?=
 =?us-ascii?Q?FBU8gSXh3z6+19/LhFvPmF7kfNeKtXZ/otuyLFfaUVkPI8FFLlHloMTHtLC5?=
 =?us-ascii?Q?lWwL4MDA5L4eX3FEk6CIuDNtEfAMMmE5u0y0e1J13uPKsQUP66OpPxkWBE8H?=
 =?us-ascii?Q?ChTAmYKCiKu39Svdqy4W8pwfPeqkj18Aa57oFbrTl/Kwg3mHw1BQtuVS6NCZ?=
 =?us-ascii?Q?o9p+VnJA16sdBf5wUK6btg8Ck2Sys/WSN0FDdlrlStGXgO5tao/vGif3NhHn?=
 =?us-ascii?Q?htQPOb2+TwfZDfZcfvi+MfW2x94BuoegKGbLxhXf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a09eb4c-5189-4558-1db5-08dd2b6e5858
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 20:45:08.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlWAuzWLK/EtFFrSDx6hl6Zz6PQenUgGJXd9jaNjR1PdxzFehlN02Xm3SlzemjvJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465

On Tue, Dec 17, 2024 at 09:00:19PM -0800, Nicolin Chen wrote:
> Allow a vIOMMU object to allocate vIRQ Event Queues, with a condition that
> each vIOMMU can only have one single vIRQ event queue per type.

I suggest you should tend to use the eventq as the primary naming not
vIRQ, I think that will be a bit clearer.

The virq in the VM is edge triggered by an event queue FD becoming
readable, but the event queue is the file descriptor that reports a
batch of events on read().

The virq name evokes similarities to the virq in vfio which is purely
about conveying if an IRQ edge has happened through an eventfd and has
no event queue associated with it.

Jason

