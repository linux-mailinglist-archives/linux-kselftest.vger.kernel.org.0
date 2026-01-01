Return-Path: <linux-kselftest+bounces-48048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE6CED2B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 17:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D12B3002942
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6052D2EE617;
	Thu,  1 Jan 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTS4JLSJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5CC296BD7;
	Thu,  1 Jan 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767285287; cv=fail; b=AtjqgBvrBxOOC0W/zJAVa1cWWm18KKi/48JM58v5wMyWDDDSznA/stm7g3y+Gv/tJ4tUlDUL5vXR5inHvxFpOKnOfE1hs3wd2xw+oqqM1BgwHTDyL/U+hNlkEaCiBIg7l5olbJW9ST1UfcDIWuXpx3iqaad9iRzdsqQMfLTqxMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767285287; c=relaxed/simple;
	bh=IdS7+jwVBrpaoP8sGYwZA3BanhECuyH/Ft8lbdK1CZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H5Z9y1CEzPpkKXrgsyfyFXrjohH1rV1KpY1iyQExNbIMprGgY9T47gjMSsGLN1Z6FnuGsNfdVo+9JOqrQC5EoM5jn0Ba5gTF3cp6qk6bHyc0QukHYbmK0oINSPumWO4tTyb//sDl0QvwlqoXJhdjbh+rWNSdlEK+0uFXOAFHHck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTS4JLSJ; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa/Gd8ABE57dOiUx1aMiVoJfehGK9tan3/Dn1r4LuRkCYbCr2tf6lk+MdNe3X/f56/Hvy/wZBQQsM11aOgENgDN3PYAvp5KwF850S0n88nnX+gCar5crHh7soNZaUrR1YXMQ50GNZLyP4Z/Fn+fkqSQO6mpBC7bAmNtwsVyfJgbKmNVF3CdfSCgAfLAMio7GTdcYaVgei9qC9hJKz+w+ZBlKA/ZhaTQgeKpZQzUdWG3l28N8woj+k/T2amXSVBS+lDaKk+hlgGlmJMVmGHHeqkcpgIpmj9jLXmT98UcaOhK71arMZXkfx0GkC5maI8xeqdPFHBacmi2sLVSDUzzPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCbpNBOZM4gglPnaRjtqpNl/gmpnbAXbJB4hlRAsofM=;
 b=VRV4h911vwUOm2kCmw4FL5WwcIQ+kHmbBKQjgYqev6bw+9iB4eOCx+Y5bT6q4MVhWNuyJ7h22DXF8FBlgmQLhECoAhO9MUt6UDV6I2FC6ZXDlyVsPxwsJaq/UeYDKc6w8yQrN/7fq6IS74C7ppZY/ome+kpOo5TYUdxbKXrH8obgD+2Q1GclHlGD77NGiAqPb7oo8mXhk/Tt25kzn6qTR9YYE1nVWJXMKLCm/46+HPZGG2legdPeoJ9Ui7zDiE60V5SAbZ+wrzBlQipAAM8jFGpXenQqi0Pu/PzWzdzMV3Qbi9EtFgYsWSKPkLaxOHNTTz0jglg5TjDoWAu68dVQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCbpNBOZM4gglPnaRjtqpNl/gmpnbAXbJB4hlRAsofM=;
 b=aTS4JLSJNjx7YrzqrhGG3ARnaV/4kroj55+nNp4ZakVei/BIVSl0qfcXaBJ0rOT1yxMqtKSTorZbRkC9Iu+WgKgXzIcw/D0bPydpZlRvo/QRA+huyP0qF8tlGvHrAUccR6nrdtBEd1+Lx7tTBpcXHyl9pIXk2+t3CH1fn9MYCL5TNf4LMBRfoTUCeGeL8rWMnCLRYPe9cBdtXGTx0bnLIgELGcIbscdN2SJDgaSp7SGno0e8KKl+sMxxvB8P8+X/krZxC6dmhcYyI6FzCLb7Qgq4C/p1Mq2JNwsl+zxR7Ek3TNXeygHJxdoXqhmyNYHAZzGlG2SFdkDDCaEtq1/jsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:34:40 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:34:40 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next 6/8] rcu: Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS early
