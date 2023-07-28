Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ED7766D7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbjG1MnT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 08:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbjG1MnL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 08:43:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7AD30E4;
        Fri, 28 Jul 2023 05:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZusRoK4i01ObTl0FfbF6EMYJnzH0ulCwn5NLtv/hR3FbjtHI1nM4aiRU70MrhZVKBB4DcjF0QaLW87wO1PMjPKy57OnksRaxyT8fVNormzbCdQupS56Oz8BlVI/qqQaGZdAj7FN3vP6EVan5h9oUzzBuiX29Ca5VQKPhL5sMyqJ74rJvwiwdVG4lCFq1lFm/yO6MypUtvozBzH1roQpWxUl5MRwDfo/Rtzd0Pez8ooehG2IwIal0Foxo4EFxNylZr64pl6NNI+qp9Vc6xdIj1OgziMuA+vvu/aKuJmIttduKrgUpPnmsk2H/rJBZapPWObjRP9jH/KBeCCaQdQo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rw0MH6O2wjTToa9NuBjnzSSzS0rXS/9VWycq6cvmpOM=;
 b=EomEHUbPBR4HGcxFUqqCoIO6qOHPbhh8dwA31t6x5W/hx4cJFXbaWqR20+UP/JJjTM+6pNBVIpBI9zGBSBeZl8jEz7iu30CPXw4/v5g492uJmVwNPwPSdSFp8FHkBh0m3lxcUcrOGONPVdP3iQBZVtt9pczgcIJPxvIclEghnsQOHv1e1NO3Uf6BMr3i+QmSX+fttONmtc3z/f27Lo3HO6lZJfmx9ny3ma9G5lhRJWSkAqFzCKzejPlijkegGuo1JZlcnKDjv0A8DJAOBnuDUn9UBLE+AlYHr0eAS0rlGxo3fWhbCiK29KRUkEIEV87cbnmEf6OpGLf3X3S4WFoxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw0MH6O2wjTToa9NuBjnzSSzS0rXS/9VWycq6cvmpOM=;
 b=snGgGW5RPQB7O+sTwv13OPYm7+Sq4+keZB4EcgNTnFaxbGYwari5RPNXGRnT0HkWH2xP1rnwVNIOVt+aM0PTZNuoV/btjJQZ94Fzk4TayBqKcOILMx0156It9eV+dep1cDysBXbAgREpSOhRPh04IsRtAjPZ2CqIKkrjU5s6SBpb2gk4UinISfMqitqGyBfanRwqj6vHKzG1AqOjUEceAfvgm5gSBLbnrA4OyuwUWpFS+vUcD1+QDiblvqx40P3YIOHu+i1TV/YJy/QviIYdOWzRuaUvhHi90J3lHY6twypt+paKnqqM2ECKjDMPmEankHhElEmy0Jdd8Smj2Z7p7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 12:43:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 12:43:04 +0000
Date:   Fri, 28 Jul 2023 09:43:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, alex.williamson@redhat.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mjrosato@linux.ibm.com,
        farman@linux.ibm.com
