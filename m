Return-Path: <linux-kselftest+bounces-6654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBFB88CB11
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D5E1F840BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD51F934;
	Tue, 26 Mar 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C+7Ouz1y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F61C6A0
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474537; cv=fail; b=AQkRqe9HbYUHq70Xcf2yHLPMPhjZYASKwzdpO/e6KeVefP63VC7dmd7hnZPiN6jIwbC4m2zA6qhxozxxaFSPL5AgKYdJHWyWpL6HRwsTEdVnAycdAabwuPGaDx7Ii1PspH2fP9CoRHvvUdzygNM+mxaRUq0/SdNw3uzPt5A0xaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474537; c=relaxed/simple;
	bh=zgZUA0t5N2UuaNL/RgQsDZdp8OvuH8c64PcRKPpC6VE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TFPg5dGo0H45QG+q4eX+YoHpbUr5IPJBJACh8n4zaztgQkUFwQKdFUVJnZZYBl80ZDwZiPretgO3VQtFuXrDN5u06A78B5lu4kyRLOd5pQohYmfafY8qyyja+u07/kGv4mivu3IQ5Ny/bcbTMuYQO6q6Jzxh0rvnWGbipuU/Kjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C+7Ouz1y; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+VhprZ4Pw8hEGEJVeByUN0OcatmE3CgRtBno6h3Pa/9WR0Pp8dXg85RwuL65CZes6ZfCJvOSxGmN3PXeMd7rrHkQrMsQVgysVbtUdHSgvFQDS3XhjZO09K9PjjcNEKbtFe/eAHjsQF/nLBly1EmoQ/hJAAwxOVorbi77FP3bCFRHfM4sD9BPut8IURDdzSakMBErLpxMhIybV5S9BZMd5+ZLzeZRK1K0ns12KL+JVwSEOzSqUe1V86TPn5uABen4HFLit2SJS4OdJPktEmO81fZjvILrWs7n6vypg03dhvMNxjJYJqisHaOxo3FRCCa8lg1GXTlY9Nlgod2Jxovyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV8qoAdG1bNXjG3oof+jxvohtUqcIRFanHuEgIslcrU=;
 b=h1Isyg3J327weB38SMZX46Ki3ERUgcDq/zsVlRfwI597/26fRvpq+mzop8h66VwSSkS83Db2ohr71Z/CWiTSLXWxXtaUwOVJZRLfyfUQ9vMJpcB8vSDQmkQ3ZJN0qH39PhFtzGnD/jikJs1A4grruoI+QX+66yLRMvYEsjg/EJRxBcpWe1jryW0MaKYGC36bIZb+kYPqoHrUfJVdp/0f8epznHGJ2p4svbXIgVX/YJbka5hKp0T6iroQ+UN/+KpNobDMZEZtAkz/hWhM73KWqrAa5Y+PRkp11UONN5ddSIXmA4+Qui10vXi6+bC6XE5XLbzHC+DcyadszXUxgjKXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV8qoAdG1bNXjG3oof+jxvohtUqcIRFanHuEgIslcrU=;
 b=C+7Ouz1y4iY0aB8aZ67eObjcxVFkNXxhR870t5BxLoAVAu+cJ6AgBZQLmAgnhtxu15jvtU+i938QzDzLHeSdir8xsoX+Ke1ZVvM9JUTm9RzwWaOmMet3cMrQFIkeIF4729tgsx+Lw9rTAqfFn3QDqW03tnxnkc683dhXHpxHWmPXV/LAO3CnNDo2MG63YMdy4K1tQPXXLgZ/gsJooSBFQnWQy5SdvarYdwPmSywfMnuN1GeOfWgQW+OY9snM3eqEAkfY6paY+FTnkgV3m82QGUweBdFHY+Bk4z8eZ0vW6oapMG5TaQa6qbSfbEXOli/PwcXVSxVyLe5vIi6dEYOkXg==
