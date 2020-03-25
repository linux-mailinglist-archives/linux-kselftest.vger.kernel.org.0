Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC4193343
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 23:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYWEJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 18:04:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37042 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgCYWEJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 18:04:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PM35m1109673;
        Wed, 25 Mar 2020 22:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=gaA4GEcqi9j2CQxBte6tshCMih51XWIGLpE+4um3dyI=;
 b=lO8+ptMyy3Hd+wTBQDCZqwarI3fgPTqvuHWVbdeNyohJt26hR4ulc9MUPu7IcDI8nSNp
 koJ2natxAHqFLij/14heAIuQW7bJwANaNv8B8kjVxDQWUbaqxg6JAl3V6jGKV0QEMCAP
 6DRDvi0LQbO2MEoTvAX4a+Dtv4DkkBGOR2T8IGvjtUIbIj8XFyApNr+Qu8ZS+JJXSwHj
 Q/87pahcU4dZ4nb5aVUeZSPd7NgQwaDOV+eGvztomrodhHSsmGCn5VMMEVtZWztBdI6z
 nRqL15OWqG5KdTCTTFt2rNfei+0hg+oMJeVqj43a+pl4Yak848lZX/CncG7sq8t/gBvD 0g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ywavmcc91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 22:04:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PM1p0a021401;
        Wed, 25 Mar 2020 22:04:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3006r7b4nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 22:04:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02PM40ll008484;
        Wed, 25 Mar 2020 22:04:00 GMT
Received: from dhcp-10-175-163-133.vpn.oracle.com (/10.175.163.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 15:03:59 -0700
Date:   Wed, 25 Mar 2020 22:03:52 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     shuah <shuah@kernel.org>
cc:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        frowand.list@gmail.com, gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 kunit-next 3/4] kunit: subtests should be indented 4
 spaces according to TAP
In-Reply-To: <dd82e9cb-6c88-58cf-933e-f2a644e09b15@kernel.org>
Message-ID: <alpine.LRH.2.21.2003252202360.25268@localhost>
References: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com> <1584110682-3837-4-git-send-email-alan.maguire@oracle.com> <dd82e9cb-6c88-58cf-933e-f2a644e09b15@kernel.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=4
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=4 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250168
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 25 Mar 2020, shuah wrote:

> On 3/13/20 8:44 AM, Alan Maguire wrote:
> > Introduce KUNIT_INDENT macro which corresponds to 4-space indentation,
> > and use it to modify indentation from tab to 4 spaces.
> > 
> > Suggested-by: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> > ---
> >   include/kunit/test.h                |  7 +++-
> >   lib/kunit/assert.c                  | 79
> >   +++++++++++++++++++------------------
> >   lib/kunit/test.c                    |  6 +--
> >   tools/testing/kunit/kunit_parser.py | 10 ++---
> >   4 files changed, 54 insertions(+), 48 deletions(-)
> > 
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index f7b2ed4c..d49cdb4 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -84,6 +84,10 @@ struct kunit_resource {
> >   /* Size of log associated with test. */
> >   #define KUNIT_LOG_SIZE	512
> >   
> > +/* TAP specifies subtest indentation of 4 spaces. */
> > +#define KUNIT_INDENT	"    "
> > +#define KUNIT_INDENT2	KUNIT_INDENT KUNIT_INDENT
> 
> Sorry for a late comment on this.
> 
> What's the reason to do it this way? Why wouldn't you define
> it as 8 spaces long string?
>

I could have I suppose; I thought it makes it a bit easier
to read as above (though it did generate a checkpatch
warning; I thought readability was more important in this   
case, but I can alter if needed).
 
> Also can you please make sure to run checkpatch --strict on the
> patches you send?
>

Sure! There were also some other line-too-long warnings
generated as a result of this patch, but when I fixed those
checkpatch complained about splitting strings across multiple
lines.  The only way out was to reduce the amount of information
in the log messages, which I didn't want to do.  In future I can
note checkpatch warnings that I couldn't find a way to fix in the
commit message if that would help?

Thanks for taking a look!

Alan
 
> thanks,
> -- Shuah
> 
> 
