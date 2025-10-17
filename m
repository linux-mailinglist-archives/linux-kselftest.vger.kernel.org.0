Return-Path: <linux-kselftest+bounces-43372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C870BE7C19
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02F3935C18D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067F26F292;
	Fri, 17 Oct 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="PhDhu3Nb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021097.outbound.protection.outlook.com [52.101.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C992D6E5B;
	Fri, 17 Oct 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693340; cv=fail; b=fC2ykO/EEbh33aT8tbeyQdYxPWEfZxxwofjPWewCq4/Hp5C4jTGEUmEIe8F0tDn6Ac/fFuxLiJ1o9uAzC/VEWFFKLiHe4bIIPV3qpvsstGvLzB+/sIiucMbQ8zUbAsHasnVnE4Kx869XDqMiuQ1xmnCgYdaSzqJOi4ZVxCHM9mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693340; c=relaxed/simple;
	bh=DjancEu9iQuuSEMOCmiskhaM+S/xyLD2U3nyb7lug5I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T4VuW/Vdx/xeISuhNJtEBzBDuxnbTfszSBOwVau8T42YZqUTmGnjx1ptl+2TmFmy8ofKsjXTCkT7o1JitCoM/e8GfKb82vcQKCvGIe6UTvwqPb6xFCD/iCibHj3oUqlD/QjfrR8AABbglpThkXs9pOgME6nY0A/LZdBNNUdGJ1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=PhDhu3Nb; arc=fail smtp.client-ip=52.101.65.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIAJM9CRaPsdhZn0ObLSIDfOHVC+pf54CbEC9vh8naBMb6K9D2q59NOu6G7wUWwzMnSqw6dLaQ37BYlwTXaPoPdc52a1q9zoIcUjZEzHBwu3FPpmRqFFJbZDZEkMTDULCafSk9SaXhKrCqwGY9h+/e/+8MsxdY4Apg8EZn7tJifFri7Dq75EFkdHZidUTgo15GAG3Q3ABxhOIZqjc8lQB9i+Mdj166w+kcrweB+TfeV/maXzlYSC80TMLPXUEmETMO/A8Jo8IVhvm8TT/bh8jezxtZIkG8r2VQdjR0vyhph7Di9GAQ15hZeNlBVea+fpuB06BuTQe5D9ywNek1R/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymOVK864oD7CdmZ8z0grwcvPJfxmBlJeoaMCM5+6J7w=;
 b=shFxVuzcKEMNfoxhS0OfJCLtJwwUTjfQ+O3AaIJhx1V/Ryaqi9F7nrKjQTwgN0kHaxVUbj3BxXvnxhRetcufdqelFLhVzzAqoXpqPI0AdPE2t/w3T/NMHyQ8Hbu3CrjymlZjBaxSqc495Zns2LFhIk9Qdn1oxNzvakrVsai85lgNhKsGdYmPO9qkGRRusIyxax0Ud7RwCys60g91JPLzPaN719G7LRk9uMdgi96UVglrW/SnSA9fm8wwTI4bt1lxQ+A0ZN87I7eMzPrnNnu061sQ0SmHpLUrOXJ3hEo1u80/Utt4xgcScvI3RPoZu11Nxc3LUmfN5xRsn+mNkR1PSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymOVK864oD7CdmZ8z0grwcvPJfxmBlJeoaMCM5+6J7w=;
 b=PhDhu3NbcFzx4STMw3kb+7jQS7X03V2T7GuObs9pyc45lG4/mMRiOv070QX6kTiClro+gukdOLtqf6F4DFOty10hyEaSsVGrm705DnYdyx/rZKHSaM50H5xTKfjOpdM/8btJ6gTyqvuQXeusZYlEX4sMXWHIV2/DWs8reMgtOgEq4E2DUzZ1b4ZCJ4Og/HFsBdymitCiHXlZQzB5VulHSsRYUpz8R/tvg/oTt128SkNeHw5LMJlUIPH6p7TjEvYsiUy5jUdwdt8vj6Z28jbHLdGPHipGQt0g7Xugssw7humogMRI+MBEuhUhP20B6YLogyM2LbFNRxVOfKn8mKig8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by PR3P192MB0602.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:28::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 09:28:55 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:28:55 +0000
