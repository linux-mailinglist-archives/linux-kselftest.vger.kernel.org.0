Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A96C614C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWIIN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCWIIM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:08:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3BB3ABA;
        Thu, 23 Mar 2023 01:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679558892; x=1711094892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xug2CztmLygpb7oMylEVnUQ2pRCuoDrBEtIUDW0KwAI=;
  b=AJ94b+oYX8H9h0NAazZhVLlY+fBQV2COfhtZzWYWpY0McW5iztQ4wGsO
   SkjlAjahk8V4LO37hPwjlxZxvLtT7qdjuPCng6OVfyRfTx5wHQAEC/K/i
   3EbXGHXxFwk3ioaDjAiQ75EPErreRewVAYtk7qVde6/4lbiFaAa3mk3K2
   dOpvi80H3U2ylnH44jUEPEtSt36XqSLWl9oXHJAqjPBEXUD4gB617+wVF
   jDVADSXcH9jzdF13r0ZY1NG/8XpkIguB1iwf0R1iqmQVW6mwLPg1agjRP
   Ea8uLv+q71Sn82lC0Zj9UL/3DBSYjSmihnoExBP1n4CLiKVCRBjVAD8o8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="336927546"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="336927546"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 01:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="632302173"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="632302173"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 01:08:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:08:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 01:08:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 01:08:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVjGjhjqRR1hYG1AhRtZeDF6UC+f5DGITexhBoBt0zw9Fuydauj46AxDwQZJW6N+F7BU4fh+GA37XFI+aBm/IYJ3Q9cTd1FTv1sCiknDlfc9Vp+rhqY3FW2WaJaBdrEfN7I8RfdZKY2ri5GTAIFXpTCmearbjlL+rg3Mn5YoDVdAxp9kyP0R9RRWY1swyk1jbnopHr+9YqPBo+mLU4t3jikpo7RvftiKi48aOOwBZMMOBZau8bBeR4hxG+3YM30oeU4tug0ONtiiSyP/69tgCr8SUZKIZXG1PEycTYj5zFGoS7rQHvRCRUcI4ZC+lGcAGDhCeESHO1JoyeYJdRu+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xug2CztmLygpb7oMylEVnUQ2pRCuoDrBEtIUDW0KwAI=;
 b=Y9FtuuRoD69CqBZPykY7WDf2rZZfUjfmLpLX15CN+NQfhGY7bnBgg7rD1r8tvg1iiMnlvDSfOlfZuAv9L2UE90ltZq1+WPDVVS0ltSbchtuRDwRjSFSFrqs7iSkAMROX3JetC48mYT86Uj01np/33TqU818S2KqHMPozfN4wWYxGn1e+ui0EDLVst27VYI4nCW7s2gEZVZl5fW78GSmTTxm1FsR7i9Kk1MfOR6TxOb+yRyiNBN3gkF+E9AoONyI7AOHfPkRQRdpH9N4TJ6gPGFFUA8goxQAJS5dHv0J2/CvBp5LFQp9yZEY/BCngxexZX8GNcsjOdkYNKAKHLoFcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:08:08 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:08:08 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: RE: [PATCH 08/12] iommufd/device: Report supported hwpt_types
Thread-Topic: [PATCH 08/12] iommufd/device: Report supported hwpt_types
Thread-Index: AQHZUl6A5YBS+XH2i0u2lqSlYvUsoq7zXHcAgAA9dgCAAAEccIAACK+AgACpyACAE8rQIA==
Date:   Thu, 23 Mar 2023 08:08:07 +0000
Message-ID: <DS0PR11MB7529A9B7872CED0F1A7367C8C3879@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-9-yi.l.liu@intel.com>
 <f0076d6a-d764-b018-7442-08a6293f9553@linux.intel.com>
 <ZArXyj3iiPa95aCu@Asurada-Nvidia>
 <DS0PR11MB752928ECB7D395C601F14246C3BA9@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZArgAXMUpNjDfFgZ@Asurada-Nvidia> <ZAtubgIHAOtrnIbL@nvidia.com>
