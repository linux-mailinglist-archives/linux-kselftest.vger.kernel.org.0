Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6339476A384
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 23:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGaV6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 17:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjGaV6E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 17:58:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14148173E;
        Mon, 31 Jul 2023 14:57:49 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKUQkV029616;
        Mon, 31 Jul 2023 21:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eb9y4iXHWiN595+MgazV3TW5aUYpd3wKp7JTr+2wSrk=;
 b=rX0icMXPo/LfBm5jq70aaEeSzrBQQX1XEGlHOd6Y0X7m2+wjAFbigl35+/Uw20ykurbS
 WPMLx2ur6BvDT9Ozyl2BOPAmRkNEN7ULO6GCXuo4qm81AUMRKyTH9OA4cg8bRzQ3Mw4E
 u+c3oVhNycwIJop3ToRw81U3QIzZSc+0eHLEeFO5DDULVTMzNCkSmViG4oDDGigK2v3s
 fXzZmGWJhreJVY6c+CYonlt/3XyAn8AlBvuTU9siFGsOsJw6qeR+Uk9DfY0Dwy/Tuh0U
 lSNDm5NEF288Sb13uQoa1mGZonz4CJYa+csvi/bwD76YfRL8of56Mvqo1anQosC16Oks jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd3pqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 21:57:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VL11p0000812;
        Mon, 31 Jul 2023 21:57:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s75ahcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 21:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBJ5xZ0ORhsA3bkiPIszRQj2cm4Q/4PVSY5ANKholv+XL1z3DMg+QZbZRJAfJtxe+6ZWakinw8q85IwLiplPkSDMRoeU1ZNQT98raUSK6UCzEoAF/nFEhuXHf/KsAXEBwC7Y/g7xT/vCKVWgG8Fch/2UT9Yy8tEY8WIZyG761IX5qxxNVZe/XOwNGeYSHKB/c6z35RT4iUVAFosPg6YYQ2TOxzwzdjjG4M6/zlWL1prPYNKjLVTBzY/PF5rOWDK2fXh+sWjgWproNW5VNlnFA3My3EDWaH4eJXlaKvhNIuKIeZEwSjGX/VdlLkkS11oCcNpeqp84AE/61JdDJ0vBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb9y4iXHWiN595+MgazV3TW5aUYpd3wKp7JTr+2wSrk=;
 b=WjmUN1tS7IVRlrJkVXgH9xIeXzCgz753m3u3GFjiO6CEXw60j8W9R9QkW5VjnFqDUjMunRFwnW1iqfvXNh+WOpD+RM14omuqnQ/rZA1YfvURqv90e+DGUfBCKmjrktwiWOV7Xm1TFqrVPJBV++Ps5p4lKxwQcUgBRY2u40hremez2LxLh4hz95p0mq0wNRJi3g5Qi3frbnb87XFT/QZ3nEX7RJPOcf7FEtcSmLzRgfPF0W55viyoqZp/i+V6s0ieAELXpW5FXwVqDv33KfHi0lvhKdaC8Y9pUEM4pqXmXVp+ywlnHsdx8h+OBLfsjG9ixHsB5K621wqWc1DNu0mAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb9y4iXHWiN595+MgazV3TW5aUYpd3wKp7JTr+2wSrk=;
 b=r9gk0v40DgBbrttggnfYJGfV4rN6JgUvQg/sNX2/7GnlQWEs/AGNt/owrcSWE4oHF59v20Y8PEbTkOK4bNJbdz5nOJfKvJdPv6eqqdR8iBLMXWdU1xaEUdBCwQf6J6Y5zA/OCYHEvKw+w7ZavWZ01wkp5KFBgj4S1biEzhZXynw=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SJ2PR10MB6963.namprd10.prod.outlook.com (2603:10b6:a03:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 21:57:42 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::da5b:2093:7a3f:24a1]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::da5b:2093:7a3f:24a1%2]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 21:57:42 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] selftests:connector: Fix input argument error
 paths to skip