Received: from CH2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:610:60::12)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 17:35:31 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::e5) by CH2PR14CA0002.outlook.office365.com
 (2603:10b6:610:60::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 26 Mar 2024 17:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:35:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:35:13 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:35:07 -0700
References: <cover.1711385795.git.petrm@nvidia.com>
 <e819623af6aaeea49e9dc36cecd95694fad73bb8.1711385795.git.petrm@nvidia.com>
 <20240325173417.1a79b631@kernel.org> <87cyrhjim4.fsf@nvidia.com>
 <20240326071313.64287229@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<nbu-linux-internal@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Benjamin Poirier
	<bpoirier@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH net-next mlxsw 03/14] selftests: forwarding: README:
 Document customization
Date: Tue, 26 Mar 2024 18:32:22 +0100
In-Reply-To: <20240326071313.64287229@kernel.org>
Message-ID: <878r24kibh.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 119d1521-6fb6-4fc5-b4af-08dc4dbb2254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qLUlthRHZwKQUUrm4glKFtD1AvSALwj7ND97a6QVSrVLaQ4wPVvFETz2w1kk6DV+q3BO9PJnFkGvX6/f83nnZ6K6opvUrY2vhtuRmf73AKw3VKhfeOuj1vIkvJPL/rTXfqhkod0NlKloMeKr/UkRrSYBq6mC3QcqRXb6R9LNqOS8106vfEur7HauVNFzRss/ynThn93RsyuVkbAZPajMSEU+0I+j2HVoEVw6EW9FBXJZ1TkxwHOeDOHvkFj0755U6+11UfuZ8v0OKnn9mjvn0HaT8Mh0mIt4mhK1knkpOBTc+iUxHjrLr4hOnED6HVfJF5gc10GRl8GONM6lpE/oq/n1RBwVIMlpLYzR9HSVHmoXJc+ImqiOLuxIphKvXH5yB+1B+0l8GQp1Yeers/vo3x6lztp0wWPY+KafH86xNqcShKmxCQy8elb30PcwGA5DUR7HhGw/xE/vmP40fon5P409tG5CV58aNafy7W/c1lbNE51k+Nikz6gd8gNiRRppnXZrcInXDZ5iTSDz0F+412BNp+36Ws/hAaMjIsOzWHmLz2Bv7J5orI0ghvaJlrYZ+y7fJIv5nMaB/TzaUf0+ioXrVKtYSDaSeI1I+vHTHn5abwqL13clveBvDckmP6g6QDkY0ruozAsLEvR7o0QgUxAMx/XQm31pnnNAg65VGtlra/8y36NyES6TIwukh7x0H4Is8eM3u+rzQiZhuY1Vmp7XjOutOfDfDEaddozIiuKkorbd4tNNS5t61Y48Fmg7
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:35:30.8404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119d1521-6fb6-4fc5-b4af-08dc4dbb2254
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 26 Mar 2024 11:31:31 +0100 Petr Machata wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>>
>> > a standard feature of kselftest. If "env" file exists in the test
>> > directory kselftest would load its contents before running every test.
>> >
>> > That's more of a broader question to anyone reading on linux-kselftest@
>> > if there's no interest more than happy to merge as is :)
>> >
>> > On Mon, 25 Mar 2024 18:29:10 +0100 Petr Machata wrote:
>> >
>> >> +The variable NETIFS is special. Since it is an array variable, there is no
>> >> +way to pass it through the environment. Its value can instead be given as
>> >> +consecutive arguments to the selftest:
>> >> +
>> >> +	./some_test.sh swp{1..8}  
>> >
>> > Did you consider allowing them to be defined as NETIF_0, NETIF_1 etc.?
>> > We can have lib.sh convert that into an array with a ugly-but-short
>> > loop, it's a bit tempting to get rid of the exception.  
>> 
>> Maybe we could do this though?
>> 
>> 	NETIFS="swp1 swp2 swp3 swp4 swp5 swp6 swp7 swp8" ./some_test.sh
>> 
>> But NETIFS is going to be a special case one way or another. That you
>> need to specify it through several variables, or a variable with a
>> special value, means you need to explain it as a special case in the
>> documentation. At which point you have two exceptions, and an
>> interaction between them, to describe.
>
> I think there's some value in passing all inputs in the same way (thru
> env rather than argv). I guess it's subjective, you're coding it up, 
> so you can pick.

I kinda like the NETIFS="a b c" approach. If somebody wants to code that
up, I'll be happy to review :) I might get around to it at some point.

