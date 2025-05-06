Return-Path: <linux-kselftest+bounces-32509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB2AAC4B9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 14:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF3D1B643F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966A27FD6F;
	Tue,  6 May 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCtssXsx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1E27FD5B;
	Tue,  6 May 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536145; cv=fail; b=BZqT6N21BifWNkd5mSYhGN/Wx71QpU2ZAjPiQK40eU9C5quDogW3vRPf/B+QGV8hHLOS89D6ihVn3jQ7KZtulKcwieORjXgqZx2pwgi6YD1AtHtM/CkksrXYrYEsj82yq03fb9IhRNCNepbK7VhA2bCl7sNlUJL7/4SK8e4SDKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536145; c=relaxed/simple;
	bh=gpiIoXbw9op/s53p7KoQEXRHRWJFz8/f0LgzM1qq5eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtncxXoGKCcYrbhKgRl+uxbyR335BfBcjBWbu/lt6zsr5jyIDJQs+QUOZBabQAESgZv22igUH835MeCe76m81EISAt5AvZQHg0Ih0IgSNRT/vdwpq9F5NUV1kJ86Ppcntfd9bXZP7QD4KFfM3L0QbQdeOnJ7uQsDTkKr+JwCBpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QCtssXsx; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tzd+eJHLwQILvqUBF2a/Bbrw1xU6G0yfGGBG5eJWQtxZeeq+Dj7EdHqF/uZr06QAZCiFwSniF4GcODo7yHk/YZB9eWwAxydFyJ4L5Dpb5taeuKkr56UR/IrwUy2sEDFfHQuPriVIsp31X3fxRAJy+d8MwPjpYRmRhVvj03PuOXTSsatzbsEEK8xpWdsvtpTIbaqMfnT5TgXjvPHUnZF6aeb3z+0LxMSNyzm99YcLR8xOqMj88XC3d8qFWlj76Oi/1vhHq/Ns6HI88xXz5LpffecwVcMg/t8156x7c8b5SnHgTrs4Du6poZN44VjxLn+JfQGW+5pt/IXcmgxdlbmDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CeKdELFEtKqoD6jWMI+oFnn0WaIXtBwP1CwPrybM4E=;
 b=lpLEl2+cg2yV59cvrE4gRaAQI9BWA/CP0pXMzT5RzJd3F82/1SSdw5/g9Fw8ZyfhmJ/lki3RDtMDbmYgTSFLjOLK3nUyUuIm+G35n3jnuIe5M+7SeJTDkN5kOe3roOq/1lXh23BSl5G9577QUd8oAyJjFYZrXEVbD/e7PtfZWk+EoZ+oPW2qar6z9yGDiABNStPSvfWpBc3s9LDeaYbne/QwurFPKHge9W6xIH/DcR+CQxI0UNde1Ht9haQQS/+8EZdUez9l4nUCYflFqQLRk3ha3VoQlUjtkHxOM60lGtpcQK2ogUnKhMVIsKXaCn5MyBqcZ3fatJ9U+QySNZiwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CeKdELFEtKqoD6jWMI+oFnn0WaIXtBwP1CwPrybM4E=;
 b=QCtssXsxO27haJDeSOQg3VhEKs7AhhVIa1OlAOLQKVYMyHzFhGcsYJdbgmTqOwLznkLh3onSajxiMo6eK96AcYCH4tVA9LiAlLWW9oKHM6u9T+i56Vt8RjVdVeraqrVYEGHkfE6TaIrvv2OG+nBdblxa6Uz6v1iGG5Rd98RS3LXnWcAy4GhV2m0BU9WCcf6oo2N8IIcmXEPoTh8W1PDLakWRJ6Sn5AggRRPHwULG5xHnwi4KFxrpBveA8McQfVejk8Q0CBPF+GrNNnDlkQFYg5sjpa433+mQCCZcKWgGA8ci3E+KwjLL1MMPCjox/ZCrdp+HzrH0QJj/uZFhbIrTHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 12:55:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 12:55:37 +0000
