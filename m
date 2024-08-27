Return-Path: <linux-kselftest+bounces-16420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABD196131E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D952EB253B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148CD1C6F40;
	Tue, 27 Aug 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qok9uLoU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909981A072B;
	Tue, 27 Aug 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773275; cv=fail; b=hOP+Lrk3LFJqcZNazh3vLAD26w4nDD2n+RhJ2VdQYcZPR9CTrK1UWzXbdzbd5dplisFalmlnrHtzLZR0Fzi3bCl0h33sbr37q62gXVSB8P8+coHFPDvbneU47regdv3blX0oIYLYqM63voQuOfAFeBl9K2b4mB6LX8dTZ6sVtps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773275; c=relaxed/simple;
	bh=0EqLkyZm3M/CYD4wSI5ZnBoizv4F+Tqjyh/KcRYxYRo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lg2grtYZyTqZRNvqnqb7/pED166YeHdZlOUXs45DnbSIpBJK5c52F23QOmmj4mC9CTdw5KVfIvrWpg7mtssGcnEP6t/cR9iTeIlgVARFFNppIG5+UPqOUbFDgjDvRK5s04JnZ8jpee/xpuKWKRxbDIphkShgnxxL30h0SVkTpLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qok9uLoU; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSmw/YveEGU4t1WkoQBkM5fR4cFgZRM7QTYvXSZJ2/kZ6IuDXDSYl9zz3U+c/9I/hD5bnh6XCo5Rr/HAE2P0YPrPbEbpifZd8BfzR++f87ffEhVeIVT96jiSg6/dgegndzd5K8h1dYHdkBVaj56U2Kn9LHQBaJWKpqEFC7+zqXlkZ/zVPihpANbpZ/yU0ShfTguB+TLGBqNlu3GsJKB/RpKClsycp7uRazvLgxl72F5OVhgt6lNFi0HY0SApIw8Ai1pAahxjxh3CIx2v64rjricw9OW9QJs8FcFxCSOLSjJVGOvbS6G/y0Egr2t2soMbE7JOTxtT/6pDCU2+BbwBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsN+3Vqbt87WhkLB4Q4DK5CDvnyaUdNM9/9O2dFwfZE=;
 b=kIixLJE4ea5NyR+7WY4BQ5aLRlbQvZUR/dw2mbuLf8ODSvGEAS3JPWkEe4QJ2hDL98eG6o6vLCCntI25Gor6V+Rttv6JC/x5h5ocywr10JH1AslNSNp0mMAAUt3PPnBkIck0Wf50VpGYP9k8e/w1XLImuBijnXgkgrHq/lWJG7xT3zuJZOpeVv7+R6nvQY3Fd1bF3lWWk8L1tIbZ2bL3hpyAqVitre0O67EcUKfGAJLuVmNWYBgXcH4n6IEusYYzcUxRB7Ut6vLcICE1Xjw/UFYPHZzb0I+Ij+a3G/SyWXqr3Im4CLrsapkuhydFm2bEjAju7pEu1E2OtJm6KgFoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsN+3Vqbt87WhkLB4Q4DK5CDvnyaUdNM9/9O2dFwfZE=;
 b=qok9uLoUDFKChcTkARQjQuIaVChVvYpRHKApD8F8xqPQrm9NgSHhjtGYRxkugWVTw2Enl7MtqBO4fwgg84GdSE2/PpZChZZXSQ3fd7Q7vbZtbTqkKRGij//v4q3i1H4uATHAJaDohoQ7tfDZ+UdyfgTbZUekcRNh0v7214b+XFWJJPI8SYOKdgjrfsyMR4ytRN1U05F9CHNzF6lAV6Iki3elOstAo1kZrc/3drPufP/D3QnEEHhffqI1qEuhQYnbOFYq6Zccp2o/7oGKahORwEVmpnDNznJPJmSy0iAcjOjmBE0tRXuJH49DNIOgK3zu8p4HEkBB6J2S6k/VPrxlPA==
