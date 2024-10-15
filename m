Return-Path: <linux-kselftest+bounces-19778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CD99F749
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 21:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C0428496B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018615C145;
	Tue, 15 Oct 2024 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RWMnsrJc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZW6oSS8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED211F80C3;
	Tue, 15 Oct 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020473; cv=fail; b=ErgbIJ1Gd9hvwVVWCXyDaj9H4rracgV3xCe13L0uKIzH0j5iuw04qs0+1eKfH/pBNGUEfZBtUkNGkQIn0Yfs5xmXSZIITnc7Ukhe/VXHhNlL48/oh6qEJE0H+JSE/5DAUInzmWKx3vYM3ojxhTFPh3PQ9Sy3VGNYRSMAENaYqXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020473; c=relaxed/simple;
	bh=Sn3qroUifQkc3uNNji/CZBTF82kYLQk6jjOZeujTzHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n+9V/K7QJP/doWa7rDgjd/0nyJYzNSoZqllurDyAKEiGfO/t4/ptdcT0+VZ+a9o6xlR9ao6wng3PE0qxExjFAwoWxAUHB92uIuly32AtCxoRsfNU/z7QtSpkWGm/DQ6VkIUpmvr7B+tylaLQciFDkd/A5Xjp02kyzB3/bCKDFo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RWMnsrJc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZW6oSS8e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtg2G019350;
	Tue, 15 Oct 2024 19:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SMtLUdfDorpDx+76kX
	QEmemsnG+2yGfoPNkTXBgG8p8=; b=RWMnsrJcZ/V8sLLRRI3l/tDpgmjwC6HLE/
	L58woMJZIbKFm81VMKNLE39i/PMbNTWVa/8LGHugvKEBA9B1/esumEddNiTdmECI
	uYjJxaJtnrNzTbrTkfS7C4Kkk91ykdJFTugZly1yyDMOf1TH/dnaqWFZbtC9b5a6
	5GQIN1VueARkjs/5ogGsFmZFVoktoYZTnyJsovr5uk2mURihRa/XevoxSamuOjBV
	r7m+zwjw72w5OnSA9UPYCaV+VN4+EaUqik3/+k5pplbclZN+ZR+CW16ClhkLn6w7
	tpTAPUNPmjpHnroBk5xu2Fk7RNhUUAvHhCgD9wmGJdz8m+R7qMsw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7j25w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 19:27:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FICeKE011049;
	Tue, 15 Oct 2024 19:27:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fje72an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 19:27:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyDVB1HJx+d8uSJeMd2Ksl42u8ozwwb5x/yBreujLcL/h8u/mUS3TUTBtPUV2KJOn9fsHM6sxvHDxbfe+VpZu8SpNzZljS5e4H6qkl+FB7gDeB3vitlVkOVcW+ID+vrSYBfQHp67gtVFanwKrDBcylt93zO4ohZkqznDvMNHCiw5yO0GehQKP2D/Gr21rZgEX401Afr6nr3P2HJNRi33GHIiOskDUwkNs5LJJpbpnpVoftXzVJhCdfDnEqavna4wiR+kR9HuRGjyVI9wMmm4ivsjGHylm5ZgPNp7OyItPZafGOpikXHjc0hfGAX8SeM1W+Fz9QuLbXsT3xqlv4QvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMtLUdfDorpDx+76kXQEmemsnG+2yGfoPNkTXBgG8p8=;
 b=S6W4Zg3DAp/fqR/KZIy1YfmqjyxKiMSDYHBzT1qdWevLCFvewn/3YN0Zf80ZMkrLjw8qtzr8v2Lfp/BLftmYl/W1HFdRTlCRNfU61FOcxFhI8jKuW/Tqosshcr/P5aXLgJ6Lf+8cUcdE4ERIPzulsXVzgy+y5vqLRzgXRPPw8MmCZvMsx97F4wxXulECSom+PKZAUccItzhzMubhCpGxtPyQHjNA3+S0PORo2IoI5HuBz2vBLIWqRVg9DN5Sy7K3SPRMKtPzSKCUn2cMFkYo0GSdWTVEz9twZWlYm0gCkJo7ya60ZE44c9SxbFAB+F0bFeJ+m5AeP1E+S/RhZyUzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMtLUdfDorpDx+76kXQEmemsnG+2yGfoPNkTXBgG8p8=;
 b=ZW6oSS8eBDneVrsfguYNgpLrHuKd3HcpJvbFmnTgztCoztZDk1PIlbAvGlfX8tR5Udqigor9uibmQ/9FY079cfdfvy+Ql8cUuvVFWUTejHkMycRJI9ITD1McwfYu1esYetzQMN6dPOVnkSTygJuUiYHX6lEsz0QKEBs+lJWzpVs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 19:27:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:27:24 +0000
