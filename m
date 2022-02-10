Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535C24B150B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 19:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbiBJSNm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 13:13:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiBJSNl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 13:13:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589AE391
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 10:13:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AGMDLv008871;
        Thu, 10 Feb 2022 18:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=G8pxliDDYaUbw6aFFGpUY5lEWh2wpTpxCvyuylmfLSA=;
 b=nDv7DfFC8v1IVb+CTE/fvz32E6iqklvvbAYB4SxFAaponYKftzpHSez+c7gUGOc9Y9fy
 1+1FbJlBmUPef2Lp9JmAcf5WVVaO5O5TL9AgVLhqCCkCjo+vpuRa8zprYem5hik3u07x
 Vbi5uedcHgwWKmwNog3XGIW51PVnwyy0kae4/CL5ZJGjVCCUgO7srO+LgFATUhpdCL2L
 m6/J0W6udqsIVrQ0ZyonmbSpQiDOuSZR2Tu/BTYWlJklyajDQIOUCEvTYrajZ+POKox+
 zuyw0tPYbq8TwJzBk5729X20DBKsyqxMA2sh9qPZtw+bCgKDxEGMia0nwH7G8ZXXejvn nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgs3p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 18:13:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AIBuEE132849;
        Thu, 10 Feb 2022 18:13:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3030.oracle.com with ESMTP id 3e1ec5hve3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 18:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ8m/SVP6ctehT74Nx1e4mVkuqBiGlCV7XBvISzGI4xv+HRhRcJ6x8SmBApPlHX7yLufledjoVQX2mk3Xx4yrB+pVebSFYZ20rTPiUkOGFepwsDIbyM1t7SdlQlELuM5ZUzrCsOloaS0rB6uGV1SDDukXCng8bNCE9YyE9bv2BHN6rvlN6amYXE4qU6XA8OP9UnEL1xN9RkE4KHJpy35oKFo7kIMdiYnQuQgJVc7EXy5r7L02CfNwhc0Ias4NQm3BMR66i6IUY10NKEB1wkb628YM/2P9w+Mh5cakNPwpMU8+Fe9n17B6irNmNkQ3oiN1rWlpmlL+7FVP6zpgYSFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8pxliDDYaUbw6aFFGpUY5lEWh2wpTpxCvyuylmfLSA=;
 b=Um33g1ZB4DAOpXygied2cng5X6Mbk4/WRxDONoxNmoh31pKWZzAbXip+d22kaGaTnES5EQ3+jz6TSbqDFdsyodHv6hMBOvlb9soLL7cg0dzpFimxH44Hw9+dEgoTuOOuDL1TFRThPsTpTsFVbY1Y6r55qDyernVgOsCCEfGqj4jcumcOkYK1SlCsa5ny7w7Pl1e2qgTEJqTOhX8oAvtlq7i0mh1Yu82CIpIJpsqkT4HcgWbv4yficPsRFpuk2Zxdoh4vLcIhvG0zNO8Lqidf3037KTJdDAJKuP7iJFM+UgGdsAyhGaMyQ8zkVuWyBDIXfW6RUaKbjZqgG91MKk/ifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8pxliDDYaUbw6aFFGpUY5lEWh2wpTpxCvyuylmfLSA=;
 b=jcYvBKo2TBCllIhgDe2Tz/fSQmPkz9tGV+HQJnVeFGIxeqamPK86kc7I4yiW/DOqSjcv97d4DQu4G/ljDltvDVjziIv6Q21YoAtuK046vZlC7gMNXOp1gmPswKldVc3lUkc9WG8UfF8dJzGp/bF9s7OCRIn8SkQrKQJWO3pcaYM=
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14)
 by BL0PR10MB3425.namprd10.prod.outlook.com (2603:10b6:208:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Thu, 10 Feb
 2022 18:13:36 +0000
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::cd19:e61e:1ee2:8216]) by SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::cd19:e61e:1ee2:8216%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 18:13:36 +0000
From:   Sherry Yang <sherry.yang@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
Thread-Topic: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
Thread-Index: AQHYGHEQ35nm0s4Mz0ebe3Zft+MEpayAw6qAgAF3UoCAAAsBAIAAB4AAgArQGACAAAVfgA==
Date:   Thu, 10 Feb 2022 18:13:36 +0000
Message-ID: <15D28555-F2F9-4331-9B77-1AE2B0526C50@oracle.com>
References: <20220202201118.13933-1-sherry.yang@oracle.com>
 <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
 <A8A651FC-37A5-4716-888B-F141E7241003@oracle.com>
 <202202031219.792E9AFF@keescook>
 <C340461A-6FD2-440A-8EFC-D7E85BF48DB5@oracle.com>
 <b908237b-63ad-ff10-8d89-540d2cab842e@linuxfoundation.org>
