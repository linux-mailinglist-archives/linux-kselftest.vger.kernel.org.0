Return-Path: <linux-kselftest+bounces-31143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFABA93A65
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EB146070F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173D21D59F;
	Fri, 18 Apr 2025 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k+oRolIY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2B21CC64;
	Fri, 18 Apr 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992650; cv=fail; b=mypHfzIl8rzMIdsjq7iaHAVqF/Gs5dNO0Ds/gOzL/4pTcsspsXxRVxgPgkP8eBeQvdpxsBUysCjvlSeNM0e2BLM5l4ZWCnWKJWFTcWldkikElihVFn7LtCJhJkIe68UNmj6e6jf54KgtU9WLa8WaJNa04XT27/oHENxOXXArYU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992650; c=relaxed/simple;
	bh=B2IfNVHDv5xZoK7Kxgf2ac11w+Xt/RMn0+cXJnYbk5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTXXcrqg7w7Poc56+AZ023Choh6h/8KudfjKqM0ufdqaQ3hU6xRfxToUj3iXJVLv/UTttQiU3GisVxrjH9Xg0CIraZHgU4JyAY5YHCGkuuuUpw8fkWS/AQJKvsXCfSZuN6ywjSMDEskvgCU8hLFHGnieeqq61XhFKRnU/ABXGzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k+oRolIY; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdwtqAe8Sp7Nu6IEVVDCDGpA1u68iManQ6pvU9dd9+rke+NBkD+AZpLKkuq7g/04ZC6nKGhk2mpmryfj77Msf5e0Ru4EZrRx7iPs23F+IAgfj5w/hVI3b9ZC/VILJdHZLVgXIchAFXbaSbBJkQaSx0wa5L/uzvatcTDZHbcB7Lg1kI0fNxFENtqENh/EI+ODT16ecWMky/knAqfFvcpRIIo94Ij52lBd4DllU9+w77GsmWMFdYZtdgN4fNnc0OJ7kFgy+vdbOpvwlhdTjIyvhtzFzeVDiXdysEmpFKZ1rWUZmz8l3wsur78WlnsxtkQFBVlEhOmCwIY16c+CPAk5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQWODUaNmaa6BcJPz1bVkgvzg1YNsZunAFGHltw3IlU=;
 b=cKYoZvHtvLi8jsSkztNn2XEi2g3TI1wvHYiQQpI0VWT3AOszQe12KovK63gElcAUFrwpwcYiq2P1c87YWxgoD3GZJ2JSunlo4+DNmZ6o1picEOQOfTL1gGyWykDmeC3RPSlVk/Iv0UjTVeMWJjJ7MwsUAvnacOaNqidUjiBIL3k0gkUXXfGjTuk6FeLIGFJqRkMcITsmmlPE002Oq6BJ6KuHDf6wpOTq0kRuWEm1aW8GMOah2W/rhjbHiLgdPlJjIG3D90LyTV7qE+Qv4tikPWsaVnr7gJ3U6jDm8LoHa7x0ao8yG+OzCcrKZg/b3zHf2rBv5onkUyGBE5KphghaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQWODUaNmaa6BcJPz1bVkgvzg1YNsZunAFGHltw3IlU=;
 b=k+oRolIYcZPBN5DY/AiIFE/durbnR8usLU2Xi7N812s5OOEBwCtMu9AFmxlt+aZPp3aNt0niF5/CrgF47eMNLkuFSOR+RG3H6hxylLF9S2gITjrWTtcEw1ZBg3CYpyTwwgraaSGn3r62rzz+3Nc3xqIAq2eH9DYIndmxEX+/I35XOaLh6lL2ss9JRoyDPMYOt3d+Se+ot5+RL/nxt8SaYt+HpBpUp4CEOCHT8WMS2Swd+TPvUtBfBIyemJDSmNPRl2UH46gDujTT+2k91wz4XNO+7cH7JjGZ9tgId6G9vmhkC5sxTHJXEW1T0pPvvMOuKl4llC5S12bErkGjBf1nzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:10:46 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:46 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 12/14] torture: Add testing of RCU's Rust bindings to torture.sh
