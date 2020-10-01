Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2590328031A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbgJAPqU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 11:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbgJAPqU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 11:46:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A134C0613E2
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Oct 2020 08:46:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so4860722pfp.11
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Oct 2020 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QW720dDg6w8WjYZQQLyUzFkTDggeR43z1zPv/IrMZ24=;
        b=dT0cpPKGpgzEScHP6GjGacfyG89UjBtM4nbWhLskXE8OBM+LpA3cfiIaQQzwNTfnh4
         uWeC8lhol/0pNhI0i9kxVq5tjolCKWjKI2SwVKJZAA+dfYporGTzxFSp69fV3t89j4V8
         LQN81t24F5+XcsoRXyJDNWQfPaCnlvqvP522Mu0dN951VwZuHg1PN6gtbt7rq1DKIo4T
         YskPmbBPJBLm/ql6UEeV9WaZF0qcH8F2y688w751qYuK9ARsSw579XDi0vFek3hG/91T
         m/4vD51knsCwY6pPeK/ury1qzq3med0bXP6YEo6+yzH4cHSI2kER7GqeEOlQYOw4Q+kY
         9CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QW720dDg6w8WjYZQQLyUzFkTDggeR43z1zPv/IrMZ24=;
        b=DR0ipPn+FTvIypCtktJ4kyK4NFdVsFwemnjFpY8tdKa2pE+ddYfeu0DKQN4lE8Yb/m
         madrFC+5+6ansizaw123IAB3IIBA0OVkJC9k3SJyJ3swJqdySwDU4j26PKrlTAWgPuOb
         05cjZmI8QdCiivWiJbSjbX5Ft/Qm3pLZUtyGmxVwKDhdc/0i9dktRmsEdIYuqy1tEVnL
         AghYVo8IyMfRrCv9A4p39I3vR1ZAnibvHBSSlw5y4bBi5ojyskSSOry+MRkttQobCIe+
         JaIbwa3shPAMi3aUV6IVgKU7lwMawB/BYq61NwYU4PE/LJ8krNEp/E7KFvU4Z7uJzYyS
         4tzg==
X-Gm-Message-State: AOAM532tPVjG4PIM+1GqyqqqiiyK1lqppzDxJmRyM2GHxmEq7O+BNLsG
        gGc+iyn5+3BzenfitfFGURKLOf6j6UCuudnvsNxsMw==
X-Google-Smtp-Source: ABdhPJwyo92ngttdaUJqIplWuz05ypEN5fgXAsM5QaNEs5Dyzgrhise69twwtOtjBiI/RFlHiC37e/EUKB9mlZBcVdM=
X-Received: by 2002:a65:5cc2:: with SMTP id b2mr6663685pgt.124.1601567178571;
 Thu, 01 Oct 2020 08:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930222130.4175584-2-kaleshsingh@google.com> <0dc41856-e406-7f00-1eb9-5e97e476afa4@nvidia.com>
In-Reply-To: <0dc41856-e406-7f00-1eb9-5e97e476afa4@nvidia.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 1 Oct 2020 11:46:07 -0400
Message-ID: <CAC_TJvdrAhyypTFqgYRmZj1ndiuuad0VfvgENhdWAO+Kp1r_=Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] kselftests: vm: Add mremap tests
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>, Jia He <justin.he@arm.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Zi Yan <ziy@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 1, 2020 at 3:24 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/30/20 3:21 PM, Kalesh Singh wrote:
> > Test mremap on regions of various sizes and alignments and validate
> > data after remapping. Also provide total time for remapping
> > the region which is useful for performance comparison of the mremap
> > optimizations that move pages at the PMD/PUD levels if HAVE_MOVE_PMD
> > and/or HAVE_MOVE_PUD are enabled.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >   tools/testing/selftests/vm/.gitignore    |   1 +
> >   tools/testing/selftests/vm/Makefile      |   1 +
> >   tools/testing/selftests/vm/mremap_test.c | 243 ++++++++++++++++++++++=
+
> >   tools/testing/selftests/vm/run_vmtests   |  11 +
> >   4 files changed, 256 insertions(+)
> >   create mode 100644 tools/testing/selftests/vm/mremap_test.c
> >
>
> Hi,
>
> This takes 100x longer to run than it should: 1:46 min of running time on
> my x86_64 test machine. The entire selftests/vm test suite takes 45 sec o=
n a
> bad day, where a bad day is defined as up until about tomorrow, when I wi=
ll
> post a compaction_test.c patch that will cut that time down to about half=
, or
> 24 sec total run time...for 22 tests!
>
> In other words, most tests here should take about 1 or 2 seconds, unless =
they
> are exceptionally special snowflakes.
>
> At the very least, the invocation within run_vmtests could pass in a para=
meter
> to tell it to run a shorter test. But there's also opportunities to speed=
 it
> up, too.


Hi John. Thanks for the comments.

The bulk of the test time comes from setting and verifying the byte
pattern in 1GB
or larger regions for testing the HAVE_MOVE_PUD functionality. Without test=
ing
1GB or larger regions the test takes 0.18 seconds on my x86_64 system.

One option I think would be to only validate to a certain threshold of the =
remap
region. We can have a flag to specify a threshold or to validate the
full size of the
remapped region. I did some initial testing with a 4MB threshold and
the total time
dropped to 0.38 seconds from 1:12 minutes (for verifying the entire
remapped region).
The 4MB threshold would cover the full region of all the tests
excluding those for the
1GB and 2GB sized regions. Let me know what you think.

