Return-Path: <linux-kselftest+bounces-48920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D34D1E6F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 12:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5254C305F825
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D2E395D83;
	Wed, 14 Jan 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZPFKuueR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D6335567;
	Wed, 14 Jan 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390344; cv=fail; b=tsuEAvcXP5zND2p7J8PgPH2uWNloBAldl08eHLI/mCGGHVhVxThtDOsTal3azxaGllfUDRo+hhU7ep+kjza5wwfYBijOtB0X7WBlEWNYYecIO3kEAaoMW/GLKcC0b4wYPzaAwkWAJo523GwBwnn7oUZsV7lA77TT3HvNH7iCVEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390344; c=relaxed/simple;
	bh=bv9af6XwvTMy3abXW8qnY1geVpWKorae3Esy/TWZuQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uN1F+HCn2TkzkUcsMsNcPRL0PdtZZ34KeRX7cEcwxSneEkbykxdUMC4udTwsv7GUcL6D09BhOsIQ8cY5KQQBtbumuVJaugaPZef6FY/UziEqfV/MT153DJIGWkH1BvrlgkOO5XDQfAIq2i5QcP9bXTwBuARZYLAOFPvE1HdHdac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZPFKuueR; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuKtsA1rZUZbykAJ37Q6Zfz3xdpd40ylFYsrb9OZxM72PUO8IyqclNL3oE/eEuTGYb6r5o9VtfYbri5pwYo9BuQ3wrc8joYL6PlvC1L65Or30imJhcSZkoLsG7Lhdn9H3SJyLhkAfr6BXL/6IsfIwjbJ4+K4NkoYca7yFwcup9hy4K2x8it+bOb3mMGZ0VbIS09wvm1O8uSAgg/sa7ciINrtVk2rySnaKyLS6/uOElzqmwISOAos6nED0Tlz3cgSMzH5ZGaOteF6LQj59l5TSxvQrpI6814Saf5ecvyyrWNw0ny6F3AOdb8u0JcUQhkhy72un0jAOfWIh5wbDciKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewOzv+Oae6KR62QxHgjqMSHMM5BBMSN7meMo6pyvWlw=;
 b=KBmg7NfuA5fIb2haSwIUew+ahi/6pUQ5sYr9+7OmIAxJ4MuzWK+dmV5Em8k1JSlgjjc4NJGEdDgEyIpTQfdXbNTfnvuVge5Y4CsmdVZLfQvBZeYJB9hnlGRyTn4jnWV9qbuqP9RGtLLhvmK94vUoYZGPIt6ezSPWmxYROvaqFAHFe0EvvyMUwqt0MVUZ3FM2AGmSiUZxm0lhM4PNUMeI1HC8sqNpSvsHga/S3UbqwBp/bR86Pdqtmktomwamii+RHwekU30Pu7KxgL30oxmQIKSicmrpefSY8puv7qXs3uPpIYg312hnU88sPbUqHB2kcimC8E+URzywvV8Ggs2aGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewOzv+Oae6KR62QxHgjqMSHMM5BBMSN7meMo6pyvWlw=;
 b=ZPFKuueR2Yz+Da07OBCCyT+AiTZEwZ33GmL+2EUdeunlFLTr7mVBCQFz1lxl6UvYqWbpqBptEATmQgizQ34U4fRNefkC6fn96sjC6+KF+oHRvDLhX9ecSwwsZfsmbt7TKdppYNlFyuY1NjEHkQUHWrna5fmYEo/B9ZBoe0hPDCrbmvrKRqvoAVHi1m4dlCa6zlK4ScpRJdKqoIRXlBzQPcvjtQnztpT/vHgc4S7jiR3VrOrD5lBqnuTcWOta9ytJpz8Zja9V8JFJg58xND+/FARw+BS7lme2BJQ8lKiFUUB/tzku+MIHJ9VTJOemnOLV2k26fBgQkyKfIXHi5utO0A==
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 11:32:12 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::e1) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed,
 14 Jan 2026 11:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 11:32:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 03:31:59 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 03:31:55 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>,
	<mlxsw@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next] selftests: net: Add kernel selftest for RFC 4884
