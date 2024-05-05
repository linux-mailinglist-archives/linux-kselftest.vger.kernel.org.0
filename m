Return-Path: <linux-kselftest+bounces-9485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F828BC3DF
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 23:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997FA28115D
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2037605E;
	Sun,  5 May 2024 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P8uq6oq1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F56EB56;
	Sun,  5 May 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714943323; cv=fail; b=R9/SMw0NPG7k2f9SBr0vG2OYaP/znU5/7XHvawpy1IGLY+0CUc3nsqrrWjrelIonmXE78e43SwWtTtvOTQCIQjUmdeTUt+c85QBKr5b+kLXcW+bFlarOYWs+Ir9bSE/KoGTlaocFt/V0SpX8/PK9HkQFw0baUxH+ufbwMbut7Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714943323; c=relaxed/simple;
	bh=kxLa9dvFP/MfGbq/RgCD5ui56buG0lfjtGR7LBPWpKk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hxyMMKNmWVUHISgVp7uux+6CooGDUKw/Lqoax7gSFx2161437t1F69rYsDak8K5BnTnZ+WiqV3WeozzEia40WqztfM++4sa9GM/BtN5B7/zIX94hBgodJUgDf67etg/c9Yb6R1hFES0eNdsqFgl+CnsLLzfQ0fHCIJEQAIzbtn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8uq6oq1; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgvYY0C5ko1T4TwN6pm2mYUPJlkm5ze5Ru7pCw6LOJcNuH/pvyKw4hoYYfu3nDutOiPsAsPeTEe3EvLgkRvV9eXH8DQbcgjjUEcRyGjilk/wl7qsAdYXAbidWCHmygu3szwQ2nrAiwdG0wDMQc/UJD59ZoH4VfqAjQ39/i+hhplu6DWYPmLJFqjfPRTMwgfDEj61IhAIBfjCA+XmyacdZ+jWQPH+JE8ZuP0LLs4Ke/kt3Gi2GKhpK4zFCwPgdqjLZU+va8pLCR91J1FV93ROSvypdWHr1xxc2zj5fOjiGDs5/bYrpHNWThY8s6y0Axe/CNkTZngLRmH5WJ1W6W5e6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfHJtGV62jAqMJJbkYxVmLgshq70N1Ma3FJWNB1N9jg=;
 b=SgxvF0Vx4kEVlViWQebTUeS8wmlhJnIV9OUKFU3YODuyMG7cj5Ievs7jFsKs2xpwk+v1GyTjnYPgm7+MebHMB8uqCWbwcOesVVYYhXZXNOiM17rsS8nixnnVPZeT3nfONmcWPlFmvSAXxKHioVPz6KI4ZlbVkmBneyetY+LHreQ8+8c0J/b2KZwbGxVUUWoknGXU68CenIN/g77EbbRySvwRHcWmOZE3y6999tCmGchGuUwz2wxHpAcBLUQoI17c/PABp77zJIbQj/4p9qG4gS+nH8K6gURVtaGNbACVSYzj4ZZsdDAUTu3JTHUSBVbBoM4GAA4z1VOIwhgU2SSg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfHJtGV62jAqMJJbkYxVmLgshq70N1Ma3FJWNB1N9jg=;
 b=P8uq6oq18TvAScnfvVv9YZ0pQHyxQN9BFosx8F49pXnIQPqgCy+yfnPG8ZRw+dKGhu2cspvC/x4UNWAT8QBuxwtgnqpjtZKFSlh2/wg8XdqO4i5SMHKDF1fjI/wH/EHtPv9cnV4kExG8T7QJxKNhTBa3dpEu/sbE9TO1Rbd8CTuMSJZZc9TIyYCgqtLmNhRvsrDm/pgWjWJZ+u3ULTVQoypMV6VYGb/nsxPnrs1XhUaldxD3uCxx1IRDdl18SyTepyJd3ToDzYgvRNElD3ytH4nkhoMSt1kpyRDPw1uSnIOOE4Gnq9KPAi3gUyFjpgf/FVgp4LtI162cs/m/yyGiOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sun, 5 May
 2024 21:08:35 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 21:08:35 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] selftests/alsa: missing a return value in unused dump_config_tree()
