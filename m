Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C8C5019D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbiDNRT3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 13:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbiDNRTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 13:19:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954E762CD;
        Thu, 14 Apr 2022 10:15:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EGMff5028178;
        Thu, 14 Apr 2022 17:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WCKdPdEN5oBknBT723+0Av7ttJReps03kMTPRxcYJLk=;
 b=rFHiCYNNcmkp2ikmIcV6wHwYK2enAy7zgbprqL2znzgSmfvs7MgNUpveWM7AQM60nZwp
 Rjl5WKp/u33xp0CwUxJJE+NiHtBAMPJpFV6jMM0ofOXRbHL1Fs1/lcOMOvjQd0ybo/RS
 hC6/VVwD2H5UtscuPSG7dncbMnIRzw88TvGQswen51MrPd/daYSINivXx9rUfpYzaIhl
 ay0olfcqLn21Uwf+ZaL/vLT0EXYBbGznO7KNpMd+Y5YzUNRu/ev/EPPsxMjyMCd7RQU8
 L/t3k5yrGbsZwEvHHFBsx0ZzILV1hHLfCLS8HGo+JgQMCP/l2dzzy4BAilkhn5u2LCcY /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a4yaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EHBpU7021735;
        Thu, 14 Apr 2022 17:15:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k5eqc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm1XV+BYbHMA82oiha9YGQdFUkX4yV/4+vxk0M2PS7awhVxFVPN567umLS/uSlnPUMPcoRgn/10AQlxI38eLUuSNLxaquq4xyPipWfhXOm82DPOWFOQgjFbrFxamqTsfUZlOlGtH5mYZDJObLyRhXfF6bVy0qWnqAVGKafjoZTaMTCKHl5KRRVxBUi4rpxvBAr9EaySAO9DvuW3ZcO1rS3JdYheOf90pZRaYut66kY3KL2wsun+/7FfGYD1M+VB6J/wFObeIpoxvPnJAJ2UEEM4xU0Wb5vMopI62PgIsbYHxoWR+725qF5pKM7jIgPH/LL+ly7afFWUc6MS7xATKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCKdPdEN5oBknBT723+0Av7ttJReps03kMTPRxcYJLk=;
 b=nq9lnpIMrqTmpeIy87bzDyeWM8yJXPdq9WsBVqT3PZlt4HLB1eBozB0Rb272drEq+MZL/coNB45mzA1wvSRMgdwRqoIlZB/0YpokVHMkjI/8qap6y1R/U3bEbgOSbITek8mmiAJn8WEqYf5Ti3RyoZEyX2oQUZZHnc1EVVOR2jxb+ZBdtuleos9DxK6UdIm1qx13oY6exc2/7J8zAlPUtz2r56w5aGZGD94tKREEzQ2FfrcNUW1UlE1VKMSgITGvyUCCHmDwN9YkfszTTCt2YU7kmiSRXjhzUxkuROGY0v80cDYW9pUYXRS4vHGR7mB/rXGkk4UY4ASDAZ8emMpt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCKdPdEN5oBknBT723+0Av7ttJReps03kMTPRxcYJLk=;
 b=IHnQGG1v6oSLwsULpQbSjywxN8fCwV/lqPTAJZmwNm7Rm1HISO6kxORUP+RTm6FGfMCMVcO84RioFZ0RX7Dm9zzgZ6ArMz44zeJqDmvN1weCa+h9J/Jq10yT+gOcj99f81N4mYj2onKx5+FXC4jik0IsHqjYcWSNKW7Lcdc+IuM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM5PR10MB1692.namprd10.prod.outlook.com (2603:10b6:4:8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 17:15:36 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 17:15:36 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] selftest/vm fix segfault in mremap_test
