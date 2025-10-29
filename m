Return-Path: <linux-kselftest+bounces-44349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E1C1CF57
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE09585DA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3349359FB2;
	Wed, 29 Oct 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PJ2fBluF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E07341645;
	Wed, 29 Oct 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765154; cv=fail; b=G54io4nYVxWKyhrb5F4QSJO2swvhYF24RRwGLDILeR4a3Pt2ZfHm2LA6FnPd9ge1w4KMjNhH4QeeW42CplqgyK8r5LnL/u+UuMi/I9g/M/+MdEYf2BHqkq+hPbvg9/gd0HUdImOatKWaRv4+Mv6c9bDAu68ZfwjIPS2p8rzgRqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765154; c=relaxed/simple;
	bh=ame6y5zu6cL+4NSe2XOxmTJRZFy2M+vCYU8kIjf6ARU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVogxsQqU+gc3WWxEoZhllkfO3/u872YeJvZ+lDUSuovDLyklDcuT8X7Yg4YmrWJgXS5ZUdC/TX9Rr65DJeYcs6o0fNuSVuAl1/Bq35HsosOaxEXYed/CZZ+MuJVZBFxI9LljM3sSxx8CNKQI4tXdYZVhFAUFj9ebGSmcgAaHUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PJ2fBluF; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7I1pDfD6hrVOFACIa8x2JRl8UhfP7+MdnxwOLqYNJWPQDnrUIECYIe/sB/hMYMGWQSOXkTVHru+Sh0S9cKf5MPgJrxQdcQLI4sgT0y56zAGaTGki9MMFaC8GZKlgWhuLAqTS2VCyv3oz10CmlacKzIaFivtg4/2BAYLEILObqSkvb6Bie7fYzQlod9gzUHRrJpmt+d1AEhButOjva5TZX3Tb83dVvCFVmQPfXolRtrXJbTPvWEH9Pq96oKSRb8SchEs2TF4yZme/mJX+3CDAaQtqTqnCl9Dc8yZWzh04FzI6COctrcQovIX+CIyoS6A2dNgD4xIjJNDNkPYSPq+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuzxeCSRRaPXN0mZvAVP6+jqOPXPGWxXkWg94qjK2FQ=;
 b=Qn+3cplLotjcowjrCCHEf7x49g1TsB0C0D/DbkRrSwpesucuTKizO42989BtJSWnwtW3ojX++Krs55j5N4zrh3C3Gpaf/C6uh9dU4Og41fTvXhAy1FHefYNda+uymBY4pcqCbrmlqk9N8fYBqDpd/Egar2szObFgvkCgK4Ur5QOcmzJzTOQ5rY5/kQ8DbzRCpgiH846SZWXbU2qvgqHaeoCagDCXEEGQ2+ipn/NJYWTX8588pPV8J4NNgTDHCU6PabKEb/EZthsFFuMfRvhBPYAJAW4isXg3DjwXoNkoW0DgM0josv/kaQRzwtk7J42YFde1qbh+AO4BUkqG7H0apw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuzxeCSRRaPXN0mZvAVP6+jqOPXPGWxXkWg94qjK2FQ=;
 b=PJ2fBluFgL72UBLjnVmhUJP6LwI4JY9QV/iIFyAmeFHx9vOpOQUAsR/8hflc0zq4c9L6nm6QQRkCiZcJo8oZJ17814Yx2WC6xfh9WiS7TOjt6HT0aSC/ZsMnnhm2F5eYGoHZwSzGFW5VfjmTpBRrLVEWe5zodykhbKI/5SEwWhUXP9vjrmyNDnVXaKtmv3p2HuUJwF4uf434o7l7Ka0/gOdD3PHS+82voCVjwTHUs+G961HSKvHGyj3SHR7+Rwxn5Y8mFf3COsFVKlV7n1al1NatKMUywVh7vfofFh6/4zOgtSdDxD878Kv9VCMC8xMShvd4QMkbyIpmrzHjwCvlww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:12:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:12:25 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] sched/debug: Add support to change sched_ext server params
