Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF42B43E89D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 20:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJ1SuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhJ1SuR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 14:50:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEA1C061745
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 11:47:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x7so1827879pfh.7
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OVU9szkq61aNLb2lvzFxnap0kX1k7Tq4ULR6zE1UQeA=;
        b=JhzxYSWISXsDoknoTCT5nmTH4RRJulSB1Z9lahh/ZTXx4d4gioMrgqswO8/VYuE+GL
         uTMcpMs9GnlYYgE8fyW79aM/M3HNcJR6IINXi2Cr2HpJoNnLX2FgIGH8po0lCth0yQ2M
         DkaEnizVNx0xEvzdLz5QigtPDn2z/jCMKZQZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OVU9szkq61aNLb2lvzFxnap0kX1k7Tq4ULR6zE1UQeA=;
        b=WGFZtnaws1JFGbVeKI8TqmbemGQ0/SRxWp3nLIhZwkHDPUH786GXxcf0y8Nt75GQNS
         4GpNPuZbLRhXohcwwOivET6m3hXTGlngpNWVZzQ3773wC2poVkfZ3fqbWp0+lPjIQlTe
         1zkBnsrL34gf177V2+3W8dLrKOfjFRYgin4OXPDR4QWA5CSLguYOo23L9fljPD8iYDy8
         X5FOEzBc8vI7GGSbSHI4aMQNiFf445eoE6VNa3L/VUwCFR8kkuNLO12S/7RmVcRcl9P5
         0wXd7dDfoeJfMci6kpbOh6aqitZGPjeImFAYjFfwe/EX0Y7xOXFvUkLvy5vk+8eaD5nD
         EO+g==
X-Gm-Message-State: AOAM532/TWNMkpW5buY7lBmUboYssvTd1zRC2PbUCJkz+qofBfN4t2ih
        QbLQxkdo2OlhkNOQ+czrGX4bDA==
X-Google-Smtp-Source: ABdhPJzgpftfzQqh6cQkfQwpqB9kCGWUYUkdWrI6OS+lGu7a8shSi/eg1Ixn5ahdw0frC07JSH/3jQ==
X-Received: by 2002:aa7:8a0e:0:b0:47c:1116:3ce with SMTP id m14-20020aa78a0e000000b0047c111603cemr5964030pfa.76.1635446869394;
        Thu, 28 Oct 2021 11:47:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ls6sm144127pjb.53.2021.10.28.11.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:47:49 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:47:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: selftests: seccomp_bpf failure on 5.15
Message-ID: <202110281136.5CE65399A7@keescook>
References: <YXrN+Hnl9pSOsWlA@arighi-desktop>
 <202110280955.B18CB67@keescook>
 <878rydm56l.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rydm56l.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 28, 2021 at 12:26:26PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Thu, Oct 28, 2021 at 06:21:12PM +0200, Andrea Righi wrote:
> >> The following sub-tests are failing in seccomp_bpf selftest:
> >> 
> >> 18:56:54 DEBUG| [stdout] # selftests: seccomp: seccomp_bpf
> >> ...
> >> 18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.ptrace.kill_after ...
> >> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (0)
> >> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (2) == msg (1)
> >> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (2)
> >> 18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 12)
> >> 18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.ptrace.kill_after
> >> ...
> >> 18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.seccomp.kill_after ...
> >> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:1547:kill_after:Expected !ptrace_syscall (1) == IS_SECCOMP_EVENT(status) (0)
> >> 18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 0)
> >> 18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.seccomp.kill_after
> >> 18:56:57 DEBUG| [stdout] # not ok 80 TRACE_syscall.seccomp.kill_after
> >> ...
> >> 18:56:57 DEBUG| [stdout] # # FAILED: 85 / 87 tests passed.
> >> 18:56:57 DEBUG| [stdout] # # Totals: pass:85 fail:2 xfail:0 xpass:0 skip:0 error:0
> >> 18:56:57 DEBUG| [stdout] not ok 1 selftests: seccomp: seccomp_bpf # exit=1
> >> 
> >> I did some bisecting and found that the failures started to happen with:
> >> 
> >>  307d522f5eb8 ("signal/seccomp: Refactor seccomp signal and coredump generation")
> >> 
> >> Not sure if the test needs to be fixed after this commit, or if the
> >> commit is actually introducing an issue. I'll investigate more, unless
> >> someone knows already what's going on.
> >
> > Ah thanks for noticing; I will investigate...
> 
> 
> I just did a quick read through of the test and while
> I don't understand everything having a failure seems
> very weird.
> 
> I don't understand the comment:
> /* Tracer will redirect getpid to getppid, and we should die. */
> 
> As I think what happens is it the bpf programs loads the signal
> number.  Tests to see if the signal number if GETPPID and allows
> that system call and causes any other system call to be terminated.

