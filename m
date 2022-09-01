Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3B5A92CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 11:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiIAJNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiIAJNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 05:13:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C931110DBB;
        Thu,  1 Sep 2022 02:13:47 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2819DJQN021032;
        Thu, 1 Sep 2022 09:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=c0O72IriMhGNyoc4XXzXY45UKftdfkl2lH0WpbycS1s=;
 b=RN2sIWE3kaHuANfmWKtqf8YhNKmGa9i3ZK0LndsqJB9Kr4UhEAfOQZNOjt8c3x1yCb+u
 3QtX5wrPr0NRMuxvfbMfiC8A28VOHv7hBVVAyXwCMPrhZlO70+pFsoZRdqQYmB6kiDFa
 K4Ky5QY7cO4Fv1M3kCLSByRafuvI0GTRIxW9Ts6VGgWa+JphQpo6L2WnVx07wPXlpPAX
 9MFSt5RrbaiFRJnYOScqBBoPhrbdqLlcPa5gKUezAxVg2egkZOLSJDIF5Nl+iNEC69qt
 y3k6PV9rVO9nfDmsqyTZBlnl2XyrpiHhfX8Gra1GRzhgqAUJlqMmuhUkv8FI6Wm86R/L RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaswjg08t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:13:41 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2819DSIk021258;
        Thu, 1 Sep 2022 09:13:41 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaswjg08b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:13:41 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28195n3i022602;
        Thu, 1 Sep 2022 09:13:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3j7aw9cs27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:13:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2819AJY236045234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 09:10:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E69B1A4053;
        Thu,  1 Sep 2022 09:13:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57940A404D;
        Thu,  1 Sep 2022 09:13:33 +0000 (GMT)
Received: from tarunpc (unknown [9.43.6.31])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 09:13:33 +0000 (GMT)
Message-ID: <7fec6d15f69751422de1e20cf13b5a3f839da2d1.camel@linux.ibm.com>
Subject: Re: [PATCH] selftest: vm: remove orphaned references to
 local_config.{h,mk}
From:   Tarun Sahu <tsahu@linux.ibm.com>
Reply-To: tsahu@linux.ibm.com
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     "Zach O'Keefe" <zokeefe@google.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com
Date:   Thu, 01 Sep 2022 14:43:31 +0530
In-Reply-To: <20220831211526.2743216-1-axelrasmussen@google.com>
References: <20220831211526.2743216-1-axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xckYG2GaperRmTQSv92VmzrzhFwfrrCM
X-Proofpoint-ORIG-GUID: LiICgCKO7R9bbFuHYXHIKfMWcNQPitE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-08-31 at 14:15 -0700, Axel Rasmussen wrote:
> Note: this commit is intended to apply to mm-unstable, the commit
> being
> fixed only exists in that branch for now.
> 
> Commit b4efb234e53cc60ccdc855190be9f35918687412 ("Kselftests: remove
> support of libhugetlbfs from kselftests") removed the rule describing
> how to build local_config.{h,mk}, but it left two references to these
> files lingering around. The result is, none of the selftests could be
> built due to dependencies with no rule for how to build them.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/vm/Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile
> b/tools/testing/selftests/vm/Makefile
> index b52f2cc51482..4ae879f70f4c 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -1,9 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for vm selftests
>  
> -LOCAL_HDRS += $(selfdir)/vm/local_config.h
> $(top_srcdir)/mm/gup_test.h
> -
> -include local_config.mk
> +LOCAL_HDRS += $(top_srcdir)/mm/gup_test.h
>  
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e
> 's/ppc64.*/ppc64/')

Thanks, Alex. When I looked why it built in my case, The local_config
was part of .gitignore which "git clean" ignored and they resided there
and source was built without any problem. 
I have submitted a new patch for updated .gitignore.



