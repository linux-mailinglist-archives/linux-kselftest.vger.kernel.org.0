Return-Path: <linux-kselftest+bounces-30869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9A6A89E74
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 14:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C267F3BE5D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0862949F8;
	Tue, 15 Apr 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="sxou5QqI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DA2957BD;
	Tue, 15 Apr 2025 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721057; cv=fail; b=GpSF6zLkFB2Iyh0W8h/s9w8AT9A6imUnAoxQLhCokL1+aF9dgNMOIaWl4XNqPy7XlbvcO63m9ZQwcG3u3mktFHqB4kZVovIqmwySzEPD+1Vj3A6BEuLIVAF5nBu8q9I0cM11j+zWGv2beEuXplfAA+CMauWKvEBIk5NJYg6Lb3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721057; c=relaxed/simple;
	bh=skgtMvZ+fSByPn+9wX1a8pyy76i4yBBKfSzxPwpVPtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrcRr8trmD4GEm46W7JJJEZQL4IVwRWuifGjHeFnixeNySBhXbQzxfIw37uTFQIZLt8cX+emjHBihFJ46ohM1Jaz/N6SvSbzwh2MDhdfFSJA8tYesRsvqx4WuWC/2ws6ldysfubBnw9Hg6bk3pnrfZ937ktH2nASYT3SWRquPcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=sxou5QqI; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgiy8jN5rb1ysHMEetRIKglMTaGGDCdL4wQhaAeGLlW7CXCmOqajTR+QZvRO3akzf43ZSehlVy783XC9eNQA7oyEUSBp9AG1zW+MYjOCg1CgZpbi7piHoamjoYEFRh0Oz+w3m4ZzumWrOw1BN+gFcLXQ5fh11Srshe/DsBuW1VPmVjNAECZN3+DBZPnE5Gv5VmChrWKf8hNYmrnyS5oXj7wmBMe9NVBko82iEtXGdm5KRaPNZXvip/q4lcgE273A5wcTlWjprgCtmYMah6ai6LCp9MTmu7XuQgyYCK22hkp0cTOJ10x2SgAsL/+SSyEl9CTpKrGqdc8+9roxhGu9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGtju3jWs5pUyzUPQRhd6MQriiCgP+Lbpgem4BhWBGw=;
 b=HzFTuGsEQZs3Lb0NhU5ltyv/pLDj6Y/AIjaxI7BHTkArlYUVMD88FWUxaXTaUqYb6apAjrFwoRda9rKSFOswlqR9ujcPQIJpuGknAfKCZOBcg0fL/K9WJzv7dXoPKA058hapampdifbCcSpKcTHQndUUytq28j3o22Opx9Zc0UMeTZJgNnhHCiuTKO8C7iKt/XohlIuJjQ116fsh9QcVPVC7ydaLQS1wsZa57ZXUYu99kCou1dbx/9nEL/2aIeFL+V5kWCHTJh3KBhMddQwyvpzRRFsIY/QY1wAUuijCixKSlqVGTVAy9sGNhQ27DLsFI9MyJDmpc0331o/IeJYk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGtju3jWs5pUyzUPQRhd6MQriiCgP+Lbpgem4BhWBGw=;
 b=sxou5QqIg2F3eiCBjWgfQLu3xWDExTVTlDG3hrAWFGyJ/L8O5tE1MrqDRQxoL4HQaAM8gArny4S5XX7OUYeFcq+1nSsHtdPLQUbDMbh9nw/BQp/sl1LM9TZACpGf5fp/CRDhdxcnUNwOYkByBilDt0yOThfYavz95ZxzWbjTpuRPbB6jgO8LTzvOAxVJo37jmOz3ntSUESOYdF/XO9p7RiQUJgNjnpvFSfcc0MDFp5c0pqRfVFATubsAl5o4nzs420EG2fwkno+4x4/qMP74GKFzMIhmXU625h8D5jGDT9jtYf/+9v812ocPi9n+fu+b/ToN7e12JcYKicZTIpOQZg==
Received: from AS4P250CA0010.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::7)
 by PAXPR07MB8471.eurprd07.prod.outlook.com (2603:10a6:102:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 12:44:07 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:5df:cafe::8f) by AS4P250CA0010.outlook.office365.com
 (2603:10a6:20b:5df::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 12:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:44:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53FChgEi013987;
	Tue, 15 Apr 2025 12:44:21 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
        pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
        stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
        Olivier Tilmans <olivier.tilmans@nokia.com>,
        Henrik Steen <henrist@henrist.net>,
        Bob Briscoe <research@bobbriscoe.net>,
        Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v11 net-next 5/5] sched: Add enqueue/dequeue of dualpi2 qdisc
