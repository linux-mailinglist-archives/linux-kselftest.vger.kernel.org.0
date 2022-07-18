Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C615C5785BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jul 2022 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGROsB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGROsA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 10:48:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC6A140EC
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 07:47:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IEi5AI014203;
        Mon, 18 Jul 2022 14:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=7gIqVswPwoqpcgecijDsaD470pvLQHPLaPcctJ1ZXjo=;
 b=wCU+jEYSLBVqXT0RU5j01RwBScVh5zNgnwoTIXx/sUkmciX+IUuWpkCVn2i5ts97t8pv
 uT0SAP/7Qga1u7snDJ5F2uPaDXmaFbBaq5/vpenAWYb7ukwmopq0mQTh5DjO3YO6AFd1
 vhRxYw900hTszYT1Ms4M2JLEyyRUNqkSDyTkiRA03G3hOXOzPlW9G9tLzffrHCjN/Fdd
 6c5ZVFpvjjmuxKXQx8hqFAohXR7uwkLVGLSKHMmrfFX9VhoxAqwl4LKrO0lpBaNTBPg/
 C1ywwNCCmMgsDHUlSPw4FlqA1oF0ZPV/tRAAhbIRmvMDQ/FABJYohztj7Lf8QXugJpR3 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a3fsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 14:47:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26ICSltk003995;
        Mon, 18 Jul 2022 14:47:55 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3vwvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 14:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/qt7g1nrnSZMPk3zzn6D1sTdlrjHM36fWU1+Msl04joK9zunGgqpxqtLc0CXbE76UGWCujYH2D4BPkB2gQzwmqSN+XfuhanByBbbB0lytv/PLxmoHa/2O5sT2E8/5fIivGCQ8LELafTX7hjvOF0XMhKUPRdqEM9Hwlee6NJa4869XL14O0OPMVOB4FmIkdSClZ8OzNucxNXNb6a4cluLi+401Umf4ZkBUirPK1jL+YB2q7zPTNoWsDUpdfdy5Ho5NaJote6fGrLe9djlPOtVnFAgA7BlLaVmawpTlkGaIX4eeaT+CXERSr7Qjgms8oTGBLLHkfrAptXQ4uDS7vfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gIqVswPwoqpcgecijDsaD470pvLQHPLaPcctJ1ZXjo=;
 b=f3SSprAiPPqKgOZD6pIlayA5gHhm8GXsOUWNah6P+BRc5yUAZzwyczoR50VrNUbVSxMNllod7p7FJrHEwJjwcJgsyxuF/ZGuX8reid09wwL36UBfWmrM8NFzpgtynDIHK5fhSDmuRYXTUbyEjbg4pEQuYZtbT537Adl0EDZyCNj1Zu29HQKXluHf1wIXsEsRHVPqESKrjnbi9Aru46RoIPaZzOL/geT3cHtXOkYe4ImkF1vPs4fnJH6HIP+yUbI7zKdIxJrGe4N9xZv6TinFNqxrzUQpIBRQhkz0IIy7nHGlnbrkyvD5O1L07AcKd54Jok/592HT6FTIfpiyrZnTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gIqVswPwoqpcgecijDsaD470pvLQHPLaPcctJ1ZXjo=;
 b=m5iPHMjhkLABrHDi/+Dhu6miZNuWML831W9h5yTChh5HQODLufWarDaDxlbUaf5rk6PnzyDF9C5s145B7CcxOYNTaPXEB/S7OzhouUEaXENPzhSmBeHG4S9Eeu5s/3QsNE4ivuVGFxplEb9LUt+wNXwva0Ta3fN2kefDZRhg3tc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN4PR10MB5798.namprd10.prod.outlook.com
 (2603:10b6:806:20d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 14:47:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 14:47:53 +0000
Date:   Mon, 18 Jul 2022 17:47:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     amit.kachhap@arm.com
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] kselftest/arm64: Add utilities and a test to validate
 mte memory
