Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFA7AE50B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 07:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjIZFaB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 01:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIZFaA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 01:30:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBCFC;
        Mon, 25 Sep 2023 22:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695706193; x=1727242193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZSTT0t17kWd/Bru70shOeQ+326sxidP0/R/xW0llV14=;
  b=m9PWAx8GcNCJW4NYFQuN29arT+RtGDdTgqPhybtw2K/BEDawT+gXdZBO
   R+dq+U0BprcDseqH2EH7SyfM4peakkSFV6+au/VY4dUmLoZZOVcR1kpSg
   glDi2R5/PuJQQ3Jok2RTN/2rCRK9xjq2KSGDW//tpxTje14a09nWxiTLp
   FXDvNLeeUAhQ+XKHQG/fjxlbebjLW0MTb5fO96sB2Q0U9Fz0ZPVGD91GO
   SzlU5p9PKDjhy6ds6Mc/nlnVkpUOPVwqE+SV0CaxIY9EdXXOAaZu11Ntv
   NMuM9OdDYvXrgvyX9L3lu4ruTGqYn3168tSmUmgvrRO4dcCqTKF4KhimO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384266934"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="384266934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="864279583"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="864279583"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:29:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:29:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:29:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:29:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJb1yoisbHKSt+owmFZ8qlROEIun3qQoqFwql5DleiOw6kqeW5y9nz2Sryzj74+uhAwij0vrxBR3CLur2R/FJkKAoQUTGX79jaUH1Iok+XxvzyOYhkpEi1rwWa9abJWmlCQCnmRSlwHnoIjJNkJ1u28eFr0ELMKHtnNeGOxnaN6Y31213R93SVyCEFgRBXnpp8ipDC3kuqUQBHhHZSHWeqAI3XOk+Y1JCRiQWm1T0ThBLpNjRVUmUYrHtq3WgX1fFHw+OCkqzS/Ku8V68Ht8m6aDb5C417fuf0ynd1DiVrSnQvYCBTVSoxecAANcQV5rSGkROHsWdpJXMjJ9R6B6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSTT0t17kWd/Bru70shOeQ+326sxidP0/R/xW0llV14=;
 b=BmHZtef61UHSP14k4qrWZGJjENLhQLAnpxZwlHuxvaL9eGktX/JW6QZVVxwhhDHBfxuqwWTcTYW8x3dd9SGsI94BCpMo0hZs3DS/7AwXheS1DNX9UQdlex/jzffSMjevsn6t6uORZeGru1dbiIaOiw00H78PXGIsBgpO45uM7k+3K1BBu0CScQ/twrXcAfUKgsYYhd4f0kTiQjLVxI7OLdFOy3rYFPwIgXrT1unplNUEJvsgc7WeU6ODFiu8oPxnlPhsnlwzxpKAfiG5TeF1PWniIwskGkzaWNxRAC7JLHq3Wnlq7IiY2j1PscXYu4b/GThS0ay+nJxxAcp/8NIvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:29:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 05:29:47 +0000
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
Subject: RE: [PATCH 3/6] iommufd/hw_pagetable: Accepts user flags for domain
 allocation
Thread-Topic: [PATCH 3/6] iommufd/hw_pagetable: Accepts user flags for domain
 allocation
