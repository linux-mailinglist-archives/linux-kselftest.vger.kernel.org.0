Return-Path: <linux-kselftest+bounces-15812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D46395936B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 05:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9EE283637
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 03:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551C436B17;
	Wed, 21 Aug 2024 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TFofwUmD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2054.outbound.protection.outlook.com [40.107.215.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BF18E34F;
	Wed, 21 Aug 2024 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724212220; cv=fail; b=cb//XSyAh2q5xopngdB4niwkAmkhx1a268eCHBV6JR/rAlYvZTelB6C5zzhe5X2e57B2wjvwrH5qF9qndozYXs+pxYqni9zCgRWUev3I+3JJwb1qCuExl3pr4wXV4EYgakybs2B3VjpisvmrmHfZs7XB264gsGeQ0JehcxxElXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724212220; c=relaxed/simple;
	bh=2bWyfgOXweFCJNose3Ex5m6sCJcVFsBjrWxnrNpXJIg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LjeD3QC1SqMZxUhTbsOrl4cYyi48oZSkVbxmpt6RFcfhN+0za5y3Uwn0EivOLscLGLe4Ah4UgKWgsqUE8nmg54iooQkc8h75WubP1ds/cuCvkG4Fu4HtLBtCYS7QLrXBQ5RrX/6bF+pxz/oxGXQ7nqUg1rBzTpQbIpX5QCMqGWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TFofwUmD; arc=fail smtp.client-ip=40.107.215.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImyjLixW52PGs19ayeNzic5YRyJqN9jYf3q+T1qfdmTnVtacJiVlR6p0RXA9UhW4TzS3YwnWrabKrNSXbyH8ySodATFIhBAfOq4wL9T8k5F513pWXVhqnU9rLgFTNrUehjlIYZuPHM+XySilj9ovV2lqRfDqRhxO8lO9nT/V2ns6zVhBCHrER7Cu9X7WuSTKhQ6js63TFmn8ttoeq+6kj9DL7/gqITAPy/ImgLTJotSgoo2/g8xsPxIH6bMOU1sIbGGTtrEmSrIlErFA+PbcAq7Db4loH1gMxkITKnW6ppjSh/fteWCqqoXntQtudUAcM7PpyRBjkcTUh4ESkJlJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8GoXfIIezXxwkNH+nkc/lKd5ti2Jm64EnlOqYLDm70=;
 b=w/O8iSfU26mJqKgGwznCDy86UBtyzW2JEKFuxgpOWktfilDWFD2fQDMUP7UIbncl4em8iE6xXKM3dWy2gIXfgRw5P8ybjllFSg53fuf4W9ZLSVpn3zekJCZT02XexPa66S5oKO6GhKYM1jo0C878CXqvoPWQuwVwDw9FD6HGFCPuWZ8nfUfqWHQb5nrQyiMz6798x/ygWm3yg3y3drLcRgpzwiDlL94r/x15Vtys34v1F9AKvbMfVqCOeJ68qJOqbGbLze5gDGEQVcJCft1oTRQ5WRXV7malXANbJGc5S32iBm2sEIzK3UQkHn8G+keGfVJURAXZVUDJXikfX5l7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8GoXfIIezXxwkNH+nkc/lKd5ti2Jm64EnlOqYLDm70=;
 b=TFofwUmDrQ9nqegVhQDJQup67feBGt0y09v6+mLsT5Ohbt+VUIR2d7+auiZJBXAFchd4ccGJ/Q1KqPgKpooNNW2G/u4MLSF35fCy4RiGKz7c14tUSdgBt5Qee2hV04m/2ll52HhwjeUNJDzBpUlD0WkOru9q4cYiI4Fd/ktY++HoS/oODT7h6jjr8YVqwQ2PD8PcaiKfpuVGJQV2+959Wo44orYwGkNAbCnVywaU74PCEcu7vysoQeZYc2cHngHg/Fd9LPeemNUfjss7A1I7+g+zRXwfH8J40orJ0IWyk8BNnkEVSbHrIUIqQyg/cIr2EMdeuBVo8l+uwbE8z09YSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by SI6PR06MB7241.apcprd06.prod.outlook.com (2603:1096:4:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 03:50:14 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 03:50:14 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] tools:mm:Check mmap based on return values
Date: Tue, 20 Aug 2024 23:50:03 -0400
Message-Id: <20240821035005.4423-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0221.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::7) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|SI6PR06MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 747f817b-6af4-4543-807f-08dcc1945d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZRi4eQJ/M1PYSWuJ3uDWLoWoypst0/AWWcyYejs3TS0wOEJzaYt09C8FsNGw?=
 =?us-ascii?Q?mSZHcAtLx7F/K4wfJNmbDEZp0nTeLV/kClgXa5UFKsIPt6owiKPpL+vpqLE+?=
 =?us-ascii?Q?SXDubVWIpkW+pXZAphp8BMEkxMTpFS9cXRD64X1qCzK+9qMH2sy8GN7WaQSq?=
 =?us-ascii?Q?Ty3Z7cLz/2wKYYZ0d97nvla/sju6qcJ0WHARofQe6gGj9Pfs9iXUnvO4D3hY?=
 =?us-ascii?Q?lZ5tbrH0g3+uNVPNgLz6iuLorIjKIki8mXr8dSSed8dz2O8sxQLEM2WiLjJd?=
 =?us-ascii?Q?cz1eb8Oa8HA08EQC58EzwtZsUGqyJHHWzOd7NIMYG+Nam+P2j2+VzU3tsGQS?=
 =?us-ascii?Q?tr7XL+KM7ShibJKjU95rLxardC9zvk7AAbmvhpExgGscp9JWmbGMNaKrLoXV?=
 =?us-ascii?Q?WH1HfR1/NY72oDMJBWpHSSjvzK2VQ7LD9Fsv/GcctMZhjbqeGIDYb2zPUqqX?=
 =?us-ascii?Q?gjOmaOi8X7ikOQmWbK8AGKmzXbH3ptUdtecIMSKLyxupGBOxHvNcPcRCWpNh?=
 =?us-ascii?Q?S9WGCJq+ywWBSMjAWFHeTA8OCdr49QDIgRLBRpWDxvLOYGoHUhFUbZDJMILM?=
 =?us-ascii?Q?v14tUB8cIsKQ+whw0v64N+iXeULZiOuPVKc2hIPahlWYjQwsql7DqNvHdNOt?=
 =?us-ascii?Q?Cj377A9GL5fhnDJhrWTKrxes+l0s5oDovpY8PhvouIP1bnPHm0W2D1BH5vr/?=
 =?us-ascii?Q?L/pVEelhOSw1HS9rMbDloSg8TDiGO8JVHBDpg0E7ssKETLPbdQ/8EPT65ElT?=
 =?us-ascii?Q?yfYU5KoJEvBxkRNf9fEzeyEwzf+09lbrVQ+nrGrcHYTzVtc8qxVRGCWdTc9K?=
 =?us-ascii?Q?ACw68T9jlJHtgsxtgfEN4FPhCDJiKURnY/MW/9JcVTjE/GrDZ8dN6zQRbfAI?=
 =?us-ascii?Q?Lf3A84s8SVm+AjvH4+H4PfzT2SvVS4xSHJjrS9/7Vp1dlv/mkaSlOTui6eoE?=
 =?us-ascii?Q?0zcCMOhxB5oAGSx7iqC9u2G06SiuOEitDWdg/XJBo6q4njzYh5z5G2hT1Vit?=
 =?us-ascii?Q?3e2JfwsMgSo+oYoVnOxb/yxL6NXZK7md08QUR/CUgiiaY0iOf4mHB5q5wcKl?=
 =?us-ascii?Q?2GGVpjS9zck5OEFTDhqmL7VRW79iOZcLzirL/iVzlpnXLYStsqiLA6jQYaC2?=
 =?us-ascii?Q?sHMdqfCtKpiNCJD/uIntOZqraNZuxfsKLmJ8ITMewvEjLnN0yU08jWIdAYlN?=
 =?us-ascii?Q?z1nxssvaZ8M1OAGBZlxuZ+0TDF/6cnJXxdpVMTN/GJbITfwbT6jwGuxZQiWc?=
 =?us-ascii?Q?W8mV7JV/1IdYqydQ+oBM5p60oVFY5wAAgZo9bGcUmNf009NJj+frhEvjoDMF?=
 =?us-ascii?Q?wQPM3qWTVi+fLG67bHg1ldX5u6HSq5APBoLKXUQIU9zucpF/rnbp+dDY2mRG?=
 =?us-ascii?Q?aJogxGKb+K0lP8pChUleRJXdw8tE5gPe2uJqGVs4uO+sEuJD6vKtocYHxnKQ?=
 =?us-ascii?Q?qrdl5oHFP54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4rN4mEa3Q010KM1cD6FMHrlmnNheVvsuq7ejueo6YliqTtnkIJwO3AZOZphq?=
 =?us-ascii?Q?SpaHv3MLKuCnVDOVq3bY6mvUpPnmLQVaDd2rVU6piebGHT6qwojpCufrZhOn?=
 =?us-ascii?Q?xNk/683cBrOHF1sjOfYe/GIrIESF64duA5p7nFNdWquYvdvL0VQp5P6kLUJQ?=
 =?us-ascii?Q?r1AFlGOTfecRtmp8dYOQZK5sISRYekjaI8dM94fiH9zHV+E8DH39lqe92oMX?=
 =?us-ascii?Q?NcXUxhu1X9LkqPAvb2qr0+LdSFP3oTi02Kf+RzK0xtLbUReRilq7fukzcFKF?=
 =?us-ascii?Q?uqnCzT2CfHtOEY05olKmYvKJmTgzAxgImI0s0btp6TvGjZwFHBJfoM6T/vDM?=
 =?us-ascii?Q?AR4MAdXeha3GQEJu/zTegis28RN0iNAm1OufS6f85/Tv8J8KzGa46JK0zeTf?=
 =?us-ascii?Q?8FzEd3SPuic6qmhIy8WLfRxasWmY6tXDHYjDvlHUIN9BaiyX6PcW6uLwz/cy?=
 =?us-ascii?Q?SAcdOwfbqkpVUQ9Pd46eLRNoyyBcwyl52eIW4Z9rW8W05WIz2zWL9YGghdw/?=
 =?us-ascii?Q?fQxNcL4GU4/Z/0/1B22Np8sYMKxMQxegPcK5RKPyiaTjwGrbc4+/sSdDtymF?=
 =?us-ascii?Q?Pjs5gE9hb5KDqC+b8l1Lx4pLSjKqEs5yzRaq+QMiZuH8cwgZPrnVcEkW/tlq?=
 =?us-ascii?Q?3R0dXYTpzWj+plK3em4Qkt2mAfQNS1WYtmhbBH9nrqfFK33npM3lEETPEtUu?=
 =?us-ascii?Q?LGRD31KpRXK8TlW3tlwswYFzae1AUz27tbeGmEKVwNm46CPPIhGnGSy8jt8e?=
 =?us-ascii?Q?acpBClHLGyki97ClhvG+iowqhRLeD5VNS/KFHoW7mY5XOU2EsqgDLhORP4j5?=
 =?us-ascii?Q?Ud+SG0hOAe2xXyvZ8jyA9TAdwZPfR5NUBo15r+AdcfPvoyVxr+vlJ1YvYViY?=
 =?us-ascii?Q?2FukZxKZ+IJA52BpE6uObebnicrjItS0SKT/kAoq+mJTyJDq5K4hxms0Psf1?=
 =?us-ascii?Q?/kZTQLx675t8GoNDA9fefO1IYaunjUObIchh8DPyQ1PEVy6Yf6UKwcR8lT2O?=
 =?us-ascii?Q?i0vAC2dL9YzRHXSBlImkznQVi8KcDs5uOi1n/LHMo2+5+rORsaAxiV1eIOUe?=
 =?us-ascii?Q?QoCGB/SCYU9OcMLllFpneCHhbFY/nkL6xF4bBhyHCAiQBcD0OcwctjsLf1Ge?=
 =?us-ascii?Q?4ZHo5tzrV13Ga9LO/9TnvCfEjccb2j7hRNsMom4CSCH/8jKaU6XIYjEwPbTy?=
 =?us-ascii?Q?vqEjhF9s3itZ0hUT0+tlvuCLp8AefARy8Uk5Sul/qU9o5CSYI+AWdtosX8or?=
 =?us-ascii?Q?meu5hTaQRfnURZDauQh36BWEYEo7hM5MfunwUVhSMY5ZROeVRQ4zLBbLYpbh?=
 =?us-ascii?Q?U5pkowtYCqYLpvrXL6X6/Nt4FvUS7S8sANF+LpanFLAyExOhfKl4j7MfVj6A?=
 =?us-ascii?Q?+ehLlsSzZ/1Fe+AZolL0eeCYbWscWy6EcLxsCY8TZfT3WNd+rIRse6AHlHIq?=
 =?us-ascii?Q?65aqzOCSDg7ys4fyzhRYqyEf/MdukBrnqtoq6Ugem0TzsLvQ4o5oVRjQVl1U?=
 =?us-ascii?Q?Iyb/M7pR/bu6gtv9Kvxl3sgEmf2PaAVOBimrrjP0nbjDWg0x4FaEFu/at9rd?=
 =?us-ascii?Q?5kSaO0FmRyjLsiolCS/PBIgIUwSE5Iv5VbgE5XyT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747f817b-6af4-4543-807f-08dcc1945d2d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 03:50:14.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L42MH1r3gsDx2Jf+W9kD0PHzJUNLnugy+IeMa/sCFruxlnCEEpzpIqbP/xdl+/nWS3hNh8PCu4kcY5vAtxqpkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7241

