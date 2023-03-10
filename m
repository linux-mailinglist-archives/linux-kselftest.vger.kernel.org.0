Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573576B3C8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 11:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCJKmh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 05:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCJKmc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 05:42:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF762339;
        Fri, 10 Mar 2023 02:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678444929; x=1709980929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WQTTg32u5nSHRx+4a418cAP/HlQ+pBF8diCkNPrU1Vw=;
  b=U5qbfPIRSibyXc8LfqboVX2Cb61jZAZ4iVE/06CE1xNPcYgeDek6S78E
   5P/LZ62231JDbr7ihTlhDKusn8/6CoMvu2I0Om663Mq3PhNdRjOCO4m9T
   RBINjYGFQk4TJvUSmczi9c7SQqs4pI3fL9mwUY5mrcJ8OpduWTZusPze4
   zXRtAL/9EqSit/Zmgb5MJnDNGogxFX7baofS8za8E/vBcwZAHLP4FET2j
   pfqkjKwRrAaMKEiSGQZ/lrWDBa8VWpBVg7E8JR93Tq6Y/7SM2PdYl7lFm
   OvuiYwt/BPyj0k92pNwUZgscEnOH1ODpQPhQ68hIj3D5BPke44vZEv0eY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338253990"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="338253990"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:42:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="821001825"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="821001825"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2023 02:42:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:42:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:42:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 02:42:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 02:42:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhJ1vG8jhvV96ClsSSLCNtAHXO69U/N6Kp97geKDtwhfFNl2AroflBVOSo6HXoOGME25KrnfZfWEZWqH65/wnopun+X1itwu0dbQ66tZe13IOhtYCqmzPusJnx8QRMGtFb5zDn7/kroPcFq/yM/lr34W6ePgfaLzl9+b5pTt12hUEiYuqVapiKUs2ubxsr1V2kZhx4t0jSHhr2UbXdteMl2b/3qAVBMncs30eI9e1qiyWTGbZV4HknRLmRhUyraqV3AFUmK9kpTajzYuuIizmrJ7DgJ0TOFUkFsDIDG9bz/fze4GOC4QDktCFCvEk4xeMA5n7xXSloG0Xc3KkOaeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjVU7b23/31LGbcAhMG99/jZ4Giexb3Ow6i6cBOF2aQ=;
 b=fuEB6SuVLYguiuw9nj3OccRgPxBPdA3KCC5EuOGF6uTAdqgMrIropo65bHxo0pv/ZVb91UE2cbd0tdbik4R4Lj1kC23XI2b3zO4uv+4N86qSyvM1zoehZU8KCYAfJcHBDs010ZN82ISrijo3XatwvSDD2QPIYdYHHACSgoxzc0kwwrqH5f8jN+V00MZKEGz71nkYd3OPnj72Kc6VlEpL0Nu+7jrDeiItIyUKQvaKKyFWsxNFYjj9V0i61aLKbSf2fYZJDJKM0X2NCQXIWx4ZJZhubzGFUyAi/RNF988oRmYJFBCljOcLFjHjj+K+b4moMXpHbxnlzOgZ21OTVQdbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 10:42:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 10:42:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 05/17] iommufd: Keep track of each device's reserved
 regions instead of groups
Thread-Topic: [PATCH v2 05/17] iommufd: Keep track of each device's reserved
 regions instead of groups
