Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4281568E706
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 05:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBHE0H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 23:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHE0F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 23:26:05 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD30830EB3;
        Tue,  7 Feb 2023 20:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675830363; x=1707366363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5j6yrf18OvFs/g2OXumc1kp/h1pDxURiDKoEyKVvGwg=;
  b=BoflH2HkHW5b/i9vQ9pqy1rappG9GszyxuedM59PDOdCL2bV7NSZc233
   pov8VVA+R3kvzVgXsEVKCkeMQziMGzke2K3k12A+6rLpR3mX6G2HkgNL/
   8m0iMwvcNzXmNkNM+beiJNcdcDEgRlExf7GqeyAkJP4QH8HEC7M00Shdz
   OIDNJCCE9Ky41LYvtJBSwjdZb9FgW/SdxQLGhuR38XSZAj9oGeebsLrVQ
   Ph/Ub/tH5BCpeij34cW156NBuOtpDhlhkU0K/dQIavkdiY5imQFmw8P9q
   xV9wGK6W9LfczSg277NdfTD9Mm0OV9CHV+KzEQloC2qfloEysavjL0jiA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328360478"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="328360478"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 20:26:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735792252"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="735792252"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2023 20:26:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 20:26:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 20:26:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 20:26:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 20:26:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLRoUhWLVvGbEnEt4A7kVumOGOFZGXXel18BCk3Q6dbJcjYBEFcN/eQlQOk+wxUxmV58zaRPws625644WT+m+N7uBs2VOG09qXg/HSWLUw3JQGgQRYePjLMyR8rN/g6dCMisSP0lD/CZTSpiLPsjGubi0kEect/yBH7l9g07aBgdZAqZ/T1shtzXAF1W7IuA2yxcMYhGikDU69TR/QkXoDUpY2ShxtpIJjUkbHNV4Y4v5+KkYmy1AsK5desIRqcc6OyiQBYAksolPBUQCmoCqqJVj/z0N8dZ3nCb3nN5mvN+JaSojD+TDjfHPeOJaNx82P7EPtbbpdErXjv1svROLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j6yrf18OvFs/g2OXumc1kp/h1pDxURiDKoEyKVvGwg=;
 b=Uvzq7jbWYkhlknA2sreqYTA/sXsBuyADflgeXshJfah09cz4b27Bjl1DFqkDM61/34KHeILd2i8uxdwk4UB5yodeOq7M9tyJrED+/ONHY+JBZtlrvkkRUXYqwUWuNShI2/EeemfBGFsPJtmbtG9giNPzuFdJ01TWdb7LwASJ+xFtiFdkY6hePFEg+9zWc1Vo5viWyRuJS/9+iix9I2sPQexaUkhUe2jA3WaOkI8e19tYK4Q3Qyb79N02LcOBg+bnYluQonbrESJExW8MyDMBgyWYfZzxANxTuWlBQ0SxV8yi6rXenHqsS5i5n+bd+UelS3tFg0c0/i/rzFB3C1LY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 04:25:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 04:25:59 +0000
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
Subject: RE: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZNtTMfIuYSgtAgESqEIXUquWnsq684BXwgABzjwCABCqQ8IAAcQqAgAC4POCAAMiWgIABDJdQ
Date:   Wed, 8 Feb 2023 04:25:58 +0000
Message-ID: <BN9PR11MB5276CD7FAA1BF85CD8F94C908CD89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90iOAmnBtqQtmiA@ziepe.ca>
 <BN9PR11MB527689447DD190FECE4FDA158CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+D/vWwRLD27slQz@nvidia.com>
 <BN9PR11MB52769E24B07CA7296D8BEAF28CDB9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+JCjazMAMzNrc+e@nvidia.com>
