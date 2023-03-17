Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF86BDF22
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 04:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCQDDv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 23:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCQDDt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 23:03:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFED7AFBA9;
        Thu, 16 Mar 2023 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679022223; x=1710558223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B9V//uZyovALyt7i+Okf7KU3FaVhzVrnmXmMWmnLuAU=;
  b=m/WxjR0/CFSnMton7KPk2mGalP4l7LOBxZnmhMeAjl5xdj7eqBj732jQ
   +I0vmE5c/cBz8qg/7dV+Hs/k0WEWktUv4FoOgxTbzvG19DAIQSXqlR03x
   ZcwN5BHQtZ9aoA26NHkk6UMKGf393mtjp3jHmG7pudT+JJDb6M3qny1mB
   re9BtDvn+61pej4eFiFqMKKI9M3Gk69gryuYgxC/PeAJ5femdQtaCwj4Z
   hA9LIrPzPZl9MvlwOE3PtkCCI0dOCJFpzJQDOFfRYxGNQI6oPojPN6ZHA
   hgzha+hXnSXp4CLY7/0dX3qMJzXkp/9+W75XH1L++DIZNNscRX/AUH5+K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424438774"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="424438774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 20:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="803961530"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="803961530"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2023 20:02:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 20:02:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 20:02:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 20:02:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 20:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCjPNqBCeBYI6Pc5GuH1skDLIl9ZpWGGb4y/aocILRwkvtfswWNKNjF1nStB3msOwUVz3T/8F87gGMiZbTtmOzlCRj2kU8OkXXreG8eGPLeW4FmRrxmqJa/FDg85d/xY72Wn9ZvXdSPi26zZWlFj9Rj9Ui1mBvfWOF1kWXECdWh0vOsXMiSO83x/v6BUjDV4BEu5I914eq4ceCltd87ophlXOPkaOSTwAGin42Vm3poegJimo7hMEzUACVXyPOUMxgbmwg8tQkF485HVf8eIJqPLoOJh7fq1bdlRXNkUtOfqe6yLGsJEs5KAXB0gecTch1xnXEDc2U7CnykqQXtjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCCYMJBtV1i2HmP0ErGY26u40wgEhM7UDd1iysHf2jM=;
 b=liCrqFHhN63Sbgs6r/5BcpR9lprAVwqg3aUlk5fvxhBBkSZt5kmkkJgmFQhZqHdJ+mw5EH443bH+eWBbSIiKw5j0qeHd+SpKSXwG5PVo0XLfv/4sah3OVjbpAHLPPe5h+5qfPWItUtkHz9cGGML6G/sf+0tsYFntNiOnH+cOGhZM55DMg7LImkN7j+XJBhbAYq3Gu5fYl6OtqMnmS3eorgtTAGCleTM24FohiMMx43LggQC2oUeEp/KwMalYBaL2mss17UXuymiOQ1yh6p/QHs+yUGEBKxWpuOWHuPM8rY6+K7+24JcgldHHL1NwIam66/Fc1FG/TV5spwEQNWOpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5310.namprd11.prod.outlook.com (2603:10b6:5:391::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 03:02:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 03:02:26 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 12/14] iommufd: Add IOMMU_HWPT_ALLOC
