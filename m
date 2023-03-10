Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB06B3E6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 12:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCJLyJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 06:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCJLyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 06:54:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B78DBF3AF;
        Fri, 10 Mar 2023 03:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678449240; x=1709985240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vJmgx24AKceq+nRzDeHhXfnPAuOp6MJK0DUp51w16yM=;
  b=URPHJc6fqt9aio76OxqHeTrt+/Jm6OL8jDxC4+ankzfZaG/B/TeViGfp
   /s5eNK+J1lAkEu2ijNo5q6KlGHkNuryB0ObFDtSs5K8DIJTpTH7OapliC
   P+jNrAXd8ifj4b22C32YokU5oeX8F8DOMWyRW5HAebx55OGIk/0oZ3KXB
   V445Sy5JwXamYKr4P1dRWRnYZIj/lWDVPgGJZIMaGrQhnKjv9JJqKp24K
   Wi0ZJV0X60d98LB4I/Gy8XUDFOjpojZaeWaN0JJhc2g6MrmQoK+Kt3QzB
   Oj/FrScCOAnNet699pQMi01Rx73PWTEc1EFwPyUVwxJ0G5VoLrJnEDWGY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="316362985"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="316362985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:53:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="741945688"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="741945688"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2023 03:53:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 03:53:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 03:53:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 03:53:58 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 03:53:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Taw0X0USg2ksfKBzqt8oqryAjYX7Ih3scwBB4X+pTmmfIVLV+ZsiWupgrp1RJmOuaycjQh/lVhcnkkZgYkMFLX/dWIrJBtF1wmJGhTBK2fjzZuq9VEVFMDtSitqJG5JN35XrxwxcLfQG7Ke6bPzmBuIJGsRbXA6OdFShdWIp0UNoh7oDjzRvq9Dl+gZQj+KYJyZ/C0bgsiESLJrYE1TabixZmNd1qiZTy1bVuT4v/HLKdtJtZrrdLwAMUk1IoljnnntS4hA8A/XU9lX0rncKjJVJS2zuJCxXONITROzb92WjN935GcLcdBnwySiiQRL4qBm0KEpdfiLJQtPchu9h0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJmgx24AKceq+nRzDeHhXfnPAuOp6MJK0DUp51w16yM=;
 b=AldqxWnyxrRef+HsNmqNWV6RMTpdocnnUrgM3VEh5XR/3JDGeAOlUSxjdKPkH6woC9J7XBHJU/LyVMnrypjcGNp4M9HHUsbM00eFsOiYpG2vg/VCTRzdlesIwPK72p/Kl0PleaP9iZ8vbHEA2inKewrS/L8cxx32vN9j2qbsBQed2y7thUAbS5QDz+4g/SpUOarauqXLwGwgUhSU/3W8BUQR4LClEoh6ae9tZC8jzgOHiYBzxQVuV4gJMZ03Mt7770w/yCJOTMhRSxB69AIl8iJt/eL1rgRbLRguwOSoeGN+ZPidyL0J2k89SrkUfGStY356iN3qLhaFaTLxmHkXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20; Fri, 10 Mar 2023 11:53:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 11:53:56 +0000
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
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v4 5/5] vfio: Support IO page table replacement
Thread-Topic: [PATCH v4 5/5] vfio: Support IO page table replacement
Thread-Index: AQHZUcoFRLfg4HbeIES7vtug94baI67z6iAQ
Date:   Fri, 10 Mar 2023 11:53:56 +0000
Message-ID: <BN9PR11MB5276F7F917F76DDC0D9186DD8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
 <600343ffb282ff3bed5eb98a9255c0084d01a859.1678284812.git.nicolinc@nvidia.com>
