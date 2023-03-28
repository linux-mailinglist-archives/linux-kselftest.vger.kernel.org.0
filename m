Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED68A6CB5D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 07:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjC1FSr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 01:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1FSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 01:18:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB1319A7;
        Mon, 27 Mar 2023 22:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679980723; x=1711516723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eDe5+H+SCTyZWiHBuKVvT9DPDISJHePOcUyWY38ugHM=;
  b=cVnahVzfN0nkoiFvZlr3nOGaT6YDtPUdHO0pnAPGFZiY3Spbzhw5Q81J
   8OFFCFkB6eYIokpUkh0DeKA/DbJJUcsBB6T4e98nuT7rAZyu3u0nIggW7
   OEk98j2/wTAcexg/ZclWBZXd/oEsDVPraTED4WcIALERKifo6IrGUITO0
   tIR5/xbi2ddjEikp1GWccNe4oVJ+6Etlrj3yk2sPBxoTf7gw8ayimZN01
   SEW22ED1YhyZHjzGpK74YkoyLmB06OymGcGwS7KGXZEUBHScYeWRyStxx
   WKrIA6vu+FfA3qEyloIKFAtU8wzLUTcCci6BZBfQwO/gCiSy8xEpjLZ96
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337977446"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="337977446"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929723499"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="929723499"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2023 22:18:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 22:18:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 22:18:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 22:18:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 22:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7s98P7Uo/eJzD79/f4X3VBDCq7xUdQMi8u0APCR5VvylMSE+hAwgcl9huygNrRAcND6xbu8vqJ2I5qoueTLdAis8Jhul0opYkguBlDxFti12+XyzvtiqZbneuvU68r97ihA3lOExwGGln1nhEYfpYpFx4zHFXGeltR1FVZd2rySCyDayBdGPemEf320msM4E+SYsrmlqmddExqUKVafQYeKx0Hq2ql8gJep3aMIs2kfejqFBEKtcIwFhe/5V0rWlszM0elSw4upDgUZwXtfEJmgfjI8aityXtErI/sJ7EfybLb6r4b7RbEjX5dixPlSTviCb9bd5P0zNbVKeUoc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDe5+H+SCTyZWiHBuKVvT9DPDISJHePOcUyWY38ugHM=;
 b=SNsE353D9o6S+jpD9f0jphhesj4K8VCnU9A5OF4swsDI/aHPHRUX0fUarPnXddoxKwOvG1PnK+9yRZhHG9M2cVKybVqL0/Y0rNo4DttqCpokXWNe+WBh4HapVos++TEJsoKuv+Z/RHt5LA/qiXOpaHAqHibdIlr9CsLsi/LE5us8cC32Ro9+XFob64c9PRbKxZlH9rJbu7IWvG/CxKn5bA91E/wS+HvZayncOd/4cpbeadpERe5nAsCdpX82oUd72PclaCTBy4yzVugJ3ffuVXkQJhQpGwJ9dEOoSRHh3pXoQg91ke3VOCxMoxO7DeAcFwBU86OEiu9RPKlR6Zf+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6494.namprd11.prod.outlook.com (2603:10b6:8:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 05:18:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6222.032; Tue, 28 Mar 2023
 05:18:37 +0000
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
Subject: RE: [PATCH v6 2/4] iommufd: Add iommufd_access_replace() API
Thread-Topic: [PATCH v6 2/4] iommufd: Add iommufd_access_replace() API
Thread-Index: AQHZYNa+SJ7CUB3zB0SwI1ZgGbGD168Pp8Bg
Date:   Tue, 28 Mar 2023 05:18:37 +0000
Message-ID: <BN9PR11MB52761D46D49BF1D877878EA78C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1679939952.git.nicolinc@nvidia.com>
 <955f7464fafc72984f3ec441671f37948f01d714.1679939952.git.nicolinc@nvidia.com>
In-Reply-To: <955f7464fafc72984f3ec441671f37948f01d714.1679939952.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6494:EE_
x-ms-office365-filtering-correlation-id: 311237ca-4b07-4df0-1bd1-08db2f4be2cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYw2LeEQNh6XAGBTKYS0bCKM3mpMonGnKHeuepAXk045YWqW5rwkMrTzUstE4BfCNhHeefixH3q5yt4iWmlno4yeQDLignTQL9Nomw2xIBpFP7MyR9Xjb7l8gBGQhHJJbTdRZej4jJcYR0WG0phImIlxXhQcB44kowisG36mTSjcedMHtazl4fMIlZoTu1Ff4tSh2YSJgQ1okLQE3AeUWVtvIVZaFUJKo1OOv+cxQvHwtbyJyL5QS4ii5g9LaeoWULIpDib5e0dq1XFIf8JJNGmEwz2W58TvHlcgyXD/HnkwZuPlsNRy31bQcj3FXXsjnJZMrUQq11C71Zre4zTRp3UtuYU42IYKT1QWs8eDgOReSUqSB5vdnx3VMt9vQtgCgYib7+4zlz18DoH7Nbw4wVVc2iUbN/qGdYgSQ9yCqlfkT9AC/noNYQLsOfXCeioRbsFqgF6Top2rpiUXZVPx/LQhi/kTk6au0/7uZtJo/HbJNNVpV3+ohmQSaE3ufL8WGuD99O5q+APVCZwOrUvBolmQQzbd/r4WEf1Sgzowu0m3K+fijdg1Q+HqkI4x22eEV1yzSBeMl52sV8ktNM+XMiQgi/fakgYwxeJkA2M6+vgEGbnLh0jfmL7VhVKg4vvx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(83380400001)(8676002)(66946007)(66556008)(64756008)(2906002)(4326008)(66476007)(76116006)(54906003)(478600001)(71200400001)(7696005)(38070700005)(9686003)(316002)(186003)(26005)(110136005)(7416002)(4744005)(55016003)(6506007)(66446008)(86362001)(52536014)(41300700001)(8936002)(122000001)(82960400001)(38100700002)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3DvXUz5Fw0iMVzgNMQRjpIHrFZzqkNbZuUK20ewQ2e4DEF0j26g6gfegpaoQ?=
 =?us-ascii?Q?OZTdvxkaSIA5UyH01GPW/4G1/A+wOz506uWw8yIUzWERFfWHP6nMFTnbZiJH?=
 =?us-ascii?Q?wOtC1vl0g0mHsSnXLZ5rr5wY9bq0gnBosRYm83rU10noWSIgy5fOeib+CI0H?=
 =?us-ascii?Q?OFX4FgQZealNfHBXG+ywA415OlydF5sPiL9EaQxVASbWFfphMrsfLXi+Vi66?=
 =?us-ascii?Q?RvIfinL+hMLSWa8/lela+7AZr8+j1QF6U2Thh6qn0MZu/P946kksqYJv0Two?=
 =?us-ascii?Q?K8DR2QwS2qhZpmxJWm4rAK7H2P7YfzSNl6EJ2H9EwRhyXWOytWAzfAfTG6NO?=
 =?us-ascii?Q?28ZyBHlqLuVYjtUNyooyq8dXcl6Te4MBHNuYctYChM3MK+XYylgV2Ot8CpSR?=
 =?us-ascii?Q?g4sS5cS+J3S4lq9MV6e9oV0tG5MdPAajHZvnSSWS8xSkBLxjcxnWgCmBtmkt?=
 =?us-ascii?Q?CDbFMWn+bgQnWCjs7B8gmjX6xh++OiTTvqoSDP4XKm4jigsH5o2Ye5LJ2ZWl?=
 =?us-ascii?Q?TcY+jEN8uHKFYE4KSJXvEdfLodxZ1pqB1ZZBt15SHwtPpZE2DXekzJHKcJRw?=
 =?us-ascii?Q?ielgrVse0gjNMFAhUco+VhhW1bbs2RxUgSK4a4H05GqQ5YxcZfjOToDsFqBN?=
 =?us-ascii?Q?AqIFd7g0FA4lJhGBU3m+bkJS48jRbdNLzsxqHW16EnkOdwWN/l0Hn+/oLSKm?=
 =?us-ascii?Q?moKv/A4VMgk0SFWUZsFjjFD3lCl1kHVVYq2tmTvHPG2011BL8KMqa+Y5VmLU?=
 =?us-ascii?Q?n54AQHO85B7zLfI5M1XVlpTopeyQUDCsUGs24E/mV4kcurAdfLoQGChYA1P9?=
 =?us-ascii?Q?LM27VXv/kMNO5rc7w4x8pfIXIYDVFaLTumTf8Cv3O9ujFxcy0nap2fKV8sE2?=
 =?us-ascii?Q?MRfCQvP3NdumR1jC8v2O29aUwwxPoAx7cqHAwn7P7x//7WfOIa0ryMT85YkL?=
 =?us-ascii?Q?gwRhewwlzjnZWudl5Smtd+IUy/FFCSfTiZvSKeg24Uk4DbrBmRFcA0EIxASf?=
 =?us-ascii?Q?GcqhDakjKAXKkOZG+ppRZaIw4u6q0335uGBLS+RB6apR99JUkK1gLYPOtugZ?=
 =?us-ascii?Q?ut0i1ZWs8FHyukP61oCzlEWPyx0lJJUya6Lhu0cKtOqqsBj6/1zRvS/gXuc3?=
 =?us-ascii?Q?AiYKiUkgu9RydqN57fFUufEqBL8hVbj6d3QmOk03Xr67nVtXlykJ2tEXJ747?=
 =?us-ascii?Q?pf+2Ac1X+WEqM+D9rNMZ81Od/htQW95LHJj/GPEp3v1ROOKoo3Nm5Iugf4a1?=
 =?us-ascii?Q?K1phINgi3xhsVEWFL6G7smMHtToudNS7dw+KAwC+YK5L9jJbrcRdEbuUIt2+?=
 =?us-ascii?Q?nVp9Tz8iTUJRU1AwucEjSwwu55kR4VI3fUTrM8cm3/hPr55P3Q18is4zsY5w?=
 =?us-ascii?Q?JuJVI3p4YGgiCdxvQrtUsk9VVZurcMAF7qSJp+HGXj5ZATlnvW2KhGyVgjA8?=
 =?us-ascii?Q?lex981slymW8LVu3ke9YMZp9X/2iFvuBvLrjxSE4mjXwXTImCOlMrvxSUJjD?=
 =?us-ascii?Q?12rnvrlk4J2s3ZmxXg8c4IiFEg4bsHXn60q5Ly6SFsBDjyQ7emi6r9YWuiDV?=
 =?us-ascii?Q?iM0z70J5nzBaEJb5B/4ioh4ksUBQl9nsowukpW1v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311237ca-4b07-4df0-1bd1-08db2f4be2cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 05:18:37.7124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riLywT0UZE/Uit2l7RLKFDkbj7kktaSLrQEIrYYcJmnwA06DM4GGzcOcVtUKES3y+wwQT9dKxDh47SV7BUmcjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6494
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, March 28, 2023 2:05 AM
>=20
> Extract all common procedure, between the iommufd_access_attach() API
> and
> the new iommufd_access_replace() API, to an iommufd_access_change_pt()
> helper.
>=20
> Add iommufd_access_replace() function for VFIO emulated pathway to use.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
