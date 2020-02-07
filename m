Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC831553AF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2020 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgBGI17 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Feb 2020 03:27:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49014 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGI17 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Feb 2020 03:27:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0178IDSJ137173;
        Fri, 7 Feb 2020 08:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=GHoz6i2gcHQTCP4Oe+AQdOOv90jmCeDfUu4HZ4MgPeA=;
 b=z7InFkfFWwDFWb8CYiGvTP6xKIfU/Pcc8SJvn3bgEZ2+YndwVXVVyYBDYESJpEWqCPnS
 8Gm+UvC/twQ3JLuI4/Wc87/xhYTgKQXYDXtBcWWxjdAdyIFVJFKxUGC84ZJHef3kkp7u
 2APR+25XnKp2Z0JY2DEaUVFCM8z7uAMbYBqAzQT5BNa/iEzqe+D1pihCC73Z6HWiQ6e6
 yemxfUw0Py+wwzfl6IpvHwqWSV9MSeQAl0bY9K67pSSmfDDYYUtA0NA2sa/EnhOhsx9p
 mhprCVXh+RDEwnnw8Vc0LN4uPlHxuZXf8LxZ3P638/N43HMbL21Y1xXvPwx2miDFMi5e IA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=GHoz6i2gcHQTCP4Oe+AQdOOv90jmCeDfUu4HZ4MgPeA=;
 b=ggxHJGFGdK3Be/ptkM0gwetkJ4pXuFCs14vMiisY4LEDH9nYrOaTrDF6PAZGzr7Rr8S4
 YjIRnCPVnBYMvllJFu/GDLfBTOz9qHT2Sl9rTHD8Pork/gNp/oDfXJSFrKOG+n/e24PH
 X9koiEcsY5VjC7vJcfilpycrrGJo3jYJUikFxcdoAYhNP7XyodCfxSalmIgzy7GCOCtD
 lZ8440ZoZedXEaCIonFnmjIDDlyOlSvQmwKQesy7hKinrcz3NJbI2i3igTNeYQaxJzH2
 210pylmBv2WhOfkJFp6qtKBB9kggDRjNGOX4LmO8beqizg8LiRFm9vHVjQ4QAqRK8VMn UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xykbpeer2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 08:27:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0178KIH4004065;
        Fri, 7 Feb 2020 08:27:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y080f7tup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 08:27:23 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0178RLgi007292;
        Fri, 7 Feb 2020 08:27:21 GMT
