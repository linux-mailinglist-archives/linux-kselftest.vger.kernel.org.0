Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09E9444860
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 19:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhKCSlB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 14:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhKCSlB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 14:41:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF347C061203
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Nov 2021 11:38:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u11so7081545lfs.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Nov 2021 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIihQMzapxTy6NnW0hBia9iOQ4EXccDghpYnj7BcWi8=;
        b=pW1A+zbrP8xGhx4zL5oEcVfO9xRPEJ3i0uCXWzYxazCLeyqvZzYS04cTJwrYIGgvVR
         j5czEZJ6ZrVDEcQvo49lWuWaqjA9nRKaU81zb4Wd9m1VZa0MZWAs3jyvPXSPYWyxsPMl
         jN5tM21t4P3VgHd+QgpQZ0EPQLZjf080n4HuzV56YdcS6zv1N+70i7ZaU9dKuvXJPYF0
         MbbWKzRUAZN2AgwxEJyImHYh203NeTVFG8lT5wgRf6c+BcUj+b26mxt/+VSdiTlFUVm0
         2zSXT/IyRGqpJRmGAHX8Wx/gGdeRpaPcUILpYueYPIK8Mf9Qg9YKKNmXDU9AFxdSDa10
         VUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIihQMzapxTy6NnW0hBia9iOQ4EXccDghpYnj7BcWi8=;
        b=erZH042+jXSZV9Zm6S3QEmuG2cU1DmSnRhfAPtVM3lq6+oSEi4f6Vcc/P/yX6LOgyW
         rzOGl4ehKY45Zyh2khozpFVfXhG1vqKj4ePkar277lS3bbSfW00cU3/3DsCL9MpB9TBe
         aB/fq/Vwv9foUC0UVJ/Ll82Tk1bfWLUMa/NyGa4+baua/WBe0GP025nbzrPlHPMvMaX9
         R/k30XgMXf+C48Bq8yDs232UxGQJA3ok4wMia6n1RivBkKivx2wdkqrzXH36njaXa/0X
         igvIyr3rOg1Nh9N+u3uYjwXvA4guQuhnbJtEtn0gzkU0HfKMr9yS3f9HdQ+2WecGTTYp
         OQ6w==
X-Gm-Message-State: AOAM531dJ0LqeMwGRykFaqrlXtcUDPkv1FssdQs77Yahai29USAn6GnV
        3YjZGGkBBI/ielkg+N58GkuY0nQeKDoMdjdHaOQzOA==
X-Google-Smtp-Source: ABdhPJx4awCVN9KREGMGULUP4DzoR6Q9mpfWPW9H5DiTLfcnS41Ndc6kmydLIaCepqati1bOe4ofzJ28eBUpEzyff58=
X-Received: by 2002:a05:6512:150e:: with SMTP id bq14mr43867108lfb.444.1635964701541;
 Wed, 03 Nov 2021 11:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211103094752.1263442-1-anders.roxell@linaro.org>
