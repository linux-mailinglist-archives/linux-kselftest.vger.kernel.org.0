Return-Path: <linux-kselftest+bounces-37977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F7CB11A01
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 10:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C0D1CE0ED3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 08:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7BF2BEC5C;
	Fri, 25 Jul 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qWl2gG8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9F2940D;
	Fri, 25 Jul 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432500; cv=fail; b=YxXfbFIlqD1p1rVMhIqNwVijlDlJFLD0Jh0FOv28QQIIddyEsd0HM2FTPFK/Ef+4M+fWAUJFgRsgof16xporW0gCbvDuoS1SrCztMf/hZP3AGkn2giOlFB+DnJTdmpOqrakb3hy8FSgDrkQngRdSfhbL8OB4eOhDKoB617W02Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432500; c=relaxed/simple;
	bh=AMTlpviCMUHkMCG6jFqg9NKxXuCR0lpTKD86ofv30/Q=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UqxzGghHEYEOlgz4QuX+7LoUbWydqxV8FV0bkR81DT1/tptGatauJPggCRpnJpqJ0HMjb3VZh7V/vauZck0xYpVBLoHnlkqU8QZqp1xCgh6ocXtL3x3vjxNYGWm+MgFWn1MVmYOwxIK59FQl2xyXFHQe8WCWuqTFm4Sp748D7Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qWl2gG8p; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhvCH+yEaiLbUi0gvpcnX14Qg6Y1uP/3qzHHlghRWkdufBMdQauPMtDfnwmzhiRsET6Y7dmf+E+4DSomADXWauJke+848V376moFixiyLM/2ti2aV4TmWLMmFMvPNuhLc99EVnpx0r/VQ+etp1eYkAM4mbExuE8n0aQi0DgYuV+WobrE2RqHQCz8c2Z02WVKM6yydcIErkYSRNCR7ZlvnSjYE8m2NaSCWTsfUzWD0tycHKvDMdfbTrjCfQkVUx9mXZCM1GmprQPdXhUJ8SrvLD5/Kzagw43d25K1h0aUM1iO1U4ym11WK9Ox4aWgoNMFGrNxabvEjWXP5M422Hre+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVocxqT5xa54LQ6I6UDhdU4fVWbs8xvKjunDqLd400w=;
 b=HH8Psob5xXgRnGwYG0xhU/y+YCwZbkJbhiW/4WfnccwZ0/m20LrgmIX7D5hjJIpzj/gtHsphpQjwkwQqO5Op5huJ77K4yDoNrN+WUyjowHKRMGrqdPpS8vYHXYF4IYIv8cz2to5pgj6L/Oi/J74M56mweDnWPcaB7WTmJ5buDqCV/zJxMfXd5AIMvQO3zhSdAiMAnBKU2JB1b1kz8nHYcC5ajdpCbZj96p046sMBd3nfAZ7mVMFghqgs1ecvYVdwa6k3rSHrFw5YKGQNXneLN6JBg9Jw7J7hy7FtYgevOtlKwRhcUMuKYMcwu6M4XNPIR++W/WfGPLpmYmISSkh8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVocxqT5xa54LQ6I6UDhdU4fVWbs8xvKjunDqLd400w=;
 b=qWl2gG8px7ueyYceV/JSze5bP4eIN5U2gCF4Z97FtPQJosMeEUE5oyU288j+7groDLGSfqkuYWNMEZ2yvnwCMgaWrDJpIPaXCsfLQZZcnvRMmAuzZbjCR78zdk04dH+gqhAaby2XZZ8dJ9Edy9/JYCuOXxy4q1K0rc+9YPpAYZ0JkEdx3KL0BzmSdIIFJJUal+XiYbI/SjHLyVViPnU0vMT6cDJWu2k8kOvInQaD7nGvIaxnt19+JW8YLtbC7+DnRO9LjqC8Ozx/I9oWGAmr9ibnf9JIsXPjipxpDgUp8WZ2hszfFHblavHWXZn4+jHcj8YKCpaVDGu7SfPvlzSMHg==
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 08:34:53 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::59) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 08:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 08:34:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Jul
 2025 01:34:34 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Jul
 2025 01:34:27 -0700
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-3-liuhangbin@gmail.com>
 <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>
 <aIGxI_ctF5RPEph8@fedora> <aIGykkgqktjgLvVI@fedora>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>, Jay Vosburgh
	<jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] selftests: bonding: add test for passive LACP mode
