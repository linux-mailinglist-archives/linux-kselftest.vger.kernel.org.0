Return-Path: <linux-kselftest+bounces-33183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1C0AB9D57
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647B6189D65E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651FF5CDF1;
	Fri, 16 May 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GVrFyVJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4911CAF;
	Fri, 16 May 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402196; cv=fail; b=ab4sf1ecVaH0cR3MoTXxNJq/2uqio+4tRO0SomAm7kUdvuJX6++Jaq6fsPGQYcjKk0zycBfPX/6XiTctSc8+PKELJtPJn6sJQUp+H3Tg4MXcr7Kz4rW4Mw9e78I/hM7uegMySCDUi5vXd1DzyrecCSyxwjv723nXw3j3CQKVFr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402196; c=relaxed/simple;
	bh=vltkiy142PNFxIo0/4BWqaqWvID/b0evO9SlCg6ax5k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q+pNlvc4JQsWLV01F0IWHp4fSHw95X9XjVof50v/+9nQ1+1U/4cFJ5hl//wxJd9Z6ytI1WYPG2QFRMdCjyUfcpCUSfRlq3XZ5xhVKtVVq8c2x0y/5NZSXalxuUuF608bbN4sdKa5f/PJmyQkTX4LM58lA46OTrMjob1Yj5AdjrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GVrFyVJV; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cY/L0cOnXWjVq6VhGcyx5raqHmfl6FpgKYplylmP062a0BG+5xee5+juFr8Kjdi6SjzZSKMcZBJghNRvxpgrG3tNgTGX7lnQLTHl7dVwqmikFtnV/2nr6vtwIMkVFz57PTxLIE9FU5ABmhw0DAeo7B+GL6NKLt1CLDcI1sEfLtH2cGf7H7mOnbZk1NLKfj4Uhx/18zHLwzHYm3BhF4bVzjBWvz+hoFJVgnIn9Vh6r7Coc7TpL9zbXlPjQB0M4kbmIDT/ibgj0j0MRrIZYUe/PPBKMwDVK0gdFj7NcEhw73awo5nTyyd8r55E5YlnwnVYnIzK8CxU6E/SAMOKU1Gw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbluxwrGfxsOVzqZEzz8oz/5b8juWfO0U6LjdOCs/Cs=;
 b=tYe3GOw97QoW0hwrqC31wGc4flrbV51CpjJ/IbxswOpVIpSDMzpMvZiHiR3e9m2xV6OzbIhTT/x5kHzWUMpg/Jf0meK0U63f4eaVZ7SP2RChZw8VYLKUMDZgt9HlXPtQQ3Ao7CRFnaru2LLDTM2Ibh3qyqiz9J+6/IWSHYuNrsxJ0l22i9dG/r4aCDNYq8fOvPDVtWVQgRNidZSXuXAyx8Y28AzIXebKU6N0lsD7Ab99LL/1Jr9hNnqRwEz9LKlI3T0tg5zEdX0kKB3X6kJ4sQAs9Vk8vnts7DlNj+RwEZ3LIIEk2q01nIwvzV9jh7qo58loAl+OLUXDNYi6DLa4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbluxwrGfxsOVzqZEzz8oz/5b8juWfO0U6LjdOCs/Cs=;
 b=GVrFyVJVK02EJ9l/122BuhcXX9Wg9D2WtFhdnHuFUzHgy82Y1Ta+CRbUuDNabHldXOtMEdhXwv0xvxP+9MGH8AGxpQ3ipBalLxOYKtFT4GXRLgZjVEEZ8/5TNdXS1xm4s47HkkOYmOwIdeqzKvT76bf/Xxc6KhaPZiZueAojy3vxWCSvV2eeA/1oAAa8s091bCCU1DTEyOpJ13pvc00T09BxDiJ2WebnYffN5qPkQm2jXHCVSYxvB/GYXbaNsu43/4sEI5JcpSZ4/3V6u0yQdnQ1W5vHg7ou4ijzWIonmw7wuskirjZMiCj3VxDJrtytBguTGGnUxV51LL9ZicTQzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 13:29:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:29:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: Pedro Falcato <pfalcato@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adam Sindelar <adam@wowsignal.io>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 0/2] Skip mm selftests instead when kernel features are not present
