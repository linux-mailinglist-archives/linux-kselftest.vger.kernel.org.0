Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC146A9140
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 07:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCCGxh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 01:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCCGxg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 01:53:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02397EFA1;
        Thu,  2 Mar 2023 22:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677826404; x=1709362404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dO4y6y2/+1UGYVhxwHkwzMX5LeQC78W+201sDFjATl0=;
  b=bra/4PRmulxQy29N0hh415BbVblVBB5q1Ez92GkzE+UOrqs1VUHnyfeq
   wZ7gXGNkjf6BCbPljkMGjvnQyw8f8trcqb2/oVpiTw0uSlFiwJLPwDtuS
   GGNddY9hOs7mmtU3W1NoM43sGzpxcYt5/H7Yv/3XdzE/PUHCwU9We6MHB
   p3awJWJMwziP1mf+EPLJQ2JnfuiXgp+pWM4VpoInHTJs9s+8uIp+bAbSz
   evlJ0Ct1VCexwl39Ta/dWCAAGvDQfS8O4we+/vykuvtWyjKBdZDpyCS55
   W+UqgNf0aYSyK5jqKMc27lgiq7oGjhiEXY42zUaDcwS/bfhxTwwFC/KYA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="337290082"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="337290082"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 22:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="785165176"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="785165176"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2023 22:53:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 22:53:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 22:53:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 22:53:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 22:53:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heyqaC0755OvdS3SBYp+9re5AEXVtmfpmwROI7mf5F22m+LQ5zeQPJv+ClTinno61GqV9fjpl1fnpt33Gc12vGfY1DWjZbS/hbmUlNOhzLqiSh9xr0uVccYwt585G9yvqz1/w/R3C2WguKQAqO/vCndpGtVgjKCu07L4ZqwsVliTEV8628a/D6/dyUx6skXdUl9DzQCehVzNvtiHPnMusLO+EZn4q7kcArS5OWguCW+K9+2PtckEUfrsBInQDUj7CxKYZGA6YcYse2PhcmmYFyOATBt5ZoXZleB7M5LbuFiIoaDqQmifOLiCHOdCLlhHZZVBXfN9bjGHxp2kOjmgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdIhJWF6WPrA3luiZ+jE3/gLWRSGsa8kOLSwaZRxOZc=;
 b=UW6jcPF6AVZHrDBmF80Qt/naKYNdiuZadwO6hJHu8u8Ba9lEfm1zi0KH6SVwegnNY9/zhs5QREMPUFn4Krb2SkHhKxV4jyQUIAaxmz6uBpIXqo6HPSd0Jqqhi2WYN04QjFkRhkN10TSdI0Lp+zxitffXCsNBC4sT7lS7yfjEzG1MmkgwzGOCEJZugpyFqqZbnyioamLaW4PzE4EZfLs65b2uoDR+hl67P6L8JyeApagwKdnmzdX37WxVwA89ywPe93Lm/zmL0vcjGBuePRzV9baBFDJLFhDBRi7S2UdFk3M/1erjSA9HkDLog59krYkpy+NpQaa5/cF4qGRq2LOeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Fri, 3 Mar
 2023 06:53:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6134.030; Fri, 3 Mar 2023
 06:53:19 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v3 1/5] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Thread-Topic: [PATCH v3 1/5] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Thread-Index: AQHZSLveJvGTuf194EubSScIxR/EM67opvmQ
Date:   Fri, 3 Mar 2023 06:53:19 +0000
Message-ID: <DS0PR11MB752965139F9075A4848EDA7EC3B39@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <cover.1677288789.git.nicolinc@nvidia.com>
 <0f8d110eabc40e71fd2c37f63b1bc8888c67414f.1677288789.git.nicolinc@nvidia.com>
