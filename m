Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244956A7C77
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCBIXA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCBIW7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:22:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762B89023;
        Thu,  2 Mar 2023 00:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677745378; x=1709281378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wwVQGDLYkqK7EMEYCyqGxhrW6z4/l7JXg2t8RIUPEPo=;
  b=XNjf1eKXjs9o1P0lwL6n5+PNYlz91QbnUB6IX3rE+a2g7d61rTTCzeq0
   qBq2lP04LK1SQQz06zJtJprrXSiVgkcw9gI401100jnBV13B08u9uQOnt
   MFxfNODuec8BUdDjrJiOVvomli/QAk8zHJmvQ6QEm1xkRziBLeXelRMHH
   sdZsjbK75oitZqsxCuw+TBKwV5Zagb+1jzVDcdJUipSw+a4hvi10diO8j
   fxwajUV2uj1XYNVL97I+B1+Om1N4OfX0KLoAYz0ppdUclL4EHoSO01xAE
   S3nWeqJKxwu+6GPw0VWy1VXq9ThU1WuLD70DyWoPSq/e42vV77RS8AZ9P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="315076480"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="315076480"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="705175334"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="705175334"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2023 00:22:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:22:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:22:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:22:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7k7zO2If/3H5gEAettnmWHIoxaRHpMZbZ+KKGjaUInKScjviEvKm6ad5Z5VWuxXiCtsZV9++z379pHkfhSU18HJFr2Y8qf+eS/yFPL5GZSE9INcnGOa6RJdPLu1nHaA8F387jMJr8k+hFri0NwldBxpUT3t2gtlnLxNJgIwXEqfaUAW+N4tzMz/+l4/AaMkkp7ii8+OPJNFiJUx6dEotiSEX1xf5AYUmkZl8FLSqcByMgBx/w/b7H1u6t4KKdubCxKxeG3iU4foAeTwLiUXISjyXZTCb01v68u8jlofGuB5N9GfgmFfRxHqh4UO6ksmzLkmAygTMkqnCBlzCGtHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwVQGDLYkqK7EMEYCyqGxhrW6z4/l7JXg2t8RIUPEPo=;
 b=LcTjomo4kgrm4HWSJkjPVITstNTj0tgRS5UGn3v1/oBwB+hX04XKCp792E456L2Qj4AjN8DgiFQdZVUnf2rcbO2b5B3TT0WRBb6agI99Jc67hRvS8cWDkrDeAZrjOmYKPlxiF9fgvhB3b1MDQlbhiB7Y6uf0cbk2/cVw4J6aWJgb/Ag5kmQM6ncnXVbnTJ3HbBs5oVpQgOJ445b0Plw/OgnGobmQ2R+EG0xSEIA9L+yVVdaBzjvHtrdj20I8lhv7Jhoo0LyaVO5W11ZbxRDDUwq9oc+UDrsdUntblp4i0HeDpfOXVMu0seK0ZH2V0TyqZl+avStvTiCh08oyiN31oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5335.namprd11.prod.outlook.com (2603:10b6:208:31b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 08:22:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:22:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v3 1/5] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Thread-Topic: [PATCH v3 1/5] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Thread-Index: AQHZSLveuA6C8LGdn0q8vh3fvbjPg67nLszQ
Date:   Thu, 2 Mar 2023 08:22:55 +0000
Message-ID: <BN9PR11MB5276EA5CB036503BC5FD31DC8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1677288789.git.nicolinc@nvidia.com>
 <0f8d110eabc40e71fd2c37f63b1bc8888c67414f.1677288789.git.nicolinc@nvidia.com>
