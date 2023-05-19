Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9A07091D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjESImQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjESImM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 04:42:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED9C2;
        Fri, 19 May 2023 01:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684485731; x=1716021731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YBDD61LYc+8YyV9IHFS+UX0XRgQWBsc6LAg20rZ53AY=;
  b=HqATrXLjs5G89/RG+47ZMn9TkOdTDJ8794BSLBYC+HwoJuKBMS+DaWBA
   7XkmwcNU+nCveMVDsI7NtdmxyfrPN2RfbJKP50FLv9SDKVoLZH7iiHuNc
   O/FmnKCZa4BSG7Wf/VRq/pXsj1dWqItu6NYRMNcqJeUFaxPN+L8duETPf
   DE5kW+Cu8uxb/tIFuUfAdqEwiF2rCBocdGEn9Bayi/JmFC1YgA/E50mbp
   t9PIEsyWG1qFoq49Pt9b2qexMX5UrRhC7Xu3Ep0ZrQYgk10859AmaRHux
   vgVMUF2tN1jS4eo0UFDIRyNAedJSpgMw380oABOazMDRbjAOZ+7oeWOtJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="349833894"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="349833894"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 01:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="652975528"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="652975528"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2023 01:42:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 01:42:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 01:42:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 01:42:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 01:42:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqjwiHx7rfb8+rnkHnbmFtARJ4GmPzxRq823aHLj7MqtdW1dHa4nTkn4UUHkX0HdtXRq185S+CpayKIZLRaHqHA8AEZY6xtcojLG/wkxhM21/J81L1I6Kby0Qm7jFmm6IzmP67CU2EhOVsKbjtDqwE0mKWeJypJfcLmbHQFVsilk7kLVM4vqOrootdF3VXQlA+Krz0FT90BZO6TiYlNZZryicWEYoj7lzG83yGybGyQhNoY2MzIHZb2Edhyg74vKTeLXUnuzpQOmqltf8iMRaLXyfiaYuSyLYoy1VA0aJnNbgBjAqx0JCc+fCw+tcqwNBrw81fqppuuv0UYGZJsiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqWPpKV/SDoufZb+WRyFoUiAVCVv7Jid7ZhuWp4XsRk=;
 b=Ibjg4SHLQTtbj4pmYF5uYDb6J2tARlKxFLGZFoi7jX7jt140nU6sZNDFAsIG36MnffwsJ/6XE+xA8ug0fbCjm2FMnbVItIYqVJ05wsYv3OzbT9olyE5iDfMAvrem3AhYf2LyvbLGuXWVJYBZgLC2Sv53nTHSXHxBQOEQ3zKrC5WxuWxPzYKKMm06JnPQm1BBDgakBZYqOeNyJ23we8cv31uo9HvkXVUy41oUsFAhmTY6SLEGHMh/CKxEtbyIdcjF2Kbu7bZRQ+wrzUn1SYK2x86B0pzhDRQFJ8ujS8F7upUuvowz7BeTFP7lFpCaDDdJXnJGYwsEJoHpPbvB/e7OiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 08:42:07 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::6f80:cda7:a88f:3cc1]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::6f80:cda7:a88f:3cc1%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 08:42:07 +0000
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Topic: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Index: AQHZhBUvZZEu1sIxqEeJFXndXH1dUK9hUM+A
Date:   Fri, 19 May 2023 08:42:07 +0000
Message-ID: <BL1PR11MB527103529CB229A58C2439FF8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
 <20230511143024.19542-4-yi.l.liu@intel.com>