Message-ID: <YtVykH0CIFM9bw2E@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MR1P264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab51b07a-f862-4cfb-fe43-08da68cc7e86
X-MS-TrafficTypeDiagnostic: SN4PR10MB5798:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcVFjLtmNdRvbdXEyY+KpAHsnwBCMB1EI53eurtV/5+7tECrbTn8qQ/cP1HgJ4WZXsTacimr2z0SCaaUaXvp7XrfQYfuFktlyozaItD8WIkyHO1ZcMIJL3osEAX/C7a1gF1XRMk1irACKbSWNbFl+159+qHmh2hPcGJQl71UMYSYdwiIW/N6/iI7ZQCQyy5FTJlSsJ3bCbzZ63efnvE0uH5rwHEjqDq9TU1Iz7Z7X6S3f6sIa5aukdvpqz1wILv0KhRKkyXl1Dr/eo6sMhi1hkB0s033tIyf4DXKJDsAK7uPARCkfTwHW0BHInjqS0HuoNzCu6PC6YHD4Ejixm4wY1ep707m0M8OLMLvHEKneoV1BtQMSbu/vtxGDG9Uwq/oq776bQaVluwt9oVTDMR48zNh+eGfGDY9QhPCwIPTz073KSd4XGHhgD+7+gxblH1+iRSVsirT5a+5LwZzmCO7pIYvINFjl81nEZBHe3Av2uWEKnC91Fx7I15Wg7retZwEwayPCby6aP0ia6T9GNdb39Hd67Zobs1bZFnle/aUPcpqZeWs/ZRfUx1XSQBGtTgAJnVKKqK4CdP74yW8FUfOjmeyJyzpKjMbiyQHbtVM4QDGp5Ug2c/BhwfXKxpKb3bI6EMYlmZDo6GL07xZqEPb3f8kvJlRlClctL+KwPgfhH2GIL1XloFW5bV6Ly5+cLrw6CcWWX2YiHgLfndB/WEEKdkdLGBCR8mJwWE9/eJDFbTtYsCNHOpHFUfaYLLkzVhIvG5SD35a2Lnffk6HSmiMNapj+h8oljUVSqdhlwNzqEhPQiCVB2HB5SZzqNeIfSXQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(5660300002)(44832011)(8936002)(66946007)(66556008)(38100700002)(8676002)(66476007)(15650500001)(2906002)(4326008)(33716001)(83380400001)(9686003)(478600001)(6506007)(86362001)(6486002)(6916009)(186003)(38350700002)(316002)(52116002)(6512007)(26005)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zp7B+cwz30Vas3FtiLDKHVeoobnY0oaFjeLGaCuKC8pFldDC7VBrEWeEqwg3?=
 =?us-ascii?Q?7y19YWHS8/GWJsDu5UQ2nWpVJBu1/SAzOi56wcaFkhLs0eKT/HEOFqlRbZfu?=
 =?us-ascii?Q?oSOU/fKS+aSF99his0qx8qKy5MIISSba5x7IHRbFacphmMFzsZ4oI8DtNMzI?=
 =?us-ascii?Q?DmrP21ZxhZ/7w8o0B46xQrW9MyZj4/TGsnjuufky2HypnmG9zCeUxM9/jlcd?=
 =?us-ascii?Q?NoEceq8N6anOgferqe7rC634Qs1opP2O/jEv94ehfHHEhfCrW6gM8RfblVr6?=
 =?us-ascii?Q?s1cfK7KwcQh978d3Chl/alqwtB1UghNlUzxesT4rEB0YbvXs/+T1i1xhsIr5?=
 =?us-ascii?Q?Yd22IRg02XG4mNhxMNLyh0ijWxWywE+D2TRqzLqP3s2Tl9u7/jgqKwKKzSLr?=
 =?us-ascii?Q?w/VYnhGRiIflMyvSmJTdLNM9Xls7NL+/cdt4jw3nRAFPJM6dmyNdNAgzSlvX?=
 =?us-ascii?Q?L84vPC3tNxHLe2Qx7MVo66r4CBBr4FPz7rIe+wjavTE+kmidTm8oqZtzLk+Y?=
 =?us-ascii?Q?JAq7Q2QwRClTHNYbeL9jd3LnJPSuXf2G5mcb9FeivvP8uiXVzYrP4HeRL/VD?=
 =?us-ascii?Q?Uy0Y5DZLLXk3nefcFpnPdrg+dKcEztx85RMnI//o3cQPvHTYcU/Se99xd/V/?=
 =?us-ascii?Q?SVKxblUORefP0eQReStI6B1ttxLJqgEWj06B00ZN1QysULpaYzfL+vLXq/uU?=
 =?us-ascii?Q?/3xzyursF2KqMMGVgd6gX0F7V0DxBIA4DGObaBbyChYnoIs4VBANlXhVn9Nh?=
 =?us-ascii?Q?0QgaHJ1vxPRVmwvDcdha9BhaVTg7j97UUoZVITJRowD2+nscBlW3Q8Nbnpf1?=
 =?us-ascii?Q?pcK0Wbr2VGIs/eVRT3qTTmicGpzDRp5uJJMXesnRQMIAWZ5D+yKCdfIx/yUt?=
 =?us-ascii?Q?6xGCvhDVftnvimf2xpG25hTmkTGvczRv8L9HnQQlAycIX1flu89g+TBH4gpq?=
 =?us-ascii?Q?kR6yzesYGIH48Z4tm3lBZ8VhycX39VVrDZr39m5jcBGj9wdGbTGzpUHl/2Cq?=
 =?us-ascii?Q?RlEscK0iL8iKK9odE6RFhFkR1E7885+ThihcEiHiXa1//JWqKh9qQtzlcAMJ?=
 =?us-ascii?Q?Jjue1HJwvm+eWA+TrzSBSBQPhFxqQW5soPjo3lYrd/j1ftmMbD/NeBtIOWC7?=
 =?us-ascii?Q?KNDr4e3AimXtj33RrRAOTs75pAJCchGfAnTvjC11jevL4F2ykGUMsN7a8t5h?=
 =?us-ascii?Q?SqHXl6/AEHFxJfk7sijLY90JGWqLwmzUWWf3fZ2dQuq1P/fwTD39I7LUnoVK?=
 =?us-ascii?Q?mPDsJ2yK04NPa2O808Hjycp5c58kHYmi3LAJIUo+mXfAaCKo/aDgaD+66FlK?=
 =?us-ascii?Q?HaQbak3zc0o0Hp5hR5RwIaQH2XF89A+hhHF7K7t1XL00avw/qlal4GdJRqBT?=
 =?us-ascii?Q?P/HPQfFOyXi2TG3ZpLAWGxWHTJ4qP45QOSKvrcK5V0rGa88Td3rJyJqV7Q1b?=
 =?us-ascii?Q?SK5Srk/2HtytHMFdp/SUiv4M0LdfLdiiVl2xLVnASLndwxtHzDqYETWnUG9U?=
 =?us-ascii?Q?z7ksSU1akv1IhtvQa9oVLPXTVp0Tzj5LkjDki7dYwRZEvpFEP+DIIKkre618?=
 =?us-ascii?Q?YeFznvyerv3eFvgnFMQfEMSF1VYzFmXpoTD/L0FgohjMk831xqTibhYKv1pG?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab51b07a-f862-4cfb-fe43-08da68cc7e86
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 14:47:53.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Wzi6FHBD3a0R9V3TPLjwyP0ZyrzwsSSE4HHzU0Dr1ieq8xZDPCj+T385ANK4BN42fI7QYw4D9eDGwRqIcUWuXCZBCrf4WF2JeLusMCar2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_14,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180064
X-Proofpoint-ORIG-GUID: huPX2zzgyXm6UcFjDV53_1_XRupdvLjB
X-Proofpoint-GUID: huPX2zzgyXm6UcFjDV53_1_XRupdvLjB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Amit Daniel Kachhap,

