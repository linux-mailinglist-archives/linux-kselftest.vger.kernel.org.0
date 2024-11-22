Return-Path: <linux-kselftest+bounces-22431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75149D59BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120A3B21F8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 07:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BAC1632D6;
	Fri, 22 Nov 2024 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BquzANcm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5F230999
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732259160; cv=none; b=pR8pi7CYufCkLptrqlSvJ6EuHKqS9GddDos1q4YEJerrAn57DWBblD2LFj2d0bcx1yPV0KEjLbRF7Ne7bcvrMrXpoMmHXH43PdqX+Z5wtwiqpf67KjJnGtq5CxIS6KNql7Fcz0sR1D3a3U3F9uX8l2zDDyWMtr/axDO2xYEQBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732259160; c=relaxed/simple;
	bh=ncTD9vSKW4TAKSe24YiS82pZJcOVBYzQ322IClGXnM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5+nr4pKhQ92nxrDivGkNG//u8x5lsSj3nOgvu4l/3Ef+QPxk44fYZ1xrZwae6CFg08vBgNQT4glYC2xvrFK4o4RzCj8QMqGKvOCHmSNxz4xhGEO4MzwP/s0vewTqjc1wb9r6vhr6zbXTTxWlxkQTQaRdSTnl/Yf2XYP/5eeeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BquzANcm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d41ec318eeso12581036d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 23:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732259157; x=1732863957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6NbGKamGZ7cVzMrSkSa+5XIC/cEb1ZcuwDOxi3VnJuk=;
        b=BquzANcmzt37EsNQvO7fCH3QGEuf+d7ZlsoA3p/rSgoFalVMMYNuT1oWQRPfp1Mrh0
         kHg+LnJlhx2UXikOrWgRTeTBk1O0DM0q7Nacw2AgOmoriM+Kku/f44AlKV+xBIoiHuh0
         e4tZqoPapZEfOsRU+m6J/P7S3ggxkYsX/qxxnqZ4QFx5nj/wToWt7dINOPMu9JVdfvTD
         9D2F5e80Lo6dHAfh5c9M2pFeoxj9PIFEH/TsVv5LG54t3kuuH13I2lUEhqMOKpBSEhdg
         ufLikcbKs1vFGvvVoy/tdhCr9nz2MbIVSXiydP8grNL7BTsDpNBGx2z09EMxQx9QyY4u
         NyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732259157; x=1732863957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NbGKamGZ7cVzMrSkSa+5XIC/cEb1ZcuwDOxi3VnJuk=;
        b=pdVLgWdehJbFNjQgVT6eg7kmnG29tHRaYj2wVMmUe7HorIHxO41HBJ2uWnyROz2V4Q
         KGSZke9FSTzOh8lE3iEuLefObse0e4PiLfWnT14gyjV/qE+O1r2gQl0/LZClQ50b65iR
         XXwp2k/psRS7YRRVRHeIJ+RYaJZTVMjrnmcVKICjPM6jpjnVFsbGbmfPGfVLT5xRzgCJ
         Cvhq1g/9ZYqxFcn137qxSNHzQRgjafrYuZt/AnOM8D5PvJrvmx7aQt92XoFdfzu+TTuj
         mpu8OZnb55oQKEE9xfhqkjH7/uO94yCi8umt2VaIYVoIQPAl8kysMcRyfOEu7h6PYkA3
         8DFg==
X-Forwarded-Encrypted: i=1; AJvYcCXkR3AfAPeTnHLUPMEM21zJ+oucFs3HqX/R5pfpDh5Lpf43x9nCdOs0vJSXTkRlOltmGi7MNb0zOlMAiHit3QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDbedaJtRH3+r04Fmc/zwoYjTh9iZycI4QD4j9Nf2bdNn1pJu
	c/e8N0kq2UwK7yh0CRrXFv7nyogkeZHq4JKf2sBWpGeIuA8yyZn0OQ3w+In1b8tfFtTCTEUbTPR
	lxy2tOpSrCI+d3H6udBQe00gQ+696daQerPsL
X-Gm-Gg: ASbGncurtRp5Cp9NBtrTSBippbWV83Vs45wq7TL4o4GXx2wR8BiCSgkT8DT9zCabFpS
	Auas37NQhD+/XZb5tY+1WPCeazonx2NAA
