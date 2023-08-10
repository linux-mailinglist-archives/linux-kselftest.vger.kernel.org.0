Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B65776E34
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 04:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjHJCuF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 22:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjHJCuE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 22:50:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5401FF7;
        Wed,  9 Aug 2023 19:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691635804; x=1723171804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PFXrlmvobpCOPQF959lBeJeKy85nD7HjNPK97ghi7cA=;
  b=VjA4aSLlxYnrWM2DefMpITimE8CyQhh8CBuHG+7bMWkTws34LnjH3zb1
   ut3Pg7Ut3Y4X5cX04w1tNDWBVijUYzXvLFvcq41UfJzp0stYYNywkH0A0
   wiZyjsqLhnxps++C1K3bn9xLSDt/L2mKoOldBAvfJSVx+J+1D5co3i7QM
   vWsOpiTNwqO1ev2fex0yHrzzBHzsbspXMAEyXgH9XVcfqNmh7/3UAEN+L
   l0nK6JM/M3eeQlpHy87Lbo7MolTak/0PjWyeUJjPXNw74yUv6IAobG28W
   MdCm4iKRQ8TPZWBzI28UJgBk6LWA3RVHDWcfTlEcJs29uembn7nTBRC9J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="371276090"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="371276090"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="801995024"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="801995024"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 09 Aug 2023 19:50:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 19:50:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 19:50:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 19:50:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 19:50:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+saY1xNYmdwN1MjQU8/+0l2qJvixaodrrLCXhvEg/qCso0ZiBfswwosZWnrHRbXYJtdF1GSUN28Ro8xNOL6J3qy4FbcBbACeg1UcJKN9dDN0Ifg1XCqFvjOlLzF/5VbgZOzSm6dBPrL9I7cdd4C0I6w5a7ffeLhZPLpY+9/2x2/qvFWFd2Hwu1aaDqDrDvrdX/xCEQexLOBgZmVaKzNamRhj+Tn11rRgvECM9BcnH9bZe6zLgJJ8y/zi285VYJ6n43xAAEyThJAxp4d/q3zGl0B3pe0boVdVgwfhtmCS0wOuoOsztHvdwzdZ5wp7A6LUaOctwpQ2dKg6YwixwufGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFXrlmvobpCOPQF959lBeJeKy85nD7HjNPK97ghi7cA=;
 b=ZSeWDSyb2IS4hHOhNH4WapASQV+o+otHFh/8PivNdpxN0L1vOAYdfxj5ZpXt1jOVlUovhxYrrgzewybVhxCMRrQFdVbcfqdMn2tkpP6uu6OJ4+zPWehjFBpfUaNhz+93Yj6i8L21Iv8u5jFlmHIal9Ufo4Fa9WXWkDP6DN5moXLzJSs4ShLn+uv0yfsZKlSEJHkavzoANpFL6nS2SVJEzvCL79ejXm5UpHpy2PlnRjzoFbGqsoiNao/L5Rmoh8OfVdW9LjZd+AqB4KVIIQ2b3EHHenl6bPpNMvR0Uj5eV0Jam+0yd2IPKY/yh2+Vb3cRgklrDF3xJ+5wxw7Gd64HSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 02:50:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 02:50:00 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Thread-Index: AQHZvh/uFyWMLiVXhUCSOYKFk2h4da/WraUQgAhYJoCAAMpSgIAAnN2AgABV8ACAAPMnQIAACsKAgAAAQaCAAArdAIAAc+AAgAAuy4CAAAHYgIAAEEsAgABtjjA=
