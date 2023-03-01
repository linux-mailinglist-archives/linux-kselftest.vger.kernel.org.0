Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675EB6A7443
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCATaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCATae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77DF5FCC
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUPL00PKbZ3rlk64bB2ilcHutbfOszh37eVM5pWUnt4f27lLRpNiugn8BTKaeenrbXom3cSDcQcOgs94tUVD54XLhau7+7TGnb6AEDj5RW4Ei4kfUaPOoVAI43jIuansLeoL3uXnrm7PNWTX9vYvbqehoSX3wIWGENJ2fZ44B6G7uM8lNEvt7KIJLpMbOanfLNhb6Rp+ED2KFPDTqjFS6vCyWt3oMCH2+KHn4aCiW4SPiUIzGTPXUlMfySRDBs8YS0+cyo6zgJGo4dKWGlE4ZGaR9K8jiFHc2X4RMw58z+diGzfl4RZrrGQE0cataiADvgf2d4iqCwZ4vDOOmY2Wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60gA5gvuE3y89wzlaXgX7fxwtUYaOAQtWTVh2/J7tMs=;
 b=Q9B0i7afBpujP83re1CXFv8hDufIuU9YlPaCRfdEQMqzA6YkXG/2LTol2o6x3pstiITdXiRF//esbf2i5sAUOS3fmMqknf6qZ3h9ptHAFvEz5VqpziEWO6vm1JqL0q4PwS5ryPZbhwR/ufdS0Kn+FXbuc8muhy5K9pv22R5tB4xQHLOaIKWyA4+1hacs4LuJpb8O36P53IxSz422GIC7rrdeoMfvZuuA2+m5QLHdwVSoOhBO9+kjlutINHDWHD0o1NT8M88VyaD7A/Au9e7U/Sh3hMVf615OwIxcfAWeWGdkZC84AbudiRaHNJU7ckg32o9yt3WsH9sTNC3XWuYwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60gA5gvuE3y89wzlaXgX7fxwtUYaOAQtWTVh2/J7tMs=;
 b=DN+csh/maK5XHPaxOB1FTxXaMtiYuK7RFmsVQMTCI7sor+IH+KdIA+yTikyEZ6sNxaEKDMTiAqUCsotAHmWRUt+bDrZU8wfWfJDS36N6K+vW0s3JC+dfJcNWNNHQnFcPWV+ePt08CC2knzQKhgxY8a/N69uNKpNTOc9wdWIyv2YDqpsIHRGgyAdL1rXTN3Eb/v/N0MFIapYi9L/wLUJC2NMzaYYCo2jtE3JQnigQfd8zE7DqgDibw3BzXEzQYasLUwBz8nSTf7vYsSc208wvTSWEtQrozvazyTHT6cz7E+m6lpu3kR66va4irBDptkuCfy2FcUTNXxioS1B/OcgcgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:30 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 00/12] Revise the hwpt lifetime model
