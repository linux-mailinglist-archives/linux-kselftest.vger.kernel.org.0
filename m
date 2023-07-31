Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404A976A389
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 23:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGaV6p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 17:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjGaV6n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 17:58:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7501BE9;
        Mon, 31 Jul 2023 14:58:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKSujI011544;
        Mon, 31 Jul 2023 21:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=06WaDfOsiH7J6eLjsNLfpbEqY38yeKyWv9gSjSiaDcs=;
 b=GpAT5ySiHbAFvV5M+UJNjzjhkkBswOd2tzkWNP3caEc1itdZPV5Ye9lukjXyLWYSJMNM
 E+ltvwyHCP+IdZkkxGdhdX3K2UlCOADMN1u/JnrOXCgXwibhw/8qDr18uTkhgB4WqndQ
 BFLYCER433Epqt5Klh3VyBkgu6RyTfWKGJEi5sZYpcRJeovCkxNMLwgjHb606E5v4mdS
 k9ZHge020ECoh7gzlWb8CK200U6I0ViPzkYsbZxuwX1eoX/eZO7ZgjeI9UUJ2SdC8YtR
 JRH0IxzcaFlb2MbR0zwoRHFd1XIWzdfRTfYkQPj6i0Z9Iq+g6AkCbgCqrTY47gGZq1Dw nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sj3up5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 21:58:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VLLDUK037492;
        Mon, 31 Jul 2023 21:58:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bsu42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 21:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKZMeNNh3ie5TUZ64W1TxyNDWAP7tSRrPAVCkINhJE5m15Ew/o+BL1XxyHFR1/WhU+0kNZ2zxOhnOQ8fgOkqFpC9rmA+d5nZZoTd0xv2tPimSsACdF7tIpjfddaOWCA/hhTpWIOGueg+IlDbPQIOvi6HHprzTo1pTlW+OSM02bmCdATo4p083XCF8TYNXjgNk6+Ml/Z8cuCheilAkfedb4ltXElO3lghSwV0iji9HBlwBjpwAClIDR7BNl3wxlLlU95sYjo+pTBNpNnEsRnQNSrokt/Xau9FMCYie7Yz+plxKN3WMgKmaQ39/zfZWxAHRM3UVYcZs+elyRRZdcmICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06WaDfOsiH7J6eLjsNLfpbEqY38yeKyWv9gSjSiaDcs=;
 b=DlAuvUFWNYu0oJggc6heoYWLTiGPEPfhNCvJoSrdPL+UdEB1rt1evO9Z/kp0usUptu+GkRgaKM+qs3ihRJD0Gbrmy6cOwfcQ9f6R8LvQSsBvtfYDD33cRb1tkhPRtQI/rc44nLv/jicUwrVcmkWFFAqPd21gmcegFYs+bdJoF9gKhA85nCkm8VHs0xiBmDU2Ml2kuw1oAqQ3LJ6FE6tTeSYgI2ydtXLXUi7hdEXj4Yw+sMGlUB39WybohF39IqTXPlIxShjS+XmyfIlgtjjFXQTmyUqjyicP7lGoOzHhNs+jaxeNXZkPUqIxnzGW50I3T3QkmERTZLaTSGqnljAYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06WaDfOsiH7J6eLjsNLfpbEqY38yeKyWv9gSjSiaDcs=;
 b=HQTopUigFZhbiAS0atM84KkA1HxVbgz9g9cb3UvyIoUb1Tk4jWI2TzQPmK01bJ5sX6sX6bK2+Qj7BeKCfyFHJzXCiA8vnKBSBIm7NR2xQyd1nxwSYRyheBEPNu975z1OJZqRoodHfOC8RuhmpjLc11DFc33ryGeJWChVa88jF0A=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SJ0PR10MB6373.namprd10.prod.outlook.com (2603:10b6:a03:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 21:57:59 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::da5b:2093:7a3f:24a1]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::da5b:2093:7a3f:24a1%2]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 21:57:59 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] selftests:connector: Fix input argument error
 paths to skip
Thread-Topic: [RESEND PATCH v2] selftests:connector: Fix input argument error
 paths to skip
Thread-Index: AQHZwbL+rSqbLonr7Uq6rDDsC48Npa/UVmmAgAAMFoCAAA49AA==
Date:   Mon, 31 Jul 2023 21:57:58 +0000
Message-ID: <96F930C6-59BD-4119-B527-496E94832F6C@oracle.com>
References: <20230729002403.4278-1-skhan@linuxfoundation.org>
 <1471f593-1ff5-902a-a045-9241feda7bd0@linuxfoundation.org>
 <20230731140701.6c659cf6@kernel.org>
