Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E855856B7
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Jul 2022 00:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiG2WAp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jul 2022 18:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiG2WAn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jul 2022 18:00:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB11BEAA
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jul 2022 15:00:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w63-20020a17090a6bc500b001f3160a6011so7698459pjj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jul 2022 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6h4ohZ2Xp6R3ogVvEX4OuhDaK3xwr7fdihhnTifVFE=;
        b=Hh3udcBgOmHDHFs4xZ2AYfapyxGTL4aNTTwsw1jabkNYhQWntuDiiyBltZO3ocuI7l
         jrjikwlBeMC5AycuKMDP7YSkUBVNwQLcxvYcBUeVkRnslx85bVunbpbRuy2yO2fvdKMH
         v4QnNcNTz6k17yfOndGCQuw8grdwHjt0OoY+WkcJ1aMz39Zx1i+Df8nAM246eWV0CVGu
         p03qAcs2lL8MD8jaiJhbYb/77yj6XQRfFSMigLUY4LiEoWFhoTGEoJwWvW0B38EFu32K
         k3if07ulbtee9ALhWPvmywvPN5THinApcIn4BNTryBMfWF3uJyVestLteJjc9TLnN4e7
         /iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6h4ohZ2Xp6R3ogVvEX4OuhDaK3xwr7fdihhnTifVFE=;
        b=ymYNUpIjHn0a9jmOBdjILCQqCiQObmlGR1tGh75ijgjiEOwznhC1P5heqTS73wSNj/
         aYW7pKpdfSQWTWCNm8ELKrmvDi+rjbAvQHTHul8y4BZVkP6woJmwRpZUt2RnFxq2apet
         J+yLDPdQe8QE7YBsgL8cRG6ZRfR0h4VhHArp4ALvsiOoOkMtCDmVBY7pf8uowf+Rb4Se
         LUAy5JEH2xPLyHl7YDhAgB3k/uF45PMulDDemZcNdUBBn3elLmYWR4Tg+ykI1VwPKd4+
         fG5YhLozq24rnjMz23VEUgvmgk5LDdpNfLWgJnEYt4pKToJfY/tyN4bBmGxr5x41Tyb8
         2y1w==
X-Gm-Message-State: ACgBeo1fJBBS8+H5m6mEVq0Y6qRBJQNu7CtBuIYSz2tzoasD5oD15IWW
        UpYv5a4XIEoWY1pi/N9RUTp2gDNp4FHFzy/9PoaxPg==
X-Google-Smtp-Source: AA6agR4uf8A0oZw69pkPAzRO4OYeL0SdNIJXKU9sGKb8X7Pmvg1arDvaoy1Sp/zSjHB+xpVg1xbkPADDnhGUC95lQGM=
X-Received: by 2002:a17:903:228d:b0:16d:4549:1078 with SMTP id
 b13-20020a170903228d00b0016d45491078mr5703844plh.78.1659132041958; Fri, 29
 Jul 2022 15:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <6f71a4f3-8f8e-926b-883c-1df630cfc1a0@linuxfoundation.org> <20220729061504.744140-1-jeffxu@google.com>
In-Reply-To: <20220729061504.744140-1-jeffxu@google.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 29 Jul 2022 15:00:05 -0700
Message-ID: <CALmYWFt0Y9OZw3ezx0PjoHm+KuXVXkhM3u28s0TXxcncrt9SSA@mail.gmail.com>
Subject: Re: [PATCH 3/4] selftests/memfd: add tests for F_SEAL_EXEC
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mnissler@chromium.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Shuah Khan

I will continue Daniel Verkamp's work on this patch.

Could you please take a look at the new patch set I sent to see if all
your comments are addressed ?

Much appreciated.

Best Regards,
Jeff.