X-Google-Smtp-Source: AGHT+IGSCeisDsKQ2mEZXtLxJ/5EuwkI4hzHduYj5bfwfU4nZ0aBwkG76/uZlLsL43QUHkzh9MGKiloxzep6kTXpo/w=
X-Received: by 2002:ad4:5cce:0:b0:6d4:22be:9824 with SMTP id
 6a1803df08f44-6d450feb1eamr31931896d6.28.1732259156300; Thu, 21 Nov 2024
 23:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121145034.123367-1-john.ogness@linutronix.de>
In-Reply-To: <20241121145034.123367-1-john.ogness@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Fri, 22 Nov 2024 15:05:43 +0800
Message-ID: <CABVgOSmn6EqcRZ+Rc047OJ5SQ9xdThuaUaPx40UgWgN+AjBfMA@mail.gmail.com>
Subject: Re: [PATCH printk v1] printk: ringbuffer: Add KUnit test
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Brendan Higgins <brendanhiggins@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yoann Congal <yoann.congal@smile.fr>, 
	Alice Ryhl <aliceryhl@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Mark Rutland <mark.rutland@arm.com>, Jann Horn <jannh@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b8f14406277b0383"

--000000000000b8f14406277b0383
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Nov 2024 at 22:50, John Ogness <john.ogness@linutronix.de> wrote=
:
>
> From: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>
> The KUnit test validates the correct operation of the ringbuffer.
> A separate dedicated ringbuffer is used so that the global printk
> ringbuffer is not touched.
>
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> For those not familiar with KUnit, you can easily run this test
> doing something like this:
>
> $ ./tools/testing/kunit/kunit.py run \
>   --arch=3Dx86_64 \
>   --qemu_args "-enable-kvm -smp 8" \
>   --kunitconfig kernel/printk
>

Awesome -- I'm glad to see this make it as a KUnit test.

It's a little unusual for a KUnit test -- particularly since it is
time-based and uses lots of threads. This isn't a problem, but it's
definitely a good thing that it's marked as slow. Additionally, KUnit
doesn't track any extra threads spawned, so it requires a bit more
care.

There are a couple of issues (e.g., it crashes on non-SMP systems, a
potential race, etc) and some minor suggestions below. In short, it'd
be a good idea to move some of the initialisation and checks into the
main test function, rather than the helper threads. Equally, it looks
like there are a bunch of variables shared between kthreads =E2=80=94 do th=
ese
need to be checked with READ_ONCE()/WRITE_ONCE(), or made volatile, or
something?

In fact, I'm not sure why there's a separate start_test() and
test_readerwriter() function -- or indeed, a separate kthread? Am I
missing something, or could everything start_test() does be done from
the main test function/kthread?

Regardless, with a few of the tweaks below, this runs fine for me
here, and it's great to see it.

>  init/Kconfig                           |  12 +
>  kernel/printk/.kunitconfig             |   3 +
>  kernel/printk/Makefile                 |   2 +
>  kernel/printk/printk_ringbuffer.c      |   4 +
>  kernel/printk/printk_ringbuffer_test.c | 350 +++++++++++++++++++++++++
>  5 files changed, 371 insertions(+)
>  create mode 100644 kernel/printk/.kunitconfig
>  create mode 100644 kernel/printk/printk_ringbuffer_test.c
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 3b6ca7cce03b..46d144908191 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1576,6 +1576,18 @@ config PRINTK
>           very difficult to diagnose system problems, saying N here is
>           strongly discouraged.
>
> +config PRINTK_RINGBUFFER_TEST
> +       tristate "Test for the printk ringbuffer" if !KUNIT_ALL_TESTS
> +       depends on PRINTK && KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the printk ringbuffer KUnit test suite.
> +
> +         For more information on KUnit and unit tests in general, please=
 refer