Date: Sun,  5 May 2024 14:08:24 -0700
Message-ID: <20240505210824.55392-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 3633d8d4-6ff9-4e06-9fc3-08dc6d4786c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b0C9vY1uUJox3SSfv9D8tg/jGhBW++PPnxSw83qgbmtM76aubOYrCd3MJ2di?=
 =?us-ascii?Q?oJFXmMlHUWoxHGgR/yMVSChMaYImuL5ylDS4RhtYLNqmMnH5VxmVpWALdqzr?=
 =?us-ascii?Q?K54Kbj1G30AeggWJuqPMn74eyUYUXbvuEE3NX7VfxJX0NdfOO4ekm/TxUssN?=
 =?us-ascii?Q?hVusqI7Sc/2L1cstRcp8BIzSMRhxJ4+73DLjzOwxeBqc5k889XeiRIhFKTgK?=
 =?us-ascii?Q?XkBT8hJT+fZorv7ZM8RD7dW43U9ZKOtTdHhFEPTe3Ol4TcxoLGEAQqyIzNq2?=
 =?us-ascii?Q?uiZo4P1hgeHM2NSOdFL3NveO60P/hz673WPem7vMVvtVvg5I93bI4puqIx6H?=
 =?us-ascii?Q?0gFm7OBECbNjNoheMYTkep4kbaOlAgT2KiYz8ALWLZKXiTSZ4pjX774c2c3n?=
 =?us-ascii?Q?g+C1DjizWs4TJrz5DNi2Lh9SO/K+/t9FX/SNLJDN8sLP2/kjQ0Xg8C0ip4x9?=
 =?us-ascii?Q?5t37oXc5lMZ42pc/6GcivNR1YhuABDntNnkFaaNUkR3TnSb7UiSeArYLuD6d?=
 =?us-ascii?Q?/fzzYGWACPbChC52LmKWlD39/R0Lc5pqBdL+FzTIrwPFGAUXpdl2iL89QO5A?=
 =?us-ascii?Q?97kACF+Bvyibvf0A2Ix1MuYcAtj5Q2mMlvmCixgtiVfetL/fcrUqeNcNQcgR?=
 =?us-ascii?Q?cUCQMVxsc2jvfpLMf1Mpr5ANRCH7ylnvs8xx8TuCIOKnM/2tP37iH06M7fvv?=
 =?us-ascii?Q?KLGfKrJPHb9rjZZUqGkWBLgWKcLtFwC+s800ZroTB2UcrlvN7mTLb9wLEMtQ?=
 =?us-ascii?Q?JI8LrSe4KNqKNmwobYYNTNCq5M89oqG9MpsDwgqRSEAOMQyKNuEgcIBESV16?=
 =?us-ascii?Q?QqvDLcfAelN2rzb3BxHFaGpS4n5kUqrz8e0hiKkjcjKdijqEuzKrQRhbxORB?=
 =?us-ascii?Q?DW2cfr983ljrlTPrxjUnILqFUKvixAQDzpNeovedu39CNyLWga3vU3UPzBey?=
 =?us-ascii?Q?ch1UgWsactPdpgi+AAB7Tf7kvPC8t+sz77jl4fZAYnlUAtEiw9DtRlM/8gZn?=
 =?us-ascii?Q?w7IOROUCB2Lc+GsKNGBAzdSkqm+su/bjK3ZllSB0M75ddVRZYwd4h+Lid5w8?=
 =?us-ascii?Q?2N67c4cxnSCWAxMilv9kkCg7lzofnDRNm4lGukkoEXRYbsJd7rbtEiXELOsz?=
 =?us-ascii?Q?huEozZXEOaOO98BNz0mrp9o5sEcuA9+4w89XkQrx4QfKNEW2TJAiuXlnQsTA?=
 =?us-ascii?Q?Rc+iRLYdW7lxQiLfpDu0XqKEG+FgKQDcj+oWDSYkllcp/SA3GAu//oMwpLB7?=
 =?us-ascii?Q?/3PIZftJzd0qgFqzvBPjqVcS+CokU1RZ8MBeJeYf0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cwmGknbJeWFvXW7rfsNoAdiVjr8L6bLOgUMMbgbGj/0WQh1el/VvTvqESWWz?=
 =?us-ascii?Q?ht3xDyoZvdfQ7EN9M0Xeb35acYQ6Qg8nKdETPOLKndCt9oV8DGoJ0o7mfNnw?=
 =?us-ascii?Q?FtEvl+IyiX6t9v96cwEWUT9BYUWG7w9ldyLkYfLESKrsuB9XnFcayzMXU50g?=
 =?us-ascii?Q?IUsVcV96cgsvN3rJg5s/9v+8npUaTARn7N16JTXov0HSYyfvlXcOfcaui88/?=
 =?us-ascii?Q?jflch7NnWGGPep/bi0w7GF9MM0bcvLqF6JJDqSZE3l2MNYPFmvYA7ilxedoB?=
 =?us-ascii?Q?syOZLdVhgz+FK1Rn+Eppjh4Qm15TvuWmqfLYzmeeqBRJEb2FfM4+4ykLt2sM?=
 =?us-ascii?Q?BIqxJl+qteoghwo5NT6xMxaDLRgdB1cLHWxqIS9NVTO4d7u4tlPDZJBDBeMC?=
 =?us-ascii?Q?Niy3pFkn5vuFT98yI7vBaylxU0Pq8jxu3odXHM/jVyuxoqU8CV1fEy4ITbju?=
 =?us-ascii?Q?H7SKJr2+Bhq7p337NJ0CaRvo73hwUMe735/iBYjYer2naQlzdJTr2qFQ1wL8?=
 =?us-ascii?Q?3xKmXEygBlslQslNNIlg9cD6antN94kMy9ygIWPNFYOle4PFvDFlfhNmYRb2?=
 =?us-ascii?Q?Fo2sdE9d6LpXAtniGwbXLXDBABRFq7mHZPhqBEq27oIAJ7/71Vv7Yb/tlkvk?=
 =?us-ascii?Q?Y6JoWhObfaqI0vvVA1o6esgeaSDBCohilX2NE+MfuJhLafE0HYSZuyPYJKZ2?=
 =?us-ascii?Q?NZv+2B2GrbGLtpO3n3fr3raYuFnP7M7Smmk7kum4afu/i4Un0aO/HLLxFelD?=
 =?us-ascii?Q?jkPINq106FGJ02OY/N61m27oPTmLUEHA6Vo08rs9hKMlKsgerDdXD1AzWSgj?=
 =?us-ascii?Q?kqTEo8j7KafSC+ogFPKwDLI74ENPqtZ6ZxP9WvoRbgL8cMqlWhG9H7mqEzir?=
 =?us-ascii?Q?oR+8vKDd5QnstDYxoHuj5O/TxPWfM9raC++e8EdLODhDCcCqGsbjfICWEzvc?=
 =?us-ascii?Q?MJaLC933CUd8yAmHpE68q84yeEybspfvEFwQTb94doPwIepdPFvJd2FjwZ95?=
 =?us-ascii?Q?CfK4Jee2DnNeYg3ZrmQTE5zStYVUearuIHiYCGooGryk/JhfASOQ4WWdCGPL?=
 =?us-ascii?Q?8nabbwYUU8XQYMW61zZFXfue6gE9cF4xfHZjLnaCWQnUQp1OczkXxewmp2oQ?=
 =?us-ascii?Q?NpQfANbssSI5bZMW+tKmX7wj7c8z56/kjANqBZaOp5JfOCEHxA3yzG5MRr48?=
 =?us-ascii?Q?ZAQbSoq1/tMkGazsjmdhH/zDowUKRU+Vu+FtmvhnLWPFcTJCL3dIESjtpZ4D?=
 =?us-ascii?Q?agXLTtIhbhzKpXux15fzwi6CdjOY0yiCZ46lngP1TT4o4wA4Fio2mKu0TILr?=
 =?us-ascii?Q?nLcpY2c4WoeA03Eu3a8WEeFIzohN6+K7Xj4HFJwtoKmyi3H256Zr18yyKZEV?=
 =?us-ascii?Q?PbD4U5mio8LGlRkn2cnKW1jteyeozR/4UfKokg/iywN5/srwSnPi3SqLR6rE?=
 =?us-ascii?Q?t/bKUBGfwKeuImhs7O4lBfzEI80ASnzBq7xBMrdSYoUpMPD7RgARb9FfOtA6?=
 =?us-ascii?Q?hXFBtHXzYjt9lyiMysQRFInLLSlyqER4rtMXsivyzc5jaSb0b7G9XRi5iy7H?=
 =?us-ascii?Q?AFMfBVyDYUudmikuORLLPprRok+BIOVrGD3IwqTdIVZ9c3RlHcRGfVoac9Pd?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3633d8d4-6ff9-4e06-9fc3-08dc6d4786c6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 21:08:35.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCIi6o1Z1L44tnYYZdKmxI34pJtYcfT6x8stW3okTXLM9QDL4lJGmXA4KCKLFuQ40PKuIcldTs8Dhrbbnbq/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003

dump_config_tree() is declared to return an int, but the compiler cannot
prove that it always returns any value at all. This leads to a clang
warning, when building via:

    make LLVM=1 -C tools/testing/selftests

Furthermore, Mark Brown noticed that dump_config_tree() isn't even used
anymore, so just delete the entire function.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/alsa/conf.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index 89e3656a042d..357561c1759b 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -105,19 +105,6 @@ static struct card_cfg_data *conf_data_by_card(int card, bool msg)
 	return NULL;
 }
 
-static int dump_config_tree(snd_config_t *top)
-{
-	snd_output_t *out;
-	int err;
-
-	err = snd_output_stdio_attach(&out, stdout, 0);
-	if (err < 0)
-		ksft_exit_fail_msg("stdout attach\n");
-	if (snd_config_save(top, out))
-		ksft_exit_fail_msg("config save\n");
-	snd_output_close(out);
-}
-
 snd_config_t *conf_load_from_file(const char *filename)
 {
 	snd_config_t *dst;

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


