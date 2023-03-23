Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1706C608B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 08:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCWHVx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 03:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWHVw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 03:21:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC639298D2;
        Thu, 23 Mar 2023 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679556111; x=1711092111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CevWnBC2ffi35MEwprQ1l2NHCvq9m+JMnLsgl6+4xC8=;
  b=Z9KdhuEh8HPgll1WymbasLAkoW1jmal3Z6xQ3/mjZIBFGz4LNkbGFvP8
   fyye3DpsfMJbhC+qwiBjrIRDahulI5demkMK7Alez5wZcSfmvlVsoAkgs
   0QFWzRLwf48L7bQCvXsLhhjh6R3BddzFLWsN0WVJoJpKrLMYrJRPvcIpC
   Lyl0Izi9dep5ACHU2aU0QnHfz7XCerYA8syfTRJSFEw4Zgjgjsx4ntkwP
   KwP6XxYNBzHGSlS5CoflzKRpFi8Kz/5BoCAyRY/j9ItIHz3q9e/qtO1LW
   IIibsvlg9hlf4zCmB+illfgpkRQ3L+m6nvBtmLW9m1Aeqp12anYy48wSy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="404304281"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="404304281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 00:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="806144830"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="806144830"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2023 00:21:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 00:21:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 00:21:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 00:21:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 00:21:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbejzcuywp2ezsY/vCz5Q7+6KvdVZ3oYhvQTafvS2XRpWK8vdCtguhVKhcnEOklxhWQhDr0rUSHxYlXNZ5oSiXgl00yH0uUlqwMy4IQSg27/l4cJlESSPDqn5xdmATLRIr/Vy8XMCcK56ArZ5g530RynCD1QSGrhPPplbpOWGyPLCM3/E9buMUkEfQvrRXShsy3wSv8tRBzGjpcWM4YLhMKDPrQhXscNjv8ETjcdgLCAGc4YbWZY42i0XUiTBCSiF4MvLpbh85MyWqLYyQjVGwpZ/QtrB6ivnCcexpfali3Ug0zl+jjAj7aMVQfVw0aWaxnNrTyrFLLMn9HrXfB0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AC3ZcWLZgembrbl0KuxNiZivBqDvJaeNP2Xt0QgACI=;
 b=QgNh2KG4VcQcWGgNFSF69hDNup7380FXK2Zrsq5247T259JxrZq3JY6N2vViji7GQirw5Jaundm0+oEMFrzn1uWAsMiLxJ3ncHGVBHkTE9ublxwZcJOBxn0HRX/NPAkgYKd6xs/PkMo56ldYBcDvKa7cNsEpHaOUb83O6gYLCzPOVcGQ/jBwuLuFEtxLBbnIhAWkUEelbKZwrlPqbV3rPpLRnXerQAQOUsK0bPGqiTWh1+63xd4b3/E4uZ6IERtsszCL578LhCxajSWK3a40wcZwK6lKnkmeykZi5U2Fr+YMRabUgFkKxNJgTnHu60Wo+JkgvLsjXf0eJVu2IzgZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:21:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 07:21:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZXCmFXuCDj8eADEa48b1mh4jx9a8H8avg
