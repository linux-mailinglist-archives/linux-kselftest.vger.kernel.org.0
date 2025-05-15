Return-Path: <linux-kselftest+bounces-33110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFBEAB8F36
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC111BA2C89
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C832690E0;
	Thu, 15 May 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mMJD5IeR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fQN9XxRo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9228B3FD;
	Thu, 15 May 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334499; cv=fail; b=mOzhZ5qb4sjEw9SyZlWe5hyw88KOsFnHK/ZvDblwmwD+is49ouS498E/dJvJrFafvpRDTtfKVmxFh2GmPMFoDCD3ntPOcoUKUFut1/JvftjS+51biHM1ZvvsUrxWqHq94oXWfWAQKqPpNp8DpUeISiOlIN39DBunTjgc712RxHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334499; c=relaxed/simple;
	bh=7Pj9W+KeNq/OJQWk/zqSrqZ3y+nqXFjhB6gJ7Ax8w5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=to3OrCyIUROaMhTdRvdj8Bieb1NCblGb+5Yj7dGG6rvUdPlMw23lDC4r92O5YiAwX7OdoY4TDS5B1CpC73YvuFuy38PiXEkCY+nYqQP/alKWCcuTnomPnqmOIyixDI2l7w6xe/76bJhug0fzEAqyFSwKYsvS43sp8UQMNvHoRag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mMJD5IeR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fQN9XxRo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1nKV023598;
	Thu, 15 May 2025 18:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CKMcjTYZLjkdkSfers
	tBNzqHJ2GrP3EhrxMJPOH7T7w=; b=mMJD5IeRu2Ia1NqTR+72qtRILif3wfRHab
	2+T8KgPi0X1tHnU6xXTeVOczJUoZYtbcUyz0EsfaQudZsxfWOdxYbPhDkSEn1cKB
	s4W6Pwq4WLtWX5Qfm6NkyY4Ixxts83TjJKzfuz7O/Wfi6aDpKLGtbx+cWuoS64tf
	om+eU5lNtmbubiiLP0ObAwPgKeieosyIh0N4Gxli/iWYCL/Px1bYt4FvN1a0qO2u
	t8ab71LeXbNvESYU3Yr2bJFbQevCOb9b2Btw33uVoqPESQBm0noipDxCXcVTH5Iy
	V/h72cRrZ2OwkPMNvgJ57zTYhAMhqviWhBJt28sTOuYinZsMB4Tw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcdw0dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 18:41:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FHDbkZ016824;
	Thu, 15 May 2025 18:41:15 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc356qkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 18:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FURws6N2kkHlQn8o/0FJIfs5Xl9lKpoAedjpmmNT57ZHkBvbfkIUrKzkdjyprHwD+AWj/EjNsXmuPV7xxibyj6tYU6ii6ZhG2e0G8fDrl2MOkYmLImpLfn9ebv1zr2lXJZpsVqDuF8uHCWbp3Y0dBPNtnN3sKk2sNIMwVhui+DvWJbttX+8RSLTszMVQrkfZuKZ5cBc0gRZW22+jgcGCbOuWiI79ZGi24jHJZE5Nvl/Mi3T+bAyVm3sOHlS11W4DRqc56+h5LwH6QnTBq7rgCc53XyNOys0cftsyXH0D2QQ5BFz9sQb6bX9rg6okwecvRjxlTf/+75/7mb7HaWrMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKMcjTYZLjkdkSferstBNzqHJ2GrP3EhrxMJPOH7T7w=;
 b=W+XcbjzyK/ZRJksW8NHCGXuoVU62NEFX2eidN5UeuzB6aK1iH1YrIrfyatT6yaDERPLewb8wNzuxRsBreMdfXAm2s+luBks01WOwrtxwhrrJt+KWnY1shX/UFekRASV+x3vnjS2QCmcwiLUwSfDyCaKluiig8+KAYEWqsbIpjSarr2TdCwoMsqMsI+LDETA2mM/s8AurQZ+rqqvaObZxvHp4kpk+wBKs45vUn15JRW9RaT12HYm0W0RTBtpFivH9Oe6Gkt/gtEOzm9ZXi7O281Z8wpHKSFTYYraWa/4JjGvNiUb+X3rKA9ZdfFUfpt4gLSw6u8M81cndvcPqQ0p7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKMcjTYZLjkdkSferstBNzqHJ2GrP3EhrxMJPOH7T7w=;
 b=fQN9XxRoCnao0VbD8XZ0jb/dCMvFUg+d8VdxWCp3DlIrBFjWqS+oni9kz6d1LBmhBiqRG5IX9GRKt2zBrynCFVtEDjnA20jYort/pAsdTBtVEXvIjZD4WzNdzjVacs2TX2fKV/fNnM2TXiN0ZgUEDLMa5kzwl2Qjo4aWCxl22eE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4743.namprd10.prod.outlook.com (2603:10b6:510:3e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Thu, 15 May
 2025 18:41:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 18:41:03 +0000
Date: Thu, 15 May 2025 19:41:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Adam Sindelar <adam@wowsignal.io>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/mm: skip uffd tests in madv_guard if uffd
 is not present.
Message-ID: <ec648245-c771-4e4a-b355-a86c99ad8143@lucifer.local>
References: <20250515182333.346587-1-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515182333.346587-1-ziy@nvidia.com>
X-ClientProxiedBy: LO4P123CA0676.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4743:EE_
X-MS-Office365-Filtering-Correlation-Id: 968e4548-a862-4791-dab7-08dd93e00b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FfzYQT+pLpU/C+QxzIzATauLGyrg/pqpzp/EVZYWLQ0NsIB+PHgSsntEj9AN?=
 =?us-ascii?Q?2ojb3u2vX3SPQmE8CjkO8oTXMd53MXYuDW9zAf8+KWBNWfpXkHAQNHtdzKID?=
 =?us-ascii?Q?3C9Ia6UWX7mayJjBLqlpg5M3+mZRZpjRqu7JeUEhYrQiPmotEf2Cd3P+VsCP?=
 =?us-ascii?Q?TSc8k8guV3yXU1+9SqMhkVtqdG8DgHP9pxY9UW6cnoZGtuvw2lArC4tlbkvz?=
 =?us-ascii?Q?logk4m190Dyb4M5eoq9FIRKUL6arMFopy1Zh4OjbGn/VgTcJIi89MHvruIZT?=
 =?us-ascii?Q?7t1UKQSDGKDpDzuIk0bORLOQ5h/c8hVeIX0uIDhSf8DxaxDHSuztn/IiMJKm?=
 =?us-ascii?Q?PoFiYjHXbi53gczpbahxgbLPBWqbtY17hINkMxDf8XV44vc9dnGddcY9jNXB?=
 =?us-ascii?Q?7y94sycCu43I9BuHARkM4n0eC5/iqmbF0NuKq93XZxiEjFHkNDiBMcWSocGD?=
 =?us-ascii?Q?CUQdi8NIDy4V1qjmXnlNtvTBsOSoypi8irNM1PrvVhW1ahY1evW876D0QLBk?=
 =?us-ascii?Q?hkPZsV07qPckAgm+g0TezCUDzhGmSunVtfzd2lTC8tJEMIQJeVXFMy3Ec4Oy?=
 =?us-ascii?Q?jVDupZejOuxxU2z7cvzITt2uR8ei12Iu4jpB0Bc0qB8uOwfeoEU5Sa+VjI3M?=
 =?us-ascii?Q?Cfh7LseTSSmyx9dsyZi3SfG/e9bGCLYqeyR8ZWrMgetjLl/NesPgtfPKIizI?=
 =?us-ascii?Q?AleVixPmBk2EhXnceU4HrFzCaE2rtps3G9zgtyhLXkdX6bMnrbaQrm/qazmA?=
 =?us-ascii?Q?64vLGMM9J/1Geqyac0rOkZbFKB/EGJ+BnOEmBB9yFECwEB91g4s0vKmK1GQE?=
 =?us-ascii?Q?3BfyuNukfjK2DII2KSC7LEEoFDjPt+StkhZ7QUVUznvC2QygsJ1fu+f9mjtw?=
 =?us-ascii?Q?xblF1mnlzMDbWGAkUKgIicOa3Sbg56MoUJGhjDSlVSIRxCx5s95YayW078un?=
 =?us-ascii?Q?IP+p7A4HHKErjMR4ge0tyswI5D/sS+x5Rguu1rtq+pOPmckANhTaGXseAsa3?=
 =?us-ascii?Q?WK98pUDSfnl1ncG2V4UtGGHZIYRCD6ChtrQ80DX99LnikuLmzWYLG5SgDqiz?=
 =?us-ascii?Q?1h51XtYEfskDlzrytC/OPqU59a+TiHZ1Po5Vc9X0JPSc5YClGJ4aHas+NCnm?=
 =?us-ascii?Q?9481CktNT1vLCZzy47NX9oz2bKCRWGSHcrcM1LTyHy7M1v107N6OFbS12OCi?=
 =?us-ascii?Q?P6HG9GnfXA6Rhmhgw152I2ZlCpzP0q9JwJcvZV+vQvvUfcBwWH33MUzxC5hr?=
 =?us-ascii?Q?rm9bDfWU+V6sftSQFAhRGZKDrpfy2K+tT8U14v43FkXkOm2OVPZ4yMR//URE?=
 =?us-ascii?Q?XhyRfm7k+qJvPsI313expVVoLn947aUR/MFkZBw9++cIgJlfeK2uHZ3f/XtQ?=
 =?us-ascii?Q?MTAE/LdGjT84myvbPXxLhc07+OeJ4fwXw7kC/FI4BFPJ4TOwrAHG6ZtO3aVl?=
 =?us-ascii?Q?FZeKd9mgRr8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qiUGdnnrJuW8C4ncK+OEnX0mhNKqAWrdHvgjaQwhjPgqWoDZo5iLEa38bVPH?=
 =?us-ascii?Q?ELGjYmxnNUw6vsp8hZnCXgTjVoCiQfoDcGEgGGq9FyPCa5dy2cptzj8fmvP0?=
 =?us-ascii?Q?jpvTNkEqk0VhYN1Ynbo0vK281XkeE/D1iJeOlulMpmvshhMo1txeeJWPAtFQ?=
 =?us-ascii?Q?8VyRZ2PN0X6sVZFM0YuMTH7Fk8xId7Dnb63SkWf1okzbp7gd/lBYAMHjtmnn?=
 =?us-ascii?Q?zw3ujAL/zoB9DZohdBEoU6OF1xWmTaPcEo+LVwbd+5ESzjzdLPl19uyGeH4F?=
 =?us-ascii?Q?DNhxclnZOpo8+55JPsxHt/YsiTwiAidO5edejTk1CczvI7+BwPN3uu8RduaH?=
 =?us-ascii?Q?WBbePMuSfolGuc1uHad+eK4rpld4CwB90l6tvC/26bs1fXTR2HOzVJcRr+f5?=
 =?us-ascii?Q?TIjZaUOr3vDCnBfmhlrez7E5fkV/2z8du6Gvn0fWGUHNFJA0Kakjp+Nlap5q?=
 =?us-ascii?Q?qQgFE6TjY0RyWuIVprBTTm/KA0EgRQNBCZaIjzPuXI8FaBbJVZPhZVEcZPQO?=
 =?us-ascii?Q?xfEhRFoXr/AxK9i7WFEAOHPPKKnpvqpg1U8TVwhfNfGm7AjbA2wcvLChf8XN?=
 =?us-ascii?Q?yHDCV7sRE+cKBjxkNO4wGvvoJc5x/iU4QNPRvlKymj2wOLwRRL0XYBtWO0/w?=
 =?us-ascii?Q?Fo6QGRW9sBnkNM9lsA7afthy+Gb9nFDEzXC6ZslkLkHWPkN5H23144rIecKU?=
 =?us-ascii?Q?kS+kDu/w7M7w1yDIfjUQl5HTkndHPMGawgakFrVAqlBE/TPGRIjBRogOWUYz?=
 =?us-ascii?Q?Cu4NeqiM64XVGLGadFLCdI1wcR7seP9H9z1JjPnwDFO7uVRTJ9gbAmVI2s0D?=
 =?us-ascii?Q?a7B9PmZ7kMesVlI6Eo8RelrL2OQ3MD6+hiLnl0z8sqZOIKmUTNr18W3ivSNY?=
 =?us-ascii?Q?wxX1C1kw3+b0jDQAqKc/uP/Xo670B4sQCsnc0L0I5L8yQlsP1Afw9h5nZ++y?=
 =?us-ascii?Q?nyQdnE0gWPyOeqY/CHvUA160UL2wrVpbbHeHgy+454X3RO6X2E07U/6XZMMn?=
 =?us-ascii?Q?+424OAwUAH0l9Eq/fag4+NKMNJeqJY2lx7UdUWz+rmHrma1LUfi+Y14p5OGg?=
 =?us-ascii?Q?989eHun9mKFsTTgLYK4vvMZOqq/AjkgvadBtZrdsIiCqR2mvLTr/SjXfF3Yz?=
 =?us-ascii?Q?b3ghtiHWisheQEH8/gGciAVYcGG3g+qIMe778OrsHVrnilBE6swyC9KOx2s2?=
 =?us-ascii?Q?yWudwc95KgH3t0WbvNa7Mi20XlYZIEqJUdKMLsits0ItCdkzczzvezwIOn3K?=
 =?us-ascii?Q?g3BJTrXLkxYdRSlFeglA8hD2G67xT2EAAaYx8mK5jDiSDT/43IjTHF/XtAc7?=
 =?us-ascii?Q?m00W//tMB25ZnpMWU1K6f4GoGoerHxzaVzh6YMbK4aZqqDhkqkwUpFJ4ZSKR?=
 =?us-ascii?Q?JYWYqjzoODuwFa2rFiyvODTRa8KVwgPRfDL3Vrki/lf4E2k2ML6R/rlu6rPi?=
 =?us-ascii?Q?6FUtOjs+Kg8jWQWgJSlTUXjICC0BjCHoEil2crH4ZAMXVm7S0iSmNOIwe7Eo?=
 =?us-ascii?Q?affxbBCqPL/wRHxEV43Jow8HoXQueP+vikYzKZbLnJzukyS0CbOEM9ye4iHF?=
 =?us-ascii?Q?e5xOy6bteLPCHE9ql98hg04K3VV3JSte3UzuWwkugiaURe0s96NhzZ6XgwiI?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y2AbyvBPs80w7INxxMSOmvewIl4m55nGmBvsGdKNxeTx7f2DRLpn9EhmSCMefZPpogME4JNa8meC3OY4iNSBTtwef8rqOMkcqM3Usa2ly7MgwTbs3Y/e/8t2+VXYVo8GT42jkk3gwtN838V/jiGDqALYIdGBXA4fQ/lvsQHbgHRq3ZJrQO6tUsh1/7pv5Lq5iBDzjOMNYIy9hIcosLyN9ptD9jebxojZvZpToYSdx7ms1j4UB3Rnf1jSjpLuy7VPjrG2F6fRuBcAJkZEw391OzvSiyv35OrG34pxoNQFthanuqMLDr7clWXn8sWjzfvHgT1e+GE/r5URuk6QXE6dwl5+KVP7GwgQX14CvaINUDq0pkqa9i8ejwMgzdF1LSEusS09DaJcM6AxOxEh3f4wMVoyTxHkRbAL/kdyEMx+9VDv3/Oe4RKFZvs9P+RLdZB0iLUHfdW308QPDZ6jLuoViuNmE16YUEFzfth1a9CrCp+MzBzun2xhZqFDA1NznoOAaDThdHj3hCnckxyLHUgEj/STnKsXKEoRwrESzyOvHB+GdfHeTE/3Jrytvi57lHvKhuqHgh+81a4JMeHIkUpMH3htVMFN5jx51bMIKGbs4/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968e4548-a862-4791-dab7-08dd93e00b88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:41:03.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFT4Nu0LfheFWc7by+a4HiIHHgccQ7cPjcBmcmQVi8jGIw+XU8n5lZRvKpEiOs48Vo+6j9EPXD0yOOvZ6vcb8oVr1/TUo6/OPyL+URS9zek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505150184
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4NSBTYWx0ZWRfXwuKHkZaiEJed mih3ssB3z+eL0PjCParda2TgL4QppbebxCnn2gxqBXTDhGMsp7gtUK7UHLkMpZCVpFy4Btu1Zf3 /oHSIRa4dQc0JuXKMMAtyAKVE7/QLZaQtu3qikxsnKpoMLiRj8yic79dy6VS510rbYHECC+aKS7
 2Vc4lAVdqOv8mo+WH0acqgNarDoKx556RLaxQ9IkpC280OtS8X3qCZvhfyxodrZWJA/HEdSAf7I KJk3ZHUWLKRezoa0EBCZvg4dFw9yIe5WxfDmupbNmeznshanwj24LYwuh6tza6+FS4T+LZ4cW0X Na8OS0eY/G6+rsEv2JaJac+BCdXrlyVItIam36wDfJ4swmSp9QYdNLJ9fMszL46E1qxQmDgKB3v
 4+0uWxlYt6cqztPDNd51ANbyeCXUm0+Wm9k8pJ5N6iAFoBlwJ2Q+J1E05aZHNrfoL+HS5wPR
X-Authority-Analysis: v=2.4 cv=Y8T4sgeN c=1 sm=1 tr=0 ts=68263558 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=w-tlDc9taImDY0Rjrg4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: EQ05pyldllo-e2cK6KqgDivTqTRmBC15
X-Proofpoint-ORIG-GUID: EQ05pyldllo-e2cK6KqgDivTqTRmBC15

Ah you got to this first :) thanks!

