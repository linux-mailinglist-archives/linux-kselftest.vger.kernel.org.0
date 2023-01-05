Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89EC65EE75
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jan 2023 15:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjAEOLl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Jan 2023 09:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjAEOLc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Jan 2023 09:11:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C75472C
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Jan 2023 06:11:32 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z4-20020a17090a170400b00226d331390cso1023702pjd.5
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jan 2023 06:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KI88ddFjWKkuzUOtDfBNJeuHrq8LZ9xQwEmrI18ahQs=;
        b=BOGgzGnWyZJLBdQXhLHwWy0IskfokqvbD02y+h83alCNPRx6k5voX92lS9WTcJEGai
         GF3pQ97xddFkg3pqTNXXsxHTZqwKevz+83E4rB8LCEN87i/fnpVe7yDI2liJNMqLURhP
         o/k0muKEP+LoTQJIeywSZH0r8v9HdYg0ACI7W/6RvA9SAjgxd1nTJfVryCE43vvWKdZD
         uUKbqaX2gp/pAAEnR9NWWBGMe6J6tSRgsNk3r1iE2SwnkNLODrd/CHCxYl8u9EArzcjt
         2lPoDchqj7UNSUwxgZbQmiu0iDi6eWEo5dT/7OnysYPuScY+y1AFP6Vhb/mhMZ1wenrD
         HbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KI88ddFjWKkuzUOtDfBNJeuHrq8LZ9xQwEmrI18ahQs=;
        b=wD5RvkdlaPpn2FSif6jUbcn7yHSzMYGsJplRT9BLHYOf72TDGyP0kVZQhpv6xuZBID
         Y5kB6Ed4LI9FL4UNPLkeqZNS9Mxi3nL+S18gFsHkdbOnfpgmAR9Ifotu+6vigNV9Wow4
         k0+Rurowetr8JbFfep0PlqErpclyVC22K/Oeuly4yzuu6GtiwXaLosdL4LTmzgECVdxH
         Jdv/t1T9BlLPYIpHYJaLlARGsCcFtl3yiG7CUl+AQyXT+sqe5RydARgBNulF5ycM3oJr
         YpiCImFM+WMLdKQvLt62H7aqwq2bxN5zoAzM2V2Vx7wyPOpg/ScV/LOVgUO8e0234cJi
         3A2Q==
X-Gm-Message-State: AFqh2kq0gekiwEBj8PtuDqdoA+YoXlqs1ywanyqymwHniM/jCNVssZAv
        whR+ImDTsEDcHtIdhu9Xo2ywHeE0o3OlSYgivmk1opdl+ZkGPsMNT/kn6EUQ0rjOhze1WDPT1jP
        wcJSO85b2Eb+zwobwL36NilNs1X8AakHiIUaC+eDR1YIbxbzYklAeBg5b/e5asNoRVj4JoikVIu
        oMqgygzBb6ClT4A7SmUU5rNAT1dc4I3b0RuefNt+EBdpdeuAKXMC8KvMTXK+vdPzpu2dsclgV+t
        A==
X-Google-Smtp-Source: AMrXdXs5UKVr9jYZzc/+xjXnT4UCr8Egwru9kdoZ1vXCxoIda0jQI/0KfN3UhAG1UmQcXsftQ24R1nbKCue9k/U3gGk=
X-Received: by 2002:a17:902:c245:b0:192:6195:44cd with SMTP id
 5-20020a170902c24500b00192619544cdmr3725829plg.126.1672927891556; Thu, 05 Jan
 2023 06:11:31 -0800 (PST)
MIME-Version: 1.0
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1> <Y7bT0OL8RAWkCu0Z@kroah.com>
In-Reply-To: <Y7bT0OL8RAWkCu0Z@kroah.com>
From:   "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date:   Thu, 5 Jan 2023 11:11:15 -0300
Message-ID: <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Pavel Boldin <pboldin@cloudlinux.com>,
        Pavel Boldin <boldin.pavel@gmail.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 5, 2023 at 10:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 05, 2023 at 08:35:05PM +0800, Aaron Lu wrote:
> > To capture potential programming errors like mistakenly setting Global
> > bit on kernel page table entries, a selftest for meltdown is added.
> >
> > This selftest is based on Pavel Boldin's work at:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c
> >
> > In addition to the existing test of reading kernel variable
> > saved_command_line from user space, one more test of reading user local
> > variable through kernel direct map address is added. For the existing
> > test(reading saved_command_line) to report a failure, both the high kernel
> > mapping and low kernel mapping have to be in leaked state; For the added
> > test(read local var), only low kernel mapping leak is enough to trigger
> > a test fail, so both tests are useful.
> >
> > Test results of 10 runs:
> >
> > On v6.1-rc8 with nopti kernel cmdline option:
> >
> > host              test_out_rate_1    test_out_rate_2
> > lkp-bdw-de1            50%               100%
> > lkp-hsw-d01            70%               100%
> > lkp-hsw-d02             0%                80%
> > lkp-hsw-d03            60%               100%
> > lkp-hsw-d04            20%               100%
> > lkp-hsw-d05            60%               100%
> > lkp-ivb-d01             0%                70%
> > lkp-kbl-d01           100%               100%
> > lkp-skl-d02           100%                90%
> > lkp-skl-d03            90%               100%
> > lkp-skl-d05            60%               100%
> > kbl-vm                100%                80%
> > 2 other machines have 0% rate for both tests.
> >
> > bdw=broadwell, hsw=haswell, ivb=ivybridge, etc.
> >
> > test_out_rate_1: test reports fail rate for the test of reading
> > saved_command_line from user space;
> > test_out_rate_2: test reports fail rate for the test of reading user
> > local variable through kernel direct map address in user space.
> >
> > On v5.19 without nopti cmdline option:
> > host              test_out_rate_2
> > lkp-bdw-de1            80%
> > lkp-hsw-4ex1           50%
> > lkp-hsw-d01            30%
> > lkp-hsw-d03            10%
> > lkp-hsw-d04            10%
> > lkp-kbl-d01            10%
> > kbl-vm                 80%
> > 7 other machines have 0% rate for test2.
> >
> > Also tested on an i386 VM with 512M memory and the test out rate is 100%
> > when adding nopti to kernel cmdline with v6.1-rc8.
> >
> > Main changes I made from Pavel Boldin's meltdown test are:
> > - Replace rdtscll() and clflush() with kernel's implementation;
> > - Reimplement find_symbol_in_file() to avoid bringing in LTP's library
> >   functions;
> > - Coding style changes: placing the function return type in the same
> >   line of the function.
> >
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > ---
> > Notable changes from RFC v3:
> > - Drop RFC tag;
> > - Change the base code from zlib licensed one to GPL licensed one.
>
> Sorry, but this still gets my NAK for the issues raised in previous
> reviews that are not addressed here for some reason :(

Greg, the selftest is no longer based on
https://github.com/IAIK/meltdown/blob/master/LICENSE, which is
originally zlib licensed. In this version, Aaron is basing the test on
https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c,
which is indeed licensed with: GPL-2.0-or-later

>
> greg k-h