Date: Fri, 16 May 2025 09:29:36 -0400
Message-ID: <20250516132938.356627-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:408:ec::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0ef568-9478-44c2-1db9-08dd947dbbd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G7qXP61gHJbxarM/TTCacIsthoSxKLgGFVwoXbzYlgo6vHWqatLa9b2ITju8?=
 =?us-ascii?Q?KUeWMo9H+lGIMUTi0yQK8NeSPxKl3fxe/7vMeyI/78vDlrwRt6zO++j33i9w?=
 =?us-ascii?Q?hDc6+W4iK/bnGXPC+pQC9JTbrGj0JaL9vsps+FYBZEFISPEoqC3KmbtHsMMl?=
 =?us-ascii?Q?49R5sfq1OpQKWFMA1s9vUr68EZCm/MeKRMWRE8cfcRYLTMK+KvZ2ar5LfWfb?=
 =?us-ascii?Q?m9m5jW/jSEoGUFRaxjMEllNatguMAMnK7jNCariRSAgCeOhy4WbQ2hhf0ACp?=
 =?us-ascii?Q?MOh16YVx+BOw8nfCTI98WhpJgwXWXS+QEGK7XFB2GahG8yeHljuGdDiOUgEs?=
 =?us-ascii?Q?T7yWkl4NyrdRDoxhnvs1lKJoAixY6UwP8UNXoGAA4pMLTQJ7lxb/jlzBVDjP?=
 =?us-ascii?Q?ELZHxdI0IFAkCH8oWuaeGa05kJ+qLSg9HnyFIYDa0/RkTYvHbS8ik2owDPUi?=
 =?us-ascii?Q?a8kk5tWZNUc9K7nD7CDPJQMnc80oPiK61kIS4dU1H1PSojqOKrRa4Z4Uhthv?=
 =?us-ascii?Q?bnG48hjrk4n4VUr4+VgFwhGhu/eKR7zOdyxCGopX6QoeFnYy49Cjhx3JVXSA?=
 =?us-ascii?Q?dpYf92fmEIB71M2JMKwaZwLy/npP00VHkHGIv44zmpx2FQao6ag/4G1j3lgS?=
 =?us-ascii?Q?3BRbTQcem6f6GLmRgxrLg3fZfMPlStYPV6M80kwglqs2yWkTKhZSAzPDT1+Z?=
 =?us-ascii?Q?3ICT0YP8qO5mx6m/v3MFWf/8klHj4Eg3hxLolIvADaquE2tPjBAHe5kvAlZj?=
 =?us-ascii?Q?pJk7zo+hklTmty6O/b51iQYteDbgJN7UufrgBQr6ULPolaeoX+g6t8pbi/5f?=
 =?us-ascii?Q?vDbR0qpC8neG8qUlLVkGfdKf5hq3DWoim4BUC30LxdaGjl3zsEQrDRgmFCkm?=
 =?us-ascii?Q?fRb5Wc5v0rHgJ+r8PbIidzJtM7oAQJwEZWO+n2Sg4p5mW1wQOp+RgZZjoAN/?=
 =?us-ascii?Q?wJR7FzJKfPogsAhSh43j/kQ0vQ9oNJMHpx2T96KWi3du5yATn0MZqXRX3zXN?=
 =?us-ascii?Q?Rw69zm9tV1SKF1uVzUEhJ6csi9g+LAUK1GDHK/Z4DtHqyVJru2WC6VgLnrTp?=
 =?us-ascii?Q?QSO5CnTO6h4Y7MbyZk8Xe/N5GPpKklfBnkUAYhq8zhfopaxUsEJ/dNKSSdcm?=
 =?us-ascii?Q?XLYh9DzSZrzeiXGLkxYVNkUYgvjr8Vhvn7qMEEsCX49qxiJINVbGAELBysgP?=
 =?us-ascii?Q?CIhZEstMWpnCiBEocgAbx4kFoSn6nNO/LkEaif287tpgHsd4u56YpMQnicpO?=
 =?us-ascii?Q?R1nJ5jFi1zi/G4ZwjwbSexnrFxDh9N0S2tnHsrdScyufqKcwYMuGHHpSFC/Z?=
 =?us-ascii?Q?XFDWy/yOyhQsIXCRhglUpJ0YOjYxJHjDHbBUpUtjkKphHnBW17ZiWoaEqwbE?=
 =?us-ascii?Q?+QRJgXYHHu9o+u5h7D1/w/jY33ZZqKXcETyvFtFWIA0coL+PKQEidPPzdVQs?=
 =?us-ascii?Q?3zRriNae8ZI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fMuKsvdWw/K5WwkRMs0gkloNG5RDa/Zej78wb3YMatKM7ME0AblJ4IT0gpga?=
 =?us-ascii?Q?ZaZVIZRcBrCaCx5Gh2VJbLN1k5+f3SxPv+wbuMC58LujfcwwF1Z70aDDCOwv?=
 =?us-ascii?Q?4cVEBlp+XoYTC8WyUFed2mUwFVo99CrZTHoA8F70BOpZRWoDJFs4Pu4baizj?=
 =?us-ascii?Q?3cwydYbZEY5cX8MET0V8JKTXKiC/z1pzHlCtGvst19waDThxUPq+qTQLMZFo?=
 =?us-ascii?Q?6AgAEcSYysRBBwa+DnaiszHHjAnDGr66jD/iN1oMTzF65g5MoeDis2G0pbXF?=
 =?us-ascii?Q?G9kMEYICexAE8MB3rgyWTbAJAzgLhsmZS7tB0JbbCs01+N/uMhliVsq1urft?=
 =?us-ascii?Q?2VZz8ovbocbNZb+J0bnzfjmGa6ZWpXA+o2i0Dxl7iEnkZPPkDXOJEUVvjrOP?=
 =?us-ascii?Q?DaWgtmWKNq380bHhkK83GDpnsre+GEx5ln7l1zUJ+vZhptcqeoFy6Fv/GZT2?=
 =?us-ascii?Q?K8dx8gD5ktI/Q/f88GEH/hncU3ELQEvX8ctCIhoWQBkLlKEACoy32oqclkRy?=
 =?us-ascii?Q?A0VC22Iku02+clLDK2QlLkUv7/6XO2Eh8wEmA0eEqXc/weLOFvQejE9rMrwy?=
 =?us-ascii?Q?CgmC2eNWOFx+CWrqfkEubPyIcmR3OAj/wXvWzKPged8NA1R7pTYsssXzid5h?=
 =?us-ascii?Q?kqgA+s8XJ7VPBHd/7GU5TrjIkM6kRU4s8sOtwMUtU1k2D81Cy+UAg249BK83?=
 =?us-ascii?Q?vifkiQ/7Q4rw3zxrQcdbmv4TqtST9L75WsBSapiGSKit4wBHnW6rgyB+zqcj?=
 =?us-ascii?Q?sFqZtNT2DF3ExqIddN13cQ9PjcIUzgq6tk1LdFD4OxwXU2qiJ705Nw/RCAu4?=
 =?us-ascii?Q?NtjTgK6e9uJsxntC9ElAi/ShRz1hpPVHyuSnbu44vYuzGIHKVrAq4wYNOZRG?=
 =?us-ascii?Q?B3QsQXw5UB5rQ7RixIX20hGaCSpcO5KVIrnSADMiK3novaSHsUroNWVbHWVB?=
 =?us-ascii?Q?DN4mrHyjTvCppdKzwzsYbRfaiYEvdTxadUv4wNgvuk/DTGufXsVvvAbNHPyc?=
 =?us-ascii?Q?bRyfznD/YVkh4hiy9QZ9yAbiQlZTlDSVoMV2l8W7pyOk8ZR+LoRbjokXQN2D?=
 =?us-ascii?Q?kEsBBVI9o/VHh373xJT8BGnjoT9jK7vrCPInF+fKADdVqRwlKJoMCS989q5+?=
 =?us-ascii?Q?3gm1ZES96lvRYeNSq4tU6PSoqVbPhOVQOBo8nP0FIDLQPYxlALnpUkBpHEjb?=
 =?us-ascii?Q?tCvvUKy+5Xvj9pjkZCxVYRMyT3IhkvUucCZknVT+LJsz9Hutba6Z8h8tU+lv?=
 =?us-ascii?Q?3UXFv8dqeGB3IlXcFzOujD3I/D03zjj4CunWg7IskkCXdxjhP/mGS9dJHQrJ?=
 =?us-ascii?Q?qhMFYDYBy+NmsW5T9qKQ2ifnGU3qOL7bQeMg6CXkxRwzz625l/Qn2wH+wSCt?=
 =?us-ascii?Q?V43XwwlxVjEZ5mXRz7e0hvxT3LyoIJjPFjSCSSAuwy7jToGi+XuQgQPr0c4x?=
 =?us-ascii?Q?RMsqjrkVbL/mPRae5d8n9+0kbJV7Y/vV3sr/N+OwUNNkbsgI+P9PdDdc2eZz?=
 =?us-ascii?Q?JGBP7yCyDllWHOgVDc0uDtaImNIhBeegbGiqRW/3MKTk8TXwr8KE2aVWtcla?=
 =?us-ascii?Q?FWi6f7zuEgg0FYTezBIG5SFo8EUPmPrT2rxTYPGf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0ef568-9478-44c2-1db9-08dd947dbbd3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:29:50.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbYwd6abuevCK2EbWwQB+rEiEx+Oh6s7OAakEc8TSuG5bSGP0PGaLEA1gx1fDv5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

Two guard_regions tests on userfaultfd fail when userfaultfd is not
present. Skip them instead.

hugevm test reads kernel config to get page table level information and
fails when neither /proc/config.gz nor /boot/config-* is present. Skip
it instead.

Zi Yan (2):
  selftests/mm: skip guard_regions.uffd tests when uffd is not present.
  selftests/mm: skip hugevm test if kernel config file is not present.

 tools/testing/selftests/mm/guard-regions.c    | 17 ++++++++++--
 .../selftests/mm/va_high_addr_switch.sh       | 26 +++++++------------
 2 files changed, 24 insertions(+), 19 deletions(-)

-- 
2.47.2


