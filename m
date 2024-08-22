Return-Path: <linux-kselftest+bounces-15990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F31695ACB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9222B2244C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 04:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D21855885;
	Thu, 22 Aug 2024 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Zkj9TQn3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010057.outbound.protection.outlook.com [52.101.128.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4450285;
	Thu, 22 Aug 2024 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302180; cv=fail; b=VzwkzfhJT4NB8vni7iAsBLzwNaP5kYMOAi5VogpFj9u0ST3iziH1uOj87mmDH7bvXtqVSMojE0CEx95Ykq3IA/JxgtOWZcb528mfConhXw34NYEMyazlXvFhXS7xFD0YaGMKUwnwDcXpTEtFhNnZd8Ho50WR4JzWKI2HDqgzdME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302180; c=relaxed/simple;
	bh=IWA21qsBqUWOiEICwiJeEbFuQzNxsSLNIW0L7imodD4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lvWIBGd8xmXZIA2I43IPIVJcfk1P6LrwbhtzvfjDvnoeC5Zcqb6jieWvLzw1R8Ix/yQLj06tgvZ+8kpGfojhnhgQZc0idqXxsUht1Z2jpziwgae/lTPGHv++z5ACFyiS2Ebn0be95mvRpTmDRINavaYUdT4DDokdJHnJQad8V3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Zkj9TQn3; arc=fail smtp.client-ip=52.101.128.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXksFJ7hZFw5C8RjKBuQ1fIcUR5nHwgHXR+K9QO5ROY/RdcjraEI/T6XTjvXdAciuZcB9LisIfqC2bs9GOoMXYtsayy+TuPblbqNgAByYYJr2v7mE56faSw9WGEWt2XAceXVNbLlGn+n69hQmW7uZktFL/OQN9vdbzt0VJCqgtKy1xUe9pp2rGTostrDcceNGfWkxg9cHClsr62RUz/lm2owVk7dvMwKOuQs3TYKdi/JV6zD+mxnOLAGGsmR56N8YmyMFMlZvUvaFXfAV5Ht6X2BWbcr1zKYPbq5afGGeadqDdB62eZ+++VmOUhvjNhQ7Qpnf3BIp/+mT+Xi+UqXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNODIU80C6+0bqcCnslgPI1vkrfbSCo0VFk8SJiCxGc=;
 b=c5itozSBXZfLe5LZfwUSFCXj5NV5hUWKMT1r45ClgXMU3QJRkVBSW4A8z+KCsynpsRWLICCrlI1rXpo/N9h5ygko/JttfK3yx50pFeiYFfzPqblDIO2H/Jqngpy7FunrQELaZMivxfREenWevoqL0Ij/NWAK+WnQxPEGvyxVnjb9AtvYf6dE70Kan/nV/T6I8C0Iz25QbYIDm2e9X/X4olAvjfi1uFpZBmMosGoikgQ1J0z4h7Ee0bG15pzlNzdQkGLhzOv4RDFEhKKU5WCrYy5tLfR4Vh0aIrv/NOgiXeG7dW03+/ja7wHWsxP1ywY2WoDWFFdSlPPpPWIWeipKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNODIU80C6+0bqcCnslgPI1vkrfbSCo0VFk8SJiCxGc=;
 b=Zkj9TQn3/J6owoR2G+Hos7ng2PGZEzzzn3pk1PiETcAQ62BvnDwiXWx+VWO5RLdoj0c7ZlBb6WClLdj5DTTQf2mLgTmKQ+0G6sTy5yfl5FMMXZ0lBGsmlD6Q9HJ9an1N8R16VNeBWAxQCK9ma++vbrjq4XlEWbviaChwTibu0sHOkhH7gM5z8m2CAvF4po+4mypLv2A8gjAlEhL7KMy6TTrtW1ATdPQqR3vFCgKEmd29Fss59/6qknYuXLFoDHR8eCD3h0laz5AjEsZNFrnTpJMQiWyLpbIP1cTnQsHPedoqRriYwyewN8yJo0CXjw8yFUl+xt6DTj3jUey0bhlPwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by TY0PR06MB5658.apcprd06.prod.outlook.com (2603:1096:400:276::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 22 Aug
 2024 04:49:34 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 04:49:33 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] selftests:tdx:Use min macro
Date: Thu, 22 Aug 2024 12:46:30 +0800
Message-Id: <20240822044630.1267500-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|TY0PR06MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 669922e7-4387-422d-e018-08dcc265d0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ixrzM79Mj/mmGbtwl+PMAqyTU2RMMNkm5MqKJg3XX36fYvUzmVy+7xt87qJP?=
 =?us-ascii?Q?SXVMSRQ+ZQAnPMZUyTK1E3D6+FIv/vBIzHhqieBHgDw1npcuY5stM7bEh6r2?=
 =?us-ascii?Q?GFJC06isihhLwEht8bSV3Fl5nfw3g4jj8gBtswHybH5rOLtQovpSb48Ep73Y?=
 =?us-ascii?Q?/2u92mvutgHkgjx2DE7riqaGAqvVCFuOgChh/dBQ26K2gwTT4LlQQfg6SOqB?=
 =?us-ascii?Q?C+/LF0ukPrED0vSj8+8TFMLl8+5XU0L9wePOM0kXrTFr4RbJV/E7iYj9r/sT?=
 =?us-ascii?Q?j9u+EvIo4v+xXo7CaEGJFSWeqOoTgfG3L+xgns/B2vip0Nn9lzDhIRyZMwc4?=
 =?us-ascii?Q?1c0GFJt1PpAuMiCPQbIxWTINqF3A+fS+NMirJ59uKmleD2HMb5M7KhP4Pf3d?=
 =?us-ascii?Q?NicUfTa3qPErZ31m0UvIWLR5BsaKfdEWMm1+YYc8HwZbqbRW6LeQCJDqNSeM?=
 =?us-ascii?Q?wv+SsS0UmtDV2aLfrPpHe7da6WLB4Y+gB+4z6sTMWGnt1iRniHHKAerVhF60?=
 =?us-ascii?Q?F7gcjK07TBIV6gOc/IkovitTe4wd6UTbQTYXooLbCsO1mc5vvgQWdEU5m6RK?=
 =?us-ascii?Q?vk53a14AjWnvOYkPajU9cfLZJZdNqSu51ImCKZSxt5fOjRVDB0ysss+MV5NZ?=
 =?us-ascii?Q?gU214tnhC6N0svRuBhzM1c6m21WTQILueXK84Jo3BbazeDX6AYlOyKMxgc2T?=
 =?us-ascii?Q?FeIYugPW7enq6iTBODuyiKTp/yfyhe4lQf0+gLTtjEmLrCTd8BFz4tG81rMl?=
 =?us-ascii?Q?oORst9qm/xOLMtZKdqsXvM6bHFdL9OTEbMrsgelrzVwOYGURzxGEe4bT98wT?=
 =?us-ascii?Q?d/OhZ65XK4+0m74STYKTOfAs78YYP60diqmSa60RvY5ORV/3xDCzlbF6jXbm?=
 =?us-ascii?Q?e1yogqvIwIqAKYaJjECYmlMthTU4BYdwxggx6jUQ/j5DmmUJPnmXlqG4SaCB?=
 =?us-ascii?Q?KL6ozWe1zV+EWXDwg4qf3z76WgY5JeDXBDs2e03RAzSidC4ZkIUcepFiPMGv?=
 =?us-ascii?Q?ENK2rIt5NSCdqB2mN193QvrnpVOuJGhigqQD45cM14Rvi87iHW8x6YPq1OI5?=
 =?us-ascii?Q?KG6q3J/mBqiE1LXVxjqGDFfqm2mW5FW71jdpPDCtBSthw318IxdH8ni689jl?=
 =?us-ascii?Q?ICV7jM9dRv/0miEMVkWl2lc+Z0NVXHxr2s+eeqGfaZK+cr0JTyH1gTtirSfY?=
 =?us-ascii?Q?8iAqGGVbB/LfnkCdn89g3glLUnAEEL7RvfND/Ogi7mIbiC0qPRcw+cRSS22p?=
 =?us-ascii?Q?D/Tq6V/VNBq1TeHG6njpAjFsXQl7YDPPRVucToKMXisXkTgUriFo2OJgQE23?=
 =?us-ascii?Q?4X+9PoboxvVxVIpv8jOBjiCe1uKJJUAIPPCugNVxDeD06hrBzTjwNcXhqKr3?=
 =?us-ascii?Q?KYvJy/quXQqfM8i2JRmC8PpKRqf0AHEY+6m0ZwYxwamqh+LYBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KBcHabT1Gp/SuP+dF5udseUeZghcIZmLXcW4WnAV75czXNuOmd8C+rIHES3O?=
 =?us-ascii?Q?PKX39oSBh1Y2Al49/AqH+L1q0GoYERntZH9yh0f4is6s6l+kbQwFHU/Odvbo?=
 =?us-ascii?Q?XMi47AVIEPQCE5pCD3JVQxq4Tind6uEH06iLMM8HR1nLcdgYgqzDjHscKdym?=
 =?us-ascii?Q?AMCpjGzMpiQQFyRqKC4NGJ9qDxloTI4DDlc0Xwz1Rk/W0bh9thP4l+NoAyUM?=
 =?us-ascii?Q?9xgd6dgcy4xQZ0yV+DG55v6sH+2h5k4jyPEYFr6z6d597vaLWAcZGuHUdd8g?=
 =?us-ascii?Q?dxbywZ3H+4oqKQCu1EIazzfKHpm5tO4K4YndWUt8j9fhhJy2pb1awa/Bukwx?=
 =?us-ascii?Q?C0UjXPrr6Lf7BFUR6SrLPwjsjQYR18Ckx4X2g5iU+lacMTs1FWtEbQRI3c5j?=
 =?us-ascii?Q?7y9Vv/GxDAAVIZEg+cSMk2gOvr11AYNLYkXjmClyXXlmjiMiPnIkbWzxy7TL?=
 =?us-ascii?Q?PtLd/mt0YnBfiz14ZRWU8qMtUARHhJncaluxZaBJgpQ4DD63ai8uEqyIhBeL?=
 =?us-ascii?Q?HCeVCtuACXaC9dM1dbrZ4QLLLGiqKKwG9K7uyGYB9NVzKCFnYBiLeiX3/aZb?=
 =?us-ascii?Q?we+4krMgFTbiSkvTtMaA3eEInvUsRZ2ss8JB+EV5UlDhX1O/KRLUWvRFV5uE?=
 =?us-ascii?Q?owak+LQ5GGK3toQjieMOQwzCOffZIL9WidfixArjSdDrxDsBTvfn44ENwHCM?=
 =?us-ascii?Q?0jlVbfjzAqB4vvqpV6zlG5+hdBa8nRxdnc0RBTbYcVSlv7mgCJxrV02elbQp?=
 =?us-ascii?Q?2WbxMPWyTtZb1KTtPP/b2IrH4c31YqGRItixSKTiE1D59et2qUSEXM2L0FcL?=
 =?us-ascii?Q?vQMar9OZaBqTKefKdgPj48ir7UV1m/sjNp9hcflLeurejMDyavSp1bpQkuWv?=
 =?us-ascii?Q?YcBr6p9igxgUmgquEHdyy+pU9iphywzw4pInBuxrcb3Js7Rir6TXl1BMVcGC?=
 =?us-ascii?Q?aH+V3LuLvfl95tbS+KfPNIdfmvkbwnkap8A9avlsqB3H2SU6uPJFnJrK8Zs0?=
 =?us-ascii?Q?0QlmDyRmXErxeTw68MPDOIpp1RSXXlDVCHlHd4Hp3q3Nc74Uw0W+7ihT9ZJf?=
 =?us-ascii?Q?lkBzky7MrvP80pB4z1uKL0RvjLmZQyvhCCMjFg+DBx4kjke7v9A0XSjTh97Z?=
 =?us-ascii?Q?X7bZLxJLZH0kNfga86dkUNXPYYSZFVsKOnzdF6IlQGwtt2mT7brnsyzAZLmm?=
 =?us-ascii?Q?NBtSvmZg4h5dDIUX1ugC6OWBUHfVZwDNRVnufKrWoNjkwyWj0j8kqVFQk9lP?=
 =?us-ascii?Q?GFWNNmN4l9BN8qETX+5Yi/qo4/iOo1xdD9TOhw0C9ZZdbF3y+fXIA10NivtN?=
 =?us-ascii?Q?KL8037KesL9kkjKKBfefUz2UanE4byhZEUL70+huaWb+cjJJjujfKO73802f?=
 =?us-ascii?Q?i22xa0/P23FEe+dTbWmtJJKt24Sx7bRWls+qKVFeC7atiO2yBJJQTjYKEMeS?=
 =?us-ascii?Q?zdoqqCCrSCoseRPjdlPHPMsBDm0lr3vo6dGlzBX3eMm9sGfEt2GInMAO8HcN?=
 =?us-ascii?Q?kVK5lVBS9BXnJAlyH/Kdjh5Unjhc3BSOcvKh3MLuwwkKJ2xwFgzZr5DQZPbZ?=
 =?us-ascii?Q?xQQkEBTTZs5phCwakQth/lLWTOn2p36bF8PQ2Z9P?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669922e7-4387-422d-e018-08dcc265d0ef
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 04:49:33.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhoP9Z7FOR4Aobn4dboN+0F7os6B1FXmXBpV1qYAUXvUVWqYAsdGD4m85gXqz6+KtoW12G+fb2/PCMshPf9oPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5658

Using the min macro is usually more intuitive and readable.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 tools/testing/selftests/tdx/tdx_guest_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
index 81d8cb88e..d7ddf5307 100644
--- a/tools/testing/selftests/tdx/tdx_guest_test.c
+++ b/tools/testing/selftests/tdx/tdx_guest_test.c
@@ -118,7 +118,7 @@ static void print_array_hex(const char *title, const char *prefix_str,
 	printf("\t\t%s", title);
 
 	for (j = 0; j < len; j += rowsize) {
-		line_len = rowsize < (len - j) ? rowsize : (len - j);
+		line_len = min((len - j), rowsize);
 		printf("%s%.8x:", prefix_str, j);
 		for (i = 0; i < line_len; i++)
 			printf(" %.2x", ptr[j + i]);
-- 
2.34.1


