Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678475F35D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Oct 2022 20:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJCSsp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Oct 2022 14:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJCSsg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Oct 2022 14:48:36 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E513A16C;
        Mon,  3 Oct 2022 11:48:32 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293IQANB020875;
        Mon, 3 Oct 2022 18:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=cMQusVPdcsqrLuzUmPtz4zl2+2FxRPK2L2HmbLbCqA8=;
 b=W8zcMlLTc440oWAj10p6OxWvPCNdAueGu9bze6jG56GoKRz7N/Rl+AAnyB3EJ1+BLkc3
 hCf0pVIBeQPLzIOsebdbuTfx75aG0kVlOorzPfuu5cgCbGPNi3A5BW2sUB72XQ3EjMx3
 h6AZPL9JjAOOkRs/S5H369zaDLIJrpwS440+tOQPsze9+lAuSnU0zNnyoLr/V0cv+kEU
 8jlB2q/kkgZGPqMwDSXmui7wnVbM9VSd1PYrSnkbb5a1/zu5TWP15ev83x9aDbxdpVOw
 SPaAKnmyT2/gcEi8rJpGSGGORhdnhsxRoiO7e3gXRocTJOyxYGDOMjYZkUqqx+GoE4T8 pg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3jxbrhj52r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 18:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg0vpJFv70MMnarnu0VIjQGu5N+r8nWbdlxe0twpuzwvrKf8EaiKMWQ7pzLHUn44x7rg/39cZs3yv4qiae44HfNpqkGkecrpOw5ytH8JQ5VphilGaV1wCLFhBu/5BGBQb+0TU9vvD6hPTZwPp246VwsFixVnW3QClvtenyQxaCUa5wmVLK/OACEjO7iZhrStPJQak37SD3Y3qjAUAROMcYH1U1XeLim3qfkuwRxPEhfaAYWbPC/SvbdhOul6SelvUINKI+Pg0RCtblxQ11A2GflBtTkqlnbAPyY3eNOjDSkZb3kwLWn9pCpwpP6ZuCgG19/C9hhkNSox9FJ4Dvf1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMQusVPdcsqrLuzUmPtz4zl2+2FxRPK2L2HmbLbCqA8=;
 b=CK8VDo7B9ttid1PdxwNBT3fjOzRsFu9I6xIsKMCq8gxfirebshDRBbAscg/snPTcS2A+jG+drnU1oxCd3+Y2jhk/hkla1SiosIrCcbak3a4QfmkJDdPeNpJ4TUmEQZfseIKDOPN7Hqzj/8c/OZNUr8Kt4ZLpnfrdmQ8arhP9q3/Nga1fDV3G7NyhT1Pcy/MKuI3tRkEvVXnQDoVCOaJa2FoBR1j6U7/MhYG8dia1PPQY/K9ha3+zQVhAZ8vnZomxmSzkpm+gfUwHCYMQRMi0tjx1KEPDAf2ZnfAXJyoZMwNSopXi6qQ8AHh48bm5J3Is5gipo3B22KAGOMJ480p0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by CO1PR13MB4807.namprd13.prod.outlook.com (2603:10b6:303:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.8; Mon, 3 Oct
 2022 18:47:59 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f%2]) with mapi id 15.20.5676.015; Mon, 3 Oct 2022
 18:47:59 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     "joe@perches.com" <joe@perches.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        Richard Fontana <fontana@sharpeleven.org>,
        "copyleft-next@lists.fedorahosted.org" 
        <copyleft-next@lists.fedorahosted.org>,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: RE: [PATCH v11 1/2] LICENSES: Add the copyleft-next-0.3.1 license
Thread-Topic: [PATCH v11 1/2] LICENSES: Add the copyleft-next-0.3.1 license
Thread-Index: AQHY10l6l1FmHdI/MkqQVjLaNetMLK39AXAA
Date:   Mon, 3 Oct 2022 18:47:59 +0000
Message-ID: <BYAPR13MB25037C0C6980DEE627300B3DFD5B9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20221003165849.1658170-1-mcgrof@kernel.org>
 <20221003165849.1658170-2-mcgrof@kernel.org>
