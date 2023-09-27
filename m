Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD65B7AFB36
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjI0Gkx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 02:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0Gkw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 02:40:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A26A3;
        Tue, 26 Sep 2023 23:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695796851; x=1727332851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bNUzxHCoGxrXcHq+Ppwwh0G12ejbLVbzO30yG7ZUpIY=;
  b=gcGcJuAJMbg4I6VVM+4VRLY7Tlu5ZO6S0c+xpfXWmYYj7E6055JKbXnc
   qi9lP4x83bkpH2PLLuJf1joMGITEsuNYCQG8DPr1bMJTrrnPOzK4s2mW+
   NAC5oAVPjNM/KbofQeSO8jx7FzqpkcMpltOe+j/Nzcx7MNhu5yRYJIYRQ
   STzs5iKTm6KxbI5VQ+DXBaKT9+GKib64YFZ4Be5QiZx088DwtN3KPmEkb
   Qb3YkMwtNzKLwaPwgUJJtsI4uHuRR4idp56wyheft8erxTjbJCuqv/cO8
   V8Eh+KK4RFbvdKmRXv5LbvZUROQTQmhL2R0q46sY9N2hO8v9XWfW3h6hh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385601640"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385601640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 23:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="872765131"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="872765131"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 23:40:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:40:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:40:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 23:40:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 23:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApDpu8YF95e7TJVexiXYXHA6R4AAXj8UVWZHXCOXd3YlKnsDgcYndi+vJ6Br5lcW1HFWD78MuP2Z8V9T+oaK5R2fiQzmQynjoLZ3fJ6Qkk+OHksjyVd3qMvlP8FNgkrGLRVvB8a5riV8FSDRkG+OVwbADEgHhwfCNExfiTnzM/ggD+RZvh2anO+AY7GkXYcRbsqpqB9ImUGbkXqnXbP2mH9A3OTGCUvR2YpP59d+4glLyUrNtfbN/BdZ/WJzwMSaU/Fh+/YFc+E9lzTlnDDDiZeBYbFQ05uDZt3sH4qYtwnLdZDzOmOIQO9XJQS00FiogLKu2mvkWoS0+dq9VoHdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG0w3EhYJfupBxKYMwNBlNww6gaBbb1xIJM3OTSMHjE=;
 b=mA77RMDZHASEZxfvej3PKEp3wudL9d+583E4n89mRjAg774XIppReeuiD6U7aBRxyzd7vSPA3aog+qrQTuQUcK0o6N0lyiDTDqlm1SfasFqxPliZbytn0aKv7oGDe3zZwGXq8BW3wOzgwfb+KnJmr5O98L2iLW7btv72jIVunL+L0jJ71z8VfZb8nziSDifeuwiUjJMDJcru30LhmYW1hSsMSqeCjUHTrVr+8ImYuWGYtZw8fhMDt1cmMV2YxXK2UXGzzPGIbekCIYygQov8+5xu9tysnM6OVEBF4P8Ehnht28IIbvAXchh+56Xhlkd2m98ocBKuPrf48qGD/9aesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7976.namprd11.prod.outlook.com (2603:10b6:806:2ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 06:40:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 06:40:42 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v5 06/11] iommu/vt-d: Set the nested domain to a device
