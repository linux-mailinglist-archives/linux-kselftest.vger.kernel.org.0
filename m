Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D086C60C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 08:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCWHa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 03:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCWHaY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 03:30:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42231E5E7;
        Thu, 23 Mar 2023 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679556605; x=1711092605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pwZgQxpRs2MUyRi5F5W/i7+cqUlNVpa/7DDDU8SWqJs=;
  b=PbTmJiWAgrh0iunnTNOO4FYMUB7b+xnVJPGxtGky/B3egYMWvCT9LCEy
   X1fgPiMh+71Di8+OUnuzzS5pQ/G1NIZyjuh0/3ZEXI7svWMG5//vm98Eq
   nhg2Fib/C/9yUq4oLSz5vVpQzD8eZIvlVgwfqLHJdkFIxgxguUQxQyPvC
   heor6u81vDAZhjpJ3yn2r6nMQLZwRWZReS13VZ7puVU1yjlU9pyfXc85t
   gYAoiY1ONXRE9pHGL3UD31h7atFwYUAwjW9HLlm2Q9s0BJlahcX3apHUm
   dQKFA1WgKVz/JY98trgQ1PXgiIohvYtiPGqzVOuUovND5hUvOPyy9PEHO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="401986654"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="401986654"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 00:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675594403"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675594403"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2023 00:26:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 00:25:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 00:25:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 00:25:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 00:25:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF0U4slt8l0ctWijxoaOmw7v8Jsmwog5N+TEn/JM/Uo2gxippEXaz04Y49DCYpYy4e/nvAFiQn4vdy3X6jn/lzPdo3s9YAvFGQkSrRMjd28YXfTwBBGMX/kz+LC6FWqzPbbnL6O/lMtknxn2ThvFwgORSaDN5vVDGKo0It2Ep+wYtaxMqz+6PMt61tg/lhE0mvG3w2ruRL9QUXBZCmRgCEOddNC6ocCdkxRpNN3wbyW2WlQDaZeB15RQz1JjIcXGo3XtrUjfqwf3rPHmuSOigNYCj24JEZV0IrOMqd3udH+UI87GJJxaouEH+9APVOckeRKumkC7ICi3xRIGy8OU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsBLWhavNObUREH7bZfUr8SI4wCABBnhW7D+apxfgWw=;
 b=AVbOB4mH5gI46uwMzGwUe5XTekPZaRPfHHcfrgQQcfGqZW8D3AKmLNgM0WLwJXRwxrjdq5d2uSx5k2d2SLd8I1Gg1BWT/JVwzK0hynvzfV7i3sWV27PLl9dTmlTonlmsMqCr7rIECBKHmDbeO3+++YfCC2N49N26C5GQuN48VfNyMV8U/fCnT8QgbjmQ/kUYzKpvPZ1gSK5f4K9pc8sUEluAfN849tfaMuIgvr3jzUf1AePzeRi+940VQdZLYqtIfBlEYnyNzoBjvaJAhXkhKfWWCTpgRNyHGZYOWcW+2n0Rn5F3etFMqMDKiMMiMUpeR0fuU123xJFWUU6/jgICUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 07:25:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 07:25:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 10/17] iommufd: Reorganize iommufd_device_attach into
 iommufd_device_change_pt
Thread-Topic: [PATCH v3 10/17] iommufd: Reorganize iommufd_device_attach into
 iommufd_device_change_pt