Date: Wed, 29 Oct 2025 20:08:44 +0100
Message-ID: <20251029191111.167537-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c52035-1566-4ee4-5839-08de171f1884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LzP/whBXWjP/IShIk57WD9TBilg+6Z9Wc0iXOskxZ3R3nkD4AT6TnEE7mXd7?=
 =?us-ascii?Q?wCx2o6e0P+68j6zofLQAJ8woQrr8h7h5H/0R4EW4NeqT3Y0tS6nlnQmOLv4W?=
 =?us-ascii?Q?WHF0ZLeOr5+FjQUACfGKVn0Lvhk0ThTFZNxlViJtWDG3VzQkOEkrCxrjM0sI?=
 =?us-ascii?Q?uCtT0wXQBj6D1otRJo4jlhxEeZIUk7dtSUjd3gL/owN+na6QvnEJMB7eaD9k?=
 =?us-ascii?Q?t3TJFSSFnE+x3b0qfmp+629F3V2zVcVLk9+xywdkJPzTZfE19R+ArJFFS1nL?=
 =?us-ascii?Q?PNy57Q4JWKcuMnwrHX9vW/NWJ/jxf5NOdstVthgmVV7osmMzFw4oB5beIc/z?=
 =?us-ascii?Q?P+PaWJyXShCAOXk4YRkWXH9HHJ/eQyDAQ7skQBhD9Q8t6E9ZQYqiQlwOwaQT?=
 =?us-ascii?Q?6QrfW+RfO/6Ytax9WWf6UoNA8MYOrR4B46wYmz7b+gNEz5QQ4MKolWF9AJFh?=
 =?us-ascii?Q?8ohAi1h7Spwzdx8XneVWXM3JqcpXPEq9EvKeHX7L4Oa4VeZNKS00M6WtGYmI?=
 =?us-ascii?Q?etvcHSd5h8BS9G1RSygTZfKQHNTL4aB5ZqC8swGpsrcMqu9GFmInYaF7PJzK?=
 =?us-ascii?Q?A4yYkev1Uu0A2Dc8u3/vmhvi22RgJynlFCRk138KWPpLFE6qhqYOk2nVhB/O?=
 =?us-ascii?Q?vq3xzgyQMPxByzc4mWdLwwFLwiHj0sJli5Yzcn3oBtm1151tnfuDHEyrMozh?=
 =?us-ascii?Q?sfQ56N7Gyu9pgtqpo/hcmMLMi7NQH2vJs5Xcsm1/zh6GNxw/GaSiHLGcOg6E?=
 =?us-ascii?Q?a7REfj7ThWsP1NNdXVoKrlhLCJQXFQY3XZwfwyt6uiF25p8HHD60VkCeWQM1?=
 =?us-ascii?Q?ONkQmYoKKScHzY6bo3WU8JSPgPE4TTX4NWVLysGcC7OjgDXR69BYqVp6e+qw?=
 =?us-ascii?Q?ehxb4U5cNiThotAz+/M0zpZU0arHv30zGvK6mCtX6Tj5RbAy15NvANE0Gf8I?=
 =?us-ascii?Q?PG7rTCpXlV8Y+EO+K0tsNvaWRA/i6snm4ERUDEPa53NqikJGjUxo6qlmiyg4?=
 =?us-ascii?Q?yqJwBcm2DLFl+Q28Qa5TfiIZZYqshM4pO5sruGy1wS37cSfZgT4C5M4BvzFn?=
 =?us-ascii?Q?3c+b2G2OpxrvWNJ3BuebzCHVWXjIk4W1Isat0OLY+tDLsRekUdVhvqB6dDQt?=
 =?us-ascii?Q?ZJz1tU5VUaOSud5W1sUCi7BX3Qujep0vNqp+OYV3jbRlxLijExoFcpWW9BPi?=
 =?us-ascii?Q?zuGfcKmuX3iX/h17B6AwG1eB1b4MMD0Rbo0ChWBION6VFJVEjav6zkPBpDM4?=
 =?us-ascii?Q?GEkHfAmUhq771XIBNnoypw1vFM9NXYnRARxArNXKWiFcTOPJVMkr9KKd+8nH?=
 =?us-ascii?Q?o/TluBEProHdQkeFojssbqd8MQl3OBFCC+U5oyRnKVwDcJ2mZsr+owy9gWtf?=
 =?us-ascii?Q?+cOQBndjB/h0CUIlLNA7AEDijMRSzrCZbrwZDwgZwwV4JZW8cDB6DmXYrN6T?=
 =?us-ascii?Q?NDEV2l8MK2idS5mrz2gxpzQkchbJZ10c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JLFt7urJa4IAbJbFxEdc+7CFeYFR5PqOQlkT9VvLI4DDDcA0rLV30Z7M4cea?=
 =?us-ascii?Q?RlWnVhQmLBdIUKDGL9JlbMXYmKn3wYdlGLXUAgeiKejPgpdJeM6CKnneYUmp?=
 =?us-ascii?Q?xtE1Z8psOuqBhFM3yL9EJ8y1uo1PvDAjGx/OphZw+cfDqc+oZbrcQzxRGkVY?=
 =?us-ascii?Q?x0o+SKmX4m38J3WGJw9oZ+n0GaMTVcq4cEhHMVYxDa+hfHtZFRXs+7WTigc0?=
 =?us-ascii?Q?8IHkhiJkohnAjHkt4R4pGfdtEJEJE9IwXekXjW8PWyvLkL+Hu0T7y2KVgMt/?=
 =?us-ascii?Q?0S21ujlMEjudW55TPAD4Q6O2NxhUBgIJ4fAKyFOrEgJS5gkmoIgizONlEyLN?=
 =?us-ascii?Q?1l5R24sN1odLnMS+ZQDOfE0iIQni/jjxpP1Fp0dBYP4YX3zaxGKqbh8FgiSl?=
 =?us-ascii?Q?UrAb6L+D8MLiPVk8F3k+aL/3gyfDtSM255UOZh80ipUIlseyw4TbzIaS+yJ2?=
 =?us-ascii?Q?C0o0Dwa7/+edTVZ/vr/FPMcjHtiTdVCdza4Bi0mv67/nU869qTlv1bOaX4SE?=
 =?us-ascii?Q?xecAdd/xSbZbzPpntKf+Gu3XIAXHNpL/3wJyHlrAVJQVhK3knli8+doyVTlL?=
 =?us-ascii?Q?S7J7BBLUCen/jgR9A19hq+dTNf0STObHy51GeIcik7V+ksRGt0NBMVM9/KbY?=
 =?us-ascii?Q?+yfZVtDYDL47qvGnfCMYhvVDaH6L5ucE2vmwM/Y/FPFceFWbJ27hEFJXTinv?=
 =?us-ascii?Q?h9Bi6Svohzg451HMj2aiUp6Rx41okbRqGvj7AD2eUuae7sGmCIJQLmNhFINd?=
 =?us-ascii?Q?Zy+Gakma9JyyyuryTbsrWVZeSiewYeGlgbNPITie0JgdnV93i/upH3eDFBLN?=
 =?us-ascii?Q?7ymdvks4jQMqkLaZbYgyHUhpQANZwpmkpZVCMUnTi0qf/TxaoH61x70QR1QS?=
 =?us-ascii?Q?S9jZQO6impHksXHvyohO/l/iUzj7+tJ5VG8rZw1uHg+hw0XzWZfz/sjtSjfu?=
 =?us-ascii?Q?SflPBWOckr/0HBWe6anlGfzzonoIFQP+cEcvCpRUNjR0v9Pb6g6OWjMcQ3YQ?=
 =?us-ascii?Q?C6mOQ8sPE7EqW5Fdca2+Xg32efBIz+e/wfOn5GNqxcfJLRjFlo+hSfu/34pV?=
 =?us-ascii?Q?eRTDfYU1PATgafOUlYbd4yyQJgyAgolp7jlTDRMU+oNIJx+BeWJqU+xp420O?=
 =?us-ascii?Q?8rCY0a1f6O0t4gapqdq2lClvup9+AqP+ksXIA9yLuXfcRu4uSxo5kEXF2MDa?=
 =?us-ascii?Q?7suAFSpneWbtBd7iM2kpCt0+QPzG0XdU/d6AS2ofWYlIkgKmaoCz/rUEaLWD?=
 =?us-ascii?Q?TzV81tZLDHTKs6GWOHTvEyfNbdD/PJaL5PYDTQgbVhRpvHkHOj/w/cycWMD4?=
 =?us-ascii?Q?yEv7nHPH7f1+B2+pf9uDz+fmtW9s7MmhuaRhlWEBcIIPsEb0VKcFW0Ehqh/T?=
 =?us-ascii?Q?5qf129PO2a+32ahrooIHZxyxCVd0XfzYExk9/BDUeQEypwRLa0VmyoY32dwG?=
 =?us-ascii?Q?R/M/ziOEnH3dOU0yziqfGCKFgTmaAuz6/2QqRKqctaoqPuQdog1Wue1rPeg3?=
 =?us-ascii?Q?Qm4XAQSQq5XmWs7xVTx06bLUEv5apNzn0WzPZHkdf4516PPUHQxyDjkEj7+v?=
 =?us-ascii?Q?Q9r7X16aPg0vMxPa3hLpw312YAFn67oseXOVBl/A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c52035-1566-4ee4-5839-08de171f1884
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:12:25.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi83XvRijzUm8LqgTzvodBTLAFWHN4ttXuRvNfyjU2MCAT4qUTACNQ6z4xwSdxTNWD7Nt3ZtBiL1NvZL6re6Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

