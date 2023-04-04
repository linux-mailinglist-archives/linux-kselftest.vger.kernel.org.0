Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B696D5C46
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 11:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjDDJqK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 05:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjDDJqH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 05:46:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F7730D5
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680601546; x=1712137546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IDXLx7blRtqT+RDN6+NhshNWvDVtC0Y5BrZ/DS3VfU0=;
  b=mbuE34dltLya/N5eY3L0kPmzmosaL+4bvdB450Yzlvo3S6nX8XdB0l/8
   NLnzAendihgniqmFnVA4z8JwAkxY5zKmSb73vWNeJflXWU8TjF+EoFjfd
   Fhd4wIGHU5BAOTDaqm5PbTy5wG1cIzZ3740uhGaJI7Gc6/M0NiVGvj9ti
   d3/EU6OYg9O2t9PPBQkhx+wwALzq7tTlBxKUjPGFCGRDaCHI/TDRCB0Jk
   HrOComPOq8wjeHPAF/JAzwa5YaE8R+pEXeUXQVAouJ8kGIyJNC+DEZL9P
   ktwRxuEMCN1ZW3OGy8Dct9l8/8V1ppCL/968e4aBIDh+MZnYRSWmG+pvE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330720227"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="330720227"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="797454082"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="797454082"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 04 Apr 2023 02:44:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:44:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:44:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:44:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGlzjZNHBzu0t5lJ7Xl0XegEFBA0s4DsPEecrUDX1O7QHII4Y8RYabvSjSmTolJBLltMDhZjxGtJAgHIZ8PsHQ6eZSMg4OXInuwgFq8AKOEIcTEb8t+f3Qc9MSzDqAVeI6sE2rN6D7BZVSWflVOZBx+LRXObKmT/hfxNV0QMVyTeDVRYILWnpitWXZ4E9TY3PzpzJjlCZ/3zGNEVY4TWjvV0LjE7JfZTbd3Wp0zrPyY6VkYAUfvyyprTQ+OJlcfJ2LHrE9jof/kM6ELgQGR6gT6hz7CWa6HrWUZ1NJRrqfzXSDFWQ5GPgzATB3m0eUj9eknf73UjeI615xNksnGLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/3Gg7TT/rJxXFKddk5Yw2IgnGC/tXSPt7u+RasN2u0=;
 b=ZnwrIBjVGm4Ug5dAUmRkuCJNP6CEYLVsWvbQm+DickzVHhULSXWYbv7Ju1n6FRUGxSf9unpY6Mm+EFKXnwQfxiqcV/A2Ejq4eiUZRaWzqZX81LrT4rDp7D9/JOWkiSk0JzqeZdrk0CxhoS1lMM/NgjYSKfF2VP2XOpAgKpQWO2qtV1FZWAjNirQbHdUo8RakIDzLmqV+kEKf+h3QtLArpLnd1Q2XXQeqt8h+aCJ2eOhMnYxpS7Ng8jPksKkwHz+DK4f1TBev9dImwqe+dcXf3B76emVCxX7BkaxoUo+FxsmQtVgNQHHdeVCy67Mgfc4peedUA9K0cxJX7DhZoLW4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:44:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:44:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 3/4] iommufd: Do not corrupt the pfn list when doing batch
 carry
Thread-Topic: [PATCH 3/4] iommufd: Do not corrupt the pfn list when doing
 batch carry
