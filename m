Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E80EAACD
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 07:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfJaG70 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 02:59:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34034 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfJaG7Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 02:59:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V6x8ld159889;
        Thu, 31 Oct 2019 06:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Tqrlv1r2UZYa19Qdf8MZqwbo2ZzfW9M4NvVmYegpsRQ=;
 b=kdF7sWEwNrnMlgnQpPb4UJt3gMlNSrm0QM4YFVkBO0rd7yBtW2oHldKK14ZZJMMq2QY9
 Cj2z5kWe2ZW/OAL3ZkosL2uCMz/71JQDnNO9WvsfPiuzJcTeTinnpKo/TT6lsDDXGwoj
 WXHlGxAtbDyKZGlZ/b0kQFFYcYfqoxK8dQkwQeJ5o9rpUyOYJpcJnsf/IWkydU/BG01z
 ER0OStkT0Hz+JiiVWL0YPaV/zKIPTmGukluAd2s3G9j2LQhA3MfVYXe3YZxvwi4gEgxg
 ToKY4IqnzZwfTu2yIXlcirGQ4KG2CC35wvvx572XJO23qYu2PSPNASZNj/9QD99gSpc/ rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vxwhfs3wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 06:59:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V6vwlQ141255;
        Thu, 31 Oct 2019 06:59:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vysbtkyr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 06:59:15 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9V6xCx5021466;
        Thu, 31 Oct 2019 06:59:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 23:59:12 -0700
Date:   Thu, 31 Oct 2019 09:59:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     shuah <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <20191031065901.GC1705@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
 <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam>
 <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
 <20191030184600.GC18421@kadam>
 <2b3b48a8512d2c567fce388394ad1d262d31908e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3b48a8512d2c567fce388394ad1d262d31908e.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310069
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 12:15:30PM -0700, Joe Perches wrote:
> On Wed, 2019-10-30 at 21:46 +0300, Dan Carpenter wrote:
> > Hm...  I imagined the checkpatch code a little different in my head but
> > this would also work to make it stricter.  I doubt it miss very many
> > real life style problems.
> 
> Well, doubts vs reality...
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3607,7 +3607,7 @@ sub process {
> >  
> >  # if/while/etc brace do not go on next line, unless defining a do while loop,
> >  # or if that brace on the next line is for something else
> > -		if ($line =~ /(.*)\b((?:if|while|for|switch|(?:[a-z_]+|)for_each[a-z_]+)\s*\(|do\b|else\b)/ && $line !~ /^.\s*\#/) {
> > +		if ($line =~ /(.*)\b((?:if|while|for|switch|(?:list|hlist)_for_each[a-z_]+)\s*\(|do\b|else\b)/ && $line !~ /^.\s*\#/) {
> >  			my $pre_ctx = "$1$2";
> >  
> >  			my ($level, @ctx) = ctx_statement_level($linenr, $realcnt, 0);
> 
> So - nak
> 

What I mean is that only the people doing list_for_each and
hlist_for_each don't know how to do it right.  I just tested this over
night and my assumptions were correct.  Here are all the lines that
generate a warning:

+               hlist_for_each_entry_safe(tmp_fil, n, head, fnode)
+static void list_test_list_for_each_prev(struct kunit *test)
+static void list_test_list_for_each_safe(struct kunit *test)
+static void list_test_list_for_each_prev_safe(struct kunit *test)
+static void list_test_list_for_each_entry(struct kunit *test)
+static void list_test_list_for_each_entry_reverse(struct kunit *test)
+       hlist_for_each_entry_safe(x6spi, n,
+       list_for_each_entry(w, &card->widgets, list)

Only the first and last warnings are real style problems and my patch
catches both.

regards,
dan carpenter

