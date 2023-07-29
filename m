Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373BB767A74
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 03:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjG2BE4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 21:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbjG2BDV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 21:03:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129333C33;
        Fri, 28 Jul 2023 18:02:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SLieeP009891;
        Sat, 29 Jul 2023 01:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+nv+EklKx6XmhgS4+lHPnfhxwiNkAtfvLm14etBEYDA=;
 b=BP70V/v+HyZOFX7rq4dJcWLqqJoAl8Hh66h3Jk9ShxLk2sNfLJODjLj/UqyVR7l84aIU
 kiLKmi6z1NVAy6wZmZsiPSElGc2+uxmhMk/dIzzFzc447QevBrU53ASq60+QUxKvEYSq
 oV5FCg7y3rCBR1vAzRAHofmN6gK6/i/lOwcov4JO5AqqCFNkwLCwzrL3Ej26ZEXIEfm/
 AOuhNq3Zac76JEn5MuVlzZxDHXCcoszz8Br9JxPr5tBt9qqzyPbYM3l0g1SRFnmdVYuz
 tUYwYK9p4/B7g6wJ5AeQrv6XIyUAacnYWBJSGW2PInHGyvX1jbxBAFL7nU+N+4Koypqc qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuvx01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 01:02:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SMZ9fC029647;
        Sat, 29 Jul 2023 01:02:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9ts0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 01:02:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDMgWprKaj+/DT2vb2Ktb+8/XbHEiPgli9zlg5LAvdZIubfV+sZ+0+GLBE1vTxcIN/WTr+GDVbvQmaen5+HP2boU1ixi5U1jwtkGXI8UjeHu9tcFZ9urzJEjI90drvKF47N5Rl7iwPn8WwU+upqrxzpFb5C/waSLb3ugf58hlYKng0nVy4esEdLlcZO9UWO4+AHeoCJR+pb/F+CLyXYXHJgE3GIfsM+5F1ujbRQ/gzUobCwn5HknfV1o3kqT/0DkprR9ZY9HmdeWoFMjrwpIrYKJ5rHGPE0Frfj/1QkXMkOJ8LAzLgL/u8DbZ6+E/60Q7FasDq6tKH7OXw+nwVqwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nv+EklKx6XmhgS4+lHPnfhxwiNkAtfvLm14etBEYDA=;
 b=ecxHJBkoxTvGRGuPPQauZn7H8K0fEdPhIrue4zQv/eYlUaN67XoOeIaIAvvNKB1Le2CFdZSCAjsFwMCQI5OrFsFCjNAgSM9Dh9BZToMvTRI1GqngX2wC3IaFeQQv2By4DMpDt5A8I79P2bMPw2OO9/U8rwcCgKUU8IPXtYAOVeXsPA3y+Aat+teSx7AUlX7hZsOdUTadcQmrVFNYGQuJSjI4uq1IhQNg8cWgISZ8k7ZFGA99yLVQ1UpYQeODFKP9SA66pp8/ISt1vwXJyQtNxmE+sQrVjhynhCdTN+DGEbjsQV3bWnIKblbplCdieL6SAzSbdfA1NpkaU8VjkMcnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nv+EklKx6XmhgS4+lHPnfhxwiNkAtfvLm14etBEYDA=;
 b=NGu7isdmBTcCFrqSAJmhB04xBAAJIh4hR0gjmjUk3iJ1R0mdOLDWV/k61XiT4qT6Fr+Ol87YlWSeA0vvv4vFx1HIvwCeDbzDAd73+Or/xNT2bj7XvE87u+J2fXNLQBxcvyvFrBQlOhJZAK8N2tDhRZKZVvjswYpjnyHFA1IpGoo=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by BLAPR10MB5313.namprd10.prod.outlook.com (2603:10b6:208:331::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Sat, 29 Jul
 2023 01:02:15 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 01:02:15 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 3/3] selftests:connector: Add root check and fix arg
 error paths to skip
Thread-Topic: [PATCH next 3/3] selftests:connector: Add root check and fix arg
 error paths to skip
