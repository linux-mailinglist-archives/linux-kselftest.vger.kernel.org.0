Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C43C6A5A64
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 14:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjB1Nwe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Feb 2023 08:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjB1Nw2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Feb 2023 08:52:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F592E823;
        Tue, 28 Feb 2023 05:52:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvpPnOnlZSVI1w7K77A68CleyB4uos1db96GoeFP89bAlf+J7XUrgptUycic/A/cKAKmfjnYaNReboRq2lxVEu++1bJe8Smma/G7zxvMffqnqL/fO0L9xxyd1cnKp5DCsetOIkgXqtC4cQDpOr/4WNcZK+br4w+4NZ9utmaW4oCV4WMeh8fxBTS96B4Alxw12Gf0bOfznx9KkGecudG6PK6JdCd3oeJktdD3qU5wlOZY9sgWElygEKnhx6nEHX+UR/IW7H4DFZTgFWXzlW7x/Zze/jUTQ1vPPLhy5k6OvT4lHNXQT7BkzLVr7nm/hX3iM+zXL1VXzjvV7a9bSsZ6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ6LqF+h3A6Gb2rqvtIujvuohfPhK+OmYw2pXTO/YLo=;
 b=Kq+7IuplYAjPzCwKEggA7pVd51iMSuRiWG23F10L16Wxr4lVkT+vvO9m0XCS/axoCkyH0fhLpccwrLRyytkB3+CCGyaeVgEy7pBkXboahKtcmaTzcjvHq013Xbn5XPIzK2r1w7VGJsb72CIBMlq4H/x7YKGjzWDprIhT4dooZunuo10+OVLaKD9jm2QMhuir3Pnl7b+DsQAQz0xBNZP499ZX+mgY127lQTzek1pVynXwJO/EmCrlMrkX9WqHrM21jC8Bk49SiYNoLY4cJ0R1dDGSnOeBsgO2WXNLBv8dTFbNb6uwKO/DgOoNzBNBHfJznC3NQt0eRzJD86v29EB1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ6LqF+h3A6Gb2rqvtIujvuohfPhK+OmYw2pXTO/YLo=;
 b=qFVqbJIFGGtsfvzuXpFb7fnATtv8KN22Kabx6zL1Od6rn1fel4QyGheXrZWiWu4ZMaYfI8wher+qloyN1z6wXcdgRzmCaovizWWJvjWmUThdffbCpH6bpJiQWRy1PROKF/qkY2TbIlNjNvAtPa85bFG5SOZa2VEl3V0WF56RGuXNMBY7IhbmEFtbRq1J7UuzLhlFJiy3mSUV0AGDAYdEP0/MMwUKDL8oqKWYtzrLDjDIsgHkPqRcH0g+k0wZxyhDzlMivdXlO8RokGh2ES1FUt7fROLX57jY9kck/3Nir2v+vDM9I/XNmG4LklM26IwqFL1vuirqA34mMvf0KudjYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 13:52:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 13:52:24 +0000