Could you do this with a cover letter though? It's really weird to have 2/2
reply to 1/2, I know sometimes people do that, but it's just odd, and it'd be
good to have an overview, thanks!

On Thu, May 15, 2025 at 02:23:32PM -0400, Zi Yan wrote:
> When userfaultfd is not compiled into kernel, userfaultfd() returns -1,
> causing uffd tests in madv_guard fail. Skip the tests instead.

'madv_guard'? I'd just say the guard_regions.uffd test to fail.

>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  tools/testing/selftests/mm/guard-regions.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> index 0cd9d236649d..93af3d3760f9 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -1453,8 +1453,21 @@ TEST_F(guard_regions, uffd)
>
>  	/* Set up uffd. */
>  	uffd = userfaultfd(0);
> -	if (uffd == -1 && errno == EPERM)
> -		ksft_exit_skip("No userfaultfd permissions, try running as root.\n");

Let's just make this all part of the same switch please!

And while I originally used ksft_exit_skip(), I think we can just use the
SKIP(return, ...) form here just fine to keep it consistent.

> +	if (uffd == -1) {
> +		switch (errno) {
> +		case EPERM:
> +			SKIP(return, "No userfaultfd permissions, try running as root.");
> +			break;
> +		case ENOSYS:
> +			SKIP(return, "userfaultfd is not supported/not enabled.");
> +			break;
> +		default:
> +			ksft_exit_fail_msg("userfaultfd failed with %s\n",
> +					   strerror(errno));
> +			break;
> +		}
> +	}
> +
>  	ASSERT_NE(uffd, -1);
>
>  	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
> --
> 2.47.2
>

Thanks!

