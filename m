Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309307BF5AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442758AbjJJIZL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 04:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442752AbjJJIZJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 04:25:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC597;
        Tue, 10 Oct 2023 01:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696926307; x=1728462307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=79030p6H7yBo7KTydve3puhHyD2Sg4bsj6TfcnZ/kTM=;
  b=ZXztjYrbr4/bWLlxWY7i/n6mZDeeyZO3xVNgFunc0/Yl4rq7izh3zMsz
   z9k/8RxQbGDzjGSe2M8Buh+26CYJvDBjkaeMAJxus3vttVcv0uANqnR+F
   SXHLTPbyR/sKrxMnhTxkhPkqTKZv0SXX08JjPgUXHLDl2TWOarUrdnuzm
   46wT2+GI/3Y2Pu5wp1Xw6EihfEaKle8QskmPdC5ZMdUYg7Vj1zm0X4qP1
   G+IGiIB+Tx7mlaw3gFVjxztAjaeRn/uJXjvhMerfYb4QprQ68P9bOx55X
   LqCUSnWRYNYzoAFaK2wV2tNNoT6rIH1HMBVFnGdUWkqJGy/v2fnrUmGdf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="383217949"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="383217949"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="844034586"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="844034586"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 01:25:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 01:25:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 01:25:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 01:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6FiCu2lSUWWoVHjZeelRTr+SDx3jPcLyNqg9JQ6KBlEtRd9hJ7JpbgYyPpdE4eI7TSPqLcgmYiSHcROveLxRMnUZGr4UmzVHieRmFs2Gsd0BtrK9TYj5yxeD6Fl92MLp19Y1B948C4bQV7cLtjqwqIvSuXTZ/lswgMPsrHlMUZp88z6Qq5156YIQXWUC/TS6j2XUd3xvU5klkGIeaUmk/2Uq7VBxBB+Tj8gBOp6hzsHXIzdTYZPvmkOugGSoOJNXJm3Yil8hkewBcAKO5J+D5MYBx+ArsFegFEtOuKBFl2TxhFQ07dmsKo4jOsLCpXP2y/ybdWa1lpWIjPVLz2yZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4PwqzeMK5yx9JD4kdpKoBAs5XFKoExKRIpNoIZ1baw=;
 b=jezaOkiC4/ajD+7dKLrsf/Ykd5FVz6k4hl8LqBSlMrDhoKVkDhLiRyXOGAjgUZ+e2SiruOstmYBocpScTdPpo5CU5PHvcv8rigg+KvSAfJflUDBA9IWlByAOd+AcWBv4Nj0hYm+DRMPODfvHsw0EE/loJr+aUI0FCq9Lz6GHE4tne9xAz6u2QKZP3wv766XOV/4yTzxx893badtxFFYjOOStlwD9PKsKx+XPU4VyKvepPVKxCS5NevYEMeHBAMrlAccOJSZ/BUDhsiortP8AN8n/4L58y1u7MNTXPtFuAw/gM+ZYEUl+v1jDtZFsazlaz5rI125AsNOipxwS4FKVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:25:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 08:25:02 +0000
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
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [RFC 5/7] iommufd/selftest: Extend IOMMU_TEST_OP_MOCK_DOMAIN to
 pass in pasid
Thread-Topic: [RFC 5/7] iommufd/selftest: Extend IOMMU_TEST_OP_MOCK_DOMAIN to
 pass in pasid
