Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D269691645
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 02:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBJBf5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 20:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBJBf4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 20:35:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DFA25BBC;
        Thu,  9 Feb 2023 17:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675992955; x=1707528955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jb1DfpnO6YCo4e/Lnnzav5XXJGHi219UHoXtSQUh3Lo=;
  b=GXx/2Unj7gng0ysdJRL4mKO300gXJ8hWPXPKbIeEZh94hZGEdBghkNCs
   gQ3sFjMRuBS20wM/48vtPEJ9d2faHIHlqiaTZE7ub8SiyTioHkHLrus8a
   BnbzpeZ1QbYcP+grX1RgQM2ZYxCFkejGnr3SnoVwNf4xoeIS1zgpeSWU8
   rmrWJOvZ25gRIdodO2AQD67xfnpGcMahZFFbUKxec18RaC9WN9YskBQzm
   JAUdx9aHCYxYz3O0sNr/GT+zBYsR4Rig8awUXIpVGdECzMtnp1IcKfFUU
   C73v8O1NV299XEvVKwkg086dkLCXYxYizHuIo1OeSFsE+3pmB+OEvjOPy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="313950953"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="313950953"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 17:34:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667889796"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="667889796"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2023 17:34:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 17:34:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 17:34:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 17:34:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnG9zXqtnUl/yFL/7dd1iKfuIIl4p3hiEQQ/O0SwrNYP6ILw0LFf3VRVo3YsF+6FpFu05T5ttb8vIF0q8G5Q9KvQycL1Jrn0FPAUxkXFgNxhlzH1hBigYNJgv1N0fGeearWyw7Hbu5ZfdWwTWifNeQvw9TENrDaceexNZOGCTw8KRljVoN+1ixuc5Q/3xOVXlGYr7PvJojuaSstQgPvWBGXGcHXdA8J0i6ig28ZUhw7LuUorGs/HD8tMdltAVbeZT4oZv4HO9ko994ZVqq9jxL9qUiHEFmTYTsLARohkixgat/98pyu4LT4N05TQTpX6lo9/qnlHAM7UgGMQONYpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bm1UdDoAupLpE+5adHk9Nr46gbSrBUh7RSFPQzKJ6Go=;
 b=k9u/6c4snXrC5811VFLlfO2zU37jJiF+81a3cLikzS9u5WuUOWKNyTUEa/Ju3sbc5u0IwORRXifFrmDEsYjt00EfZVHzzUwIPfp9/9KhMLTK+QYtz2toG+/hpZDSMTV8+Z4crewDKibyKJL7jcnSlkENDps/FjaD8aM8rar1xx6TsdtRazvT2cOABaGljp/oP/8c2QZ7wATUSmSWHfYsGF0D/NwuH9TwEzmtIH40z8PGfl/RtJ8YnbP+hoZ3AIJcv1IHu1KWWfxe99A/fF7KCoLA22DjyFb64Lmx3IM2OnWlooj9imjbwHHRiQMTLCOazcfpQyCEMlw3tbJe8HeNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 01:34:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 01:34:43 +0000
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
Thread-Index: AQHZOzoL2+M6IjP2sU+QmVuzFLJejK7F7DaQgACwnICAAMxeQA==
Date:   Fri, 10 Feb 2023 01:34:43 +0000
Message-ID: <BN9PR11MB527642EA9C74FC095C4E272B8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276859C11057878722F30988CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Tzt0p+hDz0QMfH@nvidia.com>
In-Reply-To: <Y+Tzt0p+hDz0QMfH@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4719:EE_
x-ms-office365-filtering-correlation-id: 70aceff8-c42e-4011-b65a-08db0b06fc6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: apyKRXmmE+ksWcwPdIbNATFW4pf0ciMc61yNvLJ2fSChykTIkoLdMgU+nNafzguJV7Jp1DQMLN6h0bPZ3pRCOK10nk+VeZkqwmV7pdwT5rhI1NC75L93uvl4voDAChJQYoPsUzhQJck4tkkqzxQQJy7PVVoPRPnvEO2TmwWLLzvt3vVagmv7NmBaB2aOUofTJbPeTUKOuVrj/9Lxhk1xEyF8qa7giObVaZJtcvluKOgZMSnKLbCDY2i/kiU6fYuih08hRxadM+6p467bdP+mxdYU4mhgA4TEq8h2Jnj+8Yt0TMxCk4TpEijPXUZzhZZwdAA3mknfF98CA94BGDzXK4D7lw6AuYMGXjtAcSeyH/1rYmlcF8GlNikRKBmdrPvxQE7aEcxOG2nLTKSAC5VdqK9vC5lpwJUwQYYiHGRB0UzA5yEtR2cgjxwlUUb7RAOU1VR8i4gCcNhIwXhBrGHTF59c8jx/xu2YY9xNcskxWZP6xom1+jDpD70mwKloAcKoFGmS+DWl0K+snuInLdicsyhDrlLaIjqTuTmz8+KG/OCQXd5tpRQnTGKNONO+Sjw73p6eCa08LId48+B6RZXDFrTL96MDpDNmdClQ5HgZJqPhCq3gI6ku2gcCtt7hLZdR4nBiVmZ8NN9G6ZsQNErjY0WkOL9NdFDWlaBQUmxW3jcjiAkQ4lFcfcF3S0XHHVAI4xYAh8NHNWIyKGjOuXhmMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(38070700005)(5660300002)(55016003)(26005)(7416002)(86362001)(186003)(52536014)(8936002)(122000001)(38100700002)(9686003)(33656002)(6916009)(76116006)(54906003)(41300700001)(4326008)(66946007)(64756008)(316002)(66476007)(66446008)(66556008)(8676002)(6506007)(7696005)(478600001)(82960400001)(71200400001)(4744005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UtiLU6Vj0sGVuqlD5PwZQEt70j7ZIugjRPVOYLiibPqG0xqDs8Gv0DfA4Nfv?=
 =?us-ascii?Q?Ocakd+RNmeCpjI/Deonp4kK/MpnJdGjL8DfgKcLa7CH/9RKmdMrPhz4GHYr1?=
 =?us-ascii?Q?E9HXB3k9lqnYIdI9E3ZCEt0yj6Wiu56hDkLBSeiy+8li+lrzB595ZaNVuj7h?=
 =?us-ascii?Q?dmeMMZ65/opB+sXO2STo5oEAJgDCtsg/KOdlM0fxT9ZApUaJurCh7iB0WMRD?=
 =?us-ascii?Q?llSenT4nnShv2cm8PdeLC5+dmExqzKTkLvuwraiD+Rs10BqaWmxdrGyorVho?=
 =?us-ascii?Q?wxn1zJ5ahMisuTKtjjvRtuBmbf1Ia9BM8/OhMUe+RV2GeNFCiLTq6jBg/Eqz?=
 =?us-ascii?Q?+0XH4i/43my6I5+HCF+WllkP53drApUZlrOTPLuZonV0VosNIbEmGhuDt1qz?=
 =?us-ascii?Q?Rx961ZfWQa7JDEmmYIHJKOYbsbJWEy0q2ToKNkMBiuc7aMuxbNIYiCrqxeJq?=
 =?us-ascii?Q?hRKaTNiE2WhCjs0ZcFrNoxXIhqEVtTAOAHDEhX1pXZt3oXd20jfAIyAJSjr+?=
 =?us-ascii?Q?r9FaE6x3vgz/RLdNRXOJDi5/UDHLOEeW84Ou614uhluCNutzGN1EWRod1C9J?=
 =?us-ascii?Q?nXmGg1CXNVbF0fydy5mk08o1/pBEvh76kmE3lpt8EdmImnAVL36fvNvIRttm?=
 =?us-ascii?Q?mUDnD+tvA8HBLTx9Ri/l9mamXERS/jxAC9l+G0uFBL3NZizz+KDSNwGWz6eq?=
 =?us-ascii?Q?nxFPRibYKyUKGSks4SK8C1MmEeZIzAwOPFc65LKagkNmzbMddzndBMreyIK5?=
 =?us-ascii?Q?+BblY0Sh9Q8uR5NIVSS+VpSVi3e3a53MJcN61MBmNR8zlxtyX/OlDqkWOQ2p?=
 =?us-ascii?Q?lSiGg63HuP/MqcrmuUWy5shy5sKtBRnquOx1qZoyOxlpsRt9cL5iB94h4t1M?=
 =?us-ascii?Q?pHCj3fzrc3ah/y/jvVM4YTmBMkfZ8BzFXzgfQ/T0MAjcD5mzpcYVAJq1F8dk?=
 =?us-ascii?Q?en8+qxsEJ2BY7Scsjre7wgCkAYbilzUBH8WUEeEEIyUXOmxaJHehxlfwsGyU?=
 =?us-ascii?Q?aXQC5NQePbpw6ZnSXPr4/am5REaC2TkNU8KwBUHYnth24ReziAkIyOYerPC5?=
 =?us-ascii?Q?WzrHNI5ecfnJ60/0KF6NkTdW2qnqp5HrLutwGzVahNulBX+gL+TVe1SQkqG0?=
 =?us-ascii?Q?/oxooHmmH4Pbj451bZ8mE/T5WG/vCT4Y5Hq5rhUmkIDHoXWy4uLthXsGZxGP?=
 =?us-ascii?Q?f9pllg53VLU690vgPtLtkDiMIogbsaoPOchY1eqXKE4ncO6klgAg2y1oFyf8?=
 =?us-ascii?Q?4HN5ULKllEq2vMqYIdiiboSZI4p1oDOQLnZBtHOajjO8Ba8LQfdHYGS8JAuZ?=
 =?us-ascii?Q?prOf3xkayUoxdhaj8EsBrzz4+Bg8jjrHNzBVc8DfSh4XntoTSE+e6zKK7ph1?=
 =?us-ascii?Q?Zb0YBxtkKy5jGiSlCpfm7W+o/DyliSwL0tKIgeD/DeFPmGdFPgD2e/uUFp82?=
 =?us-ascii?Q?qM5VA+xELG0kmvwyii/KI1WS0pUfHVdxA5G4uKafS65LxDBlw+wl3lN9X+Nh?=
 =?us-ascii?Q?mDgVJdkqKcCvvXBd8m1mFaPEn/Q7ReKANzSmOYJ9HDa5qpu3DZ/ZlPt7Q7/W?=
 =?us-ascii?Q?Bm49TnS3hbeD01ltO3YIm0hjUMmWB2vrvw8VlVlX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70aceff8-c42e-4011-b65a-08db0b06fc6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 01:34:43.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1vWDEOuyNCC6VbBN6Gz/DPkR+xOtn9t9E/fnKCy4EfRrVM8BRdd+H5O7ZZ321Nn4+YWXzOIPMqZz9+4VtsNnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, February 9, 2023 9:23 PM
>=20
> On Thu, Feb 09, 2023 at 02:55:24AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, February 8, 2023 5:18 AM
> > >
> > > +int iommu_group_replace_domain(struct iommu_group *group,
> > > +			       struct iommu_domain *new_domain)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!new_domain)
> > > +		return -EINVAL;
> >
> > Is there value of allowing NULL new domain so this plays like
> > iommu_detach_group() then iommufd only needs call one
> > function in both attach/detach path?
>=20
> We've used NULL to mean the 'platform domain' in the iommu core code
> in a few places, I'd prefer to avoid overloading NULL.
>=20
> IMHO it doesn't help iommufd to substitute detach with replace.
>=20

OK