Date:   Wed,  1 Mar 2023 15:30:17 -0400
Message-Id: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dc2285-7217-45ae-cb5b-08db1a8b6b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6EWIX78Uc0n5J465/H0JESgcSwK1Ie2hU4OlGRiJjdpuoa+5l/RbVS/2ViuTh5uQOhiaY5CZkLuFew5oJ3dA7pPLrTWCFDkgxu9cIN2L7kTcu08x6/x5QojG/uyuFWzMXs7DSA0Y8A4DrfUczZpTyhCcULCnheiWyL89yLIWxJJuQtedOdUWPrdNIijP2Un84NS/x4TsOQMLX9DB4X2TGLTc/yl4/HvTPzBsGY9Xmm0Ps89yJQULyo4IKDUrI+ZAN2MsSImzzf7TnQlm26nH5AGjwLUDPZv/97DrfKlNYQkxVn/CmsWgPhusgOnf4H6ul7phmGUd4l/mgtctWXsY6jyoHLYwY1D+DFG/2XMpxoqLs3houEjymUc9NeHolWToWJ5g7k/vB8g9CtZBj3F+Aho6BK3aJq1YDyt4ZVqoWEbRLMpa8GE4jcs9PWv5QjO9frUwyzU5Yd7FMqGsvovP3v75p16lk+RStzogWZ6C+YG5k8zXJhUqO+ts1Onqc100iWOI9KUh4sC5FQIA73Xy211S3HWhGLu0KDyHcqtiBQcOeXF4WcRwkNTGq9qU9GjmWJYVIQ2PaOvzve7beMSP5NeijVwm5WNjsqAjlQsrzDK5h/pZnDCSDOtUsFABAVPXF4+hfWwVznWqjszcUXORfd8yE2OLA64p3uGDsakKQ99evXDI7R6AFEtvIHmlp9zMOriJFcDGJmUSSZroG4lKXTQbzRpT6CRLqwwk3orvapyOVPTIoIgBeDN74oe1FU7qXJgHidnUSD8aVt9dQeHFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(966005)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVrPaAhVu5FVP7caodl3vF+hykIn27WZyuYWdiQcN6b0ZBG8Ige7tDteC2sv?=
 =?us-ascii?Q?VekWl+Jy4Om+yDwI9QaGCssHIJzqiWhwct6fcLs0I/tE6IBdCuP8CvO5/Pjx?=
 =?us-ascii?Q?/kmciZGr/t8gaSaX5/IEemEhrCnvPkpeh+mYuYKnzejSUZIQNFPLbzZ41xtS?=
 =?us-ascii?Q?UtZXNxAeyQF0jfNwoUyEK1FvekA4tb1IyLHGizEwO5tTv2HzExUHZqZHopF7?=
 =?us-ascii?Q?o1mxTjsCzO9uAgAbBu2hCK738pOt4bx+DAAD5co3wEDSFpOKy4aXzh4b1uVu?=
 =?us-ascii?Q?MsQb+oH6WmyKp9mqa6OajsOQ9DiJZYsw0z++mPOLB1AsB1kJIzdQvwtzTq+8?=
 =?us-ascii?Q?17bn8CiI5Zq3eYxUExuiQYqSOPfrJZZRFGWUotU4w3n29B5RpSksEWEhPv2I?=
 =?us-ascii?Q?tc6OnQPCBnF46cb6ch8bsI/+IGX/6B0MbbNvZIY1m27kJq/eFgXPG7Z4InXl?=
 =?us-ascii?Q?aG78UlFmgKKdOZzBZAZ3OEj5RWKjagK6gOxntf8c4Gs36Kx52OnY0GUK6cHK?=
 =?us-ascii?Q?Zru4mZAEOl+CroHo8I5R7aObxUyItjMtOqKFyZ6PDjjrVkiPQgcMlFiW2dsa?=
 =?us-ascii?Q?FxuD8Qhe6jjMSEvrFv8hrA/apdVrRXZO+ABhwx3KlQChxHnjnxQ9nTxidtuo?=
 =?us-ascii?Q?ZgFtF5Sqbtkbl3rujMhToy8dPm3SZJXqCsba6HHeid9ugdc94ZhxRCeAEuu+?=
 =?us-ascii?Q?Fo08Havw1ckXcStFIFyg/zhenTG5HzVWtA61rgK8UYXFWOvcyroZYGJ4Gd43?=
 =?us-ascii?Q?92aZv32HfHb9Mm3X1F4uZ8VDh2PEOEl6dNes7R/UIR71O9yOHazM70EEwRZ9?=
 =?us-ascii?Q?w80KkYuFNBB7FV185u5kDtC82XAjuU3630/7eKUnn5rSxEIj/5oGWYODkcUr?=
 =?us-ascii?Q?Xjq0w4XZAuT5ZzwrhVZGmn89f6FFu/QuMFzLBphRaT9kr7VygYCYwb4mmeC6?=
 =?us-ascii?Q?Kw7fuc29ti53jQQ5TMG7sinOP72ZShnJDQ9yc7W7FLHGE2l2i2BGAC/lTrLI?=
 =?us-ascii?Q?+gca/CeFo0MJ+Uq8brbc8s3bSuQQyufUemIBjREDvEU0tsW6HP8AWedUwFoh?=
 =?us-ascii?Q?MwNAD/a/2uePxyw84H2gqm3oEtQowlUoRoqtgaMhDiRhdy33ezOX2LjPMTGX?=
 =?us-ascii?Q?omCCblzdkh9YZqNU96s12uO52+k62GIA/pBHQx5pCusY/frde4AM02ii9Fbe?=
 =?us-ascii?Q?0zriVeq1l1nNJ9F+98XD+0PMXy36FrGG4KyadWx7KQrU/300Uk0gOzVrrg2D?=
 =?us-ascii?Q?PA7ZKXc/jGz7XrODYtC0alnHw6yoSxATpVM4X55OisHin/3QH4K8h0JPzqCK?=
 =?us-ascii?Q?9DRnnK09vM/htl9XMRyyWo/+rxmLwHwqkr4DPveA3CPumJlixJil3Z3dYyUt?=
 =?us-ascii?Q?iLzcQMm08JlFhbZcLKjZr3e9X8tgskwt8RvSkIUsYWbFfrG0fq/LNitR2uDS?=
 =?us-ascii?Q?MQILCmIC8hAZfn1h+XStBc9PbqOjdVSEJmf3Q2UuEicKq8qApY68UfaAgr//?=
 =?us-ascii?Q?Lt8M4Ax0EZ5jTufUGioqI/EM7/pDSArlJz2ICD8vKpS/fD3tgBzed/HZ6M9Y?=
 =?us-ascii?Q?+8BckQMXnjZOVuxNe1y/oWsas7vQsqGZiqV1BQIy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dc2285-7217-45ae-cb5b-08db1a8b6b57
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:30.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxZoLFi5M2Jp0h9ijFoPqffBPsZXsUDxtzmBVFLVXaC7dM+J51DDeEa2U/P2fQqt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As discussed here is a small series to address the confusing lifetime
scheme for the hwpt. This was some leftover from prior rework that was
never fully cleaned up.

