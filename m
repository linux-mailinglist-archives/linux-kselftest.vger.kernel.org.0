Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026246AC863
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 17:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCFQmc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 11:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCFQlw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 11:41:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31985ADE8;
        Mon,  6 Mar 2023 08:41:16 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326CxG18017856;
        Mon, 6 Mar 2023 16:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2paWqwq1IUe2RsQq3olmLMMJPhmp4zfZxGovW4CMQIc=;
 b=Ib/wSYWDTlgdRqg/iQQPqLXnVcwh8p4GfugsTghuZDFhGhWj1o1+JFKrFcfTnUw2eiMU
 Az3k6XjZTENDBtjlDG4d3B/sMcZaigl8Zn9uz6yBxW+DRErC8MKsPZKa7lKQ2eMo/rI1
 yoWlzcs0Af2wJfg8EFH9q2iOCe0EwSvq2gRy9e01EKXzo81056fT6yAMbrmILwwWuENj
 LewK5gzNkQKut5kRoMxQH8vmgknQPJoylT2lQPftmV1X2K5YihneQkmp4BTlo94e5TXJ
 ozxQIf8sV3Rk0bANij2wSFOmUeGCZ2CfyEGBPhuTZGnoZpuI7icccGvF0mLedn5eSVYF cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415639f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:17:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326FrsL2038193;
        Mon, 6 Mar 2023 16:17:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txd6x9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:17:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuB2udLERR4LE6200uyQt1UdqLg8TB4BQiJdd03VaRuBbeIxk50SEE+i+Ps0g3zJWEqFUQ43HI8nJEuFPTJsg+aeknvtT6pRY83pqXkAB+Dnr04y+1VELlAC2c2W/I8ni29TeFXu5iFMLUGNQYL6Ysiesi/2w/P9RNeVNMWM/tppagazonVZozUmVnBaYTzaaZER9/j8dGF8na2LI+0qtzYsob21ut9jqmVxeYtLameUy8Juxywiv6yWXzPyoFv7fajkB6xVQkPuZz+5JGfy5RLlz9tNvCseM0cpMNQA+CnFVVH1gyBdAe/S4Rsu5jmlcUnjEG+nDJJ7A5c7h7UvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2paWqwq1IUe2RsQq3olmLMMJPhmp4zfZxGovW4CMQIc=;
 b=FewbXcXA1lsoNypAaBrb9+9EYlLBckJSalmJsPPX3WLTbaUJuGfeMZeCEntcgM4qvWEvTdvKcla2Z2oZC8we6i46HmrhCjq4vA6D3lip0+R54K/sBW3kDsdY4mSm5/3HeWoAHmsjz5b4AuA8K0LZT1f2JHSn3fyZJF1I0Ktgo6kgapBCLQuNLH5kDVOEHww0lpuQTw5kw6w+xKzqaafjY7PF5l4XYjnbJ2JcUut1wD+IEGgN3oXubMLY+QpsCbB+zqbxwE9O4Ir2VZJ9HLlz9T3WOB+T+dwAuoKsX5oiYe3Xdx/MAbwlI17m3NjFaltw3kxGQkQbyX1pEOGtTbW0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2paWqwq1IUe2RsQq3olmLMMJPhmp4zfZxGovW4CMQIc=;
 b=GYQ0j8SsWyf3B1p9ZAH5ZBI58UVK3gpRTueQTafGsaoDQzktXwHKbCTSRjGC9qI09vVXqe3clna6k2YlqMPPXTPfEvjmAeHHfURRB+jkLggRBG+GfzzwpgwfznLwq65vaIo0WM5gzHrg6BJyFUUmzuMpwW35rvWdxlK9J73PPAA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4442.namprd10.prod.outlook.com (2603:10b6:806:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 16:17:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:17:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Simo Sorce <simo@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 15/41] SUNRPC: Enable rpcsec_gss_krb5.ko to be built
 without CRYPTO_DES
Thread-Topic: [PATCH v2 15/41] SUNRPC: Enable rpcsec_gss_krb5.ko to be built
 without CRYPTO_DES
Thread-Index: AQHZKQXhOAFRFLhUO0eN4z8ABCcG5K7ttc4AgACGV4A=
Date:   Mon, 6 Mar 2023 16:17:07 +0000
Message-ID: <D157AE63-73DD-4CCE-B43E-AC0D92F35038@oracle.com>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <167380331214.10651.11224254824457738270.stgit@bazille.1015granger.net>
 <1331f5b4-66cb-4afa-4e81-64cf4bc696d@linux-m68k.org>
