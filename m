Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D618D6EA4BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 09:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjDUHai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 03:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjDUHab (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 03:30:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D568893F8;
        Fri, 21 Apr 2023 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682062210; x=1713598210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ncl+Jao4I/eHldDIF39YbS2/g2daDoMMZ9vQfVAQUO8=;
  b=C1DP7sebieP1LepWS2v22OlNTd3wf7c9xjs4TWtaBwa94upXLbmrjEWd
   WMwgG5Y32UVVSS1iFehQLB5qa29QFK78aisuIuYSGfR9t5LdhuOZkL1lG
   kdI2+0f4N1sUTv9te0TN/zDQmvyUJOGCt1icwHjrsXp6CIw84HOFa2rEX
   2JZWWviaBswF1P/Y1lWRhN+fV/00VfVqzBJ9f126FBNVpZgykRe+QBnJq
   LL45/pvANhdgc0TvreFnQIo5HiUgaW/XnB+OOAIkQEaxax/wWBoB5E1vB
   0dkJIFeX6+EkwFyCf+bxrikuUW1vuu0t5b1NyzT32NBqP9Z4Z0jPRSilH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334809918"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="334809918"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 00:30:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724718102"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="724718102"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2023 00:30:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 00:30:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 00:30:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 00:30:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 00:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFjrryII5suACcfRXEIcLDfbnjNuG6N1G77ltzQ1zrlykfQ+PyKi5CDyf/mErMF3SGZey+zUzH1C4Qaq5CIJi9J86DET78aaJVy3OgA+/J/rNXAqwoAIIwJ3MwuJ/mHkQ2uoZic7XmSkEcKmp7PW49b6OkifrOeK4q7dv9sVTq1rsgIL8r6K/Qofbfyiycyn+jyU9kUYyzbwy/10o4Ky8V2OZpaTGLsz+dD9fx1QR7nUUzrIe8xtOfdFdY8RHOmlxEpkPxFzNncwYZ+2Jo/8/6e8J9v7QeugHjXHpg9DXj3iHElzLWu4F4RzudWg3lJRvf0qmT0Fr7SRzCP0q5wOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ncl+Jao4I/eHldDIF39YbS2/g2daDoMMZ9vQfVAQUO8=;
 b=OMHHhM6uvUmn2RsplpnsSJmLj69Eclu6G1nO4wIXb9Z7Yynh3kXtfCSSCWYYIOY69h5fLArQmhJWfUXaAtuDhxBMB9f2ErUf9MUcLGQGFLKNAejF+R2ccQm+Ilm19vOg4FdFlfiKT5JNkXeD2VYoDKN0vZt5UOL6DcM/a3GpPpXSzAYDY1PmN8jyIKqayJat73vPZU0UA/UAzY0R4PyMgtehQNvOcvpGddKdr1k1voACBkw9EM32gdX/jFDVI7RKeDRdvcrqj4gjXZPec3rZmnVPIevP5r29PT2N/0gQeRtF1uElsGEAbtQq+etUvG66sWafI0mOgDQZZ9F89L2wzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 21 Apr
 2023 07:30:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 07:30:07 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v6 11/19] iommufd: Fix locking around hwpt allocation
Thread-Topic: [PATCH v6 11/19] iommufd: Fix locking around hwpt allocation
Thread-Index: AQHZc7k1HU2JlOlgLUmuE2n80lxMC681Xqrg
Date:   Fri, 21 Apr 2023 07:30:07 +0000
Message-ID: <BN9PR11MB52762D262C3607E0F003C1E58C609@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
 <11-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <11-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4949:EE_