Date: Tue, 15 Apr 2025 14:43:17 +0200
Message-Id: <20250415124317.11561-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|PAXPR07MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: db01a585-2ec3-4966-8833-08dd7c1b35c2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?c2ZHTDBua1lYRm1vMHpoaEt0d0twaU9RTEg1ZGxjNWVuVFdFaFcySWFiOWl3?=
 =?utf-8?B?eE81QVpkbWgzamJWc1BqYUsvK2JRMzBLTGxJZk4vQUxVTUtES3Z6dVk5YmRE?=
 =?utf-8?B?MjIwc1JkdlAvQUNPRU95VytPYWh2eXpVeUFoQ2lBcldickF2aEdTemhtSFo5?=
 =?utf-8?B?RmpmTSt6V1NTcFZ1Q2ZSTUdYWFJndURHM2U1NmFTdEhrSnZDREFEK25Ia01m?=
 =?utf-8?B?QmlGSWp1OFJPOENhZDJObElmckpJWVVBcUdkZk5wZG9hOTVnZ25vOXZFSllP?=
 =?utf-8?B?M1dEbHJTbndtRU0yV281UzRHOHdzY3RVbi9BTWlWWjZXMTBKUTB6MHZ0WlAw?=
 =?utf-8?B?eFBLMjVrUWtPajArdEJyMzJ4NHY2ZGxzNUE1MndJa0QxVElhbzNlK25FL2JM?=
 =?utf-8?B?ODFGZytuRFp2Rml0ejZ3c1VLMGkxY2p6d2lkaTVsb3pNelZLUFlZWmMxb29W?=
 =?utf-8?B?ZmlRKzlvUWVHenozM0NBYkp6Q3phSHNsR1BBUUNDVndGQ2VoMVRSZXRZUUND?=
 =?utf-8?B?L3hPeWJYQzNKOHRQNHFjdFd5Z2xaRUJDQzBpODUzRGFmdDB5TmFLU1gzOXJm?=
 =?utf-8?B?OURlbTJRdE5Qem12cnlSMDBDWDlyYlQ3ZmplRkJPZVZiU0MybkkxOXZxRUcv?=
 =?utf-8?B?QXVnTUFLdzhNM3QreDVSVEduVWpRZ0FxQU5qeEJBT2JmejJJNjl2eUwyV3V1?=
 =?utf-8?B?QVlNckZPV3RWYWp0cVRodXB6QmVyRXdQRnVmTWVrK05aY2tyWWN2eGlCSURC?=
 =?utf-8?B?d1FZOWY5N1dVL0UwV3g2WnRmK3J2TnRTUUxMRTJZdjg2VjIyRGNIWS9PejQ0?=
 =?utf-8?B?Wi80NXBMa25QSmdyR0JBSEpzbVhONjcxZFF6eFg5Wkt0RlIyS3QxSithQk9T?=
 =?utf-8?B?K1JSSHpoRUI0QVNrMHJHTU9DUng3aXB3NVpaNVJCTjZMUXJiUTBhMWZyWEFJ?=
 =?utf-8?B?K1l1c09ZZkQzUHUzdkdLZWpSYkc4ejlyREFwTk9xRml6a1BSbzJaSzJ2K3VU?=
 =?utf-8?B?bXpwYi85a3cwUzJxVUtHTG5HcFNaNzVsWHluaWxhRDIzUzhDR1I2dmVoTEtQ?=
 =?utf-8?B?SEVsS2xza2ZzZmpRMWROaE0xenVoRmdpbzBjQXYwNzJqREZmUU5uZk5vQk1H?=
 =?utf-8?B?SmtaN05CcVBIZElBUlNvcWJSQU1YZ0JDYkw5V29XVEdlbXB5QitwcjN2WUJs?=
 =?utf-8?B?WkhvcmJBaENncDBra1BoMjJ6TEtxUkRtN1g4cUhkNlYyWFFNbUdqdHZ6dDdT?=
 =?utf-8?B?Y3YwMzl2bXRucmVwbmRoWmFLTmQ0MCsyYWcrU3FYQUhKSlR3aldGRGMyU2s3?=
 =?utf-8?B?SGxXQzBsU29uZEJmQndHSDN6dzlaQmMyOEliQTVnaFI1a2ViVWNoSlM2ZktC?=
 =?utf-8?B?d1BKM1VHa2p4bHI1YWhMVUhUQTZXSk8vNE83K1U1L0R4dDljOGszVmgydnkw?=
 =?utf-8?B?K0pWV2dtY3p0ejU1VWdYRHJjVGx6ZXM1b0VUVTNUNlhTM2EvblN3aE9SQkZZ?=
 =?utf-8?B?RW9Db3JQRzd0TFlUaUNCaVdNZFg2UEVGbkZIY3M4MUF2VndNWmtXTy9JSFFl?=
 =?utf-8?B?T0huM1ZJVUM0dXYwVmh2bkxoSGVINzQ1T3AyRnc1MTM0alNKekdkVUM3Ynk1?=
 =?utf-8?B?N0dic2pMc0c3dG91UlcwaTJEV2hTNHN2ako2dHBPWTArSldLaEZ1aFp5Yyta?=
 =?utf-8?B?dUpheFlWelpaQnFkQU51Zmp0cjRyaWFIMTk1MG01Mncwcmx3c2pyeDB4R28y?=
 =?utf-8?B?L2E0Yjdhdmx1T2crclZEaE00U3VCMHNmWEtwY0c3TUI4ZTRQVVlIWmxwU3hM?=
 =?utf-8?B?UkdaNHNhaUxhUVVUV1EzZk5qeER2MkRudjAybTNRTjlnVlJvNXlLQ0EvcWw1?=
 =?utf-8?B?QU5BZFBabU5CSTY5b2NScTl3ditVcFRlWDlnYng2RlVPTHJHMFpjdTloOHdG?=
 =?utf-8?B?SkhtQWh4c2U1T0JHck5WUHg1a3BpSEpvWEtKVzVYTUF1Mk5ibXIvRCt6MjFH?=
 =?utf-8?B?VlFWK0YydFdya0FpUUNtTU96TmFGMk03NGpEUVYvZ0VjbFNRUFpGdms3ZHdP?=
 =?utf-8?B?MlFnbTUxZDlhY2p4eWlvWlRHOW0zeCswQmRRRjlVUjJOb083OE5EV1RndmRx?=
 =?utf-8?Q?aJyU=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:44:06.2974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db01a585-2ec3-4966-8833-08dd7c1b35c2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8471

