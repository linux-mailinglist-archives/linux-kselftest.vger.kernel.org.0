Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280096973BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 02:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBOBi4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 20:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOBiz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 20:38:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C913586BC;
        Tue, 14 Feb 2023 17:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676425134; x=1707961134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sd/Vj/T4DLU2vZ1ZQn3DOLZ12ozp1nlWE4s5KJEh+O4=;
  b=JjPuMU1JM3MQbj2BP35kLnCOIZLgXzDsp6IuY7Uyl0bNcrBXifIigoTq
   aVwDM8zssC7yXYGI8/hjbFQYuJ77tVH9aCkyUz6psQd+h6hcuol/6+Ytn
   tIAHK2otNBFUxSctZ6sCuOXaaAqIC3Ti8YkWmH7LlnBXiqGzxiePPhEYe
   gtqn5TPxNzp6NkHaMWF1VplOSjJ+S39c08Vt7sjq5IRap7Z0oArFOMonx
   XTpGV7xW+W4UOJKQbqtW0l+9XAHaVAUGewq13Emf725Wkj/+h/1oIiIj0
   kZh4cozhubk6Cj4yT4MF5uC6amqLV33hXZIMyvrk8Mn/Vxhs3mLiSoFiw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="393721567"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="393721567"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="738107429"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="738107429"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 14 Feb 2023 17:38:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:38:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:38:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:38:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:38:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB8V2Nuk2o3R+WIWkKtWGqmK0e5eexgHfKrKK7noQ4283BBv0z/ckiHYh2bseflQU15BqriSukkFnVcFMvgmuxMG96J+taU24HxGnz+f+oaDmEsPkLxPKb3nyIU2QnhAp3V2OkV22/6NZOTBtCnDEWJ+mNxgBzBwr41RYEvMvWdaq421gQOwqt1+wmU5UkHaIphGi6A8n1uYYYQCP1tw0SBJmWEsnIiaH2/zGr68ALlbjm/cYO+WdnmSR/SaElXK8NcvMbICJrto7DPyxYfLulJUt+L6Rc0HA6Z0SoscfjK9DmnyFLacrfulBoYWXhng9R/1vSpMTpLAq3PD3f0iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8+0PhKS08jRxk7/iFXL2eP6QdwCr8lFE3ZS8DG9+jY=;
 b=j/fnrspvwFA9JI8vDR2Xeb0TmVeX2WJNKmg3PeHzcAlfGRx8B2wIcAaUFywK43S0jbzXzivgAc+awTb0jZXmKInD25ZeF5Zp/t0eykVPm/yZmRxap1oWjDaZSR30rXPhfCheB8UHD9GFkUlMV9ui1OZZWoX2dsAeDwwX7fKVuLCmTQ9nGWCk0I1gjDg2nGecngzyNQBIaSBVwqEaBYk0xsCsnHYL7Fg7mJWpxE8ClLkB7J76OE+pa2oEvqnIy/shiIny6k8p3YA/6CjNNbxB9d76y4FG1iHgq7eEi7F7eduvjLqPUzQbybLZ/DM5Id0Y+OW/nx+R2z9pg93lWAZEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7459.namprd11.prod.outlook.com (2603:10b6:8:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 01:38:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 01:38:32 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v2 08/10] iommufd/device: Use
 iommu_group_replace_domain()
