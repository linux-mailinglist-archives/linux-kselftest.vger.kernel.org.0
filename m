Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E192F7D5F94
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 03:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJYByN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 21:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYByM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 21:54:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2042.outbound.protection.outlook.com [40.92.59.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836D4B9;
        Tue, 24 Oct 2023 18:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuZ9T473p+JCMXltVFhZFJy/GrmWT4f1Ve6KchzUmtRObWdw2dMl2mjuZ97dHSOVALI9zeBcsifvbec0rjvQPtBPwEamvKQ0T2bg6dZgnq2hgfTVHa8i4cOy5PA51AFdLwV2OP7/kKsM8AOduhQ8guqRlNEy3iOr/Sf6LMnc+MVEgJBsJBuXYj1EBd97eiiGuIlMuO8pWstfn7tQIEjpYqcR+ErItQTEJRiwJoM9hFHORFmT2CAFDiang+nHccIXNe0fU+9ElR6uXqQpVbPtdytjJA8X5jCyOb2m79h6cnEiRWAJ7Om+tEG3HaK0LzHB9ZiuDrZvEFVosaHn7avMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPqyRMs3Qoza1TvN4Y2k4cn6mPPi7CfviWMBH94Ji8s=;
 b=ArGVlizVUTRHNZfsv5Jfm6+R7Rva6vCFpWSWKONTSD+U0rbCAxbxxYVBSKsN8kRpEMyOkkmODvT+2xrr7GmuPM+nqM9gNvRo8tOF/9N8hSaTFUDA0o5Vny5oWnrHV5x5lXfWIjFEggD5HmaoA+RXv7THRKguopcE/Tt07AXJfjo2m57xEaeLc5karDuCVZDWe48vgxShsjjyQBzIttHVVV8CNar81J5ZTkCNgG3QAEthSfGtE1+tqI6IRk0qRbsTJaK80/ENC8b+byambmp04NCJOQSiEz5jBJxE8tYvLZOxY8quK3Rsn6yB+vqqfuHckDykiRjLcwWFZo5+Rk84rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPqyRMs3Qoza1TvN4Y2k4cn6mPPi7CfviWMBH94Ji8s=;
 b=CSo95KjxvNI4LpD4nEVWe7KoXXb2Ey2vkWTd7BJR5+HTkn9FNZx4tQdt/m0nVbrvafb6vetAF2I6StmxfeXoqzcOWTwDdm1Svf8h6nhG2JKkiiiE5/xxWyVw2RMdsjNSEzn3nbZ9NoAX9icZ/FGk1tQfDT84opoulG8/FRkUr0YKlcTWxTqLZMEuS1FuQlFEB+0r3y+akTLgtNk/kUwlNQDwli8Avvpk8EeUdJZGPznUjZVzeD5wdLrknsFixOMGFK3rP5h/AQzzR65HHD4CdwxZ+RLGI1CI1q9UmMqfYnmIdCjWwyl67rFUjVfWshBXC7dKB4BQcRmebqNwYdxVew==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by DU0PR10MB6082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 01:54:06 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 01:54:06 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     yonghong.song@linux.dev
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, shuah@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, brauner@kernel.org,
        iii@linux.ibm.com, kuifeng@meta.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Add malloc failure checks in bpf_iter
Date:   Wed, 25 Oct 2023 07:22:45 +0530
Message-ID: <DB3PR10MB68356D7CDF6005480BE5876CE8DEA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cwM/ETK+MC24jL78WtpVuoheEXMqoZBu]
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231025015245.1061524-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|DU0PR10MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1e6cfd-9f35-4e24-5f4b-08dbd4fd4523
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JrvTy+DA+gUgra2isufIZkB6idG8gQCtimV0Cz0R1B1nffGUYSOW8VwpxX+h8MnhJGfgo00Jyz/XfuZEla31+XfSTRs5jTNen3DjY+Ip/QBXBT6FQM4HHG2dEkO80QTkjKLudiBKQEmq9g16txGpv+CDPTQFvJYzhQplVeIjm82AsN9yIRnapKmnr29vcuA4gfgRzLcRl8WGNe1HwHTIroPdGAADvqJ24LRBQVHCJ7iDLVJV9akIM0ngTznE165iz5ZOdjlHkuPXRDQWRuHY+RjZizFcXXT0s6oVBOttB0MtowQAeSTcaTAdfLzm8xPP8edsRA1cT0aBPqqp7n/BgFkYhX5/+ikG1cAeymVnQ4DLA5ZWrJd8OoFmgDKj8k9kevn5Zp0mCCKHW9qFUzgIRKoQxSD15MjeF1YUf6Iw5Uk+swAzQcDrZ5dHEVoywI1t0k35C0Fve9nl7Tvu/avE4aUjgda7NXfFsrtXqyYqEfQMcNJ10PcestxU+PB39B9JSH0EPRH6+qk5PGiABAgFdnbUYcA+31Zde9wl/pkUkI1DBEVAWUHaSym6Ygfriw5d1cOuUO1lfuHsJc40aSIpYK2m5ez6P9w14lW+1T80InE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s0IBQFB+9g5i48WB8H+HMXh229w+KWy8LHWRp39CrLCyjhGpbBoD+KOF8tgb?=
 =?us-ascii?Q?FRfGgO1Gf0M4EqibNtOGP+M79bf9rwz5RUFMJsmr/mhH7BdO1iF7phHMPpMS?=
 =?us-ascii?Q?f9cL62/NWp/MSkOdelJghFHdqZdK+s+nlQIhaCnzUdXopxgKXLOGkNlhsKZj?=
 =?us-ascii?Q?O8Nsm/8BM8CUbJ5Wk5wzLPGtvUqPsyO1Tae3h8kVRem6dUGq1JoD6EgIfJk6?=
 =?us-ascii?Q?UrJeqnX+g+Zsst358XA1glMURgw4FwlCaBkPOOABYYoHktsHpLisnMjmSBKx?=
 =?us-ascii?Q?kXRIdByi8buSX0/uB7SwYSQg7rjIg7BInAyO7UWE1Rw3Z+2Iuqe89W8rG5My?=
 =?us-ascii?Q?xq/6sTMGAjamJf/By93x+tDVglYd6oQiq1GrZosGF0MZnJcsj96yj1Ezr5BJ?=
 =?us-ascii?Q?7c9dIivCWb5gWODmcFOQlkD6kkJRHMcw12dZ/z1cbmPDwemQqalKYAgKFGkm?=
 =?us-ascii?Q?5FjiGxaMOl4hq7PxbhyOeNRD8NjUUb/dymkBsnvK54oJpd2TIrX6nXOAaCZT?=
 =?us-ascii?Q?GYYw4VSyMlvj6nNKBtdreEb/Rv98JX80hpVcudpdLKi2dIzZ/z1bvk4g2kLC?=
 =?us-ascii?Q?C2+p5oVRvP7kYCyRyUH9ZewYCZTVZ/tCGp2fMGMeNdLDX1Yea7A6J3jWD0Va?=
 =?us-ascii?Q?R/gEzesIUZ0SOS5wfQOo35wvapsHA2D26sClp3UgQ8Aap+7lUKXuLk1nKsq0?=
 =?us-ascii?Q?aRRPM0ti0F8PI1o35vScUk8gYWiJfDj4qa0Kc0uOgiPygE+zfm2quWWI14gl?=
 =?us-ascii?Q?OcKr8ApVJRCUUAsjOve9nae26VM/g5HGAMpWf/vnGmHGXAFla1ZFAHD+ZV6r?=
 =?us-ascii?Q?uyJM+0rimxVpdUZuBqpSml2iWY/uNXQQ+E1MgheQO/DWULMKvy0VHSF8NVe2?=
 =?us-ascii?Q?otRpni2g8DUyZXvGHVjsHC3YBA+4ykBnhqhooWBnPAjbCQig16JlNBdv3qTu?=
 =?us-ascii?Q?qbz4i1cddt5Pd5YygSVjhkvGy5/ZUVmDs+q8AGGs0awZQmL+uuDNyeZcSPWa?=
 =?us-ascii?Q?r109Iycz1Ck6xCLeNSrnvuLXXVlXLt4+v8AcodZkLbH81vXGNDYhCO6uJwYc?=
 =?us-ascii?Q?ph4OIDF+VXIODuKmVSwLLNW2IFVTfTrTYAESDyQRnLUQ5/Z2u8y7ldHffvYH?=
 =?us-ascii?Q?hbTWT2RMMCqLtjp6Dxkx48NGdi0RKVmfRHIQQga4VPQKwcZNYrAnRhhQP0Jc?=
 =?us-ascii?Q?Gg/te05wYdtlEXEn2oCP5XWe8C/MMeGWUn3LTR5q4mtoVnWOkqVzAdjzRNg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1e6cfd-9f35-4e24-5f4b-08dbd4fd4523
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 01:54:05.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since some malloc calls in bpf_iter may at times fail,
this patch adds the appropriate fail checks, and ensures that
any previously allocated resource is appropriately destroyed
before returning the function.

This is patch 2 in the sequence should be applied after d1a88d37cecc
"selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter"

Patch 1:
https://lore.kernel.org/lkml/DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 526ac4e741ee..c6cf42c64af3 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -700,7 +700,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 		goto free_link;
 
 	buf = malloc(expected_read_len);
-	if (!buf)
+	if (!ASSERT_OK_PTR(buf, "malloc"))
 		goto close_iter;
 
 	/* do read */
@@ -871,6 +871,10 @@ static void test_bpf_percpu_hash_map(void)
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
+	if (!ASSERT_OK_PTR(val, "malloc")) {
+		bpf_iter_bpf_percpu_hash_map__destroy(skel);
+		return;
+	}
 
 	err = bpf_iter_bpf_percpu_hash_map__load(skel);
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
@@ -1048,6 +1052,10 @@ static void test_bpf_percpu_array_map(void)
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
+	if (!ASSERT_OK_PTR(val, "malloc")) {
+		bpf_iter_bpf_percpu_array_map__destroy(skel);
+		return;
+	}
 
 	err = bpf_iter_bpf_percpu_array_map__load(skel);
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))
-- 
2.25.1

