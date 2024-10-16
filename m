Return-Path: <linux-kselftest+bounces-19815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE1599FF11
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 05:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A891F223DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8AD1494DA;
	Wed, 16 Oct 2024 03:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WUuQKZn7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tI/S95uL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC821E3BA;
	Wed, 16 Oct 2024 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729047733; cv=fail; b=jUaWV51w6TDTEKj7LggAuuGO6dnEzEnuD41wk9okTdBD+KgvKDnNX+b3vR5KOsJHPX4WtgoZ5k5YP7i0uUJhdOyunWvqya8+NEvJMsiUx0QDaG5mz53TP86Il/K7qJ+RCgvXFtAqZRvPdN16lir2R6RSnrFCWj6cQfjevA9WN9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729047733; c=relaxed/simple;
	bh=lBY7ieawE7BCegdN+TlqXrxs9V31LFNrFPXNCskWGEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FwodPYCzqRZcHzshJLyauXf050OApe1gqYvKwFwQXXF74sr2zrvA3lHPc+iW+4Fq8aIlMGaNZJAg7OO/FrhWbC2rjDJwLVnppeTT/lyehtDsyj+s0iokD2udkpcaEl4LKxpLldCVQ3gOwrFvLwlAqVwYtQBDf3iOFLoZVssxvDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WUuQKZn7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tI/S95uL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G2MidV010601;
	Wed, 16 Oct 2024 03:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XwjjLJXYkJI1zjpaKWleyyUAjRERRNCfQN2glacwlC8=; b=
	WUuQKZn71z+BPiCLT0XfTXG4n+p7M0C9FWR3WU9iZYopAvCH1cbDFKzOTy/ItnMu
	PuuMuph2ax3Kxaa4fw3haA8KEHZIyuYkwyfRaNDxk4nwm1si76GM1phXSSJiFAox
	voIgJFaWqGYicb+r1EdWMjvjLRIwmcMglWzXWBys5jQhTDGVBBqn01pEa2CjpRjK
	tw/iMUu1HKjpZ3YRiiIqvi+EjyRP9YM9RA16AfmtV19aJ8g1jz81SnreFTieTACO
	ZT1qnhbBi9YgQunCp9kMG8ZpgTuDOO39fYLaKuoB/0c7w5dIgSAdmhp9HHBJI2wW
	iBlQQMdif/4cp8VlvQhF0w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcj9jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 03:01:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FNao6U026558;
	Wed, 16 Oct 2024 03:01:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjetc7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 03:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMkAMUiyVf2ZeCaRvOwp4k6cidsfZi7FBTXU3/hbXCr1ajHDlhotayWdbbzALY21Crv4NCK7Ko/8gMHKaFm+w6gcofQ6+wzx05w17rvgYQSGmJsSp4eZVbliiUFrlxVnTCv00QlMi1S6mispGSZPA2IWXvR5Vl8O+aeDhYyVhxGRKGxtSyaHmCkpmUMepJ2aK+PPZ9HwcZ2PAcTASR9VUgfhkWsesw8NwVbvLBZRDbdTbjnXXItSfOoh+Eet2JAKFfnI7lHp3TyT9pD2sRbcipjQQWE0c/MBS5pHHd5e0rFWk92n5pBACg827VEm+lMSKEKGnaCeojUxgkwwWRTg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwjjLJXYkJI1zjpaKWleyyUAjRERRNCfQN2glacwlC8=;
 b=WDcVljiEutsd+IdtrRUU/RPW47BTx3mOqt5wHvMYzWeD3HHakUo0FhOI1y4nwIOsp/gZ+s0JaKLRiN6j8iT0bLblncnTlsl04DAfkaPqT3sX5k56UWbMSqK6l0rwk/pm/OlZV9xPDJChflN8KWmg7TOAQhNk9aiY6t6cLExb0vOBjId9SV24hzMXk9miSQomXnjSVzHMo1PXgds8AI6m0tfgf81MR90d7uQJnUPD7SP9hw44jPuEFuH+jOOUereLYNRcW4h7TbWRAIyTUJbEqm7yf2U/sWee6YxrEjYA3LjpvVy6dAU0Di6mtwPh9X5lauJ2L7fLTh8Y0es7KQZ/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwjjLJXYkJI1zjpaKWleyyUAjRERRNCfQN2glacwlC8=;
 b=tI/S95uLWwSrEmFnlOI9VbtcHd//jRVw4yS4HY8QjRNmbiVOzW+JPKpx2aAzwg5kOOxRhLFxJjCY+UYwrjY/pWJJb1N0h1i4soDNxPFV3DHc5OKwwcsjj2m8XJquOiuSUfBkNPduqOSjvmq09v7BB3Hz9grGU5LW341b8zW+QuE=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 03:01:46 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%3]) with mapi id 15.20.8048.029; Wed, 16 Oct 2024
 03:01:46 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Liam Howlett <liam.howlett@oracle.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Pei Li
	<peili.io@oracle.com>