From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>

DualPI2 provides L4S-type low latency & loss to traffic that uses a
scalable congestion controller (e.g. TCP-Prague, DCTCP) without
degrading the performance of 'classic' traffic (e.g. Reno,
Cubic etc.). It is to be the reference implementation of IETF RFC9332
DualQ Coupled AQM (https://datatracker.ietf.org/doc/html/rfc9332).

Note that creating two independent queues cannot meet the goal of
DualPI2 mentioned in RFC9332: "...to preserve fairness between
ECN-capable and non-ECN-capable traffic." Further, it could even
lead to starvation of Classic traffic, which is also inconsistent
with the requirements in RFC9332: "...although priority MUST be
bounded in order not to starve Classic traffic." DualPI2 is
designed to maintain approximate per-flow fairness on L-queue and
C-queue by forming a single qdisc using the coupling factor and
scheduler between two queues.

The qdisc provides two queues called low latency and classic. It
classifies packets based on the ECN field in the IP headers. By
default it directs non-ECN and ECT(0) into the classic queue and
ECT(1) and CE into the low latency queue, as per the IETF spec.

Each queue runs its own AQM:
* The classic AQM is called PI2, which is similar to the PIE AQM but
  more responsive and simpler. Classic traffic requires a decent
  target queue (default 15ms for Internet deployment) to fully
  utilize the link and to avoid high drop rates.
* The low latency AQM is, by default, a very shallow ECN marking
  threshold (1ms) similar to that used for DCTCP.

The DualQ isolates the low queuing delay of the Low Latency queue
from the larger delay of the 'Classic' queue. However, from a
bandwidth perspective, flows in either queue will share out the link
capacity as if there was just a single queue. This bandwidth pooling
effect is achieved by coupling together the drop and ECN-marking
probabilities of the two AQMs.

The PI2 AQM has two main parameters in addition to its target delay.
The integral gain factor alpha is used to slowly correct any persistent
standing queue error from the target delay, while the proportional gain
factor beta is used to quickly compensate for queue changes (growth or
shrinkage). Either alpha and beta are given as a parameter, or they can
be calculated by tc from alternative typical and maximum RTT parameters.

Internally, the output of a linear Proportional Integral (PI)
controller is used for both queues. This output is squared to
calculate the drop or ECN-marking probability of the classic queue.
This counterbalances the square-root rate equation of Reno/Cubic,
which is the trick that balances flow rates across the queues. For
the ECN-marking probability of the low latency queue, the output of
the base AQM is multiplied by a coupling factor. This determines the
balance between the flow rates in each queue. The default setting
makes the flow rates roughly equal, which should be generally
applicable.

If DUALPI2 AQM has detected overload (due to excessive non-responsive
traffic in either queue), it will switch to signaling congestion
solely using drop, irrespective of the ECN field. Alternatively, it
can be configured to limit the drop probability and let the queue
grow and eventually overflow (like tail-drop).

GSO splitting in DUALPI2 is configurable from userspace while the
default behavior is to split gso. When running DUALPI2 at unshaped
10gigE with 4 download streams test, splitting gso apart results in
halving the latency with no loss in throughput:

Summary of tcp_4down run 'no_split_gso':
                         avg         median      # data pts
 Ping (ms) ICMP   :       0.53      0.30 ms         350
 TCP download avg :    2326.86       N/A Mbits/s    350
 TCP download sum :    9307.42       N/A Mbits/s    350
 TCP download::1  :    2672.99   2568.73 Mbits/s    350
 TCP download::2  :    2586.96   2570.51 Mbits/s    350
 TCP download::3  :    1786.26   1798.82 Mbits/s    350
 TCP download::4  :    2261.21   2309.49 Mbits/s    350

Summart of tcp_4down run 'split_gso':
                         avg          median      # data pts
 Ping (ms) ICMP   :       0.22      0.23 ms         350
 TCP download avg :    2335.02       N/A Mbits/s    350
 TCP download sum :    9340.09       N/A Mbits/s    350
 TCP download::1  :    2335.30   2334.22 Mbits/s    350
 TCP download::2  :    2334.72   2334.20 Mbits/s    350
 TCP download::3  :    2335.28   2334.58 Mbits/s    350
 TCP download::4  :    2334.79   2334.39 Mbits/s    350

A similar result is observed when running DUALPI2 at unshaped 1gigE
with 1 download stream test:

Summary of tcp_1down run 'no_split_gso':
                         avg         median      # data pts
 Ping (ms) ICMP :         1.13      1.25 ms         350
 TCP download   :       941.41    941.46 Mbits/s    350

Summart of tcp_1down run 'split_gso':
                         avg         median      # data pts
 Ping (ms) ICMP :         0.51      0.55 ms         350
 TCP download   :       941.41    941.45 Mbits/s    350

Additional details can be found in the draft:
  https://datatracker.ietf.org/doc/html/rfc9332

Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Co-developed-by: Olga Albisser <olga@albisser.org>
Signed-off-by: Olga Albisser <olga@albisser.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Henrik Steen <henrist@henrist.net>
Signed-off-by: Henrik Steen <henrist@henrist.net>
Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Dave Taht <dave.taht@gmail.com>
---
 include/net/dropreason-core.h |   6 +
 net/sched/Kconfig             |  12 +
 net/sched/Makefile            |   1 +
 net/sched/sch_dualpi2.c       | 453 ++++++++++++++++++++++++++++++++++
 4 files changed, 472 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index bea77934a235..faae9f416e54 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -120,6 +120,7 @@
 	FN(ARP_PVLAN_DISABLE)		\
 	FN(MAC_IEEE_MAC_CONTROL)	\
 	FN(BRIDGE_INGRESS_STP_STATE)	\
+	FN(DUALPI2_STEP_DROP)		\
 	FNe(MAX)
 
 /**
@@ -570,6 +571,11 @@ enum skb_drop_reason {
 	 * ingress bridge port does not allow frames to be forwarded.
 	 */
 	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
+	/**
+	 * @SKB_DROP_REASON_DUALPI2_STEP_DROP: dropped by the step drop
+	 * threshold of DualPI2 qdisc.
+	 */
+	SKB_DROP_REASON_DUALPI2_STEP_DROP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index a800127effcd..d73db028a6bd 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -403,6 +403,18 @@ config NET_SCH_ETS
 
 	  If unsure, say N.
 
+config NET_SCH_DUALPI2
+	tristate "Dual Queue PI Square (DUALPI2) scheduler"
+	help
+	  Say Y here if you want to use the Dual Queue Proportional Integral
+	  Controller Improved with a Square scheduling algorithm.
+	  For more information, please see https://tools.ietf.org/html/rfc9332
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called sch_dualpi2.
+
+	  If unsure, say N.
+
 menuconfig NET_SCH_DEFAULT
 	bool "Allow override default queue discipline"
 	help
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 82c3f78ca486..1abb06554057 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_NET_SCH_FQ_PIE)	+= sch_fq_pie.o
 obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
 obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
 obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
