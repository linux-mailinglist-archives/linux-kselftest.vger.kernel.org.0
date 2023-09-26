Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8607AE7C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 10:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjIZIPm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjIZIPh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 04:15:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ED111F;
        Tue, 26 Sep 2023 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695716131; x=1727252131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x5KUEgb24kS6Qluy2ithjvbSty36xgW2qRQCvCNQGpo=;
  b=Irbum03QKPXkgags5ayiRnh66wHvd9BA9b/4w1xESml0g/WjgHxk39Tj
   u9Q0gdnKgedi6KzhS3so17nDZeQ+jalFRrUUvs8PWpY+Lb6g8aRMsQYtV
   6e8fiPWf84HFcnz6moyf8G1RIk+k8Dj7T3e/a3lUQYhkUmCzd58G2DAlM
   ny8rgjk/WQ0+Nm2jBtoVxoCduyk8oSBWQZkeN5M64lzk91kdchEF9RWVT
   cWT1V5hZWagYE2KLPV68i94RronMV6Oy1TqhMiJ7uT07wP13Esc0ULYbv
   pRvV3jo2EIVAcrXfRIAol8cj9pbz5R6+FsnOaKH7HOOPJ10yQvq/+xsOO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467798277"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467798277"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:15:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="778042276"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="778042276"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 01:14:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 01:14:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 01:14:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 01:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvG/sAONwbX5/beL+IWCFdEB3kX3Jmz2UiTJiqr85TPsAxqO/lSTxklS8MOHmM6tQXtX6z/5RNvqUBqfmBq2S1Vlmb/EUFqp1amK2Q2UZn0w9MFdueVlo2ZbmN2oYkSC1f9huvzWkuQT80OUFUvw5NtYiyidfjt70cqd9Vx4Lp9MsjOUc2PJL/wZzsGYmp/d4872LGqoEQiiF5xbtDRfVrmWJ/0BAkZY8nMcB8wQPd0X/EdXmJlQb/cubrQI24VS52MvERpo3XDVduMLKiOBQLgxuxd0oXON5X9sSjxlAMwLxlUSa7XRXQL55cfTk/u/PKCLRFT7jmxY+tq3CFwKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFHUqCEqiuUaNZUutY0dTXGW0xGYNa9/UJpz02+tiy0=;
 b=Onq5kh2Lea2SUEfzX+D+2uMzlHGgfvcqQ4rajfLEVhHCZsGNK+Do4Xelhr9nsArmRgNvZbUtcyYlW0gLSKG4zQdTmOqe/PHuPy8tGcYFH/US4UFNK5GpH/VHfHrXmZsou6Ay1S+gvkUl5chYHQLrkl2e/rZ+y63Odct095ndtsbJ0qeRqVAAfnE23FyL7t0c3RB8ZT3zkkBPYTZ6FGWuHCXMbBqyV40LHbH5ptpCy6FD5Bo8sa0OtnFx4LsMy7DzNaOO0M4EDssJWMguvj99XwtMb5jR+PZEnGL+O8krtYceLlLfVaT5KbQ40dRcSPWz0dtOJvf1lD6DzW4XASErKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 08:14:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 08:14:47 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