Subject: Re: [PATCH net-next v2 1/3] connector/cn_proc: Add hash table for
 threads
Thread-Topic: [PATCH net-next v2 1/3] connector/cn_proc: Add hash table for
 threads
Thread-Index: AQHbHyfsQT+aUyJkeE+6hWk/VeAOIrKIIc8AgACPTIA=
Date: Wed, 16 Oct 2024 03:01:46 +0000
Message-ID: <5794D6FD-DB28-4C22-BF11-2B9026F5317A@oracle.com>
References: <20241015173014.1083069-1-anjali.k.kulkarni@oracle.com>
 <20241015173014.1083069-2-anjali.k.kulkarni@oracle.com>
 <h2kgrfr3ru7qqq7xc5yplktyz26kr6x23fycfh5zzwq2cc4ai5@5alik4kqzoji>
In-Reply-To: <h2kgrfr3ru7qqq7xc5yplktyz26kr6x23fycfh5zzwq2cc4ai5@5alik4kqzoji>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|DS7PR10MB5006:EE_
x-ms-office365-filtering-correlation-id: 10ed3a24-f288-4143-606d-08dced8edee8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DApbkieC+v6lVadiEyC6bnWeVUmyoCK0b3hZI9SrYCSwcx73iTEEtC+Dz/wu?=
 =?us-ascii?Q?bam+S2dwh5IWIRSCJsPH2SIcO6Tqdb9D+Byoo524pMnW7iG+qC5qU2av9r+z?=
 =?us-ascii?Q?S+f/FZiczYLw/6Lhb+UkufacuVV299tXs3wxQnPDE3kySt4L6maQGy+QlL79?=
 =?us-ascii?Q?sWYqxMNpyXHAmDnTBDYfHIXrw3zi5Zt2Kvq6G6trF3Wd4YvRlJFbf3nto505?=
 =?us-ascii?Q?mvbXj3MN835+YzTtO+UU9rctZKX+3PYcbo8/PhwzTGPN/qvoSpHj93ga1dKD?=
 =?us-ascii?Q?g7A5rLU7RUVSbN2Hj/aFOGeY7hWdTFP22zR9H/nD1zdcEK3fMoz+syqTEUVq?=
 =?us-ascii?Q?VJefiAcp1LUyXfgbYS9CqBtb0sF8fvDbftC2ixr0sL96LkuIsTtZBy3snnS+?=
 =?us-ascii?Q?+vMyqW7Vk9ewGLuExTlIo9Zh7KwvtYCAOzgu8s1JLZOfRmiZ5IERU+PwxbDq?=
 =?us-ascii?Q?Y+ygx649/+TFXE19Ht3o2S0HiFCNYIHliigMaeYtdd8GBh4AJYZSkGMYUa1k?=
 =?us-ascii?Q?Q309Es0fDWm/SuVHzrHH/AYIDuhIboLCN8eI4rNAsqxnBLILj2rgp5+zf9GG?=
 =?us-ascii?Q?r+vkLbCGMLL0cpVQLELQQJo/IKFqOgp57LJcTzRP0WE8O0eWtfTQV8xQ6gGd?=
 =?us-ascii?Q?PQn2YumWL2f68GaD3a7GoiYpcT7Nn8uJdsCVZg/x81CnFEutOZ3qDxIgIE02?=
 =?us-ascii?Q?JaYk4WdWwH8iKaYTRV/PxaCDQ1E1OIkxgeSkjtW4u8eQhnvjaWhcklJHheMF?=
 =?us-ascii?Q?E6numBaD3C/UpAh1/SxMekSL1x19QvN8uKoExWsqCBXs6/nq6MWV9GK4yLtr?=
 =?us-ascii?Q?Uo/AiaJT5mgpxg07UusElmQ8RQ7XPnjWcdAIrQe5tYO2Ecc+lpGuL53Oo6km?=
 =?us-ascii?Q?4TFLP9ymh8l6JnI4WQpiYbANbAFZPPDBQldZZdCr6zktzgYXMsTCWoTf0r1p?=
 =?us-ascii?Q?FTW0BOsf2q6NkfK4W0M+SVgfEewy095YpFKfbPwye9mVU9tJ3uAFnBe78cFN?=
 =?us-ascii?Q?AswlLR/0FZo5X30Fp2VZTqB6LO6OViZQWmX1WZMJRZNcO0dpEEKol7EfGB43?=
 =?us-ascii?Q?BdgP3bSjUpWZqkEAEFLj5a4gonLiu6B3hmN6+j3oUL2oggCgXqjdMti3wMxn?=
 =?us-ascii?Q?ZYyLgt03Xvfl7bJsBAXD09JCo7N9t5UE6YIyo9VjmTdmLgcwSoNRMY5+H/Mn?=
 =?us-ascii?Q?Z9VpO0ViizKjtlcoPdnLfWbWCyiMjmAmoXg2ZeYYKbg+rdfQkNklg8MuroKK?=
 =?us-ascii?Q?Ea3enTlTgwAnHzrGaC/Ue24nIVGdADn6nfUme/Kc8cBm6UPZ1SXsNMKeYIvh?=
 =?us-ascii?Q?SsyrDNgsz0i1kkxinkPkW8KQnmwA2rg940qHXKzim5ErfA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KTTkC97PRSMwPezKoYmIBdiQkLZqprCA3xPknKQaV/5YFN7Qqo/xN1Lg+LkM?=
 =?us-ascii?Q?gAFv6QRhvthgtNmVQKY2R/v7eS+j4q/EfZivmbQiKRCG5zqp+I2hjF7ogFxl?=
 =?us-ascii?Q?rg42MrfhpRDkNWC8jDxq7cFQCfkVgMGlRiN8aW2TOeN7GGsZ0VGYEoScrEoO?=
 =?us-ascii?Q?oEX55eW0clS8Z6CUllZLFJVEc+Wov+k/EMCTVFI5/kd6HDYnbJyQNuWozFMk?=
 =?us-ascii?Q?RBs3haHKKPAqTvhyqOivj/2QZAkuNjqgpT6S+BF36HB3htxtZKNKoLcayK7v?=
 =?us-ascii?Q?bDjxMPIsmLnP1GTs6SYzQbSoyLsXDw3rD8uXBjuIAbHwBdwkLcrvTkI1xQij?=
 =?us-ascii?Q?oxd6aTQzBJ4mMKG6/mOPOxyiAlNTMwNM7mWLIuAKBFKdSiJc6Cuu4qTALb/v?=
 =?us-ascii?Q?y3EI2kx0hbSZcAdK1hnChglN/+pc8jJY0ZsRlc82O679u7SL4RzIj7hAuuxB?=
 =?us-ascii?Q?U81lIVVeN9EI9Leb1HlNDb+1tAKDFybVYtnLmpza39U78oF8f47ABbS42bS/?=
 =?us-ascii?Q?7tETeR92ExBCcthJDTb59itvfriMbr+PU86kln1TqpWrCeEMjI0c5r+X9nXi?=
 =?us-ascii?Q?tUMCXQsBn2looFLB6SAon54qvo1pxhoNZME01s6AjeMZgHiJ0jFaWP2hLXVE?=
 =?us-ascii?Q?lIx30XqQxFmU5ARgQuft/NzG0LCunx5GDZFaDtoq+6FFfdCuOuN/SRXOfUJt?=
 =?us-ascii?Q?L59f2cCVHoeQ5bJNPS9f0bLDtRMTKpPhaRnj7iCWDY+oZLVqvJRjYe6mH3nd?=
 =?us-ascii?Q?WmkeryDAnNtnAPSApjvdoqZtYaA7qad3yemGcro3NM0pAdSE/hO6t7GiGucU?=
 =?us-ascii?Q?iPgE38q40yjYC3XNugirnbvAUWjtUFclyW0NcDabsj1YoC6EcAcY1DhiaAy5?=
 =?us-ascii?Q?cLST7/bmZlPDU2vQoYg0WNEiRM7d3Rsyzv04JTKNvK9OKkdzdu3nerDqLpXp?=
 =?us-ascii?Q?y2IcZMJ0TdWyS/qyHfu8Ai8AAvaGYGD4Y82Wbc5UF+8Wa/d8OnI7peHRk5Ml?=
 =?us-ascii?Q?gX5tZlmMRtyMGhzp5B5S0SP6rdGKMZ+ccrhXLZIdE5C13LTck0Sz2TMClHtj?=
 =?us-ascii?Q?xrlPhBBiifUGLwSctn0/jCORHG4/ahwcacJoOXndp2uACho0kwHsHr2yifJ3?=
 =?us-ascii?Q?c10lJjsrq3kBofMhr2fWrEJ2Z/OSCY/QtR5NdtvNu8bo7MJC5UqLDQTz6AxB?=
 =?us-ascii?Q?HEyBzD8MI583HUpDKsz5SKG/uT2TZBb02mObbSnvevyckFrfgYnFu59E2ERu?=
 =?us-ascii?Q?mlHu1Gaa2Vh+06/WH5eTwovEpJxL0aBz6ttNs0LPXqRkkcZ8Nw4oOedmxZFQ?=
 =?us-ascii?Q?9ZYTdNoKgYiiehpgJw4DNdyUpn2sWtEaM5cmNdplDayXs16miokPabc60Spg?=
 =?us-ascii?Q?tKhaa2iVDlmnowx97VuUNvWcAQHVZagU36RzGbr5esraPJCPwjzGirYfsEwv?=
 =?us-ascii?Q?YVSX1xodEzGaj1XPD54BbcLjeeoC2UNBcnvRugBg/0zhmW/DpIglQVZJmnoE?=
 =?us-ascii?Q?B44bXfikziCM53hVxDw0xN9tBZzYuaveGqzk7s646yTWt0dW3LpKuj/+Ch/s?=
 =?us-ascii?Q?hf2CiJnw2bHPvDeHr0UHw+1fSvNwA7mAi1tJNbuBB8rernXkceWyHzHba7Jd?=
 =?us-ascii?Q?zEk7+/Rfew5+LRo8L5dhatepdbg2mtGbBEuFVWB54KLM?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <342FAFCA88F89C418139BDC90B6896D0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/OdrrG3OpQHrmJZXfcl47GWiB1jl/7zJhhIU/NE4TLhmY0on2snxMeFFNtaognk5f4J5NvgxkK8+qTRS0QPJyU8sdycEsBqBUaFuJMbCclAnzUjyh0bR4uJU8UCep/64u/5I3cxGIgTEbSX6PMZTB3oDE+fvpJ7EGy1v5i6w7VbsDl/MQHb7mCBK+qUB/bEy4psOEXfiW59uzdTcCYs8jyPUvZ1dabM8c/4vGiaGEWeQOHjeizaC2EUCT+ZSPkbPaL0SxUlOfGP5mD5dsKBlRPAJ53l6uqV0EJqX7AnFjDB5gV00UstrM9a9zmGyeroEyHAWAP2zA+cRyfn4W4ZTleWYdNHx5BDxWddIMlW/o5WdqZfuBnUxoT36odaI3EmM7ol4VZzKGlHxOTzgqEbEUP3ZLGuyu9ZdILhPsQc3e3u1AY0aCCYtVWvpVSXLVAqc+/oMpNj/gu50yigcX5fpOEtj07JwER8XA9aJC7JulJUnm5o5QQdMCM4Tv3vFrX2LILrMmRpLtp0cV2mMXcu/AQXKfgIL8sjBk/sMfF7yqkUoC53SkB8ewQqg+YwbJrbsjTm0EoDvO5cFEvffPEQuGunFyoQDS95QZ45UNLJ2I14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ed3a24-f288-4143-606d-08dced8edee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 03:01:46.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cet20eoFu94YKJPw0AtU9yT9x9eVn52lDeqgfBG0hAuHEtygNI/6QjPE6mOZZ6LN3th4F8e7Gh13QIw0o+XKh01lnb7BBovzANu8ArgUwHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_21,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160019