+obj-$(CONFIG_NET_SCH_DUALPI2)	+= sch_dualpi2.o
 
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 78027d6ce917..2faa45d6ac46 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -116,8 +116,45 @@ struct dualpi2_sched_data {
 	u32	step_marks;	/* ECN mark pkt counter due to step AQM */
 	u32	memory_used;	/* Memory used of both queues */
 	u32	max_memory_used;/* Maximum used memory */
+
+	struct { /* Deferred drop statistics */
+		u32 cnt;	/* Packets dropped */
+		u32 len;	/* Bytes dropped */
+	} deferred_drops;
+};
+
+struct dualpi2_skb_cb {
+	u64 ts;			/* Timestamp at enqueue */
+	u8 apply_step:1,	/* Can we apply the step threshold */
+	   classified:2,	/* Packet classification results */
+	   ect:2;		/* Packet ECT codepoint */
+};
+
+enum dualpi2_classification_results {
+	DUALPI2_C_CLASSIC	= 0,	/* C-queue */
+	DUALPI2_C_L4S		= 1,	/* L-queue (scale mark/classic drop) */
+	DUALPI2_C_LLLL		= 2,	/* L-queue (no drops/marks) */
+	__DUALPI2_C_MAX			/* Keep last*/
 };
 
+static struct dualpi2_skb_cb *dualpi2_skb_cb(struct sk_buff *skb)
+{
+	qdisc_cb_private_validate(skb, sizeof(struct dualpi2_skb_cb));
+	return (struct dualpi2_skb_cb *)qdisc_skb_cb(skb)->data;
+}
+
+static u64 dualpi2_sojourn_time(struct sk_buff *skb, u64 reference)
+{
+	return reference - dualpi2_skb_cb(skb)->ts;
+}
+
+static u64 head_enqueue_time(struct Qdisc *q)
+{
+	struct sk_buff *skb = qdisc_peek_head(q);
+
+	return skb ? dualpi2_skb_cb(skb)->ts : 0;
+}
+
 static u32 dualpi2_scale_alpha_beta(u32 param)
 {
 	u64 tmp = ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING);