Subject: Re: [PATCH v11 5/7] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMO31eBm5/vQ58i4@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
 <a3267b924fd5f45e0d3a1dd13a9237e923563862.1690523699.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3267b924fd5f45e0d3a1dd13a9237e923563862.1690523699.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 9885c6a6-ef7d-434b-a536-08db8f682f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hphdBv86Gc2OWcYKsMjT08mJPftZD7sZrmSh1TGZD4BYE/zt2C6KHsfJ8WvwqGCwFWIZ5T9pfQxYkQhQcIndwa0r5rslVr7onGz0j1UbDlVOnCICybqGw6Rs/B+VSsUTZkW2aXIvBau/k6Nbby6qnijomzq9fCGnPcVo6Gv9YIReSZ+lW1GsxXXcblCF3MX3p5KxdY/+f/2M+EiU3E928FXaBNfjxE6StgHiXDOThS9pZEPjHI7kq16uK6dTF4tz4zrurbgc6q7kVrD1wlGq+UPbTf6Z1REWToq8DX7okd9Mk0/95/JmEoWnBgCniRgg2DN4Xt0cgUu1CQFc9Y4Ngbr9MMSLzGhf7x0vNsQ7DnlIokrTqk9dET0LMep0btwsINfo3ddQhhQRocMXBkGjQ5w9Ga3H/l8NR6nhJLSniATp1c0jfdzWlkE2tj5skwFGdYSwoFeFs2+88IdBtUOpOMnQIv1rUJDh+yklFbaguCoU9xKPVyr3CaEm2+4P1/PbYfNSSWynVo7nv4e0Vx1MkCqwwCkzuryHQS8jWSAr0ExGpVaN64fOIjufUoRlg/Nl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(4744005)(2906002)(86362001)(6506007)(186003)(26005)(83380400001)(6512007)(2616005)(38100700002)(478600001)(6666004)(6486002)(66476007)(36756003)(37006003)(66946007)(66556008)(41300700001)(6862004)(7416002)(6636002)(316002)(4326008)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uYHmCU/KRYqF+e+TvMCCaNQiShUp76G/JiJnhi2Zx2t0mdOTp8XtrUi+W7lH?=
 =?us-ascii?Q?/xjKZKL/fFy+f8/M4byFgoTAudOYo8PPy4FuPCJo76ar3uVGmATmYkTh0t9q?=
 =?us-ascii?Q?CUInWsrZL87Cce9BSf7cGxzwyXslWpMDgLde0BUQwsZXlLrMTB9fxbkqPhNz?=
 =?us-ascii?Q?7y3CrZGgIWesJ+RclW8WfiKhjIPeMJe7hE3NNZ8p6H3bIuczYacCFk6wClm1?=
 =?us-ascii?Q?58/i/OXvV2do02JDzGX4BaMpNeSDoCmOril3vcOzCGDQyfiIjKDhEllnD5t4?=
 =?us-ascii?Q?nvxhONj2ZOPZaU4LtI7S/5PvAG02aE1ToB9KIdNJDWj1Yj0B18+nJ5FHcGHU?=
 =?us-ascii?Q?d5VNEEkYF7mfbDzmW+u0Vdn0n7tlXuopN84Et0G0bFsBTNf6+nTiZvRcbr+U?=
 =?us-ascii?Q?a0p9Lpauh851hQ/O3lXKP6ZU3COWL1C07yqm9d9JIsGfD8Qm1+n4NEwG7PdY?=
 =?us-ascii?Q?GKgrsIoHOYL/wotdz7ns4JNNVO6O1SnpKs5Cq+PIUoYlAlfdCoeooca+r2se?=
 =?us-ascii?Q?6MpXqiG4CPVne3Y9xF67QPKmSY5h8veAGYM9DU2l5oTRe1GdIjDmf+QAJvU3?=
 =?us-ascii?Q?wIdd33PfKDnb52SJbF+euhCxEdzFPO51AQI+shoWZbA4SIxoKVaamJGpprPF?=
 =?us-ascii?Q?PsiCRP/w46XaIHT6/D5xQJEmat/ho81N+/ngS3edczF6gaG0gdSV3u3X6wzu?=
 =?us-ascii?Q?E1AY7mAg+If6KDtCsw/XGdlwuZ6EpbsVM7aHFo2/pWvYHoCMpMG0RxQOOAhC?=
 =?us-ascii?Q?dZLmOaky6t1g1l/feju44ctpHMYnPGExxKUmi42QlQZvLHmsY1EJTu1LA8a6?=
 =?us-ascii?Q?7e7CEHk41gj80svfLwUX0N14mG7/FNLTCOeAizD9rfbwelxHqe3yLFh7OLJi?=
 =?us-ascii?Q?+lX7TIIJNGbfKfC24kXwCAxnG1HGyD8MLXtlTo7MTG+fsq11nj5LBvtK4psB?=
 =?us-ascii?Q?HsocAOk4a53PxSwBtdbQCBJY5poQNRMa5e+txn+wsNp3OdMRM6wDV45C5B1K?=
 =?us-ascii?Q?rQxun2XU0paCUn+2Y3+9f9eM8wLf5ODoTO2aEUqT+lmrnUOTLhaWJmrEOp68?=
 =?us-ascii?Q?7Md2GDoPvlUQdf3FnucO908ryITG3Wa/TqtKGv9HuQruE4FQreqKqKCmyRh9?=
 =?us-ascii?Q?SwGAUPurMQxzggP36C7Zk3T97H0i/tAG6hI0uM0LYU15SmEx9ix9ydgfW0Q1?=
 =?us-ascii?Q?v9dskTFEw7TVlQx3bViwsBaG81gfUovh1aN8kPNvnLTyLWT5DQtQfynSA/ur?=
 =?us-ascii?Q?FBZaq8DsZpcMEOq+NeHkHG/NSQiVoc88jP4yO1JyejXZH7kJaCkwcjV9OMWF?=
 =?us-ascii?Q?89Qv7FFdk/ItqeQujO0FPQUkee77nOXfyuduC8tSWZwbTTyrllISRsO6KBPt?=
 =?us-ascii?Q?zr2D0dTcWXcVra5yq+9MakeVe3yaoIwhC4SrVGku5LV99msGX2tW6e4TFR1/?=
 =?us-ascii?Q?e9cAVN2jT7NdutKMI5l/YguZlQp7996KthpiQbF1xqqZ75Z5ZYN/jQmfU1+D?=
 =?us-ascii?Q?jRsBY3zk2hxdG5I6KJzz6c9x8Fmwy6RopBgzfZIe+4OFH7H0iKP2z8MYVtTJ?=
 =?us-ascii?Q?n4f0mZlmG4Dj5Uby/ycYgXqQrllS9q+9J0vPUH6M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9885c6a6-ef7d-434b-a536-08db8f682f9e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 12:43:04.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lE6TsAgIAYtA0DdmVRTLSJZ7f3Xc3RWPKHcVZ92Xcww3hFbfFzuBtT3O8xy7qfhW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 11:33:27PM -0700, Nicolin Chen wrote:
> Taking advantage of the new iommufd_access_change_ioas_id helper, add an
> iommufd_access_replace() API for VFIO emulated pathway to use.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c | 15 +++++++++++++++
>  include/linux/iommufd.h        |  1 +
>  2 files changed, 16 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
