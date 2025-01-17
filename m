Return-Path: <linux-kselftest+bounces-24739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95554A153F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36C53A2321
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC16B15747D;
	Fri, 17 Jan 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECN7C5iL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71425A62E;
	Fri, 17 Jan 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130545; cv=fail; b=Rl7aFpgoj04sRQ/DaI4rWxj7NN6rV6MXl+4aDAXdc2hODaNBZA3GUEJ9OVxzCvL6ZAhnILaq2pfDEDtmzyczF+++fgE27UyDuAWyjcV62NuecUyeVGEuOZfCZHnnMyvHjWINDtEQiPVgdNrr72Of8oov1lxC+AgTXC+x4jsMMGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130545; c=relaxed/simple;
	bh=/yn5Uv3P5ScatWI5eA0za8JftNk1OND7CFdUf4wMjsQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AwH3C3zX6eFQPSzYpGbhzVL+81LctgScziWZpWl6OBkPX/nebJD2ShtHfQYzVlTYPDaGk3g7+6MfDjSb/23RiEehsZGjj6OG2fte81zSZT2gIyk7FVeYub+7rE3yUwBdNSVi2FEVh3qB89TqNAzZQ3kfxp/Atuj7ArY7CxM0GzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECN7C5iL; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coqziAlNsTJVL5RDDTpJXnCiUlOPw8ZBl9a2jNp9+aQ9yG16izowpbPH7ONRuXeeOUL32Yv97R0Tz5bibTHHprOu+YI5oHsu8DZt82WNp/rHVKlp1EvAd36Hlk85bciSunaSuCGLkGmS6CkRoZXONz57MqbXXKlhyAlBipV7IOT/odmvkC4UArpy0/mR3rVYfLmSZmraRtmWRiuKJVCLDTWUz2COupk/VaYwKpKJViTlTgHEAiqBxEuW9sfLF2c3U3ZjRZ3CuGvUmBSApPsY5/qhkkyCe2WqLLGjshQ0XT1nI8dRGB2dokCwrhUwj7W4tTqM07xvjH3KEuw/J40Uxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yn5Uv3P5ScatWI5eA0za8JftNk1OND7CFdUf4wMjsQ=;
 b=FzeWGU6wupf9QyU22B1inmbKXgHkTZ+1220qfpuveuHmIRIjo0yG5AHVSBwVZewVYYc+eLRDlkasoJfWzKdqP6SSJxiSrVWJry+oBHgdnmUQbe9QZmc6OcohMY58kkAyetu45ha8q9VIjRFD0l4VmrHKozERoS3UlpWA/Vw+JxddrS4/BFXdsv96Ew5jHHKTuVO3/nKC7Rk0EfRdNDVyADJbS55TKTcW8VhBDo6x+IZ2myVBY0i5Ex9B3xW4wxGDSHkvj1Vlg6790srSLekKx1AX9ihKuJEuA7gOM2vfx3IFW9rxGup713KRe7gvXhsNefKATZfiY5Sf/dS0uOBqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yn5Uv3P5ScatWI5eA0za8JftNk1OND7CFdUf4wMjsQ=;
 b=ECN7C5iLsjEX/9GAF7oYEMIhWTnhvyDQbekdH/S77ZKVyr5qxUVoB+TAGdtpAAGMqssB/pLJlWwiko7Dfa/JasHef6ntWD3M0buty01CeFu7GJi3pRisz7bVqL43ZB6AnaZDVG6UUAIazrhNu+zD1JvuAi7J1UAQ90QGTUtucj35FPXBv0XIuCbCEN9XyGh+NYQAw5SQZFkP7aySLREKJ1T7FLvsTJX+rs9MNbtqSGRmRTXiB3yI79B8ymbmKA7+ZtB9rBoUCXuwR5YFhYsClSVToK6l2BMdp6x+yWnGz0TteyXjhYCmF8UFHwWNGSZodvSmCnRi7T0gWU7kZ5Mxxw==
Received: from MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::24)
 by BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 16:15:38 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::7a) by MW4P223CA0019.outlook.office365.com
 (2603:10b6:303:80::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 16:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 16:15:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 08:15:25 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 08:15:20 -0800
References: <20250116020105.931338-1-kuba@kernel.org>
 <87ed114mbw.fsf@nvidia.com> <20250117065323.42daa2f9@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] selftests: net: give up on the cmsg_time
 accuracy on slow machines
