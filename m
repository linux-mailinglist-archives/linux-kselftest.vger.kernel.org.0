Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A270E57A74
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2019 06:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfF0EIY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jun 2019 00:08:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41739 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfF0EIY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jun 2019 00:08:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so734924wrm.8
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2019 21:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peYrxHEjDyab54KKexkbjmIh5vv0AqxnEkYF1zQ41/0=;
        b=BpY0n3g7OCtKVTyCkELlz7i/FrshCPUMslUpgW0lb8ekxnEXA4BSzgMbmWKF1NUQTI
         jJj5V7v0m8kA2DWAARDLGE3vckNQ+tJGdI8V+tSDMnEXkBmFw4ttG3VOMrwrkiiuYWYP
         79yxurg3Ha9jaM9hueT207iXBaPs2Heqc5x+oNvdV0+0KsaO49EAcx7EXK7DZ6/jcvVT
         jhHAH0WOymRIBeD9BdUknQ7spWDkW8bi44E3WoVtbrA+RqhLNRWPEgt9PRa90IoXoQrW
         JQixu9ArqgQfXYU8KaOrBR8PpKWcdTjs11DCxn9p2a4UYFLd1HpNB8lG03iloBc4NxvB
         rpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peYrxHEjDyab54KKexkbjmIh5vv0AqxnEkYF1zQ41/0=;
        b=inl0uy48XqcUkZnjZMHS8bQUePSOfH1acWpPKkEqwvfWJzsYbFlxXHeGzetXm077+n
         yVt61SkeM3D1JIQ9j1XI/C2pw8MUSUYFaxuIctYXL7u52WA+I2g/alGgLP50q1Vb+Rhj
         ubzrGb4owxwujGRhXUg9qaF8zJuN3Fcrt9K/SgpcvsPIb79TqQHUpnQlDnDMsom+wShc
         pkOJPUvaDFkxNWAhqHVMMVcpx2fkuC1FtyfXXfdm+wL1fCzvFJ4OWATydtO1g4QSYHfh
         AuQs5WXocyBFE8dcwhXtt6fYeezRbF1OUuH64hlWDRVTsL7cAAZdfZFTuo3ivhuYajKC
         2I1g==
X-Gm-Message-State: APjAAAVygPL4Lo0yxd81U5rAa07nfOGAh/9FkzDhpcS+xa8jRVPnIr4W
        b6crUJTyu63uXG4MphhY7HANq/I1Yzk8PB1gpExq
X-Google-Smtp-Source: APXvYqzJRzBUHyzbzCLyMW34lNC+PYJ6zOTaHEF91KW5X6rjaLo6CvfDngyrQpgoh96qd+IgLTc/PgkKeNkuHHkd+DI=
X-Received: by 2002:adf:f649:: with SMTP id x9mr950139wrp.86.1561608499699;
 Wed, 26 Jun 2019 21:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-18-brendanhiggins@google.com> <20190626021744.GU19023@42.do-not-panic.com>
In-Reply-To: <20190626021744.GU19023@42.do-not-panic.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 26 Jun 2019 21:07:43 -0700
Message-ID: <CAAXuY3p+kVhjQ4LYtzormqVcH2vKu1abc_K9Z0XY=JX=bp8NcQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/18] kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, Kees Cook <keescook@google.com>,
        kieran.bingham@ideasonboard.com, peterz@infradead.org,
        robh@kernel.org, Stephen Boyd <sboyd@kernel.org>, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        Daniel Vetter <daniel@ffwll.ch>, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        David Rientjes <rientjes@google.com>, rostedt@goodmis.org,
        wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 25, 2019 at 7:17 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:26:12AM -0700, Brendan Higgins wrote:
