Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA336443FFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 11:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhKCKbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 06:31:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231993AbhKCKbG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 06:31:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3AFHBN012737;
        Wed, 3 Nov 2021 10:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PB61rs0xcv2ngNqkbJK88LDgKUPemFOZsXULxkl5cYo=;
 b=ORzoFufkU1rWqBvfb7D8aItZgx/eVJ7VK/GJiW8wlsww/hgDTFNks/flW0QBr8vgx5W5
 E6exdmD7mFuIKoOOolDBrm62Q+RWlyrEIFNPGrNK5yFmSvD2ZOxcr/9QH3ONyR/g1WiN
 ACb12vFXTQJSPjzr46+E3sZzHmfMhQoRI83xVgm1ZNbcX72Y5y7mJwQjEZZBlePQvabG
 nXxOSAicYsdJ/7XhZmt5S+iRUmGJWCsuQASuPSgLI5ifR2C35lt4HhCAPlop+O+hTGV4
 kh5fBDBzEVsAl9sDV4HhQwd2N/pTLDXi9USVdJLziTpeCG/pab0XuexQ6tSVVUOB8p4c kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c3ju4pn7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 10:28:04 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A3AJOQl025747;
        Wed, 3 Nov 2021 10:28:03 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c3ju4pn6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 10:28:03 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A3AQw5V001046;
        Wed, 3 Nov 2021 10:28:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3c0wpa2e1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 10:28:00 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A3ARw6v3539662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Nov 2021 10:27:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E321311C050;
        Wed,  3 Nov 2021 10:27:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9418C11C05C;
        Wed,  3 Nov 2021 10:27:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.144.175])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  3 Nov 2021 10:27:56 +0000 (GMT)
Date:   Wed, 3 Nov 2021 12:27:54 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: kselftest.h: mark functions with 'noreturn'
Message-ID: <YYJkKjNwWycYfs8a@linux.ibm.com>
References: <20211029114312.1921603-1-anders.roxell@linaro.org>
 <834d18b6-4106-045f-0264-20e54edf47bc@linuxfoundation.org>
 <CAKwvOdk8D5=AxzSpqjvXJc4XXL8CA7O=WY-LW0mZb3eQRK_EWg@mail.gmail.com>
 <CADYN=9+iueC3rJ4=32OM9rOUDLLmvcKY-y_By4hwAj1+9gxRiQ@mail.gmail.com>
 <CADYN=9+e=qLGBN+qxmKObiOp0hTQ_sGHSusn+4YvAXuprGVp2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9+e=qLGBN+qxmKObiOp0hTQ_sGHSusn+4YvAXuprGVp2A@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZTknOKt1uRoKBIONki3_8T4uwEJiRra-
X-Proofpoint-GUID: iuTZILz1ZXN86IR1p2XYOx4Bdb-ZXZ39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030057
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 03, 2021 at 10:38:17AM +0100, Anders Roxell wrote:
> On Tue, 2 Nov 2021 at 23:04, Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > On Sat, 30 Oct 2021 at 00:08, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Oct 29, 2021 at 11:19 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> > > >
> > > > On 10/29/21 5:43 AM, Anders Roxell wrote:
> > > > > When building kselftests/capabilities the following warning shows up:
> > > > >
> > > > > clang -O2 -g -std=gnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o test_execve
> > > > > test_execve.c:121:13: warning: variable 'have_outer_privilege' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> > > > >          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
> > > > >                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > test_execve.c:136:9: note: uninitialized use occurs here
> > > > >          return have_outer_privilege;
> > > > >                 ^~~~~~~~~~~~~~~~~~~~
> > > > > test_execve.c:121:9: note: remove the 'if' if its condition is always true
> > > > >          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
> > > > >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > test_execve.c:94:27: note: initialize the variable 'have_outer_privilege' to silence this warning
> > > > >          bool have_outer_privilege;
> > > > >                                   ^
> > > > >                                    = false
> > > > >
> > > > > Rework so all the ksft_exit_*() functions have attribue
> > > > > '__attribute__((noreturn))' so the compiler knows that there wont be
> > > > > any return from the function. That said, without
> > > > > '__attribute__((noreturn))' the compiler warns about the above issue
> > > > > since it thinks that it will get back from the ksft_exit_skip()
> > > > > function, which it wont.
> > > > > Cleaning up the callers that rely on ksft_exit_*() return code, since
> > > > > the functions ksft_exit_*() have never returned anything.
> > > > >
> > > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > >
> > > > Lot of changes to fix this warning. Is this necessary? I would
> > > > like to explore if there is an easier and localized change that
> > > > can fix the problem.
> > >
> > > via `man 3 exit`:
> > > ```
> > > The  exit() function causes normal process termination ...
> > > ...
> > > RETURN VALUE
> > >        The exit() function does not return.
> > > ```
> > > so seeing `ksft_exit_pass`, `ksft_exit_fail`, `ksft_exit_fail_msg`,
> > > `ksft_exit_xfail`, `ksft_exit_xpass`, and `ksft_exit_skip` all
> > > unconditional call `exit` yet return an `int` looks wrong to me on
> > > first glance. So on that point this patch and its resulting diffstat
> > > LGTM.
> >
> > I'll respin the patch with these changes only.
> >
> > >
> > > That said, there are many changes that explicitly call `ksft_exit`
> > > with an expression; are those setting the correct exit code? Note that
> > > ksft_exit_pass is calling exit with KSFT_PASS which is 0.  So some of
> > > the negations don't look quite correct to me.  For example:
> > >
> > > -       return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
> > > +       ksft_exit(!ksft_get_fail_cnt());
> > >
> > > so if ksft_get_fail_cnt() returns 0, then we were calling
> > > ksft_exit_pass() which exited with 0. Now we'd be exiting with 1?
> >
> > oh, right, thank you for your review.
> > I will drop all the 'ksft_exit()' changes, they should be fixed and go
> > in as separete patches.
> 
> tools/testing/selftests/vm/memfd_secret.c has the
> 'ksft_exit(!ksft_get_fail_cnt())'
> statement and when I looked at it it when I did this patch it looked correct.
> However, when I look at it now I get a bit confused how ksft_exit() can be used
> with ksft_get_fail_cnt(). @Mike can you please clarify the
> 'ksft_exit(!ksft_get_fail_cnt())' instance in
> tools/testing/selftests/vm/memfd_secret.c.

ksft_exit() does not take the error code but rather a condition:

/**
 * ksft_exit() - Exit selftest based on truth of condition
 *
 * @condition: if true, exit self test with success, otherwise fail.
 */
#define ksft_exit(condition) do {	\
	if (!!(condition))		\
		ksft_exit_pass();	\
	else				\
		ksft_exit_fail();	\
	} while (0)

So

	!ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();

and

	ksft_exit(!ksft_get_fail_cnt())

are equivalent.

-- 
Sincerely yours,
Mike.
