Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706AC7B8E6E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 23:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbjJDVCb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 17:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjJDVCa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 17:02:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932F49E
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 14:02:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso4215a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Oct 2023 14:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696453345; x=1697058145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnJbnr2mWAiYCPIUcy1YmyxjoHY19D8RCl9VTGpb2+M=;
        b=UAc0EQhavfTg3SWmfDSk8OiV2SjQiewskS9/A8knMW1hEJEs0qgZqgOop5EWL+8grS
         ROgCCKlqkffbvcMsiz0IKPFXSp8FzU4eqECaGrPQQZabpDXlt6ewvL7hcPSxBZlJtmsE
         eoFSJh1FLOo56RpJgOn3vmf4NgZE52k+r77ZvNbMadON0VBpKS64x+x+NgM5hSruskiG
         S2oTN6jw0CI4qK3RtifJq4nygYlDUvBt7dq6NtzGCO6FfFkWnjMwUx8FGZdwD9aHsxh6
         onPKKQqIqKAawkW5a5Pqq7U9Z9ZTGbztW4K194jxMiNvkwabAkpU3yLBlkr1IKAKslPz
         14Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696453345; x=1697058145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnJbnr2mWAiYCPIUcy1YmyxjoHY19D8RCl9VTGpb2+M=;
        b=RcKQCpMwbA7hsV/j8iaXSi8Y9XVRvjsgqtY6ltCeQ0+Tct6aNatTSSzXmc/NQNZWRt
         XHSa1ryHx5crRH3sTyZoNr+fSLtf5oYkV6jNopGfF6yLYXR5prDHkl2DOl+A5LTS122c
         7r4UPxWV1A3S//hJIVYz2HMi8F+dXjdf6Mb3CcWPdSKrkE3xsT2nzbY3bSsN+zsWenfB
         K7F7QDNycCIK2sYsO5XKhK2I2CL0i2kCoQgFn/A76Un6KgV55X+uTzofBDL8cWevU8Nb
         l9unDab+NWEcsds5Y5djPDV19xHEMaWXdoxdD01+5bd7G5eqMLAEOvlrC7B4p68Vme5A
         BvXA==
X-Gm-Message-State: AOJu0YzufvFSTUBGfuH+Q+x61WF+mFQ3OK7is/LnRNVA0oTBY4fJwLnL
        b548NDET56p6PPOWbASfrxbh/QGntbMzuJNHSG1TBg==
X-Google-Smtp-Source: AGHT+IH71n7rGDnv5mpvrd8eflqHTYuG3mi6/ojAV/CNatKF2veQxqGYAvlW0I0ZRLay0SYnTQ+6nrxWaRbH9xtvcjE=
X-Received: by 2002:a50:c04a:0:b0:538:1d3b:172f with SMTP id
 u10-20020a50c04a000000b005381d3b172fmr5342edd.3.1696453344749; Wed, 04 Oct
 2023 14:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230908213148.3610108-1-rmoar@google.com> <CABVgOSnTGFgzje3QZfN69We+26oWrWKoJQQP_=zphSLk4PG1xA@mail.gmail.com>
In-Reply-To: <CABVgOSnTGFgzje3QZfN69We+26oWrWKoJQQP_=zphSLk4PG1xA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 4 Oct 2023 17:02:12 -0400
Message-ID: <CA+GJov55382oB_Cn3vqfLnqDsbDsbAFO7x6Z6cQPTn3ykiBHvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: add ability to run tests after boot using debugfs
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        sadiyakazi@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 5:06=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 9 Sept 2023 at 05:31, Rae Moar <rmoar@google.com> wrote:
> >
> > Add functionality to run built-in tests after boot by writing to a
> > debugfs file.
> >
> > Add a new debugfs file labeled "run" for each test suite to use for
> > this purpose.
> >
> > As an example, write to the file using the following:
> >
> > echo "any string" > /sys/kernel/debugfs/kunit/<testsuite>/run
> >
> > This will trigger the test suite to run and will print results to the
> > kernel log.
> >
> > Note that what you "write" to the debugfs file will not be saved.
> >
> > To guard against running tests concurrently with this feature, add a
> > mutex lock around running kunit. This supports the current practice of
> > not allowing tests to be run concurrently on the same kernel.
> >
> > This functionality may not work for all tests.
> >
> > This new functionality could be used to design a parameter
> > injection feature in the future.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> This is looking pretty good, but I have a few nitpicks below and one big =
issue.
>
> The big issue is that this doesn't seem to exclude test suites created
> with kunit_test_init_section_suite{,s}(). The init section versions of
> the suite declarations, by definition, won't work if run after the
> kernel has finished booting. At the moment, these macros just pass
> through to the normal versions (because we've not been able to run
> after boot until now), but we'll need to implement it (maybe as a
> separate linker section, maybe as an attribute, etc) now. I expect
> that the correct solution here would be to not create the 'run'
> debugfs file for these tests. But I could be convinced to have it
> exist, but to just say "this test cannot be run after boot" if you've
> got a good argument. In any case, grep 'test.h' for "NOTE TO KUNIT
> DEVS" and you'll see the details.
>
> My one other not-totally-related thought (and this extends to module
> loading, too, so is possibly more useful as a separate patch) is that
> we're continually incrementing the test number still. This doesn't
> matter if we read the results from debugfs though, and it may make
> more sense to have this continue to increment (and thus treat all of
> dmesg as one long KTAP document). We could always add a reset option
> to debugfs in a follow-up patch if we want. But that's not something
> I'd hold this up with.
>