Thread-Index: AQHZwXkWbDEKB7ogokq33I6v8z/kP6/PesIAgAAPagCAAAqwgIAAGwgAgAAFxYCAAAT4AIAAB1+AgAAD84CAAAWZgIAAFj8AgAADoQCAAAhBAA==
Date:   Sat, 29 Jul 2023 01:02:15 +0000
Message-ID: <8919E226-54D6-422B-AE06-EF07E7DC0715@oracle.com>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
 <0CB227BA-69FD-447F-BE73-2482A6998F7E@oracle.com>
 <5b283f3b-f176-7f19-5db0-1332a94a44be@linuxfoundation.org>
 <ec809279-cc41-7e0f-a567-29400b4c34a9@linuxfoundation.org>
 <16B47831-5F53-4BAF-B347-A1404D2ED264@oracle.com>
 <957be0e8-2bdf-80f4-92b7-3b9070c546b3@linuxfoundation.org>
 <3242346A-9B09-44F7-A062-8456F83372C7@oracle.com>
 <84048d13-9311-36f6-9eb4-8169952580d7@linuxfoundation.org>
 <AD8D16A6-63BB-4953-80BA-6410B29416D6@oracle.com>
 <8c92599f-fcb4-3aba-f367-17abd9b52451@linuxfoundation.org>
 <C3669401-536A-4CB0-80E0-5CCF2DCC36D3@oracle.com>
 <1e3d6e78-9b74-1da0-cb33-7caea5ce7a3a@linuxfoundation.org>