Make it clear that the ioas and ioas->hwpt_list are associated with the
hwpt during creation and never changed until it is destroyed. A hwpt with
a positive reference count is always valid for device attachment.

This also improves the selftest handling of the mock domains so that we
can implement more testing for the hwpt model.

This is a step toward the nesting and replace series.

I have this on github:

https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

v3:
 - Split patch to just make the hwpt_item handling consistent
 - Remove two confusing comments
 - Four new patches to clean up the confusing 'domain_id' in the selftest
v2: https://lore.kernel.org/r/0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com
 - Basically completely different
 - Add a test for HWPT cases by enhancing the mock iommu driver to be more
   complete
 - Move the device attachment as well into iommufd_hw_pagetable_alloc()
   so destroy is more symmetric
v1: https://lore.kernel.org/r/0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com

Jason Gunthorpe (12):
  iommufd: Assert devices_lock for iommufd_hw_pagetable_has_group()
  iommufd: Add iommufd_lock_obj() around the auto-domains hwpts
  iommufd: Consistently manage hwpt_item
  iommufd: Move ioas related HWPT destruction into
    iommufd_hw_pagetable_destroy()
  iommufd: Move iommufd_device to iommufd_private.h
  iommufd: Make iommufd_hw_pagetable_alloc() do iopt_table_add_domain()
  iommufd/selftest: Rename the sefltest 'device_id' to 'stdev_id'
  iommufd/selftest: Rename domain_id to stdev_id for FIXTURE
    iommufd_ioas
  iommufd/selftest: Rename domain_id to hwpt_id for FIXTURE
    iommufd_mock_domain
  iommufd/selftest: Rename the remaining mock device_id's to stdev_id
  iommufd/selftest: Make selftest create a more complete mock device
  iommufd/selftest: Add a selftest for iommufd_device_attach() with a
    hwpt argument

 drivers/iommu/iommufd/device.c                | 149 +++++--------
 drivers/iommu/iommufd/hw_pagetable.c          |  70 ++++++-
 drivers/iommu/iommufd/iommufd_private.h       |  35 +++-
 drivers/iommu/iommufd/iommufd_test.h          |   2 +-
 drivers/iommu/iommufd/selftest.c              | 198 +++++++++++++++---
 tools/testing/selftests/iommu/iommufd.c       |  68 +++---
 .../selftests/iommu/iommufd_fail_nth.c        |  38 ++--
 tools/testing/selftests/iommu/iommufd_utils.h |  16 +-
 8 files changed, 368 insertions(+), 208 deletions(-)


base-commit: 8473685c99683f9e2c7e2a42ef3d3f14a79be274
-- 
2.39.2

