Return-Path: <linux-kselftest+bounces-1379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169BA809162
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 20:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923A21F210EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC344F886;
	Thu,  7 Dec 2023 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S2P8TqDY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wfZ6+z7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B92C11D;
	Thu,  7 Dec 2023 11:33:52 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7JQnnF021849;
	Thu, 7 Dec 2023 19:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Y/yPB+ZuNveL3sslVVsAPHGJMVwWyWgfjUVsx1MBY5s=;
 b=S2P8TqDYuRjDyqAhg+Bbp4La35z7Gfu43+5sKwfNBhm3HG8RIcBcylyRrlpYPRF+qoT7
 Kzsu2pQZNOoatK6nn1w9n0hsGv1JaGnjHq1cu0v+65TlVXhx74AJSn8NtQqOR9PdYV9O
 7VPm+5S0MRacQhPWHFmEBV+rq72w6ddKbAVXuo0LcPsup8aX4Nsq1ync+M8+kAnCyZY1
 9c3xMcWJHu7FtHhTOz290QkvUszuRVtxZyeQk6FYEgDqteSI5m84dPFJt/zxgjWFK7kN
 nvfhEpPMz4Ra0py8IIawPgL1SdnoPEEbZq/DsngNNxraLL+gDgDa2H+M8wxhL/biWOxH kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1gcv56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 19:33:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7IqdQK037847;
	Thu, 7 Dec 2023 19:33:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utandxwne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 19:33:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EffPJgxLDHjQ7CI9Bj0yHip/jMd7IuKVboFIxASHiTQlerOvALZjQ8UWiJXk4rXyHWQnR97VyclWmB/ZkcBwo+El1dCemtJ+OkCELUsPOx8AniVegyLX7hSLMImJLr1T7lZE1Qr+JldDIiXYzIweWTnG3NjGsP28/bTOsfSg+3TfuD9GsmBJBdE7dPTTfZyUFYsts1I4sRG9pZLw5mojaSxPfRNRBFD9XiPVg8GG7xmTEqqcZzi8FJazgYXeD8/RRd/GG49XPZIFJgracHXy7/REUHr7AqwvPpCAVCkn6xt+2cI/pjNjz8RZQBItaL7fVnCoEDqJtwLHIY3QCcD9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/yPB+ZuNveL3sslVVsAPHGJMVwWyWgfjUVsx1MBY5s=;
 b=C/yK8NqnCSbIetKzXaXUahbA/bCATcGa1YEeM3M1SoMiq+RxobrsEzOrPOPtIV1M1K+9gEGbRhSWYfV/peLU93QK9i/JklVL0fen3F9lRqq3GK5kn/EijtHNPOkLy6PUxK+Xa33uvud4/l0tnNmyT75YbMyGSKn4DTGdzQR2gNg845QO/A2S5gZSft/yFsl5tcMp856NpvH3ln48Uj6PrFWLv0bJ3rEgzVV+VjWO7RePnX8noCbAIZwXfRJs31SgHRu7XE9295qclMnaI6Mf8eIg7azrg+w034FZYd6vTHtwLUmI4+vJtaWHCa7rex4gj36HUsMfb350V3nr2mY4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/yPB+ZuNveL3sslVVsAPHGJMVwWyWgfjUVsx1MBY5s=;
 b=wfZ6+z7x2eS9h3iTJobBhikhOrdcNpeOTRqbBXfwdEOfmX8a9INm92eGgwa7nZkUXuyWIUpS5akgCCUtU4JXBB/q+TvrMPW8MtT+EathUOfMz4zPydHFirNbQ5E31O2/y3zr771+9Um9UKGkN3Mx11fNpXBRFEeSgaOBiOPAeuY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB6697.namprd10.prod.outlook.com (2603:10b6:208:443::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:33:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 19:33:23 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Eric Biederman <ebiederm@xmission.com>, linux-next@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] maple_tree: Fix mas_prev() state separation code