Date: Wed, 14 Jan 2026 13:31:41 +0200
Message-ID: <20260114113141.2522209-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f807144-cfa1-4e8d-36b6-08de53608fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vmZqhSe1FprKmy0lQLCFqEBtFZSMN2zzoRmgikufyOahBsTiqLZDAs2w6Oty?=
 =?us-ascii?Q?vJgcQTbga9P/trNWq2sP/XPggP28plaMTj3J/hpz6Eqz4Dqc1FLbDIlLH0/P?=
 =?us-ascii?Q?uJp2/RNaQfHX7fias4VqxJakSaIwPWT7EeMgdboScUGt59AE9G9urj98P8q+?=
 =?us-ascii?Q?ThH94oEHKu0cBp0YDFlW2QHzVZje274ZB6x3Cfi7yFulc/C84kMmpiLYGzFS?=
 =?us-ascii?Q?EusUKQo4S9a+SQ1GLCnuFD5yH70MDarenmRju83fWXGwLLUEuJkA9w84PSpm?=
 =?us-ascii?Q?6qoLpraJwJas+Emxy+SgwJbkz3hnctKPwDVOwKFV0t81nrmikGV/iKrJBcFd?=
 =?us-ascii?Q?bejoT0eQklQ3ueSYLp8VaicLHQM+L0bPixAMrqUpsrsnAiZRQM1rvjNMpyk0?=
 =?us-ascii?Q?vrVYUaPtsrW+fvaJryEzxHv2IREuTrJONSRFA3+bv1EYQAG4uiT8BBAEiyKT?=
 =?us-ascii?Q?o6JdDJyNEhIF427Qs0xxuerTBQOu4KGpeExZUqSvL/eX8YWkqlH/M2az+fWC?=
 =?us-ascii?Q?sKdGeBVVxX1oYov4Eg5HwGYY5fhw7r7Rg0Y+z8lHIWn7nSQjMQonsbQjwEdl?=
 =?us-ascii?Q?5kQGjB9lOQ6Rebu32su4zrrDktV5+kRxO5PIyGWFgf1hv/d9OKXrPrHBkI0f?=
 =?us-ascii?Q?7oyIjFV5DVWPMJMEfDOzajMju1Y4EyA5kFo09Tpx/KxfZ+yA9PTnAJCikRkb?=
 =?us-ascii?Q?J63wT1bAYeYYJUhLsBICk0GdsndJJvdPW+Pw6Kyyzi7uA869nfYgYpIVcFuB?=
 =?us-ascii?Q?OAoUjCWDlSydBeAl7mIgZntN4Ed3wCgbWDRANBXIRbOiDHf1kldFXPVBqTnp?=
 =?us-ascii?Q?V2orYt74i0fBzjPCQmG/3tXhO3rpk+dzUHfGH8jm3D5K8RhzyTTjGaI/MI9j?=
 =?us-ascii?Q?9hg16jd8KSZ2irKsoTk4InrJhfqRQDmKu9EKHath7Bvo/mSnxYNvKY12qxfd?=
 =?us-ascii?Q?8bvx9ZD+bxN22W9RaGo8Wmfi9Rp78fuNyCbU2A5ZEUQNlIxIjCY+D1E6vUNX?=
 =?us-ascii?Q?+nQldKFDCma1jDJk/byMuYcl3hDBkntvyvmeQzkQlVoAHSGBlKWAi+bfDv0c?=
 =?us-ascii?Q?Ch8wCJlCKZdL7xD1IIAVlsX5KjSSNIuYwmWhEOT1iTxQnsQy7xVcauKKrA13?=
 =?us-ascii?Q?zHUZKc6hffyRFQjxzYwxzz7mA0A+svdiXLffwIVK3d2MLhRIKvmY+nhyWiV5?=
 =?us-ascii?Q?ycgbZiM271EpJoRs9rpBtEj1SbcmNDtm2OdV/xW3pEhVV84oYf5sxXqN3Cf8?=
 =?us-ascii?Q?O2Rjbg3SEmNuIpMRmw8UYzM1OYt0ML5aNAUb2u/tVWXZSpD15IRQe1/QWZ/O?=
 =?us-ascii?Q?7SiirR/PTNAvXvXSI6FchlR/BnBapD6KGt8pnyvE30+oOQjNmX2RQZfUMNYf?=
 =?us-ascii?Q?jcmCcTQREC0/5sAkyzl17XEWIzrrueNgtZXWQUIkWW4nRfck8z/rvBbl2ObE?=
 =?us-ascii?Q?XNL2SmVpFf6XK1hDjC0X8QKBZlHJwOJFY9Ai04MH0+JL2XDdau0tdh3BA1nl?=
 =?us-ascii?Q?GVii7PYVQurdOsMzo1Mw4QA22NASHMyybkc/7Mf2Y4Q69vwI+v0XA489BQRx?=
 =?us-ascii?Q?sxTx6ZkpEvg4WYdR4QJ7Z0U7CN1SMdsSdKZ/8a1VNQxYBPBlv3RbARAslc+a?=
 =?us-ascii?Q?ocBc1tMjsyT53asv49coKL6g5JhJdQz+aOUBUYodV4WUXlnSCQwEhDg90jbx?=
 =?us-ascii?Q?rWFNAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 11:32:12.4935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f807144-cfa1-4e8d-36b6-08de53608fbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264

