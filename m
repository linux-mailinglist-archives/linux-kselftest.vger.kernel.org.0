Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4B6C612C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCWH5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 03:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCWH5j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 03:57:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB12B29A;
        Thu, 23 Mar 2023 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679558258; x=1711094258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7cLebsb5cwDvaDOuywjcqPFIFoc632IaHPvW0JKJ5PI=;
  b=Nu2VrXCALjnyq1HcvEUVBHPdROja1+KoOnIR+dr0M8OKWn4GmLs//PGx
   t7CfgIgO9wM2WXwJJO4m+3DTv+lhyzlx2nHcnHm8CTGYwu3myYws9cpUj
   sQjexGmj3q+C0o+UM2wE1RgtO8bT9yVoxu9ERnfhDS5vXJgQRX2m0IDwP
   0p2hjBRBMp0xky62hPgpgBulALTKrGZBteBmaFu5kkqGHZM0gDKSWRkvE
   xeCFBXgkx//bp0/UTGR9Dwa72ShX0eRcYewbPxyi1/FS2oWGDQPpZHdy7
   SJMUXpeEAfPvZHX8+QMvXvtEa70MP029/5NOnLAsautigPnf/3pl8QcnH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="425702555"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="425702555"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 00:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="712560988"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="712560988"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2023 00:57:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 00:57:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 00:57:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 00:57:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKzB+yUhaV8Mjz48panzpNjof0vpqMafgW8liaVjKeV0A19VibJNxMXyXUvwGYyvantWmJykaXZwqdUELL0dZqJvqMaG7rxq6fl1dFLWdHw98tPQPzAGLdi9QbQ+VZwloSTAQJaRmhsc5xD8nF4fXXnZqvVN30ZKPIsa7UpIfmd/841c3bBJynOKXG8+dPiiiejbYZhbHjIszvwO7GVtG2HFWEbf9weHEMJiPsGGCP/wybCXrYtmN0vpWRIpC2S83V37m+2UOczsFpLwHSa10KPjfgSksiteXqxeOWgZZB8RsmRXRq0nZtB8nJfnYps+j97IpXRuawPIEIuNAhxHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZKC7ZdNSvkb4t8/twwfr7OPe/r5WooEZJJVDXA1uds=;
 b=eVZ4UMf823SFfeAAKUt83Lwrh0xXNLfWKYwFTxZI8xPSncbTLIxj8wsxFjvJdWcSIoGvxgNLMz2BkSa8vnnmKKD0ACb0dHW1tu3v9mgxskc8Vx5cWSaDCTr4yRCzqREstIu878bPytK4yZC+u78+ogEZqo9qGuCdB6bGBfeocvIIcJ16NsggPg2Y+K++/cuCpzPDM55mjl+lkbnwlpnavjmLO3JDA2GoWCkrAL6MSBJRcDk78gIHjgbRBozyLGcE81eVRk8Awf9m3hXQ9qYoAxH1trd4fbhzlJUTvt5U66Qgq9NTw/i2fhd60MVD51pCA9NvfYGgt9KGPIGKjKUxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:57:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 07:57:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 14/17] iommufd/selftest: Test iommufd_device_replace()
