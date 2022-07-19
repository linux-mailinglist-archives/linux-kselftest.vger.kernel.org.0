Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C465796AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGSJvL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 05:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGSJvL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 05:51:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664D855B4;
        Tue, 19 Jul 2022 02:51:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J83Ss2013970;
        Tue, 19 Jul 2022 09:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=2MBCBsYi5S3lJ1YIIYpYJw0hvxO8m9ibeQYyFKT1GVk=;
 b=ezYITSmOVJOQSaMOgkA4/RpXLg+8lGixioObkMWlPID4yZP6hcLmoUE/aJjrYNI4BsA7
 JQKb4HWFLH6KIhzL1aqNT1GyYAtmdsCpvXA9l3P5hW66qH2hYR/xjpj8t9Esx6f70hG9
 PulilN0S2GMuDA0T0t3OYqcKrs2qCvMR5/1G+QQYbc0dEHkIN7ou5H1zz3eLUqX4lJuH
 iBzO2E63V3/l9nAeL3scpbhRUDiYTvTp4mYRgeXgHmUkKZJVvUJpZ2dshdt/Rnuwrzrj
 0Iy4MsyFA2aQblEcAWAbAbz0Q/O+n0lpXb4Uv9hkM4jk+b/esBtaeAbUgaUb/AZgbQzG Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs5qkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:50:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8Zhfq007944;
        Tue, 19 Jul 2022 09:50:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k379u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUeXACEkDssO+6MxVZ1HPnshUBlBPQl6YF/VS6prfZ81q6tKYSJexYxhqGyLCGjPH666j4MEwKarMTxv1SUPKojbXYDIC7WUJ4xIHBm1f7wLjEC4//XAFMJarExoHwRS56XwZ/R0nqCE0gArgzpKuaDoVjRXzArRJN0EG+KuGWD7U3MIQDuu4bj2zCw5fQbkCyf1JbFWOj1exUlMh3JEypvImq1j9MOAnNqNw6LAy3rHZA8JP52dpvI8DM+wEP7Vt8pwaBnW35MIqJoRsI3AGY4m+BgeUXJ39cEK+tVBaNNSTxjOGD1r8q0rw4NXutybx+8NOJ1NWnVIJLQZ3DnHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MBCBsYi5S3lJ1YIIYpYJw0hvxO8m9ibeQYyFKT1GVk=;
 b=gSpxjPbFnvsQz7iKpIp2bS2xgoKLHsEYhb/7hSJdeiMWNm9jtZMLotnksxArwZW6xSRn3MlEUwzD4ufrIL7F3WXDNObmpRo2FCIy0XWi9xZhJJxJwh1H7lMskH8PwyMmn4iDzJ2XUD0+Ms4E8ohp7MYHlRqowgqZ5VdSWkW494E+XFZ2pRlysHZp7FD/izYGNlIXL4yrqGetqbm5T8kVrcj2B+Lw4UDVy3ZElfcRZQBQq+Psf6w3kYxZcZxOE+wmk2YqElUYsJRjFe7pXzD+iHCX0hJerPNN797R4aH+25gBJWq5BcI2QP/FKAzdPWGZHmkaNiQKLYxo2KTHMN5WfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MBCBsYi5S3lJ1YIIYpYJw0hvxO8m9ibeQYyFKT1GVk=;
 b=iu+3w1jXiq2v8B3HqBh5Bf+Y4NK73OumCTWMKyWSELajmXN95looW1Lpy/5L12QMJiukppHNuWdOkq2mx31DjEpJCQMut+f/+sq0cTzPSGd0tbcFjcYNg4oXEcN9/7/83mObupZ6gtrU3iLBhMK2UfehXm+S0OVz13qaDwFk8x0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB5924.namprd10.prod.outlook.com
 (2603:10b6:208:3d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 09:50:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:50:48 +0000
Date:   Tue, 19 Jul 2022 12:50:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] selftests/bpf: fix a test for snprintf() overflow
Message-ID: <YtZ+aD/tZMkgOUw+@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0127.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c32a2b1-429e-47d6-d417-08da696c285b
X-MS-TrafficTypeDiagnostic: IA1PR10MB5924:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjA3lANrJZiHqjYaNFEhGdM8sZ+emEVJd1dE3wq/25B+62ietjth6E61cucnDVa4cz9ZRdO8VBo6ygxFoghZfOPQaMso30qmE1G/+S6oOBI7UUXoVUD0iguS1ccqTz4wZC/7mOrzyvbviF/3rYpvDH2vSAQHYUWF0Nw1N7+Al5SkYM5V8W0G3zrl56CbrAvt1w7tXagYUatKaUAzgd04lz7N51vPcHid6NhQDMnkEq80MHP9w7u6HOcDpAc+mq0YPJdIHNnmJFKCrFERn5YIOTzs2OGAG7tElE//Zqdug9twz+g/ocylF6xwbth8IHUFuenGAIKgurYdAxKduK3ifP+jVW1EgXYVq5H+h9/06yJXgu2RZPRlgbuNydIOfxM58DB1t0pG3goeS5mryULXbww86kyzXeWUCNFvaO2ZeiJnv03CPB00XMiywPPzkN9ePA7lrTpGOG5Pp1XlF7Te+9qt0+vJPmbIt/5vSL4Wt2kI+iPcIwDV6OsuVyoe3JWvJvHjcT+mSQETcEPdc456VBmq89DpmBWfCsHCd3SLYnFcuh+4r83F3rnENNcL/j6n4IFkMGwyh7B1HQSQAabOkxqv2CuDE5HdwEP+t0FCRTC3yunC8ijvft+thFm1x519U3MBTR+E6XdHbK4fosO/yFXN8jmNVB40BBTw1H9Xd2KPv9xkxQdWAZG8lhAw+g/NItElRyop28zihf1fUdtJwD7GP3QyjRG24yGN7dQAofq0xAvp9pBGdSDKggIp27X5JtGduWdHqnAK8BRfF8xl3z9cg/B6HNpfL1TuOtlo+DPfYzcsi6xbT8fAbxPTvGOk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(86362001)(478600001)(6666004)(41300700001)(6486002)(26005)(9686003)(186003)(52116002)(6506007)(83380400001)(110136005)(316002)(6512007)(54906003)(66556008)(66476007)(4326008)(5660300002)(7416002)(4744005)(8676002)(44832011)(8936002)(66946007)(33716001)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nE69iPFYYsQoKpDgrsDaMHcO4Y683y/aUWqDDYinKYCcSaxXLpdFle+URgs0?=
 =?us-ascii?Q?Dx59lpXRfQkjnL9FQqCOQ+MMRBDEx2yo46iIS2iZP0vMfHya5OMkilVfX3mL?=
 =?us-ascii?Q?/n6irPGUCMtcpOJilu8I9gAh2CY3wq8BkyHSmz+zRTrMtMrSGeNGBpHTwIHF?=
 =?us-ascii?Q?KcsHncLI8HxPCtztXPeN+Vmvq9vq2L9Kgeh4lOfAbbs2Eiq1gLMoyeCmsc4S?=
 =?us-ascii?Q?OensCG0jlKOdDg7rugNBBqMgdpnx9n+cRk1WbVGeWzHvtUtcAPE9E4noTD9G?=
 =?us-ascii?Q?oDDVhS7sMln7Sa/FtbDvr8O/jgy0srhUG/1W+0q+BiqXdbGeCpmjfu7PD+MT?=
 =?us-ascii?Q?jfM3uKujA3IPJkB73xTyzp9yE46BPKSkhYgeNs5LiDAx3ANnXX6c3vIXDmmy?=
 =?us-ascii?Q?YIJpPdfcJWb4nh8G28X3HEA+dgS3ZGWSzUcwfYT3GYxJ7Lihzt1esIRpp1ru?=
 =?us-ascii?Q?CFtgvQT5IIPSXaNQSTsFEZQB+usQfrHWmB53TlPK0n0NLl89N44eAaI4Xy6U?=
 =?us-ascii?Q?4zOXhWAV3/cvUm45KLbRiuMsmf6iHufXDQifIV4kCLnZanJfXW1lXqC4Svoo?=
 =?us-ascii?Q?MKEPehhXXvJDNiT9o/EVP3ztQH9d5+3bKET4l7u3Xw3ujmNnhCmOImtGMoNu?=
 =?us-ascii?Q?zCzSOHxlmopx16oPM3tGzj7ed+V/ImDmMvXUO+T24uHBuj5sU+HSuPIWb0sY?=
 =?us-ascii?Q?SmQ+zD7qNvbi98bw2hxkyzy5gEhMVbfygIT1GURdVNjwZLbfZIo6Tojj4qoV?=
 =?us-ascii?Q?dYCpLL0TBqkESMlGb9FMY/yVgSr02Hr0qD8+cwsfFeU5YiLPZUcdg4sc6eEF?=
 =?us-ascii?Q?1aJQmoDCIkGIiZwO+I+veM7r9wBO8kJJ41Sw8LHvqQPEJAw5lSErVjOYs2lU?=
 =?us-ascii?Q?1zvCOVN/tlWn0fbCB9NWT5AZzmbOP+cWXCfPqS1llQfJZbpg7qNgMNOOpUdt?=
 =?us-ascii?Q?JyV/b/aEc2BHe2653O1z/gc8LvyRhdWH3gl3aY5s0TrRokfwxmviI7WL72lG?=
 =?us-ascii?Q?+p/bMqd9I6/CJvW/7UeBBpb44CwzlsLUwCJA4fevNUOOBWDcYK008qkfznpI?=
 =?us-ascii?Q?fFQg9tmZ/VpkNUBwYHSvodnENqO8l6tpzfrHACirpzv8VD/RAbz7ODOL/Go/?=
 =?us-ascii?Q?ePfy8c4lkgP7WEVCEgE0mAepuuY8F/p0E+EQhMqZh6X4X9SLN8LgS0zKsQXt?=
 =?us-ascii?Q?po5EbD+AgQSvhCA52AiAqhebkgLBVmJueuBAVSi1bs4xAWf5uEodE2dCJ7Kp?=
 =?us-ascii?Q?18Fm3V/SpuoUXiGi97r7Flgyeu4jWzKt0u1ZnqGvV2TEKMzcV4ta3nN2muyj?=
 =?us-ascii?Q?5oF7Px9rOiiyIYr6xDwQCgtvkPkVjoqNITRluQrOiDWu9rV+YccmiIocwiN0?=
 =?us-ascii?Q?ue2pkPcSsForP0JTxk/fAvwp0LgBl5ZQOxQcdbI/FAIDIC/WeIY95MTLA7DL?=
 =?us-ascii?Q?cDKwfB05tRHnJUVgWZ8SmG9I2CDqDig2h5zVMNIpCIlLfmL0/1GR5/JoPnv2?=
 =?us-ascii?Q?2oPcqwSACarNm8/GbvqzrzrhM4Ld8qDlGTf4KPqR0fSwI4OPOK6mML1I7Zfv?=
 =?us-ascii?Q?M26fETTMDWrRkNNvPsiF5rWaRbdn2uzYUHHoVO5o826nUTkjAQuJEWgl6Da2?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c32a2b1-429e-47d6-d417-08da696c285b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:50:48.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oehmyk9J7hUnmdkNhgixc4YumEhnrOwpV5QwbjNHbdYuiWxq3FmArEsTNjcs32EQAtldU1EEw/rF7LdscMqKWLmNPD5Jxrnet+KP4ZoaPH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190041
X-Proofpoint-GUID: nGv15GB7KoiEWO_WpFgPXAHMTJUB7yzu
X-Proofpoint-ORIG-GUID: nGv15GB7KoiEWO_WpFgPXAHMTJUB7yzu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The snprintf() function returns the number of bytes which *would*
have been copied if there were space.  In other words, it can be
> sizeof(pin_path).

Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 941b0100bafa..ef6528b8084c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -5338,7 +5338,7 @@ static void do_test_pprint(int test_num)
 	ret = snprintf(pin_path, sizeof(pin_path), "%s/%s",
 		       "/sys/fs/bpf", test->map_name);
 
-	if (CHECK(ret == sizeof(pin_path), "pin_path %s/%s is too long",
+	if (CHECK(ret >= sizeof(pin_path), "pin_path %s/%s is too long",
 		  "/sys/fs/bpf", test->map_name)) {
 		err = -1;
 		goto done;
-- 
2.35.1

