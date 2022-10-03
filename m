Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E411C5F35C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Oct 2022 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJCSn4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Oct 2022 14:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJCSny (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Oct 2022 14:43:54 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5936432;
        Mon,  3 Oct 2022 11:43:52 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293HaKPo007744;
        Mon, 3 Oct 2022 18:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=E6L/Jw4K/88b2SNAQ2ys4YNLcfpkjIqCG/S7tZeYLx4=;
 b=UkinIQfm3Dml3aXILPccFDunviISBLkmYWVhldSrl19J6s5usGYqsSa/osQNS3ICJky7
 Wd3OtbZRAozXYrSfFsiC+zf7TvbuEsdWJw7B1vwKu4yV91SdRzAFUh4ZK/15NNpk2ug8
 Jtko5vffN/V8HIkuzD4FO2nyLV+YEJIHBec0m81k4ywDPFhRLOteWNWrzi0QZd5k4L9n
 sB4rLndTTqYlkXVoAweVQ7mKwVJLDFRwi41R16mCfOJkHh3zETHL95y2b6l2o1oiAAdx
 jVdEW50AmNhyMIhTbhmvT25G4pAikiChkGRRNe8MrwFVDWNthnddvbh9qFgOSPGIdbvH rQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3jxbrhj4w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 18:43:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA2crHRZ9kymio6HBRx1yAQMLw2GoTu3U+4Aoiq/F6w2iFFuGooYn69Xo7E66Cxxf4MtCCWjo3xC2Wad37btvUTcXDnP7bSaAGJfwTcfW8KKSWg3lylawHWv5eDBqTg/eMe2xgcKjQM3T7pa8vrSEbrC6LK56PaHldlklmy95W85HooF5r+rUcuZI1lsj/7wzvFX890BHw4ePfMqV/qFaD1o676CGE1JhOPgwl+Rb2POIks1dl/+Ox7kVt1FcGXe/Hig2bgMJQgXNLekK8RUQMaeM6CrgqE/89E6+oP+3WS61TN9+N4NH/fOEvOdXyJq0+ersDNIWuVMKjCwiFFUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6L/Jw4K/88b2SNAQ2ys4YNLcfpkjIqCG/S7tZeYLx4=;
 b=J/g9lKRa2mjyNghdAP+ktGncL+vJqaZU30e4iYw/cWRRxMrRx/0Xo8R+v8tvMxJ/zu2evAkhPXKUjQ0FF/SFTfgad2NlGeQNCDQmPgaIBrlVQLLYHUMVyqGvCbRfL7f6Momje2X28JGdXD0QbMEko3b1sk9o5t4MWdmtUUlPXNlpn12Zba2Bp1GrHcvNFTDMsIZbfwMjRX/91o1AJTJUL5uQ94CwiuZNHeE2BpVVZbI5eYio5T6PdL0oozKgFBjvKykFs8ZTtDMUtg02cjiRygNh7yhDfAVTZOdy7M2joGwfzgn5BVSS2vvvmXbULLJKArc8G8KZkMBb1haP5YfdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by MW3PR13MB4090.namprd13.prod.outlook.com (2603:10b6:303:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.8; Mon, 3 Oct
 2022 18:42:59 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f%2]) with mapi id 15.20.5676.015; Mon, 3 Oct 2022
 18:42:59 +0000
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
Subject: RE: [PATCH v11 2/2] testing: use the copyleft-next-0.3.1 SPDX tag
Thread-Topic: [PATCH v11 2/2] testing: use the copyleft-next-0.3.1 SPDX tag
Thread-Index: AQHY10l43JtgllRc10eeUGsqlYrAPK38/6Zw
Date:   Mon, 3 Oct 2022 18:42:59 +0000
Message-ID: <BYAPR13MB2503DA96FB9E4F0ABF62B795FD5B9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20221003165849.1658170-1-mcgrof@kernel.org>
 <20221003165849.1658170-3-mcgrof@kernel.org>
