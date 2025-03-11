Return-Path: <linux-kselftest+bounces-28680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575EA5B206
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 01:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967FB171761
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 00:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A68BF8;
	Tue, 11 Mar 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="l93PiZfq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835085680;
	Tue, 11 Mar 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652143; cv=fail; b=f5O/8+aabgSHDBPVCPDsuUx9L8WtVGtFCKdp0g0wW16+4kU1OjJYnt6I9awlKfSstXKEOCQHJRcAf6ezzlOJyEZuhbLcTvcZrwcZyV+FjaK064rUUJJZFpQ/kAYNGd/pKAhjw9EMZ1wDmKPBo4ItCfa0XXOnaY+0ue2zD4suyew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652143; c=relaxed/simple;
	bh=q1l4v4tLZ44jjFcxhVSN+LvN4QtK47z/5t4mMQ/L+Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PN9LmAvGwczZdcWQojCy5A4d3Y6V7jS/gofWsdFb7PR9pmdVlYgIBSVrh8u6cTSO2eZfOyKx+M0jzH+P61JLxx8ZblKr8FjuB8ene1PYPIQGbsOMxjv02nHZ7AI2den/we/5mzcgAp+VTqkstN9kYry3Ry8jUQ9Coe/SpRb7CcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=l93PiZfq; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM+VzFXXrR0cofVKyudnGLpIBXXRKA2HzAk/IFo8Av3ZEruIfRQtqI8nmpq9CaUWikduaZEc+FKDajMZ/QesYvLk9ljH+IEF2sKmdTcgbyo9d4n15L95taUJDRB0jGKYMlYXKuav9YJwNVoRbeBBYs+lUn8F4AmOX8HNMUWw+/6YuNCz6uovXWRBBleMDA50Hhmiq94ZY7+eCqbZc5wLmdv4X0s79Ca20/Mb4yQ80Fob2kPH3cxCfC9r3DmINnzME8r754UaymVso5cDYc0ujT+pusV+4WkrCJUDDS+N5Dhsmbr8/7wwDknO04DPvNSv7vRe41BU1LpDxgg6c8WPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGU8rWoq76AaHPDzW9UmRY3h8h9HDaoeD+KHP1/yTI0=;
 b=KEq7BqWTkIadPtAcyr2NGXCWk+dDBIffSmRUClPp6CAeeP4YMluqBWvatt8R8FHPhTGFBIRrcUmCOC2l3ak8mBK4uSzAEHWWc0PVa4A13fOI0mr04ZSIr5fzZHN4d5QLk4n4KOzTrXA2Bx2njUUB8LEDHyXvVeG0og9S4sq3xFr4/lsRA2FgbtEBqAiYM24F2W/7bZoaSd8LcYXAWkuErOpHczQ1dDofR6iXI1XCe1nou+yggezlDQyzajKQR27RfpV895WchAsq47kEaZ4c293GpRCXBBOCo/7MiTaHIek/W0fP7bqLsYwiUOr8wejS0m1q/tVAoC5uCMESGBSWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGU8rWoq76AaHPDzW9UmRY3h8h9HDaoeD+KHP1/yTI0=;
 b=l93PiZfqby9IBE9s31Z66jrewfaUvxYe97bvwPb6BBYcr4fXOH3ZPef/wn+MuaAzsEIZvAE4CiRyBksx32GZ4be/xy82nuNy1cABziW8tNjoKukNpbZkJskgPErYt87TNIcMP6ItF7PqmfBKPB8SbkGKcFHHhPSPmzug5xbxYSaxq7fK6bWTkLK7kRGp/sJl0/TQl0vFOajKfgMkAZrYRs2p8rmspXA9i7/bSOxkxWrplYoXiyfevYZu43lilsev9eMEukeVcugPdXIGqV7T9/4LRFMEhq1fwssLXKBUCKtfkL15GUB1gtyUolOr9hKYOsTB4UpF66wvs7LreE9zXA==