From: Florian Schmaus <florian.schmaus@codasip.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Florian Schmaus <florian.schmaus@codasip.com>
Subject: [PATCH v2] kunit: test_dev_action: Correctly cast 'priv' pointer to long*
Date: Fri, 17 Oct 2025 11:28:14 +0200
Message-ID: <20251017092814.80022-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::11) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|PR3P192MB0602:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a3e8ad-f648-4f36-80fe-08de0d5f97fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IfQKvwJggUK6F0RSkAY/CF08XaSPwcJ4GidYNU4COZBsdS7oeYqKPRvjIu+r?=
 =?us-ascii?Q?w6KHNZbl8zz+1vEgdHoTD9Hm/utm7SPcn5qER5Hf3oMGYpOKxgd94GbWs7K8?=
 =?us-ascii?Q?l7rdunArjW4O2DQm3vlpcdP79/iQV5FfEXoWvBEslY03z6gfGGsX0dufBv47?=
 =?us-ascii?Q?0L8QLwvHJLpKL1hnsaMiiFYgSYn5JbY3/tE9uBCBSFq37FdaIKQyU9SSxVTq?=
 =?us-ascii?Q?RSpHDKBHArYGFlTO/gkX45GlnX+jQqgo+kq4pPr9g2iZ3YqUsIEZrfpi/a25?=
 =?us-ascii?Q?oUGrEVKgDqEcfdBH+IH5s0yfCcvVkxRhW5wNA6wpPehsV06sJkAriMtSb1E9?=
 =?us-ascii?Q?ByOLbCgOykSM13QvJnEs/3i4JDvdR6ytxe07xQlcGRa3j+Kre/fmyebusDji?=
 =?us-ascii?Q?59gg+4fO7Wx8s1IFCB8rwwiRTzEPw+iZFzB64055fv8WJ/QC4jvmVBH1dDtX?=
 =?us-ascii?Q?80JwhIRdk2lqTimXAvKq2LfhLrUX4Gl0ypLoW1TLlrzm0MXmMBVz/wgxTSNA?=
 =?us-ascii?Q?009uZQNZCqZqhJLGUVOQUHeOiiNOBf531/8xXE/R06lu8gmRMY+zqhOQWnuQ?=
 =?us-ascii?Q?rTkchRkjAOETZUFp+ZoBDm96pxoibfq4EEvAacxpA/rR/0vHaO5mTUC5kwFR?=
 =?us-ascii?Q?XJJgV8bwuCUVPZ3YHBYrShZy+ZKXB9DyDdcfG4J3zx3+RpB8mTHRF0t+rfIF?=
 =?us-ascii?Q?0rkbRdxRm7yN3zGxV6j1dCnvLN/6t/Hpw5SOp+ybx83seHu19CGzJQplyXSr?=
 =?us-ascii?Q?cAgPJGfX+mRlCpS5NGzLCEB1gMvSWAiSgszc9Uxa1g82FzmtrQ5aL3mH2KgX?=
 =?us-ascii?Q?vvid/FpAqUgzT0mSlw+aSf9NXfV16ddy3kIW6PSup/NPwMue+TA81orMrPoc?=
 =?us-ascii?Q?TzYbameRlkeYdezhxl6vwR6X9cC+PAfIygV/ihrGsAoW0SNVd9aIV9QiUjqo?=
 =?us-ascii?Q?+31xm7eFEdN860u1ro1V/ishy/NvREsiBSHrEoeCrJBk2D1RKjFvEpjGh8sB?=
 =?us-ascii?Q?02gzCiBiVeR6pYnhgK/1uqPrk2ahqBSKR20YlfmRan9y8NEWXHrbQzbu+6Jx?=
 =?us-ascii?Q?US8QumBASCulDzV9k5XKHT2eSjREA1yydBHead2lq6thLYE6Yj70sY0N6IKm?=
 =?us-ascii?Q?bHGTCB484waeojOh1FemnMo7jEeQf/9IbjQ7n5TcZxKH3g5Yz8IhG8/iCGd+?=
 =?us-ascii?Q?RQCAI6cWljrTn5DlvNuqI/F1B5/zcsKmY4jOFJOUWW4g65BhZuIIW681AJDr?=
 =?us-ascii?Q?nnS6EXxqX1aIa8R2Xrw+Y7FRCRIkZaMBcm4qA1g75WEOiD/enTYrIP1T0O3H?=
 =?us-ascii?Q?KQh8sj2Be3c32WjgGdvTEcbltnzNWBvF5XY5WCU4/SxXD054QJksn+fEd0OE?=
 =?us-ascii?Q?MAolCWXygdk/UROQEtve7cDUQSsSfu/4O24d/VT1HzvNkDtGeC9EFWMpSeDW?=
 =?us-ascii?Q?OCnhc7JBomPay/ZnM3CPjMl9ErTsj76t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mvDo4bllg4RuYWuu4sXR5sfFn7a+988Vpk8MChD0jdYweGLk7zKqnp+62YoF?=
 =?us-ascii?Q?JH4jqBapxcn1bDb1LvN0SbRmVTKX0CrUdmLPkyHOMBytaMu0yokPxOI6RyQW?=
 =?us-ascii?Q?laEt60ldV8T58/cCQJSsmtTAh7edplwTY2TmW/PQy0LXMPj7CAUXJEkVqUtG?=
 =?us-ascii?Q?XiN+2ZCvfvTN29JqlRkY8STYDk/36RyWP4WxLhUH2wpSL/A2BVO7FYdRtAOl?=
 =?us-ascii?Q?1Fv4fExZ9Xt2TRpJ3zNt1wg7qHj0lkCBt7xgHpmLiWuxIP1q1khlBOtaSQTf?=
 =?us-ascii?Q?GFvuHCoGy/0zOsgTv3Oe/QUsMNwNwQGRNQf14rJA6ypojw3vJr2VNAP/jjeN?=
 =?us-ascii?Q?EWBIH86P0h55TGXNwRPaLssEryN7KmGfJqaSxXDYBo1WUTIabh/AnrmOjfSF?=
 =?us-ascii?Q?wAtHP+69AORJn4wxD4/knG6/MVcS5qrUbSeKdrjuE+urLIsZbNjrnntEg5E6?=
 =?us-ascii?Q?hfcRHx+L66sQnIWlF8MDhtbxmXM3Kte4FwYjGuWA1wdqBBDGu48Eu/tWAuqT?=
 =?us-ascii?Q?UTSKSHIfJTODtr9MLw1Pz7lPdPsoJIXKk3h1pw0stmVrgqKBbO+q/tf/Cmgp?=
 =?us-ascii?Q?rw9gHObw020anR3e5NNqz0bvQgqZv8VIkZH13ELKpQbcvX3drnajgjgJyQvQ?=
 =?us-ascii?Q?PiGgKf+qV8MVfqurV4RGiAfgqBu+peXO0eFvMUZ1S4QPtgRnVocoxoiKY4U4?=
 =?us-ascii?Q?CTonE5VwXjk4zIuid2C8VNF13b4hATE+mCOL8d5KwM7q2I7/6cBnmF/g3L7x?=
 =?us-ascii?Q?MErrASZzXUPhzqxn+Z7KxujgduZUiub33rChGSI2aRCazJtwk6fk2sTCGLbG?=
 =?us-ascii?Q?urh+8ZUfZNO64CRNcM7G+BUkY8HuQO/MTYDnesaWHhD584IsenXd1SaPihkI?=
 =?us-ascii?Q?EJYnLAJkW8iq9Wa2kHM03PK0BH5dRkqUznNxG1+Jlg/c6vx1wQszE6gxo4c9?=
 =?us-ascii?Q?P6eeXNbzKr0dYDlS0mraB3g/enXdW2X1+3LsYAPYq2AhjfY3B8ov/b7ZwIDg?=
 =?us-ascii?Q?czHYVqwJ825lu6395kOUix1vnvtYHNkjiyWrswv63ZgHLsJDG9HS8B4Ozozo?=
 =?us-ascii?Q?a0F53BvmmaBspAu6SqfSoVCWWTdtRc7U++gnYzjHq9FJwggSv8vNpFZ6y6KE?=
 =?us-ascii?Q?J28KgYVfL42sUk3WQv3ETH7Dt7ybzfvkxx5+9mB70fL2+a9wyWgZsSdpygIO?=
 =?us-ascii?Q?cfEXso2yNNlbTUA5eUwuO9A+nq1wYZy7SEwrx08vABn6r9VVtKOfz5qWrEnC?=
 =?us-ascii?Q?GK4js5QA+wgOv+cqJg6IunQPcYY/INIJrgHngZD1Jz8P3P9cYD1QGCW0zKXE?=
 =?us-ascii?Q?X3bKMUr++oqiLQPAPt+gIrOL1DV8STCvRpMF5UOGSglfna6RxdEv6R5CYDQw?=
 =?us-ascii?Q?+rqcUvl4a0kIekWr1FI2mLqJaHxbNMp9SPjpnIT+O6gKS/rJ3jPonLJyKvK6?=
 =?us-ascii?Q?/iVhd3GzYP5jxq86g6ouK0ETE+v2lRIVx2/Pne1WrJRVzdW3H+xGgVUqccFo?=
 =?us-ascii?Q?5+dEzP7Zgelb5TlbQwXigic1BqfUfgX9Y568J5XTKu5kuAY/+4kuSc/cwY40?=
 =?us-ascii?Q?pzHfs/jHNEtzScPbpat4A+ma511n/vhlevMtD3ONL5TbhUDGuOoNq7bbsqlT?=
 =?us-ascii?Q?JRsX7g1RjcPdZMK2gWvUKLOCCBUxbqI5dO14qnbN96IFC9kBt+Yp9BJQRpiQ?=
 =?us-ascii?Q?p7hzhQ=3D=3D?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a3e8ad-f648-4f36-80fe-08de0d5f97fb
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:28:55.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYJOvEGXLbiC0g5P6KAn7/3L0/jo2t83uBcRnx8/UTppJ7gc5KfL0p2mJVjGSv857+EltU5aOUyYs3VtH3J57/TrSoFCI5ObVNFPiLn6pgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0602

The previous implementation incorrectly assumed the original type of
'priv' was void**, leading to an unnecessary and misleading
cast. Correct the cast of the 'priv' pointer in test_dev_action() to
its actual type, long*, removing an unnecessary cast.

As an additional benefit, this fixes an out-of-bounds CHERI fault on
hardware with architectural capabilities. The original implementation
tried to store a capability-sized pointer using the priv
pointer. However, the priv pointer's capability only granted access to
the memory region of its original long type, leading to a bounds
violation since the size of a long is smaller than the size of a
capability. This change ensures that the pointer usage respects the
capabilities' bounds.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---

Changes since v1:
    - Fix simple formatting issue: long* -> long *
	- Add 'Fixes' git trailer

 lib/kunit/kunit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 8c01eabd4eaf..63130a48e237 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -739,7 +739,7 @@ static struct kunit_case kunit_current_test_cases[] = {
 
 static void test_dev_action(void *priv)
 {
-	*(void **)priv = (void *)1;
+	*(long *)priv = 1;
 }
 
 static void kunit_device_test(struct kunit *test)
-- 
2.51.0


