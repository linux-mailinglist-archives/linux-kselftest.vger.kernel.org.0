Return-Path: <linux-kselftest+bounces-16283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4704595F3E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7BD3B20C6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8316E886;
	Mon, 26 Aug 2024 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5uyeuut"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5EC3CF5E;
	Mon, 26 Aug 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682731; cv=fail; b=X3HupyrCk3p4bmuRey0arScMZLJhZtJjXAntsdZb3sxTJvMupQsfbNbW5XsgndB+lz5i7mpyK9+kcIBIBQbkGt8diw7nOJdrQzMNoBJIfgxvDRX5Mm6a80y+pbMW6mjq7xh2vernYi0m/DSVs4mkR9zXwB3cLudJh0JcUdNNQbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682731; c=relaxed/simple;
	bh=f7BjLKbMvkkzWdc5OsPrvjaBTFp2eFQb9e9lpwmvu/Q=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AJcju0zilcL93q5Y5cYXG17m5M3jPkPgNGQ9ZtvIylk6ry3yLRXEq44IdEMr1jNXamNGbQ8i/Yf6Hw+4a5BDI3AzKBR3Y0KY5zfOp0hGCwAYkmzCfT1JaZVyN2iYm17i01MewgGaBwTz8L8lKxEIFShgkK5XeQ77xa8cr0BWcXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5uyeuut; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVk0zVywao+lHKo6fskP6GB3jZV/tHv66sH5+q0y9egusNl1D+EAmd8IT5Efs4JsJKowggFCmwmZxK5s3QMRD+IKOdbZ6d1T1ZB86bWG85dN1tEqJOHb5vNr8rJDmFAhAg4Ic2dlrAd7RyRDaysilCBuNqK33hC0O7m+n8p+W04vaMJHHjsealoy0cMp5HidRwIZVWe6FYc+lwHnZ9hRnlfV6JC4TZsl6k+bq+vUCx0qpQf1JrhqYV/0ukAAZ6cFGlEs8zKQ6AYjf/qyjYq3nr2rZ2bY1ig/VEeqrEfMhTfX9lE6nXk/D0LxVgbrKrcBaCTCqZRfD/PaiCUeaIpbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7a5SIozDG8Cz1obscHgTgXri89KNKWRp8sYUwg22/s=;
 b=hctE9wenZQFhSm3O4l3nHuEvAGaUUYDFZDQNJqK1Hf2xBXGrQefrdUd+QNn830sN6MWjthrMB5YHN19VZGK9ryI72Z3eeUdMtMuHMs0ACjscnYGAs/y+LrrCbS1msxoKwxL1CmhY1TAgAmLUOOKCdrzh2SyY+ukDTi7II4gqh8wp5Bn8ntYiRC9dXrIwq479cHpf5532skEMhTV8mwKS++aPozsPSgc0vZH0AJCvaEYBHKaQG0fgvRMjbx5cOIv+jhAo7uxDNmCCBJK3J0yj9U1sBLjppckuE5i/X58PRK7bQC7m4ny8gWcdXs1TtU6Z70apxajQr1JieT5W9jmq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7a5SIozDG8Cz1obscHgTgXri89KNKWRp8sYUwg22/s=;
 b=I5uyeuutPtLdRgiZYkeO61vLhxuHxmyuCV4YEtqNzO9NLaUxQ5AfsOC6qEoV08ktGcYFnc9xgJQB7cvmyaZxCshU3x902kl5iZM7gtFu6kgU5glyyU3SLV8aSRg2f/9FQk0jcOoiVurmMW8Cva08TnGz1wCxJYVqyeNLUv8sBM007gmuPDmpMo1JxIMDOaDLtOG2ux3jS8N9083Zi9YzmSLG45XHwuvpXs41ZslLPL+9Te/YzvS+N2iEiw7wjNeMlSNFJeJlGh1NPQMuY2x0lyI6mQwfV/ciRoaT/8I+/LJqyb+i7wuN/BDO3DGIO1Ulqu8Bb//IqkmJ3qrC/YMvzA==