Thread-Index: AQHZXCmJjAjb/dKmk0aMUSh8EBJu3a8H+Iog
Date:   Thu, 23 Mar 2023 07:25:55 +0000
Message-ID: <BN9PR11MB52765C5992F59307F24635058C879@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <10-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <10-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6949:EE_
x-ms-office365-filtering-correlation-id: 799a0cf7-8c5d-46b7-08ea-08db2b6fd73e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LsGEqyZ/l9V9I9fKc8s7jvBeAyEO/13u/5knW+KkYn6VoyziecJ3essgQKZCxDXXPfAkIkB2nLezzb0OKBRe2uxE1RQJjt/gR9eiU1aFkfyl3ysObtis3avGFZ6nmr9L+PMah/QvN7hxvktxyqPKkAPoVc/hHBnpFx/3hZRgEW+0tQJ1DHcK8RoH4xHnpbhEnIz/pbKb7TIqvXlrloXsCJL+7gZRpfqUrGexhu+RhfI8X2rjpY3WIJ9AFE1FHmOTjLH/WRbj48obP7JB7F0IaN1OS3ISu5CqXXUTrfOZtibD/bc//3bVu7joWHRHBz4XYM+XRa08bTgC/yOBl4Fxcrf4PhzUQwCcfQ8CjcfvJy3aYEc4AkY+ZY+DoUY98UcvJa7YCwub8WbBftF678x6IYT6RnBf6I5vUoGd5Ew+snvpzrqH9TvP6jUh8GHUugoVoz9pOmApdPJ4S9nkwqyrQGN+Ul/xtr2sJDo1xbRp7LCs2+4LYQCFulCKXAE5r1rS4IRTO9egDVKAqH217LcHUc8wG3ABnOh9/sgWHKiNJNWDReoSCpfIUPtlC3CbjGteKjaUeoySszqjxsIdEOk7ndrs17gzs/IpqhK3KTy7SUHE8VXXIqPWDxFOH30enRF/vRCxrCswQhm1TPL8wHTufAMDC4bT5+ETOScF+DbdjX5rujrtSWGlUpO0IF7FRra+gF2TvEt6fT16EsUu/zG9tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199018)(6506007)(478600001)(41300700001)(52536014)(76116006)(66946007)(66446008)(316002)(66476007)(66556008)(4326008)(64756008)(8676002)(110136005)(54906003)(186003)(55016003)(33656002)(26005)(9686003)(38070700005)(86362001)(8936002)(5660300002)(122000001)(2906002)(7696005)(4744005)(82960400001)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nvufc5coj3D+Irshg1iDl8KQjpcfFTGi4ZF1PwUETJUdNBqbRB4k7JBGrVFE?=
 =?us-ascii?Q?32o/yEzIbpnWoosyCZyiBS2z7XTP+dRwkGMTxSOZdsdOJY3xPKRfMP6Ke1VJ?=
 =?us-ascii?Q?5UXm+alytuPNvz4ru0WO5/Lf89ke63/dY/WnxNgGtI9/3eP+53Fl/BZm5nQO?=
 =?us-ascii?Q?vhyVnrnUZ16jrKOmKpm7n05fS0Tcamx2H6Lb6SlIgi7tuYT+ND6lTa3AgBtZ?=
 =?us-ascii?Q?UNFhVBX9p0lGBq92+l2xdGYzRiN5IqIq+Nl7ndPGoIZ2lO6VKSbjWVNaYGsz?=
 =?us-ascii?Q?SJFFPDzfm6UgiuICeHnyMDjhU5Ty7sU7VtAnbLMTPD+tGpbKH+iA9FCCp00P?=
 =?us-ascii?Q?q1WrOH1NJqiHlmcI/LAzw8mXK/STiyRQJoENVN1RNDKHcon5VTZ2oYjuRy/q?=
 =?us-ascii?Q?T2MZCAiYVHbXabYBagz7rmo5aRv9zMFEK1AGsFcxMhSup4bL1LCUricxeQcp?=
 =?us-ascii?Q?tYp0z/TjOsQxxCWDR8b7ONM975aEVbxROO4s1Hd2ttqYBZAAeKmQfRZXXyLF?=
 =?us-ascii?Q?fIpQCFIyI/nFjUpjjZzBPB90Di9Wgs2tQR224FNQQuGhMIwZT5XfKX1/Mhos?=
 =?us-ascii?Q?a4Cz/6ZR0HstOJJpi/bFpFkGo7hj9uMjpqH2tCtdKyVoe+AzXNdrUnzHAllr?=
 =?us-ascii?Q?sMMNZM8Mz08qYyhZmqv9h00YrS+A6Fa5l88aCF/2murr021QzRLRUHTHB4gL?=
 =?us-ascii?Q?0+ZTXydRBnIELmF+njiuB7RUZrwqrYUosc+7uNApFjzh0MUciLjDqafN7ofo?=
 =?us-ascii?Q?qQ1KZrf1vRkyT0bztHuQpIT5R1ZGLLMPiRNJEmlvoXz6m9o51/dHrAyYdWwt?=
 =?us-ascii?Q?2YkDz2LXgTuPDhBV8o4jbQFKfxe/WYw0k4YZTxBuhfxVSfFA/ovky3g6+g7o?=
 =?us-ascii?Q?H2l35ea4SFpnRF0f1nFKPEKIrUhi2GWBhFC9RFpj31ObG6hmSTdPkgZHOXMg?=
 =?us-ascii?Q?co3MpNB7aaAxBkE3OU2XIxXIX0URFWMeT+2290HguESldiVkwvsSHdH7+eLd?=
 =?us-ascii?Q?t4JQZa7R7XUFErAOHOZSUDnZ85reiwf1LH9Oa/KXFGzutpedaBnfg8u91dh0?=
 =?us-ascii?Q?EnMguJh8rwv7dbbM6Ttr0sJnWP6MCMxXFqFJbuLQOQe8L3bg/AJKpNZq9SWH?=
 =?us-ascii?Q?8bhWE1Y+7nggYDdnbTlUZLWmt6gvYRqNdKeYgEcv359H+d8BQHEMLDca2xBC?=
 =?us-ascii?Q?eho7r9wHZkMgO174T8tT0fQdNPYEqaWSNQrLw+lW7VIyo3TlVfSKH2jHuvSA?=
 =?us-ascii?Q?3icw/AtOHntKz7RvW+Nivf8P0NKdT4R6YyOuXVZyplnQY8ZvgqJC2fOui1qz?=
 =?us-ascii?Q?Ww8HkaRxS1WDgj6sVa6BKeSt+fftanSlG3SsYgtlsxU01ToG+pLJUM4QE4S6?=
 =?us-ascii?Q?nPk+Uzya7/P4VAylQTOPRclE+tjkmMoV+sPQy/SlH1ietghXu2Tgm1W11Iyh?=
 =?us-ascii?Q?cwU8jL50fjzfwMPHc17273xdROV88R1E755VkNFk5sB9NqulVJotAWrJ0P2Z?=
 =?us-ascii?Q?E1ZYpzxv8cyQyc/24otzPgPhfNQVlEO6ZrciBSxn9cdctFxVWnqQGgvjpxYe?=
 =?us-ascii?Q?PJUOyh7BO241AAWyNBgoEASODIY4i1c3M//fmP2H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799a0cf7-8c5d-46b7-08ea-08db2b6fd73e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:25:55.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynkNElX7QcR0phMOyNd1JQ7xh3DlQhbZuIq9eFvU6aVaPxAFJoiMVF/87TYFdjaE2eCjk/7Qa0dtl8xNmEbexg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
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
> Sent: Wednesday, March 22, 2023 3:15 AM
> +int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
> +{
> +	int rc;
> +
> +	rc =3D iommufd_device_change_pt(idev, pt_id,
> &iommufd_device_do_attach);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Pairs with iommufd_device_detach() - catches caller bugs
> attempting
> +	 * to destroy a device with an attachment.
> +	 */
> +	refcount_inc(&idev->obj.users);
> +	return 0;

While it's the right thing to do I'm not sure what "catch caller bugs"
mean here. There is no WARN_ON to catch.

Otherwise it's good.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
