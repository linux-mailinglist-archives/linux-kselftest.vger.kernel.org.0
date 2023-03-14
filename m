Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45D6B8976
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 05:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCNETD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 00:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCNETC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 00:19:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375527B98A;
        Mon, 13 Mar 2023 21:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678767540; x=1710303540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=heHYTyn8t+tSgC0zgbCnYcSRmqoeMvBoMKjqJEgqzk0=;
  b=bB5XMImIb0oxUEdUS2vZEdr20Jdt0Af+5Awg3fZ/xIQpaTWosrf2O7re
   VmRs5MF+sD/7Y567khN5+cF8qd1TXt3vzPaLAV5IEsAWIjh8f/1kT0zYD
   E81vLNu586NKp2iRuDbTYLvJ5RkcAapgi7uOGv6DrA9Jn7kTM9rJ1ebxb
   DXsg35PMPZSMQxFudM0BF8JWcjpd3MtNJY6k2a4o3y2rZ05z05Uk1GwJb
   9NUhPoSGuauzqEECmXgQBSD6d1dyiIoTc+d244q2A9oCysf99zcXu0x72
   hc3kQnLPNf2dnptNMd2jrs1qaT+njcfnXKB+DjODBS2gjjxBtbYHR8oHs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="364990275"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="364990275"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 21:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="743156200"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="743156200"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2023 21:18:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 21:18:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 21:18:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 21:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl9AKyACBhOsQxMohfadmqDVDIDpR0a0ZcxpYjH4YIPA3C+XK9+0XCBb89EOMPBPc+Z1lywMEq2dNW3LXE61dyOM3AJAp6/meUtpykj/yRQkMnMfjTwwXDQjK7KPPzqfmiW/cB8SFgrOLVsmF0K6gpjXMygwDtBH5lrlNizl1JvUYDPizKygL9+nea1vHQcjYAsPDLgdEP1m4G8CbN12ym9QlYj6C6J/bzpBmFndXHqk4+sbNlQm/QtHGOP4ou6nR7kRG9qDz/mmEeFfDR+TfCxOOa5/jiHXHLMqKKZ8L37ZE8oNNmDuoV51BbYZeVmAEV3e8mcNKZuSEnETAZTD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1tq2PJ2uYVf2bfd2auIRJgUPkmkhpjmXQMYrOCBsNw=;
 b=dDvH7xkr9Sw8Qin5L2hGcIWRyTY6i0VyVjA7hp8T30533KsJbIQmN0tBOO/y6C6Hu1AAd7Z6F272sPQSHAuI/I+jHqZBbHIfrj2SIAdsSge1QSfS1rcdsLyU3eVRWr7d7QjvpZBxIxx32gYAcQxwk8AgDOB9fe748zmu4PqkgSllGbX9inT7WuarwNgw3iaKId1I+xHj25q8IPZcgo3sGQGFiYX1y8dOUbAO6VW3dz2uSKixOD7wpL0VHMGD87i1iveVjTTX3wmf/7tLx7qCeFJQ7Wu6tAkhBTfBwjylGEObApu7Celg8HxTcmsQogVLoLcaEZBQaAXTJvfFK0Fsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25; Tue, 14 Mar
 2023 04:18:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 04:18:21 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHZUl6BWo8K/M9cuUy0397Pqa8aG670TNcAgAVllSA=
