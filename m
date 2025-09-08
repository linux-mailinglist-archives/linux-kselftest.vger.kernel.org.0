Return-Path: <linux-kselftest+bounces-40934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80510B48A40
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2731665AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5406E2FB0B8;
	Mon,  8 Sep 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ayIm2nyw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE932FB080;
	Mon,  8 Sep 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327709; cv=fail; b=BWr+plMXoWhzz5osvSnIfKRFT3idGgPzf8FJWIi4P51Rjh1B9VvSrNIbxSACX65M6X8oMgcUZmV8bFkIf9qg0Mke9mpX3UQ1rQSyalhP+y7fU5icu2Meqmi2S+mfj3+wvJMeZji3Nx3A3Ka+Pp48hRpiwcMVEf4hiw7xAQs2Ur4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327709; c=relaxed/simple;
	bh=qBaoBEsH9Ph98Uk9XDhOpXnSPbgEzmQF3qV0swo66Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZrXP786qGT7NoNI6I3f8ExsuH52WBtXJKYXZZojpiinbri+8z/IK+vXWpIEuDHcVI2xY7ynfk4cmmY3B/CdwheRTUAEZ/eRQitBo0mk76WOnehI3umL4DtxcauSZnBfBO7hzTG53jGNnqHoKk8ha89WVsIYGAcL/mOtaAlkQCNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ayIm2nyw; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfxX+qncc1WmKx/cIsf60wvYup2jnHuZG1UpnviAOiU6YAWv4tTKyf5bf/OAHOWBdbtMcHn1IuoVGgDL3PEy396J2KUmkw5zTrmU3ABiBFkmBHu2b+L1Y31lVdSNAwJbW1DtzTCf9bERlTtBABWjZaQuLHkowMZVjMi1IZsCXrDadOaodorGz6empbr5x/A0pADHatnm79EsOT3aBAtHbcEriYake1fVqga/UQxgoy+iFljRrYplA8dOUj9JZ13NxNMs4GiX/FIhpJb8PKuOa1w6/mfQ0B7JS24Md+VFIXE00kn6tqJPsFVyLg2unmQdGq7J59bq6oHLNjN/zNMacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBaoBEsH9Ph98Uk9XDhOpXnSPbgEzmQF3qV0swo66Ww=;
 b=EdmPPAAGrJYEYzpV6sttwWaGUA42RQGsLfvOiOWkS0H+lm3PRixWgO3524rxeUwyOFKHbcYOLw0645lGjaSEN/IqQZvXCnUMAcsKT/2XOZ7iZD7pkFrDR8kBM1YUKndCUlPOTmdkFWmCHtlKp79uChL/cqbj/42A36XISnrpkqE3tdEIwxRUs+Ic/lhsP2KH7ZPTUW5k6v4wksy8iHO/LM/g1xRYP4DCRVMlzxqEZrr5JTcqPhPUZQ3gueNGs+vZRlgiC6eq0SidM5uH+Al7BwosIpWKwFt0Z/UDYs/SuxiXEbqrZwFK3E4ZZ5xoLak68mu5HMEGu5XChGQMFSLf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBaoBEsH9Ph98Uk9XDhOpXnSPbgEzmQF3qV0swo66Ww=;
 b=ayIm2nywX2aDJCMh1zHfirhza5CgJwjegiVlSGnFf2ifWdPYCfQUO8kR8B7TP7WQTO2rUM/qDuQ21oayD5hEzm5doH4o85nnOF9eYm84cISUovvmyWUxChU+fG8AQ8zfwracREnWnwT1fvJZNds/U3FTqH0Q6LGNpi5B//D4ALLKwfjmPIEoy2fwPthKYhqW5cNcg7jqhKusJsFATqRSXXzba+tfycTmnqsD6bV7j4eK57BzWs0grd2ab/Yw9uNiFzTLpGJqLAJtg/jaYci2ONZAW5ufp5ehDac5ugImetTTv/oq4Q0FvPS+8QscrUSNFAI2o+wTrSn6kknzJrrQBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 10:35:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 10:35:04 +0000
Date: Mon, 8 Sep 2025 13:34:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Amit Cohen <amcohen@nvidia.com>, Li Shuang <shuali@redhat.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: forwarding: Reorder arguments to
 obey POSIX getopt
