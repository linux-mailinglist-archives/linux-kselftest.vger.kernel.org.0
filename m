Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC077AF285
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 20:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjIZSUl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjIZSUk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 14:20:40 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2012.outbound.protection.outlook.com [40.92.48.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1594126;
        Tue, 26 Sep 2023 11:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX4VCeefxByhbkilyddsIBTV47N02eoAp+umG0dZP3d+zgjq/6dTk5g60dmX+xLVM2UKWiKfeSj+lTYJH8MwAGyKnSldU05lNfsHD/tbYKjvM6jq5yp1at7W3Jx0nWyLgvPHku9RoDyMbn9cWCEOWEwyAgTwIhAjf7nNw78DiKh2/Qmr1X9sFd4vS1ygv/sO6dD/cbIMnLKNp+9gyAqEsrDqHkI48zwO9tq7uvnLSCtg3lOhn8jdeQgxE5iWyJM/xi0BbBRgHZy0RZpuI733ekS5oFdfSdUyx4/3u5zrNHR/iJPOGTjVkODxs5V7nQNXF5cmjX2ADvVQAHeFTFTHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVM8wUWpsLD51AyWhDWjK6FIdwXC8vGtLgVBzAfi9Ak=;
 b=HfigqPYHtlwpsC9E0mjJS4EVLJpdPmLemP2HvZA8BpbhlMBx/vUFoxrusq3A4K1xrlVNQMtGS9xjw6hqgV4MUncHmmlTqsD3vGsy2jUwJgixNFaW0ArlgEkdqqBez0KUGYD51BZs5WV8wxF2rEh5Co1zKZviZrPAAfuP5gvGxQkrDxsBn0kid/K8aK7ZZqiu9eDXhht8MG1y821mt9yDXqmA1kRFA1dTz722h7BzgAAmWPtXSvxrqLmchMItfXrogRbIxowai1Y1uL74XrnigHdt2v79mwHSQ8E6nXP6VmGpiB6/IU1QYdWrwlHujr3WY9pdaXavJCO9adr+1P1eBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVM8wUWpsLD51AyWhDWjK6FIdwXC8vGtLgVBzAfi9Ak=;
 b=dbvGaguXHba0TJSV1nO3WqquEaQIFlUxw5sCTdPduFs/cFpNtq4oc95nJ1sqayBDt8Qq6QczmVA8TpymKa3RxCMDBlt5H+uHskKs8hlPu8TZNoQZVPnwRWexqlNrlk4R+KFMvSROL6Id99q1aHbYb2TpHlCN07D9T+8Xbgy3gC0HMVVxk8VTt8F/TuQ7w2LDkR93qSIjzAnRl9urrpxSs2g7BAQSgzIguAFbcjivLu0XdmBY9pivUbWfnQPCSAy1jZ4VoEa+39cKC6nkumiLa8j/MdsLYGL2dNNh2Fbi43frdIZA2lXkp2jegM/zm8r/S64kPQwwO2hMT0JGrjcWZw==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AM8P193MB0916.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 18:20:31 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad%4]) with mapi id 15.20.6813.024; Tue, 26 Sep 2023
 18:20:31 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/mm: Fix awk usage in charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh that may cause error
