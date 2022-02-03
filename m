Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1034A8F5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Feb 2022 21:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiBCUr7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 15:47:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33954 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231897AbiBCUrF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 15:47:05 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213K430b019741;
        Thu, 3 Feb 2022 20:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Jf8mBozN8jmbq1W8j6k5RtnF3rzPkEEjUWzENltIvJw=;
 b=BRlHQf8ziVlcqFvCDgNa8mRdgza863tJtl0NoD843X5aRqVAhLfKCFN7yBPhrOi8HdVs
 0qcgFMwv+kYSk3BK/63cLvn95zubGSx/MSq/DiPbLx7TeOd7/xH5JeFNxzRYRJelteXF
 KpmLmXndplb1vfIECfRIqkL9uJ3pqnC4CjVnhcbOkSAx/5xzd4e5TalF4r1mMNRRIruM
 LaRbVVORkDx2WZtSVKGl1GHYGJRd74G4EU7ulUbR2e7DgAM3SiZaHJ6cKSiRtG5qqjOz
 SrxuW1z1N8+UUOfw738D/+vIa4+7s2JLRsM1VV3fWpwbMeUCzXxvlAW0eDFqBYbfnyz8 cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfw8uv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 20:47:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213KfoQq038325;
        Thu, 3 Feb 2022 20:47:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3030.oracle.com with ESMTP id 3dvumm9m25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 20:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKxiSctcNc78ZhOUYqdeAQbbu1UKO5wEOubw3kBmkHiRFkc6sS6RYKXn5IP84jVrAbTt05fIgA/MlfoBxtwIzr1gs43SWOASFMUZNfjHa7CegJYyMgD6c149O3iI/3sToFouYfUfLx6dU+bXn2yU9Z1NNX0sGWhyjs1TKEgUpBiDuVmWzB0C80o0JsphwAPu47dRlymXeaL6YZScy8WaKpv8Ics8KQHJDhQYScnooIVkXEfk5Mpxqm/rNqadbucqBDntXi7Of3UdeVldjKL6dHf+wE4tyCdSpfs8CIua660BkRPoiwX9zPom9jPsanGb0xBmDRJ0zef9NuNCz5d72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf8mBozN8jmbq1W8j6k5RtnF3rzPkEEjUWzENltIvJw=;
 b=Urc6rciEt/MjwIwar8QnNparJ2MIDmWauqrho6v0xzdhZs01LcVcx0b9Dq/ZkyKMF5xTG4ckYnlNcZBrZ2ZqjSHFyaI0j4rWnX1CyT7xzS213dCpJTilCWVZUOZIOSkrlKd9m37oLwzk3Wd8/M79kBk63TPDyNtFK82uemBjN7myV1B0HA3Z2GKkFKpHLZ6iTotQdfu4mDgcVI4oZave/bzD0CwHd/gZMN6uWbsFwBeUNGKrzyFkjGeF7gtqjUm1pk6AxhU9nk2JFi/PVD12tK04kwUgK0C81pMpaGmAUEHiGvadRZ1peEp7iHXnhnMTPdf65kOpfG9C7WUa2v2IlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf8mBozN8jmbq1W8j6k5RtnF3rzPkEEjUWzENltIvJw=;
 b=MHdpeSs02qX2fK2n2r775SXF2QPugoyU6B9zRGDlD6+ZZmDC+XahmOHKMwn+Qjo58YusZ4smKOaY1WNiJq+lC1eRUZjXiiH8G+XTvsmAb3wuQvyw/liDpPN+nLO5ZekgXASlu9d/sfgbl0gpO0tbKylLO+/c9tH3vUsKcNxyQWY=
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14)
 by DM6PR10MB3225.namprd10.prod.outlook.com (2603:10b6:5:1a2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 20:46:59 +0000
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::cd19:e61e:1ee2:8216]) by SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::cd19:e61e:1ee2:8216%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 20:46:59 +0000
From:   Sherry Yang <sherry.yang@oracle.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
Thread-Topic: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
Thread-Index: AQHYGHEQ35nm0s4Mz0ebe3Zft+MEpayAw6qAgAF3UoCAAAsBAIAAB4AA
Date:   Thu, 3 Feb 2022 20:46:59 +0000
Message-ID: <C340461A-6FD2-440A-8EFC-D7E85BF48DB5@oracle.com>
References: <20220202201118.13933-1-sherry.yang@oracle.com>
 <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
 <A8A651FC-37A5-4716-888B-F141E7241003@oracle.com>
 <202202031219.792E9AFF@keescook>
