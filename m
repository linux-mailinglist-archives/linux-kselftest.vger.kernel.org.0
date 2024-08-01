Return-Path: <linux-kselftest+bounces-14605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C380E944719
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0CFB23CB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6747216EB6E;
	Thu,  1 Aug 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KS1IzDTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DC157469;
	Thu,  1 Aug 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502418; cv=fail; b=MR/GTaIYQF8xO+Y+zD6uIkl7cnJLtiiD4gdDRr97IhZNgedQ7GnmgpA3nwYy7gg9Y4ZR6cx2WS8TNSgo+f2o059NP7oYf4GIY2P6rf+jBNi0jOXDUyq9vM2oim/DwVzCvGI7Hl3DZkbEyZUvxreV007kMXcVrCoFAVHgYVossYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502418; c=relaxed/simple;
	bh=aKXxp8epc9OqT4eUxD5yKxhFk9Jjj697TV4CS8fP1uQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tsvkDRfIBRlGU7wFt/F8h62WvEq4LgDJHfNjE1O8GiPBj7ElnJ8cW7Vqt2L9YtvYFkFWcqs7rAog4+i+ifXqb4ZlVq/OQaD41bNHUIvPsN3XUSPQrgcdf+ONFCA1JNpW4C9e7dk40NVH0aVxBFJF/AYyy5stRuWO9C5bMDCaofI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KS1IzDTY; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3rbdlsg7vtmEFiXPsMMCgpyzWBIiOIPyJ03tWIHIgxgOUi+ymGbCKgk5rn/GjYvFgukKkHW9ZaP2EFTmiqZLOTIdFBSPP5xgvzvm0+q7ztNuWkuuzkw3TGbv8TLenZPlVXAxcHlV/3zwXQzrWaZ0s60c/eB77X8ghTRgk/TUJ82jUMMUvWomURCw29WSPLgcOWKh5IilcQmbT8VarRBoJM+d/cXhF3Vv7QHxzIa2Xv9dcwSTwaeMQPqF+DAH1qtUd9RhSLmgiEEKOUK2lInydmrNFzRZtpFWXpp9q0tvKZHjTghl2asgjC44g0aukwSXj2qkQHcMo+KD08R5Ffp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz9+niyl6poTw+DZXb8l1wrhHuxT6VkLb4IvzyhtfgQ=;
 b=EXSj/bh3LhjjM5ZN3HQlWFHAPSMEDt+V1fdzAM8bk1c/qvthMpS4xR30txYGMAqHFlTi/Pe/rG66rLoWw8zcstjPXs4qh2IYkmxfzUnU8NfORM99Q13TyJV8ti/xglDitiy9dNN5qr1+JtnB9tkkkw3+6CY/J1aZPxy4kiIS0dUMorqmn1jKbRxYhkMIdbeiszJqSfRPFaCrJqEjtH2lL5XZhRuduSytKym45HYAnhWYjQJmjwmxb89CUWxUCh6mJOaLlY5o2qa1wkKtK9aGP5nydO5OjpKcmkzIpm0h4EKurYvhmyvJa/6pW57KE37Wof+YNkCmycNm16vlGXYq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz9+niyl6poTw+DZXb8l1wrhHuxT6VkLb4IvzyhtfgQ=;
 b=KS1IzDTYsM4bqzWvqVX6kXgaonF4iuh/upCIdqLCTkoAprSiAwagrab26GEdBsfN68lX8bHR8kqkIdKLmqZk6VbjuC8+s0c3IF434MmKaR5qNlXgQGBqvnJNBwUds6J8+SzLg6zrJ/+Tb4HQD6wSf7znwC+LRaLX5PPT615XjEOHVY0d4pfgHcL8zmvVlx3/7Al3BMph32jqE7xO5xxn48AveefQVANvqCmLDEW8T7l12AadjdG5YSQYMU9yKhhY8qvtShR9m23m/NM/FpoyaFJ/7E8SgAt9g/6hvAdpljw5NIkPbcXY8IR6utPYalHp5qxwQ6Ww6vRpeuud7lkYDg==
Received: from CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::21)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 08:53:32 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::8d) by CH5P222CA0017.outlook.office365.com
 (2603:10b6:610:1ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 08:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 08:53:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 01:53:20 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 01:53:15 -0700
References: <20240730223932.3432862-1-sdf@fomichev.me>
 <87cymt7pmu.fsf@nvidia.com> <20240731173245.2968988d@kernel.org>
 <ZqrjqpKJRgMhlvr2@mini-arch>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Stanislav Fomichev <sdf@fomichev.me>
CC: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Joe Damato
	<jdamato@fastly.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] selftests: net-drv: exercise queue
 stats when the device is down
