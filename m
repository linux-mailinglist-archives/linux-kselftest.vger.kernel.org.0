Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8D6720AEE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 23:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjFBVWY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 17:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjFBVWX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 17:22:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E1E48;
        Fri,  2 Jun 2023 14:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNLah+ZZ0u7Z9kQRtJN1PiuyEwxqAkcV5rlRVMXIViHTkDZ82ImJJmxxZtXRl0mwURnpHzqpuGzKufDhL3YVfwDVfas309ZKyeQHJVOE2ImNC+c1IPsHWAO4F8HkhvdnFY05cTUySRp0xn8yXIXbzs7rguYv3vDcJtCQBYEZvdFG2uBWX843pJ1kMyezcJ68Xm+frBGGz9g2Zp4xqPbgpVEcSGirMxbyN7szBcRZcKTBLLOBuR3YOyq+UAflycfP34dBlj1xptZDlBJU+WS5akdYwiGMpT1copVZTOR3zyaAYx+Ht4JoKUV9D+bH4KWhdJ6jwOqdB1M11kAhCw2OxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZsbyOKP6IyjXr8sEWq90SVgQwVkI/Age3OVDEgJUHw=;
 b=Blrkgas61ge1E0n/goJMLvcRI/RFp8hyMO2/dvocSfUAM2tM6UNLseGLd8FNT6z8+/Nlg/TqKIKqHy4UAZVUNZP1j72sLXABPyU3sE4gMqem16Mg92WqvAnSU99CHPlYobh8TcDZkdJCygoqmfPFmRWHu+5mm0osULz+NDvgFDTo8CUMsS5SdxvTjDbkvsk0vEx6MDvAq3iFDSdCG6NUtvIzgFuXq/0NvCk3PMwGs9w01NgJ3v0c+glHNdJoLUveBhGDnD2aIX/GYwMfijPgKR5FdZ4hFZIs62YWxe9CMG/nFLckt715cblMo/csOtXyYo4u6zliVark+UfdVDGbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZsbyOKP6IyjXr8sEWq90SVgQwVkI/Age3OVDEgJUHw=;
 b=Gc38xWBbqvOnyMhJ3T1btjlsle8LXBQdkWLWsJK1iNq+edgJlcPQBE5ZzGiiny4h2mGdt1eN8LbcBWa1hdEnFbM5MzM6Y7Md/XCV52SdqD21iWdah0mRvxs1JULzByT8ms5pQbV7blLQ0o8Qmy/SL5x7ycOZaTEnjnx2XPbWW+GTJOIC9G9g6CKPHXW+klluxj7s+rizs21qmTP6vThz/FYHisQOJnvTDdU0oI4MysoYVKbSI8fwyEF2A6jqlH6fPNJVPXlupT9lZuAGl6WpBkuzKJF61WHbhpO2tOBujJLGsTm/2Q+/5bTbIM+7fjGw4q5StZvH/p3ilcWm16vHzA==
