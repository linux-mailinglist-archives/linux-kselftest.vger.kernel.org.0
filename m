Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6436A7C7E
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCBIYA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCBIX7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:23:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6938EC46;
        Thu,  2 Mar 2023 00:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677745437; x=1709281437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XBEe6VJ0eXE79xguP9kE1Uh9GXis4Z6rfRTD4fhUgic=;
  b=SNcqwAFEj9EHnNxE/3x2XeV50pIWDo9/6mMUnWGzgPcfc2lcl0I2o1RA
   W2ajyz+hHLCZt40VCb7sEjbn0XXaVPjjPo4yxsciLk6NwNc4olCNTSlEq
   Ruo7XneHBX8+7sh6JC0AKaZ3uK5Fyf9PnWWgTWp8rX3QfuX3DvAE/Em2R
   cUqFeMeIy2NCmsLnuXhpqqZ4W9PDnLj3H5iBz7utauYlQu2IexnbUv88n
   iuvJYrDrjvVtWeB6MhsmdqhDma5pkWHlYEJCp7Y3/yvqHks14Eq3AUQeT
   5T2xub0KRfIN3vJs/CIUNyawUvx4o2TAA2Fps1e/jmvJfm9i/+z9EdVMr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="334682854"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="334682854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="668154037"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="668154037"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2023 00:23:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:23:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:23:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:23:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yyc5VbV4lmUhAgh/n94PD+KoSnYvIGEu9qY/jFaYHR3IvS/J64hWSx56Il82Mr9sgIgsMejl3/yT78MJ6XhcTWdF1x6kKQb7V1mYaGyANIUqInpjDs4r/REj97HTC1oez3/YWd0y4Zhqbd0UFLdxx0OZtQyp2sB6MpMPy/WKVATFyIJUW+oezCTXlDXsubkdVg7Ca+6cvenIQ2Q5y1l6F/rSJ5eoema8ERaY94C423yLx4+g7540mAaE39mGBxR9zynTHxnot7gVictNJze3q3KuomHxidR/em96vbZ5brEDlfapnH5xxFNwIwKQjhHP0xrl3QJK4d7y0iQtgWCf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH73gZKW2dGk4c3GqMLc88IS1kOdeSo+2fCuY8gQjOA=;
 b=mNwCtCSI2YhoZk36veK1YWXKKJ43yPEdvgxwo32k7+Pe0rFl8N1uHSx0/ejoiRrJT4EdNwApKWeVvzVQsgZ6JuNMfltuZ7JmQbH1v5iMtWERSvd+3Vq1b1/Hi7r/Did2mdWdqEIy/OpOo3oT8OtTA6ZujUCmbolnedRriHICHA4K0vqIjfmbNTQd3jXRKYAeIHOdO1fLz4BD4ODcXEi5zZ0kf/QonFRpnPJwZrp1iDjnptmAYlkKLyLfoy9VJL3hLEKquXJoFUfm3NR9eRbAsiEFj24OVYITZKGfkMmRhKAB+8ruGV/DSPEbtmW+t0RnrcsNjmxLWIdOIRlccWwO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 08:23:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:23:55 +0000
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
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v3 4/5] iommufd: Add replace support in
 iommufd_access_set_ioas()
Thread-Topic: [PATCH v3 4/5] iommufd: Add replace support in
 iommufd_access_set_ioas()
Thread-Index: AQHZSLvf/aRWef10FECmmVqOVc7wia7nLvaw
Date:   Thu, 2 Mar 2023 08:23:54 +0000
Message-ID: <BN9PR11MB527636AE29756D8A188912998CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1677288789.git.nicolinc@nvidia.com>
 <a104b334d3cc148620ac1f2aa465fc14be556e63.1677288789.git.nicolinc@nvidia.com>
