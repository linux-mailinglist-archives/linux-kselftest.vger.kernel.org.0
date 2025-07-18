Return-Path: <linux-kselftest+bounces-37589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C751B0AB00
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 22:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D05F1C81A35
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B8C2116E7;
	Fri, 18 Jul 2025 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j5fTCvq7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444EC3597E;
	Fri, 18 Jul 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752869811; cv=fail; b=VzWYQB538EdT8I9lYILG1YuOJ+9IdlWuo39qeioRiw7yCmn82AQggA6w8ht0Q8/ikXoXB1EmPF0evCkT7NvmNVQIy7Johv63k7vTVs6JnAheI4X1lroRnuUAdlnR2I3BxVFuHK307FYlONtUJbDwy74KtxLG0QsIdqt57NF1Teg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752869811; c=relaxed/simple;
	bh=dYkut7s9XPCp/XAlonFbnXK+eUcF1cvBTc7fmMIfF18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=miDoohgJY0BnNFxAX+1wZJDlu0sRCHF46Ls087DDeuagWkA1mJgYETcBRuWlflX2oLHhrddmJzE1DMAXlFmBhUj9ZH4CZSU9WyLc5dovDYhss/YIPfa57DKvT7OO8mgFTYkZ4M4ApopW928rKUZ7oRZpdItqiWnO6QpvBmHdhYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j5fTCvq7; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJgzgkiJiBbgZQaHAuCQBBj3k34w0zxdVtLxO51d+0pRYPY8grQavNEZqkqPtpFyMqqKzFHgnd+KYjvtKy5GnL6p9v02wKQd82SUjgqQr8oM+B5sM62lIHdDw5IQiBAeG//hSUh10PXQez6kjJsQatTlwtplUgSacbowmRcAEEPAqn1f/dFU45jzPagOJEdMUqBWZLiZSqPl2jS4RTalOn18baL8BlIbEC7TA7U7H247JskAcje/JA5I9ioDdryHNbZGd0IKBwy6KzWS7+8lxb8JXPyejBRYqb7KdJTMst2SW0taA4uoWD0FKorK/1NtLfnc18NHLA7y5jjQ+qse2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58xZ8/g0tJr+vgxrL9NsBB0zBw/CNuqAvgQN5MlIOwU=;
 b=hQ/4dPtwsN3WuV4tlcJ7XNoO6cVl0cv3j2gir17xWcm24wVu3U0+X2Zcuk2dhcrUJPl7UOdD005jXTNjWaMQTviwAG9B0bsCk5Lx+k8vVK4cP2EeaKe/5vtxKE17gxxDTpuKSSaLWZh2qR0Co2Y0BQX8Q3JPZQAsDN6+yucgL9L0WbW1MmoNZQ+ZaNfWNARW1FeZQ+0cxEBQWsZv3LlNrM3rLte612gizJ61WdfT9Jsu09e0vHjgsSNX6M8oSou2enRZdFFJRcpWvXmkqEuJESEZuGb13MryeT5ZmVhaFfY6dm6k8aUIQH853VuIkUy1zNjpPNr23Yjyl25e8v08vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58xZ8/g0tJr+vgxrL9NsBB0zBw/CNuqAvgQN5MlIOwU=;
 b=j5fTCvq72Idm4khGFK1dm1rPvd08XCZnecC1QGmex5GHRkwKTJB5BbyjyBVViM3bOTkQshMgYiOI/KX0/Jxuj6/2jvgDGo/USKwyJyPjSV1858elNteOAduoZ5ceyMeZ237XjAINz+W7VUsjsSvTf/QZKR54Nag/NTm1Wk+ZYcf63iItkFKWvK0AOYxc6gXnWcUMxU3viVdo0t1qQ1rvmg9FIq1SYQaI53M5rneSty0nwu6WrtEB5f5a/x6CKqhHfUIn2vwAojGhML7q/MwIQuC3rxswB8OjrhFe/qOIPUhPbQ+FSZt2zcZkG6dmIOsbgcCNqWdB4avolqHEeCv5EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Fri, 18 Jul
 2025 20:16:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 20:16:46 +0000
