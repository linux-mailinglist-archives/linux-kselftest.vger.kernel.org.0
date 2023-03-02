Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF346A78D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCBBXz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBBXy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:23:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0BC1ACF3
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 17:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677720233; x=1709256233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H+/zLyy8BphHDRjz/w20ICetfqoBmpodj/UdQI02nZQ=;
  b=n4pKfDht0LdsTPic0fhYhm5vnRsFQdm50XsvbTvXpSoV473IpcXoJ8aJ
   sG6cNBBg5FzWCexFgH/kBOIQmzZ3bEoagF1IgBh3W1mSaaQW9og0L7lv9
   0S4THW1HRfztDbKCGP7asnuLZCiQ43+VIyJO9BHC4QcFz96hjiMB3VudV
   vC6Yz0/7NTzml+6wBpmGU43wItUsQj/mVYsC5JdDbTcuuGjjII3fyV6Wb
   6NKNotsh81DpNLTzSK9qhL1VGCtjZvRE1w3lhJReW9vJScb9Jefzp74cd
   Xs2D+CObkp/toPYYc1055q2jqvflqazQ0+nQ62YDY2HnlfFUED988Wz6X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397146155"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="397146155"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:23:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="920474451"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="920474451"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2023 17:23:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:23:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:23:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 17:23:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 17:23:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIE2WFrBFdp4aA34ZamjtxPvc4dZ7SrZXvZP8DtB1Y6UF6ZaIacFtb2185LWI8SVoUbVegpDydilmJ/1hwa0wEXT90aXKlczYgaN1W3umy+Vp6+zd+aCh6SefCxkCWUFWy8m0QtNONvb4mygODXpTyN+3f/YiJCYgWwHYQpPdfYaDNX78hMl3ISGWS+fVt7UbpXzhaz0SG3gLwj7ODAovyGlBLQ/h4uJMk384MnEd/EF7UDxLWPjfLkp7HeLxpSI4Ep1bIRP4pIcQlcguA5nq09/ULYjFYdwN269UTjIZwst+VD5xutkpKMRlJHOadrVsKbH5sbZbTGt+hiT7YzgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXNIFGAY6v+pWGQgBcHo45ZmS4Gd7zLbqFeifQNyZtA=;
 b=V8zjIcmmHl0oKyoJjy2MsY+8ZZRTNn1nYJkN5yu91a2YTUzlKyINkcDpoGa8z824UXy3O7u2erMvg8xLkYdZokqH3V8tv9BgQONmev4+bXYSzTzz2HAbRhcQmTEgIOOD/mh6X1kgazJ+8gsZsjZM19pryuyRbbg6hzxyO/QaKYshQSR+v94h4xN5qtJuVxyFXU90OHrYqNb3cGC6Y47l86W5MWNZI30vqiduHbFKcaLitewjCydYorxRI12mxE16MzyJUSoU9+oRw5ZJNZNpVljCZJYfNmMZz8btLEIS2ZLcS5oUB98M9OCVCzqysbSXKra9hylxFfOZEFP6fhPaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Thu, 2 Mar
 2023 01:23:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 01:23:48 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 08/12] iommufd/selftest: Rename domain_id to stdev_id
 for FIXTURE iommufd_ioas
Thread-Topic: [PATCH v3 08/12] iommufd/selftest: Rename domain_id to stdev_id
 for FIXTURE iommufd_ioas
Thread-Index: AQHZTHRYHdkvvh92SEGIuCZ2Jq/+ka7mseZw
Date:   Thu, 2 Mar 2023 01:23:48 +0000
Message-ID: <BN9PR11MB52767FE47436B23EA38CFCE68CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
 <8-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <8-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6059:EE_
