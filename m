Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8902D1ADAAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Apr 2020 12:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgDQKEB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 06:04:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgDQKEB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 06:04:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03H9veQY030546;
        Fri, 17 Apr 2020 10:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=dKO7ialKD2AiGPTJR46eRoXOPRYf6fFf+AEC/fzDvXM=;
 b=oRilH+G7Gvipo30QtdCGbuFyuso2wMFt4B9F0v4aRwYeTrgAT8Ar8ToIYI9aCB1WNl1O
 BbjFJ+V8MiXSwtWXOzxLzCfKxiEw/Di3Svh9i32gOJL6+53Jq6E0zv2xUsDDUuX2bFqY
 lOAVIL4qU94DIe8AiKEkJhAlKLt229OF74o3jZfQlFskePn5lQD5E8IzlAEIPAfMgV2M
 d4Q5DxGcutqfTiqKNFrQFehP6bwj99000rgie8wA0ukzV0WFQ9OpyFVMskRTdIKm1sY/
 mamLBDmpayhoVuUlOMVyrTJIOKBv+qADn4Jt2/s9D8iFZ0cSNQ7VRQtEzMzkJPgP4SC0 Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30e0aabtd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 10:03:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03H9vvxF046488;
        Fri, 17 Apr 2020 10:03:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30dyp2655j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 10:03:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03HA3qWK032622;
        Fri, 17 Apr 2020 10:03:52 GMT
Received: from dhcp-10-175-205-33.vpn.oracle.com (/10.175.205.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Apr 2020 03:03:51 -0700
Date:   Fri, 17 Apr 2020 11:03:43 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Marco Elver <elver@google.com>
cc:     linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        alan.maguire@oracle.com, frank.rowand@sony.com,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] kunit: Add missing newline in summary message
In-Reply-To: <20200416114256.226329-1-elver@google.com>
Message-ID: <alpine.LRH.2.21.2004171103160.32364@localhost>
References: <20200416114256.226329-1-elver@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=3 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170078
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 16 Apr 2020, Marco Elver wrote:

> Add missing newline, as otherwise flushing of the final summary message
> to the console log can be delayed.
> 
> Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks for finding/fixing this!

Alan

> ---
>  lib/kunit/test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 7a6430a7fca0..ccb2ffad8dcf 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -93,7 +93,7 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>  	 * representation.
>  	 */
>  	if (suite)
> -		pr_info("%s %zd - %s",
> +		pr_info("%s %zd - %s\n",
>  			kunit_status_to_string(is_ok),
>  			test_number, description);
>  	else
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
> 