Date: Fri, 18 Jul 2025 17:16:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>, Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>, patches@lists.linux.dev,
	stable@vger.kernel.org,
	syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommufd/selftest: Test reserved regions near
 ULONG_MAX
Message-ID: <20250718201645.GH2250220@nvidia.com>
References: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <aHm1WRAGgk/6HZMC@Asurada-Nvidia>
 <aHoCOnOAlwpoiDNe@Asurada-Nvidia>
 <d18d7013-e82e-456a-87da-8acffc90d8db@arm.com>
 <aHqXdjJbuO4e7r+X@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHqXdjJbuO4e7r+X@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:160::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e212fc9-91fd-4391-0af7-08ddc6380558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WtmHFO+rOkxl9MTYckMXw8PK0TYU4aqeBBdRRWROZOOS7zaK6cJ93KdeB7J5?=
 =?us-ascii?Q?WZZpqlkGWL8KS2I/0ahJGjM1lObxWd8Yc+FJwJjfJDzy1jgvsN2uxy2jHz4u?=
 =?us-ascii?Q?EwwVeEhv78IcKRWo9KNvh+fM01CdIgclpSAPk0AXeHYYYEaSuJ8OXzL4icz9?=
 =?us-ascii?Q?DXt7p43Xwir4TlW0Nq8YOHJy4QQgi41Sxm/soYiDlad83UFNGEuACQbmaWfN?=
 =?us-ascii?Q?DR1QvKvYtKdQgdtXARr3mTyviMrOHmJAIfK7RtX+VIP9lU184B6e5axkJ8y+?=
 =?us-ascii?Q?AiE1nFSilSX0nu1zwt3OY88qcuZu0cBM+zCus3Cay4q+jbNGs2vsdvF/H6zk?=
 =?us-ascii?Q?D7pSi/IU20yeLoV9/AHtz3CYErnNqZQ/rKkIy203nqX+/W1lmoHs+vWUL+Jp?=
 =?us-ascii?Q?H8Wqt0GrP3Qw/NsHY1Pc2QXs1cLEyTv/1iK3ATiTsIkMe+TZ0rkD5tL3s9qI?=
 =?us-ascii?Q?tsX/C21PXcHNsA/IHkbTzi/J6g9eu6ia19KRnl9YNqKvWaL5p3G5NX1PDC7K?=
 =?us-ascii?Q?maGM68xXIHZYQRpzweRPfupn2mXX5Ev0MB00m0qAj5+yErG10VcvkKl3toZE?=
 =?us-ascii?Q?Ev8KcQm/+7cNILtvCCnLfKaDeH19AD9HsZrsZVjHg3E8cKRncSSxrP/Vx7dN?=
 =?us-ascii?Q?kDUWy1w3mMZWHGf/CeAlQ+8YR8YBX3bWnUXYJvwKC3tm+V3hqSqsx9nb6TEF?=
 =?us-ascii?Q?5PD+fiCQY3JiBU6AO13IKqpdmuhMjTNk8HOfy0CjRDsG8C4flC2gkOAB7TO7?=
 =?us-ascii?Q?KnW9sXOJI2J6huUULaS/Avpabdxiprc/v8FbwvpYjtFWTabez4KO6bBYDsSH?=
 =?us-ascii?Q?mNHqlFyCnYKmJW3geoN1I9Of7X7/bDrb/bDw4TO5tUIVlX+PItix3SJVyGnv?=
 =?us-ascii?Q?WRUZYg4hUTszw56ygMSCiQ0I+IfluRwSySSgkP4NENXBrGmZKnh1LNmTjiib?=
 =?us-ascii?Q?FbH8RkKQxUDTp8Y8kSzKqK+JHk4SBUFoQLtENqIRkFprD4CH6ZKYpIjRXB3Q?=
 =?us-ascii?Q?VrUnlZdiC11lP+akLtBQhQD8aS4UGXyOSF8/TYFPo6ofmJbvyVVH01lBYsx7?=
 =?us-ascii?Q?Ko+bxmnLN0l1pJjfA2q2kQjHgnxDZKGmhokVUG0JDyaMJYPReaCzZ699E/Og?=
 =?us-ascii?Q?FFcVvlMLA/ABmNFXzSwnDpIownUWslVHHvfZoJJ/v/0Qom5zOnT5rwZW3tFU?=
 =?us-ascii?Q?Y4EpaOFaBLzKZZxfVUlLUN6Of7yLk5AoM50MIp1q1Tf+fTb5IK9Vifb7I/Dy?=
 =?us-ascii?Q?8W3muF4lUKmKgPwSlHjmmGhZZcKJPfxsXcLUeCzvNfnMimb5fBQEaPK2NERw?=
 =?us-ascii?Q?5HT9D333hUNarGzpnIWrtkCWzT0x2LwTjvIvMdsaKlVuI7ypvvO7p1GXrmAg?=
 =?us-ascii?Q?FbQZ8t7VyNEESpltWCm/wWmaNk4NyqHcg6yWVDEsesdsKBwJJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BzxNa2BSzozCRhf0fXKufr0DuJ6WxsZ2/LJZ8W5N8wv4DJCsubAZd9hKgCos?=
 =?us-ascii?Q?vie0ChLh1dnDWC5Wbf4sxuVRy3i3n8VpM48k2iPYsNfBBrUDfuT2Aq20/xwp?=
 =?us-ascii?Q?iZkC4QIBaZNIVRTHKBMMkTubLrwS5moOn27mJyr08VzJT3H2urfgfp/QATiB?=
 =?us-ascii?Q?fPxCEsAocH0gL0IbC3bB6HEW7K8T0vVIxIji0vryEBCI8w+86+7leRe8u1Yg?=
 =?us-ascii?Q?OORJzHPg2pb1QFBc1dzEPXf041SKuRAJpV3fuF4/T2qoIC+RggVHL5mNI12J?=
 =?us-ascii?Q?wadfQJZl02SgNXzpRp+EwUf9JEC6qvrByVBCWcQxvnGdFWLFlbwCb0AWHfmi?=
 =?us-ascii?Q?PXL41O3aoJRgdrl/Vy7LXPdzWhimJ3WhdmsZ6xemS01cMlLpF8jZInspPB1L?=
 =?us-ascii?Q?IV1K1iqY8Dqfx30JAQFidtxRhnYyZj5MNJ90qzMF2HQkAY9bO15iXiOocqAx?=
 =?us-ascii?Q?59LmCNlNbZ7ZFajgXIizSRcMZA32Q4JO6u97nKsDEhN7qa+dWmHnT0VFOaqn?=
 =?us-ascii?Q?OEY62CXCyeFlgmlDcCDkp1oiZU8RycQmaBjco7ioLgKgOR6lZtjrli/aMoN9?=
 =?us-ascii?Q?jP6/AOCQ+veG3jpB1QysT516CjBmsXQxEJ6GErEbnIq4XHil/dpRs+BxB3yd?=
 =?us-ascii?Q?XjSxea9dIK2OFWtlbb+WtnlYQZ+TxfLtAbJbOr5DPjmJQDv4E8JAmag+7+U0?=
 =?us-ascii?Q?E4MvWs7FQKXCXduy3CzAv8VpZKIZCpE/JMWpzrBRO03T0CbscWu6D6WRqa5o?=
 =?us-ascii?Q?1fBz8OyXqtj2J6Ndu8E4Tn+C8a9X4QGu9aYT+N0qZjq1qZ5DiBJhR0iN66xN?=
 =?us-ascii?Q?LgBUXZgid6jLtpVoKSS+I7112Pa06PUjf4fBK6y9zv9xLATOyU9XmsrC2KP2?=
 =?us-ascii?Q?W2je6bHx8LnVm56Dt0ir99La9sGAl8TItLdhxgLI7AVTV8/atQxJ3DwDqfAs?=
 =?us-ascii?Q?ub4ORT6JRPMZwxKYDoOCnN8/zwAW7iZBPp/uP2W9lzcEIh5M01y10O80c4VQ?=
 =?us-ascii?Q?tRxU02syFfILpXMAkod6uS4K5FrxW0XJ/7LKTB/VYZuCaoRk4b1W1Iu1xUAU?=
 =?us-ascii?Q?PlLnsEbZiLsgR/l/oDB+vuCc8cegUJRFC1VYPXCB/gpfS0BEwfcZ7Wux9B1F?=
 =?us-ascii?Q?PYPGAdI+fPICCZsk+bsEyIMCO/p9BFA4iqrmTVnzGKwPTSrODRCBPFqnmABm?=
 =?us-ascii?Q?ngANlmj54KQHqESF3/Tnyx3sOdbph6QmVwvd8L20oFDPrmQMyFlThJy6Wd9y?=
 =?us-ascii?Q?sL0opczGvwd+2CWuUZ4X05RHuAgS76GePBRrA+s+YX1TfYtlTQKzSQz/jd84?=
 =?us-ascii?Q?o1VFi4Q7SUWIENnhSmh/lLLP+0H9fGUbhjEq88ewNhMTXkFqlpomRnqC/4Wj?=
 =?us-ascii?Q?TSrLjoR8iTixIHPVmUOvWZNpjxwtElDxwqP4+qed8NeYovbmu/YY++qnAE/Q?=
 =?us-ascii?Q?K6FD9prCMweY+h5Nt05UOThKe3bt91JmMkkEKaa4Fno1blvedkUDh2+y8Qdj?=
 =?us-ascii?Q?EINt/BQfF4D0FzKNSZvYTbleXB+riypj5V7w1B1hIIvKZC89ggDJlgEo4m5E?=
 =?us-ascii?Q?0s/uQpyP/IPwJAL/BQOPWqCmVOhNPvuFp8W+6r4p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e212fc9-91fd-4391-0af7-08ddc6380558
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 20:16:46.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDuGwdi3mR8FFHjHncXD+9xu53JVuzwisDiaxI7GlPb9k/fi4VnKcdIEs8CJw3fC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467

