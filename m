Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE368FE36
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjBIEGj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBIEGh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:06:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E705FC6;
        Wed,  8 Feb 2023 20:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675915597; x=1707451597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TpBiPkQ2Gf0/RhhZs8vpuWaJB20rMod17XKLzbYZcKg=;
  b=mjhH6ZWDbJGucolhuR67bT2xAiFZGrMUJ+g39Pii05jZugipKU4KcOID
   CMGUUUy+UVqCU1dfxe9qXaVCCpBD6NRk1T/kYzlBL5eTJuuG71JcZVIBn
   9oxNP6ftl5fXaa6yHVlTm7JBXoOJKZq18JHiN4AkXCA2Z4LXKoSU084eq
   sEhjwXJPkJMUinro8NWjDkGMQ84QZ+awdzr9wlYara7AMEB2woWdciTyp
   963kgGvS0fb8y5nv3VInRWsbxG2TILkP1+VFxK9WScnzS9NXI0wFJ7E2A
   BPF4e+HdFbvUQrdpXTu02yHjc89Ink+ZwJJAER5ibpOyINHh+vsE3zsBa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310365147"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310365147"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="736167617"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="736167617"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 20:06:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 20:06:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 20:06:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 20:06:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnZQaaI69UMU5ph10yw9+MBcOE8JphZ6Drh9kxQp33QLvRaPpqn9rMeXKsrlT8rtota0DBgCgRf8MB9hq0+Ab2wgLofmfUxu4xswCWeevIfZxsZ58Tj9stRQlnVM0W1pwelTUyX9Zsd6F3sU0rwrTXCI4PWlPVs+ttoMQD7rPWBfdsxo4fyo9/IiapevT4j10doyotJfoMo8xs2lEvbsUZ3HYBjMFz0xz5R1qG4ASyX+j2G1peDvo26yAMxP9FuEIXrgXpoYU3aP5vofiJa5uWv32wvk0O0CZ3cD2DNF0F2EMRVyaqNr9nKJmIsWXrzK/ymQrnp1G/i49fxtz3fDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpBiPkQ2Gf0/RhhZs8vpuWaJB20rMod17XKLzbYZcKg=;
 b=e/Kb7TEZEnb+9qLQrvH614L97XURpptny6aA0AwUIkucUFNHYYjPM2d/vKz3VROVqzzRn4trGnbI4S+Mflw7GUBEPc9LlStuP1HGnXyhx42jFAKJjuHl9IYte0lTz644+ITJRVLbnlexuxyOZY9HbLEnNHu2NgCHnpOzlcUFh4eSIA2prNMzvdpf3WD4+IuX8Q8hbrcVif9ipQ7luptec191qsQKs1Tx7HEyAV23ljeyAi6zkDdCb+e3XWrWIAdcvsWw6Ucl5q3ev1mhLrNqiG0TAAG2urMtSCoIBrVgllzeFuYF+PAWbtc1OSKX3zsr+WsZW7GKeqaJ4ryWiOZqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7437.namprd11.prod.outlook.com (2603:10b6:806:348::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 04:06:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 04:06:33 +0000
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
Subject: RE: [PATCH v2 09/10] vfio: Support IO page table replacement
Thread-Topic: [PATCH v2 09/10] vfio: Support IO page table replacement
Thread-Index: AQHZOzoQwehGMiqQOkOzSfAFJ2rAL67GAGGw
Date:   Thu, 9 Feb 2023 04:06:33 +0000
Message-ID: <BN9PR11MB52769B2848B659322145E37C8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <121b90a852cb53f3425ed0660173f12d15ed0137.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <121b90a852cb53f3425ed0660173f12d15ed0137.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7437:EE_
x-ms-office365-filtering-correlation-id: 92b34504-d745-4ffc-e11f-08db0a530805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNlv2xPleRSpSMWSdUt337CltAUWMItLmfsE79LlI1E57NCjOATClkeFTZYYQioDjb5sgYbUxPBkVckpz0C6BkZQaelSVEwNOAoz7MAWS4pUzGgJz8wSTo+sACzFwEqSmx4L7c2iGGfBb/otsw2y3t5ZP1t5KSGPUWqMQXb5sAfdCVcr0p4mTjT2I/E3WRvxSdHVY/408fh2VA6bcCXwGaoBdP5YIJXPUXTOcNdSkcffxgNg7nDSgRPiVyRB7OpK0CTzPhcurQ8rN9fOQiB4nbHTSGg1xZbc48p1dzlDh0tfpd7fpN9R7463CH5K8u4qNo7hHPnK9OnMFhkuMaMcp61sWFD58uDTxw5SvLBDMJHH+LMXybQ9WbLG5wTh2+ia9OMCez96WcwAsW4Hi8jS81hbpZ7pSsJfaCvjgVK9ofGo0RzQWj0V/2byErI2AXEO+vwL4vzAkVj+D3yKwBdKzHZzD/Vlt0hGuFC+qAjE0Lzlu4yhr0HPRKiQ+3T/T8AhIhHhSC0XZTJ0nD9s3B2a3Z6tWS9hP2VxjChRiklbN+Th3QIPwuHh7WmL6ENi50CTs0D8wdFRzPi5WrEUOHte0oFDQDvjEmILgGCmyhqiGZiN4PWhWTN/i06b+drUN5l0a6pc4jHh95b6oVGZU+BouFDAWQfT8wxcXIEB2zia1d4r2PHcqCsoFa/9rQ7LPeVkie/uyntFPYYlxtJuOej9yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(83380400001)(55016003)(54906003)(2906002)(316002)(76116006)(110136005)(38070700005)(478600001)(38100700002)(82960400001)(71200400001)(122000001)(66556008)(41300700001)(66946007)(4326008)(4744005)(52536014)(6506007)(8676002)(8936002)(5660300002)(26005)(7416002)(64756008)(86362001)(33656002)(66446008)(9686003)(186003)(7696005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KpTSQ+7F0Ypiuat2keJAsqe+NJH6wEXz9mG2OHQaZHzJfJ6AYDZqZLvcSeAQ?=
 =?us-ascii?Q?iCSfLwjQns9MEqwYu2++k1LueIGN7Z9vRHqEvmn4uub9JLrUgttzo6mtqyCw?=
 =?us-ascii?Q?HgYTa/dVmkGoHq1V4ysBEDmxsnK+TpB7wi+faN3rh26kTN0ebRTIRjPENGvR?=
 =?us-ascii?Q?axEF8E5Jq00bW24ajywas42zByEP49bNhUWBrzRkrTuRgBC72+ZVm8/mZnO+?=
 =?us-ascii?Q?YZd6jqyYJiopIRKhDrmkZ8U0N+FlJ1jCEvpqkQH9iVNsar4SV/pyQzx9sP7Y?=
 =?us-ascii?Q?nr4dTgWyg71b8vIyNOtfNy3I3YLemn6uVlk534UP5JTICCDzeBhFHfKZCWSi?=
 =?us-ascii?Q?Ay9/Kyk03OPztGRirNRc0sFiqyqIg0Mko3G9HVVLsai38VepJ/ugrVQLqygD?=
 =?us-ascii?Q?LzEwD2+icEEiIz59Cub9OlwMGXYZ7kWvxwdAbhoEg3ddMtIAO59ag6fSBiMy?=
 =?us-ascii?Q?7PVCCwjHgcc/IfZN3cXL2BfVHiHP+r3S6JBLFiMvffSoJmuHUhyPj4pcNnE7?=
 =?us-ascii?Q?aRoJnRJ3GcMxewUQhE0gHNLyq6y6/JxQp8v2FjMv3ra3Ts1Ss+7s1Ya5l6hP?=
 =?us-ascii?Q?tAP+RAuR+zLl2NLFNPkMJ8H669lljUXO4Zxbj7waX+BncOKyiJixOFMv3mAd?=
 =?us-ascii?Q?spzYZOfqBrSE7sOFD4/VlBFLffw6Z523sZZocXpkcbDAGcKeuk/ZVLOKRc1R?=
 =?us-ascii?Q?szlKtRSfY756mCPwm32da2Ul4wSfyQKYYDjcSlyjq7nP65MLvwc9UJgPSyXz?=
 =?us-ascii?Q?TCTXMKblIek7T/b5uKHjctelqiPqE/Ig2e2pDYkpa+dnqaOq2JhZMPdofN+U?=
 =?us-ascii?Q?zEUmsCfyZMSrzRPwbGCIW9iar2BeCHm6ZR6ZhywspP64IxF9x0VI6GNVMPEl?=
 =?us-ascii?Q?+DIK5zEhncbsDOTr4E1wmFoY41HQacOcnq5tb32CJtoTI/Xk7SLyTMVGSmN0?=
 =?us-ascii?Q?haviCJA3JQ3Bxi7iTTDSyMXwW8Ks1wXWUJgBE48qehE33p7j4WiIdj8cKvF+?=
 =?us-ascii?Q?wj+7RfilC+eX5WO1XwX7kqgUEuyM+8fe776XPVI73UWRGijuiTqbD1xKutnP?=
 =?us-ascii?Q?ifm5MFpCu22toyFjwE8duL469h/8mTLMmeePZvLmUMyOoS6Vsw7sgE3+ATfV?=
 =?us-ascii?Q?xddxhK3o7rw4dCMMszSnI/9eaL38p5UjRLC4jXRkItDRFH4/KlZq9a1UT0c0?=
 =?us-ascii?Q?OhC16TKRBD4r0FgUAo7Haei+OrBVK+k+GYHd+NLgxuvY9kttvxzm+R2+5cDo?=
 =?us-ascii?Q?LLSiB+GgMM/5+GlJsB6bFnpIb4ZxLvzQ9SbXj5WqPHQrzQ/k48C8appQ+VtU?=
 =?us-ascii?Q?jQyCxgvrVpXjNZr+GKAmt4BLfKoNW0lJjv1LYAHocA3PiPI8QngIQr8fFLVh?=
 =?us-ascii?Q?ay9JCvbHDgsdPMakqLiSx+iB/xPoJprgKPMbV6Y0YSsSvlVRRdvRBTR5kCuj?=
 =?us-ascii?Q?EAhhTX85n9vDTzu76LGSn2PCKuZdhqXoJVjdCJEUBrBpzrTRqWmk1beylm2a?=
 =?us-ascii?Q?/YOBp0y/ktZGrZPTbpJOqynTU++F4MYlOahKyMzk9jL4BQpUs8rTDoUQJqqu?=
 =?us-ascii?Q?6YTzlAfPQOJYm1iYa4oMHxqKoIp+VgykGTUdPvj1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b34504-d745-4ffc-e11f-08db0a530805
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 04:06:33.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buwTDftuiFgl/01I59pX8Bjv7MLqefEHrWdllutxYU5dYwMiQNiKSMFxbsMXBUwTQJc5bbJVepMNIUyGNCdsXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7437
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
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> Remove the vdev->iommufd_attached check, since the kernel can internally
> handle a replacement of the IO page table now.
>=20
> Also update the VFIO_DEVICE_ATTACH_IOMMUFD_PT kdoc in the uAPI
> header.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
