Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF436A7C89
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBI0X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCBI0T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:26:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC41038EAC;
        Thu,  2 Mar 2023 00:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677745577; x=1709281577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XLhWHtFdkVgQAaUy6sGhYyU5QbHjtb1NbJpq55HLWe0=;
  b=eFEofiwONukULjBgmqR3WW6IqYX7rKirfuZqIPE5cSfysaKsrY3t0Nsk
   2MACqakuGLnyAlvvm4ZxH1i2/+B0+SXpgDnsnEpMX9z36S4kVdKCbNreE
   dKmR7Zef1gSIgWjDc/UN7U0dz+PZHIV8Vk5ybfy3yO8YtEnHBQE1pDi0X
   bTS5jh5F29Evda7PiQkwA6bsAt1MwmW31sxlLaEXIaFBVg9g/IoMpUZ7w
   +owE8nAE9IQtUy7/eQVYk0pocuAGPIHEokLef5Wwvj4ZxFgSM46S3iHZK
   6QkuQovRNYPwrKOqyhaa/cXeOydWj+k6rISpfxk1CoR4WbvTKlyiT0Wqi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="399443984"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="399443984"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:26:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674866187"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="674866187"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2023 00:25:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:25:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:25:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:25:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS5zmEgKbNfl++bLHyAgagbjTn0ua43VIlz7vUO80SpCvmT+4cLgiSRk4sGXh/noHv++s2vbkPSlm/2QHfav0GCau2+Foyoux9ceApeSitNUZde23xyCmrILjC1SW7bYUnElt/LOuaQRHTVCnHLtwB/cjk6H5o0xSj4CH0s7ID1jdxa70fwm108ktbHAK06V3ERP8lEE4ih/yyISolan13IYuVXCx/9p/DW42z4WqauMYfFKpYxiao/6EoxHU04b9NTu91+NSQtLnQvkf28+6O5gIuf7N9TxFp20J21e3FmxwhTPf/acqUI4xZBfxvIcCtNlW1prweKFdpQoMGwwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLhWHtFdkVgQAaUy6sGhYyU5QbHjtb1NbJpq55HLWe0=;
 b=W422+k+XaJrfqyOjMDPcz6AuduFBGV1FiJ2yR3M99kNtVkAeSD8Qw9npylRcD2PaXCuAEkRzX2QUyGz5Rh7CtukeKSN2HB1kfaIR3xrai2QKWAnWGAS+bQ5dsQtGKtWQn21uee/xduOSafvqE5An0r1v2yqfGkh4rfYnpIIuyK77G/3j3uZtvAjWYUZdbWunyG/TgI/XBKxjOTp9bacEqcO1CweMO+hQdWWd1RdDHzpKcZw93j5dwtQGNje15t/HfW2CIasXkVigPET6uEHiEj9JBzXnWe0WczsjHgtY3Yb3p3vD//zTuGKu3BgCnqbr0cRcyW9riN9IJyZxFoQ+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 08:25:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:25:12 +0000
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
Subject: RE: [PATCH v3 5/5] iommufd/selftest: Add coverage for access->ioas
 replacement
Thread-Topic: [PATCH v3 5/5] iommufd/selftest: Add coverage for access->ioas
 replacement
Thread-Index: AQHZSLvglIODj7w57UeUlzTh2bS2+a7nL3gg
Date:   Thu, 2 Mar 2023 08:25:12 +0000
Message-ID: <BN9PR11MB52766455EDA5BDF98D1FD4C28CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1677288789.git.nicolinc@nvidia.com>
 <4d371c99faf55baa771a0cb00f90338145af0c8d.1677288789.git.nicolinc@nvidia.com>
