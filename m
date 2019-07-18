Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBEA6D3BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2019 20:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfGRSTX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jul 2019 14:19:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726040AbfGRSTX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jul 2019 14:19:23 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x6II6Vds008605;
        Thu, 18 Jul 2019 11:19:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=khrjtnpG6kKmS72BYUdVyVePYfUYDGHmwtuP+Bs8IBc=;
 b=fxUxvHzLdeROapSBHpgMgZNL+xAIrcS2uq/RJXN+s6QzjM9Z70Vzg9DXbk6i+uOFwqbe
 G0RxqQK137+w7YZtAPxxIvcfUcCOhbggD5hUuyUFFMMPeBt1iacvOKsfYyg0I/U2UuX8
 zSW+CtN5XhiNAdGH9pUUrH6fvalXQWQotJ8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2ttckak9gm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 11:19:13 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 18 Jul 2019 11:19:11 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Jul 2019 11:19:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyfsjmKgu5/KXhknrc7Dz8f20Bg8iuvjlT7i+lddzikc/2QQBb/B2792SQD/yNVBi5331PlrItDYPFq6ZrQ4lDmxAQNY+BT7zqDRybEN6wc9DxZ1OhBlNisniABKSfxAD4R19YkUIMMr15y1TylBTBrdrY87oPjUUaKPKe3p3D4GdEry+EO+fB7+eSGKrJMCWL0pKEvZlducQhqNzFHbTrGxsI+MXBW47oFjLVDH/XguWc52BgE/ZBD6c+cBMwAO/KwMFvrwN+2wBOWgj5akc8PsUEr+7jMJUWrPT0CGe2eZNvGrVw+vF6ZDQ36zhIMwlK9zPXiQ4ed19t1GXe2ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khrjtnpG6kKmS72BYUdVyVePYfUYDGHmwtuP+Bs8IBc=;
 b=jr2ibeE073U+C4Bv2DfJusFWg9rAeBViscDEkBSvIDMRHog6JIkWXGK6aVNYt3aHBXBr+Ko0SaobbbQ/qvbntjITLKkOfwxy3oS4W82V+D77sF9qD1bqzK2/ymRmbMHAUOEKfb3NXjpNGu4l5HKM11P3iOw3Fys0sQRHa9BfqARX0JXVc+nY6lAEqq4x865lSzP9XIehiZK+vaQnTNLiKUEdJ8nr/0gqNPui69teqcDgXUHFPff+ag2gVMP29wPppHVhYw/xFmitKC9ZU2MaiMOzByyf0GcSI+NWTYTEa9+8j1ElSHsP5GqA1iuE3Kdijb5M9jG0raYYK8FXUcPjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khrjtnpG6kKmS72BYUdVyVePYfUYDGHmwtuP+Bs8IBc=;
 b=cfRFJZkfRCiXyMmVC0sKdplm8EYjowAel6I7DaQFLlXE7kalDdZxyULBRbOkI/cqqOVtUOSvdb2KVh7aVAUUGEQKleXAHWw618S4EbgejMqCsT8rCKV93sRJYy8jDYg4OS9oBb8z8BPPLpwcTXeMyEKc4XvQ5LdCY6CjvY9WPgI=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3724.namprd15.prod.outlook.com (10.141.167.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Thu, 18 Jul 2019 18:19:10 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053%3]) with mapi id 15.20.2094.011; Thu, 18 Jul 2019
 18:19:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>
Subject: Re: [PATCH v10 6/9] kselftests: cgroup: add freezer controller
 self-tests
Thread-Topic: [PATCH v10 6/9] kselftests: cgroup: add freezer controller
 self-tests
Thread-Index: AQHU69e+99TbmRtJs06SJqByGIH3TabN82yAgACnwQCAAIhGgIACL2wA
Date:   Thu, 18 Jul 2019 18:19:10 +0000
Message-ID: <20190718181904.GD6139@castle.dhcp.thefacebook.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-7-guro@fb.com>
 <CA+G9fYvz6MA0N8GgwY5QNdWBAw+XT9QcmwnABsSpjLnwz_jLzA@mail.gmail.com>
 <20190717004904.GA32357@castle.dhcp.thefacebook.com>
 <CA+G9fYt+UmakwaZAM4gR-B+V8kZUJVNh8gFBcXa4zU2j0Cz0ZQ@mail.gmail.com>
In-Reply-To: <CA+G9fYt+UmakwaZAM4gR-B+V8kZUJVNh8gFBcXa4zU2j0Cz0ZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:300:4b::30) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:500::f13c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65329f9e-3e58-4fda-e4ab-08d70bac6dba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB3724;
x-ms-traffictypediagnostic: DM6PR15MB3724:
x-microsoft-antispam-prvs: <DM6PR15MB37240052CA99EC9D0896BF5CBEC80@DM6PR15MB3724.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(71190400001)(386003)(71200400001)(52116002)(99286004)(68736007)(81166006)(76176011)(9686003)(33656002)(6512007)(81156014)(8936002)(186003)(4744005)(53936002)(8676002)(316002)(6506007)(6486002)(102836004)(478600001)(25786009)(229853002)(6436002)(54906003)(6246003)(66556008)(476003)(66476007)(4326008)(86362001)(14444005)(486006)(11346002)(66446008)(2906002)(446003)(14454004)(66946007)(305945005)(5660300002)(6116002)(46003)(6916009)(64756008)(256004)(1076003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3724;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B/3SxoIQ2HK1jCHME4tiqmgcEwSL/nwKdOnJGq/n3Yy4SFhfAkdzZTvz9Y71AZl3eqmIuk2/O0pCDNaXKdbslzFURIEaOfzJwgdP+JQcDnqePnQtlgMhqd5FLNN8jJ3NoyCLQsdmQE9X+/bDpCp6WSKAE+NvWXvNSK9O4rIYLkkvj8AyavHSjy7PMDuypUeOpQD06Cj/w1W9/84SzvYMevjORUZnk97M5OVM+53KMRSA6vw8XYWvQMaTBn+Ki+qK4f5GatwJctKV9QT5PlXcGiORCTmfEpoTo8tPcWVjPQhgdJFsyvB4gfWlj0iEWIF4ijrdMqbSfzWjFXQPTvcWQcE5rIU1CP99CU84NKKNes5EB0GWui9zo/d6sCiabTQ+rVS1Nh3KdYSZTlVOPmvVXb8WLZ/OJRyCYk92ixv9+00=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67975A3D2650094AB9D000C513E0331B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 65329f9e-3e58-4fda-e4ab-08d70bac6dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 18:19:10.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3724
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180187
X-FB-Internal: deliver
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 17, 2019 at 02:26:49PM +0530, Naresh Kamboju wrote:
> Hi Roman,
>=20
> > The interaction between ptrace and freezer is complicated
> > (as ptrace in general),so there are known cases when spurious
> > cgroup transitions (frozen <-> non frozen <-> frozen ) can happen.
>=20
> When test ran for 8 times it got failed 5 times.
> I have noticed intermittent failure on x86_64, arm64 hikey device and
> qemu_arm64.

Oh, it wasn't nearly as bad when I ran it. I'll take a look.

>=20
> >
> > Does it create any difficulties? If so, I'll send a diff to ignore
> > the result of this test for now.
>=20
> No difficulties. I will mark this test case as known failure.

Sure.

Thanks!