Thread-Topic: [PATCH v3 14/17] iommufd/selftest: Test iommufd_device_replace()
Thread-Index: AQHZXCmDh6KhRY174keBm4J+a4fSja8IAbFQ
Date:   Thu, 23 Mar 2023 07:57:34 +0000
Message-ID: <BN9PR11MB52760F599640FAEC7A4C41808C879@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <14-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <14-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5208:EE_
x-ms-office365-filtering-correlation-id: 58be04cf-d4a3-4c61-2006-08db2b74434a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6lbYrZc3lxs6HjBVTXTCxrgh8qIZU8WzN19CcLov+LQ4CDBXGe0RS8pJNH5rdRTTDnL+fvrHv6zEWpiAY38blpcprXnTq+5FClPwezG0yzWIr+NiLbBI4vAGlYZc/NrM9cp8do6SCM5074mM9+vI7f5VI12d+jDRjMf1Yv0G4rQyIOqlbgahPjxbStPD4obWV42pRNvBZZF2+newqgmKM0KJQwMBZ09IFFDCSjwVBEwM+tvgjJcBbWz/hkjG2AALiEyifM7lDD3FZMpyDdRsuzD/xeApDrQNr387c5r4vyYp1uKkvvtPn5ekB7yRKrKwbBiNYD0dMT4NhdhuNnAI5w3ihWBEEgfMSfvIPg4GGAD02LGwM3WQRfR3PTBMWJhvqhzyJcy1FO84l1InZLn60UDDPiX6AXD7sNb2AayD4Si77YcyghKnAeJ8HogHGZdP63JcwIYhpNY5pOcxrU2a9b9ld7QjRVvHc4YGh1stiTIVi1WDkyDrug04bq2egGrG8cS8f0tLyZ0r3VGZhNrL6H/aGHWPZ/BZImd7j1fKHnog+dLK46tnoVuzo9nfI1RmZTO9KexsYNJx0M/iqxkA38a5nLgTNiI7X/2UZKZvU16T/F7mch8+e9HvPzx3etkFaj9WGeSnn09usiNSdeUhhBHaj/Mnz2up2+Vzu6mduz0Vho5tT/sKlyyk5pzZXljt9xxvZqa1D1sHr0zBG4JGQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199018)(38100700002)(76116006)(52536014)(66946007)(66476007)(66446008)(64756008)(66556008)(8936002)(41300700001)(86362001)(8676002)(4326008)(33656002)(122000001)(9686003)(6506007)(26005)(38070700005)(55016003)(186003)(7696005)(316002)(71200400001)(478600001)(110136005)(54906003)(82960400001)(5660300002)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Wyp+z1zTfN0BIv4h4E69W/AwDgAF/5X1l+PPEimR1bICGlxlW8qEwPOpaCY?=
 =?us-ascii?Q?/Sas8vtEaieY8BFxuvE3Yh+hbTCktwpxCvqTdbQmUPWtmU67IEXXMidN//Xv?=
 =?us-ascii?Q?btwtQwopIdTYTJQKt7yAtURAZXPlDlv4SuKwCUC7a5NboAeI+QqasH2UvtFN?=
 =?us-ascii?Q?iOYpVMuQsVQJN5S07ALom+goxxqm2NTQco0u9ghT1mGM+Ryolh8Kq4YhXw1Q?=
 =?us-ascii?Q?PLApT1w8G3XB9WHscmkmx9aCJNp8yPkHKvrhAzbi8m8IeX7uGjj3eRo6CfXG?=
 =?us-ascii?Q?pEe9T6y0Alrs4YtA6jY2sUeNbmK70prRMsr8kOPzcJXFeiYHSQ/6kuDllKM7?=
 =?us-ascii?Q?qkUDFWzf+FjKMlPWFUf5C3EmJ0tiBaZdJq6+2W1IvUg83N8OSEwRaJLv4u09?=
 =?us-ascii?Q?nUDUS1VTeWCjkwnIrzImzu735s3HuZRXDBcOggNkxywKO6tnMzyo5Ll8LMK0?=
 =?us-ascii?Q?sGuWuPl8RNnH/G+McfeDiWmNq9ksJzFmXq+kl0jQi+b14rhCtilYSkptcCZa?=
 =?us-ascii?Q?faOGXOhCYGNbVwDZ9Oy7HO8ck8BnQR2W8Jer2ftrcg1m0XeOxTqtELr59SfD?=
 =?us-ascii?Q?ezdky9oZzSsbd4vpvWvMHdD/FZhtjTB2K5daGEr8Ts1oLDuyDSwDk4qcHrHU?=
 =?us-ascii?Q?V8NLfBzezrbA6EUaiDbbIbFem2mgbKwaImQ/MHixnKP6DzurWMyBaf7ls313?=
 =?us-ascii?Q?rtRkH3iU9OiuHYRti/ESRzpvoGu2XKsz/VuhJ/Z6UfBbEqg0Bay8KSHW6BWU?=
 =?us-ascii?Q?SiUTh6IYvaRKu7EzMBRY32BvDIX9lbtDpIKJGeLq0hH6VE50ommi2kj1SVv+?=
 =?us-ascii?Q?fJHM5UW4q1gO9opKDGHaGA0G8mP7cuolcuLUtkDmXjoHryswDywmpmXghQ+5?=
 =?us-ascii?Q?YtNU5VMXlRL5mpBVhXrWLOZutCiJA8XVJnvPRXEFFneNmu5z7+U4bLT0UFq/?=
 =?us-ascii?Q?+EDQ7JpD8D17rpZYua7qfpWHJSVOxn2rRsaaU6uLjvQb+gITZXCyxC9+Y7a8?=
 =?us-ascii?Q?9DCHMrcp0MdBa4+EyHt3gMxvBR1SQhaF2mPdmbxytBqwALNuO3vPur4OroFn?=
 =?us-ascii?Q?0Ctade6Y3xX3GsQkiU4kgIPZYnuoGVH0+0d1WZ3WLywNswCcHmWgckCXJZPm?=
 =?us-ascii?Q?Zt69zhet+eiNicUmEmVKpC5fVD8TANk5BXMIpLuB+T8zQlfm7MTfT4U6gnpx?=
 =?us-ascii?Q?iWNE/idjF9ke6yy1WspcvLaIaH+1PSDETeWQgl1tq8SgZmP2EqCq4D6apxNJ?=
 =?us-ascii?Q?4ftt+lFn6/+PLMwZ6GirzA6BQyVhs6NwRDDronP/GI28RlKYqfQsJUQ9cQ6x?=
 =?us-ascii?Q?2zFEB8jb4hqSOvxLIjo8D8Rsh/AkL3WV2CCnylbvbyYmtxoqAK4prj1E1Zod?=
 =?us-ascii?Q?9qlT3V9Z7JKfEAXsw9mjt615IA9R4x8b0Dw3zxFb3SKFFm2koDlfRF2s5b5B?=
 =?us-ascii?Q?KMHS3OkfNB2HVcDDUPTJ5cc/jSm4NXTStHMmsMaSY/68TdB84hl88F9pMTLT?=
 =?us-ascii?Q?4zHJoFqlv9K4mY0g2/2EF2uYtYXf1YFP3KZDt51fwd6mg+RpCqOlqCnG2FMQ?=
 =?us-ascii?Q?I959Z5208gAEd6OsSNWCK0EVlYM5GPdDWmuTetnl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58be04cf-d4a3-4c61-2006-08db2b74434a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:57:34.7721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJGLuEElHTPbQImmot1xh8XwgAmPEEleOfqt+PRqCrJ0L4LMVX1xhMB9ZgS6CLko+RMHGkw3c7ABUCAAAqCqXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:15 AM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> Allow the selftest to call the function on the mock idev, add some tests
> to exercise it.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Miss your s-o-b

> +
> +	test_cmd_mock_domain_replace(self->stdev_ids[0], ioas_id);
> +	if (variant->mock_domains >=3D 2) {
> +		test_cmd_mock_domain_replace(self->stdev_ids[0],
> +					     self->hwpt_ids[1]);
> +		test_cmd_mock_domain_replace(self->stdev_ids[0],
> +					     self->hwpt_ids[1]);

Duplicated or intended?
