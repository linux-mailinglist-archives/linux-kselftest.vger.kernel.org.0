Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756716C6133
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCWIAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCWIAT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:00:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BF5F974;
        Thu, 23 Mar 2023 01:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679558418; x=1711094418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6oDYe0PWgKtfH63twKgB/WIAeXCYzQiJma5HPVBoxWw=;
  b=GBqXfqcIIgegMRKnS9ITYk71rB2KH8G95MXlm5vEYa4qLY9w57BYq6s9
   6Qem1r3RMnGHTvvWkbWdwfFaJPey49CLPgWX7vO3+fgR7qz+JEsmCoyLP
   NbyFas9fkOAQRvzASTesaVoAIpLzSCOO6G0qRHXgtqyql6qeFtLF2BGU/
   oFHFh5FD/26BBrFMbIgryIydBekvm+m6uakQiKA2rYgDX+Jj6wwSrV7q5
   EfzD3sMs7c8uPqV3kO6Bvon6Lp8tlyhXU9SJCRSLIP8fa91Pz9WkFCNMX
   6vU0zzgHSrB7pPFADMleQ9kcU+qOkTmdn3k37fGGx8xehlKEFDe3fXtiW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="425703399"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="425703399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 01:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="712562414"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="712562414"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2023 01:00:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:00:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:00:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 01:00:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 01:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWIRCfRLNz3SRbwVccPP/BmHNgpUXPranj+YIIJj9o/6wDPGmwgn/AfkBrfRiUTWAv6cjy2TGZ+IvHwHmfhaE0AZksL8BjLihcv0QfpBX/jS8i5K9gOAg80S221W4kVoZqFct8oxFQYPpdnuzxXF7UdilmULzYKSY1zj+vcqWzcS03iwtfC/qJsI8bkPysgC6Nr0liyFz+6ol/ELzYYgdYZny60KJiHkCqqKXX9VAm9GA6aYAFHODZgRNFf1XKTJlbwQWPbufzjXj4SxKwLHOk6rUVw+HUUnx/a1FgJeNco9WrpIJchDoIy7Mb92VfdVU2O9wzfXVp7PROUuAqX80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oDYe0PWgKtfH63twKgB/WIAeXCYzQiJma5HPVBoxWw=;
 b=AKy5BxpK8qpBh1NybWpxvgnfdvhkRVfjXeasriFPkbFVpFX9pYUxNUB/0GG889/mcuKFeIObU+ez9kkA3KCExvEEMRLrgRZGNzK4RT+fSQ8mDkkGfII32hUrU4W11qTcr+myDVZg2VkrWYwlXIY6XnREUBct6rgzfCGd2vjJD6nGYWjHksSn83k4+51/2AkDMldwUBRhn7wAmZ4Q0qC+SQRvwiY4F/zNwJcVeIuwuWaGLynd30si2cp24pVU5uAHnf2KDPjGPQ8O6YZN/wPaHKBlcFHkC2BVqYN92lrOwD+j5snRS3kMdaLalGdBjq0gahEhgTjCgQuC4XIH2dU+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:00:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 08:00:11 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 15/17] iommufd: Add IOMMU_HWPT_ALLOC
