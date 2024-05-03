Return-Path: <linux-kselftest+bounces-9325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B228BA602
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702EF283AE9
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900082E646;
	Fri,  3 May 2024 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oh1wJjgy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94A282EE;
	Fri,  3 May 2024 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709933; cv=fail; b=c+HJG+blCQAdtRV4E7salEdXTVWdmuhRH1YYnoWduzmyT31nbr5iUUu+m5q4aF0KgEf/j95GAHEOBoTJFi1m9WoqZqKGeRXQN097AXkyTIaqwDvlDrrI/25ozy9uTpV50LmrEvjr+KqzzCkHkxwoYxg/pcz1b3KNNltQNP2ceSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709933; c=relaxed/simple;
	bh=SFnXEf/kT0ezFP8CBnns/mhb97f77hv1Zwt/gJlYmIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YrkO0YI83YvQ+cBFA6244tasbSsFEnBO5PjSZrrKwwOJ7tsjJJ6TIBFl+txHWN9hKcP5uFdd3TcRg3ySDZQ0LibtXV46ahMxruh8cks9nL8ZDtYdlYteOs5o4o7d3go5gzapIjskcXlrm2HcRtX9Nx29hlmoRoa4sXTQHJSxlEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oh1wJjgy; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHdMuzZhfXr0qZ8Act1HI/+y6hIxHfUEjVNGZIUWPu/L1Wty6Vm+KuAgnjPkYFlbwQny46X8yP9oXQAT/KwvnCfJsj+tP2cPb4KQdrjhCw1Q4WsuAw3O3m1uGVTvfwcuS9WqIL5wXPQRRq7fxxfUTOqHt5J3YWwe/gnn1TrzzckCK39J0q7BUQZ5AtV0Bo0lyqm1DUZD0YgHouOxk2z63h5tmImwFSsBcPxqyzc//yVJk007f6bIEmNLpbCYXHBVhgpmov5hqGNc4Qb50uk83iVb0gpj1QNxL1e3tek0B+dn+Ej796uNq/vwuciEHMLvlvJhi+UM6f2n3BmDjIB6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/hQPgmK9VJIMZ5PuBMqilFqbLQj/X6et9m7OoOe+Jk=;
 b=g/MAgecIFF/cx34PuMCK8M046qgXMBLwxSi633gkAIjSrZZs7GRf+E4wZCkVoYz9Bjk6PA/yl5uRyZytxBpmT4IECilXeDUtFfvK5lj42YVoXrEHDY3HslWAVUBRPxMWt1M0nT4Za+uRZ4XUHGjyBPGqETnyxJ2F7KwN7R8EwcgaQg+q63WeEjI5/QOeWw9P4lW1g8ctOnuXLNjcYl7Obi8rp38ioNg+BzPd0q9USH+x6AbX2BrNhgaAX0pltkgaM73rZBFdCQpjeZnqGsvqn0SK8qsvms04hQzj6J24U/rTw5PDVIUOzQVqY/xy7FhpeeE1IAmg3G7GWubd8XNu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/hQPgmK9VJIMZ5PuBMqilFqbLQj/X6et9m7OoOe+Jk=;
 b=oh1wJjgynTRxAjBbE40hHVTUtKT8kL7HyaIi7wVb+M58bXw33wsumpto8jlOKAGEMsP6oS/dG01ctIiD5GPjJJuDxbEvhZZ3Fqeu3RbVeGfDlI8HkSt96QhiuPpPX7DDDCmXbfDWWWy1SnjzAWmkpYgpHUq86J54s3IFIbPTSzQNsfn/faB9LHOFoebSe9NTp5r8bt+K3ZxRIsMHZVx/zoeRIEHFLU9zlHGL83xdnCm855FpssZseKhTnRdwBy7/DKzQ6oSMrmHGcAnJ0JjcrFDk7rYIVY+MPUsUUy1J8Fjqx/OtE7KfdVVVLlDVHn+PR5Qus6JKeXHAWzJauzqWPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 04:18:47 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 04:18:47 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/3] selftests/futex: don't pass a const char* to asprintf(3)
