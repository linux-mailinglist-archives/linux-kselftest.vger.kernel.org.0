Return-Path: <linux-kselftest+bounces-3482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B783B245
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 20:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7AA1C219AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE2132C13;
	Wed, 24 Jan 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pE0oy2SP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3E131755;
	Wed, 24 Jan 2024 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124430; cv=fail; b=JpXRn32wP1bYJMt8N4JDVpXToWzaoYAjsNfVbKzGZqHoRwoiuBtqmu2SF+ru+zPGzlYWotGtkDwkI7HB+qSp/2F3UuMwv8BruP9B0+7ZKwDUYnBU37F+sDn634PnJ4ig4P/RK5h+qG3W17Tq6hXSN/6WyOurwaR5ECB76Vxcvb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124430; c=relaxed/simple;
	bh=tS1+p+10b6jXTARUCI2s206pdJw2L5QnLGmI9+B6qaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IS4O/sWNH3+ZoCHjbNw5t7q22HkHP+wi9Eq4dscqq3CTRM97RM4xSYZGVw+YWCQuZkce6p4nCUHhIz3w3nO6ziWK5IrBa2sUsnY4XD/3CVYUp4j4TFRRqD0cpgkUXmhJBmpycG1kwvetDg9h3mDG/j1TzpC6QQ0v+uP4uqZNBWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pE0oy2SP; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+pJwTJY7p7o8VJCj1MkFAyIk3xHo8jk3tOLRydXjz09EMd+/tYbpOmW8A3I9ZHFax4PG4WZY7O/YvxTT8MjXYjTSyMWwPoxCoAcw8flsX/j67eZS5B7+L8oX5SaQKsj7svb+8kNokoGPH+dL/v84r+/y6f7u3br4NlPe8IbQkOwv7RxrUyr8MNta2B54vQN5gAhdgnZ2YA6rQnDjogClp3GyVmqITbeuYVVD3ZYjrh7pzEKHZaaNIO6AxTAb8gK90g/a/vC184JQVGggJVz1J0ml8+AGS8dBa3DOnLYNYc5NT4o6RLN+P4H8OP7vefyfp+U5rrqjDACgclHHSGbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOO1e5pjw6anFy9ucBbPtVhZ3yY7C2SNLMP2wcoGB6w=;
 b=IO8AeoN0VejtjgL1XbkrQ2F/8jWSZO0zaMjhlOrUh41ALsoJrqRrfQX49HBWqioeAftPIt2I0lHepNX3QkmRm8ppZy+gj0y0DkUHri80zqY51fEdeSJ3zhlX+v3AoliNQ3pByOFK6UVXIrSEyHUU4xvRj/P94VykxEvUQx/iTzBmY2Vu1pJ7KrjWuPOle1CxuPx7Ge+WkbuKzYt1KW6SSlH3nXufZKLjfoY2bVCKKOCU5LZA/1oqg3lMYLkMjS9Hsu/ORXhpgbo4PS0B91l+aZJqE0yUsgLhKXPptJv3PJFIf0uYCI2QtJz+G7wCKsy0yuRhfUS6blBS/vMQnAg72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOO1e5pjw6anFy9ucBbPtVhZ3yY7C2SNLMP2wcoGB6w=;
 b=pE0oy2SPgsV0y+hiKgSV1vuoCiMtwiIDj9gnE5PunxheTosAkFmF/w/U7zh07iwxd9XJu1F5saYv5UQORqpeOqXLe65JxnFiKHPotjMkc2cMydDzt/0RuT20KiIhHK50kHGabzEIO38MEjMWClmshKN882eHCjWBLEci0wME6ZbDRt/xYWzJfL9JmZG7uAQJekOWM6e4i4AWvLBdgvDLNfstCf4r6+sn9xnpfn1pTqyaPgy08ZyCvtQcr0S0AnltAA7HFLT/0T/9IgDVUzO63wDC8cwWt208hFMm9eudlW7zbeUCAt+Ffi/JuQS02kEt0ciSGakH6T04aZnHD/VfKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 19:27:06 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 19:27:06 +0000
Date: Wed, 24 Jan 2024 14:27:02 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Gospodarek <andy@greyhouse.net>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	Hangbin Liu <liuhangbin@gmail.com>, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] selftests: bonding: Add
 net/forwarding/lib.sh to TEST_INCLUDES