x-ms-office365-filtering-correlation-id: 135278f9-6d74-4d3f-d193-08db423a3b6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g5injC5IVEu+5o4G5x0nbO6+VXm77OsNhMS4gKX62usrmzK5vEo7o2i0xzb9WaxvB5BhDH7IG2x4PnroiO+KMDAXESbw//WGsNPynpL0Wr7FSOALRHSv3k1UqIpwN4kkaMYo7eNQyWivbdjdJQKFPqu4OgO13O/LFbpvf5Y4vAgSUIwTPeDPoNwvoz71ZF51aGQUkiN1YKKDaOTKcnOZb5JgwjlfW3huDLduw9tncRhMTLTBgslvwssLztlahwpvZT12yXIoe9atGFvtQiZRNrcMnhb1OFYu5WrH5h4k46oKznQejbDSE6bWZqzhqSIwhlFmEjwIhuW9i6F7g+eJ+H8C3EbZTsQWlwjnPyPmd51ic0yO2q1zO9Lus3XZn1CvkIKYkAEoNQNIQv7xStafJ3cdUN55Son7jJ+/FHaHWpm42PiwEKgSmNg+iNtrRxjKHShvArX6MB/lEjM/4gbg4GL2aEZixFs/RibkeoXV444jXI4mBh9rhlaMR7Ck/dlfb4TdgTdc3DQxQjINfAtJVurjbcSAFhX9hB9ZnXsMMhvMxzfVfwVQAsQgoHDUULAyVarQq1sMpYNCnqultYKUv6EfWTpS3q2/TKOxLjT4yOVhwuTJzTHVsb+fqFb6Pwhu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(110136005)(66556008)(54906003)(316002)(66476007)(64756008)(66946007)(76116006)(66446008)(4326008)(186003)(55016003)(6506007)(26005)(38100700002)(9686003)(83380400001)(122000001)(5660300002)(52536014)(8676002)(41300700001)(8936002)(478600001)(71200400001)(7696005)(38070700005)(33656002)(2906002)(86362001)(4744005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V0WpvJxlbgRm+vidrC9WnYHaxnyl2Vpzi16YIKHxHzipdjKhnIh5jGr+bHzw?=
 =?us-ascii?Q?S56NdAddCUjHIRV9M16tmKAho0aqWT2e46x8L1xujQeyQxv7l5FnUnwOmSPL?=
 =?us-ascii?Q?qS3tQwvEelYLiz+PyAP/1iKq8a1sYTgDBPWNm22cBZKwWIWx+OpEdRfNcmR0?=
 =?us-ascii?Q?TVaE+pWPERBhIgDKwkymwTXAMVWTChlFgs+sLMjQ6Fl9dO6EZ7dvJK2+lKKG?=
 =?us-ascii?Q?BRdgD/VDMnnXJj8EUpayyUrQDEUoqdVd0h5/Slk1UmaHiUYSlbmvpFbmvW8P?=
 =?us-ascii?Q?8FWw5uZQze6adt6jOwD12CYPT/1PzzTdTz9Lna78sF1wa8Ui3OP7MhwzPs7h?=
 =?us-ascii?Q?90Sb5MFRR7xpIXgsv0On3gCyuN415xRY8OecNzIe6s0HpZwBEMh96zCiC4/W?=
 =?us-ascii?Q?iPW4KJUKII6mkYvCq+dUBCZWSUy2tVPT/2lJe4jrKA3trPUP2gGaJYsgsoz3?=
 =?us-ascii?Q?WE7KO7NiznG+Q4UMzOyrnSgdPsw5ou2MzGzZ/EhMUqCrUouYPPpyHjKWqAzo?=
 =?us-ascii?Q?/fYbbBg5WPwItiMqxCx0Fg8FHqIgtZ6YhqJXuaC1ika4KIO7eN2L8D6EkLDl?=
 =?us-ascii?Q?tJuvqnHng+DsEt5QFnoUhuYCbe/602hzhTJZJQuaDp96CWj/6JZAxToc3shB?=
 =?us-ascii?Q?JMRtIZFkeI9aNjCqfS/OQcVXTkZ0tRzdpGv4lf8ICICOE82qZMnq13IRpdvp?=
 =?us-ascii?Q?MuYd+yhwile0Z4J5aWAmLTEldce+0VKPmGJDOcI1xdViwxb2hKgWvmaIMkLD?=
 =?us-ascii?Q?OxMnsdhY3H7b7456LojxqL83BFQKFCaitkQ8NWjD01pjXJBAFtZJm2Bce1HX?=
 =?us-ascii?Q?3/5XzfYWJEaBQ1wUB5FjGE2PFg03A6nm6wHlFfBvT+4oq3RfnVY3deRcOczH?=
 =?us-ascii?Q?giBQhcK0ufjLEdjylcMOgC9TMeFXjGgPUHmtKp3r21OY8gjC5EIW507Uc3Cz?=
 =?us-ascii?Q?QvINxwiwbsjKUDtCr0TwIj5qMxCUjDLgNlFuQBgQCGW1dHHQzjjopeIgUD5C?=
 =?us-ascii?Q?JpAZa0ZRvgf649TMSrfdaVC6q9q7dqnzrhoao+PpiNdMzI7mXQBNz9Wpitwq?=
 =?us-ascii?Q?JIrSaC+Nt/GC+ihHSRF3LmeeI/ogtibLK779P2A/LBDkCvtRrWF1vM9BXQE7?=
 =?us-ascii?Q?ZMSoeQaZM05qt16eyY+RpD9qIqlk9g5KF93S5y7tk2x03Z60U645HChgJOW1?=
 =?us-ascii?Q?M+m1oYI/DIy6O96RWIJIQSmAYRzZZMkHzCzmj2Dc1K3hQxp0PeQcbKT+CrKu?=
 =?us-ascii?Q?bdjsW4fc9vgPXGoLoXXOdtoo3UTkPeUQJTFhY2N5+xzuzS85aeJAQZEvziI6?=
 =?us-ascii?Q?NBi3/7Hdj3zggzqJLjXeUMsinDksiZFDhm6pbu/+CVtiwhUHtnxrtUKC24Sm?=
 =?us-ascii?Q?HA6/zJGd9i22YN+1OghX3xZQPU/RuVqSrsR/kxCyHwJV0jGfc7YSKfDXsqJ3?=
 =?us-ascii?Q?9yeqS8LbvqzFwzd3ZGAJ44pCozkDY+/55vWYJD+TA6qbOiwCcix/rp1axEhw?=
 =?us-ascii?Q?zVMzrpp/reC60mcFVgEaejth41RrQhyF5/J8VB1JwNUwhwAp4aP7dC1bPU5R?=
 =?us-ascii?Q?hTG/2FbWJdfBnEOPL4gqNcwM2JORytOptMxLW8pw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135278f9-6d74-4d3f-d193-08db423a3b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 07:30:07.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ify2vmBpM+vAgG4IYEtldPZNT+Q53VGXjZEuQRbw7l/Ef3b5tyzC1rPfRgSj6TDIWp92lXdSnlPCXDzrDZzqoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, April 21, 2023 2:51 AM
>=20
> Due to the auto_domains mechanism the ioas->mutex must be held until
> the hwpt is completely setup by iommufd_object_abort_and_destroy() or
> iommufd_object_finalize().
>=20
> This prevents a concurrent iommufd_device_auto_get_domain() from seeing
> an incompletely initialized object through the ioas->hwpt_list.
>=20
> To make this more consistent move the unlock until after finalize.
>=20
> Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for
> physical devices")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