Date:   Thu, 10 Aug 2023 02:49:59 +0000
Message-ID: <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZNGypUee/U9d68TZ@Asurada-Nvidia> <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com> <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com> <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
In-Reply-To: <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7594:EE_
x-ms-office365-filtering-correlation-id: 9df07d5b-54a2-470d-03d0-08db994c7d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9iBXe9wkNe9KDXISNao6YySB7swFmPWdjITP6bAYXei5qlaJ22zTy63vGL06Ui8jPBkiU6jCsvZOK+YkJCTkxV7Id+a64LPtE9aMuHZp8gJeGxtR4japPkd+Ca2FDo54VPNWq8AUYYcrUi0CARoh8sJMYX8Ez/+d5JyVHi5GdqX+zTvJzhi/zC9/GQdGHEwWZ2A8QxMh8nhabSbxrMT31nMSK50BHmvDIypTp8aJNrTr+EFn/WOLDtLt0zN5UCSZmHRDQNUSGBFW85QyaBdu1/qEJCoPVWmZ8pmHIcL63NzLxdm172tyZAeFOYJLXLvtVzEW6EAT8mWe48Tb8GNvgGYvJoW/305/7TREZm1VLDky8knqupP3Kxxv3/Pj5wBPGqzG697dIXdM5QVj5vVbkwDyL9iikyQoxSlqls5GENUsCI51WmQVbrDLG6w26T/CkFHn0s5Ry7SbueMRjmv8wYfrgW4MyS7vii/UWa1vUkEEusAtRY7SvSqeyiX4wxpaIH5g6OTmhX+EWsi2SWrvXT2TaHCuuigoJCir78AMEvM3z/R64bwLaweuG0x7Q6LYjvZ1u3/A2hM/NltvyKagvdqlBdg8H6km0VPM9s290+0nKbZ0lx+EB/+fS4Q/r3Hv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(1800799006)(186006)(71200400001)(26005)(6506007)(8936002)(8676002)(82960400001)(316002)(55016003)(86362001)(122000001)(478600001)(41300700001)(38070700005)(5660300002)(52536014)(7696005)(66556008)(7416002)(66476007)(66446008)(64756008)(76116006)(66946007)(9686003)(33656002)(4326008)(2906002)(83380400001)(54906003)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fZIQ6CEJqndp90bdMz7xAHbBMlvdvo9krKyQvjix0iLSidJACL6vMkPBnF7b?=
 =?us-ascii?Q?l9JPru58INloTCdWfMBUJDtYGOG2YW4DKMeGeKo/fFU1MnRAUxBRBDBFejnP?=
 =?us-ascii?Q?x0cSe/SY6kzVQ6wHrBpozjAc1UZ52QdaptJEaV2Mp2rdwivLbd7QovUTFq3G?=
 =?us-ascii?Q?8gNRUpNn63TNkhrbYnphxMi3T0aX6eV8g7pVIi9yJprvPRQY4cNjiNrE2Zkj?=
 =?us-ascii?Q?T0P2mvTM162jFyXWpG5A4Zk1zF8Oxri3iXd1WnRtKF+7rnVOHbFlq6zDta/9?=
 =?us-ascii?Q?W+v2jWePpzv80BYjxMnhScawDR5XOpkrBS9A4EPQTwUdQlaXBXb2kSLdSfVj?=
 =?us-ascii?Q?VRhd4sINFkmtZfHCcJniNKns1WUXQP8V9+k4l01IfEuwstkrbRimLRXU2hce?=
 =?us-ascii?Q?LuQ9gNM70SRbklvvujZdxsjHwB141waLWa4xJxglu/NuQ+CNcLEwbCeTN4LH?=
 =?us-ascii?Q?g8Vuaf/fFVSS36HS2J4Y1OucuLR8XoXB0Y4RaH2j90CcSvDpNSPqAuGpAI/I?=
 =?us-ascii?Q?3n9yi9u+0wmJHwSnK/+QCjME36OM95v/4peprYe0NpmwvTaHh/6gOIWwLJ68?=
 =?us-ascii?Q?K0zC2JHDkcZdFSta55nivtwP2v3djtfERPEe6g5dp1/oAieSq5JxvOamvJBb?=
 =?us-ascii?Q?c18Gkk9OR+BMqVCxOwxpTXbXlgd8wNUN3o6i2uROy8mNjDuruiMFUzis71qy?=
 =?us-ascii?Q?EXW7ebZBcfZBXAiXI9z/5+TASD+f4MXoPpoLN47LhJgy1JUmZJSPdwdOxbWu?=
 =?us-ascii?Q?JIz40V90lLqABDl6/+IcXxWox2l0xI4OO3wQ6Z4HeVNlD9+tmDIeEPgxWMkW?=
 =?us-ascii?Q?xCBASxG1grTLAkjCaCFvXSG7X3UZcp1GFYqGadQ9KmHRHVv7tU7+rq0Q8C8A?=
 =?us-ascii?Q?yyOA1sbT0SD4CFcS89h8VXt4+xQiQ7yxo2S21k2pQqFnS38rkybTbNzho/go?=
 =?us-ascii?Q?43kWzJw4h5qezc40p3ffFVAyvwpswZ+DqgWL928z5Maqh6JyYtZ4Qc0I1V0E?=
 =?us-ascii?Q?PSIcDYeTT6ckGy3yNvXbebXeyuH9AhPufrKkLnZ8532ZbaO8nd6piVKv1PTy?=
 =?us-ascii?Q?WnAak4/rUMZNxjkNbTI73W9nsE0gDNZ3CVNQQ07bHrXqvor+ahcLf4D2evv4?=
 =?us-ascii?Q?ON35qBnB7R/ReA3L6CWJ3QZINcGqYq/bz7tMtxzzrC9prGNXE2tqBHAzRMJ1?=
 =?us-ascii?Q?8w8eLwbIFN46PA8I1CVnH5uiZRWYAKqnwjJfGsJ+zWjAkp4ffluT/HPcBDVU?=
 =?us-ascii?Q?F5wri11EWw/wRf/lDtVPv51A4OCSmGDOgLb/WfYOacxdDXdsSfYF3gDE4T9A?=
 =?us-ascii?Q?FYqLf8bKtcvOVK6ce5KC1a5cg7EMPB0m2vB2dFnaFpll2LzZQGNgzFTg/RV+?=
 =?us-ascii?Q?/Z+veOSQm4MqCV2q/Z6QXtBhwk3l5SbWAdcgnJeNixblraKXGfLjJ7yEC48A?=
 =?us-ascii?Q?dQ0bdNHlwqskH+wj/tC3mR36B756oDfet6ZyGlos3jIY+OSJOwC2+lw2hVQd?=
 =?us-ascii?Q?RPd1bs9r5IbqoBOIbpuHup7HeQWvBkwLBiYtAd2QKkSCoE/34vWwvBi4rfYH?=
 =?us-ascii?Q?13FWbHb91FOzQOik9FSJvgNTB8fqxP/5ym3Uv35D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df07d5b-54a2-470d-03d0-08db994c7d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 02:50:00.0321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9a8zy/UNYr4TMEUTT92mEjA9JGxlSLAmScW3l52j+ukoqTVKhZFo0BDv1vm/wqEo8evcOOFqW9h6/vrUiGjNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
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
> Sent: Thursday, August 10, 2023 4:17 AM
>=20
> On Wed, Aug 09, 2023 at 04:19:01PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 09, 2023 at 12:12:25PM -0700, Nicolin Chen wrote:
> > > On Wed, Aug 09, 2023 at 01:24:56PM -0300, Jason Gunthorpe wrote:
> > > > Similarly for managing the array of invalidation commands.
> > >
> > > You mean an embedded uptr inside a driver user data struct right?
> > > Sure, that should go through the new helper too.
> >
> > If we are committed that all drivers have to process an array then put
> > the array in the top level struct and pass it in the same user_data
> > struct and use another helper to allow the driver to iterate through
> > it.
>=20
> I see. Both VTD and SMMU pass uptr to the arrays of invalidation
> commands/requests. The only difference is that SMMU's array is a
> ring buffer other than a plain one indexing from the beginning.
> But the helper could take two index inputs, which should work for
> VTD case too. If another IOMMU driver only supports one request,
> rather than a array of requests, we can treat that as a single-
> entry array.
>=20

I like this approach.
