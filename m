Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E236A7C6A
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCBIU3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCBIU2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:20:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E7F252BF;
        Thu,  2 Mar 2023 00:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677745227; x=1709281227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DW9JCv7WvkliKOoqvVgCL4EsTXVbGdVVHrGNu3AIsVI=;
  b=Joq9x1cUXz37vWkIix9n273EJjjJs3PtlIznOFrxkGRz+YDllo+gtA4Q
   6Y2KMh6tzUM+JzFn57EgM/eT/mf1G9t9qvvZ90frGllr08IrHM7X63GtU
   ddf075/9phdsbnX+l1kUMNYgPaEIXPB+ft+Mt1Hi3CYMdOcrJQGg9GLTP
   Z8hEIn0OY1/G43h+4aTuW9enM3gUkAnLzhkWWlOvAHMgB44WdFdfm9yny
   gHOpBsJBz5BX4UNoZKrbKIbc369n1MZW+JF2YIk0ulkx42qZKiNiu0DJR
   RPGjtXdPjcId41eVytoVKXQEXQV8D0NRsXeELmVmc/CMA/00mizxsfFg7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420916081"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="420916081"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="652321826"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="652321826"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2023 00:20:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:20:08 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:20:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:20:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:20:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1xIJusbfT90DobHn9g0Y4062TSRRENUhI0X3UxDyUKgdF6RL1L1vE4o7T52+a+nzPEBQsQ1piL1nWhCu2QNO/39zlL1EC3BNtdwz0+ylph8thNsEKNcOVWKadWgaiNtAa1FvpORwcxd+2sMsuJ+8go90eYr3adfBcE9HB0oH3Gj1Vx9t4Ts45o1s3w28gQxTVhlyHLwD72XHHRbuplNFpHh3u6QRTBhvVxD45Fi4vVPNYK9ZQvemIQDvSnxcRzvdT4C82a+9JEUP7tCrdk+cP1mO3Ej+aaljVb5YHHBSLtQSXzEFibwa16dRtlunJlPixYBl22ni4MSeMsSL1KsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKn8LhlBwZ3BfO+pBs1Fq+AmTp9uYjl5eeXFThmGsRE=;
 b=En0P9LAoWXZTCnd3LJVAcIl5gCuqCOiHrkMMmJgWUuSCxsbcW3xGLGkB6GY95HcA1n2bbXh4b0I8aL8j+ky1sHzQmPDVDU0gATLNnpPTkhF10WYPAKmSNXWNASTiMxgIqOoqpuIWR7W4dzvkb1ErLeE+yyVVwpBmXGOOUkjS7H8PvMNAFFhQuP7ixrsIJv6E3g1zcFIndaChL3k0VJYfO8WX4V/NDTnRXofhzHpEjQewnmdHhEr+3Xvozho/O/eS46MN0QE4BuFOz/kZs4vKGrh2tVGmCJVJok2TbHSMp0ADibmnfv//4rs0v0wkacIT0vifl3WrgZnkVNp28M4jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 08:20:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:20:05 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Thread-Topic: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Thread-Index: AQHZSLAU/BSaoz29rUmbcKRH4RqHN67nLb5w
