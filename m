Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B457B3D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 11:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiGTJ3t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiGTJ3s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 05:29:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72955465D;
        Wed, 20 Jul 2022 02:29:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K6f8Ti031777;
        Wed, 20 Jul 2022 09:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=oK1oHKWTe+ZVhSt1gQCnST549v6XO4qsHJB62fdEhl4=;
 b=QBzLv0LkmgR1tKRtnnHBiGo60NNKyR9iRPamURknYzMm3tMGsv02qoKMzaFw0WAF4K+9
 84QFDn68qLHWU5PvoSzxsbvadEhcb26BkzEe8Ff0sKLCzlB5UekDurv6W7wOTf0J1zzd
 eNOYhNwhPZzKEJ2KK7p5kzrRaPFuyHJmtbPcXZUWH7nSyG4Jm6n0KcHQusqnjKslXzpv
 IHwarWwnot575eQmToQjOatVOl1XP7fbk7HpP4v8LpGd3qetHS2//z/00YLwr7FGdftU
 69YTiTBoohY5r3B/A0bpGuoMLHK1vvpRvRB9YKMUIM0ci1M3JSqy6DmTDjlr/Q/UhGrD SQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtgye6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 09:29:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K6SI0Z016449;
        Wed, 20 Jul 2022 09:29:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1enak2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 09:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5ag18/dJn//V9W4z3FXZd7xJC3ypu/9dR6JDbBF3G7nUMulILBzvV+x6Tyeeji2m1q+2jpMzEU+hQf+42aTeoSlW2noPuGzZfQJKkBt+yZ1YterfLxI6EkwWRmQArOCHJb8kshZn2Qk3Op/SL/uSjaMOuCkYOTUBn1LeVe/t3BiLeoE0Ko79P2S/Xrt/X2xgrdMI0jR6p1SM/ZPNZGIcDuSYnbObo5i6lNB5AGu1dGwhtWf2NYiqp6BXJ7PAAuugeQjdwVYu5BwjcNBZnFPVFgDxbTdhdlnAow4Ff9zpesC+L+A9vegp3hzUPzvlStiYRaPn4Mzi/gKus3ux6xjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK1oHKWTe+ZVhSt1gQCnST549v6XO4qsHJB62fdEhl4=;
 b=X59JgyDuUUjP+Kfi5gcsY4ek8QAYc7QUysMbBjcn5BbLc49q+VO8f9YRcMHO4DNjnKcK5YAnKhSIWshRV77XLb3aHC/E4EDO2PiZBXOVhP5jYdPK2UHeZ1SssPy3Rn9YJRZ0HnVKsKcS4UtQg5GX/1RNApJ6/DtsJ3DXQhx5Vnk6gtGI6vqPJIN25aSeuE0B33gy3038mpBYU6sdc0yMiqRRbPFtAekPPdVWj37DrJwETGkaeRZuL+SIvH5q8Mz3XRcVweTLqwX+W61prqIpjryRRqYshw8Ow0f6MKOywlzT0o5ZQnMiOBuCGvVx1MZukMjql1Hs2HOdiozydbKFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK1oHKWTe+ZVhSt1gQCnST549v6XO4qsHJB62fdEhl4=;
 b=MXx0H8GQN/g7O5Y1EK273Z+POYafO7eobASxK6A85OC+S+8It0fEquoVrMpHhDmfi4IUjhy+H1nx7gxyk2skIIe3fwnbn5HGUu9zkI7EdCvrR1OkgcjJRWaE8zsDgwpJyOJZ0p6nJWV/uGvcrKCwoFNJI2Ngf/3pgTxZLc5l8ws=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4298.namprd10.prod.outlook.com
 (2603:10b6:5:21f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 09:29:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 09:29:32 +0000
Date:   Wed, 20 Jul 2022 12:29:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] selftests: memcg: uninitialized variable in
 test_memcg_reclaim()
Message-ID: <20220720092918.GD2316@kadam>
References: <YtZ9Yu6HSQ2sT+O/@kili>
 <CAJD7tkYCSY1C_iif4dxF9O3dAgZV4u8o9DFGsqeTyaq_FTT+mQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYCSY1C_iif4dxF9O3dAgZV4u8o9DFGsqeTyaq_FTT+mQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0056.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0cc39ca-8e15-4577-fee8-08da6a325a4e
