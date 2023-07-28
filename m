Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD1766315
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 06:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjG1EXK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 00:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjG1EXI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 00:23:08 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F9DE62;
        Thu, 27 Jul 2023 21:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690518187; x=1722054187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DQDUwb9rXopIZLh+iwYeQ2A/O6nkL3Wxjs5tP0+80vE=;
  b=Io+8Pr6B6tY9p7qKkLbqij8VC7IjIdyv5gRLglz0EmRDQFuFp7CYO/vY
   InrSPfuGMDmC5Dv9fKzS0x/sFs+14E3Ulz2GEbE5DHnN4rcp3NxE1RDpl
   gnZcJLl+uUQSjfJZnOQ1+flTOriuFnNV5nxDTaeYaQvYkUvVIIekNLuw0
   aOBdzc9p0KvILPFh70H2HFom0aazuK7Kr6n+rQCfKX7oMUGcsvtQK0L4o
   z3JjAq5Bucj1Ijm2YX3NRyojrwMubaTUAalAu0B3zh56fwUPH5wCfgkcU
   Ei7vTZPk37MeXTf9jn3Tem3FAMzHAg11LLlQc4Z3EshFKdS11vexHV+lR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371202438"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="371202438"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 21:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841119385"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="841119385"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2023 21:23:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 21:23:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 21:23:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 21:23:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 21:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXqqRIvJTuFdAB8FLUhS2ekCE1y07/xpomjsimV1DNHfTjVxwlETIH+nTmkLWRTzweKDewgIDK6MQedX93GIkaZyC6OqMmYniLKQg3ExTlKTUYbL7QkHQspfnvyw61mgXKrvt2ZEL5aSyQALTDVZ+yNpbBcrmPvPyZ6X3FcPLcPoVYC50iZmzruE3McWa9cSOQ4QqcHxKWri/ZOuaKI4O2CTUmO9bFV+Tbx0nOqSVrSOsOFONe/M85878gsBLoEvNY5F2vy3DKLdUXmnb5BWyY5aUyFD8ZY5H5gbo+x1EitiHQ32Ze4eXUlmIX1iZu36uVMPRZ+32WGVL/AjIt7cUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpe5F0TqtWUUYQjuBY4yFaPjJrCiFnkJOBlykfGoLH4=;
 b=Qz6IbEf/Af3OLD2QJVgxQvI86yqkFlebV8W1KEx+G778WK2UJOzCCkf2QxfTMiTULdzFMoB20iRBbUf+4QMrlGs6omhMEzSqeDQCpoWVOFe27rmH49WEbxAeuiBa9nlAxl5r89wJyvzCO3rtPNQ24KUuDctQMMdTGC9r2Lv9mwhhYmyX1SUWohbESYewND+n/bGaVZszEX2GhBL8F/lBOB8QxJx5uiG+Rf3o5y/PfdAL+/d1YbazR9+0CrTD3Cr9YSZN2ekktSi3f/dmU7Qe01aklVgE6C8qX5SO+c6hwz4ceEX5Ue2Re2qMRs72/jzCT4/rrp507hIBLEcq/faZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 28 Jul
 2023 04:23:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 04:23:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v10 3/6] iommufd: Add iommufd_access_change_ioas(_id)
 helpers
Thread-Topic: [PATCH v10 3/6] iommufd: Add iommufd_access_change_ioas(_id)
 helpers
Thread-Index: AQHZwMh6JNYyFoJVN0+eOwrrdrt/qK/Ok45Q
Date:   Fri, 28 Jul 2023 04:23:03 +0000
Message-ID: <BN9PR11MB527660F2932964A47396D1E88C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1690488745.git.nicolinc@nvidia.com>
 <ad75a1f7f0b4d5b6d35238b4ae7b41db1410110c.1690488745.git.nicolinc@nvidia.com>