Date: Thu, 1 Aug 2024 10:50:47 +0200
In-Reply-To: <ZqrjqpKJRgMhlvr2@mini-arch>
Message-ID: <874j847hfy.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b31e923-777e-46ba-eae4-08dcb2076b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XRBM5bCbWaMZxQkSzxRY5WwQq3o0YjoqkfJJ7QVcD/j6f3W+xTwVx+md9oMg?=
 =?us-ascii?Q?VumpSaepE7NXRfAGgowxzCAMZ96oyepIi8+PBihrjGV4M/ml0IT9XRjhX9N0?=
 =?us-ascii?Q?jtn46/j15b9yMHN2M3ebnPcomAXL5ZLiR5O5N7KNCvJQtop+deH1+utiiQ4T?=
 =?us-ascii?Q?Tl9dieDLsoop+jOQOqTiJsuuirPPVp6Xp3oDC+Bn5CNG4dICVEWcoqz9mZYr?=
 =?us-ascii?Q?WGtj8wWQ0pe2kVnk86D7XD6YWtNI/j12FKsedNvnY9G1IOWThUZarr1z6pvx?=
 =?us-ascii?Q?yMrZYtbtLqhzdmYJuF9QqmUWCxf5a22y60d8OeKwowtPwz2Vr3AjG20I4zyc?=
 =?us-ascii?Q?4wTk8d2rghKrmZ3xqKcyQS7myQs/vu4dtBwhHIp5Hk2mo3lZ6mJpvGTbvzN9?=
 =?us-ascii?Q?ivIvQ9oAiZxkeWEoqHXTD/Zrn6zADVi+qJa0DbN8NNa40UYcTYKzC876OhGX?=
 =?us-ascii?Q?cqBDt75PxxxXYAvvnYEUmYbPR+y+afENL8iw3NksXXmK5Fwwgte9Z5nOXD4o?=
 =?us-ascii?Q?KkZu9sYf2/YytsL9BojI43aPF+GZzWDwkhSzGiZg2IwYBUrQFhQu7mJkDvfh?=
 =?us-ascii?Q?dqgOuT1rgnCwWcIMPo36LD1dBwRjfFyGoadG+FhwutvXSewp2s0/3lFzm1FD?=
 =?us-ascii?Q?KTMEZ7tOl82at7BaROFrETmnUesh0JmJ4l1btBXSVFzk0VhCoC7Olka8tcOU?=
 =?us-ascii?Q?bMXybxEp+EU22kYWc4M6CKPPCXyO8ugdvjbHc5rj9JtFobGL9bfHOgzFX94N?=
 =?us-ascii?Q?hOwGNJix+Lul5R3JelP7MuEGHTUFU/pPbHLklWPxsFh2hXpkmleL3BOvAzoq?=
 =?us-ascii?Q?kGfX4T5HtFFevGKQGQvu2HckXV9rUdjVSuWFE6kTAe7sMPJtHcSgNTUu4xd1?=
 =?us-ascii?Q?2NHpoUgUIeBCMFaJSshg++5Bc9Emvjdxw7YpaJWnRE1HWs4gUlYNUUsVB9fU?=
 =?us-ascii?Q?72GKh4Q/+tYsRbOIDmk9nTMvSyd2jZTHkRqYICh/W+DenXvCPUIpS437ULvz?=
 =?us-ascii?Q?ijO8R1afcWipEn/pF0h6cCnT5zXh4s103k0LlNONT2uhui5nBo2MhgbxTm3n?=
 =?us-ascii?Q?8Un2kGWs2P9Qwwo/W3Qll1Nzx0dQ60xuKOTbUwOnjAM3f7JTIae9USkCPqOQ?=
 =?us-ascii?Q?p/eD2CEbhhLjJt545DypJGapJuyjcNSBr/LIqgdgU+5QUJXXf7OESY4jRYns?=
 =?us-ascii?Q?FJRrSouPX/2R3u/jc5Qdw/LHQdZTjrMwm/nPlAJ1mESZtw/jUYZPPjCr3+Yp?=
 =?us-ascii?Q?gLRr0Z/cMo6LR/LzyVTZfaKrdl3ycsSWPjUNUOqqn4kHP5akFDyrD+ZvgLEV?=
 =?us-ascii?Q?V1iu4aNvUuXgqrM5IKxsvauP/LwoByY6DjaxTEah3roWNlc+sM+2Qa+w3AfS?=
 =?us-ascii?Q?nsnObR4v9U4Z+aYGWlUjOIbGzcpx/wMzbGc3GBoaP+sl9X5FqJSlNJtU8ZV+?=
 =?us-ascii?Q?YJ5zw4ca9M9rxiosoLrn+aaiShOFiFk4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 08:53:31.5978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b31e923-777e-46ba-eae4-08dcb2076b7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038


Stanislav Fomichev <sdf@fomichev.me> writes:

> On 07/31, Jakub Kicinski wrote:
>> On Wed, 31 Jul 2024 13:34:58 +0200 Petr Machata wrote:
>> > > +        qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
>> > > +    except NlError as e:
>> > > +        if e.error == 95:  
>> > 
>> > Could you do this as if e.error == errno.ENOTSUP?
>> 
>> just to be clear EOPNOTSUPP ..
>
> That might be the reason it's coded explicitly as 95? :-D

Both exist, I just didn't notice the latter.

>>> import errno
>>> errno.ENOTSUP
95
>>> errno.EOPNOTSUPP
95

