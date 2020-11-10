Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C832ADEC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 19:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgKJSuc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 13:50:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35120 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJSuc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 13:50:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAIhtQS121445;
        Tue, 10 Nov 2020 18:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wC2jbd2NkDz1nAFghaaz9PjGpzDIDHVMI1YpVUVpkYY=;
 b=mDk3bgC77SfyTsIQJmoA4JjlK+ELV0wEf+2ALlkHf8NY161gdBZxGBHOYExrMjvufFeo
 OopSm1adJ8Aesyn8ejvl+87ql2LgllSnVHTXjmYP8GNn63AYB4x8fKdDOCYsHs5joHiX
 qzPixFaNPY9xtTFmDz8NCUvr1fD21rPU953PcFmPi5czUZAU0IP7f3ANi85nkvSEeDWT
 qM+f3rjlv72E5qJZ+3J+8G9hBM7Pdjzno6nUG4jR80eC3UZLzxRgLWqUFXLiCOGYgqbo
 QqwuiYoTzAHt8QkyZTOEOTKYKX1s2wTQlkhsEEgl4PGpJTU8kTKTuGf0EM4EseGZWe5n IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34nh3awgb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 18:49:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAIjCpC145314;
        Tue, 10 Nov 2020 18:49:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34p55p04dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 18:49:27 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AAInIFC014602;
        Tue, 10 Nov 2020 18:49:19 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 10:49:18 -0800
Date:   Tue, 10 Nov 2020 21:49:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
        Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org,
        joel@joelfernandes.org, rric@kernel.org, shuah@kernel.org,
        devel@driverdev.osuosl.org, minyard@acm.org, corbet@lwn.net,
        surenb@google.com, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, lenb@kernel.org, tkjos@android.com,
        arnd@arndb.de, bp@alien8.de,
        Shuah Khan <skhan@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net, mchehab@kernel.org,
        maco@android.com, christian@brauner.io, linux-edac@vger.kernel.org,
        tony.luck@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, arve@android.com,
        james.morse@arm.com, hridya@google.com, johannes@sipsolutions.net
Subject: Re: [PATCH v3 00/11] Introduce Simple atomic counters
Message-ID: <20201110184903.GG29398@kadam>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <20201009193746.GA1073957@hirez.programming.kicks-ass.net>
 <202010091255.246395A6@keescook>
 <20201010110920.GQ2628@hirez.programming.kicks-ass.net>
 <6e1dd408-653e-817e-b659-23649259a929@linuxfoundation.org>
 <20201014091720.GC2628@hirez.programming.kicks-ass.net>
 <202010141611.70B7A38@keescook>
 <20201016105313.GJ2611@hirez.programming.kicks-ass.net>
 <202010161541.6DD2D1E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010161541.6DD2D1E@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100129
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 16, 2020 at 03:51:25PM -0700, Kees Cook wrote:
> On Fri, Oct 16, 2020 at 12:53:13PM +0200, Peter Zijlstra wrote:
> > That's like saying: "I'm too lazy to track what I've looked at already".
> > You're basically proposing to graffiti "Kees was here -- 16/10/2020" all
> > over the kernel. Just so you can see where you still need to go.
> > 
> > It says the code was (assuming your audit was correct) good at that
> > date, but has no guarantees for any moment after that.
> 
> That kind of bit-rot marking is exactly what I would like to avoid: just
> putting a comment in is pointless. Making the expectations of the usage
> become _enforced_ is the goal. And having it enforced by the _compiler_
> is key. Just adding a meaningless attribute that a static checker
> will notice some time and hope people fix them doesn't scale either
> (just look at how many sparse warnings there are).

Most Sparse warnings are false positives.  People do actually fix the
ones which matter.

I think this patchset could be useful.  I'm working on a refcounting
check for Smatch.  I want to warn about when we forget to drop a
reference on an error path.  Right now I just assume that anything with
"error", "drop" or "->stats->" in the name is just a counter.

regards,
dan carpenter