Date: Thu,  1 Jan 2026 11:34:15 -0500
Message-Id: <20260101163417.1065705-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0437.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::22) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fade6f-4a81-476b-8dc6-08de4953a90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ZfakHGokdkQpQIW4cOwVTKKXrk35mxvFnSy5ANXH23HGarP2PahmMcW/W8s?=
 =?us-ascii?Q?H9HwivtbS8L+3JjU+n4jylGzt8debsvYCS2fS8ZR8OzqO4yXvsncqF8ivvnV?=
 =?us-ascii?Q?BRofJHamNcwJ5EH2y7sthttXG6vaebYhh4KwzEH4GQmFjXRxS8VW3LTcOpoB?=
 =?us-ascii?Q?jeB/+B7vo7FW7Cfcbh8PywlXus2/VjIjeW3pd0kRGXbCc62ydZrsmzp/80Zq?=
 =?us-ascii?Q?V7T63XE+2hhXgHG8qpPCE3PkSz8pWA3f1eKK1b6mZP8T+e3FApJIROM+jPfc?=
 =?us-ascii?Q?XO/7JFyKNQiJTrAlV07nuaADDbc5twQqL+94Z2RTTAU+knk5NfoohAIUtMgp?=
 =?us-ascii?Q?EB0/kn0Oqi8roKn3HLQSp7pFM9/nGFWsIRo+dkeH0dQ/66l7mPcPEmbH5BwV?=
 =?us-ascii?Q?K3w2UbrJnNvr66D6PMohQ0UDI5ETBTuBMLCFDkLDb7d0wrVPpZljqoBhIaK6?=
 =?us-ascii?Q?LkqI9hQjXMYfy/r2iP4VMb2qZeKmmtYOR6k1pTLUI225c2gwnV9BP0Po5t7l?=
 =?us-ascii?Q?OqebR5LTY3SV6851iG3w+pa1goR4UkiWsLDVL1nb8y4oBWNtW7yC5c5Pn2HJ?=
 =?us-ascii?Q?jZuIW5KhcJ0zgmZMPyMYNidOf7qk5j9Mt/4uCO1DsRzcTgOzTxxfaOztXoxI?=
 =?us-ascii?Q?U8+kSFXkwPMfg2Nd7i+O3cVPvfvF+w4gZggTgSOsZen/SCRx38rpktuBA1lx?=
 =?us-ascii?Q?uW/6njIVQq9eKiay2iy1sQ8bz7Cz5oMgZSrUgbJLXN6HcjOkXSbGBcV8rbOb?=
 =?us-ascii?Q?7RVaVtU0MpBYfoP4z4WLMYHLLMnqtw6v+l4xr9kvR0T8W3aDDepbPwaxs6BQ?=
 =?us-ascii?Q?3lVMuFvryCHzM30Lub/cJsWSc13s/m4IH1aNpUZ95h9i+IK3vKdB5m49oq2p?=
 =?us-ascii?Q?ba3mU2iZylgqcAiaITcd5SNVNrAVT34lRPkkeBRFKTXeJAA12Cqq06kbMTpM?=
 =?us-ascii?Q?IcEUKfeZHmrwh2f+Z+Y5TAJwZYFaucyVbbKfVOcnkhAfK8mpVEoXleCeQGGX?=
 =?us-ascii?Q?g9Hnmej04bNhb8A3Bcm8lp6Tj2TgSmfwMeYqTxJmW0Aid+ThmvoKB0mF/cHZ?=
 =?us-ascii?Q?ehN+TD18AGzV3ekPhqNRd/S7AZasa1ToPrjFNmC1WNcnZpBDGAp+QOXe9aue?=
 =?us-ascii?Q?rVc5ea/gqpJ2P5A6IS45mfE2GIhx0RGmOvvWY4REgI7c+rWCXzWzXytJb19e?=
 =?us-ascii?Q?4sTdZkLbRVVg1um9Y2ZaxPmHIbwRwZ6kFHcu2llB3FMFLnHEyjCR+aoODSjc?=
 =?us-ascii?Q?2N3uEzIRcPax+sDfFsZRKIqVnGIz+AV/OLkQ/nwQunWEptZnrJuwhpKS0TId?=
 =?us-ascii?Q?8YzQ6oB6RacRePjhK8XdjWrCztSDtchbCTlcUsFzJ6k1g9lzLKREBexkTCHv?=
 =?us-ascii?Q?lBcJEn9T5a9aiXB4/RYmBus8FwZ4OwoR8yAVk+/+6i1CvY/NAjAAaZGU0jZG?=
 =?us-ascii?Q?CEInYZzEfUz9VuKNbUXVrqDIUDuVBfX3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wINiP3mfi65BlIZPLLXDH27+MnsGWUOC7txDNRZMsfDgaCAanB2kDDZ04OaC?=
 =?us-ascii?Q?E1fizkLmLdIHj8Z8nMr2KMcVgT9cG52Qw3UaCsbnkja7XcOujKeK/XILrHoz?=
 =?us-ascii?Q?tao6jUrTrHTclkXCOwTjhdi2QMSkVaZYT84oHLc/TMutSfSgPC0nPOAwUTGO?=
 =?us-ascii?Q?J3hBL9lnOjBEwZmlL60D/2q+g9FyMPsVUQUOcW7Y5PbQk97vN40qgJ6sHG/w?=
 =?us-ascii?Q?d6Qlh4fDdm5IMJKHNJ78W/Adrk6S+0Db7NKeVeY9llXwe3V/+P6fp7Cbilhf?=
 =?us-ascii?Q?iaaM2ON/+Zbx8Ga8AWhJYr6WrezKakC8JHnt6TA7ag1RtIWfCAdJuhBx1Hb9?=
 =?us-ascii?Q?dRguzFJ+fq7EW3eCz5A0fFMOt9QJHPMl9+Tu8RQ4CGJmKIygVBDc40fRjdJD?=
 =?us-ascii?Q?8tpPY73mrnFGtUe2DsIz2/IKOeFh2slXSm8aZUQRWe/BfvQGBY+uyzBN5Ewr?=
 =?us-ascii?Q?hgVsoBcXzKOkepIUc5xvDAvtiFznr1OieFzxHV9tQMpdllgeCsTcBAmMkKcw?=
 =?us-ascii?Q?AQ5DEaGxOtIxu43dmDrMakRPLUNc642a7G6iZd7ogXOFzCrBUWS7gIfuCttL?=
 =?us-ascii?Q?LBZqvgCZfiQSf8sjh3OeaCowOFsxkPS+MuIfGbp0JfKbWAFXFk75HAhhQi7L?=
 =?us-ascii?Q?Bt4Rcg2fjcCqpyCLC8WoLclOZpnLCH+o7bWb7nSwPvtTrbwbZBjymWqq33hL?=
 =?us-ascii?Q?P/iUNoyX9jN7MK/ov3kbcggqpKEn4RBmPYOkFy/wCcGx3OfMUGfi+ZvU5diQ?=
 =?us-ascii?Q?udbnJM90ckQErWcVGBXF+zYdBmDWCHtxsG5q4Hp1VNC8cjWLCrVNwC7yomPi?=
 =?us-ascii?Q?7V6mnBu/YFrOo56yihq0LRcCgtLYYeu9hwT4Ei4LQWz1gVxyGnGgaaXzIn+6?=
 =?us-ascii?Q?8mV2Fc+NB1HHEPYsiKsqqpx40ZdgZENpOJPiHdp+VfcDyp3SF616sbV2JJa9?=
 =?us-ascii?Q?iXmtTy5AaU1WrCNJnJ5W3H5+dFjhStLzDDr2vxUYX8TJ9JLIQsa6w6W02FD6?=
 =?us-ascii?Q?rVwOC8S3816NQB3egEmRnaRvRyALPZA+xz51x37jSQTRsWFTKU/sAQxAo1x1?=
 =?us-ascii?Q?1XENnwFWuk8bSeireJZ2wXk5hTCOSSfcmxSIqxNgWY4BlahRGZtld4wcCsfT?=
 =?us-ascii?Q?A4iQ0mpMLNnAVgQBV+pw/DyVgfYuFmTPXCR86p2+osXV0Fus42DceYsHHy4x?=
 =?us-ascii?Q?orv9LC0YJOHHvS8AyNIOc6SzrD75h7soe+aEuQCOxDE0unzjxiTkt9aAAM+2?=
 =?us-ascii?Q?ITVLJnvgPYcKwmTC1brRNRruizIwOaktbX+I9WzLcTbhATPiRK91CDiSH4xi?=
 =?us-ascii?Q?s9o/WGn8uOnwGpqa3B69Ms7jJN0m40k/UhVlnlQ4NxpR4yol47XLHtiQHrJM?=
 =?us-ascii?Q?u5TewFgcrvxNxoOpE5Jory7ZidUgnQGlAQ4npJTsCrJMJIKaGtQXlxNXt45J?=
 =?us-ascii?Q?mLuZxdihRSe28P5/aCL2xUWH7pW6Zb/rsJxLkphzyE7OU9Rb0Szzf5uyGT3G?=
 =?us-ascii?Q?xdTK2MdtWMJPrRc4sRA/i6Pbwl9O98haElfyqzQTkuRE2MF0hg9KyVEWTYfr?=
 =?us-ascii?Q?N++3K7dk2B+07YNW8930ljIfNwhnvWLDep/y91GAKZ4BxsdC7Gjp4anB8pO1?=
 =?us-ascii?Q?PX7lMKO/rPdCWzLScEErk0H54bnkaDJZKkHNIhIdsKQOK4dLDvjuHsDCuWl1?=
 =?us-ascii?Q?L5z/RAAXiF9rYgFfYzF1WeUhhqc+KUpt9Lpc86anfoEI04BwIBh5mB6TD5MU?=
 =?us-ascii?Q?68Eij71Zdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fade6f-4a81-476b-8dc6-08de4953a90a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:34:40.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +904GRJlEGb3PsPmE6R4ES98Vd5xSsz+60DB7jeQSSVwp/XHyo427HbTKBiMW9cHqbQ6JPuCZGjOYX3wSSlo1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