Date:   Tue, 14 Mar 2023 04:18:21 +0000
Message-ID: <DS0PR11MB7529853F52AE5E338A84AFE0C3BE9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-8-yi.l.liu@intel.com> <ZAtt4F9zSZxptyZh@nvidia.com>
In-Reply-To: <ZAtt4F9zSZxptyZh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM4PR11MB5469:EE_
x-ms-office365-filtering-correlation-id: 7754de7e-6c73-45d4-4861-08db2443257e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OovqPJ+Wmu6ctoEaFSa33uQuf2MkygOumo3u+GJpIrRyLr1pQ+stAGAZXidUMOp/84bqTbnrP/6OP9NPQjmQUDNcG+eXNLrg/F1Q1p1wC1X7oU5MgdKih9cx7BjAP3zybLAdaRkxkWt3qiXWfCc8vQxm/iOByYwRQb7EWwTRDM8Qf8pmNBzMrtcqwxUp3TtypzAJCcEBYeIOhqL71L9Sper720bSTG21jA8vTYM3ife4N8varNjJ0lfiAeflSYhQuygAG00hox/vbOQtdHKPoN3Cbc81GP3YtmEqZOyCLtnfP9eqAHau//a5mkVG6BwPSHF+dlBP8fnfjWI//aIbGoCXWsVWIPOL5Ayd6NY7c2Y801aeTbZIeltb+K4rMMSeoG3hwRVhN2BABKiIWkjLoYHIrIX+Ao1oxP3QtvgvadYIw+saf+e7/lKR1lhCJT4CwmZPPgJH7Hovfk/R4Dd55Sm3GP0XTdIDaiDUa+aUHFM6BlJKh/x65x9hNKQqUKZwIFOXfjnTK2dyq/xyDUQ2SilMAScuXaXXYWBYU3dgY86flZT5GF3FmtfX+i4QwvDGHT7XGfuOwORFHMUihwgwWZJVzyuARYzl3akgner7DanNC+wA/fgZPNO/0tpYuMj/muWG4VK23NqYMSb3o9kmswqNGQWoj4eQQ/bmph0ovMa0F7n9e3ZD+aWeR22aVW/EWm22OE9mMEeFMt/TPknZgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199018)(5660300002)(7416002)(83380400001)(186003)(478600001)(26005)(71200400001)(6506007)(7696005)(66446008)(9686003)(54906003)(38070700005)(66476007)(8676002)(66946007)(64756008)(41300700001)(52536014)(66556008)(6916009)(33656002)(4326008)(8936002)(76116006)(316002)(86362001)(38100700002)(55016003)(82960400001)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NcAxu0bD8W1A6XcwinXiIPHtr1UYKK11kC5oeysj3CfPmC+VCHlMWxgP0srw?=
 =?us-ascii?Q?9LQiPBJEWEHLNhjePoIWFhwg5MF6mx9hg/h/bAhmNAAczvbYWJxPCiYZDepA?=
 =?us-ascii?Q?hg832A8OpqMXPXwY2D3vi4TF7XhP5UUhEpMVjHvh+CDb6qjUzqCP6QYE8Gsf?=
 =?us-ascii?Q?C4A9SJqtXypN6f7yOa8KOKDm4lvbJ9TywnZsTfNzCPtOm+a1rjLFJYVwEyJF?=
 =?us-ascii?Q?1w07f7gie10u1e/8g1EbGLdSEqDR/FBywk+pvjBo3pIleTwZOUzGbMOh8Sun?=
 =?us-ascii?Q?CAWlUS32p2SdUwN7NldDSUDv5cFZh2ZvPq8d3u5kPCMLu8d0RvbRvuAlAzKQ?=
 =?us-ascii?Q?70Ppgl+bckaNe7VWfBnR2uV5QI3GqKo7hlB10X7ZxZtSPF5nBLRLJRRmQ42d?=
 =?us-ascii?Q?rAA6lU6Np951wyAWvh1/0eRJEklhHuhAZPNX6pSQocE8PPkntM0niN8c7DaR?=
 =?us-ascii?Q?IzrexvwEH6/8Azv0QwTjcx7A4PlQC3GdbJDYVRzHN19RTKXgzpTa8IRgIsWo?=
 =?us-ascii?Q?buN9L27KW+Q1WlqNJus4o+b0S9Mdh2zpHma2wTpT+scEHJBVK3F2iiHfjQ8V?=
 =?us-ascii?Q?kgxFSKwLk2D1xpuDAr1QP/dtbG4ReDmM/Dww0ah4w0uHJvGaYJFAkoA1znQO?=
 =?us-ascii?Q?EKuu60jdkzza99Y/Xm0NxyIbMUEa2gHSy2jaD1VSZNj2VQ4IEddZkkpuz9Ep?=
 =?us-ascii?Q?JmU6AlJgRYYRvQXgqwL7El2JQYy7fbQCoRuhqVpfZX2flMK0Or41y71Rq2kp?=
 =?us-ascii?Q?t3fSHbGQhzGC0HTgfX6/g+nzUd1ehqrbIMuWIjt9QChdzimbEjc1s566t+MA?=
 =?us-ascii?Q?+foszKj5r851RQpkuONyiH5GJsWk6bSq011HtxNM4aurI1dl39RVd/83TkI9?=
 =?us-ascii?Q?rQY+jTDVzlDOJi5v5ZbFtlctmgURIYDS+dQ6rSHmJmfcerruX9w6CBazebAC?=
 =?us-ascii?Q?pN9DJTgC2nEBRlrM7owbyoehAOVwspunqV+lCzX2TFTY0L/LF4n2HVC1bLmz?=
 =?us-ascii?Q?PLHuZxTUi8oBcu6vBkCw7AwpjpuhwJ7bsE58SYFZla9Vo1Ga00R+1SaXpkWK?=
 =?us-ascii?Q?9tJS2Z7nCjO4SaJdGqO9kboKvP34edDvHMnd+alZvstpRuCr+BnEu+aIviEb?=
 =?us-ascii?Q?TozF6LMtRuoW/Qy53aIJDqDyrlLP4TQRPoKb83APo+9HCUAoAkxUK9gpvlns?=
 =?us-ascii?Q?Ztf0FHQ6owJe9AvjGjpmJh4aqZgxrefYHZiqK17yIhRK8RujpyN2J+49EwWg?=
 =?us-ascii?Q?DB0te9Z5MBMLscOH6v/cQygV3f3ZTeXBvJp2HAMQR8kYMbHqgnMig8g/weOo?=
 =?us-ascii?Q?4uBX6DWdWEvr8xcdexn+IPw0V92myMB7P8CIIJJh7cGHf8C69tCOKvMYC02Y?=
 =?us-ascii?Q?lMOazgwt5YAvXRZkEiuXX1rJfwwg3pHJlPT4D7kGY9hsteBl5YKoDGYha1IQ?=
 =?us-ascii?Q?wyI97v+Key1Z7GpW2nkuK2zx/i+XZ6QhWWMArMBpi/cNt2muDtWRoDEbg/Yo?=
 =?us-ascii?Q?Ti05tMmhJgCsL+3bI3+szQbiD2YVx34h8MuU/6Y/H81MPHH8RCgTGzs8jzql?=
 =?us-ascii?Q?w4UG5cfJkcfxkI4reG3OemAj6Vr2Ol0QYpuWIB6e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7754de7e-6c73-45d4-4861-08db2443257e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 04:18:21.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq19gqdRH6DrIvPyUDjrB6XxujCdaLG7fJd8tyk+m3o07Vo7zvTRa6wcq1cEy+/RUY/0QVTyakJGmajREIOr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, March 11, 2023 1:50 AM