> > From: Iurii Zaikin <yzaikin@google.com>
> >
> > KUnit tests for initialized data behavior of proc_dointvec that is
> > explicitly checked in the code. Includes basic parsing tests including
> > int min/max overflow.
>
> First, thanks for this work! My review below.
> >
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> > Changes Since Last Revision:
> >  - Iurii did some clean up (thanks Iurii!) as suggested by Stephen Boyd.
> > ---
> >  kernel/Makefile      |   2 +
> >  kernel/sysctl-test.c | 242 +++++++++++++++++++++++++++++++++++++++++++
> >  lib/Kconfig.debug    |  10 ++
> >  3 files changed, 254 insertions(+)
> >  create mode 100644 kernel/sysctl-test.c
> >
> > diff --git a/kernel/Makefile b/kernel/Makefile
> > index a8d923b5481ba..50fd511cd0ee0 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -114,6 +114,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
> >  obj-$(CONFIG_ZONE_DEVICE) += memremap.o
> >  obj-$(CONFIG_RSEQ) += rseq.o
> >
> > +obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
>
> And we have lib/test_sysctl.c of selftests.
>
> I'm fine with this going in as-is to its current place, but if we have
> to learn from selftests I'd say we try to stick to a convention so
> folks know what framework a test is for, and to ensure folks can
> easily tell if its test code or not.
>
> Perhaps simply a directory for kunit tests would suffice alone.
>
> > +
> >  obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
> >  KASAN_SANITIZE_stackleak.o := n
> >  KCOV_INSTRUMENT_stackleak.o := n
> > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > new file mode 100644
> > index 0000000000000..cb61ad3c7db63
> > --- /dev/null
> > +++ b/kernel/sysctl-test.c
> > @@ -0,0 +1,242 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test of proc sysctl.
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/sysctl.h>
> > +
> > +static int i_zero;
> > +static int i_one_hundred = 100;
> > +
> > +struct test_sysctl_data {
> > +     int int_0001;
> > +     int int_0002;
> > +     int int_0003[4];
> > +
> > +     unsigned int uint_0001;
> > +
> > +     char string_0001[65];
> > +};
> > +
> > +static struct test_sysctl_data test_data = {
> > +     .int_0001 = 60,
> > +     .int_0002 = 1,
> > +
> > +     .int_0003[0] = 0,
> > +     .int_0003[1] = 1,
> > +     .int_0003[2] = 2,
> > +     .int_0003[3] = 3,
> > +
> > +     .uint_0001 = 314,
> > +
> > +     .string_0001 = "(none)",
> > +};
> > +
> > +static void sysctl_test_dointvec_null_tbl_data(struct kunit *test)
> > +{
> > +     struct ctl_table table = {
> > +             .procname = "foo",
> > +             .data           = NULL,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_dointvec,
> > +             .extra1         = &i_zero,
> > +             .extra2         = &i_one_hundred,
> > +     };
> > +     void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +     size_t len;
> > +     loff_t pos;
> > +
> > +     len = 1234;
> > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
>
> It is a bit odd, but it does happen, for a developer to be calling
> proc_dointvec() directly, instead typically folks just register a table
> and let it do its thing.  That said, someone not too familiar with proc
> code would see this and really have no clue exactly what is being
> tested.
>
> Even as a maintainer, I had to read the code for proc_dointvec() a bit
> to understand that the above is a *read* attempt to the .data field
> being allocated. Because its a write, the len set to a bogus does not
> matter as we are expecting the proc_dointvec() to update len for us.
>
> If a test fails, it would be good to for anyone to easily grasp what is
> being tested. So... a few words documenting each test case would be nice.
>
> > +     len = 1234;
> > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
>
> And this is a write...
>
> A nice tests given the data on the table allocated is not assigned.
>
> I don't see any other areas in the kernel where we open code a
> proc_dointvec() call where the second argument is a digit, it
> always is with a variable. As such there would be no need for
> us to expose helpers to make it clear if one is a read or write.
> But for *this* case, I think it would be useful to add two wrappers
> inside this kunit test module which sprinkles the 0 or 1, this way
> a reader can easily know what mode is being tested.
>
> kunit_proc_dointvec_read()
> kunit_proc_dointvec_write()
>
> Or just use #define KUNIT_PROC_READ 0, #define KUNIT_PROC_WRITE 1.
> Whatever makes this code more legible.
Went with the #define * suggestion above to keep it clear what
function is being tested.

> > +}
> > +
> > +static void sysctl_test_dointvec_table_maxlen_unset(struct kunit *test)
> > +{
> > +     struct ctl_table table = {
> > +             .procname = "foo",
> > +             .data           = &test_data.int_0001,
> > +             .maxlen         = 0,
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_dointvec,
> > +             .extra1         = &i_zero,
> > +             .extra2         = &i_one_hundred,
> > +     };
> > +     void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +     size_t len;
> > +     loff_t pos;
> > +
> > +     len = 1234;
> > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > +     len = 1234;
> > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > +}
>
> In a way this is also testing for general kernel API changes. This is and the
> last one were good examples. So this is not just testing functionality
> here. There is no wrong or write answer if 0 or -EINVAL was returned
> other than the fact that we have been doing this for years.
>
> Its a perhaps small but important difference for some of these tests.  I
> *do* think its worth clarifying through documentation which ones are
> testing for API consistency Vs proper correctness.
>
You make a good point that the test codifies the existing behavior of
the function
in lieu of formal documentation.
However, the test cases were derived from examining the source code
of the function under test and attempting to cover all branches. The
assertions were added
only for the values that appeared to be set deliberately in the
implementation. And it makes
sense to me to test that the code does exactly what the implementation
author intended.
> > +
> > +static void sysctl_test_dointvec_table_len_is_zero(struct kunit *test)
> > +{
> > +     struct ctl_table table = {
> > +             .procname = "foo",
> > +             .data           = &test_data.int_0001,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_dointvec,
> > +             .extra1         = &i_zero,
> > +             .extra2         = &i_one_hundred,
> > +     };
> > +     void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +     size_t len;
> > +     loff_t pos;
> > +
> > +     len = 0;
> > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > +}
>
> Likewise an API change test.
>
Same as the above, if the implementation author meant the function to
behave deterministically
with the given input, it makes sense to test the behavior. Otherwise,
why not just remove the branch in
 the function under test and say that the given input results in