On Thu, Jul 28, 2022 at 11:15 PM Jeff Xu <jeffxu@google.com> wrote:
>
> From: Daniel Verkamp <dverkamp@chromium.org>
>
> Basic tests to ensure that user/group/other execute bits cannot be
> changed after applying F_SEAL_EXEC to a memfd.
>
> Co-developed-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 129 ++++++++++++++++++++-
>  1 file changed, 128 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 94df2692e6e4..1d7e7b36bbdd 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -28,12 +28,44 @@
>  #define MFD_DEF_SIZE 8192
>  #define STACK_SIZE 65536
>
> +#ifndef F_SEAL_EXEC
> +#define F_SEAL_EXEC    0x0020
> +#endif
> +
> +#ifndef MAX_PATH
> +#define MAX_PATH 256
> +#endif
> +
>  /*
>   * Default is not to test hugetlbfs
>   */
>  static size_t mfd_def_size = MFD_DEF_SIZE;
>  static const char *memfd_str = MEMFD_STR;
>
> +static ssize_t fd2name(int fd, char *buf, size_t bufsize)
> +{
> +       char buf1[MAX_PATH];
> +       int size;
> +       ssize_t nbytes;
> +
> +       size = snprintf(buf1, MAX_PATH, "/proc/self/fd/%d", fd);
> +       if (size < 0) {
> +               printf("snprintf(%d) failed on %m\n", fd);
> +               abort();
> +       }
> +
> +       /*
> +        * reserver one byte for string termination.
> +        */
> +       nbytes = readlink(buf1, buf, bufsize-1);
> +       if (nbytes == -1) {
> +               printf("readlink(%s) failed %m\n", buf1);
> +               abort();
> +       }
> +       buf[nbytes] = '\0';
> +       return nbytes;
> +}
> +
>  static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
>  {
>         int r, fd;
> @@ -98,11 +130,14 @@ static unsigned int mfd_assert_get_seals(int fd)
>
>  static void mfd_assert_has_seals(int fd, unsigned int seals)
>  {
> +       char buf[MAX_PATH];
> +       int nbytes;
>         unsigned int s;
> +       fd2name(fd, buf, MAX_PATH);
>
>         s = mfd_assert_get_seals(fd);
>         if (s != seals) {
> -               printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
> +               printf("%u != %u = GET_SEALS(%s)\n", seals, s, buf);
>                 abort();
>         }
>  }
> @@ -594,6 +629,64 @@ static void mfd_fail_grow_write(int fd)
>         }
>  }
>
> +static void mfd_assert_mode(int fd, int mode)
> +{
> +       struct stat st;
> +       char buf[MAX_PATH];
> +       int nbytes;
> +
> +       fd2name(fd, buf, MAX_PATH);
> +
> +       if (fstat(fd, &st) < 0) {
> +               printf("fstat(%s) failed: %m\n", buf);
> +               abort();
> +       }
> +
> +       if ((st.st_mode & 07777) != mode) {
> +               printf("fstat(%s) wrong file mode 0%04o, but expected 0%04o\n",
> +                      buf, (int)st.st_mode & 07777, mode);
> +               abort();
> +       }
> +}
> +
> +static void mfd_assert_chmod(int fd, int mode)
> +{
> +       char buf[MAX_PATH];
> +       int nbytes;
> +
> +       fd2name(fd, buf, MAX_PATH);
> +
> +       if (fchmod(fd, mode) < 0) {
> +               printf("fchmod(%s, 0%04o) failed: %m\n", buf, mode);
> +               abort();
> +       }
> +
> +       mfd_assert_mode(fd, mode);
> +}
> +
> +static void mfd_fail_chmod(int fd, int mode)
> +{
> +       struct stat st;
> +       char buf[MAX_PATH];
> +       int nbytes;
> +
> +       fd2name(fd, buf, MAX_PATH);
> +
> +       if (fstat(fd, &st) < 0) {
> +               printf("fstat(%s) failed: %m\n", buf);
> +               abort();
> +       }
> +
> +       if (fchmod(fd, mode) == 0) {
> +               printf("fchmod(%s, 0%04o) didn't fail as expected\n",
> +                      buf, mode);
> +               abort();
> +       }
> +
> +       /* verify that file mode bits did not change */
> +       mfd_assert_mode(fd, st.st_mode & 07777);
> +}
> +
>  static int idle_thread_fn(void *arg)
>  {
>         sigset_t set;
> @@ -880,6 +973,39 @@ static void test_seal_resize(void)
>         close(fd);
>  }
>
> +/*
> + * Test SEAL_EXEC
> + * Test that chmod() cannot change x bits after sealing
> + */
> +static void test_seal_exec(void)
> +{
> +       int fd;
> +
> +       printf("%s SEAL-EXEC\n", memfd_str);
> +
> +       fd = mfd_assert_new("kern_memfd_seal_exec",
> +                           mfd_def_size,
> +                           MFD_CLOEXEC | MFD_ALLOW_SEALING);
> +
> +       mfd_assert_mode(fd, 0777);
> +
> +       mfd_assert_chmod(fd, 0644);
> +
> +       mfd_assert_has_seals(fd, 0);
> +       mfd_assert_add_seals(fd, F_SEAL_EXEC);
> +       mfd_assert_has_seals(fd, F_SEAL_EXEC);
> +
> +       mfd_assert_chmod(fd, 0600);
> +       mfd_fail_chmod(fd, 0777);
> +       mfd_fail_chmod(fd, 0670);
> +       mfd_fail_chmod(fd, 0605);
> +       mfd_fail_chmod(fd, 0700);
> +       mfd_fail_chmod(fd, 0100);
> +       mfd_assert_chmod(fd, 0666);
> +
> +       close(fd);
> +}
> +
>  /*
>   * Test sharing via dup()
>   * Test that seals are shared between dupped FDs and they're all equal.
> @@ -1059,6 +1185,7 @@ int main(int argc, char **argv)
>         test_seal_shrink();
>         test_seal_grow();
>         test_seal_resize();
> +       test_seal_exec();
>
>         test_share_dup("SHARE-DUP", "");
>         test_share_mmap("SHARE-MMAP", "");
> --
> 2.37.1.455.g008518b4e5-goog
>
