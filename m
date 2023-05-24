Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAE870ECDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjEXFGN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjEXFGM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:06:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98791186;
        Tue, 23 May 2023 22:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684904770; x=1716440770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oHWsGpvquMx7dvzvklpEAoCQnuecITDaXuRpffljvbg=;
  b=YgDEaxndryPd0hK4cuBV07U5CmEcAsjwlcwxhkV9Q0QjIVpFI7IOX3OB
   inMDS/M8zyAuRPKiTJyGrNlS8M/rRQT4j9tvJkvvaGW/UM14Dr4l6dP0u
   z1EitjkAPjXSUd5Zyro4d3b/6Zic5D+xTLdtH0uvMRP0pmCJ1InsWq8ix
   /wNr7MBQ4b/Ml1uie6kXA4d2uwek5NQ2nDSS1PvWtw1cNLNLu8hnH60jb
   FB6OIOxBkxFuGDp0fQWja2gPRgqth5hwbK2yz1YYRjugJ8qi6bSEs3b9U
   Gd+hQtigOemkFRiKKbl9r9fqL9s0GgYJ3+wv9xQJu3zfM6TQIOuhBrtde
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="333819948"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="333819948"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="654672540"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="654672540"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 23 May 2023 22:03:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:03:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:03:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 22:03:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 22:03:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNb14juEZ7KrjaH0Pm4BRxrkhldJchQRSjgGDBUwWiwos4H/PyQMQYPXG6tlTab14PXj12ydwIMnpSM1u+ShWVYzzQynRpSnPr+tircQvas01aSzDRBKdhinyUO2n7XD7MzsE5QW0ElWqqAuER+p6TRs8tJru43zroJoFhw61IoddmHUbYjEBxYItJosguUOL+YBeAhhs0wbYBDTVTZ7mjsiI24r+ZjN/WORg2GojM0IyJCtSi6DqhQuYmz9AKlngN5ZKC2ksB9GnbB1odkwCcTEkpgr8lcyyTo2IrM4AY53H/2y5GXnPHyBSSscOZW9WabyGPHv012g46puZjA9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCguk1Abc6jvpnT9OOx7crFRB0PTK3FkNZkMzvueqAE=;
 b=VzDkRVy8JlFABbFE265W4gKsi8XaP0tUZCHuKJZU4001QPWBinzhdzfP0PjF3cB0IVY4y1yWu6uM/6UVS3y56jE7Gwv7akk5adqpsubQ3tvA45JgToLy37mXRlB+vv7oMWZmoJ/vMg4EoFzkrhu8RVJTfYw6TZ038OzYc6WFpzLfGSFnUyS2+BvEH8h3ysMnGnPeTt6LjVRGWCo2eH0jACJ1SyrmvU8Rowvwg58eSy9NteYnca47sxulUvmMj75/N+OcODYJ0wt2yc1/imMfizoNJ60GegjDCixQr1hLXwvxao9ekzEbvHRFseX3mwsbK1sNfX9ej0MO6WD3wt007g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:03:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 05:03:38 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v2 02/11] iommu: Add nested domain support
Thread-Topic: [PATCH v2 02/11] iommu: Add nested domain support
Thread-Index: AQHZhBZWGCZiHoB7mUmjDNXa/a39Ta9hVaYwgACnYwCABvS9UA==
Date:   Wed, 24 May 2023 05:03:37 +0000
Message-ID: <BN9PR11MB52764EEC5A6048FF2487F61B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-3-yi.l.liu@intel.com>
 <BL1PR11MB52717388249F052433A7FBB08C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfEqmD0mrE0NTDW@Asurada-Nvidia>
