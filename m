Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32761DC1C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 00:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgETWFY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 May 2020 18:05:24 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42680 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgETWFY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 May 2020 18:05:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbWq1-0003v3-Uh; Wed, 20 May 2020 16:05:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbWpz-0004Ll-GJ; Wed, 20 May 2020 16:05:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org
References: <202005200204.D07DF079@keescook>
Date:   Wed, 20 May 2020 17:01:34 -0500
In-Reply-To: <202005200204.D07DF079@keescook> (Kees Cook's message of "Wed, 20
        May 2020 02:05:56 -0700")
Message-ID: <87o8qigta9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbWpz-0004Ll-GJ;;;mid=<87o8qigta9.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+UszcqdoCLCsvg49JkI5pp8HuydAxM6HQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1490 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (0.8%), b_tie_ro: 10 (0.7%), parse: 1.95
        (0.1%), extract_message_metadata: 28 (1.9%), get_uri_detail_list: 8
        (0.6%), tests_pri_-1000: 8 (0.5%), tests_pri_-950: 1.77 (0.1%),
        tests_pri_-900: 1.48 (0.1%), tests_pri_-90: 227 (15.2%), check_bayes:
        208 (14.0%), b_tokenize: 21 (1.4%), b_tok_get_all: 13 (0.9%),
        b_comp_prob: 4.2 (0.3%), b_tok_touch_all: 165 (11.1%), b_finish: 1.00
        (0.1%), tests_pri_0: 1190 (79.9%), check_dkim_signature: 0.71 (0.0%),
        check_dkim_adsp: 2.1 (0.1%), poll_dns_idle: 0.45 (0.0%), tests_pri_10:
        2.1 (0.1%), tests_pri_500: 13 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] selftests/exec: Add binfmt_script regression test
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> While working on commit b5372fe5dc84 ("exec: load_script: Do not exec
> truncated interpreter path"), I wrote a series of test scripts to verify
> corner cases. However, soon after, commit 6eb3c3d0a52d ("exec: increase
> BINPRM_BUF_SIZE to 256") landed, resulting in the tests needing to be
> refactored for the larger BINPRM_BUF_SIZE, which got lost on my TODO
> list. During the recent exec refactoring work[1], the need for these tests
> resurfaced, so I've finished them up for addition to the kernel
> selftests.

I have to say there is something poetic about testing binfmt_script
with Parot.  Parot is what you get when you combined perl and python
isn't it?

I will apply this to my exec-next tree right after the patchset under
discussion.

Eric


> [1] https://lore.kernel.org/lkml/202005191144.E3112135@keescook/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/exec/Makefile      |   1 +
>  tools/testing/selftests/exec/binfmt_script | 171 +++++++++++++++++++++
>  2 files changed, 172 insertions(+)
>  create mode 100755 tools/testing/selftests/exec/binfmt_script
>
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index 33339e31e365..7f4527f897c4 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -3,6 +3,7 @@ CFLAGS = -Wall
>  CFLAGS += -Wno-nonnull
>  CFLAGS += -D_GNU_SOURCE
>  
> +TEST_PROGS := binfmt_script
>  TEST_GEN_PROGS := execveat
>  TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
>  # Makefile is a run-time dependency, since it's accessed by the execveat test
> diff --git a/tools/testing/selftests/exec/binfmt_script b/tools/testing/selftests/exec/binfmt_script
> new file mode 100755
> index 000000000000..05f94a741c7a
> --- /dev/null
> +++ b/tools/testing/selftests/exec/binfmt_script
> @@ -0,0 +1,171 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Test that truncation of bprm->buf doesn't cause unexpected execs paths, along
> +# with various other pathological cases.
> +import os, subprocess
> +
> +# Relevant commits
> +#
> +# b5372fe5dc84 ("exec: load_script: Do not exec truncated interpreter path")
> +# 6eb3c3d0a52d ("exec: increase BINPRM_BUF_SIZE to 256")
> +
> +# BINPRM_BUF_SIZE
> +SIZE=256
> +
> +NAME_MAX=int(subprocess.check_output(["getconf", "NAME_MAX", "."]))
> +
> +test_num=0
> +
> +code='''#!/usr/bin/perl
> +print "Executed interpreter! Args:\n";
> +print "0 : '$0'\n";
> +$counter = 1;
> +foreach my $a (@ARGV) {
> +    print "$counter : '$a'\n";
> +    $counter++;
> +}
> +'''
> +
> +##
> +# test - produce a binfmt_script hashbang line for testing
> +#
> +# @size:     bytes for bprm->buf line, including hashbang but not newline
> +# @good:     whether this script is expected to execute correctly
> +# @hashbang: the special 2 bytes for running binfmt_script
> +# @leading:  any leading whitespace before the executable path
> +# @root:     start of executable pathname
> +# @target:   end of executable pathname
> +# @arg:      bytes following the executable pathname
> +# @fill:     character to fill between @root and @target to reach @size bytes
> +# @newline:  character to use as newline, not counted towards @size
> +# ...
> +def test(name, size, good=True, leading="", root="./", target="/perl",
> +                     fill="A", arg="", newline="\n", hashbang="#!"):
> +    global test_num, tests, NAME_MAX
> +    test_num += 1
> +    if test_num > tests:
> +        raise ValueError("more binfmt_script tests than expected! (want %d, expected %d)"
> +                         % (test_num, tests))
> +
> +    middle = ""
> +    remaining = size - len(hashbang) - len(leading) - len(root) - len(target) - len(arg)
> +    # The middle of the pathname must not exceed NAME_MAX
> +    while remaining >= NAME_MAX:
> +        middle += fill * (NAME_MAX - 1)
> +        middle += '/'
> +        remaining -= NAME_MAX
> +    middle += fill * remaining
> +
> +    dirpath = root + middle
> +    binary = dirpath + target
> +    if len(target):
> +        os.makedirs(dirpath, mode=0o755, exist_ok=True)
> +        open(binary, "w").write(code)
> +        os.chmod(binary, 0o755)
> +
> +    buf=hashbang + leading + root + middle + target + arg + newline
> +    if len(newline) > 0:
> +        buf += 'echo this is not really perl\n'
> +
> +    script = "binfmt_script-%s" % (name)
> +    open(script, "w").write(buf)
> +    os.chmod(script, 0o755)
> +
> +    proc = subprocess.Popen(["./%s" % (script)], shell=True,
> +                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
> +    stdout = proc.communicate()[0]
> +
> +    if proc.returncode == 0 and b'Executed interpreter' in stdout:
> +        if good:
> +            print("ok %d - binfmt_script %s (successful good exec)"
> +                  % (test_num, name))
> +        else:
> +            print("not ok %d - binfmt_script %s succeeded when it should have failed"
> +                  % (test_num, name))
> +    else:
> +        if good:
> +            print("not ok %d - binfmt_script %s failed when it should have succeeded (rc:%d)"
> +                  % (test_num, name, proc.returncode))
> +        else:
> +            print("ok %d - binfmt_script %s (correctly failed bad exec)"
> +                  % (test_num, name))
> +
> +    # Clean up crazy binaries
> +    os.unlink(script)
> +    if len(target):
> +        elements = binary.split('/')
> +        os.unlink(binary)
> +        elements.pop()
> +        while len(elements) > 1:
> +            os.rmdir("/".join(elements))
> +            elements.pop()
> +
> +tests=27
> +print("TAP version 1.3")
> +print("1..%d" % (tests))
> +
> +### FAIL (8 tests)
> +
> +# Entire path is well past the BINFMT_BUF_SIZE.
> +test(name="too-big",        size=SIZE+80, good=False)
> +# Path is right at max size, making it impossible to tell if it was truncated.
> +test(name="exact",          size=SIZE,    good=False)
> +# Same as above, but with leading whitespace.
> +test(name="exact-space",    size=SIZE,    good=False, leading=" ")
> +# Huge buffer of only whitespace.
> +test(name="whitespace-too-big", size=SIZE+71, good=False, root="",
> +                                              fill=" ", target="")
> +# A good path, but it gets truncated due to leading whitespace.
> +test(name="truncated",      size=SIZE+17, good=False, leading=" " * 19)
> +# Entirely empty except for #!
> +test(name="empty",          size=2,       good=False, root="",
> +                                          fill="", target="", newline="")
> +# Within size, but entirely spaces
> +test(name="spaces",         size=SIZE-1,  good=False, root="", fill=" ",
> +                                          target="", newline="")
> +# Newline before binary.
> +test(name="newline-prefix", size=SIZE-1,  good=False, leading="\n",
> +                                          root="", fill=" ", target="")
> +
> +### ok (19 tests)
> +
> +# The original test case that was broken by commit:
> +# 8099b047ecc4 ("exec: load_script: don't blindly truncate shebang string")
> +test(name="test.pl",        size=439, leading=" ",
> +     root="./nix/store/bwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin",
> +     arg=" -I/nix/store/x6yyav38jgr924nkna62q3pkp0dgmzlx-perl5.28.1-File-Slurp-9999.25/lib/perl5/site_perl -I/nix/store/ha8v67sl8dac92r9z07vzr4gv1y9nwqz-perl5.28.1-Net-DBus-1.1.0/lib/perl5/site_perl -I/nix/store/dcrkvnjmwh69ljsvpbdjjdnqgwx90a9d-perl5.28.1-XML-Parser-2.44/lib/perl5/site_perl -I/nix/store/rmji88k2zz7h4zg97385bygcydrf2q8h-perl5.28.1-XML-Twig-3.52/lib/perl5/site_perl")
> +# One byte under size, leaving newline visible.
> +test(name="one-under",           size=SIZE-1)
> +# Two bytes under size, leaving newline visible.
> +test(name="two-under",           size=SIZE-2)
> +# Exact size, but trailing whitespace visible instead of newline
> +test(name="exact-trunc-whitespace", size=SIZE, arg=" ")
> +# Exact size, but trailing space and first arg char visible instead of newline.
> +test(name="exact-trunc-arg",     size=SIZE, arg=" f")
> +# One bute under, with confirmed non-truncated arg since newline now visible.
> +test(name="one-under-full-arg",  size=SIZE-1, arg=" f")
> +# Short read buffer by one byte.
> +test(name="one-under-no-nl",     size=SIZE-1, newline="")
> +# Short read buffer by half buffer size.
> +test(name="half-under-no-nl",    size=int(SIZE/2), newline="")
> +# One byte under with whitespace arg. leaving wenline visible.
> +test(name="one-under-trunc-arg", size=SIZE-1, arg=" ")
> +# One byte under with whitespace leading. leaving wenline visible.
> +test(name="one-under-leading",   size=SIZE-1, leading=" ")
> +# One byte under with whitespace leading and as arg. leaving newline visible.
> +test(name="one-under-leading-trunc-arg",  size=SIZE-1, leading=" ", arg=" ")
> +# Same as above, but with 2 bytes under
> +test(name="two-under-no-nl",     size=SIZE-2, newline="")
> +test(name="two-under-trunc-arg", size=SIZE-2, arg=" ")
> +test(name="two-under-leading",   size=SIZE-2, leading=" ")
> +test(name="two-under-leading-trunc-arg",   size=SIZE-2, leading=" ", arg=" ")
> +# Same as above, but with buffer half filled
> +test(name="two-under-no-nl",     size=int(SIZE/2), newline="")
> +test(name="two-under-trunc-arg", size=int(SIZE/2), arg=" ")
> +test(name="two-under-leading",   size=int(SIZE/2), leading=" ")
> +test(name="two-under-lead-trunc-arg", size=int(SIZE/2), leading=" ", arg=" ")
> +
> +if test_num != tests:
> +    raise ValueError("fewer binfmt_script tests than expected! (ran %d, expected %d"
> +                     % (test_num, tests))
> -- 
> 2.20.1