undefined behavior?
> > +
> > +static void sysctl_test_dointvec_table_read_but_position_set(struct kunit *test)
> > +{
> > +     struct ctl_table table = {
> > +             .procname = "foo",
> > +             .data           = &test_data.int_0001,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_dointvec,
> > +             .extra1         = &i_zero,
> > +             .extra2         = &i_one_hundred,
> > +     };
> > +     void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +     size_t len;
> > +     loff_t pos;
> > +
> > +     len = 1234;
> > +     pos = 1;
> > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > +}
>
> Likewise an API test.
>
> All the above kunit test cases are currently testing this call on
> __do_proc_dointvec():
>
>         if (!tbl_data || !table->maxlen || !*lenp || (*ppos && !write))
>         {
>                 *lenp = 0;
>                 return 0;
>         }
>
> Just an API test.
>
> Perhaps use an api prefix or postfix for these to help distinguish
> which are api tests Vs correctness. We want someone who runs into
> a failure to *easily* determine *what* went wrong.
>
> Right now this kunit test leaves no leashes around to help the reader.
>
> > +
> > +static void sysctl_test_dointvec_happy_single_positive(struct kunit *test)
> > +{
> > +     struct ctl_table table = {
> > +             .procname = "foo",
> > +             .data           = &test_data.int_0001,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_dointvec,
> > +             .extra1         = &i_zero,
> > +             .extra2         = &i_one_hundred,
> > +     };
> > +     char input[] = "9";
> > +     size_t len = sizeof(input) - 1;
> > +     loff_t pos = 0;
> > +
> > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
> > +     KUNIT_EXPECT_EQ(test, 9, ((int *)table.data)[0]);
> > +}
>
> Yeap, running these kunit test cases will surely be faster than stupid
> shell :) nice!
>
> > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > +{
> > +     struct ctl_table table = {
> > +             .procname = "foo",
> > +             .data           = &test_data.int_0001,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_dointvec,
> > +             .extra1         = &i_zero,
> > +             .extra2         = &i_one_hundred,
> > +     };
> > +     char input[] = "-9";
> > +     size_t len = sizeof(input) - 1;
> > +     loff_t pos = 0;
> > +
> > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
> > +     KUNIT_EXPECT_EQ(test, -9, ((int *)table.data)[0]);
> > +}
> > +
> > +static void sysctl_test_dointvec_single_less_int_min(struct kunit *test)
> > +{
> > +     struct ctl_table table = {
> > +             .procname = "foo",
> > +             .data           = &test_data.int_0001,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_dointvec,
> > +             .extra1         = &i_zero,
> > +             .extra2         = &i_one_hundred,
> > +     };
> > +     char input[32];
> > +     size_t len = sizeof(input) - 1;
> > +     loff_t pos = 0;
> > +     unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
> > +                                          - (INT_MAX + INT_MIN) + 1;
> > +
> > +     KUNIT_EXPECT_LT(test,
> > +                     (size_t)snprintf(input, sizeof(input), "-%lu",
> > +                                      abs_of_less_than_min),
> > +                     sizeof(input));
> > +
> > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +     KUNIT_EXPECT_EQ(test, -EINVAL,
> > +                     proc_dointvec(&table, 1, input, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +     KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> > +}
>
> API test.
>
Not sure why. I believe there has been a real bug with int overflow in
proc_dointvec.
Covering it with test seems like a good idea.
> > +static void sysctl_test_dointvec_single_greater_int_max(struct kunit *test)
> > +{
> > +     struct ctl_table table = {
> > +             .procname = "foo",
> > +             .data           = &test_data.int_0001,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_dointvec,
> > +             .extra1         = &i_zero,
> > +             .extra2         = &i_one_hundred,
> > +     };
> > +     char input[32];
> > +     size_t len = sizeof(input) - 1;
> > +     loff_t pos = 0;
> > +     unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
> > +
> > +     KUNIT_EXPECT_GT(test, greater_than_max, (unsigned long)INT_MAX);
> > +     KUNIT_EXPECT_LT(test, (size_t)snprintf(input, sizeof(input), "%lu",
> > +                                            greater_than_max),
> > +                     sizeof(input));
> > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +     KUNIT_EXPECT_EQ(test, -EINVAL,
> > +                     proc_dointvec(&table, 1, input, &len, &pos));
> > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +     KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> > +}
> > +
>
> API test.
>
> > +static struct kunit_case sysctl_test_cases[] = {
> > +     KUNIT_CASE(sysctl_test_dointvec_null_tbl_data),
> > +     KUNIT_CASE(sysctl_test_dointvec_table_maxlen_unset),
> > +     KUNIT_CASE(sysctl_test_dointvec_table_len_is_zero),
> > +     KUNIT_CASE(sysctl_test_dointvec_table_read_but_position_set),
> > +     KUNIT_CASE(sysctl_test_dointvec_happy_single_positive),
> > +     KUNIT_CASE(sysctl_test_dointvec_happy_single_negative),
> > +     KUNIT_CASE(sysctl_test_dointvec_single_less_int_min),
> > +     KUNIT_CASE(sysctl_test_dointvec_single_greater_int_max),
> > +     {}
> > +};
>
> Oh all are API tests.. perhaps then just rename then
> sysctl_test_cases to sysctl_api_test_cases.
>
> Would be good to add at least *two* other tests cases for this
> example, one which does a valid read and one which does a valid write.
Added valid reads. There already are 2 valid writes.
> If that is done either we add another kunit test module for correctness
> or just extend the above and use prefix / postfixes on the functions
> to distinguish between API / correctness somehow.
>
> > +
> > +static struct kunit_module sysctl_test_module = {
> > +     .name = "sysctl_test",
> > +     .test_cases = sysctl_test_cases,
> > +};
> > +
> > +module_test(sysctl_test_module);
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index cbdfae3798965..389b8986f5b77 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1939,6 +1939,16 @@ config TEST_SYSCTL
> >
> >         If unsure, say N.
> >
> > +config SYSCTL_KUNIT_TEST
> > +     bool "KUnit test for sysctl"
> > +     depends on KUNIT
> > +     help
> > +       This builds the proc sysctl unit test, which runs on boot. For more
> > +       information on KUnit and unit tests in general please refer to the
> > +       KUnit documentation in Documentation/dev-tools/kunit/.
>
> A little more description here would help. It is testing for API and
> hopefully also correctness (if extended with those two examples I
> mentioned).
>
Added "Tests the API contract and implementation correctness of sysctl."
> > +
> > +       If unsure, say N.
> > +
> >  config TEST_UDELAY
> >       tristate "udelay test driver"
> >       help
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
>
> Thanks for the work, it is very much appreciated and gives a clearer
> appreciation of value of kunit and what can be done and not. Another
> random test idea that comes up, would be to use different memory types
> for the table data. In case the kernel API users does something odd,
> we should be ensuring we do something proper.
>
>   Luis
