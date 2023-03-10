Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D076B3C71
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 11:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCJKiJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 05:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCJKhj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 05:37:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A2C111FB8;
        Fri, 10 Mar 2023 02:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678444625; x=1709980625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZKVYvbRT857dMEBGF4LWoj4cHVCNufSE5xTIoHuAANU=;
  b=cYhFu0relf+BR/A0voCeFFuyltbeSFDM6Pj8Sk0y0AayWfbqpV1PA520
   7IWWAUjr/gLn/DAUP1vKiUuWZHFBzImApetH8l7YFxh3nAhcKD2yPFE+E
   /TW7an0lRmA9BsYF2q+0TCXuxSph1re0cfx7hQLaZxc5OprETWeRULLiP
   +PBaiUsDxg1QGYHc3Ijw/8UeUHQukq3cvb9f/QvQdb71NiL40i9RYnrLa
   FO+HK4OGNsbPf98gVgTZ4SpGPyX7+2CukUK7jOEpa4hHHDFKxpsQddBH4
   UUqIlSJiQuujjMbk6dlFjkjb0MrlRJU3eYmoTxko/0pAyMWX5ucbENkhC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338252649"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="338252649"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="655138700"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="655138700"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2023 02:36:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:36:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 02:36:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 02:36:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFiQdb5OWeV5axIHo7AYD+lQWSxxHSZ/f+8OL0kL1wSLE23XJMDhQSMoyAAnzi9tVumlGttP0hJbi6dvTOURPvqMmjdQYitZ2we/iRYtZ/MAv0TtnKk3SP+LdNYR85L14S9CvD3I7cxsf1hlmeaacN1OrMsHWPlEH3sD99LyWefwki4VH6TVG2HNvM7YvRuL4d1Ow6wkVMK3hAjd6MLZDuTAemIvUJ3ZmJPN9g9QHoxOai985aHOVv8JWvL/wZmXfNe6IDpbyroEnQz/hQ3FIKPcdvWQjBW1fbdWuQieGgglecIFKh/VjMDmPy/3pSDJEqMg9W7fEBi1pqiodOXfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCpXPRCaG8yO9b/qR7jq5qitiHiV1mEnb5lx4dtdd6k=;
 b=G1/wiazTiN3m7444/MGVMH4vpmhrrLoyHPDN0Xckr70s8TqSRIi9V+S6WfpPGfxtQarjVGKGSx3YbaYVrkI5REaJ5BhkK00eAtMSRZlE1z+MBuVV6mxXDgaZGACg0G85ragElKLvrCF4XMQkMSwwOIi4LRcxsj5OrbkrylI/YXI3wT3J5tBbZm7pFnd7ii7PS7OhBwxgdZmPHaLP2cjoQw8wW+2RRRkERIZLV28yKbQa5DPk7jG1wfKoyuw8R1pF2XW0N2/R66WiMkWKD3jsR94Ix68NySuRho2DSeZ53oDtuwbZSbYQXUnHFOgLdgtjPxcoSZEpjXRLMsDa2GxlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 10:36:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 10:36:44 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v2 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZUVX+TmEYNxOqpEOFe1xQ7QELrq7z1ORw
