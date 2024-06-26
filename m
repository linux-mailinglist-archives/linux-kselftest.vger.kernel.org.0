Return-Path: <linux-kselftest+bounces-12764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6563491759C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 03:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869FD1C21CD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 01:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873E171B0;
	Wed, 26 Jun 2024 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SZnt18fn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dnJoGxd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A40E554;
	Wed, 26 Jun 2024 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365356; cv=fail; b=Ae1htEqciuJ237J3px2ELiRjZ9A1rL/SOv/s7TRB9S38Km/+uJb7jmQH9G2RpkPpGyWgkLXsPlSszX19CTgfDgM3hCnpqCATjTdDuuohQyCt7tZKOnf6/JWL03B6wT1B0yZfrwYtQ4ZZSxfb0mqcDBSb8kU6Aap89wvMvbq5vBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365356; c=relaxed/simple;
	bh=iVolFp0MqVe/+jdM/C4qb13/lIQ5MYKNEwmrI6Ao5KM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MWnirDMn7KfIvNXqVoKfIL95noI6S18/0tmyvQQoudFS4FYNpY2U3N3RX4LUH8T5IUV8ws3c/KVjjlsO7qeWFcdFT4aZ1+6wYJaIiRM9TRoKnRot4FTmevxn3FHCMUpw2gWIqYsVeXG3Augu6H1Q7JnsYNfQHoWwDJeb4vEM/Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SZnt18fn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dnJoGxd0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PMBmoD003224;
	Wed, 26 Jun 2024 01:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=OhZpPL1pUmpBm/
	/Ha/Bolu4oTYPv4pASJcfGc9HkPEY=; b=SZnt18fnUQCivGjPvQ9tZhJD4zGP8a
	ACQi3IM08ETjPuEMsU9QrIpR5MThy392SEAqKYT/7zw/fUEw0MifBoxZaJStyn/C
	AQ6NCBmeGM15PKxX6QN7avOg4qdeRepvvW1XN/etqP7kbTN3i5ovwjAjYH2ccP3E
	nJhvzBOQ71KrzDZUUO89RD3L/TMQpmCVre1vW4LxIE3bPowXWfG8ru7pJ1fVUXOn
	hSaslr0ARiy9U1ZIG4KZ73ThNet/UjaBFrkkIin8RW6Ekz4ko97ZNS6UCfJvACq2
	L8Rp9qMdHEBY4Z9H+k3xdslhkG2shntYpcVUzGaFy47jzKxz8pnhQcuQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg99u7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 01:28:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q0P68t021530;
	Wed, 26 Jun 2024 01:28:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys59hqs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 01:28:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyCAK8ncbloMms3KSTdspsHgS2KCt/ON7ppb0nLJxCQnCr/OrZCm6Jjdp5G/ZJ8JG6X5m5FjBpkwdJfop+L5U5dN/paNzVlOJViFUBYr6rDx6Lb8E18bizsAEc3t5DH+kX3mrb+Jkacf57XT7wcxfGzBuORKTSyE0etZEeuMbhUlGt3h6AKtSmhGxz0UnXxHHlBOlagjLC9sI6QuEJiAh/J6tm/NuzORkz4EbvCvVNzfOut0TmIv3WriWDp5+Xnq9YVj3yeXjUCcr4pm21XcEnbPvFDhnTvTUOitPK5tySmsucY3ThvuSAKpOPpEwCrzRRM6BdmBQeBj9/SdVJ5QiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhZpPL1pUmpBm//Ha/Bolu4oTYPv4pASJcfGc9HkPEY=;
 b=Uf4HjQ1AtpgzPFcUsdmZZiLKdgGk8784C5iaPfTo0vTsPyBGU16jXjWpTUw6qA2lsffoXBuhE46WMATMNUaM7c7+owt5EJY9vP0MBKCKVX5V/a16RSa0O1SP7Pv1taxiiJ7gO7f5mxWQq6AFVwANUulJ2XYuUSr3AnTc9MCkO5t2UIQDgF6GexggtMx38cMG2iDE4iDbL7SqX8drumDpQ2MpDYXL0rSedG7UQJ6kfMqAPuCmREFsl4dF93OWWLZXLHd1oY0UEB/QG8WXfXFqtjrzRFtOQbBMTaiM7ijDLQPtu+TxPJ7lCQ4zfmOszdr3qvYVBMSNzCQ/CWtEwT6sEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhZpPL1pUmpBm//Ha/Bolu4oTYPv4pASJcfGc9HkPEY=;
 b=dnJoGxd0CN7xDnzlzv/ZBUtwh8z8sW+ArT5CCMuK4OEuv+v9XoCTygS6zw5Ph1wLlIGDjIANa/gMcABjZMmjKa58iy6XZPYPRsfa9vscngB2qUTO99NKvwkGlDLdVOlnSHmkZ3F60U9Wcse/bccpDujUCBR65OHjrjR7O9Zo6CY=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 01:28:44 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:28:44 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-rdma@vger.kernel.org, oberpar@linux.ibm.com,
        chuck.lever@oracle.com, vegard.nossum@oracle.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH net-next v1 0/3] selftests: rds selftest
