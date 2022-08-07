Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0803D58BE02
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbiHGWeC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbiHGWdh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 18:33:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D49AE28;
        Sun,  7 Aug 2022 15:21:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 277J4qAA017312;
        Sun, 7 Aug 2022 22:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=IEv0QDto4Pk9FuhDRw8D6o5naePOGgb/YF09FUsUpN8=;
 b=PDoFEjiUT2JCtHiE5Lmpp/syn2PGiXw4HHVLidaytakujQKYt012t0dLMFZ6FWbBjoMP
 HII1O9u93Qv8sRs35RZ2bTu9Ih4+LBsJGWz3Ppot+Gt1oZjrDKcKvnxckmB4q9PPGb8t
 aNdeo2AJtujyTQjx5MSiZ2Gk4dif/SDImDFq3/DsN8UOsEmFnYRH8huzial6z7fX47WI
 A2Nn6JanQEgS04elrunNpzfVffTFKq7aLgsmTkDb38K9NYMp0dqq/9d0fDnFwZohMiQr
 65W5a6WxhU4dzC/M5UKBYCnuTluU6gQGXYKQHMmL5yQ4p/+UKZ5G445uQnBHp3HQ7VtU AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsfwsj14k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 277DG80s035214;
        Sun, 7 Aug 2022 22:21:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser7dpus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDntuknOgPGIlrn1SmFSrXnunH0+ejcOddlsDuW8kFbqnrROUiwI2d/mCO6jxDax6iYrWD7vqq8EVMlhvIVIwnh8G04kYkntk+WbacTw/0D2+Tkqwh27iuFPchieJ+1yLbIERLtM77pCGvJENmV7tne/Vd9yBKq/nzfVs6xeQztQOegUvEOFcfKzhNLEP9+bK/aMmDWBn9Zf8ktJFdjVhXNaF329ApYv5e8lB/orBTgMVYE9JfUhW0r6GdrHEkAzYrAsJv9s5W3OTVcpHnuvrD4hjzph6QzShNWvodkIpJGk9bPoWGzLvDFSBRLbWYp7WL28qYXGRBD+EBVSeRiWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEv0QDto4Pk9FuhDRw8D6o5naePOGgb/YF09FUsUpN8=;
 b=MXp9HROD9YrtA8DujuGMJ8E9zrUnuuvkF5vNP/7NkPwL/n8gEWft7kYfkZvgTpfUPWp2v3426v+CVxU5dzWcmFl+4hG0nVyqZu9SMTBW6iRv3pKlKtnJz1KFpvu9D+ClMjiw1PCg1CgKdoPTtYQz5Kk8CfrADPlMJJDDq/9bR31fwnEY8P94ESc5DUbPZwttq+XdwG9XWgxL0JSr3oNgRX6pMbBaqGVjHaEfgN38Ey2uKmhCXUFx0TVhxH8HWRkfCSs5DwHmmdQs9leQQ3rse3nX6U9pf8wqJF17pOuoELkDyHA8gWb7RBS6yrlW4imLZqflAVCstvevSJWcHCdkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEv0QDto4Pk9FuhDRw8D6o5naePOGgb/YF09FUsUpN8=;
 b=D/cGpXKN+Ak1Q/DfzA2aGWzjQCuFauSUCAYzQOIqpwNUuT6ilolA9hkfPCXU/snjaXXcTkSK2MluPKhXwtdxr2hfHMq/Y+cgSvbbGybVUGLl+F4D+BCZA1b7fh4YkrKKJiqhkdGmfcr3m+N7KILV3FCWyEYuGsYuFjc0Xe1/fEc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MWHPR1001MB2381.namprd10.prod.outlook.com (2603:10b6:301:30::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Sun, 7 Aug
 2022 22:21:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%9]) with mapi id 15.20.5504.020; Sun, 7 Aug 2022
 22:21:37 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org
