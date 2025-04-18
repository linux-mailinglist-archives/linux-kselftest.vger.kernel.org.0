Return-Path: <linux-kselftest+bounces-31141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF11BA93A5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7564C8E26BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E70215F4A;
	Fri, 18 Apr 2025 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YGm7bcIN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50021577E;
	Fri, 18 Apr 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992632; cv=fail; b=dn0b8xAbxIShKxl8DkWhEhTyLgTEk9iLiuIS28uz4Pjmk+PaRd9RF6mHzb3JOl8svuCJnKMQUkDJmko0oony/1IdqM41XCVJKg4iCh51Ao1wRLRbZRYFP/hj73z9WfHVzolVFvrrNH7pmY3VwQ0/tVfe7LefkjjXad3Ga733zFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992632; c=relaxed/simple;
	bh=YP0aKrK7t4dZMo3zpbXvouphDo9hJrnLNLvXuKHYXnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csOnEXPAJJulIgCnNwBhGaAUY9x8tW2RddofJ0UH1MMuC0jzznGIUby3OY+cd59biFIn73nXHfdSDV5F7p5ckFe02AuKDB+RuVeXYmCOoky+ygNFcWVNJoT+97bx1f5PkDzTuNKrs7IJLbibtWIN1KIuKQBsDnqvtg+7dLZBiLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YGm7bcIN; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Npm1a90/VGq6OXuTsw30oVB/Phk0qjAZB0I4vyG1opVe4JMw0drfMZXRJy0wN2HjmcwyehoiHyJNvLfE6Cgy6qd/O2poq/ytvcKhZSHKwhVjOZ0XlIsd9J5IILe1h3+DVEhsQqxTsTcoeZR3uSWlMXPIvcaoXisWclfAMb42MLxHJ7RXh3C5eC2a4WKXjE9oshyfU26DOMeWsb/h/FTpuMYGYmmcyGWIlx4K1nl0yqa3iB1ZJNbXTeg1rMaLpTX4ehEv3frLvsTgbCPrGGhgysUS7mmK3ZqVTuBRqs/E3N0D0Ze1Pzq8i+l0LAnnOhwERcNpOzrkwLoVWJQ3Bgl6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCZQvz2PSjgu7Ewi3GlXCSujigWKeqPHTWNMbcbPoJg=;
 b=swGJxALkuK0yCp5Z+qtDhGYaCnFc+h077tSpvMa8KkVYh56juXW9hvhfHz1M2bS0yf4k5zVUOuMu1NRWR/SlKvSF8CgWJhpZomcbVwnZfJGzXYtPW8IpYWUNytd1S7X6jwRbKLpoTmW0Q5iBK8dlp43OYNbqgPQQyfPK7zmqxV5E4ShJEBJTyHsWYjGUvxFNETSG0InXQil08UnYaZZnWMlSL/MoP0fp4+/AVEOzSzeVa2yM5JIhq56AJ4+oMTceiEN29kHMX6Rx3ZH5uOsRr6h4ThEn9NOhfHKRg7ImXInVylRbfhO6kWbjSdyblYoyiInSYxxZ2165FVX6Fi9/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCZQvz2PSjgu7Ewi3GlXCSujigWKeqPHTWNMbcbPoJg=;
 b=YGm7bcINNqBpU7aCUuk486nL8C//voEV64t+khRekXagz1ta7mahTwWqvsNpcANXRq2sAzjxpW7jVnKsJUPQ7GvsrEfMlVF53xCumCTozgkpoHl5WQIrYUgoju2D4IIhA2ZRh0IupC6WNGs9sbmDVT0kJ8sbKHYzno6sUMd6RsZ+iHj+F6gITjPVHQQh2XmyGctyzMDAUzjsT4czg2RU8WKO0unU+J2Q9UzmdgvQGxXm1PDNgDrbL36W5UCAPNsrEOCr+2zUXAA3NrIGA39/Bor6ZP3JBfLPPVJVRCLfy9T5mQpI7PpBBgGemu0KE2w+NDKUQJc0i0I3rpKSci4MIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 18 Apr
 2025 16:10:28 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:27 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH 04/14] rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