To correctly detect whether mmap is successful, must use if 
(map_ptr == MAP_FAILED)to avoid incorrectly handling a valid mapping.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 tools/testing/selftests/mm/ksm_tests.c     | 2 +-
 tools/testing/selftests/mm/madv_populate.c | 2 +-
 tools/testing/selftests/mm/soft-dirty.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index b748c48908d9..dad54840f32e 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -201,7 +201,7 @@ static void  *allocate_memory(void *ptr, int prot, int mapping, char data, size_
 {
 	void *map_ptr = mmap(ptr, map_size, PROT_WRITE, mapping, -1, 0);
 
-	if (!map_ptr) {
+	if (map_ptr == MAP_FAILED) {
 		perror("mmap");
 		return NULL;
 	}
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index ef7d911da13e..b89cb83ca5c5 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -34,7 +34,7 @@ static void sense_support(void)
 
 	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
 		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
-	if (!addr)
+	if (addr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap failed\n");
 
 	ret = madvise(addr, pagesize, MADV_POPULATE_READ);
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index bdfa5d085f00..4ccbc053bcce 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -134,7 +134,7 @@ static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
 	if (anon) {
 		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
 			   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-		if (!map)
+		if (map == MAP_FAILED)
 			ksft_exit_fail_msg("anon mmap failed\n");
 	} else {
 		test_fd = open(fname, O_RDWR | O_CREAT, 0664);
-- 
2.34.1