Date: Thu,  2 May 2024 21:18:42 -0700
Message-ID: <20240503041843.99136-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503041843.99136-1-jhubbard@nvidia.com>
References: <20240503041843.99136-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cf81e7-3f88-4dd4-1bcf-08dc6b282116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qov4GhsIc8Xm1KlqC/2WdQfKu2kuCq+RGAQ3tWcxBHdLXCsAKybGYZ7jP4ha?=
 =?us-ascii?Q?Td6Ze/qHVXAAZyhV8KEbz1sXOqSVdrmoUubOxWxp+5aFXYVLfG4b9LopSEN3?=
 =?us-ascii?Q?sFHzfeTwEbIeZOSAyRWxEC88a/F5iozrt8sY/I1G8mQxAopqIaAoZVXL+ZaU?=
 =?us-ascii?Q?wXkwYZ1TFjKJtOlcVXAqaFoctqzyrgTbsqN0R0s7Rri6wrCo8tdJ9M88SUwu?=
 =?us-ascii?Q?1CanWqp9EX+vXLixjkcwUA5HIgMyMgEHpxGSyi49J5rUrq5HKUt/zEkAFuX2?=
 =?us-ascii?Q?iUJX+TYlBtAKrIZzyn9HoR/4MV3kBmDXr/62iFTwFzPtVKbX6JfcKZrb+Mfi?=
 =?us-ascii?Q?NDbkO51K+JNyE9Aw72mZmNvOMmbhRPGgjKxqSADg2yYdUPcOS05aGkH0wzzU?=
 =?us-ascii?Q?EOACtm5O37iM/nJb40TtKYfILw/CQ7MAFEEGi0G1ecrBPIyvmwf05gbmR/p+?=
 =?us-ascii?Q?xMVF4MDtzjHTTq38/HXfmMPxRl3seVSRZC0mRbc0T06UmgC5O62VkKirQlXm?=
 =?us-ascii?Q?fg5E7gAvBJ4gc3EneZOrTBKMNZgbcIUBWstOEztgCwT+FcyArE9Y5sz9LSyr?=
 =?us-ascii?Q?4N0JHhIP9nL3ooHE6SupeDbvXkciORC44cvydpBfRcYv5yvh02jDNXK2b0c0?=
 =?us-ascii?Q?9EXesuM1y7dquSYHh+s+xdlY1X11WkiUxVGw1DvcUVGeTMPZPTKLzEm3dWOZ?=
 =?us-ascii?Q?Ybqql06DquHCfLEUmlcPS+734EXoM/Q3KkYYrCbbsM/501WUI+/3MycnLlcV?=
 =?us-ascii?Q?L1gpKMya7MpCzh2h60pT1FWRCIOA6EicMgzeF2PVMz/zhpQOiW1dPnqdNWho?=
 =?us-ascii?Q?4ayEBgN8GqjqEoE2M5I1tXvT8fZYZnFBFmxbR810oos4dWPi2ruqTKA9uGM6?=
 =?us-ascii?Q?0cbd4x4X+9Ss56O8CJRrPYhcdhdbg1PTC5qSEWHuOrb1hWLatvmCeTZWTCE2?=
 =?us-ascii?Q?8ZDJijfhklDHMCNF53zsIpDGddK5YOhi7et0ahGAjoNJ3NxSgQUZWPpLK4Zz?=
 =?us-ascii?Q?/Kx8t+ilC+1IUTTXadHT0nC78EqxiNkfjqYLeVL31vqcvvU8WjGbVGk9MnCQ?=
 =?us-ascii?Q?H8NdJllI3ieP7UlDOpUUA7BVxCokVet4cM2ptiWE6bOn7XAdPk9qaTRmJL2a?=
 =?us-ascii?Q?Id3XOADuW1IOW6OguI7zsLLX5RKpRHBq0OhVe7/R2GUj+GHAmTK7WRwfU+ne?=
 =?us-ascii?Q?KDRWpuAruV5dr96Bgsux0YralWpFDH6HpYvuhgpbR4ICzjweSspZxA9WW3Em?=
 =?us-ascii?Q?uBbwuebrNsBT7ydH9VnRGgwJyUDl2WbMRH0s6gLfxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+s6UcGISukTdHvH+62hKsNNgS3iHk1C3t3urAATTK6dlyi+1knkyA98IMJ8A?=
 =?us-ascii?Q?y+uhLkZ5yrXD+lHRexCYIoHzlTo9fE0HoYpKtVPCN/bwbenoZ0KAEAMdIZpH?=
 =?us-ascii?Q?OfHJHfrSNi4+uRxAeXdP4DNLQn54fBB8qt9qOfPnsRt3n6+U4iYPsayYoG5U?=
 =?us-ascii?Q?Ua/L65rdMVCrYs4KJG0kfy3hirP2Cj2D7gsC/PB8yYArh1UR6OVWFmg+9Sq5?=
 =?us-ascii?Q?W6PnseNOs8RXboD7EWDAFQBU/uCXpAGYMpCEVJ1iXUQlhPLd6r2nRHNOdPYB?=
 =?us-ascii?Q?JUjXYGYsXJA7L+Man5o8T098GJONM6Jc5s12vPx9gjB4o6r0jgQj0xqrMC2v?=
 =?us-ascii?Q?ijRPviDbfKbtjhC+Vo8u99OyXKUqux4YzFqebypCIpiNPocHiDkVAPeY47qH?=
 =?us-ascii?Q?Y4H62brySWCgtofjPlBisdUemrWwtOm1vKGo+f1/g8dfiP7Mx2BG4uvSRRDo?=
 =?us-ascii?Q?zGd2XLauA2ualwz2JenqQMj4lfEgZXQCPfVr0yBhSX3kk6riVjnN82h2ehAj?=
 =?us-ascii?Q?kVgM5l78dbNR+qViiBstcG745TQkr4CkZtc9WJmPeu58P5i6hQAMIrq6EksU?=
 =?us-ascii?Q?IKAi5aeyVlaDKxIboUXAQpYvLA0IXmKZ9QGiT2Ho9yzpejoLN2KpzzJ/86Ux?=
 =?us-ascii?Q?u4kbnL1HcPGQ4mrbx31+AKc9tLm3lzcT+E8b40bQRUi3YGU5+4uWUGhux/xM?=
 =?us-ascii?Q?hbQP+F9DpUZo1VQwfWNo9zk+rm1w0LiHEWIuclsGUrHDHenMo7WoEZaimDnS?=
 =?us-ascii?Q?GB0hxsIO6KuAbVuqu8wujxErsx1tIbTMpKAcg28OlPWdmeBt7tzxEeWpSNWH?=
 =?us-ascii?Q?hPgAxyo/5nrbcNeOUpOqDiUx7iyN7cPYt3UhWE07XWP+k+ygDjFdh2zgCqaR?=
 =?us-ascii?Q?A2jb19CLozUQ1d8Dh/mQD0eRdVvlAnj5d9MM4NEU086zaaG2jhj7G/zQ3jF4?=
 =?us-ascii?Q?Pb4lTX76bJFCMWzz7yxqxyGNUpqI8W921dl/X3mBJ10VZUnA3nbnIv3FDo/w?=
 =?us-ascii?Q?xP7BaprG28sDAca28vO8vmjd29vvr6RoeZ4efFtk73DR7aaKSeJxYs+Cl0Bx?=
 =?us-ascii?Q?Wd76RbYyTKAPmptZthZDdEQyD66aBNSVKOM3zAfUBB5cm+PD0JdTyrbHj2FL?=
 =?us-ascii?Q?w0yuNJ6KxleUqPRuZGPn61TU5xGDFyI4O8Wuysl3yORsSSGIJHOld5CN9qGS?=
 =?us-ascii?Q?8rVX49SrFqGPLfoVWqD65ss9MDW4cr/6DsKZ6xLkB3Y1hSGYMvvGX40zmJHQ?=
 =?us-ascii?Q?Zc963iNUKqk3Q2uOzmCqraWR+eCxi+BJqeRhpMvSVOsgdkZ/Eiy0rhRY1ZPX?=
 =?us-ascii?Q?j/VqGtSg2GA2TqtO9BtUYNl4PjwPeR3sCJn+CwtGECHG+YOMaKakAKOGv5cd?=
 =?us-ascii?Q?15HrYQ/7d+vPxPmn/unD/ie+6B/Iq5bHOvaoumYDA8pamwkoqFMg4qcHbVlH?=
 =?us-ascii?Q?Z/FwjVTrj8ZPeYm3gRUmN1eFPf0qNIs9U/jwe7x4WUzMgc0jmbU07fMSQaoN?=
 =?us-ascii?Q?pvBfG8KCmqTvR7E9khs4qmvvrPeh481Yi4E0V1NkyNUtiVl0fp5QDLq2PHTS?=
 =?us-ascii?Q?tBnjYQpYlaozkKoYnP9i1m9nVRtu6gBrj90z/lUo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cf81e7-3f88-4dd4-1bcf-08dc6b282116
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 04:18:47.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g54V3dTxM+AGdFKj2ILD2yTJe5M/Zx/AiC8x7OmikI/lccNt0HnN8Q/lXravhs9maoQbRXfk4seUeqLNFjHiDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang issues a warning, because test_name is passed into asprintf(3),
which then changes it.

Fix this by simply removing the const qualifier. This is a local
automatic variable in a very short function, so there is not much need
to use the compiler to enforce const-ness at this scope.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Fixes: f17d8a87ecb5 ("selftests: fuxex: Report a unique test name per run of futex_requeue_pi")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 7f3ca5c78df1..215c6cb539b4 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -360,7 +360,7 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
 
 int main(int argc, char *argv[])
 {
-	const char *test_name;
+	char *test_name;
 	int c, ret;
 
 	while ((c = getopt(argc, argv, "bchlot:v:")) != -1) {
-- 
2.45.0


