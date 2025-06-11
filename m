Return-Path: <linux-kselftest+bounces-34666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27986AD5085
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6FE17FADB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6C2609DC;
	Wed, 11 Jun 2025 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H3s1rmP6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lEAzO8ms"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D22609C8;
	Wed, 11 Jun 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635365; cv=fail; b=CdAuS33NxMtBNoXE9qVV/NcUB64LV1WYj4Ylu9ZCuns3PeHoSKHIgotmkNcQhzIrVzgm+pPTX1j6JpyeZNT/2RTtGfDQNeriNxeNAoFog3H6R3CaaHhua5vnMkW7zni1tO30c0aoinNzkRKplthnB9c7p0TXZockmIsob1Rzg5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635365; c=relaxed/simple;
	bh=HZoI9r0et5gLOpec/nPNYIu8XWTCV/LuB0B1fWsMQXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mE3VC8JYf7vp4mBjje7zLRgi28fXH7jEnjg8w9pw2dxZguLqLYFvw65UrBvxKAO8KPCk70hjeJ7vUEX52jTq5IEyRrgbRtgvipIe6dkiOE8o6JJOqIRs/yZyaXXvI/ti8iH7iALLZC0W7LtL+hLSDHSCzv/Wq1eb5YCIdro8Lv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H3s1rmP6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lEAzO8ms; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B1BxEI028837;
	Wed, 11 Jun 2025 09:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=brohvkiu/7BAeiD5dC
	Joipr9EpKKc5itgoFNBN/a1vw=; b=H3s1rmP6BmavcOWWPv5AdlL1GFGYQvc3PQ
	AZPidCnAX6SgzFwc9o8iHgquShAUlp4iHYx/MVGjUcrguJ4e0FTscYZvOVnQENPt
	mgVJSp7foHoMJFA0kqJadw/rc+XYaopG6lr4/Mam8s0Gq1xA0z69T/4cyeDIzzhE
	M3wg9Zyjjx7e/AVujjeBqqW4Wn5JIc5SY+AglYYi8rPAoGXtirzv/fo0AUXjuiT5
	U7b1BJfd16CMEUmZNvA4QN90EVUtanNxr/J5uejL/O5J+AMb1U4iXvYDs4/2xB5H
	o45AQowyaSoX3/UzDeiFHTtflIYuuOPsrUVQeeTs6iu1GyONPOgw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf5vrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:49:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55B7o5Q3031370;
	Wed, 11 Jun 2025 09:49:02 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9wtyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbaZKVbDxnVLyr6xt71CINqG606TBa4i0+WH+giZeQbMK5DaecDfsCwzxcXUC0octYz9KEJdnJVgvR4iIbWgXPOSJVA1zUnD2x2kF0EPZrfaZUCVs/Bd5dNm2nGX27gNd/93BmYNZF6HXjx/THG1wcsDXHwoJEeXaBDf7tnbjDxNzduoH7z2NRGTc5PUH36TLJ6t4RCHRockbJVNUbe40Dqfxde0WbOTzay5Yb8HFLVkLNjDBWAAwtcy1laPAC48o9djvBAlnvPG/F9ci7TXJwP7oU2L3Dd7iTjqDYDlT6baX09qskUAehfXG4uNZ6xELFAMzHaSfudDU4hu85GlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brohvkiu/7BAeiD5dCJoipr9EpKKc5itgoFNBN/a1vw=;
 b=g69bt0vZl2MJ7jvkdWkqE7b/wwctph6b41WevqjKaMmxkmXBWbLdNjlDPTHhBMobndehSSJ64z5BSuY+x6VMcWCNhw3/mc2xe48i+huVRTJIoIcV8pgZWIV6iYRUjhV3cFnYgLMGi3W/tSXPE9rNafKI+jKMk4EYFjRjhXMuvMkVq0VzJkV/DHl0es23bEldn6EEaSganpMxZQc/0DW2mZ1/gL31jw0pe0ZEYgab0fQ54vutM3/Fb91lLxy/3wKmpzMzXehqX9LEOa3W0ltBj1Wz8qht8XAPyREHFWlqg7n+xyA31O1vgngInYPMJDiKTylI3SBxDOICpZb5KO32qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brohvkiu/7BAeiD5dCJoipr9EpKKc5itgoFNBN/a1vw=;
 b=lEAzO8msK4kPYdSXkzn8NEbY/YrzajIMIP8lUysSKpubBD+pVhderrhL3DTjsTEUNKs+8ITx5XVL+QiO76Wlny/O3hEQ9XwVeGDOK1rq6MJNhKtB4Oy1FRTZoaFt+PIas7u7laGVuSGachTknHAaEKR117nOjQR8zTOEzLc/HK0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 09:49:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 09:48:59 +0000