Date:   Wed, 27 Sep 2023 02:19:44 +0800
Message-ID: <VI1P193MB075228810591AF2FDD7D42C599C3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [xILr9DlG3sQtR9dc1DzJCCLG8cuXEP7L]
X-ClientProxiedBy: AS4P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::10) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20230926181944.24179-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AM8P193MB0916:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f755ffb-d0b7-4ef0-21b7-08dbbebd44c4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGTQ28tI/nv7wHjMyYFpLcKQV1B2pkIVz2b7z7uhlZp++lww9EPNrYDRxaI+RuzLOvOpbidffRuh1+eEMft2+TjARKnqBFdTxaq7TOCabXJpjGNqrzTP7UEunJA/k1odHwmn/OgmuuFcGDS03740z0LPxmZUcG3n15c1np8F2cfQfYPNFMMoC/vHuxmhUmGI1EwD8SQwfhVTm9kDYa/onPLF2+3OZ++/uj5OtsJtUVicz4fVg+/DJLj9acqdVsGKKTkqQkbmvHWamEasA8D71RZdGBDM1r9sjMekXVZ3yDFccrwPD9DWUVqScq3L/4/pQwTPVaFcTJOHkigsEqA3wNKAjP3A+pDmd1i2W0lOsf8oZfMNP1M88FYc0fK+TnoZ8bUSbzLXBc0zNGiuFcY184jIN6ERbMy58qTzPQvXDTArRHBLakxye6CIWCErKXTOCUZC4b0VYoXPyympTcXxPBuK8CLdmgVytUcvw874O7335e9MpMn7se7flIA6hTDojRis5WOqc8Zsdvip6Yg+obgKhkgT/RUmIY459vJmd24EgMaKOHS12nY3lqDH2hlj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?akGJZ1AGyAIBlpxOBKKHKRWD6hPUhNwU1f84jZiyyz8IntRDlsiatAxR2UDq?=
 =?us-ascii?Q?eniEzjCVJ03DwrsNWLxhKJvsKHW4psZrm3GW79vmTLTeF1lIEMihLrtZH07g?=
 =?us-ascii?Q?HQZay9sOH2aoI4tYtnJ+EWnkXc3JzSfNmmSWOo4l0IUTcP46ZQ0qtukqFL6s?=
 =?us-ascii?Q?c3Pz4ymron9RWLh/ao2TrvzS4PKDVxYE0Qyv686Sk8ypOti6bCSHDcEeZBSe?=
 =?us-ascii?Q?JSvuY0ENLmsgwtrXxlx6mxdAsN0LQbjldN2MhPy2tZqehNAcjqAa9hm4ATSg?=
 =?us-ascii?Q?bBJIg6W+TeNN3vILe3S7gpaC5Sp7BLh5CalT7ZOyAkIWorDAfVr8t2YWgVfz?=
 =?us-ascii?Q?QG1WDC7InwH7T12YLh0smJwLv4wbvLx/AMdIL7wakslaZrI3bOR/YqnqjiXh?=
 =?us-ascii?Q?yMasCtjJKRY+yu1IoQVoR7xwi2g5achkU6O/0gRkY/Zn0EgZ0oX/R5YB0vnp?=
 =?us-ascii?Q?8AKCr0wDoAEFVSHW1+FVjbjcmzYtS+zErvYi/lPFfdxGB56xoY0ow95kg8Aj?=
 =?us-ascii?Q?nnpWluZhTuvD4jaxsO7O19lpu6s5CccDwaHSRSSoYHB/nleqVU2B0R4Fwhq5?=
 =?us-ascii?Q?KsaTw+iCSz12AYdU/1C0umJbf2rXdF8GN+yckg9XTCsjqZ6Z6AR1y83JBCbE?=
 =?us-ascii?Q?Xi5gua+HHUdWLfW6nBmrDkPwlursb7mZ3WgBasNWcXUtnBPkOkva1tiuXFEn?=
 =?us-ascii?Q?mklu9Luj6xtNY8WV4PiqFZWD7/36dsxSflB7VKtpaohLdNLxE/ztnani4Eqd?=
 =?us-ascii?Q?/qV0Bq29IwOm8hdeqYV8oV3wu1eL74SoacO/xj4wRyr9nvUq6hoPIzhEpQFV?=
 =?us-ascii?Q?J0x1TGdTWweEs1ao2MED0rLyAEqVzJikvBM3NPNehdUoGGga17/5lBDpbwVX?=
 =?us-ascii?Q?FvB4Dg8XiKldto6MmvL6cbyIWDyjKkS/kvNNiPRaIsaJGyEUaqECZgEF4h82?=
 =?us-ascii?Q?cyr0GGpnrIPBqSbeL/7IHnMi/aBOWxpzAjxqF4znPDXwZU8Out+vF3nMHXBI?=
 =?us-ascii?Q?jJIbO7SZ8lFCtNMxs0p5FN1mOW7xbLKsQawDBiPAOI0iU5BYmJj4l7QJnIHM?=
 =?us-ascii?Q?G39NdvwS7Kw1SQVClaooXHUjN1MyE3Q45Zxv2lfpq2aRboTYBMvkUg5Wt5GB?=
 =?us-ascii?Q?BxH+mF/jTX4zf5inSKCM/RX1IOfFbouv8KYUJygASeWWt0FsnjmG5AnDkLeU?=
 =?us-ascii?Q?fiDWXoAYUV3EX0TTZ7czC5jG7l7m6pj5YaCs5E9VpJHR2unb2koZBibqb+I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f755ffb-d0b7-4ef0-21b7-08dbbebd44c4
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 18:20:31.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

According to the awk manual, the -e option does not need to be specified
in front of 'program' (unless you need to mix program-file).

The redundant -e option can cause error when users use awk tools other
than gawk (for example, mawk does not support the -e option).

Error Example:
awk: not an option: -e

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh  | 4 ++--
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index a5cb4b09a46c..0899019a7fcb 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -25,7 +25,7 @@ if [[ "$1" == "-cgroup-v2" ]]; then
 fi
 
 if [[ $cgroup2 ]]; then
-  cgroup_path=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
+  cgroup_path=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
     cgroup_path=/dev/cgroup/memory
     mount -t cgroup2 none $cgroup_path
@@ -33,7 +33,7 @@ if [[ $cgroup2 ]]; then
   fi
   echo "+hugetlb" >$cgroup_path/cgroup.subtree_control
 else
-  cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk -e '{print $3}')
+  cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
     cgroup_path=/dev/cgroup/memory
     mount -t cgroup memory,hugetlb $cgroup_path
diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index bf2d2a684edf..14d26075c863 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -20,7 +20,7 @@ fi
 
 
 if [[ $cgroup2 ]]; then
-  CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
+  CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
     CGROUP_ROOT=/dev/cgroup/memory
     mount -t cgroup2 none $CGROUP_ROOT
@@ -28,7 +28,7 @@ if [[ $cgroup2 ]]; then
   fi
   echo "+hugetlb +memory" >$CGROUP_ROOT/cgroup.subtree_control
 else
-  CGROUP_ROOT=$(mount -t cgroup | grep ",hugetlb" | awk -e '{print $3}')
+  CGROUP_ROOT=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
     CGROUP_ROOT=/dev/cgroup/memory
     mount -t cgroup memory,hugetlb $CGROUP_ROOT
-- 
2.39.2

