Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6337CBE68
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjJQJFi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjJQJFf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:05:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0774293;
        Tue, 17 Oct 2023 02:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697533534; x=1729069534;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4I5ZpNZheR8TqdzeNr3wgQo3ulRA4eQk/wl3DCPMxss=;
  b=mhJiViM7GHFTgwlOHTM05mxx+LWOfDnIVTQU7EjvXLE9edSnKtsGuE3F
   rAZzGsmSqEq2thed957h5BSq5ZSV1N711RYR7Yatdf1AON7KLsnqxZkAh
   Ppk4ScMAnSPxQpcu8aiaUZz/cZ+RCGnJW6aeU3KCXj1NchJgRv7U0Ae8i
   apIuqJtkEdUOXI/7TO/FUUgh67Z+iKX4JRDQS5iqx79ufw4m406SembHz
   X1ONsLq2NKLMTi0E9ZMpJaUCh8MKFCIpdaKdtWeZDyG4gT5SFah5mZFNA
   sya+s4qEuqK8o0aLOEOw5iq9bYnnoV3p8ZfusLfc4M/8QVhJKNSsPRv/G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="449958956"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="449958956"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="899839758"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="899839758"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 02:03:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 02:05:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 02:05:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 02:05:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/oCY37AkZ/R1azIKu4X8huI1lGunruohjxZ9XRomO+ewYgDTG7FGgutkdcu6UBPuJVJ2GKpmNje5V9AD6sDgQjyncpyvpeenV+4YLY3+bxlrxJHarOX6+1J9fhUZKIsqTIgjejhlHKOt4UCzPN3gZsgDfSAXrr9OareA3pUMn6At5Hp8AUL/USJi/M+14XjqeCXT71P414x4vLHXrjzRDZj22HBGm+nMimykvOZMoKO4vGcq3eiRkn1LQr3bRHnTp00NPoaHr0katSLhAV8+SjFNJxja6cFt/IPJ2y135Nc0+Ik5+Q8dyu7o1oh/RtnnjjWGnNFpd+otluXyDiQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I5ZpNZheR8TqdzeNr3wgQo3ulRA4eQk/wl3DCPMxss=;
 b=oU19Dm9KWNYYczQdHCQIIL3gzr27KmBykswikfINGwF1ylkKc3CwIpt+vkbu2scOm/cLL+v0Uh4/mrZhMmpQTPSK0Jqe3ZCKqOBAKtcB82sH8WAEKpbzNb07Z9LGTrdhgKUTOrwRz0P6+WYLXfLBSdbLWoFKiyD105eLNVTPgmK6m2VrYdWWW1KBpBqFVbtiKD/RWP9y3aMPefONm5B6qNfp4meedyUQEMfc53iowTPVarDOGKtHWcAB/IGxnL+p1fhM6CipFxucOSyey4YNiWcNNsFnE+j54nx7Q3u7PvgyBHQaUHaTsQgQczmODQdOtBKy90SJkry47lDhPFfVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 09:05:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 09:05:26 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Topic: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Index: AQHZ7GCNzWxyrCHnVkqPkBvqOzEqrbAsylxggBvMMACAA6lO8IAAN00AgAFSUcCAAA9FEA==
