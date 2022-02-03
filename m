Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1890F4A8C9A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Feb 2022 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiBCTkx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 14:40:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22322 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353823AbiBCTkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 14:40:53 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213HTM3n023297;
        Thu, 3 Feb 2022 19:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XHesXn+ZL7uT1JSql03f/3cjtgw/pgs2g1yCpBADJhc=;
 b=vGjWo32C3DAzRHl3nd6Pv7nU8ffRC435xIUmpYstoPHtc6gre1riKV9xLjkR9vQ8b458
 zcch1XtYJbzas1XKszwWmhntPYhxFbc9ai2kICTHuA4RhVotSZlQty5rqCq4t5yVwuBR
 T4r4hWVUyEPTaFXBBe5DxKW5c4yG8VGQYLnRUpRc62KaY2TpAjROPwbnS7Tnd/sSzPzo
 i5QabFnhgvAcj7xLbpF0H3kPgayoTXBeZ6nLGiCemuMdeOqPNHp9zt5LBo1f2VObkcU/
 mkgp6cAnVDwL+KQRRh6QOCCu3hK3nh6r+ao8ENNbPzCVgdXxq/mW1p9vJ3dqZwC9FiS9 UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfw8qbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 19:40:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213JLf76095536;
        Thu, 3 Feb 2022 19:40:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3020.oracle.com with ESMTP id 3dvy1vnysu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 19:40:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlxunBSocZpnMQAnaQzF56VfTCM844TVNFxz7KudMF0ROaB9HeaNje5s1ShTSoD8hLDR6x47h+NuGEzb6xDGNx6D623m3b1XnJe2jRIcoCn7HHP7zAZHm1eAx5I65hHrGCiR5Q3fF+5wQvcdj/kGsTjY/0Vyi2qgQDC/FtuTN0vYSIHmgYYunei9Tj9OJSAClcURDHjwGrsyqDZYolDIR44J//ry7DXp+dn+u7wRLrVnCr+qV3fFvIzZKcm2Z94nWqG7AadFUQo4POhs5Ja/sB0Bt0HHVvjL4X+BslHNdtU88OLPdYVNjo5fSmOTQuhAISdGjWGyhSIzBVC4q39K6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHesXn+ZL7uT1JSql03f/3cjtgw/pgs2g1yCpBADJhc=;
 b=LyXZ+PBn8PgU6n9t6BPhEiAG4DcTJbUB9ahk2MHblWfNUx8AX+BVfQtecYcrz3AnnMZBbPMYITuCVKxAb//Pkm0LFFf4C9JPc1I0cMfIovCjyuPPOlf0/rIzxLNzBerMOChP6HKqkw/85TkzVvn0lknXn3cziuX99ObYQbIdezBPbwuxgBOd1MOr1goeqa9bW4Wss2dOFL219Om8Mwubp5+n3wGhXWBzAlTbA8zp4qFCeHh8FqIKe1UZ1nrDIZLpV5kpYBHLOYtvJ2kcUGvEY8srpAVCYgHvMPUuRr2ulRim3zWyCUtNUyhQxZ16esYea8SWF6zbHyqbDJp8EKMssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHesXn+ZL7uT1JSql03f/3cjtgw/pgs2g1yCpBADJhc=;
 b=wpaZiVAry9qwGaDdUjAIXGM7jX0ET89MNG49vYo3XPTb4v1uitAmQGEVdOVG+fuhErh+/asHDuPtMPyCuUsR9kLdPaaTqdAkDPrR/9PnFKgbYGLaq+VXBPeaXRS+cilLWSKkGiz0A2b7HrmeN+qRF9AYSeqAuD3ar6vOLJ3Zs48=
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14)
 by BN8PR10MB3379.namprd10.prod.outlook.com (2603:10b6:408:d0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 19:40:46 +0000
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::cd19:e61e:1ee2:8216]) by SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::cd19:e61e:1ee2:8216%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 19:40:46 +0000
From:   Sherry Yang <sherry.yang@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
Thread-Topic: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
Thread-Index: AQHYGHEQ35nm0s4Mz0ebe3Zft+MEpayAw6qAgAF3UoA=
Date:   Thu, 3 Feb 2022 19:40:46 +0000
Message-ID: <A8A651FC-37A5-4716-888B-F141E7241003@oracle.com>
References: <20220202201118.13933-1-sherry.yang@oracle.com>
 <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
