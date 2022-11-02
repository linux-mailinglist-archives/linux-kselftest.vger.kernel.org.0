Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102A1616390
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 14:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiKBNPQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 09:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiKBNPK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 09:15:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB8622BD6;
        Wed,  2 Nov 2022 06:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j42Aq841h5sn2iCNDtEVpQDp/TOOmoxjGUGi+lVMBA9OSjv6FHwNeV6jX2lnnff8t+KAf2PNdkhHlsM20XU0e0fWvd+7iVG46JBmSHdwDv49efk/qpM7Pc96dl+y+/uSUIOWrU89w2dwv82llqCjrQ2agGwCSngLUqIIuD4x0VNUN8IUKk1AMhJoqJeC7Kb7qgYIn+EvKLV8oAJU+PY4YPrWoC7a26wD7AlAArK7r34yG58+HoyOjV7eY3bSEP8PE+IDYHZKEI6TMvRQD9JCsrkPNJ2CnEQV5NFbcL/3MV5gNMTyW1wtre4w8+ZqcBMe9avHfyEnKrEghGIFTmvBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnM0Q8akx9wRK9njUpgLwbj6skpBsPeCXQpyK3/3UQM=;
 b=P0ygtIKZdDrGPVkaHZ51h+5zmRWHHUJ6qJVYpdTh7HzvLg6REAZgtXJZWv0ZeY59uieKiuGIRug89PP66k2AP0oUFOgO2gGnSOEV1baGaHuwtMMLq4Ooef0Abvyb1iVhUY3qDoklIu7wriVnjWnT6avyLRAVUlURRjTaMFvbUP1gXQ7E6kW4uAQ8s0NSlJKfCxQVDvFHc18vpZxn3A/pTE6ZEmjSW+XdruBMAMqVdjGoL0ApA330lVU4pTS95BArUOgTUR19xFo5hEflYD5uYmBcppoXzR67XshWMMYGRcJBm9OsJwsjLxGyaCwa6WLmL/Yst4hlZWEOui0Doa1YVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnM0Q8akx9wRK9njUpgLwbj6skpBsPeCXQpyK3/3UQM=;
 b=lZT0ClaH4aEIPhyQtW1rgWkjab/VldImiHq3nNhaUnevOB98GGDNJqjxTG8NW+YKRnIpTb5IMbhnMPvibCwEjKXCPPqwoklNjLocTSSstxKVCw0Dtjeagx9RXZMHNl26hR7CUp1zmp9+rcMMTKckDOPGQmvk8rnm+hOucf+ebCu94Gm0+DJHhx7+sm7a6R8Qu8SChj6OirkMKcT9cY+YV0ZVZO2lJKF1L6b8aw8SKFCUGdDYs9yBZyVRJQqtHvtVaY2Aeb6tnBIfhI0wQRLcBLm5eeSQksRlfi6fqRW8KAz2jScyX9ZtzT89yrC2E9IuXXnbxq9yBLORUpq5sWyIyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 13:15:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 13:15:05 +0000
