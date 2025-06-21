Return-Path: <linux-kselftest+bounces-35563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96238AE2BBC
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5951885CED
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60FB27380A;
	Sat, 21 Jun 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="sGIRZEvo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A626FDAC;
	Sat, 21 Jun 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534692; cv=fail; b=KQmHkXc4xd9ahdJumi+woYmC4xyrIvVIW/rzbrAyO/tSpVDat5/Bj3L5BQI2jNIwgIXyxr+x2qqyZLZrTjlyMGiiLlQlCAkA3X7IfFH0r5m09u6ALhiUIJ6Qu4eCu7ie9f8HsgetxKIlY2z/gFKyUbT5qcMzMh8waBpj51QhYWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534692; c=relaxed/simple;
	bh=tAoIQmS+jzId2GDiEkPWpoWH4tUBog3+H+DlpW6QKLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JO28vW/H63nOyb7V2EgRUzbpicCDwOgCj91FTm5+qoJHxeCyCKgKQ4XCSob/+weeg26z4d9Ti7TagQqd4oeM8CuLme8pmvVVzZuuCZ/9s+NYOptFS/H0ahaN5AQZ/YfjWYomA7NICd1R2nSWwzIhF+C1HsIhLUfPscgTMRh1d0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=sGIRZEvo; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzyAes8GSKaNX9TPS4q/MGJ1VyV8WKNQmoINft8UKKCkdsmGjYLVOxwxDydesAoXafL8zwZ0I8ZVMU9pIWLS14YfYSEQywGpyygx+DRMp7MLMOUsVsyqTPeP63297kPgySjB8iXP4lQunDwhVs0THgopS+kpohIBduRN+q1jPNiRreFOEZLngRHb+Xau47H4CR9lk0PF4DVsC+x7pj87Sud9EVqenB+BhEmFoKArU0bJ6W42f2CmcR9SQM8mKSf5xRMkBibdCMly3z976/0Cics82F/QbxYRFc1Tk048FatFJk3xZEwaRfjLnnzgz0zzbwPDloaacMQLAWDd8qMo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJB27rbc11VycrzEBQ9Uk33DwopAtQ88geMSqc5nTC8=;
 b=dVqW1ldGUt7GpJCwSpywvJzhZ/CB1N8dI6xWDWSrR+CwU+gTm6HZXQz2MQetd34RqVf+q5772GSPBTYmJyFYR+DNWVxXG/ARVmpZdprsDPhmWJvO6nXjetlwI96eXgbPgUBk3IduukuO2PA/HgGb9E6mmLwBmZREaU0ucnAjjoq1xS3fyHjVWmqcIQNxO8o1oBESda1c+dIFuaeq9OGEslLqcPRdGN5Tczhporz1AEzmosjU7QYAcNqKAeZBrVUtftDRmq2wP5nmZG5Ljv9N1K2cw+5N8kYnIRZ8VNBZ4WyPiRcviZnEbP3AqEv5sqSgK3VPA5AdR0xYXz8YP1WNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJB27rbc11VycrzEBQ9Uk33DwopAtQ88geMSqc5nTC8=;
 b=sGIRZEvoF6pPaVe7xiph3Xnnt6KsiGs0nGUxzLNtkd+UXsf+zJjXg/YTm1Nz6GwOdqGRdcEfVaaRRRWowqgSiRQRGifQ2Dhf2WFzr5k9evUHE/d9WXJRCRxJ4cFquvenOO3pmTVwuVyxtvUQYnjpeeErUDM14lmMQenK3WRBleQvniRRagHgWs8Txux2KFHlns3vr+I75vz8Ca7sJ5V6fW7Xu6aIY7TRTpDBUSCtfghgisl7TC+aV6GtG4O1Lbew2Q8Z8BPFfq2pyxsg0UkKDS6u8GtOMSmFdQKSMooEzJRaZZHVb8KpexWqa8/rjbJGGvItkFD4P/qvCXjcBcKwGw==
