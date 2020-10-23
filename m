Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55042297209
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465556AbgJWPNV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 11:13:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14372 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S461735AbgJWPNU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 11:13:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09NF849Q174402;
        Fri, 23 Oct 2020 11:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=66H34WxHFjZ41e1XswNbb1laU7BuQLFc816MyowA0J8=;
 b=i2dKDoDh1RG1cUKqPZxkj7AL+aEG1rd+4NQxu2yiO7N/98/ceaJJ6ftMw+tFslQT4hP8
 eueKn67B75QUB5OW4XPhcT3kFJxNanJmYZ7RJrQ/o4q2IGk0o+yXwnu7mSJumGSxqL8g
 bJ/FBTlweAaWeSuuzJXqSAUhopF3tYr4cayyJVRKsKUyTXwQwYl0Np4vnlwrzsJ+Y9m1
 U2dD5ddcdpYnK5OaDMpgjb3rPmnwh9DaPnk4lewFGNEt6+0ZVLcIrFVpIEYny2pCw9cA
 KaIZ3zxTecGTsiHZrOatI1VvbOck+lOPPCR7r5JtWQq8TKDYlzsB4ToFrvGAC0Ofoab+ 6Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34byj04bn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 11:12:50 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NF6IiJ004681;
        Fri, 23 Oct 2020 15:12:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 347r883g4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 15:12:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09NFCkNW29098472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 15:12:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D44D11C058;
        Fri, 23 Oct 2020 15:12:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEDC811C052;
        Fri, 23 Oct 2020 15:12:45 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.85.144])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 23 Oct 2020 15:12:45 +0000 (GMT)
Date:   Fri, 23 Oct 2020 17:12:44 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: remove _do_fork() leftovers
Message-ID: <20201023151243.GA1537@oc3871087118.ibm.com>
References: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
 <20201023093523.65c495f8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023093523.65c495f8@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_07:2020-10-23,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230103
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 23, 2020 at 09:35:23AM -0400, Steven Rostedt wrote:
> On Fri, 23 Oct 2020 10:52:03 +0200
> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> > index acb17ce..0ddb948 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> > @@ -39,7 +39,7 @@ do_test() {
> >      disable_tracing
> >  
> >      echo do_execve* > set_ftrace_filter
> > -    echo *do_fork >> set_ftrace_filter
> > +    echo kernel_clone >> set_ftrace_filter
> >  
> >      echo $PID > set_ftrace_notrace_pid
> >      echo function > current_tracer
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> > index 9f0a968..71319b3 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> > @@ -39,7 +39,7 @@ do_test() {
> >      disable_tracing
> >  
> >      echo do_execve* > set_ftrace_filter
> > -    echo *do_fork >> set_ftrace_filter
> > +    echo kernel_clone >> set_ftrace_filter
> >  
> >      echo $PID > set_ftrace_pid
> >      echo function > current_tracer
> 
> The issue I have with this, is that I run these tests on older kernels too,
> and tests that use to work on older kernels should still work. In fact,
> this fails on the kernel I'm currently adding new changes to!
> 
> Perhaps we should have:
> 
> 	# older kernels have do_fork, but newer kernels have kernel_clone
> 	echo kernel_clone >> set_ftrace_filter || echo *do_fork >> set_ftrace_filter

Would you suggest to do the same with all occurences in
eea11285dab3 ("tracing: switch to kernel_clone()")?
Otherwise it does not really make sense to just fix couple
of tests out of dozens.

> The above still seems to work for me.
> 
> -- Steve
