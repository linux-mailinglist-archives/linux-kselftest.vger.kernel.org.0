Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53A33C8FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfFKKay (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 06:30:54 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:55354 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfFKKay (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 06:30:54 -0400
Received: by mail-it1-f169.google.com with SMTP id i21so3977654ita.5
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2019 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wqV28W+k6Y5J5PTchHnXNKYR2DeyBwGb+Z0TkQBdK9s=;
        b=LZMHerGyaHA0BlQ6Jf192bW/drTNszGg94TvCqBxKon2JPwB/AaoHvI/QK1xT+XAnC
         u2Rgt2IvpsPV7MRR0wwcI5PdFGqAsXjWcNulaxMLaam1BNZ2whA/RTMdGaFEvrYzlxgc
         fAkPgFPwsibaahkXo1tZ9ybNvqKAzkxo2lbbcRVKupntns53irArcHS6q/dRLWBzGZ+b
         LZlUeTRio1M66aJN7BTv97WS0M72iAPUyiXnSFdiZs5d1i0k/VfhOZD19Ym7b3ltnbnb
         M0xYVGOBDvmj0Sc46rhHuAIg2Q39IoNXoNLwa2nhSDwZz/jDCMJA0IGSJPaMjhOiSz0w
         iDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wqV28W+k6Y5J5PTchHnXNKYR2DeyBwGb+Z0TkQBdK9s=;
        b=NRVmHaHxRv7ZSknHB10mR+hIrt0Uw13SXctSEO0vc4GA9P+2U8OfOargQxzz2uLe6r
         EpMQAZylVgyQbCCQFbxHEoKZrpfTaxAH/GHDiK7yJFjoUxEOa+ZFMeGP6em30GLTdOsC
         sYVV5Oy+xcwa/Q5glXKcd+c4hiq1i3TxqqxnxDnijq1/xvx/UVScwcOxnlxk8votC+3P
         dn+ekAt/xHCpgf5seX9u5kpxwcl25jzQ7B1SN76Jpru96IBOHqxFoQZDCSQkK+Iwe14p
         hVLU/7fbpUVker575iI8GpR9O0uFZUoavmgeKobbN3mXx+0hYRnW87ETBEQBZJXaYN4y
         YeeA==
X-Gm-Message-State: APjAAAXGYkH/+5gPYtgVU/0Rs7nawZnMma90LBsskfUgBl8phx+zMpoX
        rn5tatM/aJS5M6zK08IycLxbuCEDxVMT5VgIbUfuSjBBBhCDXQ==
X-Google-Smtp-Source: APXvYqwTYaT/b1M8OeYDnu3M+eRa/gbDYp8Tedn6sawAce128+14dURmtFKRap/ib2SSl70fK3VLagoG/AW1qY0ZJ0A=
X-Received: by 2002:a24:1d01:: with SMTP id 1mr12078524itj.83.1560249053408;
 Tue, 11 Jun 2019 03:30:53 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Jun 2019 12:30:42 +0200
Message-ID: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
Subject: kselftest build broken?
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

I've tried to build kselftests for several years now, but I always
find the build broken. Which makes me wonder if the instructions are
broken or something. I follow the instructions in
Documentation/dev-tools/kselftest.rst and start with "make -C
tools/testing/selftests". Here is the errors I get on the upstream
commit 16d72dd4891fecc1e1bf7ca193bb7d5b9804c038:

error: unable to create target: 'No available targets are compatible
with triple "bpf"'
1 error generated.
Makefile:259: recipe for target 'elfdep' failed
Makefile:156: recipe for target 'all' failed
Makefile:106: recipe for target
'/linux/tools/testing/selftests/bpf/libbpf.a' failed
test_execve.c:4:10: fatal error: cap-ng.h: No such file or directory
../lib.mk:138: recipe for target
'/linux/tools/testing/selftests/capabilities/test_execve' failed
gpio-mockup-chardev.c:20:10: fatal error: libmount.h: No such file or directory
<builtin>: recipe for target 'gpio-mockup-chardev' failed
fuse_mnt.c:17:10: fatal error: fuse.h: No such file or directory
../lib.mk:138: recipe for target
'/linux/tools/testing/selftests/memfd/fuse_mnt' failed
collect2: error: ld returned 1 exit status
../lib.mk:138: recipe for target
'/linux/tools/testing/selftests/mqueue/mq_open_tests' failed
reuseport_bpf_numa.c:24:10: fatal error: numa.h: No such file or directory
../lib.mk:138: recipe for target
'/linux/tools/testing/selftests/net/reuseport_bpf_numa' failed
mlock-random-test.c:8:10: fatal error: sys/capability.h: No such file
or directory
../lib.mk:138: recipe for target
'/linux/tools/testing/selftests/vm/mlock-random-test' failed

Here is full log:

https://gist.githubusercontent.com/dvyukov/47430636e160f297b657df5ba2efa82b/raw/7babc4db228b88f341a376c15e8bc9c4c3b02160/gistfile1.txt

I have libelf-dev installed. Do I need to install something else? Or
run some other command?

Thanks
