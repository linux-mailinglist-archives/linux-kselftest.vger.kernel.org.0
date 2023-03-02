Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC516A7C41
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCBIKC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCBIKB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:10:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB5234FB;
        Thu,  2 Mar 2023 00:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677744600; x=1709280600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u672tCyUW751k8nJOMJ4c2lzVF7JBTX7bHJI4NDlVMs=;
  b=OusE6vPDYei0i2ONiH2a9fMK57QfJf3sYWPFgXBf7a1JuR2kM2tNtSzB
   EhEEhQvxPSlj6mz59zzGgYndJ3591rwrhrc3B4k8kmimOcfVpwtBycmEh
   5ePv2CFlA5ePl24UfzSMICpkOFx8SjqqbEphd6k9oiDhhxeeu9yAolTtT
   pdvM3dMmhIf0EbxTA8KFA6mhZLs13rDjEwHTxkeHarEm8UnSwvR3LbmIi
   HS/gfCLzOMEcgzi0VNOjWQfCa5tzFwma2hDalwWuT9bXPiWzaFjdfy9U9
   b5Z1+s/hQJe2gZdspVbHHDsB+jcj6PRYXOZ8GobU+tL9bwAEyzQzF/MAG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332135191"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="332135191"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:09:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="920570678"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="920570678"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2023 00:09:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:09:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:09:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:09:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:09:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCBnmcxiqMkAYyYWwnZFhTRBNgPUyQQ8tx1a+PU8O6y9CvUXuMRoJgKbNUzMiEzVf0q09FdqoWS7VV58JfKCcNnrJYIy3HKhDwcf+jUoPG0npm8vGacKNZJSBJpOrAoMC9gvzqsLCvXLRMEgrHFRgiwRCaVH89LsYbntJcoBLNstWxcNkkJzA21w2Ji1Tdvf2u7E/CFDlkmzhkVRpH4nwUd1DnvLL1YKQlM5IVkA5YUYWetOBPS4NbZ0ByJyCbz8YhgvfKYqe4M5iM9AIUlPhzye1kM/XZaV3ds/ZX2VRY/2+8z7MSPH63bZUIqDQ1l9SGyqGj9s0OP6WkQY+LkWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtGQSxQnRCKJAyOi0FUmC08WkApjNPTY6KjKr0fXL4o=;
 b=AUriUl0y0QgVJHEzeVtF1IfZWxBpzb81vf8fB/6ZHfVuVVNEdLyB9gIB0icLZ7+B5UzCxgrD12YhXMyPnkMEYGBQNSYkYBAwMJRoMd+onS9lNOBsFj7KHl9DGsMyYqUomzJWs2qsbivSjulNNRSAGhl0TZP5MoZcAAwo9GM0MYBKs5YGWlyLb9bd4akUsa2qBw9AwUveWcQES06dcFGJtoZTycggKQkE+u2FZyZwaxKP7dgYJ95MY34mPXHoNi2tiFOf07snCLLiDT96diOoOXvCwrYFd9SDu6r92dN1dcb76QxJw8sONO4wUVAEGTd/XWY3XNav1U72ynyow+1EHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 08:09:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:09:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 05/14] iommufd: Make sw_msi_start a group global