In-Reply-To: <20221003165849.1658170-2-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|CO1PR13MB4807:EE_
x-ms-office365-filtering-correlation-id: 02cd823b-3464-4c5f-7411-08daa56fcb4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRSP6dNQJvU7Wia6u5KTJ2TjEZCuiSdgVFEXo4azM0MvCpZSkM6v48jvv6etJnmelJi9y1FLt7knYI8xpOb9TEUwwCSxmV3lBn+QbGFC9cUta70V864kIJGTGLwuHeushVdbRUIV0YlqkUX664ghtY8cBYHUeJ4SDJQKPMtELjTIzEsYsDFPBVA0JO9FPgXZBy9b+eXEFKakJli96gh9Hz1l8dfEGkJvunH0M9vQbr/e7on3kCTaaX5Vwqdlzn1Q8J7/rHUXeLh087Vs1J8/2elmfBmwslFOwgRPxTEq8w6CJ53XJNoqk9BstMD6bZKCGIDitSWFenEr4Oetck3K3vVSjQsNviK2qcZliaxHJUqoWVTkaSiMMc8QulyCOwB7tpHePpgmMatP7zTye1nxCVIzU+WDkcObhRfGltz/hH1i1xOb6ASYIUPSj3h02CTGS5BfsEVEzHtoMEZYMFp+K2WIE3DX7AKRJ3JUyd3OD5e+6wZRyR9m3xGq5QKzYCYMq1uqB1pwZ37QZyE3zHmGsH3yg1zGAtwSltNU+At8wb1+qkKQddfDlWU2TeZ9MpsGOgZvl8tXhKIZMdGklOyD3BIISUmnRHktAxztQZIn/MmMk4zTypq8OBGsfwvLUXE780cIAnk9xSBRrxUu80v6nzxPbazM3hWJWqQnzY/bJyYRvujEByDp1SevLuRY5X3Mjpk8zNT1/13Fnhfj4diyM80ApSXuOTfc3QNnBKDVRJgQO3o02kbUmxMt+FF5n8kkTlMSjvm8Nqzg/Fje85FiTa6c2vmja+2E7dwB1M0qZRr9DRIl7+nzUtG5bhPcNUcBCxlAtVxtcSVEmfXhE9XyVZweszhTMCHPdt17NcN/3K4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(71200400001)(966005)(83380400001)(38070700005)(33656002)(41300700001)(55016003)(86362001)(38100700002)(82960400001)(122000001)(8936002)(30864003)(52536014)(6506007)(7696005)(66899015)(316002)(66476007)(66446008)(64756008)(8676002)(4326008)(66556008)(66946007)(76116006)(2906002)(54906003)(9686003)(110136005)(478600001)(26005)(7416002)(186003)(5660300002)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2fe6pYTmQH1+VfEWGvD8Y7BjI7KXIQtgu2boZZXPbKh2P/LurCWdvl38ZGWf?=
 =?us-ascii?Q?NvtKXeiDp0WajGeXHZVsk1lbLPtQ9Gbro+p/Jn1gS+ItQ7MXlwv1ygXyB6CP?=
 =?us-ascii?Q?pqS1Jginaui8TEwlR/bWd6ZDwb7oGj2eFz7jEfHaTN2+7Ncf+/3PxqbetjZA?=
 =?us-ascii?Q?dkjTn7KmGHC/KEvFsM0kaKtMeB9RGDD/0kVkZvOCziE8yhmdQVgqjeOV804a?=
 =?us-ascii?Q?rYK/s2czc9m8nlWvaagdGIAiZASBD2jHcb8Icj4vVLv2bLMLaOorUdm9FnKL?=
 =?us-ascii?Q?y4JOSFBX9eehiULewe21yECbZVTUV27Yc92mKSIFh+hRkJPUe+XH0SxajeN2?=
 =?us-ascii?Q?fO0OJesuvfv0p951km2M2oik+zpY7ixWBVfIn40JiKZpy1ZNlsLVWnAUJJKP?=
 =?us-ascii?Q?P9tGzIdBeq41BzrH9/Le3zqWA5N/eFzE1o9ijsP6WRFNt+OMF7alLr3dSp+W?=
 =?us-ascii?Q?lbXTn/xwz84peblL9RZxLif2olT0dPtO9Yws9uPw+zmQ30UFaujDaYnD4tEB?=
 =?us-ascii?Q?SLuZZLppDqfG75QSasmXGz8SkxXuctZl5lEKITOhUAePIJOp4iK3nq3xaSD5?=
 =?us-ascii?Q?4H2HtoiYSli4olBFzZBl3iE9G4ZzhAeBqZCFDMsCWSNouYpNelaZ7yxw4pnf?=
 =?us-ascii?Q?XlwkEdAIhqzwWkLFR5B22PAr0yhgI35Yxq9e+EKGYnYdT8y11j7Q4Ecfwwqu?=
 =?us-ascii?Q?dMmjfxFfV0Ej9tLqvq1vXG4O+dlXaCH4rN6fyKe87wI3FutP8NSPXR5WAg60?=
 =?us-ascii?Q?PFtlMFZm5jN61vmgCscMmRsCG63r6S7zHrgWpLz6ZyFszkt5/4X+6xuCMq3c?=
 =?us-ascii?Q?ZXWdP1/+xcn1gz3p3ER3WIKda2p00h9uI3wuukYWwC32xysaN261aBsJlvzQ?=
 =?us-ascii?Q?ZX1OFWC6gJc8L8UEIhd1j1Pi4Y+SS0xCRU73LL9Ft6AAtkPXTN4SBqGLRDnm?=
 =?us-ascii?Q?sjtda6rzaH9ncpEUOAhVFV2YRE3zrPsgpV0TtRw39SOEZ45wDPzXbWVIGy4N?=
 =?us-ascii?Q?nreE+FJVSNttDPoil467zoavDtS//2wQfvSUpLY6yFRdBvUJaEw3Vzmax1xL?=
 =?us-ascii?Q?flESssSYcPagGiltsmw0WGETqwOcsKsk8m+xu3VCoCpln2G0Z9WvfUudzSRy?=
 =?us-ascii?Q?ZKSZReBKu3+DyXncXbLevz1zs88RpMkmhBya0RUjVHmEvDMyoIbcXNHrMFhM?=
 =?us-ascii?Q?RBwlnOB0ucvItzumg8UJUcuZUnqUpcF88IpRsgyHvNAK0U2ZTTSb4Qu77tkR?=
 =?us-ascii?Q?sOTcy9btuO/KQSy1t9jLKXTyAwQ/Aro4tVGsZxidbXvghZWuyvB93gS3QWRi?=
 =?us-ascii?Q?Rt0DIteBC0so/zGFNiLs3JI6rDyNy5oKZ96sZoVdKqhnMzMtvs3aiWO19ZkE?=
 =?us-ascii?Q?PVjoiy7GtQN086WrBgDuA/5FI23hsqXVWDsHZ+LvJv5F9UtLI+UyV8O6mGXC?=
 =?us-ascii?Q?2W2TXWLlfeHZWfMXz8uGjCcVbWTLAPteFg/dyRr7DTCj6rTEpP3HnmtNg5Vg?=
 =?us-ascii?Q?gmGkYlAjJNg41te+8gXCZpqy8FmAjj9KpSPQWlwHcbFZZRaskNgeTF3ofXvp?=
 =?us-ascii?Q?BVUrs8v21vNJp3awA15j1Nk9W0aY7ZnEM8Ng+G3g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cd823b-3464-4c5f-7411-08daa56fcb4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 18:47:59.6903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MK0glvAsNfSN7ZiGxLEOik2WE97yDe92uTzcwx0xu/jDD8Ds3wp88l8kbSxHjqAIxMuX48HeaQoTLjUzSyK/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4807
