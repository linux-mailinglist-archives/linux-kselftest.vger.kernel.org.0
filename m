Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003F96A1096
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 20:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBWTdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 14:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBWTdM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 14:33:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E813B66B;
        Thu, 23 Feb 2023 11:33:09 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NGwd7C011867;
        Thu, 23 Feb 2023 19:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dEd73jarNPH1D5wgdAj9njvZsgzFCFSzy/iL8NTOok8=;
 b=gcbCd5JcdOy5OHN+HzI4s0qFf6ikvxjnM9PKA4Zt6ZIaBzx1wDym25iW5+wtwF6MUdAv
 rZ5Bkimt1xolg8bdaq/B/lH4HoAsye0hNPFK4Gb6I7WxerFUzXkG8zvoHJp0vSOcXCuk
 VnsWVtlxAYWieSjzu0kBEgJ26/IouzPXEpEZzcrn3hjN5IpCxHXyD8JzQ6ocxQYhg6TK
 vFGh/PPHcmmIFWIw5GHB/X6GYt8q2tZPBdS+FfjdpsajK+WiK/xceIvSeShYpZ5LZxqL
 YNi5TsLI6nbCOzA5dfAahMt4hjLXzp2ACWnGTysRWJqOlGLYFcHA3z5l9AxU0pGIQ2I3 Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tuj8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 19:32:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31NIE4XR030219;
        Thu, 23 Feb 2023 19:32:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn48gcjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 19:32:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1RYWDDbmvKymurK5w3guLV1DfimhR7W8c7OI6kSjbn0mMVI5PGrXOvfFMnEkmhZcnKjwXMfpT9VVXI5BsSS6t4Lnr7AaaY+F+3TEIkuIrAsy6Rw6L1PddQk98mMVXPcf1eHxPCoQf+aC6TC9g7/Znj2hfNo3Q2XtLdyeCwwisbJ/XGCwcCLJ1uRcFwaUGQWFZS1IXQ8z3wEeLRCwjfrf7H7+htmeflBa27Ds+4yE0rzvmPwjoCdI3S5zZHg6/S5Blmpag2P+HhHYn1nJvbZ8R/h1uFrDbUBxsT2V/XYoCpoAmRD0fVnmcqOMHF6jCP3u93Q86okD6VMluiV2Y25Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEd73jarNPH1D5wgdAj9njvZsgzFCFSzy/iL8NTOok8=;
 b=djIvYCzje3iQE8XMe4T/T1NFzklkR/yBA59sXSzn43ydk2OvjFeYTVsqls5lckNRGLZ0GqLcewFJaFILStJnDoY96NUaK/0exUfLpohg/5DuMReQsuyZccJJoqWcY4sfrkN2E538Wgo7uryGrSmd/T3vEPQt9y0boLt1Ao/sh/FFs+u3SEIObF2W6QsQvPDNLlsam1/A/a55ybpyTFCsIiVyFRiPlZRImPUHdXVc80N7EhRDo7ZzfvQaojdLOQwfKD+JH3lUfjZupGlzTX7HTHh1h0o9K0BqvGTSqJZdly3FJD00h9J9o5WkyMC0OvWQFoCnpKaOblisnYShBb43uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEd73jarNPH1D5wgdAj9njvZsgzFCFSzy/iL8NTOok8=;
 b=GgMSyMGAvhcySVxE3trpzH4kUAULdQeWu9IBOKC1+/JzDNlww+ak8tpQPyG61Ygl6NgSGhqh4zaS7lpR1SCUufPgspMnujxuy8/mjm/o1hwHihoHJ2GMFnbOFaCIjZoaVDi9B8NrQ65dxrj10yuvtL+a+nkLv3ljUJgpJhxlhKk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6354.namprd10.prod.outlook.com (2603:10b6:510:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.16; Thu, 23 Feb
 2023 19:32:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 19:32:48 +0000
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
Thread-Index: AQHZKQWoezbV6gQfMU2hAYqKspg87a7cvOEAgAAPVQCAABV4gIAAEUWAgAAJZACAACzWAA==
Date:   Thu, 23 Feb 2023 19:32:48 +0000
Message-ID: <59A88FB1-10D8-47FA-BF17-AFCE4B5915B3@oracle.com>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org>
 <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
 <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
 <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com>
 <CAMuHMdUG5cthYp3u6GeYqTqMaNgW0Ernq_ce0AZ22rgFQ5J24A@mail.gmail.com>
In-Reply-To: <CAMuHMdUG5cthYp3u6GeYqTqMaNgW0Ernq_ce0AZ22rgFQ5J24A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6354:EE_
x-ms-office365-filtering-correlation-id: fa7b3ac1-a6eb-4803-6668-08db15d4bf3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +IfQspjn7Wg8/sfBkMBAxXxmnJjOWmnLutjaV2URAi9qSamfnDmxtooFITqyoWzkWprFzZWJgNKhBfigwqnPQS+An6kMqthPcGgDw0i3TrYg3GO2SCCZB6qxxsIQybnvdAEB/nk1jEi8xxZ+n0pXur6FzHjQM5oSaDQB/p5noKNm+TV1xLLdYIc/AnUx9wLLmM8K8hroE0SqU3rHStDgRQC/6rgLr9jBju1+QbmWTrZ/er5142DhcfxUQk9LTiqSnwfM1607H6S3EtrEV2Hlht9UqKec1TpDtCPG/AxSitzEdPeRAQgKOA/AQPcnvfB+PGHsrQgxrcc85xkwX7PYZ6OGRiSM2Yzr/aS0yVM7QfjXRD9mPfJALfx4Dek0XWSS0w+ddWZecIhAh33wfjqTq64Gbpknq5TAQ5SMYz6tnF4v9Rm8tJU4PriycTx1P8IOVQIUQwg9XrtqW7azLDRZlehq6onnAW5rutIKwllhLbc+/AZT6hFqrsfjWb4DxEOnAKsjHIHplsed1KOFGpNeVC05kZWoNldHs7iAOjaDnEeEYqqXKlBqJSzH7x+egLp5+Lu0PbG/1fnlsNncWcbeIj5M6RzF7G8w+SLAWBujJZTOYQUxhECAxQuEstQ37idyHCpIAIMZO1jekcpmIBc0JI9TYaAR00yoBhuMfdMdqUWGU90dXDMZQiny1HxE+Q6qt83c9YMe1j07B1+naJvIytNSe9RhMxhjClNzYbvVB/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199018)(8676002)(66946007)(64756008)(76116006)(6916009)(122000001)(66476007)(316002)(66556008)(66446008)(41300700001)(5660300002)(4326008)(2616005)(33656002)(86362001)(66574015)(83380400001)(91956017)(6506007)(54906003)(6512007)(186003)(26005)(6486002)(71200400001)(38100700002)(36756003)(38070700005)(478600001)(53546011)(2906002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T5lajBFPiZNEJk845XH4jYMDkPtGygjuzKmEWzV8fJ7HZYMK5UWVselfZcZ+?=
 =?us-ascii?Q?L9f5WJFZ0yY3oUOmXyuUvTVnT5LGqDBfz3ih9QyLuB9d8N0maCoohETlwDRt?=
 =?us-ascii?Q?GDXIv9X6rhHLkdqVuTHHmA2djyIItj/jAHvI+r0cRF+dY2OHGMowqTHM7yE7?=
 =?us-ascii?Q?63vwuA8ek3y1WcejkkZ/jbFaksNE1VUTwlnkn2cR7vWLSSUSZpEp3FFwUJQC?=
 =?us-ascii?Q?QRSMrCuKeFevpJ967JskZGegLsFV8n4wzCsKEKeS0sFOiB9KIKX+xHMACCrT?=
 =?us-ascii?Q?n4p+Zq0dFJLm1K5Saoy4Hnlv4kZ3FacV/cKK0Pm5WFjyMLwBsPMQd1J8YU6q?=
 =?us-ascii?Q?GZHxQhrSjUh7Wz6MZYF3gYuZ4oEh/TaaEazySJgc6hrlXPy5ywDhcOODZzYf?=
 =?us-ascii?Q?DKx3einy9lUQX1hCsc06ZaRFN+lm8EWr5zV3127oTMIQUQEFzrifwXMkCuAI?=
 =?us-ascii?Q?/VZGB0of7ForweUM2qA2dqCN1tfz14Y8NQcGjPypYF7JJtM2Vwecz0zPnxdZ?=
 =?us-ascii?Q?a9kAX1M7O15E84EYxIY/p1QIfxsrOe9974Zh+n5RsdWPekU364H5Pad4P+GF?=
 =?us-ascii?Q?ZaqaBgrvB+d+Hz3oDKBs8iGy42ddSe+l9oXNt88PTgZDp0H7+dxeo3iVL42I?=
 =?us-ascii?Q?0CFOSV05kQ/19IpvRI12qThYJOHTZ4Wy7+258y7c2x8kKVlpVpma3EdrW8Hg?=
 =?us-ascii?Q?yDMF4uEoujWjwtu1UyM2LSXEjR2hJxvYNFzxVimBO1VBX//rCgYKc/WPpZCG?=
 =?us-ascii?Q?X3/vLUSL0QCLrtMae9BEc0ohMhMWeZ/yMBxil/MzUfGE7JJmWyXAGYGqy0mh?=
 =?us-ascii?Q?B7e35vXSSJm/cbcc1anJN5fBgK93CnVyMMjDksy8W8BkSZEd+Ql0ipFHGlHQ?=
 =?us-ascii?Q?QKvIgH3eKGUgb9KcRavKT75tRRu6AS3nhMoW7eyA2Am91cdjQR85rqFH6bht?=
 =?us-ascii?Q?QQHbOmw1U1hsAF12XipkWF4XGikKX1cYwYjE41r9Whv1UxNJ5V/eJk8TJfF9?=
 =?us-ascii?Q?im0eZzTp5Ao9TuuQyMEnGFisz9lhcNjXPuJKHiYSTYeVJLrQ5RA52sdR3mEx?=
 =?us-ascii?Q?4cpIgq9aF/Sy87WyxmP4dzsdtNWOrHD5XgHvk/gXCEgCKYzgLR+2XZZAH+IX?=
 =?us-ascii?Q?g/n+liBVPuR8I6vB2SAlltE1lTeOXBiKWhKdKrAr0WSfyLb/S8+R/uU66D/I?=
 =?us-ascii?Q?fABEfmw2yseUUIMJqT4ZnmTpP247ZFSZvYiguw052sv3et2FEJC+/zcQMt6y?=
 =?us-ascii?Q?6L/wkFZbFvWW5X5R/mWvJcjGk4tZKEOJNmFF/ATqkaQP1rCZmyZZoiCHfBvj?=
 =?us-ascii?Q?Gxt8K2+zPx3R/9uXEOMLg6U1y6AI0VozQ9ejvlV/pM0/B6ScNmBhlwJMWJc9?=
 =?us-ascii?Q?rZOvVfWb1YA9KyhQkw+YvBeJrmNUrzhkhCZnOCRc2oozb+wxsK42YJGYuCaM?=
 =?us-ascii?Q?fJsf/JC/mvhGvOr2+/DNHBoZxRgSFhEM2bXpf3cUrTn8vG0sLHe63efKb86K?=
 =?us-ascii?Q?erl9ohfM6wloQ8uzqhNLrO177sH0qsrvrm6ApsG8RpG/6ILt3a7AczzzT7SJ?=
 =?us-ascii?Q?IQyjPMJWBUDJtfrI1q2YBpNExxkmDY0yR4UwRtlYZxuOLFJYIx5duXJQI2L7?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97268AC2CA3F7C4F931E6B98C57FD732@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yucyaKx7uQKWACm1XAeK93gOaT0Cy5XGMY/OhEgyNL2F4cW5Y90/wnRtRuT5YOrSkFbfUKN+3iNzLBlIcxAc659v6ADpxpUGK4jgxtyyi8tYqUrfYJBS3ImpDOESKY+d/WiyRFIerluCKdgTc5Q0gDVE0e8fsu7WLZmxh9B2hlZsg5CNq6ugdvVpd2C3llmKTM5qjax5Rd/7kmJWGvLOoRUgIfo69Uekhs6sZxcXuXI2KS5Uwz/biBxAf69X1U2EM2ddCSfr20K5NpWJiLDN4iVJZDgHDQ6lgWgLQAWXt8XzIJycUqOhNMmOEb41Wy5Anbv9Bk6nVYUmN1wrUQnOIwrjv8SQGeACUdc+koHyd8P8ZcgNoqlZd10Y+pEQ0wWQwOp5iSTGNv/fAmADazuJ2i80qCBI10ELE2GAIikobLqNYZsUhbl9L2lE0Q0V/71YX8fT2P0LT6TO63br3N02LlkTA0TZc6VH5RrIgF6Q8Byq2UNVITiwBH0qI1kCpvaW4kWANuolV/TVx4aZtBKQHuP1hb2sTfx+vSfLR32GwL2bh44DtqeVcvRKU0uIk+DQmFqyO9Nl+F3w03VZoVSgNrhwJ/ecd/gMR1Y6JvhTzZuyL9vl8QlT4ZkJpx0rt+75PVIIS9/d7fT65ODaPRWHDU7lSMarsFoka8r9tTP/MZlPiuvHXngdg3dLc5c73CPUGstWxyWRcPGvk7iHXOTRNV4if+tmUQH3E74ZmUfkpP+rLeDhHorICALo3P3r5hIwFeMr5DEQIJIPVn78Trji0LR8v6YH1OG7OtEI/zFka5mixakwHVUufLGQmgOutueZWLUMjTjs55Xp1R0/RZTtVrH7L4OnFfeKQUIEiJeQ8ORrgQlBoE2rwpf8pR35DFpmCCOPhJt+nemdyJNmXqlERQKRYapy7O9eW0setLzxq/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7b3ac1-a6eb-4803-6668-08db15d4bf3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 19:32:48.8179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvWpnPnw+8U9FKAv48E6hpPZF7MhjPRf4/IPypAs29coa05daG5fhHBE0s2nAyaDAo7qxUgUSLm2TRBwKY1shw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230161
X-Proofpoint-GUID: RY7u9L-utksj8WfJI1elb5dXMTFL8ntQ
X-Proofpoint-ORIG-GUID: RY7u9L-utksj8WfJI1elb5dXMTFL8ntQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Feb 23, 2023, at 11:52 AM, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>=20
> Hi Chuck,
>=20
> On Thu, Feb 23, 2023 at 5:19 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>> On Feb 23, 2023, at 10:16 AM, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
>>> On Thu, Feb 23, 2023 at 3:00 PM Chuck Lever III <chuck.lever@oracle.com=
> wrote:
>>>>> On Feb 23, 2023, at 8:05 AM, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>>>>> On Sun, 15 Jan 2023, Chuck Lever wrote:
>>>>>> The purpose of this series is to improve/harden the security
>>>>>> provided by the Linux kernel's RPCSEC GSS Kerberos 5 mechanism.
>>>>>> There are lots of clean-ups in this series, but the pertinent
>>>>>> feature is the addition of a clean deprecation path for the DES-
>>>>>> and SHA1-based encryption types in accordance with Internet BCPs.
>>>>>>=20
>>>>>> This series disables DES-based enctypes by default, provides a
>>>>>> mechanism for disabling SHA1-based enctypes, and introduces two
>>>>>> modern enctypes that do not use deprecated crypto algorithms.
>>>>>>=20
>>>>>> Not only does that improve security for Kerberos 5 users, but it
>>>>>> also prepares SunRPC for eventually switching to a shared common
>>>>>> kernel Kerberos 5 implementation, which surely will not implement
>>>>>> any deprecated encryption types (in particular, DES-based ones).
>>>>>>=20
>>>>>> Today, MIT supports both of the newly-introduced enctypes, but
>>>>>> Heimdal does not appear to. Thus distributions can enable and
>>>>>> disable kernel enctype support to match the set of enctypes
>>>>>> supported in their user space Kerberos libraries.
>>>>>>=20
>>>>>> Scott has been kicking the tires -- we've found no regressions with
>>>>>> the current SHA1-based enctypes, while the new ones are disabled by
>>>>>> default until we have an opportunity for interop testing. The KUnit
>>>>>> tests for the new enctypes pass and this implementation successfully
>>>>>> interoperates with itself using these enctypes. Therefore I believe
>>>>>> it to be safe to merge.
>>>>>>=20
>>>>>> When this series gets merged, the Linux NFS community should select
>>>>>> and announce a date-certain for removal of SunRPC's DES-based
>>>>>> enctype code.
>>>>>=20
>>>>> As this is now upstream, I gave it a try on m68k (on the ARAnyM
>>>>> emulator), using a config based on atari_defconfig:
>>>>>=20
>>>>>  KTAP version 1
>>>>>  # Subtest: RFC 3961 tests
>>>>>  1..3
>>>>>      KTAP version 1
>>>>>      # Subtest: RFC 3961 n-fold
>>>>>      ok 1 64-fold("012345")
>>>>>      ok 2 56-fold("password")
>>>>>      ok 3 64-fold("Rough Consensus, and Running Code")
>>>>>      ok 4 168-fold("password")
>>>>>      ok 5 192-fold("MASSACHVSETTS INSTITVTE OF TECHNOLOGY")
>>>>>      ok 6 168-fold("Q")
>>>>>      ok 7 168-fold("ba")
>>>>>      ok 8 64-fold("kerberos")
>>>>>      ok 9 128-fold("kerberos")
>>>>>      ok 10 168-fold("kerberos")
>>>>>      ok 11 256-fold("kerberos")
>>>>>  # RFC 3961 n-fold: pass:11 fail:0 skip:0 total:11
>>>>>  ok 1 RFC 3961 n-fold
>>>>>      KTAP version 1
>>>>>      # Subtest: RFC 3961 key derivation
>>>>>  # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/g=
ss_krb5_test.c:52
>>>>>  Expected gk5e !=3D ((void *)0), but
>>>>>      gk5e =3D=3D 00000000
>>>>>      ((void *)0) =3D=3D 00000000
>>>>>      not ok 1 des3-hmac-sha1 key derivation case 1
>>>>=20
>>>> Geert, thanks for testing GSS on m68k.
>>>>=20
>>>> This assertion failure means that support for the encryption types
>>>> specified in RFC 3961 is not built into your kernel.
>>>>=20
>>>> The new Kunit tests don't work unless everything is built in --
>>>>=20
>>>> there's a net/sunrpc/.kunitconfig that provides the supported
>>>> build configuration for running them. I typically use a command
>>>> line similar to this:
>>>>=20
>>>> ./tools/testing/kunit/kunit.py run --raw_output=3Dall --kunitconfig ./=
net/sunrpc/.kunitconfig
>>>=20
>>> Aren't modular crypto algorithms auto-loaded when needed?
>>=20
>> The ciphers and digests are handled via the kernel's crypto
>> manager. They will indeed get auto-loaded by SunRPC's GSS on
>> demand, but of course, the set of algorithms used by GSS
>> has to be enabled by Kconfig options first.
>>=20
>> SunRPC GSS has a set of Kerberos encryption types that make
>> use of individual ciphers and digests. Those have never been
>> modularized, and they are each enabled by Kconfig options,
>> as explained below.
>>=20
>>=20
>>> In general, it's a good idea to make the tests test only functionality
>>> that is available, either through "depends on" in Kconfig, or "#if
>>> IS_ENABLED(...)".
>>=20
>> An earlier version of this patch set did just that. It became
>> quite a mess. That's why I chose the .kunitconfig approach.
>>=20
>>=20
>>> Of course that does not preclude providing a
>>> .kunitconfig to enable and test everything.
>>=20
>> The suite should test every Kerberos encryption type that
>> SunRPC GSS has support for. There's no reason to disable a
>> particular encryption type when running the unit tests...
>> unless I'm missing something?
>=20
> That depends: do you want to test everything, or do you want to test
> (only) the functionality you enabled for your product?

Each Kunit test is supposed to test one thing in particular.
These tests each test a feature of the GSS Kerberos
encryption type implementation.

So... they are really not for the purpose of configuration or
integration testing. I didn't have distributors in mind for
running these tests. They are instead targeted to kernel
developers and platform maintainers.


> I tend to enable all modular tests, so I can use insmod to run any
> relevant test when needed.  If a test suddenly needs something that
> is not enabled, you can not run the test without enabling extra
> functionality (which you may not want to enable).

I wouldn't expect these tests to be run as part of a product
CI suite. They are most valuable when making changes to the
SunRPC GSS code, or crypto code that GSS depends on.

"Did I just break this code?"


>>> Note that net/sunrpc/.kunitconfig has
>>>=20
>>>   CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=3Dy
>>>=20
>>> which needs KUNIT_ALL_TESTS=3Dy, else it will still be modular.
>>>=20
>>> First, I tried getting my modular setup working.
>>> After enabling:
>>>   CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES=3Dy
>>=20
>> And CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=3Dy ??
>=20
> Sure, I had that enabled, thanks to "default y".
>=20
>>> Third, with net/sunrpc/.kunitconfig, and
>>> CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=3Dy:
>=20
> [...]
>=20
>>> Unable to handle kernel access at virtual address af06da84
>=20
>>> I.e. a slightly different crash.
>>> As the difference between the two crashes is modular vs. builtin,
>>> this looks like an out-of-bound access in the test.
>>=20
>> Why not run the test suite just as I suggested?
>=20
> I don't think I can use tools/testing/kunit/kunit.py to run the tests
> when cross-compiling my kernel?

You should be able to... that tool runs under UML and
compiles what it needs to run the tests.


> My third case (adding options from net/sunrpc/.kunitconfig, and
> setting CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=3Dy) should be equivalent to
> that, right?
>=20
>> Since I cannot reproduce this crash and do not have an m68k
>> platform available to me, I will need you to continue to
>> pursue the issue. I'll help as much as I can.
>>=20
>> I would very much like to see successful test results on
>> non-x86 platforms.
>=20
> Thanks, I'll give it a try on some other platforms, later...


--
Chuck Lever