In-Reply-To: <20221003165849.1658170-3-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|MW3PR13MB4090:EE_
x-ms-office365-filtering-correlation-id: dd7a5a4d-564d-4c38-3c0b-08daa56f187a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HLmiczAQiGmiSxUej1mNHRhkNyHMIyQ0ryX/zm6zL3qhdfLeTF2MxIcFqRWpM3QbnTzYexXqEHJo6+qoY14n1FxJPK3Y3tVTfGCjdGL4VNdZIHFTqJh4ZyJZ9Tvp/3g5x50COwn7Lb+eK4McZSt39RXTJq7qNl32MmS7RElISvwaD+C34VWsyUzQg1L+0dV7EomUlgN/jOCtaMSj0q5E1269zCLCbpi7XtmiN2PbFA/vuawTjmMiW6ajQh78NU9b+DMLHCa3TZtS8AoDo0s8Dhn0UurBIWjfqj4UppTSQBoZgimNk1fi5TI2LEaWQZQ+OPNLboCk4IBQRQQD8w9VHOeCU2bxvmKrLCTs9zpvflx+hmszV6jR6q1w4/PSC23Jlm/qiUTPTTGIw4dcUypk4Okn+VnLFVCPR11srg+tLkBkVkKOSSLP/hbhCZWIUQ5YKEzIN+QkiNwYNrOebaIrIH5ZH5BPcQ0DfeEQUA68BMHbvxiorHhRkbFHCCF4drZDgSWMX/fOy8zFkLk3xd/OoS00CGY/x3Ls6XvmTbKqmJutn61MKwzpRpWCLtnON62Qd69mPGy7pDmb9FyOE2/V33PbrBVG+bUSqcxLcJkYMTLZK2+XMC77O4J54aeMdPntIRIPWe/OlxnZnrGg+OkzS07BC8u6W7fIl/hLTMEj3TGXqVMBQ2X5HzFS1mg6gpRBg4JVai/C3GwlbeVbY87DFbXP1TLnGGe6GfGilsaemNfXOsl8DkZp2gNZf5kG4ODj5Rdukccy9PB6cedSa0338FKJcYWEvMWWQKdBkiOoKlgqwPL6gpXov9VJVtNGf3Vb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(66476007)(64756008)(66946007)(8676002)(4326008)(66899015)(66556008)(66446008)(33656002)(71200400001)(86362001)(966005)(38070700005)(7416002)(38100700002)(5660300002)(54906003)(2906002)(7696005)(82960400001)(110136005)(122000001)(6506007)(186003)(9686003)(26005)(8936002)(76116006)(55016003)(52536014)(316002)(478600001)(41300700001)(83380400001)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D7l1MmeQ50ccjEOfOLjfqZO/aTVNRhHbfGezLEB0afI2onKtVj5zSNBuRUT3?=
 =?us-ascii?Q?/C4W6nbqAcvZMVva592x+4fU427Yhh+2MlJsm9E71qAjhRXkz2Qr4+ICxT+9?=
 =?us-ascii?Q?0yUh7s+vY3OMkwge+1IYpda8Tx8K1PmENS0TCPTv/BUBeshXh8arsJfyJDX2?=
 =?us-ascii?Q?8o+l739byDPy7xWu5MgKeEDRSviydDOVq4pDPI3IP25fIv65GacxuZsQKzU2?=
 =?us-ascii?Q?49lZU5qT5XNS2GwNZXvyARRIe6HkGXV+NfGVEv08b+cwUObCJHCRk+0tcNjL?=
 =?us-ascii?Q?8LWk4Oqm+luBbA49fI46fU58Q7/cMJIlVzAjC0Tu5TQ4LRlXh5Jl7CO14IHZ?=
 =?us-ascii?Q?zAl2iRHaoNw4XO3QEE5Xtm73s7xl55A7xZze3xTDZ1ygWrKPl00ybUdmgzhR?=
 =?us-ascii?Q?TMV+vlnB2cm1Pprl/ilFQYH5SmSLbaMG6tCuttIGIVqhY2BhXTXzhXRgvPCr?=
 =?us-ascii?Q?Qp9wlOQDLQb2kqudqO9fHaB+EPMXI+J/VumNC276nDcxFeGzj4qRZupX324N?=
 =?us-ascii?Q?GXA7FFwpucEvY76bjwGaYExy+GrTGRfYnwuIyP0+KNuFCf7+c4lnBJRF19Fn?=
 =?us-ascii?Q?ZGneyd6lBIV4SzuJZOyZqCpV+fPA5PdP70rgrnURbKYBcSc9YJW0/7cKDfZK?=
 =?us-ascii?Q?OGVgkeJfrI2HY/SPUtbP3pnfl7A9U1RnBK2eMIl/ZYycnPVqP7BqXFHwtKqu?=
 =?us-ascii?Q?+op5wZXt2pSaF00FtvXTUn/iohVCFpoQ0Oo219UC1xXgyYNaXdnq0wOTRakF?=
 =?us-ascii?Q?aTwcBN2TjkDkmqgbKthtJfHXykronhWCk4MsOYQxcW1Falb5Zknzkblda5Ku?=
 =?us-ascii?Q?WF3jzIM5whuobbxWaDqk83nXhW82Y+HOkrwCnAfXDpZ8q7UMFkXUP6NCf4mA?=
 =?us-ascii?Q?39nHEub/y5AvluY/It+4USGodgxKcmr40DibcdIi1a/FCdqQbQc5/UjC1mye?=
 =?us-ascii?Q?E3sCnS/diulXnvxjXGd3Gv+lPMUdehpBXfks6L+M0RcuFSppdDuk5Yn+XUJw?=
 =?us-ascii?Q?RNHW/P9cMVTX97AGFN9YbvR63nRDEoaiEooue1JFyB9iXxqxspgq9e8TdMrW?=
 =?us-ascii?Q?fYssD3E/lm/scGdZZn3+vLH/tFrj85KBUDMPJ+9v83G2sFMlR3EGg73gzhdZ?=
 =?us-ascii?Q?JIKiKp7Cl4wg4Tv7j392epGPoBmvHixKi1YLvvb303Wu4hzcs+KWhY4bFuYE?=
 =?us-ascii?Q?PxSoFrWInd0xrKLSjfsu8j4S9J4Hu6KnJo7FW26t06bZZQ6k6F5OISTpqrdD?=
 =?us-ascii?Q?GtBrvhzcGsWPeaZfkGKBMvJRgh/TLCyifqPmtPsTgDgQ5cNkMOxpB7B6aPuH?=
 =?us-ascii?Q?OJAqjN5M6dWdHR2Bf1YTauGm83Jy/KF7rKIoVH1OdOcteq3Dnqd7dzepZ3YC?=
 =?us-ascii?Q?iUxUHTfaTYW1bpyjH7r+mjmxxBN2hoHuZTBK3Nk7J+/KKqagkaVoLATzl+8K?=
 =?us-ascii?Q?RWRvKtUYgznOvSaG0fosXAXFoYChCoP1LhoClIoWr+O7Pejp29pqGc6Pn4h4?=
 =?us-ascii?Q?K4+QQKlp98+0ZfrEYvU7wBnrCLHBiuTBaHdTIcqYO8MocKxbD3vZOmBI5J/O?=
 =?us-ascii?Q?tyrFGwUbNoxR47mZZ2idqKJdqsOlPlyBkrtW5+zw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7a5a4d-564d-4c38-3c0b-08daa56f187a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 18:42:59.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+WEnEUkHU92TZAhfXkk0WkzuJJwh5CpiD1JiyoQ9ebeNwrzlLcLsY7Qj0ZD4Ea0er9y6fqjaxeDIg8yA8I6kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4090
