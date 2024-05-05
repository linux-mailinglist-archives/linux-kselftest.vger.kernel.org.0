Return-Path: <linux-kselftest+bounces-9490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B9C8BC417
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 23:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6112812E9
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D698136E1E;
	Sun,  5 May 2024 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SlD/5RPP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8C2D60A;
	Sun,  5 May 2024 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714946213; cv=fail; b=urqMb/o49ZQ6Eau4xB9Pmg91E7zMBJX/8iTTApZYQxLzrmM7RdzeQMKEqQCQk4CKd6fahydC6FrlnV7/a9adCpysRLH5EwKDaDSnN4SLEs75KhhMGaNVejuVxXxoSCtMobfpfKsl5AbxJdHdnQ2QDrneG6b+IAHCAlTFrfGn2TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714946213; c=relaxed/simple;
	bh=fBIm/dbmd9D9h6PDhu33+Fxf8X3zUDO50GVaoK2NJXw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WjTG9OxaNUFtz4IZ4Vt8HeYGeQZz54UWNr01idCrWnBkCMfpvdnhsBiuADNjaC24IabN91I66P5x6eBepah04mG/v+cBmyMAeC3dcdYnchQFby1O+5jDdLs6thrl49mHiisReJY4dhvJb3rg52RSrczJHZQVmM464V5a3ko4X4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SlD/5RPP; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSmvIyS5He7YAPerOu+COP/5cDLWx/RTwsBCFDwucFH4VQ8OaNH/lUHf8IYxdOZFsxV3wu9Y/0VTd7mMY+cLmxsUrtx2s24h9pyq97oZ026Az4tmjS2PuT5952uIWeOHgpxZm9ctiCZ5dmknH0QzoCeouI9uz48dxKiPhgU/vugzuhmNMtJhtihxPX2AmvAaixM6qlzu5FKwbxmRSdJRtaMjb1Y+Vjr4wnTaiMq+fe5+aFWrvp7wGkTA2qD4Igo/cp8sjpXvSFvT1zC0Mt5zt0+0ESEe4Th61Qb1FTMVc0P+SggHA97i+4ZwZSvjhxIfXEQgjUyCq9r9c3B10Qd0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUJ3ruv+gFeVCXUTDukxioEW4ZF3Y2kRJJo7siZyFUw=;
 b=a6YcC/SY9Htt7Ee+pfJq9BtUknPG/ULSCLVs6ZGg3ab07yGrlA5iTqsKEBpmYp7x41oOv6U45lNA1uyf1ZQLyzCUbt6TcZhwKaR6bZmYFrTfcUJwdSyOud6ve31hxYQGWS/qb44uq0TfRlHdWl7Qh4Ue6tsA/sByu/+YTP4UfYXuvW8qWhQsq6Mr34PT390auaArsx3Fod59I13BMT1vm0lgccwLrwDP4Y22gYUIOdHXJaBzyeAOul9TO2QH1KK/TnH/YLXfHprVL0R2NwLRq+QGzGzG89Lkhv2MMWgAPbb3K8lDKL7Vi1s13rxnxnEOUtHGyLS3uORwP7deOdjlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUJ3ruv+gFeVCXUTDukxioEW4ZF3Y2kRJJo7siZyFUw=;
 b=SlD/5RPPo/HjmNZOjKo0ROTeW+al3NBACOu79CRcuP2QPqWamfd2Kigw0p+WomcXMWaYvoPSOksRDKmxcZ7U0rQqwyo16YDRtpQ79Dc7SIRruVz9f5qlTgb62t4hnpiSMUR9lIK8lIqzQEo0tV63lr62wTp/41KrdJUJK82cRMmnU20zcPHqLvLsN2bs2qxQRtSEkjOlmkWI05ohn8d6alZbUcsQIrdKIr1fYOf4L2OcUc6DICxDrBnOi9ZY4I/paHM97Bys/50Q2VLKvyQ/xYl1nLQzgF2FshgUesIwSiMgilM4b/4ftA36a0FVvJEhyDDIaL14glcZ16NRU7XTxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 21:56:48 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 21:56:48 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Joshua Dickens <joshua@joshua-dickens.com>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] bpftool, selftests/hid/bpf: fix 29 clang warnings