Date: Wed, 11 Jun 2025 10:48:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pulehui@huawei.com
Subject: Re: [PATCH] selftests/mm: Use generic read_sysfs in thuge-gen test
Message-ID: <1fad971c-dd57-4fa9-b951-10f749829c10@lucifer.local>
References: <20250611084011.1047132-1-pulehui@huaweicloud.com>
 <caad6357-a4a3-469f-a824-4d7a36a0e629@lucifer.local>
 <097fa60d-cb5c-4f0b-a2b1-db22b26cc49b@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097fa60d-cb5c-4f0b-a2b1-db22b26cc49b@huaweicloud.com>
X-ClientProxiedBy: LO4P123CA0322.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8280e7-3cac-419f-8b9b-08dda8cd30cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAF7yUAFkllwj8WeWEzKr6SEJHfGTidBwJ/PFyl2u2HheKOH3UQ3e0crXLWH?=
 =?us-ascii?Q?EUI/pr2QgEiOh7wJ+Sut5kYfBfVU0cPdjP73IBPXDx5NZGHKKsYYE6Ro16ip?=
 =?us-ascii?Q?JzNHMViq99xwEXHR8w8uBfxO8qn1JNjAUXUVV9aFEuTP8wOYeGQ9VfL8h66W?=
 =?us-ascii?Q?Q8K89q4Yv4T/5+wQJrwwNALQeSMAbG9OdmpAK6Q/VXwxDA1mJ19tybBbKp6J?=
 =?us-ascii?Q?1FhUe6Fsn92R4VE2Ual8iE1gCTPrixcRqg9EQL4efdupTypgpuClC3fdp+23?=
 =?us-ascii?Q?a1h9Wm10az2hlfYdQ5Yc5XuvmL2hpn95tRCGfOFDp5RY5or7SE8kqqHVhdcd?=
 =?us-ascii?Q?meWnMOp6ZzHvmo/2vh+rzdKrr8hRg49rHZBjpm7+9f1xPgFziZCwAzkeBLlL?=
 =?us-ascii?Q?cLnb///UZziCqIrqhtrDMtLYpWC1EJBBkbzHOaMIdD6StmWjAvfomZ9oMRY3?=
 =?us-ascii?Q?vWhsxCdRe4F+xq9zlGZ02uc+yq/Wj8mJKFqLdr7ut7FQhVKLb+MM+A+teoou?=
 =?us-ascii?Q?7U4cN8OO4afFNNYXWSlqGPpMeKaiMGZvmDBReCflhHgVx7RkwzKJwJ0gsdM2?=
 =?us-ascii?Q?tcz2cDbIgdUIWnf+qo5CxQaclnMQ2+2H1bZ1pnNBME3qtI7hTvBkmG4SWm+m?=
 =?us-ascii?Q?Fw0//p3MSEmrxTqZU6/rwAyzYt92BPgPNv4ZPdVuf3WSOSUm53BLi1R+17e6?=
 =?us-ascii?Q?gcZ4yr8e0BHnmXniAq/hCaEdr1J8jfYzHCktBdAC9mqwPBgoE/6ck0HuVrAe?=
 =?us-ascii?Q?qcQGjdc+6TQsU9UanCCP//s0fX9EevEl/eV5T5NMZNug+1RZgizyFnfghO23?=
 =?us-ascii?Q?RVsTPekNlpTpr/17nLyVnMfTzijavDzI9Qkf6UFFpaci1OzAgZg293ckSxsP?=
 =?us-ascii?Q?Fl9orfpjG3htMPkNCqLHhTJykpDfLRXSL2A3N2Gfw2Wte1sDr9WgQ5tfliyl?=
 =?us-ascii?Q?Ufb/tiXryb7b31IK5YH3dH6hJ3vnrkwXNyvBozFyzozt54PfJZhO/5ZUqvgl?=
 =?us-ascii?Q?iZNe4dkfcauztQvIjOyXrqkjxnjSNJH5QTaP2wLydLgcVxEW3hVH226NyeNv?=
 =?us-ascii?Q?FKl4Rj5jbXpXi//fqnKWEIjrmDfSpxKcnCkO7y7mnCmPmbo4OBq5vwZhczUJ?=
 =?us-ascii?Q?kGUtsGO6hYuN8duwxI2XyVUdWFy8EujRO2T0BSoGRrRv5d9J3SxM9YKHujcd?=
 =?us-ascii?Q?4HT1fpdhOqEM1VzKXR1Uy3vkuwUoDtFcLFnEkPkwUYVUO9p7MUZid+OeC0yR?=
 =?us-ascii?Q?qeImqKz35ll/gFUh254NnaL2p0UTiEkmFs9hTwKJ83+rAP+kULsly2037imh?=
 =?us-ascii?Q?ZUafQVhLuJ6cxTM1dl2+NFaxf5lis59ZAYBpmTJ3UZw8ny1xIFBOTkPxeJz4?=
 =?us-ascii?Q?FbsypcKTT5GmKTv5gRlNBJDphbraUvihYFVJzbsgOyp80LXoUxmvhIkf9qRX?=
 =?us-ascii?Q?x0XVakjEK6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kh/IaFbqqyB0q7YTFXLbNo7sCxXPzNohVSZ+HZ2ZdpHbE0+YtuE70wk1LppQ?=
 =?us-ascii?Q?JuyyiSnDtdu5yy+NkVL1fISj+RhAQbnEIpsqRHra4Z1jI204J0V90LGY3Ldq?=
 =?us-ascii?Q?EbQOE42YVZmPi8+k6UugqzyzEcdqm0NHJxcIeAMjmNerY3ag76BPaKSBE9Zs?=
 =?us-ascii?Q?+/ScxSW2IHZyc0sxr+gQ/Vj4+S3rhepjuDqe837SXMcGaxLhJwyq0WHQ4tPP?=
 =?us-ascii?Q?8ettA7z91SDRofznRAQpw5PikzsZydLxJOWG8MnNCM5jRHgAlnFJ4z4l7dPQ?=
 =?us-ascii?Q?F+ooms6LlBofMYHfUs8C1jvK7VxGUNYb0uQNgEe1Y4cVw7HhAUqDZfLyko0k?=
 =?us-ascii?Q?nBgKbGNpSVq6SXrFjMvd4U60sG3sv183Uftzjvf7b5fA/cV/QKoDI2OmwBud?=
 =?us-ascii?Q?RX9lJWna3hmIYUZChQxT8cMC8XutdRnAfMEGbBSLV5zoFxX/lH2Gltdjqnv1?=
 =?us-ascii?Q?BzCpxgKMjl/dWG8zbxdpfGFDdur1LVKaH+bTpbsqffySTG2ri8hMwA45CJcK?=
 =?us-ascii?Q?hai5Qhon9aHMZNjSRkdeWwK+vBsCcES49lCb2uHinNOxFSGqorKn2/KkbkiA?=
 =?us-ascii?Q?mwVclKmIPB4ijoMAQEAlbYYBKywMetKpfb4qqMjQLOoufSoVpg8K4fBB35vw?=
 =?us-ascii?Q?UPkqn0yte8HVqxBJ258PfbIYh/wNgXjdTgYVTsTlYEeaqP2i4xAvJ/xDnJ71?=
 =?us-ascii?Q?/Kd13TKSH3+c7rn7y0hzDCnaJFWw0ezuABIycSamYmF0K5PcurrZdMyV353d?=
 =?us-ascii?Q?TKpIgxNMpoXOOYdKNhvWfYk4+XKelvwb7n662UD/ximL2wh/vKtckpXwPuh2?=
 =?us-ascii?Q?12y6cVlL217LB1M93zi7W/MWId2rvIIPVE94lkF/LZlfyLKkKQwy55zbDLzk?=
 =?us-ascii?Q?NMdJt2Sqx5WAuTwnSImdAiECPLQekl0ljG++7aLcx23MNQT/fgrdB8PNeHHO?=
 =?us-ascii?Q?gBwGhxuGu8NvqwMN0iZBwBpeY+rmoZgZXaPGP+qKGTCuPV+0OFtW9n3RmPQ7?=
 =?us-ascii?Q?eno1quESUMDjELMizBuKruFg6GaI5FV++LtCPShP2X8QYcLvQRrjiqvKhD96?=
 =?us-ascii?Q?OnDfncJQr3f5WGYuitIA8SWwykKyyi1TA83G/KUE+e+byO7GA5VVdSAn/3Ln?=
 =?us-ascii?Q?f4inbq22PmmVkxxZaMH9xThWL6SzQvrTJQjewWTlpdHlW1RUGk005h2LYz8J?=
 =?us-ascii?Q?jK53aIYyhI9TFyIFbS3pmiYwOBOUbeS4w1TzvarRQMa6jWA9e/1fJK8ioN/G?=
 =?us-ascii?Q?dyUpTf7k5xdSGr5ASyy46NQSzC2UeZNPGdmwiw3b3mz7TUBoY0oSGP2usHgc?=
 =?us-ascii?Q?0z+pcoQyKbMltmWlpvQJrO2d2FsCOkeDmrAXw6Lo2ylrpFE+zIYUHOOw0oh8?=
 =?us-ascii?Q?8MhYtZHDHitHuTVHY6wWpqwKCfmuLKc+V2xB1hX2So+6t1p3SUG4Lsd3A8VU?=
 =?us-ascii?Q?A/T5Cntp2IQVzkOMY3Ng6R8+f7n7Oaey+zYHIn/tGi8e5Zh72QcLQV7aAhW3?=
 =?us-ascii?Q?kjOr12xEpnOM2WKagKn6X1Rhkj8hzHR7woFpnidsRDWkbNCPbwWpJOb0xNqx?=
 =?us-ascii?Q?eokyWHW3EioZtUgMJdAhbZFiteZpmInwaZEZmQ3rwF8RpOk1juXtzXxWgYgx?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G5Dr62MgQzmrjiNuWZ1xBSaDwrHyTtHj+LfID/kG5sPPI8IAWNZr4OMWUcxRhz8bt6GbJWTE6QH8D+ehUFztRGudau1sWFeX6Qj58LNiY2ykE5/dsIfARrEF2nsQOl8OHsN38rsgqVEW55ifsADk/Gf23yCopdtHX8vCtiC98Fdm5h86v/LU339vI12HIsuoTIeJ15ADKInVqAQSzXTXKBbR68aRvRXoqnik1cZ2LVYg1MsqFGsULUtJHrV+9nhx90Ho1Da+/SQghQZ6qW8CfBovmp9LUgpWP7aK/PjzOE7QqQyQzHZrxdauyiL9e4RgULjBX3ts994prMTHtPi6B9v7WeST4Tt9sKmkg7+P3ToNIIkSrjWHCaPosCOkRVyfXUSZ1WDRgAi0JbloF+iYm/jXKai6YP+wu2d2HHcHaIO9WrOYL0keobcdv52YZPHgDutUTjx5YObkFte4v68/iCr+jvrHbOC/ZYXYTEasrrhhechZfJp6yKZWEXE6rXsAwLjIqeT/rcGL/askmFL0/sNVsCLGwFMR0PM1gNOO/xwBT/CPtLns9r+3WNWoOFzRjJcjTWg9TaCq1DMn6ek49oornmQ62yCr6xv2I8BCR0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8280e7-3cac-419f-8b9b-08dda8cd30cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:48:59.8905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IivlcjA0y/4aDp/lbODQbVHBkBtdF9MCSBdDj7jbFQDSnGlaeSDciWi49FLYtFv9NzD9Qei2tTpSJXMp7xtu2bcDFAuP66jprIcOpDLlmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110084
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=6849510f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8 a=RMILzy8UOvtzH9jwVhAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: T9ziFaEfkJce0gu4Ohxeok9C9khbMw_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA4NCBTYWx0ZWRfXycvw3gr+bBmZ sk5qzP6/gU0GaDE70YZrpQqZWlfOISmc22H/Oi6XFCFseJxEoCeEVUKTNNJjwhgVMUpYGTQJXO+ YYhBLphOASe08Nhm99+jsyd1RgC2WFHF26/e4Hu0Ql93pr+9l827x09OM7f9TQHRTjBXIwEUkH7
 JhZqQOGZtikT9mBR0TJyVpTH+/WsmbcerApDLt4rLRGsINaakNmcWBkToUyXOxJ4sLrlM9rM569 4hqqIilfucC4HGgzov/B5cRHxScDCCN5IwDViMdut79A4OEfGfZQV1t5TyyqsLW3TDAxdQiqZAR adPP2RPCXwFnKDsyle6La0yDwcXcvujMVCuGeKWXf9aYgF418u6Ch1Do5dz+u8mttWV0+dJtI8h
 EKWTWSGH9oTa8rNlfOBFWZrQ5ZjtFqlKYAJf3SQWI7ENCy0551tA4aIIIeQdngGn0rO1vqlc