Date:   Thu, 14 Apr 2022 17:15:25 +0000
Message-Id: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0007.namprd04.prod.outlook.com
 (2603:10b6:803:21::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2871a6f8-6dc0-4d4e-dbf5-08da1e3a6448
X-MS-TrafficTypeDiagnostic: DM5PR10MB1692:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1692A94B5CF4E674C2188ABB95EF9@DM5PR10MB1692.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHjaSXuSI5Cbu3nHAkv1aJxh2x7TKrcNUOZZefpNsGvwdjN3z05YdIrW8uVGDRVw99cpXwqSOfzPEDgfO2umiT6LTg5sc+PiDxM2QzAa/aQzit2Xkh5fSkFIvWU04a5lamhff8E9TkO3hsczwygh4EevswQd6xfMYk1wi6N7NGTlSeYx5Ny+d6V1HRoqa85igGH4vet+SQx7arkLr7EqOHWSu0YCQkdkcnriEkjIJyIbtXxJ6QG4CWI5Dx1koCy5F/n4UuK6j2u/dON5u5krCwkmwbRBEGjS+3NPufPekb2wdtF3/hjfeGzgpddWXddobqj3M+gW7nIsF2P+LZgljn374KMeeLQHJVTUFHGffNhzhkHn9o6IfBxf3USwBc7J8gvdOWrhNkanPM3aCLhru4certTsmoXx3SR+d0efsk4dekutYZ3H/MwCipj/z625iwt9UHpjD50hqFxbeMreHkUJQ3dlKi1mTDF8CXNiVBHJt3DwBf87pXRBCW+Sz/DV/ua4PhJLZKBCaWxXDQ0HAJdSw0me1ZzeuGgId1NQ7aamydN8oGKGqs2RElGXvDrfuOxUyevtkmAaI2Vv6BUZbAZoYl2DkiPiEY9DhAeKU1oKbsD5Hrqn3trvyQY9RNaJa4DcrfkDjZF+AbzemdlvIvZ+qllta+02jtGkL0flCVd8kWheBAGWnu8V7JIN4aXh2M5Vj1UTy7fOEmH3s4G+aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6666004)(44832011)(4744005)(83380400001)(6506007)(26005)(38350700002)(508600001)(38100700002)(2906002)(86362001)(5660300002)(6512007)(8936002)(6486002)(316002)(186003)(52116002)(8676002)(4326008)(66556008)(36756003)(66946007)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sk8LXd3e553KEw2BNMjPUDJPOEAfGVPNRio9gc9bvzO7LGUkn0eWds6MJUbK?=
 =?us-ascii?Q?GCUZJALPW5uLJAPN57rIaIoqUcENLpDGT2bjLMRBPzTOF4HDBnx284NwVNUq?=
 =?us-ascii?Q?UZNRqUHLxw7PdmFAzCG1IqDL4TdPgXSQmexp8UFw0kJ/HmNuIYhmGKrg0Ysg?=
 =?us-ascii?Q?W+8CCIcGPLvoWHuCWO9CS89C4NLxdrGseZ+013qFWBAIqlFq1Ki6inLTVREi?=
 =?us-ascii?Q?tZE08DrCiflvEMiD2N+5PjI+BNYfnS5ztvEPnTrl6Hv2IdrN3tq7OjGfqy8p?=
 =?us-ascii?Q?isLwnSLRzWuzQPVkBkLiZiyr/ENVPiceh5zCkx3Qh9zV4RnRgxZuCsJ2zlXJ?=
 =?us-ascii?Q?xQeDHK1FRYyn9ZpvStXITZPGs18mcLT3e/1dlemJMlU2zjrlrvAoz/HVVumd?=
 =?us-ascii?Q?K9B1GBzhksuAi4NIn5knDLWdGqL2pDmt178apXWwUMsc96zoJZzxhJqs7J3w?=
 =?us-ascii?Q?UPbuIjkcCQ5tREolxTitX3uDnpeCsfE4GHVs/73hYm+nWeDoUjnj9YZ85gEx?=
 =?us-ascii?Q?KWKTO7e/PEUBqxkpfNNdoi3Jy5k9l7o9iKJyAkNQWJ/Kyn/8Zx+pztysVpHE?=
 =?us-ascii?Q?kw1YhnPaOD3DKlCa4sJGVO8SIrSr8c3utMXfOTnNU10R7iNQm/UrlBF9VFJ9?=
 =?us-ascii?Q?8/1YztvAT5oldT9kopPvjhy+J1xDFTsdgi61unAESEMW39i/4hw8BnAlNjxE?=
 =?us-ascii?Q?fusbMMVT5WEs5ShzovfrGGu+dXyBWE6wEKaDsJYJysnSWOiZfp4xywp9+pGY?=
 =?us-ascii?Q?tXBcH6rfaBoZbwW2d4H3R7/bIoxpdw2f7yPtoGswGh4WX6TjXFToSpmc4i7i?=
 =?us-ascii?Q?mg87OSMG7WCTpLGFQoQnpTxAcM3afCcn/1wHfviUZUpmUOWT5ze+wPHeicFU?=
 =?us-ascii?Q?2zs3sMhsOSyoQv57F96rfeiWyTCCD++0TQOGgoR29GIPfL6MU/ao235YksV7?=
 =?us-ascii?Q?Y3PqCq2PSrdwbokrlCch7oytcM+GRrdm0Kyn3VC8NIvkLbLiqL0fV1GhCbrl?=
 =?us-ascii?Q?g34wH+Kc97bMmNNvi9VQ+Ekld+KbrNOONBI/g7r1VZnXxr/IkHlduOUTvvkF?=
 =?us-ascii?Q?6emG2Ab2TYwsoCbfgkfz+1c8X7WRdWzvIM/Bn86DhO0tnuRvRto2t7CUseDf?=
 =?us-ascii?Q?xaU9Hk/Z5lIUDnE5i4GudPSAR11ukwg9epCCDGu56c5Y5WP1eclEJUub/JRy?=
 =?us-ascii?Q?ehgvYwY3unP2GxItW3eLhRKzYcMVnYqcUTVu0ZxrqH1+xl76J0fC+SkJj83S?=
 =?us-ascii?Q?N4shxhqazVLVdHuCDTQ9k8axPYstkyvPYfWef1drFlKJTl1VqwCvsF9MbbmL?=
 =?us-ascii?Q?Y/bTxfLaGg5SDXGA/9Fo5oj5uBgoE0/opgOvAr8ym7VOwnrVmB18MXHDOcin?=
 =?us-ascii?Q?P95+kqJtBcvcKdC26tcacN26x0C457QipacPrsu84pD3SCtF338hm56dmjrg?=
 =?us-ascii?Q?4NBYuE7LnoTScgkpdGDTWo/0kAAgJigC4iB4eXI4FOe76rmSaOd2Ok8Fs8vn?=
 =?us-ascii?Q?oraI8J39wL0ORSUGRhlnhAUwpjUqucu6BJ+HeGGxyLrj1CaUi8c0ucIiGe+o?=
 =?us-ascii?Q?ZCrZnrxsQYaRS62Ay57XO6V+6JMDXoI80wpU5HCo8KPTSxdaKbxQdPKlIuPh?=
 =?us-ascii?Q?fU0WenIqEf7YF4z3lpesqdzAP1Kk7pcPerAeahwtYEy/Lw/QEOJ10R4KyP9b?=
 =?us-ascii?Q?TOJxWUJ6DEq7hzCRcVL+0Iq2rrNuafXqnrCMeZg2+xMgh2lnh4FG85CpIB9a?=
 =?us-ascii?Q?Ju3GuKxvC5/olE/w+SRd+cx3SiZwj+U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2871a6f8-6dc0-4d4e-dbf5-08da1e3a6448
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:15:36.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXLbA5IbesXOwW/GD5gRNQFAzrikyjGN1L4S70t7cIgFLV7NHFHq/PrWzgo/xZu6TvHsS6UVPE2o/BWqzBYX+yp1iMfZ4awjmnbuidTq2cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1692
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=836 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140092
X-Proofpoint-GUID: WpgrwkMH1YDabH-5TE5K9FlnosG3-gbF
X-Proofpoint-ORIG-GUID: WpgrwkMH1YDabH-5TE5K9FlnosG3-gbF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The mremap test currently segfaults because mremap
does not have a NOREPLACE flag which will fail if the
remap destination address collides with an existing mapping.
The segfault is caused by the mremap call destorying the
text region mapping of the program. This patch series fixes
the segfault by sanitizing the mremap destination address
and introduces other minor fixes to the test case. 

Sidhartha Kumar (4):
  selftest/vm: verify mmap addr in mremap_test
  selftest/vm: verify remap destination address in mremap_test
  selftest/vm: support xfail in mremap_test
  selftest/vm: add skip support to mremap_test

 tools/testing/selftests/vm/mremap_test.c  | 79 ++++++++++++++++++++++-
 tools/testing/selftests/vm/run_vmtests.sh | 11 +++-
 2 files changed, 85 insertions(+), 5 deletions(-)

-- 
2.27.0

