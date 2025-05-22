Return-Path: <linux-kselftest+bounces-33516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5629AC13D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 21:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B111C00B76
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A489210198;
	Thu, 22 May 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kyY291I5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OiOLLbZA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C482101A0;
	Thu, 22 May 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940430; cv=fail; b=ae2LuYIjqDhXBHF7odgb+7Djz7GEToCKHN4bvfrzYAqLIHvd/nhYywTB5B9mDZnZX7qY9ZWzMbFyY5xpgTwaj2wwPs8KMw5973cs6V0hb2JdC1YQjzVt6gEHVDpwx6EA6ro7+JTuv5TGYOrUOyL7sFp1+rGchOeo+wvzsZ7MfCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940430; c=relaxed/simple;
	bh=ifdAKCqykPzQazwqnqz0PI7ZYXJ1VgDE9I/iF82IBZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j4AUZ6djQ0ge29PDBmEyDsqTzRADF5VPlr9WmUpUjBDVcV/UsnXeylc2cKx/I0X/bYt91v+JVCFO+5PUykILn1e8zf39a5BRFQo9SqVnaU6qt7jgMrSnHttooW5+Ihf8/TCi+ttZ+gYej2REGm6B2ndOufZhoF9UfjeAXBUBJnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kyY291I5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OiOLLbZA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MIpkpn006628;
	Thu, 22 May 2025 19:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DlZhDj1zbQJONW5/Qn
	8Mj2+0PC6dibNfdz1Skv9otWk=; b=kyY291I58CnBVoXiqEsLwMI6UL7R9RRhY3
	I8Z+hBtu6i0H5VxPklDlwONsLEcXO+GIijwSijE2gnB4OCLcHv/xqvzfqw8qH1fy
	wCPTw7RveNkU2aTO6DQOKytwYa2fCHHGtsUK8cEqpKQru6NR5QdvooZJdFL7zqBo
	6CnlkymqG+o3W85WaV29PdnooOqJd6Psa1Jf2cjNCXQNLlkKRcr1t5qayGZ+wOSm
	mwQIzie5ye0HdWI4Plk32mi/EidjhsZWCtXlrvLoZzWsUxIuR1IWi05EyBJE7CRJ
	yKAl02tUqhrWs1shPI/V8+3ZZE6MayRvgRpoaen7jAgd7lwG7KCg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t9c081ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 19:00:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54MI3HDb032287;
	Thu, 22 May 2025 19:00:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwep2hur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 19:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afr7NvWH0ZHSVTWY8pAUSXTcSXjqjVMWwTWP0EKGniXFRRt0N6kiXDIdzzFO64uzxw1GL0QOj+uOBNqnqC4n9PIOLDN92SoYdMD+vdPISe22SFyizpttj1OfkNXoeTtT7sYqkCmt7rz1+i1hpx5024egy1HMRwCkfT3qOYc0E4PuFhUummEL1hNsWf6ieZ9EHsIgDezk3b1TtcuzA2wPpsJw/xlkIKT1Ud0kcsM1QUpGfXMra912Rc83zgNG/PVBssoJSWpoL3dSE4yTFhBnuBGrDbdoGxx0OhWLdwtANizEEy+sSE0VpsU2lhfburDDrE1JqU0DZyy1n3sqk9p2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlZhDj1zbQJONW5/Qn8Mj2+0PC6dibNfdz1Skv9otWk=;
 b=A9PIvGIDXjpF3A2CUe9XNh3LM4TzhCvUow2QBGsjpt4TzBNsnb0peLETU7E9CbcFkOiwLnixLHr7VfLGmdRirywkzZmAX8Ab/haSEtISdufLjV6A2XsNoNHgBoQe3x4x10Ab7yxGBLb96lz3l5oFTESibLmSsDy1xhkg/oqD2rOwNrGEpgyQ0DO76At2ObiyTnBkBwjgzroRZThIWjmw5rM/VQcHSYlFjEkFMbRShCPhP5z6yaVVYudxpKufCGM6DU5IugjcXCjjfcMqkY09ZB3pE0EjmrtFzk0oyX5iy9uNjX/Eo/goKnyfHDfs+dzdkx8wFvDpmMLuXbF+8ZpkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlZhDj1zbQJONW5/Qn8Mj2+0PC6dibNfdz1Skv9otWk=;
 b=OiOLLbZALGwhsQovf4wutIIjTTPGFHmyUFr9b2/73V3SKjz5dBhQe1fsB4KjwjPxkZx4Yp6lAv/HNHf+e1xkkHhZWJDn7p59yfpaluAeXbIFlBrQpcnEmEyCWVRbmhcROGmfqOkl0g5w8OrNHd6BESFh/VZ2JpE5NlKd9tmPueM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY8PR10MB6633.namprd10.prod.outlook.com (2603:10b6:930:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 22 May
 2025 19:00:04 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 19:00:04 +0000
Date: Thu, 22 May 2025 14:59:45 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Deduplicate test names in madv_populate
Message-ID: <aboathzpwqqgy5j3jw53cubmrtlzelazdysksqnfb5niruto43@ptubjb5ptakg>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250522-selftests-mm-madv-populate-dedupe-v1-1-fd1dedd79b4b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-selftests-mm-madv-populate-dedupe-v1-1-fd1dedd79b4b@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0029.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY8PR10MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: ac39ee2d-e6de-43c8-a0b1-08dd9962dc5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wldm4nGFAY3Vl23s/QbYXdk3DcUidqyFe8Xxci0orRFisHx69eGK0JltfNCS?=
 =?us-ascii?Q?Nzi+kijBU/YEM7rVnBAGHTbtMBpmPKb6QQ2ApfETdKPnRxJRCtXVr4CcYREv?=
 =?us-ascii?Q?eyztxmTNlLnkzlvJM8L+D7Ju5la/y8V0eh/ksR9NdzOMrp5D5dEBO//9hL9a?=
 =?us-ascii?Q?RBiQL2ro+Spd/Lh2DcHVk4YBMZGrsMwbWWVjGvJjVo4jjipi1M8huQSF9Uqs?=
 =?us-ascii?Q?4xMQZwVItOsg7m/laBudrSpGbcISaAcwGxFRGgIPitGmh66XqndLIfGlp5M2?=
 =?us-ascii?Q?2Y27g52d8LHRunKGhAOJ3kehnIqzUJVFBevLfBi3RgbBjYD0WdbFDZ6yasZG?=
 =?us-ascii?Q?3RddLttB8PIhCMwPG0yuPNYC6ieXQboy/PPdthuWYqg9kC1PxWrhzylSObTR?=
 =?us-ascii?Q?lBxF7L6rfG2GXDiPsFJC093YVpqJJOhO7Z5ijiGPiguZQfCXWloMq1VmYtd8?=
 =?us-ascii?Q?ZrslFeix9UdovOTe4W6gTLCjuwwuIYYEGmUwOaAf8JYJn0AUD+81/Ef+1FEO?=
 =?us-ascii?Q?oPURbfxn1PJKIT7I+bUbycoRmdv77l29PxMj85Y/mBKx6SKnPnE2nKNA9/In?=
 =?us-ascii?Q?YITr9hf927gNc1hwCrka/qqLZSzE6/KZhI/zIVy35XWwDDPAnf6OdDBXxYal?=
 =?us-ascii?Q?hBUeiSe5xvgrVVkGxCq1FhIdczRQebmiadtPPjcyMryZM1uxA2KfsJaz/wwA?=
 =?us-ascii?Q?rkeRispKX+NUC2otjO64qD+jeJtTef5trZ6nqAizyNuu9olU3rKxkyYEeXiU?=
 =?us-ascii?Q?Xy/CF3rNsVPs3xCmKHFcdg4/4tESfxKcjcksA2BwMNCYhc2zoxObplDjMumh?=
 =?us-ascii?Q?YObft957ZedIgHDZCFMEo2Aun9BRV7EhkTnjx6WcnuP/N6Xlr5gjEYzzVBEJ?=
 =?us-ascii?Q?b0F1kAFBlInp6xZPMs86e+lkDzGApyykhh71Pm8fPHw/o2O8+k189V8RSEtn?=
 =?us-ascii?Q?D1Vrd+j3Z8X7n2IlHoHeSh/1po/680hz4qUpKix8hbAURA14wrCgboQKzrxY?=
 =?us-ascii?Q?2DXgxNCmrblYe3NeViMiSAEpx9ItIL/RBjuptJ6nKwVA65i4s+Tdadp36WKT?=
 =?us-ascii?Q?kI/mOFc6Oy6Av+lXlOupA1vJZB0t65IlDTK0nBrYRuYHsEz3Nqg9aGq5eB+T?=
 =?us-ascii?Q?63RmFNCyNn7PgRcfGtpVImP5RuKZxD9dG8nULCNkVZ5BbWTCp/eXOtW3hbpU?=
 =?us-ascii?Q?FTHxHn+J5HTFx/QOUQBQ8tYRou1QTPP/3ENtzUu+AIy2sT1dXFTVT+jchJzg?=
 =?us-ascii?Q?spLAEBCk9ut6m++BgNVcgGGEt8PTku7FuJecE3WQ+EZW29Jpw+U+cumEmgiB?=
 =?us-ascii?Q?5kkW4Z3SG0y61mHXRMYIaoUZ24FzAWD2EG0dAqCarH9oZtfp5j+WSnl7VgEB?=
 =?us-ascii?Q?tPGxDO9f+hgioQP+9QgqX/Fhi0s/1X2ggD07AZOBVL7WD6WpUinJ5VabCspP?=
 =?us-ascii?Q?1FufGL1y8+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rT3xL/HzgCBskG5/h7TJlNuGN6zCBOVTEENXMPjwPj7gqotfVS/WqmiEHN5k?=
 =?us-ascii?Q?/la1/J/KLOTcIE2Orxuido2hkxpxM6lyfyozvZd82Sa01inDsEsQH53gwdzT?=
 =?us-ascii?Q?5oE2lQisBwR0+74mXA6fmHVGi09lMG1QOQy1HgDQqsU5gAkEx9uY69IisiOE?=
 =?us-ascii?Q?H7TxkJOq9kkhFuUi/DPg8bWg7g6nkeE/6moSR/+rQR+d3om2BhDhbFGKLNRj?=
 =?us-ascii?Q?+BuNJgfiHX62s2XUDxVRTus6qV3acVYGM2nODjzDbdm6WTh7R9/L1avkbusT?=
 =?us-ascii?Q?ICL1uNrT17E/sPWkPrsTvNeJ+zL0mw1FmROFddxXEhjUAoFEMesdbogMlm4/?=
 =?us-ascii?Q?zDLUmFe3KXjzIXakmhj3gF0HB+VDkoxA81FNqMbxNVF1d32+zab53ccZqA40?=
 =?us-ascii?Q?EBazFEpwd6VDLQuXGsiR3TpFEJPHjVYVGvoXh0hMiNXnT45hcRcJGE+ezoN2?=
 =?us-ascii?Q?fCOxHjep31VDdelPtnyHHdu7QddGpdHIQegeaxQB96z03B436K88JzsjIhig?=
 =?us-ascii?Q?3mrqumBqosaHp74m6FCDgDMX+G4smfFKvA0atjcYZFnTjIbm5XeZo9JIrlDM?=
 =?us-ascii?Q?8MXGGyUeXCpIm74fwXLTsBjJxuYLC8712rBPjkQjmTFOzlYUAXTwfVSThTq8?=
 =?us-ascii?Q?I8yfu5s0IQOQJuaBvQpjwoyeziP+4Tr8jhAKUCWoiESqO1/W0Oi7ixShQavs?=
 =?us-ascii?Q?KfMjBwnbPiKFLZ8GZu/UruHnXVShjPBvXK3LwRn7IT7JXRE+0DsvikUqPHHn?=
 =?us-ascii?Q?k5IYiyieu5Yz6mKy1znVCwLqojggLQfhkLfdZ53rwsfqrD61YYFeWxvaZqkL?=
 =?us-ascii?Q?Ilr6f08PpBwPPVVjln1zmVkXBrFmLPBuTUvzImOutVi1InzKzrfoP8m9NsqV?=
 =?us-ascii?Q?DKFBPuygd0C/Qi0cP+7IOHl8sopCysMQipMtyZlDWgsoOtsCt64ozNy07M4t?=
 =?us-ascii?Q?O+fE3Zn6ZlpyhxqeReD/dwDhM/IFjb3ZO49/Q+MNGtImtP0lurxZB1yX3fOV?=
 =?us-ascii?Q?aZ76o6JgCqJ77T0g1x+8aw4UKt9Ygi2CRuWoJBlt2P6eVCVMP7jL0L9Fb0RG?=
 =?us-ascii?Q?j89Xqq1KNQZr96QCRMQazjR775DrCTPQHOZO/CRSzSfmK38/Co2vOd2BVQoq?=
 =?us-ascii?Q?Hf6pH17m69QMd/3naAqDqM1wxmhb5A3Dq5eNAhaf0DSsf5GGQZgr6ryoqxJn?=
 =?us-ascii?Q?jVXUWv6d2TN8Ibd7o52Lu6taWaFgG6zvDONaKD/48ik0AVN1eQ1feHcV+c9G?=
 =?us-ascii?Q?wsqxpTiZrjXqx1r06wlACpcYcb0NOnAU+ccEREFfERqZ6beiSu7XDxFSpzve?=
 =?us-ascii?Q?TT0iRvBpMCMuWWCvGIWHBzviA8e/poRm02qn+m4+vs67EYv3RrddZMYNb725?=
 =?us-ascii?Q?PUEskC662RPeXm6tLgNCeab+soYXCzou+WmU4azTASiR0IU3gQuEBOFq6tYi?=
 =?us-ascii?Q?g2HgA90NUFesaQLnVuXgCJ2CUMwRvtQ5M+BabP22g0pxIPJMqgjzmpFgeJ0b?=
 =?us-ascii?Q?sZX8CR6WAmkLutuq6MwkYZRxb+B1SkgSZPMXQiu5LSOLxeXpYQ2lgs6gpmMd?=
 =?us-ascii?Q?CD1WGwxcjg40u0eeZLKtCyvsMyxJaZCQ5NEFTTIr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hdAqjNw2Lhj/u8CnPHstz3T+LUsilsb76SY4Cl5G+jlTeMPKaqA8MlEQWI93zOZbUcIx8Qp9JuxiBCBmZQQibVUNmDhIzFibuYWyesqTBbVYoD1CN11Bbmnl70hFoBHYbkOXPYAt0HiLwR81ZyCLQH7NSow8RkkU7GnGkd+QPjWR8U/KL5U44sVPeR6Fc2xKWuiwCGl3e+VWN1hpeFkjJ7I5HIGYUv3vEO2nLyugGYi+tBhdY8hkhXu81oUOtDOv9LrBvi0sAgd9l2VLDcRa528cgb5r857RIwmbWOb4YD0FsKptakf9rJWVktBSc5MFDRZm6cQ9e2Mtrz8J71ogABqH7S+a4w9KDw/j6QfP2LTo2Q0azMX8G+0kQrCWa6Na0/RKMW36X1QKnk8CMjFDguW0jlxMYPfiXJ1AMiatgLhBcJNFaEr+EpuEET8as0u8Ff4pGCT6ubM3Mw4saW24cthRYh8f8mv+CFiSYFZcx9WcmL9y2wHAWinuVcsuBSPPgKCSNKSo/1m+PgPhRkl3VRNIJhZy1CC2TyH3SfrNWiwzPGtfgowjDudpA7eO4zcbNdKXjaP/LMW3r5DmEdjuSpfOkcYPG08OSn0GSVnCaQM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac39ee2d-e6de-43c8-a0b1-08dd9962dc5e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:00:04.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4L3EjfhQ9HSA8/rXuG7IP6mSotyQS6xymjIX1Kh2BqBt9qy+N4bXHHW1et6Lf7onJW7qj7sS8w7awBuhC333lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_09,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220191
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE5MSBTYWx0ZWRfX0BAW58SlkLzk GM4vj8Ci15MyrmkdF5h+xEoufIUJL7NxBeHlUQw2S7URe/lilaHq7gEImkWksUSZ6NCcNdbwlug nfSnK6QCBCoEwD4TnS6SebFvrWYsjW1owxMiQzGr1TEazVaERknnhxuu2PJEBaFTXP6FkAV/+aj
 VcoqpmCDxuWl0NxAnjQMtt7ARahZ36h6m5Xwvb/NUJ5/TI3nFj77D+XFQIEvAZ6+XJ/QZD4TxtV loVwPGJQozy+1BNFlrGkKElsbgTbWB8lqSJ2aQjccjiavu0/RobOK176HP6yYqkACAk2MoGA7xA +puQz1O91fLGBIlKhh8VDBcGZAA+YkVFn4bpwFTQz1lBaFEOEI2l3TYnjI/0o+b3x40Zz0kNsvE
 wCR6fNFBIsS8mGrmyF0mczjLj14MBLL6t7ZLfth+ohtYvGBjrBTv1o52Xz7B9j/4MDeo1Xe0
X-Authority-Analysis: v=2.4 cv=DrdW+H/+ c=1 sm=1 tr=0 ts=682f7439 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=nWcIhLms-qcmK6hE4mgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: RlGEho1VLamJLy8N7B2XKAiMh3S6l0OM
X-Proofpoint-ORIG-GUID: RlGEho1VLamJLy8N7B2XKAiMh3S6l0OM

* Mark Brown <broonie@kernel.org> [250522 12:30]:
> The madv_populate selftest has some repetitive code for several different
> cases that it covers, included repeated test names used in ksft_test_result()
> reports. This causes problems for automation, the test name is used to both
> track the test between runs and distinguish between multiple tests within
> the same run. Fix this by tweaking the messages with duplication to be more
> specific about the contexts they're in.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/selftests/mm/madv_populate.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
> index ef7d911da13e..b6fabd5c27ed 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -172,12 +172,12 @@ static void test_populate_read(void)
>  	if (addr == MAP_FAILED)
>  		ksft_exit_fail_msg("mmap failed\n");
>  	ksft_test_result(range_is_not_populated(addr, SIZE),
> -			 "range initially not populated\n");
> +			 "read range initially not populated\n");
>  
>  	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
>  	ksft_test_result(!ret, "MADV_POPULATE_READ\n");
>  	ksft_test_result(range_is_populated(addr, SIZE),
> -			 "range is populated\n");
> +			 "read range is populated\n");
>  
>  	munmap(addr, SIZE);
>  }
> @@ -194,12 +194,12 @@ static void test_populate_write(void)
>  	if (addr == MAP_FAILED)
>  		ksft_exit_fail_msg("mmap failed\n");
>  	ksft_test_result(range_is_not_populated(addr, SIZE),
> -			 "range initially not populated\n");
> +			 "write range initially not populated\n");
>  
>  	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
>  	ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
>  	ksft_test_result(range_is_populated(addr, SIZE),
> -			 "range is populated\n");
> +			 "write range is populated\n");
>  
>  	munmap(addr, SIZE);
>  }
> @@ -247,19 +247,19 @@ static void test_softdirty(void)
>  	/* Clear any softdirty bits. */
>  	clear_softdirty();
>  	ksft_test_result(range_is_not_softdirty(addr, SIZE),
> -			 "range is not softdirty\n");
> +			 "cleared range is not softdirty\n");
>  
>  	/* Populating READ should set softdirty. */
>  	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
> -	ksft_test_result(!ret, "MADV_POPULATE_READ\n");
> +	ksft_test_result(!ret, "softdirty MADV_POPULATE_READ\n");
>  	ksft_test_result(range_is_not_softdirty(addr, SIZE),
> -			 "range is not softdirty\n");
> +			 "range is not softdirty after MADV_POPULATE_READ\n");
>  
>  	/* Populating WRITE should set softdirty. */
>  	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
> -	ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
> +	ksft_test_result(!ret, "softdirty MADV_POPULATE_WRITE\n");
>  	ksft_test_result(range_is_softdirty(addr, SIZE),
> -			 "range is softdirty\n");
> +			 "range is softdirty after MADV_POPULATE_WRITE \n");
>  
>  	munmap(addr, SIZE);
>  }
> 
> ---
> base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
> change-id: 20250521-selftests-mm-madv-populate-dedupe-95faf16c3c8f
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 
> 