Thread-Index: AQHZY+YM9qwVAnPo0UGJ5jI5aiIXVK8a7ELQ
Date:   Tue, 4 Apr 2023 09:44:34 +0000
Message-ID: <BN9PR11MB5276EEA9E95676C3B0ED8BF38C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <3-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
In-Reply-To: <3-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 468d6dc0-26c1-4a5a-801f-08db34f132bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ho5oJgBw3cj4Cmc4EVHftDseebKu4qbOSVBDO1/R1Yhmm9ymT7cHz4I7PGxA9qepiXrcf+OVPHqFvpQ7JoIH01eWF1YCzRSXwjOqTuYRrL2ojfKZBlC9oSR1SnqtqgNbxVnDt3/E688JthMy9vuG3l/GVneiZNI4JKBEN3IdY9jwm6wbCjPgioQRvnE04/cgKq7BfhNrJVUOZxn+WD2P9xSGYJrTVIQcsNVfhbj0fDsgg8hSuZtAHWHuIg/z9CwYe+UEeT/Re2kdL79xS3qrPJ+4oR9wVRO2YGL23+4mGJDTiWsjgeVQr2eSk0GWWL9RgC5MyaxVuQ20aGa6gXpZc2y8hdxIusxMVA1amw9jYTgJslTPnY0s8i8ADxR0Oc8mQ5kGTxeALxaShviY9uSJXE3R+HMCFGYiFf3nPuw4YKOVI4xUTiQ33n279JUwfBt3cw3ANSrpggVxSHPEeE+lJkCoNaDA30ilA4RRgfzRZRB84xG67Y3YfvIN9JwNUC8UNEzSznbWXnvmC4yrGEDSWb2qmYepsvBgE9pNb8OPlmEGdDNdrKKfLlmTIhjEDhpIflOB1VM7QwO1bFiqmh91QHx4JXqvEjiq6fKx37yheS8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(2906002)(83380400001)(33656002)(38070700005)(26005)(107886003)(6506007)(55016003)(38100700002)(186003)(76116006)(66946007)(122000001)(9686003)(82960400001)(86362001)(41300700001)(52536014)(5660300002)(71200400001)(8676002)(7696005)(478600001)(45080400002)(966005)(66476007)(66446008)(64756008)(66556008)(8936002)(4326008)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gT2RWG3jj+N+T+Rsrm1BrC5lTBLkbc5DzSknWH/dk+XjcwR1989WpCrU1XCQ?=
 =?us-ascii?Q?/2GB8//YtG4uZPojYXc0bcNy/P4YyQYNWbwM0W+IblQsbYvBFWrXU7x+67pg?=
 =?us-ascii?Q?1oYJzAhtC6w6F++b7A17TKllxSVHzW2vt3cmIoo6OvJRCcvlDVkPGwPAgoon?=
 =?us-ascii?Q?0AP39dY+r2KoAlg3q5eWSeVSiiUGcG0+DqttKUXC9oABqXtLwDSfQTCR3UtF?=
 =?us-ascii?Q?Cvjegy4tfX8YON+1AIxok8cJUoc4Xdhq9PkEej3dSVKalfw4TexPQ0B/SD2B?=
 =?us-ascii?Q?IeH89nlzUAUqDS5XuvH95iNrUMR58tNvjEN1xGG4R+33tNw1wXBVshdsWngu?=
 =?us-ascii?Q?kb+ePvHvuQwvCYx5hwLoSecqjUGr0VfgSzLokF2ISG5KDI55t0eH/5OtMGeN?=
 =?us-ascii?Q?zfYCLhAI0mhv0IQvYc24o6Z8Gxeq42D114aQFkmbn5tO2j+Vp23Zim1EQdfL?=
 =?us-ascii?Q?htr1Quy9fq5nnUv1psca0yXn+wU9zWVHeqZXshW6QrVF+mjqT1uU44twcW4N?=
 =?us-ascii?Q?rxNVMN4OJoefJ7+YqX9cG30QXHOXbumDnHvdYfd/ljiIduANuBAYe8M3UGHp?=
 =?us-ascii?Q?QvATphqMx2w8k3Q4ib4B9MQOO01fJEFJu6ubP1dGq2CUDlMtLlINNvWKXHeQ?=
 =?us-ascii?Q?oZ7Dh9w2DN6QpzNuBuJ5XDnJlit7kQeXjkG7CL4Uvvk2/gdYr8Ls5ijVpyQE?=
 =?us-ascii?Q?yPVGY2qG/b6mTQIh/a1p2AXehsBNtp+CEXDaZTD0mZCWcMjOm70lb6QKIVRP?=
 =?us-ascii?Q?r4ouUEo9xyF01YEES0LP0ZQ9HhjgqZvKhVbBXnNYwlwyxH4ZvypCsONDlzJ+?=
 =?us-ascii?Q?QawwV8VgLoP7p2STTWCe8A6TY+NJzZUhInR6RxIc7FLjekBSNKpszY6vDJLz?=
 =?us-ascii?Q?4wnv/bkrrcYavQPo5HlaxleZZDV1iYE+umZIZWXMXXDy8MAiH0CNJJPDAL6X?=
 =?us-ascii?Q?BnfgTdSECpr+zbIU1L4qoAx3u25svFqJ+ieVK4G3AgR7IadXrqwS1dhBq/Ww?=
 =?us-ascii?Q?Hm3yxs6ABRKdyvf9RtgKVnaA3LjeTU4KHefAcZbBTjRruLDrQfJg+h913ZWn?=
 =?us-ascii?Q?1TIabNirMsKNjisi1b2tkcAHlZvbfNPg6NwrBEj1MU5foRHgQSPiKcJZUYc8?=
 =?us-ascii?Q?ByYUy4HwsEV8JsycP+Wcy8aIv02LZU02FL7dIZDoc/V6RMx1DCV0tumDyYce?=
 =?us-ascii?Q?xHDHJ2jOoF0x1zj9jfEfp0LegR3OLz7HSz2+3IB8UMiOGfAqI0yWqceoGU+c?=
 =?us-ascii?Q?zovUZU8xJmxK0cBsEOv9yffe2EMUNKzmgPSefsb4WoOzcaIDqW4ggf1EhrQr?=
 =?us-ascii?Q?pDLrunMt7HYmDjDITle5q2LZUAShHKW9kCjhte95TDfxfT8rMHtrWW8UUqAi?=
 =?us-ascii?Q?qPaph74VSLpNabrQLjI2/6lBiMC1pRsKJ3PNjEnIHcqONZ4+XEHaOjpWMQOQ?=
 =?us-ascii?Q?HnEFVDHGE3YAecjdTGTit1CiV+N6ETp0sann/JCXQKzetJij+nwliLCQ+rq6?=
 =?us-ascii?Q?RRlZfqSk6btHxAvxTesyPo1LfM2BnUHhTgIye1sBHCRLhojJR/3PKBdVEo60?=
 =?us-ascii?Q?mpL6A95Wl6Rba1Nr9d3Y8EYNd8wrX1njlCQ+/cA+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468d6dc0-26c1-4a5a-801f-08db34f132bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:44:34.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFuft8+c7BgxBDzBP04jQZw4rdc4JY1l+7TZGrs86ZBa44flBtPD0/8DNGv6kzXtmDHNNkVUB952AY1shlZC5w==
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
> If batch->end is 0 then setting npfns[0] before computing the new value o=
f
> pfns will fail to adjust the pfn and result in various page accounting
> corruptions. It should be ordered after.
>=20
> This seems to result in various kinds of page meta-data corruption relate=
d
> failures:
>=20
>   WARNING: CPU: 1 PID: 527 at mm/gup.c:75 try_grab_folio+0x503/0x740
>   Modules linked in:
>   CPU: 1 PID: 527 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-=
0-
> gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:try_grab_folio+0x503/0x740
>   Code: e3 01 48 89 de e8 6d c1 dd ff 48 85 db 0f 84 7c fe ff ff e8 4f bf=
 dd ff 49
