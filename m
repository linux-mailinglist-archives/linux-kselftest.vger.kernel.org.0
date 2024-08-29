Return-Path: <linux-kselftest+bounces-16698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12101964BBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94F728311B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B335D1B4C2B;
	Thu, 29 Aug 2024 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g9rSPbmB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jedKH7wQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D21B1402;
	Thu, 29 Aug 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949169; cv=fail; b=baaF9eegtL5tH8sTmb+7ejTdss2+V4GlJeir+Sfs42lROYCJe+E5fsirdGPlD52f5hzzlKNuEb+U5Q7ALuy5PJ8aJCPK5qcttCWhUeJ8IOv6Rf6xDLLYAqxVp+CZiC5iM3/pg6O35uauk7eYcLpkkdGLoGYSNsNBED82U3m6DJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949169; c=relaxed/simple;
	bh=XTL8V7Og/LKTU7eXZhKN+THr67wydmKFdVwsAHq0q6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WRjIhmCwQmXFptO9p1h/p7+G7IoQawt5ZxeTQE9xi2BtoIG62nIS5nAn4QZiWX61aeTx2Wd+oCqbQLfETgch6NiB2xgnjL1wmNp1XXXMu188V0wIz3qnH9gh/hmma+/aR/MK9NtYQIlu5opGG9YLNSMDsw9d2yFT0/szAmfGOMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g9rSPbmB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jedKH7wQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGTkuq022157;
	Thu, 29 Aug 2024 16:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=XTL8V7Og/LKTU7e
	XZhKN+THr67wydmKFdVwsAHq0q6w=; b=g9rSPbmBEiZ4ehV6jJdYX67qOtTM0OJ
	09AnUdlbOLDNSOR7QsVWxL85cKGFBUMkekYb3wVx8HJRtlFhdu1oSll2eky6aUg4
	zCbGquykSj+ceAIWbmAf5i2qtKhk7xtSIv32h/TyUgkMI8v2+9NyjqhAPk14Nb/H
	zj9qFq/TFThjeWXOdApNhVSaA/CeuFylGEQwpnqaWrp/DLgAy+zf7P6eHtUqo8Kx
	1bHas5YebXeSHMeIZuMyocVPamK1TamiTkC2gNytOBEruHhEcsEycpo8wyUWYTdd
	EX8W8zsgwxsIFUq3TCb1KIZQtH04qivrCgiA3if9lfyUrpCggJJ0mtQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41athxrg90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 16:32:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGLrr7020219;
	Thu, 29 Aug 2024 16:32:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8qpvnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 16:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdIvK0yE/TRm7mNuExkvOwOpASy0Qbv0M1RMzDx2O0blW+9+pTTrplC+Qh4AApPz/9i7WAgyqLXnPE5d+fXgrfLycxsCjhJUPZlFoF4EeLNwHqZdKam2UDBN196+vf0wGZBpVI+NOVNmUt7WSxVrDNFvQ/c6LJGremVSH5zLcOgckwiwn0p9cGy5RwCvMvQ/7no+yYnkNVkESiz4dPaRvoL0y+AVmG+lhpF81wLVGg/4ZGfGZ8tUooHYF4ueZBqrfdm8VaHQk+MXoDdxo9jyvg06y0ZhBIlYKBW/W9yp3Own4IJ9HUE2S9wjh21SBrrvFPZJVUcRYf2ruQQKAL2JUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTL8V7Og/LKTU7eXZhKN+THr67wydmKFdVwsAHq0q6w=;
 b=gW7PzD1jsrJ9828bOHWyKOwvPLpNaMD8Oada1i9CIUJ8YwbFe+x0JcmRqxOzA618YG0NAk5zbUBkuf/kkaS2w44k8vTCifsRzR9D8/BefkOTMY1CD4d20yc+YCNQIVlLj3Vzkvzfg/b9sLQgbPVH90gmaxIba4NWRt/mK/1M/TYKbXAkVATqfBYNz65YWrTkO7qg9XM82BRFejwQXw1X1wffbpdpaV1ziC1s0TEmqIUjvJTTXutost8/NnRfVwZdmGnz+PQnxfqawEt/0KwNZAzTlE1TuanmlTv2cRL4mUB2xJEK7mAXzXxyKRZdPl7mqDZ+jdOvYWKZQ2sD032U7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTL8V7Og/LKTU7eXZhKN+THr67wydmKFdVwsAHq0q6w=;
 b=jedKH7wQo8IvFPil1sSv9bbUOEPj1trSF7g+AzRxtJfuYoUsb+xWi5PBAf3+rPhf2jz0BdghutNLPFD1uNQMAje3uCx0LAqw+xEDrAA3P8tOsYqg3atxh/p69Uqi9jQ4NTZo4DeKTntx9f03OPGoRvBolj+AFte89jLg6HjL+HY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6472.namprd10.prod.outlook.com (2603:10b6:806:29e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Thu, 29 Aug
 2024 16:32:32 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 16:32:32 +0000
Date: Thu, 29 Aug 2024 17:32:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, pedro.falcato@gmail.com,
        rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
Message-ID: <6667ec01-d379-4c4f-a04f-b64ca0e87de8@lucifer.local>
References: <20240828225522.684774-1-jeffxu@chromium.org>
 <20240828225522.684774-2-jeffxu@chromium.org>
 <293ce8ff-10c3-46b8-a56b-a1bddc7aa37c@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <293ce8ff-10c3-46b8-a56b-a1bddc7aa37c@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0256.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a797fa0-197e-41c8-d918-08dcc8482ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qDC9qI389XeTdig3xBJ9nmlY+1n171Jra43bqvt0Nway/oCTt3tg+exb9ciT?=
 =?us-ascii?Q?wi+LLhS00F9oaUYlOmlnxt1KKml6dh4fvSqA0x85K/2fNT38IcCzTDatL1WY?=
 =?us-ascii?Q?G0F889Rg9hvopauPtYNCjUqBVAesxd5qwbQUZDD1YkfwCqYL2F9KyTJWd1sH?=
 =?us-ascii?Q?hbtT9IsUqeqjgtuPEqP5caZ8XE/ATp8GXXZBBfEEm2urO0/9e7v2wQsex8Mc?=
 =?us-ascii?Q?U9dn61LK4cgI4LiLgmiuJQoDJrVn5dfh6gxfdv4/VcOXtXbGXH1wzXtVcqlV?=
 =?us-ascii?Q?HPlAfo+z5K4H8Gz2LGjmxHirmLj9Q0VZ1qlG8flLwnQPnJxe44FHy8O7O37y?=
 =?us-ascii?Q?9eNFwJ9MFx9BOJI+9qAm3j5cqd9tN/7nDUifZwolZh6ttE5KCb6QVQCJyzcW?=
 =?us-ascii?Q?3fxA6fthEhYGdc0qItiJE9hFwNGn7YFL+66EL9R7rHicvcOjpOniP57Fc1+v?=
 =?us-ascii?Q?8uiU5DBBgDn3pAAwpg7TpwuIUb2r81UXkfEVGsg2qDAutwD7xvKe9DpKqQGR?=
 =?us-ascii?Q?+s2CNdj/55fI4hgNEQB0emuyzOKDbwuy7Ka7dgCI2IM4XStuaOwJJyZor4L7?=
 =?us-ascii?Q?yY9/+Pmhy9ZnmmK93l6EoFi43tdNxnhq3Tmu6wsHh8r4VQG8VchCWHsCn1zN?=
 =?us-ascii?Q?g30Lhzr11yF1fEkADOGK2Yx/+a2IFY191jFbSQenOqk7MfB4nA38gbfpxInr?=
 =?us-ascii?Q?3afFSIU5Div0zrxLhXEUIB4LGf8ZfSnj240wookAox92+Ieudfw1DKpA8v2q?=
 =?us-ascii?Q?t2rN+k5ybSSE9r5GqYRIo57SBnFoiqral2wvJi8MWNqPxtgLu+KmCkUQ1MQo?=
 =?us-ascii?Q?NARPdGV+AeN9sY1JQkCa9kJfDrduK2tOwVa35nIN/Cxi46RlCGQcZ2zTAEOZ?=
 =?us-ascii?Q?4TAsP5YWoMkX/0c7YiizaKzbbKmpeq8+Gi7RxFtt4wZZsCyr0YpFiRwxUeE5?=
 =?us-ascii?Q?Z5nJyiCwXZ4SujrE40wPgpzVHL9PIKeXb83LN7WOEma22RLTStlycfnmWc7P?=
 =?us-ascii?Q?uiNst6lKMKJJnJwr1/BBl7JqvUcjyOemxxVTe/tDoV3EnwLKDnTgQc1fpaxM?=
 =?us-ascii?Q?OZU8fMpne/UKrc6LDa0iqCF7zF4Fas7OeSec63/Pki+dxHSuZc9MoOc9t1Iv?=
 =?us-ascii?Q?LzkRPZR4A3BBYATEy1Q7zmP8JTmp1AXtLp03Xb/pYYsVv00OE0hugoFM71e2?=
 =?us-ascii?Q?6uI+TxsQ2+3rSwfGn9ebqMobVg5nbpVSdV2Ddf2uT+TuMg4O6Fae+0Wz+5B5?=
 =?us-ascii?Q?FmXtXxpNICDZ9vpTqtF4+ih0SKMiMCbbfanrtTe8fsaOu+cNdyg9Ymk1snn5?=
 =?us-ascii?Q?t5DB6DpIAFF8tkUY3NfHhBHFneTT+PItxUEPY6N4mLqzbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbF+oIC+bd1hdgeIVEhct5ENsDTcqqoSAPK84txJiqEl9/jWplYMM1PreyQ8?=
 =?us-ascii?Q?RrDb3JZZrdaZ+yyx/mFV0sxdnz3cnl7ZcY4klDwBCgWir242DUZ0oE+k/RDZ?=
 =?us-ascii?Q?7rHenC35z5dqXxygkmg5Doj3K3e8E9eW1Lk4rOESR6oAi5E6kWehB3T+/R1r?=
 =?us-ascii?Q?uvRNDUmaMuZopQKEVYlbbOZkto6eaLwYi+YoiVxAHalUM3djX5lH/MPdpsp5?=
 =?us-ascii?Q?q7/IyO4fQh23NQtn7XI9AJu3HvfhIdNY2KfhLRC/LUBXATENuvR5BiqxJSqt?=
 =?us-ascii?Q?RESdVrIBilCdb7O9kp0ff4tn47q8tug91/DCS3WAaLLsmGqvvvJ1OVH5pW25?=
 =?us-ascii?Q?s6yNuh/gvcd+/03ss14z79wxPT7r+7L9AoivaXAZsZWT5FmD5gH8X+jeE7E1?=
 =?us-ascii?Q?kGakOPMmu7f0o1ScHVRcEEmr/G0N+GOmwVjpzbbMQA144UVkIyNhufuLS0Wh?=
 =?us-ascii?Q?Eq6MVinxMLjKGfgUtQv4lPF6edBYRY7RzRc6bo+j2+i75BE3DCkEaKbVZwVN?=
 =?us-ascii?Q?QSkE7uBkGcWiSZ1l/DiIRBEUulppJSTdXslSuOLi36FNkYMRGRNC++bBgtd8?=
 =?us-ascii?Q?XPG8Fv6dv2Ra95GmwMI41NF3VevU0FSedzcFzdR1Kq/5GKAJvdwGKCgo+e2g?=
 =?us-ascii?Q?4lWnLNieeYIYafvyN/L1XKMYKkXTXlGIGn917mKG8GUhXH4OD/HPW1Lonl70?=
 =?us-ascii?Q?NoIffoaVS370nFDQ1VShMlEPbbVxbiMRDuV8UxN0AJCxgxriXPdFYamgxmhC?=
 =?us-ascii?Q?YGivcjhOYOedVzcFeONvfrJyy+v9TSC9SMd5TZ8a/HEIhAS0leIa3Po3wS3F?=
 =?us-ascii?Q?XXn7b0XEgtlIe+1+QcaCQTOv0Ilnu2JhkxfxeiRt761MCNhl0meuMk4Nehoz?=
 =?us-ascii?Q?saTdvR/bViSZSZTTxVSiSG6KVjQlSOLyz5fXMH07dISH7IXJrpI1d0WbrUyw?=
 =?us-ascii?Q?AnW9zjvCSCNHcWoc5ATEonFNyLkRCgWafv7PjjMczdzzG8TpDJ1T6anWvsJj?=
 =?us-ascii?Q?ifA6+VKjebyUlQHMnJzBPH8C4nzDa++1QxiGX3qAuWjw8CJ5emY0wdWFGJ+K?=
 =?us-ascii?Q?ixmeBbcH07pTeGTuOrJx3/7d6k5NtCR2ljOgehD/zv7QAutLrfFm0Y2Qf/J3?=
 =?us-ascii?Q?FmRIkAJOfChQapG46pXbDa+C6kYxtaWAEez3Q8fbYI+92p4/IX6MbkApn9dK?=
 =?us-ascii?Q?8tJN+1JmRpRIkTs81niFtMMGuVGydU9KcD2jYmKkGg2bIimOZcaQnJPncU7e?=
 =?us-ascii?Q?g8JeSFOKI3PDlDfHH10vhjSIkHMGs2/8yT9LTOPOSUQZKnh3UDusdmvBXv/J?=
 =?us-ascii?Q?RU5KuffEioZSs0S4bP1OtAiXKCQyo90Q6ppnaZS7Ni23vvk2ltcg8bj797e2?=
 =?us-ascii?Q?gdebkv/yL1AkiydsGjGjf1jRl/HySEW5LOALoYcAi9vtTYQhnyCH5Nw9Wj3N?=
 =?us-ascii?Q?IvyAvcAk1+4WKlVayGFaiR44PZODEQTmy8t1k1BVN1OTDtpPNlni28WD30xz?=
 =?us-ascii?Q?CcxP50eI9bviv253CCfk0yMAzgz8p+9YZF0gpjWVDy1SdvKMYg2NhHSzqMXD?=
 =?us-ascii?Q?3DIuXf6YUbBcb4LmWsSWidYAp0em+GT5ALNevlWaWswGYCnXesrgUMUGIBME?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zIxcgQNUl3bcZVKWdHvaS9w9Fqk6+baugYrlQtdtSGZWEODlbhOU8CK6M6S3ejt0U72rGrx5o6iYC8/C6BbopTit8wRui5creWSY6WDBXNV7CY+Tyfu2P3iYcwVpS/GAZsM0EJ4G5brMzATR5zHssjeZ3i3L/QETMRdR1+gKP9u4GYfW3lGux4ckgZ0eH9uJCszkpES02T5TGD1/8ylZ8yPucYZHAPa31eZmeZvqJEvb1eLm55YYtNzhaRUGluTBC5HJkqrsvrhY1fxSr5ujozoyQbqxHhTPJgFwF+4CobPkzCtHEBLYZzcZ2SMMz0fX1pNRCuK8XN/EPYWh+OuC9+tWDDuZheOEFYwzbKyOtflMqlICoh2dbrf5RKvlUpGF07TFsl5LImbmrnSRDHOMLDZbt5vYflGC+uo5wBDWzwQLjA8dEyH0ITtxOZ+UunuKni6dWiqvSp6qDgdk3IpXolr8F7/qFxUpOic5yPfbX3UpKXddqRbUTwvw6dbNAUtRzgRWmr745b+UB8TEENlX3asQhkD85shau9bJ7ZfzM32QKu4THGNrWEF5LMD8BS07uylsXE2v7cWQIOaHrjrvw810FrQ6CucU6SJdnS0Q0p4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a797fa0-197e-41c8-d918-08dcc8482ea6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 16:32:32.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: El1GJqz1jryxQyiYUiJtwf42tKv8vXUnaDzc5tfGkN6tSPZpr6yJpkmO3hUSivLgy2QpTcvtXPIxu/d7wmyypQOWaffuBWe4laZ3Oucx1QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_05,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=647
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408290116
X-Proofpoint-GUID: s8BGoapuyjI4Ry4rjkxCZN3eveQimJTL
X-Proofpoint-ORIG-GUID: s8BGoapuyjI4Ry4rjkxCZN3eveQimJTL

On Thu, Aug 29, 2024 at 05:16:50PM GMT, Mark Brown wrote:
> On Wed, Aug 28, 2024 at 10:55:22PM +0000, jeffxu@chromium.org wrote:
>
> > Add more testcases and increase test coverage, e.g. add
> > get_vma_size to check VMA size and prot bits.
>
> I think this needs to be split into multiple patches, for example the
> new test cases done separately to the additions to the existing ones,
> possibly as multiple patches (eg, should the size changes be split from
> the prot ones?).

Agree wholeheartedly.

