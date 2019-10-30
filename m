Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF409EA3DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 20:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJ3TNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 15:13:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJ3TNP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 15:13:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UJ8aJe045614;
        Wed, 30 Oct 2019 19:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=AmBK7NEnrbyy8RUxagWe8vIdghjuSiFyAV9Cl/vciNQ=;
 b=jmQFYwo5iWZ23PiCeuwy3ZkbM0hkdaBTpNUVbdJdTqkuE97v+amI2mP4OY2Q+6T4zth1
 Vza1ArWgoW9ub61ItEVls5Pb5zgsg/OVUxOwNSjq/aLzkVYihD9HKFMLBMnJXaZiatJs
 rVT6l/yl/iEByo7/Wx7V9SZ/rUNb9ZA08mfLSAdugvnPH7NVY9v5xmgNXRh31Ifkf0tW
 SwfB9zKVhAhvtEl5NEQRPU7Q+ztJrCmrb0BzlsYV4mejEei/rkJqpFs7iSKe2dtGzTHY
 AxDkU4rvGM9loOLYs3vXqve6DX281pzCG6AzZPSpI463lYodKYa4vxdMxBTzwk8Jk41H gA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vxwhfpe8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 19:13:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UJ8bkk142361;
        Wed, 30 Oct 2019 19:13:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vxwj9vfd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 19:13:08 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9UJD6h4014380;
        Wed, 30 Oct 2019 19:13:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 12:13:06 -0700
Date:   Wed, 30 Oct 2019 22:12:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <20191030191255.GD18421@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
 <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam>
 <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300165
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 10:27:12AM -0600, shuah wrote:
> > It's better to ignore checkpatch and other scripts when they are wrong.
> > (unless the warning message inspires you to make the code more readable
> > for humans).
> > 
> 
> It gets confusing when to ignore and when not to. It takes work to
> figure out and it is subjective.
> 

In this case, it's not subjective because checkpatch is clearly not
working as intended.

I don't feel like "checkpatch clean" is a useful criteria for applying
patches.  If someone sends a patch and I can spot a bunch of checkpatch
issues with my bare eyeballs then I get slightly annoyed for wasting my
time.  But as a reviewer, I mostly care about my own judgement.  Can I
understand what the code is doing?  It is subjective, but I'm smarter
than a Perl script and I try to be kind to people.

The other things about warnings is that I always encourage people to
just ignore old warnings.  If you're running Smatch and you see a
warning in ancient code that means I saw it five years ago and didn't
fix it so it's a false positive.  Old warnings are always 100% false
positives.

regards,
dan carpenter