Date: Thu,  7 Dec 2023 14:33:19 -0500
Message-Id: <20231207193319.4025462-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207014104.n6vul2ylgqjnsfia@revolve>
References: <20231207014104.n6vul2ylgqjnsfia@revolve>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0266.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 854afb06-58c7-437d-4031-08dbf75b604b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Fm5VboOZDDhN5VGxcwC6TJ7F1ejNlZ80UTNh305+rGnrYA1EpvNBiFshOq/hlDp8dFKjPgQam9Dd4MqWOPIy9W9mbV93zepDw0vrGb45UeM590HSqYw3h9ucH1HqPaBqk7V2Evz3g6amw+bbClGn3P4KM8fA6+/R/tB9BzoaV6XLH8McZqSjqhrqCNF/tct4Xi4WfCxrPgQcVJMRq/ZnHc6hffX8PV+VVXC3xBA1XfFAW/PLBAgEwnE03RO8QK8FktJdD4FhIvXM7VZ6YlruGW8BxJUAvbUyMjf/ha/FJBXVkmvLjly/+cWLvx32Eg+l1Z/e663756bzP7Ro7kcZ8t8uNmpPm7NyFzX0fhDWAa3256YlvBmkyVM2trNyUkACw6qiPM8lF5t8gPdsDoBq+9VmfBvBUY1smAnunpStMm2l0vSrXH9omaLNB+aBVAGzHcdpAgoytDZqcq27c5VT8LSbq9HApswD1fgjFgZKVeKUoOufgJzSnwXv/+sw0tEa8nJheJCQLYJBKssEbeB2ty99103mJVdUmjZauHLLzaSkFj9iEksQmSDszZ/4rCKa
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(6506007)(478600001)(38100700002)(6512007)(26005)(107886003)(1076003)(83380400001)(2616005)(5660300002)(8936002)(2906002)(7416002)(8676002)(86362001)(41300700001)(4326008)(36756003)(66946007)(66476007)(54906003)(110136005)(66556008)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?idHjZXX+j7RlXoWIiePrzDO100TTmkSgjN1ZRltPHZ4UWL/uhcBkjyMAg+u/?=
 =?us-ascii?Q?WAc2kKdBcgWaR1zsRF2rDSFNJv26sn3Pe1x4gYr01cwpVdEtBVi7wfgx+aTZ?=
 =?us-ascii?Q?9bNQWfFX/zp+KscegLOC87Oj/FHiqkcnMs9nU+kmeNmrGu1eoamzN8yLuH/x?=
 =?us-ascii?Q?m+pjwsGH9tJbScSprqBzMzWX5RoDnT0OD9Wxso/usBYHrOVU8DKTaIzCsesb?=
 =?us-ascii?Q?C6vHp4BeJ3UTmWkBu3h2ZbAeUlPXcrtv+3AoES94uCdPI+bL5HP8adEb7kSe?=
 =?us-ascii?Q?OrG/2UiFzXLJ6gr61o+OFSAx1JtkS6cLU69r0whSmFHH5F9PQw3ipmXUbFqa?=
 =?us-ascii?Q?PRCj+3lOCT58KMGUdGVnuU2LSihKARqp2/qKaNrcW2gevNbENQbpzdPVXgUl?=
 =?us-ascii?Q?qWYMkgY+FAWaPUb1RMK4VSF3+rzoWhstgxIrum34b4WibrE+UEEqz+m9WHOW?=
 =?us-ascii?Q?hw+YRsK8n5ibVzPiGfbAQGxICyMCNw/A2oPKz7gJpDhjL/24F2kgqw4xx7u8?=
 =?us-ascii?Q?MGlmz3C8DgH6WZi5vKnSg7vuRA2uyACMj2EbAhM8hxaKjuI710GJ3Na8HYcR?=
 =?us-ascii?Q?9LW9gJQR7JrCoXUw4c3Q5weuGEKuiKcOW2lazt0Cv55zZuEgr6qk7Ye3bwWf?=
 =?us-ascii?Q?rGckxu3lqH9AkxW64vi9PlbSEMmQl6bkfga3RZbcrdwc++k9YjJ9P30kVjOR?=
 =?us-ascii?Q?WZHmKrZ2RX791WH5pY5eI52Zig3LNQyCKt9shRh9ky98PmfHASKY/yilmK9l?=
 =?us-ascii?Q?GMGoztksS8ZD4DOJmWdpGcVLaE0N+ObgELyvghaR1XIosYt2YY+b/hKGvN/c?=
 =?us-ascii?Q?qa6CinP8sodYGCQSGG3QB2TMx6pE8iEFNmn1OzJ0L0CxgAkaJ9nwDFUdSxEV?=
 =?us-ascii?Q?DPNRsmFVNLfJe8kwTaM+H8hRmnWqq+t4Oadm1CgQoa+nmYMCJBcBiwSrP6mW?=
 =?us-ascii?Q?mqVl1bNqXf6IWTX7AjiHTuGQMWUdoWrGdajHpt60YbFA4K3SUjT/uWz5vY+n?=
 =?us-ascii?Q?yPdSGwHgaNmFIKEbgZIrxiPGS63Ckg3JBvNsr7FDucYSwcPWScmo0x2DL0hH?=
 =?us-ascii?Q?ZjchzY4zkLIn/tVpu2k6rlcvjBzsAuHETTji6p+6sNoSm8T4Rjwi6az7KER5?=
 =?us-ascii?Q?tywahNdhmvEmaGpsQDY/whTXLcxIVph13WY/QXK3s0hx2/oQVFA/eAjUVyYL?=
 =?us-ascii?Q?BZtISummoHXmcRORn/AQazjnDIoI2YYb98SVnGd1Y/fIxteqFUGorCHIksaA?=
 =?us-ascii?Q?byd4jYwrnR7E/SK3TikQs6x5f0R55AQahjo+4bUrC6sILyYGfv2i7dWZWsjM?=
 =?us-ascii?Q?SFxeUHMlpRTBzXweZHCHdATYB7i+gdUBDG10bna2vjL7bhSMxTRVCrpd1Y7s?=
 =?us-ascii?Q?rS4Q8Bn54BE53R82EqqplohXjmkDdLuVQmWI3a4rgoegkRVjhF7UGUu4uMm2?=
 =?us-ascii?Q?9KiAZmTXjGB3wzR+/i/tgwhcC/pTAkmEqbKzbfN4lVTU5cz/CfgB75aI74qk?=
 =?us-ascii?Q?OS6dMYy6Mjw+CsYUC6FIEonCdb8w/Nj3aPY1xsPsyJHhnHdcpT11llGbhA6o?=
 =?us-ascii?Q?HCvt9G114+Lcf+0+ROqfOKmoVTwsEb15Wx7kg4IR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?4e9Ti/TB7Locg028zkRmaWn2YfAOvmxMA32duxxdlb64X60e3zR6TKg6c73i?=
 =?us-ascii?Q?N7oo6oTZTQ86IokGxxX2bhL7bUSHH9RsqH2l5U2Wm5qf0wJ4GqY7OV83alYc?=
 =?us-ascii?Q?aaKyhfhI75KofmWDgIVrBNahlhfqvFSxSTDgPe/DTH3gJ8n+/HjYMpA2WxfS?=
 =?us-ascii?Q?S4CzIAbgD5F9+gzFk8OmvED6F+2gFG4ADX0xYYRd9qRZtOVwz4qmztuzMqaM?=
 =?us-ascii?Q?ToY/qGkJ1pOKwKu4KvPiXfbXNLKAgPCfVkJF1O1QqXtvI2+aZsQPddTBwbRd?=
 =?us-ascii?Q?wJJU00lpjmet77eyArRzqU2mSaICA8nMG5NTP/7+xqETI6E86VZNGKkJXdEc?=
 =?us-ascii?Q?cJIwrUoVRFsA0S2XCo4uQ4DyRyCEMQ4DfIahs4YWpKIwKcSz74P4aZkUAtY8?=
 =?us-ascii?Q?47ns3xVK24ncBIDfrHmcpzL+Qo7miHwMCnECwCKuVJ2+SLnMfWKzctQXYIUw?=
 =?us-ascii?Q?HLhsE3B5FpcqcMhQQArUKJQtEFYPf8pCz9Y3Xw57fmnbmbc4ZpT1swN+X9VY?=
 =?us-ascii?Q?BHJji9LNu+BhZ2/Oj9xqZsPKCH2Ke6K7s0mJ6e+I3uB3hIH7DjiSAHQ6L5TA?=
 =?us-ascii?Q?WH8IsC9yj6EYrx15MfHnG3qEChwCSBqglBNzmRseUKwBBzq3p4P38tVjDb8b?=
 =?us-ascii?Q?aPQo8DOap/kc8RTpVmyei3FN00o+tOFZGaJvc4h6YSCpHLc06OE3tfUSiKEj?=
 =?us-ascii?Q?Xgr0TGgwb+RzTrNHMeL/MjCadBn3eo2CU1FrIlqgcfmepiWM3YDW+8qMwUTp?=
 =?us-ascii?Q?7CwbS1H/GRzEA69ID4/EBQjbAmuX7Y2lb6U7mK01r4mlTYuvwahTMKREGhqM?=
 =?us-ascii?Q?YAvdU6oxONCIdyHUvyN43wyPB/6v2wZBhzwUlPKUVTd7QnAWef9Z3kgKlhMu?=
 =?us-ascii?Q?VXgTUCp6Oi7+YdQneJoRpvG3ugqDFgW1CvRfyQo+OZ58CwEzyNC5+izy6wwd?=
 =?us-ascii?Q?ypUnEHO12mIWI1D5j8FARnmbG1AlPJuE5DD09V3mVRz5yTeFv5C2ESYl+iv8?=
 =?us-ascii?Q?AagL6oln8EMzKHim98KXg2hqNBMsZ+udBuCrUekmXPR2dHVJbClVNKayd+fq?=
 =?us-ascii?Q?XGQj6SXArFgHLiqBzGtwp21HiqcmeuaOFGKvi121X0rcpPTYs7wxYRI7F8iV?=
 =?us-ascii?Q?vPgLYStRrSjb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854afb06-58c7-437d-4031-08dbf75b604b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:33:23.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpT93aYK7hfs+DO3ZmoB6x73va7eMerCDX1uK3bMJmXEx5XSLXXSxs2nSInJIyajpUh2wmYfFvY5Z5hdVin90w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070164
