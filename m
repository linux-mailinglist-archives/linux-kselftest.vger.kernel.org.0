Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0FC6B5194
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 21:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjCJUP7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 15:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjCJUPo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 15:15:44 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA312D424;
        Fri, 10 Mar 2023 12:15:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIrY7pcz1uPFlZtqHq8OIwyl7e1koKvJgIil1vI3o8aWHIU/y+LDag5wCfNPPTsW0kQsF5BpBopEf4InNu5DwOJlQCJ8/USUuzwdzu0KGxQ9Nzudy1jE/KX/tkr7cuTmI056lGOIgV1yLXEQmMPinGSMw3l3ZG5wZHPg2qXF+9L0t/LLVF8C58+VwaPJt61rW87ULVnZJxmzkFdi6Q/26fqjDOYAiE4C3x2mqoqs2yHwjMn5WvrS14/61j/VjMIh8vspfMGhiZn1VZAoyCOhZ0ZKsY0cpRsfgT+SCf0QDXVeYEfblpRUdUvsa5CD1168yaO/SFL8jIpH0i/2ufSIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzRa/YSW/ZmUcQnrDoCXMw4dVcIgcaZnjhmasHvr+WI=;
 b=XuLeK2v6s/sVEa3kBN5QUxuu51MzNawfmvJj9Z3tIrrw3J6X8UFpc4raY0Aax2g4JMSwDJ7Nt3N4qQLMIX6EQd0E9pD2JGK9HV0upOlpgPVhiGxhPMhpU0wVKaEtz6Kv+kaq67+n8mlLoFfYupVYw+wd35EhOeTmNzXlkAKpXNZAopTwZwik8k1yC1visj9ZNn11mpq9wzM5lwzGY+wvqO6GtanW9LYN8f38bcO3JQBIdLg+4J4TZRUFRYnUAJl5yw1gzzuNNC0+4lDXPZx9np0/bxrPhFbMO0xNJVqpXlxZFihBwRjUarIIMPWlL25d3N6hWCFfBl9+/r15h8cu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzRa/YSW/ZmUcQnrDoCXMw4dVcIgcaZnjhmasHvr+WI=;
 b=nVYP64V7StmZ6BcwU9zxZuOgFQMBv/ty8YeWB2/HDZF8EBQkpP7Jn/PtgqFSAAfB4x4xmeIN544fwx8YTpXhH2IRO5AvMsGaRW8GJniU02IF7uGuV7dNazlU6gdWxrIxfAt82b2OaRDm9DjawobCiS5U9Q1chT4yXsBe375XSfm/WunIpjj4KEUTUuN3PFP8VYg9E6YSVjbDvTQV5dKmzaxkuSRP6wtttcfN0LgGGXSybN6rIeGAv42RN7bNShiNUskk7Y4LU99ZGGvJBcOjiBd9sf1N986ADPpIKZRyZaLaW9sJdkA1iHWvS3Rlhl05IsRhecPH3emCf180ioRDfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 20:15:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 20:15:35 +0000
Date:   Fri, 10 Mar 2023 16:15:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, alex.williamson@redhat.com, shuah@kernel.org,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mjrosato@linux.ibm.com,
        farman@linux.ibm.com
Subject: Re: [PATCH v4 2/5] iommufd/selftest: Add
 IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
