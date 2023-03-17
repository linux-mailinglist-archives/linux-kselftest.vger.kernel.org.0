Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C76BE6A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 11:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCQKZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCQKZw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 06:25:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529AEE4C4A;
        Fri, 17 Mar 2023 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679048750; x=1710584750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x+vYdx2/n7bvjj5P9nRRVFdtUcTVFbS47NfBTRf8CH4=;
  b=B0OKv3An2lngeih05TdRDfuvkLMvpooeu2vJ8EbIxUCoXH6S5zCdZ/9H
   aR/3famYESvzegVD6fG2sr8FlUWZ/kYZfDXyF0g8aK68BFZu4pSCDsQ2L
   CkEFBS1v7pc7B9nsuiqcCpT8jvB5I3SttXc7osPPUtWt2uCTpRS/M9Et4
   slqBbywKYNQrIqfFYZOYS0VfZl0yvD5aTPUarjJze+MYbK3T5PcIUyYST
   PHXgpmA6Iv2fwBQ+hKwdnEd8TdmZNnSTON2Xl0Qm1FacqZtzbxoeFhmQ5
   Y3V6RsynLw13pYrj++EHSUJPy+yt6Y7RBvYgBpNPJldKqQpo2EaDvmtTS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="336930251"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="336930251"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="854402533"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="854402533"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2023 03:25:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 03:25:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 03:25:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 03:25:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 03:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7aEZ0pc3I316N/jqqUuUiBjaJ2Ql0VgqdT7fwtwcXwDo3GdARdfMWp0MGWLAWxV/cSg9LEyjJeanq+iYD2+fHwXk7QCt53/TG3koM4TEVRFqiqThGfDMmNt0gKcR77T5+vwfChA+sxbBgwHbLNHQrrrPvBTbBgkhmfPnqEXAU/DdUKQHVjclNREXphCKlg48RDmT7gtNtBOdSpKZZSTogrSERGJtVrAoS0orbOgx4jOKpoK2ycQF0SjCslZyYL5kqFZDkYro8wI2gdQ1DRQ8CPcbgdrPwHDLs7sDI7DGGR3+TUgbza6n5lvxLEhln5buwbuOJMRsDPHrOtBMNThEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+vYdx2/n7bvjj5P9nRRVFdtUcTVFbS47NfBTRf8CH4=;
 b=ejI9xLzs2clkxh0Jf90FHk0PoHSRJwNSNZlJeLvV+Os3E30annn6PImXcO8VEfHi9jPUk+WuGBplepsfVNsVWMqL8duKpl6RRTZinLeNKcTvqS3GLCSTYhrZdmb/GVTfmO11rihal3hK/KTbM5riKqx7L+FzFa+obw0mVWTzUWUkR7+a3hu8fCsnL50AoDr8xQSga+b2NgCuXJecaiRy0ktExg8XWoRBs/pyphPViC5gGt0mjNl0qZOZmB0qcLyHwtto5VIdDz5zy5mtMBiT1P2JXcAZzvbgOpH86Dtl9scCILAc7d8R3k96K001grDZ3rzMXEqPyU4pE1PhWH9lvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 10:25:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:25:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH 02/12] iommu: Add nested domain support
