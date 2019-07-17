Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BCC6B2F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2019 02:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfGQAt0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jul 2019 20:49:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbfGQAtZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jul 2019 20:49:25 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6H0lXg6030271;
        Tue, 16 Jul 2019 17:49:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2ku0EgpNaitFugfFNzpgMALweDBXYpV13ha37sxxzNA=;
 b=QbEAEUBUPn6VLAN/vtr8FYloi3NRkRU78Lid6weyNKNF6L82MGcl+6UiYtwu/HtfzBR0
 EolJ1gPXAo3+Nvzc1PYi4BpeXYkxkWF7nyumlcrCV+32S6pFZKuOlaR6HTrUeIL3zbf9
 jcN/aHGVue8l3K+rGa8291gDfwSyul+ph9w= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tsj89skbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Jul 2019 17:49:16 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 16 Jul 2019 17:49:15 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 16 Jul 2019 17:49:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtD68+BkzcCOBCszMzj77aH13eLu0wMKP15QvXiPRkF1Vs7VbhQKkOoExdRWXJxN38MliYs9IVM/Dz3r722SBXJX9NU91jCYvaRT83IVP/9N2TtXlMqQl+WvQxj3gCb9KQlRWXPs1jLupPeR2FpH1CkkDvm6cuWu4mGtbRCdFj4SYMR3w8/MCsHFXVUWFs4G9eT8edzUVeB5GPvPBZIMNdDmBr23E1KZ3I+fQFB2g3wqyeLu2MuC163DhyxQv4ZSJVfQm1sgCBfdKe40i+DJRVSM72WljfUxTd1kcXjOFuOUrFepNTXpxg0llhAkOyHh25jR18YUl8HXQnW+joXNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ku0EgpNaitFugfFNzpgMALweDBXYpV13ha37sxxzNA=;
 b=ldpxGMnQMMECIVc/VANfePpyFNpgWFNAEuC1YEW9Z+xnNk68lhb+fiDIalWpK51C9O6vit7ABBn6TFxRAzzi7KaQ7acD0AR5Ey3rPL1d8tgwXVZrZCV8SRUtjnaCZFou+V3nHFlE9q707SopSKLVsIcRD45kjGsg5K/WdCoBwblPCFuQCxFClOJ0CF6N4q7D9JC5JT2uDtsjJl+iVv5JsaZaRW9Tgr5v+SWlPybkr9abTYN8RlMGmjSPmFCR9no4QLZzdySCNgLY8DMlrzyOl/VCtGOEcOHcD4RBV5PlNH0zkOgUPIPhDhkEIybk1febihRzCav4QEhAWxUUNhKB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ku0EgpNaitFugfFNzpgMALweDBXYpV13ha37sxxzNA=;
 b=JlAW30qUeCKMtzBUftDIY+1IqJLiUTJTnRHfxw27GvjfOrYfylUKjU/tV3sajtOlbzuaAcC496xUmjcS6kDVwowioP0VmO8ya1ZvWZPld6wy0rFrEzSmvkgJHuqsk9ro4tlc7ZAZtlgv1EikMp2fhJFGjcwiAJpENYxYC2hNnqg=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3057.namprd15.prod.outlook.com (20.178.221.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 00:49:09 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::c8c8:6331:aba0:6f3d]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::c8c8:6331:aba0:6f3d%7]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 00:49:09 +0000
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
Thread-Index: AQHU69e+99TbmRtJs06SJqByGIH3TabN82yAgACnwQA=
Date:   Wed, 17 Jul 2019 00:49:09 +0000
Message-ID: <20190717004904.GA32357@castle.dhcp.thefacebook.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-7-guro@fb.com>
 <CA+G9fYvz6MA0N8GgwY5QNdWBAw+XT9QcmwnABsSpjLnwz_jLzA@mail.gmail.com>
In-Reply-To: <CA+G9fYvz6MA0N8GgwY5QNdWBAw+XT9QcmwnABsSpjLnwz_jLzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:f93c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3f5f401-a703-4aa7-9588-08d70a509401
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3057;
x-ms-traffictypediagnostic: BN8PR15MB3057:
x-microsoft-antispam-prvs: <BN8PR15MB305704F9BC4A38032DE49C98BEC90@BN8PR15MB3057.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(8676002)(186003)(9686003)(6512007)(6246003)(8936002)(68736007)(99286004)(76176011)(71200400001)(478600001)(305945005)(71190400001)(6116002)(386003)(316002)(14444005)(256004)(5024004)(6436002)(52116002)(102836004)(486006)(11346002)(54906003)(46003)(1076003)(81166006)(14454004)(229853002)(25786009)(2906002)(53936002)(446003)(6486002)(6916009)(5660300002)(476003)(7736002)(66446008)(86362001)(6506007)(33656002)(64756008)(66476007)(66946007)(4326008)(66556008)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3057;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cuurbjXu2kuo9C1Vm/Ju+ZjNX0pkRiXpw7nftMMf+IxiLTi4Gc4e+cGm0wtj7k6w+YAM+iEYHrhe3aTzD1rTWSFXwCwLQ2DeSeVC8dedNQvGfe19HLzgP0w19mW/CnI+Mtz57zYzs8DPov86gds0VbxT5Z423iFLSmSQg8i7B9vUZE4B4AF7+k56Bi3Tfh++5ZHmEz7bZXTmznDlg1ksI8eBQiqx3SiN2a8xIYH6nNxdJG4ncD32SzKqXI2m3EOzWCFYJrtWdKQYFW+LHVy0l3hfaluTQKIy7k5K33v4DknkoUjJRQJyp+MDJ9kkeUWIBPiecJClbPcHsfRyCTYmcTpP3x6n2rCu0QDjVvOqNoK6xSj+cCJRTLdXtMCcKW+KfId5DSLGFgqBcoiLixNduhPqHb1EfNiC0dFWxl27MU8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6615751279655F448AC550872ECF4FCD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f5f401-a703-4aa7-9588-08d70a509401
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 00:49:09.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3057
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=871 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170008
X-FB-Internal: deliver
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 16, 2019 at 08:18:39PM +0530, Naresh Kamboju wrote:
> Hi Roman,
>=20
> Just want to share information here on what we notice on running this tes=
t case,

Hi Naresh!

Thank you for the report!

The interaction between ptrace and freezer is complicated
(as ptrace in general),so there are known cases when spurious
cgroup transitions (frozen <-> non frozen <-> frozen ) can happen.

Does it create any difficulties? If so, I'll send a diff to ignore
the result of this test for now.

Thank you!

>=20
> On Fri, 5 Apr 2019 at 23:17, Roman Gushchin <guroan@gmail.com> wrote:
> >
> > This patch implements 9 tests for the freezer controller for
> > cgroup v2:
> ...
> > 6) ptrace test: the test checks that it's possible to attach to
> > a process in a frozen cgroup, get some information and detach, and
> > the cgroup will remain frozen.
>=20
> selftests cgroup test_freezer failed because of the sys entry path not fo=
und.

Can you, please, elaborate on this?

>  Cgroup /sys/fs/cgroup/unified/cg_test_ptrace isn't frozen
> /sys/fs/cgroup/unified/cg_test_ptrace: isn't_frozen #
> # not ok 6 test_cgfreezer_ptrace
>=20
> This test case fails intermittently.

Thank you!