>=20
> On Thu, Mar 09, 2023 at 12:09:05AM -0800, Yi Liu wrote:
> > +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_hwpt_invalidate *cmd =3D ucmd->cmd;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	u64 user_ptr;
> > +	u32 user_data_len, klen;
> > +	int rc =3D 0;
> > +
> > +	/*
> > +	 * For a user-managed HWPT, type should not be
> IOMMU_HWPT_TYPE_DEFAULT.
> > +	 * data_len should not exceed the size of
> iommufd_invalidate_buffer.
> > +	 */
> > +	if (cmd->data_type =3D=3D IOMMU_HWPT_TYPE_DEFAULT || !cmd-
> >data_len ||
> > +	    cmd->data_type >=3D
> ARRAY_SIZE(iommufd_hwpt_invalidate_info_size))
> > +		return -EOPNOTSUPP;
>=20
> This needs to do the standard check for zeros in unknown trailing data
> bit. Check that alloc does it too

Maybe it has been covered by the copy_struct_from_user(). Is it?

+	/*
+	 * Copy the needed fields before reusing the ucmd buffer, this
+	 * avoids memory allocation in this path.
+	 */
+	user_ptr =3D cmd->data_uptr;
+	user_data_len =3D cmd->data_len;
+
+	rc =3D copy_struct_from_user(cmd, klen,
+				   u64_to_user_ptr(user_ptr), user_data_len);

Regards,
Yi Liu=20
