Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063BC7728C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjHGPJn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 11:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHGPJm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 11:09:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2CE1BF7;
        Mon,  7 Aug 2023 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420960; x=1722956960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bsCxadbHACR7pSUdYy4AL9dNViCS2KFxLuz2BdDsYKc=;
  b=kkVjoLEST1VwmuI+xsKe+2qgxTV0v1akOQuJMsiaW4YaFHv8BbgIggo5
   H26cKI+IgowT/vZSkmZ+MkIpyQYMOlX6B2s23ib0lplTSzF2zG1423f49
   5MWDC7sWks5VweuC7IzLsEMQs7eGQt4ssfVYpfJg6vsqPClUmzPcD8YMF
   p7ktG0eiwd4rJQA8kgLeyE10MkCFvXzzHSnB43+XF0f0I/pEYaDTzO2I0
   N4HzAHiLwyZMKJYWPWzXZT/vHTNPn07FJy0J7I+zujAuZ6y07KX7JQa79
   C97zyVcD8Q98JbslJo1KPQGWW3+cmR3qTJyg4lfD4nBklQSeIqpp4Z9Kz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360654951"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="360654951"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760528737"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="760528737"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2023 08:08:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 08:08:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 08:08:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 08:08:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLRS85Gpba1JrDwnF+ZsOIkPvmOpT6rB/O/SRSI+UCEPF9TGLOth297Z1UV9dVn2V+Ns6DlL/z+/D50o96IIfYoNIVKk34iabZdnBy+RbruzxZPZ3Z2POLMCDJ8PPit5mVGOSEZZiIb3vfepixW3HyrrzOQaxlxQSg6Mo3wd+B/80oS0p0Ml55i1DWPSl4Smlv1b5lG+Ch4T5NJ3H8upabatmkd1nzl36e36Yy6HuM3hZgl2QWzoVv+mO7wzPA0oqmP2VwmrEfFFcvA7yXC41Jfhbj15+EGFC+JrQgDif0uy4DTe4Ue8fiAuBUG2SetH6OVrJ0TPY56i5OVXZRcDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/NzRp193nqAxXn8JZZPzxcjXOA+pW2XqeRynYxntwA=;
 b=XOH3wyMN9Xj8QOxL72wi3iqTtMQM35ox6Bb2fPoMnCo1nMDPscUqnWitbH94Gz8tcqmLkpanWdwK70w2Gwz85DAvLZeUztnmaRDAFJ3T+B8LU2DPRT6ZsWw72Xw/mVXJ9V/7yTjMg+aZuna1MZlwd/OEy8GjcFJY15tgulktpK6x4jg0sBiwipIYA/9S2Dswmv/JP62rsFNT6fnHCFqyGw1YgPzlZ8Q4hmCCJhjYLVhc8kIpuOQGxgmEWZjZPmBxNDYWraAwd87HkxAJ6XMInsPTKV7qDkNck4nfpSrJd/lgazVoCPR7YW7QrpKzKVvTM2koMC0paqS4EyxIch8ujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 15:08:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 15:08:29 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZvh/uqwr3PK6FO0KhG3jtetteiK/WrrGAgAhNwpA=