x-ms-office365-filtering-correlation-id: c444c702-1b8f-44c9-a9e9-08db1abcc635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qFe/nE6shDTWNR56Ql8Fi5lOjAXIORLl8iZqxAtxShMRx81G7yyUbf/GRQZY8K+V9wcIMDoGDCjpd28qTffnRNtQqpWH1sXabDjz3tvoijJflBCUvALZkabhBkJ75A/gLXSzDqEtRTQB3Gqs9PY6A/TsCtLVzOfMJwcPVxqx9q1Hc8wfkcJcgHvdjJ+QbD+mKFeeMp8k7CUgg3hC8Jfv4tR5x1iobmudRkNKx5olOsyKTHQIfFkkurwlzXsQCrUH7CpD7SKIU1oyVy3DyRtsWVN0qSXZjUqVMFpA+0Q5FnYt4F5hfrx/MGIhbu9BraHh5iAhdEv5B61XbdEW1w+lUuAYWeNJRDIItFx1jPRDwmJQyDd1KmEJN36sFLjTTMAF+8/UZGsH/pdm9mciz4rH0Gg2yMoHeAZbCMwUNQ9fo9nEE89ZxtACkb6rtm8C0h8ccZTitebSkgqYk+TBvfanCb4ugfu2xe53KNE9te5qPuMY8f2GRc7A7aGGHM3mbJp0vQB+RaSUrzV4DcKi6i4Mez50ir/yUn0yQyq4MGi1KMJdCBJhtpvsTw7c8BUbZVuuf+ozI0NjLdTe49jx10ld/ytyFwgV/RxDkjWCOvYZT9cczF4iK7mHymTXdRIRGmFRGXiOUKDnaL5RmEBN1xojE1vNbHzbBYOXX+yNSwBG9+b7bRFYv91w7z9Kbo1GZlCwXv8sUtNZ0UkEMcIOyAM/Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(86362001)(33656002)(41300700001)(8676002)(54906003)(110136005)(2906002)(186003)(9686003)(5660300002)(66446008)(107886003)(64756008)(76116006)(6506007)(4744005)(66946007)(66476007)(66556008)(8936002)(7696005)(26005)(4326008)(55016003)(478600001)(71200400001)(82960400001)(38070700005)(122000001)(316002)(52536014)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i1AYVgfEPhXYI2IGz4Yymv0ZSD3flhObZ2q5dN47DSodnNYwnyUyxvrKXgGD?=
 =?us-ascii?Q?Ypd3KpwyfNytbScjj+k3GBFcY6nLgk+KsQjT3bMfh+IRQSyoNztmaR+bHpNh?=
 =?us-ascii?Q?i/od8VK34xFBlqgZ8a1xeiqzOhhrsVFF4+qU5tNea9KltgFpnX9HiZ13UnuW?=
 =?us-ascii?Q?SHFykX7NR3CuDKiMyfj/vph5JtwfF95IzG3pvkmqAvu8KT1jVlcmCJEZKRz7?=
 =?us-ascii?Q?DTevmgDpUEnGmmqgR92orVsU3sWMUs6amV1EGEYxLJdJeEiTFSdTFq/fZEyY?=
 =?us-ascii?Q?elKq4pRr8cYG6CT1FOzQgczng2IA3FySTDjmHcp0vMDPMbfN49V4WmHEUKZN?=
 =?us-ascii?Q?sVf7r7KD5LpS6Hu1coybpJZC92k8QuE1FRhusHQ4hFqZ1Dud7Vihqr7I1t8j?=
 =?us-ascii?Q?80cM0dO1zR+4wR+XEaM6uqNWT/fvynHqe324lWeka1kZdaOlxumIkKX/wjg0?=
 =?us-ascii?Q?/wiF3qDhEbzZ1A81JVBtA31CXrL9SOY40ejOnyQhLUJ+igoXbRbTthZI0t16?=
 =?us-ascii?Q?2JO1BwIs20uSyxPWvoo7lgQ8HgtKQpOJuRSqLoMoYSCV95c81cOgx7U+nZ85?=
 =?us-ascii?Q?1rppuDgaY3+htU5gzM6/XiA4N7Bm5RoIWW7Hi3JX5csxFsJWF5dpf2oW5l/0?=
 =?us-ascii?Q?qkQZzPJL3nlEgFxYpy5srmQe73kz8yjV8CrwhbJbPvn02tHg6EnO2T59VY2M?=
 =?us-ascii?Q?NwKtWbTWZc9ZWqRrAN9fJ8v0jiqP3dkbmzG+Sr7MqUMgPSQdbqQ7AJXaXvBZ?=
 =?us-ascii?Q?6gvXTxTINy2xMUsY0Zm9S9VJozOhIhwVfiONkC+6pOVQYgBzQ4bhEO4mRJ3s?=
 =?us-ascii?Q?sIlJZ9CNZnBfinx2xUp60hHHARoDRT/CcIpxnh9ac9KcYVDpFMuWro5BYXe8?=
 =?us-ascii?Q?6jd6RMsOtw59UvLYodhVzPAlMuIPC0Zq2A4wUY4nxVG3AVW2j+wxYtxj7v7C?=
 =?us-ascii?Q?2OiCiJEkMx6xrvx7uiyJ+7zN0BIoz6trKtLZZUWTg6e1AfByvwJvPb9LjEZj?=
 =?us-ascii?Q?OZHT4Y3w81Eb2opWxROwMuKFGffKcygDU+zcxGUeI+SxxUtuEaYJOpQxy1VM?=
 =?us-ascii?Q?4us+imOKPW64IQclZ6ZDGPwazDbMd4HN3J12Wf9qS03By8joSn4amAucjuwP?=
 =?us-ascii?Q?hmGvxaFEe3wAsprytHnwySlB07HAsYuQ5nrA+3LuK22CTSr17aumkELP83QC?=
 =?us-ascii?Q?7gz6NTAoiKZVr8FG3YavzJ5o0MMyxwVGu77zVZqqyaJiPMbBM1o4EXpEjFbw?=
 =?us-ascii?Q?PN1Az6b6aNlHA/pD/Qfy3cWmc60UVlQgJNRS97CrZtUre4sLEOz7KY4UaZbj?=
 =?us-ascii?Q?kdgyXWWWwph6TdkiCHaSBSuscn/lKWVrS/jIEesYmctJJt9WH5NOKw0L+fH3?=
 =?us-ascii?Q?tT4exi+/Ui0MV7v/1GG/uJd9mcpn1BZIaGGDsTR0v+VPWkh3rzq2LT2vj3TK?=
 =?us-ascii?Q?PG0DYwd6Vm5jceiDg8el72A0AvE3uk/O9uanBlzAbfItwqYvRSVkXgV9ia5x?=
 =?us-ascii?Q?0QHQf2+EGfkpuOhsDyjmG4nXMSRu4hlCTcJJoC4Wo2MG/9H21W0uBo10gc26?=
 =?us-ascii?Q?6NU0tAubhu2atb30pr2hVyG8/DkYKixkq+SkI7QU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c444c702-1b8f-44c9-a9e9-08db1abcc635
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 01:23:48.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +on+CrYqosTqCZUiJZQnr+fvA54WPxWrc/3chOjILDkATJU4vBoX2aQVJMj3mDf3/s5ny7c4nu//Zg2h0FlGTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6059
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
> Sent: Thursday, March 2, 2023 3:30 AM
>=20
>=20
> diff --git a/tools/testing/selftests/iommu/iommufd.c
> b/tools/testing/selftests/iommu/iommufd.c
> index fa08209268c42f..000fadf8110833 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -186,7 +186,7 @@ FIXTURE(iommufd_ioas)
>  {
>  	int fd;
>  	uint32_t ioas_id;
> -	uint32_t domain_id;
> +	uint32_t stdev_id;

Probably add a comment that a valid stdev_id implies a domain/hwpt
under the ioas. with that...

>  TEST_F(iommufd_ioas, ioas_destroy)
>  {
> -	if (self->domain_id) {
> +	if (self->stdev_id) {
>  		/* IOAS cannot be freed while a domain is on it */
>  		EXPECT_ERRNO(EBUSY,
>  			     _test_ioctl_destroy(self->fd, self->ioas_id));

it's easier to understand this comment.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