RFC 4884 extended certain ICMP messages with a length attribute that
encodes the length of the "original datagram" field. This is needed so
that new information could be appended to these messages without
applications thinking that it is part of the "original datagram" field.

In version 5.9, the kernel was extended with two new socket options
(SOL_IP/IP_RECVERR_4884 and SOL_IPV6/IPV6_RECVERR_RFC4884) that allow
user space to retrieve this length which is basically the offset to the
ICMP Extension Structure at the end of the ICMP message. This is
required by user space applications that need to parse the information
contained in the ICMP Extension Structure. For example, the RFC 5837
extension for tracepath.

Add a selftest that verifies correct handling of the RFC 4884 length
field for both IPv4 and IPv6, with and without extension structures,
and validates that malformed extensions are correctly reported as invalid.

For each address family, the test creates:
  - a raw socket used to send locally crafted ICMP error packets to the
    loopback address, and
  - a datagram socket used to receive the encapsulated original datagram
    and associated error metadata from the kernel error queue.

ICMP packets are constructed entirely in user space rather than relying
on kernel-generated errors. This allows the test to exercise invalid
scenarios (such as corrupted checksums and incorrect length fields) and
verify that the SO_EE_RFC4884_FLAG_INVALID flag is set as expected.

Output Example:

$ ./icmp_rfc4884
Starting 18 tests from 18 test cases.
  RUN           rfc4884.ipv4_ext_small_payload.rfc4884 ...
            OK  rfc4884.ipv4_ext_small_payload.rfc4884
ok 1 rfc4884.ipv4_ext_small_payload.rfc4884
  RUN           rfc4884.ipv4_ext.rfc4884 ...
            OK  rfc4884.ipv4_ext.rfc4884
ok 2 rfc4884.ipv4_ext.rfc4884
  RUN           rfc4884.ipv4_ext_large_payload.rfc4884 ...
            OK  rfc4884.ipv4_ext_large_payload.rfc4884
ok 3 rfc4884.ipv4_ext_large_payload.rfc4884
  RUN           rfc4884.ipv4_no_ext_small_payload.rfc4884 ...
            OK  rfc4884.ipv4_no_ext_small_payload.rfc4884
ok 4 rfc4884.ipv4_no_ext_small_payload.rfc4884
  RUN           rfc4884.ipv4_no_ext_min_payload.rfc4884 ...
            OK  rfc4884.ipv4_no_ext_min_payload.rfc4884
ok 5 rfc4884.ipv4_no_ext_min_payload.rfc4884
  RUN           rfc4884.ipv4_no_ext_large_payload.rfc4884 ...
            OK  rfc4884.ipv4_no_ext_large_payload.rfc4884
ok 6 rfc4884.ipv4_no_ext_large_payload.rfc4884
  RUN           rfc4884.ipv4_invalid_ext_checksum.rfc4884 ...
            OK  rfc4884.ipv4_invalid_ext_checksum.rfc4884
ok 7 rfc4884.ipv4_invalid_ext_checksum.rfc4884
  RUN           rfc4884.ipv4_invalid_ext_length_small.rfc4884 ...
            OK  rfc4884.ipv4_invalid_ext_length_small.rfc4884
ok 8 rfc4884.ipv4_invalid_ext_length_small.rfc4884
  RUN           rfc4884.ipv4_invalid_ext_length_large.rfc4884 ...
            OK  rfc4884.ipv4_invalid_ext_length_large.rfc4884