From: Joel Fernandes <joelagnelf@nvidia.com>

When a sched_ext server is loaded, tasks in the fair class are
automatically moved to the sched_ext class. Add support to modify the
ext server parameters similar to how the fair server parameters are
modified.

Re-use common code between ext and fair servers as needed.

v2: - use dl_se->dl_server to determine if dl_se is a DL server
      (Peter Zijlstra)
    - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 157 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 133 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e71f6618c1a6a..9c2084d203df5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -336,14 +336,16 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
-static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+static unsigned long dl_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long dl_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
-static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
-				       size_t cnt, loff_t *ppos, enum dl_param param)
+static ssize_t sched_server_write_common(struct file *filp, const char __user *ubuf,
+					 size_t cnt, loff_t *ppos, enum dl_param param,
+					 void *server)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 runtime, period;
 	int retval = 0;
 	size_t err;
@@ -356,8 +358,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
 
-		runtime  = rq->fair_server.dl_runtime;
-		period = rq->fair_server.dl_period;
+		runtime = dl_se->dl_runtime;
+		period = dl_se->dl_period;
 
 		switch (param) {
 		case DL_RUNTIME:
@@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		if (runtime > period ||
-		    period > fair_server_period_max ||
-		    period < fair_server_period_min) {
+		    period > dl_server_period_max ||
+		    period < dl_server_period_min) {
 			return  -EINVAL;
 		}
 
-		is_active = dl_server_active(&rq->fair_server);
+		is_active = dl_server_active(dl_se);
 		if (is_active) {
 			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
+			dl_server_stop(dl_se);
 		}
 
-		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		retval = dl_server_apply_params(dl_se, runtime, period, 0);
 
 		if (!runtime)
-			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
-					cpu_of(rq));
+			printk_deferred("%s server disabled on CPU %d, system may crash due to starvation.\n",
+					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
 
 		if (is_active)
-			dl_server_start(&rq->fair_server);
+			dl_server_start(dl_se);
 
 		if (retval < 0)
 			return retval;
@@ -401,36 +403,42 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	return cnt;
 }
 