Received: from DB8P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::26)
 by DBAPR07MB6520.eurprd07.prod.outlook.com (2603:10a6:10:178::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Sat, 21 Jun
 2025 19:38:08 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::a5) by DB8P191CA0016.outlook.office365.com
 (2603:10a6:10:130::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Sat, 21 Jun 2025 19:38:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5857B1C0031;
	Sat, 21 Jun 2025 22:38:06 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v9 net-next 13/15] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Sat, 21 Jun 2025 21:37:35 +0200
Message-Id: <20250621193737.16593-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B98:EE_|DBAPR07MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c86b271-251d-4404-f161-08ddb0fb2629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlJoQWI5TzQxVVpTanFGZHpqNmlDSktzd3pORUFZcUorVkxRU05MQkttdHhv?=
 =?utf-8?B?VDkvK1hrQ0xGSG1abWtxSzErVFFROVgxVmcrM2Q4UStDd2wvZzNsU2w5bzZk?=
 =?utf-8?B?ZHpEK3pXTkQrM1NXV3NGd2w3TlVmc3V1c3NYVTVmV3FENVBLYllrSlhVNVl5?=
 =?utf-8?B?M0pEWEcwVjdSSDMwZlRCOE55WDNWcjkxSmpMZEkzWE53SmNqL2U3ZU1NSFMr?=
 =?utf-8?B?cDR1TFFuWnBTYVlTeXYxVmhudWwxaFF1YTI4S25HWmJ5Nm0zNTB5a3ZIY3pn?=
 =?utf-8?B?THBtMVR0QmtHa1M3Tk4waHdxNmxQQWJGYVVnd1J3d3BJM3M0NVZQdDNVODVE?=
 =?utf-8?B?TkRkVDcxc0JmRjdGK3NVWUpnWmdRQ3F6a29qWGtSSU9iekg2Q3g3UlJ6ZHdV?=
 =?utf-8?B?elFka2xlV2RNVFBwaDUxOWtWcWI0TjE0UEhvcmgxU0xFc1FlVmN4VkpkeHdN?=
 =?utf-8?B?c1hqN2ZMNStuTk5DTnVTdVZsYmtSSGtqYm4ySDFqRll6OEhmK3RTbFB5MWEw?=
 =?utf-8?B?MFUveEFocFh5dVFuTW1KMUJMSk83bVROWU9iOExlYVh3V2thbDdJTDQxTUwr?=
 =?utf-8?B?L3Y0WFFJUHFQNTdLbmkrRjdCRFBJQWdOZjhOdkp5MEJ5S3dmazRPL0x0cElh?=
 =?utf-8?B?aklQYXk0dVhNZEdRMmU5ajFmSlJuKzZVWnVqOTJDSDExZnA3M1JWSWMvcm5H?=
 =?utf-8?B?Ti9jbjVWeERRMnVqNlMxVmhEQkVBRFhQem0zVDcxaUxVNzgxeXNZMTd2S0Vv?=
 =?utf-8?B?RWgzRVVBcHhuNGFMTGZ2UUNxQWtKOGRpcVRPVUU0QkJ4S1dKSFcvYXJLcVor?=
 =?utf-8?B?a0Y0WndZaGtjYmRibFJxUGFPWjNjOCtESlpIWXZONXlEMFVXRlBQVElZVFVJ?=
 =?utf-8?B?Q0FQclczNUFYSFhLd0d3Um0xYWMvejI5TmFzZ0JieXdXUFdlR0tNYUM5RjJs?=
 =?utf-8?B?elAwdXhOV2w5Rmd3dlY3NWtnRHpOTHUzeFZUcDBLOEYzMzhXMFJlRWs4dldL?=
 =?utf-8?B?VG9iSkh3YXV4N2JoSGhQQWZvanhvbmd6NS8ya2pQR0Z3aEpnOXRzalF6Z3dr?=
 =?utf-8?B?WFd5dlBGZWhEa3hwcnl6cFlXN1ZvTU5SOWpMWkgzS2lFYlhVcmh4Q1VFZ2ht?=
 =?utf-8?B?dVdPVVc0Vmc4eVFpV2krUFJKQjY5am1GLzNZWGkxWnpDMkZsc3I2U3U0UTBY?=
 =?utf-8?B?ZDVOYU1Ha2ZSMStxVlFteDNBMVBKWGp0WU1lWWZWdzY2UHFKVzNBRzRDanVC?=
 =?utf-8?B?OG9YNDRNdjJPUkZGaVl6TmJTQ0M5VGljWWpTemhaK2ZKLzZ4SmZ4cThDaG9i?=
 =?utf-8?B?YkpHRzNKS2dlcjlXUlI2SE1OVHM2RUcrOGdXNlVxdDl0UmlFS0M1Y0tlcXFM?=
 =?utf-8?B?SHdMVkxsUVVWMDVpM09DeGNveTdJQ2NHTkoyK3J3V2Nkc0I5ZDQ1MExtSjRj?=
 =?utf-8?B?SzRrOGNuZGVWOEpNeEh2Nk9CWFF6c3hmNTYvR0Fta2YyNWo0SVl0SDNnWGov?=
 =?utf-8?B?b01UVG5nay96KzVXY1NJVldSVGRJY2FMem05ZnRhL1ZXNVR6QU5KeGdrRkxO?=
 =?utf-8?B?Smx4dW5LMjFybENWMytTSlFSbGovMmZwb21JV2E4d3h6OUgyUldtQ2RhbzND?=
 =?utf-8?B?eEJITzl6U2g3Z2E1R1pwQjV6akM2dlczYTZHeWplaWppcmszbzNEUjBGdUZj?=
 =?utf-8?B?MFcwalUydEhkMzJ2TXNjM0lxa0tGZUNKcXNYaDdUd1UwTzVVREZaYkJ0Q0V6?=
 =?utf-8?B?Z2pXcGRSRHFzeTlGT1gvQ2k5bGtVTWh0M1N4WUp5YytCRm1CWGpnbEIvQ2VP?=
 =?utf-8?B?d2hvb3dVT2Ezc1RuTlhRMC81OUVZdStmdGd3dlRXYUNVY2NYblhjaEh6aExq?=
 =?utf-8?B?WUJ4SG1IK0g5Qk12L08xS0pUdUpZT2o4Q1lWdlVjWVdqdnNraHFqV1poQnpN?=
 =?utf-8?B?M1M1NDdGR0cwOXhnZDg2ZmRsVlk1WnZBM1ovRndsWW4zNllGeGFpbFY5KytH?=
 =?utf-8?B?a0V5d1l2aVRZSXNZbTZuL2tWQk1VaDdnMWFJTjdWTjk3ckxjbTkxTHBGUUJR?=
 =?utf-8?B?ZngwRXluc0t1bktSWFQ2d0loL0pleUZFQ2FVQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:38:07.9244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c86b271-251d-4404-f161-08ddb0fb2629
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6520