Date: Tue, 15 Oct 2024 15:27:21 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next v2 3/3] connector/cn_proc: Selftest for threads
Message-ID: <36kdqgl425qzoqqbct4jusrzgpcn4cff62jaswcsrc4licalvp@f3okz2ygoww6>
References: <20241015173014.1083069-1-anjali.k.kulkarni@oracle.com>
 <20241015173014.1083069-4-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015173014.1083069-4-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 91466901-2379-4088-d5bc-08dced4f65cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EHV30oOAeMFirU3ZfYJTDHa3FZuT3HPD1+jOyIadpWHECdAcLS3AfKlCllSI?=
 =?us-ascii?Q?tzT9Li51E8+LgCCmoQmg8piZ6YlWxGo5ueUJc6L5ncKY2uEVsFYrpIcnaoP9?=
 =?us-ascii?Q?+rzD2+7eL8ncuOYvWatOl6ancmUwG2ptWoV/FGE6VmhkmU3CD+Wi27iq37uO?=
 =?us-ascii?Q?g12OSwQexOoSEz3ZqPF7zxrTW9aoGo6EtA4ADW5DTvhXQQay9xMwJ1Hl2S5/?=
 =?us-ascii?Q?xt/1arnfqpvKayTwu9axRLx6I6PlcMXh97MyeEsYD6yOkjs0D6Q6+tiIsgqf?=
 =?us-ascii?Q?aKDlV01ZH/5mkW5PF60/hG2APX9lTahvrbgcZ5H1SQVW5G3MscW99mEnxN8G?=
 =?us-ascii?Q?p1YGxcMoOomd0hitz5iEd33woKUC0Ed/Swmd8vgyDJxpZdelLvW32OHcfVm0?=
 =?us-ascii?Q?+vVLRVk8V8i0VPnKHJU3gsVYHfxvxcTFNgpPTDEIZekrUKweWw4EraTjOMKM?=
 =?us-ascii?Q?YGqcRpmkNyn9ayZtyWeiT6aZD9+kYElw3pCpakzWhJSV7S2/LLE00W2mi4tR?=
 =?us-ascii?Q?NI+SzgDrtw78E5cEEJu1yTOreC5qfLhWD/IfvCHqnLnOVbbpPBqmPDa4+tno?=
 =?us-ascii?Q?qOguhgEoqnHlSdYqdCyUiKXy1yU533rg7m5qqtS5TGJlNhUd1qLef5yIOK9K?=
 =?us-ascii?Q?WWEws0boBJZ9G0Uj/g2qBFSHhvRj3ZqYm51aJhcjxNlv9+Q/pNE0hCeQyFqT?=
 =?us-ascii?Q?oxHkzld7H8yNiSV4w8CiATpGO28IqdQFq633eKAHDaCFh++TyWe1RawcAMki?=
 =?us-ascii?Q?qUxuS7NSGjcRBadKPmg8Ai3Ef23J0379wVAIDLXvaOkp6TNr3Ujgx4LG3W2B?=
 =?us-ascii?Q?6Ebn23gBddAFtveCLWWde10GzyPRah8JXXNi58NseAqgpfX0kTn/yT5E/F/7?=
 =?us-ascii?Q?7w490H6KE23GYrw0F1hdILODVRzB+yKVdK3cLNkKwhPnIVmDZUC1NTCqDjFq?=
 =?us-ascii?Q?XahGPQsGMQfXBYAce16PlZRLISwRQRXoalrELaI7awRwOe4yweR735GAzYyV?=
 =?us-ascii?Q?RCUtuY+suSnQ0yAMa41EVLbkQoAhcdvDSGDGEtss47bXnmHwT0ZIS7gvlWYz?=
 =?us-ascii?Q?wTymKgPO0/7sL5oWDEonjhOhVAhLH5gxrEKdGe41gm/QcxiJ5zWJiBvens/5?=
 =?us-ascii?Q?se3tacXZxA09M796nIhgTofefvGZAoTUUkMybif4pVJmJhQJDSXQpb4fAa4t?=
 =?us-ascii?Q?gYJaR8f9qxHQiHhqjM7YPYoThXE70Y/Tm1S6OETq6j66h3TyoTT0ASRRnu90?=
 =?us-ascii?Q?S7lJGx8KTzeOGmcznNqeJk0CDogZm44qblBM7hWaRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N5p+qtTHmp7437xVSn3nU9sjz5cGv5R0fx6i+DsmUC/2bnjhCoL6pNkroC//?=
 =?us-ascii?Q?P5RFq3Sfqqe271OtEoWEj6EZQL6TH+QuZlrW1GkrQr1ihp59mo5rmujXNPKV?=
 =?us-ascii?Q?Flpq/W8lNhs7qYzs6OIlbi3maXxmlYrYiUqTpMeKCQl3W4eC/O7YN6iaCuaE?=
 =?us-ascii?Q?oWrBHu7ge08Y94XYMVk5eb6+CZPfh9eugjmUNvqk8ZdkKu5TdlOq0X18NRhR?=
 =?us-ascii?Q?ImdyhzaY5u6a9yMV8cj3P4F3asBd0lms4BHB7NPstcAqcrCicWLoRQENAKIq?=
 =?us-ascii?Q?aFBqQKLALeSmPC9jZ1RpgP5YGpgRcpQFOiF77xG4bGnwnP1p+muZKYsYqdfY?=
 =?us-ascii?Q?PA95cLLoBfaS8ceQs7m07sd+Bns5li3oI+JReRenQpO4xf+M8hzt9CnjQOz5?=
 =?us-ascii?Q?jmF8f0TEYVb3yb00kAmkirfbdBSmhqkb6dmBzMZMOHKOkf0vZUrNIrtX+6oW?=
 =?us-ascii?Q?E5CViOG7ciZXABCKdgW/LLrrLR+90vCrXgjA3cKf2r9QIwhPSi1StMHmZ76K?=
 =?us-ascii?Q?By1L6yiwYBNfEXxuSVqR5gnh7MXUiY+z8b1nzgV9e2XPO8wxzDXno3/57VAg?=
 =?us-ascii?Q?+qQ7Oqmm4HV1BAt8MffzXwfDsR9Js36GKQZ02sn/oBrK2YfHf3tpvmhZDvl4?=
 =?us-ascii?Q?SVe/ZXq5fgpgQj/Rnox9dVebtbPN2rkq59SVml4uxQJYEkUooSAxLPKn1wW3?=
 =?us-ascii?Q?dfw3BMhgoBNjJegpHNXNejmgc6cXRXdK+TClNUOGKoW4fVOLRlH0hXq7VRj2?=
 =?us-ascii?Q?+yND/Y7kTdLB4T0+NuL7JAJ+JIdKDU2whV1STFsw5pcCr2NrgqMZP2ccm+AI?=
 =?us-ascii?Q?RSJTtEsDRT5lApnapCvarcfj7yMe7prQNd5Vk7ix1rE2sNDvra2JupyP8LE+?=
 =?us-ascii?Q?YzpJ5pQUJsuspUhOJjHJGokUiGuNU4usznd1y7JSmcKRs0QeQs4b8ox/schA?=
 =?us-ascii?Q?bl0VgeLpOpQJAMq7mrJaUPQ7hPXPbYuYdNaL+X9hoY/tmXD7Cxa1Q4rlVDWW?=
 =?us-ascii?Q?yWCCS2+g3767tl5l5XueJwOG2DLB45Nr12nXz7WOPs7nVoJbe0e/GCyR1qLP?=
 =?us-ascii?Q?HmGx2zGnkvVXVZQ/SrzDhpFRzfdYZ3rwYRhJWZEzVxQXCKn8t2JD1PrphsaG?=
 =?us-ascii?Q?Vx6l29NWangkw3AoseKicFhFkcrn4e4I3TWtn9x4TF7ECDn6D2660iQuSAWX?=
 =?us-ascii?Q?BiibK1tGo+MVq72RRHaxb8C929j6BU3/6aL+lIVTlaa3Ovfq1OOpZBoneun8?=
 =?us-ascii?Q?cYRxtB1KwHGC/QZxO4l5RqaNt8NgsFPJW3Nitnl71zGnPDnYWq4CSoEBvop6?=
 =?us-ascii?Q?Ksm2c3qOsCnENwRjfe/yswh4ugcfVVkZAhPI9rCxgF3oFtwg4PRc2EHbo+HW?=
 =?us-ascii?Q?juQOpwcsbFqyWlv5pGFQMfEsvj4uoxBY5lDwveHACDcEstRPDwP1CPpBKDE/?=
 =?us-ascii?Q?jOs85oTsrXxFY4E2+QDGcnPbea2BBg5v50t6tiJTwzQDPrI+Ls52XDD9JxVR?=
 =?us-ascii?Q?Cq5yaQ5Mo/m+H+PZyXPuS/zG5GLVa9hMq/ogVrGTg7VkXGDZQh48DuIKaU+e?=
 =?us-ascii?Q?BKW7TXyT5OrIW962YlOvxOYYcJxDSvYBBnKTjbUXb/l/FAwD5IJEaWKxpJ8H?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Fi8BSFS444Ejh7Mpsv6w2Q4IVYIbsUk7VkwjptEBDxmVrOAogKNQpOx2es5uc7RQr14mJE0SgxxAoBQrvmPyzbI2KnCiDy9dkGghDencuMXasATvHbJzhzg8glIdu89MAX4vPFPeufkEoNX1PAXQh5Adwk4ypeQpgkHnXqSmW2V9wYChTzyKC7OwgDSAOrxSNq4FvaHYrn8DFrGG8TLeC4MxUtWwK3PHrpl6Zx+2ancX/X/Mv/mVu0OwzmbTQZ8iSzgSR4VS/CXBBU00kt/OutgmRm2wP55uulZL9nSqBs/qNGnyyhLckjKgEyLHs2w+43M18Ef1OvzYGgfOY1LXz+OPaYABAF4fLpNc0q5a0DH8faEjWnR1eiZ/sYeif9fUWhfDTrSZCVnnjINDGEnyyOk/yOUMvcZegFJlOr44M9rjiqi4nHpnno3gzpcKWdh1RN0r5OH0dPt6oXG9wjfpondGGHNe8qDKr6D2a81DZnOQyH7SwC6fYUy6LSfGAMU4lA+CgBXo6//q5IIB96WmERfZjTxj+dEwvkmIl7kYFSCNUmKyuHEOAhlTKDqk1Owz2NfyusCAOSB8Z8uVBj3eLu4CFQiLEwbou9feq+SsEg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91466901-2379-4088-d5bc-08dced4f65cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:27:24.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtkwNRpXTgZqMlWJH5Q+7KfMENE7IKGy3CNPF774dVO1DT+LsP6kIhjAg7oUP9+5kJvIEjTnyEAwDnuMVJMa0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_15,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150130