Date: Tue, 25 Jun 2024 18:28:31 -0700
Message-Id: <20240626012834.5678-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SJ2PR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5a439e-8d91-4e9f-dbb1-08dc957f51ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/CgiIWGMbavAae6wdw2EDwNi5reDsf6HJbzgyJK44odnK0MMQg9e4HhxCV7l?=
 =?us-ascii?Q?GmYPnRXQ9NWcUpSiYTde4GRF7O2vK1Yro4eFK4zTzETcyyywgm1otfaE4ww3?=
 =?us-ascii?Q?tu+2GfLqp8y6/LrlkrLI77A+LywAkB+47JfU8Vtr1yUfP12pT1PWz8w+J+WB?=
 =?us-ascii?Q?32pc1eQuvc2Mc7B9VScacphxuo3CoXzGcFRaLSOP1/d3ZDdV8oPSbthTzv6s?=
 =?us-ascii?Q?3vp6IZOMp8/rhu0n8GkcxHisxV+RHING7MCK/+4JZ8kta6ry4/iDwstxLS9W?=
 =?us-ascii?Q?lV9LzJH15zbLSjxPyGJDSyBJuuIbSK0aIfhnbr1h/lJ2kA6Xa6tetEX7crHH?=
 =?us-ascii?Q?pLbP0QflKUs2ZkQATjaBCT48abijBVprZi1DW8BGC0h73eVEPtLD7q+uVyta?=
 =?us-ascii?Q?DTi6EBG6UcNJzKBBkBAuL50PP5X4gE9XPOle03dQ7u7J/6dUQgJ4gtV2s7CH?=
 =?us-ascii?Q?EU3/wH6sv7Iew2F47kLKuI7au/VK7J/cH5mIGaXA4RiBiv5IAtcvxszAFtKr?=
 =?us-ascii?Q?Zo4MunfjjpYHd0uWDMiEySkiwek+qG2jwoo8Zy1padKVC70xwr2Imc71/s0l?=
 =?us-ascii?Q?c3bl8G36RFG2t4AkeQbPmW3K32ODgkmp7XcIlKdsX6YKgo3JXeb49pJwEXhw?=
 =?us-ascii?Q?4uDZIKSIod41d0BMp7/wtryf0SppXOt36I+cxQ+uFWMCV+pr1/3qa3iBrekm?=
 =?us-ascii?Q?ckK62nli6dqom+99mwr6/F1qDYPAIz+5Kpqmo9ziW6soBxq5aeWU7ljr2PIN?=
 =?us-ascii?Q?F7K3c+VilFSqwa8hQpNi/TYd1luqVO+8vMpKKi/UFbnX0DxFashCEJq3vpaX?=
 =?us-ascii?Q?HQLy7ljhY1aIPSu5r4pvHbt8FL2uTbZA5KXEp4s0Vx9kI1efMiqVp0TzmSn4?=
 =?us-ascii?Q?/KMo+vKNjhemtA4V3rAtCY4p20sa583CTRVmYyDx8LbkrCZPdJqtoBZ6cL+M?=
 =?us-ascii?Q?uop4Vh8pMTyV7UPunrf5KJjk8rDJCpaKBweAtcvi02PbHBA2MbZYsStqjaqs?=
 =?us-ascii?Q?M6+dScFzn8sYerkRxZdkvU7MNg4MrI+0dmE0BxDBpgWA0Kb3s8N/XkOOz1Pz?=
 =?us-ascii?Q?Pf8kMkQ8b0XFs6tjE1z9eVn4afKJkqm3xdWTvLQCZ0QbBcgyafPgzFpGjaEa?=
 =?us-ascii?Q?AKyIz4xCU5aebBl8JROmJEni33YvthYl7HB79ZMP85Tt8/4BFOoPCMygC6mw?=
 =?us-ascii?Q?X0aoZYWp2e3Dr7wlp23xHllcVbFZuzGGoPiC/47DZiy0gk2n1lu8hT0z8JO4?=
 =?us-ascii?Q?tXvWhxHzWU+/NacQs3Y18SVEMk732La57L9kdEBBG4mdKoJAu3YKvWz47MN9?=
 =?us-ascii?Q?Z0lQD7Kp5yLOusVkWYuxaA5x/+bcSznkd5XULiih6hgIpA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LLqAZFfr/u81YRQV6EA2gzAnMFzKQTGaNod0ZnGYs6F8DajSHBq4DjjrsPMi?=
 =?us-ascii?Q?z/i6ZICgNa8lee69jPyFImu4RmSYTRsWmJyKX+0fOq7jw/hmZO0cKzCyAC9n?=
 =?us-ascii?Q?KgOJiyFtzmwZQZBRhQIvXNAnk6BHHM361vS8Av/PbtIG1cGjFEY3McKIGEr1?=
 =?us-ascii?Q?KxO00LndF8xYo03/NZrgdP/5U5ke+NgXK3fZW1Dx5OIq54UmJ4S+hfixbaUT?=
 =?us-ascii?Q?T1FZZdarivxVdLtUDC204EYn1gc9iznR7piiSsy8+dRnDKoDxlj4xqy7G5PS?=
 =?us-ascii?Q?IQQcnWZN3gaIQ8PzexLvC7zFgZ0tIZ86hyevu0lf5eHOMerpw6+mFIq4yOFg?=
 =?us-ascii?Q?1Cga6llVKKsEGYYcLTxtmNbQLga5VBfYx/OD3BWQ7gqtbV9Cekd2w1HzYzWr?=
 =?us-ascii?Q?W7whId9Bv3rzSyMFDnkk+NZoGh5Jt86FUov5rg/XPdu1sg8QPFhvE2FRg4Od?=
 =?us-ascii?Q?o/OwpTkqc7bZ82PzQkJWzycOLJs8Umq5UDVJR2YegEqORhSMEr7R22JXzCWP?=
 =?us-ascii?Q?Ru+kM2ozIR9DITMTOrZ+NvXbMNglQiRcf475k/yRYjUClo3ID1qfhMNp3v10?=
 =?us-ascii?Q?V+5Mk+LVVuMnG2qmW525u0VgtTjmdo2lxZR8wsUC0gWR6fsSSRDgKy+zdZUg?=
 =?us-ascii?Q?2NjFkqLGuIj8yDPUsVH7dgx76AQ5EbgeabIAqkCV0KaQ7P2xHuI3/nixIYUE?=
 =?us-ascii?Q?8tJjNQxPfAlLXGlpD6QfdkSNgww0MLgGIPLcHu3i5SEHiLcNToLYdNZnmfuX?=
 =?us-ascii?Q?SBnziLomFQqiFb46pL266qBAAozC2vxW7ErjrZgILUjE9YFE0TGqXlXZaMbl?=
 =?us-ascii?Q?+oXiQ2F4lrlsdP6Set58JFBTK4f/iidlExuuqXMDOIBS37lYWnid+QurQ9iS?=
 =?us-ascii?Q?kMupvoxJqhY0vA34UdASfRatPoCYzvqCDj4NqcW/+V2KDcOaa1sPZeU6IP6N?=
 =?us-ascii?Q?X+QYFIhGNq97izCKcjW99NF79UCTswqO1l60lMtmSyCFxnfPUMSPknWH99/s?=
 =?us-ascii?Q?fYM7qYrw5kCtqicfjqDsG2s1nyX+24THTSls4Hu+ouLNluF5NfTKKGiw0N4N?=
 =?us-ascii?Q?g0JZ7NEHDHbd6Z3AfwaGwQTZ/v//E+yCpU3Nhn273VvVFrCQz/Jut4Qy38y5?=
 =?us-ascii?Q?vKkBVknqGCo0gnfSs5MdMvdo+9h8zZtQ1UM4G4ZfXl1h0CcmpJmGmoTvh4xy?=
 =?us-ascii?Q?aqncPl2Q8rS9L3XkNhNnb7OYGusIgKIvp9/0jrh9DbgI2JBAkTDgFYnXJ5JO?=
 =?us-ascii?Q?hiTKzxxNXM3JSznKhM3l2laGD/1faVDf6K2hCxA1BC2/PZviZSPl5s8lyaic?=
 =?us-ascii?Q?4ZDh8aqxFrZPuS0XGbTmlmUv+Iw/9Z28P3KLYbUFwRYYUazL/PP33XU7wz2/?=
 =?us-ascii?Q?eRoKdpQZA/my3dsvrnj6xZFjq+zguYNK8OnUcIOhafJxsf5TJOnxmff72QNC?=
 =?us-ascii?Q?QIzFOzoXdTM2CMfv1G6AxENPIC4WcrwxoT1lRE4TpaYm37GeXkk3caOS3AMc?=
 =?us-ascii?Q?Dy8PK2BFheLT8Rz0AIEDc7HJsEB/Kx8JKDTD31/gXvMxPlGm9+Z4Mw+uW261?=
 =?us-ascii?Q?WGBrKDpSbctDlEeYzKFmgVYdzJP3Z4GpxWV11pQg2oR+6ertCnLB9U7rAPaE?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GbDc301pvbmbtW2NOwh/ooMZhjsTLtzHuxauEjQd3WPeH/M5KSybJaPVHO8GIurH7LTMi3MnQIZYm/4ANbDefn1N/hiqYXU5k1c6lCKzm5hJA0d+93PXOke94MweqIGLlpBu4dkdIYAW5+obFGE9W1gw8AWBmPt0il5O+MgydFc99xZDGDu3zEiXT5+JXpMvtMGMntZfGE7cMQca483lx4x1G3PuzMlnSRh7LY29UWk73aEiJC7MdwrpE8/q5OK7zoVcD5sq+xpFj2WjViiQvmb6M9oEDFVS+IPz5Kwj71+y/5fFWrcs9UQNayohVUjUiEDeOta9WdlFg5yW7vPtetghSV0V9pcxhsDG2C0kOEXzMfjMEdglRcTF4OjztKbz1nQke3nQ5Lb+u4so6Hiu+lXVluaUkGyIc+cwEi9LIkL0pEmrmeH7V8j7HfsKQNIsXQOtNsunjnD1h30GVcVMv/jUzo7fZ/iGgNqitFpDbH9m3nfS4I3nay0Su9z3XyzwGgs5XvXySnY78rgaZoCa02L9NtBMAuiC99LTqMEC/lOw/d90XScQqL0lk3H6sxibjPFnGoItwAV1fd1VFn7UzwI+sDkTpH9ZCt0W0UO1shE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5a439e-8d91-4e9f-dbb1-08dc957f51ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 01:28:44.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNJJfxiHK0suk/TwuZVP+1ovpVSzO+WHOdmFXlMQtWVRP3aVJn2E7/BE1xkgeeCmLH588IrR+Nq9x/XoV2Fed48DndIJMqNJ3t97qDS8K+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_20,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260010