In-Reply-To: <ZAtubgIHAOtrnIbL@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM4PR11MB6287:EE_
x-ms-office365-filtering-correlation-id: 618b7005-a91b-4403-acfa-08db2b75bcb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VrQluMddoqgZMsqkqA7bTK290gBIYRRxZqi0wfLKuDeLzY8d+vVlA33NAXi3hMaVWoClNlL/fiD5fczELYPf/WHkjDKFTygK6n/qFIZxHBRDhVwyvwAEleMsWtwpnsVDFkz1ZJO9UqJvnhNHLkA0RunvMeUBsI1RzdEeieTRhfrKqMJtdkSjAx1Ba3OV9Dc2X4Kfw87YV8465t7C35ryVpd/3tspZWV1C+W/K8LJgJxe7OaNliD6hSn4Qpe8phHlZ/WIrvSUvo7kdv4tbCfchKrop1wasrIWE/mKgE2nLiMWT7vd6JAiuCeCcbNWYAoOy8qtVKKxuOQb1/Qma5+5370NhkgrHqDOqI8PWGw/Xr8jEO993P+tNU8edXr/seAtTsyczlLyAUjxG/v+hPHqyvwCEDX5CjKAeOixvzmsJ+qMLsxi6RzQDPDpaIT1FCP9cYGHmZk1UBqM0H69PPfdsr8PSyKGjTiru6PemlZI6N2jXFGx/hdakhRq0tjsmZeVXEiBPmVhiw9SYC+AHeQJuyEbmyFgwLP8r7FM9YaGgaUGwWfizXJDk+hOOEk3dsWSRueJV3M6LfDRAuJqemzr0UF/FefMuQS6ox+n3+HgkZsg28yWHhkaGgUBSInXVkzaJ+adSiZ7FoKP7J2ccMzf9tnjgdzvh9eA898Atf+uvQw2cUP18g1dCi0GEAC6YDBh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199018)(4744005)(55016003)(8936002)(7416002)(5660300002)(52536014)(2906002)(33656002)(54906003)(478600001)(110136005)(38070700005)(71200400001)(7696005)(316002)(86362001)(26005)(66446008)(66946007)(6506007)(9686003)(41300700001)(38100700002)(122000001)(4326008)(66476007)(8676002)(66556008)(76116006)(82960400001)(186003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R3rClcGcc8GQEid7ks9BYhwiIlOzPodqvwhj9TOOOEkws+gWRbrf3/qWFeTf?=
 =?us-ascii?Q?lEmWsk6md6ZZbvtuig+2nLJmZbfo+p0RlGEP1Wu7eYtspzPEmvE1XJF9WXSk?=
 =?us-ascii?Q?1pRQamlg8lgP+wE/cjAfNEKvoPSkQpXLYEXcSd9d2ibLXLbxQA82iDan6LlV?=
 =?us-ascii?Q?KCX7lOKKppUeN3DV1LnWN6AZCDDMb5BZQcDcpOBfvBF6gQwG+0s2nbj0kyd+?=
 =?us-ascii?Q?LAfd9CN6dCOZTJzZGu7KU6ZJKMiiDKywd+9yD4r0lQusrIZTRIaFl2TZe0s7?=
 =?us-ascii?Q?wU+455eME+bt8vf/v1dfXwRq0r1tUPlUs2AqKdLcYVon0wtCTzA2iTmmZSgd?=
 =?us-ascii?Q?SUtn8Y0Zr4u2e4O6BQ+bKtaWqcgpbihPJAS5byG3PVFTh9tPvP0hOMWmP7l7?=
 =?us-ascii?Q?apxraLZFYzAUVk4vmrUjCZB4+07bOM7oD4PuM0C/ads81cZyqlxqv7bm2bOX?=
 =?us-ascii?Q?0sBszQq0JDhNryek+XxLQ0zr4+zGHhQdZbR7p3BoFySHvf7OHVae6i7mjLh8?=
 =?us-ascii?Q?Ivp9CextfrLKwM/zTi2W8QvmIJrnWDWe6NW/YA/YyRFD1IBh/LCdjBc1hVzo?=
 =?us-ascii?Q?z4uaS5id8MZeVxiZb22nh2ls3i2hvnLt8GufK+SN2D83ysOZuXbVU9lVV5v2?=
 =?us-ascii?Q?BCE0BIq7095BsYWR/gme5fjowxlr6UJRFBZfxml/ieNOvd5z/zz95dwmRN7e?=
 =?us-ascii?Q?OFvAM4Bo4cgtxipW6oXTKFlpQ3sIVn1JBNlXWKqpBF5DSTsjo1p05eOz0xJK?=
 =?us-ascii?Q?tAz2S28tDl0CQnDxbR2tOAaqCO9JxIL+qSUTa+sJ1clFP7DIjcX8XIJaPuY1?=
 =?us-ascii?Q?L2BQw85Lg0UjkUI1ShitDTBsxo/ovZTL/jeBHWV5wVBVbp13LbOCcWkz7NJ0?=
 =?us-ascii?Q?ljX/rISfLkUtNLKo58UiMg9mV51TpVhHA21BAFRD4g4sRtdm6Gx27jrhlimC?=
 =?us-ascii?Q?5VRMg5yFJaith+Wk9xKArCLdEZh6ZREK3bGi/fP0QvM69AY74q8/IHfkf/Uu?=
 =?us-ascii?Q?AVYf7FqkAH7M7nQF9TtZfiNw81mLvRCCGGYFYKFHZjwveY2/IwA3uUI9d9k7?=
 =?us-ascii?Q?AEv+xMPTXCnJsWnobpfx0PpCHHmDH8oubyERN4MqoYi1TJ93178yWWWUQn0W?=
 =?us-ascii?Q?ocIHM50sSk36zBKNvkoa5JvK/Lt6EFp226NZix7OimVa9IncW9tuBhtKzhqg?=
 =?us-ascii?Q?0Zg3FIBH8lH7sSzQZq62yheV201gGW7/7xhbR5KhxF8dR6Uz3s85y0RBbPgY?=
 =?us-ascii?Q?bjmP0fdgVExpnyWiD9Yc34T0ut3RVFZylHkTUIUU297yEIXAxhpRWE2TjSrT?=
 =?us-ascii?Q?rC9p0SRkIIKF3BweGv4BBnB+8jA9CJNQK/JduRzgct1BXg6L8mDOFnl9ADRN?=
 =?us-ascii?Q?Ou5O2zAZZkohlh3GjZ6LFrVzDqKu0qNkRdNZeC85sA2WVCMVtFSkVggzSx2P?=
 =?us-ascii?Q?NlKOsUTGH+Sv7Np+2Ml7nBCd2ShlJj3RyAJEGGHWjsSQxIh26N9M83dbeUjM?=
 =?us-ascii?Q?5Jp4lw5SmF/71/XE44NF5ZdMe4urQB18ZqNwh1pyGSJIpK0wemc+S9CNki8J?=
 =?us-ascii?Q?1qSfd5ZPhYevbCvXyx7ivWaDTMBhTRd58dVrg3ti?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618b7005-a91b-4403-acfa-08db2b75bcb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:08:07.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2MCLf+9cj/SzgDtA0Rnux3qMfV6oHZHuj8VvUYsFpAmi3tuI7uCk4MXY3pYu00gmy92b4bzktYMtJVq3qn24A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6287
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, March 11, 2023 1:53 AM
>=20
> On Thu, Mar 09, 2023 at 11:45:05PM -0800, Nicolin Chen wrote:
>=20
> > Yea, that's what I thought too. Yet, I am wondering a bit if
> > it'd be better to have an ops->hwpt_type in the drivers, v.s.
> > maintaining a potentially big chunk of the array here.
>=20
> It probably is, some ops->iommufd_data.XX is not a bad idea

Will try.=20

Regards,
Yi Liu