X-Proofpoint-GUID: -HCT0CBNAInqp9qJb_gkZRPC5Kvp5cH8
X-Proofpoint-ORIG-GUID: -HCT0CBNAInqp9qJb_gkZRPC5Kvp5cH8


[..snip..]

>> +void cn_hash_free_elem(struct uexit_pid_hnode *elem);
>> +int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t =
pid);
>> +int cn_hash_del_elem(struct cn_hash_dev *hdev, pid_t pid);
>> +__u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
>> +__u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid);
>> +
>=20
> Why are these here twice?  Am I missing something?
>=20

Do you mean to say cn_hash_del_elem() and cn_hash_del_get_exval() ?=20
I can combine those 2 to both delete and get the exit value.
The cn_hash_get_exval() has to be separate, as it only gets the exit code.

> It also seems like a lot of these can be static inline and removed
> completely from the header as they are not used externally.
>=20
>> +bool cn_table_empty(void);
>> +bool cn_hash_table_empty(struct cn_hash_dev *hdev);
>> +
>> #endif /* __CONNECTOR_H */
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index e6ee4258169a..a2339ae6208b 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1673,7 +1673,7 @@ extern struct pid *cad_pid;
>> #define PF_USED_MATH 0x00002000 /* If unset the fpu must be initialized =
before use */
>> #define PF_USER_WORKER 0x00004000 /* Kernel thread cloned from userspace=
 thread */
