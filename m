Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF70C57A0FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiGSOPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 10:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbiGSOP3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 10:15:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E58E4E875
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 06:44:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JDBFeS017922;
        Tue, 19 Jul 2022 13:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=AexpBLZ3hWEnvpE9AdLXiUS0IR4nnxeJDP8m6uQ8l3w=;
 b=vajdRZTxcSrJsssF1TIQhBhCbf2GszsusKfuE1jA4nl9RmBiE2O8TqJeRocwDWGNM1kD
 S/IFHOZZj+RjFgijtH8dt+PCYDhg1AEQ8eFXi5YGZ9n3vgwbOzQodNmhzSHvyrQfXHtq
 xytwusYVujVT9liFINDs5w/8E6j5ZQHSiIxppeX+g6k9YUY+acaLEFlIX+gGOKwI9FF+
 gfqjaSplVMLPteEZLZrvuXmrXWR0Uw7GnWwMclJW3njnIq1QhoXS6elriqiVkeIgOxrB
 kgMNa47v3sdBBxxGHmT33heXbUrWD02dqi93j64L2CHzeqSYuNzAoVF3d81QopSXeCvu UQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0xf2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 13:44:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JBVRE8002722;
        Tue, 19 Jul 2022 13:44:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mb51u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 13:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbyjHAfXFCQva6kvWKYXcgOD5TPjE9ZQwAegeJK/QQih1E3ytdfG+VCLSzL2xg5s3MrghV+2x4haUzB1FBgYsMDSk9E74x9ZE4d/4OAZMWxJIqJlf5Rp4vyPQydupMHcxjnuA+OA3Wj/YNMeNJ/M4vDQOxs0RSD3CsPaY7Na92ZSgu7b9ZwuQ8DESLkmAufBReobz5DBhwwAsOAWnji6GxiDWCM1F3y09czupYeYAaPcx78wUnEpJdIXKwQLZBzbHHAmfprzDSvZsy2sxboPI5TWuWsQje46855mV8XKCtnA9G33ekCqMsUtksOFsmhUUWZ7QkBuWIItvP2iPbriow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AexpBLZ3hWEnvpE9AdLXiUS0IR4nnxeJDP8m6uQ8l3w=;
 b=YYDn8EzKo6/my7ITVQIqd2qrB9UJ2vlYll+LKRDTwnpd+jsvckGrpjlVbOS/Q/MiMIKoTks5H1nsLeX5iZZOPu9HUi9+VwVMQ25ibwMAqrnwTiCOvE7zHht4DPgmFgvAcEWgdtfk93TIPKlPbuQ5Gya+PrDBv1mOg7QsKZ7Jvs4b4O1h/fI9RsT42U4WDrKNvYoVfzJOxbYxU9mp796cDCkwzJ/8jwqVXL1/NoI7v6gsp61WVOemB1PcEQZSNKTIkbx1+wJRSbuFtFHxgHYXiIHJVf3AdFrX3HX/Ytdr9YVUb02qS+wUlS5DanWLosIgLIFTDg4bK+T1KLazq149vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AexpBLZ3hWEnvpE9AdLXiUS0IR4nnxeJDP8m6uQ8l3w=;
 b=H46QuNykoA9IUIclv9XBlEWo0A4rCwca8M4cqPs3dj+EpJLiNY5OIZESXhyyqVzxpguld5YoqoCNoi4v1rsJ5Zfh7fd/rmhLlVEC3AB5Jx23zSXeTefYIca9ew+p5WTZj8H9F0J6VlXcKo5sLJhlLgDmvHzPwsXzutFUL0ApaJc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4073.namprd10.prod.outlook.com
 (2603:10b6:5:1d5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 13:44:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 13:44:22 +0000
Date:   Tue, 19 Jul 2022 16:44:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     0x7f454c46@gmail.com
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] selftest/net/xfrm: Add test for ipsec tunnel
Message-ID: <Yta1LXmj5e4CPmNA@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0164.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7076e050-508b-46ef-a220-08da698cc940
X-MS-TrafficTypeDiagnostic: DM6PR10MB4073:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kAwGVpHm3R4N3bIxE8QSPqBlg8zudVN2WgzbNQHZLUJSUTcqKD9cLtGJnBr+PxeNHzWy1uUxQUugdPh6Mhss+UW4kB4R3LuZpFxizjyjJw2xR2euTvvdSGBkFA7FfwBzNoPmweLE1Jxbqn6GwxvJIScMLEOiAr0ylyuiqDXRnwnF64MZZ4QIvHDY1dlHF6DqLvbtp+Qyd0H09mJXER2dmphkaSIvIVbmNBy3QiqXTDRgdQdG1AVszez5m8FafYZOh/Mjtci8TaOCeeqkw2AR8omYxIBuDf6GWmP6nOOyGM5rbl9hsCiDpQLwiKetLCEmeudpHsBDqjteK7/N90srDUGud36iqhScPuNskd/7hGLKq0E4yRyinTJ9NkHRHhapZR/olG/ZwVItlQcJmcGWj2bR2czx3lQhgF4ixkTJGDnM8Awo2CaNIN+cs1BGY+IWWjFJUQhUZMBimgdOohzbtGwS3AnP/AsanM18sLjyZcyndjdfIQnl/dOoj2auL9Dg0vUpb5xisstmKkaki9EGglFIiKY/WgTa/OudVfKgpO7RbvYRE5pZlgJBxYBphlaR+YDORoVmJiBxL/QKMz9C3XD3+7j/Zh6jyfX7PgHxeedZbfsjGXYbTVjeE1MEKWUklkZgj9dXhadwh+FIlK+MwV5NdVVPRcW5AKA7Bv7s7Rwl1YIlLt7wr+KCVsuhzQuluM1kmuS+hiyp1htvQGCbjwl6tNJbshq0v2TEZifDTztnFpDLebFuYHmLIagU51lbsh9RDVebWDw+nV1oklDwVtbIzHqXHyKuGLlMmLxTms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(396003)(366004)(376002)(136003)(186003)(83380400001)(38100700002)(38350700002)(66946007)(4326008)(66476007)(8676002)(66556008)(6916009)(6486002)(44832011)(6506007)(86362001)(6512007)(52116002)(9686003)(26005)(316002)(5660300002)(8936002)(478600001)(33716001)(2906002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1mh6zxiVX0EFQq99muxX9y/qQ/GFOSg6rCZmOeHFEM6P9fVfGNFrsUrkh+W3?=
 =?us-ascii?Q?v2PQCyBJATIwb38I2cpmB0c3PWwzv1FrE3bu/l+0g3Rd5Kjt+zPUgFvzAeHr?=
 =?us-ascii?Q?kwsGAHknbyJjQCauyM0prq7Q4T1pSXwCvOAD2nzO+63bg+4ruKqbxV4ivjT5?=
 =?us-ascii?Q?pRq7G+5XPW4XKnFJco7S/7qKt66sZHRTEk+NUIMt7RcPYk9lb/Ziqu0WBTcK?=
 =?us-ascii?Q?CLpIHZqb031B9uvWsYB1bnLk7NRU9J63PdrV5936kTZsgMz/JWtuiDkXyZ0s?=
 =?us-ascii?Q?kj4H12oMot1Ctq8DJXtOfMS8ZENFdJew6i1nl9ijx6jnirWkSkvOQW7ZN+OB?=
 =?us-ascii?Q?QruTcl4RX8o7IX0K3WQui9wQNUXwmtjXA8GpdYDllA1z+yQxuzeu4AJYx2GB?=
 =?us-ascii?Q?A7UVZcsQcBYAyVc1bRPc6mc5vpU1eckF5/VFsm320xB5HR6ejf+x1jb14Lbu?=
 =?us-ascii?Q?iB5L1vN7M3XyL1iCQBz+lw6RTokXCN7Q4qMR7d8LaIf1LehoIyGFcDeDE1WW?=
 =?us-ascii?Q?umfMZp9G3XeUbkN4D4r4b51JYQ905UljliBB5dUpxwvS9bBtbf4dMV5/tcbw?=
 =?us-ascii?Q?5H7MOnYSl3m91zrpgFeYLt3clYmbSVdf2A41wQQDUABbC9MCZ73fBmBOJ5Bd?=
 =?us-ascii?Q?uy8LBzNlXgtJBMQkmgq3l2Kqz8MbOMDQ8LAukkZ+/TeYOx9FNGx1X1m6tLvD?=
 =?us-ascii?Q?EODByDYwJt4FAbOLAYhwzN7h6lN9yJNeHkHecxPKEbXLgAbNubGDYwMltfxp?=
 =?us-ascii?Q?ZrAGVcavpSqZKPc5ajUbmNHJI+mVRel9VZyZ7qx3LU7oaGj+vhMaWEn8I8N/?=
 =?us-ascii?Q?weyZVwJBheUc6NAe10T1uotdX81M80JU4DbJ7NzB4EyIIaUMNIaixL2KoNEa?=
 =?us-ascii?Q?189jooFNccEXX7dirxcCkw8Nu30NsHb5swgTE71Gib7XtGUWERRWDELMgoQ5?=
 =?us-ascii?Q?UUq7cThJvvy7k+TfeXHcylknCZoWFNgGD7M6dXZDjKoyhc8UgENfZbxmAjn4?=
 =?us-ascii?Q?7tIKWXjwCunPvw9QYpdkmR2MsTyO15+3AlWXgYSN8Y86sAsE/K/zAM+/kfTC?=
 =?us-ascii?Q?iIe5C2s75AczF9/sXXswx/SuJHKMYQ7ipaKKXPRYhB0yMPW09uvTe5qu332D?=
 =?us-ascii?Q?JV/Ndj/FJ+5InI1gIP7WIgwq1/ZcjT1U2MMUn+aN1H/MejV0dLMwd51bSfnf?=
 =?us-ascii?Q?l7qeQtQI2LBYypYacusfH6qzZGz5K4p+SqClKbwAjpd05PuRvFE1jSigg1Kk?=
 =?us-ascii?Q?MRnVwNFrQPo1OnKyHOpXHYt1EV//kyRXaUoeWjGAHGoWrZ6TH8BxljxTqQSt?=
 =?us-ascii?Q?CB3vWORYyQ434UOJYoI1OeeA+BSdXIgK7Quxvn6LWg4RGw1NQbuA5XYFwFxB?=
 =?us-ascii?Q?mxDoXBx+isg7Y6Ce3YZOndVhy1n8My2X6xUK922FoLqfJgkMtFbB/d1CF3Pb?=
 =?us-ascii?Q?DcGOxHkfiy92rl4KGDacrMcghIu2hFE/kM0xdqEgkown8LeCSca6irJ+fEnA?=
 =?us-ascii?Q?1JvPJbi20PAJA1XrlERgtCEduSSQIM/B9gFE+rWbzQXCO1g4qxwxNJkbfr6X?=
 =?us-ascii?Q?KrbGnwmgmo60r0KzeOG3z2Wy2XvyCNuG7xVQlRyVGefE8qts3BMizOjUaHQS?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7076e050-508b-46ef-a220-08da698cc940
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 13:44:22.0078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHCrSW+u6dhVMuJk8GJy4LjxkRlzI2nV2jmh89RnFHy7iNn4SoRe9pEfoIXUQZJxR7GgqxRT2zUntJJLvY8kDkR5aw6CFqcDUm28cZDngPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_02,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=900 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190058
X-Proofpoint-GUID: KlN1Hvl0qArZWbDr1y1PWPiVQhgt1tnI
X-Proofpoint-ORIG-GUID: KlN1Hvl0qArZWbDr1y1PWPiVQhgt1tnI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Dmitry Safonov,

The patch bc2652b7ae1e: "selftest/net/xfrm: Add test for ipsec
tunnel" from Sep 21, 2020, leads to the following Smatch static
checker warning:

	tools/testing/selftests/net/ipsec.c:2294 main()
	warn: impossible condition '(nr_process == 9223372036854775807) => (0-4294967295 == s64max)'

tools/testing/selftests/net/ipsec.c
    2278 int main(int argc, char **argv)
    2279 {
    2280         unsigned int nr_process = 1;
    2281         int route_sock = -1, ret = KSFT_SKIP;
    2282         int test_desc_fd[2];
    2283         uint32_t route_seq;
    2284         unsigned int i;
    2285 
    2286         if (argc > 2)
    2287                 exit_usage(argv);
    2288 
    2289         if (argc > 1) {
    2290                 char *endptr;
    2291 
    2292                 errno = 0;
    2293                 nr_process = strtol(argv[1], &endptr, 10);
--> 2294                 if ((errno == ERANGE && (nr_process == LONG_MAX || nr_process == LONG_MIN))

nr_process is a u32 so it can't be LONG_MIN/MAX.  Do we even need to test
this or could we just fall through to the the > MAX_PROCESSES warning?

    2295                                 || (errno != 0 && nr_process == 0)
    2296                                 || (endptr == argv[1]) || (*endptr != '\0')) {
    2297                         printk("Failed to parse [nr_process]");
    2298                         exit_usage(argv);
    2299                 }
    2300 
    2301                 if (nr_process > MAX_PROCESSES || !nr_process) {
    2302                         printk("nr_process should be between [1; %u]",
    2303                                         MAX_PROCESSES);
    2304                         exit_usage(argv);
    2305                 }
    2306         }
    2307 

regards,
dan carpenter