Received: from FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:9d::7) by
 PAXPR07MB8603.eurprd07.prod.outlook.com (2603:10a6:102:23d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 00:15:35 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:d10:9d:cafe::1f) by FR2P281CA0117.outlook.office365.com
 (2603:10a6:d10:9d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Tue,
 11 Mar 2025 00:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 00:15:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52B0F9Go007427;
	Tue, 11 Mar 2025 00:15:10 GMT
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
Subject: [PATCH v8 net-next 0/3] DUALPI2 patch
Date: Tue, 11 Mar 2025 01:14:44 +0100
Message-Id: <20250311001447.114579-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|PAXPR07MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9823d8-bb6a-4f9e-ff70-08dd6031d81d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QWRBaUVoQ2l3RnR4ZnFFZGVjcmlMWlFBRmF4QnBBSlNZL3ZZcjRpQmgweEpN?=
 =?utf-8?B?UStqdVJrc0FVSEtOblFFMFdZMmRpSWNYa2lPeFVlQXNDSXZQc1d6dGNTeGlR?=
 =?utf-8?B?SG1BT3o2OVZwdVdyNmpvbnEvSEpNMWVEK0l6dlI2Y0hySlcvK0pGZFNPbTNl?=
 =?utf-8?B?eDJ5ZDYvc3BLVG1qSUFhalZsTm5uYnNvWmpOaTBuenpTNFJ5ZVBzeldKdmtV?=
 =?utf-8?B?TDcvNmUwVmtyU01WT3FpbVl1UldBNWpaSlp1UjlUeDV1NTBIVWxGcDd0U2Mx?=
 =?utf-8?B?clBucklnRllHL1JGYlpkekdWNzR5K2xXcENPODRnR1Z3T0dpK2FBYWlLYUFI?=
 =?utf-8?B?Y09MbGRoYnh5OHVFSnBuL2E3NXN3NGhpMGRrVmh1RmY1djNKSGlSdnRIVFFP?=
 =?utf-8?B?SDIxa0F6ZFh6ZmdYcUtSTlFZSTlZTkZhUVhBNTVDa2hCN3c0cDdSTytTWFVx?=
 =?utf-8?B?eTllWWx1Ym5KNTc3dUEyWFFLbGxjalMreHVrVkc2MS9LTUE0Q3F6QTlVRnVM?=
 =?utf-8?B?NXVxSHJ5VmR3WGRrTnByYWZUMk1LMlZoUW1Za3FERHBlaU15cFhVYkQzVmRP?=
 =?utf-8?B?bUY3dUVZMDE4OW8zN3Y0WGROL2cyNnFwbTA3VWM5djdOTjhwNlpQNnE2aUhx?=
 =?utf-8?B?TWx1K1dMcTlhR3BzUTJEdlplUXovcU5WV3JoMlJEYVZ6dG5UcGNJL1lYTVp0?=
 =?utf-8?B?eTdaRTk5YUxhZGtVVVRQNXh5UmR3TXZyejFJYXpodDl6b0ZiOGFMbVovMTlN?=
 =?utf-8?B?cCtKUmlCV0tXTFgwK21YbDQycTdPQ3VHV1ZsbUczZG5HKzFKSHNTT2crV01X?=
 =?utf-8?B?by9mNzFuM0JDS3ZMdUt3SHZBUFZoYWxzZHRJMnNYN3d5a1psbGdjRHB6TytI?=
 =?utf-8?B?QWsrVjQ2RzFBajRERGpoci84UTNSWmdxWXg4blJmdTdFa0ExcHRON3kwZlNK?=
 =?utf-8?B?amRHQWxycHlUejRXYmNHZEdPUlhYNlFNL1M0bDQyTTdRUTE3R2ozYVNRZVRF?=
 =?utf-8?B?QkJNQm0yNUs5KytzMWpGMlkxek9td3dtMlExUDIwS2pUSktjQnR0ZERnQTUv?=
 =?utf-8?B?R1djUVlQcXUyUG9LRmJ4aTNmc2NnMHJMdFJaakQrenczVlFhbjNlQW5zQjZ6?=
 =?utf-8?B?TnhnL1pnWVl5V1BhS2R5TWJpZHRSOWFKQWR3U1AwSUh3Q0VPMHVsRW9vcXF0?=
 =?utf-8?B?a3N0VXVEYUczSG1sM2J6OFVrVlFvQTJHbmQyaGxXcHhOZkZ5MDNEaXYyMWQ3?=
 =?utf-8?B?cyt3WWs0bXdJaXpFV09sR0RSOE94bmVkNGFhODlVUE5RZ0FGQ056aGxSZlNt?=
 =?utf-8?B?ZmJNRlJBdUNXelQzZVBHSkNKbzJ1Y1gxUlNGVXhzQ2s3bHkxR0dLdXpEK2Fy?=
 =?utf-8?B?dExmdW5MdERnc2R0V3N2RndGK0g1cUhEbzU3dW5yRUk3b2xkNmpmWEZjcEhM?=
 =?utf-8?B?T1EyQzJOL1c1cGU0QkhncUFVczZ0b053eDBsRFNyUSt4bzZsVm1tc2RDREl5?=
 =?utf-8?B?NC9qSkpNd3orUlJUUC9HeHgvbFJDTEZqVEYvcEZrR1Y0UG45SGRHUkZuRnJ0?=
 =?utf-8?B?bGJoYWJoQXZyL1dLR0lZT0w4UEk5VDFySDdNVWs2a3Fpa0NPcDl0anBUZEZW?=
 =?utf-8?B?NTdYN2ZpNTZIaitGcnVuYWs5YnJnZWxQODFkTG1sSi9wWmxCd0pvYkZ4eExM?=
 =?utf-8?B?c25leCtRZnlDZkNPakhnZkxEelFCdVZaSGNlbmJDdFA5MVowdTJaVkV6K1lX?=
 =?utf-8?B?Rmc4TUpoQ2U2MDN5NXNPWEYxb2w4NTFYSVpOUnhSNlV2dGZCdEVPazFuWFRm?=
 =?utf-8?B?TzBvZ20vRlMwdE1QTTlhYWFGT2IwSm4yVE9CZjZ2YTZYWGE5UWp0ZmpieDVE?=
 =?utf-8?B?WlFSeHFuUGlpQ0NVSEdYeGZycmN2SVA2bXNkNk5IaGkzM0w3UXJoMEpYa0oy?=
 =?utf-8?Q?mTQJ85CK7GmOCfOMLd9rwq6brKzId69X?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 00:15:35.1205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9823d8-bb6a-4f9e-ff70-08dd6031d81d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8603

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 patch v8.

v8
- Fix warning messages in v7

v7
- Separate into 3 patches to avoid mixing changes of documentation, selftest, and code. (Cong Wang <xiyou.wangcong@gmail.com>)

v6
- Add modprobe for dulapi2 in tc-testing script tc-testing/tdc.sh (Jakub Kicinski <kuba@kernel.org>)
- Update test cases in dualpi2.json
- Update commit message

v5
- A comparison was done between MQ + DUALPI2, MQ + FQ_PIE, MQ + FQ_CODEL:
  Unshaped 1gigE with 4 download streams test:
   - Summary of tcp_4down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP :       1.19     1.34 ms          349
      TCP download avg :   235.42      N/A Mbits/s     349
      TCP download sum :   941.68      N/A Mbits/s     349
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349
  
   - Summary of tcp_4down run 'MQ + FQ_PIE'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.21     1.37 ms          350
      TCP download avg :   235.42      N/A Mbits/s     350
      TCP download sum :   941.61     N/A Mbits/s      350
      TCP download::1  :   232.54  233.13 Mbits/s      350
      TCP download::2  :   232.52  232.80 Mbits/s      350
      TCP download::3  :   233.14  233.78 Mbits/s      350
      TCP download::4  :   243.41  241.48 Mbits/s      350
  
   - Summary of tcp_4down run 'MQ + DUALPI2'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.19     1.34 ms          349
      TCP download avg :   235.42      N/A Mbits/s     349
      TCP download sum :   941.68      N/A Mbits/s     349
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349
  
  
  Unshaped 1gigE with 128 download streams test:
   - Summary of tcp_128down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350
  
   - Summary of tcp_128down run 'MQ + FQ_PIE':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350
  
   - Summary of tcp_128down run 'MQ + DUALPI2':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350
  
  
  Unshaped 10gigE with 4 download streams test:
   - Summary of tcp_4down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP :       0.22     0.23 ms          350
      TCP download avg :  2354.08      N/A Mbits/s     350
      TCP download sum :  9416.31      N/A Mbits/s     350
      TCP download::1  :  2353.65  2352.81 Mbits/s     350
      TCP download::2  :  2354.54  2354.21 Mbits/s     350
      TCP download::3  :  2353.56  2353.78 Mbits/s     350
      TCP download::4  :  2354.56  2354.45 Mbits/s     350
  
  - Summary of tcp_4down run 'MQ + FQ_PIE':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.20     0.19 ms          350
      TCP download avg :  2354.76      N/A Mbits/s     350
      TCP download sum :  9419.04      N/A Mbits/s     350
      TCP download::1  :  2354.77  2353.89 Mbits/s     350
      TCP download::2  :  2353.41  2354.29 Mbits/s     350
      TCP download::3  :  2356.18  2354.19 Mbits/s     350
      TCP download::4  :  2354.68  2353.15 Mbits/s     350
  
   - Summary of tcp_4down run 'MQ + DUALPI2':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.24     0.24 ms          350
      TCP download avg :  2354.11      N/A Mbits/s     350
      TCP download sum :  9416.43      N/A Mbits/s     350
      TCP download::1  :  2354.75  2353.93 Mbits/s     350
      TCP download::2  :  2353.15  2353.75 Mbits/s     350
      TCP download::3  :  2353.49  2353.72 Mbits/s     350
      TCP download::4  :  2355.04  2353.73 Mbits/s     350
  
  
  Unshaped 10gigE with 128 download streams test:
   - Summary of tcp_128down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP   :     7.57     8.69 ms          350
      TCP download avg :    73.97      N/A Mbits/s     350
      TCP download sum :  9467.82      N/A Mbits/s     350
  
   - Summary of tcp_128down run 'MQ + FQ_PIE':
                             avg       median       # data pts
      Ping (ms) ICMP   :     7.82     8.91 ms          350
      TCP download avg :    73.97      N/A Mbits/s     350
      TCP download sum :  9468.42      N/A Mbits/s     350
  
   - Summary of tcp_128down run 'MQ + DUALPI2':
                             avg       median       # data pts
      Ping (ms) ICMP   :     6.87     7.93 ms          350
      TCP download avg :    73.95      N/A Mbits/s     350
      TCP download sum :  9465.87      N/A Mbits/s     350
  
   From the results shown above, we see small differences between combinations.
- Update commit message to include results of no_split_gso and split_gso (Dave Taht <dave.taht@gmail.com> and Paolo Abeni <pabeni@redhat.com>)
- Add memlimit in dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update note in sch_dualpi2.c related to BBRv3 status (Dave Taht <dave.taht@gmail.com>)
- Update license identifier (Dave Taht <dave.taht@gmail.com>)
- Add selftest in tools/testing/selftests/tc-testing (Cong Wang <xiyou.wangcong@gmail.com>)
- Use netlink policies for parameter checks (Jamal Hadi Salim <jhs@mojatatu.com>)
- Modify texts & fix typos in Documentation/netlink/specs/tc.yaml (Dave Taht <dave.taht@gmail.com>)
- Add dscsriptions of packet counter statistics and reset function of sch_dualpi2.c
- Fix step_thresh in packets
- Update code comments in sch_dualpi2.c

v4
- Update statement in Kconfig for DualPI2 (Stephen Hemminger <stephen@networkplumber.org>)
- Put a blank line after #define in sch_dualpi2.c (Stephen Hemminger <stephen@networkplumber.org>)
- Fix line length warning

v3
- Fix compilaiton error
- Update Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)

v2
- Add Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)
- Use dualpi2 instead of skb prefix (Jamal Hadi Salim <jhs@mojatatu.com>)
- Replace nla_parse_nested_deprecated with nla_parse_nested (Jamal Hadi Salim <jhs@mojatatu.com>)
- Fix line length warning

For more details of DualPI2, plesae refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

Best regards,
Chia-Yu

Chia-Yu Chang (2):
  Documentation: netlink: specs: tc: Add DualPI2 specification
  selftests/tc-testing: Add selftests for qdisc DualPI2

Koen De Schepper (1):
  sched: Add dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml           |  140 +++
 include/linux/netdevice.h                     |    1 +
 include/uapi/linux/pkt_sched.h                |   38 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1082 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  149 +++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1425 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