Received: from MW4PR03CA0308.namprd03.prod.outlook.com (2603:10b6:303:dd::13)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Tue, 27 Aug
 2024 15:41:09 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::a2) by MW4PR03CA0308.outlook.office365.com
 (2603:10b6:303:dd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Tue, 27 Aug 2024 15:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 15:41:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 08:40:50 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 08:40:44 -0700
References: <cover.1724324945.git.petrm@nvidia.com>
 <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
 <05b9caf6-ecf5-48a2-ab65-509b0d5b5fb0@intel.com>
 <87o75f8e0l.fsf@nvidia.com>
 <3312a4a6-97f5-4ae2-9527-c7b1b73da6d2@intel.com>
 <87jzg288sd.fsf@nvidia.com> <20240827071703.59401ed7@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
Subject: Re: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce
 deferred commands
Date: Tue, 27 Aug 2024 17:37:36 +0200
In-Reply-To: <20240827071703.59401ed7@kernel.org>
Message-ID: <87bk1e7z47.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 999199c0-19d2-430d-c2c6-08dcc6aeac00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XcU7JI82Y+SK/cEPuAqSc670IzNM5GOwMS0orpcpBEXRd7oIUu9e+CvLnkGf?=
 =?us-ascii?Q?l+ySiyHkY/QglcIFByBFV3SOQqAuNqQ2NS/LIAXmoX0XVNbSYcaWv1c5reCH?=
 =?us-ascii?Q?9dvBCyytm+r8jdgglOXBNNhOlwaDurum7ALZZS1XIeouPPy7Ouxm07iLduWH?=
 =?us-ascii?Q?cFGiUbQDUz5DoU0IHX/xwH8xaiDV4Vk7oJct0LwGaovR69tneppSLHu6Xbnx?=
 =?us-ascii?Q?TlEauTPS1YAJggCJuRCzQVCot4b5h5qPpA8KfL/elr7zIf0qPTNgCOfcZ0fT?=
 =?us-ascii?Q?rJBudtI6f1SPzt4Rh62ccn+xAk5U3kE0eHQcNikpTvkcF36sPUsdV9+NARsE?=
 =?us-ascii?Q?fZygERGhPF3p/1fQfplU/kTPF/gHoJgxJlpI52aTTXMr7pteuSGp5oJFfOck?=
 =?us-ascii?Q?Hqn79xw9wJ08IQ6qdrjTXP7WbR2A+UvW5da92Ul79pyouLGYRVFlBcbF3OaW?=
 =?us-ascii?Q?xbfnoVB3q0tQiS2c3nesX3O6QJPHFA2LYd5fUObBMfh74rXg/kvX1XiTgs3J?=
 =?us-ascii?Q?2qnbvBfMwMyggULUQxDFd5zZrnL0ogb95uDQ8RM8TsrDvg6jsbCXCagMx4Dw?=
 =?us-ascii?Q?Eevyp+5SNZ61u5C3/1f0cIaY4SVhsRVeTN33t+7R+eJ9ccYLCjW1+v6zpaQH?=
 =?us-ascii?Q?kfHxBBLZDmw2YwL2AcwXGXqLZ2eKeDcxjf9yS8eKledL0bQVgtMV33wc+dNl?=
 =?us-ascii?Q?RGI+280s+d16G6bWOb8cbE7pWFF1XYDHIaXbxLJyW0j4RNhZd1eag87Xd31B?=
 =?us-ascii?Q?ZqSSAKi/DkOCi69p8Wql/nxX5q2sWho4aMA/T3GTN1fqTDn/7Rt+FCXbMjEy?=
 =?us-ascii?Q?pz8NLiKqXbwh6TqRgaZxc4V1vm+bJNvmn5+J5KGGZT0e4+SfNoYhR6KBHeSN?=
 =?us-ascii?Q?8mOrPoxJ7P2L0RCNQ8LKxHphKlTCHKwEirof6sYHkWRDmbimqkzhashf55u/?=
 =?us-ascii?Q?rPbDeH8Xpu5UwUqr9W+WhHLoHM+gIBNcoxaeEqKMgLOB7iwYhH+9KuvVb2ry?=
 =?us-ascii?Q?MBfpLVftKkFyx2wQlxMG/2FKwAOAKro9F9nwu3h1Qzx6hfmMP5NuJSfInlUd?=
 =?us-ascii?Q?Emq18tCE4iZUvTyLB7e24/mke6/EzkRoeOsEs2dXNZfxvw2txmcDDRGqLraS?=
 =?us-ascii?Q?nplOT4fft2wIERtp9xzKSg9ivDmxxbmJd/SJUpWjTr/bDDNNCLeqOLvkK/4T?=
 =?us-ascii?Q?1IEdBID+SqwQEjd52C7DxrBonoMevuGsgxUvJ6AX+K3IKoZUgaehrVtC6nUE?=
 =?us-ascii?Q?KYmnoFBj8+HjxVa9n3dRPze9O8sr/Am/ox1OkHAErjyq6bjHnNHe0OzUT+6L?=
 =?us-ascii?Q?CcS3hOmeL8jRNCV+UizCGB6mEn607vLPBEtP/+K0kPfROh59/ZzZT8heQVYA?=
 =?us-ascii?Q?2iOBdV5QoJ1MvTeb0z2BUl9C1LhcXoRRrtAoPxNOu6aSGiwRwWt4qdBWmLYS?=
 =?us-ascii?Q?tupeHnjHfKqvbrzMOUZg8pxwbStupA81?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:41:09.0857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999199c0-19d2-430d-c2c6-08dcc6aeac00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Aug 2024 10:53:53 +0200 Petr Machata wrote:
>> >> I can do it, but it's gonna be more pain in setting up those
>> >> TEST_INCLUDES. People will forget. It will be a nuisance.
>> >> I'm thinking of just moving it to net/lib.sh, from forwarding.  
>> >
>> > what about separate file, but included from net/lib.sh?  
>> 
>> Unfortunately that would be even worse. Then you need to remember to put
>> the file into TEST_INCLUDES despite seemingly not using it.
>> 
>> Like ideally we'd have automation for this. But I don't know how to do that
>> without actually parsing the bash files, and that's just asking for
>> trouble. Maybe after the defer stuff we also need a module system :-/
>
> FWIW we could throw it into net/lib, which has a fake target, see:
>
> b86761ff6374 ("selftests: net: add scaffolding for Netlink tests in Python")

Oh, I see net/lib is the default dependency of everything net.
This could work. I'll check it out.