X-Proofpoint-ORIG-GUID: 8vT8cIXKKXFAi1jeMNw99CR09tZL2c6O
X-Proofpoint-GUID: 8vT8cIXKKXFAi1jeMNw99CR09tZL2c6O

mas_prev() was setting the ma_underflow condition when the limit was
reached and not when the limit was attempting to go lower.  This
resulted in the incorrect behaviour on subsequent actions.

This commit fixes the status setting to only set ma_underflow when the
lower limit is attempted to be decremented, and modifies the testing to
ensure that's the case.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---

Andrew,

This should be clean to squash into 7f79fdb1d94d7 ("maple_tree: separate
ma_state node from status.") which is currently in your mm-unstable
branch.

Thanks,
Liam


 lib/maple_tree.c      | 16 ++++++++++++----
 lib/test_maple_tree.c |  9 +++++++--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 89f8d21602774..47f2a7a973852 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4432,6 +4432,9 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 		mas->last = mas->index - 1;
 		mas->index = mas_safe_min(mas, pivots, mas->offset);
 	} else  {
+		if (mas->index <= min)
+			goto underflow;
+
 		if (mas_prev_node(mas, min)) {
 			mas_rewalk(mas, save_point);
 			goto retry;
@@ -4452,15 +4455,15 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
-	if (mas->index <= min)
-		mas->status = ma_underflow;
 
 	if (likely(entry))
 		return entry;
 
 	if (!empty) {
-		if (mas_is_underflow(mas))
+		if (mas->index <= min) {
+			mas->status = ma_underflow;
 			return NULL;
+		}
 
 		goto again;
 	}
@@ -4596,7 +4599,7 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 			goto retry;
 
-		if (pivot >= max) {
+		if (pivot >= max) { /* Was at the limit, next will extend beyond */
 			mas->status = ma_overflow;
 			return NULL;
 		}
@@ -4611,6 +4614,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 		else
 			mas->last = mas->max;
 	} else  {
+		if (mas->last >= max) {
+			mas->status = ma_overflow;
+			return NULL;
+		}
+
 		if (mas_next_node(mas, node, max)) {
 			mas_rewalk(mas, save_point);
 			goto retry;
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 15fbeb788f3ac..29185ac5c727f 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3294,8 +3294,8 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* next:active ->active */
-	entry = mas_next(&mas, ULONG_MAX);
+	/* next:active ->active (spanning limit) */
+	entry = mas_next(&mas, 0x2100);
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
@@ -3360,6 +3360,11 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_is_active(&mas)); /* spanning limit */
+	entry = mas_prev(&mas, 0x1200); /* underflow */
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* prev:underflow -> underflow (lower limit) spanning end range */
-- 
2.40.1


