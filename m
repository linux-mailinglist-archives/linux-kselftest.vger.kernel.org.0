Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1242F693C0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 03:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBMCM4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Feb 2023 21:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBMCMz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Feb 2023 21:12:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D0AD23;
        Sun, 12 Feb 2023 18:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676254374; x=1707790374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BGGUlkpRkgXouJGugwE35eOOqxjJEftf6ETbKDj4Xfg=;
  b=Sh6oDV/IWEaXghWSADKUxbgn0201ERZuvChT+xFeGui/JlGyAHCOlpJH
   u91YBukF20+pWoYF85ZOKbfXYPG6rBzdGHzSOv+2EfGd8egdiGKjsmZqI
   kkoxxCf/uBBgj+9uHKUR6eIbz0jfsLgvIEU84h2xwSs6rECmgsxDltAA2
   nb8E3GkCBu9cCOmzBCRLhuOw1wKZbHc9sgdz480LjEqgYTtEGMmNk/Bha
   8B6YbC3ofjz25x8lM20MkZW5a5+NYsMR+N6oqm1fC7Efi7TSB1qkcSx81
   fJH5URwNorjcSi2Pp5/8D/Bm9W13QRcN+PaDDGf0kjFELArVOvN6NIHrC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="417015547"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="417015547"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 18:12:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842609328"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="842609328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2023 18:12:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:12:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:12:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 18:12:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 18:12:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBm1/XPMxzBC+pYp4qIxChgraR2CIYXsgA/M1uKhGEephyhW46P6NgLk+DA+Zwq+3LE5UhNwb3Rc0H4MGoeW97I3wrLl9T0lycgWWIDJEfOaAMdfsLe944Pljb4Oiw5ULMt3wLmlYGiaSfgQV/Gp7ZPWtPcpHUaWA8GTYXotUtC5eydrWfDVCvmxQgXtc2nUV4fZgvbvnUub1ZnBuT+92mueSKXHl7+QezI1FiltzFcXKzG0F/HuGzBWQeuUMYYlbOyidAeO1ew9wtAysUGqnZyQm0V9LCnFB7Z+b7XLRVwp42AtfxGzTsAmOzKdj/vCeBGMGnAhZyY3LRkodZCjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCAv09xVZOcdkSb+50x+/l2yVZCtH39u0iQXjKSqLso=;
 b=WbGDasrLbNkqCyEPxa/H3HhTTrc/gRYAka6pUHkxTC3CXYcWH3VxxmUF2wPRnAT1PfTdMXdBeW/0RP8dN1edF0eeyO7NTt7gakgUB6O6RsW955vFJ/gvcsKhED5i6/SipBQTcRIBzUb7urqkBugIe9xk7MjmqeFZD2nmNHxmxybg6V/Ef0oq4knwOWbVUqLxE6Cw05K4MN615QoPO2IZQaVlOVKbpAUdC+wdq6qmoUHgwjZ4xt8C9bPVHGwqGQxLSSSx35FKizZvgyGpOSJw56fjH1nOoI1KjhAOubXupmYgDoxbAHwWReOMC5mlX+EJEpPAp/Xv6bOQ0S8eEsQYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7380.namprd11.prod.outlook.com (2603:10b6:208:430::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 02:12:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%7]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 02:12:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 07/10] iommufd/device: Make hwpt_list list_add/del
 symmetric
Thread-Topic: [PATCH v2 07/10] iommufd/device: Make hwpt_list list_add/del
 symmetric
Thread-Index: AQHZOzoSQMv1v33l6Eyp7LBz8BGoIq7F9D6AgACo6ACAAM2SAIABSPOAgAN3GSA=
Date:   Mon, 13 Feb 2023 02:12:49 +0000
Message-ID: <BN9PR11MB5276914C26D3063AD77DDDD98CDD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <9d0d4f935c4972771f5aed4b4837d8ae35814e06.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F36D2F07209AC7155BAB8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Tz/kkZ68e9QWR/@nvidia.com>
 <BN9PR11MB5276CA32940B6886F8238FA38CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+a0YUwd+MVMZ1dN@nvidia.com>