In-Reply-To: <20230731140701.6c659cf6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SJ0PR10MB6373:EE_
x-ms-office365-filtering-correlation-id: c63ad268-0489-4825-8132-08db9211341e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BATZYzM4lOLQicxSRkvJ1U8JP0ZjaWWQ3yDYzhxvA23tqtLjcqtItSWSr60/G7BPXecAMTA1nE4MKUpEzKyS4YgDC2xKJpVwu+RwExiTOqci56FNGaiWHBSAsD71p9gYAwfCTPeG/wPCchyukGi0l7KPV0f2g44X4iIk8RXpGigROhZh0Cr6Q6+xZ9hw4Vu3nkR4yAZi5LBWI6jlDzhkUZchkU8Hzxwn0frKmsdyKYqZ8HpRgza5VyE/Ta4fYpyHp01dGyPiyQSGeehJwtv9tPR5j0fxY6c1fyAz1yxKZmUd+FJEMavG12OOHJImXxqgWaQii4fPIInBLfEGvVF0I1W8obbX0z8XQBRoLbNvF1N2VydCYdi+dZqfO/+LuUmpjx1+rfiwmLbByl61qU6G55kA7/UHb9XmaIlA/smTS3BstcPQ7Kt5Qu/sjnpgVRkCb+2FSkeSQ4dGXEuoj8OOhEaA/RC02VS0qg4tqft6EJk4lZIN2N7qKqvuDRzhuyP5JazWFMBrHX8KBDTCs2Gp+bzDvO3SeLu0Jv9YldW1Qfx6WRlHMilXwipu1zYXH9O9l5skGW0gvIR691sMFpsGRww2fc11bCNkrAoG1ybEMglLG54Dxfi71lD242GXRBWxCsZNIp4YL+24RLDXLnY49A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(6486002)(6512007)(86362001)(71200400001)(38070700005)(36756003)(186003)(2616005)(83380400001)(26005)(6506007)(53546011)(38100700002)(122000001)(33656002)(91956017)(6916009)(4326008)(66556008)(66476007)(76116006)(2906002)(64756008)(66946007)(66446008)(4744005)(316002)(5660300002)(41300700001)(8936002)(8676002)(478600001)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uMomKDPYVNs6qBKs6nJtnnOb8fKO16H2y0GqrVprMdT87kbUrdVD6OIilu5r?=
 =?us-ascii?Q?YhS8JuwWaZfxVR+dzUkeVbAJn+Rt0eHmwTwJH6d8YuOVkVbUbLOKBs1jmr4P?=
 =?us-ascii?Q?7FIB+cAIXS7S/eX9rUpsj2XEVAyLQMn9BYIRoZJEs09nEESC2zcGBiWwHRwX?=
 =?us-ascii?Q?/9YbXxakMcO4qN2/T36mVx59nMAor+TSWTQNQuuNOnILgRMQ3ysZML8T1Ubw?=
 =?us-ascii?Q?67V2/8cXue7qQUzKLxhqwlXR2j/9i4NP6cWoKnZZ67tHS40ZzTQnJRTpce59?=
 =?us-ascii?Q?vifVHBPznr9g1bKgLv0JAzITOBn7z+m74unUvXgNAkaSNnHD/kRgXPDf6liI?=
 =?us-ascii?Q?GfXAjpncEPJtvmJ8zwBnzxw0EQJuNQeAeUCD0SirjDZsogzhtDFJ+JM8G3F6?=
 =?us-ascii?Q?y16nu0a8OoL68zmF0b+jRylLrpiclV0F5qGSzlCqrpyiZfDOFhJ4HbqciwIZ?=
 =?us-ascii?Q?BuUfbTcCucePgNFiQdsII0giwqx8/PEhPYTP5wDmx1jXp7nqYLWVEPNsX3YE?=
 =?us-ascii?Q?5+C84aVg4iZghWTXbakGQl3lz0CakL9FWEjNDorAz1hTArIw6YP/HgYa4JZ/?=
 =?us-ascii?Q?sVxVHNrmVBXomtf8Ltqcd+amgW0IDrHzH2SSbv3jIt551hkuKHTzgoj5vnlG?=
 =?us-ascii?Q?lZPxfhY6BdRWEzFrlfT4ivh5RBDKsWWzBP/Ac/Ok6PnLS0U2Tfic9+B+jMJm?=
 =?us-ascii?Q?2X7VOQwPSpXHze3pKOiXiCD3dbmnNrT29GPI7rPdt81Don6vLj9iqsgRK0g3?=
 =?us-ascii?Q?f9XD4SPRqk7bq5okAwZYY4+aLOttwHAg5HNuk/sA+CvyGSm7TghXrKw1SzbG?=
 =?us-ascii?Q?T1ntLTYsVLHpWYWiOlFAGiV5TnABlvej3+YWIhMWMpvF4guEAb9c4++XiI/j?=
 =?us-ascii?Q?bDNdLV79Knna43JV5oT5tfSIxNlMYOCAAuzwwcWkCsj/tz4u2OM+nYZOVcaj?=
 =?us-ascii?Q?BrDxSHaZXiXObSK9/uVpBAqF12f3KazPmM/qMZXRJ922RTELbKbu+jxdoCl6?=
 =?us-ascii?Q?lWqIBSIDrUX5FuKXHU4Js5o5yKmNTkQv6Rin1snVUy9HmOhb9+vgq0k4+gSV?=
 =?us-ascii?Q?fzaN4cUhoo3Q7Qp9mOv+ZrMhkwLcV2gaVDjsGhHppthF1LpxDxBy2kN8nNnO?=
 =?us-ascii?Q?JIsmvmYMsvr8xtkab4PA+SMv+DD6KHackHzfx9tjtMFUhS3g5fwX/fMudcEE?=
 =?us-ascii?Q?O6hIIP5+8yAa/6PF69LSabRYW8eKEFgwP7FfgOp0L2inq1bYIsLSwhulghIz?=
 =?us-ascii?Q?GYpJaZRdwUL29PczYrXp9p4dcMrn9DD3D2jVl2352Zq1u954OF4czN/kp9dc?=
 =?us-ascii?Q?LssTsr1jGqiJitKnuHILuJjxi/KcF61OjH/cdkMcmI4FvJVaS1Hv4v56Gpsx?=
 =?us-ascii?Q?UCqKPAg66dlo33lPb+UKJ7f7J38WJJDlnMgONjGGCk3hnTjmqy0qAoKm8jh2?=
 =?us-ascii?Q?dROqN12Z/MO/ecDSAAkEIZ+/nFlwiUZkr2rJ1hH7qx9UU58HSmEa6g0UQ7cn?=
 =?us-ascii?Q?PZyVaCE/eMywU+XaYmoTlV/VUiO3lMeHXRPzkUfzy+lEWv7pdduktF/75yDi?=
 =?us-ascii?Q?gw5XVhguz26a3bQfl5plySuH1qlJaCF3WlIpjQarvFn48CjeLRHzr4LJYAYh?=
 =?us-ascii?Q?lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <03C775B9B19C764B908532ADAF0B128A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 65smfJS4+0TY/BKElehiagpLA0Dfrf+24KW1J/E1eSdMmBsZhHg53i3AvXf5VTK0bBSr6JlZ/e6viguq8L5LujpABnKvkPISWnjHCjmzwzki8WquTizB02i8bOFcdcwkExLVoDTsLxGSoypH6axnDRtUWzUzIb1TwQj/dTMyUQBkK6sT4S+ooBAt/QR3oaJHMlVgUy99l9uJ0rqppZq7QB845tm2K/DdXtxxdUM5HJ6cBMU4nmGibZeAvYhar8lrDTVEswQwxHHc+GSC+DSLX5CsE7iXg0VSTba1Ic8JIFNL+0fdkmAoNRhlPsF1TsBCgNFLNVW6VOZg6c+0kPMmAG2/gJ9+quCoi4of7NS5JRKVLWYaCq1FoGvKneruZi6FFOi8uUkH4Yu3kblBVgAV+lv5V3YhswXbjfSLRnWhmpOsQzuz0NIfD7WNh0SCid0JRMzCbq7wXKzqQS/nhHTdQYh+3JWtEf4xTTCW1DqXcRF52I4AgTw+od4F9ZMIGbKPzGrPQUshDp2b7q/negzY7ioOREYPKKOkLmByrgBA/4LJqkryb0v3m+qxoQFKzx2+8y11qR60t/DJiecu/OuDIAylPLtYrp73A3Hy8JtJoInb7grgPxjGZHMJelHji8vNIZOKOny3B1GhmymfrSzSnjSo0R0jCSzp8IfP3Er5s460r+WZkmiIIivXRwg5sw6hSA27RTMKK5VpWDVfeOiYHwrssUCPJXtXmxQgGJXd6W/zp+V8Bs+w2L9rvQY150IXtaeuZEPCQ6i2iW6wqqpTY8r0uXoG0+6N924O2JfLnaTQOyVEaTucD7FEtGSfdHbuzDZx2Il3h7fo8DrE2cVWei0MPKzj6uQ1G/4EM4sn1NSJ48vDLJB6kNU3roRags0d
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63ad268-0489-4825-8132-08db9211341e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 21:57:58.9445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xj3nKzI27dw857CD85n+vBfRBO+d+ZXN63diTF//NsbmwE0YiZbB6RzbZUXLyDxLqmdvDSQ1VDIT5boOH6sl82NM/zFFNSR0+1jmEu6dZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=822 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310200
X-Proofpoint-GUID: VEcdfAjcHEgfIHqDNZ8IbzOEqbPIERNi
X-Proofpoint-ORIG-GUID: VEcdfAjcHEgfIHqDNZ8IbzOEqbPIERNi
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Jul 31, 2023, at 2:07 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Mon, 31 Jul 2023 14:23:45 -0600 Shuah Khan wrote:
>> I sent v2 for patch 3 in the series. Do you want me to send the
>> entire series again with this revised 3rd patch.
>=20
> I think it's all good. The build bot couldn't parse the partial series
> but the patches are pretty trivial, so low risk of breakage.
>=20
> Anjali, it would be good to get your Review / Ack tag on this patch,
> since you're the author.

Yes done.
Anjali