Hello!

Sorry for the delay in this response. I was working on other items but
I have started working on the next version of this patch.

Thanks for bringing my attention to the init tests. I am currently
working on a draft to remove the run files for these tests. However,
if that does not work, I will resort to outputting the message you
detailed above: "this test cannot be run after boot".

I am currently fine with the test number incrementing. However, I
would also be fine to implement a reset to ensure all the re-run
results have the test number of 1.

> >
> > Changes since v1:
> > - Removed second patch as this problem has been fixed
> > - Added Documentation patch
> > - Made changes to work with new dynamically-extending log feature
> >
> > Note that these patches now rely on (and are rebased on) the patch seri=
es:
> > https://lore.kernel.org/all/20230828104111.2394344-1-rf@opensource.cirr=
us.com/
> >
> >  lib/kunit/debugfs.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
> >  lib/kunit/test.c    | 13 +++++++++
> >  2 files changed, 79 insertions(+)
> >
> > diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> > index 270d185737e6..8c0a970321ce 100644
> > --- a/lib/kunit/debugfs.c
> > +++ b/lib/kunit/debugfs.c
> > @@ -8,12 +8,14 @@
> >  #include <linux/module.h>
> >
> >  #include <kunit/test.h>
> > +#include <kunit/test-bug.h>
> >
> >  #include "string-stream.h"
> >  #include "debugfs.h"
> >
> >  #define KUNIT_DEBUGFS_ROOT             "kunit"
> >  #define KUNIT_DEBUGFS_RESULTS          "results"
> > +#define KUNIT_DEBUGFS_RUN              "run"
> >
> >  /*
> >   * Create a debugfs representation of test suites:
> > @@ -21,6 +23,8 @@
> >   * Path                                                Semantics
> >   * /sys/kernel/debug/kunit/<testsuite>/results Show results of last ru=
n for
> >   *                                             testsuite
> > + * /sys/kernel/debug/kunit/<testsuite>/run     Write to this file to t=
rigger
> > + *                                             testsuite to run
> >   *
> >   */
> >
> > @@ -99,6 +103,51 @@ static int debugfs_results_open(struct inode *inode=
, struct file *file)
> >         return single_open(file, debugfs_print_results, suite);
> >  }
> >
> > +/*
> > + * Print a usage message to the debugfs "run" file
> > + * (/sys/kernel/debug/kunit/<testsuite>/run) if opened.
> > + */
> > +static int debugfs_print_run(struct seq_file *seq, void *v)
> > +{
> > +       struct kunit_suite *suite =3D (struct kunit_suite *)seq->privat=
e;
> > +
> > +       seq_puts(seq, "Write to this file to trigger the test suite to =
run.\n");
> > +       seq_printf(seq, "usage: echo \"any string\" > /sys/kernel/debug=
fs/kunit/%s/run\n",
> > +                       suite->name);
> > +       return 0;
> > +}
> > +
> > +/*
> > + * The debugfs "run" file (/sys/kernel/debug/kunit/<testsuite>/run)
> > + * contains no information. Write to the file to trigger the test suit=
e
> > + * to run.
> > + */
> > +static int debugfs_run_open(struct inode *inode, struct file *file)
> > +{
> > +       struct kunit_suite *suite;
> > +
> > +       suite =3D (struct kunit_suite *)inode->i_private;
> > +
> > +       return single_open(file, debugfs_print_run, suite);
> > +}
> > +
> > +/*
> > + * Trigger a test suite to run by writing to the suite's "run" debugfs
> > + * file found at: /sys/kernel/debug/kunit/<testsuite>/run
> > + *
> > + * Note: what is written to this file will not be saved.
> > + */
> > +static ssize_t debugfs_run(struct file *file,
> > +               const char __user *buf, size_t count, loff_t *ppos)
> > +{
> > +       struct inode *f_inode =3D file->f_inode;
> > +       struct kunit_suite *suite =3D (struct kunit_suite *) f_inode->i=
_private;
> > +
> > +       __kunit_test_suites_init(&suite, 1);
> > +
> > +       return count;
> > +}
> > +
> >  static const struct file_operations debugfs_results_fops =3D {
> >         .open =3D debugfs_results_open,
> >         .read =3D seq_read,
> > @@ -106,10 +155,23 @@ static const struct file_operations debugfs_resul=
ts_fops =3D {
> >         .release =3D debugfs_release,
> >  };
> >
> > +static const struct file_operations debugfs_run_fops =3D {
> > +       .open =3D debugfs_run_open,
> > +       .read =3D seq_read,
> > +       .write =3D debugfs_run,
> > +       .llseek =3D seq_lseek,
> > +       .release =3D debugfs_release,
> > +};
> > +
> >  void kunit_debugfs_create_suite(struct kunit_suite *suite)
> >  {
> >         struct kunit_case *test_case;
> >
> > +       if (suite->log) {
> > +               /* Clear the suite log that's leftover from a previous =
run. */
> > +               string_stream_clear(suite->log);
> > +               return;
> > +       }
>
> Can we just move this to kunit_init_suite() in test.c. It doesn't feel
> quite debugfs-y enough, and the return here tripped me up for a little
> too long.
>
> Ideally, we'd then split up kunit_init_suite() into a one-time
> initialisation (which calls kunit_debugfs_create_suite()), and a reset
> function (which resets the state of the suite back to the beginning).
> We then only call init once, but reset on every execution.

I definitely think you are right here to move this into test.c. I will
try to put this into a reset function.

> >         /* Allocate logs before creating debugfs representation. */
> >         suite->log =3D alloc_string_stream(GFP_KERNEL);
> >         string_stream_set_append_newlines(suite->log, true);
> > @@ -124,6 +186,10 @@ void kunit_debugfs_create_suite(struct kunit_suite=
 *suite)
> >         debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
> >                             suite->debugfs,
> >                             suite, &debugfs_results_fops);
> > +
> > +       debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0644,
> > +                           suite->debugfs,
> > +                           suite, &debugfs_run_fops);
> >  }
> >
> >  void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 651cbda9f250..d376b886d72d 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/moduleparam.h>
> > +#include <linux/mutex.h>
> >  #include <linux/panic.h>
> >  #include <linux/sched/debug.h>
> >  #include <linux/sched.h>
> > @@ -22,6 +23,8 @@
> >  #include "string-stream.h"
> >  #include "try-catch-impl.h"
> >
> > +static struct mutex kunit_run_lock;
> > +
>
> Should we use DEFINE_MUTEX() here rather than initialising it at runtime?

