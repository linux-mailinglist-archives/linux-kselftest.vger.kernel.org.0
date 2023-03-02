Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C251B6A78CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCBBVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBBVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:21:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E4460B3
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 17:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677720077; x=1709256077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tfKlRhzpQbyVpQfJcvuL7xAr+nTV9IuMAbe+/BuVMso=;
  b=XfTP4qJ/5i6rH+NtlrJzodcEBEuIE7t1z4pF49gIBf8a7CgJECMXmNV2
   Hagi1vWC2RJw7afHf1qnuemIPpPfkfzzCby0fNVCanNPCtfEvKfgbDuHD
   uqUFdyL6beheMCK4iObCWueWES6sDm9V7PTPnuuxDS4KFdeNzJ4sxoMmP
   YvQR7JYGl880mPaSYhZ9wO02i1AWf0oKzv9cPX0+AJ7cnIRCiJSvpo3T4
   4EcFQbvojJ/vzVsl8qt80NCQZS1useaw8D7ZxPd7v7p6BvbBO1SozXupS
   I076jEGnsA1ni/kLRm/fm23Aggrt4kXqF87PChEtr5K164SqYG2qXknd+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333304600"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="333304600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738856821"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="738856821"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 17:21:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:21:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:21:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 17:21:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 17:21:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO6Bvw+mawfTtyJukpIrpKOS5KuuUcDx0EBIvEd/Q+Ljyq9y3i9QbwA+4PROm2NWSiW/58y+i4MHT0lBXHJRgY8PDazW4xeFj9r5jtwij+L82jI4wuhb5S3OaTzAqd/JwWDmk05F7UFVFPO9k2Ew7jQH+xE/Dsa7e6JusaCdcw1MH+ZfcDr0Md5Jf5zA4KKNCAwydm09ShyMUMBTCW3qqK3mpBkTWd5/PALotqB3MPZBWQSX9YJ7Bgj5dUm3H1ahmId5fnICmyQRC8bbMrmrc4m4s8JnpOJTBARBeEmhevnzAudN7/EkzfzDYm0DyPWY743N81OmkKHfpA/a6XZTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfKlRhzpQbyVpQfJcvuL7xAr+nTV9IuMAbe+/BuVMso=;
 b=M11I/c6aGnZ+ioms9LFTjyQ3iazsP2U3xC1kzPB9ztr4viGY5uQkZbn4xO9H1fsZmIIq+UEGPviT2rHjgc7FJ1zImzKfv8iYDmdp9AbSXcn3RfabP5ejHJxdbf/ui7uXfX9e1o55QI45lhgPF9/QGHaruncBcpBtXY4K0M0do12XnusMxF7ubHgzE/eX+4JvORjK56eEnBJ4ymggCjvNfCw76LYrjwKl/pyt23mU/h/hcn5gr7p7+IjcWVWn278tb9oJu6eT6Ua+FeJyhNExuYzicNwlBLt8QbRXmEGpHNd/RCOAf6GKTgWr2GOaJIlePL7SXnRe4OYo7Gil9VdvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7685.namprd11.prod.outlook.com (2603:10b6:930:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 01:21:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 01:21:14 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 04/12] iommufd: Move ioas related HWPT destruction into
 iommufd_hw_pagetable_destroy()
Thread-Topic: [PATCH v3 04/12] iommufd: Move ioas related HWPT destruction
 into iommufd_hw_pagetable_destroy()
Thread-Index: AQHZTHRXjg0uHJuTOkmXxTdM4cx54K7msY7Q
Date:   Thu, 2 Mar 2023 01:21:14 +0000
Message-ID: <BN9PR11MB5276B92B606CA5BF95FEA55B8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
 <4-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <4-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7685:EE_