> 8d 47 ff 48 89 45 d0 e9 73 fe ff ff e8 3d bf dd ff <0f> 0b 31 db e9 d0 fc=
 ff ff e8
> 2f bf dd ff 48 8b 5d c8 31 ff 48 89
>   RSP: 0018:ffffc90000f37908 EFLAGS: 00010046
>   RAX: 0000000000000000 RBX: 00000000fffffc02 RCX: ffffffff81504c26
>   RDX: 0000000000000000 RSI: ffff88800d030000 RDI: 0000000000000002
>   RBP: ffffc90000f37948 R08: 000000000003ca24 R09: 0000000000000008
>   R10: 000000000003ca00 R11: 0000000000000023 R12: ffffea000035d540
>   R13: 0000000000000001 R14: 0000000000000000 R15: ffffea000035d540
>   FS:  00007fecbf659740(0000) GS:ffff88807dd00000(0000)
> knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00000000200011c3 CR3: 000000000ef66006 CR4: 0000000000770ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    internal_get_user_pages_fast+0xd32/0x2200
>    pin_user_pages_fast+0x65/0x90
>    pfn_reader_user_pin+0x376/0x390
>    pfn_reader_next+0x14a/0x7b0
>    pfn_reader_first+0x140/0x1b0
>    iopt_area_fill_domain+0x74/0x210
>    iopt_table_add_domain+0x30e/0x6e0
>    iommufd_device_selftest_attach+0x7f/0x140
>    iommufd_test+0x10ff/0x16f0
>    iommufd_fops_ioctl+0x206/0x330
>    __x64_sys_ioctl+0x10e/0x160
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/r/ZBExkEW/On0ue68q@xpf.sh.intel.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
