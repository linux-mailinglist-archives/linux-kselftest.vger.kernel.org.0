Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D545A6A17B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 09:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBXIHu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 03:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXIHt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 03:07:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCFA25E09;
        Fri, 24 Feb 2023 00:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677226068; x=1708762068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U9kJ9uO9fQhCq1upKbuPjJt2qEhIDmWsoWLpEABNaTs=;
  b=XRNFDnVd2QCYoXDMUrVIZ5fRgHnA0168ufp1L3jLW5LMdPbdeeCyNp4s
   PnpIjdOv4zpUjMqLq4yvf+UVOhr4YkRpwjryMcBwX7zQWB2G32a3IfpuF
   S3f8S0Fs0NaQ8EhQfE5yFrmfx5z2bcnon95tbfZybqdEXZoN/vx+50Pw5
   Cs9NEsF0SPQWvyU82gIo6m+TTl4/qDTS6SbFWl5P3DoYhX7p98EDe0sz4
   ot9xJl7EuTHyaS7Tldcr40SHXxXpRa+TpFHAF9yh0vwN6YgeR0fulDuP1
   OXS87AoBFhTlfPjTsbIGkHvlre9RPwBD3oY2T0eDyeacS0xHSsD0yjMzk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="333426684"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="333426684"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 00:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="672807122"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="672807122"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2023 00:07:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 00:07:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 00:07:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 24 Feb 2023 00:07:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 24 Feb 2023 00:07:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Can9WHjNxyG0EXOIjoJCevlultcsY57VhloyHTAYCWtCsoNfiJRZD9m+gZEYP1SywGzjWlU//yo3Nw14os0k5VCv1s71LMPoAqx80vAEuKNal2VLq6Uir3bMt8aN6Wng8fw9AE/57oQad4WcGXlKz+SggtQfN62vmWcZUvS1/QtgpTAT+DLcfgxc7+YdS4URZoi0cwkBAzE8y5/pBK65y8RLoXmKCXFYVb55kt2OQp5UBfo00vWZqmCdzUYkdyQvT3Vv/WwfKISW+CxqayZXpxyv1kaAPk/Z9xF8LXLsx+BV8e+QZ7B2RFqwHkjdSZ1Jf+d4UD34F7+JIvph29z3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btmT0wdYy9LCccYcHR9voHVL8MPZOYyHlPX9MiNMgKg=;
 b=KibOtidJL84dHtU3Ax1Lwm6uyGXHZjfybVrerPsOYk5HsEn9DNfvmssVkj6KS4uPtmp3zwdabgKeHIkiWFjDsZI3XxIsYBNXdyB7Ow6ufO4FrjMymHBAzOMddrXu8w1WqSv7SdDTdoneLGFnkpNTsNNRee1MuPFBsCR6H5BgAwl1XybgsNPT7OUea7LDVezH0RTC3n3j7sFKo8EfJj6lZTx2yD7XAtOJJ/I5aODAwcPno6BxbzYY6z+sQN+AOWKejKm4HkTVAqPm2ZYmV123L0WDbcfwXWcbygTPgqis9ssZvjNmHOrR/Rkife04wQFGv/pj5ZYpBUEdlbEJR2g15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7695.namprd11.prod.outlook.com (2603:10b6:208:400::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 08:07:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 08:07:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
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
Subject: RE: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZOzoL2+M6IjP2sU+QmVuzFLJejK7PjtZwgABzeQCACkyk0IADEJoAgAB38jA=
Date:   Fri, 24 Feb 2023 08:07:41 +0000
Message-ID: <BN9PR11MB52761AE29AC1B52D2BFF45DC8CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276941167B52F7C0A7A4BA68CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+zVliMV/R0ALrlT@nvidia.com>
 <BN9PR11MB5276A3EABA1F00DED4B5B5DF8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y/gLiNs42UyO58zJ@nvidia.com>
In-Reply-To: <Y/gLiNs42UyO58zJ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7695:EE_
x-ms-office365-filtering-correlation-id: 1fe7615f-ae6d-498a-d137-08db163e33b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M3UeJZ3MTqsLAWPXS4sWVe1jYHLeLeBnEWKlHoqt5Og8ep2/tBJiVr00fYXT0V4yIg5fFNZwzrV3RrrODhMU0aUzPc5Fc/6WksCv5n3XvhzeDKdBJ8BrtpkFkbHSvwR5ZkrnI2+awsTkLfiOUk5n6zQsqWDnta4Bu9A0bjvwg13ROpt9XFn/kyixWn3uS4N9/QqQLQwlB0F9m6Gbwvu2GmL7SYAxWpDlEobYHavOPxYDg3GY0V4n7L1JMsn3rP3FTiePTdoLv5auQfkSbLBBNHu0UU6h/X5fpoZnRTY5L8ZJIgWwQaPSIMM6gPggq+bDEgBOSFK+TBJFlk+gbXJlJQT8hh1zNLf4H7lcSXsAEQcOzzznXZg8SEbUOfNCYfrPXbu/QUinOatwVS9gDYUauL9RVTrO8+rKS2FH0HZ4muftJNoU883DSeERr5y1nmyVO8z9UBcMz70NFvnpr23xsYbgO511SwMpRAxVPM18jsFXYJB4MvI2ojhjL94ztNi8OvBxhxlnbshIvsxXB+ocwniI0vyrqoDk94mYEoR4fG+Mn5CcvLCFXFi/+MRxv7qsxWd8AnPnKuGEcrQOcbIHP/vu12f1ke8MX8TdWu6sAKfFoT1glrWm9JUIUqax2sgYq+w05bUR8wcsyvWszzX+/b0x/Kp2fIiERw1S/S6s1GaJ4Xnhtrwx5vByUdkqFfqT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199018)(82960400001)(122000001)(38100700002)(55016003)(83380400001)(86362001)(66476007)(316002)(7416002)(8936002)(5660300002)(8676002)(4326008)(64756008)(41300700001)(6916009)(38070700005)(478600001)(7696005)(71200400001)(54906003)(2906002)(966005)(33656002)(66946007)(66556008)(66446008)(52536014)(9686003)(6506007)(76116006)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hIZm7FW2t/EiW5o5qk3sDoY2NNTrJhLuDKu/vodqDZ8fFO6T6euD15GP7S4I?=
 =?us-ascii?Q?jgEhzlYVDTYO+b4ioR1CSwN+U7s120W/DIO70iNO1jaesaxEk8R7QfIDbBzf?=
 =?us-ascii?Q?P7EoEsewVdxq3TCgaMzySjIfFb+tgU36r/ZCieV2++eD36ZJ9ZE1B3C6SlDZ?=
 =?us-ascii?Q?NcG64o0eMjetBeOM2zbcT5nruOd2dHWMzFW4qSfzjOYXo50+uMieo+cTIkjk?=
 =?us-ascii?Q?I19NCnXaTZ9Zg+6rMG+DtBmw/przokNyie3z/qSxREMtQnANhmQowHT1a161?=
 =?us-ascii?Q?OXOJLjA0EpySkffrRNVFB0W4RPAaLe7R9wjBQ9eyIJK9juSE+TF/d47LjAwU?=
 =?us-ascii?Q?Pwz/65WMwSrrdSNEI2XqmA22S11LrWsK9tiUOs1dbGd9MWS1me8n4bbba4yC?=
 =?us-ascii?Q?0KT7rP0dvcPDK4XcnmgWvs2bH5GT24XhDV0PnuRiIPLCfcFiDXP9x7aDWmQq?=
 =?us-ascii?Q?STFT6zC8JVOUCJIlsxmCiSWks4er9TivbhIbNeb0L4sn6ZVmsi1Ws/hxBBrU?=
 =?us-ascii?Q?zjY6SIlUDUJa2HBK/UmUtAp0iurtD/eoLnW5SSa4ckG5b2qJJfqh6ZUYzMWh?=
 =?us-ascii?Q?L3Wvs12PrOM9HMN19MSOF8zJN/sqyrpQhY2yCE9qLqyNG9f6jAZLZS+RROAv?=
 =?us-ascii?Q?PmdtBdJ7J2a+dn8j1W//S+t+Ifgd8Z9s/rZnBZzuqgIKAOseQa/6j4RaVRwD?=
 =?us-ascii?Q?og/NHWktQSDCHYs2Z3remYk5lVml4lXHSh7ovXI158VUqo8ZQEA7LRYpw6Ng?=
 =?us-ascii?Q?RrWPNzb6dektdnMQYXkaD3hvZ/Qe3CDABCQPLNNeEL5GMjrZq+EZo8rT6roM?=
 =?us-ascii?Q?2Rnxc0GsTAUTxLI5BKCKdpVsf6dCGVO/yUn6kANU4c5XkF9VmdzFTBFYDnP2?=
 =?us-ascii?Q?6Ev7KNTzuOVo2NGwtCB03HaaCK4uwQO79FVASspIouFOWD+QWSLsUgdbEFjn?=
 =?us-ascii?Q?Th2q/xx9wRTnS6FrPAPdL3qivUJbbNSKod0OFegPDvAXeRmxE70+JJ+9UYhk?=
 =?us-ascii?Q?STXR9Bpgc7s+HTYvWoBnoVChxTzWGZkpRUwnUXcPv1kamVllIXEuyVeKBIqh?=
 =?us-ascii?Q?s0+HtYR3mdkf2L5KuMrLFCfxzerCH5RnbznVi9LuwC8+V3VehlKY0AvlGvN2?=
 =?us-ascii?Q?Ti+IB/bV4nvvyzAu0QTCRmpK7NKAdR5FAgaevIkuATvNUf6TPWu0miqqq5TE?=
 =?us-ascii?Q?j+UzTz4NFC2IdNWFOKTGwwlwYuzd6zqEnNwW7WFATcCJhwSknNMCnOZrR1A3?=
 =?us-ascii?Q?UDhr48mXbG1CymyuCDAIoNiXtLB+Fp9AdrC0TdoLgTF3UaZKEGFA22LfwH4p?=
 =?us-ascii?Q?TyU9iugd1ptIp81QFpBH5YU9eAsq3tk4+N4iBILf0fCsfHnLhvKKp6pQH4eX?=
 =?us-ascii?Q?aSm6WLuaHkXgyHZHinvZ/HyGaXru9KZFna8nE4Cimng7ZFVFg1UoNZk4mBQ5?=
 =?us-ascii?Q?zyAczlmyQz9C4kged3lPfR6UGdnjXiEhC7nIe8zJTI0eHWw06w/RxoIatEHS?=
 =?us-ascii?Q?ry58UTRfNMn05NT+1aJ5TUaROPZ1JLBA7Db6p54XWVikqsaNSbflu3xbkFOl?=
 =?us-ascii?Q?wNYKxKJQKrfuu/k8fdbGEHefItgHakIY+sdnYU3z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe7615f-ae6d-498a-d137-08db163e33b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 08:07:41.4172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhkOC/pr5RCF/MTknOBqPhcITobGgFcmmvFttmDTSA61op5yHvkizZFjomJd6rVBNYHFUHfkeOHPdEMvgvh6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, February 24, 2023 8:58 AM
