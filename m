Return-Path: <linux-kselftest+bounces-18322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0837984B5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8942853D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B300D1ABEA3;
	Tue, 24 Sep 2024 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I4hHFSX4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PJ1R9h+i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778140BF2;
	Tue, 24 Sep 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727204375; cv=fail; b=eK4BL+1IfHVLSoLYvuD0t8FREvn33AGN5uQsezVCF1MCXc5WCsO0NoI3SS33mGb+/S3UbDkQCMzFXcdcEjmvf0vGhehu6Ky3hL5DUMbxTVDHPJgohZ1DvdMEvq3sUp4oci2UaW5/VAeDwWf8gS0DkoFgOMhH1lDvfcvzyZhWQJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727204375; c=relaxed/simple;
	bh=7r905N8y5glPCp9yeTO0pjYb0G3FhCMxD86zJHane8k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d6DKiuQ1Ihu5duoTefilLBi83i1D0y5UOI4pmG2H0nXuEsveHYNSXV2pF2N7lM0QVK+znYehX5kJOZXEoa+HUNSOuXDxAx3vGUSpw1bJF79O830WB9BbgfiL8b5mDieYyao4/tvZgHZ5PDKGFSIabIY6NlNBtQ1qS1YmIuak8ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I4hHFSX4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PJ1R9h+i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHMe6U009089;
	Tue, 24 Sep 2024 18:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=hl0ilTHeCNQG+3
	zbruFsMaIdS5kHxWvGuruynS88vrM=; b=I4hHFSX4RKF/wCj72Tzi4FkRqMoVfx
	/yuegsq5hJU1Gr8r6C7GWuHHHSQbKb864PCEsdtd4ddkY4BJq50qdfhwHQYwi6wD
	RbknpS2PIDRWPmWmPwmrM9+7msOliOq67XQTtTClfjA4vSbCoizqib03vTAxjzpj
	kqjXbgqqeaFqr5MqufLLveOdZGPg65hWeQPE+tR2j78Id2pIjrzyP0i89ZSAKCIj
	aah502rRR44SbJjU8VaF9pcNAvOcdIReRMqjrPRf0KUO1bpA5JgraqsDnV4P3kM+
	QNepkLgn799l/99Aa00qfoGrpU7hUGB8j1e8nM8LL73dnsnkAngY2vkA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6cdxjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 18:59:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OImi7X009786;
	Tue, 24 Sep 2024 18:59:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9d74b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 18:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf/tDS1kD3lusVvEN+lk8fonxlRntJ54ZVoqG9nfZPC73N+baBDt1wlrIPiX8/itIoGbBBAbNiPK7RKueC+fQ0HNvBMRrTF/qWs0zxOrPUMJYAXYAFkoUGW1LP8HPiiXM47aHQPFwRXODjwWQYLMkwtquQEtOm+iyqXD1BcHpPmp8dsnSNKWKVZDuB38Dr5GjtYmBf/Cwxzj6XiH3FabIhK1esZM10NSzNwLBhIr0VADU9Wh2/WwCsifTITb7j7JjZ4wRuev86Fqqxa+2xLIrywQr99J2QXpRPL9PqFl4dPv9fszGsQWT4dqDPFKMpjqVZtmYJy2nECjMXzoytx2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hl0ilTHeCNQG+3zbruFsMaIdS5kHxWvGuruynS88vrM=;
 b=wX4Xu8Mw1ZTiYACv6JdfmWLz/Tr9w9FPFIRa4wu44X4YCC9wqSidGJB68osKc/pg05UQ/RROtgTMdKlL4zfwySJiP/0Fzrpk1okty1I3Bu2AoGtm48EhZmPnD1puM9UcRKgXID7YSlzfOcczRUltf6Wh9+vCC9vVQfVZ6Ep2hWo6AxHLinVb+2MbuD3ZESUnaF0nkMw+GAM5A1iuAHXnWPgFif4scZZkLc0VsF0xxze6CK8AEYQ7DvlNF/Y1oazfFOh6giBJUx1zJc55pzsB0/C3H5AeajJ0ZKbV7B88L0IK3xPJPvaTtA3i7h7rM75NwZTmD3rJBs8NPGcCSqPAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl0ilTHeCNQG+3zbruFsMaIdS5kHxWvGuruynS88vrM=;
 b=PJ1R9h+ixFszFm5maP6LBIFN9IEAOb55x6s26OgmvnC6mu+tq7FX1nNPPaQ13Pv/wx+YnS1zRNmRUjsN9VMGth4tPpZfVhlrQbsQOx8pdaza4ohgvV+LlCvguBapSSaVVoQ50y+m60dst1zQUZouKnk+pKsxE5KDY72GyOV+WnE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN4PR10MB5653.namprd10.prod.outlook.com (2603:10b6:806:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 18:59:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 18:59:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Donet Tom <donettom@linux.ibm.com>,
        Keith Lucas <keith.lucas@oracle.com>
Subject: [PATCH] selftests/mm: add pkey_sighandler_xx, hugetlb_dio to .gitignore
Date: Tue, 24 Sep 2024 19:59:11 +0100
Message-ID: <20240924185911.117937-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0175.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN4PR10MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 309afac6-b0d1-4801-3241-08dcdccafd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NW6AEYhgzEmEDuQm2KkIG1wraRicYLepSwUvIs+O83J1ZmKezArsCAk2LjBg?=
 =?us-ascii?Q?9tYG+2xTMacj3QAiNbakjQ7qtHNGqeAoynfwFbGwVjTgf4J0HXYJ8VWVssx1?=
 =?us-ascii?Q?d5mHEaEw+UcpyzEQywh/2GChNaNTUnSp4JTeS0J+HbA4JoF2VmmXWt8uqgNg?=
 =?us-ascii?Q?S2LDKWNdge/BCfRp3FO0eJXMijhUM7zejIkDz/FiJpT3ISbce+C06o6uIJfP?=
 =?us-ascii?Q?p7ezqEy4EZ86QveLqdqO5f+6yusExFxZDNmx9dar2gd/oy0nV3NV1XtmCjEg?=
 =?us-ascii?Q?C/cFre21lpo9hNbi9rJ9f0HykqO9+YaoNRttkq9pCM1H5md5TTxZf/fc29Qo?=
 =?us-ascii?Q?e2sz8eep8u0KdnjmTYScBdotsT35acUJ5A5lIs6d/GNgFlSDW0ckC/5UtbwP?=
 =?us-ascii?Q?ocLCrI8uWUey6tAsl/jHi+lFcUP3kg8fAnxY+lL+oQGv21ROt0H06kXFJoax?=
 =?us-ascii?Q?syQUWZPlxHDEhZCzyThCbfj+HUtMGfbKJcDZPIjP1G14glWXJYGMOGzeGMyi?=
 =?us-ascii?Q?gqG7x+l+onGD1bQr9i+BMJ06LmcLCuCBONY2fJtwKl6/heM1ucVhSEtbPk8V?=
 =?us-ascii?Q?sEc10CUdPnJKxdRe+9d0ei4pHX05vJNte0IMjbIHLWhcwr7HvQbilClgRoAA?=
 =?us-ascii?Q?oBNklSuZjFIj99qGDSV58EZ+u4x797UcQpVfX5u8XGBWUtD33K0H801HzY4r?=
 =?us-ascii?Q?/L1afeZp7MCxLnt1Nx8lz1XmbDjG05fOS/ZAo6d2+HZ5vbAS5hUobijPRsEj?=
 =?us-ascii?Q?h6BgIyVC1qUInpIYB91NK66U/UPr0KmVkVQWXE79spyfQxn98SWOEajF2yvs?=
 =?us-ascii?Q?ZQw8laxGwen/GgG7Zqak7aWB07jNR58VDnGn6xEGHk+j1RQg7nZdYAhBgfZ/?=
 =?us-ascii?Q?Qg2sRZDTIypqMOvhWOvYK3LssKpJ+vnq+43eamyPvtrpe6cowJSUSA8nKzPc?=
 =?us-ascii?Q?r7Dlrt22WgYmaJADM0VAJcp3BOSanpXuLXKG05gFPkX+3mXkRugiolVDSBXX?=
 =?us-ascii?Q?THrAwCdqpCZg5EdN+G7CFv4BkwV/uKYxpiP6L42aMbY0yE0PHS7MGwmmh9NG?=
 =?us-ascii?Q?TYGUnzXeZLS+WRvaetuvH3Vh2aGW+rV23lWTlrJagXzYc9lMeLH+6KQkJhC3?=
 =?us-ascii?Q?hdTp+huoX5x54uFK2NKfDdsZXwp1haSR0OJpC7XrHy+Akpt0dYMfFbFuVDf+?=
 =?us-ascii?Q?HStNaDfMz01+/amjV30xdJ1dfz4pST3p2b13ViesXzoLVgJnlX5NrrhI8bg0?=
 =?us-ascii?Q?pM+iLfv/JXJvD78cbjStrBMWwRxslmos/FzXWEgD6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dnoZanBKjCF3+2zvO5xEPlauqkAa4JjJ+NJuytLkAJjq8T9XpXOLCbP8hHAv?=
 =?us-ascii?Q?7sdt+2peEN9i0pEjIpJSso9WpNIf4toURsBtRTfnXmf1YE5I4Q9FdXYn6M2N?=
 =?us-ascii?Q?bPnfdOISFYIvpOT6qKtMvrPsN/cK2FkwyV1ZkkLADMQ4MwYKyMnn5kAUfmMS?=
 =?us-ascii?Q?o4Um4VLEjrsefJkbnpffTbUrSz76tCCJlruUsvG136ASxb3PT0LmhfR7wAJk?=
 =?us-ascii?Q?AOJxRuNficWcPgGjz9RkSgcQcFtqQfzhxoTEidWn3cpSO3X9dlexxVsZ6sPk?=
 =?us-ascii?Q?TioZwufouxgF4gOXKorqKgT5RVvsmMDJkTibTvxkzLQQ2IezAIY03KbduCrX?=
 =?us-ascii?Q?9973l2BXXQZ2MmVth/Uho+w5zgF75Uh7PwuE7YlFns4wmkhvTVQRizH9QTIY?=
 =?us-ascii?Q?5xGYAqiPQI9VMVdMhQtl1chI0W0eYLUrDTwrHX2mZjSo16Q6BGhzK5e2nYmP?=
 =?us-ascii?Q?aLJiRsNGpnAyzMPfmCkDq5nxgdRz3bzo8MJJX9VyfLIr78+FTg8dOrUjAXSJ?=
 =?us-ascii?Q?YlNX58TYpwVenxIqm20lYWLxWBagxMDRIIRVnHSf3kumu6W3mxiM18MEcAuo?=
 =?us-ascii?Q?E74W1MIWiUqToaJDqIWoPs6aXFI1xACQexDcbyHLjgxosFXEew80cl9S9H3J?=
 =?us-ascii?Q?dbM8ep0G5cR6/nUltVqQ8vhAhHtymoQXj4r4uBvBGXTcAdwkqlBgx6OqY0nv?=
 =?us-ascii?Q?Z51rDz0Bj/3LPFVjdFW2q/bfDJOO+OsGFu+YP/6taUyeAczVxjpXDq+z/v5C?=
 =?us-ascii?Q?VRUUO84qsuLxntruGA/ZRW66KvwzpmvnRDuGvpp4f8ExlhALFzLrNjAtB4F3?=
 =?us-ascii?Q?KuXaMv4MM7jlT533y8appmNvVKeMAXazHGRykEecoD1+1PzqHnHGvRPlEKaW?=
 =?us-ascii?Q?iaH59d9w/D4wYn22lXs1YPpzt07lfZU+v26Zr3uRslzsBUaSUzWP7IFx58tr?=
 =?us-ascii?Q?D6GMXXuUGwzAbPmRhgW0B89+q6GylI/TmYQKPWewX0G//yDR/v3v254+iog9?=
 =?us-ascii?Q?KoaoS7dZ4TkIALXX0cIXl7W0MQBrnRKKLz1i0fwETj8/9yidz1c7EWQcCYlG?=
 =?us-ascii?Q?6PJiPePqcOPwvPkIvucZA/a/odcSHLKBI6oLkiPM+0hbTcL4AnuluQO+NFDe?=
 =?us-ascii?Q?++haEGQVzBVzBNvmBgZiO75Dp5fi89p7aLoD3Weg0ZxDMFHk62XP7o1UwpoK?=
 =?us-ascii?Q?QPvy6RJVYhc8RIFklrTZFKmYJXOpNk/Jex/4Bm3rRIfzkzbMxiEUao4cnsSw?=
 =?us-ascii?Q?voJ6pG1kdrBvX9i/PnNPr9UxRNXCAfyc1PxOTUg54F1vlzasxYvVKZGWqQ9f?=
 =?us-ascii?Q?e7d0wLwmrdfyx8inKUU9WHg22KtIRGo3FYZqyQRNG8VgAHCkklXSnC9b+KH0?=
 =?us-ascii?Q?//W/2xx/mQ3jryRjs8Flim3Hq3urJMlJBP3k/eP8cHnmv7oPNMsye+JtgFcE?=
 =?us-ascii?Q?2o5+EQ+OPy/0Fi43asSSXDYNHQ8d2fbNcRe/GUgRshf9H00ljl7ifR1agHpu?=
 =?us-ascii?Q?XJa7lp4sJDXjBLLKMoClVOUMQ9QLKlLOoW4VxGjvj2VZWpb+a5UAGuqET/zu?=
 =?us-ascii?Q?lk/vYn+JG3EC6ISclhdY1900yVOZ9kEvAN3FAwxNERlqZZp++GikF99EnDdP?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T17QNrLMkZdDu2VlPFwH+f0FzMqLL5GhDuKWFZrFnTcwenBT6tjNyf0g2hRKGDq9jn3htZKp2N3r54FaB0PmoGzob8nbbyv1urvcueKPBRLfwKKbpoO+EBkZdj4BWkeg7EHblvX+GE8e4ha8Nm+a84wUV506OuHlG5MsQTEC98TOwGpJOVVD8fqyzKle2joDdRpZhUbj3w8cyLPbv6FOls43g3/A9YvDQLfHE7yAhIAyyrae6xp3Ei7IyHplWqvjmwl0OQzhsEeOGqYF5zK+z8pSr7zFs5Kr0UZT/HX1KGW0N9qMRxyIuiI894aIjUjKwIDld+xzHtqjhdkgRrdJw1oNdCjOvi3KySFPG0Rj/kncYLdBKAluTpxPS9UrqnHAIWXTcloV6HT10Q7gqd30Yw/Gj/4lRSio4W/9siUHEL+HU14NotU729BQxz3SMFj+2kZzeHSaByFLBg52r/zC4xEW+3Ov5xh/L5lmu9T3525Soop20nWuF6NR8V5WKQKgQzwlF1JWShmOF4MhFj3h9pNbViVDyEo6T1/T54W5gZ4ElA3ZwHbfLMt8FbAz9xsv40WDjk6LuFd67G9IBEHFOKf+ZAYp5JCnEQq7pT28Qcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309afac6-b0d1-4801-3241-08dcdccafd36
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 18:59:17.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvM5Dw5KNKG5Al31jAs++vwXM6G7lmGlbUtMA6aCKRb//KeP1IlNq01HXiQbqQDFYbJHrFC3N4fg881cbm+4VS4AI8D0ZfriDQ46YSl7iII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240133
X-Proofpoint-GUID: GqQ8Gj8G1eOfXh0_mXYIgCg_lXzwvFtt
X-Proofpoint-ORIG-GUID: GqQ8Gj8G1eOfXh0_mXYIgCg_lXzwvFtt

Commit 6998a73efbb8 ("selftests/mm: Add new testcases for pkeys") and
commit 3a103b5315b7 ("selftest: mm: Test if hugepage does not get leaked
during __bio_release_pages()") generate test binaries hugetlb_dio,
pkey_sighandler_tests_32 and pkey_sighandler_tests_64 but did not add these
to .gitignore. Correct this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index da030b43e43b..689bbd520296 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -51,3 +51,6 @@ hugetlb_madv_vs_map
 mseal_test
 seal_elf
 droppable
+hugetlb_dio
+pkey_sighandler_tests_32
+pkey_sighandler_tests_64
-- 
2.46.0