X-Proofpoint-GUID: 77ZNM63LdrBVl12fGZEnuCoIzwmPHnUo
X-Proofpoint-ORIG-GUID: 77ZNM63LdrBVl12fGZEnuCoIzwmPHnUo
X-Sony-Outbound-GUID: 77ZNM63LdrBVl12fGZEnuCoIzwmPHnUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -----Original Message-----
> From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis Chamberla=
in
> Subject: [PATCH v11 1/2] LICENSES: Add the copyleft-next-0.3.1 license
>=20
> Add the full text of the copyleft-next-0.3.1 license to the kernel
> tree as well as the required tags for reference and tooling.
> The license text was copied directly from the copyleft-next project's
> git tree [0].
>=20
> Discussion of using copyleft-next-0.3.1 on Linux started since June,
> 2016 [1]. In the end Linus' preference was to have drivers use
> MODULE_LICENSE("GPL") to make it clear that the GPL applies when it
> comes to Linux [2]. Additionally, even though copyleft-next-0.3.1 has
> been found to be to be GPLv2 compatible by three attorneys at SUSE and
> Redhat [3], to err on the side of caution we simply recommend to
> always use the "OR" language for this license [4].
>=20
> Even though it has been a goal of the project to be GPL-v2 compatible
> to be certain in 2016 I asked for a clarification about what makes
> copyleft-next GPLv2 compatible and also asked for a summary of
> benefits. This prompted some small minor changes to make compatibility
> even further clear and as of copyleft 0.3.1 compatibility should
> be crystal clear [5].
>=20
> The summary of why copyleft-next 0.3.1 is compatible with GPLv2
> is explained as follows:
>=20
>   Like GPLv2, copyleft-next requires distribution of derivative works
>   ("Derived Works" in copyleft-next 0.3.x) to be under the same license.
>   Ordinarily this would make the two licenses incompatible. However,
>   copyleft-next 0.3.1 says: "If the Derived Work includes material
>   licensed under the GPL, You may instead license the Derived Work under
>   the GPL." "GPL" is defined to include GPLv2.
>=20
> In practice this means copyleft-next code in Linux may be licensed
> under the GPL2, however there are additional obvious gains for
> bringing contributions from Linux outbound where copyleft-next is
> preferred. A summary of benefits why projects outside of Linux might
> prefer to use copyleft-next >=3D 0.3.1 over GPLv2:
>=20
> o It is much shorter and simpler
> o It has an explicit patent license grant, unlike GPLv2
> o Its notice preservation conditions are clearer
> o More free software/open source licenses are compatible
>   with it (via section 4)
> o The source code requirement triggered by binary distribution
>   is much simpler in a procedural sense
> o Recipients potentially have a contract claim against distributors
>   who are noncompliant with the source code requirement
> o There is a built-in inbound=3Doutbound policy for upstream
>   contributions (cf. Apache License 2.0 section 5)
> o There are disincentives to engage in the controversial practice
>   of copyleft/ proprietary dual-licensing
> o In 15 years copyleft expires, which can be advantageous
>   for legacy code
> o There are explicit disincentives to bringing patent infringement
>   claims accusing the licensed work of infringement (see 10b)
> o There is a cure period for licensees who are not compliant
>   with the license (there is no cure opportunity in GPLv2)
> o copyleft-next has a 'built-in or-later' provision
>=20
> The first driver submission to Linux under this dual strategy was
> lib/test_sysctl.c through commit 9308f2f9e7f05 ("test_sysctl: add
> dedicated proc sysctl test driver") merged in July 2017. Shortly after
> that I also added test_kmod through commit d9c6a72d6fa29 ("kmod: add
> test driver to stress test the module loader") in the same month. These
> two drivers went in just a few months before the SPDX license practice
> kicked in. In 2018 Kuno Woudt went through the process to get SPDX
> identifiers for copyleft-next [6] [7]. Although there are SPDX tags
> for copyleft-next-0.3.0, we only document use in Linux starting from
> copyleft-next-0.3.1 which makes GPLv2 compatibility crystal clear.
>=20
> This patch will let us update the two Linux selftest drivers in
> subsequent patches with their respective SPDX license identifiers and
> let us remove repetitive license boiler plate.
>=20
> [0] https://github.com/copyleft-next/copyleft-next/blob/master/Releases/c=
opyleft-next-0.3.1
> [1] https://lore.kernel.org/lkml/1465929311-13509-1-git-send-email-mcgrof=
@kernel.org/
> [2] https://lore.kernel.org/lkml/CA+55aFyhxcvD+q7tp+-yrSFDKfR0mOHgyEAe=3D=
f_94aKLsOu0Og@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/20170516232702.GL17314@wotan.suse.de/
> [4] https://lkml.kernel.org/r/1495234558.7848.122.camel@linux.intel.com
> [5] https://lists.fedorahosted.org/archives/list/copyleft-
> next@lists.fedorahosted.org/thread/JTGV56DDADWGKU7ZKTZA4DLXTGTLNJ57/#SQMD=
IKBRAVDOCT4UVNOOCRGBN2UJIKHZ
> [6] https://spdx.org/licenses/copyleft-next-0.3.0.html
> [7] https://spdx.org/licenses/copyleft-next-0.3.1.html
>=20
> Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Cc: Kuno Woudt <kuno@frob.nl>
> Cc: Richard Fontana <fontana@sharpeleven.org>
> Cc: copyleft-next@lists.fedorahosted.org
> Cc: Ciaran Farrell <Ciaran.Farrell@suse.com>
> Cc: Christopher De Nicolo <Christopher.DeNicolo@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  LICENSES/dual/copyleft-next-0.3.1 | 236 ++++++++++++++++++++++++++++++

I'm OK with this license going into the LICENSES/dual directory, and being =
used
as an "OR" along with GPL-2.0.

>  1 file changed, 236 insertions(+)
>  create mode 100644 LICENSES/dual/copyleft-next-0.3.1
>=20
> diff --git a/LICENSES/dual/copyleft-next-0.3.1 b/LICENSES/dual/copyleft-n=
ext-0.3.1
> new file mode 100644
> index 000000000000..c81acf710657
> --- /dev/null
> +++ b/LICENSES/dual/copyleft-next-0.3.1
> @@ -0,0 +1,236 @@
> +Valid-License-Identifier: copyleft-next-0.3.1
> +SPDX-URL: https://spdx.org/licenses/copyleft-next-0.3.1
> +Usage-Guide:
> +  copyleft-next-0.3.1 is explicitly compatible with GPLv2 (or later) and
> +  can therefore be used for kernel code. Though the best and recommended
> +  practice is to express this in the SPDX license identifier by
> +  licensing the code under both licenses expressed by the OR operator.
> +  To use the copyleft-next-0.3.1 license put the following SPDX tag/valu=
e
> +  pair into a comment according to the placement guidelines in the
> +  licensing rules documentation:
> +    SPDX-License-Identifier: GPL-2.0-only OR copyleft-next 0.3.1
> +    SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1

Sounds good.  It's good to cover both cases.

> +License-Text:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +                      copyleft-next 0.3.1 ("this License")
> +                            Release date: 2016-04-29
> +
> +1. License Grants; No Trademark License
> +
> +   Subject to the terms of this License, I grant You:
> +
> +   a) A non-exclusive, worldwide, perpetual, royalty-free, irrevocable
> +      copyright license, to reproduce, Distribute, prepare derivative wo=
rks
> +      of, publicly perform and publicly display My Work.
> +
> +   b) A non-exclusive, worldwide, perpetual, royalty-free, irrevocable
> +      patent license under Licensed Patents to make, have made, use, sel=
l,
> +      offer for sale, and import Covered Works.
> +
> +   This License does not grant any rights in My name, trademarks, servic=
e
> +   marks, or logos.
> +
> +2. Distribution: General Conditions
> +
> +   You may Distribute Covered Works, provided that You (i) inform
> +   recipients how they can obtain a copy of this License; (ii) satisfy t=
he
> +   applicable conditions of sections 3 through 6; and (iii) preserve all
> +   Legal Notices contained in My Work (to the extent they remain
> +   pertinent). "Legal Notices" means copyright notices, license notices,
> +   license texts, and author attributions, but does not include logos,
> +   other graphical images, trademarks or trademark legends.
> +
> +3. Conditions for Distributing Derived Works; Outbound GPL Compatibility
> +
> +   If You Distribute a Derived Work, You must license the entire Derived
> +   Work as a whole under this License, with prominent notice of such
> +   licensing. This condition may not be avoided through such means as
> +   separate Distribution of portions of the Derived Work.
> +
> +   If the Derived Work includes material licensed under the GPL, You may
> +   instead license the Derived Work under the GPL.
> +
> +4. Condition Against Further Restrictions; Inbound License Compatibility
> +
> +   When Distributing a Covered Work, You may not impose further
> +   restrictions on the exercise of rights in the Covered Work granted un=
der
> +   this License. This condition is not excused merely because such
> +   restrictions result from Your compliance with conditions or obligatio=
ns
> +   extrinsic to this License (such as a court order or an agreement with=
 a
> +   third party).
> +
> +   However, You may Distribute a Covered Work incorporating material
> +   governed by a license that is both OSI-Approved and FSF-Free as of th=
e
> +   release date of this License, provided that compliance with such
> +   other license would not conflict with any conditions stated in other
> +   sections of this License.
> +
> +5. Conditions for Distributing Object Code
> +
> +   You may Distribute an Object Code form of a Covered Work, provided th=
at
> +   you accompany the Object Code with a URL through which the Correspond=
ing
> +   Source is made available, at no charge, by some standard or customary
> +   means of providing network access to source code.
> +
> +   If you Distribute the Object Code in a physical product or tangible
> +   storage medium ("Product"), the Corresponding Source must be availabl=
e
> +   through such URL for two years from the date of Your most recent
> +   Distribution of the Object Code in the Product. However, if the Produ=
ct
> +   itself contains or is accompanied by the Corresponding Source (made
> +   available in a customarily accessible manner), You need not also comp=
ly
> +   with the first paragraph of this section.
> +
> +   Each direct and indirect recipient of the Covered Work from You is an
> +   intended third-party beneficiary of this License solely as to this
> +   section 5, with the right to enforce its terms.
> +
> +6. Symmetrical Licensing Condition for Upstream Contributions
> +
> +   If You Distribute a work to Me specifically for inclusion in or
> +   modification of a Covered Work (a "Patch"), and no explicit licensing
> +   terms apply to the Patch, You license the Patch under this License, t=
o
> +   the extent of Your copyright in the Patch. This condition does not
> +   negate the other conditions of this License, if applicable to the Pat=
ch.
> +
> +7. Nullification of Copyleft/Proprietary Dual Licensing
> +
> +   If I offer to license, for a fee, a Covered Work under terms other th=
an
> +   a license that is OSI-Approved or FSF-Free as of the release date of =
this
> +   License or a numbered version of copyleft-next released by the
> +   Copyleft-Next Project, then the license I grant You under section 1 i=
s no
> +   longer subject to the conditions in sections 3 through 5.
> +
> +8. Copyleft Sunset
> +
> +   The conditions in sections 3 through 5 no longer apply once fifteen
> +   years have elapsed from the date of My first Distribution of My Work
> +   under this License.
> +
> +9. Pass-Through
> +
> +   When You Distribute a Covered Work, the recipient automatically recei=
ves
> +   a license to My Work from Me, subject to the terms of this License.
> +
> +10. Termination
> +
> +    Your license grants under section 1 are automatically terminated if =
You
> +
> +    a) fail to comply with the conditions of this License, unless You cu=
re
> +       such noncompliance within thirty days after becoming aware of it,=
 or