Received: from SJ0PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:33f::10)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 14:32:05 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::c4) by SJ0PR05CA0035.outlook.office365.com
 (2603:10b6:a03:33f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 14:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 14:32:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 07:31:47 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 07:31:42 -0700
References: <cover.1724324945.git.petrm@nvidia.com>
 <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
 <Zsxai0ACHxfbwH-t@shredder.mtl.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Amit Cohen <amcohen@nvidia.com>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
Subject: Re: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce
 deferred commands
Date: Mon, 26 Aug 2024 16:25:47 +0200
In-Reply-To: <Zsxai0ACHxfbwH-t@shredder.mtl.com>
Message-ID: <87wmk38ieu.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 22995f7c-c779-4f12-399d-08dcc5dbdbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hGBNa6K+JubWjNPuBgb8xCg1fRdQfQ9bQok25FXtrfHBrR5HVYA0n2xpvqJM?=
 =?us-ascii?Q?Vbc963N2rHSZlnuESTPIENwn0kQZ1XouiEyM3UN3r1jTZlp5qYKiT61NBJ4n?=
 =?us-ascii?Q?IDVvCNzNcKgR6pVTeZHLXY1VaNGLn+/pr7AkendbBofaKqNNvp2v1CauWEN3?=
 =?us-ascii?Q?M+NwWVthtFTwivkUldAOaukJYwMGAzlTU41G+3xdltqo5rUv3sSt6uhJdcYy?=
 =?us-ascii?Q?rYM9Exjx9WIPp9hGYqc2pxujVNrMxc7L9JZnmINqb38HPGTsHhxyqXKlvelR?=
 =?us-ascii?Q?TzRrwoDhBw4cSvNIXM3FGHiBUVx9CEYqV91wPUnx4zIEoDh4L0WqIs5TJC+H?=
 =?us-ascii?Q?Lw0E/72PJ3rDhZ0o3RLMF7it6YuZR2jhhJmFTrDc1WNFZCTJwnFoYTCh1/nF?=
 =?us-ascii?Q?YlkAvS0v8BSwSlDIusIlVrxSaX/RJeo550yqPu5Y8VmlGOQIXU6+3+suswZ3?=
 =?us-ascii?Q?+ZbkznebyWc0//R3zIZ+Hc9Krmf7Ka7GTK2U89lSSK8bTNo6AgtYKYmZywvg?=
 =?us-ascii?Q?L2MSZpFiIc8um9FFVe3wbNFIJMIXaaeWHYfBqPMRY75iV0OLLKEivaN8U2lf?=
 =?us-ascii?Q?ptkSynq56Na7NaCBLDqGENnXZSoTRUsnqjPNzAfRmAHC2kWEuSDKhO8354x7?=
 =?us-ascii?Q?UD9/rKVzu5Pz4Vr7QJPQf4WH4mqFvucTg84h6A6NzYRchVP6JxJ/iw7khRHe?=
 =?us-ascii?Q?W/l+RrULEmbZ+p7bYgShP2TzusQkbqf+jgFPQD8cJ0Fr4UVCjgNAA/tN8B6I?=
 =?us-ascii?Q?MVDLpnuxbqLH+rwHEmqvrejbwqZqQun7p5MhM3u0yd9Jtiwco8xmyMaDiNOG?=
 =?us-ascii?Q?SrpnYXaHtJYikhK1sP/0BDYYAKLrSo39MqK9sLzNjh1rflBc1/66uA6JOwMa?=
 =?us-ascii?Q?C5e2wt53k0opRUpCofTDJfPtgPPIo+2N7tsae4rQyNZlxSX59JOYYzfnsw1N?=
 =?us-ascii?Q?3T5BLbiItKut1G7mV5uLBKbOTO5YymzgK+nbO+jypF3DpaqONnFacRtl0Q7o?=
 =?us-ascii?Q?es79zqZw6b67oyIlRc1XnTkF8ElGufreV7PaLqmopCwuMXEY5zIjG5BUXY0d?=
 =?us-ascii?Q?1C8+aQL3P3b75YnIVs7K7l4SiiDRUqPoOX2I5gTVq3O0UekBsHp1dSSgbJ36?=
 =?us-ascii?Q?Gyb9LamSZngHlqFq02BE9Zm4vrAUFe+f1uV4xcrEgbE7Wy0Ej3D4A9Ag7flX?=
 =?us-ascii?Q?o4Jam3Ftzq3Q+nHoMhLZ3EvBEZxTLw9qf0Fqas0h7Z38qsbN59AVJBN5VWAm?=
 =?us-ascii?Q?PSPPAuF+BNmLrhJYNgqKuqjtLpjb2LKQStysOIpvLEmV0TpHH6yrc5Oyzf6/?=
 =?us-ascii?Q?VsGu0mIcpFOWzHgcGqSCOffG3RrLHcNvwAo6gmRNPbyscfeiaoM2DXuBA1nL?=
 =?us-ascii?Q?zseymxE///bK9CEDHK4MCl58DG7HfJLo9+TSse7zunyQbjLRE9pV+IdD5On2?=
 =?us-ascii?Q?vg1KxmWMa8z+G6izGmq0KRcBjWH84YYj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:32:05.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22995f7c-c779-4f12-399d-08dcc5dbdbd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974


Ido Schimmel <idosch@nvidia.com> writes:

> On Thu, Aug 22, 2024 at 03:49:40PM +0200, Petr Machata wrote:
>> The following patches will convert several selftests to this new framework.
>
> The intention is to make sure new tests are using these helpers?

Well, I sent this as RFC because I'm not sure how far to push it. I
think it would be ideal if this were adopted, because then cleanups
either always work, or are always broken, and we don't get partial or
forgotten cleanups. That's for new tests, I do not foresee converting
the existing selftests beyond a couple examples.

>> 
>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 83 +++++++++++++++++++
>
> Does it make sense to place these helpers in net/lib.sh?

Yeah, it does.

