Return-Path: <linux-kselftest+bounces-31144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4299FA93A6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42793B542E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A72222CC;
	Fri, 18 Apr 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QYWLSFb5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486122171C;
	Fri, 18 Apr 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992657; cv=fail; b=Mz1oIzFXl5A/mh+dFa9gRLKWH9BYY8eeeFQozwQY6tALTgWq373CKS22vrylt4eO2DPQXrWrMAuEPhbWN7acLKk/HjY1yiVFIhXUeuxkiAcTd9GZabFWafljPemxHgBzhVy4cNYZA5nj6NowwEPYwFRq+eJ6GKCvGJYZBZTixts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992657; c=relaxed/simple;
	bh=hwgGmVtOvMLWfOrOFGwK9Tqmh4Q4OH9WksjWl+vAgOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D56Q1+9sh8XYGBsxbRF/VjlxBS9PATLFHOBiujH2XY4W/GaX5HFx9NFnCJ+C4b+y8RJ2Gex15HpZv0kBoucLgqKiWNK9EvuVnGNichfPYkEv0aqjojq/tgW5mXmV8AOibXE+e5tasYSwdsvcM4ermG2txkvWkiMWhCDJBf2ZUik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QYWLSFb5; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+krtlTbrGjZ6/qmAoHY8oQIhZEji7tGOiMd1v+qVj308iq6MAGV7wwbIKujlTTIj3f+xyReeQuuW+N126eJmVRS8UpYmkjRxk18u5mLFKxF8MxeLDsCCigq1l6/CdB7PJZEvJeszfTKaBgi5a+TeTSxmfflwgOvCfqGwhbXIg/x1uN9btwfqJFMUs5Von/jYwQOOn+HvfoQy692ffrAWGUcseaULXHdeB+UBuVqlC0Hvwq99ZC4qUeQbZluFS1Szxdm2YzdZuOwzREOgQJL0k5wXHESZxq8lfK2JiEx/N2CRaqyTnPkbdBmvLTnIt8gTG0zt+/QhWyx1Jfu8v9lvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urHpZIeQMdZeJXR70pRCganwslf0fAO0+ZZU76nM0/I=;
 b=ZZgpDAaSiUs/cxJTMf9at6zwdAM/oJcuHbEcSW+BGT53a6gcoiU+dN7MLNcIDf4Eq37cEMD71JCIkiJ74V6GPXxQGSTK0OzwYMXYKKc0wHuu8rbgMctXexkFeBBs54BxIechh/X4rwj8hR7xYJMZBeqNF6G9oaNhkr8iqHbmTZnACKVE/eNImTR6M6YTwebBfxnvHbCoXWeKKeVLjZ3c+sKBa0k4D0zqtxgJuygK27+UhZzjEFEACpEzfpnBu2RGRlfAmRnB0Onoez60Gz2yfVwbNh1alDbMzYiRPTqEyd3K/a/vLbpu9ZhF30AqhWJpqrj+sOfe74ZLdXkKCOVKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urHpZIeQMdZeJXR70pRCganwslf0fAO0+ZZU76nM0/I=;
 b=QYWLSFb5mNfDkqJWWfwh4huMB7TjhM7zXCHlotViRvKbjYir7hb9YWwT1Dv9k6xPDak4BZMBYbOWnHcLvuK7XykhQ9s1OZ1oQpOQVM/+LkI68B0ayIuNeK4x8vrB+9a7rH907Szb6T1nfqCSuvBne5fhXEihugvP2dDdaggiW/JGt8CfcZ8T0L7h3wdo55Tl1EP9eOcHLA2viRSq7pb+8S/bK8H8CoSZk15WLYZMPi50qT1BCNks+OxAZvxkm8OpIL5C5EaHt9iATyj3jL/aG0Rhgkm/W3QPgx1Vqgx2FuF4ozjycsXQP4kzUOqQiR3oPwAwfTAVECzUuANSiG1eHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:10:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:51 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 14/14] rcutorture: Fix issue with re-using old images on ARM64