x-ms-office365-filtering-correlation-id: 99479c7d-095f-4da4-6068-08db1abc6a48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jdc4Jwk1MdkE3JWvO7aUJt5WNqXSExr8tmB4Dfill0fnFsztKbvd3e3C6gjMphXw5chArHZKcNMQKmgFIdJoFrqDBHtqHIcu9u8gtD/CDLSJd99uSvBUi/JurBunjHrPS98racGtbzGpf7hIy5Hdiuln094Efd0KoAkHhtw7Q/RvtKp7msdslUsS+xhc1kMVVWvvJods1TqQv/OiasZKygmbjjwTFftXctMaOAqXnLXGtwLz2BmmqcV727PfBNYGGjF+HnEMoczAH/WexP1bKhvrP9j0XCWRzbSe8ZedhXxdWWXLdQ4z8Uo8EwrH0BFV+zGzEjrDMPEm3ltThUiekLyzeRJGOovk2P61xPUsn5AT0ppaNTms0xZrC1gE6OnBAAmcYeI8bPIUuoTSNYpbBeyQgDu44JC3oixy3DOd07sWJdF6bL+SPfN4PXRwe2HgjQzczPQPJl8UvuO0+BOuyl/rznTvozZNpsqZ7Q3+Spl56Jx8XP3HZ+5O/9bXQ2yt0pqhLVFW6i/BjgWzTzHVUUR1VIn9KwX9/Foa0Wwh0k/MHHI8RHFpXwwBi4wKFvy/8AQghV5bHgGj6Hlyl7mTpbC0kE04sqP+x1pfhuQdG3g+Ym8/3xtsQeRI+n7tccTZoyXbtCLWOzHAfO1ORFhW3Dnhmaov1WvcrE5mhdQUrlwnjIWCmXTIKepsbYguA1sYykcp6N6VzOxAdOlAw/4Dug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199018)(107886003)(6506007)(9686003)(186003)(26005)(110136005)(54906003)(316002)(41300700001)(4326008)(66446008)(66476007)(66556008)(76116006)(64756008)(8676002)(4744005)(7696005)(2906002)(8936002)(5660300002)(71200400001)(82960400001)(478600001)(38100700002)(33656002)(122000001)(52536014)(86362001)(38070700005)(55016003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HvPeobougcreJmrpQ4oW8y4AiANIXp5moz6xIn4UmdqxLFmKBYF/VjQ4nyfS?=
 =?us-ascii?Q?z5eCnx/3MG3V32cglYpMFj7SqtkeV93Ro1q/PPmSdcTUqV7fBsG3ad3obtgF?=
 =?us-ascii?Q?N04rmgiD1zBG6fqH50UBuS7s5AVlphzzhWBM5VycG6KVUdiXBGV7rawuzj6+?=
 =?us-ascii?Q?UJAbnTykjbO2DSIImUp2O1NOVYm/3BJNep7gvuaTYSlhE/cGUhtUtldcQ4PC?=
 =?us-ascii?Q?i11iOsoaejEIjHNPHxWAqnjw4t0znNjsUPOHzsrQTgoRteSBqKqJ78PgwTvv?=
 =?us-ascii?Q?YBdpWI9w4QIyJDxO2mveqJonsCB3oXNUYxoaFCnLbiAqCtQXwDSp5JtghC1n?=
 =?us-ascii?Q?G2wGRnKfwUQegKQQ44zPYnf4RFNNLVENiw2RWfVgkT77HFXXFpJ2NMjpidBj?=
 =?us-ascii?Q?PtW8jH7WsXyHNuFrj/KYiItSCoK7lPtHKBwMUNbuowqRVhvpKuSa3EfwLN8a?=
 =?us-ascii?Q?atYaqWHhyh7XwBDYlrNfSneCL18isw2g5nnemniFh0pqKv7efZWwoa2SrvP8?=
 =?us-ascii?Q?OQVo+OrEBFfXSGs1FjzZ3aYQILV/NYq85VGyg/xWHm4YMCutf+NdN2pXRw1y?=
 =?us-ascii?Q?aXk+e1IvpMkFJTqd6Alk2E3UygBy3hDCkD6GaeV3bxy+y5cMhoYHxAlPOzzH?=
 =?us-ascii?Q?DfM5ekqDpb8ST369PyTg/xGgP2gCUPLBLV01Be7J/o79VhVn1GWzqyGEfLJ7?=
 =?us-ascii?Q?O/tVV9NJE/K/B8xQbkihNBKAF+IMy+IicQuXMiMy3N4SHs4pGn4xbW4J13Po?=
 =?us-ascii?Q?5nX75ZX9kl/pgFOzMDNu69prdKaWpZfvq8WeFUu9YlxYV5J1PvesCwgu4Qj2?=
 =?us-ascii?Q?9K54R/qR8KVeHoZCpzJKvo6ZxJ0GQPq8gW27vK5JwWtu+JM2p14ZhImKmaZ5?=
 =?us-ascii?Q?S5y1uye9+J6ckE+99Y/FCi8iImr2bH4/3Gr5V2Sb5hSzrkUkfJAE2+p8UZiu?=
 =?us-ascii?Q?ewZkQ6wSIHU1kfrfkjcOkC6UQEsI+aKbBiO89DIoRIsWJnULiqaSdaq6guOX?=
 =?us-ascii?Q?14Q3zcr2Byc+5alKQLnNOQPVu7BwHhM7Eb/5m/EaVIACF+JKBIHNbf0dBRnk?=
 =?us-ascii?Q?uh4lsFZ6JshEL7kC8ceafMSbP0AIniX9re62Q4S8/wyrUgqlOs64Zbkztz9a?=
 =?us-ascii?Q?v8orgieey+3F3o/1rrlB+27ADV2l/MIMhUmuFJSZSTqKgJ6Zx4WI2oJQl2+4?=
 =?us-ascii?Q?nDaA1tWx6N9Wp8DUfNaXlkXKoObOzLxBWikzl12hVcWrdxQHuwLLZcoQTCTT?=
 =?us-ascii?Q?cZrjP2a4Eb5oESUCEJX6WWUktUx+qlJchfl9HJjbS6iwNh8KDw3fwkw9VBqQ?=
 =?us-ascii?Q?VK+pYOq1CYjstelkS04Boz/42Dg69P6+k6dYci1YlEHPhkUiwxBNdID4/9zN?=
 =?us-ascii?Q?XKocmKYcygoy35Hjf2+FQF5D6iqxoIfIL6SDdX9kWK2Ahpfm9N3L2RUK4NxS?=
 =?us-ascii?Q?OBF7QFZlDhow5zSYTO41d2cHko/hit/ACTEi8dl4hAdoEgYbMKxBITwzWDc8?=
 =?us-ascii?Q?9+Ajw5j9AhmPtHx4rFOCpcXI5usRh86uAaNhmICSIAdyMzwcNe7URg0uYyV8?=
 =?us-ascii?Q?bL2KbjXfs3v1Er/Q8IJyrZ6rgrGoggyaohEumnva?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99479c7d-095f-4da4-6068-08db1abc6a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 01:21:14.1890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGw0t4Tv7vckzdBpNvF1rbgdU/aoKR9n/UhXn08Rqmp/fHCgMeltNVpmTDvPEaHGrTMCwYgKYtxXRaJWjrEpAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7685
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
> Sent: Thursday, March 2, 2023 3:30 AM
>=20
> A HWPT is permanently associated with an IOAS when it is created, remove
> the strange situation where a refcount !=3D 0 HWPT can have been
> disconnected from the IOAS by putting all the IOAS related destruction in
> the object destroy function.
>=20
> Initializing a HWPT is two stages, we have to allocate it, attach it to a
> device and then populate the domain. Once the domain is populated it is
> fully linked to the IOAS.
>=20
> Arrange things so that all the error unwinds flow through the
> iommufd_hw_pagetable_destroy() and allow it to handle all cases.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
