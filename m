Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B46B1189
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCHS7f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 13:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCHS7e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 13:59:34 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572185353;
        Wed,  8 Mar 2023 10:59:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZyg56cUOleOzkeh1vZH9yZ1AWB5gUqq8mchNFeex64AoImNRtIqPfDImDRdcmsjZ2iRRG7DzMYSnGXGteox3PC2D8NGpdhi9HRQDAAhf+TbP8pj8UjERJIEXIoe2uayKk6q1at4st8WgNBkTDmf4ykDTN9FioQ8I9qWmdwpNKTH1cVF9pPqTVudG2hgqJOIIENWAGrOF9sdnGu/c0NuwpiYI1dt/K+I198cSZ9pCUH8/lIUmJU35FnrdlbbSKtcNnug4WJ8qDJLmgI5/WgSH1SafYF5jcOmmE+MAuPBNssZBdTtGMraHcWdPxORcVIFesGn989/0bbiHoSv2QYpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVWbkoGIu2FUBppzoP+/jzEZYwwlglCp8Cx3TDJPTJo=;
 b=dVf5e9t76UqCirqRtDpTfgYI6FXh30zrlvBhbDxuwlOy448PjUNND4H4YETgQ5CRIZQnWgn1K3EdU9gMlSBE0lEWZxVgHkfeYJ86gy/BQ6NCKw7CGnMzDnb8WCtUNhBKF3vXVtH/NfOtQMmImmP8GPFxb+G3wVtzZKW+McFaHylQW+YcSIb75Qw+tpP5yORm0EUHtX2NwidKb4nP/wsTfymg7+ReZLyyBNFEMUfn8/cmwA+dirJhPhXbfYUuoXAO13zxDAy6RD/cXzPRHrasZ2dgy4pDFeJQEh+c7iZXwsI0EbdlUPFM586XjixJKS/wb+zzY7BugIr8vyPK+xZT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVWbkoGIu2FUBppzoP+/jzEZYwwlglCp8Cx3TDJPTJo=;
 b=PSsh/AsWBfgaAJmvoyxLvQVIZ9y41AwM2FphnnP08ygFy5PgrdpZk1WHLlFk1lWexCacPOCZRDyIx9+uuITyzw4AYUPwyGpYGXAoyob8LDn8wzhOKCJmTceN2etMSrWBKd19mre/kii6Y83BhzgiJYZlcUNUiCNjY5jGiyjR/1p/eOKf0QF6fmbOCflISu7LTQZZgJkPFK0zheU76aIkIW38ji3EjoAkKLtgN444TfnYYjW+qgZ4Wz8Aruo/5SFJGInB8x+s3cw5oxr6Dlv0vkbFPciRo6h0E5Uqh495WFwFNSrPyvi0d9IPFJpfjpdi+cTcjB/rUZobE/Dsl1am4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 18:59:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 18:59:29 +0000
Date:   Wed, 8 Mar 2023 14:59:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 00/14] Add iommufd physical device operations for replace
 and alloc hwpt