X-Proofpoint-GUID: IxE_BjA0a6k9hm9I34H6jHga1_-892TT
X-Proofpoint-ORIG-GUID: IxE_BjA0a6k9hm9I34H6jHga1_-892TT
X-Sony-Outbound-GUID: IxE_BjA0a6k9hm9I34H6jHga1_-892TT
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
> Subject: [PATCH v11 2/2] testing: use the copyleft-next-0.3.1 SPDX tag
>=20
> Two selftests drivers exist under the copyleft-next license.
> These drivers were added prior to SPDX practice taking full swing
> in the kernel. Now that we have an SPDX tag for copyleft-next-0.3.1
> documented, embrace it and remove the boiler plate.
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
>  lib/test_kmod.c                          | 12 +-----------
>  lib/test_sysctl.c                        | 12 +-----------
>  tools/testing/selftests/kmod/kmod.sh     | 13 +------------
>  tools/testing/selftests/sysctl/sysctl.sh | 12 +-----------
>  4 files changed, 4 insertions(+), 45 deletions(-)
>=20
> diff --git a/lib/test_kmod.c b/lib/test_kmod.c
> index cb800b1d0d99..6423df9fa8dd 100644
> --- a/lib/test_kmod.c
> +++ b/lib/test_kmod.c
> @@ -1,18 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
>  /*
>   * kmod stress test driver
>   *
>   * Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
> - *
> - * This program is free software; you can redistribute it and/or modify =
it
> - * under the terms of the GNU General Public License as published by the=
 Free
> - * Software Foundation; either version 2 of the License, or at your opti=
on any
> - * later version; or, when distributed separately from the Linux kernel =
or
> - * when incorporated into other software packages, subject to the follow=
ing
> - * license:
> - *
> - * This program is free software; you can redistribute it and/or modify =
it
> - * under the terms of copyleft-next (version 0.3.1 or later) as publishe=
d
> - * at http://copyleft-next.org/.
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
> diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
> index 9a564971f539..e2a816d85ea2 100644
> --- a/lib/test_sysctl.c
> +++ b/lib/test_sysctl.c
> @@ -1,18 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
>  /*
>   * proc sysctl test driver
>   *
>   * Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
> - *
> - * This program is free software; you can redistribute it and/or modify =
it
> - * under the terms of the GNU General Public License as published by the=
 Free
> - * Software Foundation; either version 2 of the License, or at your opti=
on any
> - * later version; or, when distributed separately from the Linux kernel =
or
> - * when incorporated into other software packages, subject to the follow=
ing
> - * license:
> - *
> - * This program is free software; you can redistribute it and/or modify =
it
> - * under the terms of copyleft-next (version 0.3.1 or later) as publishe=
d
> - * at http://copyleft-next.org/.
>   */
>=20
>  /*
> diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftes=
ts/kmod/kmod.sh
> index afd42387e8b2..7189715d7960 100755
> --- a/tools/testing/selftests/kmod/kmod.sh
> +++ b/tools/testing/selftests/kmod/kmod.sh
> @@ -1,18 +1,7 @@
>  #!/bin/bash
> -#
> +# SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
>  # Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
>  #
> -# This program is free software; you can redistribute it and/or modify i=
t
> -# under the terms of the GNU General Public License as published by the =
Free
> -# Software Foundation; either version 2 of the License, or at your optio=
n any
> -# later version; or, when distributed separately from the Linux kernel o=
r
> -# when incorporated into other software packages, subject to the followi=
ng
> -# license:
> -#
> -# This program is free software; you can redistribute it and/or modify i=
t
> -# under the terms of copyleft-next (version 0.3.1 or later) as published
> -# at http://copyleft-next.org/.
> -
>  # This is a stress test script for kmod, the kernel module loader. It us=
es
>  # test_kmod which exposes a series of knobs for the API for us so we can
>  # tweak each test in userspace rather than in kernelspace.
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/sel=
ftests/sysctl/sysctl.sh
> index f50778a3d744..bfc54b422f25 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -1,16 +1,6 @@
>  #!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
>  # Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
> -#
> -# This program is free software; you can redistribute it and/or modify i=
t
> -# under the terms of the GNU General Public License as published by the =
Free
> -# Software Foundation; either version 2 of the License, or at your optio=
n any
> -# later version; or, when distributed separately from the Linux kernel o=
r
> -# when incorporated into other software packages, subject to the followi=
ng
> -# license:
> -#
> -# This program is free software; you can redistribute it and/or modify i=
t
> -# under the terms of copyleft-next (version 0.3.1 or later) as published
> -# at http://copyleft-next.org/.
>=20
>  # This performs a series tests against the proc sysctl interface.
>=20
> --
> 2.35.1

Luis,
I think you know that I'm not a fan of copyleft-next.  However, having
said that, this conversion from boilerplate text to SPDX identifier line is=
 very
welcome. Thanks for this change.

Reviewed-by: Tim Bird <tim.bird@sony.com>
   -- Tim