In-Reply-To: <20211103094752.1263442-1-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Nov 2021 11:38:09 -0700
Message-ID: <CAKwvOdkq9k7ceyvnDWNN6m-vYOx41a6BBZwHy_0eDRfx5B4KnQ@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: kselftest.h: mark functions with 'noreturn'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 3, 2021 at 2:47 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building kselftests/capabilities the following warning shows up:
>
> clang -O2 -g -std=gnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o test_execve
> test_execve.c:121:13: warning: variable 'have_outer_privilege' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>         } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> test_execve.c:136:9: note: uninitialized use occurs here
>         return have_outer_privilege;
>                ^~~~~~~~~~~~~~~~~~~~
> test_execve.c:121:9: note: remove the 'if' if its condition is always true
>         } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> test_execve.c:94:27: note: initialize the variable 'have_outer_privilege' to silence this warning
>         bool have_outer_privilege;
>                                  ^
>                                   = false
>
> Rework so all the ksft_exit_*() functions have attribue
> '__attribute__((noreturn))' so the compiler knows that there wont be
> any return from the function. That said, without
> '__attribute__((noreturn))' the compiler warns about the above issue
> since it thinks that it will get back from the ksft_exit_skip()
> function, which it wont.
> Cleaning up the callers that rely on ksft_exit_*() return code, since
> the functions ksft_exit_*() have never returned anything.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/clone3/clone3.c              |  4 +++-
>  .../testing/selftests/clone3/clone3_clear_sighand.c  |  2 +-
>  tools/testing/selftests/clone3/clone3_set_tid.c      |  4 +++-
>  tools/testing/selftests/ipc/msgque.c                 | 10 +++++-----
>  tools/testing/selftests/kcmp/kcmp_test.c             |  2 +-
>  tools/testing/selftests/kselftest.h                  | 12 ++++++------
>  .../membarrier/membarrier_test_multi_thread.c        |  2 +-
>  .../membarrier/membarrier_test_single_thread.c       |  2 +-
>  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c    |  2 +-
>  tools/testing/selftests/pidfd/pidfd_open_test.c      |  4 +++-
>  tools/testing/selftests/pidfd/pidfd_poll_test.c      |  2 +-
>  tools/testing/selftests/pidfd/pidfd_test.c           |  2 +-
>  tools/testing/selftests/resctrl/resctrl_tests.c      |  6 +++---
>  tools/testing/selftests/sync/sync_test.c             |  2 +-
>  tools/testing/selftests/timers/adjtick.c             |  4 ++--
>  tools/testing/selftests/timers/alarmtimer-suspend.c  |  4 ++--
>  tools/testing/selftests/timers/change_skew.c         |  4 ++--
>  tools/testing/selftests/timers/clocksource-switch.c  |  4 ++--
>  tools/testing/selftests/timers/freq-step.c           |  4 ++--
>  tools/testing/selftests/timers/inconsistency-check.c |  4 ++--
>  tools/testing/selftests/timers/leap-a-day.c          | 10 +++++-----
>  tools/testing/selftests/timers/leapcrash.c           |  4 ++--
>  tools/testing/selftests/timers/mqueue-lat.c          |  4 ++--
>  tools/testing/selftests/timers/nanosleep.c           |  4 ++--
>  tools/testing/selftests/timers/nsleep-lat.c          |  4 ++--
>  tools/testing/selftests/timers/posix_timers.c        | 12 ++++++------
>  tools/testing/selftests/timers/raw_skew.c            |  6 +++---
>  tools/testing/selftests/timers/set-2038.c            |  4 ++--
>  tools/testing/selftests/timers/set-tai.c             |  4 ++--
>  tools/testing/selftests/timers/set-timer-lat.c       |  4 ++--
>  tools/testing/selftests/timers/set-tz.c              |  4 ++--
>  tools/testing/selftests/timers/skew_consistency.c    |  4 ++--
>  tools/testing/selftests/timers/threadtest.c          |  2 +-
>  tools/testing/selftests/timers/valid-adjtimex.c      |  6 +++---
>  tools/testing/selftests/vm/madv_populate.c           |  2 +-
>  35 files changed, 80 insertions(+), 74 deletions(-)
>
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 42be3b925830..ede5da0c67b4 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -191,5 +191,7 @@ int main(int argc, char *argv[])
>         test_clone3(CLONE_NEWPID, getpagesize() + 8, -E2BIG,
>                         CLONE3_ARGS_NO_TEST);
>
> -       return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
> +       if (ksft_get_fail_cnt())
> +               ksft_exit_fail();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
> index 47a8c0fc3676..dcd9448eaeec 100644
> --- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
> +++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
> @@ -124,5 +124,5 @@ int main(int argc, char **argv)
>
>         test_clone3_clear_sighand();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> index 0229e9ebb995..a755fcd3af89 100644
> --- a/tools/testing/selftests/clone3/clone3_set_tid.c
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -393,5 +393,7 @@ int main(int argc, char *argv[])
>  out:
>         ret = 0;
>
> -       return !ret ? ksft_exit_pass() : ksft_exit_fail();
> +       if (ret)
> +               ksft_exit_fail();
> +       ksft_exit_pass();

