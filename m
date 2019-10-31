Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADDBEAD52
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 11:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfJaKWe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 06:22:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60534 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaKWe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 06:22:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VAMPx8165363;
        Thu, 31 Oct 2019 10:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=AIPRTbz1vKYMEJ2syx60gILwl+AYqYSi+XaONiaS/s8=;
 b=Ycggx2U85q5A81uE3ok4s9kutMZ3oZVrWzG6uHq3Uze8EjiUrKMTrc35pZjPvADumEfr
 qL8Fd4EckoPseP1QI21Ow88avnq4v/R/lj8Z4vcuU72YwlEHos1K63IjeJbWJ8UxI0IL
 dIMRFqhg5w6R6s1SEf1UDt99W6rxM07dWoY0C0AZoLSsFLTAdJrAmhezlWGfHQB6nJjb
 OU1BNooxcW4G4/SkNlJEajIRwEaljEMCSVPO3qdxuU57ABDXYw5Hph8kU+KutbpJz3Px
 JFE5uBJtaXlPweLc4USCYk+aj3vTxwNqFdYjhxz2nlksbIn2I5Vy+BV9oKy3KpnxJC3N 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vxwhft77x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:22:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VAJRUU151087;
        Thu, 31 Oct 2019 10:20:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vyqpdtyht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:20:23 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9VAKLJw022953;
        Thu, 31 Oct 2019 10:20:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 03:20:21 -0700
Date:   Thu, 31 Oct 2019 13:20:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Joe Perches <joe@perches.com>, shuah <shuah@kernel.org>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <20191031102010.GF18421@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
 <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam>
 <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
 <CAFd5g47OZ8x9=etJUj4Sgsw38VQb0j=omOUsubc7+pb2rJi0bQ@mail.gmail.com>
 <fad58e4f48237894de0d511adf1d663a42a2eee7.camel@perches.com>
 <20191031085129.GA217570@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031085129.GA217570@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=882
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=964 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310105
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 31, 2019 at 01:51:29AM -0700, Brendan Higgins wrote:
> static void list_test_list_for_each_prev(struct kunit *test) /* checkpatch: disable=for-each-format */

These comments defeat the purpose of checkpatch which is to make the
code cleaner.

regards,
dan carpenter

