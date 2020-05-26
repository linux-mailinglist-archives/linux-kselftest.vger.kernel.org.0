Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899051E22D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 15:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEZNVe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 09:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgEZNVe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 09:21:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B0DC03E96D
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 06:21:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id be9so17627507edb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kR/Y8SdNvO0bkGw+Ri/0kUOMzzCgyixz2CAGCI76tRY=;
        b=czD4F9qigBNeGyXPIbFCIv3FrBYFR/n0ih6udSVEh6QQ6lj0PVNzfLnvsLWflsEAMH
         o+TmtqggjfrF29k1DjPoIUpBiwoH+oNc85ndZf0xFM2dXUikxUEFb9F0lFRCWMgqbNX8
         iatTPcMldn+Zviur0CpQWpr0aYyePZqXE2tjcrW3PdS5N777VfusPhvGW0bs2SwsESGr
         pEwB81pULK/sj991qkYSXz1CMwGbd/D43uvnmvHAIucRNsl/L4YblVjCZaimbh60lFQz
         7YLC7tJ2Az27tieHZYzTmHbLZRklZk8SX6wUWooaI1S5NOQwmhDvJPuSHWpHZTluOh4m
         x2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kR/Y8SdNvO0bkGw+Ri/0kUOMzzCgyixz2CAGCI76tRY=;
        b=sTPp10pUjArPmaOD9iniFoaF+JX5/bULrCcMlYddwB96DIEfrBqT9nfWKaEtRtJO2Q
         9hszrYeaMWHRaMXBugwddK6bUtamngHaQJl9SoL6NYTi3e7Eu5f/fxRVUm/5D6oCuceJ
         bXO4/G6K2SfpS7Q3oKTg/vC2CZP3qCcDMkEsQUEnl/dog46ruQHjx1OMjgT6v2+WhW+p
         Jz442EyFbAcpwuQwIy77d5itmS3jDJQyGtFFw/caHQsiCMWSVxWo/pn4e/O70pALEObg
         k6pMwlPF/tLLWfjUstA6326nYw2OBUpQUAz8514dqFaAzl3LZYXRQRgq/uVV+pphE5ue
         aANQ==
X-Gm-Message-State: AOAM530QnUlNCgUahpJHIi0F08n/BtKSj29pDKwl3EBKJ4GMlRF6d7ER
        vIm+jveXBHRlN9DhzEGkZmT5UtWp7Oi2sfHaH4ZGv9B3yo0=
X-Google-Smtp-Source: ABdhPJzlHoGBnghLF89HY/rh9zq5spIXoQnwrlRyDldonoT0x1VXCzZC9jIbP0t/nvi3Xg6IN+IrnC6axm1uuVZ5VKg=
X-Received: by 2002:a05:6402:1adc:: with SMTP id ba28mr19566820edb.14.1590499291501;
 Tue, 26 May 2020 06:21:31 -0700 (PDT)
MIME-Version: 1.0
From:   vaibhav jadhav <vaibhavjadhav.linuxmailing@gmail.com>
Date:   Tue, 26 May 2020 18:51:19 +0530
Message-ID: <CAFzyPPSvjVh6m5XJTLtEJWYt82kpBzhfpj8EnXvvGrV-hh4nhg@mail.gmail.com>
Subject: Kselftest pstore test failure on riscv
To:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

To run the Kselftest pstore test suite I use following:

Hardware: Freedom U540
Architecture: RISCV
Kernel: 5.4.3

Steps followed to run the test:
1.Cloning linux kernel sources from https://github.com/torvalds/linux.git
2.Extracting it.
3.From the cloned kernel source top directory running: # make -C
tools/testing/selftests/ TARGETS=pstore run_tests

Following is the log:
make: Entering directory '/mnt/linux-master/tools/testing/selftests'
make --no-builtin-rules ARCH=riscv -C ../../.. headers_install
make[1]: Entering directory '/mnt/linux-master'
  INSTALL ./usr/include
make[1]: Leaving directory '/mnt/linux-master'
make[1]: Entering directory '/mnt/linux-master/tools/testing/selftests/pstore'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/mnt/linux-master/tools/testing/selftests/pstore'
make[1]: Entering directory '/mnt/linux-master/tools/testing/selftests/pstore'
TAP version 13
1..2
# selftests: pstore: pstore_tests
# === Pstore unit tests (pstore_tests) ===
# UUID=a5947bf3-bc04-4175-ac85-4056024cbc4b
# Checking pstore backend is registered ... ok
#     backend=(null)
#     cmdline=earlycon=sbi earlycon=sbi root=/dev/mmcblk0p3 rootwait
console=ttySIF0 console=tty0
# Checking pstore console is registered ... FAIL
# Checking /dev/pmsg0 exists ... FAIL
# Writing unique string to /dev/pmsg0 ... FAIL
not ok 1 selftests: pstore: pstore_tests # exit=1
# selftests: pstore: pstore_post_reboot_tests
# === Pstore unit tests (pstore_post_reboot_tests) ===
# UUID=265706d3-ab26-4568-842c-2cf1756ad9db
# Checking pstore backend is registered ... ok
#     backend=(null)
#     cmdline=earlycon=sbi earlycon=sbi root=/dev/mmcblk0p3 rootwait
console=ttySIF0 console=tty0
# pstore_crash_test has not been executed yet. we skip further tests.
not ok 2 selftests: pstore: pstore_post_reboot_tests # SKIP
make[1]: Leaving directory '/mnt/linux-master/tools/testing/selftests/pstore'
make: Leaving directory '/mnt/linux-master/tools/testing/selftests'

Trying to find reasons for failue:
# Checking pstore console is registered ... FAIL
# Checking /dev/pmsg0 exists ... FAIL
# Writing unique string to /dev/pmsg0 ... FAIL

Thankyou