In-Reply-To: <0f8d110eabc40e71fd2c37f63b1bc8888c67414f.1677288789.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5335:EE_
x-ms-office365-filtering-correlation-id: b5f3fbb6-a059-49df-90e4-08db1af752cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCnKIOstA1cESaOL9j6N3f8gEpMPt1QPNZU3uEgXSdHRRcCI18KH8QpMN4Y1Ed9IskMCJBu2dp0JzW5b7tr3ODbKpUqD+KnorcFdAFaD3A+AhnP1oDeIHJye3jrcXd1FajgB20y4KVtIUSbWdFzP8WY/k6tUHZGFTHeL+6RPcB9SzRYlJpg6Yg3yN/IP6IpiiJaSwRV7ynf64aS539AemrvjDplSGv7g8ZnchLxioDddBbWUwOOIr8sGwRoyC8b0n0Og7EWDzhIeKbcFcksWPTuF/LojR9Z+fZxh2ULXFzOWLE8M+P7qtklULfC0BEkk1MDRxlrwRHuzo5kUoVmAS130+cn7sbWB9Kj4DNGJWT9oHZKqet7JzjcbaqmPsK9XWSDv9S8UEuqSvu8X1z1nKtN2KTbf9STsIUfG1NutO9vIBrRrhJloiGdTZHTTx7N9mJDWGDBcnVrzx1X24Yp019CylfYxI/FZBvclzgZqAMK7JONlu8kCXpf1Y29hLJ8tJ9D8fOOSwTx/mT2JtjLpSUnvBdTSrpw/G9XPjB9zUBaDIQ+AwHKHewcvaOe5hm1/eKblrQKelEjh5ACh4o3xhQHfZv1rtS1zC88cLKXJXC8KHJR7ugZ10gYYsg+Yp0QS4PjLJpGwarArxjVaRsCm1xoAWzY/EXjOHCqSFfYZG5Wcs6uqn+BWXn9eU0mzv4bw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199018)(83380400001)(122000001)(38100700002)(8936002)(5660300002)(478600001)(82960400001)(7416002)(66946007)(55016003)(33656002)(86362001)(71200400001)(38070700005)(26005)(186003)(9686003)(6506007)(76116006)(64756008)(66446008)(66476007)(66556008)(4744005)(7696005)(2906002)(52536014)(8676002)(316002)(4326008)(41300700001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aW9Q+r+KyIcePTQfHi3avtzCZLdQvg2BlqpLEEz3+tXB/eiZc/e6BqyMm6yB?=
 =?us-ascii?Q?zT4oCEiuO8bIVU0KvWrBJQ3YhZR5XYyrabP/9YpGCNqkaGZoo0PZq3oakGa1?=
 =?us-ascii?Q?i2tkB0bxd65ph4zIqOLEBMr+geXfkpc7UnxH8oVoveDvHEYjQx/fyrTtyc0a?=
 =?us-ascii?Q?Vu3gEeFiS7N6zLEKN6g6MGx4ZAeiZjY/uHDHdqPPI/blMKT7J5z6Xx1NAFKH?=
 =?us-ascii?Q?yIsnyDTAixza8jtKYtlGdqpP73Ki9It7L5uGM2fjxS2GHV/EoLX+GX6MKtwg?=
 =?us-ascii?Q?OrO0O/9/i2gdO5uTNyQuyCHDdjUHO33au5LjA22VP1xzEVSBJLZiYl++EM+d?=
 =?us-ascii?Q?C4zbzin8IlY5SYv0FzFce3x97umhyE2tjFJ0ZZEABUnCvD9cughgR+9kcf46?=
 =?us-ascii?Q?RohBkhSxQ0c/9Y6JXCZ+yBmpNmZJFiaua7lcpo8TjnoVWpgqJoxSuqldlFBg?=
 =?us-ascii?Q?BoI3GhWDIHPUmpVmE/rVRQoEdL3Vjk5Npuv0O0JE4MLnsrJrQQJ6xDxeWhWr?=
 =?us-ascii?Q?B4TXe/RopCkZAxOmKtNuOldAe0YQtDX1uPdsHJgTbzv3esXtirKn62KfS3KE?=
 =?us-ascii?Q?jgKzV5lb4MRtAxqrVlhJqnHLFQ81Fg1zVvpixxhVh2RENc57VMTFmKnUO9WZ?=
 =?us-ascii?Q?mLYp+SP4AxakJlQCC78MMN0+p14y6ocyWxQknhyBEnCyZjkLf0ezsAdTO09k?=
 =?us-ascii?Q?8lHH8Cpm+iLPxUN+cm1EebYKXBIGSo33GiGUHXfVkchjOnDJQHF671XYoW2R?=
 =?us-ascii?Q?OR60WZj1161PubSFAnEKyAAzn6O95hqAQVH8F0GXmq//DxNboXIf5wa/7aHk?=
 =?us-ascii?Q?epg73IB/oKzZ7a2/PKEqije1xzdG1uQvg9oBrHHSbCSegkEIvAxbf4Gy+//J?=
 =?us-ascii?Q?R7n/xae1Mzb7AWsz024AQVb4ADwctwAosfoYhlTGqPIOReNemHmHPDEq4j9E?=
 =?us-ascii?Q?9vEJ1NdcmFJ4rH5R0imTr7/iY/DgB+KU0tE7i9OS8II8wAz9Gj9HMg72/bkJ?=
 =?us-ascii?Q?rL576o2Si4R3NunRO4FK25tlSAqHwQlT5vJwhgATTDrpsarkiNfSgjx6YgeY?=
 =?us-ascii?Q?RTdJuFlpN34No0ecRRGIvwP6Nin84DDLDMCDR8URkMSSPevIJVdE+a0xx/Mu?=
 =?us-ascii?Q?GqClYphQtOefP3vnIvKcLHbvBbX7lF0wRRP7746Gc9easvA4d9gOcR/cQhIE?=
 =?us-ascii?Q?ZCQhCg1F0hDp7EN3fBBb+hfY2ac1esg96tm4qA/jYkYVn6bwsyo55psJpjMv?=
 =?us-ascii?Q?nTRDA15zn/+KdhUe9MyClR1pIRHotEmmnXu1s2FMDxl6oJoykECWaJt51cQW?=
 =?us-ascii?Q?uecD3NkInWKRx6vqfDyJTuZR3UXdO+uorbIoHDsYqnQneg9SJZNTT4jMAlY5?=
 =?us-ascii?Q?uRIdjPrdk7elArWlmhQIszuH2FeX+faskXtwwmoRAzzGCAHVN2SlvQraWLxi?=
 =?us-ascii?Q?XOwnIi/GTPU5S7Wm1a3mcaRnbSgNzwa8RD3cqaSEm8GM4S+fP2/go1VMyyxX?=
 =?us-ascii?Q?nXiPKxPzsygNe0oBdDGasezRUcMhPdKd83/rOCTuZtcB8Ys8Itac3iFkqoOQ?=
 =?us-ascii?Q?qeYz6fzIVbwxJpVrq/bSJjnHHaTlwZ/7ierbzxJy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f3fbb6-a059-49df-90e4-08db1af752cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:22:55.1348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAP9JoxJvbYcFdTH96M8RZS/NqTSZJmIQPN6TZhNR0z5Mu8eYZmCExBGXqDt1Z492ORrg369vEoKNeNolyw54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5335
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
> Sent: Saturday, February 25, 2023 9:52 AM
>=20
> A driver that doesn't implement ops->dma_unmap shouldn't be allowed to
> do
> vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
> range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