In-Reply-To: <4d371c99faf55baa771a0cb00f90338145af0c8d.1677288789.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7119:EE_
x-ms-office365-filtering-correlation-id: e218a771-51f1-4ac5-a236-08db1af7a4d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jas+LJuyz2prVP9iVEDahi0x+/6GN7iu+PD+PqoMgn5s8byl2Ia+2vEN9mH8FcTiMQJF2xvthb+urU6hbRWRqKZGSkG1RO3PBGq9ojiVFYl44o1Ud6YgQHRRbzzjiQVKBs0EBeRdcngfu5xpHlCnZMSjLsiyTKiypcPMAqvbumjZqFaStbEnL0v0/UOWPI8cHQaHc/XxQBh1059dgOe05FKyF7fM8c/ltqEz1EsrRZDzOcKQw3aOYY3F/rYkNBqnWQ9/PEGK4sqYFkKf863ySdFxiv0TLGoISMrQJDXZEPJ/gkl/b1vuNVV4BeOGbAteweUk1coc1Ww1JPdDm07eJNQsT25iCCbrFzrIIXj8kIuD7v/RL2wjlTY94gYOx8T+Wh0Y5zLjcXkpzyAH94n7B5DNwIo7MQ3qKKmp8BtgtSlrUnOzXRxkhyqUkT8XhHLwujPreHX1pNgjivrmjNHLLNXmQDKfZs0rFVrtJdkEsNKaqashJiMSKhc2XlNQ6IQ+IC1wQBCDdp3N1aOUCY9Piy3KkVUsiOS0o8d7i5r7Onpn8zq7NgzBAPgv7zlKAJgnfs0HqkpS0L+1J7X1xL3NrwObl7zDbQ3jWD/lGdGBXKVLkIe//TBEkYjrJXYeYCrMcUPy/pBW1SBGJb0lzFdpqbyY5UdLQhCa626vMxGsm5Yn8q41h63IzJ3LPT+Ihl4R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199018)(6506007)(9686003)(26005)(186003)(54906003)(41300700001)(110136005)(316002)(4326008)(66476007)(66556008)(66446008)(64756008)(7696005)(2906002)(8676002)(76116006)(5660300002)(52536014)(478600001)(7416002)(8936002)(82960400001)(38100700002)(122000001)(71200400001)(55016003)(33656002)(558084003)(38070700005)(66946007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2tMgHUHM/OoHr1yiQ51ICgQ3b9O74rbHvFr288s9FP2xppePYYAvabYpRZSl?=
 =?us-ascii?Q?AI/7Ewyn7gxsDtIJ5KZdYzxeMWcFhXac9/pUdHCGYA+pU/dQLkAhYJOPsKjn?=
 =?us-ascii?Q?ZcNW/rk5+ofQEXfUqRazcBdaJFGCPhfHSbHHw8e94lhOodK2UFl0GMTWky+S?=
 =?us-ascii?Q?fU+L6ItcqESbBIQZC0p4I2w0c5m6/5WX8JHaIW8DBtId7VmE1WWw11BKlfMl?=
 =?us-ascii?Q?m58czkdXV+uEKBvpLPf7w9o7vhu9kPax+WDXio/pY9RRy797QCaRn5TXu925?=
 =?us-ascii?Q?39LQG/oG96TQaq82f6KSr1CqfNSEr1Zr9dQZynyfpGtWj8L+8TAGGgpUHjLX?=
 =?us-ascii?Q?mnO5KKNJS/cuY6NJC6cnugkrfouS5EYDtSmn7wKqo0wZphkSFNUKDRJRFgiW?=
 =?us-ascii?Q?ODycp5DPS4mdynwxpo1Zp0Z/oh3CYCKOzwGccHOOwwBwlGdTWUpZRm7BBJ5s?=
 =?us-ascii?Q?W5v1rWTlIisuuOAPUYrB4qZF856LgOm4fCq6mIOyVXXgPXx+Unb6tQT7TRxO?=
 =?us-ascii?Q?p7DPDwLNh2aXoqp/+kzRJqTRdhIcI1Tcx7sWdJi4mqPLS4KgHgHvIpDnlBWC?=
 =?us-ascii?Q?4Q2CEGpN/NasGDGxbfHgHq6qvd+BznZcCouV7GsiQDnv98o9Z1AKzknF206R?=
 =?us-ascii?Q?r+3pUu+nghNphJBFgbc4nrdEAxJi2cLjib5jpu+XBDvjUNXsWdIbS1VfKPSH?=
 =?us-ascii?Q?GkUCHi8gUSqw45AUCwxu2zU/ddYEgNNExBmHJu4Q+An3bqhGQlDNQBVCBpWc?=
 =?us-ascii?Q?Qp62saFtwpHTNyFvoMgyDS0sw6UtygZoLsz6bLoaSwNrB8FigZtoVdiVUuH+?=
 =?us-ascii?Q?+A/et4RLaTrycclknb6bWQvKVEMmsn22XHfC47bydx608QZL0ZM2FG2G+ces?=
 =?us-ascii?Q?dsVtE193X9tg9Kn1adhZ9QKA8pqbkkIwqxjYGNuanZVAbBxBLAWk/nH81MqR?=
 =?us-ascii?Q?8+5hMsdG7c/psuaExS5J7clndoviOxw/PAubfaJD4d1a636CtyqzMytYwdPL?=
 =?us-ascii?Q?odr/wjQ/4AEA27duhsokgO/Re2W03o8ZGke6nSMDBULcO/DSa15epW/XCEbo?=
 =?us-ascii?Q?ntuda3xVxpLcW4fIBit5trktR5kHU5I+uOfRffyuRZKOU/SgDx6nbxaEYgnW?=
 =?us-ascii?Q?nGjARo8nNdTxVT9PcSpmBWPMZ2+IwfTfpzQMHcZnTbWWWoah1V2zvDhj2CSW?=
 =?us-ascii?Q?ce5G0muDnww47SGI1VdZ1GmNYaezg7K9M9d6DhDB2MrdRQ6PyWo5lTItIEVl?=
 =?us-ascii?Q?l26CQ1TGyAZu81jNfzwnhdLQ2AzNpq2Pf42bcmHvmxVVOLphCd6Mhk4nNc21?=
 =?us-ascii?Q?sl6h+QdHUZIRfXj6ypwvewRf0M7t7AmAegTU5CcTlx0GzY0HfWCQMA7hHBFC?=
 =?us-ascii?Q?QWsWIk8fAWN/nkw6/Dgw+lSQhw1LVVVKnVnV/DFa5SOEocvcTRg6VsTx+oWX?=
 =?us-ascii?Q?mqEATuClMJRkbw6I8mL90TUoXlfUsR01SCTyw3Hl0PjtzbO0BupImOHlC56r?=
 =?us-ascii?Q?3fauG0jZ9Sla7IgiI12shQ2HtCH/Ai8pMFKMeQVzUKY60JE3eF1hSgK4WV5X?=
 =?us-ascii?Q?UGDm3TMFI5tcx/2JxcDB05IZfcFP0gPe0sqqHjrj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e218a771-51f1-4ac5-a236-08db1af7a4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:25:12.7100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLM80VG03KYjunFlzmz1Ik6Jvef2a9vyiipvzBASQpeOQvNdR9cMYLEIS2XRvCSRnvAjMImefc+Pz8sE1VHxAw==
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
> Add replace coverage as a part of user_copy test case. It basically
> repeats the copy test after replacing the old ioas with a new one.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
