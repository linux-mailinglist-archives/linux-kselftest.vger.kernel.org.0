Return-Path: <linux-kselftest+bounces-28084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7CA4C91B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F233B61C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3225925CC89;
	Mon,  3 Mar 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f5qVKYJ0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jo0QjS0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696E25CC6B;
	Mon,  3 Mar 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020627; cv=fail; b=NnZQutLt29JCmt33zUMgjbH8MktpD0bvX8ctG7Eb4fC0cmGQvKuGLyyQsrbaXNUrzvoi4v8sxPIMr0znd+QbE3AfdYMbt/Kb5SBZeZ7GIXmWTVhYqnaYIyzGIWaZoOpbFdJ5MQNqbrvLsx4lbmPH41NXXHW59cNacB1uq5aOUBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020627; c=relaxed/simple;
	bh=Umwj/p0hj6BXTE8xIy3L55JMPtOHNhZQuUtwiN5jb38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AUXU8N1WiTuQ0CGC/THRRDPwLdEsk3M6L97eJdCjghkM9sk2UB+C8Qlm3BBafSK1oCiHVBvnXpWCMI+nWeRK917hEUMz7zSRBBnud1dDOCic+ZJKJYyMgMsPy2bqko+lZsfbFg+tTtsPyEK58MBq+5rpwQuXF4mDgeNGkAGLu7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f5qVKYJ0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jo0QjS0i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GNoO2026452;
	Mon, 3 Mar 2025 16:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zTZQtNSxfyAozGSyWW
	inXpS72CGacy384aIjfdZbec8=; b=f5qVKYJ0cOGOSrzxDZG9maw5EDS2XftiVZ
	J/5Xla2BJIkaWN/85d51V3Rc1ff1NlRg9Ui0AF2rMCpJoSNyGGU6tQgsrdjVppQw
	bTwf05KsCx4dA2IbdST6/s0AYqNpPSe8Ipt2m0Q6/LhTHUHNSPT4ziFf7QB6PFDo
	NtjkkIvIIMvaQCS3gRr/31TQtp6sv+cyfYwlgEDgnrKZaOmK6+HcYaFElVgWbJIR
	lc8OwauIIxpYEQITFBzr19uygP3Ocoh2+pdWuItjVVp4X/yFBdYjoiBCM1RlrJRC
	KH/Xa1MsZgm4x3tevy2OHhZcD0QTWXTg2wuWw5ixHUOqkz1gIA0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qb4yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 16:49:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523G3gGq039769;
	Mon, 3 Mar 2025 16:49:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8f93b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 16:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2lsutmT7fKIxVjdsi4q3K4pQh4Rr1L7OFcyWZI/uNRd0Hg41r89r7NwlGV7cbhOKRbxvXNNRqYs2veIJKurUbLcpPpElZTWlrvXRsLyxRR3LVraPdIvJ/bOm80u+dEEcmCudlCVmkDeW7CA/1Dm/qJ+KDQjeWyIPkdM0KnSO5v80/V/FEeuo5B2+aU5GHfRV524+QVCKchdwd8O870o41cEDbMef48V9Om/4pmi0kLp3zIUFhDnKaRoTy79cYTuX0jprvA5nwjMd5F4Tqk55R3xWHWvdVgtXEijPOk+F8uUpnzePSlb2uqeY5RO42ikU5Ke2OTWCukQAL1OSf9vXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTZQtNSxfyAozGSyWWinXpS72CGacy384aIjfdZbec8=;
 b=fEAvB2+bKdkoGzYgamNa7t/to94OcrJQgQfdt2hjp0bztG8Vt3/6xJn27L3KJrKW0Th29FUG3FNqew6yTlLkWHLu6FSt1DliV3THcRXB681d98snv2ov1t2UJ2398YrTgsLeHr7h/lor9JZTHSUsVptIQ89Uft7aOvwRVWDtllaZCHc8I4ZbsqCE9N1RTfRe5NFDhLDLqGn1Pvga5p/Zr/xXp+SbvBOrUwEU4VpP655nrM/bzI7/c7CIO5PGVL2wkD9NS55jcvs6Wyf9XlpCqR7NbTGKfjmCbajHBAlvsh2eI5Ffa38jdAHOmXppQYRjE3d/Ta609PSEXPmSPxzO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTZQtNSxfyAozGSyWWinXpS72CGacy384aIjfdZbec8=;
 b=Jo0QjS0iM2ak7TqlmjXCil3/X7t6G8DSzRCnds0XArMU8TSUWRWltITCQpUmjHZdNgnwyV2IaTxSFV1KNgSib8PFv5XEL5KBi7pZTsGkT5t91mxPVdRD4avFbQKbwZwiZPXqKTo2m0LTC3O+CqPb1OxdObQrE6LVy5Tp49Rc7y8=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH4PR10MB8193.namprd10.prod.outlook.com (2603:10b6:610:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 16:49:28 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:49:28 +0000
Date: Mon, 3 Mar 2025 16:49:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, jannh@google.com,
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
Subject: Re: [PATCH v8 7/7] selftest: test system mappings are sealed.
Message-ID: <055cc8e4-7461-493f-a1c4-e472c279dc5f@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-8-jeffxu@google.com>
 <d945816e-b01f-4a7c-b698-23ec356280f3@lucifer.local>
 <202503030843.553DA01@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503030843.553DA01@keescook>
X-ClientProxiedBy: LO4P123CA0461.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH4PR10MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ea1b26-a7a8-41f1-68d4-08dd5a735cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ANzEiLRzWLVh1JYLOqLQMwFF0mLnkqzxwCQGtx9sMNzy4yVcZMfIH6dIXizU?=
 =?us-ascii?Q?jyNyouPXF8UQehACbOsvu6YMf+UcLtvKV7tPo/I7tQW7Fvuuia06g+G1d3fQ?=
 =?us-ascii?Q?LAWMxeYxQjARgfodc4nuFWSchU8C80wq3JdJ+o1aWas+hXUuHXYa4bH0DBzj?=
 =?us-ascii?Q?+6okX8qoBgMt+R5ad7BBhcGIiED3SyyXB7C4vFH0dCVk5WMXqvBLjyB8YE1P?=
 =?us-ascii?Q?WTWFYLkEymPHv5aAP46Grb11q77pjgTwuNMXZL+R3UCApiCV/4toqGbOByWA?=
 =?us-ascii?Q?F96Wd6R1HI6dhY7goXmmC2XJmfSJkDZ0Wj+NWgizRK1Pt+GfPxxtLmquU5f7?=
 =?us-ascii?Q?dIBb5ETDNGly6UhZpcnlbfasMT6bLaMDC0v8ecKmUo5Mufnwj3005GKvXSJG?=
 =?us-ascii?Q?BLAeud+lImOQ3GoWpL3IdO2uOB3yyMjcf73ri7a7UgV+HQ567AGWyKzVCW6q?=
 =?us-ascii?Q?ZBHe6p4Qrx5dOm/0SpNVRs+29jjN6W0FbkCYJvuCaV/zIUSUoSz6mw3sH+7f?=
 =?us-ascii?Q?lzv1ObTUdE1v11kRjESnDbCdBhRUJG9m38fz+1GakFT0RYoy2XtjghN7GB1g?=
 =?us-ascii?Q?r4D8dTaL1V3g/4BWdMjZCUKQuR18mxw3BuZVbWHGukN719MuPCtcTXhGFA53?=
 =?us-ascii?Q?Sulo+FgCAfyn82YN9D11yCQ1ANWeg2TDUW/bNM6nJlP3saLT6J5TE958DyLR?=
 =?us-ascii?Q?v8BpqFbHZEO5aCKmTd2vy/kNd7M9Jgis8tPrYH8wjW4V0O0Tw7kPUOMBGZVI?=
 =?us-ascii?Q?Dr8ZI945Ug4nlC7kT8qyANmYqZhfxmMM5WPWbpFmLKIQ6yWS/GKT1vFf/ouo?=
 =?us-ascii?Q?s/zjNtR3lcfsviEMWjL5/hkxDmTaeXcODHJx9u0m2Q/jobRRiqZVa0/XfN6o?=
 =?us-ascii?Q?CUfxHSHMx9DVPIf/F/MmfWpwv1Wsx6ESyeaHi7bgMghy2jtHRv8ZRtohAkGl?=
 =?us-ascii?Q?JZi4/C4DldWGhfY/Nb2ssK9hMj7Dsk90w3m8i99tJHryCDb1yH2gi3xGPUYf?=
 =?us-ascii?Q?MrlwVPw4xWTR5yfH1Si6ezRDJPnc5tUBM8NRt4YlvwrYNT8rWZuTYYDKcTaL?=
 =?us-ascii?Q?9/+dKjLDVWyTZXh+X6DgGA8PH46Fcu6hUdkLwFDobzZQBm4lGDzFRGqV6362?=
 =?us-ascii?Q?UPM+Wm5Fx1RkiF/KQN+cEgz7uiPJFeWJxGAoGeQwqTRAzAnYrX4D/Q/Dkkfv?=
 =?us-ascii?Q?vq70nfVY1jAfLnxUIiplyvljOUcHzURy1LNUmId/CgSD4+wjPlNIjwF/9lo5?=
 =?us-ascii?Q?ecdoA+DDv6sCwj6kwVBRcKD7tGiC7U41qPQVyU8LZIBqxz3hstfdFf/LwmuB?=
 =?us-ascii?Q?hTPsNTaYGjec0ZTN/JvPNQyJYd4q0P5UnhopSFT1jS3b9zZCFbrT5AqE005N?=
 =?us-ascii?Q?yp5nxF/D9y/HBGkZtYeF64GMiVcG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6r7UggBs9Md1hG1T3mSB5pIKDJ5cAaFehIvZrq+v0gSgxfHnBw4Ie4dqnKg7?=
 =?us-ascii?Q?76dzKwGJuRKeOhmNuXVB41uSdddwfq7VkmiMYd3oiQiUlRISiZEkGJEZGGDK?=
 =?us-ascii?Q?zOhWx8InN9sF9mWGtIKnepxo98JmaMTQkUS5vPBj3J9Sb+x+jluDpw5Os5QD?=
 =?us-ascii?Q?AVnTvSCURbLkaaNu5FCPdONbGVrVMAs4YBthX4fuq+2kqML3FCajodrKCl84?=
 =?us-ascii?Q?l1S7I7foJijbwg0CYUbZNh3773SO3HoGW3vqM330Erf/SpliJ7HiTySE9Eyu?=
 =?us-ascii?Q?BffZQbHA6853HAFn7dpFz9jXIlgIHztRgnLjyo6k7bkYi21jx2MB5EqaKX9o?=
 =?us-ascii?Q?Cq3LB+wrOyGLtsY/PziW+hQ3/oa0zmeHoLqslneuESTqn/bEVN76cZN5Lxgu?=
 =?us-ascii?Q?9ABdJ/qMD8TRcONRjtjnmU2c6BKDSeDGz6VJ0bVfUX42wt3FmhGvOFmcxdaD?=
 =?us-ascii?Q?jeAvuSpbennuKZwIvZITPT0G7pyN862O7Jh89oWXKOMBUy6KtJ5IBaJkeCmM?=
 =?us-ascii?Q?KWC1ibcizEfaBJgftbmTDVGKkSEjA/CNHL46MqQ+CQGbz4Xj/DMByplcKLIZ?=
 =?us-ascii?Q?pP5Rk6nfSwtjdPajXxgrwN+hzgArsGVRLsPGyLZCpxOpuqPfN7B0T5yPF4H5?=
 =?us-ascii?Q?zBMAP/asfP6Iv9zW2kqchdRDOBHFYbKFxW9PXxamAmCj9ks4MraYkA253qWo?=
 =?us-ascii?Q?WbA4WODI+ffQ28+usXzoq17VsgFgJwz+bLAhoNPTA/VvbEKKcthCLJZy9JXD?=
 =?us-ascii?Q?3CXBURMuBD05fEKIzMglm66iRYIB6uKcza7Zq+TLuHUoAwM/4DxA+Gal5Trl?=
 =?us-ascii?Q?TSsRudJ1Ie+XVeVl3nqalFkUs7JbCKbMI3yrdXzcJf6D880km5TWjzhpS7hy?=
 =?us-ascii?Q?yoWC2LWpenTc+YSCEQzxTQEqXLhl5b71G0+KbBpPbfD/T2/sGY6kpfD3fMNh?=
 =?us-ascii?Q?JrilqitWOZqDzs+JNHa9jPZeYhXv3fCcaNv7b9fSH4HZDe8q8mw+NcrFDEEv?=
 =?us-ascii?Q?OlHZu8GkSZrWLcJBT4qVOIwtZi4I+bGiQjgJcZ+y0BK0Mx31CvHc7/ry0p03?=
 =?us-ascii?Q?wM69XFRkkcrPRDIIavro+vskXKes48IfAXQ2evWnSwZMQr03BiLruh+/uukB?=
 =?us-ascii?Q?vjTcM4bt58Q0m8yVx/HXdQHHO4PQuAe0eQ+YLtSwueqkATV93Udt0vqhtdMC?=
 =?us-ascii?Q?FK0Vewd8HWeb9k7kXmn0qrVfAPAo9TRMZiC4yQ78rZCS69fo/l+QvmBL3XCd?=
 =?us-ascii?Q?SjT/85v+PJ8V/44um0f9Rc0pjcp7k/YkW3UA/9WRMnZfcY56F3pSZg7d8Gbg?=
 =?us-ascii?Q?tFtY2ldnZTyPNNfZ1DoF0CPChDbfr7tfbep7BP5uBnyD3XQnKD3k2rgU2MAh?=
 =?us-ascii?Q?a0gRMeIV6oF7I4VNOaRogqPmgB7DSeyW641O/jyEUUtPIlNPJEJdouLW/qlB?=
 =?us-ascii?Q?mn09+SRJPo8X7zoG9ebi4MJ6xLC1oYZ0ERWV9/Hw0syqfoo92SCHsQk0xlgT?=
 =?us-ascii?Q?pKFSzPxC1MAaDtEWEUiK8iptKuW7Pj5xM+7SkVY0IfC7V3j/kW7wDFa9XnrK?=
 =?us-ascii?Q?s7zUBHVMFHUlhgTYInys73cxOY160aLI2JwBsIqJcF6/V+d34sE8+xPXTKH1?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u88Imle3Ge6VoBnIzlI77QofhbNi+y0KL1VzafF+PXSn9NcwIccTraqn5WTeAeD4ELXdoEtJnB9ExwMU08cKBHgRFriYIfZJWc+fxLKlaD/v+oFq9TwZDNajGaJwAUjLIrauZV5skx5FgUaN2EvMj5s1lr5bj7asozfuSiH8SiqwljvXQPfKOqKZczErMHIlPEj79chsZmHIO8HLa1XFKU4iMPEfKt77qxLeh4dYDpILswJQ8GLUXS85gGs4i0Ihtm8S5QuV5YSxYvzRwI+9P9lkSiSv9kM9xscvRbV4IFEd27jUMUir4Jm26SJCIzh8kCAZCfsbpkBd9oayH/g+LCjJoXpoWCDJHCAAUrVg03YOnSXF/n0nP+5sK5dsfhzGMfQCvbBaw+Nt+vSJxXGbrb4h436mFV4JlNyTwkOdQh97vQRwxM6lAJnpAS+gh5M8MrnMiYCESa3khmMMXm5XnjwEhdD0amsWwxs0DBpaEHs4KUyuEnGKKhWfnpSlP1QkR1IAQeJRL6MOR7fLYQg70GVRO/qpnlJl0sarcwGgl972jeFe42v1hcyV169ERIvNVvwg8jHnYEx0lh+nWshwgXKiF8IApTpPPI+omf/Kmdo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ea1b26-a7a8-41f1-68d4-08dd5a735cd3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:49:28.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPf9u3YvdPj9TIigmHntyns9RQR0UHwcCkPBXANN/KG2Q4CEIhZ2D34N1XWXJ9PJ8gF+yGfKDyI5wkyeZP6IjVwWkMScFSG/Ml8HSk3/aLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030128
X-Proofpoint-ORIG-GUID: olEsS6yVmaVLym6lmX9RJsPIa-3AhemE
X-Proofpoint-GUID: olEsS6yVmaVLym6lmX9RJsPIa-3AhemE

On Mon, Mar 03, 2025 at 08:47:13AM -0800, Kees Cook wrote:
> On Mon, Mar 03, 2025 at 12:08:49PM +0000, Lorenzo Stoakes wrote:
> >
> > On Mon, Mar 03, 2025 at 05:09:21AM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Add sysmap_is_sealed.c to test system mappings are sealed.
> > >
> > > Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> > > config file.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >
> > We do need to add this to the general selftests Makefile, but this code is
> > fine, so have a:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Congratulations! :) and thanks for addressing the issues that were raised,
> > appreciate your efforts on this.
> >
> > Maybe you could send a fix patch? As it's such a small fix.
> >
> > Cheers, Lorenzo
> >
> >
> > > ---
> > >  .../mseal_system_mappings/.gitignore          |   2 +
> > >  .../selftests/mseal_system_mappings/Makefile  |   6 +
> > >  .../selftests/mseal_system_mappings/config    |   1 +
> > >  .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++
> >
> > Can you add this to tools/testing/selftests/Makefile? I _think_ adding:
> >
> > TARGETS += mm
>
> You mean this, I think?
>
> TARGETS += mseal_system_mappings

Yeah just corrected my dumb mistake :) Indeed this is what I meant!

>
> (But while we're here, why is "mm" where it is in that Makefile?
> Everything else is alphabetical?)

Because mm is very special perhaps :P

>
> -Kees
>
> --
> Kees Cook

