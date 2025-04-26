Return-Path: <linux-kselftest+bounces-31705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD3A9DB81
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EB01B66DDA
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED725D1ED;
	Sat, 26 Apr 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kw13sQh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62B25B699;
	Sat, 26 Apr 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745678963; cv=fail; b=MVihBrpih2RhzvAgmsbZl0eUb+9g5KPjzdUpf8GZ5FhjBHp1bVKwTcCn5ScRvji92DuIIZtvAFPcWruZX1KkfBHSePbDQhcmLK7SFuuZ5LSZBe7GdLRQqtbbqI1gH2rfzoMBhtCefjgsXvHSVXqKZfbrDnRzw0AmUCvA+P5cNv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745678963; c=relaxed/simple;
	bh=AbPVMBs6XoOxoDPQuwVI/StlaABKKkkCF5IR8souCdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LldOBC2L3fS7DQjcFB9p7Zb+ByONSdKlSBThJNW+zM+E6QDSGGwlw8qbRvWhoiikxNeQTQxEhbecjoUROxGo7PddEGoNXwTFwwN1mKgfoQTluW2hdtYpshD+DeTqoWZ2F2OT0UWVNQl0uS0hB7Dl171256U3qmrzWHLHRW0E2jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kw13sQh9; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YulrqPWibRNGqUK98C0m5VQDIxJ4CZSJMqzfQp2McWPi0XmDDAsv4J4a6cqj/ZFJth3rIaVMDRcGZn1u9EblyXiGg9QLmpkGES8QK36iEwWW1wUbXqpuyDGWe2Fjysyyy3R48LGbMWMtO9dyAu3b0OJAxQ09DZqM97fNjWLUmGvbwkgwYEwTCh2WJKnwI3EwwTJwC68RsjR9tZpj+eP/+LiUSDMXK5Dqg2G/SnFk5A6MHn4KMnFrxswl+wamlzTVp1d8sgGJVQLKSCqmBfDzTgZwu93DFmMdEuyDfZfmLDzL8YE0D2PSHyJGVARqkhqk7P+PZfVnKBRcAE+mwSI8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+wlHc+eAHwWXQAwmULLL83EPTtJf2ejkkvtphd30ZQ=;
 b=ECmWZyVhgVMPoFp1X/DESCcQ+Myr8RyuOtoUHPkP9EMKnhSDSAcd1Kmm45E8HMxnjDSsHWcJlLCSQ7G1pvUsmmD6I4IIjFWgRJy9lwcHY7HLfzvRwOnKCvQZYaq3NEskAuBNQz/2b3tGHAuB9VT5Sn2leECrxKjwhXPBBcgGP2pzTcufqcWEiZpb9AGH8+EegxxJSc2UmhDzcvkQj2H5yXGt4vHQIFNVTlxf+J1ARbS443Qbi5P5Vn4Hzo8/Lk6mYnUWVcw0fpg6wmQHBGZRVyQHdVDJT/s2mZp7fsOH5ioz1LoKzXNQhVOvirJEA7mZZWpo0Zo8xVwieqUd8/CSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+wlHc+eAHwWXQAwmULLL83EPTtJf2ejkkvtphd30ZQ=;
 b=kw13sQh9qx6Xvo/0OctCLH+pHpT73AHgS7eH0zXKaLPiqaDyO0C1la6oFjn1WTp7fIIO4H2uMt4JOk1Rc4RZuR4T/vEhfrkYIHCBqDwkzRHqkZaNP5cB3JIN1TsZayFQ4Qgh8TE9BdsfLIpb99SnepyS1riSwuS70ZKjQGNfs+WOtUkk3yZnk3ekgASsBcPR33g8jA1uwyd6hN5H+lxP2esNR8oaKrFNQYXl84U8ehuqe8URWE0vioeK1Igo5eP2cIYCQfz7J4KtwaqHCLrZ54TkKdimErCH20k1A2AoLGQT2vMTu6wr0Drx9KHratAnp8Mfb65K2doGnlpw/gPSNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9019.eurprd04.prod.outlook.com (2603:10a6:10:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 14:49:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.028; Sat, 26 Apr 2025
 14:49:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Richie Pearn <richard.pearn@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/4] net: dsa: felix: fix broken taprio gate states after clock jump