Message-ID: <ZbFkhmEHBSHgJ4d1@d3>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
 <20240124170222.261664-3-bpoirier@nvidia.com>
 <8205.1706120677@famine>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8205.1706120677@famine>
X-ClientProxiedBy: YQBPR0101CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::13) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd08fc8-13c0-434c-5d21-08dc1d12731b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CxOX058J9czf1nPJQv/kYP2FJBiwdl4n7pDQ/A/NzCoJgdeJoGoISeoN8oFExoZJS5DcsCNGwdVRjfec+JCFKmBCaxZvY0afq2ab6ONsSGLHKC5VV7xvh5/ovNOdOeApY3kFkh0iuJrd5UzS7kazKzJSXte/7i5/PXuNuip8ETCoXEwUdfbI5Nq6Rbt6aKUyrqM6Ur8VyBLmmAJIbpdk7tRCXKvrU8q5+4RjjRy3RXVmRLclFUkWi8HAk/YeGFpBjSfs7helEJF8ApHfmPSd1cTBkQFwvKn/8q/qKGheJkXq2l4FuWhAHlvnN/kVB5GB1k7F7g0sp8ZdMnTvtPUwpFwTX1T9rIU+Y6mfMj9qcIHgAFAOQQ6DFelXdvXJsv2CNmGLLvE0PxWU3oiDlFq1TfQRxR9jAReT1lywYo3vvQt3XyH+SHqvw+ApS/V0kkGhs3KXoSE1EI353u4xkrZhD0NdPqQDXGEXVde1WICu5RhqwUhS1Nbw4mAyULZdlyxVQDRDJ5HH0RI0BRDAFHGZtY6syA8Zl30nwliPEqAtiD8gf//Fc42EIYnIrPZB3BID
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(86362001)(33716001)(6666004)(6506007)(38100700002)(26005)(6512007)(53546011)(6916009)(9686003)(54906003)(316002)(66556008)(66476007)(66946007)(6486002)(478600001)(41300700001)(8936002)(4326008)(8676002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJw39R3kc/4/wP1aH9xzQBS+smpWuvJsEvqewVvBI5Xc2K3j+zk12IcFLiiU?=
 =?us-ascii?Q?wLy0XTX41hSFL2pLgmI8qh3kOMS89CIjwXI4D+FvWDKd0ZCS5DhTuxAGcB9b?=
 =?us-ascii?Q?qd2QA7xdgW2HBKA2fu+gYM0dVQd9XVLwo4GgbPwo+2s1ToZKRU7Q7VMIm/2q?=
 =?us-ascii?Q?ph1L3WouhqC9NZvnn1hjB4V7xjrbjHWv5w/VEUBjZ3BRNeqGEw8OGnhNJQ1x?=
 =?us-ascii?Q?u3vLYjSx47qSKDK4m78yJYFyAkBPrZCyQKbFQAg7Cj1ZjRuATHe8vzA70G2A?=
 =?us-ascii?Q?sFawf7gEdhw14w+dv+AjCxE/VmruwPaigzG7Z1tB0j1bRH0AzvhSoAXg6WKe?=
 =?us-ascii?Q?9/S+WU7GhNESdOr9A3D70Y/2CzalfYHS/LSzdkIQrO+ywMwv5IwHq+Laep33?=
 =?us-ascii?Q?q2I9yFAw9U1UVny92vlgnUHx/gn1KosaURsPwriacbow4qDSfB3MO+dYSGzp?=
 =?us-ascii?Q?Tf9U11CC85jNNe455oBNVVLXHCzLt4hr6nqJxQtlpBAheJj1sLX9JXTOpoN3?=
 =?us-ascii?Q?ccMcQh2lf+KE4YKof5qryDOduA6Brq2S83T6KK2VSW20i+/xAZGgf785kAsa?=
 =?us-ascii?Q?hjOHN2zJUuyGpltIn1oevM9CoW/0dJ5Y+hKOCSRDbw1NFs1CUgofzr3lEezB?=
 =?us-ascii?Q?2lAQGre3hkjrglM9zCrq52/X1hjM3aeZJ78I7BjQl4uV2XC/n+a23ZVEYe/6?=
 =?us-ascii?Q?Osnf2tbFlseRaWonWi7eVtb3kNAtstFgnoQIJqaJfjCJZ0QT1PW3udktUbrt?=
 =?us-ascii?Q?oWi7fidTWgT30TjI4WA/UC/o48aDvvNvswCfU16aQsfKmFXJg34D4Qz/Akwv?=
 =?us-ascii?Q?KpXu75/En831oauhm4nOwuN733UBvG2RNoS7FaM2TdwS0jtScQc+lTqU41tf?=
 =?us-ascii?Q?yYkhM0YMBs0Gr1ytR27gFtXKLW25i9/o23yvHMCy2c09K/b+uOwM+puU4wfh?=
 =?us-ascii?Q?BZYivdEOnPsiwgqY0r2q7scjMWuWKsicLwFFEZ5uMjK3XCHD37uyAHtrKzNg?=
 =?us-ascii?Q?AaNGrB21ZS9Lvs+PoGF67nMKX5eSNECgD20TFnlxMyQopB19WqeGKzebYh9s?=
 =?us-ascii?Q?Fk8w5B4z4GxG3nhGOQrFR5+CR9WQJcbRcMrZdMBRcPXy4PvbV74rVc3kd3sZ?=
 =?us-ascii?Q?vQ+FdDKnduc97pRu0vUo4+OZrzKXlDCFo8WBqS2bm3d7d0tU2O1dGiqyGOsw?=
 =?us-ascii?Q?8t06xnFaROZeeqWKR4w8Q0QP7acnsxoa5PJbLghDvxYEBXdB0sEFFqU9oH5I?=
 =?us-ascii?Q?vv4FyJsRdTCx2OeFFnf1H3g7DXX4JDKKmHf9BFVlMpp1UNvSyLYhxXB8Iyss?=
 =?us-ascii?Q?HWNeAvx5hm4G+ANB7efa2LjzmJHURF4XO0X7HlFOWxkaNYLpVxxeuUUL0ZtB?=
 =?us-ascii?Q?covj9O3pbqtqqecAJ49WQgI+/+WjN/UxJm9dnL/fdNrR0gDfqc/risxB+MD8?=
 =?us-ascii?Q?ZF7KkLZZzGYUvJ8iFDv1cgI/+Cvzypra/siF0xtYpASdvGiVfGIQL2SyX4u+?=
 =?us-ascii?Q?ct3xykeNzs0kgwbjk/YjP9E4sC79BwhWWrMPrTtXljqPvqX/EkXLysBolUD6?=
 =?us-ascii?Q?q84fAIZzCAAHZXWG+GboZBJnSfKeUajCWcAmeYmGLyOEDVDNdyWdA/T4da/D?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd08fc8-13c0-434c-5d21-08dc1d12731b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 19:27:06.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GHfErI+Vmn1IQtXk3x7+oa1U7Ti2993D4lKV0OcjLVTkyHWuIdMFAr8PaRliCy/dBUF54+OoEISP08SjN2+zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783

On 2024-01-24 10:24 -0800, Jay Vosburgh wrote:
[...]
> >diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
> >index a509ef949dcf..0eb7edfb584c 100644
> >--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
> >+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
> >@@ -28,7 +28,7 @@
> > REQUIRE_MZ=no
> > NUM_NETIFS=0
> > lib_dir=$(dirname "$0")
> >-source ${lib_dir}/net_forwarding_lib.sh
> >+source "$lib_dir"/../../../net/forwarding/lib.sh
> 
> 	Is there a way to pass TEST_INCLUDES via the environment or as a
> parameter, so that it's not necessary to hard code the path name here
> and in the similar cases below?

It think would be possible but I see two issues:

1) Tests can be run in a myriad ways. Some of them (`make run_tests`,
`run_kselftest.sh`) use runner.sh which would be the place to set
environment variables for a test. However it's also possible to run
tests directly:

tools/testing/selftests/drivers/net/bonding# ./dev_addr_lists.sh

In that case, there's nothing to automatically set an environment
variable for the test.

I think that could be addressed, for example by putting the content of
TEST_INCLUDES in a file and having the test read it itself, but ...

2)
As can be seen in the dsa case and in the bonding and team cases after
patch 6, the relationship between the files listed in TEST_INCLUDES and
the files sourced in a test is not 1:1. So automatically sourcing all
files listed in TEST_INCLUDES is not generally applicable.

Given these two points, I'm inclined to stick with the current approach.
What do you think?