Thread-Topic: [PATCH 05/14] iommufd: Make sw_msi_start a group global
Thread-Index: AQHZSLAWwiJ/Qqj8iECXNkhXyDkeHq7nKopQ
Date:   Thu, 2 Mar 2023 08:09:46 +0000
Message-ID: <BN9PR11MB52768AC4BE475A521ED1CD1D8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <5-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <5-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4911:EE_
x-ms-office365-filtering-correlation-id: 464f17aa-d524-48a4-9cbc-08db1af57c81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qttAdUfdDZO72I0gieHpHr6vkjJRyhaJWKrU+gICjRinJWQtoGzyFVR6SjWlUXEvml4CjAW5qEljMq35yDM7wUNa6m9++LbA/GPjAcV+8BzV3Y1w5kY0EW066p/NcJVb1D+l9S5GvYtYzcJhrT+SugFVbYvORftBqTRgJOJfhQXFHPBjSAcRxVu/ERkZeT8GPdPtKScZIDx4+hmKp4EBZYkEWOTSim2JIWj0hDqCNL/vbx1gVSFMvW2mCUrcWOF5eJGs83u+cfgqREV0M1WWv2jS7QsNv+gOJAi81Cb/vUoS0/c5loxApjm9CKTyz5oQEBJdzS0V9n+DnFx+SS0pbT+xfCxiTiussIgcB6kNpU/9iSFVX/vw/CZxsv7NeakpSazNECqv4K7gy8vRIIGNclrZc4P8c9uJPRj3evWQgWqAe2UU4WQN/5t0deK/LfcpniQ0Z8lrOewQssHDpcROsqBZxHSMwIK0dKvDFvzNTGaVjf7y9BJDvK3HFWOFBtq+vSYgyeQxgoFACH6QYM5MdqQgGkzEVmYFfG8+hmiqcKV5QFwL4C/oKv86UqtNg1yvvCJaNIQl6rfTX0vVSGERqgqwebehTRSIjIXoUAye8ott8R0EpMWIjOj95xLK0d9ANaD08jeDbq1tY1QNWtDy32p0PaptILxKOtM7tWCB3CbvkL2gfQuc4EywXvCxsdD6pj0MZFQzsOwUuT2RAEJAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199018)(107886003)(122000001)(38100700002)(8936002)(5660300002)(52536014)(478600001)(82960400001)(55016003)(33656002)(86362001)(38070700005)(71200400001)(26005)(186003)(9686003)(6506007)(8676002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(7696005)(2906002)(4744005)(316002)(41300700001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WZTymSAqx8HLk5EQXn1vXwEoPwkrywxuzJtXhchQJhxOhGsAW0gYijcwolG0?=
 =?us-ascii?Q?y5Y1l7SLhkbBB6cC29a/SoDGl5gqBiof2sLiWR4bd5xupl2tCjqba2u9Uwtk?=
 =?us-ascii?Q?4glNa0ouSJmGIPSdqzz7w5Pqb6Et0n3DIXgjNNJNlA/xE8UqS3a1CDvfPdQN?=
 =?us-ascii?Q?G725eFHbeqoTakXMN+nit9utYgUTuk4bThMbvYFPgxi/n99FCPkLn5PlShvf?=
 =?us-ascii?Q?VqJYJ91t01ncVrMgUCJLfr/MJfLoXr0yLRd8r8H2FgOJUs0gNyogOsD16De/?=
 =?us-ascii?Q?4yNZGcLNZg6BUHogqqaxaHLawajdFtBIPrMk5UlA+NxlB8rqwblAB2QdUCLw?=
 =?us-ascii?Q?OAbY3TqW06gtUaDDdHQ8/xTF0XvNZOEsJGrjW+qMfK4qz0UIOvkWuJFIQDUj?=
 =?us-ascii?Q?l2P1TPT2S46TihhkTHxkgARrqC5Zj/koGpl5i6oF9QZxorrfQqfvTpvXK6ca?=
 =?us-ascii?Q?RoOOaPanQ0wnkgovjCIIP3lpfT/PCnmXkPjoRwgPLwS7KNMAif7KAxDEHM82?=
 =?us-ascii?Q?bpP+IiO+CSnIxwkhh39pIGKm8bLqTDMSZWA1OaI7YGUdNCAxFcV4ahp/LtHb?=
 =?us-ascii?Q?lWOp6wmyFjFoCTx5q2Xcw+x7VhZHaEOioYZOAU/mXY+pauYzvTytO874nwWh?=
 =?us-ascii?Q?OiMAUyCDlWq2PT+bV65DR4gs7jAPonHKBmGPe6d5xFX1UgDTw3MDxll4VmmK?=
 =?us-ascii?Q?Kg51zSeUr05cuFbQVdYtBoZqDE75h3iPISVpnHSat9KI2Ny4K7PNUpdpeWZM?=
 =?us-ascii?Q?WeTEt3OjBVCav1HD0JWrm+f+YAgM7NYyrl+EhBikAZU+7J1DNKqtSWujnS/N?=
 =?us-ascii?Q?sGYZq5do5hWXVZh7ZkA04uGHse1zLkFD3xsZW1bIec72Wxv8Ocp5v+VZngiE?=
 =?us-ascii?Q?a+7DsgtRHf52NsJhtaOVkw2BYFEIPMPZVhhiNjZIh1/kXKruABEOPF2zJrLG?=
 =?us-ascii?Q?KLKimvRzg7tQGKfstcMBMOpBKLIRGzGDpVlDwdTPJQyxRfwx5KmtFt/ObGQv?=
 =?us-ascii?Q?u1bc7KK22G0ZGImXrACqm8XbguT8Pz2uxiBywpbIVwvXbsT/nvlOaqqyz0h9?=
 =?us-ascii?Q?HxcITH/maRV1joMsprsTaTJ1viw+hGwtqTPkTMlx5ya6t0ZPuS8g0z2gJm+q?=
 =?us-ascii?Q?eVyjDJlXREHC98C3+Nu+GFBpiUXzO0q4BguAASlMWWXJbT8zIFXo5yMYrlCh?=
 =?us-ascii?Q?oiWOuR9JDrVa4YlpILdWkQm5sZB/gSyiwzQVdyQZ8plUQO4MVZEJahxUWCM7?=
 =?us-ascii?Q?Eg3WR4fZ6Pj8Fwqd2pUQhsHYtQ9WLfB/I9H0e1AW3PuZn6AVx2JkAfZf4QnG?=
 =?us-ascii?Q?ugyJY2T9WL3BbobXmGuFzstvb6hgh2SHfSUjErcXaZYSaVMQrBq5rDs8ipHp?=
 =?us-ascii?Q?ZQdJEuH8iOREBl2kPQF7kTFNMnXEgzu/2/+SR3VqCYSY2a/z4iGzSiz2vz0S?=
 =?us-ascii?Q?ubkqO4qV2u/PT/AATNSGAVKT2BCwU+9HjZBzThnjHX5amQNsGnnWdXWYqv7e?=
 =?us-ascii?Q?TH7tR4C1tZmsigvAFan8Yi9qBymxHWnanFWYa7yjySDy+5vhx2T0fb6WKmB5?=
 =?us-ascii?Q?KpOhUdKRXplsbNTkrSrp3nxscvlw/EQjuSGuHXrY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464f17aa-d524-48a4-9cbc-08db1af57c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:09:46.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1ruSQroE2EI3uhIFvINBwTm+UTifWATJWLPak+QqiJddSelmA3WP6YzxFvqvCL0D7XRI/1FZO8JkouIpKzX4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
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
> Sent: Saturday, February 25, 2023 8:28 AM
>=20
>  static int iommufd_device_setup_msi(struct iommufd_device *idev,
> -				    struct iommufd_hw_pagetable *hwpt,
> -				    phys_addr_t sw_msi_start)
> +				    struct iommufd_hw_pagetable *hwpt)

Assuming ARM folks are OK with this change, better rename this function
to be iommufd_group related.