State) design where the first FQS saves dyntick-idle snapshots and
the second FQS compares them. This results in long and unnecessary latency
for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
1000HZ) whenever one FQS wait sufficed.

Some investigations showed that the GP kthread's CPU is the holdout CPU
a lot of times after the first FQS as - it cannot be detected as "idle"
because it's actively running the FQS scan in the GP kthread.

Therefore, at the end of rcu_gp_init(), immediately report a quiescent
state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
GP kthread cannot be in an RCU read-side critical section while running
GP initialization, so this is safe and results in significant latency
improvements.

The following tests were performed:

(1) synchronize_rcu() benchmarking

    100 synchronize_rcu() calls with 32 CPUs, 10 runs each (default fqs
    jiffies settings):

    Baseline (without fix):
    | Run | Mean      | Min      | Max       |
    |-----|-----------|----------|-----------|
    | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
    | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
    | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
    | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
    | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
    | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
    | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
    | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
    | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
    | 10  | 10.077 ms | 9.984 ms | 17.703 ms |

    With fix:
    | Run | Mean     | Min      | Max       |
    |-----|----------|----------|-----------|
    | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
    | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
    | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
    | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
    | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
    | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
    | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
    | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
    | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
    | 10  | 6.036 ms | 5.993 ms |  9.579 ms |

    Summary:
    - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
    - Max latency:  25.72 ms -> 10.25 ms (60% improvement)

