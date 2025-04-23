Return-Path: <linux-kselftest+bounces-31462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E3A99BDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 01:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A664C1B821B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 23:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7C1FC7CB;
	Wed, 23 Apr 2025 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CD5ILdyy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE12701CE;
	Wed, 23 Apr 2025 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450021; cv=fail; b=cC/fdkU6IUuJ/3ysp2BcLIdJ2c971HtrFG0he+rlLYc38k1vyN+dizdFP1amcMjbwKnAn9AnI5V8pmfV5ywCauQXZW+9Y8qU14q0CLwPBqFomeT9pNQaJQXIMgs0vY8BUYCCUJA5kI3Yamp4uRCgTHqGbERqZARf9mNDgYpaGOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450021; c=relaxed/simple;
	bh=znaFewy8vscRqj/6WiJJ77Q8sbjiaE+aZtTJ0DpkR4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EdKjWvXyWFxXx4RKAJftex33T/+Kg+baeiVFY8Ir1h9wnp+uZyj8NXJCOJ+QoLWiUqeDw5fb1eKleReTtkcOYZsYZl4J8siF89gu+GerrygvYSvdjJg6MPMUf8LgIQVfVlNfnamudOlbVrmuGHD4Va54dW1cAFQQbzxikOlskkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CD5ILdyy; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XALCglo/ecFqkhwd3E+xpY8qSlPOCZl++NJ95IJC6wO5dq8lEB+/TPRlzQFdsR2aiGOr2yNmPeYa2HSbBuT4tgkuQJidhhe0uyjr1M7eFWq3GIku7FP/cvJy9P9wPqUOHZy1iF6zaz6XbVIHJbUFBthf0e+qybHAPqb9beqI1rb2oziBnSLMaEkOYDTnZSa7HZZu9Syiao4bVfD1ArL1KG+TQc43Sq9WGgeOXya20c8ukKX09Edy+G6pShBHFJ6h8kwJ21gWdFDDAISiCClaHYsPTinzdTyLGYefOlY2OVSVWV2hqtDwk/ELfYI4IzQUJmPwVQQ925tfELbq5RcdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7FmK6qEFUDZgqJtuDYY7s98fV4vdP3IcCOYjjAkZuo=;
 b=yjPnXF719isjMYZZ00HjEo9L7N8LLWujID8Yymj19JABYQC8LXtETFsgFIyDZwT+H0iW8Zr20tEHBU4jexzF+eJRhmlPCvLseGiz/zUo/+pmbvVyossJ1IdjE9gXgxuTllUKKYRnC/6CCGnskeNzEwZoEfFdsUc+UebmIhAVUqvbIq+b2TwuQb6qQ299I93lm3PFSwoKK7GyB9Gfh6886YNDmYCWA7stJxrtaAuuj9Zzn9ILF5j+6hSaCs+VZ/BwuNvEpbC9SauYMPgPR+o2od1+ABg+9kd0FYp1cKqI83KJgEvxVleW/3t3dK6jGJfVdEhvfgfF/hM6/aEEv8vpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7FmK6qEFUDZgqJtuDYY7s98fV4vdP3IcCOYjjAkZuo=;
 b=CD5ILdyycsTEzH0+mJieJzW5N4FxNEcTvJb0jPQ24P2q4J02xETYUQ7Nn657iXtl/9t+n9mSgiPYa2g7YNWpn1J00hmrYpdZUl/CsdjSJnX3Bd48huM2aSwB7Rw2WV5J3ZkctoV0CQlI0+L8hzPIoqzjoHp7gt+Qz48rmwu5jPctEoB4xbvH/i8Q8ZLdB9a01yNTj7yvT2J5n9EFwdjQ/mXlRnsbuFIfiJsLQCIjUfkYvI11+VRxkL1fej6S+CF2vNNrcQpCPk/eiuxHT2Op1srip7UDS1fX1bV/x/UUDr0p29HfkDHkTmn6Y0jjZkUPb0v68EQqQOhw7jgkL2XWuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 23:13:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 23:13:35 +0000