Date: Fri, 17 Jan 2025 16:16:22 +0100
In-Reply-To: <20250117065323.42daa2f9@kernel.org>
Message-ID: <87y0z92z8q.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|BL4PR12MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: 5727be44-7627-4a82-854d-08dd37122e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PbA7JFHLM41eNaPDgWQE2jT37EjdycxUfhwKZ/aVo/CW+iijKGDfMSGSYcxc?=
 =?us-ascii?Q?kz+dhomqKOKcK1jGdKnO08heHsFRuhAJ4Ym1XS5nK2U9+xoT6vs91ra/is4s?=
 =?us-ascii?Q?OzQFhAnF/DVaDAPchLV6fP92nd9yFR4hgAQssq0QJFJVCOFeYfSrX0nCt9lm?=
 =?us-ascii?Q?EU3HD33ebVCOV2MVsjpGF0FPqhO3vc5Fm9vpiPmCaphq7lCIRsd1Y6YBgXm8?=
 =?us-ascii?Q?gmaXI5Z4HbmbHhYY8BM9+3poFl54Pcue0+3tmh2sM9H81AEWMjl03+hONq9X?=
 =?us-ascii?Q?nEtNCSMPumfuWln3z3o5xmfye+uNPJOWl5ZU/IyFnwJNSGpTUL6pa6dHQ09N?=
 =?us-ascii?Q?+JxH5h26T4F8MJ02Y+I0Y5uZm27iIS2uIPQFdkMpbvSpObNtOo5q5jpaEZ1g?=
 =?us-ascii?Q?7LLlvxxdv6rju6JaRhYTA408Lx/hUlKGsx/IFD1AMuOu+uyxDWntRxapNsZl?=
 =?us-ascii?Q?JfZGd0g6UjFlN3CfrPnWo67bph7raRPV4jBIX8f/sk7f5fOr34/DAxv4uVKR?=
 =?us-ascii?Q?g4DFnF1NhqdQ6RiFpMehCdIibB1qVzOR4Qngctfuqui4cVen1RDoTbQb5xjj?=
 =?us-ascii?Q?MGigLdcyHq1qbSMeojFeqJQA5xCuovWdKARcgtvFuwlaQ3erxn0dCR/mi4vH?=
 =?us-ascii?Q?KgO8POUZGZ6csWOd+sn0lQ7gyp1UfR0SbOdmCgc5Pcw9m0y9S6xnIFLwjaFb?=
 =?us-ascii?Q?U6w5v7+/6Woz2dWN3zhq9giXkBMoBUVlbPlkmLs2aZS7AqvOz6C+Oxf6ukKd?=
 =?us-ascii?Q?cFuH4ShGWk2ZsWsPNXxH6/ioGIH6u8k9V+KQnzwz72+Hn9uASWmDVsaX4EWO?=
 =?us-ascii?Q?hwepHaTA1NyBrMQADk9JmK74RTC+6qUQArfsbzNMNBryYGuf/C23R6M8mdP6?=
 =?us-ascii?Q?zZP7jqa/6l+2xbVWI/SUvAVW5VLCtt3Qd2biS0nBF2L6IqL5pU1EpFb2Fb6b?=
 =?us-ascii?Q?uiC6FJcFQjW1FNAA6hx9lA7MrVV5xfZJm4Lg/+KOwVdSe+SInhUVCrw97GXZ?=
 =?us-ascii?Q?04KS27ItpyLxZydM0GiuWUxnO4J8GHHj7mABCse1FLpg+SE+3x38gNwFR6ij?=
 =?us-ascii?Q?lbnaZUubVzaIKnXhMZGgeUX/TsEBvucjCnJaUHNOOpLuwL2AesYw9OShrS+l?=
 =?us-ascii?Q?clNWUSYfKwuYsuj63O6L1PQAhvbKuoG8bLKeZzWj8OVF8CfW514EQZrwvHTR?=
 =?us-ascii?Q?quBt4UeJ6HuEf3oNd05m/1PI6dlZ18/D81613joQPQc5YbKz9nZvREercJlf?=
 =?us-ascii?Q?FWkPrkiEha0wA1eTzZYbbqm/Q41/Pweurul+mzeBQfK6hPsEbkvD/V2gtATO?=
 =?us-ascii?Q?aO5eut5P7YeNk3TcAFRnvKGUlGSE8VkRG+7P049GzMNyBpLI8hWkuYP/IwQW?=
 =?us-ascii?Q?SSOTQxvAmfSKCmbGGzxF/twVqXaNXcUDGzcs53Z89TLxkIE/wGol2NBEwiad?=
 =?us-ascii?Q?KdHTdchNjGMaeQR5A+fKrwNbFi0rwq1ZJtlze+MidnWBH267CVAYh99EE6gK?=
 =?us-ascii?Q?ZDgk/yzmz3GsxoE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 16:15:37.8574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5727be44-7627-4a82-854d-08dd37122e28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9482


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 17 Jan 2025 13:49:23 +0100 Petr Machata wrote:
>> This logging and xfail handling duplicates lib.sh. Would a patch like
>> below be OK with you? The gist of it is to just use check_err, log_test
>> and xfail_on_slow from lib.sh to achieve what the test open-codes.
>
> Hm, maybe? I'm not going to say no if you send a patch, but IMHO
> if we were to change the output I think we should make it ktap.

Hmm, at some point, we'll want to convert lib.sh to ktap as well.
Hopefully transparently so that all the existing selftests out there
just magically become ktap-compatible.

If you want to preserve the output 1:1 then I feel like that's bending
over backwards too much. We could still maybe reuse xfail_on_slow and
ask for FAIL_TO_XFAIL, but that's marked internal in lib.sh. So I
retract my proposal. Too faffy at that point.

