Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64CD7D38AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 15:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjJWN7o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 09:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjJWN7m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 09:59:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5244B103;
        Mon, 23 Oct 2023 06:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd2dh6BB21Ah9lsoQ9T8qMLiYTUwtAah7QmXmzwGQJ0V2+LxxFVd/ezKrTQqw1jo7d0ecr3ujJzKezKixmjgYP9Yd4B3U9NaZpQacBESmCjZJ8Nm/u991K0czESKMXY2JIax+vN+pN0plKbr9+qVoAI2zZgaM7J1Gh+FGog47TmjcLIzhF1OJQ+u66EhDt+k6o5Z5wlQMuMcJY0ZeAsfKYNJ4JhakBOI0LO1ISpIhHIVUxzK2D7KKDKTyHYbgCf529VkS0CwFtUjeMt4YriGrqKKqXDbe6ZEWC3oZ7i/FEG4FjD1Rinyu7zhmhpsxLYtfGhs/o1KSTyry/xwff53/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1HecblvzQk5TGSI2Sf8SPoQF+dlsvZIu7XytIipQPc=;
 b=TVv6sIdlsN6ssWRIOxHZf+mn2kLEeoqoOittooVrmDOjTtxdR8A5xh4guoS7tiTughVzD3OQXO66r3akmJQwdrn3KNz48PvymJoS+sW5GVMDM4GQutCguJs0iuL6kRSvKMP0b7A/b7IudagtAXZLztZOXF5fBa714YTz70P6Q4FF+Wpm9JKXM4uF5YbgQuHbMbt4Hdl1x4uwBmiaAHcR11jTG93t16s4Uj6OhWrFK/3L4g2mSyZOE9JY2Da7mSEZZf+GlCoCEmChGzeOr8a5jnQ74B/k+i5wdaClIZKQo3UYkRupAWidvlVIiviuEsSPAmRpyMHwBwVRzecU2qMUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1HecblvzQk5TGSI2Sf8SPoQF+dlsvZIu7XytIipQPc=;
 b=lagBeR2v5VVgt8PwaumCAMZ03IZu53C9Kjimof/10cGV96yY1KtHgnljRFyYnL0pslPtb5IsnrZPNyPOn+TqpioitEKWnbJBE0FW82FdOrNSk30vibwHSI2XnB5GXFlwYJwaKRO4GPrdp9lfIccGNC3DEzVkT4cbXmFZ84IdNUii8m7y5jRJ+9mzDTK1jIBIb3YHuxN6CrRTXSkeaXj9USscDCFx9MJu0h6GHGbHg/RDlDkab9lUfRpMyGEhFeSorbs81HUFsVto+nRQ1+V+1Kbf2iyQ6vZrP72YKrINJ2+qJI821TMLkhOYepZoTZBG7XIdcOp0SQgByedWHMExLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 13:59:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 13:59:36 +0000
Date:   Mon, 23 Oct 2023 10:59:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Message-ID: <20231023135935.GW3952@nvidia.com>
References: <20231017155301.GH3952@nvidia.com>
 <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231019235350.GY3952@nvidia.com>
 <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231020135501.GG3952@nvidia.com>
 <ZTLOAQK/KcjAJb3y@Asurada-Nvidia>
 <20231021163804.GL3952@nvidia.com>
 <ZTWabb6AbOTFNgaw@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTWabb6AbOTFNgaw@Asurada-Nvidia>
