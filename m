Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A074740500
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 22:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjF0U3D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 16:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjF0U3C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 16:29:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC0E296B;
        Tue, 27 Jun 2023 13:29:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RJYdqP008631;
        Tue, 27 Jun 2023 20:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=oJqTh2QrtXa10+KGHEqzUe7CAfA+U503MbRp9GCPB28=;
 b=PJDnRheKDIAZ9yWINxLiXtwayUQF+dElJdfpoRpL1m+C5xHtb5bIZsmpg0G1wAmF/duH
 NmwUYKNMuK4LARpAliawicrQFkrSWbX1t6KMcQWWk7MH/LVAA00XCoMBNRobW2f7be48
 xi92DJL70UuF8rXeAl8GZFCnJDWWB1MzMiN6tU2u2q9m57T/SZ+QMOqs1e1BjPLOTq3a
 2U8yrV9KIcOtBpDCee15fD2mHG9ohmaNXEZUP+Er7sQga5BchYSMQBLwHlpqDI9/Ro+o
 Wg+uthH1LVLhV+dkrdprHvKzX38rH8dp8lEM+eT9z5nnexC33Sqg2eBuznOPWODYdMsh tQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e47ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 20:28:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RJjKqu038183;
        Tue, 27 Jun 2023 20:28:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxbjq1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 20:28:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx0RoXaJdxHa5xJ0VO6B33AL8/oZ/dxn0K4heuBLil6FTxgVriR1XHWgZuVwv/ZdFL6qnWa6BQQH7UPOpDfgVBcX9iFIiqdty+RRiEjSd6ZHximiXrU1A4C3clM5bCiyqHts3RL0nZRlldFktrzxaB+t1+h7lJrBoTGcL+WdLIJXFrGXpNIK9P4O8VadZ4hqwg+GRMLXYWiJfXJk1x4yuMPuR7rHvh638gxcIPu8o8pZjY2nyS38mr4Tn9I9qllaKdHv/u5DacX4WWNV3zIo10EnHDvEIUs6REL9tg9Et8vg1Z64DYrTUYNBQ/fqvKwpzIEuWg7KXj0bWWNxAUf5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJqTh2QrtXa10+KGHEqzUe7CAfA+U503MbRp9GCPB28=;
 b=c0YtuTalen96/biSlpN6zEghfegPDR7mFRndcDenW8/6euVF6jHRDQzaEbShE7CS1u7YU/wUUffEGd1fxNJ2uszonVrC+lSkQHk/lsC6y7eP1o70+vqmJXBI/wPO8xs2/EycyQQ+005lQIwQVZ+rgegTOT2XCKk1SMK0QtaQuLkbGI0MP0brlMGo3UbKUePnsp+V4i1lKh+nXdw8k7Kwk9QUen4o7EwGHYy1jishwJCi7P33J8r0dfM85Nkis3ap/zE57IYGobg5c/4mwm/t7JUQl+/fBLp0ZzZp5bKNotB7umgxbFcktEFyyMVbapfjJdDwU5Q2zP2ByOISlw25Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJqTh2QrtXa10+KGHEqzUe7CAfA+U503MbRp9GCPB28=;
 b=NpL7bBLoN9fDawaZmY9PWX2lUPR+i3rpfQlQi9g1TS7P1R21x3NVt7dgToIDnv5fhL2EhTAjwK7TmNzMM+t94EjpRZJ9RgjW+HsaHxhguEHzOLTefcQS1azFSyZ/mpGKtq5tngSeUG+QdtAKVWherw2dFpOGrQezxOw+7wYSRqc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 20:28:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 20:28:33 +0000
Date:   Tue, 27 Jun 2023 16:28:30 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 1/7] mm/mremap: Optimize the start addresses in
 move_page_tables()