Date: Tue, 6 May 2025 09:55:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250506125535.GY2260709@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
 <20250505165019.GM2260709@nvidia.com>
 <aBjzf9PrYnwF5uZN@nvidia.com>
 <20250505172813.GS2260709@nvidia.com>
 <aBkahmXQGxFC0Fdw@nvidia.com>
 <BN9PR11MB5276BA11CB8BB5A46E118E558C892@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BA11CB8BB5A46E118E558C892@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0346.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8d0cbc-0911-4557-7982-08dd8c9d4bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J1K4CRa0PkJ6ISwBb42RRV3oPZp9liwcw0YosnVGwSJzDsSfY0GiWd99/rH8?=
 =?us-ascii?Q?DClvOODQeRAxZGNhdCVwz4iggK5Bb/5NktSDJhVBqsJvobwJ7WD4H1OgdrRt?=
 =?us-ascii?Q?bzGNGcF5ssddswx+jffYhK9hFiLbpv4+hIdMIgPEuywBdOMi45AJhyBSU83X?=
 =?us-ascii?Q?P3n3csvJe4pcqKEsQiSwfUjbnaul/1EY1rkTXedYcu3qns0eboheHXaKwdMh?=
 =?us-ascii?Q?np7Bet/oHxtT3JbaAklb7E81+ec49rwj1o8JpnycQhkknKlpQf/cNclQJ5QL?=
 =?us-ascii?Q?xCsbx6Bu0zmRwX5Wp8SBZrdeVgxHRaXivDPIMgRAbDfH70WTrENkpW1MP22b?=
 =?us-ascii?Q?G5YB8Wif1WUdRF8fRFTBDaRWWUCSMEKZ2+Sce6rouSqidRud7CHxwtaEVlYQ?=
 =?us-ascii?Q?m0ongkO1FAJBh5xdBk0t7s4SdvapZ8P0qru096m/Luhwx62EoKZBPsEK0lpQ?=
 =?us-ascii?Q?xpO0FIEDR6kVBY+8oxoOcpPP97joEq8J2TNZYnkz0ZOp48y8Rq2xkxgDWRlt?=
 =?us-ascii?Q?5M8IRL7I255vA2+CgH6H7EGQ+nCsrfTks1klrJBOhzpQ+bc++E205IzcGGWy?=
 =?us-ascii?Q?B7qJnDF1gQ1N2APfDAb6yOjE5re32L9IhGBLdSYjkgWilsjC+++sSwW72IZd?=
 =?us-ascii?Q?c5a5ytbn6+EDdwyYW+LQTDFU4QcdJHPSjTVHzyR6xqo3sWIJF5FHkP8BV7A3?=
 =?us-ascii?Q?X/wxtgAuohZSwNSU/Dqf107V9Ksq1qP5P38B1HUkuXykHYSJZBfZ+QqGVwL6?=
 =?us-ascii?Q?iZlQ/XnBAS/SGornfm41IQRmoHMSkbIRDrYuvRN/ihxqjcNQPC2HTfipHwDY?=
 =?us-ascii?Q?1snK+6vqouUzE4eNgp0ztL+Fy/ogx6f6X9E2l0//BcCgxxoV67toEPVHZ9rU?=
 =?us-ascii?Q?UC0Y1c0X71j7PJ4SYQ6rvp2iwHWw6PCGjN3pA9bhvKk6/HAur+c3Lbh8FRky?=
 =?us-ascii?Q?qM0FhCGTd7aMrUM7sIKypoyFp9DEpbpDpoKmxurW9RgBuGygcBIK9PzUbgX9?=
 =?us-ascii?Q?GcJeSZ3ZWOgNcuNhbA6vCfmiWNHHq0pWNn4u2prNLtg7xtjSVDNP3uVadQg6?=
 =?us-ascii?Q?7A/XBZpOfZ4B3BlzOQCA4Zzn52SEotrFeHx77HmH0lPGs6MSHQ1IEmC07JZ9?=
 =?us-ascii?Q?WxN9CdDBPbNl+3CYYszvLtT0JvvWwjTJLnbNsin4KTzabjrQjzkziYsQVt1H?=
 =?us-ascii?Q?MZkYWujTeL70TdkhEhcHJ1yLf48d0JRFJesHMXgGVDu4r4xA/AAcBArzCQ/T?=
 =?us-ascii?Q?AjESc0fbS4Ppo1MIAIbeloB1qRh9M1lLcChuoeve9GryJDT+6sG36BcX96K9?=
 =?us-ascii?Q?2Dpz5QKXijwqvZLomieIWvPWOkaTr1Mn6xd/XLu1CsUw56pVVn+ItigoXDgB?=
 =?us-ascii?Q?g2TuFzgEDHNghRL14zs25NMZ9SJdklf+fH9f6+S4gKxroZFwIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BR0Ir4c8oBENdy4BpBaTEhq6cho2rRpWSkyIGVXXM1PnUdGUNfReeaU26tNf?=
 =?us-ascii?Q?1OBjmo/PEtBdjjKz40acj/9nVRESdlHS41eZ87oy+DnSKklvgont87YFKl3a?=
 =?us-ascii?Q?rZqWAkfv4XROYDgqpLkwqeG6GGW9RdlmMnb9ohXjh7I7M9VGcLSf2swZ1JTQ?=
 =?us-ascii?Q?Qyq9aL+DxobOUWnVVtenLwdbHZs3y20/qWqHZ2vJPmFAOZYNnCirUUHdimbi?=
 =?us-ascii?Q?THM2iABalkBZLdDZW2xomx3D1BTmUFYUmYw10LCK4QmAuMBgIbhXJVjfQOgQ?=
 =?us-ascii?Q?ZP7gZT5fWfiiMFO8JTfOUc/+WOmrval3eT1huYO/fep4/6jfC5YUjfNT96Ef?=
 =?us-ascii?Q?H7rAqziJajrY0AQAPdegXqPNQZTcGAZFBMpOS+MEaX6hNaLEt9j3b5HzFmAM?=
 =?us-ascii?Q?UXmZ62w22a1LVJ/4PoG5AYO2bTzwJ2WsnLzSFUrthZxkYG4z71VZe7Rdy4l1?=
 =?us-ascii?Q?0cZybBHqkeQgKFnenmYyFGPElRbSsgq2NS625gkBRR7HVIRIoATY1ckvBVkb?=
 =?us-ascii?Q?Z+9uYWUofyKAFKmASDFXYUBl2n/tx8/TvP2TNO/+tDA0RSFjeThDZZgwqj27?=
 =?us-ascii?Q?96lAH2mGV9K02bttPtwhyyiQIAmsG5hyOKmk5dQ5v91pS0M9hv9l0zFiY+5v?=
 =?us-ascii?Q?Gr/F0YtLoZfD5Q9j9gaaVpT0YLoUuz6WJdAH4JE7DaSPuhjW2QTs57/c9OPW?=
 =?us-ascii?Q?M7NkhsO4MVPg5N+zx20yJ3rJ8nMcEPHEVYeeb/J3yT4Yt5g+JWXgmGCHFvFZ?=
 =?us-ascii?Q?73MV0z1Zo/iamIOOQ0fOxvKE3jKv+UbS9ml8gP9ZY7XoDieEjOhb/65d7Yzx?=
 =?us-ascii?Q?x1NwQz//es8QUp/ZAzbAEag30j1p++Kx5UtrXEbUGO1tPaN37XjeyhtxjN5T?=
 =?us-ascii?Q?uk+pIX3a3A2gr2wcmvRCmvoUr3a/pinWlT5FU3Jt3Gc2/cmu2hIv7ehANsfa?=
 =?us-ascii?Q?L+RRPebrwWzIyCopF5JpoFzejuOqDNH9NGcrEARh101PuUXDrYKSWzrPQfQ8?=
 =?us-ascii?Q?blHEUuoTpcaYT/9A9WmSnjrccMiVv5VPata2bLAn/bfnJ1O27/Owz7Hc8AuH?=
 =?us-ascii?Q?0vQDOPSWeOvkg2zfUrIxPKHzYUyEqZ9J+2ANeMtwhyRL/wCN8scKu8syI+X2?=
 =?us-ascii?Q?hHBYpJdCjkmk42psRYxyXN8cPOFkXidTm1VE9ogQo2CTFLdm8riTlZ1thhgz?=
 =?us-ascii?Q?0PHk8EOg/BQhOPzBjpSnazo6TZlxvNZ52UiJd47JWqEBRX/fQ75D0gFIsvAK?=
 =?us-ascii?Q?qvuYc+iifBWnJzWp9bbb8+DTlpu/D8NT2vWUy0DeSCRY7ia5CFxWpJNwHWz3?=
 =?us-ascii?Q?8GLyxjAZxTQxsLCfiOwpeMatwsuwSCLSTbKSj5MDrIKqr5gUYb1xSodGlWye?=
 =?us-ascii?Q?0lgUMDXpPhK2cUJE+HJUqNOJe5pkMcKeTtNMhTgsrFxurB6hz/eTSzl9d8hq?=
 =?us-ascii?Q?Zn6mx3hXqLoeAWJhvNEv+FmQOSPJ9NmqG9KbAqfXP/crUzn/TkUE6LYb/Upp?=
 =?us-ascii?Q?kfaundXd/3uxsnynkeRgCRX590FIJ2EKC0UXxpnYj9m9ifMIGJaYCWcE9EBi?=
 =?us-ascii?Q?RZGkMgRuyF93s17iUtRcxwMZ7AUYSHo7na4IJ570?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8d0cbc-0911-4557-7982-08dd8c9d4bdc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:55:36.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieiGCYz1gUq7qnDWdiPOiLqCfkRQ2SE87Q0MER+NPPXYuwtobLsMHtioWpjljSPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

On Tue, May 06, 2025 at 09:22:55AM +0000, Tian, Kevin wrote:

> what Nicoline proposed in v3 adopts a similar policy. So it kind of
> makes sense to me, except that we should not return -EBUSY in 
> vIOMMU destroy ioctl. Instead, just decrement the reference.

It forces the userspace to unmap the vmas before it can destroy things
which is not so nice when it is easy enough to fix up on the kernel
side..

Jason