On Fri, Jul 18, 2025 at 11:50:30AM -0700, Nicolin Chen wrote:

> 0xfffffffffff80001 and 0x50000 could repro with 64K pages,
> exactly what your math works :)

Okay, I was also worried we'd get into trouble with how iova_alignment
might be working but if it's fine lets do this then:

@@ -975,18 +975,24 @@ TEST_F(iommufd_ioas, reserved_overflow)
                .size = sizeof(test_cmd),
                .op = IOMMU_TEST_OP_ADD_RESERVED,
                .id = self->ioas_id,
-               .add_reserved = { .start = 6,
-                                 .length = 0xffffffffffff8001 },
+               .add_reserved.start = 6,
        };
+       unsigned int map_len;
        __u64 iova;
 
-       if (PAGE_SIZE != 4096)
-               SKIP(return, "Test requires 4k PAGE_SIZE");
+       if (PAGE_SIZE == 4096) {
+               test_cmd.add_reserved.length = 0xffffffffffff8001;
+               map_len = 0x5000;
+       } else {
+               test_cmd.add_reserved.length =
+                       0xffffffffffffffff - MOCK_PAGE_SIZE * 16;
+               map_len = MOCK_PAGE_SIZE * 10;
+       }
 
        ASSERT_EQ(0,
                  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
                        &test_cmd));
-       test_err_ioctl_ioas_map(ENOSPC, buffer, 0x5000, &iova);
+       test_err_ioctl_ioas_map(ENOSPC, buffer, map_len, &iova);
 }
 
 TEST_F(iommufd_ioas, area_allowed)

Thanks,
Jason