X-Proofpoint-ORIG-GUID: WzTTpjNZ-6Ck2IXqChz5ia54ca8thqNs
X-Proofpoint-GUID: WzTTpjNZ-6Ck2IXqChz5ia54ca8thqNs

From: Allison Henderson <allison.henderson@oracle.com>

Hi All,

This series is a new selftest that Vegard, Chuck and myself have been
working on to provide some test coverage for rds.  I've made quite a few
updates since the rfc sent a few weeks ago:

  I've added several knobs to the script to tune network turbulance, and
  documented their usage in the README.txt.  By default these options
  are left off.

  Added an extra flag to specify log location

  I've also added a flag to the config.sh to skip gcov configurations if
  the coverage report is not desired.  run.sh has been adapted to skip
  the report if the required configs are not present, or if the required
  packages are not available

  A time out has been added to prevent the test from hanging
  indefinitely

  The previous gcov issues have been resolved with an appropriate gcov
  patch, as well as some extra logic to detect incompatible gcov and gcc
  versions.

  The shellcheck nits reported in the last review have been addressed

  In order to return an appropriate exit code, the run.sh script has
  been adapted to analyze the test.py strace, and determine if the test
  passed, failed or timed out.

  RDS specific GCOV configs have been documented under
  Documentation/dev-tools/gcov.rst