Date: Fri, 18 Apr 2025 12:09:36 -0400
Message-ID: <20250418161005.2425391-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:408:fe::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbc3fd4-e5e3-45de-c7ac-08dd7e93888d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?krdLJZGUu/4vL3Re3/LHl3CK8iLUPVOTRUmF+zNfLEvWS1gE/b83PhHSzvI9?=
 =?us-ascii?Q?5bT0SnauJGzL1Q0Wtnk2xZUo2O00mrr/Op0PZA98ruF54z1k2B1CvtJFtGja?=
 =?us-ascii?Q?yOnJOdxaXy2IYYlRN8CEmT7Za153/njD77Sw7l/8/Ly16oZmPG2F1bA32Aol?=
 =?us-ascii?Q?5Q0HTJ8joJ5xtsWSo2gp1kP1UCm0/1bSujNQh7ORux4MfQk66FLxUDv44Sas?=
 =?us-ascii?Q?j2iuBziQHrfN1hKk+xZ6nt3vRChQR+7XdOMAd/ZCLWreQ5njC7dykUrSve1e?=
 =?us-ascii?Q?tpvTLtwqAnXguNxE9OTXkeuwbSrV0KzGXK/z3y/B5fwPJ31HLNtpzzskFXRK?=
 =?us-ascii?Q?ccwROqCLMwDtl2cGlFgX7xV9KKYD+fU1CtTDggdgj65YdPGoDxH+cit+rFy5?=
 =?us-ascii?Q?A3ZERc7o2RUsk4X6uk1R1P1iqlpzaGYei/R7i0bvriGZr+eKSRIq2OxVZcKi?=
 =?us-ascii?Q?XadZBXt0ro401cAVDQzQvhVusBj2yjM4cOOFeTD49XbXQyJpEl0Z2EG4q6LJ?=
 =?us-ascii?Q?LuQkszKJZSjrgUfV49E+tFkcM99wM9udym3Y1RhdyMK4tjwWGK1LbumakVlB?=
 =?us-ascii?Q?AlQOW+96WgsQn8CY0Lcrr1rKLwMtEQXaezsO+jDaW+Rsavw5OZcwzZLneaUM?=
 =?us-ascii?Q?pROJtDSrma7xN1Xp1zObQhoH9cKHIIMVhHkqzti30pRH4ktIjeTdd3FxCm5X?=
 =?us-ascii?Q?7067IM1ZsB/yjPxqIwo7eFncedRmj3L4JqPISh9Fw/xD8rjn0ptHGX9wkNVz?=
 =?us-ascii?Q?49Bb/pEuFRm7aovhQAdLchf2Y7gsxPCZr/V6osFYvAYdMOCoXMywwTntHOm6?=
 =?us-ascii?Q?Num4dSWfuP7osjTGkJL8DTCX8/cbPuuhw5QVuG9NLHycSDZi3mbMFUEbuGqJ?=
 =?us-ascii?Q?YhtlWlk+nJ9tECcvfErz6JYBT0s2DwpGSkyEBwgXK0Zu0NOoTjY33W1IzR64?=
 =?us-ascii?Q?Ore1flh4RvlYvPXVD3v2LTNa0Uqru8m+zU9y9TjjjZeN4RCPmNzzQduPg1s0?=
 =?us-ascii?Q?Dh7mzrcLgWsGDaDwdilF0xj+10+u/ANgK81cZBvOAkXAXTbSvh9oihAAJNoT?=
 =?us-ascii?Q?fQM1DiN4YUWFascTyyWvgCtrOOO+pQmq0rLJn+gXCVZXEGNA3uv4Cx5xU+AF?=
 =?us-ascii?Q?tdWHmwjUuEQxShx4q4gFc9sYnDrJR0iYMq3tuQJ8y7JNmmqch2QntBDuYQWk?=
 =?us-ascii?Q?4Qs1tEKCVLDTa9tPJlXPgteF5hQxWyDw8cJjVorns2HN2+HZkdi74xbJtfEn?=
 =?us-ascii?Q?2xOslawrRMFY9Cp7WdNWhjoc2Vh8g6Tz7Mo73tb3AI5W3vU/DTXlg5XHgflt?=
 =?us-ascii?Q?vyRd9GQ8VzqVAOkGS6IzT6dadO/bmtC/VspPHwxjraShkZYB1iUUKCmW5q5t?=
 =?us-ascii?Q?CLisiGHpp0w8H6brvAdBFKEhZCrY6tj0+ZZDvqE0Bxs+H1FbrdzqJHlmqWfK?=
 =?us-ascii?Q?6YsmBkRpQHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSVWDZz/ft7YWtifiLBqv3pDLIMDwgPcgAARRmExBXTDk55b0phGlnAOOfl1?=
 =?us-ascii?Q?82FhnErKdAfnX+EoV+M0qb+In8AvKlV8qwbgxtqof+n8LNDi7rhvMT4toJ7e?=
 =?us-ascii?Q?L55SlTwJSk5kZnVY/IxuRFyIdvNfyNdcHJ0z1BCqtd6d/TA5BbTM0CM96MAx?=
 =?us-ascii?Q?I69x4cluw8xhfs4emt3HY/52MwGP7KEgqxg55K4D/eFFfffjyY3thxhI0LFV?=
 =?us-ascii?Q?qtVGWXS4bs8SVHCKjSSZ+PvX907pHRINua1aTL1pnRmW7PoByYE21KdqLF59?=
 =?us-ascii?Q?gH/N6rayHp0U8FAOeUDzluPUw7NFonLquZ5XlnegC2c7zAK0QxYGhP1IIVz1?=
 =?us-ascii?Q?x8vfrIucLo6aQUuH9AtvpOIXg7/fSpLQyeZqZnVG2NcZFJcJ8Hrt2A/77nMF?=
 =?us-ascii?Q?Cpv5SLrTNBsr0cp148eIu0L4O0h5RjAo8o0i85ZQ4cz7HjlgAh5hFwkN4Bza?=
 =?us-ascii?Q?AM2XWsYlXZzrrGuppRKjRaBLkU2JXG7zxb/q7Pp9bK7eCdExvDU0zEaRvDPN?=
 =?us-ascii?Q?57G7C5DMrfJdRoBdSTRACZP/HlRu0+2j4H7CvTFbgXwkvAQULWKvkPFwfvvP?=
 =?us-ascii?Q?yB5k0Vb1PoUK1vgOiMEqRMfzEQt761Y+4Mr4NkevfbVyqoIIyfrWT15inwKW?=
 =?us-ascii?Q?omYEtFq5+ZbcQZi7vzY0YwCR4yDD3+i96/ZLZNGJ/GWOQDeDvrIjl+4a0LOO?=
 =?us-ascii?Q?uwuqcYqpnEOOi8s9tkaHCo3jpgItzw9EdiFIiRLC4W6ZqkDRSRprsaXjuqQV?=
 =?us-ascii?Q?BlxVwwdpQGewvzRQczMKf1Bz3TjVv3EdVQkdN3+i6bt/dVZqKkSVtU1zsBp6?=
 =?us-ascii?Q?lyydShd5bEuD289T2kyUOIr81JU9BU0NGbzqrNZLK9426yc0C2DcwhSzdnMp?=
 =?us-ascii?Q?LlUjpQ6czom0yKmQAZc9ia3xdytMrldNWXvnzUEqT/kgVC1g/2awc/oRn2gv?=
 =?us-ascii?Q?ZCNgnbEGJqGfCFPeOXNO3nzRcQA7+IG87iF+eE+lfbbcA8uf0FxdgAlUQ6wy?=
 =?us-ascii?Q?1b7N5o6puCKaYMsHakzhABlxhj8cH5cd8t2OJ6qkJtvNpKUCIqr6dHUOjiGu?=
 =?us-ascii?Q?rzWVKB8GzWsU0ujWECzpnLlPTbN0JMlWB1v8X9xUcKwy50SBidkASI7M8PBm?=
 =?us-ascii?Q?7NJNppmWVg2bqPmjXrGbSWQvv/Vd/jxEq1pVpZXv8eeFdy3ZjNZjd3E65SHd?=
 =?us-ascii?Q?OG5WVxf0qxTni8Z5TA/w9s7428UYQvYmTz0WBSbZtybj5GsWGso7Z/DsGtMN?=
 =?us-ascii?Q?ZDALGGSvLAPcqatzETlyI9HrRPzxWHJ+dOVF0+P89e55Fn1QaI5/qld2u6mQ?=
 =?us-ascii?Q?WUgWyHX/Cw6cCoLjvID2xMTRPrs+jx2/mjxiJ3AohVqt1GmwaU9fQniHz2I8?=
 =?us-ascii?Q?iYoKAjk3QMf3DNmyykFoR3uJiT0wrK4XD0Ma8UYpPExfGGIYtnNEdC0g2T7e?=
 =?us-ascii?Q?bEGLKORqFLBvAs92e14RZrYihHWUs4LtmslMcDTWFS7QbVfse0Af+iVdcX6f?=
 =?us-ascii?Q?cp38do/qs7UXGz+6E7cHHMxtaYQqXFkUcSLpfi2qW/UG5ezYH2v/xIH/1yDD?=
 =?us-ascii?Q?fxW9d+FP3lKDHYSbKck/gbpm7ViHDqnGMM7MNiAy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbc3fd4-e5e3-45de-c7ac-08dd7e93888d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:27.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xkEj/wqDTPEaIXE19HuY5XU6ORSKqKKXOD6ZAFVuxf2GN/1IPwyy07IIurLHZnCkc2gVAcsTXmvRCkrTOEa7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

