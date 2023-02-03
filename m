Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4453D689236
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 09:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBCI1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 03:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjBCI0u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 03:26:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5499233D1;
        Fri,  3 Feb 2023 00:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675412808; x=1706948808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CMyHdPXX5PtWy3MOZtvoB8YWiT6NjXMDnRrUovdeaDE=;
  b=Nam1kjOEy3UaIEHv3hKokvZT8w1L6+yBDXKxZlThA3tT+mxmIh60gbmx
   OHfNFtCN9tyaObwY635O8gHsZvuhideWE+gXEJuKRpzc6Z3vZrj+cfec3
   iJTeLWWhnwGnVpSvbcfQ7CINBbp9Facnr2EdoS3i/93L/HKlFg1Pxq3Zb
   uFgirV5fLy8F51L6raJCxBAbvvqq85m6tiMpVGn0Q0dtltEJSXfKpCURM
   +QEFNW7A5qeF7OCkVlJ+jknULZIGgp8POFZThrQUywnkoPssF2nPWJgQP
   SP/XGaTxpMqwMRzc2tgmm7LmYzoSaCVV9QL3nLxYX3wlQrIqVIm1v8+mm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="391088707"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="391088707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 00:26:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="615626280"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="615626280"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 03 Feb 2023 00:26:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 00:26:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 00:26:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 00:26:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI0nb8Uli9Uh4fTQuPs2aeHE7IEN5eZIUb9r7JQOAEzV3zTRy3WIvndPTrN1xWzUVYheqRPMdD4Wlb7irUhOVG47JG1AWZT97WDVDzcej+30BXPIgWeHIRgTjsuk6X1hkicnI8EMTDwKsPR0T/C8gBv7GyPUgWoHGBALdnkFbQKv8eQfI4txV27aTxb6d67CW8cdTIKtn+dIGk371CA+EMr2Oy0hTKg6VMYzcZAYYphg/2+lboXLQ0PrSVV8HGADOH+b4n3rnG8ffHxvrCftLuVzxc8pBWyCwtIkkYhGFMLEqQmJ8Wuz5lFpowCneVqyE1WAEFSZSmPPHB0Xj2jtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfRsXrFI0gLgaEhN7xd23Ckhhe07raPURp9DgbNiugo=;
 b=lQwoxSZ6RpJsrnNdiiFEdVr12mPBg7v7TvYs1OClfym95v0Oqt0K0wcKUjEUicRcLH7lLU6RkZInWjLCZSFOOgMAkBizc7OUWyQgzrAeDh9WxjL+zuhVnl/TEdF352DF+q9XZJbvSsrsaMlZT5Zi9hmCOPNOT2/hJPuN80X+Yn/FXQ74frkTn87xYIiiNce48Eg4+MuXdT23WP+u+VlmBdGYVKobipW0gDjan4Ogm1zn/BIDAySSIlT7CH7G58nCPEJgajUD9nLoeETWtSelb4foj47LH+dZX80k57WI5sBjg57elCbgiG9DSMciBPWElVfz9gr7b9DpHWAY5I1JMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7337.namprd11.prod.outlook.com (2603:10b6:930:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Fri, 3 Feb
 2023 08:26:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 08:26:45 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZNtTMfIuYSgtAgESqEIXUquWnsq684BXw
Date:   Fri, 3 Feb 2023 08:26:44 +0000
Message-ID: <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
In-Reply-To: <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7337:EE_
x-ms-office365-filtering-correlation-id: ac23d1a3-f111-4a51-00f2-08db05c062b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JROITvFdAYbYRj8SipZz9pbMOBRPhLVBUo2mGI4GVAz0z/L7lEqFQTAbbdHy90n3Gcwdq3jBckBczQJxXs5e4nvD9tX0cp2Je5qCs75NgQlPXF3YUDeeChy0o5Z72EqoRLaL1+SWNlRwJcUj/jsxmveoTJrCbbz6itlNBx1SoLldJy/GR4XWEUPaJVNjtwoQCFrErQE6ln5x6Ycfw/48EcaJI9uJVNgXwM/uPRulLhhXGlLg/Gg8GcUqYv1cudYWr3TPE75j+FTUmFjgm3tjB19P82xkpymeWvvkA0LwEVRf97FshHRELAdl2KoSQMwk7NK81TDl65jM/sHQn53C6gmsYTyiSyN6XTBzq8qSGCxChyKMZ1Nko+orTYaLW3jg9b5OhyH7dKyesACcPDibQt8py1EqlyNi/GPFCTihEm3+3gvt2H6cbUyq/G2fSfEqTfo9Q8JsLFh5JhPRfnQ6AHcpDPWrv9gFUJNVKa/U6nk0h26PByfGy5EruX4Fkwf60r9V5B8S53rINLT7ieN+/kt8zYX96BVZw38JVJhmcCQz8I/HKAPNR1WICZpL23F8qgV8XDr/3y9p6NmJ4sXnNs7zB7vAxXyMuDxTUGxvBfVJDLSvvKGxChWKNmWFlPLOZxf9njmLMUNkI7IWqAA8jbK66gNJuQH2F2u8UU5iuBCPyBvVA38k6JvL9ZyO2UyzWITxc58P6cWUyw9M1rLsKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199018)(110136005)(66899018)(83380400001)(54906003)(2906002)(316002)(86362001)(478600001)(38100700002)(9686003)(55016003)(82960400001)(41300700001)(7416002)(8936002)(26005)(66476007)(52536014)(186003)(38070700005)(76116006)(71200400001)(64756008)(8676002)(66946007)(5660300002)(6506007)(66556008)(66446008)(7696005)(4326008)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RQX3kxSS+za4PcTX2acNHVlNd6Ay5dAjuDsfzR85B11X0CB6ySBVDWZk1Y13?=
 =?us-ascii?Q?SrEbBfDd7LZHgdVcRWKsZMTi+Q5JiypOIcH3Ji48LOoqqYZCaBW9BnGqIXjR?=
 =?us-ascii?Q?qzEakxEKbAXuSuTWNRXvDMAYw6sADk1IHZAsetBJIjAsWR4y+lbj4VDOwF76?=
 =?us-ascii?Q?AIYppMl1u9XvLVjwxVUN5edZLMrFRtuUuSivnGm3NPu7ijMmN/ytl+PXEyrA?=
 =?us-ascii?Q?0kfRNXl/oG8VvN1tsmrRmo0HwcdvTEmng2y4RfZSNGCVcCC6sVPDSLcs1yDW?=
 =?us-ascii?Q?mFr+2/oknEjUKxlx3WPxqgTk3Dm056wYezgU3FTC5wkS6l3rH01PuhxyMh5M?=
 =?us-ascii?Q?A7DRjw7HXfxIK4X2ltuoE3oHh+GU7itYbBn2PlxiUK9ZIGCZ6hfbaYVfKdOy?=
 =?us-ascii?Q?QqXJkH+26u4qMvg6QrxV5YQCwWS/1UQRZqgAClUySCqe9KQm2k6ksvshWvy3?=
 =?us-ascii?Q?hh094dbjEz5NvQkzHXg07EERITCrpDttJLL2SEPf5knMRWy/FrZSCBII3DOm?=
 =?us-ascii?Q?rs2nHwMja+8ZGTiitW46p+ljo9nN4hG/z7yXN1aNe4P8v5fPfD6ffP0/Pnps?=
 =?us-ascii?Q?gsPWTO0wARyrQN22RLb3LuOFgQcLI66JDA9nuwdq5UWQM/t8YGGPL3tvmBbs?=
 =?us-ascii?Q?Lm2k6O01+1HNPqXDGZvtwsYwe4nfP41knK66z8wQ2qam27O1L2aE9m0dHsev?=
 =?us-ascii?Q?8Aazhi9GZxVqlUaOXXSoiZfAzzeijaJ320J7Cb8nxkg9UjZcaNcVMF6R7U+C?=
 =?us-ascii?Q?UfDTRLe3v+ftHjn813DJ2UKMGI7XJfqya+gPqdamkvgsvAxQI3TKutIbBRir?=
 =?us-ascii?Q?bQqb55bmgQtf61WLQAi8q/HNJ4ceP1CV+KfhZVmsWl6KyMTM/J7qSFIP2rjt?=
 =?us-ascii?Q?nR7naXdA0UXZCULq2tNu9o4k2mA+Iib71U0jOS7olpzan1w7K8yS/Va/pzGX?=
 =?us-ascii?Q?Eb/HGkprMC4wmFwlhWnmj6WwMa5dKJh4FlJ0d5WWPN4LI1i8CWS1Wb90rQ52?=
 =?us-ascii?Q?2D3eeoMesQ9qNtj98Mr8Icomk8993EdEoU77sMgWO4O4rnY1Bmqzqd7s/0sC?=
 =?us-ascii?Q?BVuPKwprihmB6iO916hnR/M+Cdur3xGFMelDGvJn1mpYFHMC4BO6lMYUHjuR?=
 =?us-ascii?Q?dY+qbduR3ahl67T3VhljtqqAdWexV/ds/AcFF479hS3XpJIqu4xvdOqOxSkt?=
 =?us-ascii?Q?AGOskRQSV0O1AcN57cb7dQ3rmVoU1iX3r2MaPXX+KNmGBQvXQebjsSmornad?=
 =?us-ascii?Q?BhOif1S9LcB1ZqZuLO0Dao+gsOVqfyTYa3tGPOSt1PpuNXTLwc4ZJ0GXMase?=
 =?us-ascii?Q?6Zwef9HTYnf5pZwfI0i7ESH7NolrmQ4BHFrQDB2pkXtA1Rw7OzunqmMif9NG?=
 =?us-ascii?Q?UF4IJeD7PT4aZfRCHb5XNVP3ZZ1YNNFOX+JPsylMAwdkT3VdK9R5t2Tjg7GA?=
 =?us-ascii?Q?meb4C2y+E1O/PnRLYnKGOAs+Mgo/NLysDOaE1dzYUUBqG5DJZla9EmtU70FB?=
 =?us-ascii?Q?g1xcHX1ThW0WNl1Mahvpqa3pzhIxhP/rYyYQ0jw4WGtGFZuD3MD6lVcsfxBR?=
 =?us-ascii?Q?nIjFdMoy/EgHimcCb4RqJZZsYFem9wBPNzF95QgD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac23d1a3-f111-4a51-00f2-08db05c062b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 08:26:45.0255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Es8QZqkG8Iqa92AXMmx8skmAlO16zo30sESzNZDxU7U4LTrTi3nYgb/87n5THK2d1Dae4Oib7dteXA2BQrgrlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7337
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
> Sent: Thursday, February 2, 2023 3:05 PM
>=20
> All drivers are already required to support changing between active
> UNMANAGED domains when using their attach_dev ops.

