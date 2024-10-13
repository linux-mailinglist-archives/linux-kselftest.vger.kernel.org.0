Return-Path: <linux-kselftest+bounces-19609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AAA99B818
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 05:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9771F233C7
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 03:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEC784037;
	Sun, 13 Oct 2024 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oCMUViYE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YdyL635D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C6231CB0;
	Sun, 13 Oct 2024 03:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728788818; cv=fail; b=FAx94s64wW9NAm8naiaOP40JGFwJmlfI9rqBBx3NTImfS0szTKNJX/U7nm5XcrUMr3bEFiCu3Ce9jQel5nQ9YnGQVGRixhg0lfaS3kla1dBbUX6SIO/7WR5c13mvUBxd7GA24J1pxh1eP2fJOpkjbRdrDvYAwyM3C+a8VyG3D1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728788818; c=relaxed/simple;
	bh=lTVUICPX7/ZZw9XD2ytwCA/mIOYvABP4k228Z3wZQ04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XABTaz+myHTMctq2RLcNiTYHPCgzyql2f2g0lv6cI6kkFw52oYUkGGfE3kQmZ7xeUodEPh0lOsScKLxcPQaqc0qtYa4rVDGo8XQ59vnFcQ0eJqaR/kiyC58mkV6FTI7VoA/fgovy6MHq6uAXVNNudNHYHqpG1Sqt74K5uM45ugI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oCMUViYE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YdyL635D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49CMU2Hm025027;
	Sun, 13 Oct 2024 03:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+sDHO4WYmbJb3HLpBrpn7Zd56iyJOrsBlJM0e1Jnjqg=; b=
	oCMUViYEKNA+3dAzC5HVyUrLzvkqJkO0HI7RORzm4/oFgWYu5D2eB6evLBEiZDra
	VnVgy3pJl1Q4lkj9vZl7KFbQQz1DXGb8lxH79PCFTHW4j92L6wziWsgfsoAU/wML
	Y+JVWvwJq1ZIVLFFR+AcyvrBXrzLzuelXUBH3sgc3FqxDdKgg5Uhc+xenra5JQ3s
	FgdocmPwZ6ffyKuV7ffWimzBtZ2sMAyrkX8EJ46woS/BOyOxs2dPqs8Vw1dn95vZ
	M3gFHMe7ou68xsiSMNWA9R04yz9joj+Mv5YQdzFmFY02LSJLtwB3SlxxiP4X6myE
	K6Dq3nRC8JTHziC3ujzx6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5c8rrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Oct 2024 03:06:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49D00VVm026407;
	Sun, 13 Oct 2024 03:06:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj4ubmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Oct 2024 03:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atin85CwTC/dyaZttiLwa0V3I/9u3JnC6b613zHDFIiLHnbJTrJTewgTvI8ESVfweRPbtKzZZYZ2GEayohoX7M+Z/1EPc1sgARR3kkrPnuv9yyhxitDRJS3QfljYVbIkQgthL4McTnAj8+mp5A+nVbiNbXGf54fp8TUsqfdeAMNtzFQ9RlZ8r3UoEYL7ekiv5Ymo/ArByB8fhgWhYPuPcKYBrVWp90zAGyLtWwmm0uuWg9blSB4WgABSBGa9KHgz76SKMejPV2ToYiZfBH5sC/jpLogca6bVwcdPiCYkT9VqzD32o+aNFrBlppP7iLm95kjRcvmlPlU4a4T+I2iU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sDHO4WYmbJb3HLpBrpn7Zd56iyJOrsBlJM0e1Jnjqg=;
 b=mryqp8slEXoACSZjVchQXlBV5t2FCDRQ2v5czKQv11gRldvhnqkhOFQTb4d2K3a2bW2R3UvaCjJYUMhfEg9pxp09NC6k8MtFqsJ+KRzfm9azfgGN1RW5lbGvJSnNm0b3ZIcANvPXgHMbYfkr0/0TnaXqB6KIHtUbKrGx4kgl9KdnZgiqfkvHewv6MGn50lsI6GmWKi63UBYqgWyV5FgFScqzJNiTPC8hzGv1Rz8SQFGdiU1UoV58iAAN/5v5xte8op7xk/OV7cvClAiCxyYuW/6a3Sh1awnW/UNmGb/5t0QOu/WP+hUAw5o3ypQnsYfLZ4IFrGgEuLpYT/Ts/J6HKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sDHO4WYmbJb3HLpBrpn7Zd56iyJOrsBlJM0e1Jnjqg=;
 b=YdyL635DsD2v4M3UmAVbZ+dExyLkyO4P/JfYxmZ10iRFMl1uKV2GkuiLJdJcPHN5kfN4Bs3fvfd7AESWrKYtVFu1igjtLHdLNdIQY0DizzvSnr58rAb9j6SqAkMdLRF8PGMBNo53ZBFngqtb5/ju1nRsTtrMrYUDAu0ig64zKzk=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by CH0PR10MB5163.namprd10.prod.outlook.com (2603:10b6:610:dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Sun, 13 Oct
 2024 03:06:25 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 03:06:25 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett
	<liam.howlett@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org"
	<peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vschneid@redhat.com"
	<vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Pei Li <peili.io@oracle.com>
Subject: Re: [PATCH net-next 2/3] connector/cn_proc: Kunit tests for threads
 hash table
Thread-Topic: [PATCH net-next 2/3] connector/cn_proc: Kunit tests for threads
 hash table
Thread-Index: AQHbHEAVqGOqdb5T3kuEtg51UAM0V7KC3pKAgAEig0o=
Date: Sun, 13 Oct 2024 03:06:25 +0000
Message-ID:
 <BY5PR10MB412952802D000809683AD840C47B2@BY5PR10MB4129.namprd10.prod.outlook.com>
References: <20241012004532.2071738-1-anjali.k.kulkarni@oracle.com>
 <20241012004532.2071738-3-anjali.k.kulkarni@oracle.com>
 <20241012094557.GB77519@kernel.org>
In-Reply-To: <20241012094557.GB77519@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|CH0PR10MB5163:EE_
x-ms-office365-filtering-correlation-id: 31dd7ab0-5713-4cd5-3afd-08dceb340619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8HPVtTkpfwtSH+WycapJpepyARQEbu9eI6oTVW5XERhMWZiyrXM4PyOvcD?=
 =?iso-8859-1?Q?V0nHYMgMUu6avCVUcFQTR5JZIxKFqP1o+rucGaHgYoPCO18Gyf0S26rt28?=
 =?iso-8859-1?Q?EsgADjamSqiEplVxqB/NBwd4tCDlT6O0pPsGc71De4bxomO+yP5+kW1fAs?=
 =?iso-8859-1?Q?F3NRST87ziuA63r5TXsG9E0s0+Y4vA0vPjFbLryBTxFVW3h5ehtJr5WLEG?=
 =?iso-8859-1?Q?pp6beNkJd7P07LlBW7zsM6NkcI4PiN6PmaQtaiAjREYLmNR1UALLsrYqpT?=
 =?iso-8859-1?Q?vyL+rIhOvkLoUc3gz9CsBb5qqupoLRfAkvr5HsTq+joZCZGxRTiLys9nri?=
 =?iso-8859-1?Q?UIB2YCpnNmTvacbkg7T61FSEJoiqprhZRUIWvDKOPMrI0p4JXnf+1s4+q2?=
 =?iso-8859-1?Q?wb6FiIOvcHrmcQMUPrnIldmyFBikxQf9+ARTEs7veCQwCkjFW2xMHWQVnf?=
 =?iso-8859-1?Q?SEmGQ7907aB2acXU9aHn80HLdir7vn0QlgLbIdAPFMsnVPhmqp8XfCZHo0?=
 =?iso-8859-1?Q?vmvFZrl4RxSWzfko0UUhPTmETvNQBCJv7CMkOIpkyWYnq7HVMM2Hgp8QFC?=
 =?iso-8859-1?Q?jG7DjAl8GQYl+0q6HbX7ETFtp6NnPUwuvTt+nH4t4ojnNUzzRSznv3z0tv?=
 =?iso-8859-1?Q?RwrFkh0ymmQ+qYB70ffaw2pAPG0Fpo+8ynXOt41mQ8l046xW5Hd/pD7o97?=
 =?iso-8859-1?Q?P+tqr/wrKSdR6n8eW/SYIS0jwIa8888KlJ80p3JIzgr+pHgEMpIGc0NIok?=
 =?iso-8859-1?Q?KgLdZHJf/+6mk4XmfL1ltCK7Oow4tYD/n221CVG9qQbWL0KHRDmH+7ALeM?=
 =?iso-8859-1?Q?y67OTVS0gUfV0k8o5KO/LCDsfN8sDAT3KMNixJ5aM3QeCGDRM8lOxiOKLK?=
 =?iso-8859-1?Q?jz1hK2yBmb4OOT+U1AKfcz17L0XJXS4Cnsq6hbRPX+rhGZlrbbsnmJH93b?=
 =?iso-8859-1?Q?y03llGQiNdVby3cIz6QNifXt1e/ILFWiGPQeSb7xCvf2VJeygWfirjXoOt?=
 =?iso-8859-1?Q?oE0M2BXeoNaOd4qrIHwSpjsl1WoBQnCz+JHBMDtpRdmSmQnksc2n4z86xs?=
 =?iso-8859-1?Q?tJkUJrcubEqbibhfnlSRzExvSf7nwWWrRkSRHjKEB3muF84i21hWpvTmRr?=
 =?iso-8859-1?Q?+eltMMVcyP4h/3MsgPq+LGyG734gPPjK7p7+gwKIpRU/dR7mkcHj3Cr9qZ?=
 =?iso-8859-1?Q?SfkWqswnyboE7kcapvmb37LstsE/Own9iIbztpSILvZzRcgbq/UiWdyOv/?=
 =?iso-8859-1?Q?RTeGRkFOtHtfNBmS6Hr9AQu7DUNIv+/fkID6z0lLIFagafx1DK/jbgEL/4?=
 =?iso-8859-1?Q?1Sq7vjb788HW78XJDL87y8usyiFkkinEsBqBOEP2WWxtGCyIs7qBJp0xyJ?=
 =?iso-8859-1?Q?Jgn7k9/52KE5UsMUIqiqEr8j461skGEA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sfsBVXlMLcQHFe+dVNBGdOiGwG/yzsrkeinP6oRL2ownpsWQf1T9GHvCop?=
 =?iso-8859-1?Q?xNBFp/NiS3SY3C6tMj8cBkRgaJSJmd/0u38V+SUe7VsF1dNUbrgLm3n2h4?=
 =?iso-8859-1?Q?LC5m/DJk5WA1OaSgwYLnJyXRBozh9rAdLGEW6O2b4odigmfX+IHZAPlRU4?=
 =?iso-8859-1?Q?RCQgyp/eQRVeLrp+nLMnbSRy3F9mplC6wR6s2eWMJrqo53Wy/lSQodBavk?=
 =?iso-8859-1?Q?jQ0BBPpVkqVH9Gb/N51QlEFoWhNhF8mA6sakQs719n8sQNu1TEsYlGxUuA?=
 =?iso-8859-1?Q?+BToXCNcr/kaL/LrPIkoy4tNjgSjvadJoj6f+sC74l2UFFA6e8+ece2n9b?=
 =?iso-8859-1?Q?RCwz6t7LrtZZKG2KH23tFSkAIgNGF4hgb/xa7gEJrwxiaqbufM83UTFmXM?=
 =?iso-8859-1?Q?sCFmEyBq2Z0OrJVMvN0TxjJu9UFdr5Y3tl6YTGQZWbISPGKHwvZTfkXftC?=
 =?iso-8859-1?Q?K3eBMx69GOrdPcO/CH+uXHecPiUOY+lgTiv2KuXXVo0zZIjIsc/1DseqdG?=
 =?iso-8859-1?Q?CEsrWfGkIZDkEEnPbpegxdx78ixRaJkQBq32egCIimqVPslGBeWFVCKVoA?=
 =?iso-8859-1?Q?cIvNP4+pUYVBBx9gM3FvSRpDdAT1TD9i56CKlkq4lkjV/2pEsRYT3gxWzl?=
 =?iso-8859-1?Q?BRBhENKem32GgPMznFYNBjNcGXShmeVSUb3sY1RV++6I6HMRn7NLlxV41L?=
 =?iso-8859-1?Q?1RyuTLQ0wVaYXIo5KiSoKHWBolnnKoVpl1TBibJlzNZTBdfS6Ei8VM3nqa?=
 =?iso-8859-1?Q?Sbi2YSjP6eP6hOjzJEH/FZaJRLAXny9jy5nDzgH4kTPNYSq9CVuBwCiXTb?=
 =?iso-8859-1?Q?iUg8iEuQjSyj9Sx8Cn+mLDaWIN4Ehx/HGFCtSVRcU5X43BLi8k6lCYDP6j?=
 =?iso-8859-1?Q?0toHK7V6n9dQxQa3V30IgcQ+g3VmAOBd4V7SDZZscXGnSV10Bbj0MLfPSO?=
 =?iso-8859-1?Q?KhuoDOdLZfCM425btFZimJE+zKoiiJ54WkK1dlZ4UsKVeeD4/QzlnmrWUg?=
 =?iso-8859-1?Q?17k95+zjf7meh4rf2OGOviV8NXvBDDD7NFxpsfalbvFBlBLBN2A6mtOGGu?=
 =?iso-8859-1?Q?5DEoCuY1IrMG5zIC6DUy9KJF30xZtNCl2TfEZYhGukCjwFgB5ycAb+WyLA?=
 =?iso-8859-1?Q?ILv5EXd9qopGtTZ3+7LjMT3J0LLB4ReMHD2ZJkwN29t4q0DJv/6vxxfdB8?=
 =?iso-8859-1?Q?iFkRWmoFypsYOzkTPCndEH5EEsQ9+CqP26nNjUJ/LUXhG8QUSb9w5+PmRk?=
 =?iso-8859-1?Q?KuDVNi916s4uXxA0vb1DjWUmQm4ShVZE93YblUAbi1Y1LCLghZBh0Yu8ST?=
 =?iso-8859-1?Q?3x36yc6LaZK43CiDvtwTMstL65+BzrZnkZgdfVrfVzzW04uaVSlK6t/dvk?=
 =?iso-8859-1?Q?4+BeJ4K+4jGEetWLATwxvjMfHu5W/KT4nRkGPSK3vmF5eAcznPjpxLqrAh?=
 =?iso-8859-1?Q?2FS7gbW0Qv488VTwF/Opc/ALVts8iafzuz/zolQSwKiJ/HopyCx0qbxTZu?=
 =?iso-8859-1?Q?UqVr1QxtfdtKl5bj3YOFTw9orxcybik96OeOS3O/W3LLfyOQLCIh7kGpXt?=
 =?iso-8859-1?Q?I6ajjZORlj03lBvuGcEQiw4v7y/2HBkaWGkc1cuUquaxGZFNwbWtnowvFg?=
 =?iso-8859-1?Q?L4Sd/oY/HBdtVW6o92peADwhixufzw54Jy7fm6MkPBpR8qGEOvA/EO9WnC?=
 =?iso-8859-1?Q?swXk1sfX0ixNW0oFPyo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CR7CwTNPoW9jQIJF6MdtEYnzueBsXlwwYUywZ2Hdxer/aU2Nt3oH+N+66aJLDjEXVgHD1N6/wj1pQANkVOe9pSgNapuV4p59Xy4zi4CS/2H0F1FaZW6q+z8PndJkFeV84J71qBp6jlEIrlUTQbCQx0KcY1Sz9DvP2kBUxr8TkoyY0YcrnzxVmcZZLiV5Ht03q0yZErqS5d4hl4LWLrqT2OHy2BZ3GCbX+9f27RqpLGHW74Aa+QRt02blid2WOHCx+U270Z8Fk507YyrIGgvpNwbSpGp1auCiBYb5FTe6w3yuQOIKfDErerhwjvtmqBG15uj/BICDrw/2JodaTghV+4QjUBOvXVhvyNk6bAcjjUJCslDyjslHh8S8p64XmoB+4CQF6brQGSBRWugXMdgYLwYjB12kemg5vwN8WHNXTaaWs0dJl8r03APZfTJGA7UdVosxoQspqKqLlgbq7Z/X/0eKxqvXc7ELl0NiZn6ArWHTUHuWXx4fUIAhblbFSIaPWCw707zne5YTBu45jfbV2GySA5I/dcUSIVVf0RaTj2cnIsMnQycDu+nVHX4V5SaAyX5bVtdZys5iOq3cQKUdLSDiERib+h9TzdUyWEZYrxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dd7ab0-5713-4cd5-3afd-08dceb340619
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2024 03:06:25.2590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPNBvYZtU/8Dwe5gv9cdIzLuOQdDgE4r5jrPJvBWeaZMcHnBk/N0DZDud0lUUFQJlzKf0HbZcz2j6I8xs3sPS/69U1IPdmgI/veEnkiH1tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-13_02,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410130020
X-Proofpoint-ORIG-GUID: 2ROX3reG0cCGr49UxV4gK2ZLuwZm_H1k
X-Proofpoint-GUID: 2ROX3reG0cCGr49UxV4gK2ZLuwZm_H1k

=0A=
=0A=
________________________________________=0A=
From: Simon Horman <horms@kernel.org>=0A=
Sent: Saturday, October 12, 2024 2:45 AM=0A=
To: Anjali Kulkarni=0A=
Cc: davem@davemloft.net; Liam Howlett; edumazet@google.com; kuba@kernel.org=
; pabeni@redhat.com; mingo@redhat.com; peterz@infradead.org; juri.lelli@red=
hat.com; vincent.guittot@linaro.org; dietmar.eggemann@arm.com; rostedt@good=
mis.org; bsegall@google.com; mgorman@suse.de; vschneid@redhat.com; jiri@res=
nulli.us; linux-kernel@vger.kernel.org; netdev@vger.kernel.org; akpm@linux-=
foundation.org; shuah@kernel.org; linux-kselftest@vger.kernel.org; Pei Li=
=0A=
Subject: Re: [PATCH net-next 2/3] connector/cn_proc: Kunit tests for thread=
s hash table=0A=
=0A=
On Fri, Oct 11, 2024 at 05:45:31PM -0700, Anjali Kulkarni wrote:=0A=
> Kunit tests to test hash table add, delete, duplicate add and delete.=0A=
> Add following configs and compile kernel code:=0A=
>=0A=
> CONFIG_CONNECTOR=3Dy=0A=
> CONFIG_PROC_EVENTS=3Dy=0A=
> CONFIG_NET=3Dy=0A=
> CONFIG_KUNIT=3Dm/y=0A=
> CONFIG_CN_HASH_KUNIT_TEST=3Dm/y=0A=
>=0A=
> To run kunit tests:=0A=
> sudo modprobe cn_hash_test=0A=
>=0A=
> Output of kunit tests and hash table contents are displayed in=0A=
> /var/log/messages (at KERN_DEBUG level).=0A=
>=0A=
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>=0A=
=0A=
...=0A=
=0A=
> index 000000000000..2687492864ed=0A=
> --- /dev/null=0A=
> +++ b/lib/cn_hash_test.c=0A=
> @@ -0,0 +1,167 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * KUnit test for the connector threads hashtable code.=0A=
> + *=0A=
> + * Copyright (c) 2024 Oracle and/or its affiliates.=0A=
> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>=0A=
> + */=0A=
> +#include <kunit/test.h>=0A=
> +=0A=
> +#include "cn_hash_test.h"=0A=
> +=0A=
> +#define ARR_SIZE     4=0A=
> +#define HASH_TABLE_LEN       1024=0A=
> +=0A=
> +struct add_data {=0A=
> +     pid_t pid;=0A=
> +     int exit_val;=0A=
> +     int key;=0A=
> +};=0A=
> +=0A=
> +struct add_data adata[ARR_SIZE];=0A=
> +int key_display[HASH_TABLE_LEN];=0A=
=0A=
Hi Anjali,=0A=
=0A=
adata and key_display seem to only be used within this file.=0A=
Probably they should be static.=0A=
=0A=
Anjali> Thanks! Yes, will do both changes you have suggested and send in ne=
w revision.=0A=
=0A=
Anjali=0A=
=0A=
...=0A=

