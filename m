Return-Path: <linux-kselftest+bounces-12761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC058917594
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 03:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B65B226B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 01:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF6ED52E;
	Wed, 26 Jun 2024 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B1L3hbpm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DlTWHN3g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF56D2FE;
	Wed, 26 Jun 2024 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365336; cv=fail; b=qdOQiyjIiBHld+X2uOzVTy0ykgAVk/Dz/Qebfe83vUq0QvndBp5eYdqDkBLqMqKocYINlAe+Ehbs7ujW/Bl6BJDyVNOy+W6DvF/2sSyOsUVwHyIFkZRCMh8tp5D/XNnj7P2qd+cc6QJCBYQI/uVmuINsXwl6mIjevvC48hYnreY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365336; c=relaxed/simple;
	bh=dT8bHORSQArmW5ObutG45Gd9W4ZJDznbpdpFkRD1lw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H6hUcEcQceVodLv0y+8C0EZfsI1aeIto4UK5KrijK5jyBi3HxVH8XfJIlMOHpN3jiSWWnvMXHbPI53XTJYhBGFY6A8nMbAf+wbmMQuNxg/DKyvP2u+DLkwvJ03P6thWzv625d7ivQZc3yFowQ0X2Of3WJmbtMmE/ysJG2LSVXl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B1L3hbpm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DlTWHN3g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PMBWx0022430;
	Wed, 26 Jun 2024 01:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=46y0gUo0UIxpsHUC2NN6BJbOnltYGX0sUUFMBccxVqk=; b=
	B1L3hbpmxDN9stZZIqwPJmiHGPNw5msFgM3JvcXECcJsvShqi16ZqhPFACp7tt5j
	2YJ/+aP9BvGs7pi+BnuC34zsIP6CRlfb7fbtrCBQgFzsUVcRL7JkueuAZ1w8lDVz
	PpzrxBLppUmnbJTO0pQvFkw5lQJkPdOUWofw8iEmhMuJIJD5316zSPFwkmEjs3vn
	Yyc3Yi0B12n8V5s32XuBkFWE91FDJXBaSRuvvKxp74BJvrFAUEaHN+SgixyoHIsf
	OP4Nty++6INmBLIIEWfXJjszTkLt4qqCO7UNGa/z2FJf+4ZYfBNkE80+lRBdSf8n
	X7BN3OonZxgwwHv4if4eKQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb238s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 01:28:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PMxQNK010948;
	Wed, 26 Jun 2024 01:28:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ev3dc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 01:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mehi6pVRL5z5U7KI6bVlYz7zQGvSbtujb84cCxF8xq9XszCnJWOjnjZH8H6RTKaSzj83/PIJA4qFy9WNXoGYc6sWzg+XDBFP1GoI4nSP0FwqslRy0dPm06zjW/ywgM4ZsnBJ+r/DKVtQ1TarwWweZDpNSA5crdUpe8C3B5PCgH2Crvkcv7ezSULirvHedD0RozZBrYrDRk+UpirVwO7Q41nIDS1ZDaO0C5DhFoep8N1+GBtR2oRcLjGwjjR9Jz4AxIQ3SRh0Lpj9tRVRqum54Urbyl//Ce2Cnr+6iTRZWQPbdAuKMLLOADMln4hZaCkvOL4fb/zDJvCIOZHgxwFo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46y0gUo0UIxpsHUC2NN6BJbOnltYGX0sUUFMBccxVqk=;
 b=kl4g9AzedsYjzOPDgbHDU1H2VItwOGQQ3NYRRK51Dw1yBh0atdAbSwiYZf4MlXu8C/9pOYmkPyeB6viKrhAoILq1VLB800bZ3ram710G++pPzYonzgBEIvHoU9JJ3F4AhiKq4PvE6GosSG9jtZv5KJz4aTAXipKeYOUjAjqBgMWB9iX02+2ssHaT+LvghhMp+G6IgvG3jt4YZy53hmw5bP7bdfK8BUg7GnDRganYqFU4R+7Zjps43c5h2pyrJBsIaKt/v99HwVAv9rToIJ8wXS374Kk4GunfVaCt8Q8E3uTtGYQUQF2oopwvmTN5HKRpmJoGKy5r5WlVFB7iNKlnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46y0gUo0UIxpsHUC2NN6BJbOnltYGX0sUUFMBccxVqk=;
 b=DlTWHN3gBqcPhLBt2ofVFXWvW2kbi7F4FOXDJN4m2W27H2G7yb3udfwAW7m82xwmU0OWVJRDOhJXA5ZHCiPRigJDkmKs6XFOrlYZ+HXmU2RL99v42AkA11MdL61pPEf2nhgwZvvZpHBB/k4nkkWUxQXviFm7I0bVA5KUob/XhBA=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 01:28:48 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:28:46 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-rdma@vger.kernel.org, oberpar@linux.ibm.com,
        chuck.lever@oracle.com, vegard.nossum@oracle.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH net-next v1 1/3] .gitignore: add .gcda files