In-Reply-To: <a104b334d3cc148620ac1f2aa465fc14be556e63.1677288789.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7119:EE_
x-ms-office365-filtering-correlation-id: 7a8226e4-8143-4102-7bb0-08db1af77676
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 703kUY2EobAPvJQ3xYJmJ1lGw+vFvRD3Y7wHmlw2FKQpZuxxMGp10ktZpo7/r5a+RGy7D6NZkuDLNtko4SVdyZLWU4/5vgFVxb24wBuCp9jofzV2FL8vJvYcp1B7OKIgSU2UWlS8z0wGVAhEGRIBYINn52SByKTPrK0TCesvBAB/xwTgCJk4jN579N6KZf3JQBO+4NyGdcRZITJ794VO0ytHdKmh6+L/ZKZSWFVl+/sPDWuLvSp9umKrc/OZBIpJZi77ozlgw4ufhzlDimdBrXr0XUPOwVjcC5FhXhHPv/n/A+IyswnJWz+3lzNZoO9jpZXps5xvDLvF9WoZk6FWkO7XSktcHP3oB3y+GxgXS/V3vmMdIX9EesMjWnMIsYFrDpuVOvyiBmj6oXm9YEHNTrq22A91CmmOWfqYQgQ25p9d7dlQDD0fWnlOA8LZlU7/uvwLjMqMe9R5yH1U0lL4E5kyOKMQPdRvo+ya9nnQaTAKz/BGq53bfs91Z+bwab4SU2DrQZSD0kmruH7xupTXui/sM/KFJbals5JP3djRUTZRPSf0xrXLJrQmD4qUe2XrA04rVaHByPh6DXSsKc9AglHMO55QJ68xE2qOxUqDpZIUyl2G+Zo0gcJXBbWjRRjdsNKjvfVo1X4UfHHg7y8jp1vfSNleflzQ2Sg0rfM6ffxjun3OllM1aIKlDO61HTVaebCUC9g3kmbd5wOzSSWtvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199018)(6506007)(9686003)(26005)(186003)(54906003)(41300700001)(110136005)(316002)(4326008)(66476007)(66556008)(66446008)(64756008)(7696005)(2906002)(8676002)(76116006)(4744005)(5660300002)(52536014)(478600001)(7416002)(8936002)(82960400001)(38100700002)(122000001)(71200400001)(55016003)(33656002)(38070700005)(66946007)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3SSrHeSCfIk81IKqPjA6P/xyifDoICXT2YgyrHWK2jSlUmK7qskaY65ZrOp5?=
 =?us-ascii?Q?juVgKAdwnLiGYqFAv1fxwqCFU9celKxuGCExsVhaYq3ZvwvmAwzgh+GfWGO+?=
 =?us-ascii?Q?fC1qkPenEEX0OJ8l6rxVIVerD0teLa7v+28LpzvwI+hvgCGWTDqs+aoNIrLp?=
 =?us-ascii?Q?l0QN6n/iXDhHxi9sAP3h5kzF0SyNwgmVqoLfz3H2ed4dYJcTSbQk//5+LhNd?=
 =?us-ascii?Q?ViJZvXgxBr9lMH7echUN3tHlFzsM711Qx7N1r5tmHTm/i7u1ITEY/5wNgHGu?=
 =?us-ascii?Q?bS5ED9fUu6ofkJLSyIF0GHLklgmc3CiBCth+s16t9qBX7y1VbfgKpGT8Gmfy?=
 =?us-ascii?Q?kBU00oWR/ZWMOuHA/jbUEPfYYvz8lZALihDrcDoa+GtbEB9azWgdkGqPRckh?=
 =?us-ascii?Q?crUADV36yvu5x88bfkusQzi0Zt8zTFyyWRvx+o2MEJaynS42RC5ecZi1hCA4?=
 =?us-ascii?Q?owCN1+Q3Y2jvv9nH1ACDWFKmKDlS7bz4tXneAkw6AeUlXemeZJxYZImV84hb?=
 =?us-ascii?Q?FKuOg7VbKK7hqoiyg0ZtaPxUmVU0VvaYhzqUQlXS4ksPwfswCMxcAR6I9oec?=
 =?us-ascii?Q?Xsm248dmnBAZg3B0UGTuMluysZQwfPuEZLGdVm6fgM2J1TSA4NkrYDsaYPCH?=
 =?us-ascii?Q?4f8HWffJLDFi9C6Ky1FEjAGL6vyezzT7kkTO1u4RCoiDJa7fqDQYmoPi9fzw?=
 =?us-ascii?Q?ggLN3L1snAYfHot0oHwCTGGqwUIXAeSo3Usd6mj+heiP3DbBM+p+a5SuFH/3?=
 =?us-ascii?Q?qMLUszHHL7mYPxxzIUhfx3LNiMSxi699fAoW302TUqDyJEpuhL+bdsO/lvkB?=
 =?us-ascii?Q?O2UXf2kpf233It59iTAuGSzym/893LMwLQuSd3QffgcBgIpbFMEoQin6OWl+?=
 =?us-ascii?Q?ANJAlRPG/Ajzqfpa+RNH4FuEacFNsHpVBbQN0jaOOtBypWTwhoQ9e5XqejVX?=
 =?us-ascii?Q?pUj6x+QuACp016BwXlWeJ5YraGqqgraLm2XXWLHIPScGAdrWIqgSxPOIzEFR?=
 =?us-ascii?Q?cX2BVtVUmG2lhzZucf/LrlNcaVTKdrQNTj51LnyyHAFhQBIPTV8Va+ZbFWgC?=
 =?us-ascii?Q?lq0lh4tuXoCMzFyvcDUa1KJfvljw8Ue4CJ8agdoF/JGAV3kz518xo7uhuqdI?=
 =?us-ascii?Q?QldQ0b/7+lcHaUtO4hO6xgB6HBMizMYwE9OeDKjP1WX3mdTUBrzGUVnNOKS9?=
 =?us-ascii?Q?pm717a9+2dznSzApRBM8w96izimvBOqPdclwcmiRTuZsgrzFvSUQun3I3Wxa?=
 =?us-ascii?Q?Q9nCSQgScjAnkGP/G0NG3nA4WT1F+2TfzQOTJbTEE1ZDSUO7tq3G95LhBiTs?=
 =?us-ascii?Q?HZObU4ODZ4/L/vrVfXmN1PekgnkbA1Nmbtp4Zw228N8/Fxra42tHs/GEHlIw?=
 =?us-ascii?Q?JdemF1T1Ssy38Yr4sLs73sqKRx/ozIR8bZU0K74fvDIfSvQep0MCZI3gBbnw?=
 =?us-ascii?Q?yQAXLCsqTLX9kKoOsgZkexG84C5gXLv+7p+dJyPOo3LOspfO7O7YE41m/tXH?=
 =?us-ascii?Q?npqh+M8JmMmLruv89UuY5YTf4ag+z7fBIbkG6qjvBrp3+qi/1KjUzW/J2/Qb?=
 =?us-ascii?Q?MxQAi/wRkn+wevhiogKpDOpol33I8ruvW7msSm/o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8226e4-8143-4102-7bb0-08db1af77676
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:23:54.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnk5iCFFDP0aUJrmS+k218sYXRrxx48S9BIV/lc6qxRrZJEMekfE5tl3Agzx3IBQHAcq16gog7KTHKL6bmkKJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
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
> Sent: Saturday, February 25, 2023 9:52 AM
>=20
> +	/*
> +	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
> +	 * iommufd_access_unpin_pages() can continue using access-
> >ioas_unpin.
> +	 */
> +	access->ioas =3D NULL;
> +
> +	mutex_unlock(&access->ioas_lock);
> +	access->ops->unmap(access->data, 0, ULONG_MAX);
> +	mutex_lock(&access->ioas_lock);

This should check whether @unmap is valid.