In-Reply-To: <20230511143024.19542-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH8PR11MB6563:EE_
x-ms-office365-filtering-correlation-id: d47e08bd-d38d-4b57-482b-08db5844edd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S2Q6zRvtJ+M5oIAySc0QQmj+5lYqY86kI1b73VOWvO7vwYtpOaor517PawQmdb5Hs/hV02yQN46YBeo4Im1ZJTsy70S1WJnByJyI9CbUUIaPfU2hPRPQ0ZtTOckIQY+W2/SN9efJtpUuUvZ50rTsxSs0u7R7XwkbMzd8W7Z4yNACLEVhbzEy1Hw8keydEejlZhhpYp/jrc/NDScw0LRRa2prFwW8TbL1CubWVPDRoPGrVIZtUyoZb34fPTWEJReaTqO5ucGy21jDhs54ZtNwvxTiEHcXyV0YQ2sKKURBcqV5f2uVWUt5fzuAVrOi9Jb6sQG3lvpFhYStHkBhmdjQBBs8sVGFBVRbHQ7yPxDB1g7RrwxwBhXaKnY5L0VK3ZAl8duETxO0tzBnXIErydCxBlPkQdOnA0JvUa5qnQmMZ6Xs0jStZl2itatI8XUHudvCntd6hnUmVOccTta6sIhESdZ5v7ImY5r798jo/8t4UgY0JDGUws4+136QdirQuQWnkeJjeldcIKI/5DhJaYA1bHgpH091O/CEqcLb17TXT70qVm1Pki4vjQ1987/vr4JQftKNikRE9VbPOIUhHDdYzV/m3lzg/39QdhboXZjzIzcUUMJptG1SSfQ18gcJ8l6u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(86362001)(5660300002)(52536014)(41300700001)(71200400001)(2906002)(83380400001)(122000001)(38100700002)(38070700005)(82960400001)(33656002)(9686003)(186003)(6506007)(8936002)(7416002)(8676002)(55016003)(66446008)(66556008)(66476007)(66946007)(64756008)(76116006)(478600001)(7696005)(110136005)(54906003)(316002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pk1PU/6VVA+XVYn3/jTJ5weRXA5FTrZXYFaBxdR5gSDhEgVAJWw5/wpnZhEx?=
 =?us-ascii?Q?coLgtlPggaAfSTDVpjOmRAyc+doaRWzeJFhMCjAD/GgWP2aUwkpix09ofY4h?=
 =?us-ascii?Q?8p+8KsnKyzkJ9/9rc0KIonaSWvKsCojIGj6tUNkFEr+OD8dgSQaTPHNmsLXH?=
 =?us-ascii?Q?5sAAjQ4Ly9HzzW41botWY6ayYXpcx/64j9B0copoiAQ7OAgASKTCAB0/cFOm?=
 =?us-ascii?Q?siPDp2GdSL+kC+p/y6DrLDIYYhtPo+oGv6+bmxFnee4A/TFXwWI57tPxZdcD?=
 =?us-ascii?Q?bcAh9A99l51JAP66+N2IKmJtCgnq6q4XbHP9BZQXU3e9JTQqTb/l33Wu907+?=
 =?us-ascii?Q?ibYsxkYuqvvNYV/MSSOFHBX1HVPKOrsT07PAsbD2mmoxmkUQTKkz6UK7JJEo?=
 =?us-ascii?Q?k/joLEhlpUtbXvS6q6MlipVHtq8t9BJ1l9oJWoennWS8Mv+Y6QYb9OxPH3pi?=
 =?us-ascii?Q?YsxvPgB01r44Ke9QNfgLLrHlZnaL/yZnoeNJZyaPtWOXg2krasN69bxbkqJC?=
 =?us-ascii?Q?2fvThUoDKaRuVNarvcTPZNppfcxGZvrLgwoHGGW9na801LDeA0rzH+NSauzD?=
 =?us-ascii?Q?cRUQ3jJAaAYT/mTT4xFOOsCbZFG4Cw6ZPTqVEXCrrvoEngEVsXVNir1gAvTa?=
 =?us-ascii?Q?PQ6zCQ1h0V1fuNvA6cSXaohW36spnaFDB187R/6KA1cLSCIhKdK0kiqtQo7i?=
 =?us-ascii?Q?3XASJ7rzVWwTx+jm16gsfdQAD0bMhkfuqIpkLptJTRxPpMQBzfJ+VWCg0MCL?=
 =?us-ascii?Q?VbJP3ieoIzXP2Qn+043CrKXnuWLw/6QS45Ex7YAOuTl4cpyHnXim1aB6n4P7?=
 =?us-ascii?Q?CqNhLkjKwdVF/ei7ABiwOfKrqK0pWc1Mq4Aw0tNDyrndVrvC2yEWqsXj94Zr?=
 =?us-ascii?Q?CiWKXgpOCs5aOxFzCqwqob9DmGqzamvf/viqRaOp9CV46BfY1pRz7MC2Bz3r?=
 =?us-ascii?Q?L2BKQMXajYYfnnBAwMJ+52XswgW/S+WyJeDkgTTKflvzDY3UR6rgSb9shydz?=
 =?us-ascii?Q?u9S5RfvQBHoiksUdow2Dc9K7OtHiYY0DQFc4dugFk1+N2cH3I1hA/xpfGlt9?=
 =?us-ascii?Q?tqMV3Dq+CNLkyjQ7D8CqbeNHBNAVkpCo9QbluNV1n5eVwJD+LlTSFK/Vgq8/?=
 =?us-ascii?Q?T0w0GXSTfmlyox01HjcwWcvQEuHoAo55BP/JmS7XF+LksJRHTyDF6vCh6m7r?=
 =?us-ascii?Q?xFlpoW+CO8Xfngw7iWQZ63LAker27rD0pElRn7RG65qaSzCLCMLIOQdK6J5w?=
 =?us-ascii?Q?Irl2akIhnPh+2hxP8vs92WKhYjiWXqwnq8g8KheJZntaLKvzDJsBh/Mk42+7?=
 =?us-ascii?Q?DpA+UYmqgW+FCIzAiPELPpBDOWaRo7DThrjp++7isWH/XgJw7nsRHcMcK5jK?=
 =?us-ascii?Q?/8SxeYTppupe7nDxENV1ZiwRtzBrUH9cierZx4EQVUJiZzqIJD8AHHXk0Ohq?=
 =?us-ascii?Q?SXCMsbb/03qAHmlp+Mpg7148kSqsIMCPXBsUaSDnceJSJJdY9ejX2HgnBTNn?=
 =?us-ascii?Q?zw2WtdhNOaY3Xp9QjIbsCBOg0+p2IhntjjJ3g1/SV39na6dCZp4aq+hi1th5?=
 =?us-ascii?Q?kiePFANt5QGObooFiCA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47e08bd-d38d-4b57-482b-08db5844edd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 08:42:07.3925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUPD3W9m/cuh9BXjL3V5yolCTU5h0U+X/jOygi/Bn9pEs7JjQ5Ahl8WWzwB/qMPpwe/U7H56M5+kJZ4wgbmBOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:30 PM
> +
> +int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_info *cmd =3D ucmd->cmd;
> +	unsigned int length =3D 0, data_len;
> +	struct iommufd_device *idev;
> +	const struct iommu_ops *ops;
> +	void *data =3D NULL;
> +	int rc =3D 0;
> +
> +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> +		return -EOPNOTSUPP;
> +
> +	idev =3D iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	ops =3D dev_iommu_ops(idev->dev);
> +	if (!ops->hw_info)
> +		goto done;
> +
> +	/* driver has hw_info callback should have a unique hw_info_type */
> +	if (ops->hw_info_type =3D=3D IOMMU_HW_INFO_TYPE_NONE) {
> +		pr_warn_ratelimited("iommu driver set an invalid type\n");
> +		rc =3D -ENODEV;
> +		goto out_err;
> +	}

this should be a WARN_ON_ONCE() since it's a driver bug.

> +
> +	data =3D ops->hw_info(idev->dev, &data_len);
> +	if (IS_ERR(data)) {
> +		rc =3D PTR_ERR(data);
> +		goto out_err;
> +	}
> +
> +	length =3D min(cmd->data_len, data_len);
> +	if (copy_to_user(u64_to_user_ptr(cmd->data_ptr), data, length)) {
> +		rc =3D -EFAULT;
> +		goto out_err;
> +	}
> +
> +	/*
> +	 * Zero the trailing bytes if the user buffer is bigger than the
> +	 * data size kernel actually has.
> +	 */
> +	if (length < cmd->data_len) {
> +		rc =3D iommufd_zero_fill_user(cmd->data_ptr + length,
> +					    cmd->data_len - length);
> +		if (rc)
> +			goto out_err;
> +	}
> +
> +done:
> +	cmd->data_len =3D length;
> +	cmd->out_data_type =3D ops->hw_info_type;
> +	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));