In-Reply-To: <b908237b-63ad-ff10-8d89-540d2cab842e@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d6e100a-041a-41a2-6293-08d9ecc10e6a
x-ms-traffictypediagnostic: BL0PR10MB3425:EE_
x-microsoft-antispam-prvs: <BL0PR10MB3425FD47F4312E7E88B7E3819B2F9@BL0PR10MB3425.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pi10k4JFZ+F3qMyOeHBpTC9foTPUEVISepe9cxfTHYg6N6tLgNeNqXIskT1p2caS8A/B0Q12Z3cNOiVfrjIvhOzkUMCKJJ+j8dExGS4+ha34gWlBudCRjiPTmIbq6rfuB1BIs9D+d19je1BG7kWnYkn7CHIYF7prLD39AixNakLlgxgfG9k9DJQMqijl18KL2kDd5e+P2CR1MpCJ5XFQeh9YjDQoKet6GpxZ9CKpEmyCN6onBQb19Wun4yCuvsk5XukFMWlHJCZN90qCzMVszPthO1OsCiFoYs+ffu8J40K5I2an1H8GxTSvbLwXNhUksnNJaR3oqTUv3wjb60ixbSiHA0Hslv/6E6eQZv+GFqVLRuJqXGdLBn7jfT4EQg7eHZrOOYcvai9t2Ei/6N4P4bzecdcvsMBBWox9BXfXvmUM3t89FCn8MnjDxKu+KYdVpgCCmaDRJm0TkrZ1K4cO3LNOgbj4Jqq02gAzB/Z6uEFUCqsmsJgggLY9IS2sLmp1TmXmXarxmV4DG8FgaQOAo4X4cHPlvVp2qXqOd+3xtVf8oID4EEAyaT4pEGBr8BRj8Rn01BNAaooo+S/JUX3eRb9Lprpe/zjMCxKNV0qcFlQ8WPPXXaiMdTATZrXeRfReADEJSy2mff5K0KDNa5UwC8vuIgm1e9npvIfxDvWz9zffLvrdt7OdTRiFYlAXQhlQJ0cnSKaO7Dg/MSVwvE4h48Q6Wc5WzEy5+zMD57eIDgY7Q8vr9yVMZ9CnbXvJw5C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4718.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(44832011)(6486002)(38070700005)(66946007)(66476007)(6916009)(76116006)(64756008)(508600001)(38100700002)(8936002)(66446008)(91956017)(558084003)(66556008)(36756003)(5660300002)(6506007)(4326008)(6512007)(2906002)(8676002)(83380400001)(86362001)(71200400001)(122000001)(33656002)(54906003)(186003)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kTh7IHT20bxlq1Ga//q09bsri/tewALGB76ro2CkyciRYLD++qHAeuL5NSS+?=
 =?us-ascii?Q?JXQAEEDsjR0XjZxMfHNIrDu5RXErncFvtLnJQii8xIIGlfVOAOPQRQft7uVk?=
 =?us-ascii?Q?BPJFo0jSsoIK4JWKzbGJOmK97mA2HK9gM4xuxhZPiJNuK5PSrOB3GFBsowgJ?=
 =?us-ascii?Q?flkJBkQQ7+/6dzUcL51r/LFA60eeLy01Q75JHGAG0u9K4BebAUKJ1yGV0YlS?=
 =?us-ascii?Q?0Dpa5T1rxOr2iQmwyNX/t+F9Lv0fh9uWSJeXnwynerG8Fc+Et1HcQiiv/aj7?=
 =?us-ascii?Q?byBUzkWtAYUMY40Ft/QqpAOrrkheMRrQsq0Lwyi+ZqLBnDmq44JiHcW/XjTo?=
 =?us-ascii?Q?x99JHUk/rDa+3N9SJCS8TzvjyPaHBrhS2TaKbhQBg3P7hTzI1g09aN5/73V+?=
 =?us-ascii?Q?QywsON9Aaokd8u7Q7K7LDwOd1bs6EbwNaN2m9mf2Pfcd4ntSKZkkDAdJbVck?=
 =?us-ascii?Q?awU3yf5nhlophKtbHph7bQs+ECmTCbfsF8Kkr30Y1JUZ/8vHr/z7IQ7tAis+?=
 =?us-ascii?Q?JZjlcjQN1G9eNIZIngjSnIUbp58UIQd+8Ik37+CdHmLud2WT0E2Na0C5MZBe?=
 =?us-ascii?Q?zwbTaID/f99bB2f8ZDnL2CPuWSbm6i7qPJKX6/fwmLTRgtRXesBpnla3xbK/?=
 =?us-ascii?Q?6TdFAgjdOEIGCwT2Y4FTmU8zgXz5YeY3QOVsV82EFX74hNF2QigfN3ufucXC?=
 =?us-ascii?Q?XJ90Fp8e6D52bWo9RWso6FIOv4zsfFcVChhVPqCNi6i//ufAaz9SbdBvoVvI?=
 =?us-ascii?Q?+ywIilqlpJypW21bpca6HQ5Xf7gYiSk7kbJuNwwpJlDRZR4hqtPAUPMRp+nH?=
 =?us-ascii?Q?ZDqPio8t/4SLAToJtdZw1BnKPveLu4A4JH10x5AU3hUISvd93iEaxjWTCsa7?=
 =?us-ascii?Q?ENFmFg+FeuMSIKZKmYZ1k+0BbaKlKUgqrrogE/MLh6bQVxwPT8pDbAgLwtqK?=
 =?us-ascii?Q?ufptH2gVbn8Frml/NX3rTyNLMP9GTnDCE9IHMv6/FxQ0ySHT+sWVbl8wrEFt?=
 =?us-ascii?Q?AenFmOj8WBl7w6B1uBWiJit8cYRQFx1Uz8PMZyMOyXh1mgK7OhbuKlPOy/+D?=
 =?us-ascii?Q?If3nXPydH7rBl+6bniSG2E2qiLjPMr2kGNnqjYaSvbGNtuXYuz4UfncFQYFw?=
 =?us-ascii?Q?PfHOQYrycTCiMCY17xNvzCGzzhJjOFuFTeV7hisdTwfohwenR+kPBxQPB4m+?=
 =?us-ascii?Q?apzLIvVibzvkLKoZZyU/RNNvqzCGYlju97A0+jrx0GzppAno8PZOPExx6enZ?=
 =?us-ascii?Q?mgK3AmF2x7S1APPezdFfGvMaBih/oWada6/8Wzb0XrSOXIBQANfDIc2BjDhc?=
 =?us-ascii?Q?J6UkGxAy+GfyIfVV89sDnr/wLwEOA4ckewlcTcFmBtN+zAWJkXnKY6gdDxLm?=
 =?us-ascii?Q?erkzdwnrtsKp6sGCShasaUAGX4IkFVCbgvkLSH931IRKlkPiJAhY2lnqJZ/o?=
 =?us-ascii?Q?MgeDSAh3IlmZGTE1cjLRshRIjEW2in9HgQ8JJs2jpU+PVz5jCPeJL8v4o2kl?=
 =?us-ascii?Q?SozP8D7Q3/Gah3mVgessnExpOD0RPLreKTCxzPClAXQJNB4qRZ9z7EuD3UKs?=
 =?us-ascii?Q?HMRNJOGrvAZD3+OApJoOFXH8EAhKNbA4X1YEAaK/bxVA1rGNeO9RoYvWe4dD?=
 =?us-ascii?Q?wJAqr152yVYzF6RP5TsKAM6alasxvXT+tr31k6LCZUbqv1f7+DrGuO/TpcwZ?=
 =?us-ascii?Q?09uIaA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDBDB1CFBF5AA04EAAC369938F1CEDF5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4718.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6e100a-041a-41a2-6293-08d9ecc10e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 18:13:36.3238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKYLgwhF1DkbIZk9SH6OHGXm5MJsiNgaXDKXzADjQsG5QVbnOY7bIwg0zKuH/jDUZvBu1gbhBun6TSr3l7UGkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100096
X-Proofpoint-GUID: JKfWh3dPbdpqgnpxbAWvJzRdAQKA5hO6
X-Proofpoint-ORIG-GUID: JKfWh3dPbdpqgnpxbAWvJzRdAQKA5hO6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Sounds like -i works - I will queue this up for Linux 5.17-rc5.

Yeah, -I works, but just with some compiler warnings.

If this is acceptable, do I need to send V2 patch with -I?

Sherry