In-Reply-To: <1e3d6e78-9b74-1da0-cb33-7caea5ce7a3a@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|BLAPR10MB5313:EE_
x-ms-office365-filtering-correlation-id: 0bd4bba4-3d6a-4125-0a30-08db8fcf72f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DmhxFCeS6N4myTTUJUiQs7TDd5MA9Y15HhE3mFUU+BINFlNhVusmugZmeRJZl7SJRgs9f0hV0gLnBUytidd1Btz2rjf8NczhDy29IYSYXkgZt1iU+895MCB+AB26i0uZtGaewORJ7KfgYjZes0mKqXOYkFQnrxsQO5qX+Lkty8y2y87i9BkUKz1ksSUnntbirLCIOf2nVSN14hlcJE9eS93sWKlY9I4wTBtfh3bMlrrg/3R4+9JFZlfiTEWw8AMnyvZcgOMkgbOpb0o0AZp/W+2deqWXAVB3/uOJZzeV4sRmXgYN3bo9HEI9lDQM1t5wJHBUIq1lVucf6XpVboMgHcMBSQK3rJFJWWuun4i2YyUKcaJuoMMVkxMYj35Klpo/tmGWrTxQjX0P/Fty0EsFMGffLwUCO4aZnViEtoSXaVFIocdVbvV0mibIdWwJEyzDZsB5C2CNsFcMjPKn+sWK4uE3Pggb6fAXPkCchrCrWkA+jyNGEYvxOIYDWoVmCHQKS1lBFKSFyaa+jngTRVp6XD+0CitVYN6/ILcnMIq3lrDwQOPMKEkMBzNTcMe/Nz5FyOrRcKZkjiUhwHXZL2CmAT4PPPaZLwR63UIPmqVonS/AYlhtKkMegMaKpePuDTS7dIJJnFjJ053vFGv6H2KCiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199021)(38070700005)(91956017)(54906003)(478600001)(71200400001)(6486002)(86362001)(5660300002)(76116006)(66476007)(66556008)(64756008)(6916009)(66446008)(4326008)(66946007)(6512007)(316002)(33656002)(38100700002)(41300700001)(8936002)(8676002)(53546011)(6506007)(26005)(186003)(122000001)(83380400001)(36756003)(2616005)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUx2SkZqZ04yWXl0SFlBczZoNlJ5elI5SWNkSVdlTjRUaExMTW5DMjcveDVN?=
 =?utf-8?B?ck9RK1VjSjVMZXljbTBDQU5NOWlGMWdpK0s1NjlOUHVSWWl2OEJOSVArbjdL?=
 =?utf-8?B?TXlKaGFWaFNvWEFJbXg5QVdFdXJ2UzdXSG9KTjE2RUNMTHZvdG00cGlaOWlQ?=
 =?utf-8?B?aDk5YXV5MmxOKy9tem1pTm5rZkRCQWVjR0RjdXhVSGU4RHJRZ1cvV0Z0UmIx?=
 =?utf-8?B?ZXB6RGZyZHBvNEw3ZGlWMWM3b3AzQlNhaFJxS3UzRWdUSkdGVWlic25hb0g2?=
 =?utf-8?B?cWtPaUNQNGEvcStqTzdkbU9idXpkMVJSbkd1MTUxeHA2d2M5cmEzdnJQcGtW?=
 =?utf-8?B?VFA4dTVlU0VBUVowMGVleGlQbGhiK0loRDd6dFZKSWRyTzlxMXhpdW54WHl5?=
 =?utf-8?B?cHN1M1NUOEhrQThQQm51cE9RaTU2UmtLZVRQQXFCUmJQRnFxSzV2bEN3NEhY?=
 =?utf-8?B?ZmpyLytaRFhUNmJzVUdZa2ZNTEk3WHlVT1lLL3ovM1dGb25CQUx1N21GcWRU?=
 =?utf-8?B?bEMwd0VydGFKL1hwZFpGcU13Si9YWExjS2dDQjFaVjd1WFoxaXJsb2pua3A1?=
 =?utf-8?B?UUNBZ3czVWhsRGpiSlRIUjZERUJ5MHREeUFpZ3lwR0pWVkZPVXNpaVlNRVJn?=
 =?utf-8?B?UjhkbHNNcEVIY3E0clcvSnJ6anZKSHFtVWU4V3RoVTl2Ly8ybHdUOXdWMmt3?=
 =?utf-8?B?RmN4ZEdGczI1RDR5cThLSHN2V3hONW5YUUVOS2xhSExTTm1LeUg5dWZsem1R?=
 =?utf-8?B?dWk2QzZVWVEyS2E5QnQraEl4RTRQMFJtQTlIb3dZRk1JekpHUHZuNE5VdGlV?=
 =?utf-8?B?bnFOd3ltd2tBa2QrcTNDbDNSTnVhKzZPOHkraDEvT0ZHbVNJbXU0L3gzNlYw?=
 =?utf-8?B?R0J0dmpVSE95VkRtVm14Z0VIVnNZS3EwNHEyUVh0dk8waHlKc0VsRzhkWTJz?=
 =?utf-8?B?ZmhxazRGbENuOWJtd3Y4RVJYdG9vSFhQS0RBZGNJZXYyUXQ3eGp3UlFKOGx6?=
 =?utf-8?B?TFV5KzZpNWFyY2hGWHVQTERYZTdRU0lUcDFPamg5Ly96ZzV2Y3FGS05rem5M?=
 =?utf-8?B?ZE5EQWl2SlBzd3IrdTE4c3FEbGduMGJ2cnRzYzFKMVorVXZ1aytmZHYvWFB5?=
 =?utf-8?B?K3VQSHNXamlkRU85eit4NDZ5MTBkbWdrZUFQVEs4OWh0YlVXODIyNkNuUXRN?=
 =?utf-8?B?R054SGtETG9PM04wL1VUTzBKRzJRZWFxZkJHWHFHZkVmdXdZWVdTWmJ5c3Nu?=
 =?utf-8?B?V1ZFcGRwZkxVSEVnQm5IZVVRR0VzKzRnU0RvWEdsZkV6M0dTakI0Qnl3cnZh?=
 =?utf-8?B?cFk2TzhFZzZCVk9WYXp4NG1ONEE5SmlYdlB4QVl2MFM2aFE5clcrYjJ2MmxL?=
 =?utf-8?B?cnZKd3hKRktuVW5mYm9qN2t3Y1hFb2NoUTJDa3JpYnNYczhyUXlWb3RrOEVK?=
 =?utf-8?B?U2krSEJpTjZWRTc1emIzemRSM3d3R1BUTVlWWGhlcTNyWWhlNXhNa0NtdEF1?=
 =?utf-8?B?TnNZdElQV3NKSVYxZ1M4UldLQmYxaHJ0UXd0UGRCUUcvYjgvV09mSDAxWGJZ?=
 =?utf-8?B?aERHZ2hDUDFBYTFKZnNSSXpWazE1cHlVT2RxMmN4Mk5QbkxXdVdBMWxWRVQ5?=
 =?utf-8?B?aksvajFnOGtMUnVxSFZpQ25YYlQ3cXBvYSs1a1lrQzdMbHhmRnNuUUR2elRY?=
 =?utf-8?B?dENlVUZYUzlNZWRZVzRsbUY3TEdJZ2JWbHBoOXB6T0Y1cFYyMEF5ZzlqMkUx?=
 =?utf-8?B?ZGdpdEUxK2QwQW5NUXJTMER0NnVPWDJKd213Ym1jend3WkxSL1hVY1JTL1NM?=
 =?utf-8?B?Q2ZwVmdFRUxSTENReDJHY0NTcWRUSW5YNWlkSjN3a0F0UEdUUlRUc0NGMGdx?=
 =?utf-8?B?MkJVZ1ZiQTBiNm5ZdFVnUnNBN1F5RnZETkdobmVhYWIwUFlsM3hFeXM1bkN4?=
 =?utf-8?B?ZmlsVUp0dVpWZFU5aUFyTVQzV3BLWmV1N3JqNHg3NElKaVJFM3BkSFpZbEdY?=
 =?utf-8?B?OU1FakhWbmdBMkZOU1BJSno5MDV5UEtERkVUeStzYWFaVWg4S3lrMVAwbUtC?=
 =?utf-8?B?ZEpsVmJWWk1aS0E4eUxXeHNpMVoyMnIzMHA2N0JmbXQyVXJ1TGNPOTNBT21I?=
 =?utf-8?B?U0wzbEhRNVp5RlVtMHZxaWdnV2xQL3ovZEwvWFBZMGZVdHd3YTEyclVaU2pq?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF361D688BB5E4419581572010DB9915@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hK5yaIIh0FZLJFB3A31hj+b+Etp7a3hojfSwJxVvdAKKNX3OEbXq2ZhUlnr07DN3PDSjRAg7UrtzfSu2TcSkuJd3isiwTixCAteHtpDASkLEJwpthm/sI4fJiWAHT3k3rmy0w5i440ghnvx2X3jYX1GeelF/fHyUL5/jxl+XJzW1YaUvlda9OFeULEQg8NiJcU50xHn1sWKM8Wo41HY9bt04Y9LE8V1+QrAGYqKWnSHvjHybpwCCImQ2q6z2mtPuCUM3vDUfjfO77jGLd/lVxhfVnosS0YvkFmO+g0CDw3/0sSilRZ/3n3SmiF064qOkwgEsKDE4UNG/MX7UyxfW1N7xbR8ZQxalxq/n5hLfBXV6GJ3sgrtElvR9JxLuLpCDuuAaY905TGAnwE4YyTR79ULuzLzuPAiRp4WzxuXhKg7Sbmf2wVlo+r8ULGb7mYHt8TT7usyPVNASiuR5CMF0YELftJe+T0Nk7d6Hy9Z53q1PHro0bfJnoRROk/P2cFPT5skHJyG/imsPqDVoGMVJTHdPp7FJ5ZHYKvm9GYrx12qzWQlSAcDNHUFg/hYienYiCoW6hHT/j9eWUlGiggsKiMo9tEKvvjw63dIYOkf5RQiQqxabNeRk7X+OdafjerfMC06dHvo7UsrvmlmTvoqU2Enmn8rvw3WG/rXqtcHUI5M/guMFAw3+R45bcp63jTbiMg1I7XLSHEnIErLd1bQGulNB9gYkoCzCvldso5ZJpawn9ZUPzzQt58/6XQ0YzUioQl2u+jJBFJLsXSb2y74cvOLg/3IshPAbvtvmYsovfLnEaBBeXe6nRB5XZHQjM6mhGyoi6wA6CFmxTgJA9n4PG0cOHw9AQzbM4j63jNfGYtxti+bXTxe6G/x8UktmbpOt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd4bba4-3d6a-4125-0a30-08db8fcf72f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2023 01:02:15.2645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YocrFQbaC7JF1XrrnXw6CfL4vMAG8xtnltqga8VBq8wu0rJwZelz3QgXrPXif1D5UdNvOKki7q+xgRMIXcp6RUcH8mXms53aGv0ypCJdm5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307290007
