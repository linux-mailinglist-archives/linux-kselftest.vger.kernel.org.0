Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16556724A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 18:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjARRRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 12:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjARRRC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 12:17:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4E582B8;
        Wed, 18 Jan 2023 09:16:55 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IGDrfh028723;
        Wed, 18 Jan 2023 17:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CC5qefIwyzDUUEzmJ81JxFbdXzD3po+kLJFYHpzYaTk=;
 b=hOCamFmQKPgreKq7r478n6J6dtgqdAuuOGfcCsdgw5gh8oKdeyoFLSClmVcmh9CBkS37
 WnZ5V+X/rG5L5dvwun9tf9qwSwesF9ELPy7WhRQSBytFgjwvaP4T4MaqFd3DKM++531j
 LxSDktQ/VReJVxkJjWXjoz4cuQiglzEn+0KIDXHOk4dK6Me6xa6b6deNV/hWIQ9vR3Y3
 6t7ZExOCCg2mM/uEPGy8dx4NSGn9xEh/e5vs5HfZRvqSrJzILUeFezehBW66XeV7XmXT
 G4yW0llu8QL31ywl2ufmDr1OHMAjsXfFTP+o9X+tXelG6vxO2HF7ITBqQtPC0D76oZxY kA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c82k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 17:16:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IGd2uX002066;
        Wed, 18 Jan 2023 17:16:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6mfqsq1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 17:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwMIfrS28R0njVanzPXdM4vbF6rxvAiLOGYtiBzaOdDaMZksnHLyYAn6uS+vO3s3UCEjxMmvIAOvxeBpw/nDwPqzd4nWQgsv4Iiaml578GMRpsD7YgUh0BdDRhpCxAreD7Qn8BRjK+r0zPK+bt/1T3ahBmaEgcQLCvBLDtRDKnRszqy0YPvtIGUS4xkJeO+GZ8aE9wxtf1JrPbEQfRylFK6NDNL7ko/OmwQKDFVXpg8nu+Vr06OafOuWBbZb9Mq2IdyP3Uf0DmIqBQoEUC8WpZg3LBMYqxY3GyD/RF3x6TLdCNXfslzPAGpUoqw3jszAYzhkB2XDszWsvxfTjW7jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC5qefIwyzDUUEzmJ81JxFbdXzD3po+kLJFYHpzYaTk=;
 b=P2Kv3aD1Jrqc80Fd3WZEwEpCmYSsvG+nJIgTxiZkOP93zJIAka/RCi3kxfg0VEzCM69mJ9jbnMUp9bwruCkHJlT7g9CsZ3ojHlWCVfQNDB3zzl5JpPNfjE0cFA0ZiKqJqrbmuLZya20IXSLb/a00B51n4+cwdLAo7lK+EEJygyefGzWQeh5jmfUJEjwvkBmR4ekIoodL7bLqgF9GdgDLyoSB+ySHZJKZGSAahL+8doUl1n3xZoXAPCQyILi2Y0ssw/6JWwWvPH+htD3nvwN6d2MoTmX+V7wmB12HPshkFwc88pijSHqfgB4zPHbc+kWpY7U9NO5rywTvl7pVs5qxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC5qefIwyzDUUEzmJ81JxFbdXzD3po+kLJFYHpzYaTk=;
 b=c/zmHeRYJ+mlGk/dOgVT+CaQ8MwBoVchFU5QbS7LCBwSa5RfeNIp52L/1OqtuWTGTUxJduUH0s8iXdzubso/PRU411aLS6xTlx05mnrh04co+hdqrQOOOWcakEg6UcfhXi/of4gr2TiEg3hB8xubX6kzlvegP19h8ztNShx86oI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4821.namprd10.prod.outlook.com (2603:10b6:408:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 17:16:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 17:16:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Simo Sorce <simo@redhat.com>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
Thread-Topic: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
Thread-Index: AQHZKQWoezbV6gQfMU2hAYqKspg87a6kWm6AgAAUyAA=
Date:   Wed, 18 Jan 2023 17:16:40 +0000
Message-ID: <2A8D4D96-E634-49F8-B67D-3CDB0D97C92E@oracle.com>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <0b96ee92145831afba9d099d948fdd0af1b3180c.camel@redhat.com>
In-Reply-To: <0b96ee92145831afba9d099d948fdd0af1b3180c.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4821:EE_
x-ms-office365-filtering-correlation-id: 7b2178bb-6cc6-420b-5bbf-08daf977c3c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExeFuDLrwbzEeSExNqQ6oXp+ao4U+nclA4gCoMF5jfYgwaK8955JJZUHUbACO2yugSIUD8VC8UpkZ63N9T2hMa6yQ0exQIKFM3SgDJBwkYEGbK7505Of3dOfoT0GA+Mbp/INHqLLYVIKVp/mSUi1GHHFFVNow6dREVGpFW7Xn9byP7FtkmT8Apmvf2cw6HLIZ0gS1loYyjbwlVJFWnI8m8IEwV7u0Tpz2CafMysGWCdt1Diid8oak43PgtIeo4cGIcb69lkBHebdlhZrrebnbNVxd3X3x6NBvF4cq07u8C45UkLu5/qs+2rb3yWITjImqiUnx4gUOEjfTxfJ2L8VCuuZvWVFGjie8jhgUExyQRJ2L94sZdJ+cVPjlmS73S8aO5iim76Aaa/JDlVMPUGBv77u73FqyhdKURxr0XqSJqC4KdrN2O6LxWpD2BqlguCn1xdbsaFyvpM4qMYvOMlq4gaqm2Hh/uZm7xdMWw649+ZiqyvmEaX2zlxUD8Geq9ufILXeu7ZzfLKfzsjvvOgdG2q3RDjf/Fom8Itl0b2uzFX13CRJTOFA+nEpOE9WWV/h26M8+kn1UkuYWYChSiNy+pyoFduB0KOEyTbV9gCfm8zY3WzXidYO+c9oi6ipGDp8JQyUcRAExfxqUbwNMzefz6aQG+cV9c6I8T8a/jDJCUJnEoXcVY6xTtyPKYsA9nJLsnOuI3MMYOKKSsyvATBlxtjPKmMRrK7hYMs7M2gM6tc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(38100700002)(122000001)(86362001)(33656002)(5660300002)(8936002)(76116006)(2906002)(66946007)(66556008)(91956017)(66476007)(66446008)(64756008)(4326008)(8676002)(6916009)(41300700001)(2616005)(186003)(26005)(6512007)(83380400001)(66574015)(53546011)(71200400001)(54906003)(316002)(6506007)(38070700005)(6486002)(478600001)(36756003)(66899015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W6Ml+9V7Ya/Q5bBV7TSXSBN4ifVG3kZSfVVD1isuqL3NivgvsmrtrGzpVglw?=
 =?us-ascii?Q?4FACKUeHRQw2Z2UD2qf2kcGYSdLl42Ss0Hzf814rssgB/1r8q3mHnmeAa+/Q?=
 =?us-ascii?Q?SL4f7QHEjXOUUnQB+I8O60lTLHcJuGfalAQgIIKhnWFygG8i04S3h6oUwwhe?=
 =?us-ascii?Q?LaoRcQFS4BcYEf30/JyHagc2OqcYMqynzU/EK540+VjKcxUAew9yG1/aAZJ3?=
 =?us-ascii?Q?zABd7h6VYjgaquA/CaSzhhDMSeTeNMtfM2tbn0GsT5ZltgvZ+gV8ZCaqysjb?=
 =?us-ascii?Q?ZTjTK+Q4yCUcg4KJiSOa7Q3tgNVdS2JLxS0C5kw/RHfy5uQjlDLL9eYdlBFq?=
 =?us-ascii?Q?TaALGwtNwOHOKORkTadnXgTdRKiazPv7M44J5cFfPVwcpNUuK9GmUElKbZ/a?=
 =?us-ascii?Q?nVzk+r3O60jMr2ftLFENOczUxcA68OSFCCJhuB1JeOkgE02Q8Mb0kMoCVhIf?=
 =?us-ascii?Q?S5HD3AKpWtG1BgwBKioTuLByr153hYs9WTtRvFymUVwPHGgKDYPAHTeVcRkV?=
 =?us-ascii?Q?2z2+ye1xjxc40tTip7zbugT3UEo4NouLfmesQbdIRILzq7wwX8CRP3hCF9q0?=
 =?us-ascii?Q?OxkYgAOs2Zi8IkApOEZWGxVoPkXWMQnhHBn0l0qDHuuGUdXVh5r1iaCcs0le?=
 =?us-ascii?Q?OI00iFCSsG8ZUuGLZi0d7yjQWFG9mJ2Gm+wmxpIxgq060OENSGMmFy9swTkJ?=
 =?us-ascii?Q?YvKtvexUOQSbdKHLIOTr1o3M4UYgym40Qj9tmDM+dUi5CsJrAN8UixJTVpDX?=
 =?us-ascii?Q?b1Oh67nczxD2R8R+9HSPpeNOWOVUkuDwCfflYthbPJyX3Kv1veRs5VUulHic?=
 =?us-ascii?Q?hRDj5dKK7UmCPaSG7dpzxGy8MsEMNr10cjPrlw827AxdTzENuX/V9iupMAZ3?=
 =?us-ascii?Q?0q0KLoKqC/3Jfl/Js1MiMBRsBlxx923bIgYYCuKmPsPFP6txgebC/GB+d51l?=
 =?us-ascii?Q?OFsvoLfV44V4vqAxTXutwS6uEH6bIH9diEJRloPiVZLznTJ2SUc68EsN0Me9?=
 =?us-ascii?Q?xKd+OZpTqGJqxqLl7ugKAQWa9iYXaTP9ukh/UvWP0xLy5VPau3hE8/tGTyiQ?=
 =?us-ascii?Q?O9ftIKrpZcwdL3L53sCP/rowCVwttzgY2E3RZ2BONi9kcXq0ZOc1LzCfhWv6?=
 =?us-ascii?Q?on50adRNw3UOJnQ2z8A5PbfrEEA7ifSQKrTsSwFNDHco9qanvFL6Do7adWG/?=
 =?us-ascii?Q?dMhEdmOh7stwhcfaNUrWSTBsqJEPntC+9b7VBUxriApYzp5TuKBoKP+RB6/s?=
 =?us-ascii?Q?cPRkogFQxt9oIImgway604fzqiyR4hf0DMaHsdJA15YFidp6NmvVxFsody2e?=
 =?us-ascii?Q?wJBi9Puvkx370n4R1xeNQMMi4ryVsADCxPooc1oLUvcMdVhToI9f6Lb4Jv3e?=
 =?us-ascii?Q?06NqaFD6E9tysWEuXAuy0lpDuNNgW+qA/rOpZbrIpxUTz1NBIEQmtON0Hapc?=
 =?us-ascii?Q?OF8Sl2m4PCpLE/be5XV5M5/qiedzAD0zAObFvU5yza/fco9t7u92l0EOE9/a?=
 =?us-ascii?Q?m/cDIFUYaAr3SFebW/HVAygd8Ijwc16ze6cV4AB7i4zV6IaggA+NGR7LLfZN?=
 =?us-ascii?Q?Mf1uMVSzCfGbKGYWew1StmjiaGgIpdxnyGFqypZxxzWtVSaO6cpA+WNrfSXv?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28D973EACD543845AD4B9631FF5D5145@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RdU7Ldk3GSt2/SHXsyKpS5LSAckUrCeQYeU8JVR93v+ADwc5xmDWel7U3/5/lYqUAziAwnDzLk8pBSdMj8J/BaB1OBmz7B9EBWrQZx50syzXHSuHbE2iP7dl51G8Xphbs5giSHGcoT+63AaighTdUQLN+teiq42WaFJd3/5S5C+5cqdaf/6n0JPdi4azuGmybShtt1C0mIvzwiqKll50TgmDbbT0xQkVMDneRfQFkk3UjmUC8QmdzFZqZ5TEchUgozEy7FqoFNMozFe+5UTs4Zauz8LcU7Czwm0/wbaN/VlHMrNUq07D93tgmAEmAzLy/nL53kQBx5YNhM1pA0zHugp0Dna369uhzs7dmya+TsB6L4Lm2GQZyGPodihTiTe/y9jvzi74KVJL+tShX6fadBXeLRNrf1xQ2EmPokR3AmjKZ/Wx0BRgBVeJ38SVARby6dcrVDthUc6B621KQlChuA+AOp4KvpVmk/K0mK3FPElE/YE7yFXTGm5weY2u31WXS1G6YagMAJMDolXatvdW01BBzY3eVCQiFPvecFVsYwbf7xF/nQ+NxlE/r0lJO2GGR2TJi0eD+XLts5a4GVDrAhBpK9XCkrZ6mrBWLIJh0A+4NVKAjNuIuTASzhVXOTZW98VIq49mpJEkwLGI/KK7i3w2UAudFzNit4pScaOv344gSJNsdD/yGmr7RExS8hRZRanCUj8j/r7gJrwEyKsh71zzE8H87zTA2gI4aBymgdPKCt20KdxZGPROdfGB55H9Fr33cXv9tE50bQnXHVLetZ0XC686el63S2naYYBAl1kYBC9op9Uhwf9XLqqz2CPh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2178bb-6cc6-420b-5bbf-08daf977c3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 17:16:40.6859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXXIV5vgqQ45sA/y3YM8XIw+RJGtS+RHVzOPhdrWdVNBuv1nHiDxXJ+lCWbXI9toexZFgQ66xzbq5TGfX+rFmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180145
X-Proofpoint-GUID: Qfxkkc6n1HyWVAfhrrlmRtYY3ZdYOiy9
X-Proofpoint-ORIG-GUID: Qfxkkc6n1HyWVAfhrrlmRtYY3ZdYOiy9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Jan 18, 2023, at 11:02 AM, Simo Sorce <simo@redhat.com> wrote:
>=20
> On Sun, 2023-01-15 at 12:20 -0500, Chuck Lever wrote:
>> The purpose of this series is to improve/harden the security
>> provided by the Linux kernel's RPCSEC GSS Kerberos 5 mechanism.
>> There are lots of clean-ups in this series, but the pertinent
>> feature is the addition of a clean deprecation path for the DES-
>> and SHA1-based encryption types in accordance with Internet BCPs.
>>=20
>> This series disables DES-based enctypes by default, provides a
>> mechanism for disabling SHA1-based enctypes, and introduces two
>> modern enctypes that do not use deprecated crypto algorithms.
>>=20
>> Not only does that improve security for Kerberos 5 users, but it
>> also prepares SunRPC for eventually switching to a shared common
>> kernel Kerberos 5 implementation, which surely will not implement
>> any deprecated encryption types (in particular, DES-based ones).
>>=20
>> Today, MIT supports both of the newly-introduced enctypes, but
>> Heimdal does not appear to. Thus distributions can enable and
>> disable kernel enctype support to match the set of enctypes
>> supported in their user space Kerberos libraries.
>>=20
>> Scott has been kicking the tires -- we've found no regressions with
>> the current SHA1-based enctypes, while the new ones are disabled by
>> default until we have an opportunity for interop testing. The KUnit
>> tests for the new enctypes pass and this implementation successfully
>> interoperates with itself using these enctypes. Therefore I believe
>> it to be safe to merge.
>>=20
>> When this series gets merged, the Linux NFS community should select
>> and announce a date-certain for removal of SunRPC's DES-based
>> enctype code.
>>=20
>> ---
>>=20
>> Changes since v1:
>> - Addressed Simo's NAK on "SUNRPC: Improve Kerberos confounder generatio=
n"
>> - Added Cc: linux-kselftest@ for review of the KUnit-related patches
>>=20
>>=20
>> Chuck Lever (41):
>>      SUNRPC: Add header ifdefs to linux/sunrpc/gss_krb5.h
>>      SUNRPC: Remove .blocksize field from struct gss_krb5_enctype
>>      SUNRPC: Remove .conflen field from struct gss_krb5_enctype
>>      SUNRPC: Improve Kerberos confounder generation
>>      SUNRPC: Obscure Kerberos session key
>>      SUNRPC: Refactor set-up for aux_cipher
>>      SUNRPC: Obscure Kerberos encryption keys
>>      SUNRPC: Obscure Kerberos signing keys
>>      SUNRPC: Obscure Kerberos integrity keys
>>      SUNRPC: Refactor the GSS-API Per Message calls in the Kerberos mech=
anism
>>      SUNRPC: Remove another switch on ctx->enctype
>>      SUNRPC: Add /proc/net/rpc/gss_krb5_enctypes file
>>      NFSD: Replace /proc/fs/nfsd/supported_krb5_enctypes with a symlink
>>      SUNRPC: Replace KRB5_SUPPORTED_ENCTYPES macro
>>      SUNRPC: Enable rpcsec_gss_krb5.ko to be built without CRYPTO_DES
>>      SUNRPC: Remove ->encrypt and ->decrypt methods from struct gss_krb5=
_enctype
>>      SUNRPC: Rename .encrypt_v2 and .decrypt_v2 methods
>>      SUNRPC: Hoist KDF into struct gss_krb5_enctype
>>      SUNRPC: Clean up cipher set up for v1 encryption types
>>      SUNRPC: Parametrize the key length passed to context_v2_alloc_ciphe=
r()
>>      SUNRPC: Add new subkey length fields
>>      SUNRPC: Refactor CBC with CTS into helpers
>>      SUNRPC: Add gk5e definitions for RFC 8009 encryption types
>>      SUNRPC: Add KDF-HMAC-SHA2
>>      SUNRPC: Add RFC 8009 encryption and decryption functions
>>      SUNRPC: Advertise support for RFC 8009 encryption types
>>      SUNRPC: Support the Camellia enctypes
>>      SUNRPC: Add KDF_FEEDBACK_CMAC
>>      SUNRPC: Advertise support for the Camellia encryption types
>>      SUNRPC: Move remaining internal definitions to gss_krb5_internal.h
>>      SUNRPC: Add KUnit tests for rpcsec_krb5.ko
>>      SUNRPC: Export get_gss_krb5_enctype()
>>      SUNRPC: Add KUnit tests RFC 3961 Key Derivation
>>      SUNRPC: Add Kunit tests for RFC 3962-defined encryption/decryption
>>      SUNRPC: Add KDF KUnit tests for the RFC 6803 encryption types
>>      SUNRPC: Add checksum KUnit tests for the RFC 6803 encryption types
>>      SUNRPC: Add encryption KUnit tests for the RFC 6803 encryption type=
s
>>      SUNRPC: Add KDF-HMAC-SHA2 Kunit tests
>>      SUNRPC: Add RFC 8009 checksum KUnit tests
>>      SUNRPC: Add RFC 8009 encryption KUnit tests
>>      SUNRPC: Add encryption self-tests
>>=20
>>=20
>> fs/nfsd/nfsctl.c                         |   74 +-
>> include/linux/sunrpc/gss_krb5.h          |  196 +--
>> include/linux/sunrpc/gss_krb5_enctypes.h |   41 -
>> net/sunrpc/.kunitconfig                  |   30 +
>> net/sunrpc/Kconfig                       |   96 +-
>> net/sunrpc/auth_gss/Makefile             |    2 +
>> net/sunrpc/auth_gss/auth_gss.c           |   17 +
>> net/sunrpc/auth_gss/gss_krb5_crypto.c    |  656 +++++--
>> net/sunrpc/auth_gss/gss_krb5_internal.h  |  232 +++
>> net/sunrpc/auth_gss/gss_krb5_keys.c      |  416 ++++-
>> net/sunrpc/auth_gss/gss_krb5_mech.c      |  730 +++++---
>> net/sunrpc/auth_gss/gss_krb5_seal.c      |  122 +-
>> net/sunrpc/auth_gss/gss_krb5_seqnum.c    |    2 +
>> net/sunrpc/auth_gss/gss_krb5_test.c      | 2040 ++++++++++++++++++++++
>> net/sunrpc/auth_gss/gss_krb5_unseal.c    |   63 +-
>> net/sunrpc/auth_gss/gss_krb5_wrap.c      |  124 +-
>> net/sunrpc/auth_gss/svcauth_gss.c        |   65 +
>> 17 files changed, 4001 insertions(+), 905 deletions(-)
>> delete mode 100644 include/linux/sunrpc/gss_krb5_enctypes.h
>> create mode 100644 net/sunrpc/.kunitconfig
>> create mode 100644 net/sunrpc/auth_gss/gss_krb5_internal.h
>> create mode 100644 net/sunrpc/auth_gss/gss_krb5_test.c
>>=20
>> --
>> Chuck Lever
>=20
> I reviewed the whole patchset (except the Camellia related commits):
> Reviewed-by: Simo Sorce <simo@redhat.com>

Thank you!

I've applied this series to nfsd-next. Comments and testing are
still welcome.


--
Chuck Lever