> +         to the KUnit documentation.
> +
> +         If unsure, say N.
> +
>  config BUG
>         bool "BUG() support" if EXPERT
>         default y
> diff --git a/kernel/printk/.kunitconfig b/kernel/printk/.kunitconfig
> new file mode 100644
> index 000000000000..8d31a5c19053
> --- /dev/null
> +++ b/kernel/printk/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=3Dy
> +CONFIG_SMP=3Dy
> +CONFIG_PRINTK_RINGBUFFER_TEST=3Dy
> diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
> index 39a2b61c7232..edb5a4cacf67 100644
> --- a/kernel/printk/Makefile
> +++ b/kernel/printk/Makefile
> @@ -7,3 +7,5 @@ obj-$(CONFIG_PRINTK_INDEX)      +=3D index.o
>  obj-$(CONFIG_PRINTK)                 +=3D printk_support.o
>  printk_support-y                    :=3D printk_ringbuffer.o
>  printk_support-$(CONFIG_SYSCTL)             +=3D sysctl.o
> +
> +obj-$(CONFIG_PRINTK_RINGBUFFER_TEST) +=3D printk_ringbuffer_test.o
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_rin=
gbuffer.c
> index 88e8f3a61922..57b80d262cb7 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <kunit/visibility.h>
>  #include <linux/kernel.h>
>  #include <linux/irqflags.h>
>  #include <linux/string.h>
> @@ -1685,6 +1686,7 @@ bool prb_reserve(struct prb_reserved_entry *e, stru=
ct printk_ringbuffer *rb,
>         memset(r, 0, sizeof(*r));
>         return false;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(prb_reserve);
>
>  /* Commit the data (possibly finalizing it) and restore interrupts. */
>  static void _prb_commit(struct prb_reserved_entry *e, unsigned long stat=
e_val)
> @@ -1759,6 +1761,7 @@ void prb_commit(struct prb_reserved_entry *e)
>         if (head_id !=3D e->id)
>                 desc_make_final(e->rb, e->id);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(prb_commit);
>
>  /**
>   * prb_final_commit() - Commit and finalize (previously reserved) data t=
o
> @@ -2181,6 +2184,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u=
64 seq,
>  {
>         return _prb_read_valid(rb, &seq, r, NULL);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(prb_read_valid);
>
>  /**
>   * prb_read_valid_info() - Non-blocking read of meta data for a requeste=
d
> diff --git a/kernel/printk/printk_ringbuffer_test.c b/kernel/printk/print=
k_ringbuffer_test.c
> new file mode 100644
> index 000000000000..79331ea2b739
> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer_test.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/random.h>
> +#include <linux/sched/clock.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +
> +#include <kunit/test.h>
> +
> +#include "printk_ringbuffer.h"
> +
> +/*
> + * This KUnit tests the data integrity of the lockless printk_ringbuffer=
.
> + * From multiple CPUs it writes messages of varying length and content w=
hile
> + * a reader validates the correctness of the messages.
> + *
> + * IMPORTANT: The more CPUs you can use for this KUnit, the better!
> + *
> + * The test works by starting "num_online_cpus() - 1" writer threads, ea=
ch
> + * pinned to their own CPU. Each writer thread loops, writing data of va=
rying
> + * length into a printk_ringbuffer as fast as possible. The data content=
 is
> + * an embedded data struct followed by string content repeating the byte=
:
> + *
> + *      'A' + CPUID
> + *
> + * A reader thread is started on the remaining online CPU and ensures th=
at
> + * embedded struct content is consistent with the string and that the st=
ring
> + * is terminated and is composed of the same repeating byte as its first=
 byte.
> + *
> + * Because the threads are running in such tight loops, they will call
> + * schedule() from time to time so the system stays functional.
> + *
> + * If the reader encounters an error, the test is aborted and some
> + * information about the error is provided via printk. The runtime of
> + * the test can be configured with the runtime_ms module parameter.
> + *
> + * Note that the test is performed on a separate printk_ringbuffer insta=
nce
> + * and not the instance used by printk().
> + */
> +
> +static unsigned long runtime_ms =3D 10000;
> +module_param(runtime_ms, ulong, 0400);
> +
> +/* used by writers to signal reader of new records */
> +static DECLARE_WAIT_QUEUE_HEAD(test_wait);
> +
> +/* test data structure */
> +struct rbdata {
> +       unsigned int len;
> +       char text[] __counted_by(len);
> +};
> +
> +#define MAX_RBDATA_LEN (0x7f + 1)
> +#define MAX_RECORD_SIZE (sizeof(struct rbdata) + MAX_RBDATA_LEN + 1)
> +
> +static struct test_running {
> +       int runstate;
> +       unsigned long num;
> +       struct kunit *test;
> +} *test_running;
> +static int halt_test;
> +
> +static void fail_record(struct kunit *test, struct rbdata *dat, u64 seq)
> +{
> +       char buf[MAX_RBDATA_LEN + 1];
> +
> +       snprintf(buf, sizeof(buf), "%s", dat->text);
> +       buf[sizeof(buf) - 1] =3D 0;
> +
> +       KUNIT_FAIL(test, "BAD RECORD: seq=3D%llu len=3D%u text=3D%s\n",
> +                  seq, dat->len, dat->len < sizeof(buf) ? buf : "<invali=
d>");
> +}
> +
> +static bool check_data(struct rbdata *dat)
> +{
> +       unsigned int len;
> +
> +       len =3D strnlen(dat->text, MAX_RBDATA_LEN + 1);
> +
> +       /* Sane length? */
> +       if (len !=3D dat->len || !len || len > MAX_RBDATA_LEN)
> +               return false;
> +
> +       /* String repeats with the same character? */
> +       while (len) {
> +               len--;
> +               if (dat->text[len] !=3D dat->text[0])
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +/* Equivalent to CONFIG_LOG_BUF_SHIFT=3D13 */
> +DEFINE_PRINTKRB(test_rb, 8, 5);
> +
> +static int prbtest_writer(void *data)
> +{
> +       struct test_running *tr =3D data;
> +       char text_id =3D 'A' + tr->num;
> +       struct prb_reserved_entry e;
> +       unsigned long count =3D 0;
> +       struct printk_record r;
> +       u64 min_ns =3D (u64)-1;
> +       struct rbdata *dat;
> +       u64 total_ns =3D 0;
> +       u64 max_ns =3D 0;
> +       u64 post_ns;
> +       u64 pre_ns;
> +       int len;
> +
> +       set_cpus_allowed_ptr(current, cpumask_of(tr->num));
> +
> +       kunit_info(tr->test, "start thread %03lu (writer)\n", tr->num);
> +
> +       tr->runstate =3D 1;
> +
> +       for (;;) {
> +               /* +2 to ensure at least 1 character + terminator. */
> +               len =3D sizeof(struct rbdata) + (get_random_u32() & 0x7f)=
 + 2;
> +
> +               /* specify the text sizes for reservation */
> +               prb_rec_init_wr(&r, len);
> +
> +               pre_ns =3D local_clock();
> +
> +               if (prb_reserve(&e, &test_rb, &r)) {
> +                       r.info->text_len =3D len;
> +
> +                       len -=3D sizeof(struct rbdata) + 1;
> +
> +                       dat =3D (struct rbdata *)&r.text_buf[0];
> +                       dat->len =3D len;
> +                       memset(&dat->text[0], text_id, len);
> +                       dat->text[len] =3D 0;
> +
> +                       prb_commit(&e);
> +
> +                       post_ns =3D local_clock();
> +
> +                       wake_up_interruptible(&test_wait);
> +
> +                       post_ns -=3D pre_ns;
> +                       if (post_ns < min_ns)
> +                               min_ns =3D post_ns;
> +                       if (post_ns > max_ns)
> +                               max_ns =3D post_ns;
> +                       total_ns +=3D post_ns;
> +               }
> +
> +               if ((count++ & 0x3fff) =3D=3D 0)
> +                       schedule();
> +
> +               if (READ_ONCE(halt_test) =3D=3D 1)
> +                       break;
> +       }
> +
> +       kunit_info(tr->test, "end thread %03lu: wrote=3D%lu min_ns=3D%llu=
 avg_ns=3D%llu max_ns=3D%llu\n",
> +                  tr->num, count, min_ns, total_ns / (u64)count, max_ns)=
;
> +
> +       tr->runstate =3D 2;
> +
> +       return 0;
> +}
> +
> +static int prbtest_reader(void *data)
> +{
> +       struct test_running *tr =3D data;
> +       char text_buf[MAX_RECORD_SIZE];
> +       unsigned long total_lost =3D 0;
> +       unsigned long max_lost =3D 0;
> +       unsigned long count =3D 0;
> +       struct printk_info info;
> +       struct printk_record r;
> +       int did_sched =3D 1;
> +       u64 seq =3D 0;
> +
> +       set_cpus_allowed_ptr(current, cpumask_of(tr->num));
> +
> +       prb_rec_init_rd(&r, &info, &text_buf[0], sizeof(text_buf));
> +
> +       kunit_info(tr->test, "start thread %03lu (reader)\n", tr->num);
> +
> +       tr->runstate =3D 1;
> +
> +       while (!wait_event_interruptible(test_wait,
> +                               kthread_should_stop() ||
> +                               prb_read_valid(&test_rb, seq, &r))) {
> +               bool error =3D false;
> +
> +               if (kthread_should_stop())
> +                       break;
> +               /* check/track the sequence */
> +               if (info.seq < seq) {
> +                       KUNIT_FAIL(tr->test, "BAD SEQ READ: request=3D%ll=
u read=3D%llu\n",
> +                                  seq, info.seq);
> +                       error =3D true;
> +               } else if (info.seq !=3D seq && !did_sched) {
> +                       total_lost +=3D info.seq - seq;
> +                       if (max_lost < info.seq - seq)
> +                               max_lost =3D info.seq - seq;
> +               }
> +
> +               if (!check_data((struct rbdata *)&r.text_buf[0])) {
> +                       fail_record(tr->test, (struct rbdata *)&r.text_bu=
f[0], info.seq);
> +                       error =3D true;
> +               }
> +
> +               if (error)
> +                       WRITE_ONCE(halt_test, 1);
> +
> +               did_sched =3D 0;
> +               if ((count++ & 0x3fff) =3D=3D 0) {
> +                       did_sched =3D 1;
> +                       schedule();
> +               }
> +
> +               if (READ_ONCE(halt_test) =3D=3D 1)
> +                       break;
> +
> +               seq =3D info.seq + 1;
> +       }
> +
> +       kunit_info(tr->test,
> +                  "end thread %03lu: read=3D%lu seq=3D%llu total_lost=3D=
%lu max_lost=3D%lu\n",
> +                  tr->num, count, info.seq, total_lost, max_lost);
> +
> +       while (!kthread_should_stop())
> +               msleep(1000);
> +       tr->runstate =3D 2;
> +
> +       return 0;
> +}
> +
> +static int module_test_running;
> +static struct task_struct *reader_thread;
> +
> +static int start_test(void *arg)
> +{
> +       struct kunit *test =3D arg;
> +       struct task_struct *thread;
> +       unsigned long i;
> +       int num_cpus;
> +
> +       num_cpus =3D num_online_cpus();
> +       if (num_cpus =3D=3D 1)
> +               kunit_skip(test, "need >1 CPUs for at least one reader an=
d writer");

This check needs to be in the test_readerwriter() function to work
(or, at least, in the same kthread). Otherwise:
(a) KUnit doesn't know which thread to abort, and
(b) the other threads will continue anyway.

> +
> +       test_running =3D kcalloc(num_cpus, sizeof(*test_running), GFP_KER=
NEL);
> +       KUNIT_ASSERT_NOT_NULL(test, test_running);

Can we allocate this in the main test_readerwriter() function. I think
there can be a race otherwise. Equally, if we use something like
kunit_kcalloc() instead, KUnit will clean up the allocation for us
when the test exits (even if it fails).

> +
> +       module_test_running =3D 1;

Should this be WRITE_ONCE()?

> +
> +       kunit_info(test, "starting test\n");
> +
> +       for (i =3D 0; i < num_cpus; i++) {
> +               test_running[i].test =3D test;
> +               test_running[i].num =3D i;
> +               if (i < num_cpus - 1) {
> +                       thread =3D kthread_run(prbtest_writer, &test_runn=
ing[i],
> +                                            "prbtest writer");
> +               } else {
> +                       thread =3D kthread_run(prbtest_reader, &test_runn=
ing[i],
> +                                            "prbtest reader");
> +                       reader_thread =3D thread;
> +               }
> +               if (IS_ERR(thread)) {
> +                       kunit_err(test, "unable to create thread %lu\n", =
i);
> +                       test_running[i].runstate =3D 2;

Again, WRITE_ONCE()?

> +               }
> +       }
> +
> +       /* wait until all threads finish */
> +       for (;;) {
> +               msleep(1000);
> +
> +               for (i =3D 0; i < num_cpus; i++) {
> +                       if (test_running[i].runstate < 2)

Again, READ_ONCE()?

> +                               break;
> +               }
> +               if (i =3D=3D num_cpus)
> +                       break;
> +       }
> +
> +       kunit_info(test, "completed test\n");
> +
> +       module_test_running =3D 0;

This, too, _might_ need the WRITE_ONCE() treatment.

> +
> +       return 0;
> +}
> +
> +static void test_readerwriter(struct kunit *test)
> +{
> +       static bool already_run;
> +       int num_cpus;
> +       int i;
> +
> +       if (already_run)
> +               KUNIT_FAIL_AND_ABORT(test, "test can only be run once");
> +       already_run =3D true;

I'm not sure I fully understand why this couldn't be run multiple
times. I definitely see why you wouldn't want to have it running
concurrently with itself, but is there a way to have it 'reset' any
state to allow it to be re-run without a reboot.

Not a problem if it isn't, just curious. :-)

> +
> +       kunit_info(test, "running for %lu ms\n", runtime_ms);
> +
> +       kthread_run(start_test, test, "prbtest");
> +
> +       /* wait until all threads active */
> +       num_cpus =3D num_online_cpus();
> +       for (;;) {
> +               msleep(1000);
> +
> +               for (i =3D 0; i < num_cpus; i++) {
> +                       if (test_running[i].runstate =3D=3D 0)

I don't think there's any guarantee that test_running has been
allocated by this point.

Of course, given the msleep() above, it's very likely that it would
be, but it might make more sense to allocate it in this function
before spinning off any extra threads.

(As a bonus, you could then use kunit_kcalloc() to have it
automatically cleaned up when the test exits, regardless of whether or
not it succeeds.)

Also, you might want to check test_running[i].runstate using
READ_ONCE() or similar -- could a compiler perhaps "optimize out"
further reads to it as-is: it doesn't seem to be 'volatile' or
similar?

> +                               break;
> +               }
> +               if (i =3D=3D num_cpus)
> +                       break;
> +       }
> +
> +       msleep(runtime_ms);
> +
> +       if (reader_thread && !IS_ERR(reader_thread))
> +               kthread_stop(reader_thread);
> +
> +       WRITE_ONCE(halt_test, 1);
> +
> +       while (module_test_running)
> +               msleep(1000);

Again, should this be put under READ_ONCE() or an explicit atomic or
something? Or check that the thread has terminated?

> +       kfree(test_running);

If the kunit_kzalloc() function is used above, this could be removed.

> +}
> +
> +static struct kunit_case prb_test_cases[] =3D {
> +       KUNIT_CASE_SLOW(test_readerwriter),
> +       {}
> +};
> +
> +static struct kunit_suite prb_test_suite =3D {
> +       .name       =3D "printk-ringbuffer",
> +       .test_cases =3D prb_test_cases,
> +};
> +kunit_test_suite(prb_test_suite);
> +
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +MODULE_AUTHOR("John Ogness <john.ogness@linutronix.de>");
> +MODULE_DESCRIPTION("printk_ringbuffer test");
> +MODULE_LICENSE("GPL");
>
> base-commit: 4022ef25504db2fb79a2acac0afe9bac934f8dd6
> --
> 2.39.5
>

Cheers,
-- David

--000000000000b8f14406277b0383
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgKQv58/uSGKT6eKzlRivdGEG1U80p
G5n6TBK46tUSrBgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MTIyMDcwNTU3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAEDn2vAg3BUfDudGcZQeroNg+Q8pZTZV1q0aPnuvYqOWuX+f
Wk048AYIzNa8waUOeNnaoeeLtOBm0ZC7kvBtI/he74eSti/JwGSmmnRbPg3ywggBWTcCcAl+aTpR
npdMbpDjqwT08cef2598Szsxv4TITl7SvWjEHE+8MXd8AovyqeYjZ2q/7wM1faTsQqcxhqyGdODM
1siEOmPwZWs8C2CE1CEWKy6KMucRHwt4EloergNBrvR4igV+89BZtLkX01y5B1nvkBe2cL0K9LTN
5BpPa/HZAhWp8AHJM7TXjrnzADEwlcyPOY+Bsyj0ZEIZoE8g9J5Ha4ooJKM1/sa31sU=
--000000000000b8f14406277b0383--