@@ -139,6 +176,25 @@ static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
 	return ktime_add_ns(ktime_get_ns(), q->pi2.tupdate);
 }
 
+static bool skb_is_l4s(struct sk_buff *skb)
+{
+	return dualpi2_skb_cb(skb)->classified == DUALPI2_C_L4S;
+}
+
+static bool skb_in_l_queue(struct sk_buff *skb)
+{
+	return dualpi2_skb_cb(skb)->classified != DUALPI2_C_CLASSIC;
+}
+
+static bool dualpi2_mark(struct dualpi2_sched_data *q, struct sk_buff *skb)
+{
+	if (INET_ECN_set_ce(skb)) {
+		q->ecn_mark++;
+		return true;
+	}
+	return false;
+}
+
 static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
 {
 	q->c_protection.credit = q->c_protection.init;
@@ -158,6 +214,401 @@ static void dualpi2_calculate_c_protection(struct Qdisc *sch,
 	dualpi2_reset_c_protection(q);
 }
 
+static bool dualpi2_roll(u32 prob)
+{
+	return get_random_u32() <= prob;
+}
+
+/* Packets in the C-queue are subject to a marking probability pC, which is the
+ * square of the internal PI probability (i.e., have an overall lower mark/drop
+ * probability). If the qdisc is overloaded, ignore ECT values and only drop.
+ *
+ * Note that this marking scheme is also applied to L4S packets during overload.
+ * Return true if packet dropping is required in C queue
+ */
+static bool dualpi2_classic_marking(struct dualpi2_sched_data *q,
+				    struct sk_buff *skb, u32 prob,
+				    bool overload)
+{
+	if (dualpi2_roll(prob) && dualpi2_roll(prob)) {
+		if (overload || dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
+			return true;
+		dualpi2_mark(q, skb);
+	}
+	return false;
+}
+
+/* Packets in the L-queue are subject to a marking probability pL given by the
+ * internal PI probability scaled by the coupling factor.
+ *
+ * On overload (i.e., @local_l_prob is >= 100%):
+ * - if the qdisc is configured to trade losses to preserve latency (i.e.,
+ *   @q->drop_overload), apply classic drops first before marking.
+ * - otherwise, preserve the "no loss" property of ECN at the cost of queueing
+ *   delay, eventually resulting in taildrop behavior once sch->limit is
+ *   reached.
+ * Return true if packet dropping is required in L queue
+ */
+static bool dualpi2_scalable_marking(struct dualpi2_sched_data *q,
+				     struct sk_buff *skb,
+				     u64 local_l_prob, u32 prob,
+				     bool overload)
+{
+	if (overload) {
+		/* Apply classic drop */
+		if (!q->drop_overload ||
+		    !(dualpi2_roll(prob) && dualpi2_roll(prob)))
+			goto mark;
+		return true;
+	}
+
+	/* We can safely cut the upper 32b as overload==false */
+	if (dualpi2_roll(local_l_prob)) {
+		/* Non-ECT packets could have classified as L4S by filters. */
+		if (dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
+			return true;
+mark:
+		dualpi2_mark(q, skb);
+	}
+	return false;
+}
+
+/* Decide whether a given packet must be dropped (or marked if ECT), according
+ * to the PI2 probability.
+ *
+ * Never mark/drop if we have a standing queue of less than 2 MTUs.
+ */
+static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
+		      struct sk_buff *skb)
+{
+	u64 local_l_prob;
+	bool overload;
+	u32 prob;
+
+	if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
+		return false;
+
+	prob = READ_ONCE(q->pi2.prob);
+	local_l_prob = (u64)prob * q->coupling_factor;
+	overload = local_l_prob > MAX_PROB;
+
+	switch (dualpi2_skb_cb(skb)->classified) {
+	case DUALPI2_C_CLASSIC:
+		return dualpi2_classic_marking(q, skb, prob, overload);
+	case DUALPI2_C_L4S:
+		return dualpi2_scalable_marking(q, skb, local_l_prob, prob,
+						overload);
+	default: /* DUALPI2_C_LLLL */
+		return false;
+	}
+}
+
+static void dualpi2_read_ect(struct sk_buff *skb)
+{
+	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
+	int wlen = skb_network_offset(skb);
+
+	switch (skb_protocol(skb, true)) {
+	case htons(ETH_P_IP):
+		wlen += sizeof(struct iphdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			goto not_ecn;
+
+		cb->ect = ipv4_get_dsfield(ip_hdr(skb)) & INET_ECN_MASK;
+		break;
+	case htons(ETH_P_IPV6):
+		wlen += sizeof(struct ipv6hdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			goto not_ecn;
+
+		cb->ect = ipv6_get_dsfield(ipv6_hdr(skb)) & INET_ECN_MASK;
+		break;
+	default:
+		goto not_ecn;
+	}
+	return;
+
+not_ecn:
+	/* Non pullable/writable packets can only be dropped hence are
+	 * classified as not ECT.
+	 */
+	cb->ect = INET_ECN_NOT_ECT;
+}
+
+static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
+				struct sk_buff *skb)
+{
+	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
+	struct tcf_result res;
+	struct tcf_proto *fl;
+	int result;
+
+	dualpi2_read_ect(skb);
+	if (cb->ect & q->ecn_mask) {
+		cb->classified = DUALPI2_C_L4S;
+		return NET_XMIT_SUCCESS;
+	}
+
+	if (TC_H_MAJ(skb->priority) == q->sch->handle &&
+	    TC_H_MIN(skb->priority) < __DUALPI2_C_MAX) {
+		cb->classified = TC_H_MIN(skb->priority);
+		return NET_XMIT_SUCCESS;
+	}
+
+	fl = rcu_dereference_bh(q->tcf_filters);
+	if (!fl) {
+		cb->classified = DUALPI2_C_CLASSIC;
+		return NET_XMIT_SUCCESS;
+	}
+
+	result = tcf_classify(skb, NULL, fl, &res, false);
+	if (result >= 0) {
+#ifdef CONFIG_NET_CLS_ACT
+		switch (result) {
+		case TC_ACT_STOLEN:
+		case TC_ACT_QUEUED:
+		case TC_ACT_TRAP:
+			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		case TC_ACT_SHOT:
+			return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+		}
+#endif
+		cb->classified = TC_H_MIN(res.classid) < __DUALPI2_C_MAX ?
+			TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
+	}
+	return NET_XMIT_SUCCESS;
+}
+
+static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
+			       struct sk_buff **to_free)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct dualpi2_skb_cb *cb;
+
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely((u64)q->memory_used + skb->truesize > q->memory_limit)) {
+		qdisc_qstats_overlimit(sch);
+		if (skb_in_l_queue(skb))
+			qdisc_qstats_overlimit(q->l_queue);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 SKB_DROP_REASON_QDISC_OVERLIMIT);
+	}
+
+	if (q->drop_early && must_drop(sch, q, skb)) {
+		qdisc_drop_reason(skb, sch, to_free,
+				  SKB_DROP_REASON_QDISC_OVERLIMIT);
+		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+	}
+
+	cb = dualpi2_skb_cb(skb);
+	cb->ts = ktime_get_ns();
+	q->memory_used += skb->truesize;
+	if (q->memory_used > q->max_memory_used)
+		q->max_memory_used = q->memory_used;
+
+	if (qdisc_qlen(sch) > q->maxq)
+		q->maxq = qdisc_qlen(sch);
+
+	if (skb_in_l_queue(skb)) {
+		/* Only apply the step if a queue is building up */
+		dualpi2_skb_cb(skb)->apply_step = skb_is_l4s(skb) &&
+			qdisc_qlen(q->l_queue) >= q->min_qlen_step;
+		/* Keep the overall qdisc stats consistent */
+		++sch->q.qlen;
+		qdisc_qstats_backlog_inc(sch, skb);
+		++q->packets_in_l;
+		if (!q->l_head_ts)
+			q->l_head_ts = cb->ts;
+		return qdisc_enqueue_tail(skb, q->l_queue);
+	}
+	++q->packets_in_c;
+	if (!q->c_head_ts)
+		q->c_head_ts = cb->ts;
+	return qdisc_enqueue_tail(skb, sch);
+}
+
+/* By default, dualpi2 will split GSO skbs into independent skbs and enqueue
+ * each of those individually. This yields the following benefits, at the
+ * expense of CPU usage:
+ * - Finer-grained AQM actions as the sub-packets of a burst no longer share the
+ *   same fate (e.g., the random mark/drop probability is applied individually)
+ * - Improved precision of the starvation protection/WRR scheduler at dequeue,
+ *   as the size of the dequeued packets will be smaller.
+ */
+static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
+				 struct sk_buff **to_free)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	int err;
+
+	err = dualpi2_skb_classify(q, skb);
+	if (err != NET_XMIT_SUCCESS) {
+		if (err & __NET_XMIT_BYPASS)
+			qdisc_qstats_drop(sch);
+		__qdisc_drop(skb, to_free);
+		return err;
+	}
+
+	if (q->split_gso && skb_is_gso(skb)) {
+		netdev_features_t features;
+		struct sk_buff *nskb, *next;
+		int cnt, byte_len, orig_len;
+		int err;
+
+		features = netif_skb_features(skb);
+		nskb = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(nskb))
+			return qdisc_drop(skb, sch, to_free);
+
+		cnt = 1;
+		byte_len = 0;
+		orig_len = qdisc_pkt_len(skb);
+		skb_list_walk_safe(nskb, nskb, next) {
+			skb_mark_not_on_list(nskb);
+			qdisc_skb_cb(nskb)->pkt_len = nskb->len;
+			dualpi2_skb_cb(nskb)->classified =
+				dualpi2_skb_cb(skb)->classified;
+			dualpi2_skb_cb(nskb)->ect = dualpi2_skb_cb(skb)->ect;
+			err = dualpi2_enqueue_skb(nskb, sch, to_free);
+			if (err == NET_XMIT_SUCCESS) {
+				/* Compute the backlog adjustment that needs
+				 * to be propagated in the qdisc tree to reflect
+				 * all new skbs successfully enqueued.
+				 */
+				++cnt;
+				byte_len += nskb->len;
+			}
+		}
+		if (err == NET_XMIT_SUCCESS) {
+			/* The caller will add the original skb stats to its
+			 * backlog, compensate this.
+			 */
+			--cnt;
+			byte_len -= orig_len;
+		}
+		qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
+		consume_skb(skb);
+		return err;
+	}
+	return dualpi2_enqueue_skb(skb, sch, to_free);
+}
+
+/* Select the queue from which the next packet can be dequeued, ensuring that
+ * neither queue can starve the other with a WRR scheduler.
+ *
+ * The sign of the WRR credit determines the next queue, while the size of
+ * the dequeued packet determines the magnitude of the WRR credit change. If
+ * either queue is empty, the WRR credit is kept unchanged.
+ *
+ * As the dequeued packet can be dropped later, the caller has to perform the
+ * qdisc_bstats_update() calls.
+ */
+static struct sk_buff *dequeue_packet(struct Qdisc *sch,
+				      struct dualpi2_sched_data *q,
+				      int *credit_change,
+				      u64 now)
+{
+	struct sk_buff *skb = NULL;
+	int c_len;
+
+	*credit_change = 0;
+	c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
+	if (qdisc_qlen(q->l_queue) && (!c_len || q->c_protection.credit <= 0)) {
+		skb = __qdisc_dequeue_head(&q->l_queue->q);
+		WRITE_ONCE(q->l_head_ts, head_enqueue_time(q->l_queue));
+		if (c_len)
+			*credit_change = q->c_protection.wc;
+		qdisc_qstats_backlog_dec(q->l_queue, skb);
+		/* Keep the global queue size consistent */
+		--sch->q.qlen;
+		q->memory_used -= skb->truesize;
+	} else if (c_len) {
+		skb = __qdisc_dequeue_head(&sch->q);
+		WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
+		if (qdisc_qlen(q->l_queue))
+			*credit_change = ~((s32)q->c_protection.wl) + 1;
+		q->memory_used -= skb->truesize;
+	} else {
+		dualpi2_reset_c_protection(q);
+		return NULL;
+	}
+	*credit_change *= qdisc_pkt_len(skb);
+	qdisc_qstats_backlog_dec(sch, skb);
+	return skb;
+}
+
+static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb,
+		       u64 now)
+{
+	u64 qdelay = 0;
+
+	if (q->step.in_packets)
+		qdelay = qdisc_qlen(q->l_queue);
+	else
+		qdelay = dualpi2_sojourn_time(skb, now);
+
+	if (dualpi2_skb_cb(skb)->apply_step && qdelay > q->step.thresh) {
+		if (!dualpi2_skb_cb(skb)->ect)
+			/* Drop this non-ECT packet */
+			return 1;
+		if (dualpi2_mark(q, skb))
+			++q->step_marks;
+	}
+	qdisc_bstats_update(q->l_queue, skb);
+	return 0;
+}
+
+static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff *skb,
+			   struct Qdisc *sch, enum skb_drop_reason reason)
+{
+	++q->deferred_drops.cnt;
+	q->deferred_drops.len += qdisc_pkt_len(skb);
+	kfree_skb_reason(skb, reason);
+	qdisc_qstats_drop(sch);
+}
+
+static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb;
+	int credit_change;
+	u64 now;
+
+	now = ktime_get_ns();
+
+	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
+		if (!q->drop_early && must_drop(sch, q, skb)) {
+			drop_and_retry(q, skb, sch,
+				       SKB_DROP_REASON_QDISC_CONGESTED);
+			continue;
+		}
+
+		if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
+			qdisc_qstats_drop(q->l_queue);
+			drop_and_retry(q, skb, sch,
+				       SKB_DROP_REASON_DUALPI2_STEP_DROP);
+			continue;
+		}
+
+		q->c_protection.credit += credit_change;
+		qdisc_bstats_update(sch, skb);
+		break;
+	}
+
+	/* We cannot call qdisc_tree_reduce_backlog() if our qlen is 0,
+	 * or HTB crashes.
+	 */
+	if (q->deferred_drops.cnt && qdisc_qlen(sch)) {
+		qdisc_tree_reduce_backlog(sch, q->deferred_drops.cnt,
+					  q->deferred_drops.len);
+		q->deferred_drops.cnt = 0;
+		q->deferred_drops.len = 0;
+	}
+	return skb;
+}
+
 static s64 __scale_delta(u64 diff)
 {
 	do_div(diff, 1 << ALPHA_BETA_GRANULARITY);
@@ -604,6 +1055,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.id		= "dualpi2",
 	.cl_ops		= &dualpi2_class_ops,
 	.priv_size	= sizeof(struct dualpi2_sched_data),
+	.enqueue	= dualpi2_qdisc_enqueue,
+	.dequeue	= dualpi2_qdisc_dequeue,
 	.peek		= qdisc_peek_dequeued,
 	.init		= dualpi2_init,
 	.destroy	= dualpi2_destroy,
-- 
2.34.1


