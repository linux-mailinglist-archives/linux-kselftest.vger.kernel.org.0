Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A76BBDF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 21:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCOU0L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjCOU0J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 16:26:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EB049E8;
        Wed, 15 Mar 2023 13:26:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FKERPU018201;
        Wed, 15 Mar 2023 20:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=h+9w5tHZTyDBaR8+1R6/ERMRV4DRR0Nntcr8pzs4h5E=;
 b=PQKkrw498QUqoj07tq5wYCR5Ssmac90I55ArMC9yuuZB3gs1Ufj9I3X+tS9pviOIhmm4
 KJblLBZpXdUrcIpcnR1Z3g3UXwUwOfSeARkWpE9hiN0ukVtVN8i3biPsOpOGHe4ND7A3
 iJWmNxWYGxTHfevllLU8NyLeSyGZLHM5MVfeVBb+J08Fn9inKUBqXeC4odU4VtgsH9dq
 UXgTaNrsQ4fcfIFBm3oxdtw16zZULTpMg6kLNZVY9wPg4G8Dm2cGmQwA9l9SEBznGoRD
 fkf2UwfUIrIgnRdcnWRq49jAGq4J6RJpjREFzk0z764kS1EehtgAbSBTDsJyXuLTr/As hQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbmvq00fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 20:23:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32FKKvOw017424;
        Wed, 15 Mar 2023 20:23:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbmyqr22c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 20:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvkLBIP/VNqR/dHRCc2YB/bxgzN2xBWmRpDAYk5JGdRMFOGWoC3m5+x/AvxXE7ElIzzRoycbOFXImc6ohrE22yOtd38bKhUvmkH5e43L4yGvYbOurlSp1fB7Dgul5IO0/RF4X9uuM7sqDTl5isygsKqw9QYr8jE0+P/OURbivQ0ubLqMvQhx3fbWXgIKIfM0qhMgIx2+9/heSY0i5oR/AlqCB2GJr53TezNKO3GxENpXkXDxOiH9wp8AaVyJCB69CE/oW+41VjzcxXXVVin010I/+0OW0Bn6MIYwB+sYP5/QOUXVEduSVN4w5/xwkabV4EbHjSrL3n7pccCFTtrwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+9w5tHZTyDBaR8+1R6/ERMRV4DRR0Nntcr8pzs4h5E=;
 b=cTNNOFTLTM/n9BV0cnHwhGuAJrGIAfi6V5+Ig1MhsZNJ1zueDIlJY8yjxDODa8qKYZF22R7TObCQLr99nNJyM/V1k3gZ2PnDyX4nvU5JjC8HYXcOkd09oSEYiw7F598+m82F7MLG7pZRUa+HO+LwfA4PMl4mfaS+hT/m48j1pCUJ4zvP6wOEc1fKPnw0bANHIMN3y2Kp/TYMtfNNcMZC01ai7S4SQNRHfl0tdx0kO2Mr563y5pKDXdUoD9EWD5fSJCrgc5xdl0sDPfwsNGoU/zRjdLI6eEXZenHe1YpzFiPOIPT366plK/pmmFgf0+E7pKnki+FriW9vUaAoaAOVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+9w5tHZTyDBaR8+1R6/ERMRV4DRR0Nntcr8pzs4h5E=;
 b=FgtiOKNBPZLLQ7DWdjM5O1nH18ThYo6Z6sf1zb8AccFECYOIK65Jb5x2AFgk/SntrUCbd4Q2IVtf3+sx6UrXhr/vp/2hdri0R0e5Vy9FJvsieHMsXcg/gJLBfxlMeWFNL45I3YVSzoWYWIUb2smcH8P+D53ZJEo6qddUeiP3jeI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6087.namprd10.prod.outlook.com (2603:10b6:8:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 20:23:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 20:23:06 +0000
Date:   Wed, 15 Mar 2023 13:23:03 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Message-ID: <20230315202303.GB3092@monkey>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <273a2f82-928f-5ad1-0988-1a886d169e83@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273a2f82-928f-5ad1-0988-1a886d169e83@redhat.com>
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 095dbd7a-531d-4156-7488-08db259315f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97OZ1fOky6jFX6UwZ2/wU9eKF+DHwr8X6AD+QxtSu/79/28LgKR4A0RzCxPdCruVKemNrI6KsvIPy989HtQE+XjHihJZ49FCMgvWC64vlI3HNhxblnoSGV+mnxTmUv9tqKu6PoyVSUld0cygdM5NLBS1RS/PaACXE8V0hLpwY+VGkAIhjokRTo7GihUufgKOI6dZmB/bx746chGs+M0R30JWeVYbnthgjXABafxn2T6UDh8M7eNqSqt0M6oBzHnZy/IE2O4TLICDVGFfvuFGAglFINulh2EB2Vqa61InzylhQPtwgatybpbMck2nE0xAX99w8Wz4DYmtix0y2/Mf4Po0ANYfEHerQBxafHhPXIwXpJsrQlHCawapofvI28U7B+NzogYCBWGO8ss5U2uo+wdM5UhDlS8k2gTaJ6JoeMtHC7Idx125V//tBzMXsBYqUVl9ZKmwLvJ///Qrp6YxQwEhdv4b5taYv2lKq1t5GwbljkZ18prJPTWW0+c+YAnXntOpQjzqOnHmlebk20div5kPghuXMcHIGf6BPfThcmeKc6HhEegJMWXUdCfy1n3tg45PjaLoywfJUlLO5QLfkdj/hzdotu50370+2+ZkGKltH/IgPkEDHoDJcLms4NCxX5S1mgRzf/T3bR0da4WiJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199018)(44832011)(5660300002)(7416002)(83380400001)(478600001)(1076003)(53546011)(33716001)(66556008)(6666004)(26005)(6506007)(6486002)(6512007)(4326008)(38100700002)(8936002)(33656002)(8676002)(66946007)(66476007)(9686003)(6916009)(86362001)(316002)(186003)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVEmkh1C2h8FSJ+8vRRxaSbNJRIpRNhEw9KEa3WjWlB8m4mC9PuBBIi8zXlq?=
 =?us-ascii?Q?tRgZ8Ln825uJUIbsnJqAuMuJXgu+Ue1XBz5tGPtHYnI6+VVCxxAMf7YxyUUp?=
 =?us-ascii?Q?6atRk7ltItWYaAv/ar+57ImnTDD7uekyxGOkTHxY8z8McVci4tVE/3BW8tuo?=
 =?us-ascii?Q?t3fHzaq8WY6eoBkZf2TBv/YvqK88WtXTuOGJgo8Iws+bFeZAzzx2XDNxWHEI?=
 =?us-ascii?Q?PpW+eZCljx6mAEtUUDzufdkG4mO1scHj7ThostN259hbWJBYgfng6jU0+r1b?=
 =?us-ascii?Q?Qwoky/qTkVZz6AXhsjVZm5canPMdp9i9m3P2BWzNS9cUzuqgfyDimsfAP4jm?=
 =?us-ascii?Q?0lCkuCsi+1lJNgJr8YZauQk8SqemQmx0Ekl2A7yIEIcki6Y+7GkAunc73dqr?=
 =?us-ascii?Q?REtqRidXVRRR2UYTPFR7YJAO3gPCX9WEfiF/gTGRuF7JJHoIQl2k86pZQ8yx?=
 =?us-ascii?Q?kxGEipnR2YiAFWai1RPluUhiKBI1FA8WxPkoQL1O/7jpvwhYU0O+oR5uZ0cz?=
 =?us-ascii?Q?cYN/ZPKekfUieS2OObrc60+udIznZPOXJNXdNFsGKaf4lNWsbPGMxoYElDgU?=
 =?us-ascii?Q?guMsc1yCu/VRXEqa55w8qyRzYAodemC4UWo5LqA20AI8S87bfbrNXB3U51pa?=
 =?us-ascii?Q?haF6wcV8ox6XnFUptTVsw7umDmuGNt8b/XeORn9/aLfTfTW7BvXqMvjM+I9X?=
 =?us-ascii?Q?QizVgdiAhksmTsCS7BVukcxM5j/3K302YfdvGyuzuZKnNOmdBLLmiB2j2EaR?=
 =?us-ascii?Q?iT4X1I4n0WvBQINRCYxfYI5HfI4/YkdWGVOSCxzdDzPyfLkXt5lSdr6xo9u2?=
 =?us-ascii?Q?aT3NjeoFN4922wg7M9E4NywJiMHsaFerbc9NiG6M8JgutRS/X8d4pjqQwYmY?=
 =?us-ascii?Q?vwHhBZY/PN+fKoNOb6Nuasuef/FOqQQdxUyVgCrAiKsjxWNdYvB8bEdt5p9g?=
 =?us-ascii?Q?SXteqO6fkxHnRz/lBBSYUsm+zAWsus6MR6uV0bDP3szTCgFi1anljh+aoOmJ?=
 =?us-ascii?Q?xkMlGgtSObwrY6mDPvTj3Dp+d+LZGOg1rA+yHE9yK8RV/FblLCY7BcUEcgHK?=
 =?us-ascii?Q?PL9tY48u+7rwpZf5VPyZubT6BKknNUhPVD6427fRTTTCiM/lgdUhsBSvUftR?=
 =?us-ascii?Q?OpnVQg4ucL2bc3cps74jYwdlpMwj4IFxb6WZs8uM+pXSs/+RaVPwkERU174e?=
 =?us-ascii?Q?i/LwVGJ3muq6e1XLwySKKxcKy5wtSrFkzwTym3mEsi1coPZ2sdGJ+qIMluuf?=
 =?us-ascii?Q?7jGNTYz8rnOb7471Q6J5fKGeJKe2VkdsQPhG6jIQg0v2ntKA/j256OeSy7Ue?=
 =?us-ascii?Q?ccr9CCPa25/dEGFzIKiH4hFvpZLykQYaoKd/6QqzU8JsTdzo1xndK4d0LY3/?=
 =?us-ascii?Q?TaQ9Xkq9LKJbsieGKVe1h0pPyIywKbj96u9uiJWO0NiOhfpZLG1V7aUTJ7sU?=
 =?us-ascii?Q?D7aUHUJr6j9exrfM4b+KvphqHLhqYZ44haHEPYGWNKPxq2YXhvYhBC7U3+d1?=
 =?us-ascii?Q?Bpf+gsj1S7+jTiE2Bt7qFpx0joeNW6fIO5DOJbvnQp0WdEV2hvj8Uucpnok/?=
 =?us-ascii?Q?5zuli283wXmRPtRJTyqjo4Tbk0chjV9t2jqJ7h+rm2ZBNMOOnEi6GjY4kkDQ?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?e2hVkjX4Yoo/4kParCdNiu7gbT6tYDR0mRDlLrjs2/eKYPLOYMage113CXyC?=
 =?us-ascii?Q?TQfSbXdCTB0JuRwv1u4LVaz6ZBjwu61q+4/76phIrAPzM59C2l9lBj/hxeX3?=
 =?us-ascii?Q?3juwxGcOCz7PRRXA6ZMJXiIpQDJBk7WWWR6bR4utWbwaNc0bnunznpXIiYU0?=
 =?us-ascii?Q?xL+NRw2gfOCuqKdCvDL6+AAdsbzlnnu0SDXIsSUPmryuknbibWGLSc/S7BuG?=
 =?us-ascii?Q?QyTmfMy/MnUF/K4du3x7AzYM9MKv+otgh+MON3FVHXRnvvKd9RCWLlYgrm8z?=
 =?us-ascii?Q?UK96zebp4H0ZoHyw7j3MGESi1C4KvE5EYqlP41xBw1MqJE2M5vsNzz+6aIrB?=
 =?us-ascii?Q?3QzvIawR5Bp1IVJU/mu5evvE4ONGnnNn4Rwq497miuD+iFluBOyyX6xvccy8?=
 =?us-ascii?Q?qAO98B3VzjpEkNREfygyYM/tDdRGLKE03coy4uP6Thc3r5JdXIxn4du1urpX?=
 =?us-ascii?Q?qhr6a9hvt8Ytcv/HGwB7HKNtA92RRdzIbSw1PAudKVWaPnJUEeKvCm58IqZJ?=
 =?us-ascii?Q?waXDklYOn229e9ALumNtSgFBXPwu6tJBVQ9Hdnq0bLd9iE+VgfXhFqICWlmb?=
 =?us-ascii?Q?OqlunheVX9qoEjxwoqmj8ub01pVtBwY33oJy4Rk0Wb/kvX15haNLGP4HZA2S?=
 =?us-ascii?Q?xprbJk3fISTYrJ6famx5vCUEdbUPf9AMQ9T0C2Bssncy0DqjjFkPwU5JF71Z?=
 =?us-ascii?Q?7N3+V2dznfMt81wARK89Z2EQ+4uUUk5MRgFIZ/XHTvn+IV/7XWX/rA7eCpZb?=
 =?us-ascii?Q?Go1d3EVmXnAf1tLd7VF/Pcs3685iEeY6Sslhs/75iSRR8Xf1NEFxQZKPKLem?=
 =?us-ascii?Q?2eCjnUk2ZW39gKJVP5fmpyiGZyfkjUzMy1vupAVW66Zv6zCr+r7HT2JmHFw2?=
 =?us-ascii?Q?AOTdCFcEqw6uY1iG7SeYDzRDSKxFvNHuh5I9PfC9+WEetYKhyHNzqdaYu2ds?=
 =?us-ascii?Q?pmoOGWjRdpyFdbXhVWtdWt7x8wsnB+T1MWXR1VGDwHZajGMvMhSOhKQZDWct?=
 =?us-ascii?Q?PbK3Hi4A3Xl5CvKnw6WvDQPoig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095dbd7a-531d-4156-7488-08db259315f4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 20:23:06.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyeAJm8EALycg0Kv6TLDHBky0KsVgBlvkNm8mzvBqLMieerDXVM6j3+2epoNL34L8dJOYg0AXNNpi7s/E8N0Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_11,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=741 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150000
 definitions=main-2303150169
X-Proofpoint-GUID: JDE-wsrLgZfHZqyfHRaMh9fb0ddxckw3
X-Proofpoint-ORIG-GUID: JDE-wsrLgZfHZqyfHRaMh9fb0ddxckw3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/15/23 21:03, David Hildenbrand wrote:
> On 10.03.23 19:28, Stefan Roesch wrote:
> 
> Stefan, can you do me a favor and investigate which pages we end up
> deduplicating -- especially if it's mostly only the zeropage and if it's
> still that significant when disabling THP?
> 
> I'm currently investigating with some engineers on playing with enabling KSM
> on some selected processes (enabling it blindly on all VMAs of that process
> via madvise() ).
> 
> One thing we noticed is that such (~50 times) 20MiB processes end up saving
> ~2MiB of memory per process. That made me suspicious, because it's the THP
> size.
> 
> What I think happens is that we have a 2 MiB area (stack?) and only touch a
> single page. We get a whole 2 MiB THP populated. Most of that THP is zeroes.
> 
> KSM somehow ends up splitting that THP and deduplicates all resulting
> zeropages. Thus, we "save" 2 MiB. Actually, it's more like we no longer
> "waste" 2 MiB. I think the processes with KSM have less (none) THP than the
> processes with THP enabled, but I only took a look at a sample of the
> process' smaps so far.
> 
> I recall that there was a proposal to split underutilized THP and free up
> the zeropages (IIRC Rik was involved).
> 
> I also recall that Mike reported memory waste due to THP.

Interesting!

2MB stacks were also involved in our case.  That stack would first get a
write fault allocating a THP.  The write fault would be followed by a
mprotect(PROT_NONE) of the 4K page at the bottom of the stack to create
a guard page.  The mprotect would result in the THP being split resulting
in 510 zero filled pages.  I suppose KSM could dedup those zero pages.
-- 
Mike Kravetz