>> #define PF_NOFREEZE 0x00008000 /* This thread should not be frozen */
>> -#define PF__HOLE__00010000 0x00010000
>> +#define PF_EXIT_NOTIFY 0x00010000 /* This thread has sent an exit value=
 to be sent as a notification to listening processes */
>> #define PF_KSWAPD 0x00020000 /* I am kswapd */
>> #define PF_MEMALLOC_NOFS 0x00040000 /* All allocations inherit GFP_NOFS.=
 See memalloc_nfs_save() */
>> #define PF_MEMALLOC_NOIO 0x00080000 /* All allocations inherit GFP_NOIO.=
 See memalloc_noio_save() */
>> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
>> index 18e3745b86cd..2b12a24e4651 100644
>> --- a/include/uapi/linux/cn_proc.h
>> +++ b/include/uapi/linux/cn_proc.h
>> @@ -27,7 +27,8 @@
>>  */
>> enum proc_cn_mcast_op {
>> PROC_CN_MCAST_LISTEN =3D 1,
>> - PROC_CN_MCAST_IGNORE =3D 2
>> + PROC_CN_MCAST_IGNORE =3D 2,
>> + PROC_CN_MCAST_NOTIFY =3D 3
>> };
>>=20
>> #define PROC_EVENT_ALL (PROC_EVENT_FORK | PROC_EVENT_EXEC | PROC_EVENT_U=
ID |  \
>> @@ -65,6 +66,7 @@ enum proc_cn_event {
>> struct proc_input {
>> enum proc_cn_mcast_op mcast_op;
>> enum proc_cn_event event_type;
>> + __u32 uexit_code;
>> };
>>=20
>> static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
>> --=20
>> 2.46.0