In-Reply-To: <202202031219.792E9AFF@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9160a5d8-112c-47f7-966f-08d9e7565319
x-ms-traffictypediagnostic: DM6PR10MB3225:EE_
x-microsoft-antispam-prvs: <DM6PR10MB32257384D10785F7520A8D639B289@DM6PR10MB3225.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvoW4aMDAjvHgT6VmqfsSODXyKdKhOOE/CBAA9StS6zoLoxsYXs1qjyixasyNcLIMhiPKJEiKfR6KPSeIH7dIcChVckHnMPlxMBQiyWN5GTf6izNjgBoalVJd35LGDirWHxm7YcMVZw62Nw+YQy5oJmruPrSv7NrHiKoGZ2rIDSkezadSq6uhzK0/2ZaIeVPmDuVEC3BUnBv/qcNkQ0P2r2dE+FnpVMkA6ZKia1KUZCFdJbbOflh29hw/E56fg6feRhQsEcKaQI2y9ksiAXQVemNv7tap9tAFJUenCj227AZlLhJQsz++X54RU8yrj3zWSv1x3JNCV5UxCz3FCa2SNMlfFNFE0TKGAtlvD8Ln8bu+WnBRXFwsChDuwYVI3469kJbhSQHSN6LpPaCwMXT7pH1cmOB0D7BpXd5Hv9DC3Q2DSSUvc3d7aIUHBSj9ey2RRAMjEcGqlZb99Z8OdcS/nM3dnzwjjlwimJP18ajibV8DJzLq8/zj4B9/IA4h86Qkf6UOD+b2eR9alaOFeTwZFE3OzQ9Q1n2aWj6WlDNlG0Sfvh3pRZRBRixoxJpcqLR7LkiYD73ZiJ9LU5+cIDrfRtoqCZuNjE9vetjQAZPkc5TBlK9xejE79p8THM3z9T3Jvt83TnhEPYTsi6liT7NwxLry2tWAoxcToacvotJ+qw4ZkHMdxs/nDguJv4YBLf4xgBSeLrwTwg1sWnb39e8cf36NxsqtSEHrBX09JzsJcNX+DR4WQA0Dyjky8iho6rwzEi0BRX9cdvkXCNu4z3IW4vJcnPVNhZRwTZvGiGtS4HztH7kCboW4nn6xVsmfJAve/zSPF7+uobCq4Wkjy8Z5cmIfYhWS7ynlZKm4b6mVGg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4718.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(26005)(186003)(71200400001)(2616005)(38070700005)(38100700002)(86362001)(122000001)(316002)(64756008)(966005)(66476007)(508600001)(91956017)(6486002)(66556008)(76116006)(66946007)(4326008)(6916009)(54906003)(8936002)(8676002)(36756003)(2906002)(33656002)(53546011)(6512007)(6506007)(66446008)(5660300002)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U01mQ2ZBWVRJeEtnS3BlYVExSXR6MVBJWldkcTRJVnJtMHh4OXlJcXR6bmt4?=
 =?utf-8?B?MUp6K3orYTVML3pNYysyQmNpYXpvM0pvMzJxQVh0VGh4dzNvdURUVmw3dHBI?=
 =?utf-8?B?SlNKQ0V1d2ZacGlQVkxYNUtUblhITFFSQVQ0OXhjN3ZYWUJveFA2T2NTK1BQ?=
 =?utf-8?B?Q0ljV25hczZLUVh3Zkt5Q1ZybCtWTmtXc2tkdktZSXpMbzRiM1ZrMS9RTmgz?=
 =?utf-8?B?WDNzNVVORFF3Z0pVQit4cXdydmJWd2tpZWhPM1RIZUtpWWtJbDgzdWt1cVpv?=
 =?utf-8?B?QVJnWngrR1ZsSVBIa0VkN2Riam9GTlIvMC9XSExqbXd0YkJTV1lYYkUyaytq?=
 =?utf-8?B?dW53U1llcWlQaVBNa2orcGMwbVEzaTdHQ0dGditTc3k3eTlSTVJTMFpvNjdn?=
 =?utf-8?B?RlhUbVhBWDRZOHhFUExrOHh4amo5ZUVqSUVGOG4vdWdxVUw3SDR0alJpeW1h?=
 =?utf-8?B?eWg4WGxDM2pXbW1kT2N3bytCejJDRXVyYU5nS0d2VWE1YmNlcFhPN2JtU2sy?=
 =?utf-8?B?ODV5WjI2YTRLWk11OWpiNWpUK3I3Q0N1YmpNa1JjSWZvajRFdXk4SU9odHlF?=
 =?utf-8?B?WUNyRkpDSjhVcTdGNERzUzBXRzB4RFVqNmFpWEVqVDVwNW1PY0RPSWhVSkg4?=
 =?utf-8?B?NTVONEpQeXR5WSszemZ0Q3pCL0lDT1BNcmNnTzljS0ltNjJJcjVUd0lOVkZi?=
 =?utf-8?B?RmhTeUhkcnZVNXpRT1doNXpxNFJQVnRuWGJkR09lallPM1J2VzdKKzE5cU9r?=
 =?utf-8?B?bW45NDhtTmVLWFpnWHYwZ0xwZHNxVmlGbHJVNXlNS3NWU05VcGEzYy8yMTNQ?=
 =?utf-8?B?MDhROEdnalJYL3RZVHVlSUJwMnN3eUcwZm0rK2hBRjMyT3MxYk5XcEIrQUMw?=
 =?utf-8?B?anZ2MlNTalhxVUpPMXBWQ1UyS01TaGVTcEpqdmFwdmlwdzN0L1BocFpTbE9D?=
 =?utf-8?B?aWU1UndITEpIdjFncTVWeURiN1FjMVk5RlI1eE1MZ2NrRXl0c0ZBYmNmTFV3?=
 =?utf-8?B?RXlEOVhndWoweHU1V1d5dWJOTnBhYXUwK1M5V1Q3ODlEUW51TW56QlAwSFhM?=
 =?utf-8?B?U0tqSkJsd1Z1MWNlVXZMMUJ3ZVc2cDJDYUdNNFpYdUJPYUFwakd3RDBYUkdh?=
 =?utf-8?B?K3NEV3lGMVlRY3RwWHZJQUhFUGQyYnNEQUcyUml5Rys4cTUyQ0kxSzRxbHRm?=
 =?utf-8?B?U3BzeHNrY3RDN1BxY3BjcVo4SWVLYUo3UGpQL3dUNitaeEowNStVc1dXMXlG?=
 =?utf-8?B?NEJkME1QakVDNDViWmcyVS9aZTB5a2hpcWgxOHdkVW04bnRFdm8wdmNzNGRS?=
 =?utf-8?B?aURqVGJVZEJRdnFFeFZTbDN4b1B1MHBFdDFmaHVPcFpSTWtjQzY2ZkgyLzlm?=
 =?utf-8?B?bXV2ZWc2ZVQ4VTlrQmc5VXA5NmNLd2NIc05TcDB1VTdGZHhPVFlmNHNOQ2lG?=
 =?utf-8?B?K0hmODBqZGpyQ2JmWXRCcjBONDV1SE9uZE5Sd2poQm95NktnTnZZbC9LdUdC?=
 =?utf-8?B?dTBGZWhjRVNkWFpuSXIycWxuSGpyMGRQVlNQd29VNnlEUHg2OSt1UmJUSGRV?=
 =?utf-8?B?ekZzTm1oUUpoaEgvNHo4ZDhYRFJhUjE3bWFmSEtMYnVuUU43MVdOeVBYNFdr?=
 =?utf-8?B?WFRBengzZmFvdGRJbWh0Mlp3dW1hSjZRMTNkUUNUMUFpeXlEUFpTZlltN3R0?=
 =?utf-8?B?VThLdXZ3NnhuVWpBOEFqN21vUmF5TkN3ZGVYa1hvMmNYME5RLzN1Um9DZVYy?=
 =?utf-8?B?WXZjNW0wOTZoakxHN2cyZHJWZVBYMkpQRGF2N3JBRXJxak9ETVVXS1ZSNnRK?=
 =?utf-8?B?eXl2L2V3dDExeHN5WXBNRHBHL2pSQlJ0ejFmZEJKSGZqUktDQ1hvNktDYXoy?=
 =?utf-8?B?QWVDV0dVVnpNUUIrOE42RGo5SnZzWk96ME10R2pIVjZ1T0ZPL3E2UmNWTlJP?=
 =?utf-8?B?Q3U0ZWJETWJKZ1VvWWdBNUFCNlh0OG9OcHdpbUV5V2RCNm0xbUFtT2tHSkx1?=
 =?utf-8?B?Zzl5Um9PQUQxa29ZcUtRZlQzMmJabW5UU2JoQXBaaTlFQUNRcVhLbTJ2S3lk?=
 =?utf-8?B?dC9KZ2RzZTRmbU5Qc2lEdUMxbFZteWl4bUMyRFcram1jMVY1QUFjdGZRVjlB?=
 =?utf-8?B?MmZqdjN4aVBJREVNK2pUU0d1aWNGa0tYNkNKczU5UWIzcWF5L1pVcjhlMWN6?=
 =?utf-8?Q?/Wz6VY7y3PWaNRfw95upcfA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <114CCBAD09926A4482C7B9FB4AAA088A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4718.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9160a5d8-112c-47f7-966f-08d9e7565319
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 20:46:59.6712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3XwA576IHMomh2fSMDMR7QEEvTJWMLFo2uVCQOHbPhKtCvB6rWRuiW4DZADh/FijxiY0DcRs1QBC6FKWpfOyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3225
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030123
X-Proofpoint-ORIG-GUID: m2cHjQGhPaHJrKz1vA_ux9NwAThJb-vI
X-Proofpoint-GUID: m2cHjQGhPaHJrKz1vA_ux9NwAThJb-vI
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQo+IE9uIEZlYiAzLCAyMDIyLCBhdCAxMjoyMCBQTSwgS2VlcyBDb29rIDxrZWVzY29va0BjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBGZWIgMDMsIDIwMjIgYXQgMDc6NDA6NDZQ
TSArMDAwMCwgU2hlcnJ5IFlhbmcgd3JvdGU6DQo+Pj4gVGhpcyBkaWRuJ3QgbG9vayByaWdodCB0
byBtZS4gVGhhdCdzIG91dHNpZGUgdGhlIGJ1aWxkIHRyZWUsIHllcz8NCj4+IA0KPj4gSXTigJlz
IGluc2lkZSB0aGUgYnVpbGQgdHJlZS4g4oCcLi4vLi4vLi4vLi4vdXNyL2luY2x1ZGXigJwgbWF5
IGxvb2sgYSBsaXR0bGUgY29uZnVzaW5nLCBpdOKAmXMgYWN0dWFsbHkgbGludXgvdXNyL2luY2x1
ZGUgKGxpbnV4LyBpcyB0b3AgZGlyZWN0b3J5IG9mIHRoZSByZXBvIHdlIGdpdCBjbG9uZSksIGku
ZS4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL3Vzci9pbmNsdWRl
P2g9djUuMTctcmMyX187ISFBQ1dWNU45TTJSVjk5aFEhY1A4LVNYVk5YLWsxTHVXWWpmVVl2Q1ls
ck9Kc0luTGk5bDdoTnNxTG9YaUZVTGQ3eHFSUzlIUkY5V25Ubm8zbkJnJCANCj4+IFRoZSBmaWxl
IHRvb2xzL3Rlc3Rpbmcvc2VmbHRlc3RzL01ha2VmaWxlIGNhbiBpbnN0YWxsIGtlcm5lbCBoZWFk
ZXJzIGluIGRlZmF1bHQgcGF0aCDigJx1c3IvaW5jbHVkZeKAnS4g4oCcLi4vLi4vLi4vLi4vdXNy
L2luY2x1ZGXigJwgaXMgYWxzbyB1c2VkIGluIG90aGVyIE1ha2VmaWxlIG9mIHNlbGZ0ZXN0cywg
bGlrZSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvY2xvbmUzL01ha2VmaWxlP2g9djUuMTctcmMyX187ISFBQ1dWNU45TTJS
Vjk5aFEhY1A4LVNYVk5YLWsxTHVXWWpmVVl2Q1lsck9Kc0luTGk5bDdoTnNxTG9YaUZVTGQ3eHFS
UzlIUkY5V21oeUg2bWNRJCANCj4gDQo+IEFoLWhhLCB0aGFua3MuIEZvbGxvd2luZyB0aGUgb3Ro
ZXIgZXhhbXBsZSwgc2hvdWxkIGl0IGp1c3QgYmUgLUkgaW5zdGVhZA0KPiBvZiAtaXN5c3RlbT8N
Cg0KSW4gdGhpcyBjYXNlLCDigJwtSeKAnSB3b3JrcyBidXQgZ2NjIGdpdmVzIHdhcm5pbmdzLCBz
aG93biBiZWxvdw0KDQrigJTigJTigJRXYXJuaW5nIEJlZ2lu4oCU4oCU4oCUDQpnY2MgLVdsLC1u
by1hcy1uZWVkZWQgLVdhbGwgLUkuLi8uLi8uLi8uLi91c3IvaW5jbHVkZS8gIC1scHRocmVhZCAg
c2VjY29tcF9icGYuYyAgLW8gL2hvbWUvb3BjL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3NlY2NvbXAvc2VjY29tcF9icGYNCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBzZWNjb21wX2JwZi5j
OjI5Og0KLi4vLi4vLi4vLi4vdXNyL2luY2x1ZGUvbGludXgvcHRyYWNlLmg6NTA6IHdhcm5pbmc6
ICJQVFJBQ0VfR0VUUkVHU0VUIiByZWRlZmluZWQNCiAjZGVmaW5lIFBUUkFDRV9HRVRSRUdTRVQg
MHg0MjA0DQogDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gc2VjY29tcF9icGYuYzoyNjoNCi91c3Iv
aW5jbHVkZS9zeXMvcHRyYWNlLmg6MTUzOiBub3RlOiB0aGlzIGlzIHRoZSBsb2NhdGlvbiBvZiB0
aGUgcHJldmlvdXMgZGVmaW5pdGlvbg0KICNkZWZpbmUgUFRSQUNFX0dFVFJFR1NFVCBQVFJBQ0Vf
R0VUUkVHU0VUDQogDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gc2VjY29tcF9icGYuYzoyOToNCi4u
Ly4uLy4uLy4uL3Vzci9pbmNsdWRlL2xpbnV4L3B0cmFjZS5oOjUxOiB3YXJuaW5nOiAiUFRSQUNF
X1NFVFJFR1NFVCIgcmVkZWZpbmVkDQogI2RlZmluZSBQVFJBQ0VfU0VUUkVHU0VUIDB4NDIwNQ0K
IA0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNlY2NvbXBfYnBmLmM6MjY6DQovdXNyL2luY2x1ZGUv
c3lzL3B0cmFjZS5oOjE1Nzogbm90ZTogdGhpcyBpcyB0aGUgbG9jYXRpb24gb2YgdGhlIHByZXZp
b3VzIGRlZmluaXRpb24NCiAjZGVmaW5lIFBUUkFDRV9TRVRSRUdTRVQgUFRSQUNFX1NFVFJFR1NF
VA0KIA0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNlY2NvbXBfYnBmLmM6Mjk6DQouLi8uLi8uLi8u
Li91c3IvaW5jbHVkZS9saW51eC9wdHJhY2UuaDo1Mzogd2FybmluZzogIlBUUkFDRV9TRUlaRSIg
cmVkZWZpbmVkDQogI2RlZmluZSBQVFJBQ0VfU0VJWkUgIDB4NDIwNg0KIA0KSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIHNlY2NvbXBfYnBmLmM6MjY6DQovdXNyL2luY2x1ZGUvc3lzL3B0cmFjZS5oOjE2
Mjogbm90ZTogdGhpcyBpcyB0aGUgbG9jYXRpb24gb2YgdGhlIHByZXZpb3VzIGRlZmluaXRpb24N
CiAjZGVmaW5lIFBUUkFDRV9TRUlaRSBQVFJBQ0VfU0VJWkUNCiANCkluIGZpbGUgaW5jbHVkZWQg
ZnJvbSBzZWNjb21wX2JwZi5jOjI5Og0KLi4vLi4vLi4vLi4vdXNyL2luY2x1ZGUvbGludXgvcHRy
YWNlLmg6NTQ6IHdhcm5pbmc6ICJQVFJBQ0VfSU5URVJSVVBUIiByZWRlZmluZWQNCiAjZGVmaW5l
IFBUUkFDRV9JTlRFUlJVUFQgMHg0MjA3DQogDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gc2VjY29t
cF9icGYuYzoyNjoNCi91c3IvaW5jbHVkZS9zeXMvcHRyYWNlLmg6MTY2OiBub3RlOiB0aGlzIGlz
IHRoZSBsb2NhdGlvbiBvZiB0aGUgcHJldmlvdXMgZGVmaW5pdGlvbg0KICNkZWZpbmUgUFRSQUNF
X0lOVEVSUlVQVCBQVFJBQ0VfSU5URVJSVVBUDQogDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gc2Vj
Y29tcF9icGYuYzoyOToNCi4uLy4uLy4uLy4uL3Vzci9pbmNsdWRlL2xpbnV4L3B0cmFjZS5oOjU1
OiB3YXJuaW5nOiAiUFRSQUNFX0xJU1RFTiIgcmVkZWZpbmVkDQogI2RlZmluZSBQVFJBQ0VfTElT
VEVOICAweDQyMDgNCiANCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBzZWNjb21wX2JwZi5jOjI2Og0K
L3Vzci9pbmNsdWRlL3N5cy9wdHJhY2UuaDoxNzA6IG5vdGU6IHRoaXMgaXMgdGhlIGxvY2F0aW9u
IG9mIHRoZSBwcmV2aW91cyBkZWZpbml0aW9uDQogI2RlZmluZSBQVFJBQ0VfTElTVEVOIFBUUkFD
RV9MSVNURU4NCiANCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBzZWNjb21wX2JwZi5jOjI5Og0KLi4v
Li4vLi4vLi4vdXNyL2luY2x1ZGUvbGludXgvcHRyYWNlLmg6NTc6IHdhcm5pbmc6ICJQVFJBQ0Vf
UEVFS1NJR0lORk8iIHJlZGVmaW5lZA0KICNkZWZpbmUgUFRSQUNFX1BFRUtTSUdJTkZPIDB4NDIw
OQ0KIA0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNlY2NvbXBfYnBmLmM6MjY6DQovdXNyL2luY2x1
ZGUvc3lzL3B0cmFjZS5oOjE3NDogbm90ZTogdGhpcyBpcyB0aGUgbG9jYXRpb24gb2YgdGhlIHBy
ZXZpb3VzIGRlZmluaXRpb24NCiAjZGVmaW5lIFBUUkFDRV9QRUVLU0lHSU5GTyBQVFJBQ0VfUEVF
S1NJR0lORk8NCiANCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBzZWNjb21wX2JwZi5jOjI5Og0KLi4v
Li4vLi4vLi4vdXNyL2luY2x1ZGUvbGludXgvcHRyYWNlLmg6NjU6IHdhcm5pbmc6ICJQVFJBQ0Vf
R0VUU0lHTUFTSyIgcmVkZWZpbmVkDQogI2RlZmluZSBQVFJBQ0VfR0VUU0lHTUFTSyAweDQyMGEN
CiANCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBzZWNjb21wX2JwZi5jOjI2Og0KL3Vzci9pbmNsdWRl
L3N5cy9wdHJhY2UuaDoxNzg6IG5vdGU6IHRoaXMgaXMgdGhlIGxvY2F0aW9uIG9mIHRoZSBwcmV2
aW91cyBkZWZpbml0aW9uDQogI2RlZmluZSBQVFJBQ0VfR0VUU0lHTUFTSyBQVFJBQ0VfR0VUU0lH
TUFTSw0KIA0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNlY2NvbXBfYnBmLmM6Mjk6DQouLi8uLi8u
Li8uLi91c3IvaW5jbHVkZS9saW51eC9wdHJhY2UuaDo2Njogd2FybmluZzogIlBUUkFDRV9TRVRT
SUdNQVNLIiByZWRlZmluZWQNCiAjZGVmaW5lIFBUUkFDRV9TRVRTSUdNQVNLIDB4NDIwYg0KIA0K
SW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNlY2NvbXBfYnBmLmM6MjY6DQovdXNyL2luY2x1ZGUvc3lz
L3B0cmFjZS5oOjE4Mjogbm90ZTogdGhpcyBpcyB0aGUgbG9jYXRpb24gb2YgdGhlIHByZXZpb3Vz
IGRlZmluaXRpb24NCiAjZGVmaW5lIFBUUkFDRV9TRVRTSUdNQVNLIFBUUkFDRV9TRVRTSUdNQVNL
DQogDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gc2VjY29tcF9icGYuYzoyOToNCi4uLy4uLy4uLy4u
L3Vzci9pbmNsdWRlL2xpbnV4L3B0cmFjZS5oOjY4OiB3YXJuaW5nOiAiUFRSQUNFX1NFQ0NPTVBf
R0VUX0ZJTFRFUiIgcmVkZWZpbmVkDQogI2RlZmluZSBQVFJBQ0VfU0VDQ09NUF9HRVRfRklMVEVS
IDB4NDIwYw0KIA0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNlY2NvbXBfYnBmLmM6MjY6DQovdXNy
L2luY2x1ZGUvc3lzL3B0cmFjZS5oOjE4Njogbm90ZTogdGhpcyBpcyB0aGUgbG9jYXRpb24gb2Yg
dGhlIHByZXZpb3VzIGRlZmluaXRpb24NCiAjZGVmaW5lIFBUUkFDRV9TRUNDT01QX0dFVF9GSUxU
RVIgUFRSQUNFX1NFQ0NPTVBfR0VUX0ZJTFRFUg0KIA0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNl
Y2NvbXBfYnBmLmM6Mjk6DQouLi8uLi8uLi8uLi91c3IvaW5jbHVkZS9saW51eC9wdHJhY2UuaDo2
OTogd2FybmluZzogIlBUUkFDRV9TRUNDT01QX0dFVF9NRVRBREFUQSIgcmVkZWZpbmVkDQogI2Rl
ZmluZSBQVFJBQ0VfU0VDQ09NUF9HRVRfTUVUQURBVEEgMHg0MjBkDQogDQpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gc2VjY29tcF9icGYuYzoyNjoNCi91c3IvaW5jbHVkZS9zeXMvcHRyYWNlLmg6MTkw
OiBub3RlOiB0aGlzIGlzIHRoZSBsb2NhdGlvbiBvZiB0aGUgcHJldmlvdXMgZGVmaW5pdGlvbg0K
ICNkZWZpbmUgUFRSQUNFX1NFQ0NPTVBfR0VUX01FVEFEQVRBIFBUUkFDRV9TRUNDT01QX0dFVF9N
RVRBREFUQQ0K4oCU4oCU4oCUV2FybmluZyBFbmTigJTigJTigJQNCg0KU28gdGhlcmUgaXMgcmVk
ZWZpbml0aW9uIHByb2JsZW0gYmV0d2VlbiBnbGliYyBhbmQga2VybmVsIGhlYWRlcnMuIEkgdHJp
ZWQgdXBkYXRpbmcga2VybmVsIGhlYWRlcnMsIHRoZSBwdHJhY2UuaCBpbnN0YWxsZWQgaW4gL3Vz
ci9pbmNsdWRlL2xpbnV4L3B0cmFjZS5oIGlzIHRoZSBzYW1lIGFzIHdlIGluc3RhbGxlZCBpbiB0
aGUgc2FuZGJveCAuLi8uLi8uLi8uLi91c3IvaW5jbHVkZS9saW51eC9wdHJhY2UuaCwgaG93ZXZl
ciwgZ2NjIGRvZXNu4oCZdCB0aHJvdyB0aGVzZSB3YXJuaW5ncyBpZiB3ZSBjb21waWxlIHNlY2Nv
bXBfYnBmLmMgdXNpbmcgL3Vzci9pbmNsdWRlL2xpbnV4L3B0cmFjZS5oLiBUaGlzIGlzIGJlY2F1
c2Ugc3lzdGVtIGhlYWRlcnMgd2lsbCBhdXRvbWF0aWNhbGx5IHN1cHByZXNzIHRoZXNlIHdhcm5p
bmdzIChyZWZlciB0byBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3MvY3BwL1N5c3RlbS1I
ZWFkZXJzLmh0bWwpLiBJbiBteSBvcGluaW9uLCBpdOKAmXMgZmFpciB0byB1c2Ug4oCcLWlzeXN0
ZW3igJ0sIHNpbmNlIHRoZXkncmUgYWN0dWFsbHkgZ2VuZXJhdGVkIGtlcm5lbCBoZWFkZXJzLg0K
DQpTaGVycnkNCg0KDQoNCg==