ok 9 rfc4884.ipv4_invalid_ext_length_large.rfc4884
  RUN           rfc4884.ipv6_ext_small_payload.rfc4884 ...
            OK  rfc4884.ipv6_ext_small_payload.rfc4884
ok 10 rfc4884.ipv6_ext_small_payload.rfc4884
  RUN           rfc4884.ipv6_ext.rfc4884 ...
            OK  rfc4884.ipv6_ext.rfc4884
ok 11 rfc4884.ipv6_ext.rfc4884
  RUN           rfc4884.ipv6_ext_large_payload.rfc4884 ...
            OK  rfc4884.ipv6_ext_large_payload.rfc4884
ok 12 rfc4884.ipv6_ext_large_payload.rfc4884
  RUN           rfc4884.ipv6_no_ext_small_payload.rfc4884 ...
            OK  rfc4884.ipv6_no_ext_small_payload.rfc4884
ok 13 rfc4884.ipv6_no_ext_small_payload.rfc4884
  RUN           rfc4884.ipv6_no_ext_min_payload.rfc4884 ...
            OK  rfc4884.ipv6_no_ext_min_payload.rfc4884
ok 14 rfc4884.ipv6_no_ext_min_payload.rfc4884
  RUN           rfc4884.ipv6_no_ext_large_payload.rfc4884 ...
            OK  rfc4884.ipv6_no_ext_large_payload.rfc4884
ok 15 rfc4884.ipv6_no_ext_large_payload.rfc4884
  RUN           rfc4884.ipv6_invalid_ext_checksum.rfc4884 ...
            OK  rfc4884.ipv6_invalid_ext_checksum.rfc4884
ok 16 rfc4884.ipv6_invalid_ext_checksum.rfc4884
  RUN           rfc4884.ipv6_invalid_ext_length_small.rfc4884 ...
            OK  rfc4884.ipv6_invalid_ext_length_small.rfc4884
ok 17 rfc4884.ipv6_invalid_ext_length_small.rfc4884
  RUN           rfc4884.ipv6_invalid_ext_length_large.rfc4884 ...
            OK  rfc4884.ipv6_invalid_ext_length_large.rfc4884
ok 18 rfc4884.ipv6_invalid_ext_length_large.rfc4884
 PASSED: 18 / 18 tests passed.
 Totals: pass:18 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/.gitignore     |   1 +
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/icmp_rfc4884.c | 658 +++++++++++++++++++++
 3 files changed, 660 insertions(+)
 create mode 100644 tools/testing/selftests/net/icmp_rfc4884.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 6930fe926c58..97ad4d551d44 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -7,6 +7,7 @@ cmsg_sender
 epoll_busy_poll
 fin_ack_lat
 hwtstamp_config
+icmp_rfc4884
 io_uring_zerocopy_tx
 ioam6_parser
 ip_defrag
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..fe7937dc5f45 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -166,6 +166,7 @@ TEST_GEN_PROGS := \
 	bind_timewait \
 	bind_wildcard \
 	epoll_busy_poll \
+	icmp_rfc4884 \
 	ipv6_fragmentation \
 	proc_net_pktgen \
 	reuseaddr_conflict \