Thread-Topic: [RESEND PATCH v2] selftests:connector: Fix input argument error
 paths to skip
Thread-Index: AQHZwbL+rSqbLonr7Uq6rDDsC48Npa/UcKeA
Date:   Mon, 31 Jul 2023 21:57:42 +0000
Message-ID: <033ADF0F-F8D2-4382-BE78-A5AFB2044994@oracle.com>
References: <20230729002403.4278-1-skhan@linuxfoundation.org>
In-Reply-To: <20230729002403.4278-1-skhan@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SJ2PR10MB6963:EE_
x-ms-office365-filtering-correlation-id: f15b9a86-8fc8-4d3c-0637-08db92112a10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWCj/8GhMRKRIYXSwucOdYJ8qOa6BRFuM6D1IINqN4tF6IzTCNYPmJFm+C44sIWy9wxeNzAWZR5T0wVlcs47NOooKfOX1acKRXiFgRskFm24wwPZ+8c/PNal/9gyojDJ3Y2UgDvNvkZuG0OCBAf932cFfAQr+WWmtkRfWMtoN2tFF+yo4XeMngsTIHO6wNev9DM4hbixq7M0vWlbGp95L1a+v3VQl9qe/SSzgMZ0XUrMwFzTMzAP071NbGb9PrK0r2Etp1Yl1TJX8wsADENjv6VlfadHTU6Jjp86RmDRgB4wKTeKx131IQORTRysjIccOq2genEFzkeonL4TWOFt+VcjggxZphb65e4SUpCVptWn30oAtLr+SQNdL1T26z9CKqnbbcRFMHaYSgFzP7PYkxWRHDqgXK+JyS3Y9VOnjHYsyHlo1OmADZTsVjF4GMfChX450ySIOiyUPA9xjm5nairpZYL5qg4BIFqJkheyHSxCm4O+ciGzmeYHmzeg89x3R86K8WTeglVw9aCOFHQc3CKQ5o0jgy0TwqBCCM7ckibY4WpliCmBuRMVl+3zMM+V3m/YxXUoRppXB68o/xQkGopGRzhp3sZaXvg2hy5vO1VJ9YrsUNUHHD6H3O2uCz/+5cdfE4Mrgkjs7sDePNB4nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(38100700002)(122000001)(86362001)(38070700005)(33656002)(36756003)(6512007)(71200400001)(478600001)(6486002)(2616005)(186003)(53546011)(26005)(8676002)(8936002)(6506007)(5660300002)(66556008)(91956017)(66476007)(66946007)(76116006)(6916009)(64756008)(2906002)(54906003)(66446008)(4326008)(41300700001)(316002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3mSHh9xl6nlTaXr3IdVYdn/qdKukL2nNhzGWegPVmOJ05bk2YzGk0PRvTJhV?=
 =?us-ascii?Q?e5yihO8vew3NN4cXVuBze0QqqzjfcmTxK8NMjnCxf5FPiammtEVVDOqZVpCb?=
 =?us-ascii?Q?6XMT/5Lnw4GknlsmXjt635TAnUQme8ov6vqsYjxcPGMEiMI/NKoanVJ77kE/?=
 =?us-ascii?Q?dKHfGDW+e1Atcz1Xd22zBYzH5jM+/2GCy2spFk8nsEr45pe58kdZ3fin6iww?=
 =?us-ascii?Q?NhGJevC1GWUW2vukKc/V3Mwp4XejOGhrVt2ZByvbxj0n0AELIVo+EqrE7kMI?=
 =?us-ascii?Q?eFqLFi8y7dM1cDXZzGw0W3/C9koDR2FPTpe69K/XbDWBYFkjQRtRnfn/CtEz?=
 =?us-ascii?Q?WbJO6xowyii7sUIlbliL+YzfZ12PgosrnlqZfX8oCbnqg0dAvuCjb68ofVIz?=
 =?us-ascii?Q?hNS+LXTxES5LN5R/W7/NdsYZU2odXfgWGoJDdc6h3L/ADJjWeLgyInQTMYCZ?=
 =?us-ascii?Q?0ooSd5nmYCIDC/2qmTiB9X8jrXlQwgqwB/CBPSeRRgme4LA+kpPP/7gb60av?=
 =?us-ascii?Q?/ehQMwTBTt+xitKdsbCvhr2vG4fB6jdUMzU6ejfuLDeC9StjSn3Wc3fXz6on?=
 =?us-ascii?Q?MgJY+20QHSzAlUGNaVPGMSANi8RDA8hcfWNp3UNmwVanmpFPcj4tSCQoHfj5?=
 =?us-ascii?Q?qDKHyr6GEPGbGgDRuvXcB3vBbat7j4OQVRNFFgq7VL5rkFQRzz2juTFVI5Ng?=
 =?us-ascii?Q?3wUWjzyOigsvu0D80zHx/Bm2TYri4acSThu24R9HdMWSyqPaAKK4iplIYgHH?=
 =?us-ascii?Q?D9SUb4/8NW8THA/6AcPpY/dNNdI4Ei5ult7HdaNuRmAnODvPtTyQSUYfVOQ0?=
 =?us-ascii?Q?g4/Rb4aC/nF6G07DVSg5RUod7RQMNEK07k4xHjsgEpZwIk4FBHEydGK64G6v?=
 =?us-ascii?Q?zGqwbCZ8DvuHDGn0ij8I6ZC743muBK8sBU0JIuUy2MJZNJWz46iM6TaXYDSE?=
 =?us-ascii?Q?YNWque3wF7udttbMETKpOJgxpWeuH9uWoIJ80LPw5vPg5mF8lD00a+q1u9r8?=
 =?us-ascii?Q?ItUxyc4E3eMbMqYFUSkNuR4d7Fn+Gy/hen8wd/WIH16ctbXN3o5AW1gO53L+?=
 =?us-ascii?Q?4oVRTHshEshZEPNC0wwqbpuMHui7QkS3qDt99dWWvb/1ivywxfT0KqB3MdAG?=
 =?us-ascii?Q?yfq3qeT0AOzyt0cmWNFpwBJfORwXpP/6urqpCFR/5t4Iegx2ROGfB5kmK2bT?=
 =?us-ascii?Q?BWjcODpgK00N4PBpSW2rNStL/7Xt3bVyu7NoSkx8mkjMSkI54dixfWhcq2Wn?=
 =?us-ascii?Q?M2raNISw/1mLc50Wyzr0dOsYmXrwK9MjECxRXMZafeMZ9Qkxn29kQT+/c1cm?=
 =?us-ascii?Q?mRQTao1bEAVHuzXYtL92DpbkWw0EC/HmyhCqFhGNeOaKKQWY68sdKWlHc7vQ?=
 =?us-ascii?Q?epvN+o+57WoU/MVjtqRMZR976HVrMflOodpwhlVbuv81KOffa2SnH9C8FNco?=
 =?us-ascii?Q?C94G+8DK5LPPEU72DzHL6xVggWXjX5Zw8uSnJ1Csi0X7p3S5SAfdmz9o1rFd?=
 =?us-ascii?Q?bi6pjL6Pa2jTqynNjccLlznfU34LwIwv9/mxJFezS6pGq8bK+klbsUfb3B9Z?=
 =?us-ascii?Q?G6xRWS69YUuEmsPGaOo8h/OQCklStEZ+L6PbHD3gzJ//mKXCBdWV0+AQXjYS?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA6CDEFE4F9CCE44852CDAC6D2EF56B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: owNa+n98cGE+wRoUFyJfbCPz0pgrFWfcxFsiZvMDYx7nZDQqJuLI4wpGgsNSBTN5E2p1fqUQBjeyy9CvgMv827Xml9kJi4+xhJKB/Kr6t9dKu5aOZ/1LKyX7fgo5aaWto2HKIBPXb3Evp8NrnIHyQnJItvNPb2YgpdTCGMCiEgMvHoZVayKqV2hJeRWn0nTHqJeK4xW8NlnHGM84aFkvziHbRQPk415LzlzbTV2aYUXfDV/8J0kvfYrUMhbueZrcuUpxKpyJ2ro8045zGO8XbQTbSNMIhIQAWmTs+xt3d4MTJbYhdu8ZB7xjba1YU45eTjGn2jchIHXgCtjjPdWHgNe3AjTwjkXYZ1qHL0j/61HP9DUvoNaZUEft2PM0u55a9AbOEj8swXTJbx29Md8U/8ZvBkjBhqE/YpEgzyKqLP5U7YlHmz2txMH+nNQDbXvEXFmlgieAnzTjU3Y3oqAsKQgbT3acKLsZeVQeEstsbi+U1tXJfX//uyuYAe9w/rINwhJoYxLIE+qUDKwkrn2LtwyfRgFlvoXFGLHAQ6E1W6ls3sIDNw97K3wKCZjNDHlCRct10ExUM13Ek93yogCvI7ZjcZfJLNUL3ZXfvXJ4O0PoKbySsKvkzxJf6tMQThiPTU60aue+Q61tlwtpezoMQFew554A7IzjhbfNHOybqtI2DoMwhUF1v/33mNW2pA1MBKFy2Tn706ydKLMF1gLEZzmuI2VNXbduCDBWPiQ3alvg03IQ5hhcDCqf65D1pzAnHu06oYq/oEQgXBbQ5Hbsni2JbB/34iwwY86i49LJubwWRp9yKmMlAN3Ut07nKnPfGvLDdvrKF5ZoyNTXLz41+mbyF7FWJAeMbGtDbmNOeb7G3m02DWaMWgIdKUMSEYdR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15b9a86-8fc8-4d3c-0637-08db92112a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 21:57:42.0708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uM0+DxotFsz82L27SbZoPuTHJPmlhB0RyNcvHhlHN1l0DKN75/xfR4Y7S/iRty7nl2KpIQK14E1q/Q4A86ZjPfIhVygLrfq5ETyZ54SbLCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310199
X-Proofpoint-GUID: 0qmV4Gp5VcWKOp9XMdZ6SjmJ5OZIR6Nd
X-Proofpoint-ORIG-GUID: 0qmV4Gp5VcWKOp9XMdZ6SjmJ5OZIR6Nd
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Jul 28, 2023, at 5:24 PM, Shuah Khan <skhan@linuxfoundation.org> wrote=
:
>=20
> Fix input argument parsing paths to skip from their error legs.
> This fix helps to avoid false test failure reports without running
> the test.
>=20
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

> ---
> v2: Removed root check based on Anjali's review comments.
> Add netdev to RESEND
>=20
> tools/testing/selftests/connector/proc_filter.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/test=
ing/selftests/connector/proc_filter.c
> index 4fe8c6763fd8..4a825b997666 100644
> --- a/tools/testing/selftests/connector/proc_filter.c
> +++ b/tools/testing/selftests/connector/proc_filter.c
> @@ -248,7 +248,7 @@ int main(int argc, char *argv[])
>=20
> 	if (argc > 2) {
> 		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
> -		exit(1);
> +		exit(KSFT_SKIP);
> 	}
>=20
> 	if (argc =3D=3D 2) {
> @@ -256,7 +256,7 @@ int main(int argc, char *argv[])
> 			filter =3D 1;
> 		} else {
> 			printf("Valid option : -f (for filter feature)\n");
> -			exit(1);
> +			exit(KSFT_SKIP);
> 		}
> 	}
>=20
> --=20
> 2.39.2
>=20

