Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2476629C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 05:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjG1Dpv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 23:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjG1Dpu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 23:45:50 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8479D2727;
        Thu, 27 Jul 2023 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690515946; x=1722051946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l8yquTVfZY+CsHICvful7/Pto0x3UxTswAjdv/zNu7w=;
  b=PHNFxKYtrUrZCA2j00ViuRSq02FMGkbqiQkpVDKjSRt5oTdotk5WQuAr
   sMh2Yttp2Muv3pmUhUBzn2iXlf0egBDju0ZQpHixZQZPB/4yuEHGptrZ1
   R95uW/1YKzPXJ2L2h4CnflQ1xUs4mUAvtKudqOHSPMYCrIs0kpQUYlaem
   pn68VCivFqeyJm+L5QsTjD+C4+SKeuT6fi3WBRyA4wIXDPQzooTCe0mNA
   t7cxAYRUvDpDRZFPX5SRrTy5DraYZjrbZuJHuqNiaP6V48nnHMugnzN/J
   9K+1u+qDwYt79Ell2h+UqMTaVXn8gWSvvmAXW3wAw5ejq9dMHyBdOnxrQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432308745"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="432308745"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 20:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="704375109"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="704375109"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2023 20:45:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 20:45:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 20:45:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 20:45:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 20:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7+K0hAsDtbt7dzA8cQ5250IKphi4ktc3o40sm5K/VtxkQsaEBwhqdWUCW3IEwC92bhTjzpbgIqgXBsFfJpEZ2q55cZx3tl5hovATGWSCAf0KNuy0vjHbCb+CHRcZFFPCA2D7YVP1E9D4UA1sgNo5DNv10lEO6bjBAx9QBCwqINotc94K0qtEQcXDPAWD91dZVb3wksN9varN5umpjFGf1+1YnDp52q6vO1+BI6JKR2rvBIaETGbcPEFP0cXnoZD8fdY/2ywjWph6KKSsQT3boIvCLUma+IIM9x0gzTv6vv8qQyd3CqXx01HZUhwMM19f5i+1D6qtIR4mUFSh1sSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8yquTVfZY+CsHICvful7/Pto0x3UxTswAjdv/zNu7w=;
 b=R6bPoz8zvhCaKt+fDzZ3Efrwd88ULZBqOYJjXnxD4xfT+sZ2kddeEdwMzSLdFr8hwN7M+vUVrbVEF8gbTNEgUqLmUuSsDnlfY7dG7CRKu8XU7Aj/VwRCVYeKGxruvXRC7+41mTdnoSnqJUC7aNm0ubpTH/Ae26O/lly0aqWZjMYXESpaZbBIgKkGxHQKJDPN7A+tNfmjK6ClP8YDqy1oxXtMuX7PBX6lnjqq6x9qWzcaAVCyNU48Wa3ttEsXtdJM3hflSpbNoTe2Uf5pH7nOJnCxw3d+zMg4JLswA39H9MXYR1VMFvqtyIeE2CV9tqMB2VUQngcUSFBqo3SunoPcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7186.namprd11.prod.outlook.com (2603:10b6:208:442::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 03:45:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 03:45:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Thread-Topic: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Thread-Index: AQHZvme4Wz9PfkBkx0y7nT6tapgWUK/MHpWAgABqOQCAAC5lgIAAOKCAgACX8oCAAHWfAIAAkFtw
Date:   Fri, 28 Jul 2023 03:45:39 +0000
Message-ID: <BN9PR11MB527691E9B421682C7B88AFD68C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com> <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
 <ZMGt/4CCCmUB85HX@nvidia.com> <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
 <ZMJc9elDILpHaKP6@nvidia.com> <ZMK/oN6EUdQnKd6i@Asurada-Nvidia>
In-Reply-To: <ZMK/oN6EUdQnKd6i@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7186:EE_
x-ms-office365-filtering-correlation-id: a1a423c2-f8af-41b0-712f-08db8f1d1c9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZ1bevtdPGJ4LcGY5LeOaIIYHS5phKiAFN5zJvujWcoGd8nZRr72ph/RtZs/5fjZAh4qXdXSCo8ynlt2BcdWWABXepfkNWlKequG5cccno2lB1fVtGqVuqvyM0MlmGee/Mg+h4isnUSs0FHb8an2RQsJyQNyIdShpH7OpX5/6yaZZLCKUy/MSDKSNbAVRL16b4f1Vqb65sePuu1ozb1uQDK1mE0h0/sqWovb4W47sGEmTZQqJ/qLr/kz0mLaYFQQWJkOfDrlM1YZ+YlNnCw3EFCaxPE1c5cT+QEWp+F8EwW7zszQu2BprvMciWEyC+WJarieQP/EpNWidVANkEQ1PRu2MQCandzCfGRDgwVaXnPd+LYx8GIZ4FF6xNMXQfICFUOcYeOhL+NPF0jxNAhgqrDEJ5AfKcBAWduk8U2oxOt0ky3AzXHsG7KXF8+IE6nuOdhSpy1A8kE3fFieTraUL3zOGw9uumzuKjuy6U9EQ3qqJxMGAmewJ95Gs0ItuTacj8q6Q7FIS18JwuFrGnHkGTDftYZBqoAWeFIB4U0p8VWmYyP73nB+uzpQZkTv2R+J1i2uXC+5EiyKTewVQR02S88TGQN0vFyZBbxX69uIBYEdhjaBa6qWBldZ9fG9zb6w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(26005)(41300700001)(316002)(8676002)(4326008)(8936002)(6506007)(33656002)(110136005)(54906003)(122000001)(478600001)(82960400001)(66476007)(64756008)(66946007)(76116006)(66446008)(9686003)(66556008)(55016003)(71200400001)(7696005)(2906002)(38100700002)(38070700005)(83380400001)(86362001)(186003)(7416002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l4riroAfQqBiPoGcWflk61IfKOK4V29sqljtcP4OFz/C6Rn7/9POOvtShTMD?=
 =?us-ascii?Q?UvbI6nqLFGlExLwk9MRFbXtgSHqUfnXhyFzZU9/mqpwERVbcWgMcEH1XFwQd?=
 =?us-ascii?Q?9WuYokeyLzinMElhka0RP3DKLLZtWQIrprIiNtIV0EgA/GLKQ5wLNofXddbY?=
 =?us-ascii?Q?VihClMdw6PEnhjgVWhF4Nc1omWaeph8gT/yQ519UrWs0kIFMRA5EjcFBsJbR?=
 =?us-ascii?Q?R6fwt39KCQgExEaiLgOOEt1VCLUpArGGJnUmwELyW9mu0EthX5iOA2ySZuEG?=
 =?us-ascii?Q?JtX1dbr2i/CatmFXBTTOV7a6peT8dA1K4cGvnnxItigsRZYX7v+vq5pYgMnn?=
 =?us-ascii?Q?2CZ8SjnQUJxUiE5Ssyzp1ReYGjHLUI7UQdnkOr4VcEZRVsT1MpKFQY5bz1tX?=
 =?us-ascii?Q?qC8ShOdsnK4Opa8H4WjbZ1672Qnyq0O99XEzebXoAd/TBNXr3xc1MSfueCAe?=
 =?us-ascii?Q?O5zIR6zq8BBk5Ix0yPYrFdUlt4Qpo7IdRStOILZ3iSlJ7dUm2RMk30q+ZLV8?=
 =?us-ascii?Q?gXDOrxSLhI/uTf6/yCyJ77ly4osnO7zPlK3RKw/LJNcDkNObhUNFJlCkULCd?=
 =?us-ascii?Q?9l/HqeBiQsYdLwMNCEF5HfxqkQokNKF6nnI7pB8LirDwqwoFIKFbMAxbQYJC?=
 =?us-ascii?Q?x+9nUbJ+z7s3CI/s9kQZ9LBLfQV60FioXcpZJIKNv9XreIz4sLyyFhJtVa0w?=
 =?us-ascii?Q?/EGkfSTqi6saPELTVQPAV2VAg5+aZpel0BtwetTUhN2qRVx2Z/556wRRcxu+?=
 =?us-ascii?Q?aE3dMBYSqeJe4obPS72k5fwf0YL6JZAo40LtaaJmlr/x4hkOLpzdLJp64Gj6?=
 =?us-ascii?Q?HkjXKOW6wd+3OepAOfyZFwLe0qA8kMO0yTmP3xUQvQA375jlemXtINc4P4Nz?=
 =?us-ascii?Q?8GHqgn9idB7r1UtXW7NvOZkPhYP0NicPg60R3igDWcrtViZeGBc/Mw35qU74?=
 =?us-ascii?Q?f9U/YiSmgLKRtjHeJ7/fZpm4PMM7EnlqIRbc3i8fGlAcA3Xz8bVThB7AwyjE?=
 =?us-ascii?Q?NzArTa0xjIyIM/4tCmqI1MOUHs2b3yV9P9Ll0xHBI9iEtWxnY+Ga6v+UMFnV?=
 =?us-ascii?Q?HcYfpbh6grzZUOOdO5qZ0VXxMqiS68rcYmpZtLuMNZngH39M9qWHZFg64X2Q?=
 =?us-ascii?Q?pCqT4wDNLmXs7HSwr+QmCGEwYtwC4ikfsBGMwqaUq5KW7j8J32qSFnS7rb8J?=
 =?us-ascii?Q?5zKgkcHCgKjN2ogpgTx9ghARUv6hSrYHQ/EfyqgdrWblXhd1XHZMRqEsfLRG?=
 =?us-ascii?Q?PYPP6Wi+cRvSsSNXJR6UAAh0788vOm6YzWPIiLHJU8dgXRzheqz9QTolQznC?=
 =?us-ascii?Q?E8Vroa63YAb7Ql6FszNpG0/FlKjZ8nwfwnlChkGBL5jwbLU98oATyse33GdZ?=
 =?us-ascii?Q?+KkHPp87jhpAHW00FPyjndtjxIvaQi/lifgV66ZUYvRQNippGTcZiOWsc0um?=
 =?us-ascii?Q?C/gEKqYsT+6xDfeR1HSW9YJrj78JIbsaogivnYWl6w2s5P4AWKPsLUXhfMCR?=
 =?us-ascii?Q?ID8V9lrbxfdo0wadsRoovlyd+mkWILvOaOfHeNYdCZutD/svz/+00O5XTGiL?=
 =?us-ascii?Q?UZvucIO70YKzjXVpcac3144G2VTlYUDQZjAlZiAo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a423c2-f8af-41b0-712f-08db8f1d1c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 03:45:39.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atAq0hAbwxUgQnFD42U8uVtyNIZ/ObnK+Ud9LRE9YB4OYGNsJ1+qGl17ynFsgzRKQQXipBKuS570OHw7CDcvvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7186
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, July 28, 2023 3:04 AM
>=20
> On Thu, Jul 27, 2023 at 09:03:01AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 26, 2023 at 07:59:11PM -0700, Nicolin Chen wrote:
> >
> > > I just realized that either my v8 or your version calls unmap()
> > > first at the entire cur_ioas. So, there seems to be no point in
> > > doing that fallback re-add routine since the cur_ioas isn't the
> > > same, which I don't feel quite right...
> >
> > The point is to restore the access back to how it should be on failure
> > so future use of the accesss still does the right thing.
> >
> > We already have built into this a certain non-atomicity for mdevs,
> > they can see a pin failure during replace if they race an access
> > during this unmap window. This is similar to the real HW iommu's
> > without atomic replace.
>=20
> I was concerned about, after the replace, mdev losing all the
> mappings due to the unmap() call, which means the fallback is
> not really a status quo. Do you mean that they could pin those
> lost mappings back?

None of mdev drivers does that.

but we need think about the actual usage. I don't think the user
can request ioas change w/o actually reconfiguring the mdev
device. Presumably the latter could lead to reconstructure of pinned
pages.

so in code-level as Jason said we just need ensure the access is
back to an usable state.