Date:   Thu, 2 Mar 2023 08:20:05 +0000
Message-ID: <BN9PR11MB527622B6031FDB540D2820138CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6098:EE_
x-ms-office365-filtering-correlation-id: adaa7df1-4361-46f7-8a72-08db1af6eda4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLmGwXMEg42U+lvZnc44KFvhMaj7SL+1GpBv3Qi4X6PiHwC0uQvQiWu2dQcWsPoRHQ5JkvSucHC7tqu2BQyBe5jmpGw3kDRpCeyTthZd+mRqoqQnTMZ+x2IEOxDbPbXPIki+Ws12ewZ4UxcUub2sq50VNIT2wpS1UzzLz2+vH7Izqw3L6Rq0q1muQ341oDd8d4so1PcxxYbfkbREfES7KRllDDLmd5MrWtDxVvLzEaGo/pnNLvnZVBpgSOU6HWTIlBy4cXSGWsX63BKTKBJ7H1rlHlz3a1YxwR27hMQ5UXo/HoHzm8QFQm4uarcqKErODMU94YeBZ5gs172UDa18/cjT+rZk15AKLrzceflU/a1x4I84QLDohp9Zmpeywua72zup5ai9/2MCblYm4cyI/UX74Ihf171W4R2rNEMez8wSRwkdX6iMWdt7WuSWbyCppcKhAyDXJ9M/qlvavlJL/1QJYTvZOCQhAxKr8qU2PpbuHaJCGXvn2oljjj0YcvpWhHrrtpm3a/4cMxmtQ31KW44Zm/QAL6nJrOVPvgDS1oBENTvbfPTG9qGzCiPya+5KudM9arfT4zKR/lRZXOHbFKYQmlJ43kVrEtpUISNrP93hZ0Sh9WaG//UvCnyNrihEla4+BIp6yp40et6JN6kfk230hwuXq+PrOTvOwBfpoCPqKNxeOhsZb9bia17HnWou
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199018)(33656002)(52536014)(86362001)(66556008)(5660300002)(66476007)(41300700001)(64756008)(8676002)(66446008)(8936002)(2906002)(66946007)(4744005)(4326008)(122000001)(82960400001)(55016003)(38100700002)(38070700005)(107886003)(478600001)(7696005)(54906003)(316002)(71200400001)(76116006)(110136005)(26005)(186003)(9686003)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l1uuZktbsWa2QNAcdtkNTYcHdT9cQcK6O2q8c8iQ3cfyCvRWbDEQ3Z7HFu8Y?=
 =?us-ascii?Q?Gb0Re/blRJZ6qFQCmrSp78BXueFTp86AhTVcXifgjZ0XjAkUvUtpWrvCm87N?=
 =?us-ascii?Q?AWwAzfJqwu06uLdkDUlsILFVY2fNSyMcq53oUrSePtr06xOuu9RNyhAAcPFF?=
 =?us-ascii?Q?uJYnohaOWd8rgs0Bg2TyxO3U4hz2zDgurrLWwn4MEl6va7wKybFYb38FOPji?=
 =?us-ascii?Q?/t7MgHLSBHrr0xqFiBHATE9iF9FcaN/qWHeAG9SXcE3dK+NEMXzCsBBOWfSH?=
 =?us-ascii?Q?p9JnIXgDCMtMX7D9+yI/7VHJkbImA9rYiD8qDa23xlu2GQHQfSsCFNIqzZ5U?=
 =?us-ascii?Q?m3UcpaTgQ8YFZKvIwhcKf6b6InT/+MDsmchwjhQCxu424wIu8KAZpOFBSbrD?=
 =?us-ascii?Q?TaaKCLnBoZCya+l/ycGYMtCpw3sLtAdVzo42ssucV/Uq/DSmVMOSp14lAEAG?=
 =?us-ascii?Q?lTCvUcH7jKJVX9Jk8HK3jxEKuCJrOCvZ07gqUaxATyUyUBnMG6ET2bq9AiOQ?=
 =?us-ascii?Q?h5yh9dySYJDpH4OrCttgpy1u8DsZHjjwRYlA3qXqE42lAihkaMD4k+DPxpcc?=
 =?us-ascii?Q?brrpJXfqLTcLo6Vb8UfW3YzjCKQZijQ4Gz8GtB08loiyfGPGiXBshWnd+XWo?=
 =?us-ascii?Q?k5QOrhCqlDVbiM8dsGEDPV7YiBy+UnZfoiPhabJmYEDe7QBL0spr3a5c1H+r?=
 =?us-ascii?Q?HVlUMGh9KX0jqbbhikoxtS+Loy488baisZKZMCYWQfUVbh2+2N43A1Xr4G4A?=
 =?us-ascii?Q?s0SJJ4B+5YCbdA00B2CtFCWqtk2Mq1iKWKOQNJEj9y3IAKwTzCnt+QYLR8bf?=
 =?us-ascii?Q?HRdZ18MefSlqUtMYqOpJg64FPQGu2oxvLN0OniNWb3e0k+bNByzalN4CfgVD?=
 =?us-ascii?Q?6JfXVJeGU25rVOJJkCnQY3J742DWlaxjA3IRbJ3HkIAEB1Ia+Cv3kx2uUEuZ?=
 =?us-ascii?Q?LbouJlLA4iPfYM8XAlc31qI99Zv7VHVORI1tpUsv9XIEFm8t1tP571Nbzn19?=
 =?us-ascii?Q?6zYO523zd0XpmWXBRDUv8tiUD7wGOEb+ByzmcDFxjUfdA5t2deLPjftk5PFN?=
 =?us-ascii?Q?O1guW5HcBJuX0cTxh93vAr4jWhoqFh7WbBpG5t+gSbQTA9ZAdJhK1b6VLom8?=
 =?us-ascii?Q?HjGTJ3CmkO/6TMFcFAbcQ/M331p79o2WlxMW2qoIA27CpxYiuUb0S8unXHUk?=
 =?us-ascii?Q?lwI+6SIe6DOWkZL96E3l9zCiPLceASIHvnw0PfuzsfFdac7Ar3gFLS5vpFt7?=
 =?us-ascii?Q?91FLRFUD0wJES30ycgUcKn8O305byfCP4wOFaj+362wXbQaOGp+ohBrRvloi?=
 =?us-ascii?Q?Ngghe7wTNz+9pwEpF8OqOXIv36wjfVMcCXsw1H8rZIKHjnxxAUzndUgcwwcw?=
 =?us-ascii?Q?gujrHb3heeUn7uyuOjWu2AEYkeLCyWX3i/rzbObWP4MSbU1Q1hKzuGTYuwwP?=
 =?us-ascii?Q?ybE+z8Z4Zgbpyq9aBBqRxsmgcEWnHM251u2f64VHrPkaEvTD3qZVRDARml8p?=
 =?us-ascii?Q?jt3jR9P6LjOC8PaQpxwSSTko+xMpTsIUrpjSkLmobOaxgGcyFsEtM9s6ptGv?=
 =?us-ascii?Q?RwpFPiItx0YVyz4MCa96m4L+iTOcGuW/KnE3mQUN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adaa7df1-4361-46f7-8a72-08db1af6eda4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:20:05.3681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhHmhnMHm+TOsGITWf7etYxG/G2FxBdjzSDmwcVsWKsFDqD54ogTaVL+pwcwzA3O7Tz8Rv5WGhfw7TLYTDyuxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6098
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
> Sent: Saturday, February 25, 2023 8:28 AM
>
> +static struct iommufd_hw_pagetable *
> +iommufd_device_do_replace_locked(struct iommufd_device *idev,
> +				 struct iommufd_hw_pagetable *hwpt)
> +{
> +	struct iommufd_hw_pagetable *old_hwpt;
> +	int rc;
> +
> +	lockdep_assert_held(&idev->igroup->lock);
> +
> +	/* Try to upgrade the domain we have */
> +	if (idev->enforce_cache_coherency) {
> +		rc =3D iommufd_hw_pagetable_enforce_cc(hwpt);
> +		if (rc)
> +			return ERR_PTR(-EINVAL);
> +	}
> +
> +	rc =3D iommufd_device_setup_msi(idev, hwpt);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	old_hwpt =3D idev->igroup->hwpt;
> +	if (hwpt->ioas !=3D old_hwpt->ioas) {
> +		rc =3D iopt_table_enforce_group_resv_regions(
> +			&hwpt->ioas->iopt, idev->igroup->group, NULL);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	}

This is inconsistent with the earlier cleanup in the attach path
where setup_msi/enforce_group_resv_region are done only
once per group (if that is the right thing to do).