> +
> +    b) initiate a patent infringement litigation claim (excluding
> +       declaratory judgment actions, counterclaims, and cross-claims)
> +       alleging that any part of My Work directly or indirectly infringe=
s
> +       any patent.
> +
> +    Termination of Your license grants extends to all copies of Covered
> +    Works You subsequently obtain. Termination does not terminate the
> +    rights of those who have received copies or rights from You subject =
to
> +    this License.
> +
> +    To the extent permission to make copies of a Covered Work is necessa=
ry
> +    merely for running it, such permission is not terminable.
> +
> +11. Later License Versions
> +
> +    The Copyleft-Next Project may release new versions of copyleft-next,
> +    designated by a distinguishing version number ("Later Versions").
> +    Unless I explicitly remove the option of Distributing Covered Works
> +    under Later Versions, You may Distribute Covered Works under any Lat=
er
> +    Version.
> +
> +** 12. No Warranty                                                      =
 **
> +**                                                                      =
 **
> +**     My Work is provided "as-is", without warranty. You bear the risk =
 **
> +**     of using it. To the extent permitted by applicable law, each     =
 **
> +**     Distributor of My Work excludes the implied warranties of title, =
 **
> +**     merchantability, fitness for a particular purpose and            =
 **
> +**     non-infringement.                                                =
 **
