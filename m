Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642867AE536
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 07:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjIZFse (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 01:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjIZFsc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 01:48:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3329D;
        Mon, 25 Sep 2023 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695707306; x=1727243306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z8q7jKFrN2RhuAzW/5fH/XfnGaji4Lmq6/PL4HbCWOE=;
  b=biSNHR9IgWwzCP1MNqiSsK7emVJk3srJHzgKjXaSb8gqpwtcw5ldpGAR
   M4I/Io2AbplZ4YBD30tKvsTwosEqZqpgfSSIOPhrOoImN9PKSMv8OwA1e
   eK11kyened/VBh/i+4FXXw0mubwkY0db6HXiOJmQVMG2YoDoR9C2GbRv4
   qwMb4ZkvqmxS0O+Tcvnl9TItExnKx9GCMbkAGLE7Z0LH3U2BWeCTDKZ+T
   0ePmSmSXtFIl/2otHmiQzyNxkXnTRLzZrE6q2Ihgz60k2iCqy9i+MmxgO
   Sy/g7Ock5lkve4IKIBXDAFx6bxUqCSZb6+HpCyOkqMNcj3NypYwIMqbFg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385339514"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="385339514"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783830206"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="783830206"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:48:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:48:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:48:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:48:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:48:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdvBSOs3k6VKHAWGl/6Px7jdVLjOOwnLTvIEHJl/c9sYNuFM//uLVW0AG9RNnoKuZBzMwh15JgcDZieMVO3AnX0c4SjomcH7ZTpwozBi0klCEvuRzZNK3a2KFOlJWBV+KI34IAzuo9GrFRr4sXHjbbb/m3UuUXN+5N+iaQPk/n82e/RvpPqeQbj4RZeqXyo4d7z9OkDjIeB95FmH5aNFJRYw3Dax90QrIKCLQj2vuZkwp+hGH3ANmAds84i6wQCyQH3IQCC13mclJMztR6kCLYdfzyIBJrlpSDH8pHROGcQhPn6dYofG7mNrg4pqAQYYoWa7dd5bTCtpD+8YzcHYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8q7jKFrN2RhuAzW/5fH/XfnGaji4Lmq6/PL4HbCWOE=;
 b=g6U0TlidA8eTwuTjibznNr974k87SZv3gPfpaS+2gDLF9MkaZEKAzQ+VPbNjBW2vhios1g0wNHsGMOlyQsRcwd7dRXPzcihrVcOmv+tW1ja5nX3TBhyfOH+tZCu7xyVNQanOvAROK64Iev4L8ldOTI2RTxiVkrAoZ3dkIN93G+q4jKWAfy1+Buhk3kOuNJLo+/SkQjoaRcDIGbpJTIpeemD2SvxEC20u5eVRvZByJ8qKVfadJCNKGQ2Ie0k0kCbDwfv4LieVoxXWSQ23dsiwmw7LW97OG01aogwb8PcY8tXHTC/yJ9hpWflO4kL9aQZT1RQ3azgMZeQhEh3pBOoXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7909.namprd11.prod.outlook.com (2603:10b6:208:407::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:48:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 05:48:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] iommufd/selftest: Iterate idev_ids in mock_domain's
 alloc_hwpt test
Thread-Topic: [PATCH] iommufd/selftest: Iterate idev_ids in mock_domain's
 alloc_hwpt test
Thread-Index: AQHZ6pcCDC1jaKuEeEOl2n7l2KRpjrAspNew
Date:   Tue, 26 Sep 2023 05:48:18 +0000
Message-ID: <BN9PR11MB527623155BDFEF2571EA13FA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230919011637.16483-1-nicolinc@nvidia.com>
In-Reply-To: <20230919011637.16483-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7909:EE_
x-ms-office365-filtering-correlation-id: 73735bdd-7b88-4f64-4463-08dbbe542f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SW1l4Y+Lsa16FM8JQTaLyvDC0xqIpQMMKieJV34xzIbCla3j4dhIgJFP0YmBV4/2/15uVdB67cmhZL0OQKIQAUiCQIdq8waL8rGDad5DjA8uhSVkBrJPPh32D3sBaW4nIRHylBP6elGyXEKXCDLiYLuIpEl2rO3sPYNtN+ZyYpJPoCOIj9BOl3Tw984c9RJhpeLmGBu+x6ZCm7uAfcH7rTWTpZj8t9DUaXvmAA1j+HKZ41jOB9+57jibNnjJsv/V83tXUUNUUdGqMhOoVouKjf+3N1aWQafyK8i00Vy62WNuw85pK59FbTwL8MyrGrvYROahFtsamZItEcaO+KprNTgDgAVQ5loiPZ1eLvAmpWY7BVfVO1HpFIedbuzX9cug/QHzaTqVmki2uVOkEgFF08/9+kRi8HI3aCUmGtjQuD0sGcUyvQ7i+bDz2TKn7NRZgpATGbcPtriQVuJlXoM4nF6pXGVJXk+2oT5fCQsuV5HiyCyx8YFTYgR7Y/gZbJZSGMU0GFeKNncSFjCZ7MWZcAm2hVGYWMHlRS5WuSlPLXtAILrc9brh0lqrDEcFoT2nPimx6g+bNORf7mqbrLZ0w1y0ooc85Bo6r1Ew8xHjrX+GELwYsOT6v1VAIu8wyb3o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(26005)(71200400001)(122000001)(478600001)(86362001)(82960400001)(38070700005)(558084003)(33656002)(5660300002)(55016003)(7696005)(6506007)(38100700002)(9686003)(4326008)(2906002)(8936002)(8676002)(54906003)(41300700001)(316002)(110136005)(66446008)(66476007)(66556008)(64756008)(76116006)(66946007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4NWPupBcbCcqZDLW+nryTDCFNCvheQ4BrZYkMsGQ+oku1dOsC6aIir2Onr03?=
 =?us-ascii?Q?Rv0UlE8nf6WS+/onF1kAa5/xQ5tCrzVIceS91kizOxyoj8AVwLrOfQcCMqXl?=
 =?us-ascii?Q?AwMYKRbxvnZt1TWAmAwqXk+2K3aQrDiGqiRSD3S38qu8U7XIBYw4EAS2AtTP?=
 =?us-ascii?Q?b2t01hxnXNQB6SjSgp4VjHobiJlp95yv724kzvd4Xgx7e5/IGl/vo4H7KiwH?=
 =?us-ascii?Q?kw3NLhOpDPHBqz8+zDne51+cHRDKAIIEPdJqUrrNkFumD8T97d/xCtJjPcka?=
 =?us-ascii?Q?661c/c7WHVyb/xyPtLS1Y1/amGDRlRnmRMDcKm83wygRTnJkjOg7mQ8NMhiv?=
 =?us-ascii?Q?503/Ycjlf5rx6p0iogcnn+3NuMKzO+oG2/M1uAzAVoD1/yXHytSzfbA4uvYa?=
 =?us-ascii?Q?VRdQ6b88QlZtsmP8PyiwVGa4OchDtS/MXDuOP/JOZWr6wpudU0M/uutcsaUb?=
 =?us-ascii?Q?pNyPB7io/WHRSq5MhUf9Km7IgsFUSHmsXCO8J3TNUHv5jJfEu3QBSt0IP4ES?=
 =?us-ascii?Q?xwL5Ws248dmK9HwBtlPVuVQzKcxj9zDYpLesmHCFVNkogrDbr5M0XFTzFNLc?=
 =?us-ascii?Q?l8NtZEn+j5olvGg3TJlEWEmcMUWzhrpBwbWJoxXgxrqpVfN0SmBmsrXRdnYq?=
 =?us-ascii?Q?+JHF3+usunfRVCDZbTBZQ1DiaI2Wo1cEeZl1U56q3chtXsuUOyoLLCKNOIE8?=
 =?us-ascii?Q?g8mhjRnrApaKAg0nj9yyVaxk6b2iSsYL6rRGHTT7liusJ9U4+OTfpfBGhqCN?=
 =?us-ascii?Q?Ze0BVbteDs6viHafpU6HaXRWwQJ7ANrsrt5TGghqwei2RMewsAf6vx67d8dO?=
 =?us-ascii?Q?LvK12eP9KsW0cqvhuokHIyRQvU57X/D/K9LdvdSecVsKmFVBAyzI2fmmg5Ft?=
 =?us-ascii?Q?vzSKLLBklfllfpSUSBSr7Gfu0ZYxbHRi7OP0FMXpTJJt/+KgTTeJpD3xct/U?=
 =?us-ascii?Q?le5AJCg/BPKc27F159nZcBZtJhS4OIfPaLynHagfDf15DsUt2UlTNedipM6q?=
 =?us-ascii?Q?Gdb/lJe7JoIVekNdg1MTbr6yBj3emtaFL6vWTJmd9P7o51ZtORJ+6JRyzbxy?=
 =?us-ascii?Q?7FjQiHK87LISBEbWQ388kiAlOoGWgUx+mT5g1WeJFtUppkTdszRDMF+mS03k?=
 =?us-ascii?Q?dvDFfQhUCImrQr6tQyHtZC3FRsv90ATAyS19zEGXL8zFQlw9YvjQDlEeUy4Z?=
 =?us-ascii?Q?zk81F/I0JFHZsVC0TGMYh7nD6cNy8SBDJLOozCv+IXNhx+VA9v9jESeqWfu1?=
 =?us-ascii?Q?woPNi0oAqHbB947X+R1aXqiYA2IjtiH6aExPMN5cVPzp9K/yTuBdIaUGFSbV?=
 =?us-ascii?Q?kafgdlIIKjEuXrkr6oB5RJrbRnIXmixNfeHmfhG4EOjYOoDjiwSFFsydDwc6?=
 =?us-ascii?Q?VKDSm085WE1aQdtrR2EYFqB/FECwnvRtdSo5ZW1P3/OCe5QLsY2LozulVRHw?=
 =?us-ascii?Q?RLfR/xhw6uA7uh6iBbNFFzlsrQfo1KBzhHJVsROEerVhfZZ6P0gWDGKDVg8M?=
 =?us-ascii?Q?DLm0V6wKNQPH3aR7nsNLVi+S1B400HFkLfuKYGy2RhHchk7Fwsc1Bmz/qr/n?=
 =?us-ascii?Q?eWzJEaiuWIVpKsZMklBBZNvdFuO1+pdJ1kB1KAxV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73735bdd-7b88-4f64-4463-08dbbe542f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:48:18.4751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZhXDgvxEzI2JE7H+LYEOa4SwFIqWEp9LCFabAbqpiVSXH78ajWNxSbPnTsu9u5BrhFpv4ZhqL6Cswpq8Z5VbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7909
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, September 19, 2023 9:17 AM
>=20
> The point in iterating variant->mock_domains is to test the idev_ids[0]
> and idev_ids[1]. So use it instead of keeping testing idev_ids[0] only.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
