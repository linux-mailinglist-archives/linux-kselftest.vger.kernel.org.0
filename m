Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE8A18740F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Mar 2020 21:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbgCPUbJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Mar 2020 16:31:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46561 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732538AbgCPUbJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Mar 2020 16:31:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id y30so10358601pga.13
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Mar 2020 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSCfrC5MVAMPvsu9dcDXiK9/v75uuFCpGC851+yHoL4=;
        b=Ho5A8cWkUYfvTKQPdBbUqDGnZNatk8dR3geecakaiYgWgs2iB75NRwMFkXjpF9UfyI
         44iHGvholdldIETNBdpz5nllteDz78DwJHlzrxGA6jCy8tfzoXPpc3ns1Kw/W12voUyV
         R1cMf81FQGaE0dbbXHdtAc4Ht3UOPMSiY9MhLNVHDMXhbmeg3aizad2/fQwBO0iXQruF
         icofb2Oaxa+srP2vHozKm3e2boqYtvfLuFWr4SybFNTOFJfytt+PUe4jFZrY/8cNNpB/
         RMoag02LTf+ogJ7Lr2RCvjpKdd8Z1Fls3xZzPO5SVt3OTDAhqrSrx6nLNFo2mmX0tZcf
         jyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSCfrC5MVAMPvsu9dcDXiK9/v75uuFCpGC851+yHoL4=;
        b=Ox0ggRq5gADTIQDGX9r/vYjeTDdswfDqiWHJgJ1SO/8fcG2kkJbe1ABkaxlucfbz1A
         ANNxMRBlfcf+T+2zBXqWOyVPZh6j3TXYKNrPf+cWV6RVjPszng2/r579nsuiaAva4b7A
         6YLK/swHHW5+k6AM4amvxmCp6WY6iowpuCbUxjF3Aieog3AyQUziUX48gI8/K3XoWA+7
         kt1LiiRajYTXhsmer9ABuGadeAtrk7n2XpCW25D1gNT46Uhu5ANItouN+pR/nQGvhJlc
         AjQ87QRIeJQtAe7vJKiwAqvFY1k83681GIxYOcn7HbIec5T8N8ArrqpvxeZbfPy2APIw
         zJow==
X-Gm-Message-State: ANhLgQ0q0qxBcOkeXabRVG1IaAmhrQ9cPPPXYba5jLzqKj//aFgbRB17
        5+VcM/bDt8ZqjyMar9di33fuapKxga3QwlaE1ml64w==
X-Google-Smtp-Source: ADFU+vvdH3hGZiNHfp5iBR00/N+6sETjH64ZPyloW2OjEXctpOITNNnPDqaRsU+jDGfek6xVGRXod7j6HF3TvbF0BZY=
X-Received: by 2002:a63:dd06:: with SMTP id t6mr1491334pgg.384.1584390668326;
 Mon, 16 Mar 2020 13:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200316202125.15852-1-heidifahim@google.com> <20200316202125.15852-2-heidifahim@google.com>
In-Reply-To: <20200316202125.15852-2-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 16 Mar 2020 13:30:57 -0700
Message-ID: <CAFd5g478+t3b2rVOUJmD_wGH=cLYMYfbWeWogMB8C6LK7DotRA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: Run all KUnit tests through allyesconfig
To:     Heidi Fahim <heidifahim@google.com>
Cc:     shuah <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 16, 2020 at 1:21 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Implemented the functionality to run all KUnit tests through kunit_tool
> by specifying an --alltests flag, which builds UML with allyesconfig
> enabled, and consequently runs every KUnit test. A new function was
> added to kunit_kernel: make_allyesconfig.
> Firstly, if --alltests is specified, kunit.py triggers build_um_kernel
> which call make_allyesconfig. This function calls the make command,
> disables the broken configs that would otherwise prevent UML from
> building, then starts the kernel with all possible configurations
> enabled. All stdout and stderr is sent to test.log and read from there
> then fed through kunit_parser to parse the tests to the user. Also added
> a signal_handler in case kunit is interrupted while running.
> Tested: Run under different conditions such as testing with
> --raw_output, testing program interrupt then immediately running kunit
> again without --alltests and making sure to clean the console.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