In-Reply-To: <Y+JCjazMAMzNrc+e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5275:EE_
x-ms-office365-filtering-correlation-id: 9618a1e0-751e-484b-0408-08db098c942d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R6bWnFSZK3dp8gbGY0dSDOaL2yF4oMr4Bd1rw5DWm/ocHeYsves16Dio5eMsAhCoHgH1addx66uqzRpEpf4dYw7TRQ5C218YxEYzTzLuDdp9bUJP9cV3f4hJWJZHeI+nuIg+xgARpLBAaP9yO5NOf2lAxs4RFZ/SWqsGdFt7mVBB0bbd7Hqd+Dy1/WcCAINbamgoHMrI/Tghr7ppUX5Y+fr/bh3a8d+HHCTIXs7KppoI6NbYCbI1oexLTwSSQDh/pMEcmyUZcWQ1B/u6JtsObHusWCjQs7Q9cSaWLoFPmRJRi519q0bq58dFJ2ZFZP+Nbf3/o1RlLu3IJntLcuLBh9WOLjOmpkf46zGTHO4hqaoOV9tjTAg/a5psOp7ybpgriES0OeX+IxAZ8S9jn+I47Qx6fxA1kU4uuECOI/D5YtkFbZ2+qKZq7PLY1BvxkmAgTJJl7MIVnZCkt+oeTYglkH0OzSToiRxZ8dZEcPoX7eeVTqHlQFSWFTM1BdsJ1mnmtdGP4ssjlCHkRw6xC39VrVg40nrK2In78EVUtM4t0SDQil8Q6xcWfc89x09OUJThJVnErpddWi4Nj6qy0h9JJBhRXHnVdzPx4h1YYB9290C/tOBx0nS+4lk7BffCbIcOoUITrpRUQuq7Hz0/C0EESWYnHaOMpKVYQvi+enQS7LnVYoBNP/s3q6OVBueEEWNG2TnHFCs/Rj0suJeOt8Wm1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199018)(83380400001)(2906002)(7416002)(82960400001)(8936002)(4326008)(54906003)(5660300002)(52536014)(33656002)(41300700001)(66946007)(76116006)(64756008)(66556008)(66476007)(6916009)(8676002)(86362001)(55016003)(316002)(66446008)(38070700005)(9686003)(26005)(186003)(38100700002)(71200400001)(7696005)(478600001)(6506007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XgQzdj+CZtcBuAYwMTeAQyh5Gv860uouwgAWUKXZwXoFVrihtK0ESVCnPcH1?=
 =?us-ascii?Q?LYXE16A6nfdjq80LRU0N91CaFpnBt1lQUsse734IFMdhziziQLUXnnSMtyjy?=
 =?us-ascii?Q?BzVacddEOcLckZH4/WRtPqmiRzaG8Ym9G8+sR9O9TJHforeA2nkeJaXxGj4H?=
 =?us-ascii?Q?8cEb0IZoqOwZ75rFCG0/AVhBx0FnzIoW2xWeJ5H8JBi/iqjUGAQO5xxVDOai?=
 =?us-ascii?Q?BdPU9EupH6wgOBoiGniQwV8Kog2ymYSstZ24d7hnJi9+5F541/UE5XTPJsVB?=
 =?us-ascii?Q?thY9LUfZzewf7RLAu7Vyqo4CEvVU6MBtIhedVlvS6s/cp42dyEA+PSZakpor?=
 =?us-ascii?Q?njqvkeW1eR8icY/r6byWcM9DQ67IbE/QwdMF4yeL3FeblbMAKVRts96n9JEA?=
 =?us-ascii?Q?H4imQrqZ29flpf3xtW0poPv5VKnqYmumgFlZzdzuARmIOktnxE+rjr2ihGKr?=
 =?us-ascii?Q?/Qtefmd7eghwwYACo7c5Bw4xCkovvb1ufENqRBvKxjCnZcr+Gge7j4X6tmka?=
 =?us-ascii?Q?8m+yx1MU0OMF7hHp578KCmwQrJ3XSwdpDXk5AYI3/hOfkLOT1H/9FGcCmqvP?=
 =?us-ascii?Q?L9MmdbPkRvcq013V8wv6FkJDdaLby9A22OKMn4IiIyBGB5PIoEXlHBDQUn2D?=
 =?us-ascii?Q?oYuB6PyQ1uiMyZuMnfrR6BdNw0ft3mjQIS7qYQN/4A6RCuPIeHcRQzneL0Yv?=
 =?us-ascii?Q?b1JdONG3+YULahaaIwI48PB9zNOQvxDw4+jW4NAeVdkdYt+TdRIRsByCmvG4?=
 =?us-ascii?Q?l/LGz/SDVYo1ust9pV/QACDsqoLmLyfDdIIlzzCyMpjaurCGpMbx0oDXAwZ7?=
 =?us-ascii?Q?htaWD6GEtUd1+wmE5D+h4DgUIE9bjfC+KIvyM+C2Jq0zcq9GkdbyLjZM/rs7?=
 =?us-ascii?Q?bmdNuQ5c6RDE0jiusuXU4khPLuz1L5iKG/QJA2RMjuqYnMU9se9PZqP8kiaE?=
 =?us-ascii?Q?EtI9v0elCEzN57DidxthirIZuAnpQv+3+Uhpn6RSBnrrSC4jazb/lg/9DPOG?=
 =?us-ascii?Q?4pmZ4Vkx06MlEyOdMnQvYBO+tgoYFG5dvUgzmoQVHMEW6PXwycM3MiiaIH66?=
 =?us-ascii?Q?8Gyg5K4pGw75KOoOM1tnGtcZNbfR+uQDOxIrgy2ZQGIv+3QTNmf0zNeXkFWh?=
 =?us-ascii?Q?09OD5EMndTFL+QP4paJtM7K7Nbqi/oO+EHg5mDhE/+eunkLYDFtDjyAhmGQN?=
 =?us-ascii?Q?UN7erJBwm1141M1PuHDeos36q7FqT1klIVfgD3UYMJuV0/fFSWEfV69ql7M1?=
 =?us-ascii?Q?FOJMzXw8J6C4iGEr+sCy8m/fr+8VwtLIDWDvegLbGuHnMWyEcKqGGG/PswdY?=
 =?us-ascii?Q?Qq8ciPFfZ6ScPdO/RZcyCZMkaSC7OGBWnomfkE5/aQDi0g4aWclTyzg+EpZN?=
 =?us-ascii?Q?xTBgsP7FUpTrSCWSzFhUlEzeKxH35Qhfs9m4d/10wi724yNM7/hWLkuyDUvM?=
 =?us-ascii?Q?O+Md+3O6MY/T0Tk1wUsJtL3c53pw/4th0pVu8Yo373/SJpfjZfOouhSZjqGL?=
 =?us-ascii?Q?107v739Y05HhbnUoG1x/pa5FnYVeuhHeTRalMMY9j6bPxMqwBkadRtlnIMH2?=
 =?us-ascii?Q?u7f9o3C3iLP3jfxFqBGoUHf5YryFd4xKb3hTn+X3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9618a1e0-751e-484b-0408-08db098c942d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 04:25:58.8794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: st21CvnZT1dd+4uKOLnE4BykhWtomLCYSdcKhHVIAOf8Z0oBqV83CSmRxdyeCsk1x79290dWcyvI26mWP2cWPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
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
> Sent: Tuesday, February 7, 2023 8:23 PM
>=20
> On Tue, Feb 07, 2023 at 12:32:50AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Monday, February 6, 2023 9:25 PM
> > >
> > > On Mon, Feb 06, 2023 at 06:57:35AM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Friday, February 3, 2023 11:03 PM
> > > > >
> > > > > On Fri, Feb 03, 2023 at 08:26:44AM +0000, Tian, Kevin wrote:
> > > > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > > > Sent: Thursday, February 2, 2023 3:05 PM
> > > > > > >
> > > > > > > All drivers are already required to support changing between
> active
> > > > > > > UNMANAGED domains when using their attach_dev ops.
> > > > > >
> > > > > > All drivers which don't have *broken* UNMANAGED domain?
> > > > >
> > > > > No, all drivers.. It has always been used by VFIO.
> > > >
> > > > existing iommu_attach_group() doesn't support changing between
> > > > two UNMANAGED domains. only from default->unmanaged or
> > > > blocking->unmanaged.
> > >
> > > Yes, but before we added the blocking domains VFIO was changing
> > > between unmanaged domains. Blocking domains are so new that no
> driver
> > > could have suddenly started to depend on this.
> >
> > In legacy VFIO unmanaged domain was 1:1 associated with vfio
> > container. I didn't say how a group can switch between two
> > containers w/o going through transition to/from the default
> > domain, i.e. detach from 1st container and then attach to the 2nd.
>=20
> Yes, in the past we went through the default domain which is basically
> another unmanaged domain type. So unmanaged -> unmanaged is OK.
>=20

it's right in concept but confusing in current context whether DMA
domain still has its own type. That's why I replied earlier the statement
makes more sense after your patch which cleans up the domain type
is merged.