> +
> +** 13. Limitation of Liability                                          =
 **
> +**                                                                      =
 **
> +**     To the extent permitted by applicable law, in no event will any  =
 **
> +**     Distributor of My Work be liable to You for any damages          =
 **
> +**     whatsoever, whether direct, indirect, special, incidental, or    =
 **
> +**     consequential damages, whether arising under contract, tort      =
 **
> +**     (including negligence), or otherwise, even where the Distributor =
 **
> +**     knew or should have known about the possibility of such damages. =
 **
> +
> +14. Severability
> +
> +    The invalidity or unenforceability of any provision of this License
> +    does not affect the validity or enforceability of the remainder of
> +    this License. Such provision is to be reformed to the minimum extent
> +    necessary to make it valid and enforceable.
> +
> +15. Definitions
> +
> +    "Copyleft-Next Project" means the project that maintains the source
> +    code repository at <https://github.com/copyleft-next/copyleft-next.g=
it/>
> +    as of the release date of this License.
> +
> +    "Corresponding Source" of a Covered Work in Object Code form means (=
i)
> +    the Source Code form of the Covered Work; (ii) all scripts,
> +    instructions and similar information that are reasonably necessary f=
or
> +    a skilled developer to generate such Object Code from the Source Cod=
e
> +    provided under (i); and (iii) a list clearly identifying all Separat=
e
> +    Works (other than those provided in compliance with (ii)) that were
> +    specifically used in building and (if applicable) installing the
> +    Covered Work (for example, a specified proprietary compiler includin=
g
> +    its version number). Corresponding Source must be machine-readable.
> +
> +    "Covered Work" means My Work or a Derived Work.
> +
> +    "Derived Work" means a work of authorship that copies from, modifies=
,
> +    adapts, is based on, is a derivative work of, transforms, translates=
 or