Thread-Index: AQHZOzoV+UAbwLQwnEuO17sJd5b+0K7F+NzggAEnS4CAAE2/cIAG4ngAgAD1Q2A=
Date:   Wed, 15 Feb 2023 01:38:32 +0000
Message-ID: <BN9PR11MB5276A2CCAB714977F07AD0758CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+tpkpNYil3duTIP@Asurada-Nvidia>
In-Reply-To: <Y+tpkpNYil3duTIP@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7459:EE_
x-ms-office365-filtering-correlation-id: f5603b8e-8689-4c80-a1f8-08db0ef55922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5GWYkLfRKXpYMXTUPi6AP+j+01wwPmlE0LcA1eZGy+8PXAz1Iz8lMcklo3WkYPL/gNI/LHvYKU+uRo++6W0hBy8H5AmOJQP9HQpQozXvIsp9uKVyR/plHPCX4h0kPcHFPE9OYjLsN5CtLd0yBKYdN1BUwycCvXW7Wfu34eq1Pt3x0jal60Nc82z5Tjwse5MBAjUQCEVUbDtMMbTTyQEaGEDkD/GIjbTCHyZlE8tcLNx3HR4Fnf8Rmrp4+Nxbw2BB9o3A6tygtyDJj9dSsCvVL4CFbkuJEHSY39EJNF9By7czHn+O4q2+5foiIP0vlNGR4QkvD+40bii76Vec+3AWFCl6rJ0Sooq3ss0CODqGJxgZUGB0glUAVHOXquYudrbW/5pK725AKkFh4A4+xhqlPFZbkrg9Y8Ho1JDDkdvMnXfYm+48prHJSNfUynDPv2ky66uvMOQWcvDU+2SxKoYyEbtE1SuWo84XPxMkWZkOSRX54n6psNkXe0Ca6iW4LRujibA/XXLfghMObuDn2ObbE5w+f8cHudbWzvpo+4AhSiPpLSTySxp4mKkMbfAwCXGSDRHPVjJT7f+yUJEHnUJBeIKSBIpgzAUnM4bU1DPMszLURcQ11MOJXeJyfKklTS87Ae+T/9ZB63g7C3se9tYiAi9/bysGQX/eNkL8tqogIMDfXiPC+NRhKDDkANYNL1WHmze9tviIFsDCZQOt5EjcDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(6916009)(52536014)(5660300002)(4326008)(41300700001)(33656002)(8936002)(6506007)(122000001)(316002)(9686003)(2906002)(186003)(26005)(83380400001)(54906003)(7696005)(8676002)(86362001)(76116006)(66556008)(7416002)(64756008)(66476007)(478600001)(38100700002)(82960400001)(66946007)(66446008)(38070700005)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wzqBmPJEp4rtxthM6EJoa8GIq/AsEVYbvtVzPoGDpLUPAiUXN/fgEMpKu0GG?=
 =?us-ascii?Q?GNGBFxl3/x5kdtQ1aFx4QlNJaEOMT4c4ARXzO9+If3xnMi6eyQ/tWMmOVb/a?=
 =?us-ascii?Q?NEOgsqyH8IThpEAjuI4Uk3sNHc42XvW0ECG5llL/TCaMVtbdueLv3GCU15Ma?=
 =?us-ascii?Q?7V4GrgNRrovW6yNrVFyC/YIuWGAk4r/WaBW+F56hjP9bpaWJf4ZZkjobqrM8?=
 =?us-ascii?Q?qIJsXXyErBEamUG3ZnBbfEupG0qE+oJJ2N+8wyzF1wSeIEPUTAav6FDRZBxE?=
 =?us-ascii?Q?ADXJFaEsbjnWp9GDh/UjafOGfvXx+1FoqkOSAiK/JC7fU7Wp75jBPwehxg0M?=
 =?us-ascii?Q?puvdXrC3FczmHFbK1cKWh3MuD9ynaMFfqT2IxHpecmJuOWSkO2Gd7XF+vi+9?=
 =?us-ascii?Q?N4MX8pWLiJjECRiUOj02GiXHZ4K3j4QpDDuM0GbZIll8/RFMMAlkoH8R4qmQ?=
 =?us-ascii?Q?X4O2fjak4YRvYi9X07BPw8oZPRnSefndkk1wA+cspaweTrMLtoiXy4ffHdPp?=
 =?us-ascii?Q?CQEjJFRlkzBTLboyNCOrC3LMft0bqe0z1MxhK4LeNmqVing9YKw/XpidscSC?=
 =?us-ascii?Q?FarC6Z7U3dH1akv5kgnbrGZt91IyGELA97BO04+2Oyy/fA1KdgGrPh96Xveh?=
 =?us-ascii?Q?2kHcws0E8FDOUYDtQPCBKqUTo7dseeFWqZsLPKSCt/6ONZZn83jTlzMq6ZtO?=
 =?us-ascii?Q?T30J0ZNUo9nz6L+pMgyHmySIMwZu0vAfyvUPvJ3P5nCkgNfO4cFMyV2a7ka+?=
 =?us-ascii?Q?tSM1lWgDEV7WNz6LWNytZyIIZf/lwPeBocB3CyuxaQE5pxOTKwW4qAAecFEe?=
 =?us-ascii?Q?ydzp5eXesrw1M9ybihpfvTZjKoX4hLfNTWgD7k7wYMjPxvbMGvhqn5K2D/9g?=
 =?us-ascii?Q?5I0BX7zCVI9f59OGOZm29CNbJ6mDbSFgb3bcYsTmef3TKTVAkpab1hMfsNgG?=
 =?us-ascii?Q?pAxzYkTrEiumxDdVsmVxTEZhJzx+EryR1ScmjLGc4tXqGkD/6rQW3maND9vo?=
 =?us-ascii?Q?qAcsE3ykxFze2ydSfv5jWXg/fXKAmGRs2xKaaMyAuKPz4jcxBCzrnhMhjSJh?=
 =?us-ascii?Q?7yyE0n3CAJZnKpgzSP2BRp3bYzSo0WB19TUtWk7dXFbeTMS2RZEtzkJmqr6o?=
 =?us-ascii?Q?ia/FiiN5u0t3HoS1/lTBPa/rCDNiUHXojbomnlkVqc9l5dh+ap5BgAqJlEY3?=
 =?us-ascii?Q?t/MQbDyDXuL2/GJFYyGga5tLTnOPfsWpNa66+jY7IbBvaAGJ/YmEnFlHz1o8?=
 =?us-ascii?Q?EpsVQY2BPORqMgfunx0Kp1md9OQOadpqsd92gIXHPGjlHC61jzL47gdh6lwt?=
 =?us-ascii?Q?ln01z5kg557kQlNGa/A4PePmT6VpJyhiawDyTS+L5ql71mRl/+P5BpWMUfLz?=
 =?us-ascii?Q?ukqgJtboOOUQ6eD4NdeTs8HUGjrk+LEyUZM9rdcF+olTzTKbab8mdEhSJxWY?=
 =?us-ascii?Q?/MA5XCEfmhy+yjzbzcE9rrdVpuaZanWq5cKhtB0HhYFY8eSx7KGBGpdOOvUe?=
 =?us-ascii?Q?FlUxPC5rrFZ7mar/XFJVtsXGG82wUiBOye8xSF+EGBXXmc/xLs3VODkMHomM?=
 =?us-ascii?Q?iYFTdVXDBWMVUPDSgr0hQFadrA7V39qZfhVz+Ntn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5603b8e-8689-4c80-a1f8-08db0ef55922
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 01:38:32.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8X39JTtghaq8D4nutp4+6E6pFIwv4aLQUICJAxUJvUHXmwkFSlRDECWxvsLFCGckSRbyW4WubpkyqIv/Bn7Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, February 14, 2023 7:00 PM
>=20
> On Fri, Feb 10, 2023 at 02:11:23AM +0000, Tian, Kevin wrote:
>=20
> > My confusion is that we have different flows between detach/attach
> > and replace.
> >
> > today with separate detach+attach we have following flow:
> >
> >         Remove device from current hwpt;
> >         if (last_device in hwpt) {
> >                 Remove hwpt domain from current iopt;
> >                 if (last_device in group)
> >                         detach group from hwpt domain;
> >         }
> >
> >         if (first device in group) {
> >                 attach group to new hwpt domain;
> >                 if (first_device in hwpt)
> >                         Add hwpt domain to new iopt;
> >         Add device to new hwpt;
> >
> > but replace flow is different on the detach part:
> >
> >         if (first device in group) {
> >                 replace group's domain from current hwpt to new hwpt;
> >                 if (first_device in hwpt)
> >                         Add hwpt domain to new iopt;
> >         }
> >
> >         Remove device from old hwpt;
> >         if (last_device in old hwpt)
> >                 Remove hwpt domain from old iopt;
> >
> >         Add device to new hwpt;
> >
> > I'm yet to figure out whether we have sufficient lock protection to
> > prevent other paths from using old iopt/hwpt to find the device
> > which is already attached to a different domain.
>=20
> With Jason's new series, the detach() routine is lighter now.
>=20
> I wonder if it'd be safer now to do the detach() call after
> iommu_group_replace_domain()?
>=20

yes, looks so.