Date: Wed, 23 Apr 2025 20:13:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <20250423231333.GN1648741@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aAaY+f2/jw9NaIWF@Asurada-Nvidia>
 <BN9PR11MB5276220C7B2C5743DC8364CB8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250423115551.GC1648741@nvidia.com>
 <aAkyAbO5UQRySizN@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAkyAbO5UQRySizN@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:208:d4::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b7fe1b-283e-4bff-51ea-08dd82bc78c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?faFpnCHk0siVsIIdPr1M1SGrO1q4CMdvUz6tnti8PmCrLIFYzZGYwrdK73Jq?=
 =?us-ascii?Q?2oN1we/Q8rEv60wwl228UGKIxhe8WKuTHMTciisOfWo8qB7om3ajTgFB0WEa?=
 =?us-ascii?Q?AxhqswcBGaNNSzOdV87w5S+5BlgazGly4KvENHKbI6eNhqcCnbIVN/Eyv8sD?=
 =?us-ascii?Q?qtFzKfq7bhT9pm+6aWEn2nb2E1pUG63pR7GCtFpZNTSLggs9VFmvR42MhYEn?=
 =?us-ascii?Q?GiuKCJyQAagFHeCZfHqTKp0pj/0sAGR4fGrWnh90Z19CAFQaGrkFM8IlgFw6?=
 =?us-ascii?Q?/k+32XD236Ou+CuhsMmbxkICRnVlsDjXH+bkOQs1HP1xq66Wa3C6hAT/tEcL?=
 =?us-ascii?Q?pRPab8sS4hFBgTm63OnhZhg/OJYqedWhEB7d1fE9fosUIatxCIl4BkOkJ3p/?=
 =?us-ascii?Q?Wp5RZYTJeeox9lnnsGSEBVLpS1eba9H8xHmDn9/XZxNyyfMNo9EeI3up3en1?=
 =?us-ascii?Q?WHXp9J5I4ycax5D5vq82ydo/y9d5yFDDqNHGJuQI2Xxw4gpjeomjNX9LtdAG?=
 =?us-ascii?Q?m6nF5tDwbvqgcLebwJYX3jpqJlQCeL67bAGuGatQiHRRpQMexyugHf8NsLP7?=
 =?us-ascii?Q?t+shAELnPtrEFRaD6n45BNZZSjuQtrDtepMUj5M0+KXAodH4rYq7xXDCJlkQ?=
 =?us-ascii?Q?VMUEg2UNfPVYjFrsaS0/B5RxreMWYtImSH15Xo3oLHWkh9fgrKmeB6Gsqk+/?=
 =?us-ascii?Q?HFWO7PKNIFritb3oSOkq1xrJF3ZM5fxm5ejmV4gHD/9fcqNTv+2XRkh0vquS?=
 =?us-ascii?Q?Dh9vHw9vXNrRKRtRNbdukA2PTeFWDN8hStrKivHyLKg2f6s03QlWR1JGI4oi?=
 =?us-ascii?Q?7q9MS8lGDeClfGhM89xeO9/gYrX7uD6+M/dYz8V+Q7jjG0qYU89E0n+k/fMB?=
 =?us-ascii?Q?Dvc2lICAUDnlgQF9rOb9J0ur7P+oduT6Lu8vdhCvb/X5tLDf4cCjl9LdIbFC?=
 =?us-ascii?Q?SG4ZWIXArYhKOPioo3UDdQrBm9JCncVRIF71Pd9qhMcOv0hNK6VwIH0SvJTW?=
 =?us-ascii?Q?x4lGYZbLehqBMngLfeVDHGjqHWaI5fxNoyM79wl8mekJUDALASPEh5PgotRu?=
 =?us-ascii?Q?7D45r2OCQ8RZoWBqwFPI/rHo2ucKxl2J2BIkTBCGXp4qBQeYdoMcsJyYUWUh?=
 =?us-ascii?Q?9wnr3izgtMeuvlZvWfz7KKpGEte2FHolNDS/2VDErRCnETecz/yaXfBZMSnW?=
 =?us-ascii?Q?otzT+P+WTPskjKHwn/8lzgkl3xNLtm+FbhZ+7tmG+A0vTOIl1FsMbROwGMp3?=
 =?us-ascii?Q?Lyz9oO0nA6G1kcCI22Q5gqndasktz4ZTTgf5WgfLabyQjkMcn1niNpIdKc5L?=
 =?us-ascii?Q?GPzTcUDgCUDZhauyDyZW1awjGXOqlELU3muVNLIb0uWmsZ7xCEAWZj7a85Hx?=
 =?us-ascii?Q?DD9v0GDVREHZ7uhONBe40rNBKMh4dt/Zrfhp8bJHZ08n0s4DYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZiS0bpUX1LOOyTkh9FQ2d4ZXTiAB+MNa5s4AgfWBuyQltFXz9lbePb9hC2y9?=
 =?us-ascii?Q?wyd/xeYYOZuPDdbeJMN654Oybo36SxsMDubyFSsOYDL3eOPkcWiqhoMm2k9s?=
 =?us-ascii?Q?18s5DxD8ctrbvT28JumRXvzvExZz6oFFfqzj0M85rFW7j0SzY6XBS5k/BbnU?=
 =?us-ascii?Q?RDwi+3KYAJh6rhzVp1fuIBl2fyQ98NamTh7qrHLDVjgYXUaA92fqkuTp95Ha?=
 =?us-ascii?Q?x5Xd3f5qLsEFxhxbPTWIrsJQhVYfZINgb0Q9ns8Y7mT3vkJwlFHHcQvUBb63?=
 =?us-ascii?Q?XCIvRAUrBStT8qqfnmql1AwXp9oZ8HLZWIV3gtBTd2gnkwyAU/mIg/Nk2gbs?=
 =?us-ascii?Q?GJ0DXbOrJn0rz/wHJYQZhYajNXwuuwNa7wR3efjl68+H87L5l+L55kI6QZD/?=
 =?us-ascii?Q?TMIU7HE1PP6Io2jo4ADwF52xpI8C5NNmqiX1cJPUc+I+SOdLHDOY7SfQjd63?=
 =?us-ascii?Q?kB5pIZecid8Nll0n2Qmzu6UrHRzYBngbmVpOCZ1I7E8Ob/H0U4Q1umpFSjIG?=
 =?us-ascii?Q?F2oLEmBxGend3Bkra2yUe+cO7WU+gCrH9VJDX8SuzfmETksDw4RM8CxXrHGL?=
 =?us-ascii?Q?gQBnapDfn8MGEHBb5qs5HlWvBYD9Vv2UvZNinRknOARI//lVZ4JnFDF7qdIx?=
 =?us-ascii?Q?gLZpHmQ9/c2JqMHh2ZlLXRbywfl+DTVLwK98vkhcF6EhgryezZNe5XOFwiIf?=
 =?us-ascii?Q?fUoCCV/dclJNcLqmPwqbSIgx4XIJjE3NH3faGNoGP2F6TFXMvTtDn6cejsXr?=
 =?us-ascii?Q?s2cS0SvBQf/HnmooxsplmLczd55X8DkSZYfoiZHw/N0GNim20ky+813rvSzW?=
 =?us-ascii?Q?mgP13Ow2jJacIxRtFk3SpHKdQSSVdZC26xP8Up+UkATFtMpOfzaEP97dYT9l?=
 =?us-ascii?Q?xHxW0pukOwQKuROLPxmf5aGEZmsW5rZlwEBBFKhrFPqyM4d9gSVyCnNW0z7D?=
 =?us-ascii?Q?J6jZUSy0+y59HVV9CqZ5nQ+y2NAjgGOY6jJvNCkHdPnjeot70OFYJSPBQ+4w?=
 =?us-ascii?Q?46/FovtaG3xapQ/AoMIQGeQp1m5T5kKbESNzV1fCPE9wLVQGXK+o4rOFh53i?=
 =?us-ascii?Q?pbL2ZVt3jwj1MABQfw/P4pJwuLzs7bByv41qp4LtU5SgUrfYQtYPSo0mi1R3?=
 =?us-ascii?Q?xcZXxT+DbR6+1svCwkaCEopZ1mUVsfFdQ/Ctuzgl1QVZn3BEFV+/KkTUxrRL?=
 =?us-ascii?Q?ZXgBJjs0ddkPaldjv/2/OCSmjb2ISOyb8a+T8oHyDJriZqNAKW19R0wYOe11?=
 =?us-ascii?Q?Kd1g5STHCkUnKMp7AF95KG4Wx37mlLNpnCGSIClGb8jX7ezZGpInhNPNwh1g?=
 =?us-ascii?Q?ds19/RyHHapIy18lNfxfwZ1WpEzbH+qHrqlaIJkl8uu6cbRB5NvY5c027LyB?=
 =?us-ascii?Q?PoGgdS5n/k3Yzvn3WUjoOiGqsAvET9Csnf9VP3CzcAu0/NbtSROstjGiMb0n?=
 =?us-ascii?Q?/O/qMPj8OwvGQHTrIUi47vApXS/0Ne39EcJKGDVnJflTFtSXlAKA/Lut9A6u?=
 =?us-ascii?Q?YIp2VndiXDfzrrzMZtcRP20n7uA7y/Hr6PW2k3ypczMPCqJ2+NzE14VpzsUr?=
 =?us-ascii?Q?jfRmO3Ftq1HIXtOVl06UFCiMSocEpGpT1trZEKnr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b7fe1b-283e-4bff-51ea-08dd82bc78c6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 23:13:35.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfRFiiTPTnmZXosSqjeZB9lHz+5zJHqifNraAQyUHmNkAfTZXfBnwV5xYFWJqGmo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

On Wed, Apr 23, 2025 at 11:31:29AM -0700, Nicolin Chen wrote:

> > It also needs to act like a mdev and lock down the part of the IOAS
> > that provides that memory so the pin can't be released and UAF things.
> 
> If I capture this correctly, the GPA->PA mapping is already done
> at the IOAS level for the S2 HWPT/domain, i.e. pages are already
> pinned. So we just need to a pair of for-driver APIs to validate
> the contiguity and refcount pages calling iopt_area_add_access().

Yes, adding an access is the key thing, the access will give you a
page list which you can validate, but it also provides a way to
synchronize if a hostile userspace does an unmap.

Jason

