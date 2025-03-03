Return-Path: <linux-kselftest+bounces-28031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C8EA4BF80
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBAC165841
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1DC20C039;
	Mon,  3 Mar 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kY1Ao6Y1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LVkixpPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D041F76D3;
	Mon,  3 Mar 2025 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002906; cv=fail; b=f7tnyH5pskrYhdcK7B3gTeDGtoYTTKn9c39l01o+m0lBVjW2JH7FRCMJ7Z0xfkVQ1N8EcGDM5S0OpcEPOHNkwmmV4/GxUMQL3ZBIm5W4981Lg+ZHYAGZo1ESlnjRrQPBuosEDITLKoQxpW5hooFrv6rdi9Nf9PvxFfnAoycXc8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002906; c=relaxed/simple;
	bh=f/N1rV3EsvsaeBlFJqON+itXkWKOaiZjsg0MbHSmhwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZV9V7vcJq9mqNpMq5+1gUMzPPofuf42xwm4d/01LFp3PssrOeT8y6WrWesijA1LQrTlrrNXRqVdUn/yKAhfJsA0eO6leyxj0mog+8iJp454jv1dqWYNz4q9EjN8FOkcJcTYEGpFsZsn11/pEzuu84PjoP6DHQKH3unTPe/UH7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kY1Ao6Y1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LVkixpPC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237td6u028720;
	Mon, 3 Mar 2025 11:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SSQYbQ7dCqfG5TB+Na
	fieJs9V4cR+r8CUAQQqeIFCZY=; b=kY1Ao6Y1Y3C37lNHQ9hP026mbktoRe4+om
	gNOzEdWi4WL2n7LDsJhaxa/G4QXRIUmcqhLtfYTOlCVrG6p6g95R6yEs7aOD9zQF
	WrhQSNzPnEidlXbn0H0tvWEJkvOOOdHcc8hzlFK2gYRUNmK+MrNeu2/85BPi/UuB
	ulWvCCL41wRnJhv9s59LVOZDhmTm2+ZJJgIio2mWtR8wZU5M2FemjVKVbAmKp2zP
	wVve1c3jMUr68HljlIJ2VME1+CKyHz7i3BXnauo7cvsUVHZyXdtU7ahyR9Lxx/j/
	X8NKiAesIVX8dx3/zhkBB/y7bEMgKH/1gOoJXprbhNCrMW5mA9bw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r428sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:54:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523BIEwN001246;
	Mon, 3 Mar 2025 11:54:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp83w1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:54:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsWUeEWAMT/PwgWRnMfmqvwr6Eqe9bAsIsrzUFARXn5vFSHpJvUbQwvjnbF8yzCU6YjDC2MX1/o8KUufzx5odavQrZDArHA+EJh21lvd3XDDUdjDDF3TeGV6Uc701DqelZp9nB0IzEv8R1iarSciCQaVkPZXmzyEAXzE+xtk22ByhzZ8hJJNBDlNubDf47dYHiDpf6NKCsL19DZlETpiylo2fu48S9c9GcLB22hEv3FD67Ic9DIreMFRY4Wi2uu4T249OekX+JngOSqZLEMvymkSQVhLhVzq/V9XRigPCZsatsSNFPWlSzouyXSnraveAkugDKacD0GV0z5hKSF9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSQYbQ7dCqfG5TB+NafieJs9V4cR+r8CUAQQqeIFCZY=;
 b=YDMaMITNUU5+7p8gVWkXLsEpeMMafV2ZNjePG5mu+V+u2G52FXGdVTUWvACvo1aULZoZ0iXM1CXt4iPFiBLqArGVvqDaXSuxacZsW0+6RWJ/DQmGUnile3hMk2g3GB8CKOwloFRbA2J4KKq0NH0qm3aJeItmO9l5Q9eLTFgTKLk/HDz6K2vXjYAaxjxD8bsh0mJTUgde3w2MWuqs8z84czic2FSS2mtxXQ7ylOvW/UCjHpRWWJkUEm9HQwSTHc2Y94M7oD9G3eHrp26UPQ8LngDkvzJBNBhNyqSjhE937JxHIYi8EeHACKKOMEHPPHVVuQbJSSFisG62AfVmPefXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSQYbQ7dCqfG5TB+NafieJs9V4cR+r8CUAQQqeIFCZY=;
 b=LVkixpPCntb6s9RnYLb8UE2BQSVpCfUpUGoARFsG/TSnsZCvFvT3DkQGFZ/Whv66VaIWzDJqjoHiew55ePyFscWe9okWgvYiFwbii4o7Tx8znt6GIAR1GWEaRcaTxRvuMsjPG4JawTvDN26YJCkHpyXz4VCDE7zNS8UloFCyPhk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CO1PR10MB4755.namprd10.prod.outlook.com (2603:10b6:303:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Mon, 3 Mar
 2025 11:54:21 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:54:20 +0000
Date: Mon, 3 Mar 2025 11:54:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
        sroettger@google.com, hch@lst.de, ojeda@kernel.org,
        thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v8 5/7] mseal sysmap: uprobe mapping