The test suite runs a series of seccomp filter vs syscalls under tracing,
either with ptrace or with seccomp SECCOMP_RET_TRACE, to validate the
expected behavioral states. It seems that what's happened is that the
SIGSYS has suddenly become non-killing:

#  RUN           TRACE_syscall.ptrace.kill_after ...
# seccomp_bpf.c:1555:kill_after:Expected WSTOPSIG(status) & 0x80 (0) == 0x80 (128)
# seccomp_bpf.c:1556:kill_after:WSTOPSIG: 31
# kill_after: Test exited normally instead of by signal (code: 12)
#          FAIL  TRACE_syscall.ptrace.kill_after

i.e. the ptracer no longer sees a dead tracee, which would pass through
here:

                if (WIFSIGNALED(status) || WIFEXITED(status))
                        /* Child is dead. Time to go. */
                        return;

So the above saw a SIG_TRAP|SIGSYS rather than a killing SIGSYS. i.e.
instead of WIFSIGNALED(stauts) being true, it instead catches a
PTRACE_EVENT_STOP for SIGSYS, which should be impossible (the process
should be getting killed).

> Which being single threaded would seem to cause the kernel  to execute
> the changed code.
> 
> How there kernel at that point is having the process exit with anything
> except SIGSYS I am not immediately seeing.

I've run out of time at the moment to debug further, but I've appended
my changes to the test, and a brute-force change to kernel/seccomp.c to
restore original behavior (though I haven't tested if coredumping works
still). I'll return to this in a few hours...

> 
> The logic is the same as that for SECCOMP_RET_TRAP is there a test for
> that, that is also failing?
> 
> How do you run that test anyway?

cd tools/testing/selftests/seccomp
make seccomp_bpf
scp seccomp_bpf target:
ssh target ./seccomp_bpf


diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 4d8f44a17727..b6c8c8f8bd69 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1269,10 +1269,12 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 			syscall_rollback(current, current_pt_regs());
 			/* Trigger a coredump with SIGSYS */
 			force_sig_seccomp(this_syscall, data, true);
-		} else {
-			do_exit(SIGSYS);
+			do_group_exit(SIGSYS);
 		}
-		return -1; /* skip the syscall go directly to signal handling */
+		if (action == SECCOMP_RET_KILL_THREAD)
+			do_exit(SIGSYS);
+		else
+			do_group_exit(SIGSYS);
 	}
 
 	unreachable();
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 1d64891e6492..8f8c1df885d6 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1487,7 +1487,7 @@ TEST_F(precedence, log_is_fifth_in_any_order)
 #define PTRACE_EVENT_SECCOMP 7
 #endif
 
-#define IS_SECCOMP_EVENT(status) ((status >> 16) == PTRACE_EVENT_SECCOMP)
+#define PTRACE_EVENT_MASK(status) ((status) >> 16)
 bool tracer_running;
 void tracer_stop(int sig)
 {
@@ -1536,17 +1536,34 @@ void start_tracer(struct __test_metadata *_metadata, int fd, pid_t tracee,
 	/* Run until we're shut down. Must assert to stop execution. */
 	while (tracer_running) {
 		int status;
+		bool run_callback = true;
 
 		if (wait(&status) != tracee)
 			continue;
+
 		if (WIFSIGNALED(status) || WIFEXITED(status))
 			/* Child is dead. Time to go. */
 			return;
 
-		/* Check if this is a seccomp event. */
-		ASSERT_EQ(!ptrace_syscall, IS_SECCOMP_EVENT(status));
+		/* Check if we got an expected event. */
+		ASSERT_EQ(WIFCONTINUED(status), false);
+		ASSERT_EQ(WIFSTOPPED(status), true);
+		ASSERT_EQ(WSTOPSIG(status) & SIGTRAP, SIGTRAP) {
+			TH_LOG("WSTOPSIG: %d", WSTOPSIG(status));
+		}
+		if (ptrace_syscall) {
+			EXPECT_EQ(WSTOPSIG(status) & 0x80, 0x80) {
+				TH_LOG("WSTOPSIG: %d", WSTOPSIG(status));
+				run_callback = false;
+			};
+		} else {
+			EXPECT_EQ(PTRACE_EVENT_MASK(status), PTRACE_EVENT_SECCOMP) {
+				run_callback = false;
+			};
+		}
 
-		tracer_func(_metadata, tracee, status, args);
+		if (run_callback)
+			tracer_func(_metadata, tracee, status, args);
 
 		ret = ptrace(ptrace_syscall ? PTRACE_SYSCALL : PTRACE_CONT,
 			     tracee, NULL, 0);

-- 
Kees Cook
