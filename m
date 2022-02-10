Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769254B1707
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 21:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343924AbiBJUi2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 15:38:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiBJUi1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 15:38:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2BDD68;
        Thu, 10 Feb 2022 12:38:27 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AIV2Gj027653;
        Thu, 10 Feb 2022 20:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/v3pZRH2sQOqADtYhaypjfWdwcqB4nHzcY2ltbnAJ6g=;
 b=SLfkCAQHZtPgZNNNDQKFKSEeG1Pxc7xUfdyyr7/k8U4c3hd1pONivcHUgiW1hhC+r+mm
 wuw7Dn5Slu8yF1TlKanuUmxNysp1mpnSfIZ0pownGVw62MZEHr6n4iVe5h4VnzMU2h1D
 MIxVIMESQjtDDyTClVvS+IF8uBG3j93Y7GwO4oRoF+tLJrJjnhDyPDGDxH9vOULI3o9M
 ev/JscTqR8dx3zLcXeySyZQuU7rFbzV0V7BR+srLgVBPFqdVYDgvs1DZUovsbhwb2d1M
 co9VwawleWsbRmUQO4xnIv846+Jx0fNOlMB6EAgac0GDQN0akLm52i+g2UoINUmMzKQk MQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdt19nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 20:38:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AKKDre180651;
        Thu, 10 Feb 2022 20:38:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 3e51rtytv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 20:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhfiWmzU81i9F3gVNANGf1ruW9SOP8IGlhwqjQLpFH5e4pSYmQHjTvBED9MZTI1Xfka/KfB1KKYLRCRkenEdCB4pBSsDEQKaEir+M3pl5+BzawbWvcUfCbRdwNYGUg3w32uZwVG1V+dBsAcoAVk+MHG8/VTTe2MKlX9rMbenghilbM95Mpe29TdrmuTplhpyAks5sRlLKlGXE9qYUtITJPP1KM6VQ3v70T8MrMTtADV+p6zeE2bZn0o5+PfDdodILLMK8zSpn+qMip64chRf/MqWDeY5QrFrjdjcQnDtRJ7O9PV5AVdpQVsf+OLc8GPDIGyl2lSJazotDUSnUvhwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v3pZRH2sQOqADtYhaypjfWdwcqB4nHzcY2ltbnAJ6g=;
 b=PNPn0iUIdChgXNAuQ+bz2sP/3hxARdLdZwTKdAbGMFVEZR+ozxqbT0KkBDEvqltCp2mPGmxI9+mUrzPp5fNVd223YolIrtPmzfk/uNARv+rS0Eld4SJ3xD5QFSsCRw3OITRJPTRDyne5vGnzopKexZhbW+PbTIoaJoEp97EYdWOSBCJDbXlZVgZPuydn3v7+nCpmzCXMWCcTrEetmIwDXBXEsWCQHPoD99o0F5loLiZpp4iODEPxSW8C6QZcDfiHouQlIrIceYLzCef0f2r5d22okH6B0cgeTLsPKP+urgi7yseOJTATAGxTmbkHwsbSkTh8EkglWy8tSQPHSJ+UwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v3pZRH2sQOqADtYhaypjfWdwcqB4nHzcY2ltbnAJ6g=;
 b=nh87U6pTzbtQsMg1gtPIS20y6nwFmdkmLR6lPrD5AcpQALC7Du8ajgDGmD+mvDY+wXa+1jbgt+M6Npzqdiz4UpAAuS0d+W30dBqnW2sijQ3Wmzf1u2CF8VLKcaiODXj/J90zTEcvYw2Iwik4fgzJXbLxqc04/RPIZPjv1EL+sYY=
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14)
 by BN8PR10MB3602.namprd10.prod.outlook.com (2603:10b6:408:b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 20:38:23 +0000
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::cd19:e61e:1ee2:8216]) by SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::cd19:e61e:1ee2:8216%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 20:38:23 +0000
From:   Sherry Yang <sherry.yang@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
Thread-Topic: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
Thread-Index: AQHYGHEQ35nm0s4Mz0ebe3Zft+MEpayAw6qAgAF3UoCAAAsBAIAAB4AAgArQGACAAAP7gIAAAawAgAAoKwA=
Date:   Thu, 10 Feb 2022 20:38:23 +0000
Message-ID: <AB1520F5-E982-47AA-A56D-7679D61CBE6D@oracle.com>
References: <20220202201118.13933-1-sherry.yang@oracle.com>
 <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
 <A8A651FC-37A5-4716-888B-F141E7241003@oracle.com>
 <202202031219.792E9AFF@keescook>
 <C340461A-6FD2-440A-8EFC-D7E85BF48DB5@oracle.com>
 <b908237b-63ad-ff10-8d89-540d2cab842e@linuxfoundation.org>
 <6FCDF584-C765-4344-A851-E623B2FCB9A6@oracle.com>
 <9fb71ee9-37c8-575c-0ca7-5a849403f7d9@linuxfoundation.org>
In-Reply-To: <9fb71ee9-37c8-575c-0ca7-5a849403f7d9@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa0046b6-2976-4c4a-39c3-08d9ecd54876
x-ms-traffictypediagnostic: BN8PR10MB3602:EE_
x-microsoft-antispam-prvs: <BN8PR10MB360269B8C4B3E0177B19BDC49B2F9@BN8PR10MB3602.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKX+tlXc+t0VMmiAXBdvyPiCQNDmqvOVznoSLraJyQ+0xnTyEKPwK70YKqZ9bfl97EeGANjEInD2CvYBHXy4mmm4/6da8TENGFg9dEM4SCQLbzigkQcCYcnElKR85Qovt9lbCnbLhNIX3BBceibAW7xb1axXNxhSTrvEmM0dQD27DIvaY9laEr414FTUB+3ygWA1V2LQd9BtH2eomJKylHEuLHvf2l85zl/8WsXq8i3gLjc2biqvkUpZD0bmHc9oSHqHt9so4MWJ+y+R2wIr1B6eNpc3HGFBq0yDZoSMioPI0WBPNw8XAbmY6pkgDHPxQ1CzfXdhIMJYcwgWas8AT33t9zvxOP2qzKdIlVoBbE9KhJlPwEb6K2xVCjw/7XB8hcau+4CXs7sYZgvHCLU4s1gbmcEnwW9YfM3/7C2++YgrbVAU1EDl8fJRzh8sb3r2ui6j5kEZL4ztqh9a60MyzxNKDKd/CgsjT7OSjDK0hibZaygCxY3sloEN9sYvEv2t996MMBOVm1JBUxUhGxbxDn2ulURJr/2B39wvNP25kwgc6s6UaDK60XZVT2P0JQRD4mu9FpVQvO5X6fkUg4XsVi++Qypb1/Tl9f7l31MdJyDZIKV2zwjE54hb+vabl/8Wq7FCBhInUuZU9pvw2SJH/0IvUadiIeDg/Y5ZdWOK18xqDFkQIMxvgJRsvQF6m+o+h5rVgqmOYTyh2eV2aLMJNj/mjraXZr3O21i32KRCMZuTliBwtuzPfjp3fkQ1gnHHSx2dPrYJGJV0S9XIhDDDn0+wKyQ0WR3rHAK20OwIArotEfNY4fE/lVuAV7DrTIa77p4tWOmFnCpzFtuLQzmCMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4718.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(54906003)(8936002)(8676002)(6916009)(508600001)(4326008)(66946007)(316002)(122000001)(76116006)(66446008)(6486002)(64756008)(66556008)(66476007)(38100700002)(6506007)(6512007)(966005)(71200400001)(38070700005)(86362001)(4744005)(36756003)(33656002)(2906002)(44832011)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3krQi9LTUM1Q3VYck1ueTVGbXRDTDhYTno2L09JWFpSQzFjR3M2VkRCTFVJ?=
 =?utf-8?B?MWFVUDNQRE9GU3hTSmdVS2FZdm1rMGFvUk5FVnlIdy94RFo3UzI4dHMxeTR2?=
 =?utf-8?B?WjhxeVREQWlTeWpzQW9ndUIwS05mVEMwSnNHemtPVFJnR1g5c3hVd0M3UUM4?=
 =?utf-8?B?Zjg4U0YyZ0JLNWZsNTBITTRKem1zaWtFcHpYWDZsT1JXZG9MV0RHbkt6Sk1k?=
 =?utf-8?B?M2Fva284L1dpOVdEVEdPVjhZdVl1WjJKZzBRb0VJQjQ3cEhYQlVkWllLUmJu?=
 =?utf-8?B?M1RJU0NIVUhvWWVvdVlNWnc4YzZDcGZIdmR2R1M4Um1ZbjB4dTllNTZEczFH?=
 =?utf-8?B?NURJTktHdUdvUlpTY081VlpHWi9KVERRSE0zVnpSWTFjaGIwaVRuaW51K2Nt?=
 =?utf-8?B?YXoxZGdFM3JSM2oxaHF2OWc1bjUvbElEN1J6T3k5eUZlOWJoSnpWbVIycEJD?=
 =?utf-8?B?Y0k4OVEvbHFIcktEQVBMejZUczFFYk55Y1luWVF6UnRFZkdKMUJzc1NXRFJo?=
 =?utf-8?B?MCtDWFNzYzFXTitITnZWNW1ZY3NzUjZLc2RzakxqaUpXbjZrZlhvWHpsQUJn?=
 =?utf-8?B?WmRrTVNtRTF3dU5RSWZKU0FYQ2tmb3BuM08xWi83TXIyS21ERk0yOFlpWHlK?=
 =?utf-8?B?OW5qNzNkTXNsaHNwM1M3c2FLQ0N4U0kxSU1HVVF3WmdCbU1CbTRhbnhLN3BS?=
 =?utf-8?B?U2FpeDYwaEpycHA2R0EwcnFFTXVuck9kWWZ2eU1TWXFOcTE5SURBMUtKL0w3?=
 =?utf-8?B?aVlmTUNtdlp4TEtZbXpNSDcwaHYyMlNsUzh4Z0wrUjJWRmtmUEV1dXB3Q3Uv?=
 =?utf-8?B?OEtiQXZ5amx1S29zVTM5R054R24yY1lSZmdlNGI4MUJSZHprVGlrd3AzR1Bu?=
 =?utf-8?B?cSsrWkpjck51WmN1UWNzY013cEFSV3BxMElpV01yWUgvS25sOUY1WHg3U3dJ?=
 =?utf-8?B?K2REWEtwTzFLYSs0eTZTaTdYcGw2b2pxcHVjSURseE4vV01pVms2b0lYYlBn?=
 =?utf-8?B?QzNvWEhNRW10UmVpbDh4YXAzUS9RWU5ndjlRMnd4YS81N0FSTm40Znk5Zm1h?=
 =?utf-8?B?Y2t1Q2YxaEtsNXBuZVh2bUl6b3ZBM1A4U0VYQjJHNEpUWUZjWXp6WE5EZ3hB?=
 =?utf-8?B?TS9HY3BheDVaRlIvZ2d6QTNLZXJRZzg5UEptWlRzN3NnRi9UTXp2ZDNWenFX?=
 =?utf-8?B?cEsvSDNtU3o4Q2k5VkFTaTVFSTZiNDRrQ3ZzNmFReXVHWHc2MmIxUUd0bldT?=
 =?utf-8?B?V0ZVTW9Idm5zalJ2RXJlcnJmMktUQlcyREphMUVUbzZ0OThDUURrcDd5c3BV?=
 =?utf-8?B?R1V3ODVLcEcxdXNRVGJUSG9QbDlxcjFWbldJK0luaXpqR1NRSytBRmZEMjlQ?=
 =?utf-8?B?aGtHWkZaY0NvYzI2QXYwSmZxdDFYSVA5aHg5bENkZFNBOSs1YzlSMDQ1RnlD?=
 =?utf-8?B?WFNJM29aUTFmZEtLNGVqaXhNVWJnd01Wd1c1dzFZVGxoL0hDL0taK25kVzlT?=
 =?utf-8?B?K0swQjM3aEljREsyaG0zSDk1V1dGdmMySEV3clJ4cStFa2hLWmU5TVc2TFpU?=
 =?utf-8?B?M3haS2lvRlJIT0JHSVNQbHVUZm96RlZ4OFFhQlVmYzR0UVkwaXRReTIxejF6?=
 =?utf-8?B?aUpWZnp4bjgwZDdJNUJ4ZlQwaVVYRzRYa0d4YVZ6RVVwMjg3UmVhMjJZMFN1?=
 =?utf-8?B?QXZ4dUZTRmRlZnBhc3lQQUtyUzBhYmgzcVRqVFFMdGpuVmxLRGlDU05ZcG8v?=
 =?utf-8?B?K3liTWJRTnJhQ3BwRm9iczVtVnNGN1Zvc2JFc25hdXJaL1ZmTU9OOGpESG45?=
 =?utf-8?B?YjJnTkxNUVZpT1RSRDREYmhMZnhOU0V6WkRGUVdUenhpTklpTmkrNzFNTDBD?=
 =?utf-8?B?RG9xR2tTZFRNZS9xczlzcjBMbXdFVjhCWFp5M1hUVS95WU5WbHVraExyWG82?=
 =?utf-8?B?QTdGQmlOZ0hROTlQclJiQ1RJRGhnWnFWWFBzNEhuVWhRRkdEeHRDNlJobVpF?=
 =?utf-8?B?aTR0YkdDWDM1VEZqQWFhUElSOHI3VEpvaXBNeVoyVFByZktwSHBvQ3FFUDdQ?=
 =?utf-8?B?SmlGVUVhMTY4eHM1VUdtSCtCMVNDeXNVYTBxZkN4OGFQVUQrYmo3RkU1TWll?=
 =?utf-8?B?a3VCeUJ5Z1RiWTE4TUxrbVlITFBDUjc1Y2ZBRVVqOHhILzUwUkxweVVpZlFY?=
 =?utf-8?B?MERPc1ltd3U0QTZySFl3U3JSUE84RVZCS2NrQ2g1SVRCS2xBeGhsUUM1NTZN?=
 =?utf-8?B?ZnJXaTVlUEd4ek15cVBGdDlxeFhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BD9B6A53C813D4797888C6D87F87F5E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4718.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0046b6-2976-4c4a-39c3-08d9ecd54876
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 20:38:23.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8m0fLQ9YVg7bUWdOcTik/qVz+c4M6RRS/XVcoPSY+5weDrMWRkNdtDhMvshRT5Y3LbMI193dQsdyI+EW4vhyMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3602
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100107
X-Proofpoint-GUID: DNFC7IGx5iR-onJZVl3sYT1QAF5JRwNE
X-Proofpoint-ORIG-GUID: DNFC7IGx5iR-onJZVl3sYT1QAF5JRwNE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBObyB0b3AgcG9zdGluZyBwbGVhc2UuIE5vIG5lZWQgdG8gZml4IGl0IHRvIC1JIC0gcGxlYXNl
IHNlbmQgdjINCj4gSSBjYW4ndCBmaW5kIHlvdXIgcGF0Y2ggb24gbG9yZSAtIG5vdCBzdXJlIHdo
eS4NCj4gDQo+IFBsZWFzZSBjYyBsaW51eC1rc2VsZnRlc3QgYW5kIGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gDQo+IEFsc28gcnVuIHNjcmlwdHMvZ2V0X21haW50YWluZXIucGwgZm9y
IGEgY29tcGxldGUgbGlzdCBvZiByZWNpcGllbnRzDQo+IGZvciB0aGlzIHBhdGNoLg0KDQpKdXN0
IHNlbnQgdjIsIGl04oCZcyBvbiBsb3JlIG5vdzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjIwMjEwMjAzMDQ5LjY3MjQ5LTEtc2hlcnJ5LnlhbmdAb3JhY2xlLmNvbS9ULyN1DQoNClNo
ZXJyeQ==