Date: Fri, 18 Apr 2025 12:09:44 -0400
Message-ID: <20250418161005.2425391-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:408:fc::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: f3563a52-9a78-4b04-8595-08dd7e9393e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9NQFMHq8lcHbbIYzHWoI9CTjylgS0vZYcyiZvL7K2ImAGFzS11E5268U2lnw?=
 =?us-ascii?Q?cjyOKt0J6r/HNMyn11Q/dP7eTQ4i1ZLmobnB0/L8neiw3AuJFMhfdq9wtyNq?=
 =?us-ascii?Q?qjKjBLjH1K14zM04uKAebfo3Zg6SOEMDMwAW9/rEykM0JCEUyiTRA9wp+0Ga?=
 =?us-ascii?Q?muupyZSYuSzB1hPRirvAk3wGKrsQFkVrnY08nwt8O42XZdkGFnRWuAYllHRU?=
 =?us-ascii?Q?PWyLoXThvU+hFkrbmoR38yowEapnvHIjajRpPYp+rUaSpOWgkKFgyrSKbcSz?=
 =?us-ascii?Q?X8lqrcmGh03v+rf+r+wznO+T1j4u3SqdSUIvFgoX+EI1appAYSn1Bu2cnBP6?=
 =?us-ascii?Q?Bu5tUu3Wow/jJOubR2VMvq2Vw2H635BUgDeWMLF17RFfIDYQQlF2i1Nfoijg?=
 =?us-ascii?Q?lhfhXsMLmW28dguFjRhatBbuAd1n210YPEO8bOfS7nyEi1zX+VlEHqPM4V/g?=
 =?us-ascii?Q?vvdXfRiPkfTvroE0cJ2bMX8XjdkVGX6WciAE0VcIF4AZLjoXEPNVt9bZwNZw?=
 =?us-ascii?Q?GFEb2uXhoi4ckMAN929NOEpCTXQf9wrl9RM8dZv0nEj78/BA+NDlNQNnhcQj?=
 =?us-ascii?Q?w/Q3KYSO+ph28tIh9VDU6NB8gwoX+UXk45iV01tdCdDPO5Fx62juteei6MZH?=
 =?us-ascii?Q?rpS0AU4g07NQai+jMLQJ9tprBMerNv6JJYEFT+dBVSslVfKVlazMGcqPtRG7?=
 =?us-ascii?Q?FxTnDswLaoQQyzprX5zCvePIx48s2uOjvCtube+epthNLA6yDKEtFmkwtvgB?=
 =?us-ascii?Q?7lsEVm0ZCZbMv/ildnFD8G5LayXj4e9sVWM7hZAfeJTVQqPLYg+4pPtJ6Sde?=
 =?us-ascii?Q?KLvBTzh14Z4JXA7QbzWQDlriwVHDsZKIeaEPj5TnEtJ97ES4bl46pHan82G+?=
 =?us-ascii?Q?0P2fN37y7jO5ERNBIN3aT6Fn2qDnXhlW5WWtQCvkKwU9cwkdlWsIJHUIQsMM?=
 =?us-ascii?Q?rzSG4mnb9PLnLjcrAy5IJbnaWQVj+W0JVgkaLIH8LcxpfwdLrNBmFyJjx716?=
 =?us-ascii?Q?Nor2f/ndLX3eWxV4bq52tmcMJ5zdfy+LzpRyun8+cuQ/qj2EZhn5M5klxhWk?=
 =?us-ascii?Q?y/0VngxzLKsp2YWjwJSW2hM0gGZvA3IKcj1p9MRWFy0vPO6Lf4Eq5g9DvEXn?=
 =?us-ascii?Q?6Hct/mZu01bC/rXU0CNdIA/7OjIMqe701j3zy1AgNZckpeB6egSDx+xpy2Dc?=
 =?us-ascii?Q?cOIbSFErPHYFpBKGZ/38F2HidMGpIdgVwc7a4jxwvF/r6XOVjaUFFxEYYpUQ?=
 =?us-ascii?Q?6XTXF8oRaQpwp1Vt4pC0wWDyXfsUKnpSFh6sNxPnEk1PMu/9HURyPvN9eD9v?=
 =?us-ascii?Q?ibtCPnvWQWhAjg4fKYBqVHiIqHg5YmxdQOj4frb651/92s9CI91V+t60T834?=
 =?us-ascii?Q?sVptaL7TfsKdCO30RzPW4ZwXtuJUjh8CHrt5aSFsQHY2u7a+VLAmTg3/YQ4C?=
 =?us-ascii?Q?PKwU1HZOfirx3kx751trsJF5GllSiCXuJZMVeGGI9feMBm+LUXQTXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i6B31siCP2pI0FVdJL7cZEZ/+BGPrxsuwJBXJjYqZity1pY88UtzqnxY7cLx?=
 =?us-ascii?Q?aBlyfbfDZhuZR417X103TvIzbr2A4H+zFJ3KnlPqA1v9tx789B3lmRDyZhJk?=
 =?us-ascii?Q?5m5xnW7T3kZ4WvH2RmnesXv7CP922WQlQDNCV2lGYQ20KpOwnCRZ0MtGUpyw?=
 =?us-ascii?Q?Xc35cbq67IjIH7pw+xmxGf83B9XyqBcA81o7O0j8aF+pQe0dDjQ3cABhSX4b?=
 =?us-ascii?Q?MILXly52VI0QJRHdo6cNm4Sn/fFjIrFJCCqz/B3JC0nLw6dbOxPEikGLJ5t2?=
 =?us-ascii?Q?KgEfzJ8qtiZrYp9vRDUwLJr2CBoESl35C2Sn5wWcOGSdhasipt0YzeimQ8hA?=
 =?us-ascii?Q?ml2MHJYZoCENzatN9BQ47al5DykocY/jVBc6scpynBGbEFV0nsCZjkuKIXwC?=
 =?us-ascii?Q?/fRja4ZCfjXUHft8Se/nSmQs19uj3FKmAtx8nD0rZ0jooC83ALzhwF0y07We?=
 =?us-ascii?Q?L0l4Tgrxlb2uVwbBw4OP/Fefxt3EKV7/VDCHfVXeTrAVMsw2QEUrwZGIgfKT?=
 =?us-ascii?Q?SnIiSiXwL1IYwrRnMGuItJWr2fSSIiGjimNLFGs8e/MlRStdL90TWcouIdGY?=
 =?us-ascii?Q?FwwhJxwQMeSYibvYuyIvj/hifZWdvPKMHW7mcKtQNGORw+aSDVINPbUN1qwI?=
 =?us-ascii?Q?qUidKLQEo2iW/+R/MuRYNLWB5prJ5BYVrsagWYEwEwF550EWQiceaqcW9HvC?=
 =?us-ascii?Q?yQ4IlAu2BCexjyMD7zeUD496v4IbSu7gH4lusZ8TI2vGMUKcp5Elq1ZQJmgT?=
 =?us-ascii?Q?Wh7mqoWNS4Q/2wCVUXrStPc/cEsbtjkNdQLEtmYJ8coIpWqJtUk768T7Spzy?=
 =?us-ascii?Q?tk5wvKZ4O+o+9MLC3OfeEWYZ3lEZSNrqYA3UCltOlJqtCqEOab6hdlKvVsc+?=
 =?us-ascii?Q?LdE9iPCssNQCJSZorhmGzXe5WCGfLQ6hS+FokGZXUA7sL+9nv+kR58SNNyYc?=
 =?us-ascii?Q?a+DZzuKjX2HkzIwBEqSl/c7fk9ue1DtiSDAUVkiSujs6iOCk6OzI6bfRJ4L0?=
 =?us-ascii?Q?7Z7y+Cmjm/YbFQl6kjkr2127xxEuNkqOMdgPuIEqgQg5+fal4uwQ5ft6dFKI?=
 =?us-ascii?Q?2GSvkiZlDRAQNqEQ8kJ3pa4yw2y7qUwk3sowDjAs6nVaTAG/CY0oPHF161j2?=
 =?us-ascii?Q?M9DupU/fOXExKPZ7O/4Zdg8/JzC0yP2Lf6tPQLSolXi1MQK4gGnT0m+UdbpW?=
 =?us-ascii?Q?F7dKDXREbVM0FWiAf+yOj9xH9oiVWVTFvdh4e+r305AdxNZ/kPH0rGIl8C0/?=
 =?us-ascii?Q?NO7EzKEcl2OWMaPIdMQjva42SX+wZDd3c+z6yt0Rp5CStTmTZtI9X+XnW3k5?=
 =?us-ascii?Q?q9zL/0K2hOCfevlO39bV3KFMFS4Bcekd6Hn7UH01OKMATHWgABhzFShtL9bg?=
 =?us-ascii?Q?WVKpFy4Zwnj2PYOmuLXpuTig+LOndm+DXeg4uIt1G0FZZM51nR3MhFf+Ah36?=
 =?us-ascii?Q?pxg1odW97sd0dhvzPjmLkvMTYJmuIjtmCil5rcyxUb2qKXfFO8cXUh9flMzv?=
 =?us-ascii?Q?BtsFEXjQuZeYCeWHUxUEe9fnHFyRrfgIM2GM7X5Mh7g6r+soAIo9JAS3QMU0?=
 =?us-ascii?Q?mtHqvjEkPo4gJJ5YnZBH4/vur4g+s1swCo0nykTM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3563a52-9a78-4b04-8595-08dd7e9393e8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:46.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NscfphxaJ/B9UST5EmUqqN16uRQdNgSQf2cX3AGElEXBHAyYX39+UjFUmaJVSv7zOKfgsVtLvoirCMFHxbnSuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a --do-rcu-rust parameter to torture.sh, which invokes