Date:   Tue, 28 Feb 2023 09:52:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Message-ID: <Y/4HF2bc/uBydmgG@nvidia.com>
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <909ee61a-9cbd-eda1-89a2-349348eeb735@linux.intel.com>
 <Y/y3fnSJZB7QhAKM@nvidia.com>
 <322462b2-a3e2-31a3-d520-34fe1467b26e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322462b2-a3e2-31a3-d520-34fe1467b26e@linux.intel.com>
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b84aff8-1972-4aa0-a6a5-08db19930576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bOpsMJSAlNrL2FzOapWaiDOOMWUtGRLyH17JxwAbJLI41vdjV75Ov93GmmI0Tmi4C18Xj4Lgs1YhvMY0speS7U8H7Ois0f8LDNAvsa6ChdQyeIFksNL5J91R+FjrFLxJyZtUVlU7U8GzF1o42Yu/z78S/F/8EtQ0ePxQDToFTDnsmC35KvgLRI2qombjobXY86l8oZOVzS8ow0AOrcb4XBofyeGLDTvCZFiYk/ke17EajGF21miwV4f09AjcaKtqnBpVYEHxYZj9/deFif5MejTkNjJXJ/DcGvsibON4tXdaUUqQWfJs0HMJt6MjZ6ANcRDHCgGUgUE06g9W0DaDDUQdyw+jBF36BNTZ5PwCx5YSHLfcUgreAHRZob498rJ4MXfakYlpq353+wSYcyEbWjdCvj370asZX20mKWF4hR1IbKtEQUSTUrVG7tcQ2BhpzellJmMjFK3p8zCyzTDxRL9YHhborFO5vOMfQAzrSUUUtuiFUcQSEsSXpGw3t8HGUvddRlqQR/4QLeOdCuMwUaQLgb58iPtWckpika/sTssTS2rAQ+zBWMwx9Ia56krtJmvy58bzt2ZcIMVVJlCjr66yBciyH7Hfki2R2XUv5qJmZ0ZUeXWYsvVcSkCeOIuNVymX94RaBWzCh+BZLGePg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199018)(2616005)(6506007)(66946007)(38100700002)(4326008)(41300700001)(2906002)(6916009)(8676002)(66556008)(66476007)(4744005)(8936002)(26005)(186003)(5660300002)(6512007)(6486002)(478600001)(316002)(36756003)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FK9pCDRhJnNVXnPShQzRlsQjDBrij+u97IT8XGaR6jrRa/pwzjO2A2lGO62D?=
 =?us-ascii?Q?KqebP/p9ozgCj7btrklCg/jFnKnrl4Kas4OlELYEtzUbA/y4zpBOwiBglO7h?=
 =?us-ascii?Q?tq6fRQS/mfi7bCxlFJCG/09LrwzlLI2GZYIRY2Vy7J4oiRcoctLEspItiO8I?=
 =?us-ascii?Q?CxCs5U1/RVp3svmx6BGUwvulEjxc/2Tn6xpPsyfMbHpfcgcm6GO7/OlA8Hza?=
 =?us-ascii?Q?hlK0Y7dk4qsIpIa02Zy1XdIbUD4X5qSAp/gcNnRtaPVz2Xlf4KGRvEf3twNy?=
 =?us-ascii?Q?ex5DY11j6lmMqnFrBNELYUohFxOS0oulHuuNvL2cMJn0gC7XK3kjKXWGyy51?=
 =?us-ascii?Q?/HRdNfQL1q0PTroivavwOpJRlQacDcaNXCYYnHsy+n377c/W71UiFAgpB8sC?=
 =?us-ascii?Q?786btn+7kGl7CnyrizRYigNyYrPreUj4+lv/ZwW5uJYyaNZ8FOw+16MlNqu5?=
 =?us-ascii?Q?H4c4d+BnFb6sbtAKMjGeTpbx5h8Ewm6eUfkAsAi5A2L2lc7aK0YoDUr4Vqzb?=
 =?us-ascii?Q?twTYXX0vnOM6n3TL2x7KI8Hv+QrPpVIln++kd1Ie+ckmGquAzHPkaNhwpTr8?=
 =?us-ascii?Q?Ue4EhcEjI+bZx68Ntq6BqmZzAdYoRH7TWMU8sX3LtiT6Dz5w1xq8cu5fa6eT?=
 =?us-ascii?Q?ZQtp9/y6thqhYPthAbIGVW+BqO99oAS82GXc9GX6pYNMaYjC2dLQOR8VUOlR?=
 =?us-ascii?Q?TEAggid/oyBCzmYk+Zej97QE/Qdxr3OQsKNEkhXMxoLTpKEbG6m4OuSyKJAK?=
 =?us-ascii?Q?ez7ODTRKpYXSPHAu7OSsGcjSE6x1ZRGiQCS/+qYapNdF87fTB1GhvP5h5rGQ?=
 =?us-ascii?Q?dZfPq8YcZCMmaGfTmXpeNA1zOf0BOazRKI5SGEtLjxOYkvSImhoEKymtOF9z?=
 =?us-ascii?Q?Ps5hjGAI0ZqODGAMS5RHXAKedD6GimktC10oyltcE0gXz8YDtPw/BwNzXjDy?=
 =?us-ascii?Q?TPvYT3BmIzQSZpwJHmsIDK+PGYhW6IuePhLiWNWP5v2YBFbsLaoa6EvHt8/z?=
 =?us-ascii?Q?zDgdeT9UstHVwbm8GOW49swk0r8B0MhhQMvVqlYv/w1gonCB+3ni/tMtp325?=
 =?us-ascii?Q?+twbpghJNPFsREg/Qkv8lqA8TqDqHEP0bPdBtwLWOSigDTlhPTtue2btU/c8?=
 =?us-ascii?Q?IPQGHq22DbtJJCfQiv9j0GhLJPB0Rk+0WmqQKvo0su1usjCppJWsawfBQ4iF?=
 =?us-ascii?Q?sWhpQnzydJBNMR/qEjcCOdZ0MVUcT3BNYWgxR+TJApqTde2Gb4C/l7WQmU70?=
 =?us-ascii?Q?OB7uS6HyZg9HY3O11CBtC1DggWS5eAgVgdLbvsNwUaBPKxggCscYHEG2inYM?=
 =?us-ascii?Q?as3QrT19zwgUe/RnMg76IaPz7Q0bKiqHJu5Fa4UMO8Tc6IN3xmJQTjKoc5x9?=
 =?us-ascii?Q?XOZiHnjshGdCbwtXo6iFV+sPVWeBlZ/poDCua5pBZe1Lv/XfiAc0Ks8ClHtn?=
 =?us-ascii?Q?F5SuHAha363zYaFxpZVG382Nz3cGhfnxbvFFts0JMCYP9Ka5bqB71fYJr1Y6?=
 =?us-ascii?Q?Ktibn1TfHWFX+stKFAa1InLXkg79YgUHdgTLmwiFaPlzani1YGLLD0EJMyLL?=
 =?us-ascii?Q?WkVO+RCjBzqoMkoL13O8Ga/LODxP9d009ZhFSNXE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b84aff8-1972-4aa0-a6a5-08db19930576
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:52:24.7324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqHULe/bBgBgR6jOZBbNU4Bu9QAmB24Mk2MlaMy/DwCblbBx9bmfeiktQk0u3GTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 28, 2023 at 10:10:41AM +0800, Baolu Lu wrote:

> > If a HWPT was passed in then it just leaves it unchanged which is also
> > correct.
> 
> Functionally right. Above I just want to make the comment matches what
> the real code does.

It does, on output the pt_id is always the IOMMUFD_OBJ_HW_PAGETABLE ID
of the attached HWPT.

Jason
