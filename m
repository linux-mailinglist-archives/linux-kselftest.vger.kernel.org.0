Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF876905A
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 10:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGaIif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 04:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjGaIh7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 04:37:59 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639161B2;
        Mon, 31 Jul 2023 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690792528; x=1722328528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rij/ajlVsZYhCrmhIM/f0Xw93aUlBZOXoWxzweeoSsU=;
  b=VBHqs4zrwP+MUnqTTdJqA//6HAljVLpoPAESwWMXbpzBzqdNvygbVAvN
   x6hSBdOp0iPXh2HDaA6cflt11jTsCgvsXvbdqoIx725D8dT4tPEiyP6Yx
   wE1WNng//0V8XndyL7v3nif8cKyjbKpCYfa2jDKLwCQrXyx50vyqWuSHu
   OHhAaQer2MZjK30Fch8BNB6yAKsk963KpEEja3clVCvRO9SWn5gk8EkWQ
   HViPduArF6Ym9vuDz/4HDLnMAae5m4cWE/kWuyXb4NoEkoUyotVisQDGU
   SRyEc65EwGvlyKws5e/6ki6RHHcpbvy2/L7VH8Lem+Y7n0XQWrm2JhpIE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="372585969"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="372585969"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871579974"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2023 01:35:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 01:35:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 01:35:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 01:35:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 01:35:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7AzqHJH3nT1Z1AaRHugc4bB8ZUHwbE/G9+RUJn3t+0oX+i4RwsnPCFXI6pvX7qAfDXpipZjSXFkMckyww/NOsf+EFToAKR28VV2wupl0gc6oWoV6Qszn4tf4+l1T2QwLbkJyr/P3JZ2bZPCrm4PN4nqJEEKCv0kMKjCg00hPnIgi81uAP2oy8E+kLFf0d6Ovk+k33D/m2VYhSMJ10rwEIn+aC/ChlRoGtl4UkUHclJNE3E9PsDWknCfTa94NyeQeuJgTmgFJkbbokSRXXEYztTBI6p5i26RI8Lrf+KhlHWSxRMyw2ycKjYyvLajt0rQibytT52IRqYr/hmlSR3GfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBmx2adFJPOuzOO6SvHkoJ2RhcSlTetSIkV/7xf/XNQ=;
 b=jjw2PoOMQQuZ+5+++Nso6JNX0yOTJA0sTLO2YPenlaECRUjRB3aScbQXQa5mhgw2qDelXjEN84ageLgAIKQ9JZZ7A1R2nSs0uKRRO2qHtWuJ6DxhSkBaZcZFP8cjKgbZuKM+kLuFUm+sYkKx5jEKNS6cKXOqkSRn/n/MaN4OaQABVBHNaBPI2TRbWEMrmUQBQxSPvKI0NDM1Lvw+DF8QXD++++tFhAl4Se0725SHpYTyaaCUngjye8Q4tXpVOeQ19Z+pPbhqji9n2S692vtNvvcECyB7yk0nUxTelOyeQVgwk6Gw88pz5B0iPIST4NQp/zCwLWW0mgh44DW/zXFnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 31 Jul
 2023 08:35:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Mon, 31 Jul 2023
 08:35:19 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH v4 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Topic: [PATCH v4 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Index: AQHZvh36uTC3+O2tJEuGe12u054rdq/JMlSAgAplLVA=
Date:   Mon, 31 Jul 2023 08:35:19 +0000
Message-ID: <DS0PR11MB7529D67A8A3CF78FABCF359AC305A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-4-yi.l.liu@intel.com> <ZL65z0i8d42Try7a@nvidia.com>
In-Reply-To: <ZL65z0i8d42Try7a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|IA1PR11MB7365:EE_
x-ms-office365-filtering-correlation-id: 40ee5040-2ac6-4d55-d51b-08db91a112f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+GYfvJljbUWlfj2+Bz+GHfdnYxOti4XWvcdx8BtusLuJi/1Cj3snIj1sdqPwSRGWmbLx1ylE5AjZ6kZTzqLviwVXYSzDOvcodR8HRDWnGvI8FetGPIyUo4FR59LRLJSUkYzstOJ8jmqn7hsIzUQ86g+CqPWq0H8n+xFaTxFNDlL9UirTu8p8Pr5ldiW8RurFgR7PoIw8byOjiXT0v+umbjF28LLMfM/w5YWsIZpPryiRDznyUGolZ7iDyQOrRdkOV5gJM/o695Q4+miu9z8qGocEm8V6xu+84vNytrm8gkNyIfByt08zApHwU9keQNqrXPXrm2sE1qp08G854ADSl2EGJ8JvKQKh2RhMMYoge1XyzVAIYWSjkc48JxbaZvssseKnIS247SvlDFLFLKChQWFzPwGkou5AsfYnRDK8M5MlmpL6ReHbZ7qZwngW5sI/3IUo052Gne4hAHHx6dUi0i3EUczrdXJbbliC9Imtmo6FuG3Na9c2J978THA+DbER53xDCmRvNd4iw3HJ/A9UP00L7SpfCl8EAV1kuBZUYewYCGegZzv8kbehqrYHZMDC3ys3+IjGzni1oAHFF+WOPEHQoEmphsSF3kFD9uzqxdLU9XY00OExzkFndVTB+iV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(5660300002)(66476007)(7416002)(8676002)(8936002)(41300700001)(316002)(76116006)(2906002)(54906003)(478600001)(9686003)(71200400001)(186003)(7696005)(6506007)(26005)(66446008)(66946007)(64756008)(6916009)(4326008)(66556008)(83380400001)(55016003)(33656002)(52536014)(38070700005)(122000001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DCOo2Zt6g+pnkhqgsgLe2zKKSrXB29jCKPl3jh0G9q91zKPuDA7qdP+wMXCl?=
 =?us-ascii?Q?rKzxfdnl0LbnfRARbosWXKgLExRHMnkGUk9w7Z0T9k3pYEGLW6rvDwIxIGsx?=
 =?us-ascii?Q?4EURCQCINhwFFOy7mUDUY08uQ2JLwcyuDgkWuEvloqyH8+I97jgGRecWgxuH?=
 =?us-ascii?Q?K2IHtKU1zCiF9lHuXmIE+b+autDdKmMWEtpj/IJYs1w+9AVlNYhld3kA5mCA?=
 =?us-ascii?Q?F03G0Qr65XHP9vSk0/DgZHyp/ptdsE8HqjwBnG1aeQ+5BX6L3pHerLab67hI?=
 =?us-ascii?Q?jMIa8MUVOj9ute5wJIdzltsuuextJNz3ssN49vck8fzjuYWVoe7CM9NHCAbD?=
 =?us-ascii?Q?S8NaUUPdRxKqt7nJ3Z3W7ZXSJaThuW2+3amMastIqzhx7WsCvKijaVcEyrlm?=
 =?us-ascii?Q?nd63G0aA4IJXPYQqzITWo2f2MhKoFF7QRM/CWAQShPC/6hlpEUTKCHOcxPCs?=
 =?us-ascii?Q?4v2hEDZ2yben23Eh3ZRYp3utbvIvWNDFVcH5LgmkmQl0+C3/t/UOTfMPv141?=
 =?us-ascii?Q?/j4CuwEg7OCln5FAQM5+wZm3SpGHxUsHaRBw+jcBRxV8BPlfp1odzI5uOcRv?=
 =?us-ascii?Q?EOfyuf/uFWEwxiPfM3LAoTvRwKOjnp89rg10pEpEQk9xrFkSLugAiPwlXWTE?=
 =?us-ascii?Q?gm4qPvqD1NjobXIze5i+h7gdk6op7lu/vILsw+gVkpXp3m9Ju3Tc+6ovpmXv?=
 =?us-ascii?Q?ehGE1nNN8ZlFNoJXTvZEa1jwOIOPezoAI8IdZm8wZInvRdMBxQH3ht4HNh/d?=
 =?us-ascii?Q?ZI5ixG8heyZc8QkwjKsiPgd8Vw3dQ6YwKFbaY+B+VZS6mkF37cKkchib2UE2?=
 =?us-ascii?Q?efWsYV1nqbUZuHp4gOj3kcA3r4bYTLaDroBNx/biDKSKRHqfAR8GYPL8YFml?=
 =?us-ascii?Q?P+41x2s2P8M4rDvNr2dL6zLZGdylIrzhztP+X4Q2A9HsnQPZXZ09lIKJ4P2k?=
 =?us-ascii?Q?i7H4jR+IgYKjHER/YSixOuXLc5JHyGPQ08CumnQogAdsW1svHZ9AmN/aLkqU?=
 =?us-ascii?Q?Tp1gl04yNgluFueIg7vHeBTVKMZ0UWspRS4p9CWdvgdk1NieEa9XA3SjQqV5?=
 =?us-ascii?Q?99yVUlsugjlFdENZEKtwCmhUo5Jzzct9ysfLXxpyKKwyRPzS3Ep15Tg8LN+I?=
 =?us-ascii?Q?pERYIWCioPYwt8/JIECQog9uPdrtVlG1r1eXwVsFOc24k8LMlaPZycC4nw+R?=
 =?us-ascii?Q?HVbWIjUUv+XUMx2Mn0M+1GdscqZMDUVwCLumyd63RFiZHSPX+wGJZAJFd/+O?=
 =?us-ascii?Q?RoGo7hQBxW/q67CjKepgnnq2O9qpZwCqhusOHfJI2IrlxBfO55YF7FEiw8s5?=
 =?us-ascii?Q?S9m4vYt3E/g93s6F6nAFcrm4nmFn/fUNzVkwfE/3YIFy6n/TV4D2AHgU81W4?=
 =?us-ascii?Q?aHdxe6eAGpV1R+TQnJTFC8RECVDzU/1wAGLfTinstOCy7IUKYI4BZNifIb5h?=
 =?us-ascii?Q?qLCIf57ol/kuA83RpGVpaevdtfmD14gZjRxTJSjXrOM4KNUPTMGzJ0S7MPUN?=
 =?us-ascii?Q?YQz/n2Rn7KIaZ8V0QUTRVP8txmnUyZEN1Q4J1W9vBT/K629Y2hBU/oJryNqc?=
 =?us-ascii?Q?NLacXbO1V/Yn1Hvi3E2d3IseADPwNW8wbg2HW3AG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ee5040-2ac6-4d55-d51b-08db91a112f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 08:35:19.6637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RF5XSfeBkKnxFTfGiaBfCe+8CkyYr+OtPa3sUQa3p5/WDfHE6ruG1Ce02hmPY8FDcfGHzTcG5Q+pDbZ0ylfEiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, July 25, 2023 1:50 AM
>=20
> On Mon, Jul 24, 2023 at 03:59:35AM -0700, Yi Liu wrote:
> > diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.=
c
> > index 94c498b8fdf6..bd3efc1d8509 100644
> > --- a/drivers/iommu/iommufd/main.c
> > +++ b/drivers/iommu/iommufd/main.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/bug.h>
> >  #include <uapi/linux/iommufd.h>
> >  #include <linux/iommufd.h>
> > +#include "../iommu-priv.h"
> >
> >  #include "io_pagetable.h"
> >  #include "iommufd_private.h"
> > @@ -177,6 +178,78 @@ static int iommufd_destroy(struct iommufd_ucmd *uc=
md)
> >  	return 0;
> >  }
> >
> > +static int iommufd_zero_fill_user(u64 ptr, int bytes)
>=20
> (void __user * ptr, size_t bytes)
>=20
> > +{
> > +	int index =3D 0;
> > +
> > +	for (; index < bytes; index++) {
> > +		if (put_user(0, (uint8_t __user *)u64_to_user_ptr(ptr + index)))
> > +			return -EFAULT;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_hw_info *cmd =3D ucmd->cmd;
> > +	unsigned int length =3D 0, data_len;
> > +	struct iommufd_device *idev;
> > +	const struct iommu_ops *ops;
> > +	void *data =3D NULL;
> > +	int rc =3D 0;
> > +
> > +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> > +		return -EOPNOTSUPP;
> > +
> > +	idev =3D iommufd_get_device(ucmd, cmd->dev_id);
> > +	if (IS_ERR(idev))
> > +		return PTR_ERR(idev);
> > +
> > +	ops =3D dev_iommu_ops(idev->dev);
> > +	if (!ops->hw_info)
> > +		goto done;
> > +
> > +	/* driver has hw_info callback should have a unique hw_info_type */
> > +	if (WARN_ON_ONCE(ops->hw_info_type =3D=3D IOMMU_HW_INFO_TYPE_NONE)) {
> > +		pr_warn_ratelimited("iommu driver set an invalid type\n");
>=20
> Don't really need both a WARN and pr_warn(), just keep the WARN_ON

Above two comments well received.

Thanks,
Yi Liu
