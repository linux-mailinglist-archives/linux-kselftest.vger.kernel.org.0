Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527A56D5C43
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjDDJpz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjDDJpy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 05:45:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F84199E
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680601538; x=1712137538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PxdKFDjEjyEwlfX9TBYbvTEgL1CbwlLVibzy3n8ksmQ=;
  b=Vdokm5A8D2CCUkvHQrHN1cartQCSCJUOqTYCsO6QuW/WM8VC92HFI/B0
   HEO5WSUiyDSk1yTR8vUNJO81yyb1H7N7RN+dzQyo42nB+iaGaZF+CA2hC
   OzkeKQ3nLe1bgVUVcDHA5bBZwIm+tuFqWhGKVF4X2ZFR6GBTeWBhlcwMI
   KC05ndGrITaDW6mIARZTzC4Nxbe+ZIPD7YZPwMkntSH+C1RpNVhcNWl+G
   lf0gaD2+q+7b7fR0FfGWyzfvKWxOReWgV/tE2pmgo+tNkzKbpfBQpQNkq
   uKnBKVl5o2P9s6l97CG7yMuxlclmhhn0IfsaBFNGUvl9D14NLtSNmKjfq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330719888"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="330719888"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="663520503"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="663520503"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2023 02:43:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:43:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:43:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:43:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHKzC9XGBU7MuniY3j9Yju+8AkJM3++pn50Twtxn3WXVuj/6A4pJ789WW0LA/I6TWWNvCKj+E+TPCYQ09dCTiSY3z9NPti3U2L/eAEMUk8xb1Cx9XUtgamiXzzDImWGJAovZzWkPzMJs0EYfabdCnwx8CrVtADt37V2f0diLQ2c8T4i6YRsOpZ3MXSBp1/pkFr3F2ExBLVHaa/RlhOOUD8XmWIkabMNlIEVPXlxtEjkof8xpw69JuIhVLUiROP4CrNve0LVgz7sg9QAt6qVn33H1TELQUKhLbvccc7vuYEub4xmXcttWJWOQKO2chPE94urH36y06d9bzi/xM2FyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ip5lkdEaWQssKVS7mEaSyucvFMS32u9trqV8YMdfJE=;
 b=bI8EZtJQso5ZKE5THZ+crAVMD4tmXPtYWO6OdOliNTPfsfg49Fj0dZkGFPat6dpiFTrYoDBZiTo2/sHue2Nu/XqVcP679O5TVn0mSVWjPOYxKQPOjLS9/DdcZoBSrh1/LUYIw6rPiEnjI/C3DYd4fsuHDFpAiJ+6M3yehQMEro+867lAf1WwrQzpwlqBZLGvOH0CFcypblpJgA9IFRMSDE36DA/Vd80ihCcaGJJ8a3Gh8HHoDfx9nj8MjnuojiS7FOILKBhG1vOYdCz8JMMPSdk87/kBZjdnQXk/5XeYnltuTRj5Oj2TrvRFUASDR8HqiKmuaRPAyL03gm5omOz2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:43:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:43:36 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 2/4] iommufd: Fix unpinning of pages when an access is
 present
Thread-Topic: [PATCH 2/4] iommufd: Fix unpinning of pages when an access is
 present
