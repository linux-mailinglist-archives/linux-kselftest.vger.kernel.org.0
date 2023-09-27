Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556B7AFB66
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 08:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjI0GxV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 02:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0GxU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 02:53:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF3AA3;
        Tue, 26 Sep 2023 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695797592; x=1727333592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S6zfFbGPd7IgsJz62NtWVIO5wxuvdcLT5bWaHsOnyak=;
  b=MfZenjqI1qagb4UJzTLz3JWRkMCifjgRN6sEn+u2hW6Svh0qsQWXozt6
   NiQbXtnKA9H/C93ucHRMdzJPibJPN+RGrKQB8fVX4FziMD1kIzcHYxH1T
   ZmCYXs1ONudH2Pe9abBFnnC9cqMxiUI+sk+omFvSyBplfgSulF+R66LiU
   8xwz7xzif/MZRhfdhLwtO25au0LkTp0+6mO/ubBlM4QlmVIs+BJWpjSrX
   yBEe4Mq6jJAkbgpycWaWWaGo8Hp3q5koIZ4RImLpmpDCRNO75mwo6i9Ck
   wTed0DcE1tNfmscLeHu2A1N2/0tfZtfTXcL4xbBqA+eCHWUSdUZmYheg0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="372082284"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="372082284"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 23:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="872767154"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="872767154"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 23:53:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:53:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 23:53:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 23:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOiqLPesvgjcSZldtDPWr/RKPzDW4RBrz5q4czEKogMqjakkKNlHfTCUgnMB/BmrJyzZngFdMUL36Cp4C6SRDr7v+0y9U/A9e15Gls+0R/6VLUQM7QCvUynVyWsM+nodCE9w0EuxLZa8g9FcIipwYNWqsUUQxvM4+wLkwkiQHe4QwDXliDRbUesT0D0Jm/M/Os1c8Ioruxlj3WgPI21bESAzhE4GsFulBsa0RX5tbx4hdLxrdtAKzvv3/NiVEPxx9VRfZgSQ43Q3tM58/1shufuVdI7JQanhWvq42NSN1gkLU4irDkY6aoQBxozMTuXRCBBZ1XO1Kdx/c5VeK0vKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1msHR+yXPmDWHo0SCH+Uh6D9aVTRAOOsU8CX6XZQoM=;
 b=Ap6YP/6VD27xqjc93EYydpvJsM4tIQHHZ0XQCmgGly4B9lsBAqTEDhfumSo/tes40v7WWenZPVcw3iMU7JO/n/npmI+y02o82dDUDThp9kab2c1o92ToCyAjMRG/TIqbr9zAf5bSVqqIBkbNbxb+VzHB2iLQzD/bS6RX4Q562QjpJ+h72pAW+MjiqhTEfHdAFEwBfYtK5rthS7KkjDCrAtlcwMIbLSpPKcYR0U76g24WYs9ucGC/lhoz8p3fPhpNwNmHL5/R+SG522wnlWQ73lCkm2NZ6Et538Fzk+ZjLkmGqvXS4KZqxTPFKbs8tgfrtpu+dxd0fK6TBXotGsOVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6501.namprd11.prod.outlook.com (2603:10b6:8:88::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Wed, 27 Sep 2023 06:53:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 06:53:08 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v5 09/11] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v5 09/11] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZ7GDu5NzUrjY48U+ng7153fLb4LAuRTFw