Date: Sat, 26 Apr 2025 17:48:55 +0300
Message-ID: <20250426144859.3128352-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250426144859.3128352-1-vladimir.oltean@nxp.com>
References: <20250426144859.3128352-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:802:2::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: dbce7fbe-f288-41ff-59da-08dd84d1826c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EphMRiFgoDi+bRMWLaTSicKq6YmScbz+MGZGBl7jGrG82kOoyjfJAQQxTFy/?=
 =?us-ascii?Q?CnK5KFiScX8F9+Q41xz7ELisj7mH0ZU/s7FL6PYWj9o6OKwQyxYOGn/jkJq+?=
 =?us-ascii?Q?ibPWJ3Ia3iwBC+mNYm0Z+5uE7q/iC5m1JKEehRf89hfCPrSjHYnmgXPCFeRU?=
 =?us-ascii?Q?NzC79tHUNqJ/6TqWZyg9kaL00bniPDPE4/qzeOr7ssz+wH1ogaieGuQAALL5?=
 =?us-ascii?Q?nhEH+G/elEbBofdxwk5fFFvj1WxfUrayxsKEuLxrcf7fGrwgKz8RLWQcOkh9?=
 =?us-ascii?Q?YOkLmwFOXXvpUTGKSKMQ6yCTCFTh20onkTz3On/MmGmRVgCRrIm7UvGibtlB?=
 =?us-ascii?Q?KaJ4hoNwDN+0EYTGyx8+lBLtMuCjaVU5f8WTdgRpOSxK16LOJcZDsd9iNsQp?=
 =?us-ascii?Q?En6ryT8pnTWs5e5NkAXhxYauXHHcaKtwdOMdNxDUl/M9j3EzEsWqqbOWRq3i?=
 =?us-ascii?Q?96csQyR9KEozu9Ywj3sDSFZo20dEIb/NPLFpzNJMpdoJPHVVnu3mBgdccySC?=
 =?us-ascii?Q?0+IvZLDWitZ3ZNqZjrnqALnasqOxiuzAuTuh/LXCwo2y9Mh51jA4qjN5ZZpV?=
 =?us-ascii?Q?oE2DN9emjftAv5Zqu+170bTSJeDIvaEWwlbDxiBMH3tVhDKXAy6EsntOpOMt?=
 =?us-ascii?Q?RObxVL8QblBVECO4qFMthxjoHPTaXlB18p2Xr7ZRGmeq4sXJBEBdoAN7iXIe?=
 =?us-ascii?Q?UDuO118bNJSdOlSdYNAQdReKEKgafXJu5f3j8cSP2t5piYfsRtBuAE1zzYE7?=
 =?us-ascii?Q?6OY64FLPeTSsDZpTXX6ouz80ukD52sn2W8xY6duzdMlWFbGoYNwv3iFfAxDM?=
 =?us-ascii?Q?En5nmRNH2LmHrTnvNyKHHvYUq8Sqqea0d7PrlLdOKFSkyn/3EJ6/QUl2ondm?=
 =?us-ascii?Q?+ycRnonRXWW3ZW7lx6Mdaccf8sW8lIipb4H33M+4/K+XBRSluKwe7yoNmhWT?=
 =?us-ascii?Q?X6ZZdgXLHNEHBuSwDxU4oBHUnk3vgRJWG2smcSFuNunZxlYc63MSOdOMspXw?=
 =?us-ascii?Q?1yVpMsvftnT1VSlarMdrqglsDWEyoONQR3RZWXrRGcQ5b3t6weNVTluv63u3?=
 =?us-ascii?Q?eNpuvg87HEbUa4GTEFR72uozUEWGVj9f1m4qhR62YLvJFr+ImOSyiTz8nICS?=
 =?us-ascii?Q?OrqrOGAdPvkJD+Cl+lLbY5g7QQOo4gkTbc9QTcv8+XbT0woiBzbf5s9ti/6J?=
 =?us-ascii?Q?PwKt3XumZouxZUrHQW+wI3sOzBDyD1kk4av7pN43Udt+/JQjXsCn/5rae7WL?=
 =?us-ascii?Q?Pv+Y+qB541C0UhRxh6YpeRrUOFeos9LULLzOopDVJfngNAdWPqzV7OfUclT9?=
 =?us-ascii?Q?JeeXJPHlD+2/KRCuRLsjlD9pzkQqYWXHD7PhBqu13DF3POMcE3rGcShJmNcx?=
 =?us-ascii?Q?bt7kai9FKoZOVxog0KvJM8KF5figeFBtN6de93TCcQk2W0UCmw5uExZu8exa?=
 =?us-ascii?Q?iIUKj0zne0eho+Bk0RHIvRFD5NJ5EGH5U996ylBiahW30dWEZuobLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r++K/SEOrgoQ73n+DzeqkCHsXVP8/tQab6uSWmbXbPCAdWL5WxR7WwR55Yvm?=
 =?us-ascii?Q?6RyggTuWJP/jSXMt04b9HO8OB0Xu1P7iKaLg2KRsefsNEKWh73QBk0MTxZpm?=
 =?us-ascii?Q?XPBsffnoW9SUFR91d9TvRQMYYxij3kzVebraQerAtS6QR8AzzjrY0AgE5jjK?=
 =?us-ascii?Q?qlIkZDt9IbHDQzF1zq6TXvvIOyHMXPqkYeFSBOJjL4VdSwbRYFj/8tO9czSY?=
 =?us-ascii?Q?SXfVIQx3HzGgq6p4tLBVAC3NF7cikLIDO61A6XLww/4HGtOuF7lC15qKAZ62?=
 =?us-ascii?Q?lq/hwLLNVizPdoKA7fXLovO9Dlm5cv8x9M+Lmhw+3yP//G+wNRL3h/svkmDV?=
 =?us-ascii?Q?QcyoJxacXIoT9LxJ8XBNJC/L1MskZh603kS1smURav9XT54KHjUEL0wBjlGQ?=
 =?us-ascii?Q?KwsMgv4EvwNeKsH333BrKlEWJK+MFWXYnv7v1AhzSepEyL1rH48kPRyG/OPD?=
 =?us-ascii?Q?EXoufL4xqwgX+pHbByjSw76Tf9uFv1j++KmINr66rwvDKK8Wde1U/PvDAVRK?=
 =?us-ascii?Q?Rtd+QnbtzbcqKf1KMoTNsYmzLDbGKqoPDt3xI+uZN6HlD0ntWkhXDfb+P/MR?=
 =?us-ascii?Q?jheX6gpCtX+hVsCHOPBDu1up0JaXroh+x/LGbVXfQJus1rvHTkBU2XJ+bvGz?=
 =?us-ascii?Q?s51DBgHbga970YxhMCupmeBl6n4olJzwNCz/HM6j1jg+OQIo16eW/ggWrZS3?=
 =?us-ascii?Q?icDQOCdFnUiyOlbIh0GTed9muMnsMxzFmUuF5S3dZUB+y8od9FHv/vRwhHUs?=
 =?us-ascii?Q?yhmBv1Wd0orF6QWo0qQAQdyWbvli8UA2bsa1U9Xqa7Z23irmig/hhYLghHws?=
 =?us-ascii?Q?4eAdFjYPsnB7/WVzT7VET9t5bnC+My1REhr0PSVNd+PHbV+btx1Lwc74k6Kv?=
 =?us-ascii?Q?ppIqAH8y7C1VfVwhJHGxYGNGohj3irjxlgtsmfpfABcEOw5KZGmbzPqmsoCV?=
 =?us-ascii?Q?Rghhvg2lBQ91fXthw1K6CBTALfmWwOd/LA7LIwxIiHCpDaPsHnLSoru5OOSf?=
 =?us-ascii?Q?SBuHITH49Ond/EEHlkFwYG22h301a6gfZ/Ignqqx9GMTCZN0khf7Wt3eITdz?=
 =?us-ascii?Q?aXc+H1TgPowpX7iXnGtSbdlgZHBntcOujF9ayiqibzjrIT9gEF7gu+Dr7WGs?=
 =?us-ascii?Q?u0ipa3n+B1mW7bWmFMrpzVyl2M0UZx+nv9PuDaksFHYxU3mf0jPJICpqT7cm?=
 =?us-ascii?Q?1gWtKhurTp99qymRe3XhsXQQoA/dTAPvsYSd0WV6NM3MFGFzcSaQg5WSGBAa?=
 =?us-ascii?Q?jsKpdIuJhQRf4qS5ggcaswOohsUzmWkp5okT5ySt9pkSfPP7xJWsTM4TbgCR?=
 =?us-ascii?Q?UFyrGAijE7Rm7K6Ou4b8TJiKIDOrSpVPY+Kk8Yoz1injk9cdI0ZHv6geZ+aA?=
 =?us-ascii?Q?vPW39/RBforXxtZk+Tcz5XR9tIIQtSnF1+28twCJ6dEZbRAhXKNrWIMhhlaT?=
 =?us-ascii?Q?lQ1CNpideBJeR+DqWSm3l+V/QmhOKt24o0LvELS/HRICDvptwJqQI0Wa+KMN?=
 =?us-ascii?Q?NRmhrb+On3E2pZopm4eo6JWW/iDGDa73JkrALOnSzUPqqeXeYVVnvnZuQ8IH?=
 =?us-ascii?Q?6sRedgYm2oaY3NkX2aZprFARnMwKhfS9vAhuVoX6YaFUVXzSfsE7LHGwe2sf?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbce7fbe-f288-41ff-59da-08dd84d1826c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 14:49:12.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFHETtRU6dtN+VO7yffnbAVplaD5JlatzZh9mR8VLmL8VBWM/+PmrqUHgOerBTOKCwk+gsw4uxD7upUqyl68nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9019

