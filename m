Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CAB7AE057
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 22:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjIYUhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 16:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYUhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 16:37:06 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2018.outbound.protection.outlook.com [40.92.91.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE26AFF;
        Mon, 25 Sep 2023 13:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OD2P3qzQ2scGFT1ddnvi++zDHsC/crGKP4hHVm7bfQMzA4OgcWls4lK95wanBs+1RxUFZElosoEDj9zD88eHqN/SJu/U2ZlG3xJsflZnv5uDdgy8WYgVN1Jl9KFQ4sKaW4uSu4mVI9gZLkGIzVsNgcpOc9aN7pY4GwfDqrw7dMboUsCWCthkIsjZ9nTh053LavioWVt/xCmn1vuhZ51UiGWPu536eQyhpgJ3H4lAlcXRUND0uuX8gUZKpkH8IBDZzatQiNVWVDtkH0+gbjzXUeF7DhNk9eXMEe97i+ewtBhJmG59HzE6Vsuv8nNd++66dS3fqsIsa0aB3JPsAYC7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+N1/eapPVSUeaY8xeEctebKxPS5SKr3WxRHfNZThbA=;
 b=FE1/vm2SGWY/B+ol6BOroZVV/I+KzNLCvqgWUqGYT4qOCIgFcw/0876JISWEjQMnWyOxditHfm0wgS9hkflzbpgquJi51SYgRmSyX8wijez/cXkr7nC3A+uGNcy/KEa+aI3gr2d01H9CPFgHZfGAvg8y4ekTvj/PR4Fv1i9KwSIrWu3nUCaI6NAEuW/HCNhSuvOUQm57QBVvrEJb52KIZJsk7JzQFOaQVKmMU3RE9pYpsUJ+I9T+VpKqtznr3NogA6UFVbXE60K3/dunbwRmsD979asQmc+gM8oVcQHpYg8QZGebX2iEBRGe5EugUnQo0TT8nDbNRqrlQGVPyLxgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+N1/eapPVSUeaY8xeEctebKxPS5SKr3WxRHfNZThbA=;
 b=T6fh1W09oFAcLb5tUcux8p0o7u2GoOXpZ4ElnHO1yGAu4i21HITgadwoc/XGuxkx0TwqJ+8RrKzQPJEFykeulZ7fQ52T/d1BaTrvmT503Pfc297CUOdqhJz7qZWbU0tLJvep3xkX2Lrdna7R9LsV4CngGvLDTDkielans4w38MDoEKpZaWsGG0t3Emea5BgGDE/zDwLusxbVa9+iiWAX+v98iIPvRcs/dRiJ/xKNnz6Q7dfJvdNs11GHLwtfsP+4DoaSebHcWDtJFWIsy32k1EERdeOuD7wiWfsQUBTDjt84EXIbxY16QdpiJVcKYAAO56WyaEHLAsfT8M6gHOQNJA==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AM9P193MB0904.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:36:57 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad%4]) with mapi id 15.20.6813.024; Mon, 25 Sep 2023
 20:36:57 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     sj@kernel.org, shuah@kernel.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/damon: Add executable permission to test scripts