diff --git a/tools/testing/selftests/net/icmp_rfc4884.c b/tools/testing/selftests/net/icmp_rfc4884.c
new file mode 100644
index 000000000000..043965289116
--- /dev/null
+++ b/tools/testing/selftests/net/icmp_rfc4884.c
@@ -0,0 +1,658 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/errqueue.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netinet/udp.h>
+
+#include "../kselftest_harness.h"
+
+#define SRC_PORT 44444
+#define DST_PORT 55555
+#define MIN_ORIG_DGRAM_LEN 128
+#define MIN_PAYLOAD_LEN_V4	\
+	(MIN_ORIG_DGRAM_LEN - sizeof(struct iphdr) - sizeof(struct udphdr))
+#define MIN_PAYLOAD_LEN_V6	\
+	(MIN_ORIG_DGRAM_LEN - sizeof(struct ipv6hdr) - sizeof(struct udphdr))
+#define ORIG_PAYLOAD_BYTE 0xAA
+
+struct sockaddr_inet {
+	union {
+		struct sockaddr_in6 v6;
+		struct sockaddr_in v4;
+		struct sockaddr sa;
+	};
+	socklen_t len;
+};
+
+struct ip_case_info {
+	int	domain;
+	int	level;
+	int	opt1;
+	int	opt2;
+	int	proto;
+	int	(*build_func)(uint8_t *buf, ssize_t buflen, bool with_ext,
+			      int payload_len, bool bad_csum, bool bad_len,
+			      bool smaller_len);
+	int	min_payload;
+};
+
+static int bringup_loopback(void)
+{
+	struct ifreq ifr = {
+		.ifr_name = "lo"
+	};
+	int fd;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -1;
+
+	if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0)
+		goto err;
+
+	ifr.ifr_flags = ifr.ifr_flags | IFF_UP;
+
+	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0)
+		goto err;
+
+	close(fd);
+	return 0;
+
+err:
+	close(fd);
+	return -1;
+}
+
+static uint16_t csum(const void *buf, size_t len)
+{
+	const uint8_t *data = buf;
+	uint32_t sum = 0;
+
+	while (len > 1) {
+		sum += (data[0] << 8) | data[1];
+		data += 2;
+		len -= 2;
+	}
+
+	if (len == 1)
+		sum += data[0] << 8;
+
+	while (sum >> 16)
+		sum = (sum & 0xFFFF) + (sum >> 16);
+
+	return ~sum & 0xFFFF;
+}
+
+static void set_addr(struct sockaddr_inet *addr, int domain, int port)
+{
+	memset(addr, 0, sizeof(*addr));
+
+	switch (domain) {
+	case AF_INET:
+		addr->v4.sin_family = AF_INET;
+		addr->v4.sin_port = htons(port);
+		addr->v4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+		addr->len = sizeof(addr->v4);
+		break;
+	case AF_INET6:
+		addr->v6.sin6_family = AF_INET6;
+		addr->v6.sin6_port = htons(port);
+		addr->v6.sin6_addr = in6addr_loopback;
+		addr->len = sizeof(addr->v6);
+		break;
+	}
+}
+
+static int bind_to_loopback(int fd, const struct ip_case_info *info)
+{
+	struct sockaddr_inet addr;
+	int opt = 1;
+
+	set_addr(&addr, info->domain, SRC_PORT);
+
+	if (setsockopt(fd, info->level, info->opt1, &opt, sizeof(opt)) < 0)
+		return -1;
+
+	if (setsockopt(fd, info->level, info->opt2, &opt, sizeof(opt)) < 0)
+		return -1;
+
+	return bind(fd, &addr.sa, addr.len);
+}
+
+static int build_rfc4884_ext(uint8_t *buf, size_t buflen, bool bad_csum,
+			     bool bad_len, bool smaller_len)
+{
+	struct icmp_extobj_hdr *objh;
+	struct icmp_ext_hdr *exthdr;
+	size_t obj_len, ext_len;
+	uint16_t sum;
+
+	/* Use an object payload of 4 bytes */
+	obj_len = sizeof(*objh) + sizeof(uint32_t);
+	ext_len = sizeof(*exthdr) + obj_len;
+
+	if (ext_len > buflen)
+		return -EINVAL;
+
+	exthdr = (struct icmp_ext_hdr *)buf;
+	objh = (struct icmp_extobj_hdr *)(buf + sizeof(*exthdr));
+
+	exthdr->version = 2;
+	/* When encoding a bad object length, either encode a length too small
+	 * to fit the object header or too big to fit in the packet.
+	 */
+	if (bad_len)
+		obj_len = smaller_len ? sizeof(*objh) - 1 : obj_len * 2;
+	objh->length = htons(obj_len);
+
+	sum = csum(buf, ext_len);
+	exthdr->checksum = htons(bad_csum ? sum - 1 : sum);
+
+	return ext_len;
+}
+
+static int build_orig_dgram_v4(uint8_t *buf, ssize_t buflen, int payload_len)
+{
+	struct udphdr *udph;
+	struct iphdr *iph;
+	size_t len = 0;
+
+	len = sizeof(*iph) + sizeof(*udph) + payload_len;
+	if (len > buflen)
+		return -EINVAL;
+
+	iph = (struct iphdr *)buf;
+	udph = (struct udphdr *)(buf + sizeof(*iph));
+
+	iph->version = 4;
+	iph->ihl = 5;
+	iph->protocol = IPPROTO_UDP;
+	iph->saddr = htonl(INADDR_LOOPBACK);
+	iph->daddr = htonl(INADDR_LOOPBACK);
+	iph->tot_len = htons(len);
+	iph->check = htons(csum(iph, sizeof(*iph)));
+
+	udph->source = htons(SRC_PORT);
+	udph->dest = htons(DST_PORT);
+	udph->len = htons(sizeof(*udph) + payload_len);
+
+	memset(buf + sizeof(*iph) + sizeof(*udph), ORIG_PAYLOAD_BYTE,
+	       payload_len);
+
+	return len;
+}
+
+static int build_orig_dgram_v6(uint8_t *buf, ssize_t buflen, int payload_len)
+{
+	struct udphdr *udph;
+	struct ipv6hdr *iph;
+	size_t len = 0;
+
+	len = sizeof(*iph) + sizeof(*udph) + payload_len;
+	if (len > buflen)
+		return -EINVAL;
+
+	iph = (struct ipv6hdr *)buf;
+	udph = (struct udphdr *)(buf + sizeof(*iph));
+
+	iph->version = 6;
+	iph->payload_len = htons(sizeof(*udph) + payload_len);
+	iph->nexthdr = IPPROTO_UDP;
+	iph->saddr = in6addr_loopback;
+	iph->daddr = in6addr_loopback;
+
+	udph->source = htons(SRC_PORT);
+	udph->dest = htons(DST_PORT);
+	udph->len = htons(sizeof(*udph) + payload_len);
+
+	memset(buf + sizeof(*iph) + sizeof(*udph), ORIG_PAYLOAD_BYTE,
+	       payload_len);
+
+	return len;
+}
+
+static int build_icmpv4_pkt(uint8_t *buf, ssize_t buflen, bool with_ext,
+			    int payload_len, bool bad_csum, bool bad_len,
+			    bool smaller_len)
+{
+	struct icmphdr *icmph;
+	int len, ret;
+
+	len = sizeof(*icmph);
+	memset(buf, 0, buflen);
+
+	icmph = (struct icmphdr *)buf;
+	icmph->type = ICMP_DEST_UNREACH;
+	icmph->code = ICMP_PORT_UNREACH;
+	icmph->checksum = 0;
+
+	ret = build_orig_dgram_v4(buf + len, buflen - len, payload_len);
+	if (ret < 0)
+		return ret;
+
+	len += ret;
+
+	icmph->un.reserved[1] = (len - sizeof(*icmph)) / sizeof(uint32_t);
+
+	if (with_ext) {
+		ret = build_rfc4884_ext(buf + len, buflen - len,
+					bad_csum, bad_len, smaller_len);
+		if (ret < 0)
+			return ret;
+
+		len += ret;
+	}
+
+	icmph->checksum = htons(csum(icmph, len));
+	return len;
+}
+
+static int build_icmpv6_pkt(uint8_t *buf, ssize_t buflen, bool with_ext,
+			    int payload_len, bool bad_csum, bool bad_len,
+			    bool smaller_len)
+{
+	struct icmp6hdr *icmph;
+	int len, ret;
+
+	len = sizeof(*icmph);
+	memset(buf, 0, buflen);
+
+	icmph = (struct icmp6hdr *)buf;
+	icmph->icmp6_type = ICMPV6_DEST_UNREACH;
+	icmph->icmp6_code = ICMPV6_PORT_UNREACH;
+	icmph->icmp6_cksum = 0;
+
+	ret = build_orig_dgram_v6(buf + len, buflen - len, payload_len);
+	if (ret < 0)
+		return ret;
+
+	len += ret;
+
+	icmph->icmp6_datagram_len = (len - sizeof(*icmph)) / sizeof(uint64_t);
+
+	if (with_ext) {
+		ret = build_rfc4884_ext(buf + len, buflen - len,
+					bad_csum, bad_len, smaller_len);
+		if (ret < 0)
+			return ret;
+
+		len += ret;
+	}
+
+	icmph->icmp6_cksum = htons(csum(icmph, len));
+	return len;
+}
+
+FIXTURE(rfc4884) {};
+
+FIXTURE_SETUP(rfc4884)
+{
+	int ret;
+
+	ret = unshare(CLONE_NEWNET);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("unshare(CLONE_NEWNET) failed: %s", strerror(errno));
+	}
+
+	ret = bringup_loopback();
+	ASSERT_EQ(ret, 0) TH_LOG("Failed to bring up loopback interface");
+}
+
+FIXTURE_TEARDOWN(rfc4884)
+{
+}
+
+const struct ip_case_info ipv4_info = {
+	.domain		= AF_INET,
+	.level		= SOL_IP,
+	.opt1		= IP_RECVERR,
+	.opt2		= IP_RECVERR_RFC4884,
+	.proto		= IPPROTO_ICMP,
+	.build_func	= build_icmpv4_pkt,
+	.min_payload	= MIN_PAYLOAD_LEN_V4,
+};
+
+const struct ip_case_info ipv6_info = {
+	.domain		= AF_INET6,
+	.level		= SOL_IPV6,
+	.opt1		= IPV6_RECVERR,
+	.opt2		= IPV6_RECVERR_RFC4884,
+	.proto		= IPPROTO_ICMPV6,
+	.build_func	= build_icmpv6_pkt,
+	.min_payload	= MIN_PAYLOAD_LEN_V6,
+};
+
+FIXTURE_VARIANT(rfc4884) {
+	/* IPv4/v6 related information */
+	struct ip_case_info	info;
+	/* Whether to append an ICMP extension or not */
+	bool			with_ext;
+	/* UDP payload length */
+	int			payload_len;
+	/* Whether to generate a bad checksum in the ICMP extension structure */
+	bool			bad_csum;
+	/* Whether to generate a bad length in the ICMP object header */
+	bool			bad_len;
+	/* Whether it is too small to fit the object header or too big to fit
+	 * in the packet
+	 */
+	bool			smaller_len;
+};
+
+/* Tests that a valid ICMPv4 error message with extension and the original
+ * datagram is smaller than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_ext_small_payload) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= 64,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message with extension and 128 bytes original
+ * datagram, generates an error with the expected offset, and does not raise the
+ * SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_ext) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= MIN_PAYLOAD_LEN_V4,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message with extension and the original
+ * datagram is larger than 128 bytes, generates an error with the expected
+ * offset, and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_ext_large_payload) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= 256,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message without extension and the original
+ * datagram is smaller than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_no_ext_small_payload) {
+	.info		= ipv4_info,
+	.with_ext	= false,
+	.payload_len	= 64,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message without extension and 128 bytes
+ * original datagram, generates an error with zero offset, and does not raise
+ * the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_no_ext_min_payload) {
+	.info		= ipv4_info,
+	.with_ext	= false,
+	.payload_len	= MIN_PAYLOAD_LEN_V4,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message without extension and the original
+ * datagram is larger than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_no_ext_large_payload) {
+	.info		= ipv4_info,
+	.with_ext	= false,
+	.payload_len	= 256,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that an ICMPv4 error message with extension and an invalid checksum,
+ * generates an error with the expected offset, and raises the
+ * SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_invalid_ext_checksum) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= MIN_PAYLOAD_LEN_V4,
+	.bad_csum	= true,
+	.bad_len	= false,
+};
+
+/* Tests that an ICMPv4 error message with extension and an object length
+ * smaller than the object header, generates an error with the expected offset,
+ * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_invalid_ext_length_small) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= MIN_PAYLOAD_LEN_V4,
+	.bad_csum	= false,
+	.bad_len	= true,
+	.smaller_len	= true,
+};
+
+/* Tests that an ICMPv4 error message with extension and an object length that
+ * is too big to fit in the packet, generates an error with the expected offset,
+ * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_invalid_ext_length_large) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= MIN_PAYLOAD_LEN_V4,
+	.bad_csum	= false,
+	.bad_len	= true,
+	.smaller_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message with extension and the original
+ * datagram is smaller than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_ext_small_payload) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= 64,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message with extension and 128 bytes original
+ * datagram, generates an error with the expected offset, and does not raise the
+ * SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_ext) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= MIN_PAYLOAD_LEN_V6,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message with extension and the original
+ * datagram is larger than 128 bytes, generates an error with the expected
+ * offset, and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_ext_large_payload) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= 256,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+/* Tests that a valid ICMPv6 error message without extension and the original
+ * datagram is smaller than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_no_ext_small_payload) {
+	.info		= ipv6_info,
+	.with_ext	= false,
+	.payload_len	= 64,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message without extension and 128 bytes
+ * original datagram, generates an error with zero offset, and does not
+ * raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_no_ext_min_payload) {
+	.info		= ipv6_info,
+	.with_ext	= false,
+	.payload_len	= MIN_PAYLOAD_LEN_V6,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message without extension and the original
+ * datagram is larger than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_no_ext_large_payload) {
+	.info		= ipv6_info,
+	.with_ext	= false,
+	.payload_len	= 256,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that an ICMPv6 error message with extension and an invalid checksum,
+ * generates an error with the expected offset, and raises the
+ * SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_invalid_ext_checksum) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= MIN_PAYLOAD_LEN_V6,
+	.bad_csum	= true,
+	.bad_len	= false,
+};
+
+/* Tests that an ICMPv6 error message with extension and an object length
+ * smaller than the object header, generates an error with the expected offset,
+ * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_invalid_ext_length_small) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= MIN_PAYLOAD_LEN_V6,
+	.bad_csum	= false,
+	.bad_len	= true,
+	.smaller_len	= true,
+};
+
+/* Tests that an ICMPv6 error message with extension and an object length that
+ * is too big to fit in the packet, generates an error with the expected offset,
+ * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_invalid_ext_length_large) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= MIN_PAYLOAD_LEN_V6,
+	.bad_csum	= false,
+	.bad_len	= true,
+	.smaller_len	= false,
+};
+
+static void
+check_rfc4884_offset(struct __test_metadata *_metadata, int sock,
+		     const FIXTURE_VARIANT(rfc4884) *v)
+{
+	char rxbuf[1024];
+	char ctrl[1024];
+	struct iovec iov = {
+		.iov_base = rxbuf,
+		.iov_len = sizeof(rxbuf)
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = ctrl,
+		.msg_controllen = sizeof(ctrl),
+	};
+	struct cmsghdr *cmsg;
+	int recv;
+
+	recv = recvmsg(sock, &msg, MSG_ERRQUEUE);
+	ASSERT_GE(recv, 0) TH_LOG("recvmsg(MSG_ERRQUEUE) failed");
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		bool is_invalid, expected_invalid;
+		struct sock_extended_err *ee;
+		int expected_off;
+		uint16_t off;
+
+		if (cmsg->cmsg_level != v->info.level &&
+		    cmsg->cmsg_type != v->info.opt1)
+			continue;
+
+		ee = (struct sock_extended_err *)CMSG_DATA(cmsg);
+		off = ee->ee_rfc4884.len;
+		is_invalid = ee->ee_rfc4884.flags & SO_EE_RFC4884_FLAG_INVALID;
+
+		expected_invalid = v->bad_csum || v->bad_len;
+		ASSERT_EQ(is_invalid, expected_invalid) {
+			TH_LOG("Expected invalidity flag to be %d, but got %d",
+			       expected_invalid, is_invalid);
+		}
+
+		expected_off =
+			(v->with_ext && v->payload_len >= v->info.min_payload) ?
+			v->payload_len : 0;
+		ASSERT_EQ(off, expected_off) {
+			TH_LOG("Expected RFC4884 offset %u, got %u",
+			       expected_off, off);
+		}
+		break;
+	}
+}
+
+TEST_F(rfc4884, rfc4884)
+{
+	const typeof(variant) v = variant;
+	struct sockaddr_inet addr;
+	uint8_t pkt[1024];
+	int dgram, raw;
+	int len, sent;
+	int err;
+
+	dgram = socket(v->info.domain, SOCK_DGRAM, 0);
+	ASSERT_GE(dgram, 0) TH_LOG("Opening datagram socket failed");
+
+	err = bind_to_loopback(dgram, &v->info);
+	ASSERT_EQ(err, 0) TH_LOG("Bind failed");
+
+	raw = socket(v->info.domain, SOCK_RAW, v->info.proto);
+	ASSERT_GE(raw, 0) TH_LOG("Opening raw socket failed");
+
+	len = v->info.build_func(pkt, sizeof(pkt), v->with_ext, v->payload_len,
+				 v->bad_csum, v->bad_len, v->smaller_len);
+	ASSERT_GT(len, 0) TH_LOG("Building packet failed");
+
+	set_addr(&addr, v->info.domain, 0);
+	sent = sendto(raw, pkt, len, 0, &addr.sa, addr.len);
+	ASSERT_EQ(len, sent) TH_LOG("Sending packet failed");
+
+	check_rfc4884_offset(_metadata, dgram, v);
+
+	close(dgram);
+	close(raw);
+}
+
+TEST_HARNESS_MAIN
-- 
2.51.0


