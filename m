Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D498F14FACE
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2020 23:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgBAWSq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Feb 2020 17:18:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52146 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgBAWSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Feb 2020 17:18:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 011MIFU0155051;
        Sat, 1 Feb 2020 22:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=b0eloi3LYgRMZOO881K2rypqFpFcW6O9Ott7NikrdgQ=;
 b=GaDDcm5MfqnjKt0yrsOs7KHPkR+V5Rwvh+kbpO9qzOnGzuPDafTUXT4FR7Ot3Dpd7zFg
 +n44vGjrQBCatAOSxbpbnOxy7S7hYkwgdpKPFc/ChiHxjNRTAvjnY3wOyWO2txngX5c9
 l/bseESXJVtIR8+cS4DTaWzA/kikQD0etuH68uObmXW8JbFZ/BXmOKaXTp5WUiNWiIbT
 YOr8o+umByOQj3mbqmCS8gQp56oLf+h6oJVPtfjx+/kNPymH3ekJPTwhMCz9CfgborK/
 uKobUCk0+LbYv1lsLpieHYZcIavkWrc8QLu5zHYfhtkygDrg5YxATTybsplo2EOJQjCf Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xw19q25fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Feb 2020 22:18:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 011MIOud067305;
        Sat, 1 Feb 2020 22:18:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xw162p0rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Feb 2020 22:18:37 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 011MIY0Y027747;
        Sat, 1 Feb 2020 22:18:34 GMT
Received: from dhcp-10-175-204-75.vpn.oracle.com (/10.175.204.75)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 01 Feb 2020 14:18:33 -0800
Date:   Sat, 1 Feb 2020 22:18:27 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-204-75.vpn.oracle.com
To:     Brendan Higgins <brendanhiggins@google.com>
cc:     shuah@kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, davidgow@google.com
Subject: Re: [PATCH v1] Documentation: kunit: fixed sphinx error in code
 block
In-Reply-To: <20200201000102.69272-1-brendanhiggins@google.com>
Message-ID: <alpine.LRH.2.20.2002012217470.16960@dhcp-10-175-204-75.vpn.oracle.com>
References: <20200201000102.69272-1-brendanhiggins@google.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9518 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002010164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9518 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002010164
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 31 Jan 2020, Brendan Higgins wrote:

> Fix a missing newline in a code block that was causing a warning:
> 
> Documentation/dev-tools/kunit/usage.rst:553: WARNING: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 3 supplied.
> 
> .. code-block:: bash
>         modprobe example-test
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for fixing!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  Documentation/dev-tools/kunit/usage.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 7cd56a1993b14..607758a66a99c 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -551,6 +551,7 @@ options to your ``.config``:
>  Once the kernel is built and installed, a simple
>  
>  .. code-block:: bash
> +
>  	modprobe example-test
>  
>  ...will run the tests.
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
> 
