Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DA8E612
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2019 10:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHOISO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Aug 2019 04:18:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51558 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbfHOISN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Aug 2019 04:18:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8EUpI180838;
        Thu, 15 Aug 2019 08:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=HelmCFZbqj2rmdhjCFWAXjTPPw6e+Nfouk8FRPn/GBs=;
 b=FX49OUYITaQbV3OTdZIBcKa+07DGGdLiJMe/lSrakBGZaSci4pGq7+TJqok9VLlTLWtj
 9WOFw9Pbxt6tlJjZgmtheeWbGgRL1Cdmvwq6LIoIXWAmsOFak6UZ9BI1g2Ucpqfvt34/
 rqpehVfIpnfFfUdcVWnkQ2TaqN8Gwq/FZbfd1SRyo7wAj8QL0uPur/GaHgdHB2BiIGVe
 1kcUjFXD4UvjtlDwuQXPz0FyUU8vyruzdNAHZsb9RFslCJk+isd16Ez3ELIjdPujo9kM
 YPCC3EexUyAyXLw7z1oBJQmNV5Veu6ca7Kp9nb1Ar4pjQIGeAcpLnU7Pctw0d+7HZEN1 DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u9pjqse55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:18:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8I5dr006659;
        Thu, 15 Aug 2019 08:18:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ucpys4u71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:18:10 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7F8IAH3012048;
        Thu, 15 Aug 2019 08:18:10 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 01:18:09 -0700
Date:   Thu, 15 Aug 2019 11:18:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     andreyknvl@google.com
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] selftests, arm64: add a selftest for passing tagged
 pointers to kernel
Message-ID: <20190815081803.GA27238@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=897 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150087
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Andrey Konovalov,

The patch 9ce1263033cd: "selftests, arm64: add a selftest for passing
tagged pointers to kernel" from Jul 23, 2019, leads to the following
static checker warning:

	./tools/testing/selftests/arm64/tags_test.c:25 main()
	error: uninitialized symbol 'tagged_ptr'.

tools/testing/selftests/arm64/tags_test.c
    14  int main(void)
    15  {
    16          static int tbi_enabled = 0;
    17          struct utsname *ptr, *tagged_ptr;
                                      ^^^^^^^^^^

    18          int err;
    19  
    20          if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
    21                  tbi_enabled = 1;
    22          ptr = (struct utsname *)malloc(sizeof(*ptr));
    23          if (tbi_enabled)
    24                  tagged_ptr = (struct utsname *)SET_TAG(ptr, 0x42);
                ^^^^^^^^^^^^^^^
No else path.

    25          err = uname(tagged_ptr);
    26          free(ptr);
    27  
    28          return err;
    29  }

regards,
dan carpenter
