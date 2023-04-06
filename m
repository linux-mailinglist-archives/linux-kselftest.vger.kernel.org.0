Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853906D93F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 12:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjDFK1S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 06:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbjDFK1P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 06:27:15 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E33C12;
        Thu,  6 Apr 2023 03:27:14 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id dw4so12059098qkb.10;
        Thu, 06 Apr 2023 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680776832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKHYiJH86czCteQw3t0gPmm0rVsFJxuWCCtAJ1eRpng=;
        b=p4/tDTZ4e6vVezjF3sZSmRKDd5HTdoOxKtd5WYZn+KeLTWJyPvrf8JyLDBYknd70kn
         +mSmdwfZQc/ouuwp+g/M9go83TrpwmVA/wca4ef9xlY0P6f+RibklUNWEckuYzD3mbVr
         6gtX4jEwhGgNWnwJFSPFdgDAJrfrYK0zEszSyG1oqfYHZuTald5ovV81DBhwrNvVsVI3
         BqHmCZt4AnORdFzMI4OOQwLz9w5vKKssXQgaCMkm+ZBKne/xu2EAvgR6OagCpp3XsasY
         P2kHlTCE7MS5LK5cFKCBVbMDPY+9BlPF50KTXGY32MtVH5KXFtRt6KAYVp0fBBRJTzX8
         crWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680776832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKHYiJH86czCteQw3t0gPmm0rVsFJxuWCCtAJ1eRpng=;
        b=48xodL6jh1tjHDzfmr1pVbQ9fCWgQAWE2tELGCswuG1M40sBW2H1H5X1UrWgJlmX06
         HFp0GwY4pOCb1pZaLemjSy0Z4PCBKP769Go2GYEtFMrTMrFSmAsTcX5Ir9Cosvqvmog9
         DF3wUequ4fPZRe6XmoCvNqZ8E/f5Y5PbE/RwAQ0He5rYq26QxQe7PEGEN1RA4RCJYYCr
         MdGMRTGSqsJH6LmcT/k3fTwS7k8QVFpF1waElgCMKvVT0xAUKGBtLo+oll6atxC1BtOh
         MLBefwKMF4HNj8EHZizRE9kop1KV9E2BOEROwmPduS1NRSGa+Uii1nCr7Fu0cx3DXF+K
         VMkw==
X-Gm-Message-State: AAQBX9cbThXHBGLtJzSte00REvgqn4WsAMH6VzQMH7s3MWMwRxethUrP
        mDoTuQbFJLiSNWV7Xul6D8++SZINNRtpax7dXp8=
X-Google-Smtp-Source: AKy350atjzlo6Zxcs+pePfnODHDiYSug84zs6Jww12Uuksk0Fg4XkvSpGpww/mK21Xcw4USo/V2FAPalTkoApXDfarI=
X-Received: by 2002:a05:620a:4415:b0:742:412d:1dc6 with SMTP id
 v21-20020a05620a441500b00742412d1dc6mr2418559qkp.14.1680776832227; Thu, 06
 Apr 2023 03:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <ZC6OHBjdwBdT4sSb@xpf.sh.intel.com>
In-Reply-To: <ZC6OHBjdwBdT4sSb@xpf.sh.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Apr 2023 13:26:36 +0300
Message-ID: <CAHp75VebjkJZkC=0ubGSVYm75M6sFAHt3kq=WqqfDmtBJrvVDQ@mail.gmail.com>
Subject: Re: [gpio kself-test & bisect] gpio-mockup.sh kslef-test failed in v6.3-rc5
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        heng.su@intel.com, linux-kselftest@vger.kernel.org, lkp@intel.com,
        linux-gpio@vger.kernel.org, john.fastabend@gmail.com,
        edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 6, 2023 at 12:15=E2=80=AFPM Pengfei Xu <pengfei.xu@intel.com> w=