Date:   Mon, 7 Aug 2023 15:08:29 +0000
Message-ID: <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH0PR11MB7421:EE_
x-ms-office365-filtering-correlation-id: 2588996b-511f-4f28-457d-08db975828a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8MX5Fx3hH71Z1nPIRhn4LJ1TakMlXet49Pwp/EANudIysKppyjv1suqgRf/QVoIolGbwJQTzW4EPKFkrQsmF75lnXiUDfelPHum63Vu5XuedcDWWpLjuQDJovjbtheDJPNk3JempRZmmpn/R8seR6MxkHsuFqEBNh/ePncARLrZ3085UvexntBcofXocQ0VNGOdeAY6yJHpPu2/XOomiEZlXSVz8dADZFmLO7ebiGU66+tamUWdzwJ7MWqedCtoFZA6xWU/+LO6lXht5dNAqftVzn4q3HFJj/eI1SQcDxNgietpCkU/aE+AaNgHaKrPJIMmkq8zwQyvIyeE+xK9dQ4NavnzgKEmWx5fMJnQV1VtFinwfKuo2XWExPN8fb7/PbvWwAqyx9RVMOp2fRVAvx93kOaRiqGET2REp8n97PY8gkTXTNkl242tPI1y9l9961uUYOxlv6f1ZrRohHrPyW05fPn3CBEvzBDR83efkUBxQ34SH/lAx35BgxTBatRwI5STQwxj6jdShehS48bDS0wyMUEtHnvnlkhtNk988JmAE6w9jUx5aTSYoOLTfz8836ihXR2rBvWU1Hp9LR4siVs0GYqjzqJ9zYhivXRgK85PiJyEz0Ajonnae6Py8/Un9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(396003)(136003)(186006)(1800799003)(451199021)(7416002)(66946007)(66556008)(64756008)(76116006)(66476007)(4326008)(2906002)(478600001)(66446008)(52536014)(8676002)(8936002)(5660300002)(41300700001)(55016003)(316002)(54906003)(110136005)(86362001)(38070700005)(33656002)(82960400001)(122000001)(71200400001)(7696005)(38100700002)(9686003)(53546011)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mtlzMzZkiEd8shFKPjZOQPlgF5EXznScqm6RMfIsrknOHAO+fI/Movck2Hy+?=
 =?us-ascii?Q?GwClwNOnHB+x2UhfeIXFler6lRA9bXy8BPrD81Rl2oSYvbpvG6AvUAOvw8zX?=
 =?us-ascii?Q?zo4m+12/mbN1HSTrHcWpp5g2Uf4iK0MdehtuWNFoc9Kc0LV2E7ufLs8SsccY?=
 =?us-ascii?Q?RrIng1epjUK3KjzhbhnqyJBV9icX06p1VI2I12eASDIm8dWgWZKBCSYSR5IX?=
 =?us-ascii?Q?WsckPwHnDoRrIjHK0joRDgAxZkdhXrv/omsjrGmFxXn8elACOZiDvk0HpxYj?=
 =?us-ascii?Q?wK026B8ErXZt6E7yGrl2zPDQ81776QnLMnn6xvN4GY3S6PczgwtLMcrPXvxK?=
 =?us-ascii?Q?Lg6gvgsqcW8yHzNkUZShn6CB/13WfiG9k5Hba/CFojAT2A+PA/s+N8vdBRl0?=
 =?us-ascii?Q?nBNFFAdGm2tHUlthppViy4wNTHXiICAIHrcJzy3Yopfl2Jlb+HDAOMZqwIMp?=
 =?us-ascii?Q?3TqfcFXAWNVF8VtkTOx5xOLKwk3E7meHa8QxqdEaz8yjv/3kEpa5YYnx78Fo?=
 =?us-ascii?Q?m9qd7jfYAC1s77eveH+TviT5lkyHIc/4mYaHtd7WXo/T+GP1A02SjkaUXeHW?=
 =?us-ascii?Q?AgtTnXArVE1CERNTxBO/Xz75UFpALK5RvX1MCQ5iTWoqmaBxW/V+vjxKCcX8?=
 =?us-ascii?Q?JbEbya9OA5LwNsEAIphYl2mX/p6fEMfmbI3DE/VH6yUPF+HKSnrML6ldHqgJ?=
 =?us-ascii?Q?OisHRQEDKOl2w9hsgl9nlzsEJUmKvC0NtFghTBSZLvr810HO7TUXblVZKG8D?=
 =?us-ascii?Q?UwiGmF3pPK5JLKJXCW0JBuizhf+c1o4cXCRqe3dBm2N5Va+jzdt6vHATk3mC?=
 =?us-ascii?Q?0U6AEVogWF1ewqDOxyIRRG3FW7tkRqGiJAyXQMmC3BLQASTp/d8cwwe2qHNn?=
 =?us-ascii?Q?M6DLCCaK5N51j3V9CH6EkH42DN0/Fngi7YrzeXrTdR8icKP3ZZMQr+qwCXXI?=
 =?us-ascii?Q?e/Q5M6V0jkh9QHpGJjyu6saQHEVJzAzIf5V0j3uveNpMJUMYHMZ3TeMd7bpn?=
 =?us-ascii?Q?G9uPSO00zzH9SZTty+UfKDsmxofWi3dXH9fbPoi7x8qe593S2HrQ9eVqreea?=
 =?us-ascii?Q?VSKG0c3ZxcAZ65ndgwI9QI484Lv3gqBg4v6d7N+uJtyVllVjJbfwzMYTeWO2?=
 =?us-ascii?Q?UkueR7cVydv0RR80ekpJcPIX0/Rc/Jq5FxUspdAknaxL5F922gLVhqi/C1LT?=
 =?us-ascii?Q?09sZUX8NSJH+dtiTpzBQpBBhVqbU1B80wrZuDPRmC+Yfm6VBpCvgSRN54tJb?=
 =?us-ascii?Q?+5T5S/3HeN2RJIFQoy6PwM4Wlbfy5DRLXFbowB1BvVB+nxAR1BT6IHgijeTE?=
 =?us-ascii?Q?tuvglSjLkR0LQHsau4RATCvSeDM5gic+YLJqWpk5PdtG5RPSw0ZgGipRFP0Z?=
 =?us-ascii?Q?De2WMLb0jyprBi9eM+U6LRwbvISgHmNb/+1yC1tAqaqfeI7Pt+YyjMnLst4m?=
 =?us-ascii?Q?+pyqdWxx6pDkOye+/MAz5z0jjq1ZQ1j4kL8QyEm8p3UkltRu5eR1eQ/ae98T?=
 =?us-ascii?Q?zUyyUa0cpZH2FsqIbEx7+rjoTlu3RZCUoAhwWY6ty78KS49TP3DEJciwTg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2588996b-511f-4f28-457d-08db975828a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 15:08:29.7645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zq7t591YG6hlX8XfMCuHuGhppKSBltg1H9qbrv1wNO4ppzNwEDUaQ5YTbvoNkLXgfpJc/noE/aI2ofjHLLPkVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Wednesday, August 2, 2023 3:47 PM
