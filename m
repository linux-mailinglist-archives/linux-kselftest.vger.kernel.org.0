Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A4F6AD7E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 07:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCGG7R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 01:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCGG6q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 01:58:46 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA3252AB
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 22:58:04 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id f17so8203201uax.7
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 22:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678172282;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xOri0YYJ5NS7U4H0ruVU6CafbE/ITr9yJ4TlL7q9GiY=;
        b=rS9ocLjAyDNsMzHxEEUtWJn0sCkfTJilYqFPwnSDGDMX1r2911VQ0aQrcgCyISF2Bq
         H8yi+F9FYTHsgsIZWpRmYuvQH4AQcMwCRpQAlvbKOWMlWVJ/hqiRQ7bMW8yCVxVQhQYI
         9EAueeNy5NhoviOzdJ3YvcZBkEvQFRaJXz7pLvTDLBA5X/O8uI7wZ4YsvOCxvziofQqz
         xE41elcmnlX9Ml8iG6Ol3lAWiPBpxQ+m7mlNbb5PS27E0X3Ef95r5dbpZWWMBBAmQSY9
         njR+R8vr7fdnPRyyzkkI6X6sfcYCsJao8QFbjkwXWXJWqNAInvChth6vnD41vjWXtYZA
         VN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172282;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xOri0YYJ5NS7U4H0ruVU6CafbE/ITr9yJ4TlL7q9GiY=;
        b=rHN9S93lA9dhNxIOFlZQcr/It6FiBq7o6kGbgYaDPF79J6p/ii1bglg1vhYR2y/PO3
         aMz6atnJz7pc+oMHKI4x2KLL4s0FMgC7Xh7vFwoXtbrgcQgTBvo9ikNONGZRjGpUWWM1
         8fmwWXJ2Xqrm5dE14ZEh6VR34cdBmseNtpXqppLsfQOs4x1+oEycYzXIyBR8bpMsZh61
         VbymCV6/6xPcahG8glsM/PDB16vXu5KzcCoYN8xBZPw9xKrNrvDm/qcm3m2oPZgim/KL
         ceqj7A8usJ2XPgpi+RSOXWydMFMb2oQMDvU9D5XlsavTjGuHxhL1nH0gYeQd7bs2bZW4
         Ab1w==
X-Gm-Message-State: AO0yUKWmbQnbq4oMOKArwcWjl32fbZ9mXspMGjBRJHijaTZN2x5ilggR
        BLss4nnNOHDlMNbKC0brlefri0geur+zAjuRyzXL78BNP6xsfhkukao=
X-Google-Smtp-Source: AK7set8mVP90VI6DxUik+GetZvSOY6Z/jAzDuPXzSe7I8eD1DkNrgnghlHMmkECl2xkTVaKGdLse2WheabYxsO3RQ+8=
X-Received: by 2002:a1f:cec4:0:b0:40e:fee9:667a with SMTP id
 e187-20020a1fcec4000000b0040efee9667amr8624630vkg.3.1678172281936; Mon, 06
 Mar 2023 22:58:01 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Mar 2023 12:27:51 +0530
Message-ID: <CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com>
Subject: selftests: sigaltstack: sas # exit=1 - # Bail out! SP is not on
 sigaltstack - on clang build
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-api@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest: sigaltstack built with clang-16 getting failed but passed with
gcc-12 build. Please find more details about test logs on clang-16 and
gcc-12 and steps to reproduce locally on your machine by using tuxrun.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
----------

Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake) (Debian clang
version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.41),
Debian LLD 16.0.0) #1 SMP PREEMPT @1678159722
...
kselftest: Running tests in sigaltstack
TAP version 13
1..1
# selftests: sigaltstack: sas
# # [NOTE] the stack size is 21104
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# Bail out! SP is not on sigaltstack
# # Planned tests != run tests (3 != 1)
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: sigaltstack: sas # exit=1

Links,
  qemu-x86_64:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15303778/suite/kselftest-sigaltstack/test/sigaltstack_sas/details/

  qemu-arm64:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302557/suite/kselftest-sigaltstack/tests/
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302557/suite/kselftest-sigaltstack/test/sigaltstack_sas/log

kselftest: sigaltstack built with gcc-12 getting pass.

Test log:
---------
Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
for Debian) 2.40) #1 SMP PREEMPT @1678159736
...
kselftest: Running tests in sigaltstack
TAP version 13
1..1
# selftests: sigaltstack: sas
# # [NOTE] the stack size is 50080
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# # [RUN] signal USR1
# ok 2 sigaltstack is disabled in sighandler
# # [RUN] switched to user ctx
# # [RUN] signal USR2
# # [OK] Stack preserved
# ok 3 sigaltstack is still SS_AUTODISARM after signal
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sigaltstack: sas

Links,
 qemu-x86_64:
   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15303751/suite/kselftest-sigaltstack/tests/

 qemu-arm64:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302458/suite/kselftest-sigaltstack/tests/
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302458/suite/kselftest-sigaltstack/test/sigaltstack_sas/log



Steps to reproduce:
--------------

# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.37.2
#
# See https://tuxrun.org/ for complete documentation.

tuxrun  \
 --runtime podman  \
 --device qemu-x86_64  \
 --boot-args rw  \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXLbLsvBufVn1MrsnXVZ133Bf/bzImage
 \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXLbLsvBufVn1MrsnXVZ133Bf/modules.tar.xz
 \
 --rootfs https://storage.tuxboot.com/debian/bookworm/amd64/rootfs.ext4.xz  \
 --parameters SKIPFILE=skipfile-lkft.yaml  \
 --parameters KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXLbLsvBufVn1MrsnXVZ133Bf/kselftest.tar.xz
 \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f  \
 --tests kselftest-sigaltstack  \
 --timeouts boot=15


--
Linaro LKFT
https://lkft.linaro.org