From: Ilpo Järvinen <ij@kernel.org>

Armed with ceb delta from option, delivered bytes, and
delivered packets it is possible to estimate how many times
ACE field wrapped.

This calculation is necessary only if more than one wrap
is possible. Without SACK, delivered bytes and packets are
not always trustworthy in which case TCP falls back to the
simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3f8cac22efda..97b5fe52d8fd 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -758,6 +758,24 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
 		if (!d_ceb)
 			return delta;
+
+		if ((delivered_pkts >= (TCP_ACCECN_CEP_ACE_MASK + 1) * 2) &&
+		    (tcp_is_sack(tp) ||
+		     ((1 << inet_csk(sk)->icsk_ca_state) &
+		      (TCPF_CA_Open | TCPF_CA_CWR)))) {
+			u32 est_d_cep;
+
+			if (delivered_bytes <= d_ceb)
+				return safe_delta;
+
+			est_d_cep = DIV_ROUND_UP_ULL((u64)d_ceb *
+						     delivered_pkts,
+						     delivered_bytes);
+			return min(safe_delta,
+				   delta +
+				   (est_d_cep & ~TCP_ACCECN_CEP_ACE_MASK));
+		}
+
 		if (d_ceb > delta * tp->mss_cache)
 			return safe_delta;
 		if (d_ceb <
-- 
2.34.1


