Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2836C6D2816
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 20:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjCaSsi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjCaSsg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 14:48:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E913420DA1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 11:48:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so24370761pjb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 11:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680288515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha0y1aVGGlKryyACSylfRfMiUopPmFx0UKtPGVQ010A=;
        b=dG65J7A4VVcqDAMEt/KHhdXENN8I5sFeiwg0aBjxIt6HSSCB18H3F99Oo7WyyJ6PU1
         ThxkRfrhTkLyalsHdj6HBZwOyFSdUgW8Ae6MAT3bKoxKRURQoqRY0yBR2cXtpXHkNpia
         ZIJ3r97rTNQYZl0h5hCIVASmnfyq7XNL7LewtRUICU1sXvuc7nBt7Q5UBKdR4ZhUQN4r
         M1IFYkSIeE5OhY15+XPmRafUGEHNNC59WzUgAqYKlfX++xNH20PYXaDI1x/LXndvrvXo
         C4gdXS4dDeshQkapddOG+7Qezzgt/4TFF/Mn/YQeTfhEHtnohOhyvQUKPQt2fLORvbkR
         m+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680288515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha0y1aVGGlKryyACSylfRfMiUopPmFx0UKtPGVQ010A=;
        b=QOHSAvcTqWpenazSXe4Gl0Kp25yBRtkD5s923TPmGe/7QI5jr/6RXgu0U56j3wxYZt
         qouKl9FFTLkx+CFdwP/9xUg3bzLZRaNLULj72NgP5tONOaMwMNjwXLffuJ6VTndsUR85
         RE/foX/BFcqWBrpSK90tWtbWzGCtLpo3anQrROrLST0ShyLQKmddMygmEPGx4waHNLeK
         hmp/e5zewx8vzCj8k5WtDrQgk3hofce6rIEKd/TFjGG7j0SGNGZ6CGkwg6uJW2eJ+e7y
         JhWMN37UluG2lhwbOrBbIMEd1ZhU/TR90ev5/2fQ1cZ9S+o5eSDHDV+QyGCpgKD5Ctop
         +B2w==
X-Gm-Message-State: AAQBX9ffUUUr75JOmBaSLD8zOjYSbC0H6tbDdbugyUsntsZZPpxpjSX7
        2k8pFWcXHA16JOWOX7jWOBMhrEWcR005l9uI87cmRg==
X-Google-Smtp-Source: AKy350Y/Lf2dCfi5UPTpbKVKc+6vTRtA4W694ps03YfOsv3zY1TjGM/sDdzAfOi/2xhGi26H88Yj/rnB8ijgSU8pQDE=
X-Received: by 2002:a17:902:8f8f:b0:19a:64f6:e147 with SMTP id
 z15-20020a1709028f8f00b0019a64f6e147mr3865059plo.2.1680288515105; Fri, 31 Mar
 2023 11:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <202303312259.441e35db-yujie.liu@intel.com> <CABVzXA=+7wF4=NWxi0x57YSNs1Mpp7pJCODvyC6JRn9tQQAGLA@mail.gmail.com>
In-Reply-To: <CABVzXA=+7wF4=NWxi0x57YSNs1Mpp7pJCODvyC6JRn9tQQAGLA@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 31 Mar 2023 11:47:58 -0700
Message-ID: <CALmYWFvXuQGuHHm9s5YAvG2VC1b3T+vu29xUYpKgWp6fmeUGaA@mail.gmail.com>
Subject: Re: [linus:master] [selftests/memfd] 11f75a0144: kernel-selftests.memfd.run_fuse_test.sh.fail
To:     Daniel Verkamp <dverkamp@chromium.org>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Daniel,
Thanks for initiating the analysis.

On Fri, Mar 31, 2023 at 10:57=E2=80=AFAM Daniel Verkamp <dverkamp@chromium.=
org> wrote:
>
> On Fri, Mar 31, 2023 at 8:05=E2=80=AFAM kernel test robot <yujie.liu@inte=
l.com> wrote:
> >
> > Hello,
> >
> > kernel test robot noticed kernel-selftests.memfd.run_fuse_test.sh.fail =
due to commit (built with gcc-11):
> >
> > commit: 11f75a01448f1b7a739e75dbd8f17b844fcfc510 ("selftests/memfd: add=
 tests for MFD_NOEXEC_SEAL MFD_EXEC")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-d4cf28ee-1_20230110
> > with following parameters:
> >
> >         group: group-02
> >
> > test-description: The kernel contains a set of "self tests" under the t=
ools/testing/selftests/ directory. These are intended to be small unit test=
s to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >
> > on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (S=
kylake) with 16G memory
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >
> >
> > # selftests: memfd: run_fuse_test.sh
> > # Aborted
> > not ok 2 selftests: memfd: run_fuse_test.sh # exit=3D134
> >
> > $ ./run_fuse_test.sh
> > opening: ./mnt/memfd
> > 8 !=3D 40 =3D GET_SEALS(4)
> > Aborted
>
> Hi Jeff,
>
> I think this is caused by test_sysctl() in memfd_test, which sets
> /proc/sys/vm/memfd_noexec to a non-zero value and does not restore it
> at the end of the test. If fuse_test runs after that, it will
> unexpectedly get F_SEAL_EXEC in its memfd seals in addition to the
> F_SEAL_WRITE that it intended to add.

The sysctl for /proc/sys/vm/memfd_noexec is pid-namespaced, and designed to
be non-reservable due to security reasons.

I think the fix is to run this set of test_sysctl in a child
namespace, instead of init namespace.
I will work on a fix for this.

> I'm not sure how kernel selftests normally perform cleanup (e.g. an
> atexit() hook to make sure it cleans up if a test fails?), but at
> least we should probably set /proc/sys/vm/memfd_noexec back to its
> original value after test_sysctl().
>
> Thanks,
> -- Daniel

Thanks!
-Jeff

-Jeff
