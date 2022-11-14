Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354DC627695
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 08:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiKNHqs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 02:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiKNHqr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 02:46:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D21011;
        Sun, 13 Nov 2022 23:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668412006; x=1699948006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WlrX9VLqIsTqZJYHbvoXTNG/V13WorOmVf7Xyjj6eNc=;
  b=JUx17c6cr+EV57uS02rK1EpcfiKMG0QxWy7VhKqk52QR9SnPNr1wjwwF
   B81XED+esl3p33AxqHxqKtF+I2bHQ9Jar1cAnfGQjkBrUnSd5vpPr3jKV
   cnQ45EwOzUmD6W2B0xJPeESZiS00lMa0C5M+qL923t6kD9iScwiEKISog
   FZEiAFHJLY15O7Lhec5Ie5tAjiyDSgpNNx7X/Kx22ahXnPRT0SgbL4Hwb
   UgPnEpAZYwH19YNIgkU/R1Umbu8ju9LpRcWDwZZDrfXHMcgYo8DTrJUIp
   uwiGYEEAl8PkVyt+BF4rVxlvJvaLf86YW8H1A9gLoTKVUOlDUcgTR8z22
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="376172929"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="376172929"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 23:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="727424780"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="727424780"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Nov 2022 23:46:45 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 23:46:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 23:46:44 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 23:46:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chs6yiZCx3X6XYNS6Ruj9DG7uJxkxNz15jVO0WnYYd9k4vprentD4/SDOvhZGPNUHY5oVSE7gpIhakGidBTapdUNaRVZ9Q6UtmqDiNutT0I42BioSc624LA5eY6Kb5R6++soVDN7BWKBiKwwpvNEqIHmxnqUlAbOBSIH6nlux+xhA+lc8hbcehrJEQldY7GbDGuyoTz/UUvWi4jU+8YeB0BNaD9DcKaau2kPM89oTsWSo+dAgwmQa4QOrB9FezCldo6cGKfalfNKYLUn+OpqSmr2ubj1AZXLb4XuRF2Lh8KZnvxTXUlLRQGjPJpCFvLzjOnl4Cvikc9OYsKqdMvqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmuFiCdULwRdyuQB1/dit9yTb3143QUUyEEJ2lCWVNM=;
 b=dxAGvbvsmg4wqII3OuISlcooJKC1L/k92ZDvF1Dif25DEAsI37fUrZhFcsjf/6E8Vj9KCdnFDczAqiiQpQvpYn+WepoQOOHr+Pl6KKJTlfkJCvx5l3ZfoN0ymNy44QYqNlk6YLSsqA6wEzhn1poflU8Rhb9wN3MiIPR0OYnwzOwOz6q62iojQ/+nvaeLF8EyJQfEkPwqDmDXXHXM6Z45WfUlQiRQHaS129BHhf8rfBQNr+mFIT7f579A8pTo/nLR2F2qa4h7cQ0D0h2gQ1WkNo4QLTC+6igSrTm1Chmj9lP0Ih18NlyFZn2I6lEeppOjPvUmaHrDYXXGZgah3gCQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 07:46:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 07:46:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 10/17] iommufd: IOCTLs for the io_pagetable