X-MS-TrafficTypeDiagnostic: DM6PR10MB4298:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/VYiIyGo1n01MNZ3awb5+WsCb4runUH22QZWGtVFed4jsVBROI3FeNy82PYCPZNnpazBFk8Fqm/Gw05tiPOTS51NO+Va/kPcMV2hNoiZ6qiJChq1T0HpV0GiyZEdWTpIxPytNSpwPyg7O93CzQHQlnzrewjUtxqi7EoK3/QedH0mUOm7TZ+WNdzMJ3aDo5AzfRYc9ts95avycmrG+rMUn7C132J2IiypmCbEmRta0U7SAEtWNOuuUPs06oYsgXabk96eoI+2aJps/EUSI3pboUCnCjyAfrEgoa8uuDXpK1//AyXkIZmCt9oTqImZH9TN9HU+C7swN42eLQKh4D66n0wvZouR7GVaGlNXmSq8k4V/zkT5/uxLRJggGJOT1qnwyc9EcE7dQ/1XPcgPQqXAL3ziJjvfxY/uu31DLEd3JlDTk/dTXFvElVlSujEjt+u/BN+vqey9bm4eoXDJlJkeRWauDhVcz3c/cgDJNiwL2VauMl5vmVs0xrpzyn5vbr+r2mm7EQfK4tVYueWKRspWQz6A4vZehawjIpGiccuBQ5B432WCZgF432xhxN1CTpd1fjXi5lbPJFHpze9GlMrG363WX1khRAkgZsDeveE+AGxQFnOd3MhmM23sLl9iE6e/Tbwlk2pxTLDRjwwn9Z4sqXJYEoeDHM8LhEU9awSSOCajXPBSn+PiLQnYUHY5wLNUGnihaagYhb/sgXHhQivjJiOpMuRzeji073d61OdzXSEhzOi5gk8QC+HF/0igx0AyecsYwrW1VhoRk///rNNxYby5I6NhIubh/xlMIwrCkPddIuKHajJhPUHC8kQC6Bf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(376002)(366004)(136003)(396003)(2906002)(6486002)(6666004)(38100700002)(38350700002)(6506007)(33716001)(33656002)(66946007)(66476007)(66556008)(52116002)(8676002)(4326008)(9686003)(6512007)(86362001)(26005)(1076003)(5660300002)(8936002)(186003)(44832011)(316002)(4744005)(41300700001)(54906003)(478600001)(7416002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hWsW3yxsD7vYJizdnGO4oseMpNHHqhamKxKfVSXWBRy1Tt+TLpHbv4iq6Rp1?=
 =?us-ascii?Q?CPC/WZGaHHk+t/oUEHJHLEjoBn3CyqDybCEYlcI9eTOzXdHsd4GdLaalqEX+?=
 =?us-ascii?Q?ZEOo9oS4UciuJ9HZ2FP8MhtcQNyMoMu9IX1gzJs63M+Zws5QKvRkVYheGAlH?=
 =?us-ascii?Q?mx4RNnIC38v/SzdhMKcNAFF/X3sV8dMgOkLI5WaI3s7KOUvovooX/1QNYwPF?=
 =?us-ascii?Q?k89GqzXsi4QISDn0xhej9LvSVRnwOhIm4/Hm0/TlX3IdC7LyYHF4f0eb2VBZ?=
 =?us-ascii?Q?+WFyR9YrfUe5cg3FfFrsgVJZquBvEaBkt0lfvBpMH1Lhgt2vGrumb1A19EGQ?=
 =?us-ascii?Q?9OADkPaE3nhe2/9ERKFhHqcwZ3SP2AZESYhcUKxF0W+uSiI/4GmtDQ0WrcUb?=
 =?us-ascii?Q?Efyap++b4cmX7OjlZ6RvSbAu1EIPT4vrWCnVCtQpGlIv08yra/P4yE0mOzuP?=
 =?us-ascii?Q?2TXTZdRRazBXRwoxvTviGseZCAWmIyCWHfMhaKWgpncILTnb+wgxDLYMoZRk?=
 =?us-ascii?Q?mnnvQ/4iHAnFRSf3vrdupgE3SUHKKgAAe9DaNRxiWE490Af88tqb+OFhBujH?=
 =?us-ascii?Q?MtjrDeRjw7LJAudYq02gdspOqiwQVIPoGBT7y5B7bUJAJ8I5Ajc7PraYDDLa?=
 =?us-ascii?Q?xB/xxHypLlHKdRgNAQ8VhEh9Y0CWqVBQAQ4vteosP+ZJjOsLYi3V/Bt363Z9?=
 =?us-ascii?Q?WqOZVwvNEFwtZFU5uPaTE5ZcZ+RVq0HKKdjadHBc+iG/BwPVTIyOJxceqAHZ?=
 =?us-ascii?Q?e+XvgIy6Cc0GaYeBVE300rzG0Gb6bFan5EZ2IVkEZwxQVsEk00cDHGujOYNn?=
 =?us-ascii?Q?9me8ko9PLWJ/JJO7V8C6qcTMl4SJFcELewi298ylAZPJ62GfJfmt6vNy/fVX?=
 =?us-ascii?Q?NeNHHmmWyJqptzy6Mmfp3bfoeutorWcZLWith4FcelZ8kSctcdC37IY6LEn7?=
 =?us-ascii?Q?Ev48oaZR/QjwNgTfRPCaNdRCnPIyZFwkFJOlHVECFpEbF6bvNJvjfjiDFmJL?=
 =?us-ascii?Q?E+RRCm6ffPWQnd6Bf+JODYXh3SRTlyJhyCf+9SfOTy+VI6KrZVGT2YvQyRiM?=
 =?us-ascii?Q?LqhhYtFd75mNsYFVAXuujPfH30bvSPV8BGN84ZYEgTjOK0IsNqKY3obhWsjL?=
 =?us-ascii?Q?215XEvAUlzt9mpUtu2hry6ItYY4UT3OfGOfvsX1UCIuUAkcQNkF+9fBTSNWY?=
 =?us-ascii?Q?etgsDbKOeRBh1L/CV4dTijjjP1fHYctizY61Qvwfrg7dj/6yxsa0SgTsefNx?=
 =?us-ascii?Q?YUO9rWnbqeApjuqwoR7+4AcjZxtbIKCUva/AgN/fYjLRp2rJ0fBdocJf6B/j?=
 =?us-ascii?Q?D8MPkSYPKVi9o3ElYVHPjiK7HyH9+XH8Fi2UJqtEOcfXkz2KYdwPnr+l/w8L?=
 =?us-ascii?Q?YeE3/bChvvcYQXueqB7qJWXuPZ0vzqVNx51q7w8HuIvKNmE8PCUKHWcJh8nn?=
 =?us-ascii?Q?9P/WKm0bvtJ9K7wMab6SVLrCjWYG2w0D58debSQK0ZVuyBGOLf0lRU/IujjD?=
 =?us-ascii?Q?JVh5ZVCoeq0/iGqxzO7DQ2YG/9wRTc8sBJmC1GToEFUvS/M42k9Aod5oM+Dp?=
 =?us-ascii?Q?tU0dg/jgVqrZb9XIrAhLiHQGQgGxmocqGcVNbW0AkUgTMfyOFOiVi8/+GaJw?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cc39ca-8e15-4577-fee8-08da6a325a4e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 09:29:32.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9BgE135GypPmRJY7ZDCGVYVGRLYbVOGLjKpZkBfbE5TlaAPN3C8Ie4EHwKeDJJQzuDlx1Lvb+LLdy8cJnw94KS+rj334jAAqIj15dNMrPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=667
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200039
X-Proofpoint-GUID: ka_5VC5_HPPN3MVLdaOkAFMeODbQANGv
X-Proofpoint-ORIG-GUID: ka_5VC5_HPPN3MVLdaOkAFMeODbQANGv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 10:27:36AM -0700, Yosry Ahmed wrote:
> 
> Nit: keep the cleanup_* naming for labels to make it obvious and to be
> consistent with the rest of the file (e.g. cleanup_free,
> cleanup_memcg, cleanup_file/cleanup_all). See
> test_memcg_subtree_control().
> 
> I would honestly have one label to cleanup the memcg. Calling
> cg_destroy() on a non-existent memcg should be fine. rmdir() will just
> fail silently. All other tests do this and it's easier to read when we
> have fewer return paths. My advice would be cleanup_file and
> cleanup_memcg labels.

One error label handling is very bug prone.  You always end up freeing
things which have not been initialized/allocated.  Or dereferencing
pointers which are NULL.  Or, since most kernel functions clean up
after themselves, you end up double freeing things.

regards,
dan carpenter
