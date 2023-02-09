Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED968FE6A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBIEUi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBIEUg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:20:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F72A2E826;
        Wed,  8 Feb 2023 20:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916373; x=1707452373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u7/aWh8drFEywB1LXfuI6tYGFq+uw7ZP4i1ii0TSC9I=;
  b=IKFHjulA1TjFQMBc1vE9+t0ykFNB7irMSWaJD0hGDpnEod0VUaFzzO1g
   nvzU1mkEr8cHHN0zJhDELOcIlpRUsqC4RbV5eUKQjppA/3HGZPk7SS+Od
   76CLunnB499i0weUZqVG/nKKWbMVKUIAJFPuPGXbqcKLfzzeTSTj3eq/c
   B50c9+Blw3U8JXXJG3NN45GIqreJq5ysmN7Fkx9HoKyrk17N+H7CnPsDu
   ViTwSUorNyPQo5xpSKdNq2/ZTNK6WFd7IzUQJ81XLTddyvbgqQh9iTtHZ
   6+oPR3w+XWmrkRWfmlKWIEVtsUMwbHRqCrE7oxdBerO9nsSO6aHi4PMlT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331294743"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331294743"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:10:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="810186216"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="810186216"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2023 20:10:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 20:10:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 20:10:06 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 20:10:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBk0T5sk+YMt6+7b/YBrcX/UAuu7hEW/rZD7z1uWbJiABOdBqVsjqN7FLQRopGzLcWF4Dns5mXniPelouoQ5dxW+D4v2AyiJam7iVh2Xv0LLsGJrCvIQE7/hV+LfUDsKuEEWmTLKZ5BO6kB6hnI98uz/Pd8fLAXnExHNeLkY4yZmVcMJUkxHZNcK9nm6Es5HBee8JR64erROWqFpBA2RudmPwC4Rhvw4gL5r9fOKsNlBCVP7q02fhSsXDgEXURjQyFLEJIx8xtgxpZa2122CbX2h1+FI8Kv5iHuxFcjpkfhd+h7rSWZrCkE9PjZb5EiGpVsjWhWU/Qg7TaLOd28Vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMTpOTBo0QWxr4lCUtVIfqbTYoxt1lagoT3q1YoGSac=;
 b=bM+KFg+yAwT/PV9mxC/HS/9z7bGi+GI1bXh1eAfHI1AJ78V4Fbqz3LVpleO4pT+hcu0KQbfaX3ruDey/3OIE/tMiOqw4TwLCewFE+cuyci41t2FT9JYenZKm4q4VVMjuUU8/SmXbgcW24lz8fIWBBDVK73UKDXOfLN5QYNq3djt3ttVHDpie7k5iVo7/AEJGgtao6BrvpDT14cUd98w7zH761udye02gXzv4KMGem6aWmXpm4IrGYNlErt/OxJew/BlUAG6C5WSsT8b4SuTduiVerbSEQF/sP3mDwSnQe0VYzL6aBaQNFX9fKjXgKpWAeAT+ZGF2e1bkAeJSPTvv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 04:10:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 04:10:04 +0000
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
Subject: RE: [PATCH v2 10/10] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Thread-Topic: [PATCH v2 10/10] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Thread-Index: AQHZOzoS0Bls524n7k+sAm+muGsnhq7GAZjQ
Date:   Thu, 9 Feb 2023 04:10:04 +0000
Message-ID: <BN9PR11MB527687E27FC35CD842E4EA7B8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <59e5eeac675172ab1cb07236a3eb3e166553fe71.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <59e5eeac675172ab1cb07236a3eb3e166553fe71.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6995:EE_
x-ms-office365-filtering-correlation-id: daa858cd-1d33-41ef-ba96-08db0a53857f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ee4zWnnVCkBIWtMYowVNFv/0EHAKiFVnyN2t5Vk0rE/vlX6EsUC6XdQ/umfjuvwmiCCzolBYHZjo2gu9Mrud3eVFBJPA4OTB26DzeU5qW1CMd3TSkqD6ei1bq/BLe3DKsMcdPwygJLfVAisiQtJjxUEDtyggPIKAxQTJQvvpLgdfw9z9D6jCs3JRlTuGZcIgTmtClTmQbq6n1gQrlJmGMHpg68kmpoWwYPbYWzTLoXUoGOCqJTPxrXJQiYjVZ3Usoc4H7V5DN5AxrjyvXVNnw/oZ9PVMLwhOaQARHLv1Ol5IDHToDOphi3lXz2k8lFQX/ssEVy6LMOYipJxWvD7Cb0800cZlnKlZD44HAs03AnTEBfR7VyAyd8Zu4i+wBKhWHXdMHFRqh1CSf2cXvNSgLHZGlod7bejoesxMRAFWu/B8By3+7b5e44FllvqNeYRkzjGyJK2unaWPvugVOI6opJrztgrH+SRIFSFh6fYpodLbtfBh/t/3YpC7KalHn9HIomaAfRreH5fmBHJ+o4iayD7uSJCUqhyZ6htXdcS+CM6vFheIXZ153Uf9SZHKCpJvsSyMZ5SJptvkOCpi4jw2uJOJnbEJ5zhcd1Fr3j2hirroFOoUpoGbFtdK1o6hTlxw+d8/bMYwgcwHpCSQhRFEVd4xY/2o/DbhT827IBJr1eKsH2OGW2Ws3YVW4DIQgPkWt4qepTCcw6Yg+9g7k3WGnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199018)(6506007)(38070700005)(7696005)(26005)(186003)(122000001)(82960400001)(38100700002)(9686003)(2906002)(83380400001)(54906003)(316002)(110136005)(33656002)(41300700001)(478600001)(52536014)(71200400001)(55016003)(8936002)(66446008)(64756008)(4326008)(8676002)(66476007)(66556008)(86362001)(76116006)(66946007)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IKvLyJEDX0zOgJeXkOJ/tNow6uBwStyrfM9m0acaJTIBY1+9DuXWpzMqMKMx?=
 =?us-ascii?Q?TRDjVekaJUgPYe35NhSRQAxjzqXXcQ53yPzSb9YcRDUvE9ZAd/8rIOmsmSOT?=
 =?us-ascii?Q?3HBs/eD3j4ke+yaZ8bih+lNfr/KJIeiRh6aVzo3j1hC7tpLb3hA7oQ1kvbCe?=
 =?us-ascii?Q?mbZLn+uOOJ06DeXh1b5pZrhYu3m6DfDiq3oud8heRWc6EJM3ifLwq/F1ufWx?=
 =?us-ascii?Q?VtAhxDZWo4Odz+n3eKz6ClZPaU9kurrVMU4f/YzDsjTTxtSMbIIj4SSU1i9y?=
 =?us-ascii?Q?N7vbG756DlHVOnieuys4Q3MU91V0fWB9ow795DKhz0H1im21RuaxEt3dLarx?=
 =?us-ascii?Q?fAs0ZILJZFexE80SUzR0WYTW9+ZHu17dtMToIg7spzAG7dFKjQXm7xmerdtu?=
 =?us-ascii?Q?qoB8tJjbjufEfr1SksyE/4J4iKKaOw2F0aQpiIa0AJV9giGJZ3c1XQoQzZE+?=
 =?us-ascii?Q?sJN+9XdZG9bcSJtEPT73NspON/K/VlT15Q3hcqxSTdjfZEMderDI4PdcHCwc?=
 =?us-ascii?Q?yspRZ/6aRf0JNrgyUNU5fR0mZ/pZjzjaVBNkor0PxLMH5JjqMNH/1E3vLeT/?=
 =?us-ascii?Q?gawOfLd3JpRO0CGdsu4Q6oxEV3aBKeXREfYkNjXwUyBBifAR+fe3gCZAkdQf?=
 =?us-ascii?Q?VP+TsS8hHAPYAatBb7YpDCJqRkp8Ma/NvQY7lojCKlqcxmVZZyJhBslJkUWp?=
 =?us-ascii?Q?KHk1JC1OxKMgHxAnd/pXQgnqsPCqiZmCkxKiqj+4FiLTFSZdDyAgGCCZ3XS5?=
 =?us-ascii?Q?JEZxyYN4hdjSeahVh73EN/o6hxO9uCdKo/oeN0jmTwRv1LZjqqDF8LNTLUJ+?=
 =?us-ascii?Q?EdQUK25CrByKNfn4tlqIdcdX7aSbaKHCIcbYXTEUBAG1ETuOK7feE8PFzcX+?=
 =?us-ascii?Q?r2gnc0zzyPtjwccVvMDgD6iXX5enBLuRu4V/9DyTEzGmx9KMLE2TtPejBaaD?=
 =?us-ascii?Q?5SObEBON46p5WF31NVcwY9/BS6ihtlQOHX69f9y0Blq95eDVHLLM362IXpWZ?=
 =?us-ascii?Q?MF19bJVoUrx+DxKmqQBqqg7GN5PGQh5akpJYEV5iUuXPvXWWmr2u9AhBZ2Y+?=
 =?us-ascii?Q?lSGHu+/zEyZhzKNOjEO0/D+Qa8kBlSto8zfvQn/sri8ddJb/qxS84EMIe9cd?=
 =?us-ascii?Q?7imCNqoCxfUo3UaGjrf8TrqxhJ0IioFreQvdjdNkCJjfo0Tu4AALnRc1kYV8?=
 =?us-ascii?Q?F++zVl/gjPmryemvwlfrVafLrFknM6lDJ3146sUTovAtBCeJUn2l54Y2+WTm?=
 =?us-ascii?Q?SPuJdSq1H3DgEWSyviTJX0DYdxdzq3pEv6pWOq19e0fDZuwnY2tz0Pr/v/RN?=
 =?us-ascii?Q?eJDURg3ESuBnzZJ7/cGhqrfPqZWvi+zn+HYu4r6RJ4afETTq+gQdlRECZpZ0?=
 =?us-ascii?Q?9VT+oYze680/nk+EQrv8pKkWYZT+oKFJr0u/+QrnyDzg02U+IifOL1Rwajkh?=
 =?us-ascii?Q?EMHu9/WpcG7oNH0tY7vGqtSuRraquZOQIDktVc5JGcIe3qw6P6WMCR4f5N7u?=
 =?us-ascii?Q?PdKoS2x+sZCC+oTxKlts/dyOLlrmBjF0gLrzQ53pt7KBsa1MOsmEqqzInolm?=
 =?us-ascii?Q?VIuVt3DKDsoyM2KtlyXt8Sw9EVNkmrgN0f8IIR5E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa858cd-1d33-41ef-ba96-08db0a53857f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 04:10:04.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5ceS0/DqV69id1MVLrxyIkgbD0/B6jo8evV9L16dknPCXP3cXhBEWlQ1Y/tH0jWIYvjjSDMKN6N7c9U3ucD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> A driver that doesn't implement ops->dma_unmap shouldn't be allowed to
> do
> vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
> range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/vfio/vfio_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 8559c3dfb335..c7f3251ad6e5 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1543,6 +1543,8 @@ int vfio_pin_pages(struct vfio_device *device,
> dma_addr_t iova,
>=20
>  		if (iova > ULONG_MAX)
>  			return -EINVAL;
> +		if (!device->ops->dma_unmap)
> +			return -EINVAL;
>  		/*
>  		 * VFIO ignores the sub page offset, npages is from the start
> of
>  		 * a PAGE_SIZE chunk of IOVA. The caller is expected to
> recover
> @@ -1580,6 +1582,8 @@ void vfio_unpin_pages(struct vfio_device *device,
> dma_addr_t iova, int npage)
>  	if (device->iommufd_access) {
>  		if (WARN_ON(iova > ULONG_MAX))
>  			return;
> +		if (!device->ops->dma_unmap)
> +			return;

IMHO this restriction applies to both iommufd and legacy container.