Simplest setup to reproduce the issue: connect 2 ports of the
LS1028A-RDB together (eno0 with swp0) and run:

$ ip link set eno0 up && ip link set swp0 up
$ tc qdisc replace dev swp0 parent root handle 100 taprio num_tc 8 \
	queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 map 0 1 2 3 4 5 6 7 \
	base-time 0 sched-entry S 20 300000 sched-entry S 10 200000 \
	sched-entry S 20 300000 sched-entry S 48 200000 \
	sched-entry S 20 300000 sched-entry S 83 200000 \
	sched-entry S 40 300000 sched-entry S 00 200000 flags 2
$ ptp4l -i eno0 -f /etc/linuxptp/configs/gPTP.cfg -m &
$ ptp4l -i swp0 -f /etc/linuxptp/configs/gPTP.cfg -m

One will observe that the PTP state machine on swp0 starts
synchronizing, then it attempts to do a clock step, and after that, it
never fails to recover from the condition below.

ptp4l[82.427]: selected best master clock 00049f.fffe.05f627
ptp4l[82.428]: port 1 (swp0): MASTER to UNCALIBRATED on RS_SLAVE
ptp4l[83.252]: port 1 (swp0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
ptp4l[83.886]: rms 4537731277 max 9075462553 freq -18518 +/- 11467 delay   818 +/-   0
ptp4l[84.170]: timed out while polling for tx timestamp
ptp4l[84.171]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[84.172]: port 1 (swp0): send peer delay request failed
ptp4l[84.173]: port 1 (swp0): clearing fault immediately
ptp4l[84.269]: port 1 (swp0): SLAVE to LISTENING on INIT_COMPLETE
ptp4l[85.303]: timed out while polling for tx timestamp
ptp4l[84.171]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[84.172]: port 1 (swp0): send peer delay request failed
ptp4l[84.173]: port 1 (swp0): clearing fault immediately
ptp4l[84.269]: port 1 (swp0): SLAVE to LISTENING on INIT_COMPLETE
ptp4l[85.303]: timed out while polling for tx timestamp
ptp4l[85.304]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[85.305]: port 1 (swp0): send peer delay response failed
ptp4l[85.306]: port 1 (swp0): clearing fault immediately
ptp4l[86.304]: timed out while polling for tx timestamp

A hint is given by the non-zero statistics for dropped packets which
were expecting hardware TX timestamps:

$ ethtool --include-statistics -T swp0
(...)
Statistics:
  tx_pkts: 30
  tx_lost: 11
  tx_err: 0

We know that when PTP clock stepping takes place (from ocelot_ptp_settime64()
or from ocelot_ptp_adjtime()), vsc9959_tas_clock_adjust() is called.

Another interesting hint is that placing an early return in
vsc9959_tas_clock_adjust(), so as to neutralize this function, fixes the
issue and TX timestamps are no longer dropped.

The debugging function written by me and included below is intended to
read the GCL RAM, after the admin schedule became operational, through
the two status registers available for this purpose:
QSYS_GCL_STATUS_REG_1 and QSYS_GCL_STATUS_REG_2.

static void vsc9959_print_tas_gcl(struct ocelot *ocelot)
{
	u32 val, list_length, interval, gate_state;
	int i, err;

	err = read_poll_timeout(ocelot_read, val,
				!(val & QSYS_PARAM_STATUS_REG_8_CONFIG_PENDING),
				10, 100000, false, ocelot, QSYS_PARAM_STATUS_REG_8);
	if (err) {
		dev_err(ocelot->dev,
			"Failed to wait for TAS config pending bit to clear: %pe\n",
			ERR_PTR(err));
		return;
	}

	val = ocelot_read(ocelot, QSYS_PARAM_STATUS_REG_3);
	list_length = QSYS_PARAM_STATUS_REG_3_LIST_LENGTH_X(val);

	dev_info(ocelot->dev, "GCL length: %u\n", list_length);

	for (i = 0; i < list_length; i++) {
		ocelot_rmw(ocelot,
			   QSYS_GCL_STATUS_REG_1_GCL_ENTRY_NUM(i),
			   QSYS_GCL_STATUS_REG_1_GCL_ENTRY_NUM_M,
			   QSYS_GCL_STATUS_REG_1);
		interval = ocelot_read(ocelot, QSYS_GCL_STATUS_REG_2);
		val = ocelot_read(ocelot, QSYS_GCL_STATUS_REG_1);
		gate_state = QSYS_GCL_STATUS_REG_1_GATE_STATE_X(val);

		dev_info(ocelot->dev, "GCL entry %d: states 0x%x interval %u\n",
			 i, gate_state, interval);
	}
}

Calling it from two places: after the initial QSYS_TAS_PARAM_CFG_CTRL_CONFIG_CHANGE
performed by vsc9959_qos_port_tas_set(), and after the one done by
vsc9959_tas_clock_adjust(), I notice the following difference.

From the tc-taprio process context, where the schedule was initially
configured, the GCL looks like this:

mscc_felix 0000:00:00.5: GCL length: 8
mscc_felix 0000:00:00.5: GCL entry 0: states 0x20 interval 300000
mscc_felix 0000:00:00.5: GCL entry 1: states 0x10 interval 200000
mscc_felix 0000:00:00.5: GCL entry 2: states 0x20 interval 300000
mscc_felix 0000:00:00.5: GCL entry 3: states 0x48 interval 200000
mscc_felix 0000:00:00.5: GCL entry 4: states 0x20 interval 300000
mscc_felix 0000:00:00.5: GCL entry 5: states 0x83 interval 200000
mscc_felix 0000:00:00.5: GCL entry 6: states 0x40 interval 300000
mscc_felix 0000:00:00.5: GCL entry 7: states 0x0 interval 200000

But from the ptp4l clock stepping process context, when the
vsc9959_tas_clock_adjust() hook is called, the GCL RAM of the
operational schedule now looks like this:

mscc_felix 0000:00:00.5: GCL length: 8
mscc_felix 0000:00:00.5: GCL entry 0: states 0x0 interval 0
mscc_felix 0000:00:00.5: GCL entry 1: states 0x0 interval 0
mscc_felix 0000:00:00.5: GCL entry 2: states 0x0 interval 0
mscc_felix 0000:00:00.5: GCL entry 3: states 0x0 interval 0
mscc_felix 0000:00:00.5: GCL entry 4: states 0x0 interval 0
mscc_felix 0000:00:00.5: GCL entry 5: states 0x0 interval 0
mscc_felix 0000:00:00.5: GCL entry 6: states 0x0 interval 0
mscc_felix 0000:00:00.5: GCL entry 7: states 0x0 interval 0

I do not have a formal explanation, just experimental conclusions.
It appears that after triggering QSYS_TAS_PARAM_CFG_CTRL_CONFIG_CHANGE
for a port's TAS, the GCL entry RAM is updated anyway, despite what the
documentation claims: "Specify the time interval in
QSYS::GCL_CFG_REG_2.TIME_INTERVAL. This triggers the actual RAM
write with the gate state and the time interval for the entry number
specified". We don't touch that register (through vsc9959_tas_gcl_set())
from vsc9959_tas_clock_adjust(), yet the GCL RAM is updated anyway.

It seems to be updated with effectively stale memory, which in my
testing can hold a variety of things, including even pieces of the
previously applied schedule, for particular schedule lengths.

As such, in most circumstances it is very difficult to pinpoint this
issue, because the newly updated schedule would "behave strangely",
but ultimately might still pass traffic to some extent, due to some
gate entries still being present in the stale GCL entry RAM. It is easy
to miss.

With the particular schedule given at the beginning, the GCL RAM
"happens" to be reproducibly rewritten with all zeroes, and this is
consistent with what we see: when the time-aware shaper has gate entries
with all gates closed, traffic is dropped on TX, no wonder we can't
retrieve TX timestamps.

Rewriting the GCL entry RAM when reapplying the new base time fixes the
observed issue.

Fixes: 8670dc33f48b ("net: dsa: felix: update base time of time-aware shaper when adjusting PTP time")
Reported-by: Richie Pearn <richard.pearn@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 940f1b71226d..7b35d24c38d7 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1543,7 +1543,7 @@ static void vsc9959_tas_clock_adjust(struct ocelot *ocelot)
 	struct tc_taprio_qopt_offload *taprio;
 	struct ocelot_port *ocelot_port;
 	struct timespec64 base_ts;
-	int port;
+	int i, port;
 	u32 val;
 
 	mutex_lock(&ocelot->fwd_domain_lock);
@@ -1575,6 +1575,9 @@ static void vsc9959_tas_clock_adjust(struct ocelot *ocelot)
 			   QSYS_PARAM_CFG_REG_3_BASE_TIME_SEC_MSB_M,
 			   QSYS_PARAM_CFG_REG_3);
 
+		for (i = 0; i < taprio->num_entries; i++)
+			vsc9959_tas_gcl_set(ocelot, i, &taprio->entries[i]);
+
 		ocelot_rmw(ocelot, QSYS_TAS_PARAM_CFG_CTRL_CONFIG_CHANGE,
 			   QSYS_TAS_PARAM_CFG_CTRL_CONFIG_CHANGE,
 			   QSYS_TAS_PARAM_CFG_CTRL);
-- 
2.43.0