In-Reply-To: <Y+a0YUwd+MVMZ1dN@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7380:EE_
x-ms-office365-filtering-correlation-id: 00bc607a-d194-4b88-aa06-08db0d67ce54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2QZUWCuEGRigKFFDLYA04eVIX83woU70RehKWlDMC89+ZlukinmPlt9q4fceGT2002mZ1n7v5/Zid2EQIerMKYfoRUdoZKOL5iTA2DsfNB0ii4XTPRBPUnrI3MqTV22H9OhNJrwzdXE9bVfjb+OgGHAOwAj+DMIPZCFC6SYVGzy8BMoE6Vw5yl8iB3yE/87s2AbPhbt7rqp0eMoQGmasccICLXc0DClIBJ+2vD74AKDuySIZXTYGACAHLAP7IIqPeGvUf6G5nBxf904XvLksH4jARfDRcjP202Qw0uQjmMkCn2fz3DW3+sX+CpdC69/RhNDT/cU5agftScnjF1qfAPAQVPhS4uVQ8FKG5WW2pHBmta8CZToZGsoLP75ptPlruzkz5DWsGvG6mRbNGYUH7rE5q9qqqil5dwMKOx7F22G3HB1nrexT7/XPg7vu52BoiZVxfsNrj2eD7UdiWD3shohIDc6bSJWAlGfGK6301vBlzrezX2WJlVVX7HtTXDqGGw7B5HFor8Ty54LPs3NJHxW3J2+zvyoupXvOndw9K6tKBQ/wIqBEL2Dl2oVXCmGHpUFO1/jBNwFV7tTKJMTxgXlo8gDL5oN4bjz8jztB+AXKZbK2kX5fYneUU7F68s6IVBAMeSzfe7LaUnEc3BBABxAekfRMTRH8kh78n0T/Be0DTJ5g4V/hnTjgenwFFF+rbPjQfNUQZTonNSVnb500A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199018)(86362001)(33656002)(38070700005)(55016003)(71200400001)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(4326008)(6916009)(76116006)(83380400001)(316002)(54906003)(6506007)(9686003)(186003)(26005)(7696005)(478600001)(2906002)(122000001)(82960400001)(38100700002)(7416002)(5660300002)(52536014)(8936002)(4744005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g/iYpl526boituLCZmJvTeylTx9UZFMLjSWxtcpxtiQ4T4InyuqdxOceLmja?=
 =?us-ascii?Q?WMqnYyrHn6Ie+8RSroswt3g5szQJg74YU/UTp93rKwWMGQwX0Po710zs+dRQ?=
 =?us-ascii?Q?8LwGGHjRBq8cjXpHXkNVLVAe6V00dzu7QIlxSKBwvIOIm2zY/LBf8Suk8OBX?=
 =?us-ascii?Q?SW5ufmfQHuFUznvblqtfroKfAS27coF0+Gm7tIIjjy6cFmhmld8vUmGJ7hqo?=
 =?us-ascii?Q?mduUoKe8XUI6RFg5jfMNfxUWZPpw6pQWcO9aZ8TlVH5XQEkx50l3z+jXHcAt?=
 =?us-ascii?Q?i2Pie75nuQpiPdSYa42Mz1vnZypYirLnirnoaXrg9SPqzdVV8eTAJhj0X6ia?=
 =?us-ascii?Q?M34C9+oR+b3noGPu0XdZzJnaCytteJtQMDf41KDNSJfNUoNa8lYnbAhPvkXb?=
 =?us-ascii?Q?5i/RtNfgxGzWmfJ6kJDU3AclDT0FKlZHovnGV1uPxJ/KFBUKR7FKzYTGi0pa?=
 =?us-ascii?Q?MRVaaxA0s75SbuZ9Q2DoUiqM0a8QYNfHTxIbVT4dcuZik1VU0Xt31PWlIvev?=
 =?us-ascii?Q?fC5NcuOhLWolDqfFr0oTDKFV/rgcUTxVZVZEUO9TKIk40vNYktOs0K3j/RzQ?=
 =?us-ascii?Q?FqxgPmXhVOvb//HpFviBRvO+/gHhRpNm7uY0knN5ss8fbmtnGbAPbUTj6jUJ?=
 =?us-ascii?Q?SmbWIJU3uGq5Ci59TzXnRBUxQzSEedqO9caAkid6UwmWk97lS3DE27YNG/ER?=
 =?us-ascii?Q?Y+LCEIGNa2DqMI/pvrDPEsKKEam1WLter+7PMrLsHYz8HIbh8oBXVkODp+Og?=
 =?us-ascii?Q?zyGtZgzkD+P/PRxriMs4kcLTK9XdbVQpBTOyQVMxyj+KK6DXx+YoHzWWNWof?=
 =?us-ascii?Q?Bkwu8UZwyYKz98Q5lQQlXcWJ2l/fWwgydTDhXIxWoagiu4jCyyk9FyUdbDmd?=
 =?us-ascii?Q?AtfA4XGJ5nIikV8bzbSVre1WbWd2B112ZjByzRvz5KaoTaBUIr5h+Oak5Bg1?=
 =?us-ascii?Q?G3PlEXbYKA1cz+zNHmioD7hcdL33QM5MyYkkKFbN5OKmXI1fNrd+OtELNs/R?=
 =?us-ascii?Q?Clfyqyv4rugMRiLAf4Iij+yrQG6gs5RgDDVnm0RwGOs6/7w6EOIRDpJAJcMJ?=
 =?us-ascii?Q?9Pk09nPKbehUBSgfmrokVWM+xVUi1NzFeWa3lPVAf099P6G4BwHX4E25p+6q?=
 =?us-ascii?Q?18yzy1jmbkuXV6FTrse+QLsPuiS4RRT1U/pkVTxXlEV6Y3q/QvJcmM54eexH?=
 =?us-ascii?Q?rmZsuddB127OB1bkkZjqBz7eEO7YXgIbXsySvGfRH8+GjvHCzw4dMiYeLsBp?=
 =?us-ascii?Q?tx4LY0+Ib5xLr/21G5MUeyvoUKzOPxNo46tNW3rV1b/SV6gO0ZS9V46iovBp?=
 =?us-ascii?Q?rQKfHWRYnpYWk9wgVLIqBrCzdFC3/d03zORzXSQngbhFtkTKP5QGl/1x19Ft?=
 =?us-ascii?Q?RMFwJrYzCZFBJ6x+w+dhJAEocz2/1aPL63/W/i0miol4NGmFA+hw1waVPBr0?=
 =?us-ascii?Q?paTHCjKtfBDQ7ZqWuuCOoVju6VXtlTyy6OP6U9SmccMu4v800KYmZz1pKVLC?=
 =?us-ascii?Q?XZeLdq/eAfTGQuhDHLK3Tp1/bq8l4TBmGaWasq4sEiXpYN7KezU04+ctU7nC?=
 =?us-ascii?Q?MsxexP6zsi//5kzF6/cZkWm9IsfmkjVvWgl9Vtm2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bc607a-d194-4b88-aa06-08db0d67ce54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 02:12:49.7348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVB77lsOKkfJYwc0Qgaiyuh8Nog4MV0OvyvwZ5VUCoaZEQFIqGJid7xYpJyv4acVqdpLaBcKDYjyGoiPX3wMaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7380
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
> Sent: Saturday, February 11, 2023 5:17 AM
>=20
> >
> > there is semantics change.
> >
> > here is the current code:
> >
> > 	case IOMMUFD_OBJ_HW_PAGETABLE: {
> > 		struct iommufd_hw_pagetable *hwpt =3D
> > 			container_of(pt_obj, struct iommufd_hw_pagetable,
> obj);
> >
> > 		rc =3D iommufd_device_do_attach(idev, hwpt);
> > 		if (rc)
> > 			goto out_put_pt_obj;
> >
> > 		mutex_lock(&hwpt->ioas->mutex);
> > 		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> > 		mutex_unlock(&hwpt->ioas->mutex);
> > 		break;
> > 	}
> >
> > Above means every attach to hwpt will try to add the hwpt to the
> > list tail. Isn't it a bug?
>=20
> Yes, that looks like a bug..
>=20
> But this patch isn't the right way to fix that.
>=20
> The HWPT should be permanently linked to the IOAS as long as it
> exists, and the linkage should happen when it is first created.
>=20
> So attaching a HWPT to another device should never re-link it to the
> ioas, thus delete these lines here.
>=20

yes, this makes more sense