In-Reply-To: <ad75a1f7f0b4d5b6d35238b4ae7b41db1410110c.1690488745.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4653:EE_
x-ms-office365-filtering-correlation-id: a4c75e89-c8a9-4654-bab4-08db8f2255ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBW6+KlAjZ96H+TK8/PWKKmUCMC2j0kQmKmRxzZd6RiwjN0jbg6ZEnxcOu8uU8XFh5uAgKaEyom4zuAcmXVfedJeJXO7ZbtHsTqPtbWiTrbRCvkCCg/NouL8NcsrBJIPCSGFBrI/LURybmLGJ/UEbMSkis6pBkT3upfkKT3gP3zqJjVLgc1Wi/dJcJy59oGa28hdlxCTzBiFlUNw8nOVYHZb1CpVDUUFY2KbvoUtYFQ6Mq5VQReGBXSxX4xkFn36j/k2sKwXfujTsAZ4DPNXw45/uBEw6pKoUk5I/J48YtjbPYtuxYL+X1tATONenF6mt2FhrjQvFj/JqxyYmDVsMiOgDFjD3EzC2AhBr9qjqgzf0LZpYEI5u+WRSPTQqECmOjADzxjLQZBOenPHaGU2biobwel0YTeTPFkyqpLHUYmX3c15Lf8N8iV/gpixybQjg8V2EozdirPRjaST76CasiRwHgN1tKQlkK1zpJrWFZthuSOzhNbFAXQq8qs53sPK5GNR5oP9L6ff7chgJHOrM4L6RMdj6tziEqNBzEBWGAaNjUA0jXb7BOUgaonrRYctnQy6+MNCYTrtntnyLVKDfgibJ03UkoMrAqyUBFf74vm2/Yz3bI/09PqsZYGK93bG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(55016003)(110136005)(4326008)(7696005)(41300700001)(122000001)(54906003)(478600001)(71200400001)(9686003)(38100700002)(82960400001)(66556008)(52536014)(8676002)(316002)(66946007)(64756008)(66446008)(8936002)(76116006)(66476007)(5660300002)(186003)(83380400001)(6506007)(26005)(86362001)(2906002)(33656002)(38070700005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JUqG7Qlc3v3zgI+Ohbh6gOxscRaXYb85LMmyK/6khFnrtB6vi+7Xu4Qu9FT+?=
 =?us-ascii?Q?p6G4S4KkUglkn7Qw2+xQ8sShnFCxN//H7CYQpjCbut7J9aNOQtiOx0tKX0Iw?=
 =?us-ascii?Q?ukevpOROAm26J+Pxr4Ce6car3cokWwoBQU0v5nR/r2TQ5yIAgxU2Y7F0zQSj?=
 =?us-ascii?Q?GH1XpCNlplQxRA9P9WUWVuK7R9LQPpIl9EPYv3zzoD0xeGOTtkqby8QUA5DD?=
 =?us-ascii?Q?0I8Kcl+X6igsEdmwjZgAKOqi1J5tjgPpPr8hzJo82ib2Rm3fH5FQjRRDR0K/?=
 =?us-ascii?Q?yyiT+mVFfg+lWY9NV8+/N9EHAxYAXDbPXFIA20BJ3YtHE9O3lsdKI9CYKhZs?=
 =?us-ascii?Q?eFXKZsXizaQJcrYHyTmuXAMGC4Gid64Pdhsvxn2AJxxaaWuswL183QZ89CUK?=
 =?us-ascii?Q?6lY3WsRv2QfAppKGGbiWQVoF65icnkEgjExJfMbkzO6nGIe2n3SHMdvkp/yk?=
 =?us-ascii?Q?PMI80iFsIsOJzcnfAnkrncuAo+W9Qt+v43ZPuXCtZncv8JOt3Ku3LQcKHKlV?=
 =?us-ascii?Q?1ptsN+eiWXlbf1pzNGAvZGB+/Cj34qOVbqLY4DJX5O/gQXxR+0pdnMZvktm7?=
 =?us-ascii?Q?sWNUZIbfQPDEvm/r1hGEaRAbsyB03x9LCBCxJKRCfkGP4ywNYq0AqG97lM1+?=
 =?us-ascii?Q?/VplJ/aQR2kiW442EoEGBN8wD42yz9c/idfsEu0jfswYud7DL5gtQqfn2fOL?=
 =?us-ascii?Q?LuMpSUScaqd2SHI2HB8ryYo0SIiqZ5xbOI2C175sexmZyof+5rjkG+DRslNR?=
 =?us-ascii?Q?d+hCGGn8c3BQGoDtxnD4lGT8vJ1MNPnflpaxC3bB/24MnoDCn0ao8EUn8q9J?=
 =?us-ascii?Q?7Lru+jf8YiCQ9iy7FhOI0stL8U40xvne6v+bqmBYeZCDxW4Jqv1IyDZmYoQc?=
 =?us-ascii?Q?tu4fnuZzPzgcGVw1vKJgczgjQg73sIErMn+70BeW5VwzFEh0r3P0QWGp918o?=
 =?us-ascii?Q?IbeTadmZSNySU0JJzQ3nFj/PYCBkngC8ETgHFGEkKgg+L2LybvPn1cQab8Td?=
 =?us-ascii?Q?BePokUf3ds/vTr3bEUHyT4W4+3Ji7a2OJXrlYCdt51ApriiSOVBK9iAU1ilF?=
 =?us-ascii?Q?JouZT3WUZoCxVEFvvi6ckDyQBa1NDfrBZeSBNdoO2bq/esUVAOXi9I6KRVRh?=
 =?us-ascii?Q?iEvc86sG8Yc0Y5aX4wf6iWGITVAoe2Hw512rezCudvJTvKFoTmG8ZgVigQRI?=
 =?us-ascii?Q?apkACbh8vhWzLI5pNA+PeCz+7kLMWkTIHWdRpEFbnG3d6g2j+IIBOXaBbLFb?=
 =?us-ascii?Q?hlewYho93gNjWjaC5sL3Xsw5eOhMVD7l2xp9HOPJiGX+N/mkqf/O+86SVNNj?=
 =?us-ascii?Q?YJ2NQaLEC185+I+ZBKj4z1S59EcWOUg7e9o/n1oYCjdbU0Mn/ZvngH5wr0bi?=
 =?us-ascii?Q?2d6r+HtWDweTnfsLvj/yLlMTLZOIB8fChDYca/WaRbzzr5JObQZCKOeafkCW?=
 =?us-ascii?Q?VUzflYt602l4aort/kKnFf/D6jVRwh60eGMEDWoskibYCY59ytFJVLMT/mp2?=
 =?us-ascii?Q?MXQRlfVIat7CvnOC9xQbD+LbbWAgPBXeYuVRN0yyEMrORx0fyWQJajcaMqpo?=
 =?us-ascii?Q?hay+XIt1V5Nemg/KXrQJrE7LROybsxB5uSfWf/VU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c75e89-c8a9-4654-bab4-08db8f2255ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 04:23:03.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vd7Kaj+0ugGxA8wotikf5QhWcCNBS+IMvR4vCpjuEkf2vVwVD5GMlDJ8Ic7J3FZ0bbEcDpQvrb8ZJrvIp9TMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, July 28, 2023 4:25 AM
>=20
> +static int iommufd_access_change_ioas(struct iommufd_access *access,
> +				      struct iommufd_ioas *new_ioas)
> +{
> +	u32 iopt_access_list_id =3D access->iopt_access_list_id;
> +	struct iommufd_ioas *cur_ioas =3D access->ioas;
> +	int rc;
> +
> +	lockdep_assert_held(&access->ioas_lock);
> +
> +	/* We are racing with a concurrent detach, bail */
> +	if (cur_ioas !=3D access->ioas_unpin)
> +		return -EBUSY;
> +
> +	if (IS_ERR(new_ioas))
> +		return PTR_ERR(new_ioas);

iommufd_access_change_ioas_id() already checks errors.

> +
>  void iommufd_access_destroy_object(struct iommufd_object *obj)
>  {
>  	struct iommufd_access *access =3D
>  		container_of(obj, struct iommufd_access, obj);
>=20
> -	if (access->ioas) {
> -		iopt_remove_access(&access->ioas->iopt, access,
> -				   access->iopt_access_list_id);
> -		refcount_dec(&access->ioas->obj.users);
> -		access->ioas =3D NULL;
> -	}
> +	mutex_lock(&access->ioas_lock);
> +	if (access->ioas)
> +		WARN_ON(iommufd_access_change_ioas(access, NULL));
> +	mutex_unlock(&access->ioas_lock);
>  	iommufd_ctx_put(access->ictx);
>  }

this changes the behavior of destroy. Previously it always removes
the access w/o detecting race while now it will give up and throw
out a warning. While I'm fine with this change from bisec p.o.v.
it might be good to split this into a separate patch.

>  void iommufd_access_detach(struct iommufd_access *access)
>  {
> -	struct iommufd_ioas *cur_ioas =3D access->ioas;
> +	int rc;
>=20
>  	mutex_lock(&access->ioas_lock);
> -	if (WARN_ON(!access->ioas))
> -		goto out;
> -	/*
> -	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
> -	 * iommufd_access_unpin_pages() can continue using access-
> >ioas_unpin.
> -	 */
> -	access->ioas =3D NULL;
> -
> -	if (access->ops->unmap) {
> +	if (WARN_ON(!access->ioas)) {
>  		mutex_unlock(&access->ioas_lock);
> -		access->ops->unmap(access->data, 0, ULONG_MAX);
> -		mutex_lock(&access->ioas_lock);
> +		return;
>  	}
> -	iopt_remove_access(&cur_ioas->iopt, access,
> -			   access->iopt_access_list_id);
> -	refcount_dec(&cur_ioas->obj.users);
> -out:
> -	access->ioas_unpin =3D NULL;
> +	rc =3D iommufd_access_change_ioas(access, NULL);
> +	WARN_ON(rc);

'rc' can be removed.=20

Just "WARN_ON(iommufd_access_change_ioas(access, NULL));"

otherwise looks good to me,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