Thread-Topic: [PATCH v5 06/11] iommu/vt-d: Set the nested domain to a device
Thread-Index: AQHZ7GDtob+tP6CFnEugYDjif1Do2rAuQeLQ
Date:   Wed, 27 Sep 2023 06:40:42 +0000
Message-ID: <BN9PR11MB527627C665FE2AC737AC09308CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-7-yi.l.liu@intel.com>
In-Reply-To: <20230921075431.125239-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7976:EE_
x-ms-office365-filtering-correlation-id: 4caa48a7-89c4-4abd-3fcb-08dbbf24abad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVnYW1UZsioDhdYmdzllP3zEpm9XsoKv+buDG9ksIu8kxQVA6bl0XYqMa4BMu9l3XUEsdeeIhvdYYUP6baM6VRiYfzMFx6msdmqV/t8LAqZe3LU1a1u6dN26sz5N15x/9JaYIa4jvYUi8qDG2ELVZXsT4JAyt2ZjIG7hynQMb9oMA/tiWQowuZWpjDUj32enBKXqEkDPKDzn1rnB+3aXEq+APeoEAWHPoM84ZCaVyREITmQgjEGtVPWOWXtp40tGbpswEK5oqUbvnWNDzWVwDuuH3G+k/vld3I0TDaVDyziq1U5o9LeqF9EUTl0U1HRgf10r4T6pZc3GCbG5Z2yA7eCdzMXLf7y7NBnWKhLeHwJobdwO6JKY9Rj7Fy+zd25Zmuaf6XxVbieAhMSJLNakC/5oD9mvvb05JpxR+Ecc937J7dMAh401PiXkzyIJrJup65ybBb2Yt36HBhfC79Cm4lbOg6Sgmo3/4ddCUahGIid92wUJAy55MRQi8tUNsym5XQ5mJZjrnkp2BZm2xeiSPC5HiwoD2ksme7RWsMflnnv28SWe9GzbJDxVALeCVSN9Ga9wNrdQwJXMdkQ7gdaH+PTz80xdlNT3XPRC0U13H9zv7iKAxoMky9Fm/Flc3/43
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(26005)(6506007)(7696005)(9686003)(71200400001)(33656002)(82960400001)(76116006)(66446008)(110136005)(38100700002)(478600001)(122000001)(38070700005)(54906003)(55016003)(4744005)(2906002)(83380400001)(66946007)(8676002)(64756008)(86362001)(66476007)(66556008)(8936002)(41300700001)(5660300002)(4326008)(316002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VEwzzNVAgmWVc6lDvGdHLe5A8sNAAKPO16OaOcBK9P8IBZs1oI/uOVuT4sL2?=
 =?us-ascii?Q?DF21hKFBVr+CfL231CVV8Y/aF6lbJYu2SmcWzr3MJADkacteyNAQFWI/vqLh?=
 =?us-ascii?Q?1N0hA1+XF00XjA51GbjTX2b7rbfKbx7xSv+LFZdCsgIiXeJ140IjvuGr1/1X?=
 =?us-ascii?Q?h0mzxiCAp0IuMzBqnk//kqRnNWvOuxqDekrX4Lauhnb2i1XffDM6Y4+0zvIC?=
 =?us-ascii?Q?34vUSlSwRh4ojwf6z8sYaKTNofpDczZzt9HjibYoT53+z8s/LFbRDPfPzP8V?=
 =?us-ascii?Q?POfzQKvaDlb7PkXa/KlowFreFGnYmEyVdMm7kkKk+4OLVgBh8bqAfUa4/utk?=
 =?us-ascii?Q?7Z7GZ4VlvpRU/4YzGtO8wJN6qeUm0G9KR3ntd4o60A+w7Shc5w2k6BjfLwrs?=
 =?us-ascii?Q?PZ9AY3GDEt5iSmIMqYiCzol+PQq388uIeXqV8+ePOerVMv/d+ZMc/WJa4WCV?=
 =?us-ascii?Q?9ri+lrzjZ9RAPosE6rbg7aXM73LjTrTHmg5vlOQ9cK2rOs+lBzr7B6xtWQPO?=
 =?us-ascii?Q?hy+BZeMqylBWm4FZLHwp2oilxXnsVVkFmsNSiSP554pvzfcEe7a1YGkrFxXd?=
 =?us-ascii?Q?hIx/C+sh6/RY51cJnlrtg+/clG8e7voeaWW0J3SrSK69n4jzR1mGZ7Fm1+dQ?=
 =?us-ascii?Q?T9YwvJL0M+/MAmPXT5yyFvGtz3q2XIPi8B1LdsN+ZN1GRGWng/wAOFrOAXAH?=
 =?us-ascii?Q?Q64p9DqBxiP/wrQEfedENBj8DFZj8Y+YC9t4io1ZH4yESB616LRMIXuqhnv3?=
 =?us-ascii?Q?gVXmPYv2FNhE8edJwzu3Rxmv9AsjZwEfHXdXqYie4UQiNTK6X8RI7PVL+CU6?=
 =?us-ascii?Q?JLNbfU1BB/mXbdnEFei/rfsbyUDqIjq/Bl6f9zKeBZgKgR2pbGBycfXuP35N?=
 =?us-ascii?Q?AMKcCRhE57v03VzxZzis/WqeXixIZNngpnIDE2dtfpUV62AL1F59aSb2RO8O?=
 =?us-ascii?Q?awL2wrFttaURRo87JrNU8sMbTE33YOLy76Ue68LlMg9bShg2VCScc1/RfRgP?=
 =?us-ascii?Q?Xjp+oFFBhToawx9a2MFe2FaNMvbn+dvrMOB6A9dt0y9tdexFESzfHa/Y+Hjx?=
 =?us-ascii?Q?eehV1L0ATEynD+mSC6Nk0xvPSJSE1Bv5oepf0UK2x9gP2iwvGlI24R9XZBJa?=
 =?us-ascii?Q?RRuu0w9DoIA/Bt2GXMQnY87P10YEbR2aeUSPeRCAjiD+eAOVIApSr4/JXy9X?=
 =?us-ascii?Q?lUi1UmQ92pxUD9CcZALk30timAWPPwkG33wgCztOmbiA/aS08bXBfIko38mn?=
 =?us-ascii?Q?vibTARqXf0GG7vsdf7ED0IE+fmlOhpijSCHRA9IC/bTyyub0FoEELF2yWWDZ?=
 =?us-ascii?Q?BY2YO+dJ6aH0FeVZ2K6C4ygGXNveplc2eVzSldIVjvzh3TRsYu9spM+gsZb/?=
 =?us-ascii?Q?OnunVXgLSFkY6Es6TpMEqrRXSELffpedndHpf+VBVhxXI6usKqLS1R6obD3Z?=
 =?us-ascii?Q?ifkS5Mjd98wpVWepN/Ezmfs/oZ+gXlCsa5BPH0AX+UUogvXA7awrQK/5sR8h?=
 =?us-ascii?Q?bCIqKoU/iVQW4wyVbM45PkInvb97bu2AHVmS0J3krjh3rSbcd+CLXXjCXcnt?=
 =?us-ascii?Q?NrCjhBlD/mP7Jz11eutKOmyJzvdJI4qdjrXnr6k7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caa48a7-89c4-4abd-3fcb-08dbbf24abad
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 06:40:42.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K99zx1yjDLAf4el2/IELFX6F2rZsz13m+Q6+Wb/bNkEaqyhp9HsuCHToEWGT8HwIhZLhApjEwSMLlNcLyh/CqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7976
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:54 PM
>=20
> +
> +	/* Is s2_domain compatible with this IOMMU? */

Add more words on why prepare_attach uses s2_domain when the actual
attach is for s1

> +	ret =3D prepare_domain_attach_device(&dmar_domain->s2_domain-
> >domain, dev);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "s2 domain is not compatible\n");
> +		return ret;
> +	}
> +
> +	ret =3D domain_attach_iommu(dmar_domain, iommu);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "Failed to attach domain to
> iommu\n");
> +		return ret;
> +	}
> +
