Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31718EA394
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfJ3SqU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 14:46:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfJ3SqU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 14:46:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UIi4DD192894;
        Wed, 30 Oct 2019 18:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=hm/o318mvjFeFtZF2DJgVJdJV0Epy7w7WoZkohXHDHo=;
 b=KIibVIxZs/TRmnJgreRCzeJPB4SbyHlOEvaqSrIHoaFvRYzRutJsM/4MA5cngnCI0spo
 k5LC5IhXLh7LOeT5/YCL7NcKQB3uG9krquvPhvccgyy5wyJEBxLW3GByyLtZQY0BF75n
 mJXratnQYnbt38TwmbBJR9LXf2x+zmqC/idTmRcKUZxXpcj2nJ91lOiJW1Hmmi3jYfSC
 CCJSWrsKgL6u82BgXG0p5rfzF8TRAQCQzYYfiUfTIwputonAZbQ/W8M+6ci+0n3ZW6O/
 np8i8Ynd6cyG9ugxzmh8TjvamVcb9UKxA0XExsTaTnAMeZe20FHJWNmDbRZPImraxwEe Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vxwhfp9f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 18:46:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UIeAT2143415;
        Wed, 30 Oct 2019 18:46:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vxwhwkttj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 18:46:12 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9UIkAkb007960;
        Wed, 30 Oct 2019 18:46:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 11:46:10 -0700
Date:   Wed, 30 Oct 2019 21:46:00 +0300
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
Message-ID: <20191030184600.GC18421@kadam>
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
 engine=8.0.1-1908290000 definitions=main-1910300160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300161
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 10:27:12AM -0600, shuah wrote:
> On 10/30/19 4:42 AM, Dan Carpenter wrote:
> > On Wed, Oct 30, 2019 at 01:02:11AM -0700, David Gow wrote:
> > > > ERROR: that open brace { should be on the previous line
> > > > #869: FILE: lib/list-test.c:680:
> > > > +static void list_test_list_for_each_entry_reverse(struct kunit *test)
> > > > +{
> > > > 
> > > > 
> > > > I am seeing these error and warns. As per our hallway conversation, the
> > > > "for_each*" in the test naming is tripping up checkpatch.pl
> > > > 
> > > > For now you can change the name a bit to not trip checkpatch and maybe
> > > > explore fixing checkpatch to differentiate between function names
> > > > with "for_each" in them vs. the actual for_each usages in the code.
> > > 
> > > Thanks, Shuah.
> > > 
> > > Yes, the problem here is that checkpatch.pl believes that anything
> > > with "for_each" in its name must be a loop, so expects that the open
> > > brace is placed on the same line as for a for loop.
> > > 
> > > Longer term, I think it'd be nicer, naming-wise, to fix or work around
> > > this issue in checkpatch.pl itself, as that'd allow the tests to
> > > continue to follow a naming pattern of "list_test_[x]", where [x] is
> > > the name of the function/macro being tested. Of course, short of
> > > trying to fit a whole C parser in checkpatch.pl, that's going to
> > > involve some compromises as well.
> > 
> > Just make it a black list of the 5 most common for_each macros.
> > 
> 
> How does black listing work in the context of checkpatch.pl?

Hm...  I imagined the checkpatch code a little different in my head but
this would also work to make it stricter.  I doubt it miss very many
real life style problems.

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a85d719df1f4..4f10e8c0d285 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3607,7 +3607,7 @@ sub process {
 
 # if/while/etc brace do not go on next line, unless defining a do while loop,
 # or if that brace on the next line is for something else
-		if ($line =~ /(.*)\b((?:if|while|for|switch|(?:[a-z_]+|)for_each[a-z_]+)\s*\(|do\b|else\b)/ && $line !~ /^.\s*\#/) {
+		if ($line =~ /(.*)\b((?:if|while|for|switch|(?:list|hlist)_for_each[a-z_]+)\s*\(|do\b|else\b)/ && $line !~ /^.\s*\#/) {
 			my $pre_ctx = "$1$2";
 
 			my ($level, @ctx) = ctx_statement_level($linenr, $realcnt, 0);
