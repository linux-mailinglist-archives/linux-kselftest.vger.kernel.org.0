Return-Path: <linux-kselftest+bounces-49487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0FD3C4EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 11:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD4CB6CA37E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622B3D6473;
	Tue, 20 Jan 2026 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HSdJ8Ylq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HSdJ8Ylq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4C3C1FFC;
	Tue, 20 Jan 2026 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903735; cv=fail; b=B/+7Gse6jdihC48xMQCyZuxKO46WSZT4TpQKRAu/rYKGwKEB0BGy9Vi8sLytHx1/haA9QoaBr0MsIU1oZ0vl0DaSd53hHceowZQrIp3fBd/0nFz03P/BOguZ3prnX4dFSizp+z0QbdUZ+p7HOk9tveTTSjF8O+W2lasxKQENMEI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903735; c=relaxed/simple;
	bh=wxoe2En/o88JG5I3h3wqxk2TZlUq7wyWcQCm559enOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A3R1RaLDnXzembJPkF0UPGTpvM/sjA9xgiCjXoDznOAkR0tuDToOBVs+D1muF2ob6yOvhPX5xa9F2lQX2qvkEGQaPPDIUioFP21i0wfbhvTopwrNISigLEYhJzsCDTTH6ygy4BzuOBdMKhSCwBXynaaFKGca/2UMDi6qmIINFDY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HSdJ8Ylq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HSdJ8Ylq; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xxJWZlcTplBHKwptXWwp+wzfDIZ5/lWl5OfDYjR84ISjo5mbK2iDBmIOWdD22XOmUvszmkANO2urB7CHYKorZm906hNa1BLmR1ZnmdLOUpWrWMjMIdE18/A2pwFOLU0X+FFgdTmQYbUxlW4YWm3WMwfMHAgQT46Q/PWva48mGaSJGWsLtc1K8VZpfw+JsJ0zbTBaf6ieM6fV8i4DsB8ppSUNoB66K/ERlGTXyjBeazhqYWH7SO2epCglnNfdYz6P9zJ96TjOXX1loax2HMtkm01d9ZkQXk0FDZZwPwpbSo2ef/QRbYvBhcnAx6cUkAIyQCKAevyMGu+E6QF0spH5jg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNmrwiIbxYygLUlVl4JfPOzhtIrsHlj6sMYBfsXTjHY=;
 b=vzmg3brOUsIBiCM81BTVlJR4JxrkukHhTHgUdIyCOiMcru1QazpoYfEhE+38HZuc6HvH6igZA5a4rR+Q3wddc6lL+Wa2X7hQRwIMHDjaTT9pJsxFxiUaI6SW0Y7TVopDdaU5WnLGYJi/2OplLTSHYB+nNMFFNq0v07/4TcuKUqJivM158nco7eY1Edpap67+h13ghGnwSseFu5UX/K3fMHpurqCkcyFOP8wMdzoXwLEHQW2YD22NLDGDH4WdVOEgRKe/2EuBRg3zqskMsgZKFJA2ySmQ6BRECB8tJwmcA/d1W9EMxGWrriNYKH8FkLmRPYLX6z77fDoBSXFLv9EDnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNmrwiIbxYygLUlVl4JfPOzhtIrsHlj6sMYBfsXTjHY=;
 b=HSdJ8YlqiOvD5aYC72Hk/PIaIleMRv+IJkUUK2TE993nm3VVzdD/mx+8G7npI95PeKOdcRb46ihFSi7EHqA5389rCt1Tfd2YlEyM1z07dgdt9+eaB+ECd3rA0rZn0WpCu++4d+LAdxuHpQo5JZ3WEMYwFcgKl2Jxw/Jt2/4pIxU=