Date:   Thu, 23 Mar 2023 07:21:42 +0000
Message-ID: <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4891:EE_
x-ms-office365-filtering-correlation-id: c87742b0-1c9e-4432-3b61-08db2b6f409f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyFnYDu8YnR31S0DqRY5mY5EA4ArqSLjd0JBCBYb4t0NPAAs4Og88JIQUscK74MCPGScQLMhg8BJ4rqkFusSkVd+PlSgRrz+idybmRgQ20gtptmDEZzlqrBfh/p9C1yC68mDofoA1IxASKjBp25xEmAwvVubHgc8+appsxHi7VzqC1UGrV0/KxOdc6Vpn+8A74xvwUKoBwCtN5kLN2F92JOEgvDvBNQvBvybxkykb9oQlDD5WufyluJ3l/l4OGmfWTCW6CABeWCpGiAsPiVBtXZTYV+Cxc3CIapIZKVMqwQGjD1cf1skfOpejlm4O5hCA4L/6W0Z0ZUDEcHtXvlfv+7UKKFkBsIQLMB9t4k5PjodsDj2AP4hHm9UTXnzjz/JaNYv6ABBSVR6f44znZoHu9i44YuJzP9qdF17RnMN9CKnbLpaIyTsZV0pR5elIY5QbLTXnIJN4xE6drEJzhlsGQcSa619IUFcvySEOizYvkU5lClNfRg0XzcEvleDLqrG6luPulIVba3x/67UIXaMUJq7jMA1BzH2yfo2Zcg57Yq88apnyKHCa8N8eK2vAc15unCjCxy2T9QuJVefyFsKTZzraPu7ehfzN755W59+9+/7sjc9lad98JHpckNEb5r/Tpu7A2pasbwvwnm69aKM3cjQs8ffoqYyQuaDSw5MsZEF/KZiXdbf3PRAPZ3C5FWkuql0i4Tt4JP6LZk6FttcUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199018)(26005)(6506007)(38100700002)(82960400001)(122000001)(55016003)(83380400001)(186003)(9686003)(54906003)(41300700001)(110136005)(478600001)(33656002)(52536014)(5660300002)(8936002)(66476007)(66446008)(76116006)(66946007)(66556008)(64756008)(4326008)(8676002)(316002)(86362001)(7696005)(2906002)(71200400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DyGEAcLMPhbQct0/NKdsGnZDkUnjkJiqLUZEUeocXwt9W6Od9TkfFr7g3+9Y?=
 =?us-ascii?Q?S6nVqPVE+reEuEolj7MUXj9JC8AmU34LDrImVOEi7rBDvK0M44/iTlO9yQiy?=
 =?us-ascii?Q?HF8TS0NcAld0NDjEjqkoeWm4UILutXqbbN1v8tNfMOq3wvBr737Q19Fxop4e?=
 =?us-ascii?Q?KLuo+AGfWqX9OrNIXgqZwuTHVSEfw8I5omlJBbxizHXCOVq35jZiN3SyAikW?=
 =?us-ascii?Q?zfN4TPCvZfgg+txBYGoxgwjS3BTM0ry4Lx0gR/Um0Au5qmBP3RDduD/7ZOzF?=
 =?us-ascii?Q?unyHznjv+2tCKAQQjX22rzr+qhaogCaNyZMa0w8GU0hTNpuK5Y8W3q5D8buR?=
 =?us-ascii?Q?/gBX3rUo1fQjDcuIKVSB/0NUEM7q963692tLNK1+AnnftgCcDRy/Pwem7tei?=
 =?us-ascii?Q?Z7MAVLItS+NC5Y213OfzK04K7SMFSqgUESteZw0NJV1qYi03vIS7huU4G3hy?=
 =?us-ascii?Q?l2zZ5gjXPQuj7VXMvyQhCRzIXeGbCRpiVcf9lylEB4Qz/8OErd4nCxRV2MAf?=
 =?us-ascii?Q?Y0dU70gB+P3VSrWurldwtwMDcvNf8siBbZDIq8FTsDmVlYYdal1k7tP7JqXr?=
 =?us-ascii?Q?Bdzn2iQJaaxfHkw2a9y2784Ao938iidKgxBZ9AGZAHdXnzoqiwjIpfmFZDDV?=
 =?us-ascii?Q?61jG2R5Hjhh+Jj8qYa21V1/HLhfmdS4hay4P3HdURGBNfyxl7bjpGx0NpW2g?=
 =?us-ascii?Q?YOqXLWxQGxh1fQcoqpMLAhxUljaS6AueNFmm7PKwOMJ1d19k3qcSFlv71Egl?=
 =?us-ascii?Q?v3sSPCthgu02nbYh7yMkq0S0J3sCQnaQ4b70v6IASsWVBuN8FQHXmEsjTiLF?=
 =?us-ascii?Q?HWgezDm3wnB1PwszteOYYxCbNNMrmtGfmEV2qQPTyKOun6f1cnz2RoIsnPYD?=
 =?us-ascii?Q?MyFW1rJlTvXmr0URph1sJ8ztMiy3onfHr1503vIdiOOQq2sB7Ua0joVU/h1j?=
 =?us-ascii?Q?V5/iK9V56lXLB/G/oBJxW7zWmKoYvBxxm2w0vZzBBLJAaVtiUT3sOTP7U2uO?=
 =?us-ascii?Q?PJ65NCPrfRinDN0YuHwxTi+jNa/3BZ0cMXzHCP4GDdsWuOTKruaQDlBhCGvR?=
 =?us-ascii?Q?3TAVlFn3W9M+ncH6C/SRjZQNcRqRZz9bCYsA0heUzQYPNdFiHFj1IKZwAZ9g?=
 =?us-ascii?Q?b3ffgxSK1k9I09PaPmRVAOcu5sc1kTF7/cSlhw5lyHskwHvDAuEpG0lpU5Mt?=
 =?us-ascii?Q?rQYmIEoxzB7ykRpRR6drlDtiaY0frE8bD9xZXlM7xsl86ykfbbi1a/iG9SRd?=
 =?us-ascii?Q?ewqOvp2u5or2pfxcFXu9KOjUqPmV2Z0u7FQhG06Hz4Ro0IXdodywup2oWAEl?=
 =?us-ascii?Q?tcSND+/InEkM6FUjg/gB4Dq5leivL52XkfJbL81gjzDq177k0eJboOmgEI1W?=
 =?us-ascii?Q?0b3VVpUGfmKDFcbSaqzV2Y5VOumvKVjfsSgVnrG7nDcUup4DGlXLWIcXxIl/?=
 =?us-ascii?Q?U2N18KpnuQ2KzWsBf9zeZrIrFjT7PICObkS1g1Gt8zAv1RDkU8pXe6uSz9vZ?=
 =?us-ascii?Q?gy+0NjamYkg3SyU6i5cTQubYfwXOABmZix9l2RtShA9KHEtCZ+8H+1YDrL1Y?=
 =?us-ascii?Q?AsF32Y4lxtvJ39h2QXSkfbyv4tVOOgfznHtl6HHv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87742b0-1c9e-4432-3b61-08db2b6f409f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:21:42.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jG6uaaoqUTDISqHnpcj7V8OZcRQrqjHzKReuZnrMVUZwXg+TlhdDk89INwtWjTmK3KmFYCEyfomKG+iUvkAplQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4891
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:15 AM
>=20
>  	/*
> -	 * FIXME: Hack around missing a device-centric iommu api, only
> attach to
> -	 * the group once for the first device that is in the group.
> +	 * Only attach to the group once for the first device that is in the
> +	 * group. All the other devices will follow this attachment. The user
> +	 * should attach every device individually to as the per-device
> reserved

"individually to the hwpt"

>=20
> -	mutex_lock(&hwpt->devices_lock);
> +	mutex_lock(&idev->igroup->lock);
>=20
>  	/*
>  	 * immediate_attach exists only to accommodate iommu drivers that
> cannot
>  	 * directly allocate a domain. These drivers do not finish creating the
>  	 * domain until attach is completed. Thus we must have this call
>  	 * sequence. Once those drivers are fixed this should be removed.
> +	 *
> +	 * Note we hold the igroup->lock here which prevents any other
> thread
> +	 * from observing igroup->hwpt until we finish setting it up.
>  	 */
>  	if (immediate_attach) {
>  		rc =3D iommufd_hw_pagetable_attach(hwpt, idev);

I thought about whether holding igroup->lock is necessary here.

The caller should avoid racing attach/detach/replace on the same device.

Then the only possible race would come from other devices in the group.

But if above attach call succeeds it implies that all other devices must
haven't been  attached yet then the only allowed operation is to attach
them to the same ioas as the calling device does (replace cannot happen
w/o attach first). Then it's already protected by ioas->mutex in
iommufd_device_auto_get_domain().

If no oversight then we can directly put the lock in
iommufd_hw_pagetable_attach/detach() which can also simplify a bit on=20
its callers in device.c.