Received: from BN0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:141::32)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 21:22:20 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::aa) by BN0PR07CA0011.outlook.office365.com
 (2603:10b6:408:141::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 21:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 21:22:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 14:22:04 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 14:22:04 -0700
Message-ID: <d233f87d-fb86-4c84-298d-0ca573abba01@nvidia.com>
Date:   Fri, 2 Jun 2023 14:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 07/12] selftests/mm: set -Wno-format-security to avoid
 uffd build warnings
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-8-jhubbard@nvidia.com>
 <4faf7915-761c-c471-399f-3fcdfc208fd8@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <4faf7915-761c-c471-399f-3fcdfc208fd8@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a2432c-08a2-405a-b82d-08db63af72de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wq92w9+TdHxD80+uHm7FLCk8d++6BRDzUqGRgA1uMoeFJYqbL9ppWJrAifwFv5JTc34Cvhc+0REyYhKb3NsE0jS5jFpOGoPqXp3ruFr1Cza9JeTx/d69y+G2rQUVglopp4+/V9oeHPcPFfEqj1ZUMWZZke6E86WmG13FrfxRkZXFdjDRsL8v3aT0akuVJqltbS+WLfhlJ5Uf1igLgztrqtYrchWzjCSNTlayTZCBlVZEXhZJ4WGbUPtDHyup9eA3OveHaT1Ti7l4wf0cstu6HYzUJIhvFj9hg8zljkbpDZt8QyCrm1G+ei06bGRpztw4NzVEYvujrsl16MPy1CtbSnu7KJAkplKLzMhORbz2BeKXdcGZ5KzHxoO9FI5Wz6NOskm1dmxx42RDZ+eg5exLlen6Lv+/neppqxzh/+TAo6ZM9ofsk242kHvqKoSKVHvWplzzTHkaJlMaz0lChWvsuLB8FkbaFdE2I8XYwYukBd8rG07zaAKfouhcm1LqS/2mcmLYAB78yphkIgwIqRvGC/GkQ8+20MFfyAj8R/N0npU/lQoO53q+b4MsHkkXJk/FEj0uGeDDvPrioju31FfWekXQCeHb5nEcRcEdBUTvduSR+ncJyPKTGrNcXAD4vETFQgl/XkUJP8PzxRMtD+PHv7H/jX2BnJIrJXd33MrcdOYPTkfp2SmYsv3trGtON2Ld7/pIlpaCGpjNsYBfkB0biJwBlVJAEcge0o1Amg9YUi48Y+updUyoS+7ER4WwRbvygRCSvqJRYwo37Jkry257PQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(7636003)(356005)(54906003)(16576012)(110136005)(478600001)(31686004)(82740400003)(70206006)(41300700001)(5660300002)(82310400005)(8676002)(8936002)(86362001)(26005)(31696002)(16526019)(2906002)(53546011)(36860700001)(70586007)(186003)(15650500001)(40460700003)(83380400001)(316002)(4326008)(426003)(40480700001)(336012)(2616005)(36756003)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 21:22:19.8651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a2432c-08a2-405a-b82d-08db63af72de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/2/23 03:15, David Hildenbrand wrote:
...
> Maybe the following will silence the warning by removing test_name
> completely:
> 
> 
> ---
>   tools/testing/selftests/mm/uffd-unit-tests.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 269c86768a02..15c76ce972be 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -1149,7 +1149,6 @@ int main(int argc, char *argv[])
>       uffd_test_case_t *test;
>       mem_type_t *mem_type;
>       uffd_test_args_t args;
> -    char test_name[128];
>       const char *errmsg;
>       int has_uffd, opt;
>       int i, j;
> @@ -1192,10 +1191,8 @@ int main(int argc, char *argv[])
>               mem_type = &mem_types[j];
>               if (!(test->mem_targets & mem_type->mem_flag))
>                   continue;
> -            snprintf(test_name, sizeof(test_name),
> -                 "%s on %s", test->name, mem_type->name);
> 
> -            uffd_test_start(test_name);
> +            uffd_test_start("%s on %s", test->name, mem_type->name);
>               if (!uffd_feature_supported(test)) {
>                   uffd_test_skip("feature missing");
>                   continue;
> 

Yes, that does clean up one of the two warnings nicely. I'll do that
instead -Wno-format-security, thanks.

That still leaves another similar warning that fires for "errmsg".
However, that one is easily fixed because the associated macro turns out
to be unnecessary, because all callers pass a simple char* string,
without any format specifiers.

So just turning one macro into a C function fixes that, leaving us with
this (plus your fix from above):

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 269c86768a02..04d91f144d1c 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -109,12 +109,11 @@ static void uffd_test_pass(void)
  		ksft_inc_fail_cnt();		\
  	} while (0)

-#define  uffd_test_skip(...)  do {		\
-		printf("skipped [reason: ");	\
-		printf(__VA_ARGS__);		\
-		printf("]\n");			\
-		ksft_inc_xskip_cnt();		\
-	} while (0)
+static void uffd_test_skip(const char *message)
+{
+	printf("skipped [reason: %s]\n", message);
+	ksft_inc_xskip_cnt();
+}

I'll send that in a v2.


thanks,
-- 
John Hubbard
NVIDIA