Thread-Topic: [PATCH v3 15/17] iommufd: Add IOMMU_HWPT_ALLOC
Thread-Index: AQHZXCl5HFGfpnlADU+kMblx7q/wDK8IApHg
Date:   Thu, 23 Mar 2023 08:00:11 +0000
Message-ID: <BN9PR11MB52769541EE4A36F9813D3F318C879@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <15-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <15-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6676:EE_
x-ms-office365-filtering-correlation-id: 001d95a3-2c40-4a4c-bc0d-08db2b74a0ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YO8jp76jtuEWs+FTC8TUMFadYNJp2VjPTECEaEtypUIGP7Yu4MYkDzVfGWGSzJlCy+yHHxqisx0jHknYOYRUBZxsCBwBkt1J1kmLGk5cUmNGACS/cl/Bp9k8RFBw+nNMvi8sF8nFQJa/3exgfZqoVZBm6KohC4k6cvIYcA52asoxPyr3xF94Zb5CBwtYAci9N6N2e8dnoOicNnXxChIDIu6xu76xAjyFF+ZYdClMEN5p0G9x8MaqOfg8d0qlPRIOfMcWyOwXcYQRj2ogUFGllf7sTMWOFf24wTnu6cXS2keD2LG172l50ele0DMUpPLQYnUl74+jlmcHhlNWR8iupifi4yjMB9ib8TdmVRwxOYRKcZPk7JeNqt1ysvag849HumH5rA1fg8AI9VPQTBjK2WGdtagB4jy/iW7FKhj/YaZv8mK16p43HBxgAyn51iX35gpO6USU4y4D4zHFjaGvq7PC8gqIaBI9HX4WbnusE2SJAhTELR3wo7x/hHPA688Cb6cbph8sETWhj4xmeZ0EUzDjGKdgiQY8i7+XaYSEPKLDYpozJRUSy/kQjMUIHjlUubs8bHpddtotvS3etHC5jsdDQzzg1T2J3GEQhYpZRQgwQbLhTJhCE0H1ErG/L5tywrovKUrbIGspZnMM83+i+Mti24JnIJ9HUvgKesX3fEeJCfURtKDdpEYyMXPdvCKuGhkV6KnWcYm/mNzO3MP3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(6506007)(26005)(33656002)(9686003)(186003)(55016003)(316002)(122000001)(2906002)(110136005)(38100700002)(54906003)(41300700001)(52536014)(8936002)(66476007)(8676002)(64756008)(76116006)(66556008)(66946007)(4326008)(66446008)(4744005)(82960400001)(5660300002)(7696005)(71200400001)(86362001)(38070700005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KKw8mPVo3chxL6pHNnohNdVpGg6bNqwcq/QIxTN6DSPG7pAA8jp7aRqcqEIN?=
 =?us-ascii?Q?vjy/64vpPvYPFAaRewfyEgQtWPTitmReZINmKBvSjBK3fKQdju2SH2sACT0O?=
 =?us-ascii?Q?CVfQAXWzd6NOUVYFAOkMx2NscYrSrmRYtkEKltcUjDDDb3IZyqnIyylN/8ZI?=
 =?us-ascii?Q?cptRrHZJUB2Crc9CuhxcMRL6EOPgrhrEryVtash0Cal2qgJIVqEBLBS1HJy8?=
 =?us-ascii?Q?dF7yW6yzmoaJZN3EdpVMhCYcVWe4RJktWN51m5114jtBh+VKLYlBOV00QGkX?=
 =?us-ascii?Q?q6TVclMCArFOOBW5nG/Lp6Z6D1BBWzyyu5ry8nNQF2/R0OMhLyz1GvMdDcWl?=
 =?us-ascii?Q?gwA3MP7yUyACf4VWYKDmbTMc0B97vPbxH4ioznXhNBdC6CeGbQhrpMRekH7i?=
 =?us-ascii?Q?orkBq//qu+l9XPQTsDMMPk9JqwhVdGGSAMFvON9QVl0r2DKZGiF3v/iLz830?=
 =?us-ascii?Q?5SXHawweGUR7tQnN4yz+j1zLwtum2RrWihCQRI/2G8FG+hQca3bMsBZ7LCcn?=
 =?us-ascii?Q?LUk5adta4Sfu2yafHFh13Nc9bJE46in5gg3JMagObpE4oldulSGeYKzmtKw4?=
 =?us-ascii?Q?memrGBE+aOanvF9Af96ywAR4dxn/m4zt//L7Me+pFXxSy9E23qnC/Ozlq9cr?=
 =?us-ascii?Q?UxfupGCXyKQlETrFMcKGj/5WLbndMMKkcaWPP3NEG0Jt6QztYDZGUmrfdiXe?=
 =?us-ascii?Q?DRZdwYxgGmLr3zHXxUyrqoB0OXBGuEClHBO1DOMXTNfHd7fVNJnEn1YlEzK4?=
 =?us-ascii?Q?yhGEzrTlgQLrEZIYg0ZvYq2i3VQM8OB/x05zHOjtpiXgAYFrGDU8DxtsUBzN?=
 =?us-ascii?Q?rQErWgx0jg9DrQA2eP2+c/CXQ2XHIi7Q/KV8Rr5U2EXhwBjOWufoKIyj9ACK?=
 =?us-ascii?Q?Gx+0MOLXqkeb/c128D7v6gwvl1Z7i4JmiNzCTscV0j62dZMU5YyLSmp9qXac?=
 =?us-ascii?Q?d0mtpy5c8kL0oHb0Ke5nTmC20hjXBHKKmujY3191v+UZMQ920G6wR9CeLAQS?=
 =?us-ascii?Q?9lDYK8C2A1E+kQ+OL5dtmPwqYROq7RX1pyaGjF+Ws3i/eXW2dVLHBwePwVSX?=
 =?us-ascii?Q?SBG+PlbrDn9mwKQNxltbWtruPIBe6VD1SNIswONrMT92qUi7jXFypn9tnSMo?=
 =?us-ascii?Q?sT4BQqaFF1UUk1A/HZ7Tjdw/qY6cfWpJlgGrXuwIhQfrxhnfXyo7K6XPHRjm?=
 =?us-ascii?Q?+Vj/+qfv26rMAcYeqmbEEJqQvXEkvW2UKqOuhd8gHFMfZNAoWmoFCe968x73?=
 =?us-ascii?Q?5d08F3k7dGYAsyOAxsld6W5hWN9sNkeqtrihLv+ts53WgMLkcupdhmFzUeVC?=
 =?us-ascii?Q?khx64OqC6UcISMaPSXco3Q5mKoi2KHXKT45O7iN2xdhLXxpNt3tCEAXbQzAr?=
 =?us-ascii?Q?EmlBurN9i0zI7GwQEv9ONa1FPJbqElb4i4Phco42Acgu/IkCSy9NZr3ZUQoZ?=
 =?us-ascii?Q?wJhmfLBubhS+3bJagHtsFXp5X/ZXDXZPX7PEB0/Ah1gORbQGsNpgAIi6robC?=
 =?us-ascii?Q?94Xpo7PTCECmYekxWwVGWRALzPDM2xOIKS8a7NZ+ltaW3YHxWbbiAFa0pld4?=
 =?us-ascii?Q?NQ4sUUeXieFma+V4m2LZk+p0hvbYZzkO+jZvaGDk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001d95a3-2c40-4a4c-bc0d-08db2b74a0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:00:11.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ahMazpY7y1zDAuxXjN1jRQMHZIJG5nhrS4/Ph5uFPgrLui9MTbXFC2x2EoDDq2/1j8f7Ek15lEli4x1yx+pPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
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
> This allows userspace to manually create HWPTs on IOAS's and then use
> those HWPTs as inputs to iommufd_device_attach/replace().
>=20
> Following series will extend this to allow creating iommu_domains with
> driver specific parameters.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
