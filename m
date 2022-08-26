Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534C5A31C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344902AbiHZWNa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 18:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbiHZWN3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 18:13:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446AFE1A95;
        Fri, 26 Aug 2022 15:13:28 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QLSjK5014332;
        Fri, 26 Aug 2022 15:13:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=C7ugfbb/BOSZKg2YMnKoCRUxB56gCgAq3Xz5E/NFG58=;
 b=MjUSw0YSprBFuS/sMnxCTxL1KL8MyI+c/my7gcBGm0Qr7Ia5jCFRQus+EpmqqBdv1dVn
 tIC6E3kjjKC5tw7wbmpe/F6ZJjPnasW5OfSJDi5jjlBRHtUrOujyqPLFSprry8fbcYLr
 l7XkY1slsK/aDAWZfkB00HJhWvkQibxrZFA= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j764gg6xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 15:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mThRLSwEI6FnBqsWiwgMiwZQN6TDRb/MO9nKHhAYp/qU/CpFgbQXAzoq52Toz89GF/A6F8J/lxtZzkQO2HNWEGnFr12ONd3TNY6zrtKPf928/DfKZJM1QATAuLnZmZX7HlCSrOyUd0Rn10NGNM74O+u/RjgziVTcTgrukIPKsxqH1hprqj7947XgBZQw8PMVjeu8FvmXxSsAqYuy/zAmrz1up+Tectdcz3cD0z3pOhy4yvZ3hOiBpXqYYA6dug08uA8L/vFitVbbZ0c6N/cEhifxOthx29EzDMlOBncZfEvkeKWOblgWl7lbMjV5eJx3N1W7iPZVa83lNb3JNNyjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7ugfbb/BOSZKg2YMnKoCRUxB56gCgAq3Xz5E/NFG58=;
 b=j2csh+DwkxTe9u8no/G1UWn1xmy2Rz1qhbuaUBUcJI47e2SN0tpa5up+YzrXHnPthuFO0XxIy7bgWpczHJ+YZ5GR8AmOo3hfPFqgkVAmLP31iCANw2XurBcI/ZE+m6NTipByODwh9u4P5Ceu31xGfjHguX9QiZvZt8k9u9Dj03gGRAGVtlwUkViboZfbvm/o5bEHWUgPIJSDIWAR0Unq0gyBLaKbK/7hj/yhYPdcRjXkhPp3aNrjJ1gJem32fVTKwiPXa6O+YRk65akP1Upe0QnVinXJ2d9iO3uXP1M5nCGrP7E3b1opUxx8U4rdq4Sic4SF0dcjomTSxdMRCJH6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BL0PR1501MB2082.namprd15.prod.outlook.com (2603:10b6:207:31::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 22:13:06 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 22:13:06 +0000
Date:   Fri, 26 Aug 2022 15:13:04 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: fix type conflict in test_tc_dtime
Message-ID: <20220826221304.5nhjiclvreotphim@kafai-mbp.dhcp.thefacebook.com>
References: <20220826050703.869571-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826050703.869571-1-james.hilliard1@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d232af-1843-405a-d9bb-08da87b026f3
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2082:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IulDLGk8tHLa2LPhAIxE3oRtbwzRW8vL5qkRhbsS4Hg3NJSoE3yROwpbp4WuGsF7daqxQWaNvZnC+vRRN/e33GyCP/tSg44/PJ34b8PBPali1QCowNsU3exBY6WiEmx//uX7wlhVBPfQxob6nSSAU3l7nUESzbkkg7hTMA8oJRTmm1KMW8z4Kc04RkE/AfRQbitECid6GcDfo/wPCX4h9KTBIWe0MqXfTFrY7mAuiV/JaCTpZcVZkLZXr+cqi6ftBnLujuY3gCJDQ+3KiAyIlPhnBhU5XOvCPikJxt/QIiAbX7v7EoKBRaYkafkCCRfokM52vaTuZeJ4fSwONU+WOqAqzgKCO3B275+N/2WtXKPw1I4MGrHEjiN9gDxmsTnM3Samq85IuM4+QqdRMBCwaEjek5pONsZDLraEJn25KkzqGCrHhyipe+3OmsjdzJ6L96XdScPrKgHeRfvDk25Co+1Xw5nIkdIFYxcosZ4b9YD8cz8tOwPxuug9q+rzKmV3PgzAcvDjasWZIsCKVnWDVTQric6tQ7i5gbLGqDMNK52MXiErlGWEqm5WdjYS/32dBIwjETUYdSLOL6XhecFM5VoH8EKZTqS+zeZb1xGkGvHoJKIZQizB1AxPcY0x+lfm7VkoEsdZ5ZcI8+BpFNQdboQioF4ExkfimGdXDEweppr7rXnyxvc85cbDSrTEnL09BpJgl5dMg1q8CnsL/i+CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(1076003)(5660300002)(7416002)(8936002)(2906002)(66946007)(4326008)(66556008)(66476007)(8676002)(6512007)(6506007)(9686003)(558084003)(186003)(478600001)(41300700001)(52116002)(6486002)(86362001)(54906003)(6916009)(38100700002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CHglVKwYIrh/LhRcdeFS14svxdt3yk2lec2SwwywOP7h7SuS0I9xeLX7+DM?=
 =?us-ascii?Q?mjZW0dYhlfpbyTWOJONpA0MCQHp1670frr4Q9+2EVYO90Ocmy2bNS129GyxK?=
 =?us-ascii?Q?CiEGNeVFxHoH0hhrzFDzjriRIRFbZqI+1FJWSnUr1L4kYJBQFQxrc5c1gPu/?=
 =?us-ascii?Q?was+ckhIEV8a4Q8n+xdCDEw7W8r7Te0W34l9K3W9H/FXcpp+I03I+WBCGnr4?=
 =?us-ascii?Q?fHfyg3ug90ZAYEJ9eP4Eckgo7ibeMcvAMJipnGbtNoY2HSuJGDZdn9+6j1lY?=
 =?us-ascii?Q?re25D3IOykbKVqQKpxJsmKHy6onVe1VZmlTWsy9y3buqG9eGH4ujHUM9BNfH?=
 =?us-ascii?Q?5G0xE9vgoPP+7EB+lJoSbG6LS5n3576hmhu0GY/jVPhs5tATJZ7tC7DG54U3?=
 =?us-ascii?Q?G2FvONDbHZfXYcNO6LZSbvIb047kB8F2wm/MSMXIl1mRYbZkP3NqfGXXFRGC?=
 =?us-ascii?Q?WBkQMNG0K59rsrFa2IBQCiQoI0N1dcSxKSofyp+MZ0P7VJMFNKAzSnAkAsQC?=
 =?us-ascii?Q?Qp/MjX9MEpf0U6rHyjqiSLVMlVTrCkCx7zuAXonDCey4YsGwv2jIq2Pqtd7Q?=
 =?us-ascii?Q?JRxno/NRx8XlejoXNw9awVkUEcBmxzfi1f/5+OZw6U18N2/PUe3y3mUNaVZU?=
 =?us-ascii?Q?+q1DCHWEpjBkQx2qeV4L6S284QscIYHggEhe28Ykur4QQUWwcx/KZKqjIVIG?=
 =?us-ascii?Q?y+Xi9x4smdBdDl0oElEQme1GhwNgT5KdVfIu07VCwSnxGFIWF/Sy29kHJEL3?=
 =?us-ascii?Q?uqVQJaV2QAdP4e66W38AAUzID8RXDzwOzWgkU2ecVSdK3CRFSpoYJcZRT54c?=
 =?us-ascii?Q?uOoOMzMCJ2gkQPSDY9tn7xy8p15Bx6g5G4wQKKv3Kg0sYnw88FEUyFQZMjiS?=
 =?us-ascii?Q?BWpD25/PEc5nZuVgHB8ZKwUKD8ujpnfqyt/3MuRRCG6aTXqSDgKc0tYgL3Bu?=
 =?us-ascii?Q?QqnX3DjmzBFXGYXXkHEHW6BqAKSZH2Gp+Ee1Nrx0DKrNCqeKicwA84aY/n6n?=
 =?us-ascii?Q?DmzWH2/FKfDfXAHlCR7khQpb6Qth14GF/n13iJcZT5Tr0K+Nwq7Uwr90iOdD?=
 =?us-ascii?Q?6Gx/UOo0T6U/Vx0UmwO1sThVhxvoiTlgNHrJ8RtM6tTeS7gtIEL5aZDbLQad?=
 =?us-ascii?Q?CCE1CDzNtTQbgxy5oj0Gz4sSeppEY3r3QlQ2sMCcH7kxm0ysTR9ED8/bcEnn?=
 =?us-ascii?Q?YqVnoAZeRzscQtk48drXst4AwD2N6UjOhCjvGNq7wUDzke+uMlMFvkHKdeJh?=
 =?us-ascii?Q?eXBoUIcbpucrLoIFjqoNXRLWbbR49fRSCF9xjrocukBHVnNMwgEUv5vRMFEq?=
 =?us-ascii?Q?a5JxWJhpSYCDU+Uyfj+05oiZXHZJBT0XNK8jNQ281zQ9r8b7HNC+D9g3SkLv?=
 =?us-ascii?Q?A2AnAJyFSWrmxYz85lwFY/BFtKMVpjoeemmuFENN/SfKb14rJvx5ihXwpwOX?=
 =?us-ascii?Q?MxnfgaLEF3MI2sHwBQokvlyaTUcdgpws8DqVZcrna5GjHrrzxbUKlKg+TugN?=
 =?us-ascii?Q?5wn+R2BCAoglajQac9gkerpkQttyZuUYmvgOekmAsxhgYEBGS4KL0gUqNYH0?=
 =?us-ascii?Q?CbwoTX6MPCcZPCbyvL+7IkiV7cfKM7p1UGwb75F+6m4Y9bG/fi7yrRTfClW5?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d232af-1843-405a-d9bb-08da87b026f3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 22:13:06.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwPG+Fw6kMxZFdFOgeR/QSjRqYBjgVCFkzHE9zuchXrIryF04WOP3wOoZJw9XS6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2082
X-Proofpoint-ORIG-GUID: G6CUSYR7rRuo6Z4TqFnbQydUmdN4tYkt
X-Proofpoint-GUID: G6CUSYR7rRuo6Z4TqFnbQydUmdN4tYkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 25, 2022 at 11:06:59PM -0600, James Hilliard wrote:
> The sys/socket.h header isn't required to build test_tc_dtime and may
> cause a type conflict.
The header is unnecessary here regardless of the conflict or not.
so a nice clean up and applied.
