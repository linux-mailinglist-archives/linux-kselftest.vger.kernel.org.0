Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4243257A51A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiGSRWm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 13:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiGSRWk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 13:22:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF141D3A;
        Tue, 19 Jul 2022 10:22:40 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26JH9mbD000859;
        Tue, 19 Jul 2022 10:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=p5Y6HwFXzV012PEyXHSCXqRRt7+AvJppG37jMLvcas8=;
 b=irrqB1qJEAEIi7/Ym64V27DW4fiKzaKimGT5jMqt4Z6AdnVd00cmWV1KPObEl946W3uP
 p/+Xhp3xvcAmbN5xkLU1oIs9HC9MV8MZEN2QiDSlTf1sABaIChhAEM/fjGNC6cLJhh+Q
 L6ATVPpWN/fl8quUp1MEGRyLOoTxlcN/bS8= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by m0001303.ppops.net (PPS) with ESMTPS id 3he0ry83np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 10:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFT3chYx1qqLQcTeyZr6gfkt1XQBSuRkvwDyBtIyPSdGzbzah3dD3fjZRouSYJrmBfXlmgC6jWKbeiDNvJbG6KZ2F47K5FotppxC0gHi14JUghBjcqLYTCpi/mhH4im1PNucoOF2WbrV+k3yohlfgO6tZdmorFGjl3jCaJS+JMtnk41CUK7wz+oeIqhioAau2azrLl6+XrLQff7nWNlw4Wv+6l8RCrETgChGK8w2vA2GR5fPIQM98vPxmWxSB0BgYMe9aSAH3HN/U66g9nNI/FKCYtrWwGPfpuw8LolmUc99k+CnzALWt21e2r4hoBEW8wwLNHJ6h/0qfYs09A1fng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5Y6HwFXzV012PEyXHSCXqRRt7+AvJppG37jMLvcas8=;
 b=go0Pog/mrmVJxw/7MCiHEsjgHSNB4KcJpibNhpeg8Y7dvyNSKfPtyLlBwwkInac6CuoR6A5nNNzVdPkX45wopkfgYRlmPFc6nqvB7sxOa66ymMX+KgI+k/+huawGIeQLGR/5q4mNlxYWgJDQ/YQs2QXwNrj4Egd66uZ8LiTDx7gGJOu93FJRsnprIsjrc7mGNRKf8Is7O0af/i9snzZFLLtst3Vd5oi9ieL+Iv2OWgmR7wfqkBGkD5REzT9XqausOHyQl57evdqWkk7kCPjLQEQ03lvVs6ruDpihcu3rV45kfWNAD5qPqjrv9Ngbaz0ArSH+EPnPtNRcbEQdcOW0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN6PR15MB1747.namprd15.prod.outlook.com (2603:10b6:405:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.24; Tue, 19 Jul
 2022 17:22:22 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%8]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 17:22:22 +0000