X-ClientProxiedBy: DS7PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4d824d-a6a8-460e-9b7f-08dbd3d04ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRlk0Nw6di45DL4T8QqtB2DlC7iYqPQyBc2I2ehfpGe3633LkaJF40yupaTjL3rADs5lhb63rdlscyPDnEFKHBwdJbYzYJuNM1/qUVTvVZONqH0Xf9xvcd/nuNsIFr6+dhSciMhpjMNgmszh59WtkTuFDKKwa9R6cEbm9X5/USdBzjORXDQd5mNY9HhCZN8pg3DFkEQF9aNk5wdMx35UiDFbsc1oTvMaLekk8Mx34fFKWJraa4AD6LAMZ2OdclF6o2yw53wZ/OvkIJxBk7qIxaYb5cVTL0+6o3bAiJokOulT62G3DLwIaqtd/WFTqyBkR/I5vvVMHkGkc/wktbDuWSFjUko+hjqkEUBLCVq/fB1I2cQrC3wf0/Nu/JYUIxr292bmjOirQ9u6m0kaLJn6Rk1An8Hln9xzceWuw+6wtouHWHGXw/AHdwivm9EYP68VdVWvTXopBUCJCc+FMMUJSVoynuv7tisb0sK82onaeo2S5Zs6uzLsWgx/ED4EyB7bJg1vRC1M7e3YZwgw6HAGbyz0buzm+XH3HYMiOU7j+qNo0BrOYFR2yppFnqcqw/Up
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(6512007)(66556008)(66476007)(66946007)(316002)(6636002)(54906003)(37006003)(7416002)(2906002)(4744005)(33656002)(36756003)(478600001)(6486002)(86362001)(6506007)(1076003)(6862004)(4326008)(8936002)(5660300002)(26005)(41300700001)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n7OnO53z08ct+KCbspNCLLYtQoQ17OSINFHSxajswshdtccVDGrJKSbe5Y2W?=
 =?us-ascii?Q?M6Gj7iilq+FMQxkEUdRnpdrqKVgfxpRu0IGO9bXPxZfaXtACc84D5QZT7iDd?=
 =?us-ascii?Q?zINuC8pXMSQRokMUXf+2r/p7UxRrvaqD/C/2GmmZaAqgqr2lwoY2nhpyjrqK?=
 =?us-ascii?Q?9FNnLJLM746HDmld4UtwvwGDVdBGloOIgqnCP3LflIPkRcHWyqB9LGbAyryL?=
 =?us-ascii?Q?bKuKsPsv3UwYSqwER8qGoV96ndXTQ017pbz3OHS7YSrBKN3EvFdsUhWe1AbR?=
 =?us-ascii?Q?e6F6MQfNn3nFc+CHpZdjgqHoz2bg8Z6wZWaIwUcsxgHtdMo+NEEKYP728RGM?=
 =?us-ascii?Q?QRhl4kRZra26P+DifEkUIYMSFgqjD+mnAj7cRY1BTkBZk6IJa/Y4Cpi1orV7?=
 =?us-ascii?Q?IQ8N/Mb7upOYsuBN3A2mFHuQukukLU4X7o+vipqTOvug8k/MO9mQv1Hd+NC4?=
 =?us-ascii?Q?R/V+f1CLGqvjQKtIJ5+0udyCV4r4AWJSthdP+Y0wj7JmN0h8wmNR1YYjXwJY?=
 =?us-ascii?Q?n4Xq3KUbpcA+tcBEquI7oYZH4OExqJPe8ag0AlZE/dJ/GqNI3S2Ar0AmFmrF?=
 =?us-ascii?Q?zLrscHqFU4K+8XymRPc+ha9Yk8ayygvrKYH1AUStt8H9k1NGzfyEsYPtRGUP?=
 =?us-ascii?Q?3EAJ2dVCY9T/oozf9l2F7qk+AmNbViVrPeGHosYNMu+C+wOiwfDSWecwO4h5?=
 =?us-ascii?Q?urvXiScMJM9v5NBmO0AFQzn+5aaOc1s/T9RuBnfuozOGqK2vOmvyH6AFjFOP?=
 =?us-ascii?Q?Uuw757DAK1CUPZx77Wd3aW9QQkz5ETp5nwXjWlWRJoz/x5LqsuirJj5tA+LF?=
 =?us-ascii?Q?aItf0J9rxnEcOPj8eb+KPy5a5BVx0eLktmzsMo/N6VhEunWQMHGDX1bLa+lY?=
 =?us-ascii?Q?MDmo+sylVz7V3sjNxFsoc1Lu9gBZ4Bo70nDI+qmbWV5F0qAXIiJVC8Hbe19a?=
 =?us-ascii?Q?3QfsiPYvBO5auCsVzB/LukOvm3erGH7l0w/xiw101FSsN8lbEBun72rWzQPy?=
 =?us-ascii?Q?Jv7Nlr8tbwZw2/IO9K12O1hnSNFi8f9ONbVDaXua3c4zHGXOkFAnRoC0iFQB?=
 =?us-ascii?Q?Lp57tu0YbDdAxkoorGO1g2MRKBBX4e/Z9sdGrK1+vhuyJ1IgsIAv7OGp5yOP?=
 =?us-ascii?Q?E6sCbKI2maGyuBsKCNQrrIK0/enu1vbqHgUhZAoZZWDdvt3kt9W3WFn2Zr5W?=
 =?us-ascii?Q?On3X0qfNvkoxwwN4pP3K/NKhfmbEn9Fug/hVrI8VrVfCY4XC1mfRC6EiqZbM?=
 =?us-ascii?Q?RQ6OvYoLFlEs4Q9/hTpkGysiHbzt2hwJqvdLbHvUqgTcfydQ5jqXX7e9mkcB?=
 =?us-ascii?Q?pJR69pBFx/1MXoEe4zayI67jLIgK+k+xsVIpGsmfc1X68/s6UQQ3rij6WESx?=
 =?us-ascii?Q?oi5mEl2lDbfM/dXJvAPuj/t1ZJ81ibCkbRkT+Lzw61ExV6LX6GT70Q35m/Aa?=
 =?us-ascii?Q?GmQGsiwuWAYnHYKmMuhG+vDdvwIJc8bDc7vPbvRezyj+6xZC1Xg525GEOshD?=
 =?us-ascii?Q?sPmYa25vM+kSyXMypP6X3VLjG2k9YzbZnj4Mbn1vDch06HNg05qEGTaZFDuA?=
 =?us-ascii?Q?jHLtOPYpaqjHPulPj8YpHowYlJtCxARNFY7c9ne7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4d824d-a6a8-460e-9b7f-08dbd3d04ae3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:59:36.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQX1wqJuXG0/tM68+r5mqWSUT5b42UniPWI9UwK+ZnH6lag7AOdN8iWPgX7MBh47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 22, 2023 at 05:18:03PM -0700, Nicolin Chen wrote:

> > > And where should we add this comment? Kdoc of
> > > the alloc uAPI?
> > 
> > Maybe right in front of the only enforce_cc op callback?
> 
> OK. How about this? Might be a bit verbose though:
> 	/*
> 	 * enforce_cache_coherenc must be determined during the HWPT allocation.
> 	 * Note that a HWPT (non-CC) created for a device (non-CC) can be later
> 	 * reused by another device (either non-CC or CC). However, A HWPT (CC)
> 	 * created for a device (CC) cannot be reused by another device (non-CC)
> 	 * but only devices (CC). Instead user space in this case would need to
> 	 * allocate a separate HWPT (non-CC).
> 	 */

Ok, fix the spello in enforce_cache_coherenc

Jason
