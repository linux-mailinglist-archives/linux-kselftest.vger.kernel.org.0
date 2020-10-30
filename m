Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4329FB70
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 03:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJ3ChN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Oct 2020 22:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3ChN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Oct 2020 22:37:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ACFC0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 19:37:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j30so5954049lfp.4
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 19:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xFYydufIASOT1348QHvdhcx054g3YPBB0GlnwkmPlA4=;
        b=fqY0QzTowsczinxLoi7p1YYNLXiVR+Y1eB50Shh+M4uY9e+S4mD6vAMFR1OALIsedD
         MqauLqgaFthhRU8wdL9elZGucHR9gtwwk0471Iz/x8n0b+FOO/QPNGMvzAiNilWkYSmg
         ZmxNqP1efDTCryrgA6gj3HKdkq/PM6kIELyKnEb1eLPGfXJD21ZJKp3aRW6YF3x7vKj4
         O+u71D45ZNiNHfCismLBiX85+LVKusxRIVLd07DLVBqmBYfJ1LSAX/Ji7HPyelS8iW2p
         VNegffHh7yIcdcoHmF94VNQgn/bKVQcCWTBdb0TRCAcbs7n9RBiaprWdveBmLDmn7pGn
         lQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xFYydufIASOT1348QHvdhcx054g3YPBB0GlnwkmPlA4=;
        b=gk72GbHJZDevaIVdKdMmfDR6EOH5fqy8tXPY1JhvgmxLBQNjPV38JBDUGpF/ULQTDm
         ojV8eOupvF8JCC0IT0Wce7rZKpFWqY1XuXIgkr4srxtpHwcj+6A95cMyvGurxkEF0Jwg
         kVOe/78oTURXrkpYsMR6Snk+AujGhESWEWah688E61UBns2VzWum5PK1P/fSxpW9bT2R
         IWoifbjT7uwzERDOVH2RWbYRucvnryXBBM7fROmBCNShoTEcsqsi9brDXIokfZaKuK6F
         kQk2K8/PDGx0RMZ60PZOWE4Avd53LYeIpho8WuBjN4XmPhfJW1rINeD4X8Vk0+UMcHD6
         GcKw==
X-Gm-Message-State: AOAM531mJT3ZrJHw8SPxtZBknaPQ8C0wfxibJXatkMp4WCVA2YhOzATA
        NzCbnyhX5Uis8dxU4d9gHX1yaS7BZysjZbDwW2IIm0Y63lVULA==
X-Google-Smtp-Source: ABdhPJyUQqafmlkZzWU1B91YkWKdrr/Hr9r99S3ohbNLGZnHZyRkPYMfEkd1tI0FXegIB2xTw60ou/cS/VrCEnK8aRQ=
X-Received: by 2002:a19:c357:: with SMTP id t84mr15909lff.34.1604025431105;
 Thu, 29 Oct 2020 19:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220929.4068251-1-dlatypov@google.com>
In-Reply-To: <20201029220929.4068251-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 30 Oct 2020 10:36:59 +0800
Message-ID: <CABVgOS=t4q2EOqvmNrDWJsfSV73GQpecQCOpoH_nMJt-ARuNJw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: print out stderr from make (like build warnings)
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 30, 2020 at 6:10 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently the tool redirects make stdout + stderr, and only shows them
> if the make command fails.
> This means build warnings aren't shown to the user.
>
> This change prints the contents of stderr even if make succeeds, under
> the assumption these are only build warnings or other messages the user
> likely wants to see.
>
> We drop stdout from the raised exception since we can no longer easily
> collate stdout and stderr and just showing the stderr seems fine.
>
> Example with a warning:
>
> [14:56:35] Building KUnit Kernel ...
> ../lib/kunit/kunit-test.c: In function =E2=80=98kunit_test_successful_try=
=E2=80=99:
> ../lib/kunit/kunit-test.c:19:6: warning: unused variable =E2=80=98unused=
=E2=80=99 [-Wunused-variable]
>    19 |  int unused;
>       |      ^~~~~~
>
> [14:56:40] Starting KUnit Kernel ...
>
> Note the stderr has a trailing \n, and since we use print, we add
> another, but it helps separate make and kunit.py output.
>
> Example with a build error:
>
> [15:02:45] Building KUnit Kernel ...
> ERROR:root:../lib/kunit/kunit-test.c: In function =E2=80=98kunit_test_suc=
cessful_try=E2=80=99:
> ../lib/kunit/kunit-test.c:19:2: error: unknown type name =E2=80=98invalid=
_type=E2=80=99
>    19 |  invalid_type *test =3D data;
>       |  ^~~~~~~~~~~~
> ...
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks a lot -- this was really bugging me, and works great.

Reviewed-by: David Gow <davidgow@google.com>