> +    contains all or part of My Work, such that copyright permission is
> +    required. The following are not Derived Works: (i) Mere Aggregation;
> +    (ii) a mere reproduction of My Work; and (iii) if My Work fails to
> +    explicitly state an expectation otherwise, a work that merely makes
> +    reference to My Work.
> +
> +    "Distribute" means to distribute, transfer or make a copy available =
to
> +    someone else, such that copyright permission is required.
> +
> +    "Distributor" means Me and anyone else who Distributes a Covered Wor=
k.
> +
> +    "FSF-Free" means classified as 'free' by the Free Software Foundatio=
n.
> +
> +    "GPL" means a version of the GNU General Public License or the GNU
> +    Affero General Public License.
> +
> +    "I"/"Me"/"My" refers to the individual or legal entity that places M=
y
> +    Work under this License. "You"/"Your" refers to the individual or le=
gal
> +    entity exercising rights in My Work under this License. A legal enti=
ty
> +    includes each entity that controls, is controlled by, or is under
> +    common control with such legal entity. "Control" means (a) the power=
 to
> +    direct the actions of such legal entity, whether by contract or
> +    otherwise, or (b) ownership of more than fifty percent of the
> +    outstanding shares or beneficial ownership of such legal entity.
> +
> +    "Licensed Patents" means all patent claims licensable royalty-free b=
y
> +    Me, now or in the future, that are necessarily infringed by making,
> +    using, or selling My Work, and excludes claims that would be infring=
ed
> +    only as a consequence of further modification of My Work.
> +
> +    "Mere Aggregation" means an aggregation of a Covered Work with a
> +    Separate Work.
> +
> +    "My Work" means the particular work of authorship I license to You
> +    under this License.
> +
> +    "Object Code" means any form of a work that is not Source Code.
> +
> +    "OSI-Approved" means approved as 'Open Source' by the Open Source
> +    Initiative.
> +
> +    "Separate Work" means a work that is separate from and independent o=
f a
> +    particular Covered Work and is not by its nature an extension or
> +    enhancement of the Covered Work, and/or a runtime library, standard
> +    library or similar component that is used to generate an Object Code
> +    form of a Covered Work.
> +
> +    "Source Code" means the preferred form of a work for making
> +    modifications to it.
> --
> 2.35.1

I reviewed the license placement and usage guide, but not the wording (cont=
ent)
of the license text file itself.

FWIW,
Reviewed-by: Tim Bird <tim.bird@sony.com>

 -- Tim

