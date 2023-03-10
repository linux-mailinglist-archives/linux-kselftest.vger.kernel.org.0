Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA136B3775
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 08:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCJHjI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 02:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCJHjG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 02:39:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7370F208C;
        Thu,  9 Mar 2023 23:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678433944; x=1709969944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s8hCA+nUGoKVYd2GWojElQCY82081lBNJW8eYZSiXAs=;
  b=l2UtLS71fFg1x7rcMWN6TWPs+HPe7fWxe+NNRGt8YqqnjciTHQTQPvW6
   ZBEE4zEnm1D6XzEjuPqsB1AiC3RKWn8HMDEV/gWnri2nUUhyKx6CWC1sV
   fcv97aOCl22gnAHdqZ5IpBydQrNkUoRsPxXOVgXbHFyfUF/jk//0FWeul
   BXDxa96oBztsVRUbBDzZVfCJcLsikpF1svJgnonzBgKsjE7/7ThAomu8x
   DmcFC/SDNO2YPCvoKw2DbbJ6dwmU8jKYUxxOd2/CWL6LEFrJs4OL/tGTd
   67pm4+y8/jgp0Qmi8j/EmyYWAEkXOQU4ph+iHQ9sFVN0FNwFNJZAWinWB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="334147828"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="334147828"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 23:39:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="707920748"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="707920748"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2023 23:39:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 23:39:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 23:39:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 23:39:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzKGh2kYGt+wobhCqUS6cBWUhNmcxs/I/YVcFKn2c+CFBLYDXpud/vAI7PxofwssYEsJsvgBYnv5Dn9gpjQFQouOE62ZdzP/ea2YrjO5B9nShXOE+VTaz8bPajyhpblLtgfgrV6/bOznm8EGVLXQ+1QIbDNrwAufxMkGbdmd+YpVjTekFUlQUiKp1ijRoq6qFblmANEAaOug1CMrYYR62TdQtuwKfsxOsIGtWYwGP/6qxThDnn2EsTDBTYwPxByJ2InDwvdMGO23CAhkAN8IyV+UogQ8dJ/rNbulzv6OHErNtjwk9iijWp/hbuJ3Xs0L75ReqT3qA501tj1zNDjJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVpQWHCrjLqIAmj1yvrwzKo/BdqUL1q+GEvaaV/VVdI=;
 b=PojfQd7VsZ/1chr+M+AUi0b7NbsWp1fzjAdsKoGWlC2lEk/TRikXH9tJi+SUFm1X9h2aaDKn9hqG2U5j1RRjQpyTQV/HqSwZHuF4+Xw4W5zzhb3ZocVaEBJb4zb+cmANetGRdQSi9iH8yO262yz05H1oMSafXf/eePrpolQw7trSaTCsoUoo/jWtNNut2hgSzyAHxo0X2tDebg+bCGfUZWzHB2xUXwO/1i/Fn4KaynOZ4jMeujBTyTzJjL6jNnBsbQr+Qx69s/sm6u8gMDDEbQSUjU4aDWfXTaIYKmDefR582Q6Iem6hSmQf7dr6llqw/wx3u37oRHwn4LpHQOlTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7384.namprd11.prod.outlook.com (2603:10b6:8:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 07:39:01 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 07:39:01 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 08/12] iommufd/device: Report supported hwpt_types
Thread-Topic: [PATCH 08/12] iommufd/device: Report supported hwpt_types
Thread-Index: AQHZUl6A5YBS+XH2i0u2lqSlYvUsoq7zXHcAgAA9dgCAAAEccA==
Date:   Fri, 10 Mar 2023 07:39:00 +0000
Message-ID: <DS0PR11MB752928ECB7D395C601F14246C3BA9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-9-yi.l.liu@intel.com>
 <f0076d6a-d764-b018-7442-08a6293f9553@linux.intel.com>
 <ZArXyj3iiPa95aCu@Asurada-Nvidia>
