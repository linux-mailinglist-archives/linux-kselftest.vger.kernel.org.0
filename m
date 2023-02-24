Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E683C6A16A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 07:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjBXGf1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 01:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXGf0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 01:35:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BCC3BD81
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 22:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677220525; x=1708756525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oRUYWWwRUu5V10Xvr20H5etU/HMr+1ZIrjJDaVlxwn8=;
  b=Lxlj0g8GC808CsoSV+U9VaYYgPztuCkdj2KBaLnUMnzZr+cW+l/Dhjsi
   i/LnlSF868uY4vo+Uhtgx/ZNhgJVKCjHLJjYIQsUn2OcgKdA3gBafJATt
   cwctrhA9qoHQcVlvbbkk/NAB/oOIsWXoYWj0fxt76zF9HYZGRa7qmT61X
   yejduzhrUeR8fYFRUfPBQ6V+G7UCsiusxFyL8+8KlBgteH04hNucvLwNy
   OHZh1VR/EANDd6OG7qGu1QHAguXC+X4K8f9P4fTERACuD9PckSs/Gv8QO
   ZE4yB2C/UC3PmAzi7FcN0PLKEfFR5qLNyDSMtuy9KA1uFFUylqSXwrEBm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="398143482"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="398143482"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 22:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="846846626"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="846846626"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2023 22:35:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 22:35:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 22:35:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 22:35:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8JVrrYgEvQRgVZzx4mR4QAgnw6vDCJ3pkTEjQkwotSQomDvwftdrpTrV5iYF7ZnPoNQmgsvnGddk5a7dg3PNiqgvgRQ/5it1VgZ8wNNm1rndOGiEFSHCwDwQ+Ksegs9Pi7NR4kz+Tb4tcGWZuyvfVQgbSqzncAq7PC5arIi3i073KeWAn2WdTDsRmPocl+wsTvwKl7WQWzPhsH3zF3hIPRtX005AnkRbyk1z6GXtYxxy9IxRnrePspXXPZO5uQDbddcb3nIqlRXZsLbPZbb02cEVCT8rHbutrJ3MVruHM2aTX4koaqo8kyI/OpqIK71oKt4j1DoAS3mANiURCuEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXSVUSXmvYAe7QqmCpAwUztj/bsMYIgU01zh2AavjkY=;
 b=VmUj0MpPX4wR90gXjVpa79CdY15dpeKu21UA3iPyitA9laFhdGHnmmDn47wb5Ovc7397ILHZDlmuV8S3VIPyNpIbrQWKZ0MJIl0C0AZXhR1+O8wlc0ioFLVgTHD6PbxxdSBzsz6YpLg2JsCPRSx/krL1NxmZE/LzWysIr8wsDhvi66nWUBbqf6j89hKNhxkvqavAyhtDQ9mwPgPEQSXWmMl+eOU5TSMD5RnFEc1tKRaAVIusoegg1kCBeF2cX6rxecRgKxPw9qNoNsZaaJeywgXWvwsmpuOWuJAF602W1+10SIDyxiIi/FVFoGecvIHfzRuohXVlcNYaric4SFiRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 06:35:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 06:35:22 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 5/7] iommufd: Make iommufd_hw_pagetable_alloc() do
 iopt_table_add_domain()
Thread-Topic: [PATCH v2 5/7] iommufd: Make iommufd_hw_pagetable_alloc() do
 iopt_table_add_domain()