Date: Fri, 25 Jul 2025 10:27:48 +0200
In-Reply-To: <aIGykkgqktjgLvVI@fedora>
Message-ID: <87ikjgd5yq.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec48d5b-b522-42a4-600d-08ddcb56210c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5PLCuenFUkY3s9Xj0Gj8mr0B2pDKbT2l/UoNj18RaJqt3C9xOw0JrARWNP3?=
 =?us-ascii?Q?Lf4Ml2RFeEdfogVuWAeAsn4397vEFFTF9Q6cSInZsU+DPbao8CGox2sKML6u?=
 =?us-ascii?Q?Qnya0yPqJ4AsWqXZsQcJ2yhw7xOQjfiogV6ma6IWSAekEO9GbdW/8vgTuNNP?=
 =?us-ascii?Q?p8rck+mfDm4i6chNKVu1j2zsE08uhfXsfd/ot5m8SjWFt3eYPVcWfqUlsBhB?=
 =?us-ascii?Q?dxfniIakexf91NtLslT73i8utMLb89Ev0OhxF5uYGeryY0A7hEOtwL/jXHYz?=
 =?us-ascii?Q?VBQ2hP21/SBDdU7zBhiS0YpN1Ii0oqBQPERv7mLkEnOpKeGOmauFcn98mvXo?=
 =?us-ascii?Q?6gQqaNZ3JSSHY/4eFKxUE/IIX45J65jVljS8CKZeMIzgW3AoffVU7ql9uTE6?=
 =?us-ascii?Q?GrRQakHbnK35MqitlvNIGt5tX9gcIlqRoGUlygNUihQsUFv8qSOBFcu808HP?=
 =?us-ascii?Q?gcv9B8xosbPDkY2Qj+ZjkQUnU5XduRHWy8fOfZMOTTaXVXf6w/QKLUiuPeJO?=
 =?us-ascii?Q?DY6dvbqmwn5td9VAY93c0alAkanBI68Fq8cvPZyzPw7mO2pGn+go08hzYIo9?=
 =?us-ascii?Q?tVOAKyNiYne0JSw6V31y4R/CDKggqYdbSw140pUKDEy9jkYu6e/VEpMBfDTO?=
 =?us-ascii?Q?HeErPJzkaVwIHQYoykZ5JgAYNLPDKgw+uNzwwUapF6LH3x/28DLFPl1WCo15?=
 =?us-ascii?Q?up4HYZP3XePtmyRYPPoONLvI8fXn/GU1UxE2tO4qNdYyvPCSiDAOe7s4qjRY?=
 =?us-ascii?Q?wzypyYAKC7piXWz8KWnDxm2JTQNV+1IzC5waOcaPXn5+5oOWP1ABwsN5mUE3?=
 =?us-ascii?Q?X+PbJllxEdvwKn9FfuDB8lF0zg3lakH1X19I6n7GUyPa0VAD1kSbOyovDjDu?=
 =?us-ascii?Q?dxH++K1nlPEfxdQO8c8C782WgshfelfCiCU5qIMe+zj3yTElH3P3zBzTnihO?=
 =?us-ascii?Q?APzi6V3l5DqOI2hs5PWnARB0v/2YdO1asOIwnWyTCAE8ewTNsVxNfOZ7jh8z?=
 =?us-ascii?Q?V1FtBDKaK4F9tFW3M8QlSNCCdFFX9yDT63BHjQMAUVB+QvFUqBrkXlHzSUsV?=
 =?us-ascii?Q?ew2bxt4WSOqrpQ3sCvruHASev7UTS9suVxGN5hxf2ngXdARLMJA7b3PJkl4p?=
 =?us-ascii?Q?2jq3zANQPJjl0f4AZP59V0uBgayW50bm5cDdYMe8ISo1Kzd2JPil1HYfOmiP?=
 =?us-ascii?Q?0nsg2l1e/ALB+YBQumDKEu5EeixWxvgamIAsqMEaz1pyolp0YtEyRTe/y4Ve?=
 =?us-ascii?Q?6RLJS6nMAtzGJwevW9spG0NJT8Sg5EElMnfn4+b8qDkR1FRSqm0WMu+zGWn3?=
 =?us-ascii?Q?YIK+/GZVFRlTC/oF4I+MkpSohhizPLQ8d7elN5+e6JjLh9svzOZ8r02iZOqK?=
 =?us-ascii?Q?lpzdOF8LcCLSPK7slEbES7/1FrFahDQM00O9t3vW/ed2e422l9h0HyOWHqFO?=
 =?us-ascii?Q?j5M0giZe9ILx+uYD6HCH4iUNszvuuCL5OSYINjYJPq7AfXGB9F5qsU9ZLLRG?=
 =?us-ascii?Q?5hMhr0gQAtD/At4RenEh2xK5PjBxPRSkUAA6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 08:34:53.6628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec48d5b-b522-42a4-600d-08ddcb56210c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438


Hangbin Liu <liuhangbin@gmail.com> writes:

> On Thu, Jul 24, 2025 at 04:06:03AM +0000, Hangbin Liu wrote:
>> On Tue, Jul 15, 2025 at 11:37:54AM +0200, Paolo Abeni wrote:
>> > > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
>> > > b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
>> > > new file mode 100755
>> > > index 000000000000..4cf8a5999aaa
>> > > --- /dev/null
>> > > +++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
>> > > @@ -0,0 +1,21 @@
>> > > +#!/bin/sh
>> > > +# SPDX-License-Identifier: GPL-2.0
>> > > +#
>> > > +# Testing if bond works with lacp_active = off
>> > > +
>> > > +lib_dir=$(dirname "$0")
>> > > +source ${lib_dir}/bond_topo_lacp.sh
>> > 
>> > shellcheck is not super happy about 'source' usage:
>> > 
>> > In bond_passive_lacp.sh line 7:
>> > source ${lib_dir}/bond_topo_lacp.sh
>> > ^-- SC3046 (warning): In POSIX sh, 'source' in place of '.' is undefined.
>> > ^-- SC3051 (warning): In POSIX sh, 'source' in place of '.' is undefined.
>> > 
>> > either switch to '. ' or use bash instead of 'sh'.
>> 
>> Hi Paolo,
>> 
>> I updated the case and remove the source file bond_topo_lacp.sh.
>> Instead I source the forwarding lib directly like:
>> 
>> lib_dir=$(dirname "$0")
>> source "$lib_dir"/../../../net/forwarding/lib.sh
>> 
>> But this cause shell check unable to find the lib.sh as $lib_dir is get
>> dynamically. This usage is common in selftest. How should we resolves this
>> problem?
>
> OK, I just disabled this warning.
>
> # shellcheck disable=SC1091

I believe the point was only about using "." instead of "source". The
following should have fixed it:

. ${lib_dir}/bond_topo_lacp.sh

... or just use bash as the interpreter, I suspect lib.sh is not
actually POSIX clean.