X-Proofpoint-ORIG-GUID: NiPtP3yTJfrJEuDDIh6gAdEcP6ghjXLA
X-Proofpoint-GUID: NiPtP3yTJfrJEuDDIh6gAdEcP6ghjXLA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI4LCAyMDIzLCBhdCA1OjMyIFBNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIDcvMjgvMjMgMTg6MTksIEFuamFsaSBL
dWxrYXJuaSB3cm90ZToNCj4+PiBPbiBKdWwgMjgsIDIwMjMsIGF0IDQ6MDAgUE0sIFNodWFoIEto
YW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDcvMjgv
MjMgMTY6NDAsIEFuamFsaSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4+IE9uIEp1bCAyOCwgMjAyMywg
YXQgMzoyNSBQTSwgU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6
DQo+Pj4+PiANCj4+Pj4+IE9uIDcvMjgvMjMgMTU6NTksIEFuamFsaSBLdWxrYXJuaSB3cm90ZToN
Cj4+Pj4+Pj4gT24gSnVsIDI4LCAyMDIzLCBhdCAyOjQxIFBNLCBTaHVhaCBLaGFuIDxza2hhbkBs
aW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDcvMjgvMjMg
MTU6MjEsIEFuamFsaSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4+Pj4+PiBPbiBKdWwgMjgsIDIwMjMs
IGF0IDEyOjQ0IFBNLCBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90
ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiA3LzI4LzIzIDEzOjA2LCBTaHVhaCBLaGFuIHdy
b3RlOg0KPj4+Pj4+Pj4+PiBPbiA3LzI4LzIzIDEyOjEwLCBBbmphbGkgS3Vsa2Fybmkgd3JvdGU6
DQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+IE9uIEp1bCAyOCwgMjAy
MywgYXQgMTA6MjkgQU0sIFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdy
b3RlOg0KPj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+IHByb2NfZmlsdGVyIHRlc3QgcmVxdWly
ZXMgcm9vdCBwcml2aWxlZ2VzLiBBZGQgcm9vdCBwcml2aWxlZ2UgY2hlY2sNCj4+Pj4+Pj4+Pj4+
PiBhbmQgc2tpcCB0aGUgdGVzdC4gQWxzbyBmaXggYXJndW1lbnQgcGFyc2luZyBwYXRocyB0byBz
a2lwIGluIHRoZWlyDQo+Pj4+Pj4+Pj4+Pj4gZXJyb3IgbGVncy4NCj4+Pj4+Pj4+Pj4+PiANCj4+
Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRp
b24ub3JnPg0KPj4+Pj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4+Pj4+IHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jIHwgOSArKysrKysrLS0NCj4+Pj4+Pj4+Pj4+
PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5l
Y3Rvci9wcm9jX2ZpbHRlci5jDQo+Pj4+Pj4+Pj4+Pj4gaW5kZXggNGZlOGM2NzYzZmQ4Li43YjIw
ODFiOThlNWMgMTAwNjQ0DQo+Pj4+Pj4+Pj4+Pj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvY29ubmVjdG9yL3Byb2NfZmlsdGVyLmMNCj4+Pj4+Pj4+Pj4+PiArKysgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYw0KPj4+Pj4+Pj4+Pj4+IEBAIC0y
NDgsNyArMjQ4LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4+Pj4+Pj4+
Pj4+PiANCj4+Pj4+Pj4+Pj4+PiBpZiAoYXJnYyA+IDIpIHsNCj4+Pj4+Pj4+Pj4+PiBwcmludGYo
IkV4cGVjdGVkIDAoYXNzdW1lIG5vLWZpbHRlcikgb3IgMSBhcmd1bWVudCgtZilcbiIpOw0KPj4+
Pj4+Pj4+Pj4+IC0gZXhpdCgxKTsNCj4+Pj4+Pj4+Pj4+PiArIGV4aXQoS1NGVF9TS0lQKTsNCj4+
Pj4+Pj4+Pj4+PiB9DQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4gaWYgKGFyZ2MgPT0gMikg
ew0KPj4+Pj4+Pj4+Pj4+IEBAIC0yNTYsMTAgKzI1NiwxNSBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqYXJndltdKQ0KPj4+Pj4+Pj4+Pj4+IGZpbHRlciA9IDE7DQo+Pj4+Pj4+Pj4+Pj4gfSBl
bHNlIHsNCj4+Pj4+Pj4+Pj4+PiBwcmludGYoIlZhbGlkIG9wdGlvbiA6IC1mIChmb3IgZmlsdGVy
IGZlYXR1cmUpXG4iKTsNCj4+Pj4+Pj4+Pj4+PiAtIGV4aXQoMSk7DQo+Pj4+Pj4+Pj4+Pj4gKyBl
eGl0KEtTRlRfU0tJUCk7DQo+Pj4+Pj4+Pj4+Pj4gfQ0KPj4+Pj4+Pj4+Pj4+IH0NCj4+Pj4+Pj4+
Pj4+PiANCj4+Pj4+Pj4+Pj4+PiArIGlmIChnZXRldWlkKCkpIHsNCj4+Pj4+Pj4+Pj4+PiArIHBy
aW50ZigiQ29ubmVjdG9yIHRlc3QgcmVxdWlyZXMgcm9vdCBwcml2aWxlZ2VzLlxuIik7DQo+Pj4+
Pj4+Pj4+Pj4gKyBleGl0KEtTRlRfU0tJUCk7DQo+Pj4+Pj4+Pj4+Pj4gKyB9DQo+Pj4+Pj4+Pj4+
Pj4gKw0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBJIGFtIG5vdCBzdXJlIHdoeSB5b3UgaGF2
ZSBhZGRlZCB0aGlzIGNoZWNrPyBwcm9jX2ZpbHRlciBkb2VzIG5vdCBuZWVkIHJvb3QgcHJpdmls
ZWdlIHRvIHJ1bi4NCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBJdCBmYWlsZWQgZm9yIG1lIHdo
ZW4gSSByYW4gaXQgc2F5aW5nIGl0IHJlcXVpcmVzIHJvb3QgcHJpdmlsZWdlcy4NCj4+Pj4+Pj4+
Pj4gSSBoYWQgdG8gcnVuIGl0IGFzIHJvb3QuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gVGhlIGZv
bGxvd2luZyBpcyB3aGF0IEkgc2VlIHdoZW4gSSBydW4gdGhlIHRlc3QgYXMgbm9uLXJvb3QNCj4+
Pj4+Pj4+PiB1c2VyOg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IGJpbmQgZmFpbGVkOiBPcGVyYXRp
b24gbm90IHBlcm1pdHRlZA0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gWWVzLCB0aGF04oCZcyBleHBl
Y3RlZCBvbiBhIGtlcm5lbCB3aGljaCBkb2VzIG5vdCBoYXZlIHRoZSBrZXJuZWwgcGF0Y2hlcyBz
dWJtaXR0ZWQgd2l0aCB0aGlzIHNlbGZ0ZXN0IGluc3RhbGxlZCBvbiBpdC4NCj4+Pj4+Pj4+IFNv
IHRoaXMgY2hlY2sgZm9yIHJvb3QgbmVlZHMgdG8gYmUgcmVtb3ZlZC4NCj4+Pj4+Pj4gDQo+Pj4+
Pj4+IEkgd2lsbCBzZW5kIHYyIGZvciB0aGlzIHBhdGNoIHdpdGhvdXQgcm9vdCBjaGVjay4gSSBz
aG91bGQgaGF2ZQ0KPj4+Pj4+PiBzcGxpdCB0aGUgYXJndW1lbnQgZXJyb3IgcGF0aHMgYW5kIHJv
b3QgY2hlY2sgYW55d2F5Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSG93ZXZlciwgd2hhdCBpcyBzdHJh
bmdlIGlzIGlmIHRoZSB0ZXN0IHJ1biBieSByb290LCBiaW5kKCkgZG9lc24ndCBmYWlsLg0KPj4+
Pj4+PiBUaGlzIGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBtZSBiYXNlZCBvbiB3aGF0IHlvdSBzYWlk
IGFib3V0IGJpbmQoKSBmYWlscw0KPj4+Pj4+PiBpZiBrZXJuZWwgZG9lc24ndCBzdXBwb3J0IHRo
ZSBuZXcgZmVhdHVyZS4NCj4+Pj4+Pj4gDQo+Pj4+Pj4gSSBkaWRu4oCZdCBzYXkgdGhhdCAtIHBh
cnQgb2YgdGhlIGNoYW5nZXMgaW50cm9kdWNlZCBieSB0aGUgcGF0Y2hlcyBpcyB0byByZW1vdmUg
dGhlIHJvb3QgY2hlY2sgYW5kIGFkZCBzb21lIGZlYXR1cmVzIG9uIHRvcCBvZiBleGlzdGluZyBj
b2RlLg0KPj4+Pj4gDQo+Pj4+PiBPa2F5LiBTbyB3aGF0IHNob3VsZCBoYXBwZW4gaWYgYSByb290
IHVzZXIgcnVucyB0aGlzIHRlc3Qgb24gYSBrZXJuZWwNCj4+Pj4+IHRoYXQgZG9lc24ndCBoYXZl
IHRoZSBrZXJuZWwgcGF0Y2hlcyBzdWJtaXR0ZWQgd2l0aCB0aGlzIHNlbGZ0ZXN0DQo+Pj4+PiBp
bnN0YWxsZWQgb24gaXQ/DQo+Pj4+PiANCj4+Pj4gSXQgd2lsbCBkZWZhdWx0IHRvIHRoZSBiZWhh
dmlvciBwcmV2aW91cyB0byBteSBjaGFuZ2VzIC0gdGhhdCBpcyBpdCB3aWxsIHJlcG9ydCBhbGwg
ZXZlbnRzIGFzIG9wcG9zZWQgdG8gYSBzdWJzZXQgb2YgZXZlbnRzICh3aGljaCBpcyB0aGUgbmV3
IGZlYXR1cmUgYWRkZWQgYnkgbXkgY2hhbmdlKQ0KPj4+IA0KPj4+IE9rYXkuIFNvcnJ5IEkgYW0g
dW5hYmxlIHRvIGZvbGxvdyB0aGlzIGV4cGxhbmF0aW9uLiBUaGlzIHRlc3QgaGFzIGp1c3QNCj4+
PiBiZWVuIGFkZGVkIGluIGNvbW1pdCA3M2EyOTUzMWY0NWZlZDY0MjMxNDQwNTdkN2E4NDRhYWU0
NmRhZDlkDQo+PiBZZXMsIHRoZSB0ZXN0IGhhcyBiZWVuIGFkZGVkIGp1c3Qgbm93LCBidXQgaXQg
YWxzbyB0ZXN0cyBrZXJuZWxzIHByZXZpb3VzIHRvIHRoZSBuZXcgZmVhdHVyZSBhZGRpdGlvbi4g
U28gaXQgaXMgYWRkaW5nIGEgc2VsZnRlc3QgdG8ga2VybmVscyBwcmV2aW91cyB0byB0aGlzIGNv
bW1pdC4NCj4+IFRoYXQgaXMsIHRoZSBjb25uZWN0b3IgbW9kdWxlIGluIGtlcm5lbCAoYmVmb3Jl
IG15IGNoYW5nZXMpIHdhcyBzZW5kaW5nIHRvIGEgbGlzdGVuZXIgdXNlciBwcm9jZXNzIG1lc3Nh
Z2VzIGZvciBhbGwgcHJvY2VzcyBldmVudHMgLSBmb3JrLCBleGl0LCBleGVjIGV0Yy4gVGhpcyB3
YXMgb25seSBiZWluZyBkb25lIGlmIHRoZSB1c2VyIHByb2Nlc3Mgd2FzIHJ1biBhcyByb290Lg0K
Pj4gV2l0aCBteSBjaGFuZ2VzLCB3ZSBhZGQgZmlsdGVyaW5nIGJhc2VkIG9uIGFuIG9wdGlvbiBh
ZGRlZCBieSB1c2VyLCB3aGljaCBmaWx0ZXJzIGJhc2VkIG9uIGlucHV0IGFuZCBnaXZlcyBiYWNr
IHRvIHRoZSB1c2VyIG9ubHkgZm9yaywgb3Igb25seSBleGl0LCBvciBhIGNvbWJpbmF0aW9uIG9m
IHRob3NlLiBUaGlzIGlzIGEgbmV3IGZlYXR1cmUgYWRkZWQuIEluIGFkZGl0aW9uIHRvIHRoaXMg
ZmlsdGVyaW5nLCB3ZSBoYXZlIGFsc28gbWFkZSB0aGUgY2hhbmdlIHRvIGFsbG93IHVzZXIgcHJv
Y2VzcyB0byBiZSBub24tcm9vdCB3aGVuIHJlY2VpdmluZyB0aGVzZSBtZXNzYWdlcy4NCj4+PiAN
Cj4+PiBDYW4geW91IHBsZWFzZSBsb29rIGF0IHRoZSB1c2FnZSBmb3IgdGhpcyB0ZXN0Og0KPj4+
IA0KPj4+IC0gV2hhdCBzaG91bGQgaGFwcGVuIHdoZW4ga2VybmVsIHdpdGhvdXQgZmlsdGVyaW5n
IGlzIHJ1biBhcw0KPj4+IHJvb3Qgb3Igbm9uLXJvb3QNCj4+IEJ5IGtlcm5lbCB3aXRob3V0IGZp
bHRlcmluZyB5b3UgbWVhbiBhIGtlcm5lbCB3aXRob3V0IG15IHBhdGNoZXM/IEluIHRoYXQgY2Fz
ZSwgaXQgc2hvdWxkIHJ1biBvbmx5IGFzIHJvb3QgLSBub24tcm9vdCBzaG91bGQgZmFpbC4gSW4g
dGhpcyBjYXNlLCBpdCBmYWxscyBiYWNrIHRvIGRlZmF1bHQgYmVoYXZpb3IgYmVmb3JlIG15IGNo
YW5nZSwgd2hlcmUgbGlzdGVuZXIgdXNlciBwcm9jZXNzIGdldHMgYWxsIG1lc3NhZ2VzIHJlbGF0
ZWQgdG8gcHJvY2VzcyBldmVudHMuIEkgaGF2ZSBub3QgdGVzdGVkIHRoaXMgYSBsb3QsIEkgYW0g
d29ya2luZyBvbiB0ZXN0aW5nIHRoaXMgb24gYSBrZXJuZWwgd2l0aG91dCBteSBjaGFuZ2VzLg0K
PiANCj4gVGhlbiB5b3UgZGVmaW5pdGVseSBuZWVkIGJldHRlciBtZXNzYWdlcyB3aGVuIGJpbmQo
KSBmYWlscw0KPiBvbiBrZXJuZWxzIHdpdGhvdXQgdGhlIGZlYXR1cmUuIEl0IGhhcyB0byBiZSBj
bGVhciB0byB0aGUNCj4gdXNlciB3aHkgdGhlIHRlc3QgaXMgZXhpdGluZyB3aXRob3V0IHJ1bm5p
bmcuDQo+IA0KPiBTbyB0aGlzIGlzIHdoYXQgaXMgbmVlZGVkOg0KPiAtIENoZWNrIGlmIHRoZSB0
ZXN0IGNhbiBiZSBydW4gYXMgbm9uLXJvb3QgKHdoYXRldmVyIHRoYXQgbWVhbnMpDQo+IC0gSXQg
aXMgc3RpbGwgbm90IGNsZWFyIHRvIG1lIGlmIGJpbmQoKSBmYWlscyBkb2VzIHRoYXQgbWVhbiB0
aGUNCj4ga2VybmVsIGRvZXNuJ3QgZG9lc24ndCBzdXBwb3J0IHRoZSBuZXcgZmVhdHVyZS4NCj4g
DQo+IFNpbmNlIHRoaXMgdGVzdCBlc3NlbnRpYWxseSBiZWhhdmVzIGRpZmZlcmVudGx5IHdoZW4g
dGhlIGZlYXR1cmUNCj4gaXMgc3VwcG9ydGVkIHZzLiBub3QuIFNvIGl0IGhhcyB0byBiZWhhdmUg
Y29uc2lzdGVudGx5IHNvbWVob3cNCj4gY2hlY2tpbmcgZm9yIHRoZSBmZWF0dXJlIGFuZCByZXBv
cnQgY29ycmVjdGx5Lg0KDQpZZXMsIHRoYXQgaXMgaW50ZW50aW9uYWwuIFdoZW4gdGhlIGZlYXR1
cmUgaXMgc3VwcG9ydGVkLCB3ZSBhbGxvdyBub24tcm9vdCBhY2Nlc3MsIHdoaWNoIGlzIHBhcnQg
b2Ygd2hhdCB0aGUgZmVhdHVyZSBhZGRlZC4gSWYgbm90IHN1cHBvcnRlZCAob2xkZXIga2VybmVs
KSB0aGVuIG9ubHkgcm9vdCBhY2Nlc3MgYWxsb3dlZC4gU2luY2UgSSBhbSBzdXBwb3J0aW5nIGJv
dGggbW9kZXMgaW4gc2FtZSBwcm9ncmFtLCBpdCB3aWxsIGJlaGF2ZSBkaWZmZXJlbnRseS4NCg0K
PiANCj4gdGhhbmtzLA0KPiAtLSBTaHVhaA0KDQo=