In-Reply-To: <0f8d110eabc40e71fd2c37f63b1bc8888c67414f.1677288789.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH0PR11MB7616:EE_
x-ms-office365-filtering-correlation-id: e5556956-6d91-4d66-6481-08db1bb3f91d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTmSRXQicx261rfCHaRFhOR7kHYASMxipFzHljG+8CUQUlLQWViz+vBRmj8+b9OVR+UgtMaitDEUir1P6hKcXabx868MH4i9EIOlnMtL9SnhJqJKvbH9YYaVnsO7MMLetFHYUwa5iWC3zvRSN5eNsLWd6AqEntr0EjjoEMlJmyzdC604Zog5WisJdFa9VdF/U6NJHvNEB9QeGsnTbMi3S0HgxQitsB0EOIei883PZswaCFXQNakzwOjIv3aLIYpy6LF97/9nwWq5jADFmeQgysWlDrDCxUw9HXwtMWcinY4UyyIZdh4Zs+63sjcInFYcjeiUZbS67Kg/n/eWlUz2QJv3+TLlfhlDjJkucdPOnOoi0P1PsXdT8bX/nNHIYXrdPHJEycoi7dluH+dfwlPxDSNaYoWUiBNYy9B9LrG9ZiUJDwA5HpHkAbcsvH6AlqjsRhh/jYFEVQ9BT3ZlLckxkB1m73PfrD0M38lpNy07Ov6l014RIQxnTTirYrKobKBMYPqvhC7rkV/2kmUV17MJQHubjfm5DAtsk/OIMK8MQ0o/pckuh+pxLLAlE+CRqVehnaKrTZYujF4pqOlxGaYC/uJl2/3k3MDG1VLF8nXja5LF2jNt17GuoS8IFV/4LY42isNbbvfzbutPdbJiHOwh99mgdcUNIedq13uYiR/2zXXje3fz6KWPZzgAmLmfTkdNlbBXauM5t8jUS6sw/KRHtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199018)(86362001)(38070700005)(64756008)(33656002)(5660300002)(52536014)(38100700002)(66946007)(66446008)(66476007)(82960400001)(2906002)(76116006)(41300700001)(8676002)(66556008)(8936002)(7416002)(55016003)(83380400001)(6506007)(54906003)(110136005)(186003)(26005)(4326008)(9686003)(7696005)(316002)(478600001)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mR4upl8UyXRUAyvrJlakIcRCA4hFm+x0azoWJXjC7B/nud71nasxWFpWb+nd?=
 =?us-ascii?Q?woC6ZyJSu1GI2D8jWKFQpDv37EuBvLytS7wtL155o4fJpru9HgZ0GL6vNXCk?=
 =?us-ascii?Q?dr4e4JZhUYA3/aMAyAFBtA0QFt5BirHfiY+/R+IO9jb/R17f+8Ofqand0kM1?=
 =?us-ascii?Q?98uT6Liqv4FehZx5Y3IEyuZSbU9feP6QcELFVieUjM9nA1muoDRApCdHIL4Q?=
 =?us-ascii?Q?uxBUcFxKwUhKim9LTi7czwuFPBRdxt8Nz+QGv6DQSjrb7/3UP5A0ruZfATxP?=
 =?us-ascii?Q?Lovq1MkfAo6yamlkNSN9JtXvT9tpWIfqA5aTAGrE+h7D7fVKQkTo7+LVo3B9?=
 =?us-ascii?Q?3C89ZVH8OerO15D5xi4K715PXtv1Kb6ZXR0ejYIgxgmnna7l6VMNyJvBMP3a?=
 =?us-ascii?Q?vq9uLsnDrX8VmN8+8wA2fyT4c4AdsmTGK0adeS7yRNRhOkhEv75sMiLpRajw?=
 =?us-ascii?Q?1sWfj1MKnMF6sIDIOZWxbxZel8GEdeLEulHwwUvdPeGODGBPOxmw23BREMP3?=
 =?us-ascii?Q?x/bpPuBx5nbSymiMR/Wrrb9NPuhoFzoGvFDuzHoo/purs0pw7fIUHBk84Mjs?=
 =?us-ascii?Q?C267EdNbHwFunqENkhP2CafQ1VUauLFWiJk2VXT43MHy2Etk9/QtlzR45DPq?=
 =?us-ascii?Q?mxmxGEcLbzMq7IQSP0gDuxazGG5d4Gok8cDTNMNcp+C5Q35j26xyURfj8bpA?=
 =?us-ascii?Q?U67YQtPZV2DFVtCTO7dq4nvZ8AoEWj2wh7snJSrsH1cBdKQoQvSq40Z5+mKM?=
 =?us-ascii?Q?R7XENrAO1oUoQ5JgT2kzmABBB370BeNG0Q8AEwC+jUuqP0/ISpsMknuJ8TPn?=
 =?us-ascii?Q?Qh1SHhTkwJJHR672EgizCrOUzH1mJZgNqKRGL/sgVYI4boDyWVon1BLdCJq6?=
 =?us-ascii?Q?v7osf7ykFqbIuQPfU1WUEaAda/yQ4oYSz3NsqtVTxK9f5HdCf2ILtMxdajMY?=
 =?us-ascii?Q?yLQhx2RGjwnTXTbVB4g09grQCAWCFguzq2EJB7+g40Mgc67mYWKb2SzjQ6A5?=
 =?us-ascii?Q?+FYh0IMotH1DN438s8JWrod+y7LcAcnQqdGlPDCM0y7bzbYLawUu2qCPIbYM?=
 =?us-ascii?Q?fy5BbwUS8DZwsElRGeXomkkQdfaYmvi982u9i6IkU/3apQ8ikHdYK8exkyOh?=
 =?us-ascii?Q?bNOVbY4N77IAEb//XDCUgEdW1GXwvtoGu87MMcggzZd+m2vbjUOf61qGTzFB?=
 =?us-ascii?Q?NPZk2nb8RQtmFxoYPDdE/UHibZmH9huXx3vE20EALA1UJrNdBAXPEwIgPxQC?=
 =?us-ascii?Q?S7CGMYPcEacZEwUtZ2Xvh7E07RZ47hlzIs/KzpKnG37+qFBI4p17tuNAVM8L?=
 =?us-ascii?Q?TBn8qWQ5hDMsOPskZ2dgo2iHA030pWPTJrLKg5cyM5LQVa/SxjbpnAZzsae6?=
 =?us-ascii?Q?J0tSjcD+e7gyzZ1YSrwIzY9/fNxKinr5FuvjgKMDDRpS7Fmwsc5faN5Wcd+U?=
 =?us-ascii?Q?uzqHuK+g1FgIov3xIeRlfqr+j+FRSwSAAQiGqvrz4XamJwLIDmWqso5eOybC?=
 =?us-ascii?Q?Xr3zX7vfIWLIswEaRj0gd01C2HghfBGFfygKbdOp81nTTrxP46MWF3ptsuec?=
 =?us-ascii?Q?QOEuh+Z6NktCM9J4am3cD5TIll/ulhw8+uBPmvzU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5556956-6d91-4d66-6481-08db1bb3f91d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 06:53:19.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HMCm9N8f/lrUWukArUYkOQxO/kGq9OpTboFD6GRT+K0cmcU7yllYjkMulXYrvNSQWyvdKzGcS6FPI9iR7gpbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, February 25, 2023 9:52 AM
>=20
> A driver that doesn't implement ops->dma_unmap shouldn't be allowed to
> do
> vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
> range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> ---
>  drivers/vfio/vfio_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 43bd6b76e2b6..0381f6e7f4e6 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1292,6 +1292,8 @@ int vfio_pin_pages(struct vfio_device *device,
> dma_addr_t iova,
>  	/* group->container cannot change while a vfio device is open */
>  	if (!pages || !npage ||
> WARN_ON(!vfio_assert_device_open(device)))
>  		return -EINVAL;
> +	if (!device->ops->dma_unmap)
> +		return -EINVAL;
>  	if (vfio_device_has_container(device))
>  		return vfio_device_container_pin_pages(device, iova,
>  						       npage, prot, pages);
> @@ -1329,6 +1331,8 @@ void vfio_unpin_pages(struct vfio_device *device,
> dma_addr_t iova, int npage)
>  {
>  	if (WARN_ON(!vfio_assert_device_open(device)))
>  		return;
> +	if (WARN_ON(!device->ops->dma_unmap))
> +		return;
>=20
>  	if (vfio_device_has_container(device)) {
>  		vfio_device_container_unpin_pages(device, iova, npage);
> --
> 2.39.2