Message-ID: <20230627202830.cqbkquapapo6tadr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
 <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
 <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
 <20230627175609.xrn4mle6hpi6exh7@revolver>
 <e6da79b4-e48d-4b09-86b8-96bc66604694@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6da79b4-e48d-4b09-86b8-96bc66604694@lucifer.local>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: ea46690d-39aa-4072-99aa-08db774d13d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzLAub56Tr1k3pLgAc3et6O3iMSUQytlSq/L7xruW3ye61chS6JOgWrkUCtuIdpR5BaW5jYcTV6MCFSmrWwr2SmSYmYXQtB1EEM2XTx4LLfHYaR4+6ardzgfn0W5hbpfM2E3neWwudD5v2TTVUPAG2Z1f8OvubnzVonZSUMOCs0Zqmz9tw2srs7rjpFIe2V1yeLXFtxsaPAu+XEKfXl75M8sEYbDA4DBEnZ5q5MkuELKop4YLwZiku6cBBy3lmnSBoWGywbDlZMJQjnfFnoLGalTfpTmHU6KniLpq4R+6l+YPKfUPEGmhehq6Sy9+0VqfWu/UDoYOaFHQ8MzwZrTef9lA6jMpj4XXaiupa5jYEh+JgD+sLHzaZKm5APpn+vXEhKL9tmrf+EwYGSoIV7/tzk/cFzRTZrmO0FJcNykTQ+kWhYwF+mHC4MKKahwn9KXkfVQ7ygSC0VmSlPZZhYvE3VPYfBWkwoh3YvVHqHxvaey1I46ExFC0OoG5M5se/BGCAXcll9oyEfTjl6aPz1zrTF/BmINCIRokJkp1Qpldz6ehdA4DoEDc3NP6/l5sG4d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(8936002)(8676002)(6486002)(33716001)(5660300002)(7416002)(6512007)(9686003)(2906002)(54906003)(86362001)(41300700001)(83380400001)(38100700002)(26005)(316002)(6916009)(478600001)(1076003)(4326008)(6506007)(66556008)(186003)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BXs4/Ppe/I1zItHDIYaDf3dCXQLeya+ytUrC+3AF/EoOtStp0BV+cfUBIoXi?=
 =?us-ascii?Q?Hxc2wVUdtsaaokEOOWyUzZ6CrHgblkgquzXLmaEmDTTJFEVCg/ioMh0UXChn?=
 =?us-ascii?Q?y1XEs4gujKew1Ddxcxr1WWMAkMYnHEAJpijo5P7+Wp2Txq9k/4eMjPUE13qD?=
 =?us-ascii?Q?5jKGiojZ3rRGzXn+akqE+ngiRavKB+p0Ppc7APxPYoOG0ixB767vn3cIM4HR?=
 =?us-ascii?Q?an0TaQ6Tiv1uZK8QYtPPFxKweYtcvgGIoNHJiHWHhv8/BLOJL9b9VA0z3tUZ?=
 =?us-ascii?Q?93gHk2ekDeDLVWorjeCxJMvC5MDP4S5H+s7oRJiEfUwUzIDgYouZTphmb/Zu?=
 =?us-ascii?Q?k0LS4240jIDBfOV+DS4hukDk0oHiuAYy1jA7X1fcbZdEHK7P6Jc34f62YMFP?=
 =?us-ascii?Q?1ulW+mMiElbdF30T3ggBw6iRYvIqB/SQeHUdGKZlO+OHkd4shJ0mKuap+0W3?=
 =?us-ascii?Q?3bGft+X5LQRfeEL7Z8DK0WfpzKU8jzW1WeUZB6/CAt2qf40po4VOHyQWMKQv?=
 =?us-ascii?Q?fvzq2+yzafQzDEgPYXQe6MIX8i9MxusyE5MYfTq7WkdwM3fw3yNtn8sSUBB3?=
 =?us-ascii?Q?1BrHCsWguPcfGYbE5+KKkk9KrZqsYYTCTiuXO59S9AY5W2uv07qmc/N4VvVf?=
 =?us-ascii?Q?+ARgwIbzqZKVI2P8WCmTyDV4FpggjwFSxsLv/3uulVClK6hKtxYiMpK/napc?=
 =?us-ascii?Q?w7RpfUSOxwVQpsMSsZ6PoCCT8PUTz0xcxnQt3zOzrsYMGHlLRdMRahypUHz1?=
 =?us-ascii?Q?ixYL+WfIbCX/PCVYLGCPTo7epmjBt49YPW5hDz2PFuMmlkRFn2I6fdaoNNUl?=
 =?us-ascii?Q?BtbtN3zJ5semlDFbUV5vu+BRwx0+2wiWWiywKsF7cTbekYAHqh7AuMl7X6CG?=
 =?us-ascii?Q?n+julgKjLm+/ybpNJiWUL6o3ZI6t/3il3gPjsusyFDwCJqYEWYF2ZX+FmEk0?=
 =?us-ascii?Q?QMhOrJaqyqQjAN6Mma+x0WOVbgZjKIsiGY6299qIYAjJl9eAvcMsp6DlaWYb?=
 =?us-ascii?Q?IztwFCIIhSaTCBIxapeb3DK7rzAM9q1+W4cuoUJlHHvGDQGn3dU0EZdqsZGL?=
 =?us-ascii?Q?QSkBm6vxZPdp4BQdlAD+1P7O3xwmgAD0uSGABaRgJV5jm1+hK6257FcDOwPN?=
 =?us-ascii?Q?bDrae6hMr4BdHCR0kPCKSRjqRjKVI5J+ods2IbKH9RPUfiTBKwqn/NHZIzcr?=
 =?us-ascii?Q?LG9dZNSAi/ZeCc+7TLFzq8gsTnEz175JChqis3bMFTgw9NMNbpQGYy6KX7Op?=
 =?us-ascii?Q?uj+ZoXreGwBEXgJ7FZQ47cNcWpi58AfJY8u217oF4nxr36e8o1HiL1511EQS?=
 =?us-ascii?Q?Ut2W2b+Fhm94RxvyZ71SrEw38HEdaSJ7/O00DOVclfH0G3xJ/+UPjAbFNtBN?=
 =?us-ascii?Q?o0uaqVq5O5JGlwW3l8b6E1W3k5uAnts+IjUiKkV2f65NnYbsRA2v1LE6os52?=
 =?us-ascii?Q?V5WSqRdDI6IMjEAFWXoTJ0+74zcSvPnrbsHFqHiISvei+fhmdXYx5OdkfLDg?=
 =?us-ascii?Q?i5NbSE1a9DxBHy/o5HwjLaqeR6rIH3f2/iSczYfZRO9SJT5ZvCHqonX1Z43p?=
 =?us-ascii?Q?d4/VgXo4PnvugEYxpTHviPkQ0owG5x7uGzqn/h/5KltRcvzHmbkbQk+qtQCB?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SAFUggOHl2lZmFehvfow50QYUAPCz26C24NTzzukVY2C9594gxpTELRL5qFS?=
 =?us-ascii?Q?QanyUpdDKQxQiWPQRGcoSAcKBbnTgTMLUJc/t4BNAtRrqqfe6mD1BYZwOR8Z?=
 =?us-ascii?Q?OetMPQ+4l+ZNGfEViNlWM7EBDRtk+pAHqUi9llvVW1SKXZtYWImmzazC4tBo?=
 =?us-ascii?Q?2PXAGbL3Lti3xsuYUYnfS66gvmLhVLnQSe8VS9thHK6AlVKZBTQ8qa1ed9GM?=
 =?us-ascii?Q?H/J2GzvuOnvrcE/F6D6YuXvyvlzWc/RB6lyHV83odgILIPNPpKF8tb3DslEg?=
 =?us-ascii?Q?D0619NU9N0L40Bz3dKSt0w7G7DNBvAW0tUUpMBh635Nxr91lPILmzqZgvkZK?=
 =?us-ascii?Q?L0AY4uRwWvVzJp6dUvE9P80fXHBwubyKZNaWpfa/7EHqm9LemVssSJBLg1mk?=
 =?us-ascii?Q?qtVAvbvP3s18BFvrcjEnMU+Br2qOR6qcNsB/8mp81YogYBhS+U+lntMXL7hX?=
 =?us-ascii?Q?Rn5kSD4kpdIw10RqXhOp6+MFMwTjmZDWRQC9SWHfJ3l8dY0NJCx+Q2t55By5?=
 =?us-ascii?Q?F5fbHIyGwb7grXsTAwIIkPVZjoQL4zIMT7YcrgS3QGQMCPuKG1nLEbb4fPx4?=
 =?us-ascii?Q?dBJuzL1TwqvdVGXErrh91HcfoIid25BGWJoTlyVX4cKWznfW7ZNbjecgW1ov?=
 =?us-ascii?Q?fy74YOeaPr1fbLAq1WZUlPWkZc3RYQLRcLgcr2RG0ftW/D9SGnn5IKnqwjEY?=
 =?us-ascii?Q?LBPfz33hj5iOkhZ6HlNhGMQLzKhm2aPMFc2OXo1qOpIjgpAEkWm5lIxnGk4C?=
 =?us-ascii?Q?4S0Mteexq0bWOPz+iGAZ2azs/j/c16jb3QG4Nad9wg8hrpr7Z40nT9U9N5MH?=
 =?us-ascii?Q?QnqRccqatAYdjyNH0PrZDLlCspdrx8/KRfgkQYp/f5cxu+YX/A3zpMBzeD4e?=
 =?us-ascii?Q?VgscV9OeEpfUapNpBGofY7g/QKk1ao8Q1v0e1hJIduAfsm+nuwoPGsg/c7aR?=
 =?us-ascii?Q?qhGDf5AMrlTDwbxkLDsHj5T9V82A4g5ltnUrpfBQbwS07Iej9cMOTmFuY5/F?=
 =?us-ascii?Q?0fDjkhGMFlDpkP2UQcIGBLhLSntpXOdhnoiiV5Zw8oOHkNkuj4+rKOFRx5QP?=
 =?us-ascii?Q?LHasc6SpvLHCBN5gzf2iQdStxHwvPNta5QdscL88dbtFiD2MRxk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea46690d-39aa-4072-99aa-08db774d13d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 20:28:33.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p61rXYfOYJYQFwsVwNZBzwubf4CogeC3IjRLivFxeMPbXNVeXA1QMoIz2qd/Td2dqEXnVRjvGEWIp9Jl5QcNbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=745 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270186
