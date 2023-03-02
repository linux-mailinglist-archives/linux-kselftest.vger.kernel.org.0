Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321B46A78D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjCBB0J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBB0I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:26:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E7C498A1
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 17:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677720367; x=1709256367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dO9CxC0Z5aPkRso4XUnc472BsT9LvKhXVST19izyeHY=;
  b=a4cw5nrWTSoevUIfjrFr4qmH8QlaVt1iUbornczXtMmJnGRBWauUYpqH
   7SDVvsg8e8m993zQUn51FtEeIOxnnKJbTXaTSxQPWad5EiSNeuK4pkPjB
   oW2vm3wjno1lvZNCJyEoFrDKokLMyws42NmX3kY4Fp2B3HTW8DV9Dw91a
   uBVoWpHluTs5VyIvKEbgFMwVxOR2r/8RhSVjyAz3+JB48XG7B8a24fUbJ
   9+ECO0kQLCk/d1ZSkq5KErbap37pJFjv7zJxqEY2bH6TPw4gM2tZCsffo
   cNynE3fQ2OOKAr9t8ijFW7jq6ALMv+vWeJyOjldZWWDkkFJ8oaL07RACz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="334611719"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="334611719"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:26:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674772417"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="674772417"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2023 17:26:06 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:26:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:26:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 17:26:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 17:26:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOdT9K6EJbF13zDumoO64kURBYsT9Z5sEc+pyNIadyKKomeyg5sMClBLJvhoNdHmf5nMceIR8c0kNu5bQEi32QP6YDZuWDSAC+c5YtKvu/rWPFd6VOhPbBWMMiRDSP3oPQUj6lu3/zN4bCtYnggk7osn28s8QIPwqpgxRCBUcHArDdhwbvBKiC3Uc3PVbCu4ZlOxxPyoY3RsZih0Sw+Bk0RCji6A7DYIKDgwfw7ZjfTo580DCfn2ycM0YEd3Ef+Y3oiEZLo9EP+ByTAZz0vIvW1Z8qo7ZvgSpMiazgpJR09AYCieLKuOrSfB+usU2DntxM2Mqj5nOOn4Lojhk/7Acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO9CxC0Z5aPkRso4XUnc472BsT9LvKhXVST19izyeHY=;
 b=Rxo6Ax1oe7QhW1SrM4Hsmbvj09b/qImbEBN6Rlq0tBlycNcGoPbiNTVhARhV1aRpROioGGqHw8C84f7+oft8O1khY8zNeX/V56daVl15kSCxV8LZEAxSqdbgpVB4RWFMQCbM+b9VP7EWY3vO/ZJO+OfHbWGnQY0tIsOl8OBUlZuWw/NbgTpzsOdopQWQdEnqo8K99RqSn7kB1YBmNMCkZB3sNKZB+0A2+wrAswAQTpeyb5isj4//s9YMhZy1T1uAkfoiSxNSRkosmkVQbWJCrj3NE5WM5bETJBNCRtjELFFUV7RKvrxxywcXNQ4r2jnEkd1pAogiKQC1nKk0ik2x8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB8233.namprd11.prod.outlook.com (2603:10b6:610:183::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 01:26:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 01:26:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 12/12] iommufd/selftest: Add a selftest for
 iommufd_device_attach() with a hwpt argument
Thread-Topic: [PATCH v3 12/12] iommufd/selftest: Add a selftest for
 iommufd_device_attach() with a hwpt argument
Thread-Index: AQHZTHRaLvT/FFHSpkmm/irE5CNQIa7msuiw
Date:   Thu, 2 Mar 2023 01:26:03 +0000
Message-ID: <BN9PR11MB52769A95CFBDDD5940F6F78C8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
 <12-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <12-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB8233:EE_
