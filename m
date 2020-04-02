Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CEE19C5C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbgDBPYa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 11:24:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44406 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbgDBPYa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 11:24:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032F9dqH135553;
        Thu, 2 Apr 2020 15:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=YGiAhHtA16Q4tYk3m8cxFMkmHJt5fwf0CJBlxo32jHs=;
 b=ASIJARDm1PIk4kwOZIQ/G2LV3UUzl+F21EoYeQOkgwMYJ4ZIRGUPGWN4oPVyuvJ3VMxB
 HUCzIOI1gvCHxqUIx8A3AOYC7qzcXB1yKbwMrGmY+6okK0DL5Rw28qfSsK7QA5bo8ORw
 85aBsx/SkdgrQ+huiQZJrFvrhIi8qF+jFVX2UjlHVUOet632/R8PNQqQ1YFl8WgzclbU
 LXvizAMtZ2ZmeUJbZAcLbgoq2+vjs4TXd34QJCNuGgrtcX0ergwmzix2saYUV5jPNFsY
 VjdhuUO/6rgD7XTNu1rcwUsNogrsQI+ot7hpqJKdHpAcbzoTJDRGBiydKGOcnAEeMtWl hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 303cevc52w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 15:24:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032F8U37188492;
        Thu, 2 Apr 2020 15:24:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 302g4vq7td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 15:24:20 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 032FOHRv019903;
        Thu, 2 Apr 2020 15:24:17 GMT
Received: from localhost.localdomain (/95.45.14.174)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 08:24:17 -0700
Date:   Thu, 2 Apr 2020 16:24:10 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Colin King <colin.king@canonical.com>
cc:     Brendan Higgins <brendanhiggins@google.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] kunit: fix dereference of suite before it has been
 null checked
In-Reply-To: <20200402150314.568044-1-colin.king@canonical.com>
Message-ID: <alpine.LRH.2.21.2004021623270.21551@localhost>
References: <20200402150314.568044-1-colin.king@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2 Apr 2020, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently pointer 'suite' is dereferenced when variable success
> is being initialized before the pointer is null checked. Fix this
> by only dereferencing suite after is has been null checked.
> 
> Addresses-Coverity: ("Dereference before null check")
> Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks for spotting this!

Alan

> ---
>  lib/kunit/debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 9214c493d8b7..05547642f37c 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -52,12 +52,13 @@ static void debugfs_print_result(struct seq_file *seq,
>  static int debugfs_print_results(struct seq_file *seq, void *v)
>  {
>  	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
> -	bool success = kunit_suite_has_succeeded(suite);
> +	bool success;
>  	struct kunit_case *test_case;
>  
>  	if (!suite || !suite->log)
>  		return 0;
>  
> +	success = kunit_suite_has_succeeded(suite);
>  	seq_printf(seq, "%s", suite->log);
>  
>  	kunit_suite_for_each_test_case(suite, test_case)
> -- 
> 2.25.1
> 
> 