X-Proofpoint-GUID: eTupTmC0TD82nKzThJebPk-DbifJyByw
X-Proofpoint-ORIG-GUID: eTupTmC0TD82nKzThJebPk-DbifJyByw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [230627 14:02]:
> On Tue, Jun 27, 2023 at 01:56:09PM -0400, Liam R. Howlett wrote:
> [snip]
> > > > How about something like:-
> > > >
> > > > return find_vma_intersection(vma->mm, addr_masked, vma->vm_start) == NULL;
> > > >
> > > > Which explicitly asserts that the range in [addr_masked, vma->vm_start) is
> > > > empty.
> > > >
> > > > But actually, we should be able to go further and replace the previous
> > > > check with:-
> > > >
> > > > return find_vma_intersection(vma->mm, addr_masked, addr_to_align) == NULL;
> > > >
> > > > Which will fail if addr_to_align is offset within the VMA.
> > >
> > > Your suggestion would mean that we do a full VMA search starting from the
> > > root. That would not be a nice thing if say we've 1000s of VMAs?
> > >
> > > Actually Liam told me to use find_vma_prev() because given a VMA, the maple
> > > tree would not have to work that hard for the common case to find the
> > > previous VMA. Per conversing with him, there is a chance we may have to go
> > > one step above in the tree if we hit the edge of a node, but that's not
> > > supposed to be the common case. In previous code, the previous VMA could
> > > just be obtained using the "previous VMA" pointer, however that pointer has
> > > been remove since the maple tree changes and given a VMA, going to the
> > > previous one using the maple tree is just as fast (as I'm told).
> >
> > I think there's been a bit of a miscommunication on that..
> >
> > If you have already found the VMA and are using the maple state, then
> > it's very little effort to get the next/prev.  Leaf nodes can hold 16
> > entries/NULL ranges, so the chances to go to the next/prev is usually in
> > the cpu cache already.. if you go up a level in the tree, then you will
> > have 10 nodes each with 16 entries each, etc, etc..  So the chances of
> > being on an edge node and having to walk up multiple levels to get to
> > the prev/next becomes rather rare.. and if you've just walked down, the
> > nodes on the way up will still be cached.
> >
> > Here, you're not using the maple state but searching for an address
> > using find_vma_prev(), but internally, that function does use a maple
> > state to get you the previous.  So you are looking up the VMA from the
> > root, but the prev will very likely be in the CPU cache.
> >
> > Assuming the worst case tree (each VMA has a gap next to it, not really
> > going to happen as they tend to be grouped together), then we are
> > looking at a 4 level tree to get to 8,000 VMAs.  5 levels gets you a
> > minimum 80,000.  I've never seen a tree of height 6 in the wild, but you
> > can fit 1.6M to 800K in one.
> >
> > I think the code is fine, but I wanted to clarify what we discussed.
> 
> Would the same apply to find_vma_intersection(), as they equally searches
> from the root and allows the code to be made fairly succinct?

I think so.

> 
> I really am not a huge fan of find_vma_prev() searching for a VMA you
> already have just to get the previous one... would at lesat like to use
> vma_prev() on a newly defined vmi, but if find_vma_intersection() is fine
> then can reduce code to this.

find_vma_intersection() will work as well.

> [snip]