Cc:     corbet@lwn.net, mingo@redhat.com, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC tracing 0/4] tracing: support > 8 byte filter predicates
Date:   Sun,  7 Aug 2022 23:21:19 +0100
Message-Id: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3c4a8f0-8772-49c6-0843-08da78c33166
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ThuDJmRBO2a4JEtMxZ6dZx4uJawfhwEm7NsRsjeSzA4y3GatjJki3RdwNt7HB9O9283y21mnxbx4i/Ms8W7U/F3nt2A+sY5/Ba7I/mCZNTY8CWh4AyQs9l04TpUyPlgiZEbwWKJ7tsEpLCn1H/EkDAv8YC9nnvPrFokTaDO+WDTfAR1fNyN/a1uv9rGAscKhCZpk0e6wP4rVMD3//B/2cc9+rAL2+tYpgIbqD1djqVk05vURvJd7b/+VI+M4BpRkrpV3H8l9yViJO2B5LZZz+SyABhLYEcZc7XWNetpfbgvWTbFXfXMugTiwzxXBitnFf3wq5KazPsgJ/0tX7DBtCiTy2glFU17gcaZI5qKBQDApaD5udsRfxJihzOh8O6uHs6wY6+wy3lGhynH7glLUCgNuDbw2bav57IYL/JVY9Vfam2DZHXzgCPjDhiRYUoxtvLQoVSw0akgTDJ094+BbreEX2+HNE89pihS4kXEFW2xwiO1piVuH/CpeEl4sx6xb8WSM8XlP1FNfW2e7cc/xa89QhpOdNvTNpE36cftDzoBVqHjI2rVMvlFd1/1JZNnglW3H8VmAbIICyGxodwhAHh+oXiXdVY+MtpwNYi2DesxVKLmr9HHnzHPgjrgjoikTApSli6srUWsbWXCYnTJi4WQsjMNwxKZEumgCpfpxEL94i0obEl8QD9gUTT1ld6SHhZDE//D5C8hCIuV/dIOemuKflrutVui1ErIv0mxJghQvSKlATlpr4oPslt7y5+QxH+lSLOmZ59J5xBERudwcDqIHxJCDbOZj3g1It+xy0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(396003)(346002)(6486002)(186003)(52116002)(107886003)(478600001)(86362001)(6512007)(26005)(41300700001)(83380400001)(6506007)(2616005)(6666004)(2906002)(66946007)(66476007)(66556008)(38350700002)(38100700002)(4326008)(8936002)(44832011)(5660300002)(316002)(6916009)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oiBSvg2gWXvFfWdoLNApBKMeDgYcbbXgLt8+lsT/6GmT+Z05labn4w5UJDOp?=
 =?us-ascii?Q?9DdJ6gpteTu36lnyKvzMdLG4xhJAI0tB2ygQH+PkdLADIIrePsLAgmpkZTFy?=
 =?us-ascii?Q?1yP01bQSHi5Rk7kL/MJr100J6Bw1d3C2wdGYAj+wPjwFwrwD9WEk6mrOqxZf?=
 =?us-ascii?Q?9n1dp2Dit+H/COXkdHN73oe5SgxBxwBcf0xbPukCuSHLathk4w8ZOOedjDqU?=
 =?us-ascii?Q?vy1GAs9PeZOojKx87HAPwbZDHYlpGPplf8KwU5pHz/Q3K7eq4IwNcDh3xT3J?=
 =?us-ascii?Q?Nsdtog8P6A2EqMGo7ic+yCoRYoPrz6vuYACmhQuGb+s8wTgy5aQRXh9xpJGs?=
 =?us-ascii?Q?HOzo//C24zUZ2gD3lPy/PPi1W//1xcB5dggdraB6dibJcrXRuqidYI5KWjTK?=
 =?us-ascii?Q?a+d7GFOi1iqH7C19Bw8u0b2OIVmGxRTLrId2KMjRQvneDSDnRWrq1P5+FA5l?=
 =?us-ascii?Q?IFbV37DB55YC0BBpB1NNJLsZDxt/wjlGV6ltVVG9L5lUf0ce1h2hxvU9pHmU?=
 =?us-ascii?Q?OIOYkppMTYAOUdTTd2vBIUF60Cf5tnfMWilm59D7LQVrfaODEof6aDv7VxHp?=
 =?us-ascii?Q?rA5kVcCEjHCiz/m1RLiTCXz8QAln1fjbBeTzheZ+BCO+c+7pMJdLiBO/j8Hk?=
 =?us-ascii?Q?7mCtPoPOLckW+cm7G+X/74hdEhRmOe7r7+2yCHLeQDuwPz+uHDGNbVv+J7NK?=
 =?us-ascii?Q?g6S9juvxqVON9msCD1dE5lDNWz2anVPOe9BwNsc2Nrow1fPWJDymRhbF2/bW?=
 =?us-ascii?Q?kTDHI5+iA5SPTTBy6JSGphM5mumC6IjEAptXtI+u0hzs8X9bjPpyo/HgdheD?=
 =?us-ascii?Q?RTVcePvJ7BoQlaTx3qhB/6r40bTDYpacn8blP0z+humAyBTxDqsL+YfyUq6x?=
 =?us-ascii?Q?bVEvcEN0REQU9+K4pj8sttnMSUDA0BgWq+Ra99CRjVf/DOI3JiDGIgBLhI0q?=
 =?us-ascii?Q?DknerZesEVoBv0hTeKs5hVCcbwnAaQyGTqckIaQggPLl2x4LPrKvFW22ovEE?=
 =?us-ascii?Q?HfDjUBcj+wRMVXAaD+SG1O5sf4ZSTp9uaA9bckokSUdtjrJWjdQEL5Kbf+it?=
 =?us-ascii?Q?C83cR0pHn5KkjOqkoTtoNc2aAarkSMi1zgr0DRaDom5OzSOpXZ9Y9vacZrft?=
 =?us-ascii?Q?NQ5CR46W63bYoEo1e884PWyR/fy3jC8KfUH8CYcNseCsPPABqCRoI73RXCF+?=
 =?us-ascii?Q?cWCArglpQ9u+wtzK9WOlW5yB2ODqTXEVUFn2ydjklYpInQmaZR/YIIE0TtWm?=
 =?us-ascii?Q?Bqnh31VOAyc2BaR4k+5KC/EfN9wJxkj3bBLYAw1do2ZeiWD8a92UT8GAfLMz?=
 =?us-ascii?Q?qeH4TzXQp1J7k1nPTbZZe/ZMcjKeobyK+pvCN7D5Ti/mDbw8WRL8VKbx3aJU?=
 =?us-ascii?Q?C1jIrEOJRJIoz57EIVrRh76N3k+51qda4cEst4jzzv9birOYuoBXr7lqwPxX?=
 =?us-ascii?Q?S44xO6gMGS5g4R0n2qdcFGxDRZc837nmfGfhawhT7aLGmQTSO6bhcz+EeXZa?=
 =?us-ascii?Q?MRt4hAVVKBgDqYBp+t7VLF7PWD+rme61LDbpEt1jTaQ/b2LGSbzMEm7N4/m0?=
 =?us-ascii?Q?Lpcxg9hLoUW+OK3c2NTbSWnSTKnp9XGyCpPqBPQr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c4a8f0-8772-49c6-0843-08da78c33166
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 22:21:37.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtV8xiNUgk+qL1uC2v1TcNO2L14LHYx6aqz9SyCtQk6CUqiu2LZmtrp4IVtMo8GMdwwhXPIzI+FcYRPqCU7rLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_15,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208070119
X-Proofpoint-ORIG-GUID: -gguk092FezLH8-VRd1zq-EAGljttw-v
X-Proofpoint-GUID: -gguk092FezLH8-VRd1zq-EAGljttw-v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For cases like IPv6 addresses, having a means to supply tracing
predicates for fields with more than 8 bytes would be convenient.
This series provides a simple way to support this by allowing
simple ==, != memory comparison with the predicate supplied when
the size of the field exceeds 8 bytes.  For example, to trace
::1, the predicate

	"dst == 0x00000000000000000000000000000001"

..could be used.

When investigating this initially, I stumbled upon a kernel
crash when specifying a predicate for a non-string field that is
not 1, 2, 4, or 8 bytes in size. Patch 1 fixes it.  Patch 2
provides the support for > 8 byte fields via a memcmp()-style
predicate.  Patch 3 adds tests for filter predicates, and patch 4
documents the fact that for > 8 bytes. only == and != are
supported.

Alan Maguire (2):
  tracing: predicate matching trigger crashes for > 8-byte arrays
  tracing: support > 8 byte array filter predicates

Oracle Public Cloud User (2):
  selftests/ftrace: add test coverage for filter predicates
  tracing: document > 8 byte numeric filtering support

 Documentation/trace/events.rst                |  9 +++
 kernel/trace/trace_events_filter.c            | 59 +++++++++++++++++-
 .../selftests/ftrace/test.d/event/filter.tc   | 62 +++++++++++++++++++
 3 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/filter.tc

-- 
2.31.1