-static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+static size_t sched_server_show_common(struct seq_file *m, void *v, enum dl_param param,
+				       void *server)
 {
-	unsigned long cpu = (unsigned long) m->private;
-	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 value;
 
 	switch (param) {
 	case DL_RUNTIME:
-		value = rq->fair_server.dl_runtime;
+		value = dl_se->dl_runtime;
 		break;
 	case DL_PERIOD:
-		value = rq->fair_server.dl_period;
+		value = dl_se->dl_period;
 		break;
 	}
 
 	seq_printf(m, "%llu\n", value);
 	return 0;
-
 }
 
 static ssize_t
 sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_RUNTIME);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->fair_server);
 }
 
 static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
@@ -446,16 +454,57 @@ static const struct file_operations fair_server_runtime_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_runtime_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->ext_server);
+}
+
+static int sched_ext_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_runtime_fops = {
+	.open		= sched_ext_server_runtime_open,
+	.write		= sched_ext_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static ssize_t
 sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
 			       size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_period_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_PERIOD);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
 }
 
 static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
@@ -471,6 +520,40 @@ static const struct file_operations fair_server_period_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_period_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
+}
+
+static int sched_ext_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_period_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_period_fops = {
+	.open		= sched_ext_server_period_open,
+	.write		= sched_ext_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
@@ -494,6 +577,29 @@ static void debugfs_fair_server_init(void)
 	}
 }
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static void debugfs_ext_server_init(void)
+{
+	struct dentry *d_ext;
+	unsigned long cpu;
+
+	d_ext = debugfs_create_dir("ext_server", debugfs_sched);
+	if (!d_ext)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_ext);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_period_fops);
+	}
+}
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -532,6 +638,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
+#ifdef CONFIG_SCHED_CLASS_EXT
+	debugfs_ext_server_init();
+#endif
 
 	return 0;
 }
-- 
2.51.2


