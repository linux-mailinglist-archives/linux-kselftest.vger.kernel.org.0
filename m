Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276216A258C
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBYA2P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBYA2M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:12 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F618B25;
        Fri, 24 Feb 2023 16:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBkj6CjfhBHjKshAivf4mIGo2u6axRUTwdTR+Dhj1ijbdi4G5hMTfQE5SecBBq43rTXyLF5xdoecEeDavJKVrT+lBFQYkpJGAo/giXe72ss1KK265JOefhL3BPR7tIK+PRKG3idDfgT7toe750RNXuwWFvXTcF6SWKQ0a/HiJmPK2vIxCWce2FBaYL4wbnjyVS7s63e+C8vNAj2Qoa6LF/gKHjpNH0TXKGVs1BR6KOyabs+PIg9XmrepMXsxUO3aE+jaboKcIUNyvNi6WlUl4D9zlqFs2uUkc5XJx481Ww08OnWPy6isrMuCCemVxhm6qKBZPbDPcSWIcDvnvaYxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zZyToX+vqatFFYVHBK3thKEYjf42q4vRD8Ucb7WcpA=;
 b=FtHRY1FF7xkK/akWd0va25FHbQCVvaDzYg+Kvs2yye77tvQ33KX93BxlkyDRIfzDt7QwxWsjPcloxQUgf0nPm9VIv6v55Q90dHko7ihfnphphFiOvPAdaIbSJc+dzHgxB1HuhyiBWtwFTGFw11IQcgAtycEN7VUH8EVMES2/unEp7C3z/d2aVEUq5E8iOR4U0OzEe/B7O++f+FGia+3Ipc0u/WCWMJfE6uAf2JG8otmQzNdLXT2RWynfqpMMN6VRioV9t2YOmPPhV3nqepeGVDQ5qE12Is2VLhbW1S5nlWFLwf72lZMUuG8FR/q1O7gCvq9UDVILfMgAnfGyYB5cEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zZyToX+vqatFFYVHBK3thKEYjf42q4vRD8Ucb7WcpA=;
 b=rizj9yJuXL7RojiULGrgqHLi3+cSxzL30RE0DYC3a2686CE4sryX5X7pmQgOIJehGbCnepu7XwGR3xHC79afnamENLK1yhUX54pGJBq3fiItF+shF1eqhVTy+PiDrcLdXd9m4ybzX1j9h0GUNBRsvmjj3+bAFOwjYdAhP/kZ7qvm0htpubaaBeKib/avG0KKjPFqU0BjnMDtJDMLU+5f/t/i4w8Mf6DaBgCBthtTu6zbiku82MFREiTv/dKeTKWjkAX7UzFbogxfq3yZ/3Gw0BSGETGsL0eRe446Qr8ZB5gMBUPcDbeeL6Vxh9umj5eGDDdUjyCjzFUL04jL6JuCuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:28:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:06 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 00/14] Add iommufd physical device operations for replace and alloc hwpt