Thread-Index: AQHZ+o3RUFke0M40jEq5pzQEh+RSurBCsUSw
Date:   Tue, 10 Oct 2023 08:25:01 +0000
Message-ID: <BN9PR11MB52762B560FD7FB5EB4E225828CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-6-yi.l.liu@intel.com>
In-Reply-To: <20231009085123.463179-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5316:EE_
x-ms-office365-filtering-correlation-id: bb7be005-fe0c-4e02-6f11-08dbc96a661a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33p75sQe9Dzu5oC0yYHydKgF6YsapuIA0JuF+sZ6f8ORHmphXXOZR8G11d8QN1BGmdP4j15X0rPFicayy+ciSnSkwcBmMS/5w2rxPnPe1NzqVQNXgAu9f4n10cnCAbhO8QGqPDFAWyke05f5oK1jEEOj9bYy4nX+0enJ1Ar+zzYKLMPTZCZHBWT6tNvQgD+mn1Lgtt7DZ2Rs0yaRA0ZGFP1PNoAKtgyu5eIRGyIon/8L6b3GXHeRs7WJHC7bojjUcrHFJTdjIxAkuKIq0mPtEh1/Qc9o0pBI2PwTBYy3GLERa15ez8V711S16D4ONv7myBH4MUsnBplVYNEzWW1BxmULySvN3yGbH87k7WQPszuqnpKf7ISYUnpnp8IwbEGwirE9TpC/0GluaBNpjhCiOmccxbzAvu2SE8pjbgB2jWdbTCpLR8asWgkGOu/gHjZQXLTYH/AO2YX6bpTGsmKkdi/DfZKWJnc0iiTBQB+VYNfQBAOX3Th3s47+rK0x2innwZYmPWJe+YpTeGdkZ8MU4RE/mbBx4Co2rInT4GXK1l93iJ61HBao73XMQUhkFfPi3lw1c2f4Zdk7BAehedUfXSygp4v0EirGA91MvfIk2ZSUI5HH3H6rXe8nA80YWUAW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(9686003)(7696005)(6506007)(38100700002)(54906003)(64756008)(76116006)(71200400001)(26005)(66446008)(66946007)(66556008)(66476007)(110136005)(316002)(41300700001)(122000001)(8676002)(8936002)(52536014)(4326008)(5660300002)(55016003)(38070700005)(82960400001)(7416002)(2906002)(4744005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?omb3Js6WL6d5NWdxqtmxCNZqMV0Lhjr1nTezkx5MifLjPt/Gsjc3TEFsxTBq?=
 =?us-ascii?Q?et1ozmcfNi2Fbx0FUpctbMFUN0IxuQhp6OI8b7lNhQ4Ga8JPwLBStV5ip/Et?=
 =?us-ascii?Q?NBS5jrZAGyqGrtPTTFbwHu782toIrq5vWQ9oL9rARtIeQJdam+5CeaHaQ72W?=
 =?us-ascii?Q?kZd3ychNGw+gyFZxqlV2kD/XCiK1dMZGlhYdB4IE6sGS+RZHPoxi2+8dSVxM?=
 =?us-ascii?Q?D4LX57DtbUBmu30r/MofXLrL8GREJAbxoYKMyHRoEjlgRd4CUuvvRqOm8uX+?=
 =?us-ascii?Q?bYM7YkUtQrVeRAP48IRVIHhXBLAdWActsfSjs7GsKv8+U25k3zAQTkT986pM?=
 =?us-ascii?Q?0kPRo+4WdTVLHUBhRPCVyYbcGq9o6JH8Yp/5cUy97H9QhG0eycTVjy7CAspJ?=
 =?us-ascii?Q?feGt7A6WpjZEdJ6g9kBoNEfxO88OqChCfbYWPpwbMCPwmOaZsh+CyCxlZBLY?=
 =?us-ascii?Q?3UY9lXfnWbOEnJUqngYcD/Ow0/i55TMFUIqFI1amIUOcyOHXGtrc0KykYTqz?=
 =?us-ascii?Q?N+ih3iojYGwDqhjOvwxLAhz2GQG0UHFa6i6yjSbG23V/YsCqxNoDQzIIgOLH?=
 =?us-ascii?Q?KAjdetCqDGxA+28qYMDiWU7E5zWoYgblEBEkBc6jLh27prY7EqI1on+RgUny?=
 =?us-ascii?Q?Z/9mWNbeCX12jfACs1Y3WE1r2T6MMMGZuDc+uSTbK3u4IRVpu7i9Xg5tRcBl?=
 =?us-ascii?Q?rkSn3kbfXUwz6hSYpFaLkc3sqCPmQuNYvPVjzQKbGbdALrM7Tx9rG/dIVu6x?=
 =?us-ascii?Q?wUhWyZTvim5akBlQewiqVZ64Y5gSYPM6FvlrBt0gU+MNaWKmDXHNGBdBj3d8?=
 =?us-ascii?Q?N01VTpCsDL6nSvhI2RpV23SkYfXISH8zBwTy0mmeJstFicKOlZ1nX7w6M8az?=
 =?us-ascii?Q?52nMO5hNel0fNh8vYc5kDtC3XKdmfZNvavywCVy3ImMMnLkjgIpCuI+B+497?=
 =?us-ascii?Q?kTxruH+sqtdpOVzkmLl9tFfkih7yIG+uK3NQLyJH4Cx9Fw5V98nmy5OpWDks?=
 =?us-ascii?Q?0jWdYPyQoCozLuQ6Jdva5cA/MtSUK494bFtVOIbRcQNe9KlFvDmIYSCBySbl?=
 =?us-ascii?Q?XaV4EdWiwiHlaOk5VmgRVqx/J0AKy6CSljkNLge/2zg1AkaCCR48MCSo3TVv?=
 =?us-ascii?Q?8sQxnv6vCmpCT1fl6Q3b3uxZD/D85Wh9+eCHseyJ6/dlAQuAqqPb4jnLRNDc?=
 =?us-ascii?Q?EvB1sXpzCt0p3imLbuYi3B0P1ZcR47qMq2VVksnKXF3ZQDlbgcZY8eCgEaQS?=
 =?us-ascii?Q?GHHR3nz158yLjoDlV42ilXb/tMAc/IYjyGzJAJG4PV8EwZ0kw7ZG9FSEUfKt?=
 =?us-ascii?Q?3HC5QKowkJYzbr2wsK+BAlVX6uBPwPB7WWHbamppeaqD3T17psX0GJye8EtB?=
 =?us-ascii?Q?cZoIwB3t++U//CnRZBG9DHdtS3T1SCZ7iKiR7+wjFxrDiKn0LpR/bJ/X0hBb?=
 =?us-ascii?Q?IAF/joSFnZ+5zR6MIIQmqLU+nxzKrTsJTH1KBxz4QBy7FGw09GvFHRLs9d/O?=
 =?us-ascii?Q?1nc7IE4o6dKX2UBxsqP7LsPN7uRyjRRyx0SpFKvGROJvVY/2NOG9/BROUwoX?=
 =?us-ascii?Q?rZ/8VjsDVy+ybu76675bkB6TKj8xRCR/dJztMeMy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7be005-fe0c-4e02-6f11-08dbc96a661a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 08:25:01.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +70LZIchGBLpIXoJkF8i/9iuOwH74XYdG2PsBbuTdKffggNokUZ04gzeVnKUgU++9bB/HoFqdg4J9tN87jNSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, October 9, 2023 4:51 PM
>=20
> This extends IOMMU_TEST_OP_MOCK_DOMAIN to accept a pasid from caller.
> Hence it is able to cover the iommufd_device_bind_pasid() for SIOV
> virtual devices. pasid #0 is selected to mark the physical devices,
> non-zero pasid values would be considered as SIOV virtual device bind.
> Will add SIOV test cases later.
>=20
...
> @@ -62,6 +62,8 @@ struct iommu_test_cmd {
>  			__aligned_u64 length;
>  		} add_reserved;
>  		struct {
> +			/* #0 is invalid, any non-zero is meaningful */
> +			__u32 default_pasid;

#0 represents the physical device instead of being invalid.