The patch e9b60476bea0: "kselftest/arm64: Add utilities and a test to
validate mte memory" from Oct 2, 2020, leads to the following Smatch
static checker warning:

	./tools/testing/selftests/arm64/mte/mte_common_util.c:336 mte_default_setup()
	warn: bitwise AND condition is false here

./tools/testing/selftests/arm64/mte/mte_common_util.c
    316 int mte_default_setup(void)
    317 {
    318         unsigned long hwcaps2 = getauxval(AT_HWCAP2);
    319         unsigned long en = 0;
    320         int ret;
    321 
    322         if (!(hwcaps2 & HWCAP2_MTE)) {
    323                 ksft_print_msg("SKIP: MTE features unavailable\n");
    324                 return KSFT_SKIP;
    325         }
    326         /* Get current mte mode */
    327         ret = prctl(PR_GET_TAGGED_ADDR_CTRL, en, 0, 0, 0);
    328         if (ret < 0) {
    329                 ksft_print_msg("FAIL:prctl PR_GET_TAGGED_ADDR_CTRL with error =%d\n", ret);
    330                 return KSFT_FAIL;
    331         }
    332         if (ret & PR_MTE_TCF_SYNC)
    333                 mte_cur_mode = MTE_SYNC_ERR;
    334         else if (ret & PR_MTE_TCF_ASYNC)
    335                 mte_cur_mode = MTE_ASYNC_ERR;
--> 336         else if (ret & PR_MTE_TCF_NONE)

It looks like the intent was to make PR_MTE_TCF_NONE into an ifdef
configurable thing but that never happened?

    337                 mte_cur_mode = MTE_NONE_ERR;
    338 
    339         mte_cur_pstate_tco = mte_get_pstate_tco();
    340         /* Disable PSTATE.TCO */
    341         mte_disable_pstate_tco();
    342         return 0;
    343 }

regards,
dan carpenter
