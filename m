Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8E26A78CE
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCBBUw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBBUv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:20:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBFB460B3
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 17:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677720051; x=1709256051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=51PTN9yZaYvRvm+zJNCK3eJSbrIindKVv3/2zOMAtnk=;
  b=dG4zAQkPdlMtpMjtltdZR1TgokpTGDmwkw8bFN5xQDiTqSYsrqa1mqa0
   rn17Ocp6Sy0XsT/y8pxzF2w/x3ubLbihGhebzdRCMs9d6qk748l6T59SD
   iB1QH09gB0TnKcJ0F4VU20o/NkuZSJngT40m+0GBwca/NT8hoAX/Y5yOV
   w1n/Y1u8CXb0h7nAuxLR3BQ24mLfw9jLA/LmB3dbWHHT2gsKte8/lQELy
   by4J5XJJSQnshtN5amNiWMkqskUy8oAxPzHVUlolFJy6tpTe//XLQgZxA
   cmcIG+YIbE2Yv1W6ppN94gjeVx6jJK1AP6F2O7ZD+HsuX1uvwmiS6VnBx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333304538"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="333304538"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738856698"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="738856698"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 17:20:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:20:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 17:20:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 17:20:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXpHCrQPooWpcPWMI+OMeyXndx3ZTLUzPZtrZ81uPnG3NaI5s14Cz5DXET0yh8hjem/Cj3ka5g+qc3r9xea2kIPvZr82sdZqqY+dda4fLvPGsmQkq7dBAgnwm/y51TZXf4vjVRBTGyxEMGXBN4hAAHtuy96wFArUoKlXXeICOqrIujUx68Dzt/bkbAy697+2XBhI084WRE5+g8qq5AxHJoGyDT5H4APgbm2Qb86NYT8h3uo9eNg6hqWckX8ZLS35PeL1eVU2VOX6R4ek+yAmJr5WRS/pkqvYU+z/WGhpp7QnWzKTwwpDkclFydJKaF0BNjvxfQ9ukgrLy0PRs/FUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51PTN9yZaYvRvm+zJNCK3eJSbrIindKVv3/2zOMAtnk=;
 b=TlUxvd+7VsAMo0nTBUyRAxy5QXJHttZNXXAeygR5lS1UHqgNwAq8T7szI32T+F/Pr5Ln8aluuKZ+LbNidFFXvkMfwdKmTesQpAc4gGDH4JyXPawJ1os8NGtorAkLoNRpfYZdZw14pLVFoo/f/TtHq6UTRpaLzJkGIlK7HIk/hJ/FBSMkciOvPEBpxBK71E6IuaNYUrt1hN6xNCu3KizA1JzwJzCRNGFoarfecGjfQFq7y4NGS8Ft61aaHWcP4xb2mO6uEizI3i+r1wUPKgao2TstlPjEhAIRHBWuyQZZiwgoK7Aqlo1X+qcEwdEBzqiA28ZuH9KiBA1+qgPNq9ffcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7685.namprd11.prod.outlook.com (2603:10b6:930:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 01:20:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 01:20:48 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 03/12] iommufd: Consistently manage hwpt_item
Thread-Topic: [PATCH v3 03/12] iommufd: Consistently manage hwpt_item
Thread-Index: AQHZTHRZyoRaTi3+eE2F4jY1eLhkcq7msW/A
Date:   Thu, 2 Mar 2023 01:20:48 +0000
Message-ID: <BN9PR11MB5276369D4478AE5A3678517D8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
 <3-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <3-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7685:EE_