Date:   Wed, 27 Sep 2023 06:53:07 +0000
Message-ID: <BN9PR11MB52769D0ED40EB2D3D8FB56658CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-10-yi.l.liu@intel.com>
In-Reply-To: <20230921075431.125239-10-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6501:EE_
x-ms-office365-filtering-correlation-id: 9619773e-edea-4013-3de9-08dbbf2667e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeud5WgcGpRaXcLJwzy3YhPo9GiflgVSveU5hqnuEyYMFBA/6SAG7eJPRVVGDlOeNdrtrPO5dT4osJTGKvvkEMFp8DHwAi6FNwgmOPCTdJMMRIEVBlx3KQL2XinB1vDNtKlt9JupU+yIusIvNkV7qMMK3u03KrKwCG3JHh6LVjinlkgzSW1ipIrdob45VvhivQB0n2Fbc95CFdEgXcaWiEjP6tJ/iC0/2fgQEcqz2SCo3VagM2kKtS2rd/qr5HePqFD1dtMkkPK1BOHKbUaSze8pfj3Q2Ywe+gn55vN1f5aONo1YbfyoBDuBaaGt/VlkLN87bxTlm6enXCWMpDfKce1r6p7IjZN0hizZOgfEzsIUdlcqcJeripoxOl1jS0aYCD0eMgaB9rH0Ec/ca7E3/miH9b/VwNh8oC4kFcV1oTQqhaZbzc0VnKtvE37S6TWgfT1m+NBoyL6AEWSRZ9NKSFJdLVi6Q4N2TQd/mcL+vWQmC5X6Ll/aumg/tkQDYZ++aHO3GgGqj4t11yfNmJzh4ZDPrMzz+aDpiKhfsutYfRs4MxvuYtw9AYrc++nLErDQhV5Wc3x/pDgGYkpZUQeyYji37HKR0D+AfpBvsya/aQXjv5aYMEKAFoA0yMLlgOJb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(4744005)(7416002)(2906002)(8936002)(66446008)(66946007)(66476007)(76116006)(64756008)(54906003)(316002)(110136005)(66556008)(52536014)(4326008)(55016003)(8676002)(41300700001)(5660300002)(83380400001)(26005)(33656002)(86362001)(82960400001)(38100700002)(122000001)(38070700005)(478600001)(7696005)(9686003)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Olve+/N8fH52GHbUbaO5mh3yU02MEvsy6QJjUcLDY8XOa6wTnQAJwtTjKtfV?=
 =?us-ascii?Q?PPct69PBbFPA1FtPYwOhjPELUuRaJu+gwWkmV2dl0xo6PBv/oScBYi6+S002?=
 =?us-ascii?Q?9kIIBUL658fdAtFlYg8+yv5TXShSJNzk4WAJ4sCW72KX6GY8jOJTw+7Irrvu?=
 =?us-ascii?Q?J248gwg3cYA/t3mdPBhfS7y6rd9/pEEhm6bZsNq99FflxVYGaR09UrsxghBF?=
 =?us-ascii?Q?1dUwQyYk4eWmxCn3cT4C85o13/CVJOtE/L4IY7QgcXVCRSQ/fFMLVB27+W9c?=
 =?us-ascii?Q?ys9166yoUbyaDVO+d0QjKFhsUIK1PgjvaPrf6MfAK2qyNmCBHPM4fWPkysn3?=
 =?us-ascii?Q?nOHkz0+fqcAJTdkOVKofZmJbrx9HGRx/QaVeRU3wSTs7WoqE+HftVIp93jtu?=
 =?us-ascii?Q?FFeakTzO8ZqVPQk7s939aqJ2Bi9fGXG43MA99+HwSfcpv5kcPyID4+OR4PYP?=
 =?us-ascii?Q?VjM7IOqQROEBoPfockaUc6t/ebNIlsbORfU2UXCvShINuXlxGWw3/5gUmZAv?=
 =?us-ascii?Q?gj+27InMH1rwyVKY6DFprGnnCTahH0HJuYfEZalb0NsamV3B4GeXRpsyzfBT?=
 =?us-ascii?Q?i8PPBPuOZRyeJhVh5QHbKpn9Kfn1mQrZ3pPOXRU8S3RNm05B4aRhhYA6DCEG?=
 =?us-ascii?Q?IWwv5F9exW6FLx5T3ib9tkqp+KoKH+M4svpr3iA1rXSVVtuE1vE6UgT8KdYZ?=
 =?us-ascii?Q?qXBue5UIc6P9REqozsBOjSRuv4qQuh093IhamgoDym8tqqWfYOARyIMZ7+wq?=
 =?us-ascii?Q?vaH2Bz/QoPV9BCbKEfFISPOR36e1wgYgZiOdPwGBybYrURuAjfPO/lr+3cO7?=
 =?us-ascii?Q?HZu2Szv4PjZpwBTQTpJjYyRLUKxK3rFtdA3yRvDSk4vdr9jAjkVTrfjTg9Jp?=
 =?us-ascii?Q?JPSJgcykFHxdrevLc2Wue8L4tsDKmyJab2QkxPTACpzZFMJUGNWyCJIIFaN4?=
 =?us-ascii?Q?R3Zt9+isYVZwe7L9C98MDeH5L4UaYJUQGibFfiT3Z6CmDVbxgJ+5kxyy8NG2?=
 =?us-ascii?Q?stytl0e6SMekEqRLwwyaq3vRiMHVyHdi7Yltrleikpc7+adrLKQkKf7IeFwm?=
 =?us-ascii?Q?w5qkgtPZntdJ0Gv46o4BTMJwwLqllbz+KksYKWpzTyyzaGLNwG4oPocGo8iT?=
 =?us-ascii?Q?5kd1r77aj9KJ7iii/Iokv/R5p8wjmXijhZNWFW7lXva3WPK1S9sI4P1Bh0lb?=
 =?us-ascii?Q?zAiKY0jPcFeTNxBSumotJXbcVut5kz86GhiJ7R6yCPYwT57B5QTXcmG76oy/?=
 =?us-ascii?Q?Rlq48+R5fLjWm625VfAZKL4f90o2DD335DYWGAyinFOtLM0OMECx1yK1W1rT?=
 =?us-ascii?Q?IrhQHtM/Rx0/feM+uhYOebeUDTaM/LeZuq2zNsvkY81urQHuGR+yFJkiqRxd?=
 =?us-ascii?Q?UGrc2uWIFOFP3jO0LeuL3/JAGfqYwtOZX90koqeAj9i5eArBnpj2gXkFYgIk?=
 =?us-ascii?Q?EihErT0V0hEWDTDoV3Yzdr3A1s1nhfkmrub67Ht8KWuG2n/eQTM5u0HuJjdO?=
 =?us-ascii?Q?WSI3/bm7UE5XE3528yXjluXypbwtBC+X+1GDSTzl1/QqrcicznDeF5nZIiyj?=
 =?us-ascii?Q?4ksZEhzUYJ4GFNo1D258BYO++qA/5pondVxVwwE4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9619773e-edea-4013-3de9-08dbbf2667e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 06:53:07.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DS1EgWzTFy8M98JJ9STQcam7sNMRodJnw0cMKmxkEItYNdfQpr6neFegSSs4DBVe1MF5pi/DB4nIp8pLzwyp8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:54 PM
> +
> +	/* REVISIT:
> +	 * VT-d has defined ITE, ICE, IQE for invalidation failure per hardware=
,
> +	 * but no error code yet, so just set the error code to be 0.
> +	 */
> +	*cerror_idx =3D 0;
> +

Is it "hardware doesn't provide error code now though it's defined in
spec" or "intel-iommu driver doesn't retrieve the error code though
it's provided by the hardware"?

Is there guarantee that '0' isn't used for an existing error code or=20
won't be used for any new error code later?