Thread-Index: AQHZY+YLRNhvvKAAVUO451FpBPq5q68a6+ww
Date:   Tue, 4 Apr 2023 09:43:36 +0000
Message-ID: <BN9PR11MB5276500F5C1A3F81FA606ECA8C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <2-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
In-Reply-To: <2-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 387ad366-88ce-44d2-79dc-08db34f11009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFy7/v690tqFbZaHqLAvWx+mlVZJ2FkCmLxpJcBjhDcOrk2NDUSfK6xFH5KPEBITaU7nq0UsNww3kbYDY3tZ8n/vjzoQW3wEqojLItBr+4c+ZuxVJAGui+NgkZApIqWj4C2gLocA6JLOoGbnau747b8LatJq9dhsTz3CIOCs0bJod/37Par+8akR5W2vq0m7uiTmiUcQQMeJCKNBr2lSMvuPpJADDtuXX9pUImwnzZExhqOs+TuQKsqGffQ2FYaofY8Xnbm3Fc5T9X5vNKP05dfny5ZP4GGqweVX0w2WBufkuWqv9+WUEtb8pnCRYuwJEg6pEyUoUyHuf4gQodEsZYaMBHzG71Ob4qC1Vqodo1UxHag4HeSdHGVr48lRJkz/g1C47svVymlFH8SHy7R+mCzfbqbT3T3nzmZlvYmZiNutnaP2EfDai3q6of04EUdre7P/XsNkxcFj603dOoQGn447tUFPP8MR7yfm6P7MOmMdDo1/73Yxq6DKalHGLHz8VvQNNNh+XYp6fP39ommSGvk06459THg6egWNdpn68nHN3UmEuPqSe6aEQ6D1e+XNXw01Fu3fJWwa5PXHaN5+6uzcpo5sn33gyZ+7jONDUsU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(2906002)(83380400001)(33656002)(38070700005)(26005)(107886003)(6506007)(55016003)(38100700002)(186003)(76116006)(66946007)(122000001)(9686003)(82960400001)(86362001)(41300700001)(52536014)(5660300002)(71200400001)(8676002)(7696005)(478600001)(45080400002)(966005)(66476007)(66446008)(64756008)(66556008)(8936002)(4326008)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ei+5QaaOJzJ/PbSIQf/77K1AwpKfLFjXaJUFASL2YO4hfVs/PL3miRuzHCj7?=
 =?us-ascii?Q?meibvKpN5Jl2WeDnLZISxXaG0YNQmUuxYN8eREBf9xjwroXAfdGd6SsyDVcx?=
 =?us-ascii?Q?8/LjbmQfys40ADhYXaMLlSSXgkUmAE7d2n6ry2TQXPWnI8YP6yVHFmXVJbXK?=
 =?us-ascii?Q?zzjJ34mAmDsrGhSWW3VUVC3mi1db8AHV14rmI4SPYuye8phWE69RviDNgYeX?=
 =?us-ascii?Q?2tpyUk8DhhLmzmDBz4XSJxlUx4nMgF0VkoDwAYvaiGRTBsTR8n6qVY+N7BS1?=
 =?us-ascii?Q?wr5V0zBiPhQq6s1ObrA7FFQ+gGGgesa81pCOeoWr2j+wzQTytslbJgMVez1C?=
 =?us-ascii?Q?Wm8IiagezXQh3R5jiuMtpSHkLQaFUBKjxmyWs8sNinVL0wuucFXryNdfJzmj?=
 =?us-ascii?Q?7+iP3XyAthPtnGX41w9O5jK+iYCezqT1EV4e6NCWdbT34kdeMHkTQc3ppyF6?=
 =?us-ascii?Q?zm0amiS8YceUlKp5RaYhr107a5nPWn9aMQGPB9fuYPrEEUSSUv3cqBAQDd2P?=
 =?us-ascii?Q?WjxmTr+JhmljGHM1r+8q3JpcNUzFkJSD3uyUyP1iNbG1qbW1vjWvWqRyaoRs?=
 =?us-ascii?Q?jQbYOrjXEHTi0lKZwCv13sg/dRrqrHhsB6UyzDIhA61Dr+EsPfAfWmJ0OAbh?=
 =?us-ascii?Q?P0oA1gC/F8XzdHsfJ9CPZ1wrrTvo1f8FbTSjooT2wDvVdBm3BKd9Z7/yLy5k?=
 =?us-ascii?Q?e9QCDf4v+vJw3Le6reyiHp7vebx/TMtIjgt3mUTWGFaDTDgpDa6Hnp/h9D8k?=
 =?us-ascii?Q?YQWPffvPF7K1yynX1Nqa4r8JjmyeScc/+7h/+1/qd/kbHcOb1o6uKVp8p5xg?=
 =?us-ascii?Q?nyKQ44Ve7XGK5er4Ml9rUs0gcwgKTMJGT75LjcegKPaMfLG39QhM1y2vnGkz?=
 =?us-ascii?Q?EyLO0aXI9tjSWS70eZjlhqdJgJu8I+nQ7Q6Ufo7+S7a0/GItyl67L6XIodgD?=
 =?us-ascii?Q?zeK8eCwbXYcCfHxqiqj3gA1i4YQCFk9SqRhWke+3NhDvWm9AvUFQwI2ZrxCq?=
 =?us-ascii?Q?zacSbst7AJ8Wy34IXGM/59ohWcLy9pxB/A9KgTmDLkVlr4dhiQWC1yVFAAep?=
 =?us-ascii?Q?e4b3JM6Z1cE341/9Yp+bEPqaV/g/Dd7nH3cxsjg5samwGP09B0k1Mi+qsV81?=
 =?us-ascii?Q?W8WMoxnBnJ7Fa68KvmrjA+iiDDbBBTI6sBKtcLL74RJ0cfroyduLkbGkgyCs?=
 =?us-ascii?Q?fGYzoRB9RoymSGQIvpXZkkEwPDNeFckGg/d25UWMbIPZUoqfx6nTWiSRIg7A?=
 =?us-ascii?Q?aiWA2ZoLT7hP+M8EMFCuCyD2+LBzMAR0kEtPhZf0EEur66k/73dhiQiQnaKs?=
 =?us-ascii?Q?nLlt5TUaiK+dblI0Qc/V1jiLVnvIiMIBkqMi/cQ98G9NXaUAcNdEbQGJVj7A?=
 =?us-ascii?Q?zWijOT+IX8fkuQ/0YFVjU10ieCicEpj0mnUmFDN8bkpcAKXPQmDyo90f7uh/?=
 =?us-ascii?Q?1bqEEgelAguf1ff7ZeJBmK/aTuGaPC85cHmhqRcJCTx1Zkd6iYN4HoNZQWLj?=
 =?us-ascii?Q?kKHV6cH1mZjCDMbTMCuJo6ngiNnVE+p6w+mtjSnikhAZUnkDYmHRfwIsuGen?=
 =?us-ascii?Q?IabD/Ulju72cyzbQrkoTqUrS250e1sOCnoRoQ276?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387ad366-88ce-44d2-79dc-08db34f11009
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:43:36.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3Ehu4A1N2JUCCOnELycM76c9HS6/ZT+QG5x7x7949b0UnomSEXgUjONoU65bEzZcwEqVmo5ssESPC+Om1exUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 31, 2023 11:32 PM
>=20
> syzkaller found that the calculation of batch_last_index should use
> 'start_index' since at input to this function the batch is either empty o=
r
> it has already been adjusted to cross any accesses so it will start at th=
e
> point we are unmapping from.
>=20
> Getting this wrong causes the unmap to run over the end of the pages
> which corrupts pages that were never mapped. In most cases this triggers
> the num pinned debugging:
>=20
>   WARNING: CPU: 0 PID: 557 at drivers/iommu/iommufd/pages.c:294
> __iopt_area_unfill_domain+0x152/0x560
>   Modules linked in:
>   CPU: 0 PID: 557 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755 #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-=
0-
> gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:__iopt_area_unfill_domain+0x152/0x560
>   Code: d2 0f ff 44 8b 64 24 54 48 8b 44 24 48 31 ff 44 89 e6 48 89 44 24=
 38 e8