Message-ID: <ZAuP5ewmDwql8Pn5@nvidia.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
 <08a875b83daf7047c3cc67ed0da23045b6dc6fb9.1678284812.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a875b83daf7047c3cc67ed0da23045b6dc6fb9.1678284812.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cccda4-9567-48eb-df89-08db21a434e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3gLDXKbgC/J9DsWo6Tm+TWeqE60drM/LTp8p7CUkpkJ4qyCMTgjaANImbC6YWIGYSFFuYG+lLmdGAdQlIMPe4jzlScmM74HRG6flZYZlAmmoKdq+0tU/AH4EI7u6ttqTa1yRtaPBhEfHiMlRKYnNT+MDyv5YAUg53iIiDUKJjD2JXtH2QQvdIL8rB1rM/kgLNiLRXv6rQqreU0t3rhw8efN+IYaqf4IORoTJgDaqS5sMgXzk3/tKvnjCEedPtBHJ3mzIDXgybyuF71wZtVsrwrLPJ15So2M9asbcAO3P7PoY21vj5vwAKrSo1V0/m5fACJnk9i2hf+ODr0FoFWsD40r4fSHnZgRB8iHEXm3w0AQ6gDyhJ9PBzyUuCmokzsCuHWlbf0xfKrw8jNHDhIZlb5DbX4OSjYSQ+V2GaP6Im+tLJDK6+6IpXKd8v/MWwWQOysM5bkYlLb5CvW/oljF66OBBbCOzHJgUmHQEd8/SvScra3Nj1CANc/pm9O789I/D8y8tR78czr4PhXzcqW0LAMpuvk0mys2R/x5m7zhRnHgdcS3QMb3z3kNdyeJDsfC0VyNHO55dvvwl66UNDOrGkyhlXGdFLE39BoWJMn33KgqYHSXQFXjY8xBW7fr7+u6brCUQ8JD2XXcHlnmn5gSTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199018)(26005)(6512007)(6506007)(6486002)(66556008)(66476007)(6636002)(186003)(316002)(66946007)(8676002)(37006003)(6862004)(8936002)(41300700001)(5660300002)(4326008)(7416002)(2906002)(83380400001)(2616005)(4744005)(38100700002)(86362001)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0t2/lScQLUmKjhq8Tlc2FaUiCPnQXgFZQ/ooTvq8aNB8kItQfdhMRWnoWCMt?=
 =?us-ascii?Q?+2S1cK4awKMGK1Q0TtP/jNCIXc4VACRAOixE3rAD2n4Pk1+E97mIfywkkf8q?=
 =?us-ascii?Q?4YKARScwGArh/mOQSZNx7kY8tPya7pGULdBaUViosfasfHdLRG9Gmeud3wtc?=
 =?us-ascii?Q?tHmWQ4pOO8mnyTFH+YTff25dysJ9ioYpQP9EFPEIh47wIHshqIdUwLOTsgLZ?=
 =?us-ascii?Q?66n4jVgtIqg56FAN6aOgqTAVc4GZwqa9n4ttuRw7Orrhf2W9hfZWkaoKKu/0?=
 =?us-ascii?Q?2xLl+ajvIFk/t7iI+uAKhtOGsOjpbjYsRoRXAFIqgw7ruBeoAGHGpNAIaZey?=
 =?us-ascii?Q?xpmCYiVMzlvWEV1fg35lbrJyy6q+OHn38jNesNLdAbGFRZ0qey162PLD2i/H?=
 =?us-ascii?Q?Wvui4rUhubOpNXVfRgBJBYnPGGtxjtwiiSSUQrHczHaH7aBlSbIuvS8xj5Gj?=
 =?us-ascii?Q?j3la0WYsS8HC+3H9sSF4ZxyUVXTTRXtzGnR0LiNk6/nDsbfbWrxVkR+W2D85?=
 =?us-ascii?Q?NbTB7vEh1+qUn5hUeQ/kywd8ccTqAU3XtIOLEWqMo6fJ1hTTN4vU275bCLjZ?=
 =?us-ascii?Q?JsyceJFPDTSY5NVco/KDI8Zu9wHiJLEpz4URCnBHQ4m9Xc+WkJTqEabnIPNl?=
 =?us-ascii?Q?JVOHTMn0r+eBH5EbZaUOl43AYE8he6qmbngckvQ0JkayNEAfLWu2fvXILjfW?=
 =?us-ascii?Q?kPS1LngtoLiCHcb7dAMqRdiV8ki2T/rvR9d/sWoPsehT4JTVUxlox8lJgZlN?=
 =?us-ascii?Q?70uHBIYSixepwnkAqVKCvzaBhjvAlc19TyjBfRfpJQUUSAX6sEGg8GPe3Z1A?=
 =?us-ascii?Q?jCj1fLXJucZzzlvi763ESpDw1xoJ/DO/zalD2y4ghn7bdSig+GiRHcCWUOa+?=
 =?us-ascii?Q?AwTM8kOPrHQuxHY8GSm+ST11ky0Z/7Lg1O+XwiqSgdHAAaO3FNNy6KLwAbQK?=
 =?us-ascii?Q?HlTLlTI6UtP9xMZ3of8qjxtRRgS7IilWcqONWlcGUIny0LztL9Y8GcUMvqvt?=
 =?us-ascii?Q?3SpXGiyaJnx8jXeqBBGEkgXrMB7nfQ2OK5i716Eyjo9VXSD4+D9zLie2THpB?=
 =?us-ascii?Q?5W40JHsBfcla9584Zsw6MysA3DmIDNjdiKgy+yhqBCGMKzOVvlpXKHaEwTCf?=
 =?us-ascii?Q?BAOkxL/+tVif1eWabMifeG5q0Rkjst0seTCLDXVQGvcEEyb66AUY9jTrGrrH?=
 =?us-ascii?Q?s+sP+0UTqbVkaRAYt4F68azTcVtU4kjU7EOC9ngZPwWGKtYTjx3voAbzyNbj?=
 =?us-ascii?Q?0XPefk0Y5yfKw/eLtEOzlhFvmO4NNCJ/7LQVk6kkoYNU9OoBnz3f6hWW/dj7?=
 =?us-ascii?Q?H2u3uhEyKU/fhqZF72bNwVzmyPTT3q1PuPt0aldNAyhMWGmBcocGjCZp1XFn?=
 =?us-ascii?Q?ovLAf89dfg5AGqTBXqtzns2Yw1IbbmeYHut0wP3RmJar80/tVBUp6G1TBgyz?=
 =?us-ascii?Q?aY8FMtJtkreWmw6Y7wIckTJ4CI1HRZtPN2ZBRpXst5qIUPNEqMCWEpskcZGD?=
 =?us-ascii?Q?lmHxCZL3gNWsxm+dt+OmtUBFdxVfmah89pY6RUc7HU9yrP/9OZBXYBPzVLGG?=
 =?us-ascii?Q?ai7E9rDeonFl5dAA2SKdP8oMnJjyYtYPa+rn5yZs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cccda4-9567-48eb-df89-08db21a434e5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 20:15:35.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTr9hLZ04zoTTWijGnxKEPnvNKrfRWg4k/x6SDppO+MMFqFqFF2xFGrsT2SBkvYh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 06:25:59AM -0800, Nicolin Chen wrote:
> Add a new IOMMU_TEST_OP_ACCESS_SET_IOAS to allow setting access->ioas
> individually, corresponding to the iommufd_access_set_ioas() helper.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_test.h          |  4 +++
>  drivers/iommu/iommufd/selftest.c              | 26 +++++++++++++++----
>  tools/testing/selftests/iommu/iommufd_utils.h | 22 ++++++++++++++--
>  3 files changed, 45 insertions(+), 7 deletions(-)

I'd prefer we keep it so that the IOAS can be setup with an argument,
this will greatly help syzkaller

Lets have it so a 0 ioas will avoid the setup so the second call can
happen

Jason