a rust_doctests_kernel kunit run.  Note that kunit wants a clean source
tree, so this runs "make mrproper", which might come as a surprise to
some users.  Should there be a --mrproper parameter to torture.sh to make
the user explicitly ask for it?

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../selftests/rcutorture/bin/torture.sh       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 475f758f6216..e03fdaca89b3 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -59,6 +59,7 @@ do_clocksourcewd=yes
 do_rt=yes
 do_rcutasksflavors=yes
 do_srcu_lockdep=yes
+do_rcu_rust=no
 
 # doyesno - Helper function for yes/no arguments
 function doyesno () {
@@ -89,6 +90,7 @@ usage () {
 	echo "       --do-rcutorture / --do-no-rcutorture / --no-rcutorture"
 	echo "       --do-refscale / --do-no-refscale / --no-refscale"
 	echo "       --do-rt / --do-no-rt / --no-rt"
+	echo "       --do-rcu-rust / --do-no-rcu-rust / --no-rcu-rust"
 	echo "       --do-scftorture / --do-no-scftorture / --no-scftorture"
 	echo "       --do-srcu-lockdep / --do-no-srcu-lockdep / --no-srcu-lockdep"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
@@ -191,6 +193,9 @@ do
 	--do-rt|--do-no-rt|--no-rt)
 		do_rt=`doyesno "$1" --do-rt`
 		;;
+	--do-rcu-rust|--do-no-rcu-rust|--no-rcu-rust)
+		do_rcu_rust=`doyesno "$1" --do-rcu-rust`
+		;;
 	--do-scftorture|--do-no-scftorture|--no-scftorture)
 		do_scftorture=`doyesno "$1" --do-scftorture`
 		;;
