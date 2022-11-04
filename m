Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6CF619019
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 06:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKDFne (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 01:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKDFne (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 01:43:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55054DF97;
        Thu,  3 Nov 2022 22:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667540613; x=1699076613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=trqSu4uttDtLId6wzhhHnXrPyjPOvJ92u2kouTvFFsc=;
  b=jjBKBIfg57wr7ATgsrtgUhjQFP2WNnLbYrB79cVQbipXvgA313crgfJi
   9TBNrb/mNast9AjuRGC8PcXolZN4lxwBxnpFC/ko6hOuCV+87dAcvq0Dj
   RXGaDyih/cN73veQzGOrqN4ahUuCu/MLib+fGaUJXhyK34BzJSl+D7qhV
   tZyLanchvTVC9OpPJoFkmedszYsZOKdfk1IsYEO+hEZ1E6oLu+J5AJpaz
   afja/wI7fLJ4Qj7CkpxmRV0sJP9q70Iot3h/gwbHNaJG2k5QcAnUomqz5
   KhJAzkMlG/EnuqiBfS9Cv74+jnTykTyxZCocTzd0gP8u861zPYD0Blagt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="293212370"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="293212370"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 22:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="880175886"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="880175886"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 03 Nov 2022 22:43:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 22:43:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 22:43:31 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 22:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWpdZKhR26ZTUt2g3B5yc+WvztZRrGaTMm7wxTh5v9A2xcRtsJ/skyS/m/aFg0oTfBPZwjfys4TN9dmwwcTP3kAQQqR/FoKKTGl+aKa1im6lYyRWnusUhSOpVd+DUAJf+uFx/Htc00AIL0hsgv/yh0xrcmaP7qpS6ARthbSc2dwCeEf1E+aZJpFmB0WmKl71sRFC0fnqLw0vH7mOGPziSc1TtzC/WJoQ1oCRUsOt46ZoDD40uGIGg6wDQhV7oxfSGs85+m/QOZLbTVRut+yUjLVGk6kj+ZK0ltq9SHEChTx4a3svhs63L8y5P3cyZfwH+F/yHU8X6htCyaRdhRdarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trqSu4uttDtLId6wzhhHnXrPyjPOvJ92u2kouTvFFsc=;
 b=LvZO1AoGjgCgKH7RQEhOQflt5J99yPC6fR71Lyx5y39+Ogyj+uZZy5iW75yexzqj8fcAFq4QzbPncMaFmeigYQQA6gv+EqHP/jxnkZ+X6/v8ZmcIW+WetvPDDRIERR67vkrfRGIuCe71aO6bZCmibtrkXbpbP+jhcLsp4zCA9vLDgMY3Fxck13VN6IAN1MfeGj+/lBLpvamgc3WGYsAvDajB+Zjcurw3siUAifAnT5zN1EZ91KJ8k1arNaKMUhSBGcgDVX4GX47yg06/9jkJzAYXBqsBcbM5Txrz5pEM46JwMpUH3axG7FPh7dzAsXSbw4M4q5QfaZFLu7MQRKd1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 05:43:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 05:43:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 15/15] iommufd: Add a selftest
Thread-Topic: [PATCH v3 15/15] iommufd: Add a selftest
Thread-Index: AQHY6J1pXc4epOTBu0+Bzhxi63Udt64uAKiAgABLnFA=
Date:   Fri, 4 Nov 2022 05:43:29 +0000
Message-ID: <BN9PR11MB52769FA78CA8B7FD3DB7595E8C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <15-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com> <Y2RkXV+q0Q6bdTde@nvidia.com>
In-Reply-To: <Y2RkXV+q0Q6bdTde@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7283:EE_
x-ms-office365-filtering-correlation-id: f515e5a7-099c-435e-b3de-08dabe2780b9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c0xilIuTZ/p5bHNvK89Hx5D0lSX4l0jmD7C5J+me8itrX/V5UnFYhxFR2TtlyJb6kTNVhOI1r1tspo4/1LppwV/Btw+Maxr4CaXbolV2xkiUJfqIFabi6Q34OxWEZU4w+xeW2Yy490NkNGwdj2JxELEiabH8zjscnhjvfSbuUum3aidAAV9rloxvkQ2rrLWi4Fdgq6AJATH5QxqeUCVr6ICGBv01qiyXAPy7uMow0FQnr0beYbUMbZbuvnY226JHv5bzor6PgBhmKlQHqt34xUVwIjJGFtzM1UbzrQRuOhrox0gEih/2Q3zh/n1sPqRqm0aD/FnMd6HCGem22x+LFqhDY97VCkTwGGX9c9wQcFDpOz3CPpsxi3n360vCR0Y4Mmt9mENm2aPRZV0iyTJZ9USRB6UzDWfAUgj7CL+f2+2LgjX22zLbEwyj2kURyQ9vIxjC/d1i6nM341sACzp5mwtaICtUC1qniedxUv+lgMioKUgnQGSxZLOSKEL20RqBvjQq8Zo85xjHj6atQ2nPGAEqPwr6wSvi1Qg/z4aKTTsDnagGtJ+R3KIqDOvRuBv5xb3CnWbkIwbxgC3/4SDP/k3wo7MGjorN32y5Q6D14kywjHLPhCA+I2j058n6cXt6268pAdRz+XATYNs8bLrZp/RI2Xu5jxvo3ptnCEw0Jj3EtHkWF3ESI6YS5sn5Wb61dKgvbQx8OU2ThF2kyyjhphr7QdlCEqjL9xemB7WgEvNGK0GuI9rKbfczht6XieAbJmLaMMPa0nK0EcJiALjvqaiMK7l0nVhWxS/ZoZG/MyE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(921005)(66556008)(66446008)(71200400001)(55016003)(64756008)(66946007)(6506007)(7416002)(66476007)(38070700005)(8936002)(5660300002)(52536014)(2906002)(41300700001)(110136005)(4744005)(54906003)(316002)(4326008)(76116006)(7406005)(8676002)(26005)(186003)(9686003)(83380400001)(38100700002)(33656002)(82960400001)(478600001)(7696005)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LHZZcyupQoW+WnhOROgBP9dSECgZHutrR+Pg/wTjaTjsdf1DsC2ASm+WyEqR?=
 =?us-ascii?Q?qHAzA+iNEk1b1SEerE7MENUsRoIzAQJrcTfatMa5H/WI9X34LIdVw31eX3hr?=
 =?us-ascii?Q?f/RWThtnLSbdzMth9TRNI+yvPpSCgv3sIpdm6dVLRb/DhI8F6384ZJVmFIGI?=
 =?us-ascii?Q?wq+nhD6sVv40UqN1dupgpvKFw4Iwtid8lus2eXZUSPjEacxdRaDxyQonRJek?=
 =?us-ascii?Q?plLkMUaM/i9UZOeGzSEid0RLsdLzIoAxe1tVz2EsL9D0s4iw1sRm3MtW+faF?=
 =?us-ascii?Q?50ENWP6KgMhQacYEppNthUo38WlHViXSRXSxkR949sfQUMbqFUAVUdeogly+?=
 =?us-ascii?Q?H24bAMbPq85MItgmyfMQ83VSSWo+tJLF98e/Knv3Hh/M9JzA7lczi7V/JSJh?=
 =?us-ascii?Q?ClVhCZEr6LygiGPTYfPZYXDxwKRezpdHIzajZYgD8L0aPupNexOjV+dho2Kh?=
 =?us-ascii?Q?rzVj9cne41aAJ4w6xLsN4x9L4oBjt+4Tlyl6SEY0LM1fBN0AV6YIqqXZ/M+T?=
 =?us-ascii?Q?CT9XOLaR9rKcyyx4rYap/ONBsLxlmM0xw4M+U25cor61f6dZENP3T5UaJbdv?=
 =?us-ascii?Q?iZOfGiq901ItYvBos9I5RiUbiXm2JFJXj3I5j37lJZJzChse6XSNMjZOV7O0?=
 =?us-ascii?Q?hE7YDm7zBl7DaPRF5sLnqLkgpaS6DYpbbjkBRrMYC+BEf/fqKRxeuJN6iNRH?=
 =?us-ascii?Q?3CsDi1DpsxXbLA85YGcYBX3uipsMf66mqH2KxOGNPJ6Ho77wKKV7TM06UnOO?=
 =?us-ascii?Q?4dRW3dJOYt6NrX/scrukze7iPRA98LfMqxeD0k+OqHPmmXp2r7Z53/+6pMAA?=
 =?us-ascii?Q?XE1d3L2IMWoX4Ma1THKuIVng0fSzDO27mEv93CGuffJilKi33tokoYEMjR3P?=
 =?us-ascii?Q?F3dn4CKLrHHNtYkqbG0zYDSCJPbA8ZBz09MatWcDQ+82Tz+iCnFDrdJsP50S?=
 =?us-ascii?Q?SETrCSrrJFEQ65HC1Cj3b3LSOuyQnm3U2G2CyKbsIQ83yJqdqdQvPvSvERaK?=
 =?us-ascii?Q?8j9264gJM7Q8wnYEiONDLdUpBiB1HIFYvlWO+weQtqh1gq17ajaY2D5refVX?=
 =?us-ascii?Q?8ldEW7Ud7Du9I2XX8dsPLv9MQG9q+/1PRMBMKQQt1Ee3kMcGo/Tu6w0ZZdwB?=
 =?us-ascii?Q?qMx9V2QltCzaZii/Qk8JMVgPhYJza0Zkip8hDvUqiYkc4MrW+kV0wXFd0gtC?=
 =?us-ascii?Q?f0k7PfrVt8r55V0KZ6wrp7oEONiyJhCfRfuEAeYxWGX+BezXYVJcXlh7tryu?=
 =?us-ascii?Q?1V4liicT7cczChBJ0B1ZmVHmKOqVCj9kzjlvS8HzpK9DzSvET8YZXVk0yLGf?=
 =?us-ascii?Q?/RB+CaR+FwsoX0W6e3cD06vnN/ux2T7ytTwOREAtpHXUsoiR/TnnK7/kWDkE?=
 =?us-ascii?Q?3olMw7gOi5PdtII3rip4a5h5YS1V3kIYW7YDa7IhyAdzSap9qjccbMBKbn7L?=
 =?us-ascii?Q?H8ydu4Wyl+LcIUun0oTZVJSAlAGWpOkHGmqbHTdVY6pf68m/5OwHDa5sptdw?=
 =?us-ascii?Q?cZ8+ntvTPClxaNMXi73yhV0KV40JS17RltLoUus1yqBHgiYKB6uh1HTiNi7v?=
 =?us-ascii?Q?ydKvNjBbINzKRfBgpGHDUVb/iAyuhtgf6QypiWq8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f515e5a7-099c-435e-b3de-08dabe2780b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 05:43:29.8533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pLgnATjJF9MN2ZJYeOEL7BE8YdyE/cXTlGU6AgKYJEn7MLPf/EZuFw2YeYXKZGrryislrKm7vfijbOMYYo/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7283
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, November 4, 2022 9:01 AM
>=20
> The only way I can see to solve this is to hold a serializing lock
> across iommufd_access_pin_pages() so that neither
> iommufd_test_access_unmap() can progress until both the pin is
> completed and the record of the pin is stored.

same as gvt does which maintains an internal mapping cache and
conducts pin/unmap with cache update under the mutex protection.

>=20
> Fortunately in the iommufd design we can hold a lock like this across
> these calls, and in the op callback, without deadlocking. I can't
> recall if vfio can do the same, I suspect not since I had in my mind I
> needed to avoid that kind of locking for deadlock reasons..

I think so. iiuc vfio relies on driver to ensure serialization in this scen=
ario.