In-Reply-To: <1331f5b4-66cb-4afa-4e81-64cf4bc696d@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4442:EE_
x-ms-office365-filtering-correlation-id: 116379bf-1fb1-44d1-2c5d-08db1e5e3b9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxZ7KP1aDJHD/HqfehtdU9/lWiIWNCb32mmBKDSoKqvS47PNnnIh9XFshnP7d20SP01zXoOFKUKYKPCE2RtnOTBna3TekMsclc3BwXBvlMBg1iJLcEqP1urCD8qIRYYqBdmckmczkhu45A0+bhfpgUcmSgrIcnQ3odiNoW9yenR2OeWfkJlp3SJ8rfk+ppkG6WGT/l1v/pR4We44adFmPqI5UqBj7P0yf7yX7usZKii8WP+J9I20y21olM4yzM7wD9mLoxYZei4VsVPVgwFRpo+oiiGgT7VYZc2Vhg6CDYSlfbKZbju5zgt+Wlv2zli+j3bJts9Mt4dHSi8CZXO95DUGHzDWwY0CpbgNeK4XIFk6YgMzfB+OHM6et81kZk+dpAxSFkJMxQ/HGFHDouZI89t1GiSEM4DfL2GQ637tJojBMMLDvJ7NLr9d6gxu4pQwtpaokp8uHHb/yVGZnqvFnk6Lj5M2y6ak4Zh7CiskSgIX6SWGJESbv2pwSupS28gHn5WX4afeOUTm0+SceLaPtjkbXURhHI+cg/mAWKzwALhBBl3jG431MlFXGRStjdxemmic7Y8YmVuPIz4H1+fwZtXHEPGyCsi+0hnwx1FtgvoSB/oZu491Z7KYCmscZNlbNDxT63rkPFmT4im2pOHAyWrZtiId17qIOLmcQvDlmWAmIOrZ8elSCDSV28XaJ2Vb+d40TFFMhsD9RXTTdZ8vBqQcqWKlcY3AngEX4yDkB48=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199018)(86362001)(33656002)(38100700002)(38070700005)(36756003)(122000001)(8676002)(2906002)(4326008)(41300700001)(66946007)(66446008)(66556008)(64756008)(8936002)(5660300002)(6916009)(66476007)(6506007)(6512007)(2616005)(26005)(83380400001)(186003)(66574015)(53546011)(54906003)(91956017)(316002)(76116006)(71200400001)(6486002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9BkwXYfh2GTBsgoRS/Adyd4jkqst3HZLJPMqqHxLoV1eIiC9SKDe3sbpYytW?=
 =?us-ascii?Q?AwK/s3Jj+fX9hN/TIqbytDjiF7o8XkavyRCGGWT7tV1MdaW0lZANF7PgOgsF?=
 =?us-ascii?Q?sFFhBvpoHQNigK5FUyJsdPkVZ4rQUd7k+mToNJybz21MPdMrlcIAYHgFTDk5?=
 =?us-ascii?Q?OJJ4LjxBumMcl9m6RyVlCvtRoVEImn+zWeADgIb7u0i5hMiIZ5D0x8azduTn?=
 =?us-ascii?Q?nNb2b60DV9hpMf5an2D2OSjKVYQqdYiFElo3gAzqaWTVmSunc60XEMQUhruJ?=
 =?us-ascii?Q?G3AqeNIDa3Uc8pg6/8HHKmpTx5K5liETVImq0zTeckc9lVDwGcWikMr76zTf?=
 =?us-ascii?Q?MhRRpytATD20f4mVC5NjZ3wRmuwzo4CvJd9oKlQ1UPUp4PcMh0rMMMFDARJ3?=
 =?us-ascii?Q?7XhlSMaVlGt/MAlyxrLB8NlM1WTt6g2Mw7KNH3YlJnPWVGvIKrEFuYoJaA1Z?=
 =?us-ascii?Q?I9AH94jbN0uQPMFJ7DW27K0wLe7PAyTEdJ1bHSxIUIyl2GpI+Yz9clOm55fP?=
 =?us-ascii?Q?7byU7XIlNZ1jyCOaNj8FyYdjoauw8Z2CI2TYNTgcV65UBwUBmOlBtAe81muc?=
 =?us-ascii?Q?Njkeg6lZ9G7EjVUvYJW0zDgN1cVWBfhwwdb77Ty9SBczfuoRbSxvqHQZjeXW?=
 =?us-ascii?Q?mhC1BsXaEhjRw/gRN5rMNsJ4Vo+emMp+W76VT4A2mnMf+ly5Ejtr27pS6qrQ?=
 =?us-ascii?Q?A1KkcRj2Xy6Wr/+Xyhtiuhxe1p8Es6BK4uKuWU5KCaajR9fTLXlkh/Q7Ud76?=
 =?us-ascii?Q?8uKLAZsFlkzI6FkQDzlP8LnXK/41HQi7nFNRcYRQ/FOjQWsgA+jT6LWif0U4?=
 =?us-ascii?Q?DaMm+fgHxJnpq5ysdedd5qd7hHnWAzrVbA3Ue8tTOKtGDoolm+TyWRR/rZOV?=
 =?us-ascii?Q?+a9cA+2Yvjoyz4/LwdvgqGa4baHZx4uHIMMn0jqepKNZWXl18hF1gNLyBNv0?=
 =?us-ascii?Q?lGXYc5Vvb/XILd5frPtk55ixK34sBtEb7DLG5ngpRz89lIqdXsBcPhxuvUyJ?=
 =?us-ascii?Q?uwXW6sTCHPX0hqBSOAnvxSoxhT+j+1TLQ/Nc6KpEqZ1bhjU+0QsiSk/hMKD2?=
 =?us-ascii?Q?YGl+5W6gTFuwc5PVPjnD7gxYTcAsChdiQPxNkFa+yRrtYHnZLTiEMjHA8D5g?=
 =?us-ascii?Q?eeLg76I/hkcd9h9sTl/JhD6+8b3rL8AAl5NvsBpIHl0kWHsWkJK9wSEwnOBY?=
 =?us-ascii?Q?8/DgwC7L2yiHaXodXCPl5IO6GCYx6gx/bTNNHSDHCChBFnV4exJykWlNkXYr?=
 =?us-ascii?Q?GG2SWdYsPxshaaet4AX+u/Ge1ndYEL87kPu3fpWjbsj91FerDatypjwTLG2s?=
 =?us-ascii?Q?NeQZv5iXzrNS2IGFKUcmJNylk5bof0mpJWncLdusiD60DRH/uxhCeyV+Il8J?=
 =?us-ascii?Q?bjzodKwgwYM5GeBtyGmetpyDDUHdW661qSLXqOT3oMn6ICJWb5sseOHpaK7S?=
 =?us-ascii?Q?/vnJSxMOOTAiOeQKIq7O2We1FKoOhzxaPLHQ0i6Gv6WBaDazUzi9SllNL3wx?=
 =?us-ascii?Q?MnrmjITTYu47MjQPQy2KZx8fTCqjQp1D3Lm+X1DGEzRnw6caAmo4Ld4fvJ3l?=
 =?us-ascii?Q?m1hJw0lHIVhhwvpFhjrkacx09oPN+tW37hJUsCtMrRbYMyU10Op4nq/Wc2vn?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A4D9B2EA5A15E4C8198EFC8277383EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MtfyFLZEi1xYkj5ahgnQpzvVUlJSKJqNxlccqcMlsycTgTDrMtDndYPBm38rwAwk74DPBHcoPlYPpYJ16Zx3kSDw8azmh02HAfPMNsZtAv/4854hDArrCTTbz9D0o+fixfx1qIvzb5rAzYCR2qlQcrq5pVTX7nVOIMNNGdGhG0YDfos6ER1CWSuuLsqnIKkprnpcqbtOVNNmD02yX+ye0KK14yjl/OVbRtDtbfQR5wnctRobPbgmoG4MMHCYI7lGDXPQHP8yOPtqMyARCdmlAPX2zbnAQK6ctNL1eWX0Q7V+CxVLEFmdkE2sJ6RBacM7b3QS8vQi4Xv513umeYL2iGwB6TLTdR3UUq78xM96S2NXYc1WuKuNXwRW/GxkOq2ABdUdtTmg4AM94w4RefTukUh99CmQD2x0Pi60xloliAlGOIudBFEjVS9v/nIYTkRO6AVstyGI2meGagM7pLK93y2wSYhtnazEh9BHH3qi6uQI1Jocbg8tF/DcMZGjrGjahQA/RHZ+opnRpj9DVcyQLU6EdYK9EmvN7RI3ZUGnXMDW8NWQL7YnKXuoOF6h2LmisuYwPa7hhEwrwJNlvchMBfa3uBmKj+dURUBeYy48ILT+JvnSoa2tqeQVErVqtUR0GhUm2T+goahuvv2GCsfdHrMHhJ5mxM1Np1REAd5rsXLsspJSGxFCZkGEycB4UHd+q1CWeM4jYtxCpUkcfUKl2/thS3A3/vlAZ64Z4lTYDrq+xp1qgJJjnv2LnHK/BtszXTQoGNhY89YOz+KXy/v/SltQVoewF4aX1AwisniJjt5yV2XGXmqRwmrEzvJhj3E/2GyjSC1+5zUC4j7iywobtbUAzgeoZEXpD47XNFI5CNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116379bf-1fb1-44d1-2c5d-08db1e5e3b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 16:17:07.8529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONpBbP1wh8dAe5t3JnwsKKznG3/YCeDQRijnTuPncLfqCbM0vsrlly1MjkDvn55K8SSWpfZc2kqLu1/sSMq23w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_09,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060144
X-Proofpoint-GUID: wvaLpduwXKP-TgmwE0GmSU2CGHSZ9WvV
X-Proofpoint-ORIG-GUID: wvaLpduwXKP-TgmwE0GmSU2CGHSZ9WvV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Mar 6, 2023, at 3:16 AM, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>=20
> 	Hi Chuck,
>=20
> On Sun, 15 Jan 2023, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Because the DES block cipher has been deprecated by Internet
>> standard, highly secure configurations might require that DES
>> support be blacklisted or not installed. NFS Kerberos should still
>> be able to work correctly with only the AES-based enctypes in that
>> situation.
>>=20
>> Also note that MIT Kerberos has begun a deprecation process for DES
>> encryption types. Their README for 1.19.3 states:
>>=20
>>> Beginning with the krb5-1.19 release, a warning will be issued
>>> if initial credentials are acquired using the des3-cbc-sha1
>>> encryption type.  In future releases, this encryption type will
>>> be disabled by default and eventually removed.
>>>=20
>>> Beginning with the krb5-1.18 release, single-DES encryption
>>> types have been removed.
>>=20
>> Aside from the CONFIG option name change, there are two important
>> policy changes:
>>=20
>> 1. The 'insecure enctype' group is now disabled by default.
>>  Distributors have to take action to enable support for deprecated
>>  enctypes. Implementation of these enctypes will be removed in a
>>  future kernel release.
>>=20
>> 2. des3-cbc-sha1 is now considered part of the 'insecure enctype'
>>  group, having been deprecated by RFC 8429, and is thus disabled
>>  by default
>>=20
>> After this patch is applied, SunRPC support can be built with
>> Kerberos 5 support but without CRYPTO_DES enabled in the kernel.
>> And, when these enctypes are disabled, the Linux kernel's SunRPC
>> RPCSEC GSS implementation fully complies with BCP 179 / RFC 6649
>> and BCP 218 / RFC 8429.
>>=20
>> Tested-by: Scott Mayhew <smayhew@redhat.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> Thanks for your patch, which is now commit dfe9a123451a6e73 ("SUNRPC:
> Enable rpcsec_gss_krb5.ko to be built without CRYPTO_DES") in v6.3-rc1.
>=20
>> --- a/net/sunrpc/Kconfig
>> +++ b/net/sunrpc/Kconfig
>> @@ -19,10 +19,10 @@ config SUNRPC_SWAP
>> config RPCSEC_GSS_KRB5
>> 	tristate "Secure RPC: Kerberos V mechanism"
>> 	depends on SUNRPC && CRYPTO
>> -	depends on CRYPTO_MD5 && CRYPTO_DES && CRYPTO_CBC && CRYPTO_CTS
>> -	depends on CRYPTO_ECB && CRYPTO_HMAC && CRYPTO_SHA1 && CRYPTO_AES
>> 	default y
>> 	select SUNRPC_GSS
>> +	select CRYPTO_SKCIPHER
>> +	select CRYPTO_HASH
>> 	help
>> 	  Choose Y here to enable Secure RPC using the Kerberos version 5
>> 	  GSS-API mechanism (RFC 1964).
>=20
> While updating my defconfigs for v6.3-rc1, I noticed this change has an
> interesting side-effect: if any of the CRYPTO_* algorithms were modular
> before, RPCSEC_GSS_KRB5 was modular, too.
> After this change, RPCSEC_GSS_KRB5 is promoted to builtin.

I'm not following. Which CRYPTO_ options trigger the behavior?
On my test system, CONFIG_RPCSEC_GSS_KRB5=3Dm and the CRYPTO stuff
is all =3Dy.


> This is not necessarily bad in-se, but you might want to be aware of it,
> and perhaps change the "default y".

Well that might be there to address the need for GSS to be
enabled if NFSv4 support is built. See commit df486a25900f
("NFS: Fix the selection of security flavours in Kconfig")

I'm not claiming I understand exactly how that fix works.

--
Chuck Lever