Date: Sun,  5 May 2024 14:56:36 -0700
Message-ID: <20240505215636.63592-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::24) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a03d6b2-bf5a-4d0c-4519-08dc6d4e42fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AuPhHoFdhk/ki3CRNRAnZR2SfQogrW7Bv02RrSPdW/xx2gWwLCSgNp7/9P/e?=
 =?us-ascii?Q?w7xnox6lBseAB2kvhf0ZKhIn+cVuqZK3tEARYd7DBV8wvsIAMm2P7f16eht7?=
 =?us-ascii?Q?wkcoucLNy2+fGZdUM0jtnGyGlR6oSg40JlvHkchpPf694nfcaI/Tn/AgB8Fq?=
 =?us-ascii?Q?GWV3BSLBEaffXlSRRc3AAZUptCURodp9NGP7Bjq6trPS+pUS+hNy07UGR+8N?=
 =?us-ascii?Q?SDc38yiZoF8xl+jG9VahzBv4zyUKKMFGW2IcuohrBb7gPPQQ5JrYnvU0lkfn?=
 =?us-ascii?Q?kMUXtyMeNo3l6teDplKGfsILvVQ9P+yrIAcHtfIEJKC5mUoT4+Z9XsLENfG3?=
 =?us-ascii?Q?zYsjn5FyuhVugPMfZCAz2jI/hvujrd4/c62oQ/RDmmhhwCio1IX3lLBZcREV?=
 =?us-ascii?Q?Etp4ENQKty+KqSAtLxbQAK+7V3s3c5lvadhirOs4mbOzAY1wN0L/QmblYBhA?=
 =?us-ascii?Q?mTAlIuPZRQMzI71X4kzdJx+5N6DooFTlfeoARS6+0oQpXvwBYBfxaugJiETT?=
 =?us-ascii?Q?B32ULFuMG9b0lG9g+X2th0+Djm9uxyqfUwcC2wliiBo6TtQrGWTW1jrpZ7M2?=
 =?us-ascii?Q?ds0WeuIxd9LSo5hcIEt3xCsd4QDWXQG8MsaHFePLxPzob3MR5s7Jk5fotapJ?=
 =?us-ascii?Q?ptL4U2jSYvhcKiXgemS28vkOa364jMjyA81wQSBu4KEpd/0lzsBRz0ImeKuH?=
 =?us-ascii?Q?61OFm590T5V1wdiGPgg8BC99PRKSVUVpsQfbnzONo1RUBMtkpWJJSkYYenCa?=
 =?us-ascii?Q?j6P4YWw1Lqqv5XOMv8K66IJBV7LjTQwQQl6yJoxuUdj7ZvHWiz+fZW46ctel?=
 =?us-ascii?Q?rnaWPKZUux0uPrgwuUn3jTIYMr3B4OWMgJDa9Lao0eJJGEdtz/fiG70zpIc9?=
 =?us-ascii?Q?+bCruwhg6+BhlibGmthIVq5HbZKbKNILpKcwpWwclwZ9Z2Arwhbz0R4ECYFb?=
 =?us-ascii?Q?IsB/dde7oomEN392IPW5/dtANTQ2/S3TtPEEo4++h+bLMlKSul9bDSZn10eT?=
 =?us-ascii?Q?95iDMm/+jKNTXUhHacdO6WvvIxvz4/KQ6hrk0AfWqyc3fuHNyKsWsy+L/y9A?=
 =?us-ascii?Q?a/WbqZDW1ahUZBmahRcn7vXpFFRE1CLDaZZwLo1jHIimL2cj+CjIb+eaytUh?=
 =?us-ascii?Q?B+NoO5kr/mk24WXN/IqPgzuhrR+BFXOMNJZO5LFJcs/ymxjAk4yLnXrOIS/p?=
 =?us-ascii?Q?gHmHgtYiHRCkOd247+C58xFlli4iuQzbde54TarTL7SMzKkCU/QBIzgfpqkx?=
 =?us-ascii?Q?deAXcMWN1kYypQ8QiEaY4iqCIyThRmH1qyjHEN5MQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+BvI927ZtibyJrrnwUmC+jubUmjksn9AmVBr3dXMDiLjWjwdm0arZh3ArQQG?=
 =?us-ascii?Q?m21/nN+3FJPTu6W73ZYrrCPXwzRcdAyjN2psLJLE1VmG/YT/mrRYb8UlUo37?=
 =?us-ascii?Q?vq7LfjaLFEZdvQe8csP11AlG/sxb/F3WFcwqDkAfPYoGnE8+kC600obxqhi3?=
 =?us-ascii?Q?BYMShrozLIWzjv8Si92n84UtEyRj59Yydh5qDeeSZUo55BnfYhOvkMT6HLeN?=
 =?us-ascii?Q?XuVfbJqdLkRmiUqyWuJnd1bO1oaCQ74+rt+IvmkrsBiX4dE+8qFlSghPXYvR?=
 =?us-ascii?Q?ZYLODHW3duAIkCXmcO1Uj6gVzvZUy/AeWpF0U2CD+fAEXYP20IybSOb8jcCe?=
 =?us-ascii?Q?Dlgya2Dr5BTjKYSU5Hutj3Xa0WsE2rXnlC/K7FzUJ/meaASZjPR9NUTGzBAv?=
 =?us-ascii?Q?xJJaAb2j7fBUxx1tN/MshsnAokgO+ZcuoJqvvNTU14xIBFDpKisKnEpMiZ9k?=
 =?us-ascii?Q?lclPTajDdsvz4DXvvCOJJXozsVMFUv/VGEcmJ5tG+F0WMVGoqXDA7dFm+m02?=
 =?us-ascii?Q?/S1PlfjetZwGd06UJcf/OcLtbEQZPoeHUM2kQTUlUzrpNgNS3Em3xnXs3TUT?=
 =?us-ascii?Q?FQHVnNAsPz5dON4/0GBJqfWCaUNG/Py2YntrfQBHaIgCgxpYNKSmJzuBZmAY?=
 =?us-ascii?Q?75jZkNm0bUM/RsUDoJWiA4CYro6JL0AVWXPFYLqlrZJb/dEJCSkEnR2HxwAH?=
 =?us-ascii?Q?5JhWfU1S/Nx/oD81d+8a/Vm7gkiJyhna9j4phXnc/TPwzG2EUQrsrQBUk0PZ?=
 =?us-ascii?Q?GCmxYyKJXBxQupGWCwU3BNHssAT+yAFosG3MX8UR6MnME5dCWZCthY19iFEs?=
 =?us-ascii?Q?O4MKxywEDQY+ysAT2zRbYlRVEDq7ijhNeBq0ePXENaKr8lRk5OAkwSLo6h7+?=
 =?us-ascii?Q?CmJmvX6hnZZtNgQ8kpwYq80TDDCXMzuGHwIX5Qf6FXr+rcTkfSNDbUkweWIU?=
 =?us-ascii?Q?AP2D7uT34/diQ0th0pFCfoVeUwET8dkk/wlCKMRBPyww3oc2Bg03ZWQp6+dM?=
 =?us-ascii?Q?CWb7Xi8Q1ypG8X/dA6eKUqTpqhsnt6fmFvsKT4mCUdyJkE9VWLvmy4vz585J?=
 =?us-ascii?Q?VvyW9ZRRmr34zPQvyMQAyOoPdJUYhKquhzuQrykX/s3piGs+iqpZaOXifBP2?=
 =?us-ascii?Q?hun1qh+WuivxNQQ17qIU0vnHxNTaMIYDpVU3IATv5gXJodIRKBYCFkA/so7R?=
 =?us-ascii?Q?DrXbuLWdU1Y8A5YicIDoLtujEzOq1ax9/0LR81LQ7GFiGxhFQt9trLhFV8Tl?=
 =?us-ascii?Q?eTF1A0kCnl9fWYSI6AzrnCgQI0fqQttqKAIrFR709WE2Npbl0thcXJGIEI+1?=
 =?us-ascii?Q?1y/sZgBXITr9HHDT4e1DuMpYh7UXUsbuItU1kTluX3tvz7AaNrbhVVZXA4DQ?=
 =?us-ascii?Q?6IjzWMgJcC4CUBpjMEazqZ230z1fHNiOnnHXGjCJHHNyhnfRtXXxd9RJYdJk?=
 =?us-ascii?Q?FfnZhhHIl3N+jTkpTStno1ZnsRjEt+lTx2iOZCpcAnTHXZc4FQBx6/NIDIy/?=
 =?us-ascii?Q?FmM1OOzmBN7ZPDmN5oK5H7lhkgdd6lMQMLvaWhVLseGbbh78HfXGOO++ap4C?=
 =?us-ascii?Q?0wjub0+PhCchaAbwb9HwIGyVCoBm93cV8bYxNRoD7shFUDdDoVKbfUTMQeWm?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a03d6b2-bf5a-4d0c-4519-08dc6d4e42fc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 21:56:47.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go32feFVmAO679TObEYITs+g1oVh2JUs+aCNlZMPsJ6KwpQcQnT4lOYM1jjhMjKKIiZ/j00t7gq92psbDTpx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

When building either tools/bpf/bpftool, or tools/testing/selftests/hid,
(the same Makefile is used for these), clang generates many instances of
a warning that is useless here:

    "clang: warning: -lLLVM-17: 'linker' input unused"

Silence this in both locations, by disabling that warning when building
with clang.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/bpf/bpftool/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index e9154ace80ff..c7457921d136 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -133,6 +133,10 @@ CFLAGS += -DUSE_LIBCAP
 LIBS += -lcap
 endif
 
+ifneq ($(LLVM),)
+    CFLAGS += -Wno-unused-command-line-argument
+endif
+
 include $(wildcard $(OUTPUT)*.d)
 
 all: $(OUTPUT)bpftool

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


