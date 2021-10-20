Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4244352AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTSbs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhJTSbn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 14:31:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F71C061749
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 11:29:26 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id m20so25732095iol.4
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q89oVyQBTUak6GonDhBQZ4EDfITIyfwn25FBB5afZ4A=;
        b=PivA0O37xPWODAtgcpFLG2r/iqzG5FxY0Z1hpYBfW6VZg5VIOVXpfMnxgJvbGRxTMI
         oD1HfkQFsFxt618Dy2o5t7Pmn99nl9ZFhg6kHos74iCwpoSWpazp9IlHtWEAu6qZMZHq
         8tZGm/Jiz3KskWvoD3ZaJ3NODAa9KdLaa3wmG08Y6A6BslHnZza1nz0bs9hg1V1tASEN
         d4gVv9Q6EvK4gJrwPtDXDVaNJTEQyDiI6x7k3wxcB3yKnMhs1tauwPjWlai9SZ5UaoB9
         qrPMPMNaVWpm8lxt45Shm0bVBGupNiefNymH/IoHyGOMwHgYK9HzdiXhFZEssPCtXp9Y
         74/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q89oVyQBTUak6GonDhBQZ4EDfITIyfwn25FBB5afZ4A=;
        b=rGlnFuRU5oTxTWo71tQPyXhifwY5V9Vl1P/wQoIg6rbGy9W3T0mO43QjfP9zHwJ94B
         KOhpp6PW5U9jjLNk0oosUk77+UYmgv642Nv3aB2hvDj+y8BNXxCj3E1kprKUzFmcBYFh
         4dmXrZl+MJRKPz5bQkZXuwiQUc3e/UXtkzQNFF/JODp/YfeL+j0r4+WJHPklzhq/+ZJR
         +ctm+jcqlgcptx1VSo6pqUAlSLn6qact2QJ1In9eeFzgs+jtsIZ0NYTJtvL0cQaygvHa
         2Ih9GVA6IK4SkePuvSfIlGeLkRbI4IowUuyd6VAjLkIfLEUjmb6AnERI563uz4rT3PoE
         F4Dw==
X-Gm-Message-State: AOAM533X9ouvDxiWPPcgAMTpEWbdmyBNKuJIo79CVoF1SrCVByY1gZiG
        RGHd9VWiRl+rJKrTUCJO5W4S3OnxkINhusFO/QH/KQ==
X-Google-Smtp-Source: ABdhPJwkWpvxOxpujW3lsZJOksr9h84iP/TYpMsyjLLw3iXEacR6REvlDPfOHJXHv8y2tSgP93ld1vQs3EtYLRu3cFg=
X-Received: by 2002:a6b:f614:: with SMTP id n20mr618747ioh.134.1634754565966;
 Wed, 20 Oct 2021 11:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210930212309.4001967-1-axelrasmussen@google.com> <20210930212309.4001967-3-axelrasmussen@google.com>
In-Reply-To: <20210930212309.4001967-3-axelrasmussen@google.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 20 Oct 2021 11:28:49 -0700
Message-ID: <CAJHvVcj9FpJgC5EsB1_6yfgDA8p5-=Oakccg+TUrGUWZB5nHzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd/selftests: fix feature support detection
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Just a friendly bump for review. :) Peter, any objections to this
version? I think it fairly closely matches your suggestions from v1.