Date:   Fri, 10 Mar 2023 10:36:44 +0000
Message-ID: <BN9PR11MB527621AEB6AB1E3E9252547A8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <3-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <3-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7515:EE_
x-ms-office365-filtering-correlation-id: 2133152e-e262-487d-4d94-08db2153582a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPz3Rar6ett1mdCJkbwPrX9Uuaa33KBd7mrwVHB0blE5qohZNITq27XDZk1LhbUr29Jrnou58EQ3+m9Wrwf+E99SrmMqkxW990dpHjXfjKt2fSBaiWHyucQQ9nSAEHLlKYrgRDlGiiHfzS1r8ddmQyzlcVssDGe7PI97pOsTWrE//iY7cFELI4DUEDRixYRVfbvDyGtOHuBgSld5gYN4/ze1qy1zJMN8MlM17vglKLDwd10xf8luOjJONKRo3m/ina1aEcmI41YxO/YR9TqptNWafyxaPeLSIzSchgrA2JYWVEBgWIUPv2MURd/BbrsJ7uCiYgpm4CQ3gJtFKG4gqQz2PjZ6IgQFYEnBceauSc7OV4WEh6qqWmQTwC/QpOmWsV/8hkaTPDXR6Pek1iLVfyKMsnouWgswpK99OVxryw1jUYbsXzXLM39p732y+FU7z7CUKx9Ng8AhHZX22EaTzhCjBh7xG5XxiTRiOEzn9pHdeafAoTL0jGE99vvzPRHBjSrNZFgZ5Gn6j0uR9rZSQZ6EsjjX7nt3kdAlZfy209FwxqNwE0o4U5mowMtALFwPbj8ajNsAmmCKXg8nsjgCGRIW/JY7vOrhR4ns9Lq8YYnGC43klhhXoplPCfQ/JV6F2iw2M19ppkYsn+TP8WIWncpIR2euYQkOsOPluH6kZTIVTdgABfw4G9+YD8JDuDyllZgfh46Luiu9+n5z6W3xJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(82960400001)(107886003)(33656002)(478600001)(110136005)(54906003)(122000001)(38070700005)(55016003)(316002)(38100700002)(71200400001)(6506007)(9686003)(7696005)(186003)(26005)(2906002)(5660300002)(4744005)(8676002)(66446008)(66476007)(66556008)(66946007)(64756008)(41300700001)(52536014)(8936002)(76116006)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmdSpjiwhPRFL83rXWZu1QWx4KaguJ5tYsKwPXrJ8bCFDNfmzqHtDFLz56Zv?=
 =?us-ascii?Q?BaocdOOdBy2OBXnLMfbrvM/3xV6HOwLi4dvAfCgXTvZ+CXzXkDKwdN33fZBl?=
 =?us-ascii?Q?pxY3Z8c0IEnzvj6+JcJzOtaYHE1GOfUzzgZZw4zwDhB6SX3+hcndOj/Lr/rs?=
 =?us-ascii?Q?oidOwYo4lb/rlRk1q2HMlU1sLgqfYL2r3ThSRcAw2HdUlqJCqcwtDv+66uwv?=
 =?us-ascii?Q?XKA0wx678ytWQBLb6ifASej2F6Npnm3YSgT324xi60KSXb/ugVrIR+aCKurt?=
 =?us-ascii?Q?X5dt4yNfhgKTtEenWogEGVWPqT1S0RTZXdYl4SmfdXZTWjXpHDI8gpaXRnQK?=
 =?us-ascii?Q?9kvfKgO5vqOfpirndd0AdCvQ1A6RmHV+3VTR5jhlAoIJvQ8F6F5kQ5Lf34on?=
 =?us-ascii?Q?wvxINHHPVSuljo7P+9tBHpx5ozDAHuqgWmrSUDGuhTwgL5gbUmFFxzyywIxN?=
 =?us-ascii?Q?GMo7wXBKaNCX3lgcHAbCmhhqT37Zz4IQOu3cO7NxTwRPGITOongCQkwVBnlC?=
 =?us-ascii?Q?1k0Mr73B7Z1j2QyOGsJhf5JpN4lg+BifoanZ/ry+na68qbDbOK4BTtSo9pgn?=
 =?us-ascii?Q?9IYjIjah9KgIQx/h9RLovkdE3xzJNcfosGeSGaptKdmEEtYQsaLop3mFbQsF?=
 =?us-ascii?Q?ofD1QRkC01/m/j7j8f+BacKTUqqRBOHr/b9QzTmrsUaJimYkP+050MenSlfS?=
 =?us-ascii?Q?W6kl4ykImO+Yov3Iybpc28WrnaF8WrwESPo+rNb3/74FZ5grkYxrTVJE9H3V?=
 =?us-ascii?Q?GyicOXuSGxDyYw9+pmtbNJJuMOd9M302TItyTi/GjbNERV5c5+VtobJo+YMh?=
 =?us-ascii?Q?opcK20CeN1UdZAI6b1nfAEzMcVPVh1Ax5bjM0SPKxGKF9TFsi3LJf8GjukNN?=
 =?us-ascii?Q?MQLfBFBTzB9q5aiteuLYcs4SsyYvYkROF7JhiKigCuwEK7kX4qIvKlCBkBHT?=
 =?us-ascii?Q?OmyLIinxNitKh1AOHH6lor2i93BLyzoQ+Vlof+5CA23Q9lxTiTQMiR7ZaxCr?=
 =?us-ascii?Q?PkGlvEVRyDEm/sE/1nIWMrZCAu4rTv0jNLKM20N6mhviQpxbAhAWjrBYJBbj?=
 =?us-ascii?Q?kZIH9h1qzJqMC6+4t++8pRCRXcQU/h63dpWbqW9ZTj+LRdQSMRfSebx4i9XE?=
 =?us-ascii?Q?k55+7KW3pdjx3Tmb/OXl2NU3mTSF2vcx7BwuYIVZV6QFCMuAHA6Q0307d1s5?=
 =?us-ascii?Q?ttrdUXxZAC0vCCeVQwfLZmx3oSGC083LzuWKxwYIUH5YJWFfL6RrskPcJ6Zd?=
 =?us-ascii?Q?I1zeeH7jDSudjptWwSWFFhGfmmK5yYt471iyBhI3Jh/jdiVbBz3Z9YdKTwUi?=
 =?us-ascii?Q?YxInD5GwXkLvz4U+qxV4niCukc1L73L+b5j4KotLbNLHhheQ+TsqjfepmgFx?=
 =?us-ascii?Q?lZ0lKnkiOWm1OXbLPbLUoDEw9hB6eh9nhL+eUzN+qvSXG0dWtqz6g76hFrLf?=
 =?us-ascii?Q?CeEEhs8cIAmwJadkRipzVwUjJiZ+9jC4JKya9TfEBpLeuU/F2q77YE9c98oe?=
 =?us-ascii?Q?9LXIcJ02/LSQSAFG+mYkDaimSjRVXHQBXOYgRANALTclL5U5/b8kXFxdcl0V?=
 =?us-ascii?Q?jiusBJ1CBnR7FX/RbjJzD0mF2s/KK8Iz/W7Zy9gO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2133152e-e262-487d-4d94-08db2153582a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 10:36:44.7913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9oWPidtv4YwFRI/Zs2KZgEqbETyPCYwd6yw7AuHU7/uDE+ffayi6qqu81MjAzjhSFPOoHktomXkyZ+Xzx7K6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515
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
>  	/*
> -	 * FIXME: Hack around missing a device-centric iommu api, only
> attach to
> -	 * the group once for the first device that is in the group.
> +	 * Only attach to the group once for the first device that is in the
> +	 * group. All the other devices will follow this attachment.
> +	 * The user can attach every device individually as well.
>  	 */

the last sentence is confusing. 'as well' sounds like there is another
option but we don't have a group version of hwpt attach.

otherwise looks good to me.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
