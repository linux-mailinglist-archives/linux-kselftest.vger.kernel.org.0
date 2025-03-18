Return-Path: <linux-kselftest+bounces-29287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C7AA663A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8D43A79A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8150917BD6;
	Tue, 18 Mar 2025 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LVTjS1KZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A917E0;
	Tue, 18 Mar 2025 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257671; cv=fail; b=uy0FzY71DWi2FMLuw/2JfD9bDqJzSC4oeWmq0aCq+aHe7nMYV+salvbrH4le0IwcvzdFv/y6z8EHuJ3tycBEhecNTQtJi9jobEV/njXT0aPR5dCOmiveBnOPrwufuU1YRkQgy0ixXPHk7xfG5qCJja/hI/5tF3ilfdBM3fF74w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257671; c=relaxed/simple;
	bh=2kXaDXBbKJMW1K/UL2RSn4wkHQ6USq1U9ttL3ktkywM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M5A/6cl4ReHvbqtWH7ZC3Nilkvbp+XZnGiN3e+p9Nyp+kuiUiY8iJ5RoEb7FldnNsBFHMim42KexwE3U9zM+G6uj0qlf2TPMsTjIkUKPBsKKryj9iB72BaA+8NdyiUkBYQpuhASQnMXUtqVEwXT8/83/hyfHCFOIBl1nySF5vPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LVTjS1KZ; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExQwumlB5edtB/dyBU19Xt7O6TpzWTLwdOwliBsgAjFdu084YCrXJdzcFolXVcqqbzME6+v1yocUNUm2qKfhVJJ84gDqtHkHhBy4iz4o9rjO//1LhheDtYyfbmHPUpwf1NmT220LtJR6+LqWYfPzg/0gszZ+3aD1s1tAlBsKRgnF+AlBc7OqJ+IXjakVRs93jyHKshil1Acfu3QfMt4culMq4Y8KscVk1bB65oT7krBmdoBChkhXXlC7Tjy95SbqYEUYIH9gt+u7tC2ZKAeRVm7SofXSb8amJ4Vh7c9p+fYgF1x/qkyhV7yzW7C0KsG+MVpLjPZnHEY3iANjQGyyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4TxGCeI8pg6rv2rryNI+9uypAFjBmRKwqX1EoeBFVk=;
 b=VrOCjzDo+aTOCHdDXfcNeBsUyWBdPLy8Y12JKkgn29Ed0D7/v5F3Kvz3z5Wo2lnk6vzXpCKZv4TAdCIGB/iGl1y8wXgd6kh1dSSqs/jIr4XZ5Rn/BMrN1z82BiI068AW1D5+bLxXFJJk0Jb00NBfvX9QmLvYtQlveV6qoKQ0ZmpVLEhHV0KDe4OQB5JwMpPQnvswbDemi2CjN8ecT3fDILa/B/2h8BRpKftIVsDIPPBnHPLBxVEtuPN7XRzped9rU+7/8qH+oxGWLxcsF2bOlap5T31HRIHLNwv4ZvQjcJ/8upvebAIUl95+3nN4ls8m0kcgLXD61KwFqm2nW2nWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4TxGCeI8pg6rv2rryNI+9uypAFjBmRKwqX1EoeBFVk=;
 b=LVTjS1KZx1V2OgcRboCk5pcj01nycrrOX8o8XbOzcCBBXxVTe5pPnLEbE0pSryle08GHBdUMfExGFT57PJH0rb1UKbt+2NteIcAi87jM3Ng1MC+GBSd9w3BMiCILoGINx4GZCVK8vh3zAk/zsWy5cLxdKtA0/Z1ebgGv/tmbpcCAwMSxVSgMVBiTP7hT461lJHMMROM6N3WTYig7B7HKBqQFGCc7zdDGZNDKO0Oo5zplrp28Cyq3GFU3z25D5m9TZX3Ctg/0pqUDXukYRlY3J+jN7hrAf1Hq4jZpI9Whr7Hy3tWLSJcMI8VxAAM/X2s9QbGqQ0o4U0Z1LF1KuVd7Dw==