Thread-Index: AQHZ6ttWtNesTJY3okmprzzmJVfOZbAsnx6w
Date:   Tue, 26 Sep 2023 05:29:47 +0000
Message-ID: <BN9PR11MB52765FDF58AA3A4F07DE42E98CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-4-yi.l.liu@intel.com>
In-Reply-To: <20230919092523.39286-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7966:EE_
x-ms-office365-filtering-correlation-id: 3493110b-3894-4ad9-70ce-08dbbe51991f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLUejcpd+RlNHGO24CL30hz7H3wk4zp+3iNOwe0JfYjav1lGMCISIDU8DdLEdoHqrY4Z98ENZLnA6Bzt9JQcoK539Pi7KJVbuECQaIQ+OaY/d9Smm/s5ueodIUb39ZE0sxkXsnHVHEOlUIcP/mQhmmZzMj7ARL9nNlii44vbiOWMO+vROyQr1mIwD49ECMf0gz27fw2kKhvqXNxFUK2U0KaPwtrg4U+QLk7CXw6/Bjao3hQQDzgHW2QuOaYYT3Kmpscfb1orqlp5OcHldIyb5A5zn1P2N/+dmPSMsh/z9MAPlRjgdym4aekI+gmkttbRve76RlyROQOvganXQLGxP/eDmTPb7N2oNr0BhuCMbrmOEOW3nN65UC9F6Wgl8RpbxZYzx52EycT+BF1INC8ZwW2BzsxKmH/8+8kntVj4t0WIiDpVLCKx2x9sHgTRcXYSZEbjjdZRJC41cM6QiB714ZfxtsXMBhYyua25GdU7D0HNToq+GZWMEat2tRohxnhxd35MlWLKAYrGZ09+iuCI37NuVZaXJ47pLPi+kIpS49mPMvt4e66v59l/OH9scTQqOk1oSlAAnImaBFiMjTLb9wFgs5fNYCQaju0AdnPUE4tPEjiNJPCgADgUlWKVfSO9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(558084003)(38070700005)(33656002)(38100700002)(82960400001)(86362001)(55016003)(66476007)(2906002)(52536014)(66556008)(316002)(41300700001)(5660300002)(478600001)(76116006)(54906003)(64756008)(66446008)(110136005)(66946007)(6506007)(7696005)(7416002)(71200400001)(122000001)(9686003)(4326008)(8936002)(8676002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8WA21p65RjXwNjY9fBn9A2heIR8br0Klgze4MrStd7b8dgMKPPEFbYDnOxK2?=
 =?us-ascii?Q?0y3pW66VY2VNEPwb7TwmaR/0o0MAIDgYMzJ+08QGSE6H8QvVfuX2MzH1bgp7?=
 =?us-ascii?Q?3HY8s+wF+Hy1FoMSBfu47cO049Wp0Am245iCHwoGqUrHjFWSlYpOwYEbw5Js?=
 =?us-ascii?Q?+fkhbtlaRcrYIgQ8t8h7f4qRl+lauR008K72Uj0jzw5ce68jKGUN3wQve06K?=
 =?us-ascii?Q?Gq+bldzFYSn4ies2+DkKN7YlBe4kboYUCoNSWi/C1cr+6mLD6zVUFp9M8SVg?=
 =?us-ascii?Q?ZLhR0TfHjdxIFYGzbfAQaSTIs57oWrVjT3kga2sHifxMLn231k4nGLWKCJAi?=
 =?us-ascii?Q?KzxUR6RAhdP7GnqxfQIYY0699JceACGxMT+EhhbWjUJxU7NVUWWvxDZ7xTBh?=
 =?us-ascii?Q?JP8faNRPKj6gvBUlILK7YUmhRC5ukQAIwlJeQ3PPnxWlvmnB3ncA3zDxs9Tz?=
 =?us-ascii?Q?Bw0N2mZ+iA74mbBleoSsmiWYAWFqu8yx/ywofw03ioVvq+Iyjjd+wskHW7/2?=
 =?us-ascii?Q?t8qAjFAALZ+8DnKBx4fXSOM3vdIhYDq4d+lutu8NlM1VAw2xkGyW/YjtSb61?=
 =?us-ascii?Q?qD6unjHmJo5+kgFTcL3nAL8Zd5rQQwn5TxWvkQJnJ7eRIVYcQfGcPNiTSs9w?=
 =?us-ascii?Q?zE8osHgBfB3kU7gurhHusvXnRHkEh92KKOVdHVJDc3LYWKbA+nsrwlx3ydvC?=
 =?us-ascii?Q?pclSfaYW9EmtG2wZi4SWw2stpbzNBj3d4vLaxvNMNrFzOxP3Qv+3vLF6+zRp?=
 =?us-ascii?Q?KWNrXT8x/QgbDSmD2RSC+ySB2R0BwcEaOzN8rYEp9cOK4WjcMbPftX/qCsAr?=
 =?us-ascii?Q?oy8oJ75qVsUU4oqlxpkOrkmC2iz/GeXLgWqGnwfCt1aArKNCH5BI4ndBFoOH?=
 =?us-ascii?Q?s1I+4d8ZXxr+u4wS/NQ1cHgW0cZ7a9AiXEp1KLOAfRCaW/WYYcpUTVebaHrR?=
 =?us-ascii?Q?xr0qNJXGc9JScPEt7faI9SSQLaGqbUzcxuzxedXNozJglE4vd5EgfE1hVbMs?=
 =?us-ascii?Q?wOz5io2QTibyIEHBUUfDnKVVvGfnBFP3wPDQjR6y2zBl9f/lu2NHHNCyQJ9p?=
 =?us-ascii?Q?XPodVlAx2jQrMYB1Nus7gXME/0wZ33Vzrb/WWH0Y1fT5OM8OQVvtWLNmBClz?=
 =?us-ascii?Q?+dhMfrV24zF2gBrKE2kv0QuXQo8Eq1xWNKmb8RzlHVHxktYgUJHL9fImHTuB?=
 =?us-ascii?Q?Zcbau0IPoWm0y3IH+S24jwZ3gZNS2R1yhH1ctwPqyQ3uUre2KzUjZL5SpRVf?=
 =?us-ascii?Q?m2oKeRZstVRVDm9iKzQuP7ULxlekRMo9w0DnHBwl5zsVQUsv8zuS2J8fouwa?=
 =?us-ascii?Q?zgFfziy522Wy5IfF22hp3MfGBk0yL0WzMqSzUti2PqqRzPBhMdMGuDyelU94?=
 =?us-ascii?Q?NRW9+biaMD/7zRefCm9L6/yM2NY2yINo9cV1ohD+F/42amNHrmKNlmKmXdCk?=
 =?us-ascii?Q?+OR09pMacSCM0D5MOgZduwq2EOalnVJtaUuY+o3Iv0T0gegHG3IGJ38p872i?=
 =?us-ascii?Q?Brhqbhu0drUwP7fiZj2KRlZvNoJg8KeaigDjW+udj9BzRq5pfNsEZydtldff?=
 =?us-ascii?Q?LoQPoTTJqRUA7T19qD1KuujW77q27VubaB4AzHf+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3493110b-3894-4ad9-70ce-08dbbe51991f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:29:47.3252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HULk/A55dpxC+8SpcZvyqIoHKoYKG823gS20U+NyvjvnncfqncFcLdcSndN9nhKTH1+NWMADNYqGbadaLA892Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, September 19, 2023 5:25 PM
>=20
> This extends iommufd_hw_pagetable_alloc() to accepts user flags.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