Date:   Fri, 24 Feb 2023 20:27:45 -0400
Message-Id: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:208:e8::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: 61551ade-d863-45ad-8975-08db16c727bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBBQUDkOO7fX7GiNc5kdMKMJZ4R1g939j6Mu7W763lyveSgxBctAWMPBoIU2xw0UAbx0HN6IB/lQZTUcZ99KEw9mNV/bvChbl0JGbKqKczysr8A/q5u86jePSXN30mdVXnOcGL7NyjUJtnvM9q1TEXUdETTSV3euDqhUY9FPF/WeuwTqO0f+sl2s6Z775Cqkw9tR9I6xJuyxvG8IujJd6Pt7GdrCTdbDKzUZgK7tRf6VZsZX07dhHAGvNtcIdgxmdio8FL0szBGQaqv3zRhL9TTFo4GRQQcj+szVG4T+qrFB/qUwxoyhbTYhs0fPHONEmT+qXXvUVX1E14a0aUMRvjFM7DwcyTynIT0NlosoymY3HxMFljKSBz+mUEwdphmRfJhttbiCZ7GKiaoEey/ZvC4twDUlqOJYUuIp8A3LEa3L5FvwJAfJD3sImIq9N5/c70Cw5+84+BaeVDa0yv9gQ7HL7fhHoRZcCTCO3eG2o21CbXVbiAD1B+0065+Sob/mqzgEMho7fOa9xXC+OPnaLH3t5Y05mTnf1XxUDd4d5yFyL4vs/aiWQTY0H+4lNOY65ZFCz4KjriEFFROmB3ujoBC3aqJyvM1DAC0WpjuYoyxW2zNLInxDgMYLai96Z/VWHviKIYpq5jMmN/3EX0ADJVO5wsRs5sekpFaAHUGzMhpxr6VR1A93EpQKPR6YjDu4MDrIwmrhLgaDcR01lgMJizaemFqV/1Dh/5JxsPT3qoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(26005)(6506007)(186003)(6512007)(6666004)(41300700001)(83380400001)(86362001)(36756003)(38100700002)(2616005)(66476007)(66946007)(66556008)(8676002)(4326008)(2906002)(8936002)(5660300002)(6486002)(966005)(54906003)(478600001)(316002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mak12T4OdGIf02E8Y6i8kV3WJgt3lUqaYVO5ihDLSQibk80Z8XN+VBk1QXsn?=
 =?us-ascii?Q?QlKeqsGn7q+d5Ep/DgsmChCbCZH0xGNBtStc8hWPra/08bTp98m/+BssRbiL?=
 =?us-ascii?Q?ejswfjt0FvSdgU4rPvrXfTQe6q+3uqIu/h6lhXRX3C3ClNk8nYXX5iN37bZr?=
 =?us-ascii?Q?ouHsA+Su914eb7pt79objuE955fxD9Q1FsX0pkdjpIu+qtVkGvVlJ6J3YAfk?=
 =?us-ascii?Q?JJYtdIdWHjABO9Wn5GW5irhp84cYtN2PiEaT9Aip36P3WZbmxz9lq8bUswSm?=
 =?us-ascii?Q?tVqKLrppAI+gLOmyZhD8/pzabo3rYBBofI+pvrhmnRK6N5GjDnIowwJ64D+M?=
 =?us-ascii?Q?W0WU9bu8FRXbhvCG6R9N3SfdipdFs9w7f9hRG00V9O+24i2pk1Zdh6FrmAvy?=
 =?us-ascii?Q?9/xtZDb1q4mauOHeKi7tJ1R1HQXumpT0+M15fKX9XxJ3GwIg6URPMJNf6EI9?=
 =?us-ascii?Q?uK7NV6upRk6wa7VjzpD+Nqec063I/7ftcU03cLb97IALb+F6BazhCuPyBVLW?=
 =?us-ascii?Q?A+UV4h7yo1+FmUljELTLKcnkX3/isud0xYoPC4whzEDdEk0JFZSTsm9EyhLE?=
 =?us-ascii?Q?b+RY/aYs2YCc3V+a8OqWYuGQJRLl6zzutxU0pE3MjW6mOTck4JiJBUqdGZGx?=
 =?us-ascii?Q?SxL3UCKTzQxT02cG7MU/O1bZrGJ7Uumux2WsM09nxOYEqw1e+1v/KZlCrvKu?=
 =?us-ascii?Q?ubbKoyeONZ9KKdTNQx15XEb+yLLeRp3ClGHQaT1pClL5WruvDUWbKZUcJgYn?=
 =?us-ascii?Q?AMXywRp87sUKwTtl1lgDCOSR0Tc3/+9ySMNasfAqqUcpcuzoQOQHaKBtB0Ys?=
 =?us-ascii?Q?d0wG8q9MfQNk0JRoROQaaQUDVs0EjpItELEk+09148J5yNKOCWeSbQiWjCsM?=
 =?us-ascii?Q?R2siB7g1efrPD6MvpqRPMN+tB6dkbuheb09JMtuq2Yeb5ghOizx3hv1z6lmb?=
 =?us-ascii?Q?nihprJ9eRe8SZGH3P6hAMc2RYGkkKjXOJrfnU8vUoawqL4B0Euf7Tnm44DZ8?=
 =?us-ascii?Q?k2JMqx9YHA/x8XgP6XxmFO//ajsdBCQ9rp+/nXfUVaC9lPpkuTUQScUkxT/f?=
 =?us-ascii?Q?rcD1bHR8bDarZ0Z/9RHrLc0Ho632Klmsyhd4/ghoTdBWHOAgxs49zz6HDKaE?=
 =?us-ascii?Q?mvpGQp/O6S3CgsZ4Mcge2BgaoSgGwbyKAfFJTyVSijaHFHmn7SyhfFQg3S2j?=
 =?us-ascii?Q?c3Zd2xUA+rk54TEAIJWHaHIm3ix/XZ+bRH2A8ey8B39vQcrLzObh7VEfq2V1?=
 =?us-ascii?Q?9Ce87aUubutMq0XPYWafBM9VLTIOpiAPm/LOciXT/mBmxm+t8tNxrPftAhgv?=
 =?us-ascii?Q?yTL9hFagJ2XC1llVrjPj5c0oaDXn705ogMloAFK0R0Knc2sQjd7fNeBka7GR?=
 =?us-ascii?Q?FiXNyzTfJVwfqR4qlqfCYfLLnrGOpQz3reQRRe1FRuEXhMQqKbmsH2+MTqcn?=
 =?us-ascii?Q?RXxkNo+qEID3+p5MBo8+JKQgyp6WbghK/lJC70RVghTMoRQ0FsMAZ8uzccEl?=
 =?us-ascii?Q?uAGLaTSkCwIJs9K2LuwBJ/r4syC2P96//Mj7YPWQvp9vBQuiohDelxCwajEJ?=
 =?us-ascii?Q?Q++kjGT4awBHp7oorIVww/OlOIX9YHGEtoxiRCCo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61551ade-d863-45ad-8975-08db16c727bf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:02.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txA8nvOcsVhKYob/ODFZCdMQBnw4Dc9jDqTUPisbqf7yXAg3ahTHSRYrJ/w9AqVK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is the basic functionality for iommufd to support
iommufd_device_replace() and IOMMU_HWPT_ALLOC for physical devices.

iommufd_device_replace() allows changing the HWPT associated with the
device to a new IOAS or HWPT. Replace does this in way that failure leaves
things unchanged, and utilizes the iommu iommu_group_replace_domain() API
to allow the iommu driver to perform an optional non-disruptive change.

IOMMU_HWPT_ALLOC allows HWPTs to be explicitly allocated by the user and
used by attach or replace. At this point it isn't very useful since the
HWPT is the same as the automatically managed HWPT from the IOAS. However
a following series will allow userspace to customize the created HWPT.

The implementation is complicated because we have to introduce some
per-iommu_group memory in iommufd and redo how we think about multi-device
groups to be more explicit. This solves all the locking problems in the
prior attempts.

This series is infrastructure work for the following series which:
 - Add replace for attach
 - Expose replace through VFIO APIs
 - Implement driver parameters for HWPT creation (nesting)

Once review of this is complete I will keep it on a side branch and
accumulate the following series when they are ready so we can have a
stable base and make more incremental progress. When we have all the parts
together to get a full implementation it can go to Linus.

I have this on github:

https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

Jason Gunthorpe (12):
  iommufd: Move isolated msi enforcement to iommufd_device_bind()
  iommufd: Add iommufd_group
  iommufd: Replace the hwpt->devices list with iommufd_group
  iommufd: Use the iommufd_group to avoid duplicate reserved groups and
    msi setup
  iommufd: Make sw_msi_start a group global
  iommufd: Move putting a hwpt to a helper function
  iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
  iommufd: Add iommufd_device_replace()
  iommufd: Make destroy_rwsem use a lock class per object type
  iommufd: Add IOMMU_HWPT_ALLOC
  iommufd/selftest: Return the real idev id from selftest mock_domain
  iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC

Nicolin Chen (2):
  iommu: Introduce a new iommu_group_replace_domain() API
  iommufd/selftest: Test iommufd_device_replace()

 drivers/iommu/iommu-priv.h                    |  10 +
 drivers/iommu/iommu.c                         |  30 ++
 drivers/iommu/iommufd/device.c                | 482 +++++++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c          |  96 +++-
 drivers/iommu/iommufd/io_pagetable.c          |   5 +-
 drivers/iommu/iommufd/iommufd_private.h       |  44 +-
 drivers/iommu/iommufd/iommufd_test.h          |   7 +
 drivers/iommu/iommufd/main.c                  |  17 +-
 drivers/iommu/iommufd/selftest.c              |  40 ++
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/iommufd.h                  |  26 +
 tools/testing/selftests/iommu/iommufd.c       |  64 ++-
 .../selftests/iommu/iommufd_fail_nth.c        |  57 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  59 ++-
 14 files changed, 758 insertions(+), 180 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h


base-commit: ac395958f9156733246b5bc3a481c6d38c321a7a
-- 
2.39.1