(2) Bridge setup/teardown latency (Uladzislau Rezki)

    x86_64 with 64 CPUs, 100 iterations of bridge add/configure/delete:

                                   real time
    1 - default:                   24.221s
    2 - this patch:                20.754s  (14% faster)
    3 - this patch + wake_from_gp: 15.895s  (34% faster)
    4 - wake_from_gp only:         18.947s  (22% faster)

    Per-synchronize_rcu() latency (in usec):
                  1         2         3       4
    median: 37249.5   31540.5   15765   22480
    min:    7881      7918      9803    7857
    max:    63651     55639     31861   32040

    This patch combined with rcu_normal_wake_from_gp reduces bridge
    setup/teardown time from 24 seconds to 16 seconds.

(3) CPU overhead verification (Uladzislau Rezki)

    System CPU time across 5 runs showed no measurable increase:
      default:     1.698s - 1.937s
      this patch:  1.667s - 1.930s
    Conclusion: variations are within noise, no CPU overhead regression.

(4) rcutorture

    Tested TREE and SRCU configurations - no regressions.

Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 78c045a5ef03..b7c818cabe44 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -160,6 +160,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
+static void rcu_report_qs_rdp(struct rcu_data *rdp);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
@@ -1983,6 +1984,17 @@ static noinline_for_stack bool rcu_gp_init(void)
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
 
+	/*
+	 * Immediately report QS for the GP kthread's CPU. The GP kthread
+	 * cannot be in an RCU read-side critical section while running
+	 * the FQS scan. This eliminates the need for a second FQS wait
+	 * when all CPUs are idle.
+	 */
+	preempt_disable();
+	rcu_qs();
+	rcu_report_qs_rdp(this_cpu_ptr(&rcu_data));
+	preempt_enable();
+
 	return true;
 }
 
-- 
2.34.1