Thread-Topic: [PATCH 12/14] iommufd: Add IOMMU_HWPT_ALLOC
Thread-Index: AQHZSLANXhC73ppY102GjnYoeeDveq7+aCgA
Date:   Fri, 17 Mar 2023 03:02:26 +0000
Message-ID: <BN9PR11MB5276AD6D42FA8FEFE3B69C878CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <12-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <12-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5310:EE_
x-ms-office365-filtering-correlation-id: 17e03892-20d2-429a-48c2-08db269409b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4IdmCilzw2PzeQZpAdmcguNkYk+rnHX01ZStaOaKG7GP+nOJ7I3KXPnoNxhzse3KZ8N86pSyPRvnYAZS9fzG7LqQEAazQaWPQFonf4risGKUcteu5j2N4d7kmVMzGXzHYO59Ny8LAHIJzxNBTlHTnFULmb6FMAprR1QvOvD9PA+0vvRlt+gYqJwnaQEQkoSx16UNYmlig08XUGWIGy79otmzOmFn7yidU1UCo+6NZVIrzvdq1k0hhuuZqvvse3WObrhINu5uXOdn6DvK32ZJsAFb+dvkQ8CnDsLfg1ywE+UzE65YwgjXFa9vZJdI7P0dw5KBiMxe7sAUSofehGyFZ8i7j8EbxanvwgHUf3AS82yl7HLDyk2eOCetLshJUt7HfGScj1Cfi98wBasj8PrMFoOBPis/faDlSxfFDzZS8cElTWHngt5Z2O8ytg0r/IUG07CuYCCcBSUdaUlNN59ZXBEMm0pqHnQrYobA1waZhwPazasbmaQRHyhJ4w22BLQYMCcfYKkzKyjLDdAZShAvOeeikfSRyawXHlSAwOKvZqhPs2ipBmEjFN+vD7mj7KMBZZQqHwNlRSUAvgoWBF1NYIRn7bn4gTZJrZLOkdOAtQsfg27HnEWbSx/fGS+flsZe3H+IJJwmvP8lIhv9HpAOrgZ5JyN8S1uSySmaWBnCq3Le6y2RLY84jCwEiGLivQFzL05+7iW8vNbKH6qvowCwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199018)(7696005)(71200400001)(478600001)(9686003)(107886003)(54906003)(6506007)(316002)(110136005)(26005)(186003)(8676002)(64756008)(66476007)(4326008)(66556008)(66446008)(66946007)(76116006)(41300700001)(55016003)(2906002)(52536014)(8936002)(5660300002)(38100700002)(122000001)(82960400001)(86362001)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e0NLg9bPKQuFqSgqsLI+L8OPRojRB6+JwFCvVT2C5jqITgdCRunkT7r6wy8M?=
 =?us-ascii?Q?mSieG9hIa7CfnwAi0RnG1ugpxKa7xp6UqrSJCTWZsmBPgtBnrIpbwAHe9jlU?=
 =?us-ascii?Q?/iRhSt/lU+EHCRSmXIjyiWhJIildWBKf/DYuBrFL589/vG2nXHRziguaa3gl?=
 =?us-ascii?Q?Zy0D0d70LH5dI5OsszcOQPFCsce8zrtvSnuTkxf0FtX31pULfQorn2GeWnpc?=
 =?us-ascii?Q?LNO+OJzEBkUPjqm00KQVdLKRMpur+Ss8lP2h2Krf+7OR5FEL5AZIomC2FO8A?=
 =?us-ascii?Q?45DEONd55U6YcH6khL99QXfus1JNG23A4C6k5B3uP9ovwTTIBgDRzfSbiBfN?=
 =?us-ascii?Q?tj7t9ybPKiCqH+1qmYAO5JPCGNATREbyqAxHNMgttOidoUlkxuhyS/gm3bhh?=
 =?us-ascii?Q?gKU2C/O8kkJzemT+PRi3kZcMMCKJz+hexra+7SH6YNwHM4H13EXyRskkZYF1?=
 =?us-ascii?Q?BGsv0wVwRMzqv38E7j8SrOf2rApx5LffSsY/jTVEYl3/WESwAJp+7mA/FM6f?=
 =?us-ascii?Q?J/DPS7riYtYy0gC6UJdTucwu3pY7HsroCIDtlHocTAA/g1Vd761a87yhYQrC?=
 =?us-ascii?Q?nTqvOFaxW1Jgcpd+clrZxA3qT7gSKx+0fcNZScn0D8S+wNf/VQXL+1CLZY/C?=
 =?us-ascii?Q?o7svsezSshmF7+ff6vityqP7btsk2C2/eSJ3LeoMXsKquEKquBmGkmXB8AWq?=
 =?us-ascii?Q?gIIYJnvKAyTVVWccUaOsylkec1ynQCiHVn3zcWUsiYpjl4AERixg6vkbVUct?=
 =?us-ascii?Q?2SI6Q+dVn4VXc1XHFx2EDRQzO1JM4WFxnw8vLOT3EE26Uy5kIyyVzjU4Kxi2?=
 =?us-ascii?Q?r2LpnPWBttZj1Izv1aYkRlAIpME0NqhtPBEV4HFxKUlUxlTdkj9tSSnZiLtH?=
 =?us-ascii?Q?Eh4aGi0pUWuE/z+0vtawJWxZuN+Oc/xKhofv2qPC1aoOCgJSTeBGV5EAbEct?=
 =?us-ascii?Q?5USgPP05f9D9tv5kmCP5Ys5QbGZsvQkBjQ4RDNP2NcfXoP9lFwCplz285Ef1?=
 =?us-ascii?Q?lmTQxk1C4AzQURM6rEUetjaQOjJ4VbWSjRr0er3K7SfXgWUkkNIVRfyDcNaT?=
 =?us-ascii?Q?afKAJ4q41MmC0O6wPDmjhVMr3FgR0JilGzepGv+lk1i9z17O9A3xW3obQIIo?=
 =?us-ascii?Q?UTCvWkuCFB1vcHzlFhkOZFsCagOXSMgjzxNzTAlgEGKIXH6StsR5SGt7Nb2L?=
 =?us-ascii?Q?zqXAzlsvOVskm21OevmlpXsdp1Y8uAcBmWaWI92pq+ms5eNJLYUlJxs2iZi7?=
 =?us-ascii?Q?43xH4c+vfG1a5u3ae2OLo5zXovDsurL6HQxRAqOzywQaluhFupvhiZPQAAkH?=
 =?us-ascii?Q?LzfCKr/jzUToHxXDC9UjHldcEasBUT9S4rQGGZFEl4PgLMI64oY1wcG2vYLp?=
 =?us-ascii?Q?YqkUt1XtxFhEko8kqi3/2Vh9gvu23z+rSOun/Yi+cnN0M8BPDD9uYN6xzT5W?=
 =?us-ascii?Q?n4N2S/5dacANEpCb2By1vA8IhPuxDR20+T0Z3Vs68pN234qVpKORQVJTD/Ua?=
 =?us-ascii?Q?aHiNULty97zqpTEOsEd0pWuV6L3HuhNc3pfb/nbtldrKgBnkA4VjUaqNliMA?=
 =?us-ascii?Q?VvSMB7Hcrs0J3svc3AQESE8nKh4QxCgu4oktYjU/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e03892-20d2-429a-48c2-08db269409b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 03:02:26.2414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmkliv7E/rcEaFgGHK6a33nSC9F8SVMQlFEQE8ByBGKL3yGraYm2mjyiJO6Gb0bwzPaE/+mdquzsOJfhSVvFKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5310
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 25, 2023 8:28 AM
> +
> +int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_alloc *cmd =3D ucmd->cmd;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_device *idev;
> +	struct iommufd_ioas *ioas;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;

miss a check on the __reserved field.

> +/**
> + * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
> + * @size: sizeof(struct iommu_hwpt_alloc)
> + * @flags: Must be 0
> + * @dev_id: The device to allocate this HWPT for
> + * @pt_id: The IOAS to connect this HWPT to
> + * @out_hwpt_id: The ID of the new HWPT
> + * @__reserved: Must be 0
> + *
> + * Explicitly allocate a hardware page table object. This is the same ob=
ject
> + * type that is returned by iommufd_device_attach() and represents the
> + * underlying iommu driver's iommu_domain kernel object.
> + *
> + * A normal HWPT will be created with the mappings from the given IOAS.
> + */

'normal' is a confusing word in this context.
