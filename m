Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40E66A8F11
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 03:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCCCNf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 21:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCCCNf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 21:13:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398DC10A9B;
        Thu,  2 Mar 2023 18:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677809614; x=1709345614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3oPChdHHdJU1pq/pBbCauPZ5MZxwG9JZ5bXJ+a0meCM=;
  b=iltuMThq7L376M9Jh523IimtL2IadmmE71U7EjthAjo4C5Tjr70Zpsfj
   7T+WzLskkkEtvmjBdn2xasfhWMMA5k6v8/7kHEO3HsifYNBY8deLVlzaJ
   IQnH5fDpxon1jdnoaoJenIcZVLVOWZdlCUwjJYZK2y0m1o09+gRcbMAs3
   zKz4yj2Y77hSNrFbKZGjjGzNz5lpTXbNPOlho4WoNn4Gw8Tus1f4LEsRu
   auF0Dl0SsOnA9tjDYGbvipP6LTJVdC+1MRRD5RYzK+BvRh4nnxU/PLwDc
   /hKmRACTiDmy2Dljs3086cyrVEBuzSq+ZsvoyO0/jC7Rej/RqSiCxxIMH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="318750588"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="318750588"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 18:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="1004404727"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="1004404727"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2023 18:13:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 18:13:32 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 18:13:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 18:13:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 18:13:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdhzKbkEBRcI/y7PTafb8yIMesh7Qx6T7BxZRupwyu7v9ouXV0/iPvu6Hu8Yhyt2vynvNf9LXBmqk64oEPOAIt/cCmtt5p9AKCNwthOPI14lww2w2ELvfuyDtYwVpXL07rYue93ZCamotHzE/OJzEUeIhwYoL88BqSA0jste+EpyzvPl2549hO642i/eUJY/LGCMUyQwy1AibPKwXQ+AVjLmeJsgkL0iB3VVy01UdFE4VjYz05kxMaKee1tYv7G/9GoA/pdPBkfhB2M4d8Wi3pM/v8Pbo7i+xA9rlK1znL1w3ypchqpHhHwG7oDqvI0sitJDBiPW+nHR3oFjm5UPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYtlqcg9kzTLw0sGNoUuMkr5ePe96ixaJfV1euTxAnw=;
 b=EoAI3M3R36oCfFPemRSg8KfllnAUxx/QSNGCcHKOJy3VabM6RVqFwrWem0LZQnH0BBz6pfSQbIYQzu87TYSTNmNxV+okp6E65NzCOdomJjvV23qAGkjRsPGPpPcDz7SvH+kRNJJnUihhr2u1onFaBx0tuSivlUfta8lKnxHchL6E2GR52VJVGfauMWSnFCL0yvu+jIr7S2jUrNYioIuWc19B0r3EnK1PTAFqdRZlkl/bAGlO2nfJbi6V/H9Y4kJ4mrF8xCf5jQfbk8j2yFzqD5OQtHsMfRZSSNeDelElWhbweY4oSTYPluA3cCg3CcWHtekEoz0JMCfdhpqpjym6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Fri, 3 Mar
 2023 02:13:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 02:13:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 02/14] iommufd: Add iommufd_group