From: "Paul E. McKenney" <paulmck@kernel.org>

The torture.sh --do-rt command-line parameter is intended to mimic -rt
kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
mimicking more precise.

Note that testing of RCU priority boosting is disabled in favor
of forward-progress testing of RCU callbacks.  If it turns out to be
possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
testing of both, both will be enabled.

[ paulmck: Apply Sebastian Siewior feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0447c4a00cc4..b64b356f55ff 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -448,13 +448,17 @@ fi
 
 if test "$do_rt" = "yes"
 then
-	# With all post-boot grace periods forced to normal.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_normal=1"
-	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	# In both runs, disable testing of RCU priority boosting because
+	# -rt doesn't like its interaction with testing of callback
+	# flooding.
+
+	# With all post-boot grace periods forced to normal (default for PREEMPT_RT).
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcutorture.preempt_duration=0"
+	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_IDLE=y CONFIG_RCU_NOCB_CPU=y" --trust-make
 
 	# With all post-boot grace periods forced to expedited.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_expedited=1"
-	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_normal_after_boot=0 rcupdate.rcu_expedited=1 rcutorture.preempt_duration=0"
+	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_FULL=y CONFIG_RCU_NOCB_CPU=y" --trust-make
 fi
 
 if test "$do_srcu_lockdep" = "yes"
-- 
2.43.0


