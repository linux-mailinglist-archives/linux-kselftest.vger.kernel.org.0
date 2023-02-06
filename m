Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34768B7A5
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 09:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjBFIqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 03:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFIqN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 03:46:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69521A6;
        Mon,  6 Feb 2023 00:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675673171; x=1707209171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3y0dVOGudU1AIykUjR6rYiN03b8GPJxirNEfuorPo/0=;
  b=A45Z95UNXuncPOdDBiGRK5SyHNBRahXFwrBDoN7IhhZiEFbCDRjJTFhc
   EbOmOijdSijeMr3wJWiDv713pZWNLLqMr6UQmTtFtpkUKDkPzn+oFfpvs
   aqP9CNLosOcFJlm++Dv7cxjyQcsWRs0Q4upF+zDKkER7Rg6VljMUWU24q
   oIKtNds1LKdzvEKKG6hbwump1IQjZZKBMJOiYxZ+iASueRBvMFtuI83i2
   uoqxFfi8I0+h1q7lHUWjGqsXq29yKDpGXSWRYZ5VQ4UtIGKLFLc70Fg5R
   W6NDqxz8VossKfBD3ks5/OmVmk6UKeVi+ss4lApBOwXUmypLbvISnxss5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="317167670"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="317167670"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 00:46:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="755177993"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="755177993"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Feb 2023 00:46:06 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 00:46:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 00:46:06 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 00:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wuf3m5k3E5Y5vjShV1QVlDglcd3J4rOEPKaEDoPkDwLu0qJFhNgJdjmgpQGXUh+RSfLfvoaK/e7q6sOQVZL+hrXGUg+SBvAUhq09ZIBEVIMqO/0WGO6BPOF7oKFxi7lbAdupXwAjLjW6HWWFJrfJeWs/u7rRKv0yIgIQTBGuz44PLm4128u5axZO48L90OS+zW//rrr21qHNcbsaIDVK0GEW7l6bgEi4q47Ikdv7GXExjQ4oJTRmSVnynu8VQ6fi7fNOfjN46m+fKeVDG4NUSVfjORead81oIjzoxz/534Zh4eaBK0rBa6kRTuN/TbuFhk5F3OU9DXjNwbEJLaxWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y4OtyLnWmMo2lea6DsXtzZXbzotkKB5cLO5UqXHT2o=;
 b=Msxo6rXxTLYYxlbzcIOkPYZ3WWi2vsr5DjO7kDW6jYb6Yvfku84GhiGbrPXF6ZLuMppnBR6WuF3BMaZhjmz+1H2i/Z+JLNeyW4hUGqWj6WDU8dXyuHGNdsz8FeaNq6cPFeekpRf/PQeMvQE8PZBogQK6rRx6plarxsPhXjLmqXLzjjq6bCVtyIDldKXoAfl5rqc4i2C9+rZF01K9BGf9cyVllD9s9F2rulhmxZHypdlDasoOu5A/6bQs1hXrJ6qwZBVhssZw8LlQEzFa2RLGD/2Jszxm3nwhdPvUhk43I1VKzYGCIWfYu5IIYRz9LG6SKFWUiV7pK2XFjER79lsEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8035.namprd11.prod.outlook.com (2603:10b6:510:245::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Mon, 6 Feb
 2023 08:46:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 08:46:04 +0000
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
Subject: RE: [PATCH v1 7/8] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v1 7/8] iommufd/device: Use iommu_group_replace_domain()
Thread-Index: AQHZNtTLkB/Ugg11HEWfRX5kjXpVwK7BoBMw
Date:   Mon, 6 Feb 2023 08:46:04 +0000
Message-ID: <BN9PR11MB52760BBE37B65AAFA0CDCC708CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <de1cec7698e9b4e2ad03b7d9414b25d655fe5a6e.1675320212.git.nicolinc@nvidia.com>
In-Reply-To: <de1cec7698e9b4e2ad03b7d9414b25d655fe5a6e.1675320212.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8035:EE_
x-ms-office365-filtering-correlation-id: 6d4c031e-e0fd-4327-1d9f-08db081e94e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: knnrBB2LE5vTpzgJRGl3iIfmeehXua5KfPSGSEAFvB1lGuysKhanxRh2p60lmXJ+pvIqAKqNnr2xv515df+3gDz0YCrH2+f4BEIaxVfCW8UxLNmR2mDW+hWGLRzSEFSAcsWQ1GbYzAjOSllfMDEX5Oo4U95XlQho+NqCCeM1QczmYIei2o3/VJLitjHmogXFFeWzz/0EOKArl8D7vnBqrZ4PeIvNgc8wxXlvwZDn+tZig4veTPwk3+DM6zY6mkcw64S+1Up0eLNJ9IR2RkubNRtiejGY5XaTcn7P3JHaz+LbKiYEcqfyrgf7DrQgITnb7AYGXPGMlqlwRjQI68heXIWjdOkz+cJj/e5DTWcQhgXQQvwfihZuGc5peiirQOp7lBfqDw6cMsgicDRqCljWSJPa4pOgPpg+bqGH9BVVwYro1WcES/hzpQYMmQ0INXDlykjAH7pHwi4geCWW1pUKKFVBSMe8te+OWCD6XBqtZal86RAR/VaDudKYYcZLa9rFwrCQ4pjl/Vj0p9jMMEpIuk2eco0mIAJFxNMgGcCJ8OFn6P53cfP87lA86kV5EP4UkwSXUW9s/SxI1oUubwKb3Yf40I8rpYN54SpvTcTSZ1v7ALdcSsMCB9l13ZA9BYbLPzLn5Itpg3i0+wwchUkZR4kPjvuwPMYPYZq7whosRr1mLxije03t/IlW08+/ETiFCccnhtEnOSg6MoTz77Hrwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199018)(7416002)(86362001)(4326008)(316002)(76116006)(83380400001)(66556008)(71200400001)(5660300002)(66446008)(66946007)(66476007)(64756008)(110136005)(33656002)(8676002)(41300700001)(82960400001)(38070700005)(38100700002)(54906003)(52536014)(478600001)(122000001)(2906002)(7696005)(8936002)(55016003)(26005)(9686003)(186003)(6506007)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jTvEdX/WxHtjKQ13d6dHrQu7QKkxhTc1l6empEQwu4/9yZtNyrBANZzUNYtj?=
 =?us-ascii?Q?lgXSMfvvf+yPPy96H6XInOSkY4Kh4O4HIitXovjo1I9wPv8YVNDYg6qFCAva?=
 =?us-ascii?Q?NLPyP5R0ytWvY3DBAGl1VvEm/rF2HQg8vB2ViBMA8rhN8+R10pmP2Ahb0Flb?=
 =?us-ascii?Q?FUNznmsByJXzvl3ASrXIauKF0UyDsdUNoFaNnXOpAz6sOOZ8iI0bQU3hfNf+?=
 =?us-ascii?Q?euOjQxxmwEtNS1/rDUFGIkePAdruzEKgQK1WOC5YHEh5+A6AVvMjDcn+Pw0n?=
 =?us-ascii?Q?OCVKNmAu/a0D9xemVwji4gFrLdrkN4QkYb3D5PjaQExHJ7AAce2TDx3vdK7T?=
 =?us-ascii?Q?CtsEy6ErzdizONao5lkpWK/nImlgAZX2ZnViw+olgl7sWSk6RCA9jXWhki9n?=
 =?us-ascii?Q?t8VTUdsDBBH3cJtjnTkqQoirl+cGsCfOFE5iUZOjzGWK/xvLzBif6D/aONIx?=
 =?us-ascii?Q?x3famHnh6OY+fTNKg9gWGsEexStU56vfHmwz6ad4tMkq+wFmQiWvzZlzQjvr?=
 =?us-ascii?Q?QkWqHR2F6yvyIy/5XLgurewlrGOMgbVpFP3ns/6i6mv1xUKCZnAwE9cO4mJu?=
 =?us-ascii?Q?09un6Z+81us1SOsOFgTFZRX/dim/eWIK3kZBb0OhcnWot/n8o3gDWvWAd+Gq?=
 =?us-ascii?Q?ygde3ssISzdl2P2HPzp+hgGsmedWfntWcb9O8cLgLY/glYhUWNniv/tl9D5V?=
 =?us-ascii?Q?HlbEpDg0v/2oNdF3tC254zu9ql6LN3ODIR0UGX66w0/GrkSvFEEIkdvM9KP1?=
 =?us-ascii?Q?njkK5+pqNj545CiJi0BGMcuKXI8il5tEOQFVOYsCzNOszDThXIkqRUJP1wLX?=
 =?us-ascii?Q?i5CNfuM0vLoRxKBjYZtEUJ8ZqTUApjEENx8ROiMQ7pzBt33Fcu8o3DzeKWTZ?=
 =?us-ascii?Q?q1liPdBly5qpC34bKK9Bq9REzQqfCM1IT6qo1IllaOD19WR0v59IeI/vBIui?=
 =?us-ascii?Q?dyitxEWxodACyi/4g3+uydI0Vya3BY7gHl3E8klroaKMe96wLGMEJ6GOceK6?=
 =?us-ascii?Q?U5P/vR/yA5XqDS+KW8sqNRQoRv2k/cqGsAfAAoA4PuwvkCtvXxLqhpEJUq6Y?=
 =?us-ascii?Q?2e0DBIm0ghY2JkXu9XJN1Unth6e1Tu8ds3KZSYclCKN9bqJhbjCuu+Raq7YY?=
 =?us-ascii?Q?h9ro3G6ag1BMKWM2CN/8iCTzjxaD+0UVcy8VuuiNF+nTCvuEn2yv6U/Gwftt?=
 =?us-ascii?Q?rA1PK0lkN4e0n/rSjaipHn7mS76n+IeG/Alw8I3vofDjyZ9rCJWjVruwtGkG?=
 =?us-ascii?Q?7qwedS313FmJib6Gw4hG9at2EU7gdAp0yROaOQy23rDtvk8b0dwLNwRXL1uP?=
 =?us-ascii?Q?xast6YlI2SckQmPtOj5DHv/GGBteM2G49Mgm8GdA1lMKjI/aUK8Wb5WFAfdE?=
 =?us-ascii?Q?qBENggQqeR2dLYNOt8ghRSDc0JBy0V6f/yeYJJzt20XjyUDN1fqiVae4dZEq?=
 =?us-ascii?Q?GtDiXuv4wWV5cHvOcKcu7riYJUqAMFElC/94sPpeU8FgYgiH8fbvyKiG4X11?=
 =?us-ascii?Q?sjR1tnp7JK+ZWx7YKeJZcQ8YoeWPjyehVM3PP5HOXsdb301q8VcyttV811OA?=
 =?us-ascii?Q?iEqnbcdj85R0/XDPG+3W85GBYTIyBaxPfSojvoFE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4c031e-e0fd-4327-1d9f-08db081e94e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 08:46:04.2385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOo6iSaIam76as4YaPVN2+CwBzJHTadxUE85XFHxXF0c4Wz6Un1kMIXxTAuM7V/5cXtweF+mUR2IC701DJL8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
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
> Sent: Thursday, February 2, 2023 3:05 PM
>
> @@ -246,6 +249,18 @@ static int iommufd_device_do_attach(struct
> iommufd_device *idev,
>  		}
>  	}
>=20
> +	if (cur_hwpt) {
> +		/* Replace the cur_hwpt */
> +		mutex_lock(&cur_hwpt->devices_lock);
> +		if (cur_hwpt->ioas !=3D hwpt->ioas)
> +			iopt_remove_reserved_iova(&cur_hwpt->ioas->iopt,
> +						  idev->dev);
> +		list_del(&cur_hwpt->hwpt_item);

emmm shouldn't this be done only when the device is the last
one attached to the hwpt? and if it's the last one you should
also iopt_table_remove_domain() together with list_del, i.e.
similar housekeeping as done in iommufd_device_detach().