Date: Tue, 25 Jun 2024 18:28:32 -0700
Message-Id: <20240626012834.5678-2-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626012834.5678-1-allison.henderson@oracle.com>
References: <20240626012834.5678-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SJ2PR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7d1ac9-aa39-4065-9d58-08dc957f527d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zmGSgQEUWhIgCGlI/uPoX89D2vBX4k2ubVxPDFk71LV9kXy53JB1NGglN7g5?=
 =?us-ascii?Q?0Bx8qJm/lSPKbP0lpCRNChYs80K16lqt4QCEzBLOpfdt1YbbqXtwFbAjNmQ+?=
 =?us-ascii?Q?GqQU2JayqjEeW6gtfqFJkEi7JfzhtdkHshOw15OsBW1q3NIBojr2l+nWcMW6?=
 =?us-ascii?Q?9gbYixm8U75udH2iQ8pIq3DEOf+KvH7nK6M1jaiHGpRSNPN5Tji3fxfpO69R?=
 =?us-ascii?Q?BmgJJ57WVVhGHNiGv8jkpUDRZw47iAqEudtP4g7KHyQWtybWbr+pzNUlJCuo?=
 =?us-ascii?Q?LjBJqglPxEbiABDeisy5FpA3XQg9uceYjrIQeXJgxSBF2u8+nGYd0yNZhsBw?=
 =?us-ascii?Q?ykmyDeaSzWdALDTWWcLqzSUl+3YsbZfmYrO44md3zgSpKNSsyc/7tNSOQlc1?=
 =?us-ascii?Q?dPpseBURMq0uMGxgqn6IPNDSKvzPSRBv3ZrFmxfSBsqBhKleH2uF+Remo8Yl?=
 =?us-ascii?Q?ctICNVj8uAnWPMi5OvHlru4S5i5w+LguLSiaA/uDVwO7U6WRPmAJJVvUDqNP?=
 =?us-ascii?Q?eRrjTmuiUEfI7FOOKrlSutxLF0na8+zfV/butK6MIBYxEQQMHNL1wMIqciJ0?=
 =?us-ascii?Q?6cAKjVr/eb9hDkhVIyxIAUBEKChDatW+Tuyc+dv4jcpFOTG51k9vMCwkNwD2?=
 =?us-ascii?Q?Gsnwp0qEmQnAfee+eGBWFvZhkRMlg8+XDaehw7oPvR1wvs6dE3GcB/NEf3dw?=
 =?us-ascii?Q?7ZZQk2oh8Vfl63vJBzKhExGLmC0LFAbUoymigvearjsvD44h8xVwLEt+Y77c?=
 =?us-ascii?Q?T1V67VyD9hJgB4hSqE5ZSpIaCGp1Z1ZnPx383DE54BdlJgtCpD2K7iXxxov1?=
 =?us-ascii?Q?eq2KvcEuocT6XEtTHuohLpq45nZjXZfDErgMADod/3xf5omYrdxnJjDWTSPu?=
 =?us-ascii?Q?CcEYwlG7BBtyoRyDDyRsoBiTxYmLaPeR3bDhviAxRvNtC+HOlW5dxzbkjXYd?=
 =?us-ascii?Q?3WsrWn+OKLeuxJQVMeMWGf+XSD48geiB3vLk0E8pnVKGk4sGIZ+D6XoG2woT?=
 =?us-ascii?Q?Y9oq5ivR/ceOZKJAzks7w6xlJX6kDKng8r0g2/74Z8hj+yLpr2dhlLZy3HLD?=
 =?us-ascii?Q?pG5KAGwHrdakYebD1LRuimoVieNPPJEof3yyVo/TvcmAbM5GYCIAS40kP29t?=
 =?us-ascii?Q?l4Ed+4HtJqBHINXr8cUF+tru3KUs8J3f3dOfVwsFXVyJDmUAKYrzcQf7XaxF?=
 =?us-ascii?Q?xi3ku27l12Ix1LxLVk849sH9ndlJXwQjYklnQ1b3O2FxaPXqAH0CywPDmeQz?=
 =?us-ascii?Q?IO24k+DcXTA/moBCs8MS13vRGzk5Y1aOC8Vwt5YVSAgaTGNJMGDnpEvP5VfC?=
 =?us-ascii?Q?KqyWl1yqe25uNdyEvA0ZYI76kUhaYfXDMYWKsk/2HF0oBw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1aPfbExfCl7fHIwN5QiWhcizDd+aI/zGyteO5qYzi+eV4k8XZvehS7y8NDQW?=
 =?us-ascii?Q?ag76MuZb6QY6QW59vcV2ueslWofQs3tyd9e4zyiLAb3G2fTWXKaa81i3+HuY?=
 =?us-ascii?Q?fUPtjg7olnL3ZDKCOQyE2dTjehJgY1ETPT2p8l6/o/QyZFT6y6kSvq5BGhkd?=
 =?us-ascii?Q?D76/6z06DV9sTda3VTjzo+VNMtWoQLf6+x73dHe7cc5w6UvoaEXInzc0ZBh1?=
 =?us-ascii?Q?JYBwP9PzUnZFiAS3zRTp5cTbP8lh71aCMyUjrIDPT8m0kyuxVo6FYTd40nw7?=
 =?us-ascii?Q?xz8+wJ/6M8ngGSyYgKBMqYuf2MkXefYlbbEylmC4VTX9sG1q96CganK1hIhv?=
 =?us-ascii?Q?s9E4xwR3wuhQ9gdze5KZ2d5OF5qf81nJ3omuq5v0xGW40UEqH2rC8SwbVKJR?=
 =?us-ascii?Q?kxEb57WWfGONn/e6io5T2KhTXX9VcXFFgRIGIT8ZImY3VfQdjfDLhRGutaPc?=
 =?us-ascii?Q?ZEIun+i8KR6M8DFp8Q9L0TOsAcMhG5ObIVjiQSU/IslT5DFkbMNBrCyQzJ34?=
 =?us-ascii?Q?9JDquvN2/LAVlM5GUroA+Ng/M62eeT8keN4Uy7apkYXBPTCbVQM7/D5ZXV6O?=
 =?us-ascii?Q?CGch+vcrXbG/W6aXpsOqFHSPLEFKvrxTQ8kfd3u1SR+Y05+I1HXvOLCdBB52?=
 =?us-ascii?Q?PJUftKAdFMpxFxGfHQKJD305XpW0zXXhXOkAJiFW4OJ5iWHx0GY7L0/0HeiE?=
 =?us-ascii?Q?1tuCT2MI9Ttb5G76p7i5UEcqzIkYYyeeRg4lBV3erkickiJH9F2xMTxVnaZ5?=
 =?us-ascii?Q?QuNNjyNX0vTds7hciuMGe81OL9rgvuHZ1r3kQOuonrngM7061UPsEXyMagF0?=
 =?us-ascii?Q?XKaVahceEtYJ+D5q+MwK6Xt7rGIE5IWLqdfo/vUKahBfZko+R+IOX7WXS0o1?=
 =?us-ascii?Q?mK3XrXvSu5qca/yWaUNx3jNBuHYWlFbg3oLTyKggO/4P4mj81PZxSuxgkFNr?=
 =?us-ascii?Q?Fz7XWSADuopJuoGhhBk1opSzrjPi+CzSgxWqq7kp54hjZ4Tp/fXrnYUqjBf7?=
 =?us-ascii?Q?yDrYHMDDAkWAXrRbjtFUoQuet6Xk+ECtjPCD7WEbwt0/umojraiSDn9kE3O7?=
 =?us-ascii?Q?Q+lxP75IYrggKYyYtPIMzCgbFXo+9f7Y0vKDZtew4Kk0DMVBh5rIIjdlVBTv?=
 =?us-ascii?Q?IZsKCVouAatBd34TzATp04/8Hde1FANFR83IO0rfRhYN1MyjrBDaIzdIkr3/?=
 =?us-ascii?Q?/1UZA2cR0XNZokJl8/M20FfwXZaZXLNe+DBBhNv+cF2yPyH01dmHQjb7czMr?=
 =?us-ascii?Q?SsiSlgX1UKycZmdeO2EthdM1ab//U7dCsrjYL0miaUAKjPwBtrJ5YkpCoDTY?=
 =?us-ascii?Q?K1+7smCbM65TpMoHlaFj8H+vljbj+KAt0n6KjthKH0Pbu0hWMEgDmWG+XcPW?=
 =?us-ascii?Q?1FtVATaxXUvNnmNmuPLT+lko8BwZ5rRezf8M3u4NIu1xS9A+iogxsjzwqp+H?=
 =?us-ascii?Q?GYDVluxsM7/Po5rmDVxDJtYontYcXyyGz49Bl0PT/78enwiO5/xGzv9AVPdy?=
 =?us-ascii?Q?Gd245g9xdtN/EpiN0xmnf6/6GZSrkFwGhek1ie2yImcXvyalKLOtRBzdtxYV?=
 =?us-ascii?Q?47qnDt37+oni+bxuJI7xcmqhWBeHW0TtZRKjSxe0XQJjzc3k6cwKK3LlJQ1+?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GzMCEXdT5xW5EoxJhv7Pcuhv/9Cp8xOVJyLfi3h34Zt6GKG1bA+dBhpXAIYrZT014tISe38+CH6xLF9najiBIp1X5U/cHQxOQifsnBDbPbNbdbu9zSlyQvJzaPVpZN0DhvcHsHL/egLqaVIsbfxw/Jm0afvAALDaILTm0PBpZ4OhBXeKyIzHC2d5BFOvIA8d9b8QOMkuoPf/5ZFVU7MdUR7GceT6+DAkP/wU1Bnc2azWjne7p/mlHRnffb/7R5YI1y2hwmUnuf/tLbGhKO2OOiCoazeylJQhOCknWJe+GlnAmRhqii+lY+8XLHnx+f0x6dzNkyrvCpanPZEiKHJG891udwSLNy9sbIx70LqHii5QV2PNWGbtOjleJ8yd9NZ2N0vlEFTHfGEt2NyD5fgnAtlcFjXoDcU9qlqFkCRupZYfdNdzQYt+mPE/EAl3jwBaNEAKBp6ZUvZAMmtjuNI54WKM+mNxaOjiElDv2IQ9Qb5EtEyMCY3u/MGUWiy0CKoFLTOlhDMs2p7jR66ly2gozSYHEJbPFjQpCrRjMFKBPlgbhtrwvjncOAwP3wkMsx1jK+YbhzRtfzI8vVWB/hoAKSYiQw6gJTu5DBeRUvaECMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7d1ac9-aa39-4065-9d58-08dc957f527d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 01:28:45.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9q/Aw/jxtBPSfeEcTxUDF5kkEXu1zCnVFc1wLiwzBwbCsp92X/a9gjEHWO5pkAXgA+I/J1Cg9mJbI/7Sz7WC+JG3UIfJw/hW408to3Q0dLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_20,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406260010
X-Proofpoint-GUID: Cd63ySH20lELtFrPsiU35n3vrmugAGF9
X-Proofpoint-ORIG-GUID: Cd63ySH20lELtFrPsiU35n3vrmugAGF9

From: Vegard Nossum <vegard.nossum@oracle.com>

These files contain the runtime coverage data generated by gcov.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index c59dc60ba62e..8ff1b4138c56 100644
--- a/.gitignore
+++ b/.gitignore
@@ -24,6 +24,7 @@
 *.dwo
 *.elf
 *.gcno
+*.gcda
 *.gz
 *.i
 *.ko
-- 
2.25.1