X-Proofpoint-ORIG-GUID: kMypuZ0BrNDoYnAmYgJ6ze4FpHosYSV9
X-Proofpoint-GUID: kMypuZ0BrNDoYnAmYgJ6ze4FpHosYSV9

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [241015 13:30]:
> Test to check if setting PROC_CN_MCAST_NOTIFY in proc connector API, allows
> a thread's non-zero exit status to be returned to proc_filter.
> 
> The threads.c program creates 2 child threads. 1st thread handles signal
> SIGSEGV, and 2nd thread needs to indicate some error condition (value 1)
> to the kernel, instead of using pthread_exit() with 1.
> 
> In both cases, child sends notify_netlink_thread_exit(exit_code) to kernel,
> to let kernel know it has exited abnormally with exit_code.
> 
> Compile:
>     make thread
>     make proc_filter
> To see non-zero exit notifications, run:
>     ./proc_filter -f
> Run threads code in another window:
>     ./threads
> Note the 2 child thread IDs reported above
> Send SIGSEGV signal to the child handling SIGSEGV:
>     kill -11 <child1-tid>
> Watch the child 1 tid being notified with exit code 11 to proc_filter
> Watch child 2 tid being notified with exit code 1 (value defined in code)
> to proc_filter
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  tools/testing/selftests/connector/Makefile    |  23 +++-
>  .../testing/selftests/connector/proc_filter.c |   5 +
>  tools/testing/selftests/connector/thread.c    | 116 ++++++++++++++++++
>  .../selftests/connector/thread_filter.c       |  96 +++++++++++++++
>  4 files changed, 239 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/connector/thread.c
>  create mode 100644 tools/testing/selftests/connector/thread_filter.c
> 
> diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/selftests/connector/Makefile
> index 92188b9bac5c..bf335826bc3b 100644
> --- a/tools/testing/selftests/connector/Makefile
> +++ b/tools/testing/selftests/connector/Makefile
> @@ -1,5 +1,26 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -Wall $(KHDR_INCLUDES)
> +KERNEL="../../../.."
> +
> +CFLAGS += -Wall $(KHDR_INCLUDES) -I $(KERNEL)/include/uapi -I $(KERNEL)/include
> +
> +proc_filter: proc_filter.o
> +	cc proc_filter.o -o proc_filter
> +
> +proc_filter.o: proc_filter.c
> +	cc -c proc_filter.c -o proc_filter.o $(CFLAGS)
> +
> +thread: thread.o thread_filter.o
> +	cc thread.o thread_filter.o -o thread
> +
> +thread.o: thread.c $(DEPS)
> +		cc -c thread.c -o thread.o $(CFLAGS)
> +
> +thread_filter.o: thread_filter.c
> +		cc -c thread_filter.c -o thread_filter.o $(CFLAGS)
> +
> +define EXTRA_CLEAN
> +	rm *.o thread
> +endef
>  
>  TEST_GEN_PROGS = proc_filter
>  
> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
> index 4a825b997666..6fb4842894f8 100644
> --- a/tools/testing/selftests/connector/proc_filter.c
> +++ b/tools/testing/selftests/connector/proc_filter.c
> @@ -1,4 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> + *
> + * Copyright (c) 2024 Oracle and/or its affiliates.
> + */
>  
>  #include <sys/types.h>
>  #include <sys/epoll.h>
> diff --git a/tools/testing/selftests/connector/thread.c b/tools/testing/selftests/connector/thread.c
> new file mode 100644
> index 000000000000..8c9abf6115d6
> --- /dev/null
> +++ b/tools/testing/selftests/connector/thread.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> + *
> + * Copyright (c) 2024 Oracle and/or its affiliates.
> + */
> +
> +#include <pthread.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +
> +/*
> + * This code tests a thread exit notification when thread exits abnormally.
> + * Normally, when a thread exits abnormally, the kernel is not aware of the
> + * exit code. This is usually only conveyed from child to parent via the
> + * pthread_exit() and pthread_join() calls. Sometimes, however, a parent
> + * process cannot monitor all child processes via pthread_join(), particularly
> + * when there is a huge amount of child processes. In this case, the parent
> + * has created the child with PTHREAD_CREATE_DETACHED attribute.
> + * To fix this problem, either when child wants to convey non-zero exit via
> + * pthread_exit() or in a signal handler, the child can notify the kernel's
> + * connector module it's exit status via a netlink call with new type
> + * PROC_CN_MCAST_NOTIFY. (Implemented in the thread_filter.c file).
> + * This will send the exit code from the child to the kernel, which the kernel
> + * can later return to proc_filter program when the child actually exits.
> + * To test this usecase:
> + * Compile:
> + *	make thread
> + *	make proc_filter
> + * To see non-zero exit notifications, run:
> + *	./proc_filter -f
> + * Start the threads code, creating 2 threads, in another window:
> + *	./threads
> + * Note the 2 child thread IDs reported above
> + * Send SIGSEGV signal to the child handling SIGSEGV:
> + *	kill -11 <child1-tid>
> + * Watch the event being notified with exit code 11 to proc_filter
> + * Watch child 2 tid being notified with exit code 1 (value defined in code)
> + * to proc_filter
> + */
> +
> +extern int notify_netlink_thread_exit(unsigned int exit_code);
> +
> +static void sigsegvh(int sig)
> +{
> +	unsigned int exit_code = (unsigned int) sig;
> +	/*
> +	 * Send any non-zero value to get a notification. Here we are
> +	 * sending the signal number for SIGSEGV which is 11
> +	 */
> +	notify_netlink_thread_exit(exit_code);
> +}
> +
> +void *threadc1(void *ptr)
> +{
> +	signal(SIGSEGV, sigsegvh);
> +	printf("Child 1 thread id %d, handling SIGSEGV\n", gettid());
> +	sleep(20);
> +	pthread_exit(NULL);
> +}
> +
> +void *threadc2(void *ptr)
> +{
> +	int exit_val = 1;
> +
> +	printf("Child 2 thread id %d, wants to exit with value %d\n",
> +			gettid(), exit_val);
> +	sleep(2);
> +	notify_netlink_thread_exit(exit_val);
> +	pthread_exit(NULL);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	pthread_t thread1, thread2;
> +	pthread_attr_t attr1, attr2;
> +	int ret;
> +
> +	ret = pthread_attr_init(&attr1);
> +	if (ret != 0) {
> +		perror("pthread_attr_init failed");
> +		exit(ret);
> +	}
> +	ret = pthread_attr_setdetachstate(&attr1, PTHREAD_CREATE_DETACHED);
> +	if (ret != 0) {
> +		perror("pthread_attr_setdetachstate failed");
> +		exit(ret);
> +	}
> +	ret = pthread_create(&thread1, &attr1, *threadc1, NULL);
> +	if (ret != 0) {
> +		perror("pthread_create failed");
> +		exit(ret);
> +	}
> +
> +	ret = pthread_attr_init(&attr2);
> +	if (ret != 0) {
> +		perror("pthread_attr_init failed");
> +		exit(ret);
> +	}
> +	ret = pthread_attr_setdetachstate(&attr2, PTHREAD_CREATE_DETACHED);
> +	if (ret != 0) {
> +		perror("pthread_attr_setdetachstate failed");
> +		exit(ret);
> +	}
> +	ret = pthread_create(&thread2, &attr2, *threadc2, NULL);
> +	if (ret != 0) {
> +		perror("pthread_create failed");
> +		exit(ret);
> +	}

I expected the test to check for the correct value to be returned?
Could you use pthread_join() and verify the same value is returned
through the new mechanism, or will they not match?

> +
> +	/* Wait for children to exit or be killed */
> +	sleep(30);
> +	exit(0);
> +}
> diff --git a/tools/testing/selftests/connector/thread_filter.c b/tools/testing/selftests/connector/thread_filter.c
> new file mode 100644
> index 000000000000..3da740aa7537
> --- /dev/null
> +++ b/tools/testing/selftests/connector/thread_filter.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> + *
> + * Copyright (c) 2024 Oracle and/or its affiliates.
> + */
> +
> +#include <sys/types.h>
> +#include <sys/epoll.h>
> +#include <sys/socket.h>
> +#include <linux/netlink.h>
> +#include <linux/connector.h>
> +#include <linux/cn_proc.h>
> +
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <strings.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include <string.h>
> +
> +#define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
> +			sizeof(struct proc_input))
> +
> +/*
> + * Send PROC_CN_MCAST_NOTIFY type notification to the connector code in kernel.
> + * This will send the exit_code specified by user to the connector layer, so
> + * it can send a notification for that event to any listening process
> + */
> +int send_message(int nl_sock, unsigned int exit_code)
> +{
> +	char buff[NL_MESSAGE_SIZE];
> +	struct nlmsghdr *hdr;
> +	struct cn_msg *msg;
> +
> +	hdr = (struct nlmsghdr *)buff;
> +	hdr->nlmsg_len = NL_MESSAGE_SIZE;
> +	hdr->nlmsg_type = NLMSG_DONE;
> +	hdr->nlmsg_flags = 0;
> +	hdr->nlmsg_seq = 0;
> +	hdr->nlmsg_pid = getpid();
> +
> +	msg = (struct cn_msg *)NLMSG_DATA(hdr);
> +	msg->id.idx = CN_IDX_PROC;
> +	msg->id.val = CN_VAL_PROC;
> +	msg->seq = 0;
> +	msg->ack = 0;
> +	msg->flags = 0;
> +
> +	msg->len = sizeof(struct proc_input);
> +	((struct proc_input *)msg->data)->mcast_op =
> +		PROC_CN_MCAST_NOTIFY;
> +	((struct proc_input *)msg->data)->uexit_code = exit_code;
> +
> +	if (send(nl_sock, hdr, hdr->nlmsg_len, 0) == -1) {
> +		perror("send failed");
> +		return -errno;
> +	}
> +	return 0;
> +}
> +
> +int notify_netlink_thread_exit(unsigned int exit_code)
> +{
> +	struct sockaddr_nl sa_nl;
> +	int err = 0;
> +	int nl_sock;
> +
> +	nl_sock = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
> +
> +	if (nl_sock == -1) {
> +		perror("socket failed");
> +		return -errno;
> +	}
> +
> +	bzero(&sa_nl, sizeof(sa_nl));
> +	sa_nl.nl_family = AF_NETLINK;
> +	sa_nl.nl_groups = CN_IDX_PROC;
> +	sa_nl.nl_pid    = gettid();
> +
> +	if (bind(nl_sock, (struct sockaddr *)&sa_nl, sizeof(sa_nl)) == -1) {
> +		perror("bind failed");
> +		close(nl_sock);
> +		return -errno;
> +	}
> +
> +	err = send_message(nl_sock, exit_code);
> +
> +	close(nl_sock);
> +
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> -- 
> 2.46.0
> 