Date:   Wed, 2 Nov 2022 10:15:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y2JtWGHaY9bdqLNA@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <Y2F3PVS2JflqrMI9@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2F3PVS2JflqrMI9@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: d019207e-e758-4490-2be1-08dabcd441ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wd14sl9YNiIGdQmXS9aUaWKUqmOZarmVMbxMLxZwU9jHvUBwwy9nCb4QJzzIHA1/D+lWU1jfd/u3y6j61CIm7lIi+JRARnbMe3VB8LT0RiOTrlxifPXU5eI3EhQBC8fkPGdbjYzvJnAf+DaoY0a89rN3gmnTQlUWBQIg85eeQgvD+2dYRTB4VQY6mlMN7oaJEFedVKBTRauagQ+hyF3DqkTk4eaSPLHK3SN+9gpTb+jJnPE2wMKw3v41TIsbz6hCu3QshXxEYqDXb9tpdOJgNx0Lfrp4l0+6wuNnA8CEPVMIKb8jLsETwOocWbUqLbR6ayL1b7RIw6HjojH7P5ctVtKSaXXjv2JfmvAoY7TQLbOAmpS0EVnUqcodN9JosGE1b4f+Zuec9WgDkuGtem7l3Kx9uLb3tVWYNcQTaJH6y6KlQ4GCvm57XLxx5X/A8e+Sp8k3f83qLpZRtPp+MfEdWmCobDy6My4R4rNBY/Kfw023S6TrEuyMoQyMEk969FAv/ygBrwIDZroLGkKH+uSMoNQ+jTw2pTos6MgJZZfewaCfuKDyMwl04H0YnwDR+FPDeyS/Ke+fLxXTlrau7x/z5IvT3fOozbnvpQIhPDNp82WchNbDfLJG+wIK3D10yz1yYqOFBPv7WPEsHJns5zVo7XGmb7zSBBOd6TZmLE8duy5T/VhOeVR46QPJ47PX3Bz/K7AnSykxWF6ryO8996OWZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(86362001)(36756003)(6512007)(8676002)(66946007)(8936002)(316002)(6862004)(7406005)(41300700001)(2906002)(4744005)(66476007)(7416002)(6636002)(5660300002)(6486002)(66556008)(478600001)(4326008)(37006003)(54906003)(26005)(186003)(38100700002)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUfIAmzxaaBG8SlQqTLIDmXTxkPuciPa1Lae3iJMYo4dI82nqUeKhx8/x9iQ?=
 =?us-ascii?Q?lvr+qV9hDcy+WkDorMkWlj+r8O/lpFTzJLnvTs+JJIT1zpPAzyJc2wlQYjSr?=
 =?us-ascii?Q?Z+xQscoUF4EiVkepehbqUH5Ubv6bUn0OnkoL7/irEWcLTKmuo/AA+iDVc9Ps?=
 =?us-ascii?Q?6Dpsyd1ZPjvAHe1N6uFSI9Ne2uDtWK2egQJXryCrp66Er5UqvAVtccjvKYYC?=
 =?us-ascii?Q?a7fu2wv5YMn6ofcObiZPeTTQ3riijW2/8jfovywzRzEGVyovzxAUth30mfV2?=
 =?us-ascii?Q?Ona8V6lq1A2dQOjbBLJ6LX5eqCyoTuij8cZsdLNjMezdxiXzJUqGJjcqMeiT?=
 =?us-ascii?Q?FRVueIAQPuOU6q7RCUyjqcYYtonkq9DgBRrkk92hbjq/t7txpfFmzwwzbI/f?=
 =?us-ascii?Q?NEmwOLlFzSOWr3MC29j/mGdqm6C5dIQAMmzV/CzRvJzwX33BVewoMjDRtOdL?=
 =?us-ascii?Q?YFbJOaRf+1Wq3DomHsuCT5dOfEmrEAVhDD7QQsdzvX/nGQglbfPSiCUfwPXo?=
 =?us-ascii?Q?MkNb4Sm+0GfUpmUw7lx29pEm1Vlr/FcAZQA2pH6WS12vdzspGhBvshWfRUAy?=
 =?us-ascii?Q?QINKjK7j9NrLTvMmHqzIinVsUtlx9qlgZorvS9QlpwsBU9i5LqB2+FrgT8Z/?=
 =?us-ascii?Q?LwNOJQG+QJADntS1qMubbUOIZh121v1S1cV8tt/X35Sv2cnV3Q6TWk4Uxt6J?=
 =?us-ascii?Q?EEgLBk4PLFjBkIaqqAXf8xpmrSrxI/gUyXrcUu6BNN6P78GZxaGOWd1yFGch?=
 =?us-ascii?Q?d6nL5xEfIIGgVfHM5OIYGer+TSmTEDcqclkOB2PD5msyXso3VZR9YcB80lR2?=
 =?us-ascii?Q?5N/lPZzs84wrfZilBEUjUuS8YwS545ydrtS0aEP+9J5kptYKD6TXz93axpvH?=
 =?us-ascii?Q?Nnc2ZkxuGQkF3k5DZEWJnh+qUdw7QHT3YcSe5UnKN+vYo8TJwsO3Nas/tOT2?=
 =?us-ascii?Q?TqBbEHim6EkXgzKka6wkIye60hh9qaSGQxCaGdSlbV/ABJ2YnHRBbSG/peYQ?=
 =?us-ascii?Q?Q/ypI9SNmz2t0F+Ri6j1rxowa2x4ae3O1oRVLxEi/Gdf/b7bY3c1FK1OKv16?=
 =?us-ascii?Q?Kln5jfa3vFlFK5CH8ZH7oJ/Nsv3SjF7KE0JSNEBU//AZjYwz0zBeA5aTbJx+?=
 =?us-ascii?Q?WgpSVdPK8Bf7GpcSYQX/QRGCyn8GgXNwn4PmCq+mJXeGjh8/j2DwL6ik6qk/?=
 =?us-ascii?Q?rd+PpRFupWwWCeQtN8dbgSaOnneaa0s1uNrzmd15G+Jqm9uK2wwwj3dlht7m?=
 =?us-ascii?Q?sG4iRY0gaHfP70PSgvIevxOcxNCH+pNBP38zyvUGjte5I/BOqlJ6vkTtkCcZ?=
 =?us-ascii?Q?69d9MHpNMSm/tX8CnxgbQXWuLt3xGr/b+kK55vArnbJCGDCBw5ayrb2SZiDh?=
 =?us-ascii?Q?u61GGi42gj8N7EawipRPuKvXJ48ZHDc7kW4iGE/58LVEjX39Md3JPiN+mwxI?=
 =?us-ascii?Q?pMIpbZI4klOm7oYkA6wmFeIxzKiSDxWkwd76EHOeQsFSIdKNl50FxoDBbz+9?=
 =?us-ascii?Q?79bQsJNv28TUyy/XD4rIMT5/8jnO0fvB6Ea5YavrEnCOPz9JrCugNjpr/g8u?=
 =?us-ascii?Q?zm7AMGiEOqiO1kaYeFY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d019207e-e758-4490-2be1-08dabcd441ef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 13:15:05.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhqGtOSKd251Pdy1a3xQ1C0rP5WDdl/Y4iFKpMqpdooHGVGvp/JJEQicoLjHbmD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 01, 2022 at 12:45:01PM -0700, Nicolin Chen wrote:
> On Tue, Oct 25, 2022 at 03:12:23PM -0300, Jason Gunthorpe wrote:
> 
> > +static int iommufd_vfio_iommu_get_info(struct iommufd_ctx *ictx,
> > +				       void __user *arg)
> 
> > +	if (copy_to_user(arg, &info, minsz))
> > +		rc = -EFAULT;
> > +	rc = 0;
> 
> Coverity reports a value overwriting here:
> rc gets -EFAULT first then gets overwritten to 0.

Indeed, it should be

        info.cap_offset = sizeof(info);
        info.argsz = total_cap_size;
        info.flags |= VFIO_IOMMU_INFO_CAPS;
-       if (copy_to_user(arg, &info, minsz))
+       if (copy_to_user(arg, &info, minsz)) {
                rc = -EFAULT;
+               goto out_put;
+       }
        rc = 0;

Jason