>=20
> On Wed, Feb 22, 2023 at 02:11:39AM +0000, Tian, Kevin wrote:
>=20
> > > > There was an attempt [1] to fix error unwind in iommu_attach_group(=
),
> by
> > > > temporarily set group->domain to NULL before calling set_domain().
> > > >
> > > > Jason, I wonder why this recovering cannot be done in
> > > > __iommu_group_set_domain() directly, e.g.:
> > > >
> > > > 	ret =3D __iommu_group_for_each_dev(group, new_domain,
> > > > 					  iommu_group_do_attach_device);
> > > > 	if (ret) {
> > > > 		__iommu_group_for_each_dev(group, group->domain,
> > > > 					  iommu_group_do_attach_device);
> > > > 		return ret;
> > > > 	}
> > > > 	group->domain =3D new_domain;
> > >
> > > We talked about this already, some times this is not the correct
> > > recovery case, eg if we are going to a blocking domain we need to dro=
p
> > > all references to the prior domain, not put them back.
> > >
> > > Failures are WARN_ON events not error recovery.
> > >
> >
> > OK, I remember that. Then here looks we also need temporarily
> > set group->domain to NULL before calling set_domain() to recover,
> > as [1] does.
>=20
> Sigh, this is too much.
>=20
> I made a series to clean up all the domain attach logic so the error
> handling is all in one place and all the same.
>=20
> What do you think?
>=20
> https://github.com/jgunthorpe/linux/commits/iommufd_hwpt
>=20

Yeah, that sounds a right cleanup at a glance.