Message-ID: <aL6xTl9vzfczjxri@shredder>
References: <20250906170440.3513399-1-mmyangfl@gmail.com>
 <aL59Jl5p6bEtCAxo@shredder>
 <CAAXyoMPP19LEMj-dYWFQmwdZgGbXOq+iYbONCAFx--PNN8TNoQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMPP19LEMj-dYWFQmwdZgGbXOq+iYbONCAFx--PNN8TNoQ@mail.gmail.com>
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c0e0b4-a284-4d75-4da0-08ddeec35f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z/2TJ6EKy1SIojNa31SA1o6Ebibz48GGPPjvc0HSPr3HylZ7FynyBvG7SUEa?=
 =?us-ascii?Q?Lp8CGT3jdDtJQSwRzFML5LjY9VN9UMVRiEd+fvH5/WkTza1SgncDWke4kQ20?=
 =?us-ascii?Q?CTdFD/B3RETWs/N5Mo+LBlcEb2GN+DC/Lb4ztBRPzAeU/vDR0SWX0z+hUhnD?=
 =?us-ascii?Q?lK1v29KiuAXcJKguJ89vNLCCwA/DYDv7QVQDSOS4e04ubnLpiL8JcCz4sypN?=
 =?us-ascii?Q?PyY8lof9r58oL6EUMQvePm21o/wuDVveIsBhKCqAKiSD2oV3ZWGOO2qg/ic+?=
 =?us-ascii?Q?zh9c/SOCPYAzia2ed64i2/MgGRTrv970wpvDOiN7HtvIEKFaoU+Gb/69lNlG?=
 =?us-ascii?Q?Mq2hgkf1GIf4AmGic7o7irjMsS2eY25Aeekt9fponGNUlUFwSBqm30Qt5dc5?=
 =?us-ascii?Q?/YEXGqOL8FRHRuOHArg0WojdeQL1NqvBoWKTZ2B7CqYWj0u/9QeJXL/2CaPh?=
 =?us-ascii?Q?dsHXehE9F8r/P3Fbk3YGrlN2ehvHIrqku25DdNn0T+4p4rW9NJ0nKZoqsUw+?=
 =?us-ascii?Q?QWx54yTeLYvnGNwBbdq2GjILMIf63Na0tVuTmknnJ4R6YA2uiTPLPqgnrOlt?=
 =?us-ascii?Q?omExX76o6HfGS+UiGAz4VDVOaIXkqO1cmldeABBdEtzW31hgYq/tzJ11NZte?=
 =?us-ascii?Q?BrwJlRnQdgKg94cOZGwsoPgGWUkR7rJf1RmE8YtQKCN3b1z04RsLpBUJQwOP?=
 =?us-ascii?Q?7qL/5xKD/UCwjfJy/fV1nY0iZejla8rK5+BpHx2BELa2DFwqGvUIHqMbKcUx?=
 =?us-ascii?Q?mBIATlU9C2ccR/W4f+I/3iNxaMrEj0c9jKJQqEtyAEjQZK6mdiXVObRjQAwK?=
 =?us-ascii?Q?3UMBEkjSL1KumpyNSfqQeRJFyRZYEdwPtX2Vv8UfOeYC5+mKjmP/rSzyJ0Rm?=
 =?us-ascii?Q?T9MAHTaj8aBjkttvp5lysULU2mXMLd6M2AXPO0epZBYx6eQEQx7dzvIunq6T?=
 =?us-ascii?Q?9YmY0/Fejtb4h6ZtocNgEFc9Rdh+qPHlu+sWlDv437t41Md5vfB/dzcULTcN?=
 =?us-ascii?Q?2WYFIpfdE8s2mi76NcmOFT5M6fbIBJB+NnDKl7w+8oa/uEwwTWcmpPMTvrp/?=
 =?us-ascii?Q?rsvBk7D9O2IPkxCfLHdeX1Z/MHASb4C9qKJDqr7rl7R+WKhoCjHSGHkXSmoM?=
 =?us-ascii?Q?HHtqc8yuv+PxKj0pPD2KnkntryogPgOGl6ZNBdup6KA+x2XGQeGNTPYlt8zB?=
 =?us-ascii?Q?5TtxhVxA68DgjrEEONkvzq/3jmOT1XvwJGwDW4MqhXzjc5L6Ic7GtmiB3mRp?=
 =?us-ascii?Q?dv1o9AJZP2XkIWVUCsojMc/WPwjNerckk1FMCenA0JGgs54YMb6sfkHzFlx8?=
 =?us-ascii?Q?Z+T4eYIo7riF5IgHG2Sv5nHUsLD3zkBW9+NHilvvIYbg03s4AEcWtbVtE3ye?=
 =?us-ascii?Q?oqefBpq0JtxHqhEu3lvaYqaf3RnjeKKq+LB4YyOJf6918qjrzhf73hQeWos1?=
 =?us-ascii?Q?X6DvL09GuxM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u0O7J7Cu1zKu0QzHghLrjqPJBw1Q3aPrTN7qJ+BHVruVHvMt7dyLl1IKgEbJ?=
 =?us-ascii?Q?KLXwcw9mmDfnlTYrDUnsLPIriWVFlLc2Oy2t2XnzuOXS8rQgMY99V6m4F+qr?=
 =?us-ascii?Q?mvuo2o5uYSEC3DWDybo8vXX4JjYGeI3352DOMyEdNsVXtIKbJzqri4kijo3F?=
 =?us-ascii?Q?L50945vZHWrEfMx79YRUYvFAzWIe683F72uLPLYawB1kOFA4mWxQsfs6ipRI?=
 =?us-ascii?Q?S02iRQQAEGv0fCWaqygmqK4pLPuXc4b4y44Sc3Tes/Bmfk9WuJIRggUzQJOH?=
 =?us-ascii?Q?sssUmI2qkg5/1D+kIebpgMYW+6zG7HTg0po3I3GR6Mw2Sf77kqLeQoteYYzt?=
 =?us-ascii?Q?7qJbypZsnFoOsNfNhFO4K8r25gtTFXjoYePXaztkBnIqzh1p/gVoRlKYxBwn?=
 =?us-ascii?Q?vNjJsy3b4sDREf/1yF/Cry8E13j9pu4YlvBUFv64mGvi9Nl5BU3GAtLQK+gw?=
 =?us-ascii?Q?I9B3RUYlWMelEnWXNTc5a3AOLuVzIngxuD0YiCga72r12SLxGYJmeOHA8g6U?=
 =?us-ascii?Q?/2NSKN0+rygpk70hXauQ5uNFDF+rJb+aGRbszWxacgHxn97sXVygPjYbX1mF?=
 =?us-ascii?Q?m8lGGGqd29fD8U9HIecMFukx6+sYKRTXU8XjHiaL0+MlIs7BDGYVTGiHgoYq?=
 =?us-ascii?Q?30XDKySyONC9M8e7GNeCU5BXAyDuv0MDyN6Sy2YoEK80kBXNf29GVd7EdwKE?=
 =?us-ascii?Q?pxX5aGPdfRD88J05XsmIjh7NBaKePQyL/QVUdHnUZMMgPqdMXneaTdLy+5u3?=
 =?us-ascii?Q?vV45nvgjJTi++2eNsny4u5HsNx/BrDebR82SSRExaAAzaMlJazk7oC86SuWF?=
 =?us-ascii?Q?ad7fKYrNa3JKWhyaXHFkP/Ai/cNh8rm0795u01YttFRDJj7jWcrGbRPbXWBq?=
 =?us-ascii?Q?pW/HH77os7wfijwJGt7eOLaDvaNqN5tIH2tK+7Umg/t1co4tGtJDZ4cs+q6H?=
 =?us-ascii?Q?Vgr7nbsUb9cHy24ygdlpYs1QeCm8zmdyehijjJo7LHUmrQKfGOTPNqfAJG+h?=
 =?us-ascii?Q?qVkmZPZNY84wc64JyIOmI0uA/vPYKvvbY5qspAHxrxkPEB3VV1k36Fuh8rfG?=
 =?us-ascii?Q?3wU63oyLWUYnwxonTFOKHXgTH8kOl89iYDHcKwsV1mdL/RqTPnAIijodfpn7?=
 =?us-ascii?Q?Y6d44UInwptlcWmAoCUUXC5GKk40ZZhhXM34OTrKAxLOonFD2G8fbJHXnlWC?=
 =?us-ascii?Q?E/3Mgp/WyOGNEZRI0Vh22UKp+ulO6zjv11m2K6twHA4XXcL5vYtmXcZ6L8fg?=
 =?us-ascii?Q?vDSrrD9fUupDZ4nlLezKxgPaz3592HbQsHYpppeYTsEEWRXiL33FhV8RM0cY?=
 =?us-ascii?Q?Dwg3BfOKTTSF/oTI+ml+K8H6Cq4dqpIuwG5dk+xyVJKwXdw9qdN4VITRhdXr?=
 =?us-ascii?Q?7WdOiJLljiQy5NDFtudaSAt7QdfQkiYb1mtJf8yznX18rSvbK/UIYYtSs1p1?=
 =?us-ascii?Q?8Xs3GMyhv61FjmK+XtGwcssYI/kY4tPCuLaaJbtmdBtiGpMQFpfbTwg1oHP/?=
 =?us-ascii?Q?Hku8KFWZtQPHQjMq6eF/cawxUkgyCxu1vTrO/8GMpOFfuzconBrFtqwKKv+E?=
 =?us-ascii?Q?sS17gjHy2v2nA41V2wgYUk32LjzH2Ldd2CoHcsce?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c0e0b4-a284-4d75-4da0-08ddeec35f63
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 10:35:04.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGg/HloITwvm3HkJWH+TvBehYKQKQkIyynXyJpLmUQPd+M16Olq1+0DULB6W0WL15xcrcb+WUVH4EXdWFWuSwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

On Mon, Sep 08, 2025 at 05:39:58PM +0800, Yangfl wrote:
> Should I fix (ar)ping only in selftests, or fix iputils with that trick instead?

Looking at your patch, there are only a dozen incompatible invocations
of (ar)ping and they also go against the synopsis in the man page, so it
makes sense to adjust them. But this is going to be a fragile solution
since very few people seem to be running these selftests with a musl
based system, so I would also try to adjust iputils.