Thread-Topic: [PATCH v4 10/17] iommufd: IOCTLs for the io_pagetable
Thread-Index: AQHY8wwAmLWNKApnDk+3Pc+6gJCy7q4+D6fw
Date:   Mon, 14 Nov 2022 07:46:42 +0000
Message-ID: <BN9PR11MB5276E095689615279EE962808C059@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <10-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <10-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB5780:EE_
x-ms-office365-filtering-correlation-id: e313efc6-ec0a-4694-a801-08dac6145efb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OqnjH5MbpAyYWk7JAIqikts+XW6lCGXKinXiWhSfUGKOfOfXvSWO3XoB7G/sj/p6YTXH3yheoMGtSWniScTw68842QlIEqMc5olGkNbIQH/gV9St7OfJsUxBaPf9OMXUEmjVJrHcYH1aksX2TEhos6RFRmsRbeShGtIgMdEaCWoVRLF0jfu8nelzn9HM7P/GeDhmMj4iFXj1kT9UqQz1zvKSfvv162EHWUrZu0shH5yp68yXMeCY8ayD2dgaTLVltaLZmVVWwylir3cCrtmWGEjdvkSV9Oo7tqZMQpZfSVi+qgWfRFXqCMMrKvNoHQUtBCBfP/1p/S2vWsHq05IEzSEHKGQQSasEWviGYmD1R3bQMbwgudp8F/s0lNJbiOpImDkV/EtrOMA8FX8gnYhoRbncMcMckgFKVICw3OcA6jwrtuN50rXHTNy9TcU27kfzFHiLlgdDg/g4sFwFNZUDRq2+UXDLRqq9KHgg9ei4uos+DuswPtwWYCKhGAZg1xCle2Nu3qA3NCVbsXkuepqON4+wB1JR/R0AkBRjxv+ZLNYdnOBHNrp8gk3kujn3R5FD/93XGe5vbuAKbYvZkVHwHhQLxwabYkznX+bvV/nfgmNR+i/kM9xHOtHTATue2xjaq1oek6XdlBJnjeu6xmyeJIqmnJpQg0mGUw0Y4g9greG7mRVpUtRu1ygrr1k65FEe25OtqFjSXOQCuQ8NcIqjYktCl7NDxnNeHNpIm4Gi/ZLam4Iz4IF3NU8W5O8JcVhSzA7yUM+NZQbz+QCosDw/UoJZodtsKA9AFgOvwjYmG1E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(478600001)(38070700005)(33656002)(921005)(54906003)(71200400001)(110136005)(7696005)(6506007)(316002)(52536014)(8936002)(66556008)(66946007)(7406005)(76116006)(4326008)(8676002)(64756008)(186003)(5660300002)(7416002)(9686003)(26005)(66446008)(41300700001)(66476007)(83380400001)(2906002)(82960400001)(55016003)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TAxAFb3BQz6oL1QT2SDguH8V+QgYBQk4HhPu1al9mzqdI6h1jfe5NqIbhAjM?=
 =?us-ascii?Q?OEvenkkeJtPUS7lPcpYfM0M9agLK0tzXfVkY0sbmtfvUbmEI9st6Co7m7SfM?=
 =?us-ascii?Q?xkvwn3eMF1Vr0GLJdVDOWpqwTkUEpP05OXon0ZXxxD9njD6t61LWfGsOMrzO?=
 =?us-ascii?Q?FkL1KsdthgvJgxXEkO8ItnYs76h7vPfDcuQUFFo0EevkJ3VakKHw7VB+SmoR?=
 =?us-ascii?Q?b8bI0Up94KO0iPnsBwZaYob7RLUuSPa2UHuGa05gK7BtawpGGamhxuLoBosX?=
 =?us-ascii?Q?jtrVQumO+Y6DSXN56aCSXuays8rJFVt4+iF9vp2anT7DWAk6Pbvf9COl+Ge3?=
 =?us-ascii?Q?tb7SlZ4ftyeiqGON09F5rb/V7kuqka+9RmgxWYQVR5Ow837cJLcQXn5Lfyt8?=
 =?us-ascii?Q?ulywCn5tAIOiFaCTbntyso1Swl8wwjINV7P3LiEQOkuT00d+vAdSOM/2z8MI?=
 =?us-ascii?Q?UMEtzEVAiS+p/pYHaHC9mfgUUAcc1E+CCGIXsMbxq7qBd8KA793s0mkoP/7d?=
 =?us-ascii?Q?Lt/eqY6ZI43XmW3v10LpMfPIrYjG1/mJI5ljWDWL/TcEkaM67a0T1ZyYfnrA?=
 =?us-ascii?Q?V0Yj23Xsb7pkQmkFJDlUqsoOQVWJdGi5s6G251nXHN8t44G33Ez1uvihJSJN?=
 =?us-ascii?Q?Bdu6pDQSh1DvtOWbXkfVP2VYPPC3vj1zWirqKgAzWSmK+9yHkqtSuhqDyLfn?=
 =?us-ascii?Q?cHq8hanpVbDW7huHiD/7sv7oq20xL1K5COnFY6jBpyEapPuaTrhQHvip81Fn?=
 =?us-ascii?Q?gpWPQLToGMNhXI86urXV+p1CL5ZiiH0cHMkiioLdqGxK45v+pKTMK99l0DHD?=
 =?us-ascii?Q?4f/d/g+iZNKxqHBQWAXFFe7LGKZtvmZ5nm7GyUI0RTgBWK7MemXNNc7Fo0W4?=
 =?us-ascii?Q?STTcvB2zWbB5qBWpnLBDsKl9yOJRBJXHwyi1RJ+1vHX5y30LBSXTjDwjkloa?=
 =?us-ascii?Q?M2kNrVZnRKghuulfET3XCJBEf3qhUXiAfJwjviUoRQ6u3+o6F/z3UFt0mYxI?=
 =?us-ascii?Q?h70Xu2hWhgSiGldkcL95WF3Y+nhBDVUAlWt3oTdRGy6lenE8OYYyUn1Jx0sQ?=
 =?us-ascii?Q?kBy1ZbbAUGeuyWx7BO6Q3sPC5fd6BMmyu3rdJG6TJxPRg4Sz9I3YGsbOW34T?=
 =?us-ascii?Q?qEAppI7Kos5wOwDxV47lUgA5a9z3flRL+yMXTEGr9IxlIyvlxV2Or4wyxsJk?=
 =?us-ascii?Q?FziYNUGO4qCFJtxQSbEGEZrueS3mmn1ql5S7ARbjYI4beZhtN/QzbqcVegTv?=
 =?us-ascii?Q?hSv1bZQKX+8z5aT6FAGyjzAlxxbpNxYfVYC+xWc1d8tT7vj3Q3GqY+K4b9rp?=
 =?us-ascii?Q?SYP1WwT1DK1kpXGKjSw/O6BG4xPG7ovWMWeZBdG7Sh9c06WCEttz3oHfgPLL?=
 =?us-ascii?Q?7E8sJBEyTgeCQWV0UkK6o8GhOv6Xi1oHrf7FtkmKox8/49REQq2KSNXQkjZT?=
 =?us-ascii?Q?+ZagVIRonNRLwOnq3WjMNg8czsku3U0L32ESPfUrbmaKX/Rf7jthrYoGZm9O?=
 =?us-ascii?Q?2/iL/vHOXqnaYYDa+Std1GjP4M778ezxeqqezHErRxZWxK5VCwky1e8VFogQ?=
 =?us-ascii?Q?x2ipOe6C7W1aKcuAraDyz3PrQxywR4XFc0JYCf2I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e313efc6-ec0a-4694-a801-08dac6145efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 07:46:42.1074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+j5HqMdrK8liA8wYyNUsbA60XeDqr/hlgzvO31ew3PMMN4h9pS128haZuZJsfH281JBZPJl7maLrzpFQRL2qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
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
> Sent: Tuesday, November 8, 2022 8:49 AM
>=20
> Connect the IOAS to its IOCTL interface. This exposes most of the
> functionality in the io_pagetable to userspace.
>=20
> This is intended to be the core of the generic interface that IOMMUFD wil=
l
> provide. Every IOMMU driver should be able to implement an
> iommu_domain
> that is compatible with this generic mechanism.
>=20
> It is also designed to be easy to use for simple non virtual machine
> monitor users, like DPDK:
>  - Universal simple support for all IOMMUs (no PPC special path)
>  - An IOVA allocator that considers the aperture and the allowed/reserved
>    ranges
>  - io_pagetable allows any number of iommu_domains to be connected to
> the
>    IOAS
>  - Automatic allocation and re-use of iommu_domains
>=20
> Along with room in the design to add non-generic features to cater to
> specific HW functionality.
>=20
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

with kernel-doc warning fixed:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