Date:   Tue, 26 Sep 2023 04:35:52 +0800
Message-ID: <VI1P193MB07529234393616AE94D58C7B99FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [t5+2B58/31xcaF0fSebiYT11R15AdCyZ]
X-ClientProxiedBy: AM8P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::32) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20230925203552.54855-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AM9P193MB0904:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8e3bea-608a-4ba2-24fd-08dbbe07299a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dnt/xKB1VRpAoAoQ8C11syznRH81ivesrOCEdb/LmPkzCBID0YzjYtXMcfTUnb9VHmZPf7sEBJoMxxRWPX8xoRxA2w7HhjkEs8mA71X1OilUbf/mKcT2KcFL80lQ5vozXQ1+BTEPXQpaEh7AT37Z/KRqoIfa8gAD8GmJs/pMLcICXMLavqlotFV5dd+jQgKZofPl6PJaRDOlTq7E8WpiQzMGeQScsO5oBAF6fRqKIChijQ3EMuQOcscaUeWEOvnmDpqcFtjjqBdt+dbhUkcv8kKxuISOgy4E8ebcXKjFZJzhi/3NUY+ppAXM6Cy4uwqFcCTWJV/WimCBURKd8zi5B9tJlzULL6cTf2sMbE2DSv6y/EpMJcGLSQYl9VLmYUrK2j2/J+baJYY5YzbUt+zMZ+peEGvVRipgEyoVSEOa4ayS1e2ptFrId7thB3Uehs/Ew8Aenk71GFNU0W4CcSCeptUYPHLaX9SdT0uuaTpRcPT8hx67aw0tA5Xg/Fgdhxankb9kTTwaC59Hw/lyEQFYLYfcF0zOem+Qu+7W/zRB9vdFlmsNCFb1pX7kWNmBX/5S
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JeNlVTIsuLrsWcF6Qw47kFXKxvIlZZyUPn3+mSPLt1KNwfAnR02uTe1QdpiH?=
 =?us-ascii?Q?JZfA5a7m6Uter/7kbPfr/g1BzsTJ35VjiW15J46zw9qHopYORo+N4aosjWmc?=
 =?us-ascii?Q?IWZPgaJQCa1zhpCezTpyspiROBubV+gjwbf46blwU7INXJQJa7T7mq5VKBhC?=
 =?us-ascii?Q?5ta321FD4/eGXx8QiKm8lhUUZXL1YLvwWeuXOT1dJLQKdzS6NUGyrji9RnkD?=
 =?us-ascii?Q?EjtiiicsMugtaRy6ER2vvn/ZOt9+HDpGfWB+mgMvRGR8pSTCdI1G+V26fsoi?=
 =?us-ascii?Q?HSceDNqPcsxv5mJ05F33b2rACqSBJJpOqhIAyN+XRePCJFSZ1dQo6JIh/43j?=
 =?us-ascii?Q?LOkC4e0e0WFgvvcOWkbn5JLccwCvJESxJkLFY3HiwiW/NxlmNa2IJo1D8N6m?=
 =?us-ascii?Q?ZHJPtru/BeaV8+LOdebXWm1t9VOkhgNwmFDtm5z0xhH02824esv5pjfUEq/S?=
 =?us-ascii?Q?9HUnLEh9I5iKVUC9jW3QU3f8+lyAYINLOUNq33FYQ2vUZDmwkOen2VYGoEbE?=
 =?us-ascii?Q?/r7D3aXlVgmbviY3Xixb21PjKoobT3Nm59VfL09E2JVO9y1LXaIirA24v/0x?=
 =?us-ascii?Q?wLE2tR50LgOZ06h5QLh6ha1rqzJ1KDl7a9tMagSU2pjiHVMaiidpIbc34F1S?=
 =?us-ascii?Q?nCKRh51HIVI6LK2ZSGkolXBe/hpWj5MjzLej52Ld0w4uZkNzrCz/cT8JT/i7?=
 =?us-ascii?Q?xA/odJRFKWED8QG4j5EqU64dr/h2+wZ+HCMBaNnpMZAp6LUL9eIzEYrHoQtO?=
 =?us-ascii?Q?xji8x6XSyKyElEpiThMvZGc/1UIdLR1kmzCl/fbGSRrzrkDuwTIrGHSBdl76?=
 =?us-ascii?Q?2K3QL66Tzx2bnUWcAqVbo0SZ/aQsfCrZZNCoZpEJXo5v1224jMAxYVZ8vnhJ?=
 =?us-ascii?Q?WmyLrgxjIfaQIUm8jy87Mvl1awsyqIH5jqb54Dwu5dSTvT73dZzG9vGShBk6?=
 =?us-ascii?Q?D75v3NgljkKXSZzdx+HfEtU3kjRG+w8+ICEMkMg6mavl/dWkG7YMGCyS1Ctg?=
 =?us-ascii?Q?RykgKUil9GhQLHxaIH5OrvXFbONyRo9QwOBrXnCMU/Fx3xAS8bg3ot2dX6SV?=
 =?us-ascii?Q?6G6f99rS+k5kbNmQQW3yvDFhnZumFVCxgXNbsXAdpqnd4jFxNmvL06Bl+Szz?=
 =?us-ascii?Q?+cXU6qcLBslUrc2R3YrSMGj6XLv3+vH/YK8bdO4M2GKJPT8Tj5lrMou2QELQ?=
 =?us-ascii?Q?7WqEmsNCreURRKZiXk4y7kE3VCqbEhFGhw47mTvwRIiwJLrDaVMEKWHrV9A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8e3bea-608a-4ba2-24fd-08dbbe07299a
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:36:57.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB0904
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running the test for the damon subsystem, there are a lot of
warnings because test scripts do not have executable permission,
for example:

Warning: file debugfs_attrs.sh is not executable
Warning: file debugfs_schemes.sh is not executable
Warning: file debugfs_target_ids.sh is not executable
...

This patch adds executable permission to test scripts to eliminate
these warnings.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/damon/debugfs_attrs.sh                    | 0
 .../testing/selftests/damon/debugfs_duplicate_context_creation.sh | 0
 tools/testing/selftests/damon/debugfs_empty_targets.sh            | 0
 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh    | 0
 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh          | 0
 tools/testing/selftests/damon/debugfs_schemes.sh                  | 0
 tools/testing/selftests/damon/debugfs_target_ids.sh               | 0
 tools/testing/selftests/damon/lru_sort.sh                         | 0
 tools/testing/selftests/damon/reclaim.sh                          | 0
 tools/testing/selftests/damon/sysfs.sh                            | 0
 tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh  | 0
 11 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_schemes.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/lru_sort.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/reclaim.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh b/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_empty_targets.sh b/tools/testing/selftests/damon/debugfs_empty_targets.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh b/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_schemes.sh b/tools/testing/selftests/damon/debugfs_schemes.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids.sh b/tools/testing/selftests/damon/debugfs_target_ids.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/reclaim.sh b/tools/testing/selftests/damon/reclaim.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh b/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
old mode 100644
new mode 100755
-- 
2.39.2