Thread-Index: AQHZRwEJjmcTUIufy0K/NtdPAAEd4K7dpBHw
Date:   Fri, 24 Feb 2023 06:35:22 +0000
Message-ID: <BN9PR11MB527686A5ECB8DB6B34E07BAC8CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <5-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <5-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4750:EE_
x-ms-office365-filtering-correlation-id: 4bc0ed3a-c4fb-4a96-8280-08db16314e45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2FhD93esNI4WNKcqiiEcDAL4CS08V/eHEVDtZ6cLvXrOsqegWv/o6l5ohccmUcQb4ctldUpa5K3YGNUNYe2eyhrG1Yj1OeHbA2BUgiSfvfmmI0OKdWlZWbMqcNf/fFoNTDJHYI0Elye08ps4eDAVQvyIHIkccY/esFCwcnwc2rxuljPn+AF7jW3kgwoRz2zT5m787frzc7+ZrGXlcWCaWDbxmmWpHzAKsa3/pYewIezfD5FpQJeB7yHivYIsKDVAdBAD196NLevsbvj70QVlIMpT2zAiNoxY6f6GzhXhunRu9K94AxpLqQve3OhVtcWWczAGIIAr9fiz5W3XxunGHNb/+37F09wwmeXjhc7zTtLwlE8XuUbB9p5++mLKXPKqG8FSo0RX+r+7ot2Efgjdxdgdhz3+qthZS/zhWT1hfabNgE7MumWNoU9Srd5rhALSRlfcm9mpEjPb4TL3bGKmP7WClVyR274yMcTkHHDgCfe9vq4psZUGZtRcaI3bcE/LMDpb9YtYkVKHVJYZiJfDO/YYZI6GHtsF4/r/ttiU5h3kP9sNDqQx4PidQpNoAkhR2ra6qDpZTd+SEd8FkWim671LAv/9FE6GCi5mBuhLYZ31IcFJr3rwUInKg3+lD8miY67txwr6atHi1i1dBHqt6+QxiBrx52eDe3wnBRhYx27hRcCOOKTm/hWk8xCPffywS2DSmjCdlzGclqv/16l5kwe8QAt0bcUE7dPe+FISo8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199018)(86362001)(82960400001)(2906002)(38100700002)(122000001)(33656002)(9686003)(478600001)(7696005)(71200400001)(186003)(26005)(66946007)(55016003)(38070700005)(66476007)(66446008)(76116006)(66556008)(54906003)(83380400001)(110136005)(64756008)(4326008)(107886003)(6506007)(316002)(41300700001)(8936002)(52536014)(8676002)(5660300002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fTJvsOP0K6mmE3CVCquRuqNAX1UQqClOZ2RDxfwMPXRN6DnIebENrggRTG8A?=
 =?us-ascii?Q?oogNXks4Zw/lb9fISCkrzbQu8wOK/MxGBuIw0Y52uWBhtbm67MTFld/0LKuF?=
 =?us-ascii?Q?yMFnGzCvjCGgiiweWaJ8s4ZYtWTD/9kxlymhgZdgt5UNES8TPVqZgA1B8tPe?=
 =?us-ascii?Q?dqm22UIcIUuU/SwBLjgnwp4NCJl9AkL8f6d4Nmsq4RdBDH5xTUXZLTwc47PU?=
 =?us-ascii?Q?EqJ1gdPpKQ5jjdSEnL4/1/n64holh2Egjl/tuZf6uM4tK3/iOlx9Rnssf1/L?=
 =?us-ascii?Q?9bBic16Sk6LDp8tAG4F/2olFuPLJ1+bwZYe1dQRNN4gFZKp7XLnc2MbfvDpP?=
 =?us-ascii?Q?BAgHD/7dtRJkjZrhBDOcZNbCZO1NCXv4Mu3Wk3lHeng3ybWMhCexr12h0KIn?=
 =?us-ascii?Q?tLnWUcs5laBG9GzOqfhSnGxTD2zdWtZGLCZyLWnfSe8yndY1Hm2tg5z0mi9k?=
 =?us-ascii?Q?rA2k/FVrW6pkHUsSNZLqtE0JOmVvY457hOlu3aE/zvYhEDmA1xxhUEr7JrYu?=
 =?us-ascii?Q?F29RpkrdcIGU7Bidz+9WLB/UooTxjFWkRqegVCoXtMvikTzObdgYH7q7eIly?=
 =?us-ascii?Q?Z8nix6iSMNQXzR4YYkXa15CnY3JBT080C8OIyAYguhi03YZPuEgaJcSK+f2I?=
 =?us-ascii?Q?bCjqBFKY9g2eT78mW9E0o75IqfTP7cZZJ0zGkjyVgKCT1xL/8g9ztGZ4Ad9p?=
 =?us-ascii?Q?ceIOQn1+4mceFqrZn+XrrUJsUgQ6McoLRTiGUJfcVPvrTtChmOdFTFKD7iNX?=
 =?us-ascii?Q?68f+JdmNtl/DyyGCplyyPI9UD0xlTy+hMyXf7V+zRS36EysnA2SJqdELccOG?=
 =?us-ascii?Q?QVHR3phZ0FTT0YFuyHW45piwEkNgBSh60lgW2GvJ6XvuWJCwQIdVyvagfyF+?=
 =?us-ascii?Q?FdEBzlYiplkJBFqRJtmeglLhaO9y6uCTz854rZmn35nRgSpUi1iHoC86IVjJ?=
 =?us-ascii?Q?8Bv83OaftZF7QXD2k5NmPgp1jTl+cwOfyp2I72HDEmtxYYPBzVExyGopeFF7?=
 =?us-ascii?Q?cA8RPJEk+v8VygrtTVPG+RSm/Z0bNdyrj0IiqtQ/MSJjhWkNk/HOg+FcImmF?=
 =?us-ascii?Q?tk2C0CWhCftc62cRsUxm2MMsV0Qa6UHQf8AM4VzzHRGzeJL/GhSENGio8D7C?=
 =?us-ascii?Q?CkuGAxCNKhXuN1ZqLltP6MoN5CMqZuVtCEw16nZMWuEgjF+9xQAFvd7UPJfw?=
 =?us-ascii?Q?En06ANWaiUgn8lF/ClKemuqCvw+fYTOPJRz4TAGc8IEJ/1PilLV9H7OlVQDn?=
 =?us-ascii?Q?n9DuhqOm+mHVYT/X/Fqc9iWO+hX8Lip5dimPk5ySZVJBbxftFqmiM7HUErZd?=
 =?us-ascii?Q?OPhq1sw+DHsuw2yhv3EnSX6UZUQniZ4f4yWF6veLbaRDKt1zvxmMMOZEi6YL?=
 =?us-ascii?Q?E64Ibjc9wLdW0kcnk7ZeMyNS4gxZLQJG6pFYRW2GSUIavHwsQNxLV+H18tcX?=
 =?us-ascii?Q?gvmHMjBzhjPQNwTYcUG8csbM2gSRKg0CFxWDr/aDYXLS0P45hNC4VdoYwKpj?=
 =?us-ascii?Q?on7YeCXyBK3YAl/qy+qFMgkhhumZaazMfsnCILIj8OPKGDVcek+p8Scr6/l2?=
 =?us-ascii?Q?ksixzl5MX6rI+QvVF0BgUq3BwwuQ41rvEtwN8igl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc0ed3a-c4fb-4a96-8280-08db16314e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 06:35:22.4819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2ZC0ssqRsrAHGUqlA8sXfNqmF12mtRrlgHzdfQGu9yGn2wARQdJypZd8rvRf+Ps4Wh6ZLWf/U56lTNiBB8jFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
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
> Sent: Thursday, February 23, 2023 5:03 AM
>=20
> +static int iommufd_device_do_attach(struct iommufd_device *idev,
> +				    struct iommufd_hw_pagetable *hwpt)
> +{
> +	int rc;
> +
> +	mutex_lock(&hwpt->devices_lock);
> +	rc =3D iommufd_hw_pagetable_attach(hwpt, idev);
> +	if (rc)
> +		goto out_unlock;
>=20
>  	idev->hwpt =3D hwpt;
>  	refcount_inc(&hwpt->obj.users);
> +	/* hwpt->devices is all domains that have been attached */
>  	list_add(&idev->devices_item, &hwpt->devices);

s/domains/devices/

but I didn't see what additional info this comment actually
give in this place. It's there in a function name xxx_attach then
certainly every device in that list has been attached.

> +
> +	rc =3D iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> +	if (rc)
> +		goto out_detach;
> +
> +	/* ioas->hwpt_list is hwpts after iopt_table_add_domain() */
> +	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);

again the comment is meaningless

otherwise looks good to me,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
