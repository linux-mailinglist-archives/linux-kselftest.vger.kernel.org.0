Return-Path: <linux-kselftest+bounces-48145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60512CF1620
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 22:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29AFF300662A
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 21:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316E82D6E7E;
	Sun,  4 Jan 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JC/3PAVX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n96bn1GR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93298248F68;
	Sun,  4 Jan 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767563413; cv=fail; b=pT6CDdXDlJREMwdRpadTTcnSzJSfZ/KxqgHCh9q5dBFTw5Nlvu1WS6V866SCJGCqaapC3sToOcSIsg6dy0vB/hd+WefQMXG/aQMLTFNddYSoPX1e2QbQhbZIFNXNqv0LayfkfIbFhD0t9bSl3+DwbAnpnuEVFfKxs5T1VRAiGDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767563413; c=relaxed/simple;
	bh=tgYn/yQyYq+1L89QW9qcH72X5GhY9V55dV3wsMUMHko=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=LnEytSd+VXm4BUfNM+YPm077lW5xDb87FXXHsW5PNWVIJy+BL9LXSx69eMnpTJRDZrvuxh/cEJwh+DNOWlgaRdfwMyegDbRuaHUH0OFWrkbtL6Er/K7AZFWY2NQD1veveCutzCa2FKrLr7ONAEmz/Lg/XSAm2SiGxMknytoNH4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JC/3PAVX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n96bn1GR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604Lo5w6084911;
	Sun, 4 Jan 2026 21:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3XGYoAL3K2kz74Q87v
	0JfYRS7p2y9+RKbE0ZWdjomb8=; b=JC/3PAVXdOCckbFHOqXKcnT7UL2HCa+oWH
	UrOpW6Neu3PBRRROxVDkZwkSLLnBs87EdS1ApwhpiqKCVi1cBZZra2TB1lFalvB1
	y5cxTZMprgnFdeA1vdm1mh8oitaCJm5WdCnIdvqWg0BkCxNXtpgorJayuMOFvFkp
	eBPU4uUJpw7XjMptFKjHSr4EvEEev3Qkkwq6gTM2Zx0ea1q8ue9qUE1FvzKPsl1l
	Gz2MOZBdUW7GuRO7vhhJWMW1KaZH6Ogiu05PXkiXZzGhr+fzGLgMK3D2tSTW4oQa
	gCauYVqjcwSYGNof/YkQDpkfyYK6+EuQwtVoPc2eECwOiZssk22g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev1qry45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 21:50:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 604GfTCS030813;
	Sun, 4 Jan 2026 21:50:04 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjarh37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 21:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7Pn7qhtgJ2e4LjjjHRBnHNz3+GUUYePosP0JsvwvEP7P9+EgLxSsH+0j1f41k70FDV0CvgoNFVtroYdKVo4IrpasPHc0IA8YRAORE6DJkeBTtKXIAiecXw2woDD2xeIhjfZ/d1K5VHKPINBVejqiDwexzdE0nLaEvrTgHmXEwHLe3EevlqidfsqH4Eoo2nG8G3N+VhOO+edAH4b3rmU5gscxuJkENmk6Rq6WSctCckmnoxIDdQUIhYwDUitIfAXz8nozNfP7k1A5MqsJWoorEeUxCYAPpe9yO7HVunZypIHO2Icul1gxnS6w8eOdWfpHL9hty1ZkrUX/be1ALqBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XGYoAL3K2kz74Q87v0JfYRS7p2y9+RKbE0ZWdjomb8=;
 b=Q7Z/hcffr0gxiI0nN/GS8fY3oJO6vVOogreCBYxwlo2AAL76j9zvuHn7tt9MC9WbDVNIlULmMNxPj77FPPur08cHRDmxiQfjsmLf5TB74OO87Hvh1rvdj/wx5ImFHNJdXKtXG76PP3ovMa1lY6A0X/6ePNlj3yjnv84vArrJ5cK0qgiPwEWQWJBcxmN2xX4lDAadEPy+aToicrX6Loi4LVojGizei0w9Dc5FcwfOCinscxidPc/k3B8DtAPSvYfKpyKFXTUvGXLelUMRz27ELn6b1OyYN0BYXbC8RRdbNtUIwU4BfrpafFDgSL3OJXjsJrjNiCEx0t1XZSk/hzLF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XGYoAL3K2kz74Q87v0JfYRS7p2y9+RKbE0ZWdjomb8=;
 b=n96bn1GRsXd6a0kuhq0jryTfAO9/BOEkSbYPXb/aVfA7IwPoMLaHfwjjqQklf7EeQW2wLK3xcgV8zIzWpWp3v9ImZtCpKcD/r0vAb6ETcwcNSht5Saz+27lgeyU/1pKHP7CzOtHJNnqWmsdWz1UvekUHp11acUxsg/ydShYM8As=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DM6PR10MB4283.namprd10.prod.outlook.com (2603:10b6:5:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 21:50:02 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%3]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 21:50:02 +0000
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Shuah
 Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanley
 Zhang <stazhang@purestorage.com>,
        Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH v2 01/19] blk-integrity: take const pointer in
 blk_integrity_rq()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260103004529.1582405-2-csander@purestorage.com> (Caleb Sander
	Mateos's message of "Fri, 2 Jan 2026 17:45:11 -0700")
Organization: Oracle Corporation
Message-ID: <yq1a4ytt5du.fsf@ca-mkp.ca.oracle.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
	<20260103004529.1582405-2-csander@purestorage.com>
Date: Sun, 04 Jan 2026 16:50:00 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0188.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::31) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DM6PR10MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c2e146-6c03-42c1-1505-08de4bdb36ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FM8EhuC7s81bPIi/BQjBZlOG54IZGjTBkj7bhEWP0MWksc+yRIq1B5k8U4PG?=
 =?us-ascii?Q?LTC92+vrrT+9r+9iWvVPft1r6IxVpobbF0O3B0SA16F56B+lv6IW6x6Hn16A?=
 =?us-ascii?Q?Wmu6NVFDSUp8aNcuY62uDlWk8cqi+/ijan6F4bi5Zrn0Jdy5TX9G20/qHp8K?=
 =?us-ascii?Q?QNhrlQG3zg/m3VBcZbT0AIPY7hTX2Qr9NdrTi4P+yhLEMFXlsx4V6PUF0BrV?=
 =?us-ascii?Q?nh4yEqWfHpYxPwYqs5JzS+d95dKOEyFQfBNZZhi3qryRJGhc6YPQHHJAypvD?=
 =?us-ascii?Q?LgTgViZdyVhU+ZxBxs8xRlkXGck3lNoInXl1r2yUy3cQmRt9CgN+k4PWb633?=
 =?us-ascii?Q?o5mgPoIU8nq5FWe+iGyZNb8DHiLD0ZOYFNeOiHs++qZLN9Dh5rOOdAW7Sq+I?=
 =?us-ascii?Q?+aNxPkRpDXXw2hgTpyVV/JuQRiNxcm6Vt48XO4iQd/9cqSyFo/MccDxWXasN?=
 =?us-ascii?Q?RdDzjb55vygX5uq6z5C0mA+w96Rqz5iHDbZqYSxtsVcWnCZWSv3albx1X5tw?=
 =?us-ascii?Q?q1JWN3xCEem8XBVP+OkhNe+82hQoPv2TZD9k/D33qDjwWAsmHtrT6TnJ6EsK?=
 =?us-ascii?Q?9vdeCSBGuQPx1vh7iJCHPNrxwU6XOgnxk+ywaS9CQmT+HWBgaTcB5RRLJJLx?=
 =?us-ascii?Q?qZP/G77ROpfNlYp+OHLTNctsSXhp1HLX4/6L6FlJYstwb/gZIJDUz2JWldt/?=
 =?us-ascii?Q?s9JHK+ue9Lz6PTLGsrGdQgPQTUtB4/cWx7Wwt0SIgoYTzdPcJAp/9sWGa4Q+?=
 =?us-ascii?Q?//8Ax8CayBqeJYe6vtrjEa+guDdvQIJDAuHZY7ZRIt7R02yi9ORKPfHDXGna?=
 =?us-ascii?Q?63BowxyAJO9LS+jQsrYJwONEkLopG8QXYkkpuuMCYopCT3qQsIhAtEnG/LLJ?=
 =?us-ascii?Q?maxCKZX+5gazl1iTGmfG5CfOeV1NlM7xzoaGZOM0VtFlsm7z/fOQrkvnbJ6s?=
 =?us-ascii?Q?uO/V9s0b7oCsZ7yMcqcmb7O78TNUB64PTQU/njhqtIJmHqe3E5z3QxiC9iz5?=
 =?us-ascii?Q?H/XCMTiO+3dI3HhfE8Lu5fzVjaZroxvMxw2GkX+IQkFATy09KDfbUU9kY9FY?=
 =?us-ascii?Q?9uw93qCxNbNSD7EPkHpb4LtfVzuyCxo0ur+75Rmm1rwrbG9jwlou2VKIuw2j?=
 =?us-ascii?Q?a5Yl+tkxeAr5RpaNcNv82hhHHMsODwiBZNjBA7QF8xANR/6wspwyjGizaJjQ?=
 =?us-ascii?Q?93P0+c50P4P7W2lLfN4JV2ITUvlvJKFobh3H6dwpB4Vc2hHjEx+Xcwp8xwJg?=
 =?us-ascii?Q?XGLzQYUUR6Jr+9gp4gH2Pl9RLr4JDlKZwoWjqMdweFqSq7ohitri3kglK5cO?=
 =?us-ascii?Q?HlDdrathPLLrNG9fQETDNu49fYTJgwOScqNPGV3YRurps7rOQonFjNl6hdFz?=
 =?us-ascii?Q?BpV2iD0I8dRrFy9586iCls5BjjJGjt9+AXqaImaN2F/8kGXdiUJj2FlMS5iB?=
 =?us-ascii?Q?UvTO5p7M1N1g7Wsxxc7z9reAnJ1N+NID?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3EhpZRKajI/4yJ0RcYe5nHAuS+Ghuth7PFtvaFsqhbK7SKDLxDxKGRmgFKOq?=
 =?us-ascii?Q?0LkBtY3E5CQH4vRXE1UT3kSvHjgiNjn1r+4CHgwLQGs7IIFUDYFoceV7+Ihw?=
 =?us-ascii?Q?Ryf2qmd3rzZWx9cFd1XxcOzAHI4k6Ma2QsFH3NM6fWKG4JmcOR7DPQdDfAFf?=
 =?us-ascii?Q?1ptyboajXlIguT6OiI5mg5Ni2Ec8s4v1pfHEKe9rYX7adFx41aJQsp9wAk6U?=
 =?us-ascii?Q?VkHEBSblPIO4rEGyQjobc4z7R46gPEmtTnqvZ03REyRhLKhmWKlKpptc/zDF?=
 =?us-ascii?Q?AExLm2NGTs71LjBn/B+TnVKDmwrdm2Pk8xaOoQdxhftWTvUqSS+DklTOa7mK?=
 =?us-ascii?Q?uZBX683Fx6xyCQuhlefX+RKgrDo0HzccDx336fSgbOBcw65C1DVcUPPzlKvw?=
 =?us-ascii?Q?hHOpxzhM/FeGkP3w+a946rcnC2TdleH/Xpy9FFHYwPSOs/2oD35BdtF0mOH3?=
 =?us-ascii?Q?wWCAMtn3VoG3F8b5sMZ8jntzOPsnj/ZE3m6DspP9MzpSuaqvMexSto3ue9hR?=
 =?us-ascii?Q?n+rv7/tAYYXb9YkfG1WT+IMbIVcO2BtBzQ6r4sjdxuerp+0RTKbTTkMgPqaL?=
 =?us-ascii?Q?jOy1rjQQ8EbH7BGl2D0KRDhav8afcWpBUr+Bd1nh+WEtKhyAErdViI4Isd3w?=
 =?us-ascii?Q?MPO+gSY3ygYlbEBzYmfVkNxoxDuD2IYyOrYgzdu7rUWozvntgy0fZEI8I5w4?=
 =?us-ascii?Q?QUs7Y+2WIe04/PDdiJg1BXTExyK1sPl13+/2FY55mVAtFNyY5joWpFUyuaI2?=
 =?us-ascii?Q?4NdQHKpwIYXykkROIWXgeWaHrpUI2E9NpgUPk+Gl4sy3SMRFpk/CgmVdOMBN?=
 =?us-ascii?Q?lvNZRG6tBs4ZZDtcVaH79DnIOWi2rwLnYjLmUDg3VQlLGMbfmC2AJFjahkkD?=
 =?us-ascii?Q?GURlCMwEKXYvCpiOYSTFlwvew0BUJBu7HvB6uzUUWyftKbwHNwXrNVCHYnBw?=
 =?us-ascii?Q?UukuwpWh/YC5ISX4nQpA5xufJyg2jZyJboVl21hRYMPjTavaFoFVoP1WETfk?=
 =?us-ascii?Q?PstlNXH24+5Vj+ibyat7ix478WomtlhHWC+1o1thMe2ld+Mr8B9GEdr1qnxH?=
 =?us-ascii?Q?itsqecVxPDRgzT2gF7LF/xNcPJuoGRcAFFYrmfkr/I6GB852bk7+ENF6vFYU?=
 =?us-ascii?Q?DXHbWXphRIVTm+H/q6hOLIavx2RzDaImyQIiN3iRVLQKf9zEdtDQyMbXQ5n7?=
 =?us-ascii?Q?C8wBVHCzl1LN49C1hRU7iS4D43r7IBX9e4SwhaV4V9+Pb0st2/rJUqEcim2O?=
 =?us-ascii?Q?GznsuGkikYOliXzUlEH7lcHP9fBXjVk8Ev/NFC5ug3y2NtN7k/DSGivJWZJX?=
 =?us-ascii?Q?FeFBoY01k2jg8MnMhbELLzJ3VdYKO0tx7RvyEU9o430pM7yMx8YnbTiSnwRf?=
 =?us-ascii?Q?ru0R0tFFV7lZzifaL/nMSH0k0LmJBNn1D79hlahwW0i9gwP1yjb7Dk8by9Ve?=
 =?us-ascii?Q?pIeUE7pB0IGdxof/vQSatlVsSO0rsOfnTa7XTioaRRLNMIbBURlEraUAHvam?=
 =?us-ascii?Q?wyLkqG3Q3ocavGbECLanvMKdBpV00PzetpKkmhtWFSMWhWFTXX+I4ZS37U+m?=
 =?us-ascii?Q?uhq8B5Dx6lCbe7xNmrDajraMZeDbq5jFrOGodHx1TMruzoQ+wBscT5DkefAS?=
 =?us-ascii?Q?F9tnWJCy37uO7lBrQsdpScvFgW6orXBkkGaIZPz3fv6L3cTwHRi0mBEyMgr9?=
 =?us-ascii?Q?KPnlWq/vhv23c2AEt8czvlohEnecNcui6KYL3MvcZLafIkoZ6kWyUOoab2Zy?=
 =?us-ascii?Q?oKFa6fPppu6k2yUhbMOcRtb5HJ4+TKE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uxb9wLlDrajCQ3iBifQzoeeVzB6Mem7NA8emUk/TxAVDI/5i6Mxqp2xH7LNlFaS+lI9TOIBB5LclD4+5SnFFQBIouz4mIoPGQ+VkPbEY9X8BqeKUjgB7vxNr0pa/Ah6rF7lK/W7dtZAeuitjggW+nGkqoRhuDZx3EnECDOvRGxjChoeE+XZsgacD3Bl4/FBXF80rtOIMRryW9fRlGzpi+awOEY+r/RxsNgB7gFDXun02qT3fxHhyhKX7xj2jLL+pHnEl1JvuhbS9egSCnf9/xXVzkNKtTh0KQSF8MeauawHTBk3U8gYvS2lgUfcECHronLMkmN0c0o9M09VK7XjrkafwWRKzDdGG77Mb14Xz06YBBR4gao1P33efEWiVzyJdbSqrGQXfTCXfD5FW3WzJaiI42lhCIQWv4KHgR30nYJ8ZYcQhYFSaoGqlOSsE3mW9q+tDhOFkS9c4ncdW6WgjFy3KV3mmIGTBQvye3zlTpU9H6W6IMcoFYcmX+eA9w2/1lN+7JGJqvtVkUki5mat0XPSdvPgGMy9ZXnv9zJOVmEFgGrpwnTU6nICfFmw6u0Sn2gmW20uW1Y5/TBv5W0qNrU5KRm1vqAA6Q0eH9O8JJlw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c2e146-6c03-42c1-1505-08de4bdb36ba
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 21:50:02.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOdionZDWEdW7eYr/2pzQ3izfazyq5Hh7fxiUswF8ELLG5E+N7qUEn9q+PEePllzUKMOwETyQISIv99VadvoVaJFD7p1enmBTSujzRbY+4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_06,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601040201
X-Proofpoint-GUID: 3cAe25zKT0-9E7HS5zODfABHeOCcso7R
X-Authority-Analysis: v=2.4 cv=Ec7FgfmC c=1 sm=1 tr=0 ts=695ae08d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=smfqpHB--8seKVOFkhEA:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: 3cAe25zKT0-9E7HS5zODfABHeOCcso7R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDIwMCBTYWx0ZWRfX8E8sZuFUh2PL
 zHg9Fib1hRFG8EEZZgsm2oMhrV3h+YwY9sFck7kQY2Fw76QKdtv5Yk+Qn/et4u5HCdedqiA40sJ
 bIxYYE/VDnAV4TGBWd6dKYQlDu1xUp3qSia7VPT1ffM91WdSWBYwaQh4Et7eAoLMIjiQELa6A25
 W5UTM2+2UwiYVv9VZSu59vPx8EVSDGfJ9tQznorpoaBFlgARW3mTrGIcdr8EFIH0gGydBCSPTAr
 ql7j20f6bPSD5kWYEYNMyzhjSiQNlOqDp48/vXQZDr5hhMFTsr2eM3LglaLubBHnaYegjgEPGxC
 jNs9t9B37BnFHrGgD6bl82RKsp/KOs6nJkF1Z7xymLgdXc/Zfyb7oW+EC5XgPt81ujrnmn+TLVB
 trVUSzARFObSgdof27qYC+QUuSva1G5ND2m3gI8w1Bcf8bNTo6D4APo4gtjole7CWrJIG4r4V8J
 rTp3+xiSvOlcE0LSNlWi9SNVgeEOONvi/N8yabOI=


Caleb,

> blk_integrity_rq() doesn't modify the struct request passed in, so allow
> a const pointer to be passed. Use a matching signature for the
> !CONFIG_BLK_DEV_INTEGRITY version.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