Received: from dhcp-10-175-186-149.vpn.oracle.com (/10.175.186.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Feb 2020 00:27:20 -0800
Date:   Fri, 7 Feb 2020 08:27:13 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-186-149.vpn.oracle.com
To:     Masami Hiramatsu <mhiramat@kernel.org>
cc:     Alan Maguire <alan.maguire@oracle.com>, rostedt@goodmis.org,
        shuah@kernel.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, colin.king@canonical.com
Subject: Re: [PATCH 2/2] ftrace/selftest: absence of modules/programs should
 trigger unsupported errors
In-Reply-To: <20200207134316.54cfa16707e72e50cb320f8f@kernel.org>
Message-ID: <alpine.LRH.2.20.2002070818310.21581@dhcp-10-175-186-149.vpn.oracle.com>
References: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com> <1581001760-29831-3-git-send-email-alan.maguire@oracle.com> <20200207134316.54cfa16707e72e50cb320f8f@kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070064
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 7 Feb 2020, Masami Hiramatsu wrote:

> Hi Alan,
> 
> On Thu,  6 Feb 2020 15:09:20 +0000
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
> > In a number of cases, the ftrace tests check for the presence of
> > ftrace testing-related modules (ftrace-direct, trace-printk) and
> > programs (checkbashisms), returning exit_unresolved if these
> > are not found.  The problem is, exit_unresolved causes execution
> > of ftracetest to return an error, when really our tests are
> > failing due to not having the requisite kernel configuration/tools
> > present, which is I think more of an unsupported error condition.
> > With these fixed, we see no unresolved test cases and ftracetest
> > returns success ("ok" when run via kselftest).
> 
> If your problem is to pass the test even if you don't test the
> feature, please change the ftracetest itself instead of replacing
> unresolved with unsupported. Those notice different situation.
> 
> unresolved - Testcase can not find some tools or helper drivers
>              which are required for this testcase.
> 
> unsupported - Kernel does not have tested feature because of
>               the version or the configuration.
> 
> Obviously the unresolved is a test environment issue. No test-module
> doesn't mean no feature to be tested.
> Could you tell me the reason why you can't install those required
> tools and modules on the test environment?
> 

Sure! In my case, I'm testing a distro production kernel,
where I can't control the CONFIG variable settings.  In
this case, ideally I'd like the tests to return success
if no problems with ftrace were detected, even if some
of the tests could not be run due to missing modules
and programs.  As you suggest above (unless I'm
misunderstanding), this could be accomplished by modifying
ftracetest itself.  Would doing something like what is done
for UNSUPPORTED_RESULT (defaults to 0, but can be set to
1 via --fail-unsupported, such that ftracetest returns
1 if we encounter unsupported results) make sense for
the unresolved case too?

Thanks!

Alan

> Thank you,
> 
> 
> 
> > 
> > Fixes: 646f01ccdd59 ("ftrace/selftest: Add tests to test register_ftrace_direct()")
> > Fixes: 4d23e9b4fd2e ("selftests/ftrace: Add trace_printk sample module test")
> > Fixes: 7bc026d6c032 ("selftests/ftrace: Add function filter on module testcase")
> > Fixes: ff431b1390cb ("selftests/ftrace: Add a test to probe module functions")
> > Fixes: 4a075bd4e13f ("selftests/ftrace: Add checkbashisms meta-testcase")
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 2 +-
> >  tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 2 +-
> >  tools/testing/selftests/ftrace/test.d/event/trace_printk.tc    | 2 +-
> >  tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc | 2 +-
> >  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc  | 2 +-
> >  tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc     | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > index d75a869..3d6189e 100644
> > --- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > @@ -5,7 +5,7 @@
> >  rmmod ftrace-direct ||:
> >  if ! modprobe ftrace-direct ; then
> >    echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >  
> >  echo "Let the module run a little"
> > diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> > index 801ecb6..3d0e3ca 100644
> > --- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> > @@ -5,7 +5,7 @@
> >  rmmod ftrace-direct ||:
> >  if ! modprobe ftrace-direct ; then
> >    echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >  
> >  if [ ! -f kprobe_events ]; then
> > diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > index b02550b..dd8b10d 100644
> > --- a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > @@ -5,7 +5,7 @@
> >  rmmod trace-printk ||:
> >  if ! modprobe trace-printk ; then
> >    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >  
> >  echo "Waiting for irq work"
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> > index 9330c87..fc22ac0 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> > @@ -13,7 +13,7 @@ echo '*:mod:trace_printk' > set_ftrace_filter
> >  if ! modprobe trace-printk ; then
> >    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
> >  m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >  
> >  : "Wildcard should be resolved after loading module"
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > index d861bd7..4e07c69 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > @@ -8,7 +8,7 @@ rmmod trace-printk ||:
> >  if ! modprobe trace-printk ; then
> >    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
> >  m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >  
> >  MOD=trace_printk
> > diff --git a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
> > index 1b081e9..1b339bd 100644
> > --- a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
> > @@ -9,7 +9,7 @@ fi
> >  
> >  if ! which checkbashisms > /dev/null 2>&1 ; then
> >    echo "No checkbashisms found. skipped."
> > -  exit_unresolved
> > +  exit_unsupported
> >  fi
> >  
> >  checkbashisms $FTRACETEST_ROOT/ftracetest
> > -- 
> > 1.8.3.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 