Message-ID: <ZAjbDxSzxYPqSCjo@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52764E0C994D6B2519BD6F9B8CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAcyEzN4102gPsWC@nvidia.com>
 <d441b9bb-e9b2-190d-981b-1fdc288b0a07@linux.intel.com>
 <BN9PR11MB5276580F971F8C90A89F3AF38CB49@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276580F971F8C90A89F3AF38CB49@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2904cf-a1c7-4aa1-f12c-08db20073eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/DB1hP3IEzX7NVdItUMd/4eFcH0wNDz6eoMcPMLs+ntwrCtVXIEDTHBilVrITfAD9iCXsG3nxermXVG/S9QKE79qh9C5jT3vwtPGOakOh0R7RqTGY/pGmwKSRf+w9v5YV4YVKXjnW8X1gSQI48ZP4/0aGj1SQeIqJRqbrA54h7b2nQIvJCBjdWFnp5vNTI2iY178wEb/QYyKTfph6P4rjyjEANmnxXV12wvwjcrTGeYGT5mdcowJe7WPJTffmUsKs31WhDzs+Kp3eqX7kmdf6APlXymlG1la+BNtdSRQS1r0pAx+1YaB0MQmJB0msqwBZg0xzt+/pJu6U7kC/W421icwsfTZU3IBgRVuQskSP46cyPXOVXd6wy7XfVQQcOmnoICpDsGe3iwO+54MRRNhj8oEgDL7o/Xn3hwNwMzO63lld0leCZxzYwkExkInNe6O3X+gf0BURvYiv3NRjmgTPwyI+7Zh5k+XckbxGuiAaHGym95kdzc2ZAaR7lDRoaK43hUnGR6yzAKkRqTLsCU3IOGjZdzPUGbwxpRgeiOcqgR9h4QVF5uMDOwTC+AcD0+LQBMCKoqYZ4cVTMlwfQf1Ivwab1aDbeFXp1M9iMkKT6b0qd1Yp5Ugt632gu+8qwRnV6EfdUhnOzJQg2k16nApQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199018)(478600001)(5660300002)(558084003)(186003)(6506007)(6512007)(26005)(86362001)(2616005)(36756003)(6486002)(2906002)(316002)(41300700001)(8676002)(6916009)(4326008)(66556008)(66946007)(66476007)(38100700002)(54906003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vttoSLuIL77YvvlReZs6QYJfdm4wc1zyU/UR0nvwEKEizn9KTyaf157sgSfK?=
 =?us-ascii?Q?Yqd5Od6PjnOMgybApUXfBzMrlNQRc2Qu4LvRom6u8C7cF0cPRUmo/cwac2+P?=
 =?us-ascii?Q?FCTji9wzfoMw75kmyNFDf7EiKSW0neTkvKnkXww+W0C51M3bdqL8uz7ozHM/?=
 =?us-ascii?Q?UYO8DAJo3Dp0UIuLufLvTTCl5prLOYRbgbnkZFhWJ9rDXgEr0Dv8vDRJvfFK?=
 =?us-ascii?Q?36qpN7qBOJP6Je91vlBdu/kcugh245/IDh7lqmECKsJHAODXr3CxZEHALqEO?=
 =?us-ascii?Q?3vwVSv6hQhyaAYBSH7qPpuNdBBfXxHm9y+2AjT4704HyZM4+xdc2S21zHxPQ?=
 =?us-ascii?Q?KZ2l7B8Wkk5yZ0YKdgO5kYOaRwJc8P2iqTH3bpm26k7VFl5AYKW5qY7jJWmZ?=
 =?us-ascii?Q?oH6dpVf6yOqihv5ndqYNlo3B+Zpj2KSR8Hu4EBm6r4hh9wLTgzR4AH4rO6Q0?=
 =?us-ascii?Q?RTP9x9Vablw/DPz4COJwD/j8vFa7IVdeayG7RMuTbqrXZxra3VD8W7D/Ig55?=
 =?us-ascii?Q?LYt2Gc9VRgsFCLkabPiqn7NIfUouxLNs9oJqonf+1lHsko/UJROqCnVKf/xC?=
 =?us-ascii?Q?AULWBBHTvL60b5cearJgTMCUNpwJI8ABEwKba91xU9aAFopNJg+G+4gZDKjc?=
 =?us-ascii?Q?ER9r2MKvQdmfNKQL9Hf+WQiM1h1ymJ0XQJ5pI4cSQIdDoQddCP0yOQctKka2?=
 =?us-ascii?Q?qh0rubQsjD8zJlLTp/aaw8ZMT5d8rMZLqeviESbGpdiS6Wtij8U47FJ4XJCf?=
 =?us-ascii?Q?z3ju4lvy/z1Ha+ys/EnlH8oDduBk4crBV/W6XK5K7VkrXD1w7IY9K7Wn30QN?=
 =?us-ascii?Q?BrepYBvzLU92Vc3JuQfDc0iMSddzpVGRIUnE3UJovucpt3o8gQ5LK/8722fJ?=
 =?us-ascii?Q?xesZkiMEirU1/i1v7M+xycow5RdtTAvIZ3EtfvQwMNnpProwXGmKTS7jEIl2?=
 =?us-ascii?Q?ZfpTqXUTTxMFa8UpaGePSiUoZB+qVR353WUuWQzxJIr5j8QHpnXh96x0ciBB?=
 =?us-ascii?Q?RoPFkdD4ZHuAkPjpDUdPut0Q5rtlNKKrGJrNUJiS3pbF/W9M0EuFmm8+Atbp?=
 =?us-ascii?Q?Kaak9RBdM69W4qkc0jv02+vjtN04QtvGdGrxOBtBDbcXn6vXDi2ukMKA0pcE?=
 =?us-ascii?Q?g8OGsBehNWIKXSPnh6DTYd8dVYLUiLb701opHA8f+Wygc6yQ+VTGJDlw1Ap+?=
 =?us-ascii?Q?+xt74taCVSR0Sx8g8QjDc1qVPHtyhJcwNmYe4Gl5k1AqDldVZWNK4/7toWig?=
 =?us-ascii?Q?ydE1M2VdGFzQlbzv3tlGuBuwvdVnf7rfy2CmGPYZOFgPPHURyqi4ufasug3p?=
 =?us-ascii?Q?IJsRsTRgjY6aIvFY2VUO5qH6UsqnbKlZNDR/0ckSUByydCONzUFEL6dlxsgX?=
 =?us-ascii?Q?apPTaXLOM000JgHr0185EsxqLPjcUSh/Pyfuk3MsUG17HRUtheyu4EYJl1tT?=
 =?us-ascii?Q?zqNIgTVPOWN6usoaabnG6RwMoElSXsVpAEL1SwPeIpTUSlbPsLDrLCt1WRsS?=
 =?us-ascii?Q?KIjK59+LwXrx86U9O0TN/cprjyqIhwJ5MpDHgk6AqhhJge+0IHq9S0cY9IXb?=
 =?us-ascii?Q?/GpUxdMZCrB8P3bYCnMLyF9gOFpXa+0yQI2H4zMi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2904cf-a1c7-4aa1-f12c-08db20073eec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:59:29.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDO6yIpkvbRRukQQ1mUcMrgKCRX5SrB8D1lH6RW5ZMgL1Um10v9epLzb6SDx8nzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 07:38:38AM +0000, Tian, Kevin wrote:
  
> > Perhaps we need a check on singleton group?
> > 
> 
> or move the xarray to device? Storing it in group while adding a singleton
> restriction only causes confusion.

Makes sense

Jason
