Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F275ECB1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGCTTo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 15:19:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40234 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbfGCTTo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 15:19:44 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63JFvE4028407;
        Wed, 3 Jul 2019 12:18:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=H3t8rEOqLID0vLpGQm044hmrh6JXygY2OxYPHO7+jSE=;
 b=RVKgYP6DrhF3Op5ZxUIOATLM+wmUeBDENn1xFlLqPGZYsByfDUvUIA270JQkwDcF04j0
 Ab8dTwiOaqmlughJ6QXYkCYkGNWj+TTeLmz2H/VvfTbHqH6IqsyqObVNsdgd1fOf3jNO
 XDH+kQHQvZIacIIJOir+JvLBZwiGHy3OBTo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tgx97s3uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 12:18:52 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Jul 2019 12:18:51 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Jul 2019 12:18:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3t8rEOqLID0vLpGQm044hmrh6JXygY2OxYPHO7+jSE=;
 b=OEy29Bs16XVGwjscRCFLU+JV5aTRnRWsktaGWjv7OIku+MnFQSyirIyUNqotGrPX2v9gBTo3VOOTApqauQEZcT0JzqCs0RxmtDiI0oqwRFZ2WQHfMvme97+RguvntJ94gTeYzAv2NR8PaHMXHVsVcXmShOsS8Yk1rmKfygDjx08=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2882.namprd15.prod.outlook.com (20.178.219.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.16; Wed, 3 Jul 2019 19:18:49 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::a169:14b9:5076:a1ff]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::a169:14b9:5076:a1ff%7]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 19:18:49 +0000
From:   Roman Gushchin <guro@fb.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH -next] kselftests: cgroup: remove duplicated include from
 test_freezer.c
Thread-Topic: [PATCH -next] kselftests: cgroup: remove duplicated include from
 test_freezer.c
Thread-Index: AQHVMNfnTHdDLm3deUmt1uz4w2/kL6a5RpIA
Date:   Wed, 3 Jul 2019 19:18:49 +0000
Message-ID: <20190703191844.GA19618@tower.DHCP.thefacebook.com>
References: <20190702131233.7064-1-yuehaibing@huawei.com>
In-Reply-To: <20190702131233.7064-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR18CA0044.namprd18.prod.outlook.com
 (2603:10b6:104:2::12) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:f7fd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fd65e53-ea08-45f3-d8c3-08d6ffeb46bb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB2882;
x-ms-traffictypediagnostic: BN8PR15MB2882:
x-microsoft-antispam-prvs: <BN8PR15MB2882D91E8258294E7EFEDC55BEFB0@BN8PR15MB2882.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(366004)(189003)(199004)(25786009)(14444005)(86362001)(256004)(4326008)(68736007)(7736002)(1076003)(305945005)(8936002)(76176011)(71200400001)(71190400001)(6916009)(386003)(81156014)(81166006)(8676002)(6506007)(52116002)(102836004)(99286004)(2906002)(6436002)(9686003)(6512007)(73956011)(46003)(53936002)(6486002)(6246003)(229853002)(54906003)(6116002)(33656002)(478600001)(64756008)(476003)(66476007)(66556008)(316002)(446003)(66946007)(5660300002)(11346002)(14454004)(4744005)(66446008)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2882;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ni6BDsTGZR5coQhg9XX6F7Fs012Oo53QSCbc9nwP4u8Qn2ERfK+BD9TGzO5Qm0Pz9q98BZXoSHZNy/O4pWxRToUf4gvyPTebZUflyi3ccA8Hta368KywtvEWq+izyUIheQaC/ZeC2MDXNgcHvntrS203J1fKZi9Tx/Hzylp5ge1iHEaG3mAb5Lrrp6hJHdOZan5tchbEtSY8VREFZ84TavLR5eGtapw/5dd9DOT3YtS2cfJ45lQzw2JN4CsGYVvpzjm8Qn6Bgax/EiYcRErlLdJLFNgPVVun09FkxvCxcdlD+XEJyZ6wASKQai4TV1M4v4CpdX+1j9j6St/LPYUl2WeagSjNF5ef0RCsPmrnwaf1mayqEoW3wHFNqpqRZJFTVoOZBSo1O54ODm7lgJ8RFQINTX7zcWYCPQ5NjUh/byM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99F121E8FC63584A9CEFF0980DB55D6E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd65e53-ea08-45f3-d8c3-08d6ffeb46bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 19:18:49.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2882
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030235
X-FB-Internal: deliver
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 02, 2019 at 09:12:33PM +0800, YueHaibing wrote:
> Remove duplicated include.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  tools/testing/selftests/cgroup/test_freezer.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testin=
g/selftests/cgroup/test_freezer.c
> index 2bfddb6..8219a30 100644
> --- a/tools/testing/selftests/cgroup/test_freezer.c
> +++ b/tools/testing/selftests/cgroup/test_freezer.c
> @@ -11,7 +11,6 @@
>  #include <stdlib.h>
>  #include <sys/inotify.h>
>  #include <string.h>
> -#include <sys/types.h>
>  #include <sys/wait.h>
> =20
>  #include "../kselftest.h"
> --=20
> 2.7.4
>=20
>=20