I will try to implement this using DEFINE_MUTEX.



>
> >  /*
> >   * Hook to fail the current test and print an error message to the log=
.
> >   */
> > @@ -668,6 +671,11 @@ int __kunit_test_suites_init(struct kunit_suite * =
const * const suites, int num_
> >                 return 0;
> >         }
> >
> > +       /* Use mutex lock to guard against running tests concurrently. =
*/
> > +       if (mutex_lock_interruptible(&kunit_run_lock)) {
> > +               pr_err("kunit: test interrupted\n");
> > +               return -EINTR;
> > +       }
> >         static_branch_inc(&kunit_running);
> >
> >         for (i =3D 0; i < num_suites; i++) {
> > @@ -676,6 +684,7 @@ int __kunit_test_suites_init(struct kunit_suite * c=
onst * const suites, int num_
> >         }
> >
> >         static_branch_dec(&kunit_running);
> > +       mutex_unlock(&kunit_run_lock);
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
> > @@ -836,6 +845,10 @@ static int __init kunit_init(void)
> >         kunit_install_hooks();
> >
> >         kunit_debugfs_init();
> > +
> > +       /* Initialize lock to guard against running tests concurrently.=
 */
> > +       mutex_init(&kunit_run_lock);
> > +
>
> As I understand it, we can just use DEFINE_MUTEX() above.
>
>
> >  #ifdef CONFIG_MODULES
> >         return register_module_notifier(&kunit_mod_nb);
> >  #else
> >
> > base-commit: b754593274e04fc840482a658b29791bc8f8b933
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >
