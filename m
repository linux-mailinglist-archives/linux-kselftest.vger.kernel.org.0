Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1616A0DB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 17:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjBWQTL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 11:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjBWQTJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 11:19:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C3A1E1C0;
        Thu, 23 Feb 2023 08:19:06 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NAE0S1022472;
        Thu, 23 Feb 2023 16:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6UknSPIsnDXNOdgtprDSVUO+Gt8T54dLcZrdOrLrHBE=;
 b=j0ASLB59z0sg/hC3F8jtZHgt6+99vLj6FQw1tZ6CTJhRJhFgORzwL3yof+OlsBu4Jgo2
 cgWxXvD623QApkuHNsuzRf8yQfyzFXPlzHBaUHhAFkeofyegkfTWfKYcgLJKiXkuBx5Y
 j0vtarJzkkoWA8KpEN/Tmv5XOiKHmuTJkGG5Y8Yg9mijjzJFPGz69LbHao87hdm818Vr
 k/ko+KQsUqaexTFpQTw8Ogd5bQokaKXyMboVeJekyaGuOY8o1SSQffvtKl6NkwJwUTkx
 G70Ki0P43TEc6wiiKQuHACun/gZOSro9bCBCTaffOCZMMHsnPPPelbZrB3q3zPcE0sHs +A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqck20w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 16:18:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31NFBMOq025878;
        Thu, 23 Feb 2023 16:18:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn488g5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 16:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4Rt/PZ7zC7G5CYVOlTHs6bKhqVchpRami+HIdHGgzVUsjRb7tveU8Pg7rxX1c93CdWboYXwfAnD0y0AWwcmE/nBAFCLIfX55qPgsF1fK0R8b/yI8kdS73qpq/v4f0Kzg8A6PF9O0+2h0ObKDOeubMekGd7OwLEm0rWNeFiOQy7w8vUXAgiSzAHprX1ivfA1fBx15XcknAdp4YLGNrswwnsh8+C+V07qWhhtOrqSQ6LkCAy4mfva5FUr6QR3hiA35LkwUblVEzt+GQArgpcKkAZG9s7gxvZu/CPBPnK+5sRvtEfgMjsfzwBCkf4DFNO3/O5OUl/cuFAwQXRMSlQTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UknSPIsnDXNOdgtprDSVUO+Gt8T54dLcZrdOrLrHBE=;
 b=UydL8FZBIiFPQFRNWduof2Rpx8ockXBo02C2t8V98DP6dyoE8BMch8GM7oBdNblgXUzlXE2CuJfgNGVU9ixwFzL+f4fzelM5v4RB5XW5t16cMXFPyBzOuWVaWxio8qLoG44ca/yGtIiLlTYKixwcAwkw0BzjF8x6+1DWFBt3QreNNUQykkuelFhRKm+9Be/F8CYxU1X0fpvysqPHBV5tzpqOZ/ZvZLOyruWyF571lgQBSLI91ufHzBypMjhGynci9J0+LcU9+JXIZ9APUFM9tIZHLKhFZZ/hKXKWSTmIxqh4Hw8NVMKe83hmHqqAkoXXbDBxyESAlev2/u8jbGycxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UknSPIsnDXNOdgtprDSVUO+Gt8T54dLcZrdOrLrHBE=;
 b=koiPfd8FRDWhTGf+c36zz30krRSvoBaRn3Wi9sHReHedekM86d6LtFsmZZf556iQUk/ydFKCDlpKBR3IBuCtw1FnKldUkq6ptLez5sqbI1gqqYCvCz1pSfmLLs5R+0hnyAapsxz8JUiOOr2ZOZUnJai87tMX4RuvOqDdot6Mytk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6590.namprd10.prod.outlook.com (2603:10b6:806:2bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 16:18:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 16:18:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "simo@redhat.com" <simo@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
Thread-Topic: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
Thread-Index: AQHZKQWoezbV6gQfMU2hAYqKspg87a7cvOEAgAAPVQCAABV4gIAAEUWA
Date:   Thu, 23 Feb 2023 16:18:44 +0000
Message-ID: <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org>
 <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
 <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
In-Reply-To: <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6590:EE_
x-ms-office365-filtering-correlation-id: c81c4246-d3ac-4d73-26ea-08db15b9a28e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AVqmSLviS8ZW6Qg/u+Q0wE6MqOPPfHLGnq1EVaZKBBfdG4DSm14uANR8EAzDXmLeVILzjMP1wU0MG3M3toSWgiSvx9mSXe7H0QOAY06zeQe2b7i37MQW1OK2r73/+aJHD9d1yz7AlRLyyBiOmLUn07pphu6c4wQtp8FYLToKw4dfEVX7zexc67EuviG8L42V+uonekxtC+QT5b0Ak4Jdrb/ezHZDM6hmSPTDQE2szRtnI6+7so7aH42XdFo/Ne6zWHSghx9RxzjDb63+m3SeqyZZQrmfeWrj54ZJ4d3pN7OqZyIH9k4o/PGcfioidQuS8hP2L7iq5hSEG0woXo2gUmHljYUTlmpQTJ7dUmfqiPJgXAC2uYrr8T+w7d4s57qUAX135Gb7Trr5wd1TwP+EHCvAmsjr5O78kBYINJJuHCRkWMyNw1dlM4t2IAwoKAJdKWpzmndDN6Oa4m729xIA2deJtt0o8Wp8hJiBcF8xgmWl/5MCc+xTPNcdmePr44VzlxhspudV4q0bBfxW3gS5w2oTDbMUFz76Q7bjchXXxAlaBkeMJSSbiY71X/QeS/4ymHjUs3U2oBQvd86UPEjvhDI4hzX2SKp62oyhnN6SB2thC1JtawuPSNr9VLcsXcju67FSRz+jD+1AVbP1dv8GxU/3eLWFWJYpgJvw8swucOBbQwz+2Ee2rOh4O2dnCOmQHnavS2DYAgQr6bSH7EMcyxq9a1mJdFcmETeumKZr7EI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(122000001)(38100700002)(71200400001)(2616005)(66574015)(83380400001)(36756003)(186003)(2906002)(6506007)(6512007)(53546011)(316002)(54906003)(5660300002)(26005)(66476007)(41300700001)(45080400002)(76116006)(91956017)(4326008)(8676002)(66946007)(6916009)(66446008)(64756008)(66556008)(38070700005)(33656002)(6486002)(30864003)(86362001)(478600001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i74wag62p0/V00W2xy0MhaDcTUIzsHOEWyhVbymK3PHCjTzW7GRUFeXGyE7U?=
 =?us-ascii?Q?rX0y9JwRrAlByYvKwJ8U4852vNy3QW12JSAe25qGEgCNV8k8/IFujSGPmrKX?=
 =?us-ascii?Q?AAQHA3CBFs9tnDv4zKK/BUr6ed0RPgm8JKacbbdsOe9E5CY4hDOrNQLfEPje?=
 =?us-ascii?Q?OlVPpKGtFkpG9SGZ+6JIGaQePWEYMSwZAfud2XOCckMccTUvYYl1K74/yQNK?=
 =?us-ascii?Q?ALpwXapHHgIeSEDnV5S8PxmEQU0kx2UOrCMuF0qZ8it0caqW9yXDTneS7GYu?=
 =?us-ascii?Q?QRtYL7JGh5sTz1Vo1dSkHWsaA8bEqKAcfYSVB1pUmm40yXYF2dY3FNjMWkzf?=
 =?us-ascii?Q?HhfcEPs/BhArfPNTcIymj0Cpr4Fqg8YpLHkTK0GvyWm4+c9N+/l7uZ47pkXe?=
 =?us-ascii?Q?wgNAnCECKW3FEZ3DBWA8N5VcIBC9IpjiVMh3B6UClXkAxQgbrDyB53DDqw+/?=
 =?us-ascii?Q?v8QrM4P9meRHB7S1Mp8NUh5kpU1d96I2DIrhLtFomlSf8ib1z5aEYc7INxfr?=
 =?us-ascii?Q?ATeH5DIsL1p1r619ZSjyjrjoEbZrFIDeGakdFthcjUuNO9UQ5RNPy0b3fVRL?=
 =?us-ascii?Q?/rM1i0wCVboQOsRi987M/0ibSxjuzPJhasVGaAO8kKQHp31b1qedsHnMfA7f?=
 =?us-ascii?Q?tMC+RdTRpIUZrKQg+IuGqyoe9DvCyFTeCPqS4Es3Fw0Z6LnmqrYO6aht/rYL?=
 =?us-ascii?Q?d1rZV/H9w1lcPKGGPtKFpsUyfwc9su5ow6l3MX0jk9YwToPiBzIyfsdLJPu4?=
 =?us-ascii?Q?JoRBwRgQp1tUxBvcDCfrf2x959f5pHpJJTpAZB8q5EbFuqh4UnyZEayxeq9v?=
 =?us-ascii?Q?DWfXiul4CTV9jCDgXrgU7anTHyJBeFhZAa5GkKaAqucpkDvrhet1jiv7Xm1Y?=
 =?us-ascii?Q?OlPZiAl/L9AB1JFrdyUJkijoGJHq3fQwOD9bwQA9WSgk+ew09MqEjnoCYDhZ?=
 =?us-ascii?Q?41BXwW+DX61uWZxPNxaQqtRzniHvV9M+R2g/tObyr4/OSeaWnyuXgTIVGDEF?=
 =?us-ascii?Q?qjP5T7OtNNv/J6BkzQpg9VlUhcJ+oVK3bnyc+rIOdmp5dsRu7KMHYO3fl/75?=
 =?us-ascii?Q?0MmF+G7bF8O1mRYMHwLmx4nPvRPfCMderfercdjnhpOXestkQyRZqnsYG14j?=
 =?us-ascii?Q?tNFWyFLbtfoCYf7uCKf6MVjrep3uPuNTRqmnQ5IaOzcY1L7xm+6ymNSCBumZ?=
 =?us-ascii?Q?4+9LzNzmAnAmW/PSJd/Ys86oPWsBX6EsOVlIMnYV7qntLQU2qsY0wY23Xp/T?=
 =?us-ascii?Q?Msg/R0+3WA3rIyi4OxxjUYrer6suhEgXaABblcNM52DA57CkwhgblLr5zIDJ?=
 =?us-ascii?Q?pVenAX0cQL140xnwCEbEiTlsdfm+hx/qTNIsyyr/Md6oW98Eh2fCmq+7dvxL?=
 =?us-ascii?Q?wPsj7UBqtoQC8yw82cMXnuaSnTr64WTeJ0wp//iQYAs2PWbhukNLeCg0RUyD?=
 =?us-ascii?Q?LAJ0t3My6MKRBAwO1hjtEmDsKDhIjS6Epxxb8GFS1S4UDsOuFjEmqvDEE5O5?=
 =?us-ascii?Q?g0GXdkQMW6P4QcW6hQtV8dEEvj1ZVC0cMvlvpm3LxOEf+ueqiz2cZ9CiuYnL?=
 =?us-ascii?Q?QC/Wrk8kldjxls28/NUYFxr7hXyiYaM0iezyi8kVnS6q9vIsAj5jM36xemLL?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <335217E600454C459990E72001EAFDBB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lvr1PEqMgoW7aOcmHV0CzFME7nrYyLQ0yxa4ss7tkIVropWgbW6z2zP7nHg6CcfWaldpj3EkQjhOjjmeVz6dF1Bmokql/S2OoeDlyPLPgZwYtVZE1D29E+zY8V/6J1pWQb88emhoYqbhyFIe1788xCAp+aLFcYdPBo+pq5L0YGMzqpwUT7baW2Tm4NmxrJa6UyaXtq37DzSYjtQIAU+QZRjoE9zHA5M6udG2QFQI6bfllrMYdcl7rhYm4p62cncxLYFG5wz2L4rCmFkCGK3d9rWY9ZDw89LXRiN4hBh1sNlKgvnA61LhzkUd4zJmyReuwPzsf3221jehJenjRxP/0IJzuwEZUb+NvFYHJ0QR+ZaVyzUKP5jixqhwHuhwngT3a7ZlRTWMTKua56Z6EQmjOlXKZ1Gu3052TwFSVjgRevNK9Mfp7CVGxNah1f9jqi9Qnm0vz64XZZz7YWGdMaTtL4EDbcU1PAAhjmaTWGDGq1ibKHfyDMjcKV4F9ycLulh/VliGUW71tu64YUa60Hc62zM+R55vCDhcys/676hoaqgNeygWvpPBtkmP5ei79TZbkuY9YuIlOvpfmapIiwD+BSE7MN2aQMkPFrYYqLQ8sE1Wm9JlFYwZ7Suwis15aMRzpc4ZLIl2FOXa6Q0cp9dEtJt44RiXRBYNFbm+40DJTBN+uWUT7qkvRm/L5rsqrVelRmin65bPNQS5OXbwPLOQTzt/gAEwSy8xbxcSzUZ88MwQjN6GM0giX3IhB04ifBw6jXW1A13uK1PERz1RhsTInaKj18XR4RfSdDsz6kOgegdW1YXL8Dzktw2OpktTDVa2I/w/KPutqHSvhzmZSAUwvdYrHY+CMJFsZLesvV/uSR503tNDbLNXHz2A32Z0Z6NZplvqLz702hSoS/8AKNHs3zGZe5JEJ9cPxebeVLiuLlM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81c4246-d3ac-4d73-26ea-08db15b9a28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 16:18:44.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dx6z9xyiuDVXAhCFZkZ/7VMHPkBmGZSo/b2ZMExqibUpP5CEiTSJuMh5etn+SXyvSWdm6AkBPOtX6vvWAWzZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_10,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230134
X-Proofpoint-GUID: JfeqsN26db5mJCI4jrBsEP-zcpLI38_N
X-Proofpoint-ORIG-GUID: JfeqsN26db5mJCI4jrBsEP-zcpLI38_N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Feb 23, 2023, at 10:16 AM, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>=20
> Hi Chuck,
>=20
> On Thu, Feb 23, 2023 at 3:00 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>> On Feb 23, 2023, at 8:05 AM, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>>> On Sun, 15 Jan 2023, Chuck Lever wrote:
>>>> The purpose of this series is to improve/harden the security
>>>> provided by the Linux kernel's RPCSEC GSS Kerberos 5 mechanism.
>>>> There are lots of clean-ups in this series, but the pertinent
>>>> feature is the addition of a clean deprecation path for the DES-
>>>> and SHA1-based encryption types in accordance with Internet BCPs.
>>>>=20
>>>> This series disables DES-based enctypes by default, provides a
>>>> mechanism for disabling SHA1-based enctypes, and introduces two
>>>> modern enctypes that do not use deprecated crypto algorithms.
>>>>=20
>>>> Not only does that improve security for Kerberos 5 users, but it
>>>> also prepares SunRPC for eventually switching to a shared common
>>>> kernel Kerberos 5 implementation, which surely will not implement
>>>> any deprecated encryption types (in particular, DES-based ones).
>>>>=20
>>>> Today, MIT supports both of the newly-introduced enctypes, but
>>>> Heimdal does not appear to. Thus distributions can enable and
>>>> disable kernel enctype support to match the set of enctypes
>>>> supported in their user space Kerberos libraries.
>>>>=20
>>>> Scott has been kicking the tires -- we've found no regressions with
>>>> the current SHA1-based enctypes, while the new ones are disabled by
>>>> default until we have an opportunity for interop testing. The KUnit
>>>> tests for the new enctypes pass and this implementation successfully
>>>> interoperates with itself using these enctypes. Therefore I believe
>>>> it to be safe to merge.
>>>>=20
>>>> When this series gets merged, the Linux NFS community should select
>>>> and announce a date-certain for removal of SunRPC's DES-based
>>>> enctype code.
>>>=20
>>> As this is now upstream, I gave it a try on m68k (on the ARAnyM
>>> emulator), using a config based on atari_defconfig:
>>>=20
>>>   KTAP version 1
>>>   # Subtest: RFC 3961 tests
>>>   1..3
>>>       KTAP version 1
>>>       # Subtest: RFC 3961 n-fold
>>>       ok 1 64-fold("012345")
>>>       ok 2 56-fold("password")
>>>       ok 3 64-fold("Rough Consensus, and Running Code")
>>>       ok 4 168-fold("password")
>>>       ok 5 192-fold("MASSACHVSETTS INSTITVTE OF TECHNOLOGY")
>>>       ok 6 168-fold("Q")
>>>       ok 7 168-fold("ba")
>>>       ok 8 64-fold("kerberos")
>>>       ok 9 128-fold("kerberos")
>>>       ok 10 168-fold("kerberos")
>>>       ok 11 256-fold("kerberos")
>>>   # RFC 3961 n-fold: pass:11 fail:0 skip:0 total:11
>>>   ok 1 RFC 3961 n-fold
>>>       KTAP version 1
>>>       # Subtest: RFC 3961 key derivation
>>>   # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gs=
s_krb5_test.c:52
>>>   Expected gk5e !=3D ((void *)0), but
>>>       gk5e =3D=3D 00000000
>>>       ((void *)0) =3D=3D 00000000
>>>       not ok 1 des3-hmac-sha1 key derivation case 1
>>=20
>> Geert, thanks for testing GSS on m68k.
>>=20
>> This assertion failure means that support for the encryption types
>> specified in RFC 3961 is not built into your kernel.
>>=20
>> The new Kunit tests don't work unless everything is built in --
>>=20
>> there's a net/sunrpc/.kunitconfig that provides the supported
>> build configuration for running them. I typically use a command
>> line similar to this:
>>=20
>> ./tools/testing/kunit/kunit.py run --raw_output=3Dall --kunitconfig ./ne=
t/sunrpc/.kunitconfig
>=20
> Aren't modular crypto algorithms auto-loaded when needed?

The ciphers and digests are handled via the kernel's crypto
manager. They will indeed get auto-loaded by SunRPC's GSS on
demand, but of course, the set of algorithms used by GSS
has to be enabled by Kconfig options first.

SunRPC GSS has a set of Kerberos encryption types that make
use of individual ciphers and digests. Those have never been
modularized, and they are each enabled by Kconfig options,
as explained below.


> In general, it's a good idea to make the tests test only functionality
> that is available, either through "depends on" in Kconfig, or "#if
> IS_ENABLED(...)".

An earlier version of this patch set did just that. It became
quite a mess. That's why I chose the .kunitconfig approach.


> Of course that does not preclude providing a
> .kunitconfig to enable and test everything.

The suite should test every Kerberos encryption type that
SunRPC GSS has support for. There's no reason to disable a
particular encryption type when running the unit tests...
unless I'm missing something?


> Note that net/sunrpc/.kunitconfig has
>=20
>    CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=3Dy
>=20
> which needs KUNIT_ALL_TESTS=3Dy, else it will still be modular.
>=20
> First, I tried getting my modular setup working.
> After enabling:
>    CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES=3Dy

And CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=3Dy ??


>    CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=3Dy
>    CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=3Dy
> (the former is marked deprecated!)

Yes, that's one of the main points of my patches. ENCTYPES_DES
gates support for several Kerberos encryption types that we
want to remove from the kernel eventually.

AES_SHA1 is another set of encryption types that still has legs,
but will need to be deprecated because it uses SHA1, which is
scheduled for deprecation.

CAMELLIA is apparently not widely supported, so it can be
disabled separately.

AES_SHA2 is shiny and new. Some distributions might choose to
keep it disabled until it's had more road testing. But these
are the encryption types that are to replace both DES and
AES_SHA1.


> and loading all needed crypto modules (cfr. the .kunitconfig), I got:
>=20
>    KTAP version 1
>    # Subtest: RFC 3961 tests
>    1..3
>        KTAP version 1
>        # Subtest: RFC 3961 n-fold
>        ok 1 64-fold("012345")
>        ok 2 56-fold("password")
>        ok 3 64-fold("Rough Consensus, and Running Code")
>        ok 4 168-fold("password")
>        ok 5 192-fold("MASSACHVSETTS INSTITVTE OF TECHNOLOGY")
>        ok 6 168-fold("Q")
>        ok 7 168-fold("ba")
>        ok 8 64-fold("kerberos")
>        ok 9 128-fold("kerberos")
>        ok 10 168-fold("kerberos")
>        ok 11 256-fold("kerberos")
>    # RFC 3961 n-fold: pass:11 fail:0 skip:0 total:11
>    ok 1 RFC 3961 n-fold
>        KTAP version 1
>        # Subtest: RFC 3961 key derivation
>    # RFC 3961 key derivation: ASSERTION FAILED at
> net/sunrpc/auth_gss/gss_krb5_test.c:62
>    Expected err =3D=3D 0, but
>        err =3D=3D -22 (0xffffffffffffffea)
>        not ok 1 des3-hmac-sha1 key derivation case 1

This assertion means the RFC 3961 KDF function is not
available -- it was not enabled via Kconfig.


>    # RFC 3961 key derivation: ASSERTION FAILED at
> net/sunrpc/auth_gss/gss_krb5_test.c:62
>    Expected err =3D=3D 0, but
>        err =3D=3D -22 (0xffffffffffffffea)
>        not ok 2 des3-hmac-sha1 key derivation case 2
>    # RFC 3961 key derivation: ASSERTION FAILED at
> net/sunrpc/auth_gss/gss_krb5_test.c:62
>    Expected err =3D=3D 0, but
>        err =3D=3D -22 (0xffffffffffffffea)
>        not ok 3 des3-hmac-sha1 key derivation case 3
>    # RFC 3961 key derivation: ASSERTION FAILED at
> net/sunrpc/auth_gss/gss_krb5_test.c:62
>    Expected err =3D=3D 0, but
>        err =3D=3D -22 (0xffffffffffffffea)
>        not ok 4 des3-hmac-sha1 key derivation case 4
>    # RFC 3961 key derivation: ASSERTION FAILED at
> net/sunrpc/auth_gss/gss_krb5_test.c:62
>    Expected err =3D=3D 0, but
>        err =3D=3D -22 (0xffffffffffffffea)
>        not ok 5 des3-hmac-sha1 key derivation case 5
>    # RFC 3961 key derivation: ASSERTION FAILED at
> net/sunrpc/auth_gss/gss_krb5_test.c:62
>    Expected err =3D=3D 0, but
>        err =3D=3D -22 (0xffffffffffffffea)
>        not ok 6 des3-hmac-sha1 key derivation case 6
>    # RFC 3961 key derivation: ASSERTION FAILED at
> net/sunrpc/auth_gss/gss_krb5_test.c:62
>    Expected err =3D=3D 0, but
>        err =3D=3D -22 (0xffffffffffffffea)
>        not ok 7 des3-hmac-sha1 key derivation case 7
>    # RFC 3961 key derivation: ASSERTION FAILED at
> net/sunrpc/auth_gss/gss_krb5_test.c:62
>    Expected err =3D=3D 0, but
>        err =3D=3D -22 (0xffffffffffffffea)
>        not ok 8 des3-hmac-sha1 key derivation case 8
>    # RFC 3961 key derivation: ASSERTION FAILED at
> net/sunrpc/auth_gss/gss_krb5_test.c:62
>    Expected err =3D=3D 0, but
>        err =3D=3D -22 (0xffffffffffffffea)
>        not ok 9 des3-hmac-sha1 key derivation case 9
>    # RFC 3961 key derivation: pass:0 fail:9 skip:0 total:9
>    not ok 2 RFC 3961 key derivation
> *** CHK ***   FORMAT=3D2
> Current process id is 785
> BAD KERNEL TRAP: 00000000
> Modules linked in: gss_krb5_test kunit rpcsec_gss_krb5 auth_rpcgss
> oid_registry camellia_generic sha512_generic sha1_generic md5 cmac
> hmac ecb cts cbc
> PC: [<1187775a>] rfc6803_suite+0x2/0xffffc688 [gss_krb5_test]

Assuming that "PC:" on m68k is the same as "RIP:" on x86...
this does not make sense. rfc6803_suite is not a function.

1416 static struct kunit_suite rfc6803_suite =3D {
1417         .name                   =3D "RFC 6803 suite",
1418         .test_cases             =3D rfc6803_test_cases,
1419 };    =20


> SR: 2200  SP: efc1339e  a2: 01b4e610
> d0: 00000002    d1: 00000010    d2: 00000014    d3: 01b57cc4
> d4: 01b57c44    d5: 00000009    a0: 11877754    a1: 01b57c44
> Process insmod (pid: 785, task=3D52ae00a3)
> Frame format=3D2 instr addr=3D1187775a
> Stack from 01b57bd8:
>        11869860 00000000 01b57c44 00000000 00000005 00000001 00000000 000=
00000
>        11877e5c 11877e34 11877be8 1186a4d8 1186956e 00000001 00000009 000=
00000
>        00000000 0000000b 01b57cfc 00000001 00000000 00000001 00000002 000=
00000
>        00000000 00000000 00000000 00657333 2d686d61 632d7368 6131206b 657=
92064
>        65726976 6174696f 6e206361 73652039 00000000 484e4f4c 4f475922 290=
00000
>        00000801 000c729c 005d6074 00000000 00040cc0 00040cc0 00000000 000=
00000
> Call Trace: [<11869860>] kunit_run_tests+0x2f2/0x3d2 [kunit]
>=20
> I.e. -EINVAL later, so something is still missing.
>=20
> Second, with net/sunrpc/.kunitconfig, and just
> CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST still modular, the tests
> succeed, but there is still a crash:
>=20
>    KTAP version 1
>    # Subtest: RFC 3961 tests
>    1..3
>        KTAP version 1
>        # Subtest: RFC 3961 n-fold
>        ok 1 64-fold("012345")
>        ok 2 56-fold("password")
>        ok 3 64-fold("Rough Consensus, and Running Code")
>        ok 4 168-fold("password")
>        ok 5 192-fold("MASSACHVSETTS INSTITVTE OF TECHNOLOGY")
>        ok 6 168-fold("Q")
>        ok 7 168-fold("ba")
>        ok 8 64-fold("kerberos")
>        ok 9 128-fold("kerberos")
>        ok 10 168-fold("kerberos")
>        ok 11 256-fold("kerberos")
>    # RFC 3961 n-fold: pass:11 fail:0 skip:0 total:11
>    ok 1 RFC 3961 n-fold
>        KTAP version 1
>        # Subtest: RFC 3961 key derivation
>        ok 1 des3-hmac-sha1 key derivation case 1
>        ok 2 des3-hmac-sha1 key derivation case 2
>        ok 3 des3-hmac-sha1 key derivation case 3
>        ok 4 des3-hmac-sha1 key derivation case 4
>        ok 5 des3-hmac-sha1 key derivation case 5
>        ok 6 des3-hmac-sha1 key derivation case 6
>        ok 7 des3-hmac-sha1 key derivation case 7
>        ok 8 des3-hmac-sha1 key derivation case 8
>        ok 9 des3-hmac-sha1 key derivation case 9
>    # RFC 3961 key derivation: pass:9 fail:0 skip:0 total:9
>    ok 2 RFC 3961 key derivation
> *** CHK ***   FORMAT=3D2
> Current process id is 716
> BAD KERNEL TRAP: 00000000
> Modules linked in: gss_krb5_test
> PC: [<1197575a>] rfc6803_suite+0x2/0xffffc688 [gss_krb5_test]
> SR: 2200  SP: acd229e8  a2: 01ae20a0
> d0: 00000002    d1: 00000010    d2: 00000014    d3: 01ae1cc4
> d4: 01ae1c44    d5: 00000000    a0: 11975754    a1: 01ae1c44
> Process insmod (pid: 716, task=3D962b0746)
> Frame format=3D2 instr addr=3D1197575a
> Stack from 01ae1bd8:
>        001f3158 00000000 01ae1c44 00000000 00000005 00000001 00000000 000=
00000
>        11975e5c 11975e34 11975be8 001f415c 001f2e66 00000001 00000000 000=
00000
>        00000009 00000014 01ae1cfc 00000002 00000000 00000000 00000002 000=
00000
>        00000000 00000000 00000000 00657333 2d686d61 632d7368 6131206b 657=
92064
>        65726976 6174696f 6e206361 73652039 00000000 484e4f4c 4f475922 290=
00000
>        00000801 000c729c 005db3c4 00000000 00040cc0 00040cc0 00000000 000=
00000
> Call Trace: [<001f3158>] kunit_run_tests+0x2f2/0x3d2
>=20
> Third, with net/sunrpc/.kunitconfig, and
> CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=3Dy:
>=20
>    KTAP version 1
>    # Subtest: RFC 3961 tests
>    1..2
>        KTAP version 1
>        # Subtest: RFC 3961 n-fold
>        ok 1 64-fold("012345")
>        ok 2 56-fold("password")
>        ok 3 64-fold("Rough Consensus, and Running Code")
>        ok 4 168-fold("password")
>        ok 5 192-fold("MASSACHVSETTS INSTITVTE OF TECHNOLOGY")
>        ok 6 168-fold("Q")
>        ok 7 168-fold("ba")
>        ok 8 64-fold("kerberos")
>        ok 9 128-fold("kerberos")
>        ok 10 168-fold("kerberos")
>        ok 11 256-fold("kerberos")
>    # RFC 3961 n-fold: pass:11 fail:0 skip:0 total:11
>    ok 1 RFC 3961 n-fold
>        KTAP version 1
>        # Subtest: RFC 3961 key derivation
>        ok 1 des3-hmac-sha1 key derivation case 1
>        ok 2 des3-hmac-sha1 key derivation case 2
>        ok 3 des3-hmac-sha1 key derivation case 3
>        ok 4 des3-hmac-sha1 key derivation case 4
>        ok 5 des3-hmac-sha1 key derivation case 5
>        ok 6 des3-hmac-sha1 key derivation case 6
>        ok 7 des3-hmac-sha1 key derivation case 7
>        ok 8 des3-hmac-sha1 key derivation case 8
>        ok 9 des3-hmac-sha1 key derivation case 9
>    # RFC 3961 key derivation: pass:9 fail:0 skip:0 total:9
>    ok 2 RFC 3961 key derivation
> # RFC 3961 tests: pass:2 fail:0 skip:0 total:2
> # Totals: pass:20 fail:0 skip:0 total:20
> ok 31 RFC 3961 tests
>    KTAP version 1
>    # Subtest: RFC 3962 suite
>    1..2
>        KTAP version 1
>        # Subtest: RFC 3962 encryption
>        ok 1 Encrypt with aes128-cts-hmac-sha1-96 case 1
>        ok 2 Encrypt with aes128-cts-hmac-sha1-96 case 2
>        ok 3 Encrypt with aes128-cts-hmac-sha1-96 case 3
>        ok 4 Encrypt with aes128-cts-hmac-sha1-96 case 4
>        ok 5 Encrypt with aes128-cts-hmac-sha1-96 case 5
>        ok 6 Encrypt with aes128-cts-hmac-sha1-96 case 6
>    # RFC 3962 encryption: pass:6 fail:0 skip:0 total:6
>    ok 1 RFC 3962 encryption
> Unable to handle kernel access at virtual address af06da84
> Oops: 00000000
> Modules linked in:
> PC: [<20746573>] 0x20746573
> SR: 2204  SP: 05ef00e4  a2: 010195d0
> d0: 00000002    d1: 00000010    d2: 00000006    d3: 0101bdf8
> d4: 0101bd78    d5: 00000000    a0: 20746573    a1: 0101bd78
> Process swapper (pid: 1, task=3Db63809d5)
> Frame format=3D7 eff addr=3D20746573 ssw=3D0546 faddr=3D20746573
> wb 1 stat/addr/data: 0000 00000000 00000000
> wb 2 stat/addr/data: 0000 00000000 00000000
> wb 3 stat/addr/data: 0000 20746573 00000000
> push data: 00000000 00000000 00000000 00000000
> Stack from 0101bd0c:
>        001f64b0 00000000 0101bd78 0000001f 00000023 01015480 000359ba 000=
0209c
>        00000000 005890c0 0053aafc 001f7c88 001f61be 00000001 00000000 000=
00000
>        00000006 00000006 0101be30 00000001 00000000 00000000 00000001 000=
00000
>        00000000 00000000 00000000 006e6372 79707420 77697468 20616573 313=
2382d
>        6374732d 686d6163 2d736861 312d3936 20636173 65203600 4f475922 290=
00000
>        00000801 000c886c 006003b4 00000000 00040cc0 00040cc0 00000000 000=
00000
> Call Trace: [<001f64b0>] kunit_run_tests+0x2f2/0x3d2
> [<000359ba>] parse_args+0x0/0x202
> [<0000209c>] do_one_initcall+0x0/0x184
> [<001f7c88>] kunit_debugfs_create_suite+0x0/0x54
> [<001f61be>] kunit_run_tests+0x0/0x3d2
> [<000c886c>] get_page_from_freelist+0x176/0x48a
> [<00040cc0>] __finish_swait+0x1a/0x1c
> [<00040cc0>] __finish_swait+0x1a/0x1c
> [<00040cc0>] __finish_swait+0x1a/0x1c
> [<0000209c>] do_one_initcall+0x0/0x184
> [<000c86f6>] get_page_from_freelist+0x0/0x48a
> [<000c8500>] prepare_alloc_pages.isra.0+0x12/0x84
> [<001f6632>] __kunit_test_suites_init+0xa2/0xfa
> [<003a160c>] _printk+0x0/0x18
> [<001f7b9e>] kunit_run_all_tests+0xd0/0x1a6
> [<0039a0c0>] strcpy+0x0/0x1c
> [<00564602>] kernel_init_freeable+0x152/0x190
> [<000359ba>] parse_args+0x0/0x202
> [<003a6e76>] kernel_init+0x0/0xec
> [<003a6e8a>] kernel_init+0x14/0xec
> [<003a6e76>] kernel_init+0x0/0xec
> [<000028d4>] ret_from_kernel_thread+0xc/0x14
>=20
> I.e. a slightly different crash.
> As the difference between the two crashes is modular vs. builtin,
> this looks like an out-of-bound access in the test.

Why not run the test suite just as I suggested?

Since I cannot reproduce this crash and do not have an m68k
platform available to me, I will need you to continue to
pursue the issue. I'll help as much as I can.

I would very much like to see successful test results on
non-x86 platforms.

--
Chuck Lever