@@ -485,6 +490,46 @@ then
 	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_FULL=y CONFIG_RCU_NOCB_CPU=y" --trust-make
 fi
 
+if test "$do_rcu_rust" = "yes"
+then
+	echo " --- do-rcu-rust:" Start `date` | tee -a $T/log
+	rrdir="tools/testing/selftests/rcutorture/res/$ds/results-rcu-rust"
+	mkdir -p "$rrdir"
+	echo " --- make LLVM=1 rustavailable " | tee -a $rrdir/log > $rrdir/rustavailable.out
+	make LLVM=1 rustavailable > $T/rustavailable.out 2>&1
+	retcode=$?
+	echo $retcode > $rrdir/rustavailable.exitcode
+	cat $T/rustavailable.out | tee -a $rrdir/log >> $rrdir/rustavailable.out 2>&1
+	buildphase=rustavailable
+	if test "$retcode" -eq 0
+	then
+		echo " --- Running 'make mrproper' in order to run kunit." | tee -a $rrdir/log > $rrdir/mrproper.out
+		make mrproper > $rrdir/mrproper.out 2>&1
+		retcode=$?
+		echo $retcode > $rrdir/mrproper.exitcode
+		buildphase=mrproper
+	fi
+	if test "$retcode" -eq 0
+	then
+		echo " --- Running rust_doctests_kernel." | tee -a $rrdir/log > $rrdir/rust_doctests_kernel.out
+		./tools/testing/kunit/kunit.py run --make_options LLVM=1 --make_options CLIPPY=1 --arch arm64 --kconfig_add CONFIG_SMP=y --kconfig_add CONFIG_WERROR=y --kconfig_add CONFIG_RUST=y rust_doctests_kernel >> $rrdir/rust_doctests_kernel.out 2>&1
+		# @@@ Remove "--arch arm64" in order to test on native architecture?
+		# @@@ Analyze $rrdir/rust_doctests_kernel.out contents?
+		retcode=$?
+		echo $retcode > $rrdir/rust_doctests_kernel.exitcode
+		buildphase=rust_doctests_kernel
+	fi
+	if test "$retcode" -eq 0
+	then
+		echo "rcu-rust($retcode)" $rrdir >> $T/successes
+		echo Success >> $rrdir/log
+	else
+		echo "rcu-rust($retcode)" $rrdir >> $T/failures
+		echo " --- rcu-rust Test summary:" >> $rrdir/log
+		echo " --- Summary: Exit code $retcode from $buildphase, see $rrdir/$buildphase.out" >> $rrdir/log
+	fi
+fi
+
 if test "$do_srcu_lockdep" = "yes"
 then
 	echo " --- do-srcu-lockdep:" Start `date` | tee -a $T/log
-- 
2.43.0