rote:
>
> Hi Christophe Leroy and gpio experts,
>
> Greeting!
>
> Platform: Tigerlake-H and so on x86 platforms
>
> All detailed info is in link: https://github.com/xupengfe/syzkaller_logs/=
tree/main/issue_bisect/230406_gpio-mockup_kselftest_failed_bisect_v63rc5
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/issue_b=
isect/230406_gpio-mockup_kselftest_failed_bisect_v63rc5/bisect_info.txt
>
> gpio-mockup.sh kslef-test failed in v6.3-rc5 kernel.
> gpio-mockup.sh(gpio overflow test) in kself-test could reproduce this iss=
ue:
> cd linux/tools/testing/selftests
>  1.  ./kselftest_install.sh
>  2.  cd  linux/tools/testing/selftests/kselftest_install/gpio
>  # ./gpio-mockup.sh
>  1.  Module load tests
>  1.1.  dynamic allocation of gpio
>  2.  Module load error tests
>  2.1 gpio overflow
>  test failed: unexpected chip - gpiochip1
>  GPIO gpio-mockup test FAIL
>
> And the simplified steps to reproduce this issue are as follow:
> "
> # Load gpio_mockup with overflow ranges -1,1024:
> modprobe -q gpio_mockup gpio_mockup_ranges=3D"-1,1024"
>
> # Check is there some Call Trace generated in dmesg
> dmesg | grep -C 5 Call
>
> # Should not generate any gpiochip folder like /sys/kernel/debug/gpio-moc=
kup/gpiochip1
> # Because load gpio_mockup with overflow ranges -1,1024
> find "/sys/kernel/debug/gpio-mockup/" -name gpiochip* -type d | sort
>
> # Unload the gpio_mockup module
> modprobe -r gpio_mockup
> # Check is there "Call Trace" generated in dmesg
> dmesg | grep -C 5 Call
> "
>
> Actually the judgement "gpio-mockup.sh" test/bisect judgement point is th=
at:
> Should not generate any gpiochip folder like
> /sys/kernel/debug/gpio-mockup/gpiochip1 after load gpio_mockup with overf=
low
> ranges -1,1024.
>
> I met gpio-mockup.sh test failed but there is no any "Call Trace" dmesg i=
nfo
> sometimes.
>
> So the shortest check steps are as follow:
> "
> 1. modprobe -q gpio_mockup gpio_mockup_ranges=3D"-1,1024"
> After above gpio_mockup module loaded with overflow range "-1,1024":
> Correct behavior as previous v6.1 or older kernel:"gpio should not load "=
gpiochip1" due to overflow range -1,1024";
> Wrong behavior in v6.3-rc5 kernel: "gpio *load* "gpiochip1" with overflow=
 range -1,1024 and "gpiochip1" should not be loaded".
> The underlying problem was already buried here.
>
> 2. Could use below command to check if "gpiochip1" generated:
> As before v6.1,  there was no "/sys/kernel/debug/gpio-mockup/gpiochip1" s=
ysfs folder due to overflow range -1,1024";
> Wrong behavior in v6.3-rc5 kernel: "/sys/kernel/debug/gpio-mockup/gpiochi=
p1" sysfs folder generated as follow command check:
> # find "/sys/kernel/debug/gpio-mockup/" -name gpiochip* -type d | sort
> /sys/kernel/debug/gpio-mockup/gpiochip1
> If there is gpiochip* generated, gpio-mockup.sh kself-test would be faile=
d also.
> "
>
> Bisected and found the bad commit was:
> "
> 7b61212f2a07a5afd213c8876e52b5c9946441e2
> gpiolib: Get rid of ARCH_NR_GPIOS
> "
> And after reverted the above commit on top of v6.3-rc5 kernel, above
> gpio-mockup.sh kself-test could pass and this issue was gone.
>
> Now gpio-mockup.sh kself-test is failed on almost all x86 platform from
> v6.2 cycle mainline kernel.
>
> I hope above info is helpful to solve the "gpio-mockup.sh kself-test fail=
ed"
> problem.

Thank you for the report and full analysis of the root cause. I think
we may fix the test script however the gpio-mockup is obsoleted and
should be actually replaced with tests again gpio-sim.

--=20
With Best Regards,
Andy Shevchenko