Subject: RE: [PATCH v4 07/17] iommufd: Add user-managed hw_pagetable support
Thread-Topic: [PATCH v4 07/17] iommufd: Add user-managed hw_pagetable support
Thread-Index: AQHZ7GCNGmhTffD5jEKiTFgUr50vNbAsx/Yg
Date:   Tue, 26 Sep 2023 08:14:47 +0000
Message-ID: <BN9PR11MB52765F6D764B0C621A2D3FEC8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-8-yi.l.liu@intel.com>
In-Reply-To: <20230921075138.124099-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5108:EE_
x-ms-office365-filtering-correlation-id: 8f4ad315-9b38-43f9-aa36-08dbbe68a630
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTOe07UXmuG0jPYkJNFvplcNt0OV0vO+u4MB3SbpdBNxL6cPHKTh7FHfQuPDZvBglq5Z99EPaqw0pk2EXVXm5vxRSJRtUqbMp6GJjTY1N7/OWmGyXefN/B783EquDO8msZbMsdof56g+97tMnL06Br/FhlVTLRwUj9ADDLfBxQYwpg9ZYZi7xGV1jG22WSvDMlS5Mkf0apsIlB070a78CS5hwuXZcooRJVNsSeRoIL9/JRtI1IcUu4bzg1JUJuMmHM/F+/tyq2hsq/D1LOQS6aZ+p9b4JSqCggL9ERAwwPaRPQtWQWp+iw+sEMbqNroanjPGYhDAho72LOfr4Kf2abChVJfc/SVr30Dx3gOPcswU0BoRyNOHPeTmQynEeldwqDxI6TtDRI0t1KXM/oEDejy1ya2xO1rJ1nNmn94YaiT9dA6j/UW/3XKWffKV+OnTvQ6E/dz8NNytbUY0LSiavl4uZpV9H9qCRf7fXwSCYoF3xbC3HyhARHeZklDQWCC0H9Fk6N+125HYguk4BZyC3DBzwgYT6ApMKXQ0SKJA081irP46nRcL11aQqh2/KR/g5vFefBeBEfV5nDuuUUTZuakfXdmO3ghHcoHR5D2Sr230sf4jLkwjphjMxS/+JTaw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(9686003)(122000001)(55016003)(82960400001)(7696005)(6506007)(26005)(71200400001)(66476007)(66946007)(110136005)(64756008)(33656002)(76116006)(66446008)(66556008)(8936002)(2906002)(7416002)(54906003)(86362001)(8676002)(4326008)(5660300002)(52536014)(38100700002)(41300700001)(316002)(478600001)(83380400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P7ygxJ76ESlRud46nH8YM1bMojJnIE4Wc7Fgi+Th683k3PTCkKByxxhC1E+O?=
 =?us-ascii?Q?hwg/f/z2Vo7CQ3c5ssSjw8hEFykRjnX0gLYxnrrvxjRe3P1sMezAluhKBtwa?=
 =?us-ascii?Q?Vs46qafpb7wYa1a8uGvx5SuSuWtVDBenGLzFVI6xApvSowSiVY5ER1D01yeS?=
 =?us-ascii?Q?UnB4fnZpwl39xPd9SMhOyYMbQ6RSRjSqnNPSjNntFBiOjQ44cs9gVLobTWaB?=
 =?us-ascii?Q?T7aim+oTMw05djClTiMnnMjnG+kwaDa1zE0Yi6aZpnVqQdpzB6TpzyUg+N78?=
 =?us-ascii?Q?rRMvWaiRi8r0j0hn9RE5lLAx0QggwRkRRR7pTl7gN+3VR4P44/wvD8CESX56?=
 =?us-ascii?Q?XvbTcRQl4P550fdXFc7wYX5kCGluhhNW2c4WgPBJKWLY55V9fmQG2GPinA94?=
 =?us-ascii?Q?xTQyfkQbkEk1ACyqU5BrXeJm2BNaCKoho89LC/F+JyWLNOJ1EOXGqUuLV7Vj?=
 =?us-ascii?Q?TVT0tx4ZFSGjrOJW+nkFqzZBhBQKBes6w7nNTGsqOpgZMYQM4yqnS5+EE9HA?=
 =?us-ascii?Q?yz4M7BwNMIjsGMUt6l7oRBFXx/p21kGJnxnEJafhxzyUN2QHJvSzYWXDU9PY?=
 =?us-ascii?Q?UAxiNDyOKfYPgIQIySHMNVFixPNvat8eC4xu1r+m1t+T4TZBIslaR2QfEXX0?=
 =?us-ascii?Q?qpYjtvAZn0bNVPeSC3Y4gjXn46iZd+bJ0Qw03XlfMPWeVlqvsThLtoV63VrE?=
 =?us-ascii?Q?j1t7xwQZVZCGEh/9rAJKIy5hiHM0bCroYPJt32F6MmuyIXlc8wSUTJ8lsqZ9?=
 =?us-ascii?Q?qv80jCFxj2EZTbUoIxnPu+Vf71SbQkfJ6ajkwO8s0uct1cljMNaqSG4I2UeD?=
 =?us-ascii?Q?ha3meRYh8kCQlQcwRqw+zJCgbizAcfpj5j/Gz+rtRV8FZ0CLSvxLGOOJKPtS?=
 =?us-ascii?Q?hvda1f10de9X4LTY/RRAMPqeeNbdckrqX6DFxUZx0Q1clz19klR+Fzp4OtCt?=
 =?us-ascii?Q?W0w2ponNaDjy/O0bO0cgYWs80jG5ubqyEXOF6grE7foSznAG/W6kqXHcvrVj?=
 =?us-ascii?Q?+DdFzpEWVFsFMRnn89BztLstWhCSKgcxvyV9LKkTkoAZpdHiCORCe0DwU8Gu?=
 =?us-ascii?Q?lw0Y+8xVWcfybmopsVB9JxviKMFYSwKhAhQqI28Ep7Ml/PE2jGf50moSO/SJ?=
 =?us-ascii?Q?gIOVGCPL1z0K84hlHl79oJt0TEKSY5JWZ0wRYTtsh3nzyocFdnjiDvoLRs76?=
 =?us-ascii?Q?UShXfry6okm2ZzcD9oP3MDi/YBZpUbbWA9wM/zYkbr/s1SfrtuDJGfAKr0Tu?=
 =?us-ascii?Q?Dja8y9OVx/zLplV/Quq99BU8i0MRJEUtJ+wOrDNaSnlW7RiFqg6RA22hbpO6?=
 =?us-ascii?Q?WBlr8nqvWwuug8tcx3LwiGQvMAhKHAC8xzfc5SJ372eFQo6FG3Sb05qH+vUf?=
 =?us-ascii?Q?zWh45choLIkr794ulHPJlCu9dkx4AjofEZELUsSSYY8R/IJReKFwk2b/N23/?=
 =?us-ascii?Q?0pe08ZzFVbr71Ja/HyM7W1dt0Z1zjOTRLtuJQZ+K0AF7Y1mpAI0HrIOPfGwY?=
 =?us-ascii?Q?K+N1PssfJHlg99C5eFCs5TmUq42avdDiROqatsLyYfuS8XsVBHv1WxIqtwYS?=
 =?us-ascii?Q?XiPYOI0QVmtTZZSW743/OXnX9sZla5wKZP4jRqKy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4ad315-9b38-43f9-aa36-08dbbe68a630
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 08:14:47.6889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmZHaESUEeXG6vpJGZFyuhiejXPtkmScy1GTDtYWwYRNBJBtlCvtHxEHotmxvtRXiKQkXzM6IE0P4IVhARtgGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:51 PM
>=20
> +static void iommufd_user_managed_hwpt_abort(struct iommufd_object
> *obj)
> +{
> +	struct iommufd_hw_pagetable *hwpt =3D
> +		container_of(obj, struct iommufd_hw_pagetable, obj);
> +
> +	/* The parent->mutex must be held until finalize is called. */
> +	lockdep_assert_held(&hwpt->parent->mutex);
> +
> +	iommufd_hw_pagetable_destroy(obj);
> +}

Can you elaborate what exactly is protected by parent->mutex?

My gut-feeling that the child just grabs a refcnt on the parent
object. It doesn't change any other data of the parent.

>=20
> +/**
> + * iommufd_user_managed_hwpt_alloc() - Get a user-managed
> hw_pagetable
> + * @ictx: iommufd context
> + * @pt_obj: Parent object to an HWPT to associate the domain with
> + * @idev: Device to get an iommu_domain for
> + * @flags: Flags from userspace
> + * @hwpt_type: Requested type of hw_pagetable
> + * @user_data: user_data pointer
> + * @dummy: never used
> + *
> + * Allocate a new iommu_domain (must be IOMMU_DOMAIN_NESTED) and
> return it as
> + * a user-managed hw_pagetable.

Add some text to highlight the requirement being a parent, e.g. not
an auto domain, must be capable of being a parent, etc.

> +	case IOMMUFD_OBJ_HW_PAGETABLE:
> +		parent =3D container_of(pt_obj, struct iommufd_hw_pagetable,
> obj);
> +		/* No user-managed HWPT on top of an user-managed one
> */
> +		if (parent->user_managed) {
> +			rc =3D -EINVAL;
> +			goto out_put_pt;
> +		}

move to alloc_fn().