This case is weird (pre-existing-ly) and looks broken.  The assignment
to ret should probably occur _before_ the out: label.  Honestly, I'd
remove the use of goto from this function and just call either
ksft_exit_pass() or ksft_exit_fail().  Rest of the patch looks good.
Thanks for sending. (I did not check that this is every case of
`return ksft_exit_{pass|fail};`).

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>  }
> diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
> index 656c43c24044..21dd6af76b21 100644
> --- a/tools/testing/selftests/ipc/msgque.c
> +++ b/tools/testing/selftests/ipc/msgque.c
> @@ -198,13 +198,13 @@ int main(int argc, char **argv)
>         struct msgque_data msgque;
>
>         if (getuid() != 0)
> -               return ksft_exit_skip(
> +               ksft_exit_skip(
>                                 "Please run the test as root - Exiting.\n");
>
>         msgque.key = ftok(argv[0], 822155650);
>         if (msgque.key == -1) {
>                 printf("Can't make key: %d\n", -errno);
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>         }
>
>         msgque.msq_id = msgget(msgque.key, IPC_CREAT | IPC_EXCL | 0666);
> @@ -243,13 +243,13 @@ int main(int argc, char **argv)
>                 printf("Failed to test queue: %d\n", err);
>                 goto err_out;
>         }
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>
>  err_destroy:
>         if (msgctl(msgque.msq_id, IPC_RMID, NULL)) {
>                 printf("Failed to destroy queue: %d\n", -errno);
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>         }
>  err_out:
> -       return ksft_exit_fail();
> +       ksft_exit_fail();
>  }
> diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
> index 6ea7b9f37a41..4e0776c044d1 100644
> --- a/tools/testing/selftests/kcmp/kcmp_test.c
> +++ b/tools/testing/selftests/kcmp/kcmp_test.c
> @@ -162,5 +162,5 @@ int main(int argc, char **argv)
>
>         waitpid(pid2, &status, P_ALL);
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 8d50483fe204..e47f634bf5c0 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -207,13 +207,13 @@ static inline void ksft_test_result_error(const char *msg, ...)
>         va_end(args);
>  }
>
> -static inline int ksft_exit_pass(void)
> +static inline void __attribute__((noreturn)) ksft_exit_pass(void)
>  {
>         ksft_print_cnts();
>         exit(KSFT_PASS);
>  }
>
> -static inline int ksft_exit_fail(void)
> +static inline void __attribute__((noreturn)) ksft_exit_fail(void)
>  {
>         ksft_print_cnts();
>         exit(KSFT_FAIL);
> @@ -231,7 +231,7 @@ static inline int ksft_exit_fail(void)
>                 ksft_exit_fail();       \
>         } while (0)
>
> -static inline int ksft_exit_fail_msg(const char *msg, ...)
> +static inline void __attribute__((noreturn)) ksft_exit_fail_msg(const char *msg, ...)
>  {
>         int saved_errno = errno;
>         va_list args;
> @@ -246,19 +246,19 @@ static inline int ksft_exit_fail_msg(const char *msg, ...)
>         exit(KSFT_FAIL);
>  }
>
> -static inline int ksft_exit_xfail(void)
> +static inline void __attribute__((noreturn)) ksft_exit_xfail(void)
>  {
>         ksft_print_cnts();
>         exit(KSFT_XFAIL);
>  }
>
> -static inline int ksft_exit_xpass(void)
> +static inline void __attribute__((noreturn)) ksft_exit_xpass(void)
>  {
>         ksft_print_cnts();
>         exit(KSFT_XPASS);
>  }
>
> -static inline int ksft_exit_skip(const char *msg, ...)
> +static inline void __attribute__((noreturn)) ksft_exit_skip(const char *msg, ...)
>  {
>         int saved_errno = errno;
>         va_list args;
> diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
> index ac5613e5b0eb..b055625e4eb5 100644
> --- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
> +++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
> @@ -69,5 +69,5 @@ int main(int argc, char **argv)
>         /* Multi-threaded */
>         test_mt_membarrier();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
> index c1c963902854..daec48e0b6f2 100644
> --- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
> +++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
> @@ -20,5 +20,5 @@ int main(int argc, char **argv)
>
>         test_membarrier_success();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> index 22558524f71c..d6c5cfd1c4c6 100644
> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> @@ -292,5 +292,5 @@ int main(int argc, char **argv)
>         test_pidfd_fdinfo_nspid();
>         test_pidfd_dead_fdinfo();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
> index 8a59438ccc78..c62564c264b1 100644
> --- a/tools/testing/selftests/pidfd/pidfd_open_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
> @@ -159,5 +159,7 @@ int main(int argc, char **argv)
>         if (pidfd >= 0)
>                 close(pidfd);
>
> -       return !ret ? ksft_exit_pass() : ksft_exit_fail();
> +       if (ret)
> +               ksft_exit_fail();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> index 610811275357..55d74a50358f 100644
> --- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> @@ -112,5 +112,5 @@ int main(int argc, char **argv)
>         }
>
>         ksft_test_result_pass("pidfd poll test: pass\n");
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index 529eb700ac26..4a4ab7e25796 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -569,5 +569,5 @@ int main(int argc, char **argv)
>         test_pidfd_send_signal_exited_fail();
>         test_pidfd_send_signal_recycled_pid_fail();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 973f09a66e1e..e1cf5a73571b 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -205,7 +205,7 @@ int main(int argc, char **argv)
>          * 2. We execute perf commands
>          */
>         if (geteuid() != 0)
> -               return ksft_exit_fail_msg("Not running as root, abort testing.\n");
> +               ksft_exit_fail_msg("Not running as root, abort testing.\n");
>
>         /* Detect AMD vendor */
>         detect_amd();
> @@ -235,7 +235,7 @@ int main(int argc, char **argv)
>         sprintf(bm_type, "fill_buf");
>
>         if (!check_resctrlfs_support())
> -               return ksft_exit_fail_msg("resctrl FS does not exist\n");
> +               ksft_exit_fail_msg("resctrl FS does not exist\n");
>
>         filter_dmesg();
>
> @@ -255,5 +255,5 @@ int main(int argc, char **argv)
>
>         umount_resctrlfs();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/sync/sync_test.c b/tools/testing/selftests/sync/sync_test.c
> index 414a617db993..aec7057696de 100644
> --- a/tools/testing/selftests/sync/sync_test.c
> +++ b/tools/testing/selftests/sync/sync_test.c
> @@ -110,5 +110,5 @@ int main(void)
>                                         err, ksft_test_num());
>
>         /* need this return to keep gcc happy */
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
> index 54d8d87f36b3..594c59497015 100644
> --- a/tools/testing/selftests/timers/adjtick.c
> +++ b/tools/testing/selftests/timers/adjtick.c
> @@ -205,7 +205,7 @@ int main(int argv, char **argc)
>         adjtimex(&tx1);
>
>         if (err)
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
> index 4da09dbf83ba..9ac0c098b20f 100644
> --- a/tools/testing/selftests/timers/alarmtimer-suspend.c
> +++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
> @@ -173,6 +173,6 @@ int main(void)
>                 timer_delete(tm1);
>         }
>         if (final_ret)
> -               return ksft_exit_fail();
> -       return ksft_exit_pass();
> +               ksft_exit_fail();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
> index c4eab7124990..89c97c8b8e91 100644
> --- a/tools/testing/selftests/timers/change_skew.c
> +++ b/tools/testing/selftests/timers/change_skew.c
> @@ -89,8 +89,8 @@ int main(int argv, char **argc)
>
>         if (ret) {
>                 printf("[FAIL]");
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>         }
>         printf("[OK]");
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
> index ef8eb3604595..ba4c7f66959b 100644
> --- a/tools/testing/selftests/timers/clocksource-switch.c
> +++ b/tools/testing/selftests/timers/clocksource-switch.c
> @@ -163,6 +163,6 @@ int main(int argv, char **argc)
>         change_clocksource(orig_clk);
>
>         if (status)
> -               return ksft_exit_fail();
> -       return ksft_exit_pass();
> +               ksft_exit_fail();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/freq-step.c b/tools/testing/selftests/timers/freq-step.c
> index 4b76450d78d1..73b636f89fdc 100644
> --- a/tools/testing/selftests/timers/freq-step.c
> +++ b/tools/testing/selftests/timers/freq-step.c
> @@ -257,7 +257,7 @@ int main(int argc, char **argv)
>         set_frequency(0.0);
>
>         if (fails)
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
> index 022d3ffe3fbf..71362be52dc8 100644
> --- a/tools/testing/selftests/timers/inconsistency-check.c
> +++ b/tools/testing/selftests/timers/inconsistency-check.c
> @@ -186,8 +186,8 @@ int main(int argc, char *argv[])
>                 if (!clock_gettime(clockid, &ts)) {
>                         printf("Consistent %-30s ", clockstring(clockid));
>                         if (consistency_test(clockid, runtime))
> -                               return ksft_exit_fail();
> +                               ksft_exit_fail();
>                 }
>         }
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/leap-a-day.c b/tools/testing/selftests/timers/leap-a-day.c
> index 23eb398c8140..986abbdb1521 100644
> --- a/tools/testing/selftests/timers/leap-a-day.c
> +++ b/tools/testing/selftests/timers/leap-a-day.c
> @@ -268,7 +268,7 @@ int main(int argc, char **argv)
>                 if (ret < 0) {
>                         printf("Error: Problem setting STA_INS/STA_DEL!: %s\n",
>                                                         time_state_str(ret));
> -                       return ksft_exit_fail();
> +                       ksft_exit_fail();
>                 }
>
>                 /* Validate STA_INS was set */
> @@ -277,7 +277,7 @@ int main(int argc, char **argv)
>                 if (tx.status != STA_INS && tx.status != STA_DEL) {
>                         printf("Error: STA_INS/STA_DEL not set!: %s\n",
>                                                         time_state_str(ret));
> -                       return ksft_exit_fail();
> +                       ksft_exit_fail();
>                 }
>
>                 if (tai_time) {
> @@ -295,7 +295,7 @@ int main(int argc, char **argv)
>                 se.sigev_value.sival_int = 0;
>                 if (timer_create(CLOCK_REALTIME, &se, &tm1) == -1) {
>                         printf("Error: timer_create failed\n");
> -                       return ksft_exit_fail();
> +                       ksft_exit_fail();
>                 }
>                 its1.it_value.tv_sec = next_leap;
>                 its1.it_value.tv_nsec = 0;
> @@ -366,7 +366,7 @@ int main(int argc, char **argv)
>                 if (error_found) {
>                         printf("Errors observed\n");
>                         clear_time_state();
> -                       return ksft_exit_fail();
> +                       ksft_exit_fail();
>                 }
>                 printf("\n");
>                 if ((iterations != -1) && !(--iterations))
> @@ -374,5 +374,5 @@ int main(int argc, char **argv)
>         }
>
>         clear_time_state();
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/leapcrash.c b/tools/testing/selftests/timers/leapcrash.c
> index f70802c5dd0d..8fd065eec904 100644
> --- a/tools/testing/selftests/timers/leapcrash.c
> +++ b/tools/testing/selftests/timers/leapcrash.c
> @@ -87,7 +87,7 @@ int main(void)
>                 tv.tv_usec = 0;
>                 if (settimeofday(&tv, NULL)) {
>                         printf("Error: You're likely not running with proper (ie: root) permissions\n");
> -                       return ksft_exit_fail();
> +                       ksft_exit_fail();
>                 }
>                 tx.modes = 0;
>                 adjtimex(&tx);
> @@ -104,5 +104,5 @@ int main(void)
>                 fflush(stdout);
>         }
>         printf("[OK]\n");
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/mqueue-lat.c b/tools/testing/selftests/timers/mqueue-lat.c
> index 7916cf5cc6ff..f3179a605bba 100644
> --- a/tools/testing/selftests/timers/mqueue-lat.c
> +++ b/tools/testing/selftests/timers/mqueue-lat.c
> @@ -107,8 +107,8 @@ int main(int argc, char **argv)
>         ret = mqueue_lat_test();
>         if (ret < 0) {
>                 printf("[FAILED]\n");
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>         }
>         printf("[OK]\n");
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
> index 71b5441c2fd9..40ff3d710d66 100644
> --- a/tools/testing/selftests/timers/nanosleep.c
> +++ b/tools/testing/selftests/timers/nanosleep.c
> @@ -153,7 +153,7 @@ int main(int argc, char **argv)
>                         }
>                         if (ret < 0) {
>                                 printf("[FAILED]\n");
> -                               return ksft_exit_fail();
> +                               ksft_exit_fail();
>                         }
>                         length *= 100;
>                 }
> @@ -161,5 +161,5 @@ int main(int argc, char **argv)
>  next:
>                 ret = 0;
>         }
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
> index eb3e79ed7b4a..4c201a06cb94 100644
> --- a/tools/testing/selftests/timers/nsleep-lat.c
> +++ b/tools/testing/selftests/timers/nsleep-lat.c
> @@ -172,9 +172,9 @@ int main(int argc, char **argv)
>                 }
>                 if (ret < 0) {
>                         printf("[FAILED]\n");
> -                       return ksft_exit_fail();
> +                       ksft_exit_fail();
>                 }
>                 printf("[OK]\n");
>         }
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
> index 0ba500056e63..337424c5c987 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -194,16 +194,16 @@ int main(int argc, char **argv)
>         printf("based timers if other threads run on the CPU...\n");
>
>         if (check_itimer(ITIMER_VIRTUAL) < 0)
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>
>         if (check_itimer(ITIMER_PROF) < 0)
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>
>         if (check_itimer(ITIMER_REAL) < 0)
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>
>         if (check_timer_create(CLOCK_THREAD_CPUTIME_ID) < 0)
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>
>         /*
>          * It's unfortunately hard to reliably test a timer expiration
> @@ -215,7 +215,7 @@ int main(int argc, char **argv)
>          * find a better solution.
>          */
>         if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
> index b41d8dd0c40c..b58639a7d19d 100644
> --- a/tools/testing/selftests/timers/raw_skew.c
> +++ b/tools/testing/selftests/timers/raw_skew.c
> @@ -138,11 +138,11 @@ int main(int argv, char **argc)
>                 if (tx1.offset || tx2.offset ||
>                     tx1.freq != tx2.freq || tx1.tick != tx2.tick) {
>                         printf("        [SKIP]\n");
> -                       return ksft_exit_skip("The clock was adjusted externally. Shutdown NTPd or other time sync daemons\n");
> +                       ksft_exit_skip("The clock was adjusted externally. Shutdown NTPd or other time sync daemons\n");
>                 }
>                 printf("        [FAILED]\n");
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>         }
>         printf("        [OK]\n");
> -       return  ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/set-2038.c b/tools/testing/selftests/timers/set-2038.c
> index 688cfd81b531..f7d978721b9e 100644
> --- a/tools/testing/selftests/timers/set-2038.c
> +++ b/tools/testing/selftests/timers/set-2038.c
> @@ -128,6 +128,6 @@ int main(int argc, char *argv[])
>         /* restore clock */
>         settime(start);
>         if (ret)
> -               return ksft_exit_fail();
> -       return ksft_exit_pass();
> +               ksft_exit_fail();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/set-tai.c b/tools/testing/selftests/timers/set-tai.c
> index 8c4179ee2ca2..5b67462efcd6 100644
> --- a/tools/testing/selftests/timers/set-tai.c
> +++ b/tools/testing/selftests/timers/set-tai.c
> @@ -61,9 +61,9 @@ int main(int argc, char **argv)
>                 ret = get_tai();
>                 if (ret != i) {
>                         printf("[FAILED] expected: %i got %i\n", i, ret);
> -                       return ksft_exit_fail();
> +                       ksft_exit_fail();
>                 }
>         }
>         printf("[OK]\n");
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
> index 50da45437daa..7ce240c89b21 100644
> --- a/tools/testing/selftests/timers/set-timer-lat.c
> +++ b/tools/testing/selftests/timers/set-timer-lat.c
> @@ -278,6 +278,6 @@ int main(void)
>                 ret |= do_timer_oneshot(clock_id, 0);
>         }
>         if (ret)
> -               return ksft_exit_fail();
> -       return ksft_exit_pass();
> +               ksft_exit_fail();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/set-tz.c b/tools/testing/selftests/timers/set-tz.c
> index 62bd33eb16f0..20daaf1782b7 100644
> --- a/tools/testing/selftests/timers/set-tz.c
> +++ b/tools/testing/selftests/timers/set-tz.c
> @@ -102,9 +102,9 @@ int main(int argc, char **argv)
>         printf("[OK]\n");
>
>         set_tz(min, dst);
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>
>  err:
>         set_tz(min, dst);
> -       return ksft_exit_fail();
> +       ksft_exit_fail();
>  }
> diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
> index 8066be9aff11..bfeaac8d870d 100644
> --- a/tools/testing/selftests/timers/skew_consistency.c
> +++ b/tools/testing/selftests/timers/skew_consistency.c
> @@ -70,8 +70,8 @@ int main(int argv, char **argc)
>
>         if (ret) {
>                 printf("[FAILED]\n");
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>         }
>         printf("[OK]\n");
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/selftests/timers/threadtest.c
> index 80aed4bf06fb..76b38e41d9c7 100644
> --- a/tools/testing/selftests/timers/threadtest.c
> +++ b/tools/testing/selftests/timers/threadtest.c
> @@ -189,5 +189,5 @@ int main(int argc, char **argv)
>         /* die */
>         if (ret)
>                 ksft_exit_fail();
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
> index 5397de708d3c..48804223eb4d 100644
> --- a/tools/testing/selftests/timers/valid-adjtimex.c
> +++ b/tools/testing/selftests/timers/valid-adjtimex.c
> @@ -321,10 +321,10 @@ int validate_set_offset(void)
>  int main(int argc, char **argv)
>  {
>         if (validate_freq())
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>
>         if (validate_set_offset())
> -               return ksft_exit_fail();
> +               ksft_exit_fail();
>
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/vm/madv_populate.c b/tools/testing/selftests/vm/madv_populate.c
> index 3ee0e8275600..5f2f8ad32248 100644
> --- a/tools/testing/selftests/vm/madv_populate.c
> +++ b/tools/testing/selftests/vm/madv_populate.c
> @@ -325,5 +325,5 @@ int main(int argc, char **argv)
>         if (err)
>                 ksft_exit_fail_msg("%d out of %d tests failed\n",
>                                    err, ksft_test_num());
> -       return ksft_exit_pass();
> +       ksft_exit_pass();
>  }
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