X-Proofpoint-ORIG-GUID: T9ziFaEfkJce0gu4Ohxeok9C9khbMw_l

On Wed, Jun 11, 2025 at 05:40:06PM +0800, Pu Lehui wrote:
>
>
> On 2025/6/11 17:18, Lorenzo Stoakes wrote:
> > On Wed, Jun 11, 2025 at 08:40:11AM +0000, Pu Lehui wrote:
> > > From: Pu Lehui <pulehui@huawei.com>
> > >
> > > As generic read_sysfs is available in vm_utils, let's
> > > use is in thuge-gen test.
> > >
> > > Signed-off-by: Pu Lehui <pulehui@huawei.com>

With the fix below:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> >
> > It generally looks good, just one point about a warning below to address.
> >
> > > ---
> > >   tools/testing/selftests/mm/thuge-gen.c | 37 +++++++-------------------
> > >   1 file changed, 9 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> > > index 95b6f043a3cb..e11dfbfa661b 100644
> > > --- a/tools/testing/selftests/mm/thuge-gen.c
> > > +++ b/tools/testing/selftests/mm/thuge-gen.c
> > > @@ -77,40 +77,19 @@ void show(unsigned long ps)
> > >   	system(buf);
> > >   }
> > >
> > > -unsigned long thuge_read_sysfs(int warn, char *fmt, ...)
> > > +unsigned long read_free(unsigned long ps)
> > >   {
> > > -	char *line = NULL;
> > > -	size_t linelen = 0;
> > > -	char buf[100];
> > > -	FILE *f;
> > > -	va_list ap;
> > >   	unsigned long val = 0;
> > > +	char buf[100];
> > >
> > > -	va_start(ap, fmt);
> > > -	vsnprintf(buf, sizeof buf, fmt, ap);
> > > -	va_end(ap);
> > > +	snprintf(buf, sizeof(buf),
> > > +		 "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
> > > +		 ps >> 10);
> > > +	read_sysfs(buf, &val);
> >
> > We're losing all of the 'warn' logic here so if we can't find
> > /sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages when ps != getpagesize()
> > we no longer print a message about it.
>
>
> Hi Lorenzo,
>
> Thanks for review. Right, we should explicit that warning when ps !=
> getpagesize(). How about the following modify?

Looks good to me!

>
> diff --git a/tools/testing/selftests/mm/thuge-gen.c
> b/tools/testing/selftests/mm/thuge-gen.c
> index e11dfbfa661b..8e2b08dc5762 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -85,7 +85,8 @@ unsigned long read_free(unsigned long ps)
>         snprintf(buf, sizeof(buf),
>                  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
>                  ps >> 10);
> -       read_sysfs(buf, &val);
> +       if (read_sysfs(buf, &val) && ps != getpagesize())
> +               ksft_print_msg("missing %s\n", buf);
>
>         return val;
>  }
>
> >
> > Should we reinstate that?
> >
> > Other than this, we're ignoring errors, which by default means we return 0, but
> > this is what we were doing anyway. It's only this case I think that matters.
> >
> > >
> > > -	f = fopen(buf, "r");
> > > -	if (!f) {
> > > -		if (warn)
> > > -			ksft_print_msg("missing %s\n", buf);
> > > -		return 0;
> > > -	}
> > > -	if (getline(&line, &linelen, f) > 0) {
> > > -		sscanf(line, "%lu", &val);
> > > -	}
> > > -	fclose(f);
> > > -	free(line);
> > >   	return val;
> > >   }
> > >
> > > -unsigned long read_free(unsigned long ps)
> > > -{
> > > -	return thuge_read_sysfs(ps != getpagesize(),
> > > -			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
> > > -			  ps >> 10);
> > > -}
> > > -
> > >   void test_mmap(unsigned long size, unsigned flags)
> > >   {
> > >   	char *map;
> > > @@ -173,6 +152,7 @@ void test_shmget(unsigned long size, unsigned flags)
> > >   void find_pagesizes(void)
> > >   {
> > >   	unsigned long largest = getpagesize();
> > > +	unsigned long shmmax_val = 0;
> > >   	int i;
> > >   	glob_t g;
> > >
> > > @@ -195,7 +175,8 @@ void find_pagesizes(void)
> > >   	}
> > >   	globfree(&g);
> > >
> > > -	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
> > > +	read_sysfs("/proc/sys/kernel/shmmax", &shmmax_val);
> > > +	if (shmmax_val < NUM_PAGES * largest)
> > >   		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
> > >   				   largest * NUM_PAGES);
> > >
> > > --
> > > 2.34.1
> > >
>

