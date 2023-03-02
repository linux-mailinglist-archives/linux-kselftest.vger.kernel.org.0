Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4BF6A78D4
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjCBBWr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBBWq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:22:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC62460B3
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 17:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677720165; x=1709256165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0E0rrvJPLlxsNdG5W/qh22uUfr9BUXHCR9gH5D0UV3Q=;
  b=L8fRCtWT2nIN7czNfqqxFs0z4yUXtM1mMeaktTljuFAljqBCtiduAx4k
   +PAngJpmVsyproHPgpXq1P9+KWkNxhbWdV/39DEJ0c4SSNkK8GXVxjhX+
   chNLvLgxTbEZm5TUZvTTcq83CZgwIkaa5cPusMQRj5yK0khsKKGYxwRay
   zpBNchV+twhpYV6a6MG+GsBtHgYqCY/tVI282umgFRN+Lw/se4DLE/Jn8
   A66T0NEKGzybx4AZSpyE5dd+H3/gEyEZiN7fXaIV0diP827mj+blPS7Zm
   kz1li6avmRzcwGisIm4flWrLDa8va3P5WDyZV81b9iz8y7Wy8KhyXPM4r
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="334611162"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="334611162"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:22:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674772039"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="674772039"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2023 17:22:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:22:44 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:22:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 17:22:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 17:21:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX8t3FczDcil/BRFiATqXm+vX1tZqz3cPds2030SZbVQ9eJ8nBoxrEbfYcYW82BzZxm5DWVNqUDhxUXwkjYPcQBt7igPmSzqGBD9eOHq5qtJo3jUMjR06jw629yic6zyWoxt9bej44UYeY08o0Gq2iPLuo+kuwJxG99IkaCqRJSu0TPPiEFmgMU5ocqb8IWf8VBfp+CyGh7ivVYgTlbndwS2MzUb+cJ6HeynkWxGuF4fRgVULqOIfVW7RBfIHWvlwHrHYLP0IlvDJvkJmNk3a/zAQsr8R/WT8gjt7cmkjKt0mhmxwIccHm3PpwGq6hpHaUAU7Vx1nS2MdxxED48hwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E0rrvJPLlxsNdG5W/qh22uUfr9BUXHCR9gH5D0UV3Q=;
 b=QVSB7fb6B6h9atdmmksTEPFwciwxXdJzCTHhrvm8VAVvbhhSUCAVVE+VobQ1pJ4nc+LQcyUrB9EnVbl7/L2AcctkCYFJEndrmd/aqMfxK0FPFxdeinMo8mdR22HunD+MreMOvFGlL/SZEMlz/IK54gep2e/WlTqXpbQmvUaaSbdDlpIueSW5ZpCN8UYYEXBEJm8LDa4UxoxfTuYbXCtIEVWcuEZ/xOLsPk0BhYp6fJzfqRSrol48L+ajuuOnPGJogMf4HD+G/+06D/4mP7p915sEgp8Q02YRB4T90gaVcwsjAFJLSBw0KU1n9J7Mst2LseSRSPryQWmeq3+eo0GTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7685.namprd11.prod.outlook.com (2603:10b6:930:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 01:21:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 01:21:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 07/12] iommufd/selftest: Rename the sefltest
 'device_id' to 'stdev_id'
Thread-Topic: [PATCH v3 07/12] iommufd/selftest: Rename the sefltest
 'device_id' to 'stdev_id'
Thread-Index: AQHZTHRikBVRvS7BTESca8o2EEPf5a7msbvg
Date:   Thu, 2 Mar 2023 01:21:50 +0000
Message-ID: <BN9PR11MB5276A776A56DEF2E6DEA5B828CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
 <7-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <7-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7685:EE_