In-Reply-To: <600343ffb282ff3bed5eb98a9255c0084d01a859.1678284812.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM8PR11MB5637:EE_
x-ms-office365-filtering-correlation-id: 553bfb29-fb43-40b2-a652-08db215e20a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cheCSLFkLZ/YkPHudM7hAP78N2mK5xy25U1ZdO5zRfh5nIlGnJTGZqjiBYEB1/4nHA61u0FbwR4Z/A6lJB0rOlm7bADLKMnupsljaicI0nrJKXhYmqvklY9T4jnu7/iePHvH/rRV+8pq34ISiOXpjQ/SiAl/LAXay3T37sYzJT4oG2YHiyr/oqvqt8MCR3crHAj/LiVLH7Y8wIruPBY28T5Spj+R6W0MszfIG8J/OHAAt+qS4THOCvFWODgNwYkcr1pJkc1T/6byw6yobaeuYHGKmg7C97IThs3CfBs5KXTtUeik/f772JyW+Tbx+WIYo7XJh5AJIUJD8IMAF/ODnGi+o83gJHzGJkJlYQUiYP9/Is0g4ZMIR3gLqOZuQkTC/SOp7nK7TurQzjHIuyZhhHWDSAQ2H9xojqRNAWNHhW77BcnHjYtQ2XAJh5Q94i+ekbym8RBsZvMA/B/7d5DH7JWtUecivx+FsqK+3e/9Vh3AJGlH9KVhQ+EUdI1EPGhqDqYNE63ksAYDV4oQQ06Pp0dqYXoriMUle9iPSWejYzYot5D+5D5ODElKDn8MyOrLbySiDMTlRAek4FrgvAXam/rOAf8A3KDK5qtsUmRI/gFAHCEkCKHOhad5NW9ZFkRtB6JJUPWhcFk7ctqnGAyx8g6dV/ojJZVe5aNK6bpOqQgVqv5TV8ax2zb++o4duo/ydA6sKht/Pa25IwVUOqYMZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199018)(82960400001)(33656002)(558084003)(478600001)(110136005)(54906003)(122000001)(38070700005)(55016003)(316002)(38100700002)(71200400001)(6506007)(9686003)(186003)(7696005)(26005)(76116006)(5660300002)(7416002)(2906002)(64756008)(66476007)(66556008)(8936002)(66446008)(8676002)(41300700001)(52536014)(86362001)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZiRr6oWvNSE2Y0FxPDUrL4lnjJKFhAvEqGrxNwPmiqKlaTxiFxrzBYnZuD3y?=
 =?us-ascii?Q?mIOmiw8mk58K9/jWe2kd8P4CBZ8yDgoIhFyDd9+NZiE5lRTa/E/WP31PwYxN?=
 =?us-ascii?Q?q2k/RUD7FVFjvUQP+cFNSy9zQpuxh5qyaNVoTxEI358kAZlrmz3tg0VWFJmI?=
 =?us-ascii?Q?JiOmGjPBBsXFUDhHop1QXkmr5gyt1Y9EJPLaq0n2jg1Bi4rw4iwt174Gvwfa?=
 =?us-ascii?Q?9UzY3qh7YbjJzsXtPKz1OI5ffCiAYO1AVMj+cvkhzs0pqRAsjGS3SDJ4rx/9?=
 =?us-ascii?Q?OopR2iYmxjCUy7pp8YzA0qh2u8pG0yfltlhps1U6G/fQRSXYhhI6IB3Kwez8?=
 =?us-ascii?Q?CJToJGBtBFHiuViXRRXeyu7x7LrnoQbVMUg1t3a5gTqX52MT1QY/RXeNnfqI?=
 =?us-ascii?Q?X3Mwin8bd1fWqBXOI4WStiP1ysvVAAKkLjldLcyveh6U4ddDyrpLG03lES0S?=
 =?us-ascii?Q?OXRiH5qi0tQoY0+PY2cpa0y6fOQKtZn3gwDiUsPI3T6bkjFxsF46Nn+0j4eC?=
 =?us-ascii?Q?gLt3qkkovIY+t1w+fWQEjIecVXvDHtqBZWBCIDIzLHsX/+TtjAHfMzx/Uaug?=
 =?us-ascii?Q?/YxxBReMdFmOnTp3rWGvyVLKNKaWTOlxnW7qhjLxLSCRNfPswcxbpf5rHhrd?=
 =?us-ascii?Q?3Aby3LVhN4a13OJ3Kp2zrmkuEWa2GTGphwHg0e6ixh/Rhre5mpakRM/lUPzb?=
 =?us-ascii?Q?H2uZKkiPgFc1PXrsFPVm5ffvgwKmIoTVp8A6ux+FQ0Rl4nLSpNEKe3UW8s7/?=
 =?us-ascii?Q?TcNBhe5lGzooJXtALt+ODjW0CZT4ueFoGpGu45gcFHKTp8iAT/dpI0U3xVKw?=
 =?us-ascii?Q?cIhvlA6/+XB8lXnMyFav1Py5uD7WBA61aLvcfA7VC00HuGz0E4jbYmLs2098?=
 =?us-ascii?Q?rXZ/Nrr7A2RDGtwi+Fbps/7XjhB8KezwIsBOBNecuZuMw5q450wWqTKvD7lj?=
 =?us-ascii?Q?IoJA3Z372l4qN0SQmTeWJE3fFrVf9C9tciuWyHnr6D/max/Rqr2BI1He0TDK?=
 =?us-ascii?Q?8KZBVsm/I4FIlpniU7i+EpV88hKttEiGnQmXMvFuCtkR/Rjbjzal1X2vitdd?=
 =?us-ascii?Q?e+IQBEXuAlwXIIhbCosjhGarO7bEd4gDegOo6M3WGIh8Av44o8SpNIL4sHz4?=
 =?us-ascii?Q?LKa294mRIJxrk0F2dCbepdgBKJHgP9LeTxscUqrfiRowcqfqj2uG5IzL009i?=
 =?us-ascii?Q?QDFQGdHwcYo59BhwJJOTlH3xR9HBTZmjw5e82aYkocy+MgKqoQTyN9QobTq9?=
 =?us-ascii?Q?5rQwwGH2lriaFm+QrKgsLiSDeq1jcRlq6GmsBUAN/LrSTnfnLCp+aQm2RrM7?=
 =?us-ascii?Q?2IA7mV7FFh53Ip+V2W47oGe5pdNZh9t454XgNO1RyZKW3uOKCL9yVRc16Xwx?=
 =?us-ascii?Q?+WfIGCNG6fL9MsW1K2wPnSoCA2JNo6+4RivlEcETvRuS2yShXgDtphzufBAt?=
 =?us-ascii?Q?nj0LgC1Kig3n4YFvfOFOa1WF/hzc2WeVXbfsA5GIAW+v5ZeWWkShgrRJX2+a?=
 =?us-ascii?Q?mQX07+7fPRkJZjfhDaaiPMKkXTKpd6OesE6gqGWOv3Dssjzohufof5j8N6BD?=
 =?us-ascii?Q?XYMvx3r1YeK2cep2/e4SHNODTriuSC+PX9EMZPgK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553bfb29-fb43-40b2-a652-08db215e20a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 11:53:56.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IexEMJKK1tOaViiJ+EK7cnOZ25zppef/zcxQTESS3ZJRG25xc+4PRz3D2B4zO47qBfqU4+YiwN3y2b9MvPqqLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5637
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, March 8, 2023 10:26 PM
>=20
> Now both the physical path and the emulated path should support an IO
> page
> table replacement.
>=20
> Call iommufd_device_replace() when vdev->iommufd_attached is true.
>=20

why is replace enabled only in physical path in this patch?