Thread-Index: AQHZUVX+iqvyMC/fIECDmZDmi8C4Pq7z1weg
Date:   Fri, 10 Mar 2023 10:42:01 +0000
Message-ID: <BN9PR11MB5276FA160E7533824D5683EE8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <5-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <5-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5228:EE_
x-ms-office365-filtering-correlation-id: 3d57e097-876c-42b9-c514-08db215414aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k1CG+D0EtD7BXvoJ4o09z6tE+jGqsQJwONjOzk4xxfu0o5HwjJiCjma9wFXstn1FSyQvhNzBthmCUaGT2uAhkH3ivVTsqMoZgUFee65QbKnATaRFMB9fmGcfEuwXX6D5E/ndX2p9zQCZXlMX7G0wr02dL7vPyrDEDW3E/98VeaPdlDrbGE2XTrG+TiSInLcFedtHs9BQfVeAOpuuQGD8tcEzFZJnxxP3Ay7Izx1Qsm399h8z9gnx/URka5aOKI2SsfhWcEF/+60v23IGNrnrRmW7tcA8Y0WnZeTviwuPy3wLXXcPElf5IPmxw9QxivS0vttNDXT4kZF6l6PA7p028vZnaTJYjXLWgpLGOYiZQz9yYqMmpEWRz78m4SzNam5bwmJmB2pbJjfOk5y3cpvRkY+corG/xW2sYkWsU2KDi0obgQAPAW0t/Pr+kePQcFwwxXjfCNyyPlysEZSgq7n2LkPuttJMzpTTqBST8jp1M3cvn6i228lx/xDOwJZkyMkca3o6AKHu4TGhlsEirVg2Bv6HSeG1l3vZJv2KcXND0Q+xpwRMNc2mZlhT4ng7eSSgxRmm5ReeqKVuvOYDhU5EhDXoIr2uC72mY3vSJAXB9a+NC5itC5vTkURMcpKAqfNgBDVrtGVtWkBOl2JwXpg7Ih4axnnHsMsh9zCULW/0KUAKxVb6nYP7L8gbAOr6Mv+FaP69xRzsj+R453E4Cw5uGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199018)(82960400001)(122000001)(2906002)(33656002)(5660300002)(55016003)(52536014)(66446008)(66556008)(66946007)(76116006)(66476007)(64756008)(41300700001)(8936002)(558084003)(8676002)(38070700005)(4326008)(316002)(38100700002)(54906003)(86362001)(110136005)(478600001)(7696005)(9686003)(186003)(6506007)(71200400001)(107886003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zFQOc3HevCEntTpySf9UVI7bVB1loN4UjeWAaRU0bqvPqTF+kBp6QmqvEUlF?=
 =?us-ascii?Q?/fz2cgTf6TBYTWaOTh7u9Ekdl/19yDKztgzd5MmIg99NVHXKKfTrfzUxnU+A?=
 =?us-ascii?Q?e4M427rsq81Opus5JD1uEkPhnaPNxV/pey9acCvrOodun+ab7uF7drJ//aWY?=
 =?us-ascii?Q?jAkrQhS/e/S4sOe28RqJS23KHthndhr0dSYWrZ+G5VJwrhaF/xAXn7lVgj1l?=
 =?us-ascii?Q?ybmEeA4yyFxFRf9RTPCATTvAXXt3u9eFAy09NCV/4IusVaR1uczkLe4nyJid?=
 =?us-ascii?Q?RTghdYUW+4LRFwNKBLVuss0bcsCGYuxQO/s9ne7lMVICCiZNy7pDHR5NQzc5?=
 =?us-ascii?Q?vAha+LUpaMyBTX+ujl3KOvEx2PWNnpVMJjaO8C1eK8fb24vWHc7K4PesxwCY?=
 =?us-ascii?Q?p1Vw626kQWtemQcwvwW1RgOK2t3FKxQ1fZiZQ0QZAXEKx8MHbs7ycAujenVt?=
 =?us-ascii?Q?S5iFgZJ8XNdK3CcWHIvUjEn4FzPdhXjwka5Ri42BsHGr2d+s9JxFQbOe9er3?=
 =?us-ascii?Q?ili8hXpt5971lZYNauQOtrSB+g5z+33kLygxnmjViKJFbfICZlExQYnXCMFA?=
 =?us-ascii?Q?g7bn3e5MU2Y1jml3dO7rHaesxBRb6zY/1jVobkDAuixf/FEuckz+Gmsbtq4E?=
 =?us-ascii?Q?rya+dEyyN8tL+49GCW4NhGKMAP0sFhBPxRaBePLgxlT8IITDpXui630sppNd?=
 =?us-ascii?Q?BTmjRFzd0eY5URqVt49n7VmShNNFFz5KR+3WIcZ4n66Lgcxe3IwrYmDkf0U4?=
 =?us-ascii?Q?EhVilZpscQ0OheqIdmd6wDVa14IIJbKUpyEOz7v69ljYkxCuHGRmXas3D4Xm?=
 =?us-ascii?Q?wcYOiHiPXAuGH5ze1vHVZnt6yQ1Bov3H1rbsRwTYipKGUx0q708AX0ZUkzRH?=
 =?us-ascii?Q?7zB5vnUdKWONRIp1Zk1Ax0H5moB/ikQ14JD2tdGCPsboQeV4iBpOSRffZ2gE?=
 =?us-ascii?Q?3QEJwF2qNo1DsRsZEqtLPj34cbg1aSD76wDSZNrg+G7ifwMv45k29l5XFjGQ?=
 =?us-ascii?Q?L/zAwszCJPSNKMjxi3bD2rvQjkEvsAAI1rQFpQcFmzXWbkaDeptfquu2SH8f?=
 =?us-ascii?Q?a7Br3Mod0YI7W7Lov8DwvK25jjbtFA46KTxbT6ztqspejey07DFe36rs8JQ9?=
 =?us-ascii?Q?Qai0HQ0tQmcRclB9SQOuTLa6C8ZeLcBpuxwbr/j9o8od7uc9QiklUM/BBg0r?=
 =?us-ascii?Q?8zcj2AZfl1U7wIw8EX0Z8me2o9oNTnpLVwihHuPJ6VSloqEhbCVC7dKBWtrD?=
 =?us-ascii?Q?VCjVbD4fi1uVm6ViKSFr5FL2RlijMas14m5WNOFNyyOQ80/duutHvwuvQ3xd?=
 =?us-ascii?Q?VjFYqPXuiUrznZWE/iqy4tiFh0A4dhXozmuQcY9IGEAkMrH9WPBj7QmEuznX?=
 =?us-ascii?Q?4hwM8uFvxslY8Smg19I+g4Y/pwyBXPrFV/Pp4EWIsCjpwAk27A6UzG8SyHTn?=
 =?us-ascii?Q?UvboRMZ4Tmv/W1tKFdy1ELnKKZa7dRfJGagTjO0t5k8yVnw2YClDq+Yl2laM?=
 =?us-ascii?Q?+24wDSCYvaOcsIw/1dgaeHrfApak2UUraWql2iZs3X/vDQU7FTqyqNRuKqI8?=
 =?us-ascii?Q?hI02b8peXqpwjFcOBPnG28BOYyiI38oMVpvtKHWc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d57e097-876c-42b9-c514-08db215414aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 10:42:01.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcTplKdUBFh1/500G2R86me9IteCMXxYpkVTeyq6McvaAal3IgQneaZwz230v6dJqtN0TQp8rHmR6mLrp7w/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
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
> Sent: Wednesday, March 8, 2023 8:36 AM
>=20
>=20
>  /* Narrow the valid_iova_itree to include reserved ranges from a group. =
*/

s/group/device/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