the 'done' label should be moved before above zero_fill. Otherwise
in !ops->hw_info case the user buffer is not cleared.

>  union ucmd_buffer {
>  	struct iommu_destroy destroy;
>  	struct iommu_hwpt_alloc hwpt;
> +	struct iommu_hw_info info;

follow alphabetic order this should be ahead of hwpt.

> @@ -302,6 +303,8 @@ static const struct iommufd_ioctl_op
> iommufd_ioctl_ops[] =3D {
>  	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct
> iommu_destroy, id),
>  	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct
> iommu_hwpt_alloc,
>  		 __reserved),
> +	IOCTL_OP(IOMMU_DEVICE_GET_HW_INFO,
> iommufd_device_get_hw_info,
> +		 struct iommu_hw_info, __reserved),

before IOMMU_HWPT_ALLOC

> +
> +/**
> + * struct iommu_hw_info - ioctl(IOMMU_DEVICE_GET_HW_INFO)
> + * @size: sizeof(struct iommu_hw_info)
> + * @flags: Must be 0
> + * @dev_id: The device bound to the iommufd
> + * @data_len: Input the length of the user buffer in bytes. Output the
> + *            length of data filled in the user buffer.
> + * @data_ptr: Pointer to the user buffer
> + * @out_data_type: Output the iommu hardware info type as defined by
> + *                 enum iommu_hw_info_type.
> + * @__reserved: Must be 0
> + *
> + * Query the hardware iommu information for given device which has been
> + * bound to iommufd. @data_len is the size of the buffer which captures
> + * iommu type specific data and the data will be filled. Trailing bytes
> + * are zeroed if the user buffer is larger than the data kernel has.
> + *
> + * The type specific data would be used to sync capability between the
> + * virtual IOMMU and the hardware IOMMU. e.g. nested translation
> requires
> + * to check the hardware IOMMU capability so guest stage-1 page table
> + * uses a format compatible to the hardware IOMMU.
> + *
> + * The @out_data_type will be filled if the ioctl succeeds. It would
> + * be used to decode the data filled in the buffer pointed by @data_ptr.
> + */
> +struct iommu_hw_info {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 data_len;
> +	__aligned_u64 data_ptr;
> +	__u32 out_data_type;
> +	__u32 __reserved;

it's unusual to have reserved field in the end. It makes more sense
to move data_ptr to the end to make it meaningful.

> +};
> +#define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE,
> IOMMUFD_CMD_DEVICE_GET_HW_INFO)
>  #endif

Here we have a naming confusion.

'IOMMU' is the prefix of iommufd ioctls.

'DEVICE' is the subjective.

Then "GET_HW_INFO" implies getting hardware info related to
this device. then it should not be restricted to the iommu info.

with that it's clearer to call it IOMMU_DEVICE_GET_IOMMU_INFO.

similarly for struct iommu_hw_info.

'iommu' is the prefix for all iommufd ioctl structures.

then 'hw_info' is too broard.

iommu_device_iommu_info reads better? though having two
iommu's in the name is a little bit annoying...