Date:   Tue, 17 Oct 2023 09:05:26 +0000
Message-ID: <BN9PR11MB5276633A3740894D4C5C565A8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7353:EE_
x-ms-office365-filtering-correlation-id: 11648391-07d5-46ab-29c7-08dbcef0344f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NYG5yqctk6M3aqrHa30jfXnmOgPORIrI+4JwXc2FEJuxpqI8IHWlDMcY9VDEfhN4G0uBJ29QnmUuV0+hYpihlofP6nCcx3G1IFQlTdzxNApjD1mcip31ic2rrYfzMPd5BRC5NRKPAz6rTC7cWz8t2R1NUuPtTo4oiFpjiWZUBqh8kO2T+1jzkyWid8hAcaj56GUP4H/mVJhQyERljHK8yIIXyi9FKDBlYjUBm4H8qFyDIze6sltTKlc2vk7REUhCFhQr3gp0vtosm+Lo/wUYqK7/b/9Au5j1G+nJz9qsyM40iMkjTbkvTHDwrOrF21WsUdBMnapp0bfRNTPv+R+IyU3FXWMXAiRWv1WSoslQgxvO7gh3KD9yOXit4fZSdYFS+nWge53mp/SamO86pSAf7V5CWwH2DHVEyR8T3DuRE/3j8oZb6Lov2OMIJAbsi9OA5smdC08+L6PH+vlvnoYsjyRRgBha6uo00VMSBjAgSoXEL1vZX3aSGrH6AyVlx62BLlmK2fyQDB0oV79gIxTGtsqTI8LV+kA8mOp1Mo756lueeet3WZE00htMgvsIOdJ5EDzPUDVpm8pcZfYQBtQGlBL5efBuh7peEq+8jj0zApNwOskHdc7G3M8jbCbQEILW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33656002)(66899024)(55016003)(66556008)(66946007)(316002)(66476007)(66446008)(64756008)(54906003)(6916009)(76116006)(86362001)(38100700002)(122000001)(38070700005)(82960400001)(9686003)(26005)(8936002)(71200400001)(7696005)(6506007)(4744005)(2906002)(478600001)(41300700001)(7416002)(5660300002)(8676002)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wz0424zTAyQB91EsrbVq0aRh8Ij68U/iXJgRzg6+1UFDIFI79bCtFYlD+WQk?=
 =?us-ascii?Q?+PsWZ+myFEtJ2LzBf8nocjEljzxrkDqpIU2KWPD4dw4IkKwQE7ZPb7YVpZUC?=
 =?us-ascii?Q?6hTTjggiK1iHgKvDqA8QeuobHRU1wZwSE/aU8wSbfKy0p9F/aVzsUBfz9m4b?=
 =?us-ascii?Q?ahOWtB2FdNVfHolUIvhGaSXNXqK+AOFkK3uCTEtC3EpkJLMWTp8MDBuI2K8n?=
 =?us-ascii?Q?lCMkhvPVMSk05yJeSF5peZTBf7o5e4CQSXfUC2h7GPeIil8YMV3tAepXNSlE?=
 =?us-ascii?Q?IqjHnbYt7giQNa8tIXPeLirr8PMyj1699z/XhikLxpsNmYS/bExzf8HpmAfy?=
 =?us-ascii?Q?C7WNdV+nrRJI7ArimezsQKNtQIa2hscxrKmwB8YEDpofSjdfmZOaORJi0yjI?=
 =?us-ascii?Q?M5cANpU5TEYPzrCfzIExCJGf5KeBBq+GFvLGDK/Ce2o3h93LUiC75kaVb5DC?=
 =?us-ascii?Q?gkCGG0mE+oLSKiWQj2w8z8faWvOQ7dpaG1TBl/jIx2rH0kq13KcZ0nMwDix7?=
 =?us-ascii?Q?kA3rJJjJVdRddgjp5HISJFcdZFstBhRra9YnR8VR9FP5V8sKAcBIEKVDzko1?=
 =?us-ascii?Q?rJQWx+aDiAyfM6cMLdtj4RPrTv7BZt6uMzRGeu7ogCg/njRFPwp1h2NmuZcZ?=
 =?us-ascii?Q?d16J9V1PAlWWgzCxRb71bDhLv96y5h6cXUNpGYmg9sVhMNPrfOmqChjEm/G0?=
 =?us-ascii?Q?v7IEMwN4qUShw3P072fIlAGkTmirHGsUdzpEhtttIdEV76nFVmLfnuXvj5ac?=
 =?us-ascii?Q?CJoi4ZvEYHin/OQHnMAMYofWV5BMpFyimEEBHy3t2KcAwhVVtwLorBsZh2P3?=
 =?us-ascii?Q?rMP/I5sqmjYzbf0SNMHS1+zIdAzm7xiQdyrHcTUWiL0CgXz9bqiprufSrjX3?=
 =?us-ascii?Q?24KIDM8BgNNSOdf5IQ9J/B/naWNmi/Hr0MdNQU5hyxz3Wy7qs90qNu6Kj+iQ?=
 =?us-ascii?Q?WudAOIVlunqXRX01aQUomCWOcQK+JIqbDF6v7Ut1P2l2COh3WQX8cPWbN6+f?=
 =?us-ascii?Q?f6qGXpuXiutWU+nAwrAwVEmgx6kkEAkCGBC31OvHsJBCwNhTtDlAVYIcp845?=
 =?us-ascii?Q?uAQC+G/9/dSIbKKq9dzVasIc1TT1fTg/LTeU8MVf6yYyFEauyzF+yqkDbsoy?=
 =?us-ascii?Q?cl+z2C1vmVy0onrrDKwMtiOXrTfNy/XIRT8Hx6V3Syd9Tcyb36qxJW56dB8x?=
 =?us-ascii?Q?4Fiwpp90+6hHSeJ7OGJ/ZaQ8KlcqTKXDOAUkYXeX/3InBfX0KZI0AvxfHSuu?=
 =?us-ascii?Q?ZOR4lcYWrmr+0W/gRJ19S7r+Syeff97TmpOMGuDmimoV8U+UNuraSnSBzUqD?=
 =?us-ascii?Q?qm2ObdApGlVC0RouB5Ogabx5tCCifyVoqEtxxPxzxoc2G/ByvRoewuTppPYM?=
 =?us-ascii?Q?iar8xw+zrqykYPNyTGQcgxxs+kLzQCUedE8GfNdYJsXvEkP4W+5xDFOcRl9D?=
 =?us-ascii?Q?3jbta0jBtkAK4seFDzKvGgY6fd8wOlIu4tnnZqm/kDP25LON7DAXZ2dHjMRs?=
 =?us-ascii?Q?hLN1vcFxqI4vuRv589zQyL+dQ3OTHUdFNg7BgvbqM24oWcA87hJoiA3+WlhR?=
 =?us-ascii?Q?KtC5YgEfU5pkawSyIaH+KYSsPXVLRBEpk7jOdMXb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11648391-07d5-46ab-29c7-08dbcef0344f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 09:05:26.7929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oL21JYvkHGNvA+GofkI2NufH5IaX1DNk2N/3Gu2yp+ddDEJeeUriQkhD2TnS+noBqxSK88Krrk3k9gn11N20xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin
> Sent: Tuesday, October 17, 2023 4:53 PM
> >
> > This is why I wanted to get rid of this bad mechanism going forward.
> >
> > Manually created hwpt should have a manual specification of cc and
> > then we don't have so many problems.
> >

Actually I don't see much difference between manual specification of
cc vs. indirect specification of cc via specified idev in hwpt_alloc. What
really matters is how we want to deal with the compatibility in the
following attach path.