Questions and comments appreciated.  Thanks everyone!

Allison

Vegard Nossum (3):
  .gitignore: add .gcda files
  net: rds: add option for GCOV profiling
  selftests: rds: add testing infrastructure

 .gitignore                                 |   1 +
 Documentation/dev-tools/gcov.rst           |  11 +
 MAINTAINERS                                |   1 +
 net/rds/Kconfig                            |   9 +
 net/rds/Makefile                           |   5 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/net/rds/Makefile   |  13 +
 tools/testing/selftests/net/rds/README.txt |  41 ++++
 tools/testing/selftests/net/rds/config.sh  |  56 +++++
 tools/testing/selftests/net/rds/init.sh    |  69 ++++++
 tools/testing/selftests/net/rds/run.sh     | 271 +++++++++++++++++++++
 tools/testing/selftests/net/rds/test.py    | 251 +++++++++++++++++++
 12 files changed, 729 insertions(+)
 create mode 100644 tools/testing/selftests/net/rds/Makefile
 create mode 100644 tools/testing/selftests/net/rds/README.txt
 create mode 100755 tools/testing/selftests/net/rds/config.sh
 create mode 100755 tools/testing/selftests/net/rds/init.sh
 create mode 100755 tools/testing/selftests/net/rds/run.sh
 create mode 100644 tools/testing/selftests/net/rds/test.py

-- 
2.25.1