x-ms-office365-filtering-correlation-id: 4b14af83-5cda-412c-724a-08db1abc5ad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZmJwH/IHiu3tvjF9t6WpSe2z6LY3GTDKXNRI9Tr1WQ2wOjt8Am8cS2Tuq1nC4x9hoK5GMJprRVgQcn4IEonQPs9peNPT7xawtluurwefa0WDdPYwIePskwSapqZ9zcAltyOiaQtFiEZIKbmAJxoutfQKdxbw9dUlLgEtMs2go/m5hdgt0pbedNQ7AsygujAAy8Aj21SCxSuc8prtG+XnWnPFeNe+CYzW+I2GQTeV63NVlmKaKHcRRf1vA6v5c2OhZZI9eCxIxrHYDuOa/zMP4Jo/q8MU0UKooegyc7BarDj8h/TYh0gdygSBD6H2+63KFaVRqa0w+BLho6eFeT/tTcCljZDJafF+55WKf7FjLeoA1MvydYaYqSAkcR4bUNOg4+dTZMtYw/gjo/JK8rsjlH51NyrJWVO5zVPznobslqTVUwAdHkZD47XNdN6Y2HbADb2DWLx6Wd7kFM3mXOqahJr0iaXYQ/9XUZObzh4bPE9bbQ488RR8rT4iaeHZa8QkxNP5sN9erZFg2ty+UfpYCoT47JImOrLo8/Us7TMqmLyxHosTu4u2vWG93XdoUNlcd8HenhPnxl6cNNcfggNQDUx/zcs+UOXEJsFfj3tyXVpU9TU+0D+N0x11F4ZyqeS0lQhOCBh4pQitoYnIPU4vWh/SFwfaxrDgFxMF6h+/zcZdHhfFbtPSkhAiWxo5boqT6jSRSEydQjZEhwnOyu7yag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199018)(107886003)(6506007)(9686003)(186003)(26005)(110136005)(54906003)(316002)(41300700001)(4326008)(66446008)(66476007)(66556008)(76116006)(64756008)(8676002)(4744005)(7696005)(2906002)(8936002)(5660300002)(71200400001)(82960400001)(478600001)(38100700002)(33656002)(122000001)(52536014)(86362001)(38070700005)(55016003)(83380400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+EIf700zLJ35bcg6Wm945ld5SIR05IOwgJ0JQMGQDGxD10wAitn2kh7lsZgM?=
 =?us-ascii?Q?eQIWtrFQwgni8w2WpUcX4bd2IiiCu+Or0kucTngSgO7/y8NDaq57INCnzV29?=
 =?us-ascii?Q?9wkZksoEOaatSf8flwy2yiurWWzaJ4NTR5HOurl75fLEybYiSpGD4vfvx8a/?=
 =?us-ascii?Q?//uzAiePaJ8OWIFkQCzbN7tRIMLIIaurkhNIGWxg6d545a1SwOk3GYZs0p2+?=
 =?us-ascii?Q?IdScoL2NlU/WGI4qnRykbqWbcFwAQZ5HyqrIVVISZEhi6+mx47Gr0Yn65JgA?=
 =?us-ascii?Q?s/BS25bnw8dkFSFZrenJOF2MJquWZK4HcT45qysPtO665ocYAbQ5lGcSPXib?=
 =?us-ascii?Q?xJYriMqoi8OD/MUt+Z/BJ1v7R1blLIpTG03NgjS3ii4IaOKp/ck3FqKFCQ0Q?=
 =?us-ascii?Q?WFoBRK0aRn3YDSg0JdhKQnfGrblAMP6JupJvvPk4zCN5ZTcX4mCKQkhl4hjC?=
 =?us-ascii?Q?uTwCHhiEAB7Bc9fxWCLSHax8e9sCNFp+0YBQRlUDw6QpiuQ29AkuS8UEbAc6?=
 =?us-ascii?Q?2LIEU/xelbsEXpg4yv31OiJGuT98WGw6mAAw/cbtXPz9I8ovEyDV2Ov5j+Jy?=
 =?us-ascii?Q?zWSDxyr1BHrzNzLeM+7EUJd70RHusHZvuvFBYyBXsi9IprORzVzWqJXyNz/1?=
 =?us-ascii?Q?X7yLkC2W0DlirzSBiFoPlgQiOsoInC7VjnWVP71EQHuN9/dJ5DFnnZji+gtI?=
 =?us-ascii?Q?TGta8AeORRZszwennaspg5J8ETChN4iReW6W3Z4Wtmi421Ik6BC/2aO+36Jn?=
 =?us-ascii?Q?9UcoLLaVUeeJXTorUS0ikNzKHHg7wc+3ciTt5dRKnza6ajSznFe7biCEcySQ?=
 =?us-ascii?Q?WfymsZieWcoXzfWmxeGRly4uZQce5MNhr4zGCM2ZM1RbBOxlcLhKZeBBQx3R?=
 =?us-ascii?Q?hgGeJ0R2DUmxWK+EjoROD+6vnqRKoNfu/rR99QqO1I88w7PSbayazohxIKNA?=
 =?us-ascii?Q?ZN9s4FMBJ8J4rCmJePPD1+jYvLBeiZ9t/lW3r7J21o1FDCAzeXkTI5uBOUDJ?=
 =?us-ascii?Q?gPUIK9ygJZfmkwWHG8vDW/DA4qFFhugShguSe1ARwdjNFLmEvcbqq4fD/Ok5?=
 =?us-ascii?Q?BU8s3Ici7hlcz9TRsV+qaeIDq8+zxNrXEXWoxb8T+n875OJDQ5x1ED9kcJJT?=
 =?us-ascii?Q?EsuFW5e+WoWeUDWL6OaCyxZHOKeLlf7SkNydcYVexepSemIkYxoOhLQp7JCX?=
 =?us-ascii?Q?aVtOWn4vI/0dQsBzGxAXrs0fyXM66VVMKLen5WnvERpXTsF0qpQobDBwi0Iv?=
 =?us-ascii?Q?EVLNCr3cKLoDRqWwASZ+ls/qKaRF7sGDCncddUiy501X/rtiyniSjKSnoAgz?=
 =?us-ascii?Q?8TWy6QCklHyPpvv7NL3jt5Xi2jxycGtPoGNVdQPybnDOXaF2Mp2PLlHJxmRf?=
 =?us-ascii?Q?8RbzT4wMHWN37/LRvIQCGVViaaAmT3lUGs1K3QQaiJFmYvOEH6LlY4nyiKcA?=
 =?us-ascii?Q?ovU400mSO7Cw62/UtRhQMjc0VOLPqrLO4XVCL5io8oA7zUJJZRp6GobfaB6P?=
 =?us-ascii?Q?+GFsNZYAkgM2PUXel3NnNMwW4Ydnf37X9vJD/alvnHi9MGBt5gmmguMmz25F?=
 =?us-ascii?Q?8n9KdOwDLk1cJCX5EkYukQUkaz+7S/Fbi///L4aj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b14af83-5cda-412c-724a-08db1abc5ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 01:20:48.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMpRjItYLgqkYx8WVuurwcMl6W6VUojsytDooVblOVkBtgX8Gg94UGEc8Isg9yK1z0H8RF+zaqIrmTm0OKUlYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7685
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
> This should be added immediately after every iopt_table_add_domain(), and
> deleted after every iopt_table_remove_domain() under the ioas->mutex.
>=20
> Tidy things to be consistent.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