All drivers which don't have *broken* UNMANAGED domain?

>=20
> +/**
> + * iommu_group_replace_domain - replace the domain that a group is
> attached to
> + * @new_domain: new IOMMU domain to replace with
> + * @group: IOMMU group that will be attached to the new domain
> + *
> + * This API allows the group to switch domains without being forced to g=
o to
> + * the blocking domain in-between.
> + *
> + * If the attached domain is a core domain (e.g. a default_domain), it w=
ill act
> + * just like the iommu_attach_group().

I think you meant "the currently-attached domain", which implies a
'detached' state as you replied to Baolu.

> + */
> +int iommu_group_replace_domain(struct iommu_group *group,
> +			       struct iommu_domain *new_domain)

what actual value does 'replace' give us? It's just a wrapper of
__iommu_group_set_domain() then calling it set_domain is
probably clearer. You can clarify the 'replace' behavior in the
comment.

> +{
> +	int ret;
> +
> +	if (!new_domain)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	ret =3D __iommu_group_set_domain(group, new_domain);
> +	if (ret) {
> +		if (__iommu_group_set_domain(group, group->domain))
> +			__iommu_group_set_core_domain(group);
> +	}

Can you elaborate the error handling here? Ideally if
__iommu_group_set_domain() fails then group->domain shouldn't
be changed. Why do we need further housekeeping here?