Date: Fri, 18 Apr 2025 12:09:46 -0400
Message-ID: <20250418161005.2425391-15-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::35) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: e580e7ae-f428-4a33-a606-08dd7e93969d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/vWwVI2ODd1lXzhPPs4odvCZR84U7DZAgDEIc+FUur+o/v9aCIZMhR2gdI3F?=
 =?us-ascii?Q?oxa9T3YWkcJ8oQjlo8Kiq7lN27H5yKd0TQorrlwMGf0ykQtiAGTpfKx+BBzH?=
 =?us-ascii?Q?dIrVWq7ms5P/K8Xt6Pt3FOKS4Fc8184pYEjmrdMlpeQpncWSshrXvIRHqjDd?=
 =?us-ascii?Q?xdd4IE5zwCXW8AHH/HNgTVGkXiBx1MbikCn5DBAFB6w0oe4QPqvf9N8Hh23t?=
 =?us-ascii?Q?ndmdcPN14BaL1OhKFjz3nFq6nEKN3Rle+M4d0eHf/elLJB2KaskYnt5UoBxk?=
 =?us-ascii?Q?xPghFiwRL6oHING+7BW6H3N6+Mipr7L/DQimCkZk3qXLkrBRwCsTWq0wWWwk?=
 =?us-ascii?Q?fDNKnVvFasHhjucutO7yG/VcsDDv+61LIDk0c7oSMtrO5kiJlJcpgszuSDFU?=
 =?us-ascii?Q?VbxP8DRwScOlB/Z9m+4uppFTDn5TuNn8UclIZdW6rWWSDy+tmiQXvif9AKch?=
 =?us-ascii?Q?aRB5yRtZ6ICctF3FhVlfcUFLB6PaqNrFVPOUgw3Q8EgnU2iZoOST5GeI8Dq0?=
 =?us-ascii?Q?C05qxPu61PhRdzuTrj3GZUP0AbEcrZSCQ4NS7Lp9tI2tz0FVJQ5BChSwn5Gv?=
 =?us-ascii?Q?Sy0ws1893AQvgNtkxPkcvB3UCTuwikWiUU4/llZoadJrRIlCqDvZ+OVMy8+J?=
 =?us-ascii?Q?ESe3ApnpufqckCRKHTjZbq43eMmYYmzKSUuzpSG5qnUVPvOHpRaGlE8xIV4M?=
 =?us-ascii?Q?iarF/Q9FAvWQgKpz5qT4a7SnlV68gbwZSUi6YhXa4Vve1YHU9WB8caTVEH3I?=
 =?us-ascii?Q?hmNVWX203B56/syxi0SvpumWHc38z7MYhPaSZTnyUXN3TF+50xd7fHGYDZRZ?=
 =?us-ascii?Q?sn6nXNapE2huZTO0sEve4taDBoRlPZz5yEuUPSN/YjmnNWxQT6/h7PiCJ596?=
 =?us-ascii?Q?tK9EI5iZJx5zTADDhNArtxSdxMzhNUTzMO5CtKsJ7Fa0fDtoDXw7RFAYpkEW?=
 =?us-ascii?Q?qXR+s/16mPMvVOK+mKWMpKuK7ZRaypKFl3HQhfOE7WWXI3tMK16qrzE3MN+p?=
 =?us-ascii?Q?6Xxyb8YkyrC271ugub7Ts41SEnKQWhvGmNa5P+gOY5IAwfhh0SoJX4sOgjKp?=
 =?us-ascii?Q?gBqzDEuhxKPI+Eg8u3b5zIks0EppTTMRRUEuJKavnxj3XU4ABzOHbwXqfYok?=
 =?us-ascii?Q?sCjYRIqderdsY7/fg0BpCkICt4JkqotOPHv0NaTbjAFoqByT/D0hXP5FfMpC?=
 =?us-ascii?Q?OUB2GwpYqkuuadrcNBDJ4OnKnSRn61CgwntvZqA738lj6Js/GMD9L1yvK80v?=
 =?us-ascii?Q?LpM6oKuV5OnyFmJX0Wu3n5Oc2yjtIUHZFk0wH7lfFolJ0K+J+DzhHlFflBTv?=
 =?us-ascii?Q?g2siu8KEjrhrIK7VSsoZYI9fLG9UPXV98wVkWpjOOfK9m2jAUaYdnnbiRXfl?=
 =?us-ascii?Q?r2WqSAqyb78NpDBGDrRZe+B2wa/3X0mzzTELUPBNb60DWwSvs0qKWvPl0w4q?=
 =?us-ascii?Q?RvbWoZOawe0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?004Z0gForWWKO+ZpJ5RlkfzeJFOgS6h242+ztdlg+WQZCqPWaaiAD2xON1dA?=
 =?us-ascii?Q?fm11yf5EucZl/Si4vBwW82r/0lEKN1zfVSuS01LFM+hzIoSb9PEmT2NWtB0I?=
 =?us-ascii?Q?+tjthfdxn1aeIz5St0a0xAXwR/bAP8FFrRb7iEKN0bgcm929/kv7IMFiF3mi?=
 =?us-ascii?Q?lUp3fljmSsQuVBOQyUJBJwsYRnTXRTH2nIBJmLIU9znzUFwh9aRh77mb63PE?=
 =?us-ascii?Q?dtJ1lVlpeApANlOg4B51B+qCpVcuMlqjVpkMyS46TPGNtdIUgjoACP7tt3SM?=
 =?us-ascii?Q?8STPVEHRF9i6lyMyHN3VDJ5qq1IOLTmfXpLSEVrAQ4/9+6Ol0MMVEPEj7jz8?=
 =?us-ascii?Q?PQD7y165RCt4LrFZXLasPkNzCtsDqDOUczqQQwNfmUfdGLh3d8Atxez007dU?=
 =?us-ascii?Q?iroHNpuk/r7O65LInleonbU/b841zUFMsEIeoNSGvc41beqkI+zJ17TS1j5e?=
 =?us-ascii?Q?u6pcghMYJQcoIt6fb2HH9VJsRsMS9ZTrQOa4vQvhtZF5lHkWcTs7YpIFH5E/?=
 =?us-ascii?Q?Au9uIZzVryOUejFg+8yGPaHID10R2Z7akLyqShnVyvLGQY31GwkZ9AUofYCM?=
 =?us-ascii?Q?pRomGB5I7RZXYtOxh7Yl0yLCiwcTxGD89mLJkDLRx9M6jXQLps6ZHZukoXRj?=
 =?us-ascii?Q?lR2v5ZenS7IK6JwWOihX/+7BvyIBHYQDwus7l3C59s6ITQO8GlY8Kerz3ZlO?=
 =?us-ascii?Q?Yp2MynI7PDUxep9OX3dag6v09SbA/ZcmcH/xDqmDMxaGAow+Ts+O3zyADv5b?=
 =?us-ascii?Q?QmrIyaxIITqAzJHmWoBnWVayidQydS2zzT0yDErouVGdAw8gBHhgBkTK1i5d?=
 =?us-ascii?Q?EkXoU6Ak3gFYLRM24S1bg6oVzwjpsoerPK1Ltq/eEBW1B4TW/vAoO7yxAea0?=
 =?us-ascii?Q?xkK5aUB8i4MH10kQUThQUm3nFexKrC/YonfN9rttCOJP3WbwkkkyAtYeOt7N?=
 =?us-ascii?Q?XWsiwxC1hBBK+OKHocf+jnL6fbsB22fvi/P97xHh2YD9gBCrrBLbAjYZwHV9?=
 =?us-ascii?Q?7uX0N+7jRG2DAgjoAbhqswF2ygTBKz3F+kaAwqRI0ILztMghLU/WmrVkm1tk?=
 =?us-ascii?Q?/dNnt2K4p1inGLG5AV3kYzj+vOgkXwKUVya1KBSUnn1ZRNxWKI2haTe+WDgk?=
 =?us-ascii?Q?c9f3i061vK7K0st6UeQKq5dZgVR7nHhNUyZ8b6IXf7mSP27ycipuG9iO7qhk?=
 =?us-ascii?Q?CHCRlnRkvvGFIs6cCs3ocUeWVGJ7BiOoNrCw059KABjqyCdKCEtYMg4jfgD8?=
 =?us-ascii?Q?iLI+jR4BhKEgxELYb1fGXgxga1hkxkv0A1zdXzkEVunDz267QmAul7dzwTM9?=
 =?us-ascii?Q?t5RuTMhVzaMB8MZ9cVFKQQP5GjKZSQK9lvsYUkD46Mnzb4bxNgfqeOsIRTyb?=
 =?us-ascii?Q?NUL4qwVfAlhAhreY9+MdW6gfx9QGv3qMwtY2ArCs2Jb5SIxRLexJr3ORde25?=
 =?us-ascii?Q?eRdkL1qo3nmQrGvaTqgLP0IP6IWMkVZLAElc4HPE1llHVSUQstfrw0aUedW+?=
 =?us-ascii?Q?YbkkO3gM4TMxzi1Ag2C2+vGssJsqHCu+xg9gPLOj9mxF/TW3+f/qiCvCqjf7?=
 =?us-ascii?Q?T/JLydwCCaon9s8fb2RNDkxy+kI5sT9n3C0TqyMK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e580e7ae-f428-4a33-a606-08dd7e93969d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:50.9667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0S+EUW6QO104ANpgPwhz0VXd7/CtvpEdFG9wUQzA1OjDgy1AJzvpMh3x1YoT1uS1t6WhoQozKwhDtCCQdmnLSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

On ARM64, when running with --configs '36*SRCU-P', I noticed that only 1 instance
instead of 36 for starting.

Fix it by checking for Image files, instead of bzImage which ARM does
not seem to have. With this I see all 36 instances running at the same
time in the batch.

Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index ad79784e552d..957800c9ffba 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -73,7 +73,7 @@ config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
 cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
-if test "$base_resdir" != "$resdir" && test -f $base_resdir/bzImage && test -f $base_resdir/vmlinux
+if test "$base_resdir" != "$resdir" && (test -f $base_resdir/bzImage || test -f $base_resdir/Image) && test -f $base_resdir/vmlinux
 then
 	# Rerunning previous test, so use that test's kernel.
 	QEMU="`identify_qemu $base_resdir/vmlinux`"
-- 
2.43.0