>
> Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested doma=
in
>=20
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, July 24, 2023 7:14 PM
> >
> > +static int intel_nested_cache_invalidate_user(struct iommu_domain
> > *domain,
> > +					      void *user_data)
> > +{
> > +	struct iommu_hwpt_vtd_s1_invalidate_desc *req =3D user_data;
> > +	struct iommu_hwpt_vtd_s1_invalidate *inv_info =3D user_data;
> > +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> > +	unsigned int entry_size =3D inv_info->entry_size;
> > +	u64 uptr =3D inv_info->inv_data_uptr;
> > +	u64 nr_uptr =3D inv_info->entry_nr_uptr;
> > +	struct device_domain_info *info;
> > +	u32 entry_nr, index;
> > +	unsigned long flags;
> > +	int ret =3D 0;
> > +
> > +	if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
> > +		return -EFAULT;
> > +
> > +	for (index =3D 0; index < entry_nr; index++) {
> > +		ret =3D copy_struct_from_user(req, sizeof(*req),
> > +					    u64_to_user_ptr(uptr + index *
> > entry_size),
> > +					    entry_size);
>=20
> If continuing this direction then the driver should also check minsz etc.
> for struct iommu_hwpt_vtd_s1_invalidate and iommu_hwpt_vtd_s1_invalidate_=
desc
> since they are uAPI and subject to change.

Then needs to define size in the uapi data structure, and copy size first a=
nd
check minsz before going forward. How about the structures for hwpt alloc
like struct iommu_hwpt_vtd_s1? Should check minsz for them as well?
=20
Regards,
Yi Liu