Message-ID: <32d4c017-1c71-4559-b77c-2a16d0688488@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-6-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-6-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0553.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::7) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CO1PR10MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: 2572acc5-ed8b-4f1c-5a54-08dd5a4a2268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p0iCpr0P8wZjjSkgFa84Gb4tPwaC+bGUqmpCx53Bv4Ni7uHx1E7rjUC9/x90?=
 =?us-ascii?Q?vlHfAxBhoJnZWGRl0FtlDml8waVMV+thoCGYBrA4iP+dLbdrMxFWi721pPIS?=
 =?us-ascii?Q?QfxrupkKd7eRHoD4zdh8l6fxaGiVWx3g7HCZsrQCREzpInn2ttjhVYh+HIJ1?=
 =?us-ascii?Q?lkf/dCchoUOsAPAblBIu1dnwir2Cx3owSumKCieCveLXm0hsYOnt0zDTHOvW?=
 =?us-ascii?Q?S4fVZk1SclKESkOjYOhaLfxn1pNc66M8vePiVDm39QvJIv+bwAqV5TVJeHBO?=
 =?us-ascii?Q?K/NSy8WTtfuDfpYgc7d+k1e5YKYOcavnre8BIINDaV5fGGIH6yrjpHSjDWqT?=
 =?us-ascii?Q?mCnXmoUeziMVLhvxIZOqy+MK13ZDFWMBLDsnK2DH7pCZvaFo80VMz+iVtOmf?=
 =?us-ascii?Q?gQnW4c+oEni+gKZAJn38C+gV+ie3D7rYoN7S65b0/2fubZHKAgJSaCd5hmFN?=
 =?us-ascii?Q?u2I1d0FjtTSuRnAYzNeKcpBpJcBG4+RxT4zJl62yc2wHaW/HRi6dFEjILHOy?=
 =?us-ascii?Q?iSyFiOTJKhZmSobuy7T41ZhBAoTHUbn+tnfcBwO7+od68McTC4wmNrFDpYfz?=
 =?us-ascii?Q?nmxdeEvBf+U9raeM67/1cDLYCeOw/H8ZU0iy6CEwZaXu675l/Xp45fMCwXoL?=
 =?us-ascii?Q?RdWGyHVGB95Ciul+nTBlotSXzhzrnTPuqbJvD88wrUrPMM+yL66niqyRy1gs?=
 =?us-ascii?Q?jPCsdRPTUCck1F22jsXDOpeGVegHK5DlJ76lWFVblwOQV8Yq+o9MQiXZnZar?=
 =?us-ascii?Q?UCUX+2I4c0woyHOtVozKWWKaPnOYit7Ko7oqCu9aYgHrqgTh9FB8nEBFJng/?=
 =?us-ascii?Q?J9TnsTA0mpAq0DEfppS/Tytf3m00VqqgFctGl5On4NN0KZ84SyBWSSmrbvMF?=
 =?us-ascii?Q?mEt/a2xFhvhJCC3Hvp9OgKCvw9a6zwPED2pAU6cmQo/n9cJsw59pT/pAzKUa?=
 =?us-ascii?Q?TKNxSkb2FO6UdNVyFzSy9NrTQkEAjcpcUk6ennrNjMZ4HzsxNzv0PjQU4lpt?=
 =?us-ascii?Q?qzQd0H4z6t1Mv8qqsz0TfTZqQ3mZzDwY0CDohzbZCCdoQ7SUho7sKDWSeLUm?=
 =?us-ascii?Q?y9jdv3hP4ys7p5hT/WxY/pYZPuOcQVU0XAuvX03X8RFVoaQ0ZHNBv8fXTKsb?=
 =?us-ascii?Q?ztFRIAaXX/0AZJGYt6RT9ov2bxeFr+nQH/jD+ns9TK8ZciT2qYnGqPdR20s/?=
 =?us-ascii?Q?4JzNYwhf0Zne4Ms1El0owVrwcZDJFwvCacrdgqos/Vyf7duQFVLcJEd/BST6?=
 =?us-ascii?Q?+6bEpCUUxY1hdJkezj8XvfoxOywvNS/FUSbvy7OSfG+7YQwTulOqMCVoV5rD?=
 =?us-ascii?Q?vsqzd4+48yjnFEH5gRP//WaRxxuzBGiz+Bb+C33Izh51RrbFpw+qnyxH+ylD?=
 =?us-ascii?Q?xJCNr4RO/1LW2ZGIYfXmXg6Gyplo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Sd5EwEXfskAsGedvWTGQ+RTlbmm2lKhO+WmDxh1W9WiJUv2cxG88tY0sN6A?=
 =?us-ascii?Q?pw1kaO5VOOQTq6jUKkZzdicpM7crctMSXVzvUAjLD2vVTLezWrUzAeR2clEZ?=
 =?us-ascii?Q?HXWJqVzexyFEQ28HAnQESWvo6zHYnWtab3KWpIse3j0e8I3jztFizhL5930V?=
 =?us-ascii?Q?h1vRcWq032ssBLEEJfIKvqIiqvL4T8A+O7QJ9XplI3Fn1ZpNR9jEIgNwYfCx?=
 =?us-ascii?Q?CK0FlAM1G0ZzTW11A3L697YfX8+2b8D/ksZfzuz2Oksj0FK8Cetgzgz+J6dV?=
 =?us-ascii?Q?Pbteb9fHWCKVg04sTUkcUyyynU9y6rhsWoQ65gPK2ftez6TDqGkyTjLb9ySU?=
 =?us-ascii?Q?cFZt/LTdQtqK5FP9SwywI3ctKqtBgJN4f9FsspYD6VJCbJtJdeacg00pOUqz?=
 =?us-ascii?Q?lJeiUFiNFmpRKbQqJt1GCD6btESqtEqaEmk36b57ASx0uEMDGZQLrolCmZdE?=
 =?us-ascii?Q?Z4E0Q95qTIpThS21/w21o+yaODsbubskNup11DR1kWOruyVjNSdhnd8f22nO?=
 =?us-ascii?Q?WAjAemBlpZ2BBjzmMsR/HNk/WNwjB7y0eHYfZQIEIBGu6uw+s/7zOPLUPk4m?=
 =?us-ascii?Q?nXA/Ja8hOHofoHhcDOjwiaj87foAB0KFYy71HRLR4nGOUruXwMkIQdxqMQaq?=
 =?us-ascii?Q?TPKqi6VbZFoGSj7uXThtepS+SEZ5GL6WHcJ23AYRVA5ekdw8KsQhItpJvZCQ?=
 =?us-ascii?Q?h+m8Z3QueoralAE5eqDyhaed3xHLHJmd05nUiwjNuvu78X0zPsKV39MnbG3s?=
 =?us-ascii?Q?uf5Ryh990LJ8yyEkpu0LxVdjlI5K4Culgk2RX6mYrI/X2YTJDvONhsiCZFAu?=
 =?us-ascii?Q?Q6Ha7b7wRjMiT64/tk+b4XFL7q5VhV21jKypAiGvbzXfnoZot6BuUffipuGW?=
 =?us-ascii?Q?7Cn5JjYD0JKKbCox5xcOlbGL0jBCOJMZh0N3JrAexEZUEaIvJBTjYBSrMjXK?=
 =?us-ascii?Q?SPZLtHuKUOqwj/9HtZThfqxzy8BNezDZ9s5+Z1dQMIZRKol15ouad5Aii2KQ?=
 =?us-ascii?Q?zIwoHWI9uDC5k4H53XogDpRYMzG5xCZTSZA4O/EojqTKh66zROr+JsCDuEAi?=
 =?us-ascii?Q?5nt5b8St/31qAFNvYlSakkv7bE+29tzRGdauFBKh6WsjzcH8UhR0mou+TiE0?=
 =?us-ascii?Q?LM0YvkFUrU3qNF7vwnRBIpLW9Yy3IAqokhJNv6EXDnEfZiBtAHo8CQzuX6z7?=
 =?us-ascii?Q?6YHYaQ71COH0jz2b2FUhkW12hJimWoY20EYfS0V4BulIXdrvhjHowtS9rhTY?=
 =?us-ascii?Q?ZfqTZwIY9ybWkgw13QmGYrd2cePUHsu2VmlHfYkQfAdyslnq9CgwXhTEUCrq?=
 =?us-ascii?Q?muD81Pw584pt32qJufRljYrND9icrWdX2a9D0UNVQHsw/7873rKPXlBSywjZ?=
 =?us-ascii?Q?EuGniCzONbWhMnmeIlnuKYjfcAHeTaXJDrsRy+pFRkKQwYLdWQvODmYtbxYa?=
 =?us-ascii?Q?/84oxDbgt88SKMvgpb35A2T5l/AODTFmbastToiEvO2IV4KJlcaaripjCIMr?=
 =?us-ascii?Q?3Bqd/dFShzRXalB5cH+YkBq6VirrQgfYmd/aVkkm3UkMsemvGBk74ztOpuws?=
 =?us-ascii?Q?ExxrrA2zVC1b5xSx/lHbZ94YT4Tt8M8FsjCD5TgghF3YtYBXNJ4+XXYSyTW7?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sl9L7HXQU+jMtmPmsJO0xtx8C1cGsGQOAqRVJjTDQ0rvmin8OPP3UHnkiT5HzYzfdN1yvZ8s9QEyLj1E7NceWHjwwNJ6rdthMpkdy4+JBcpGVrDcfi8BbbybAJ8jTbkWT3A+iLgtkcB6h9/5oE14TOPlQPWVm2QbEOHzNO6RADXkoojNqC4S+7hwHZUXB7YaKfmckUWVRPop7ENCyRQxwTjtbPw+js7dhMyO+53FwZ5SFeorTAflTUgY1weB4FPZX65o1hc45Njf+pncr0h+61gxTVSxpY6tTzKU6kT69YBqRKZxwaY151t/1HzRovriR/JWe3cUmvSMWIQCvbwFxInSfh0tHWOBVoV0th//ix9/psKvxNq0v8rRNS35eCTPyZawh/1WzzqyO8wY76Qw/towO+h9RS6vP166jw2p8UnN5DOWPGWNbES5ksOj6H6eISbcU0rTDpsMG0dF49P3i8tSwtA3jUA2116BebX54IjBDl19fDhSb+66Sj/R7ovemVO8qKc5hL3ifWrqykB5nxCxQ9EwkagweWROnrjFFcnDcuY7zocb4+uVGqzX6MfsBKK0nSIZbLyi8kg68KnAHLb8qi0wkVsKlykM8qKkzy4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2572acc5-ed8b-4f1c-5a54-08dd5a4a2268
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:54:20.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLbWtDQ1FglJWqpZDLy5HEwtu3pbl8u5JUXgOICm3OW9JqGglePHfSEN7kkxhHqxDpQDckljTcc2+Va4WbFHAiNviVMIUcSmf8XXdcmwnAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030092
X-Proofpoint-ORIG-GUID: H9kCSECz-8tB8KjpDk28I-VTby3o9NiS
X-Proofpoint-GUID: H9kCSECz-8tB8KjpDk28I-VTby3o9NiS

On Mon, Mar 03, 2025 at 05:09:19AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Provide support to mseal the uprobe mapping.
>
> Unlike other system mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime. It could be sealed from creation.
>
> Test was done with perf tool, and observe the uprobe mapping is sealed.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/uprobes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index bf2a87a0a378..98632bc47216 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1683,7 +1683,8 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  	}
>
>  	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
> +				VM_SEALED_SYSMAP,
>  				&xol_mapping);
>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
> --
> 2.48.1.711.g2feabab25a-goog
>