x-ms-office365-filtering-correlation-id: fe7db46d-b6a9-4233-1af9-08db1abd16f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9GHHSDLCDBQZfD1D17nmdf5YgWERlOBCs9iBlrM9pjkg767lAX+nIjlhCZpYLLugvYEqrYAOie/XY6mffLhTzBRaUxCqD2u5Mr/fqiXva15zBzbdNM3MG0g7osVmtGSyLruSSkJ4jYogRsZSyrEquSdQoN3qvSkilSe9tP/fgayeZxc8jon177MrllGP7fQ5q9mSbK8houDE//8Txk5qKOyIgYzdcSxmh3aiJI0+unUiCRy2l17DcXaS2kwAwwMSXmsGvSXppDj0ktwPeI/cCPaCBuSM34kpTZTiP27kKs5see/kdC70ImvulXV9a9aUwLHmEOcu/HnJOs5ARpRXw+ns5vbFUxXRGBL9eBrjW4haQgNZ+kgBEeDUsQli4R5HgdvOYDRrA+YpTOE3LFMk1nv6kCORF/Zuja/eK2wtZlE1bu1a02GhhwdhxoShskzUZ9Cm9DBPI4ps9ZDM1SLaFbpY5T1EDSlT+k90j0G+SmZo16236JJZhpnYPbZ2gl4GB823nyEGTLXDsrDrtgFq0TNlfl2QNw4tbd4yvvAYO9+76GVUmpTWzzoe+nd7sY9NWD1pv2nO/9ytS0vckbPOM7fmG7lI0IIUl8yF/0mCSsx9zpOE9MaOd0YQ8tulN96IaHmoGaRcc3vE/L0Vvc/BKDY8FQRrBHtmP2C5j1gq5AGe7VClRnmED+sfcf/xJwkU0dMvIKjuhzXqqqEVcOmvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199018)(55016003)(76116006)(82960400001)(8676002)(122000001)(38100700002)(8936002)(4326008)(66556008)(478600001)(66946007)(5660300002)(66476007)(71200400001)(66446008)(41300700001)(38070700005)(7696005)(54906003)(558084003)(86362001)(33656002)(2906002)(64756008)(107886003)(110136005)(316002)(6506007)(52536014)(26005)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e+f5oUuf/+MK3HFIWseFrlugvViP97itsODQWVfdVprf7u4R48Hx5t12MqNr?=
 =?us-ascii?Q?nDwGgxU272dwDW+1QeFH9JqH+f7aRHjJ3MZ1zJHaGhYri5hy5lYet7Ysfmly?=
 =?us-ascii?Q?FCP/zfSC4tfMooRKlLLlCCfPcnxFjZ+zf64MKdQRH0/CH8uKohuD7/tPMn8z?=
 =?us-ascii?Q?UzjlAmDPXAxFgk89QMg7ru8UAk55/lyFP/S6GJX3eoy4sELRpiuHu7skvZYs?=
 =?us-ascii?Q?KbqZwya2T0IgeJ7cod9OMau0eZ8Yvh/iQk1mdGHOGhPKgu74T5UHbtu3vyCM?=
 =?us-ascii?Q?DdgwlAKnHeWBE0sbA4TXQLVBHXNiyuQKNnnJ/jrzCuDSaDQmQh9batHju/DO?=
 =?us-ascii?Q?IFfPWv0WSwPhA1sgzAhbONCisRe84H1uiNfk74Mdm/aKQENxTaWghLMWya57?=
 =?us-ascii?Q?QHykfK1Hqp1ZwSeCZT/aVuKY8eQYwQNqM1sATUqaW0YDgHNsFVDU5whBc8Kb?=
 =?us-ascii?Q?xxesOZ2xa4UWUaVBViAh2Z/E7ucrCzkqftNj8zJ9m7p844u+h66al+0YokN3?=
 =?us-ascii?Q?rEhLw/pnmtMr8WoSpmQdAN2TbJfDHST3HtDbhhmrk1KsZsC+JXMIk+T7/0BV?=
 =?us-ascii?Q?l9WcBM4pm5D9yxnRtUgg7Uu4KC+DcDPssjs11cbN8dyT+IG7BntFpiGstoOf?=
 =?us-ascii?Q?ji6zrGfMyQUPF/+1F/nrScCN6DwRNQZca3CacT3oAeeUzu0fl3v9FWBHGU+v?=
 =?us-ascii?Q?KcNvkdbAi8m9w2uX6GbMhv+rmPMb5xCLsJ5/xkAzmMcpJpqy7+WQQMGL0KWM?=
 =?us-ascii?Q?ULpVSCK1Lpxc5HN6xdGmmUhIQh5jYKTWjjWCe7LOckRZ3IsKJWf/LzDIebqw?=
 =?us-ascii?Q?f2w/bYJqhB8IHBC9tWXdzVtiFmQ6bgdtoOrxdtcjtyEEifkNI74Rhim5jiBk?=
 =?us-ascii?Q?CX6omFCOJ+Cj9r1WSRZpSdMnsy6RlUVIEiTh3WcJWQMQs2Bg3MTk6GGx9+dU?=
 =?us-ascii?Q?zAoDRnUwxVOjNxux58pTteCwr58Dqy4SU78fKYUR6POeAkqTRkcH2+Dc2UUK?=
 =?us-ascii?Q?57yg7IDfVaMlYInHg5Dff1fMjrBnINjltAi5azQxow8QIG1VlgapcUV/ueIe?=
 =?us-ascii?Q?FHmVh//826R0GGr5oRfsqqoflKJDyLmrwjYd7DvSs4mK+HYILKuu0c6Jhoyz?=
 =?us-ascii?Q?8qn74mwhOfcQrsAvV2kBc16Xu0iIZiTcEeKbOhxL2ErrNX+CgyeMKccfZ1kV?=
 =?us-ascii?Q?bMOxyzr4EW1hCi83J0xigv5PUgdvqRyQHXCxer6DhHZhTaCHoN2Qp5G/zYZi?=
 =?us-ascii?Q?2zKSYrxy9fOUPZ6JtO+qkXq9/MSKuyoZ+prClIaWjT0TdIiBkCx3SeAyJ1Em?=
 =?us-ascii?Q?23a9WrjSvFaG/ygTiHMgJxdim7kYLOoji4yLn5FRyx/bK+wUHt/iYBJetkjR?=
 =?us-ascii?Q?ia4YE3QpK+fp2QwXidL5uj1StDkI/g2eLEzfQW8exUIOkCLSZMXiWu7Ywmfw?=
 =?us-ascii?Q?0y6yPzhwT+4yXZPMJOj0qUyayGQhyqxfTayZr9rc24914JZ6/B3hc0XSL0HV?=
 =?us-ascii?Q?GirH5BIWTf66P45YX165e+EIC0EYIJfstVwaVVGSeH36yfoc4sm6QgoNx3YE?=
 =?us-ascii?Q?lPwqvKP0gy/61QUGgrz+IG8T0RlxTw6IXfQWlINr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7db46d-b6a9-4233-1af9-08db1abd16f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 01:26:03.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L92z8bIfer9IR95553M/Qq8y2lBBBBe/apzYydecm0RMIHgL9Jq5C4X4R2IhnoDOL7ORmjewzVEN9CM2rxmTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8233
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
> Sent: Thursday, March 2, 2023 3:30 AM
>=20
> This can now be covered since we have a full struct device.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