x-ms-office365-filtering-correlation-id: 752939ef-4cd8-40ad-b36a-08db1abc7fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VOVT2646/U4nUpQ0kit5E+H8ScudJvIjuRGCpa1eJ8yytVpDav/PJnG/VIm9OkvNXUPaWVkbMw52RxBVVcknWy3HUqiL1SEk3WxUTCmStZvDizFLT9MmXkjXgxMr+3fC2v9YKRF/t7NZOn/hzYu92JbenRSqn8WSxEpeVx6y0LflcvMYuHBLzDfR3Rv8sCHCQHGGI3jr3y4w4WOshqrKLHoYmO6Ug9t6/fmR7HRzAimPn4j+CPxWopApdhINBHz7lRoQ/6fD6BGP6/QnYhyx0zFouogrDLMWMeb9arK69biY4QVfAJQji6YVVIwzIVLdg8qAqzWjQ6Zk6EJ4NoZwGKRPSvYmOd0w7kaLNN7tM5bBcXJ2W1hd+dIKjWhfr9oS5h/o26cUoZOqG3BRqaLhRa88Hy7OdlGINMxH82iLkYGprq79tWhM3TFAm4d87KXAm9pJSvbGD5YrNYeqQ4opCR7/f2Q0UJqZ58nCIxImbL496WK9tA68UgouKYCwDHVGB6sc6s8xtpYJS3b+3Qf5yv/2knVZ+EyjPERlCoCsvEMf3U6Vn4CQxTAsNC6C0ca2tUCA32U1r+MR1EWcuI2ier7UBwRQgAW2IhmjLLqn9y7fUd0PPwaURb2z6s6KIzJB7BfiKmXBvleBGKzvsk5MlFcyiZzLm4t6vgyJxS0sCLm1Y09RAntyEga2OM52RCR7UutUNbcbTKfrX9wZkO+k3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199018)(107886003)(6506007)(9686003)(186003)(26005)(110136005)(54906003)(316002)(41300700001)(4326008)(66446008)(66476007)(66556008)(76116006)(64756008)(8676002)(4744005)(7696005)(2906002)(8936002)(5660300002)(71200400001)(82960400001)(478600001)(38100700002)(33656002)(122000001)(52536014)(86362001)(38070700005)(55016003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yiKGkGMTeaBYRoTGvTuY2sZwRr4RInBsktF8l7I6JazV/jff5r28hBS91oG5?=
 =?us-ascii?Q?0a5T98JEXNT53ygO4PLv4HZZW9NCpaBQzraO4ZN8Cey/erTl13HNi3lnEcL9?=
 =?us-ascii?Q?bXug9KCwZnWttMRkA/S+PLS5zSEdEnElJPWt+YrigcuOG9/VjrkeF9DE+8NO?=
 =?us-ascii?Q?ycyR/vNrIQxmLF89mwcOQwjd+/c3eGnDfKiWceyVorYEpOTF4ecvjvtcFKhU?=
 =?us-ascii?Q?PnE7quwU/paxAcVOrFg89/rsxHw3of68MX+s7rElgYX4KgcYMMq1nQdcGglw?=
 =?us-ascii?Q?TLtDUXG3vBv3D93yI8Q35euvoa2LW8qwguhRXZzMEBx24LGngwjOftb0x6Sd?=
 =?us-ascii?Q?sti4M2dDrAKVc2vM3A8QGlTVG+mqimjcBvUr6QXBSX4stIPuc/40wqx7P+IL?=
 =?us-ascii?Q?Wl0Au2a/V7gmFY2tGmLH/V2xX/90lEntD3gB1KUH7txKiIhhkCF8Ee2dALvt?=
 =?us-ascii?Q?uAOsGjt1qgManowbJFz0U27aPAlCXA8mlucAVal2I/Xb22zT7sKSXXMQAbYW?=
 =?us-ascii?Q?CydDOrot3eo6Bzm66H763J2V2TPfjMEUEBcoa0ISAQ49jsoq3Z9ks3m0UJDJ?=
 =?us-ascii?Q?7i80IHstiG03ykFR28cLf9Tt+F496YzFFsIYoZuc85hcPWVouKsnWM+FDZCL?=
 =?us-ascii?Q?eqZXSHDJeR/NUMZSJgeuc8N9EhdsY1bUhMovNv5rKo3U2tn/4Id1Q1RCCv3s?=
 =?us-ascii?Q?Rlv1r68EV0tOi0LHPHiHMwn7mW6NKQSJ4ExG5rRO2dtQQKFCdc8G7k7nVYXk?=
 =?us-ascii?Q?JJ+31aCphxjMTgWMql2BWmZj/WM+jbMnoRACBOHXtAgyU4RHSWS0i99uBkBv?=
 =?us-ascii?Q?wIiDIyLUmDGYLwUrciDj7oIboOwS50MVQO+M+8U9LBgrFunXKf3kMuNiISLU?=
 =?us-ascii?Q?pljSmw62lk/ft0cuiRELLB+dqbThEhXn1MBjsC2NKPFc8ot/yQumgTy2bNWn?=
 =?us-ascii?Q?sPzoEzf4rLoSTjsqs/tEP8SPcpQvoNYqhiuGrw2BT7YV1sxlOxDGQeiB7uM2?=
 =?us-ascii?Q?v9afZSIFiYnjJOD3/Y8dONrTuCU+HWD/mb6iIeNzRw/x67SJsn3F4r4kAmUQ?=
 =?us-ascii?Q?qJOJdTL3EPZjVWEl7xKJQIHRWa3DfEAKBRsWVNX2yO3BMTinZ0cj7mPWQtyB?=
 =?us-ascii?Q?/zBuz/brOzTR3w2TGKl8QUklmY17/8UMfJ9YqOZ4WxTVcIgTdmsZhT/yy8OP?=
 =?us-ascii?Q?6H1RBxcuRS8q7f+vTMbHpd0qn1lDoAjKf+LO/6oAmU5n4jiG/NKgfPxD3pUK?=
 =?us-ascii?Q?UVydz6mcf0JEWy84XamapjirFv0MYCbv3utzYUSUbHoHhkQVRsCo/VrTh3b4?=
 =?us-ascii?Q?uRNY0Ohvr0greirdb1rCQECwG7yUS4+s4YZBijxYphdHJLgFtnSZCADEh2A1?=
 =?us-ascii?Q?YNBA/iEgUtEbY9rHMmsbhU9kItw3WWqQ+r9Kowd5lo7Vd1j11H6ii4sQSFIm?=
 =?us-ascii?Q?7IDRYhrod8+8QRqJiC57WXqLxxSCp3uYMN1fJvoFpiPkk0IuLg+2mCEeHvis?=
 =?us-ascii?Q?da7TOGjr70jAQl7fNao9JZ+FxJdkRB1uxYRLNAr2SHCJcMfWRIEMLjQED5g0?=
 =?us-ascii?Q?M/KB5+oPC6+iaauY2zJt2gFVkRo/1vRHiQFcPGk2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752939ef-4cd8-40ad-b36a-08db1abc7fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 01:21:50.2057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlB+Cuno9YZJK002KNWgBzPS6V3ZilQ+SpeF1cXfpavqO7SYFRguBRFwNpWhHCfeCLsQF7uzSOItVjAI1pXaKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7685
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
> It is too confusing now that we have the 'dev_id' as part of the main
> interface. Make it clear this is the special selftest device object. This
> object is analogous to the VFIO device FD.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