Received: from DB8PR03CA0016.eurprd03.prod.outlook.com (2603:10a6:10:be::29)
 by DB9PR07MB9152.eurprd07.prod.outlook.com (2603:10a6:10:3d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:27:45 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::ac) by DB8PR03CA0016.outlook.office365.com
 (2603:10a6:10:be::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:27:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBg024935;
	Tue, 18 Mar 2025 00:27:23 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 00/15] AccECN protocol patch series
Date: Tue, 18 Mar 2025 01:26:55 +0100
Message-Id: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|DB9PR07MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8da9d8-f1e0-4a85-575b-08dd65b3b3de
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bWVoOXB6NDhhRzlseWNuVk9PdS9rdEZZNXFBTnd3eXBlWFZmQ2ViZjZNMHZC?=
 =?utf-8?B?aUJwMVp6VUVhUUZkbS9NMzFLQURHZmVvRmcyWFBhWjZHdklLR0g2NkdUTS9i?=
 =?utf-8?B?azhZN3VyTS9lQWlNOVlJSFR2SHZJOVA1TzNVNjg1S3dWWnJ0MktnSXdaTExW?=
 =?utf-8?B?TnhIWThYYk0wZkJ1TnBtVnhZQ0xQSmZzejAzanNUcGdVOEpLdHk4SVZ3czF0?=
 =?utf-8?B?MHA3SEFpT1JUT2hueWFiS2hDUldCaVJ2Q1gyZmhuNGc4Z3NEcTYzUERML2xi?=
 =?utf-8?B?NGIwaFpTbmpGZ1BoSGFSQzRMWXN4akxpQzMrMmxGWVpDN3FMdFJKK25hVFUx?=
 =?utf-8?B?eEhxRW40VnNaR2tjSlJ0eG9RTDhZOVNRWEJEL1d5N1I0ZFo2V24ybW1pL1Fy?=
 =?utf-8?B?MmtLVXZhaHdtMXZYZGRIc0tucXVXVFRqdmdnaWl5bDZQUnhncG4vMlROZ0Zr?=
 =?utf-8?B?ajArQjU5OWw2bkI1c0tBd0I0QVdBU053NVE2T3FUbjIxTmtoTUQ3T1lJZVJ3?=
 =?utf-8?B?TTQxYkQ1bjM1YmZabFRwL2JuVmI3ZW9zM2lodW9IQVRjczVrbHlERjE5d2Zm?=
 =?utf-8?B?U2VUWlBJWng1c1JqM1ZMNjg1NXVvRk5Uc1l1TDNLSXcxMTNVNHRHSGRpdHN2?=
 =?utf-8?B?eGNBQVdDZnlWZ3I3U1E2QkZMK3Bpb0piOXR3cmF3OGxlOTB1cUV3M1lYcEMz?=
 =?utf-8?B?RlNkV0FyZjJod1RDcGoyR3JSMCsvcllQT2s5S04xUkxHS0hTbVh3amx4ME5Y?=
 =?utf-8?B?bjhIQU4zQXpzeGZ4MW5rVkQwOTRyMnpNYVlpcS95ck5mZFZreVRhS2Rqc2xz?=
 =?utf-8?B?Uzl1M3RFRzZxMVFoM2t4WEpDUlBXQlFZN3FhQ2NweFpzcDFKUG1mY3hiL1VN?=
 =?utf-8?B?R2ZYb2QycHFISGQyQWx5T2N3WHdLVFk5RE1YTGYvelNYTE5zTXMzczNPR1JH?=
 =?utf-8?B?K0txekNxMWRQNHVUNjVOSmtzUy9NM2VEM25ZOXo3WUN0RXNnZm0zam1kSG14?=
 =?utf-8?B?ZldKSEV1dDY3UnQ5enAxaXhrUUZRa1ZBUUZOY1VwUGt5aGZrUzRWR3BsY0d5?=
 =?utf-8?B?Mzl2WUt1ZW5yaUJOTlpqY0k4TTFDaFRvUTN1akV3QU0vaDJyZzdFSk44QWla?=
 =?utf-8?B?WFllUm5DMnl4R0JUT0svdEpJNlJpa2w1dllKakR2YzJ5ZWNLdzFYWStVMHB4?=
 =?utf-8?B?NEJOOXYwck9tdGlMdVpHZnJyK1NDL0pvUXY1L0I5NVdIeUlBREQ4bW5aMHYv?=
 =?utf-8?B?STdRd044L3pNc08zSyszcWhRemtTR3VkQk1PMjlhWUh3ckRMR04yUUZJU3hS?=
 =?utf-8?B?Q1MvLzIzelg3ZFRGZjk3cUJPRTF3NXVUODlzWUpNM1hxTVJpZHgwQ1lzUTlz?=
 =?utf-8?B?Zk1KS1NKcnBjTGJUdG9LdGpKcEVXejF0R2NZMmNiSWxPSElHc2o3MGUzejNM?=
 =?utf-8?B?eUh6K2Y4cDBmNVRRdWticTMwcVJKYjAyYkRCQTN6SUNKTENMUGErNHBhWVlY?=
 =?utf-8?B?Rlg5Mk40aWtDTnJDWjhta3o2cHg5N1V2a3V3U25EZTRTbnFkQ2UyaEZPcTZJ?=
 =?utf-8?B?VnhMQ3c5dUZZZzlOVlNZUWlsK1pzVjFYL0dSK2JYaWxwQ1dsVXdTeFd5NkRD?=
 =?utf-8?B?SUV5alh1WkYvNms3TWR0SFRDL0s1dkZUQ1VnVHNWNkNXWVZBL2dvYWNFQ3FG?=
 =?utf-8?B?cTdSWTFJWWpESFZMQWdKb2ZaRWIzcHZkdTlLZmZGTXorM05ERzhuWER3eTV1?=
 =?utf-8?B?d0R3N25kNVdibWlST2xhNUJjZnBudm5RY1c0RTZ2NjRpckp2SHI1akRSWFcz?=
 =?utf-8?B?RFd2a0piS1dPT0N4d3VmNm9HUk4zMHpQRENmbXcxOUIzU1ZWbXRJd1ovTlJU?=
 =?utf-8?B?YVFPZWRobDU3eTJDWVh0blRNNjR6c3prcTNKMDQ2ZmVac1J5ejBFTDZvZ2Fz?=
 =?utf-8?B?SkltUEtTUjdhbGJURzNGUGNEaUNaM05zbHdXU2NmMVErU2k4U2h2NXZiWDI1?=
 =?utf-8?B?WkdrZ0ljeEZBQ2VxbkhOQmhTWUMxR2xDaTlaUHlVM0F5SGUyUDdVdmZhMzFr?=
 =?utf-8?Q?qlxW/y?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:27:44.6629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8da9d8-f1e0-4a85-575b-08dd65b3b3de
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9152

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plese find v2:

v2 (18-03-2025)
- Add one missing patch from previous AccECN protocol preparation patch series to this patch series

The full patch series can be found in
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

Best regards,
Chia-Yu

Chia-Yu Chang (1):
  tcp: accecn: AccECN option failure handling

Ilpo Järvinen (14):
  tcp: fast path functions later
  tcp: AccECN core
  tcp: accecn: AccECN negotiation
  tcp: accecn: add AccECN rx byte counters
  tcp: accecn: AccECN needs to know delivered bytes
  tcp: allow embedding leftover into option padding
  tcp: sack option handling improvements
  tcp: accecn: AccECN option
  tcp: accecn: AccECN option send control
  tcp: accecn: AccECN option ceb/cep heuristic
  tcp: accecn: AccECN ACE field multi-wrap heuristic
  tcp: accecn: try to fit AccECN option with SACK
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN

 include/linux/tcp.h        |  27 +-
 include/net/netns/ipv4.h   |   2 +
 include/net/tcp.h          | 198 +++++++++++--
 include/uapi/linux/tcp.h   |   7 +
 net/ipv4/syncookies.c      |   3 +
 net/ipv4/sysctl_net_ipv4.c |  19 ++
 net/ipv4/tcp.c             |  26 +-
 net/ipv4/tcp_input.c       | 591 +++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_ipv4.c        |   5 +-
 net/ipv4/tcp_minisocks.c   |  92 +++++-
 net/ipv4/tcp_offload.c     |   3 +-
 net/ipv4/tcp_output.c      | 299 +++++++++++++++++--
 net/ipv6/syncookies.c      |   1 +
 net/ipv6/tcp_ipv6.c        |   1 +
 14 files changed, 1177 insertions(+), 97 deletions(-)

-- 
2.34.1