In-Reply-To: <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5df9ae76-382a-4d51-30e8-08d9e74d12f4
x-ms-traffictypediagnostic: BN8PR10MB3379:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3379C9C43B0E75D9674FDA5D9B289@BN8PR10MB3379.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5yXffMBQ3D6D+uN4w5lrJ5JNz2gzl8Q3cP0o3unfQQpCHa6HCPdQkPF57dxL/xkeFfssVf6ujKzax2b1DnTaYOhoShTk1NTqrLVi6kWP6DBC86HU3B9uQFM+CtZv91bw/FVUcG4anhDVQ0CMtB3kZ94Pq4coRUOo41sjD28m2YD9CVQBniprOThlSeFke31HyG6a8UTpB8GaXZn/ZZXPnS1Ff9gQby0jBXwLsNwhb2kyFGV7HTy1+DQQiGWOLNs95b4L6Hzf4yDrjHVlwXFH1ymQss4mb3Kaf8QOvOi/g2kwgK4Mxr5nBwmyWwOz7CkMDKqsntj05P7+iSUj3U3moEj5qDB7eSTXjFuLiFooFET42f4ZgM5JeypmXVq2GrSOpqFK/z63WT5GW+kN+F+ZrMzZIPOnfY4aHxlpCHqwGgi61y+VqXOMJGF1XI137ToBpn/Gzwmfl3xqrvtozVp9bGI/+qt839tyoRMlkVQ3hl/2+JzldqQea9s9Q3LOlZ0aCwGr+qxd1T3rX+ny1dZTAWRlOMm7q8l0lgkFzcKB/PfAkv9rvbFxK0AC8x0fxGREPhV2RM7ODFwAkpUo/EJyHT61FxVa6jczvYxrNQ+i+FDbkw7AlRywbqWOtXilQGL0cOlVYSP6IsySEvucguZLz+E0dVJtw0tpXaBg72cvOErgdAsUcgR/4+MzP3i25/awTJygBpHu6tAd8avN2qIQYPBgKq8DoicwLjKFCDDvMXFVEoID4NPxGsGwZVPd0tuBr3lRt5TZc8KJhYKNCuY/GfCfZ/AtvIFo1jLZkuJOZRfCZs7TZciNDn2PQ6FGQssMoWjv5QMqW34nUpWJacfRMYtMi5w2Do/26UqyCrX9ak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4718.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(64756008)(76116006)(66446008)(66476007)(66556008)(66946007)(966005)(6486002)(86362001)(2616005)(38070700005)(36756003)(91956017)(4326008)(8676002)(8936002)(316002)(186003)(26005)(54906003)(6916009)(33656002)(5660300002)(2906002)(6506007)(44832011)(71200400001)(4744005)(122000001)(38100700002)(508600001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUdaQUdFNHhVbHFBV3FlNHVuSCswRFZNVHh5UUZkSk1Yc01qcEZLT1pKbENS?=
 =?utf-8?B?dXh0eFNaV25mcThLNXNhQTBwR0xuazVnczRIeXFzcUIzWHBqZlVyZVVRRnE4?=
 =?utf-8?B?L095Z29pQkt3VGROcDdsR1ZWMkxpTzY4WElwM2lhd2dUcS84aE1iMjlTNmw5?=
 =?utf-8?B?YVJKeDFRbEVVM0dRU3VQbUtzTlEyazIxUUsxQUY1K2Y5QnBPNEpHbVYrNHF1?=
 =?utf-8?B?SkV5RlZzYVFaZmNaZVF3dFR6di9nai9HTEhHNHpZU3RPU1IwZEFOREhJKzRl?=
 =?utf-8?B?d29kbDBMQ3NJMTBUcjl3eTBDb3dNay9URXFSVlhuR2RobHAyQ3RXU1kxbXZQ?=
 =?utf-8?B?SDZROFNFOCtLUGFyL0VWL21xaWtRbHlQL3RxWmdpMTNqQmdBYUpWdDUybThT?=
 =?utf-8?B?ZnVNejROSTNNY3Q4UWNERC90MUI5NnZBUGtqb2JUNzhBZkNUT0xmV3h6TzUz?=
 =?utf-8?B?b0QvcEF0c3gySm8xTzFSL0hSNTJvVGhIbWY4OEd1U2kwc0x1UERvNENlUzdx?=
 =?utf-8?B?cmwxWEh4TEdqa0NsSkNUK0lTOXFGL0Q5WEEzcFV3ZW1tYTd6d3lScW5RZXI4?=
 =?utf-8?B?UEI3QTJWY1FYVmJlT0FyUWsxNDFBQXBkM2c4UFBnNEM3Qk8remZCaTAyWmlU?=
 =?utf-8?B?NndDZEliLzNWeFc5Nk02VTdMZnZNazIwUUdLNUpmOGJnaDNoK2p3QmgybFNs?=
 =?utf-8?B?SVV2dUp1S0Q2b2NVRFBUNjhlSWxTVWRsQ1FBNXFKYXZxVGFzQVFqQlI0dXFY?=
 =?utf-8?B?Q2ZSczBXMkVNWndOdXI1eVlJdXpiS2dRTVVxNW5jWTlYcVh6QXF1TEZ5SEpK?=
 =?utf-8?B?RE5PeXFJdHorcnV3MzhZc1lDaDlCRUQwRk1kN3gva0x3b0RYM2lsVGJlWUNG?=
 =?utf-8?B?ZURoT0taR2ZJcEl0SitUcXVnT1VBNVpUY2xJUW56QlhWV3E0TjFXR0w5endR?=
 =?utf-8?B?QkRsTEt6d2lXdGo5MVZuUDBYaVAvY2xUenN1NlUzTlhuMlVwTmZrb3EvOFli?=
 =?utf-8?B?K1JZdWY1bDV0WGw5eW1yLzVTNExpVlRYY2JrWE94S1FOUTRRZGdZRThUMFhB?=
 =?utf-8?B?c09CbWg4L1lRV2REMHNvcVRnVjlndW4rdjM2ejRCZ2c2T1lJTTZJZ3FVdjhG?=
 =?utf-8?B?MitTSmtubmhOcThOZ2NoK3NiL3czMzR1RWdUbUdOb3czVXRIVGRacEhlUktL?=
 =?utf-8?B?MmtYbjFTT1lVNmVpWmszdTdCM3NlVGVtWGRtemEzNEwvTGlCOVhUSWM5OHpK?=
 =?utf-8?B?WDNOQWliM2pqa3ZmSnErai8rNVM3UGFjTUtyVm1HVmpTR21tMWpkNzRiUzdX?=
 =?utf-8?B?VjhsSXNpNHh4NDRKMGx0dEZVM2Z3dmdmck9QL0hBQlU4NlJrZGR3ZUhvTnF4?=
 =?utf-8?B?dzRHblRNY0xzK0NrOGdyQk1XYjJLbVpIMnZpaS9OK1FKbE1zTjZCRGJicCtn?=
 =?utf-8?B?TzNxVDJYNmlDSEJtMFdEa1A1ZjgybnplK2hIc0lWajg0SW1xUkdCdEFBTGZD?=
 =?utf-8?B?eG5Qcmp3QnFHaVdlb0Y2WjVpSi9xbllNSjhldVJTQTYwK2REcDJHN1BrWm9B?=
 =?utf-8?B?aDJxVFBjZUZvbzdraEorSURVMGsrZnIxNm1aNjVSTmJwaXB3aFVHRnR3TVFw?=
 =?utf-8?B?bGZ6UytGZkdSbVFOeTFQKy9zR3R6SCtPcTFMdTEzKzdiVnRSM0ZydjdJNkNN?=
 =?utf-8?B?bXhDMEhuYVZ6cVpsU0JscXFuUFhIR0UwT2hHdzFtakJ0Z0dzYmN0TEtJOWpn?=
 =?utf-8?B?anlxT0xYcGptclNSWnllcGVVNm1JZEM2NDdYYXo3VTZsWndXeG9FWEFoRTJq?=
 =?utf-8?B?ZXlQRTg3T2ZhZXljbldGSjBOU3hzRU1uNnlwMDhBaWFQWXhZdTBWQU44V2Jp?=
 =?utf-8?B?M05wMXl4QnBJRGVIMDEyNmZHTHVEM1ZjY043TGdvNGVMNlpkRGltdFkzeDQ3?=
 =?utf-8?B?eGJiZU5ETTRmekFUTGQvd25ZbkFOeVVDK05INStpWnNvejB0YWVZajFWc0xU?=
 =?utf-8?B?Ni9xNWtBQjZrNlpaNU5uMHczR3VHTWZweW1pR2dVemorY3dHME5nWmpmVG9l?=
 =?utf-8?B?K2VZNDFPVTVMTWcrUkdmcTBoRkRiN0lxWEJzTExLdnFOcUdTdVlPWHJONzgw?=
 =?utf-8?B?R2dXN2hEU1FaR1lYM2pNbXBCeGNPQ29jL281VTdVd0FEMVFLck1LMU9JczVG?=
 =?utf-8?Q?VDAbrJJJuHXGUhM8TVbTIKs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A15DC78AA4EB64ABF7514B0C2E36925@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4718.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df9ae76-382a-4d51-30e8-08d9e74d12f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 19:40:46.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLmKNIEkd8tIugo75O1LyBOwPuL5EqGSDN9cYZ51GpZgNz8CZxX4VIyxnepLzZB61rDdm3Cqx/D5V3MZBjGZug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3379
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030116
X-Proofpoint-ORIG-GUID: QiHL4H_F6auFBYC4STt4vCtN5FBSMX_t
X-Proofpoint-GUID: QiHL4H_F6auFBYC4STt4vCtN5FBSMX_t
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBUaGlzIGRpZG4ndCBsb29rIHJpZ2h0IHRvIG1lLiBUaGF0J3Mgb3V0c2lkZSB0aGUgYnVpbGQg
dHJlZSwgeWVzPw0KDQpJdOKAmXMgaW5zaWRlIHRoZSBidWlsZCB0cmVlLiDigJwuLi8uLi8uLi8u
Li91c3IvaW5jbHVkZeKAnCBtYXkgbG9vayBhIGxpdHRsZSBjb25mdXNpbmcsIGl04oCZcyBhY3R1
YWxseSBsaW51eC91c3IvaW5jbHVkZSAobGludXgvIGlzIHRvcCBkaXJlY3Rvcnkgb2YgdGhlIHJl
cG8gd2UgZ2l0IGNsb25lKSwgaS5lLiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS91c3IvaW5jbHVkZT9oPXY1LjE3
LXJjMg0KVGhlIGZpbGUgdG9vbHMvdGVzdGluZy9zZWZsdGVzdHMvTWFrZWZpbGUgY2FuIGluc3Rh
bGwga2VybmVsIGhlYWRlcnMgaW4gZGVmYXVsdCBwYXRoIOKAnHVzci9pbmNsdWRl4oCdLiDigJwu
Li8uLi8uLi8uLi91c3IvaW5jbHVkZeKAnCBpcyBhbHNvIHVzZWQgaW4gb3RoZXIgTWFrZWZpbGUg
b2Ygc2VsZnRlc3RzLCBsaWtlIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nsb25lMy9NYWtlZmlsZT9oPXY1LjE3LXJjMg0KDQo+IEkgdGhvdWdodCB0aGVyZSB3YXMgYSBw
cm9wZXIgInVwZGF0ZWQga2VybmVsIGhlYWRlcnMiIGRlcGVuZGVuY3kgdGhhdCBzaG91bGQgYmUg
dXNlZCBmb3IgdGhpcz8NClVwZGF0aW5nIGtlcm5lbCBoZWFkZXJzIGNvdWxkIGJlIG9uZSBzb2x1
dGlvbi4gQWRkaW5nIOKAnC4uLy4uLy4uLy4uL3Vzci9pbmNsdWRl4oCcIGluIHRoZSBoZWFkZXIg
ZmlsZSBzZWFyY2ggcGF0aCBjb3VsZCBidWlsZCB0aGUgdGVzdHMgaW5zaWRlIHRoZSBzYW5kYm94
Lg0KDQpTaGVycnkNCg0K