Received: from CWLP123CA0241.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::8)
 by PAWPR08MB8912.eurprd08.prod.outlook.com (2603:10a6:102:33d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 10:08:44 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:400:19e:cafe::1c) by CWLP123CA0241.outlook.office365.com
 (2603:10a6:400:19e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Tue,
 20 Jan 2026 10:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 10:08:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dU0mMUdMVm1HP2yexkjE58iZse6gTVHlSU2cf5DvArsItHRgHeQlSevDUhmq323EA+nMDKvzFdmQZqxVhxfM8AOkvUw3YL9RBym3yMR8YBptOJUTf0NaMLcJHD/4HPLFlU2nmgh1i1J//5xQLWjtTho2giQoM6amZBGsSNCrTGBZrTw5On0ru6i7hE6jMjrmOe0PCMdRMH1vV0arW7zkdwDQ9E3PoTdIEwY+DL5yDruaoUn7G6Rz+o4Y4UVnAUS9N+Z9ZRH1yIl83PMZqYxGmVoG77bmPOFgJhUPmiFUGqKWNdIg9WQIYS7fCTmOTT0Qdi2qb/cBnLix2/8KRPAdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNmrwiIbxYygLUlVl4JfPOzhtIrsHlj6sMYBfsXTjHY=;
 b=MJg1N0bd8w4/THDi7Rd1Euv4Se/3ObX/SY905Uy6yRszj1iXDaD7NjznpZbEFDjS2D/X6r9K6q3n++4qAtZepEq325tRo9mDnmy9m+kc4t6MAseqQrqZuytLVBPDzbSiNzncoGhU4IK/YP24z/7VoIauF20qiACZPVMTL1/mZUa1Fcy6h02gpHglhvil1tzqGEx/Nl/3Z3DY2eIovJ+PCVNooZigDS5u4C6Oh6Hy3dsVm7ps1+FDBuhXxPYcVVgVKr2vRuorzl6i8g+PPTRzk15Ny2s6Fm3q+6PCfOenCE8cHGRYtH6lkWuLg+B3kVsQRPsgXP6hacd1agsfKGQTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNmrwiIbxYygLUlVl4JfPOzhtIrsHlj6sMYBfsXTjHY=;
 b=HSdJ8YlqiOvD5aYC72Hk/PIaIleMRv+IJkUUK2TE993nm3VVzdD/mx+8G7npI95PeKOdcRb46ihFSi7EHqA5389rCt1Tfd2YlEyM1z07dgdt9+eaB+ECd3rA0rZn0WpCu++4d+LAdxuHpQo5JZ3WEMYwFcgKl2Jxw/Jt2/4pIxU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB11090.eurprd08.prod.outlook.com
 (2603:10a6:150:1ed::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Tue, 20 Jan
 2026 10:07:37 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 10:07:37 +0000
Date: Tue, 20 Jan 2026 10:07:33 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	catalin.marinas@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
	miko.lenczewski@arm.com, kevin.brodsky@arm.com, ardb@kernel.org,
	suzuki.poulose@arm.com, lpieralisi@kernel.org,
	yangyicong@hisilicon.com, scott@os.amperecomputing.com,
	joey.gouly@arm.com, yuzenghui@huawei.com, pbonzini@redhat.com,
	shuah@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 9/9] arm64: armv8_deprecated: apply FEAT_LSUI
 for swpX emulation.
Message-ID: <aW9T5b+Y2b2JOZHk@e129823.arm.com>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-10-yeoreum.yun@arm.com>
 <86ms3knl6s.wl-maz@kernel.org>
 <aT/bNLQyKcrAZ6Fb@e129823.arm.com>
 <aW5O714hfl7DCl04@willie-the-truck>
 <aW6w6+B21NbUuszA@e129823.arm.com>
 <aW9O6R7v-ybhrm66@J2N7QTR9R3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9O6R7v-ybhrm66@J2N7QTR9R3>
X-ClientProxiedBy: LO4P123CA0339.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB11090:EE_|AMS1EPF00000040:EE_|PAWPR08MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f62c08-6d92-49d1-3a5c-08de580be429
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ywzuM6qsfrvVMhUEnIuXJlzhzJLgSVbubm4dhkm3czGz9CnvO5MOJYbfVAdz?=
 =?us-ascii?Q?qKdz6hKNyGVZYj1UBw62doZZrWS3obYp7beo0OZLDacWzZWTi3EYrSK2SxNF?=
 =?us-ascii?Q?4uco8xpQHPtUDflRETeXWHV5fST85TJQZCa1y7j5qJzVHssptdz61GvSeggc?=
 =?us-ascii?Q?gXruwMtFVr9wc4DDOWD+9lXRZ3NcjzXIAChMA6lwEtdhzVcrhxraINFRQmCx?=
 =?us-ascii?Q?GDrHU4Bq3v2Ug2LvTcXJfMz2n8b9JBC2HH8+p2Qj1XLpdtyEKzaoCYcrcxls?=
 =?us-ascii?Q?Ybvrii3pQDajkG7k9ez9JiD9YfWmcK7gu+PpwCPS4/AF5byPSezk8wzAKWg6?=
 =?us-ascii?Q?bsN3ONPSTxhQXg8VikYGDnsK3zmjO2b5u6K0kdAFHEfDou47CId8UE0nwam5?=
 =?us-ascii?Q?KFZUTZuQ6VlDMK7DTR8i/lMwDRLoi0043viSwbOchEh3CloUWZyD7rAwZ9Hz?=
 =?us-ascii?Q?pGs/J7IrymMYTDfQP4HXKyr+suXAIyKScw+LdS/1EQM2iqr5OKx4hQTHUF8I?=
 =?us-ascii?Q?ac8zkLxogHCjGQtC6m2N2zzBmaiCubsqZMHVBQMsru2+QaXYRxrtxHKfzTwk?=
 =?us-ascii?Q?ykWdPCkGr/aNci52ZXpQqQlWd0U0ObL8IS8/eG2IMv9XLFO8A748IRY7HfCd?=
 =?us-ascii?Q?aBROGzZRdf1LGP86bV+9hZKE0tcYYY+42E1UqspGNFDDvPsuY67bKOteraAC?=
 =?us-ascii?Q?8w7K9266hquBhSyN6m3St5IXZlrpNxwEwhNqPVWD0PGpFKODZer9nZMZtrAX?=
 =?us-ascii?Q?D2FtPi/rQV0/48iAI0nMYZoRc4WxJUvxZjjEuM+cGU3ov5ET3FshticNvVD3?=
 =?us-ascii?Q?i4ODdr7vb1/kmdnkLzYvgOLbzdVVl7UpcBywDvHvp8C+R9nsMNUliiGA+us6?=
 =?us-ascii?Q?DeG+c2hMym3+kmsAiI/RYTWOQ5Kk7VNJpfqixwdtSIvZQo3zvy9D3EJLQsqt?=
 =?us-ascii?Q?GsXzvHLlXVoRIK3LuZEw4BoE/ccImbAZCFI22YCyyXLYrsQSI2eO6PS7xUt+?=
 =?us-ascii?Q?XX8DJLr7MY+0sqUyz7kyb8GKafXTZ/R2elKMQ5Cu4opmPZKHC5RcBXw6Rmlc?=
 =?us-ascii?Q?qw8hhmS0lMemOEFlS+fTUmc3kiRwdbvURakWGThPV4UMbxUTItA4qdEZlcQ2?=
 =?us-ascii?Q?Bxm/q982qLPytj/VzrKom3lBpIZsXVhRY3Xr1ZgjVEL/2Zl/GqtU8ZF9aPXB?=
 =?us-ascii?Q?CENkz7if1oMMPb97dY8SLh9ScpwvC4/UpEeACP80caF/rE6iLk/yeRF1GGOe?=
 =?us-ascii?Q?CYomHosxsrxAPcMNZP30ahenh/465yCO6xZD5Uz5+r/vOhwCJ6Vba47eBA5S?=
 =?us-ascii?Q?JOuIhih7HzShe6ch7HU9TCMAKz8v0KtH3E79ZT9Saitc4PIqZ84GgV10+ldd?=
 =?us-ascii?Q?QA+PSLtS0AEkIhFjl5VUAWjG0Ae2T/40K/S9CzrSLE0tyWywUhXwfCsRMizJ?=
 =?us-ascii?Q?onIkRIjztKctge00WA5gtzvsaHkyeG50I5NJoLXKlsL0FdpeYS77vehPPgO7?=
 =?us-ascii?Q?FlQvS7KteL4uf3TNx3VpbsFnnnqfLS1K804N61k0VLGhr6+N+McDZVGrtrJH?=
 =?us-ascii?Q?Qi0wQKzlV3ved6ht8DE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11090
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	17b70958-4515-4769-60a6-08de580bbcc3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|35042699022|376014|36860700013|1800799024|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPvHsXwlg7dpBjCHP/wZ86rNyJHm4AP51oMacXeAvbUuI32MC9nOmu5E5QzB?=
 =?us-ascii?Q?e10jitBwdF48qFjc8Y9naYRzysli4PkSvS7DqltSCPWo7V5KHncGgiOmnNEp?=
 =?us-ascii?Q?uzycAdrO6XrYKiLUXZ6mgA3+VJzXbB2+fkHmKXlr5xgqc6PzJsEEGJ8nKA6c?=
 =?us-ascii?Q?xszpV+yYIwzJrB3W3bRX58RukooSvgSX2PWxPIJv8tIrsY5YhvxXK7Aot70b?=
 =?us-ascii?Q?PAkBO8PaN1Fdkd13KJ+CkFE9+1rfm5NNe+S0xLR511wnYjpgQ6mvCFvS1NhA?=
 =?us-ascii?Q?4yjMo0J+9JN+mgXLxxfI2OX4IjUFl2obx3LAeyqktEdLh9d/13AbbvFAj6UV?=
 =?us-ascii?Q?kKalSfbgyH7qYxtygkqtlkxmfQniXgdetJvwtDHvErNfgdV2ObKOO/zQLqJR?=
 =?us-ascii?Q?E7yi/QN3BQQ+SxLdst/ZayEM7PIS2D1iPosDof/PZ2rpGuF8rbMH8yQjrg2L?=
 =?us-ascii?Q?ut80Kyf5wzqX5ZyAg1I4k4QfbKktTD2bi+2HjzwiMR3zRnYWU39CqAxkOkKn?=
 =?us-ascii?Q?7pE27CbJWtdisY5/3ln3/5dLgzQsH2dQ3Y2pGr0sH0dX2A3Zingd4B/PDohH?=
 =?us-ascii?Q?zFx30zBf+Gm107fQdV1DZC0fZLxGHFMXFDwUqTNDuM1IUfbwxcupNSr8qqsX?=
 =?us-ascii?Q?TytUtfIB82OKt+ScGCREdNM7cnzlFKBNYpHKLqPDK31moGOSNb6cYkXYE7ge?=
 =?us-ascii?Q?t3UB0VvzmDf9gdd8sAwBxMHWgwBWISbX9mUZSaP75NjfdPn94GTvj7y8H69D?=
 =?us-ascii?Q?C6agVCS2qOPtm8IWIv2oBQ6hLlxmbAAoRqLjHYTv6bKQg4j+jHjIAGPMYWbV?=
 =?us-ascii?Q?Zsql4xvnOazjZ2NgTJfmNcx3UnufJs8NEMmbxeE/Csu9sNBZmyjjPHU7kWbE?=
 =?us-ascii?Q?o2mcXhtnuh3mKkqnfXH5Yjno0H4Y6z+ujsvBcteb1ixtWFcFeLXUlHpnTIXN?=
 =?us-ascii?Q?MmoZUv4FrHE98iGpF1rzi5fYsy07CYzWNBJQA2jRpOsX7H/588OCk5iouSp0?=
 =?us-ascii?Q?6M4OBw9BOzJafza1Rbj1vrMHZHvfHpk/5gZ6XT1ADUchbg+njpfRjaipMkRz?=
 =?us-ascii?Q?yR9HMb2/ZCDwNFroPEXccrFHXFogDW/QlJZ3FpLtzY4S73LVO2R9mIIBv3NN?=
 =?us-ascii?Q?f4PXzgz5DYQzUCexGgRm/v3gjQ45x6SOYVy9Y4VfpqjS6Q2iws2GXpg7rqjg?=
 =?us-ascii?Q?GZi4HZCNIiLl9WlfoVh+/9CAdDy7K75CdRvE4Oagza49Uf05yFfSXfjPEZTw?=
 =?us-ascii?Q?BANToYVGFylxi+lNX3vLo2MLyln1FBGVeJ6oKr4OoCxj86lXDa1ld3ZDPFQs?=
 =?us-ascii?Q?tD1WWmIp4+5jWJGQVEycTlLOatH/eABhn/OVTeChqxWAfOXVBL2MV0JC+eIR?=
 =?us-ascii?Q?vMKTrEy5PvQ0tJ5lomzTZIlCdkHf5K7mn0hmJTZ9LX/ntUm+Ml3HqvViM1g8?=
 =?us-ascii?Q?QfiqpM5nY2+yjmhQBxlLEGXdvEwWsvFxdjGphzmd5nQNPR2ReH7+XWXkRQBQ?=
 =?us-ascii?Q?A9y/uYUL43P92M4vT/CKCDVsbyHf6kD5S5zUpz3e4NgI7VEFGNyogynQr07S?=
 =?us-ascii?Q?omqNtLctG67AXvdLSYzDU3EKeymes2dsFxjzY0iJgH8cY9J2s78tQedc8zae?=
 =?us-ascii?Q?p0v72zzwGT2DwyMklfgiowh0OEIawebM1iTrJcmZzk4SRF/QtH0USZf2zvX7?=
 =?us-ascii?Q?juMebA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(35042699022)(376014)(36860700013)(1800799024)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 10:08:42.8100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f62c08-6d92-49d1-3a5c-08de580be429
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8912

Hi Mark,

> On Mon, Jan 19, 2026 at 10:32:11PM +0000, Yeoreum Yun wrote:
> > > On Mon, Dec 15, 2025 at 09:56:04AM +0000, Yeoreum Yun wrote:
> > > > > On Sun, 14 Dec 2025 11:22:48 +0000,
> > > > > Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > > > >
> > > > > > Apply the FEAT_LSUI instruction to emulate the deprecated swpX
> > > > > > instruction, so that toggling of the PSTATE.PAN bit can be removed when
> > > > > > LSUI-related instructions are used.
> > > > > >
> > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > >
> > > > > It really begs the question: what are the odds of ever seeing a CPU
> > > > > that implements both LSUI and AArch32?
> > > > >
> > > > > This seems extremely unlikely to me.
> > > >
> > > > Well, I'm not sure how many CPU will have
> > > > both ID_AA64PFR0_EL1.EL0 bit as 0b0010 and FEAT_LSUI
> > > > (except FVP currently) -- at least the CPU what I saw,
> > > > most of them set ID_AA64PFR0_EL1.EL0 as 0b0010.
> > >
> > > Just to make sure I understand you, you're saying that you have seen
> > > a real CPU that implements both 32-bit EL0 *and* FEAT_LSUI?
> > >
> > > > If you this seems useless, I don't have any strong comments
> > > > whether drop patches related to deprecated swp instruction parts
> > > > (patch 8-9 only) or not.
> > > > (But, I hope to pass this decision to maintaining perspective...)
> > >
> > > I think it depends on whether or not the hardware exists. Marc thinks
> > > that it's extremely unlikely whereas you appear to have seen some (but
> > > please confirm).
> >
> > What I meant was not a 32-bit CPU with LSUI, but a CPU that supports
> > 32-bit EL0 compatibility (i.e. ID_AA64PFR0_EL1.EL0 = 0b0010).
> > My point was that if CPUs implementing LSUI do appear, most of them will likely
> > continue to support the existing 32-bit EL0 compatibility that
> > the majority of current CPUs already have.
>
> That doesn't really answer Will's question. Will asked:
>
>   Just to make sure I understand you, you're saying that you have seen a
>   real CPU that implements both 32-bit EL0 *and* FEAT_LSUI?
>
> IIUC you have NOT seen any specific real CPU that supports this, and you
> have been testing on an FVP AEM model (which can be configured to
> support this combination of features). Can you please confirm?
>
> I don't beleive it's likely that we'll see hardware that supports
> both FEAT_LSUI and AArch32 (at EL0).

Yes. I've tested in FVP model. and the latest of my reply said
I confirmed that Marc's and your view was right.

Thanks.

--
Sincerely,
Yeoreum Yun

