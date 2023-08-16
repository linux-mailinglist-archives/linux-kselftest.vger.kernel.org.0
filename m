Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0477D9BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 07:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbjHPFOH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 01:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbjHPFN4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 01:13:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C399E7F
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 22:13:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4036bd4fff1so187861cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 22:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692162834; x=1692767634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQIHIan4UgwN8PNlutsYyTVZApetHryIC6JPWb8ty6E=;
        b=xj+Wh4p0ryCM6u+0ke6PF1ZKIWXPnqDCM2X2W+Vh9DRPemN7o1IAJXVlQ8ebnFqqy7
         NB7U1xgXTbtRiVUnO9pdj1QvGThirUh1JM05Vw9I419YXC633tnXWzTIBC/x0hDl57iM
         SXLip6VcckpF1MHVCBnihB7PTZRoG1mBeCVMydwHnvXdayx2z06NaEqfUhqT5+fW0oUX
         B1CdjQMpAjW7usda8p2facaUUSzGjgSNMg+GAiUrSMEcShzIkImShl1i71PjVsYqpp1f
         coNSn1PudFw4PPNwiHbMtK4K6AC60oBl36rXmDZrvkVKkUOm8eR95tMyvdM5xdaFsDap
         HEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692162834; x=1692767634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQIHIan4UgwN8PNlutsYyTVZApetHryIC6JPWb8ty6E=;
        b=hQzvWuLrF+Ekg8uCgHK5LUOHj5rv2I2ISRv/iegO6UCt8uZHb/8EShcCglmCF9yHXK
         4hSppsO0yFhlY+x21hrp5inmc0yPwbNiTlnKY5lYzqrH5uUcW/aFnZ1O+lYtrlL87lWB
         X2XSAAj8XI8wm7mtQSsAPsaFjjsd5p41tVJg43DI3yXfjczV/vbSm1CzcyHZ9VDmyn9i
         zKiJdbn5hIWvNd1K/pD7lRi4zuKSx1BFLMI8mhyG05paBsSksa+UJmyZeJA4YxMcjMj2
         84b+Yv78NDPw5XuOA/Z2FzHLldn5C8yRzJ2n42tWWP0sgLKSqtt3p1Uj2R8jyrwCPqKr
         FXoQ==
X-Gm-Message-State: AOJu0YwENDxiSbEiailwinIkQR7SEzJeMzxVl6geKWGR/cxVkdE6WULY
        MlA/5ptihcCsiy8B5WFtgllaa7FOTaaA3Y48mq3UDQ==
X-Google-Smtp-Source: AGHT+IGP4SVn8SCneg6CjJ1ixzGWEsewlhNhcVCZOTXpO5Wj/AlFbxwap6oQp9wibsgICq0L8WSBO0iTE4GHZgff8DY=
X-Received: by 2002:a05:622a:d5:b0:3ef:5f97:258f with SMTP id
 p21-20020a05622a00d500b003ef5f97258fmr142674qtw.16.1692162834282; Tue, 15 Aug
 2023 22:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com> <20230814-memfd-vm-noexec-uapi-fixes-v2-4-7ff9e3e10ba6@cyphar.com>
In-Reply-To: <20230814-memfd-vm-noexec-uapi-fixes-v2-4-7ff9e3e10ba6@cyphar.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 15 Aug 2023 22:13:18 -0700
Message-ID: <CALmYWFvxLee5+RyLh=vo6kpwMVS-_C7BJ9kmTPDa2tetgHOHPw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] memfd: replace ratcheting feature from
 vm.memfd_noexec with hierarchy
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 1:41=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> This sysctl has the very unusual behaviour of not allowing any user (even
> CAP_SYS_ADMIN) to reduce the restriction setting, meaning that if you
> were to set this sysctl to a more restrictive option in the host pidns
> you would need to reboot your machine in order to reset it.
>
> The justification given in [1] is that this is a security feature and
> thus it should not be possible to disable. Aside from the fact that we
> have plenty of security-related sysctls that can be disabled after being
> enabled (fs.protected_symlinks for instance), the protection provided by
> the sysctl is to stop users from being able to create a binary and then
> execute it. A user with CAP_SYS_ADMIN can trivially do this without
> memfd_create(2):
>
>   % cat mount-memfd.c
>   #include <fcntl.h>
>   #include <string.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <linux/mount.h>
>
>   #define SHELLCODE "#!/bin/echo this file was executed from this totally=
 private tmpfs:"
>
>   int main(void)
>   {
>         int fsfd =3D fsopen("tmpfs", FSOPEN_CLOEXEC);
>         assert(fsfd >=3D 0);
>         assert(!fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 2));
>
>         int dfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
>         assert(dfd >=3D 0);
>
>         int execfd =3D openat(dfd, "exe", O_CREAT | O_RDWR | O_CLOEXEC, 0=
782);
>         assert(execfd >=3D 0);
>         assert(write(execfd, SHELLCODE, strlen(SHELLCODE)) =3D=3D strlen(=
SHELLCODE));
>         assert(!close(execfd));
>
>         char *execpath =3D NULL;
>         char *argv[] =3D { "bad-exe", NULL }, *envp[] =3D { NULL };
>         execfd =3D openat(dfd, "exe", O_PATH | O_CLOEXEC);
>         assert(execfd >=3D 0);
>         assert(asprintf(&execpath, "/proc/self/fd/%d", execfd) > 0);
>         assert(!execve(execpath, argv, envp));
>   }
>   % ./mount-memfd
>   this file was executed from this totally private tmpfs: /proc/self/fd/5
>   %
>
> Given that it is possible for CAP_SYS_ADMIN users to create executable
> binaries without memfd_create(2) and without touching the host
> filesystem (not to mention the many other things a CAP_SYS_ADMIN process
> would be able to do that would be equivalent or worse), it seems strange
> to cause a fair amount of headache to admins when there doesn't appear
> to be an actual security benefit to blocking this. There appear to be
> concerns about confused-deputy-esque attacks[2] but a confused deputy tha=
t
> can write to arbitrary sysctls is a bigger security issue than
> executable memfds.
>
Something to point out: The demo code might be enough to prove your
case in other distributions, however, in ChromeOS, you can't run this
code. The executable in ChromeOS are all from known sources and
verified at boot.
If an attacker could run this code in ChromeOS, that means the
attacker already acquired arbitrary code execution through other ways,
at that point, the attacker no longer needs to create/find an
executable memfd, they already have the vehicle. You can't use an
example of an attacker already running arbitrary code to prove that
disable downgrading is useless.
I agree it is a big problem that an attacker already can modify a
sysctl.  Assuming this can happen by controlling arguments passed into
sysctl, at the time, the attacker might not have full arbitrary code
execution yet, that is the reason the original design is so
restrictive.

Best regards,
-Jeff