Date:   Tue, 19 Jul 2022 10:22:20 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: Re: [PATCH] selftests/bpf: fix a test for snprintf() overflow
Message-ID: <20220719172220.h2ptmkggvezq3v4l@kafai-mbp.dhcp.thefacebook.com>
References: <YtZ+aD/tZMkgOUw+@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZ+aD/tZMkgOUw+@kili>
X-ClientProxiedBy: SJ0PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::29) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0720253c-5de2-4230-a905-08da69ab3d85
X-MS-TrafficTypeDiagnostic: BN6PR15MB1747:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roc7DiodRV9H8dcvXqXvtXwDcO3r+cmHlsu/2eF2Oa8wJeWhnQikX6kP6JR95smX4cm805ko1sDrCa/PHae4jzwdXNJBiWT2gVtS8WfhirrEdf1zPi9wxXlqZI7s/ZAD8DxZQse90KHejrNScOeQ0lzDJLAe5eIofwcvAVtDpjgD7syyfx8l2rG+eb2DZrIGt0rH4jhXPub5Uwt1Cd/vNQhA3FeJSkzUfUUFp3tvKbI6Uv6v/O1puIMtkPM0r7nJ6aBpabzrwbsoYxggsUKkEXPXwiTOHp8BaaIEtm2gZHVSVkG7aMu6CaZDW11JDWQkfMhIQK/tGq/li9p8le9XycdTWXWzx1sI38oghexLhMOpYxcW5OqQ5TPwebWSpdyayB1KHf1h8VNjyzK8ZqGDPM8/3EiKScjfYuI6pcVPFeWYm+ZzVtyO8x+1Ye+rwqWcLEwty72iuInKtUhqwoIj1IGoUB5aG6MtPd0baQyQSdF701XzXms4rb8c9Ig/cDMe2VvAdHyCuK6nWLysa8aJLLtQPjuQovbCeOyuPR/RF5k49QjEKBhftXOTo96wka8xutwyKBo61by/W1WGvYx0+uxDSwI5baHXTHcR93Dg5ZADAWLaxiSM/4isP5cXUVgYa9fGuNfGrtklX0UyPVN35UPR28ylUAC2C7OSP1vimu864OkGH9nh7dCvd4tV/xxArzjVKPJ3gbhAMHANnpJhLCPOAagWmwhKsgOVvpIpsagE0jZaulgGszkiJ2EZv+r5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(8936002)(66556008)(5660300002)(9686003)(66946007)(7416002)(4326008)(66476007)(8676002)(4744005)(38100700002)(2906002)(86362001)(6486002)(478600001)(6916009)(186003)(41300700001)(54906003)(52116002)(1076003)(6506007)(316002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZxdmoJvXFGu6QO2K497njrRQwgPJWpRIs5t2BmD1KgU/N/kemmMRjuooyVr?=
 =?us-ascii?Q?tRNwmSiw4+XPS7KioeH4GpjZk23SStWHvYQzlxW1a3fIk3fS3DHluIe4royt?=
 =?us-ascii?Q?YxAd/t9x+d8I9sZ8rxOUVOpekPhnyw1mcLTZeNNmH4VR5yJMVKoE0+EnJmXU?=
 =?us-ascii?Q?5fx5pJNUoz2E0Y7Tmx162Qg5W1SLHmKhY83pPl4k3blBBu/Y+iFU64c+7x6b?=
 =?us-ascii?Q?gr3XS1qpaQUtFtkj8C0bY6TqyyS+tLza2t34RAQ5oRv40KonVuAlp33zzWvx?=
 =?us-ascii?Q?m07D1zqSAWqpcLKm6irqBkay7SOu2137FuBt6w5ruZc/OMtdJKci6+yzEa8o?=
 =?us-ascii?Q?hgkRK2vz+qbTq9R2TyvL56dZExC/PU60B0wNufAM4FlLS4ircc3GmqVkBe7y?=
 =?us-ascii?Q?SFOf9q/6yygZ+8a56Lmou368xk0uCc1FqmSC9KWM2bjG4vLeeXQEe9/mrwVT?=
 =?us-ascii?Q?A6/4N5zfyUAKaWRKltsVnF1VDxMrZfN68EiX9qyGm/9yPeDlveALRzCC1h9F?=
 =?us-ascii?Q?z0WuWyOkAto20xb6qLackUFbOedgP13k8vg4Xgo+xGH3bpyxAKZen9jITA8i?=
 =?us-ascii?Q?34bXlyZOxtLUGHJUD1mz05IBDRVivZk7xou3Mm6Oad15aOM9oxkmM96+pOYb?=
 =?us-ascii?Q?Ac5RExcfpHdrZ+/vbM7rboE5ta/uCRYOJ0YzGL9OvuKL2+A9npXjR72NmOBU?=
 =?us-ascii?Q?xGB5DgSzXuMIQPDPFZnjLL4ZIVVmLF1o+j1xdSxC2QNNBR1wuU0n8im4KMX5?=
 =?us-ascii?Q?nKQOfHH7qmWBfPoTmsZ2gIydZBCe/TJLijKs3tQks38fYTFjnFtW+raynfVU?=
 =?us-ascii?Q?MBwZSOxVztCqQorwkgvJCJBttKhck/5qRSu8rPjsmWILNU0jdXx02CuksP2F?=
 =?us-ascii?Q?+qxuq68SEVoGneXXIwgRwnEPUCjgGEHgssOHkF2MEVnK4aCbdNgpfJ/+A9ih?=
 =?us-ascii?Q?Eq7QdXRLb4Dop48EX7mm/43eyPaP0MpsHRf3lIJfsmQjFpqIbXdYTrnFxMsD?=
 =?us-ascii?Q?Kk/5L52JlRLOIqkGmFR29tcZBXUYqSS/Zn+hxxGQC6/ycIFNGE8EGOQhB0On?=
 =?us-ascii?Q?Jbvx0bJEtqac0L8uQKtAz0shFJ1a36i3Kj9LZQH1lHJWKOorfcuGkfjJNIZC?=
 =?us-ascii?Q?ZbqZmH7+o57cHgGvXVbqWH4GR4+ebSa+QaDVMo9tzvg1a6ulCjGadKS8o1m2?=
 =?us-ascii?Q?VAVpMgaOHbvhO0tfX06R5P3h7tGF34Z/LFO/3hquEbsfwzsv98jP1q/sYO/K?=
 =?us-ascii?Q?cc0dHFtS62AmmwuSzpHubZRGOQLx0sQEVQ8d1DxIDeBMEf5sYIXW4T6SXxl6?=
 =?us-ascii?Q?egNdyEGSrswIUp1lJc7156zML1THvWs53JEPKjiwXzv4cxqtRM+/gGDbB69t?=
 =?us-ascii?Q?IYZy/0uoUlL1Fl22sReudgeP07gdYRcrVDyxZ8/ctvWqFfBJxlt++dlDhucf?=
 =?us-ascii?Q?xR6HaGBEFiUcPZNE/c45mGezROQMnkE0a+NPPMifh0kP16QfFUoLAj0ShE1x?=
 =?us-ascii?Q?5rGimnTHcydQ0LX1evsBQjAr81TdeddbJfI1orD1mwkaHkOZZ9jixw8gYzIY?=
 =?us-ascii?Q?0bH5mVoLZF/gBtZUvPYR0eKsCCqtDcQ3j9Kd5w1Dne7Xzv62c8vc4ia4d64S?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0720253c-5de2-4230-a905-08da69ab3d85
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 17:22:22.0558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lpEej0kOpjS1CtfD6kidyoku+IPUCekL44aDKsjUMOV669YkPlUrj9c8MgN1M0H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1747
X-Proofpoint-GUID: Om1nyTciwwdDeTxBuYv39rUftTGnLUXJ
X-Proofpoint-ORIG-GUID: Om1nyTciwwdDeTxBuYv39rUftTGnLUXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_05,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 12:50:32PM +0300, Dan Carpenter wrote:
> The snprintf() function returns the number of bytes which *would*
> have been copied if there were space.  In other words, it can be
> > sizeof(pin_path).
The current test does not fail on this check,
so this could be bpf-next.

Acked-by: Martin KaFai Lau <kafai@fb.com>