> fc d3 0f ff 45 85 e4 0f 85 eb 01 00 00 e8 0e d2 0f ff <0f> 0b e8 07 d2 0f=
 ff 48 8b
> 44 24 38 89 5c 24 58 89 18 8b 44 24 54
>   RSP: 0018:ffffc9000108baf0 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff821e3f85
>   RDX: 0000000000000000 RSI: ffff88800faf0000 RDI: 0000000000000002
>   RBP: ffffc9000108bd18 R08: 000000000003ca25 R09: 0000000000000014
>   R10: 000000000003ca00 R11: 0000000000000024 R12: 0000000000000004
>   R13: 0000000000000801 R14: 00000000000007ff R15: 0000000000000800
>   FS:  00007f3499ce1740(0000) GS:ffff88807dc00000(0000)
> knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000020000243 CR3: 00000000179c2001 CR4: 0000000000770ef0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    iopt_area_unfill_domain+0x32/0x40
>    iopt_table_remove_domain+0x23f/0x4c0
>    iommufd_device_selftest_detach+0x3a/0x90
>    iommufd_selftest_destroy+0x55/0x70
>    iommufd_object_destroy_user+0xce/0x130
>    iommufd_destroy+0xa2/0xc0
>    iommufd_fops_ioctl+0x206/0x330
>    __x64_sys_ioctl+0x10e/0x160
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
>=20
> Also add some useful WARN_ON sanity checks.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 8d160cd4d506 ("iommufd: Algorithms for PFN storage")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/r/ZBE1k040xAhIuTmq@xpf.sh.intel.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