Thread-Topic: [PATCH 02/12] iommu: Add nested domain support
Thread-Index: AQHZUl56OnBZKouzpkSAeG2m6axxIK7+0JUg
Date:   Fri, 17 Mar 2023 10:25:46 +0000
Message-ID: <BN9PR11MB5276265987486AC84D2039818CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-3-yi.l.liu@intel.com>
In-Reply-To: <20230309080910.607396-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB8150:EE_
x-ms-office365-filtering-correlation-id: e36ff35e-57d6-488e-98a1-08db26d1f874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +k95twkdHP6tKLFdqnZuloDOiot17o660MiXZn6AdBdwlLCcxRbXb+e8EMGCvgCIspwf9Jd3Vq0DM0o2ruw6wucKZS+7wKJgGwCI8Wju3Jj4UWUqkOXHSLb0Rg8/KSo0eSrnbKBdgVCPBPLL1BfR5bxI6tXECwsxgg2lOt/2KA4Wm+j0RgbwTS/jdCuu8Rpgmy9FP4eVQUkZEolH8QFXfUq/Nw0h0XE3+lvnuhVTuIcE2Iu9CvBWDBfrDlDd5jnVluBajOm4S63svuBiS9CBAGuM6GFgXId6UG5mD+4KuV0SgryvAsGMQ/Is3JLeJeaEpvhakR+nC059yPeBxBcFStEsybHNFMYaW34qqbxQ54M3uGN7bQBE6obpusXw7wa9fqhoAb7eZlEehEpG+/gcmaQvHQY8jnZhJ7e/ueJngg2i4vq20T4Nv+VjdSXjxwm1/90jcVol1rCne23rWY66vTOb5yaqb87tQuTIjvm+O7U5pATHwj9+UTtFyEEetisAL1vCHS/Ua8aok5a3ltRTVlTPPECpKo/W9oF+kuJTdaNteLrmlSu0ljHRoQpP0+mE714690BBdi1+Ck0+Tg1wreDoN4F+hH1Tq8eHsAIPd6N9JR7VxIY7SOBLyB2lG1zt58FI2okddxhhkXm7ESFjZKlzLyMYPDKelE3LTBP89Y9Y/O1ZRHLdFHoppTnqpXIK5hP+9VPTgg6+c9Aqd7YTbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199018)(122000001)(82960400001)(186003)(5660300002)(7416002)(558084003)(52536014)(38070700005)(8936002)(66476007)(41300700001)(38100700002)(66946007)(4326008)(76116006)(2906002)(316002)(64756008)(9686003)(54906003)(478600001)(55016003)(110136005)(66446008)(7696005)(86362001)(66556008)(33656002)(8676002)(26005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eOYlxQVKi2Hgr43dbz43apJrZNCwzj7jWNimxfpn8lNKH/tmChKY6emOxZpr?=
 =?us-ascii?Q?FYzorI3S7s2sqtxabyeYqEzcH+N9/TvsDGhgoP/GVS3NgRRk6kj/MlavpN8V?=
 =?us-ascii?Q?b7eRmKrgmIxZUJhW/Uq5ZUKb+E74yMplpEwhAMojhxbn5k3GrQ+95XCiqsJz?=
 =?us-ascii?Q?OaxCUV4b8BlO15rbydASOQq+xH47/iLYNgI2Iec2nPFSSrFikDp6pTxJ8U/C?=
 =?us-ascii?Q?SnYyq27qrI2LONysLoEFqCvJoFuD/uJD+a8NBdyU/CuCztBVJ3oSu0l6pT+o?=
 =?us-ascii?Q?fc92XV3jZjP35btnpTSES+1c3JawZ8Lj2O9cGmyW5KBxMErcdZ2Gn4jIyNBL?=
 =?us-ascii?Q?K6x+nQvY3ffg+FFALfbP4JFBmt3phT1zdxofO6CuQa28wcBjUS3C9Xyid9Dt?=
 =?us-ascii?Q?l+KmIlqNT8OHcHg/NtoFxswtd7skwlPST6Ra1raacWxix/kk8zGUwR1IIitT?=
 =?us-ascii?Q?/yQ43dmCEJuUequSHUtfcgWWcCKM3cO33BqIhh7zASRLtVfMGr8y077i7PhW?=
 =?us-ascii?Q?HHAC1JstSET5n4n+yFhaoJHZqff7+T4mVtwU1YDU/BsLsQ2NTcCsAzj3CiNw?=
 =?us-ascii?Q?BKUdDPGzKgpjvjHhTIfJkEu1TEklDbFmcMXigu/rEgj0PGb45tGGc6UV9Rl0?=
 =?us-ascii?Q?leUUfTYX+SWJROrQ2S17riOgerIcy7za2te5hUBsiYqu/lgTsvFEBFL/4JHo?=
 =?us-ascii?Q?FyscOtTk2FVyHW/Ry+GajgNZJyCjTeLQ3KUpZP1ZACI0RFEh9a557Kw+Knqm?=
 =?us-ascii?Q?2wBvOVbsvHcJnsevcmRD7yTSSl0Aj1RsBWAXBizyp7ThkQf4JrYvvAA2iEjV?=
 =?us-ascii?Q?+xU82E9xpDaKreU5M7RFetyaxNgyKLduOJ0mo1fL13MvOtwZ6fQlYSxlXJku?=
 =?us-ascii?Q?myZ6WmMmKaRCazb4Dd8oS9Itc7qHalwhMafN1dETDkt9UJSBPX3/rm/0eB+b?=
 =?us-ascii?Q?em9iefRuWgA/2/hkugc6iJAP0Cg47pmSRkhNrxjVNV5atNCMjpwdVizj3v1X?=
 =?us-ascii?Q?sgjVz9Lsr+ETiHVajl1uocuZQJTnz/CSsdSU7I+06nxHNTCP89wk2syV59PF?=
 =?us-ascii?Q?IA03OCw/KjvRZs8oCG+OwRryzHYULXDr4Bhphd1Gx8ANU2a5ZVoqPfJl+ZxO?=
 =?us-ascii?Q?gWdsg0GxPupTZz4oLkpMwL8McB7xSUuf7w1ZcYIsLU/0BzD+b9vLZo1YUg5W?=
 =?us-ascii?Q?EZwu1eZ+8R2I/WV9vyMLfe3So0GAXOv5pt9S848+0fSkIhwWbLop+BF+TCFz?=
 =?us-ascii?Q?OAIhnxI67EJrONF+sabXEvB5/lvpsEgodX0FPWKkHvYfz2CRRJf8MsksiQbM?=
 =?us-ascii?Q?eYdXo5qdZMl3MljJuexYijly8WzfPOv5lY06OMZVevpKmHn4/M/DyfQZMcIe?=
 =?us-ascii?Q?oM1NUAKNBxDmV1fzuiKMXGw0PTcyoe0dQStSHy7BT03acN2RxAzcdlkTmFnK?=
 =?us-ascii?Q?FVJm4vQtqBMmrkO5RLAfd0PZU4Pqm0UWw0dXfSrVphMLQG8Vp1u55amhEtHf?=
 =?us-ascii?Q?unqzrK9hJp7W0KPrmNvwMhLdZufTW53ZP7U/4RtQXvfchQ5o5hiethv2b3+q?=
 =?us-ascii?Q?uJMhVaEnBdTrkpMPHylnE5g5yQJXXAk5F8GcJmh6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36ff35e-57d6-488e-98a1-08db26d1f874
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:25:46.0999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPjoCNKkGnUplNx9x076Gkz0FtQhz+qwgBY9ZFXfjNWqX6WvTFfJ2R85CSsg/VhDWE08SbwS97RBOvoPAtPJsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, March 9, 2023 4:09 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Introduce a new domain type for a user space I/O address, which is nested

'a ... address'? let's call it 'user I/O page table'.