Thread-Topic: [PATCH 02/14] iommufd: Add iommufd_group
Thread-Index: AQHZSLARxLaEke/AGESa0unZyuRN0a7nJK9QgABVcICAAN62sA==
Date:   Fri, 3 Mar 2023 02:13:30 +0000
Message-ID: <BN9PR11MB5276F5AC80DE63A6F5B020ED8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <2-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52768565CB65BCACA4E3808E8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZACb415lOsmjaJz1@nvidia.com>
In-Reply-To: <ZACb415lOsmjaJz1@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6010:EE_
x-ms-office365-filtering-correlation-id: 2379aac6-fbce-4c0a-c6fc-08db1b8ce1e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOhqit+9k/Lp0AurWaCLLdfTmeDAhlEPjgHcWR2/Ns70nVawpJSNznQO2BBJGixiADX9JP1bMgF5kqpl+Y+2DEe/0db+i4cxkj12LolD921R1ioeyG/M7daq60uSMGrqqw4PC4tuP1jaQ1p11Xqmr5tPhN0VB/pDsHEWnCJiLPE/o8RmFigABcetpwXmXIk+jo6E7/Z95bAUlEI0RRgGHGrQ5cCfGESHsZVc7Lg0gNahMIH49xzJkCUt0uiPR5GmZXmef4rbNO5S60yCS6q6+giYgVaQ2cfGlg9Ax75S0bWDflBNYg9SEJasQ8wH1qNSQYubhkVHtYdd920GiYs18mkvqbL8LQ8tY6GV0+v00nDsvHHwVlablCIyhlamwyBYO1SUSbOAozQvmlcUXUr6Jmgz/NoQDj7MnmF7MPqHCCK0iRRuAIOUXTywy5X/JHNPW+uOjxPeGo6BuzLvwL/v+rI28fXcYwiaTD5is5+nkd7hU9bDWDftPnQAY54jHgVlrfvj0EhpbAo9COhbepoY41hPq7G9pNc9a9Yxriufopi3FmcimXx3Dd7gIZH50mnMe4Ma9oygc4sn2fd1QgaNUR3QnQm8F/qUt1Upaqehs8zWxNd8RvxoQB2ZWwFbm+NiIg0q+7E8YcOkjR8YjkQi2hP295TEG4PIJu6bIhvUJOSAT5vkCK39KfQB4rtEIZhj4tNiHYTHPbNqFlP/X3mX3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(316002)(55016003)(54906003)(33656002)(86362001)(107886003)(38070700005)(6506007)(478600001)(9686003)(122000001)(26005)(82960400001)(38100700002)(186003)(8936002)(71200400001)(7696005)(52536014)(5660300002)(4744005)(2906002)(66556008)(66946007)(41300700001)(64756008)(66446008)(8676002)(4326008)(6916009)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dU741ghLUe0kL65djfd7nrTclQaPJmzDY+8PGisOL55hFxGoLg103/xtVy7G?=
 =?us-ascii?Q?jC4Mgpjpc/EhovBmD/+pO00T7n7DN6XLm1Fzi+yQ6XnV/zNI3UsCgcuIlebG?=
 =?us-ascii?Q?JLYicwwOJMU2nujnZ2+s+NTpsUNsrHFvTTVtW9W6NXRUClbNlbT1JY7WsFoG?=
 =?us-ascii?Q?tCe/NTIvfd/E4uHQ4bmMb+yY2yiU/+ld87TfVIyEnZjAiOyL+KbrjwZArKDp?=
 =?us-ascii?Q?3K038vfNE+LopkOxNS196cQC//vdRIVuTFgE3I4ohc6/+VQLjkttohQataL1?=
 =?us-ascii?Q?Mo2tCxX4GfjZ5cF5zQpAlTKl7SRvYHX4Dfv8y14euKOJx5Dr0t+j7dT1Tlw4?=
 =?us-ascii?Q?2AL6EK7yp3F5wFRoWSQNs45SaGOZp6SSU1Cd+IIbgMhhVbt8sQZC6/Yz3038?=
 =?us-ascii?Q?dpKOgug8WstfoHW+o9XxpmjBUM4SxYMSVlfuGYrgJrRLtP3VXgmjzu0YuYJg?=
 =?us-ascii?Q?pWCYXrZ35Piz703Ny7sqQV5/GCL1ZCslrny/9AHvWPLSoahjJfHViTx+eoJD?=
 =?us-ascii?Q?oORnL980DnkDhjsEdbRi38eB9FUTDOJk4mBIYpCpbxomT7O3N94nE53TYj9L?=
 =?us-ascii?Q?GR/kzlNJ4F/JkQ1JnsDBzug2470Ma75i/jQnjL7iup+FwgMDvrbZwv4Ur76z?=
 =?us-ascii?Q?xiPOCpXFaPG9hdqKl+UdyVLk7B84+tP/MGHJRhAwIhDL+XdIgpqzwpml8vec?=
 =?us-ascii?Q?c7kpZcuQiwBTxW6mXJuJkewLo5HiZW72VcULIGSncXjzIk2lAOiNybCkkE+X?=
 =?us-ascii?Q?kghS97juFlcOPCqMi+a/IbwA32CCQZP8pmmVui5oUPqU2l+fSLhfYGavduQd?=
 =?us-ascii?Q?5IndCDxh7E1Yv6RKXjBza2ex3ddOVx0ucIgCwAljaY22QtVn6W/FkOWwT0+r?=
 =?us-ascii?Q?4WkpT/nrBU0d18+Ozs+ntDEqNJNf0VPB4qzrvSCtsBlE3YpotGFJqPO4jXLC?=
 =?us-ascii?Q?kqPcp83bEfTptABvJ7CjTBeNKxEfDmry4TfA5jzQ96drYxB1aN4qr85eL/rf?=
 =?us-ascii?Q?FWe3ydsQdYpwbGwDkGE2NaeiFHpaQy4DwQ3bSrlH9a3Xu54+UaPCHcjQ/pJg?=
 =?us-ascii?Q?dUUolgbvpIdf+v3sax+8ROer+r9BRJM2CJkcsTHhs/0nblofRGZ+5rY9IDGz?=
 =?us-ascii?Q?V4WNozO4ZsfnOw4MSb4VHwTxaExk2cqg22BGgwe052ipM4ShJssIl5cjwZGD?=
 =?us-ascii?Q?u32SA5P7VrKlfEzV/uSz9UoXCu6A9uGzGCsNMchvwTp+cFAu2ZFORVRI1oa7?=
 =?us-ascii?Q?gNU92J/soFcNeeoqHxNxLnPfdSWbglkSnn0IsI9mUox+Z2WEYmb+sQtsMm/y?=
 =?us-ascii?Q?CzkAxjA7jzdi7jclbRZbxTuB0Lg0y3ZBMIEe6PVMJ56kKtsKj4neekWaHJTI?=
 =?us-ascii?Q?3KpojKbYr8VvHkbY7vFWobJNcJwMXd16w5oAYEdtcYkPhP83AFhUZeXWGRsk?=
 =?us-ascii?Q?mAXdaEQsqDTDww0CVZe2J3oTypknU6t8o1JaE3cotL+JZlP9U7wchOtG99Rc?=
 =?us-ascii?Q?VUmPe6P249qWh/1HWV7eM75B6qC0hK6Tg56CkVnlc8qeRwdMgKNYPoS6oqhQ?=
 =?us-ascii?Q?TmxlaSQiLGVmWhK5GuhC4YbFar1xQI95WeJJkije?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2379aac6-fbce-4c0a-c6fc-08db1b8ce1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 02:13:30.1851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bW9oagdNYtBn72KIiUH4hYJrH+QpBrtHb64GvXvMRsxEvxRxLPm2Kr/SZYCcJi7JecUa2lCdS+SRFJmk9TgSFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6010
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 2, 2023 8:52 PM
>=20
>=20
> > > @@ -98,7 +195,7 @@ struct iommufd_device
> *iommufd_device_bind(struct
> > > iommufd_ctx *ictx,
> > >  	/* The calling driver is a user until iommufd_device_unbind() */
> > >  	refcount_inc(&idev->obj.users);
> > >  	/* group refcount moves into iommufd_device */
> > > -	idev->group =3D group;
> > > +	idev->igroup =3D igroup;
> >
> > the comment about group refcount is stale now.
>=20
> You mean it should say 'igroup refcount' ?
>=20

The original comment refers to the refcnt of iommu group.

Now that refcnt is held by iommufd_group and no movement per se.

I'd just remove this comment.