In-Reply-To: <ZGfEqmD0mrE0NTDW@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7296:EE_
x-ms-office365-filtering-correlation-id: f0617359-4e9b-473e-eb7d-08db5c143c0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3IESKGJeBbaQkMILZXUHX8X/phZGliSYoDbgur/FtwwfgBP1HKTQ4EIG6rkJ/awHn+99OAM1gomTd3EvQQYyjumvs7D8hycYL51Kcm1fZ4Vi7vYKSG45Ciqf1m8FjOsSIM3wY0so4eB/BzdQfzD9xqDdZZV61JR4vHkcVJsUilsDIn157W81y6lbhKtQuxhw+8PghA4oOLT7ynw6ibkylCgtlkB/qNiyC5w2iwP3klNa118yIc/RfDdDoks9lqLh1XJR+Ax1FLZMKaaF0rmoy0MZIKb0iulXLJIe9Fii5sVX/Cr7bfmAAkGzcBGYZ88fgPsHo4hNJExfmv4+QmKDjFFfDd3ifXQc4+FJSRLoVpWPm7koz4C4H6JJAl90tUKFmNhr4lnWxSbCbA2CEbFNKL1XDbAlBKVwMOVHhJqRflKq2LMhiTYQl0l3wUoJKcJP/HuoHKkhBID4/anZsbiNCkuUQNpgZZ7xCZPzxpl74UwPrdy6Ch2D2VcwFG6uVw6VThZaJ1jAAaZDp10JZHrhnx+rNY+wcJ8/9bUQxDL8qmgGeT/lTw4COF73iNXYsgeEVehqm4Dy1upRl5iVDVOJpGs6esoKVCeQlUF3P4IInR7g1FxLwR5WUVMb8JacJN/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(86362001)(54906003)(41300700001)(7696005)(478600001)(71200400001)(316002)(76116006)(6916009)(66556008)(64756008)(66446008)(66946007)(66476007)(4326008)(5660300002)(38070700005)(52536014)(8676002)(8936002)(38100700002)(26005)(122000001)(7416002)(9686003)(186003)(33656002)(2906002)(6506007)(83380400001)(55016003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EpqpFx/DISujJNYWMVEUzpbmi3uJVYqGIhJ7YExhPPFK3IZJzYrz6RcrzCiW?=
 =?us-ascii?Q?wFJxeKp0NotjjWrOVfvxRJABvC0FqPE1/u7WhZBmz9T6FVBU2gbmcUQfaRVF?=
 =?us-ascii?Q?/zE0bqUD53J6T2gjAidhIgKu/beS0iQZII3x9cDUnlIuQxc4ubQH1cvnVA08?=
 =?us-ascii?Q?GTDENqh7qCyVbTrBzdHYTwMU65jwXrJI/wH0yZR2sWbFGdKUec70BMv43M9j?=
 =?us-ascii?Q?H9Z4LomZyXL56C90A1nl34iWx0ZXYX6Gu0Z7ugceULiTMRAfuogcHg5M/qO5?=
 =?us-ascii?Q?KtHlOruBw8Odckvz4zgwQ5dH498V14V5TaFfd7pvt/ytcvmpL+TCXfGYjU4a?=
 =?us-ascii?Q?/tzy7zPkTS4Lb18TgyK44hTfm5YHp0Xo+txtkvTBJtNrv409pFo93ENitAba?=
 =?us-ascii?Q?z6DidXTNKzAR0WYrq/BQbOqLSGX7Bts4igmLHWZNku+eqm9On6VVYrpXw7uf?=
 =?us-ascii?Q?h8RKharjEYmPDq97yB7DjivD7QO3bfnMTQxwXGoOZlNAqOy0b4ZoiUSpOAFd?=
 =?us-ascii?Q?P15Cm+fmjtIdJgzhk47PgJ3CEmDN5b9V2rx90366GCGVZkF+D1U6HGVcticq?=
 =?us-ascii?Q?SqveMNdqk2jptGhcPXDeUL5vzTOVv2C/auyy4EJzj4kEuAEaFKJ7kalDJvMm?=
 =?us-ascii?Q?n8hOSIH5xuUtx7iuJfBxftVuywjqG1/el7CzDa65kZGcrM0a686ZNgfiNdZA?=
 =?us-ascii?Q?UlW9onn6qR7U5kyTa+A9QnxIQuml3W6zgDfStpzmSb97dS3Jh0H9KVd940Ee?=
 =?us-ascii?Q?e+YOC2NsafemhsC+C7A8uhMbsR+CA6pCscbDhMLrA6ESigy85B8E0+aexlIp?=
 =?us-ascii?Q?OSFelfSOIpODc/fZpH5aHa0mrTg6Pbr5V3hXdYVz4UmVa3qUWI42j+mLuDuT?=
 =?us-ascii?Q?jzYJeupIuZb93j8y8r92iiNs0dfP8+hWSWYkNzgOSNR8Xc4je7j9YTKCRv4P?=
 =?us-ascii?Q?iSkJpWV+mYsysUHsTW/jPCUiUOPz/ejwE1yueW1TfGYCLe5o6WmFVPSpsRo1?=
 =?us-ascii?Q?TlG9TYmO/Di6nSvVi6ItTbpoAosAOOFbOvww3Sdfv1b+tUMfTidf305exIvi?=
 =?us-ascii?Q?DXY0Zu7p7NQj7vo8CHDrZcbi1Oca9s4kM+EYreQpEXfDXprIZkhuqf9hHH6k?=
 =?us-ascii?Q?ythgxKz2PMdM645+0D/L51Y3zR6QnlHcy90CoXiwOKim9ICmZhs5g3jJ3YFB?=
 =?us-ascii?Q?wRlYDVz4GKCeh3/CYE4nfSKH+5ujZ3HD56+1I78oeJ7eS9DGWbUDHRAKKIza?=
 =?us-ascii?Q?ovW5/lRplIMc17mQLRzZZujENIl7aK7UhA2UYzXw8wwCV6ZnJnn+6U3lP2UO?=
 =?us-ascii?Q?Ob0XjPyStwEDR5v0RoVwC7MysF03geAhlPU8loELxSK1JyQYUXmtuVaAK9zn?=
 =?us-ascii?Q?i/JVOIe5ULsT6/8/jjmcLjMigjD5YZfQUxReSzQy4lu32bMS19Y8P+5n8/T6?=
 =?us-ascii?Q?1bUowddWeL3mercSXwH/maIZEL5TxRX78ahn4gRA5rfsoG3/tsswfFdX27Fs?=
 =?us-ascii?Q?ZTlhtK3ZIjUmZkRcpHxAvH/hqOk/eqz0JPNTn7kzaJ08fX6rz8sMICjXwXdI?=
 =?us-ascii?Q?fIyVu5Hwzjj3D1aDdbO6UTQlOawMp/8BuNA7KVPO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0617359-4e9b-473e-eb7d-08db5c143c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 05:03:37.9315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWGJTg9bkUtlZGOBTOGzFlxeqQRca/SajldohpDPE2e2kMuWDJvxkG0smLvYOv3q8HklXj1Di/z868kMuzadRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, May 20, 2023 2:49 AM
>=20
> On Fri, May 19, 2023 at 08:51:21AM +0000, Tian, Kevin wrote:
>=20
> > > @@ -346,6 +350,10 @@ struct iommu_ops {
> > >   * @iotlb_sync_map: Sync mappings created recently using @map to the
> > > hardware
> > >   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and
> empty
> > > flush
> > >   *            queue
> > > + * @cache_invalidate_user: Flush hardware TLBs caching user space IO
> > > mappings
> > > + * @cache_invalidate_user_data_len: Defined length of input user dat=
a
> for
> > > the
> > > + *                                  cache_invalidate_user op, being =
sizeof the
> > > + *                                  structure in include/uapi/linux/=
iommufd.h
> >
> > same as comment to last patch, can this be merged with @hw_info?
>=20
> I think it's better to keep them separate, since this is added
> in struct iommu_domain_ops, given it is domain/hwpt specific,
> while the hw_info is in struct iommu_ops?
>=20

Just be curious whether there are real examples in which the data
len might be different upon the hwpt type...