In-Reply-To: <ZArXyj3iiPa95aCu@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DS0PR11MB7384:EE_
x-ms-office365-filtering-correlation-id: 4f0b47f3-e9de-46b1-105c-08db213a83d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +PKVs10dF7QwHKMDhhxFA/yVCGsR56tcv+jYy8pfo3iYLpJPvOUegueDviQRRNAiLXZEnyfGCk+1+mJrVOR6HYRfZggP3+dRk3Zj5qI/krPHDXySAYy9Twh2TddFyH+/oDDYNRpn9+anwLZNAX9XGlMwENOn7zzD4VbLoaYm5Nbu11pNgyFFvWw/aySJYDynvEXKtav3cfuKinhLr4KqJvAS8sln+yLtSq//wfYB6GFh5IJdugXK4++liM+RVpKqcImvuuVd76wuJiQL5j6dJ6D7wAmRMg5vyGeAYaL+h/2B2i5BsPXS4jQRpbzXa+xkcj4zfRfdGzZVXxBCf/G5Yrgyadw+tHxWehiuvQJWkQ6LIgeaDyYiMf+cbN7RPv+h2gw4pOEXfwl3Q36azsaSCrtuCKDfaSjWV7ChHaXfo9gK0KzWSejWfRe9bsPJmj3CegY7uCnjQHZOZWMBAWMidAkX+xfq0t0MjdG52evSFNjXsJUg1VPfIaxBsYs2X9RVTTyg+N+Jz+P0QyK6wQrTOuLkE+XDKjcJousjQtiADmNDXhChDQ8+sP3NMK7sF2Oa3YERvDmgMv7mSsUhKX8RoVa/nqD49zhqohFk1bjrdyCjELXIKXYLYkB5u4mZYYx2ctNLWYhwMn3SPfF8bHIIaDuW0BgjkM3Oaz/tbsh8i1apMvP1y+0DZMcVPIkvAj9C2OE+qatfR2T0ejnObpINZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199018)(38100700002)(83380400001)(122000001)(2906002)(38070700005)(82960400001)(33656002)(86362001)(9686003)(66476007)(316002)(66556008)(76116006)(66946007)(7696005)(4326008)(54906003)(64756008)(478600001)(8676002)(66446008)(966005)(71200400001)(26005)(41300700001)(186003)(6506007)(55016003)(53546011)(5660300002)(7416002)(52536014)(8936002)(110136005)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s6cgzdAhfKJwZbyIlaeKhsWThrnbUs32wVVqr7XzvD3gsOQnCKRRZWb0YsPQ?=
 =?us-ascii?Q?rMdgwGYLaNhwlh6REyi1e6smcitducl2FOwyLxkys89VxzmTsYP0TxpL2T+v?=
 =?us-ascii?Q?h4uFmrwVTWyl7P8I2LeJ4JKTkYtqoWgYaM5OR0IosqHI/ldizhtJTD+tjmP5?=
 =?us-ascii?Q?ooFCpdEYjuYlwgb99xIGewbxTo5DlWta+kkdO7O8AptgoYpcXQXLp2TEPrqz?=
 =?us-ascii?Q?4Pws5zLN21i4c9lfzfJ9uU04XSd3HMNySar1lihaBYo94gWXA3shDMU2+5JB?=
 =?us-ascii?Q?OUm5CMLDstRJThjV+I1J6Ap7flJXrWnt8F4NNh0rq6SpL/uCyDd1H6VNU5tN?=
 =?us-ascii?Q?bGskAO1T/t/CLaxPaZVynSrUrY8Pgi/GcK4VRd2iBCU56bXbqEeaCh5sNyHa?=
 =?us-ascii?Q?8KHO/ObN2GaoGpt61kTjC3UCFGLaYeTdh4Ft6MWqsLnmfoDwlZDz6Ijc6xXD?=
 =?us-ascii?Q?4tUWH2/KwHw9JRSNXVDSmgyrM4CsBqiipLiE0nV8oy2AhkG0sKmsI7n8a+d3?=
 =?us-ascii?Q?AoWH6fg4uVFh8hnqJWBHoaEu+A3doBBS8UiWDLpg+xPCnWnRdn0hYIqj1Y/f?=
 =?us-ascii?Q?yyjKhjRPdbJhg58qVcH9BqDIwrRlETbjcS+W0EcU/inxwyETOi0a85kOHlnP?=
 =?us-ascii?Q?bB2ERF9X7yIoqcg2XavnPx7qXYiEk6vFN5Vydu6mt+82rviN6dqMAQkhEjJk?=
 =?us-ascii?Q?ZFDi/AsKpj0iw7CyiquOgvebhWTtOkHpg3thPa6D8PNEIdo6cJtdU7Fy6LpO?=
 =?us-ascii?Q?FQGQAeGMt2gF5Z76uqvSqgmGL+CQm09FdunOOw7KhLQ/lusNlY1JJa8qfG6G?=
 =?us-ascii?Q?xmC+BYYSf2d5ZVK+dLukV/+7N7StdBl/QLqG5he/bVAVSayr7LfwsDB/QcaD?=
 =?us-ascii?Q?22QnmIMQr3g4KruITXUlxtyWSqELkL+OkWdj5NqafWtLGhKJClEFU5lEOFRh?=
 =?us-ascii?Q?8tNw7nAq8bQXRj0qAGERiMKjiZ+R0j2vNJmP95L+2bKoIALnCd6W0tg3XZM8?=
 =?us-ascii?Q?BW4CcTCiKTFVfkBBxl7qJzI944pfIT8EHdcSa4/93T5Q7Qkk2BLFKvIkj1ji?=
 =?us-ascii?Q?3JxCJh8njczZgv2DtR+itzjx2dP1KCXtds/zLGaRVtU1TcAFy2KdTcJE88gf?=
 =?us-ascii?Q?T6Uhzs1BAYgXhN2o1jB4GUXfdR9zAYQv7D0kkXZA9++t/GTzB8qzWQXInXL9?=
 =?us-ascii?Q?UfDtM/Wb/zIB1LrRu6t7V5OhOukT18825+ExYwO1Jcm37Iq+hKbwsE6A0qbi?=
 =?us-ascii?Q?/K3ePdtKtQydyqbEpCwhXce+ArsmJuttrqhXMGRD16ZKrTLPo78zqJmJrlrf?=
 =?us-ascii?Q?0tEk1uHUYdN5iK1iNfa5Gg75V/XfCwV0Mo5rVwjyWG2j3OKrvjddS+Eoba+4?=
 =?us-ascii?Q?5/8Kle6Rv/j2yKkf/Z0H4YOp0pEzJ53bC+3neQh89aU9iG7T9IahYXFxMtrz?=
 =?us-ascii?Q?PV4Oo35gerXqb10prg86DLzbLq6xGi87eeDtDFPDcYKbx7vNvhlvIz/4fhUw?=
 =?us-ascii?Q?xoT+/kXlT9spaBY+osjgun7qPgkr8RaUKAmQjfzO9L0FiFBhDho0XISUlYh1?=
 =?us-ascii?Q?9nPhh+wDYpeyEUPSMptU3969KLbRvHFxXE0VQXV4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0b47f3-e9de-46b1-105c-08db213a83d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 07:39:00.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cvo3vMsAIioSB3Z+rqBvSKxMW/uccvwhUY78wigTEtEd7INT0b7NdSaRbQnoMz+2JyUQygInjdopKXET3QuAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7384
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, March 10, 2023 3:10 PM
>=20
> On Fri, Mar 10, 2023 at 11:30:04AM +0800, Baolu Lu wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On 3/9/23 4:09 PM, Yi Liu wrote:
> > > This provides a way for userspace to probe the supported hwpt data
> > > types by kernel. Currently, kernel only supports
> IOMMU_HWPT_TYPE_DEFAULT,
> > > new types would be added per vendor drivers' extension.
> > >
> > > Userspace that wants to allocate hw_pagetable with user data should
> check
> > > this. While for the allocation without user data, no need for it. It =
is
> > > supported by default.
> > >
> > > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >   drivers/iommu/iommufd/device.c          |  1 +
> > >   drivers/iommu/iommufd/hw_pagetable.c    | 18 +++++++++++++++---
> > >   drivers/iommu/iommufd/iommufd_private.h |  2 ++
> > >   drivers/iommu/iommufd/main.c            |  2 +-
> > >   include/uapi/linux/iommufd.h            |  8 ++++++++
> > >   5 files changed, 27 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iommu/iommufd/device.c
> b/drivers/iommu/iommufd/device.c
> > > index 19cd6df46c6a..0328071dcac1 100644
> > > --- a/drivers/iommu/iommufd/device.c
> > > +++ b/drivers/iommu/iommufd/device.c
> > > @@ -322,6 +322,7 @@ int iommufd_device_get_hw_info(struct
> iommufd_ucmd *ucmd)
> > >
> > >       cmd->out_data_type =3D ops->driver_type;
> > >       cmd->data_len =3D length;
> > > +     cmd->out_hwpt_type_bitmap =3D
> iommufd_hwpt_type_bitmaps[ops->driver_type];
> > >
> > >       rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > >
> > > diff --git a/drivers/iommu/iommufd/hw_pagetable.c
> b/drivers/iommu/iommufd/hw_pagetable.c
> > > index 67facca98de1..160712256c64 100644
> > > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > > @@ -173,6 +173,14 @@ static const size_t
> iommufd_hwpt_alloc_data_size[] =3D {
> > >       [IOMMU_HWPT_TYPE_DEFAULT] =3D 0,
> > >   };
> > >
> > > +/*
> > > + * bitmaps of supported hwpt types of by underlying iommu, indexed
> > > + * by ops->driver_type which is one of enum iommu_hw_info_type.
> > > + */
> > > +const u64 iommufd_hwpt_type_bitmaps[] =3D  {
> > > +     [IOMMU_HW_INFO_TYPE_DEFAULT] =3D
> BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT),
> > > +};
> >
> > I am a bit confused here. Why do you need this array? What I read is
> > that you want to convert ops->driver_type to a bit position in
> > cmd->out_hwpt_type_bitmap.
> >
> > Am I getting it right?
> >
> > If so, why not just
> >        cmd->out_hwpt_type_bitmap =3D BIT_ULL(ops->driver_type);
> >
> > ?

The reason is for future extensions. If future usages need different types
of user data to allocate hwpt,  it can define a new type and corresponding
data structure. Such new usages may be using new vendor-specific page
tables or vendor-agnostic usages like Re-use of the KVM page table in
the IOMMU mentioned by IOMMUFD basic series.

https://lore.kernel.org/kvm/0-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com/
=20
> A driver_type would be IOMMUFD_HW_INFO_TYPExx. What's inside the
> BIT_ULL is IOMMUFD_HWPT_TYPE_*. It seems to get a bit confusing
> after several rounds of renaming though. And they do seem to be
> a bit of duplications at the actual values, at least for now.

For now, vendor drivers only have one stage-1 page table format.
But in the future, it may change per new page table format
introduction and new usage.

Regards,
Yi Liu