On Thu, Sep 30, 2021 at 2:23 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> Before any tests are run, in set_test_type, we decide what feature(s) we
> are going to be testing, based upon our command line arguments. However,
> the supported features are not just a function of the memory type being
> used, so this is broken.
>
> For instance, consider writeprotect support. It is "normally" supported
> for anonymous memory, but furthermore it requires that the kernel has
> CONFIG_HAVE_ARCH_USERFAULTFD_WP. So, it is *not* supported at all on
> aarch64, for example.
>
> So, this commit fixes this by querying the kernel for the set of
> features it supports in set_test_type, by opening a userfaultfd and
> issuing a UFFDIO_API ioctl. Based upon the reported features, we toggle
> what tests are enabled.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 54 ++++++++++++++----------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 2a71a91559a7..00d1b7555865 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -346,6 +346,16 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
>
>  static struct uffd_test_ops *uffd_test_ops;
>
> +static inline uint64_t uffd_minor_feature(void)
> +{
> +       if (test_type == TEST_HUGETLB && map_shared)
> +               return UFFD_FEATURE_MINOR_HUGETLBFS;
> +       else if (test_type == TEST_SHMEM)
> +               return UFFD_FEATURE_MINOR_SHMEM;
> +       else
> +               return 0;
> +}
> +
>  static void userfaultfd_open(uint64_t *features)
>  {
>         struct uffdio_api uffdio_api;
> @@ -406,7 +416,7 @@ static void uffd_test_ctx_clear(void)
>         munmap_area((void **)&area_dst_alias);
>  }
>
> -static void uffd_test_ctx_init_ext(uint64_t *features)
> +static void uffd_test_ctx_init(uint64_t features)
>  {
>         unsigned long nr, cpu;
>
> @@ -418,7 +428,7 @@ static void uffd_test_ctx_init_ext(uint64_t *features)
>         uffd_test_ops->release_pages(area_src);
>         uffd_test_ops->release_pages(area_dst);
>
> -       userfaultfd_open(features);
> +       userfaultfd_open(&features);
>
>         count_verify = malloc(nr_pages * sizeof(unsigned long long));
>         if (!count_verify)
> @@ -446,11 +456,6 @@ static void uffd_test_ctx_init_ext(uint64_t *features)
>                         err("pipe");
>  }
>
> -static inline void uffd_test_ctx_init(uint64_t features)
> -{
> -       uffd_test_ctx_init_ext(&features);
> -}
> -
>  static int my_bcmp(char *str1, char *str2, size_t n)
>  {
>         unsigned long i;
> @@ -1191,7 +1196,6 @@ static int userfaultfd_minor_test(void)
>         void *expected_page;
>         char c;
>         struct uffd_stats stats = { 0 };
> -       uint64_t req_features, features_out;
>
>         if (!test_uffdio_minor)
>                 return 0;
> @@ -1199,21 +1203,7 @@ static int userfaultfd_minor_test(void)
>         printf("testing minor faults: ");
>         fflush(stdout);
>
> -       if (test_type == TEST_HUGETLB)
> -               req_features = UFFD_FEATURE_MINOR_HUGETLBFS;
> -       else if (test_type == TEST_SHMEM)
> -               req_features = UFFD_FEATURE_MINOR_SHMEM;
> -       else
> -               return 1;
> -
> -       features_out = req_features;
> -       uffd_test_ctx_init_ext(&features_out);
> -       /* If kernel reports required features aren't supported, skip test. */
> -       if ((features_out & req_features) != req_features) {
> -               printf("skipping test due to lack of feature support\n");
> -               fflush(stdout);
> -               return 0;
> -       }
> +       uffd_test_ctx_init(uffd_minor_feature());
>
>         uffdio_register.range.start = (unsigned long)area_dst_alias;
>         uffdio_register.range.len = nr_pages * page_size;
> @@ -1574,6 +1564,8 @@ unsigned long default_huge_page_size(void)
>
>  static void set_test_type(const char *type)
>  {
> +       uint64_t features = UFFD_API_FEATURES;
> +
>         if (!strcmp(type, "anon")) {
>                 test_type = TEST_ANON;
>                 uffd_test_ops = &anon_uffd_test_ops;
> @@ -1607,6 +1599,22 @@ static void set_test_type(const char *type)
>         if ((unsigned long) area_count(NULL, 0) + sizeof(unsigned long long) * 2
>             > page_size)
>                 err("Impossible to run this test");
> +
> +       /*
> +        * Whether we can test certain features depends not just on test type,
> +        * but also on whether or not this particular kernel supports the
> +        * feature.
> +        */
> +
> +       userfaultfd_open(&features);
> +
> +       test_uffdio_wp = test_uffdio_wp &&
> +               (features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
> +       test_uffdio_minor = test_uffdio_minor &&
> +               (features & uffd_minor_feature());
> +
> +       close(uffd);
> +       uffd = -1;
>  }
>
>  static void sigalrm(int sig)
> --
> 2.33.0.800.g4c38ced690-goog
>
