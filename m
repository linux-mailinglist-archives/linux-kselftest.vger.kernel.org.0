Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201856A0B65
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 15:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjBWOAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 09:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjBWOA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 09:00:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA7D515FC;
        Thu, 23 Feb 2023 06:00:27 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NAECIW022709;
        Thu, 23 Feb 2023 14:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XzddRWOUDgfYPKOOV5YA5t8s762MkrhFMr8pktSYKUY=;
 b=nGf4TO7M/DCz6KXP8gHvFrW7NiOqUCjYw+ZpgUwQrD1Z2ibRjHaeg/OO5M6I0M3q+rFD
 BFR18NkkOH5KRxT0OTGgG57Y8HFJs21i3Xq+g3a0S36UBP7/JuOJzGQDTr46xw+lX/36
 JysJAaL4EUbVS93asEFYfJbq9/2561enbJZzKxO8zT+Ts9cq571iQiJQ2ljOZnqiVkMV
 YvIuUG0Uj0yu3hFFftTQBky00JQuuWNdArU/yAqEVNfy7EDxrscvyZCa4N7Uw5iYPzWZ
 chxS4Iaiqt25Oe39MaOHfGUnGNePrgAuDQRULeAcfsSSIM1bk4+IZQFhEB3MlMlG98h5 bQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dthre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 14:00:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31NDkQBr025868;
        Thu, 23 Feb 2023 14:00:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn481pat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 14:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5P0sBeECxxy0MqsCkhg9ppPKJJGh6Zgep/FsmaXEOyoLD3pV6Ov+WHtgFxNRpmb01/xCCM30Gr5NI+bMRdGjLKNVGW66NwhYDLvBhPY3lcp8GDNji7cUj0MYDv9BwOrft56OsnS+0ukvatg5Mop9HPf+hQxgt5URHD7Rq0Ybs9CVJXybEPlYkKI/RHx12LPuc+P5qHim3UK4VvbyuR+Od7QUpL1A4jQthloS3t2Jamf91vbz5SIpXqjgI8Wleh/e1cxBspLBQw6lo3sNnKO/godsRgbcPdLnUtXhtb+ACps3lrvjrsFBpPFleA5ErooPo8AVbCo0qajyFpxf21P8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzddRWOUDgfYPKOOV5YA5t8s762MkrhFMr8pktSYKUY=;
 b=ObbQrVv1IPrIdDv1FELmAucpFvWSRIkekKLyZO2QOKVKcENr/ZSSNiHjYUsvKkVMWWkGdYtnjD/x9gysLnr8kInsLZl7B/GkXgA72PkFHsOKxuQy3XSts48jSqaVcqsoRdmh8Yt6fvWwM0Nt2BeGAlXvOgD2nL0E0x3Lb7Q+HfzC2dctFlkWAoPnOQWCfi4aN3BOYeQYYRkJIjQC7gQKBLAGvGLH3mceirPvWij99Gfp1txbc2Z16ESzKgsNNa2VOm13zWXTdrXk82XXy25lGh9DktXE5ZRJ4Y5l+6w9KNGjum5TExEJEJbAx66nAZbF4GJRzcocLy32rII1RiiO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzddRWOUDgfYPKOOV5YA5t8s762MkrhFMr8pktSYKUY=;
 b=pc3AHxbvub+7r7aiiVxEgLSGAXwfEvByv4vUpskK5BDq5OJhrvmheAzYdcuKDj1Ly+obAouU+5HNMZyEueWa4+y2m+bNGNzj+5EMA+iALXOGWrm90vmdyuQHCyD2IA2nCbiSsmHcdbyq4rfzR0m9ehZkgmQ8AUBv2b1IrZ33j5E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7514.namprd10.prod.outlook.com (2603:10b6:208:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 14:00:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 14:00:05 +0000
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
Thread-Index: AQHZKQWoezbV6gQfMU2hAYqKspg87a7cvOEAgAAPVQA=
Date:   Thu, 23 Feb 2023 14:00:05 +0000
Message-ID: <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org>
In-Reply-To: <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7514:EE_
x-ms-office365-filtering-correlation-id: 3130281a-6852-4bbc-4f36-08db15a643e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /EriTgPk5+cF2KHi6k+dR8JaeMBHwbn5DgjSDCRGZGv66AluXnu0qFVmseIx7MbQ7vrH+2jLpRpuM2u0cWvMXjraVmx7zbJIklYTajXAj2qLuQTZVXT1Dn5QGN2+kVrE6dYVjYIfWt/hEeFRAbkJpyhOPw9whACtbKJGB9NzneWaI2q5v8WwB3O+6uzQRnxSnKjHwR6vISLg5VS/+sLKwxqekpV8wV3R2JQiY7moz7z4wmzOv6EMThRstWqBBrZoTCwfpk91wGw7QFM0WTnrw+K6ZScnKvFYVHfuzCeYEnFTEC/EpcebTsrxZ0QPDbodt2TDz+Rk7P53TVQmqXJgCpV9h3skKJnPNfEQ8do8KzYmSlFZd/i8nbcV18PaGzrCrcEPzPcrRe3t5tXeU9N+464SjkePif1XUPfUi090CjQwRySgQ2NCoeKH09XEJ66DOfMdM7UORAu4EFNUcXT5gdq8qcre4jEBvoUJRdkvztcRf0LW6o4TKJOJIQlWHfQ8+HWVdTkls2MzeqX0ts1JYdFsjxg/gYnSy2tJHdefa3vji/zXfDqVmHpZxxnEDCU4EJy5TeFPl+C5lmAaXQ2lGL/3IKmePJniigwtmE7P4gtjSfaMIzw4Hc+CyXU1bY435GcxQxuBFvJwwmcaVTHVxH1B0JiNNKqz6uunjWzhQUfuFeZ7MBTnizXUlNi4gx9KUB2yHAen0ckw3lcozcGTafVBRrHazMx1US95f+KI95Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199018)(38070700005)(33656002)(86362001)(36756003)(316002)(2616005)(71200400001)(45080400002)(83380400001)(54906003)(478600001)(66574015)(6512007)(26005)(186003)(53546011)(6486002)(6506007)(2906002)(122000001)(38100700002)(8676002)(4326008)(76116006)(91956017)(66946007)(66556008)(8936002)(6916009)(66476007)(66446008)(64756008)(5660300002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GjQ6C1Hcx2P3q39kG0Pe7aEfS5E/w7wcsLQq4FKlkqnDS06GxpJV+czV0Rc8?=
 =?us-ascii?Q?WUFNePyinjU1R/30v9YAo4iGZboA/CfdQYPPwc29e8wwhr6j7Otw26XL9/Ma?=
 =?us-ascii?Q?lOQpS1kLxyDJ9LJrwZY7HuKkKgTZ8koQGWpi13YCE6xEEibGiVnrYQyZ4o9x?=
 =?us-ascii?Q?T2/8564UByvO693fZ6dIyTohxYCQwuvQUjWsfuFmERywmBkTp5V3T9R3o1Bd?=
 =?us-ascii?Q?oB0kh/wyBfa/QiLonAVO3fp0KFtiAIydXVYn92wRhnAViXu469dc8136lXxs?=
 =?us-ascii?Q?ejlTUHiyoUE83j5CZZ5mnQj/HCPWyIkEoWryjLYQzg9SBqPmGMFxflApQUp0?=
 =?us-ascii?Q?8dRHI1MvU/FfCX00B9LDzrdxsLIzZd0bQmCxjCn3P5g2rX0VWGL+WDH57lnG?=
 =?us-ascii?Q?picDC6FWAhtsA0FitQXuxTp4WoAvWxfk7VSdsgKq0Yrd0fJJBzMJp3nczNMr?=
 =?us-ascii?Q?eCb3jVi+3L4X8CucDj3sY/fU5Yq14kRQGsxze12tC15PJ4o5Q+9EVb4Og5u2?=
 =?us-ascii?Q?15dqHVr00ZdC2GWmMXgBKxJZE4nhOjsUxAcX9F3zSgaCHi3c7LpocHMKuf3O?=
 =?us-ascii?Q?nbwEgpkaq1uVIwuB8JB6/v+Meqs73U+XuM8WC+roN82ajMGg7cPC56hrPx2V?=
 =?us-ascii?Q?4Z3LWlmYm5tTBoCqcFKmrAww+RDKReKBirRYDbaRiW2fJTE9XVifslNSgflw?=
 =?us-ascii?Q?eEUGkI8LbiaYKBuiRLOxRbenDkLbJv9N8NjcjhT8ebOSeSh7eMdOYIrAavGu?=
 =?us-ascii?Q?01FO//uQZdLpGCDw+2WzNqz7/b2PHghPPGVQXu6wczOjYmBgc9I14odP3dGY?=
 =?us-ascii?Q?Jk0CdBdMmt8Vil6fsgR/DrAJ45j4g1fl7Y0wuZ71GYCVYCrL4Ckqs1IN7EtV?=
 =?us-ascii?Q?qIp1VI4ke/1h7ClNK9ac9VLF9Q2zAF0wG+ZQkukrNILbE3Pdsrzrb/VNUpBR?=
 =?us-ascii?Q?/RiSFBELiL81QCF5UeOb+9bM0r9zQY/1d5GPq4R55zxIhhhMv5agp2t1rz/z?=
 =?us-ascii?Q?iWu1+pilFm20BsVBBLc7wRHEFqCNZvTCVc1rQ1KndSNTjEhutXT5zxBKhAsW?=
 =?us-ascii?Q?QxK+lfaNktFvfv0Q/LgaH+irkh/LZu4T1XUCMxl4h5wyT3N+x1ZJZwL8t0EH?=
 =?us-ascii?Q?AfZAvPH2UCNtTkYu93wQ+CrhoEIYbMwh6iwW666nGSYzZTg7XkgwYaD4UQBO?=
 =?us-ascii?Q?Lt62esivjjZm5uo/dKE+7bW+J6zQEmPbiH7ndgYB7DLpOj+JcxwGTAdI2xTb?=
 =?us-ascii?Q?eodDQSOzgf2bj08gJMQilzF8ICCtB7+hQZMjOpxy1mhYyUwXoBnNH9QdOPnj?=
 =?us-ascii?Q?Swh6K6dyUAF828jphJFqu0k5opEdSX/EsiLzz4ojz/aE9/HG985RtVuyJMbL?=
 =?us-ascii?Q?SFBdok3xgRvQbfqkCfe+QqjqkXzs7Z9S8ItkSTYFlNR62cSxdkcSYQAvqhF7?=
 =?us-ascii?Q?fs3RCj0O44/gQ53LIk60T/WDxr8ZghiMtu4X2OiziDdFWz/cqyrqlu5g+FRo?=
 =?us-ascii?Q?W8lTMbVSNhiaM1DJozOUNx5sHE+6dCg9qrwba1w8hqfz7MJ9NgtsNWLZplmJ?=
 =?us-ascii?Q?etcZc9U3+1YfbqxSX6WutiwvWpGOr6KwNKlNlz/0OGtIZwa5Oj8DLaxyF3tN?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D8594DD33827145B7AD52B859FC94DE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LprrYATNtOaRggotKJkZneSaBfxP7JeeeNO/g+HdB5L1c89Zi+WBZB16NNPZYrp0IxqUxwozN52XHLHOKnU7JxiLcut6DMamKbSNvR8sKoN3OY1VMI4fGbFFA8+WmrC7pwzbNiHhQPK8Uhrj8tTidMpkiguSiquXvn4znHFZ/e5fKhleTdhhDHwXsKzjeod/0SuW/TNvXDrMPWt2lGXWdHK4R4v3t9WpwYGUGSvn31lz+ONbrdKPFWWFZH+gA+qj5eu3v5z65j+qcI8VsDFwkzRVHOfSd0DkCZUhDtUqDyartI6vh9SPtaMVoGpxayX40A2ZtkmAbow4seQve4+rzBwQ8TPgQMUovhrRSEfW65OOla0yojVx1TOZVciA3hDfFP+5lpKTyzwtb6/+7qmTHu36pamrmiJlL9cStqr1ZXuykNAycjxqfzUEvTscIuvV3IEozSuaezWVnMZxajESBSImQFai9oy1G1Ff2UeS5O5sstGu7J3SjazV5AHEAnnD3Km1+nFxhvD8SIg/BnAHnO2kiwHL1SzA6qdKgDlIFvfjo9IvNMHdX/1u05EixlIQF0gPfHuuTx3xQQsHWY414HGpmyCn39tu8SSVuaJo3zeObE2Pvy67fBFtBICrAkHXcXx8/gjczyd7eTNXGuulue40nwce8Ljn0eUoKVMQgzeAPRkJX066FlM0/SCBIJ5LTxSLxPeShkd6kCLtSTNl+AStvhUphxpRD/rJUKeAmRxi4OGIMYI9712aWoA6PNxYL7TpOsviMOeGwgiHqoHhMcDf2EtjvlPzGXosSoiMCMuyTDjUZfFzE2Nhd4EIMtItgIUPVO3/MuBPUWUq/jTp1xoVxJEXLEwniHUZEAbjWZcgSjr27AQYak2V94pZ2JhvY7b46IMrVZH5cyYkTIvMqPr4nfrHrexEExOPpQR2qCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3130281a-6852-4bbc-4f36-08db15a643e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 14:00:05.0091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/bW3Mw4Yl03uPAZ3s9ClfcLZcLsgqmFwYGgWjq5dEOCXq8pmHifLS6HirhdWzn179I7jNWxJJhTcoTd4FxVPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_08,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230115
X-Proofpoint-GUID: hYghsI-ZadSo25gLzHIsdPoUFYGxXEl1
X-Proofpoint-ORIG-GUID: hYghsI-ZadSo25gLzHIsdPoUFYGxXEl1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Feb 23, 2023, at 8:05 AM, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>=20
> 	Hi Chuck,
>=20
> On Sun, 15 Jan 2023, Chuck Lever wrote:
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
>=20
> As this is now upstream, I gave it a try on m68k (on the ARAnyM
> emulator), using a config based on atari_defconfig:
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
>    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss=
_krb5_test.c:52
>    Expected gk5e !=3D ((void *)0), but
>        gk5e =3D=3D 00000000
>        ((void *)0) =3D=3D 00000000
>        not ok 1 des3-hmac-sha1 key derivation case 1

Geert, thanks for testing GSS on m68k.

This assertion failure means that support for the encryption types
specified in RFC 3961 is not built into your kernel.

The new Kunit tests don't work unless everything is built in --
there's a net/sunrpc/.kunitconfig that provides the supported
build configuration for running them. I typically use a command
line similar to this:

./tools/testing/kunit/kunit.py run --raw_output=3Dall --kunitconfig ./net/s=
unrpc/.kunitconfig


I'm not sure what's crashing at rfc6803_suite+0x2, but I suspect
it's a similar issue.


>    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss=
_krb5_test.c:52
>    Expected gk5e !=3D ((void *)0), but
>        gk5e =3D=3D 00000000
>        ((void *)0) =3D=3D 00000000
>        not ok 2 des3-hmac-sha1 key derivation case 2
>    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss=
_krb5_test.c:52
>    Expected gk5e !=3D ((void *)0), but
>        gk5e =3D=3D 00000000
>        ((void *)0) =3D=3D 00000000
>        not ok 3 des3-hmac-sha1 key derivation case 3
>    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss=
_krb5_test.c:52
>    Expected gk5e !=3D ((void *)0), but
>        gk5e =3D=3D 00000000
>        ((void *)0) =3D=3D 00000000
>        not ok 4 des3-hmac-sha1 key derivation case 4
>    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss=
_krb5_test.c:52
>    Expected gk5e !=3D ((void *)0), but
>        gk5e =3D=3D 00000000
>        ((void *)0) =3D=3D 00000000
>        not ok 5 des3-hmac-sha1 key derivation case 5
>    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss=
_krb5_test.c:52
>    Expected gk5e !=3D ((void *)0), but
>        gk5e =3D=3D 00000000
>        ((void *)0) =3D=3D 00000000
>        not ok 6 des3-hmac-sha1 key derivation case 6
>    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss=
_krb5_test.c:52
>    Expected gk5e !=3D ((void *)0), but
>        gk5e =3D=3D 00000000
>        ((void *)0) =3D=3D 00000000
>        not ok 7 des3-hmac-sha1 key derivation case 7
>    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss=
_krb5_test.c:52
>    Expected gk5e !=3D ((void *)0), but
>        gk5e =3D=3D 00000000
>        ((void *)0) =3D=3D 00000000
>        not ok 8 des3-hmac-sha1 key derivation case 8
>    # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss=
_krb5_test.c:52
>    Expected gk5e !=3D ((void *)0), but
>        gk5e =3D=3D 00000000
>        ((void *)0) =3D=3D 00000000
>        not ok 9 des3-hmac-sha1 key derivation case 9
>    # RFC 3961 key derivation: pass:0 fail:9 skip:0 total:9
>    not ok 2 RFC 3961 key derivation
> *** CHK ***   FORMAT=3D2
> Current process id is 794
> BAD KERNEL TRAP: 00000000
> Modules linked in: gss_krb5_test rpcsec_gss_krb5 auth_rpcgss oid_registry=
 kunit
> PC: [<1188975a>] rfc6803_suite+0x2/0xffffc688 [gss_krb5_test]
> SR: 2200  SP: 93025120  a2: 01b6f700
> d0: 00000002    d1: 00000010    d2: 00000014    d3: 01aebcc4
> d4: 01aebc44    d5: 00000009    a0: 11889754    a1: 01aebc44
> Process insmod (pid: 794, task=3Dc42c6bea)
> Frame format=3D2 instr addr=3D1188975a
> Stack from 01aebbd8:
>        11963860 00000000 01aebc44 00000000 00000005 00000001 00000000 000=
00000
>        11889e5c 11889e34 11889be8 119644d8 1196356e 00000001 00000009 000=
00000
>        00000000 0000000b 01aebcfc 00000001 00000000 00000001 00000002 000=
00000
>        00000000 00000000 00000000 00657333 2d686d61 632d7368 6131206b 657=
92064
>        65726976 6174696f 6e206361 73652039 00000000 484e4f4c 4f475922 290=
00000
>        00000801 000c729c 005b9c58 00000000 00040cc0 00040cc0 00000000 000=
00000
> Call Trace: [<11963860>] kunit_run_tests+0x2f2/0x3d2 [kunit]
> [<119644d8>] kunit_debugfs_create_suite+0x0/0x54 [kunit]
> [<1196356e>] kunit_run_tests+0x0/0x3d2 [kunit]
> [<000c729c>] get_page_from_freelist+0x176/0x48a
> [<00040cc0>] __finish_swait+0x1a/0x1c
> [<00040cc0>] __finish_swait+0x1a/0x1c
> [<00040cc0>] __finish_swait+0x1a/0x1c
> [<000c7126>] get_page_from_freelist+0x0/0x48a
> [<00009752>] ssincosnan+0x10/0x26
> [<000c6f00>] __putback_isolated_page+0x62/0x7c
> [<119639e2>] __kunit_test_suites_init+0xa2/0xfa [kunit]
> [<000405ea>] __wake_up+0x0/0x1c
> [<00037774>] blocking_notifier_call_chain+0x0/0x46
> [<11963a5a>] kunit_module_notify+0x20/0x34 [kunit]
> [<00037404>] notifier_call_chain+0x34/0x48
> [<0004e3b4>] module_put+0x0/0x50
> [<000377a0>] blocking_notifier_call_chain+0x2c/0x46
> [<0004ebd4>] do_init_module+0xd6/0x1a2
> [<0036ec50>] memset+0x0/0x8c
> [<00005b94>] flush_icache_range+0x0/0x30
> [<0005009c>] load_module+0x1304/0x1368
> [<0000eb60>] zer_rm2+0x1c/0x24
> [<0036ed04>] __generic_copy_from_user+0x0/0x40
> [<00010000>] EXPTBL+0x1c8/0x400
> [<0036ec50>] memset+0x0/0x8c
> [<003762ac>] __cond_resched+0x0/0x46
> [<000501d4>] sys_init_module+0xd4/0xda
> [<0000eb60>] zer_rm2+0x1c/0x24
> [<0000536e>] buserr_c+0xc6/0x49a
> [<00002962>] syscall+0x8/0xc
> [<0000eb60>] zer_rm2+0x1c/0x24
> [<0000eb60>] zer_rm2+0x1c/0x24
> [<00010000>] EXPTBL+0x1c8/0x400
> [<0018c00b>] nfs_direct_write_schedule_iovec+0xe3/0x1d6
>=20
> Code: 646b 1188 42f6 0000 0000 0000 0000 5246 <4320> 3638 3033 2073 7569 =
7465 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
> Disabling lock debugging due to kernel taint
>=20
> All of gss_krb5_test, rpcsec_gss_krb5, auth_rpcgss, oid_registry, and
> kunit are modular.
>=20
> Thanks!
>=20
> Gr{oetje,eeting}s,
>=20
> 						Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> 							    -- Linus Torvalds

--
Chuck Lever