Your other comments below sound good to me. I=E2=80=99ll make those changes=
 in
the next version.

Thanks,
Kalesh

>
> ...
> > +
> > +#define MAKE_TEST(source_align, destination_align, size,     \
> > +               overlaps, should_fail, test_name)             \
> > +{                                                            \
> > +     .name =3D test_name,                                      \
> > +     .config =3D {                                             \
> > +             .src_alignment =3D source_align,                  \
> > +             .dest_alignment =3D destination_align,            \
> > +             .region_size =3D size,                            \
> > +             .overlapping =3D overlaps,                        \
> > +     },                                                      \
> > +     .expect_failure =3D should_fail                           \
> > +}
> > +
>
> OK...
>
> > +#define MAKE_SIMPLE_TEST(source_align, destination_align, size)      \
> > +     MAKE_TEST(source_align, destination_align, size, 0, 0,  \
> > +               #size " mremap - Source " #source_align       \
> > +               " aligned, Destination " #destination_align   \
> > +               " aligned")
> > +
>
> ...and not OK. :)  Because this is just obscuring things. Both the
> code and the output are harder to read. For these tiny test programs,
> clarity is what we want, not necessarily compactness on the screen.
> Because people want to get in, understand what they seen in the code
> and match it up with what is printed to stdout--without spending much
> time. (And that includes run time, as hinted at above.)
>
> ...
> > +
> > +/* Returns the time taken for the remap on success else returns -1. */
> > +static long long remap_region(struct config c)
> > +{
> > +     void *addr, *src_addr, *dest_addr;
> > +     int i, j;
> > +     struct timespec t_start =3D {0, 0}, t_end =3D {0, 0};
> > +     long long  start_ns, end_ns, align_mask, ret, offset;
> > +     char pattern[] =3D {0xa8, 0xcd, 0xfe};
>
> I'd recommend using rand() to help choose the pattern, and using differen=
t
> patterns for different runs. When testing memory, it's a pitfall to have
> the same test pattern.
>
> Normally, you'd also want to report the random seed or the test pattern(s=
)
> or both to stdout, and provide a way to run with the same pattern, but
> here I don't *think* you care: all patterns should have the same performa=
nce.
>
> > +     int pattern_size =3D ARRAY_SIZE(pattern);
> > +
> > +     src_addr =3D get_source_mapping(c);
> > +     if (!src_addr) {
> > +             ret =3D -1;
> > +             goto out;
> > +     }
> > +
> > +     /* Set byte pattern */
> > +     for (i =3D 0; i < c.region_size; i++) {
> > +             for (j =3D 0; i+j < c.region_size && j < pattern_size; j+=
+)
> > +                     memset((char *) src_addr + i+j, pattern[j], 1);
> > +             i +=3D pattern_size-1;
> > +     }
> > +
> > +     align_mask =3D ~(c.dest_alignment - 1);
> > +     offset =3D (c.overlapping) ? -c.dest_alignment : c.dest_alignment=
;
>
> A comment for what the above two lines are doing would be a nice touch.
>
> ...
> > +     start_ns =3D t_start.tv_sec * 1000000000ULL + t_start.tv_nsec;
> > +     end_ns =3D t_end.tv_sec * 1000000000ULL + t_end.tv_nsec;
>
> A const or #defined for all those 0000's would help.
>
> ...
> > +int main(int argc, char *argv[])
> > +{
> > +     int failures =3D 0;
> > +     int i;
> > +
> > +     struct test test_cases[] =3D {
> > +             /* Expected mremap failures */
> > +             MAKE_TEST(_4KB, _4KB, _4KB, 1 /* overlaps */, 1 /* fails =
*/,
>
> Named flags instead of 1's and 0's would avoid the need for messy comment=
s.
>
> > +                       "mremap - Source and Destination Regions Overla=
pping"),
> > +             MAKE_TEST(_4KB, _1KB, _4KB, 0 /* overlaps */, 1 /* fails =
*/,
> > +                       "mremap - Destination Address Misaligned (1KB-a=
ligned)"),
> > +             MAKE_TEST(_1KB, _4KB, _4KB, 0 /* overlaps */, 1 /* fails =
*/,
> > +                       "mremap - Source Address Misaligned (1KB-aligne=
d)"),
> > +
> > +             /* Src addr PTE aligned */
> > +             MAKE_SIMPLE_TEST(PTE, PTE, _8KB),
> > +
> > +             /* Src addr 1MB aligned */
> > +             MAKE_SIMPLE_TEST(_1MB, PTE, _2MB),
> > +             MAKE_SIMPLE_TEST(_1MB, _1MB, _2MB),
> > +
> > +             /* Src addr PMD aligned */
> > +             MAKE_SIMPLE_TEST(PMD, PTE, _4MB),
> > +             MAKE_SIMPLE_TEST(PMD, _1MB, _4MB),
> > +             MAKE_SIMPLE_TEST(PMD, PMD, _4MB),
> > +
> > +             /* Src addr PUD aligned */
> > +             MAKE_SIMPLE_TEST(PUD, PTE, _2GB),
> > +             MAKE_SIMPLE_TEST(PUD, _1MB, _2GB),
> > +             MAKE_SIMPLE_TEST(PUD, PMD, _2GB),
> > +             MAKE_SIMPLE_TEST(PUD, PUD, _2GB),
>
>
> Too concise. Not fun lining these up with the stdout report.
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
