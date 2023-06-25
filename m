Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB073D1D3
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjFYPml (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjFYPmk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 11:42:40 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB67DE66
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Jun 2023 08:42:35 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so307139f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Jun 2023 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687707755; x=1690299755;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fUvLrDDP5ORCm09e3T3oL2DHCo29oFLZoe6Uf9DtRnI=;
        b=Rjvpt159VZR8hM4Zg/duOBUKXBVv/6kAbEPW63J/m0wX1MYTdsnw++R4eHTDuyoyur
         8sMpNwLYq7jle4/hCF+oByPeStDdxBYkFodLuLqd3+sySt5TNIYZBPX0d2idHQxjkPfA
         Os5nmbZa8OhyKldVloL1WkqVX3A+gNXTlSfFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687707755; x=1690299755;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUvLrDDP5ORCm09e3T3oL2DHCo29oFLZoe6Uf9DtRnI=;
        b=g1pjcQipbkoPMxERcrzCKqHfYB+n4nMB+/9prNiN6/yo9ge3N/3FLmpOS1XfPtPDy7
         /oJvjlLtv6pS+aRg48P8dyI7jlj4WuvjdSk81boy6If79szChr6pCnjP0kHF9ov1KZdI
         b7NZyvXRyugjOMAQMsjM/skmYST9y7xnJHiTHwgvoFQZ0djjvvVafSKyMNw33UPaAIdN
         NlpZdbjOKb3aByjCxISXwb20jALopVJhndcVaeU3curge1FdGyhC1GgfKsQtUhVLVgSP
         wYq223evfbjMIifleJ/8oS9najVeKCj3CnjpokKtqLlnrB7jBd0G8GCpygFCe3CNrmDs
         lLww==
X-Gm-Message-State: AC+VfDxHMDp3L/XKISZbN1Qr+RcWJJ5QOOm+quE/INVdCiP0L+gH7ChG
        8IanGcTVA73S3GE6qWtruO4oiw==
X-Google-Smtp-Source: ACHHUZ5GEK5wUlLd/tXn3TkXHmsU6lydvLJw8+K57iXvT0+V0UiiRnJvcRcmoCy4gsdiSQ9lzH0tmw==
X-Received: by 2002:a05:6602:481a:b0:783:4d85:4172 with SMTP id ed26-20020a056602481a00b007834d854172mr1205939iob.2.1687707755097;
        Sun, 25 Jun 2023 08:42:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k26-20020a6b3c1a000000b0076c569c7a48sm1455793iob.39.2023.06.25.08.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 08:42:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------lXflhxVjGJkywNDDqdxwRMlp"
Message-ID: <b0bb8387-9216-0fe7-61e9-7e2daceeef20@linuxfoundation.org>
Date:   Sun, 25 Jun 2023 09:42:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 6.5-rc1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------lXflhxVjGJkywNDDqdxwRMlp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 6.5-rc1.

This kselftest update for Linux 6.5-rc1 consists of:

- change to allow runners to override the timeout
   This change is made to avoid future increases of long
   timeouts
- several other spelling and cleanups
- a new subtest to video_device_test
- enhancements to test coverage in clone3 test
- other fixes to ftrace and cpufreq tests

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

   Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.5-rc1

for you to fetch changes up to 8cd0d8633e2de4e6dd9ddae7980432e726220fdb:

   selftests/ftace: Fix KTAP output ordering (2023-06-12 16:40:22 -0600)

----------------------------------------------------------------
linux-kselftest-next-6.5-rc1

This kselftest update for Linux 6.5-rc1 consists of:

- change to allow runners to override the timeout
   This change is made to avoid future increases of long
   timeouts
- several other spelling and cleanups
- a new subtest to video_device_test
- enhancements to test coverage in clone3 test
- other fixes to ftrace and cpufreq tests

----------------------------------------------------------------
Akanksha J N (1):
       selftests/ftrace: Add new test case which checks for optimized probes

Colin Ian King (2):
       selftests: prctl: Fix spelling mistake "anonynous" -> "anonymous"
       kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REALTIME is undefined

Ivan Orlov (1):
       selftests: media_tests: Add new subtest to video_device_test

Luis Chamberlain (1):
       selftests: allow runners to override the timeout

Mark Brown (2):
       selftests/cpufreq: Don't enable generic lock debugging options
       selftests/ftace: Fix KTAP output ordering

Rishabh Bhatnagar (1):
       kselftests: Sort the collections list to avoid duplicate tests

Tobias Klauser (1):
       selftests/clone3: test clone3 with exit signal in flags

Ziqi Zhao (1):
       selftest: pidfd: Omit long and repeating outputs

  Documentation/dev-tools/kselftest.rst              |  22 ++++
  tools/testing/selftests/clone3/clone3.c            |   5 +-
  tools/testing/selftests/cpufreq/config             |   8 --
  tools/testing/selftests/ftrace/ftracetest          |   2 +-
  .../ftrace/test.d/kprobe/kprobe_opt_types.tc       |  34 +++++++
  tools/testing/selftests/kselftest/runner.sh        |  11 +-
  .../selftests/media_tests/video_device_test.c      | 111 +++++++++++++++------
  tools/testing/selftests/pidfd/pidfd.h              |   1 -
  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c  |   1 +
  tools/testing/selftests/pidfd/pidfd_test.c         |   3 +-
  .../selftests/prctl/set-anon-vma-name-test.c       |   2 +-
  tools/testing/selftests/run_kselftest.sh           |   7 +-
  .../selftests/vDSO/vdso_test_clock_getres.c        |   4 +-
  13 files changed, 166 insertions(+), 45 deletions(-)
  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc

----------------------------------------------------------------
--------------lXflhxVjGJkywNDDqdxwRMlp
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-6.5-rc1.diff"
Content-Disposition: attachment; filename="linux-kselftest-next-6.5-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2tzZWxmdGVzdC5yc3QgYi9E
b2N1bWVudGF0aW9uL2Rldi10b29scy9rc2VsZnRlc3QucnN0CmluZGV4IDEyYjU3NWI3NmIy
MC4uZGQyMTRhZjdiN2ZmIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9r
c2VsZnRlc3QucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2tzZWxmdGVzdC5y
c3QKQEAgLTE2OCw2ICsxNjgsMjggQEAgdGhlIGAtdGAgb3B0aW9uIGZvciBzcGVjaWZpYyBz
aW5nbGUgdGVzdHMuIEVpdGhlciBjYW4gYmUgdXNlZCBtdWx0aXBsZSB0aW1lczo6CiAKIEZv
ciBvdGhlciBmZWF0dXJlcyBzZWUgdGhlIHNjcmlwdCB1c2FnZSBvdXRwdXQsIHNlZW4gd2l0
aCB0aGUgYC1oYCBvcHRpb24uCiAKK1RpbWVvdXQgZm9yIHNlbGZ0ZXN0cworPT09PT09PT09
PT09PT09PT09PT09CisKK1NlbGZ0ZXN0cyBhcmUgZGVzaWduZWQgdG8gYmUgcXVpY2sgYW5k
IHNvIGEgZGVmYXVsdCB0aW1lb3V0IGlzIHVzZWQgb2YgNDUKK3NlY29uZHMgZm9yIGVhY2gg
dGVzdC4gVGVzdHMgY2FuIG92ZXJyaWRlIHRoZSBkZWZhdWx0IHRpbWVvdXQgYnkgYWRkaW5n
CithIHNldHRpbmdzIGZpbGUgaW4gdGhlaXIgZGlyZWN0b3J5IGFuZCBzZXQgYSB0aW1lb3V0
IHZhcmlhYmxlIHRoZXJlIHRvIHRoZQorY29uZmlndXJlZCBhIGRlc2lyZWQgdXBwZXIgdGlt
ZW91dCBmb3IgdGhlIHRlc3QuIE9ubHkgYSBmZXcgdGVzdHMgb3ZlcnJpZGUKK3RoZSB0aW1l
b3V0IHdpdGggYSB2YWx1ZSBoaWdoZXIgdGhhbiA0NSBzZWNvbmRzLCBzZWxmdGVzdHMgc3Ry
aXZlcyB0byBrZWVwCitpdCB0aGF0IHdheS4gVGltZW91dHMgaW4gc2VsZnRlc3RzIGFyZSBu
b3QgY29uc2lkZXJlZCBmYXRhbCBiZWNhdXNlIHRoZQorc3lzdGVtIHVuZGVyIHdoaWNoIGEg
dGVzdCBydW5zIG1heSBjaGFuZ2UgYW5kIHRoaXMgY2FuIGFsc28gbW9kaWZ5IHRoZQorZXhw
ZWN0ZWQgdGltZSBpdCB0YWtlcyB0byBydW4gYSB0ZXN0LiBJZiB5b3UgaGF2ZSBjb250cm9s
IG92ZXIgdGhlIHN5c3RlbXMKK3doaWNoIHdpbGwgcnVuIHRoZSB0ZXN0cyB5b3UgY2FuIGNv
bmZpZ3VyZSBhIHRlc3QgcnVubmVyIG9uIHRob3NlIHN5c3RlbXMgdG8KK3VzZSBhIGdyZWF0
ZXIgb3IgbG93ZXIgdGltZW91dCBvbiB0aGUgY29tbWFuZCBsaW5lIGFzIHdpdGggdGhlIGAt
b2Agb3IKK3RoZSBgLS1vdmVycmlkZS10aW1lb3V0YCBhcmd1bWVudC4gRm9yIGV4YW1wbGUg
dG8gdXNlIDE2NSBzZWNvbmRzIGluc3RlYWQKK29uZSB3b3VsZCB1c2U6CisKKyAgICQgLi9y
dW5fa3NlbGZ0ZXN0LnNoIC0tb3ZlcnJpZGUtdGltZW91dCAxNjUKKworWW91IGNhbiBsb29r
IGF0IHRoZSBUQVAgb3V0cHV0IHRvIHNlZSBpZiB5b3UgcmFuIGludG8gdGhlIHRpbWVvdXQu
IFRlc3QKK3J1bm5lcnMgd2hpY2gga25vdyBhIHRlc3QgbXVzdCBydW4gdW5kZXIgYSBzcGVj
aWZpYyB0aW1lIGNhbiB0aGVuIG9wdGlvbmFsbHkKK3RyZWF0IHRoZXNlIHRpbWVvdXRzIHRo
ZW4gYXMgZmF0YWwuCisKIFBhY2thZ2luZyBzZWxmdGVzdHMKID09PT09PT09PT09PT09PT09
PT0KIApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25l
My5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lMy5jCmluZGV4IGU0
OTVmODk1YTJjZC4uZTYwY2Y0ZGE4ZmIwIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9jbG9uZTMvY2xvbmUzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
Y2xvbmUzL2Nsb25lMy5jCkBAIC0xMjksNyArMTI5LDcgQEAgaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKmFyZ3ZbXSkKIAl1aWRfdCB1aWQgPSBnZXR1aWQoKTsKIAogCWtzZnRfcHJpbnRf
aGVhZGVyKCk7Ci0Ja3NmdF9zZXRfcGxhbigxOCk7CisJa3NmdF9zZXRfcGxhbigxOSk7CiAJ
dGVzdF9jbG9uZTNfc3VwcG9ydGVkKCk7CiAKIAkvKiBKdXN0IGEgc2ltcGxlIGNsb25lMygp
IHNob3VsZCByZXR1cm4gMC4qLwpAQCAtMTk4LDUgKzE5OCw4IEBAIGludCBtYWluKGludCBh
cmdjLCBjaGFyICphcmd2W10pCiAJLyogRG8gYSBjbG9uZTMoKSBpbiBhIG5ldyB0aW1lIG5h
bWVzcGFjZSAqLwogCXRlc3RfY2xvbmUzKENMT05FX05FV1RJTUUsIDAsIDAsIENMT05FM19B
UkdTX05PX1RFU1QpOwogCisJLyogRG8gYSBjbG9uZTMoKSB3aXRoIGV4aXQgc2lnbmFsIChT
SUdDSExEKSBpbiBmbGFncyAqLworCXRlc3RfY2xvbmUzKFNJR0NITEQsIDAsIC1FSU5WQUws
IENMT05FM19BUkdTX05PX1RFU1QpOworCiAJa3NmdF9maW5pc2hlZCgpOwogfQpkaWZmIC0t
Z2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY3B1ZnJlcS9jb25maWcgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9jcHVmcmVxL2NvbmZpZwppbmRleCA3NWU5MDA3OTNlOGEuLmNl
NTA2OGY1YTZhMiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY3B1ZnJl
cS9jb25maWcKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY3B1ZnJlcS9jb25maWcK
QEAgLTUsMTEgKzUsMyBAQCBDT05GSUdfQ1BVX0ZSRVFfR09WX1VTRVJTUEFDRT15CiBDT05G
SUdfQ1BVX0ZSRVFfR09WX09OREVNQU5EPXkKIENPTkZJR19DUFVfRlJFUV9HT1ZfQ09OU0VS
VkFUSVZFPXkKIENPTkZJR19DUFVfRlJFUV9HT1ZfU0NIRURVVElMPXkKLUNPTkZJR19ERUJV
R19SVF9NVVRFWEVTPXkKLUNPTkZJR19ERUJVR19QTElTVD15Ci1DT05GSUdfREVCVUdfU1BJ
TkxPQ0s9eQotQ09ORklHX0RFQlVHX01VVEVYRVM9eQotQ09ORklHX0RFQlVHX0xPQ0tfQUxM
T0M9eQotQ09ORklHX1BST1ZFX0xPQ0tJTkc9eQotQ09ORklHX0xPQ0tERVA9eQotQ09ORklH
X0RFQlVHX0FUT01JQ19TTEVFUD15CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9mdHJhY2UvZnRyYWNldGVzdCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFj
ZS9mdHJhY2V0ZXN0CmluZGV4IDI1MDY2MjFlNzVkZi4uY2I1ZjE4YzA2NTkzIDEwMDc1NQot
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvZnRyYWNldGVzdAorKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvZnRyYWNldGVzdApAQCAtMzAxLDcgKzMw
MSw3IEBAIGt0YXB0ZXN0KCkgeyAjIHJlc3VsdCBjb21tZW50CiAgICAgY29tbWVudD0iIyAk
Y29tbWVudCIKICAgZmkKIAotICBlY2hvICRDQVNFTk8gJHJlc3VsdCAkSU5TVEFOQ0UkQ0FT
RU5BTUUgJGNvbW1lbnQKKyAgZWNobyAkcmVzdWx0ICRDQVNFTk8gJElOU1RBTkNFJENBU0VO
QU1FICRjb21tZW50CiB9CiAKIGV2YWxfcmVzdWx0KCkgeyAjIHNpZ3ZhbApkaWZmIC0tZ2l0
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9rcHJvYmUva3Byb2Jl
X29wdF90eXBlcy50YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQv
a3Byb2JlL2twcm9iZV9vcHRfdHlwZXMudGMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMDAwMDAwLi45ZjVkOTkzMjgwODYKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2twcm9iZS9rcHJvYmVfb3B0X3R5cGVz
LnRjCkBAIC0wLDAgKzEsMzQgQEAKKyMhL2Jpbi9zaAorIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorIyBDb3B5cmlnaHQgKEMpIDIwMjMgQWthbmtzaGEg
SiBOLCBJQk0gY29ycG9yYXRpb24KKyMgZGVzY3JpcHRpb246IFJlZ2lzdGVyL3VucmVnaXN0
ZXIgb3B0aW1pemVkIHByb2JlCisjIHJlcXVpcmVzOiBrcHJvYmVfZXZlbnRzCisKK2Nhc2Ug
YHVuYW1lIC1tYCBpbgoreDg2XzY0KQorOzsKK2FybSopCis7OworcHBjKikKKzs7CisqKQor
ICBlY2hvICJQbGVhc2UgaW1wbGVtZW50IG90aGVyIGFyY2hpdGVjdHVyZSBoZXJlIgorICBl
eGl0X3Vuc3VwcG9ydGVkCitlc2FjCisKK0RFRkFVTFQ9JChjYXQgL3Byb2Mvc3lzL2RlYnVn
L2twcm9iZXMtb3B0aW1pemF0aW9uKQorZWNobyAxID4gL3Byb2Mvc3lzL2RlYnVnL2twcm9i
ZXMtb3B0aW1pemF0aW9uCitmb3IgaSBpbiBgc2VxIDAgMjU1YDsgZG8KKyAgICAgICAgZWNo
byAgInA6dGVzdHByb2JlICRGVU5DVElPTl9GT1JLKyR7aX0iID4ga3Byb2JlX2V2ZW50cyB8
fCBjb250aW51ZQorICAgICAgICBlY2hvIDEgPiBldmVudHMva3Byb2Jlcy9lbmFibGUgfHwg
Y29udGludWUKKyAgICAgICAgKGVjaG8gImZvcmtlZCIpCisJUFJPQkU9JChncmVwICRGVU5D
VElPTl9GT1JLIC9zeXMva2VybmVsL2RlYnVnL2twcm9iZXMvbGlzdCkKKyAgICAgICAgZWNo
byAwID4gZXZlbnRzL2twcm9iZXMvZW5hYmxlCisgICAgICAgIGVjaG8gPiBrcHJvYmVfZXZl
bnRzCisJaWYgZWNobyAkUFJPQkUgfCBncmVwIC1xIE9QVElNSVpFRDsgdGhlbgorICAgICAg
ICAgICAgICAgIGVjaG8gIiRERUZBVUxUIiA+ICAvcHJvYy9zeXMvZGVidWcva3Byb2Jlcy1v
cHRpbWl6YXRpb24KKyAgICAgICAgICAgICAgICBleGl0X3Bhc3MKKyAgICAgICAgZmkKK2Rv
bmUKK2VjaG8gIiRERUZBVUxUIiA+ICAvcHJvYy9zeXMvZGVidWcva3Byb2Jlcy1vcHRpbWl6
YXRpb24KK2V4aXRfdW5yZXNvbHZlZApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3NlbGZ0ZXN0L3J1bm5lci5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tz
ZWxmdGVzdC9ydW5uZXIuc2gKaW5kZXggMjk0NjE5YWRlNDlmLi4xYzk1MmQxNDAxZDQgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC9ydW5uZXIuc2gK
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0L3J1bm5lci5zaApAQCAt
OCw3ICs4LDggQEAgZXhwb3J0IGxvZ2ZpbGU9L2Rldi9zdGRvdXQKIGV4cG9ydCBwZXJfdGVz
dF9sb2dnaW5nPQogCiAjIERlZmF1bHRzIGZvciAic2V0dGluZ3MiIGZpbGUgZmllbGRzOgot
IyAidGltZW91dCIgaG93IG1hbnkgc2Vjb25kcyB0byBsZXQgZWFjaCB0ZXN0IHJ1biBiZWZv
cmUgZmFpbGluZy4KKyMgInRpbWVvdXQiIGhvdyBtYW55IHNlY29uZHMgdG8gbGV0IGVhY2gg
dGVzdCBydW4gYmVmb3JlIHJ1bm5pbmcKKyMgb3ZlciBvdXIgc29mdCB0aW1lb3V0IGxpbWl0
LgogZXhwb3J0IGtzZWxmdGVzdF9kZWZhdWx0X3RpbWVvdXQ9NDUKIAogIyBUaGVyZSBpc24n
dCBhIHNoZWxsLWFnbm9zdGljIHdheSB0byBmaW5kIHRoZSBwYXRoIG9mIGEgc291cmNlZCBm
aWxlLApAQCAtOTAsNiArOTEsMTQgQEAgcnVuX29uZSgpCiAJCWRvbmUgPCAiJHNldHRpbmdz
IgogCWZpCiAKKwkjIENvbW1hbmQgbGluZSB0aW1lb3V0IG92ZXJyaWRlcyB0aGUgc2V0dGlu
Z3MgZmlsZQorCWlmIFsgLW4gIiRrc2VsZnRlc3Rfb3ZlcnJpZGVfdGltZW91dCIgXTsgdGhl
bgorCQlrc2VsZnRlc3RfdGltZW91dD0iJGtzZWxmdGVzdF9vdmVycmlkZV90aW1lb3V0Igor
CQllY2hvICIjIG92ZXJyaWRpbmcgdGltZW91dCB0byAka3NlbGZ0ZXN0X3RpbWVvdXQiID4+
ICIkbG9nZmlsZSIKKwllbHNlCisJCWVjaG8gIiMgdGltZW91dCBzZXQgdG8gJGtzZWxmdGVz
dF90aW1lb3V0IiA+PiAiJGxvZ2ZpbGUiCisJZmkKKwogCVRFU1RfSERSX01TRz0ic2VsZnRl
c3RzOiAkRElSOiAkQkFTRU5BTUVfVEVTVCIKIAllY2hvICIjICRURVNUX0hEUl9NU0ciCiAJ
aWYgWyAhIC1lICIkVEVTVCIgXTsgdGhlbgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvbWVkaWFfdGVzdHMvdmlkZW9fZGV2aWNlX3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL21lZGlhX3Rlc3RzL3ZpZGVvX2RldmljZV90ZXN0LmMKaW5kZXggMGY2
YWVmMmUyNTkzLi4yYzQ0ZTExNWYyZjAgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL21lZGlhX3Rlc3RzL3ZpZGVvX2RldmljZV90ZXN0LmMKKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbWVkaWFfdGVzdHMvdmlkZW9fZGV2aWNlX3Rlc3QuYwpAQCAtMzcs
NDUgKzM3LDU4IEBACiAjaW5jbHVkZSA8dGltZS5oPgogI2luY2x1ZGUgPGxpbnV4L3ZpZGVv
ZGV2Mi5oPgogCi1pbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCisjZGVmaW5lIFBS
SU9SSVRZX01BWCA0CisKK2ludCBwcmlvcml0eV90ZXN0KGludCBmZCkKIHsKLQlpbnQgb3B0
OwotCWNoYXIgdmlkZW9fZGV2WzI1Nl07Ci0JaW50IGNvdW50OwotCXN0cnVjdCB2NGwyX3R1
bmVyIHZ0dW5lcjsKLQlzdHJ1Y3QgdjRsMl9jYXBhYmlsaXR5IHZjYXA7CisJLyogVGhpcyB0
ZXN0IHdpbGwgdHJ5IHRvIHVwZGF0ZSB0aGUgcHJpb3JpdHkgYXNzb2NpYXRlZCB3aXRoIGEg
ZmlsZSBkZXNjcmlwdG9yICovCisKKwllbnVtIHY0bDJfcHJpb3JpdHkgb2xkX3ByaW9yaXR5
LCBuZXdfcHJpb3JpdHksIHByaW9yaXR5X3RvX2NvbXBhcmU7CiAJaW50IHJldDsKLQlpbnQg
ZmQ7CisJaW50IHJlc3VsdCA9IDA7CiAKLQlpZiAoYXJnYyA8IDIpIHsKLQkJcHJpbnRmKCJV
c2FnZTogJXMgWy1kIDwvZGV2L3ZpZGVvWD5dXG4iLCBhcmd2WzBdKTsKLQkJZXhpdCgtMSk7
CisJcmV0ID0gaW9jdGwoZmQsIFZJRElPQ19HX1BSSU9SSVRZLCAmb2xkX3ByaW9yaXR5KTsK
KwlpZiAocmV0IDwgMCkgeworCQlwcmludGYoIkZhaWxlZCB0byBnZXQgcHJpb3JpdHk6ICVz
XG4iLCBzdHJlcnJvcihlcnJubykpOworCQlyZXR1cm4gLTE7CisJfQorCW5ld19wcmlvcml0
eSA9IChvbGRfcHJpb3JpdHkgKyAxKSAlIFBSSU9SSVRZX01BWDsKKwlyZXQgPSBpb2N0bChm
ZCwgVklESU9DX1NfUFJJT1JJVFksICZuZXdfcHJpb3JpdHkpOworCWlmIChyZXQgPCAwKSB7
CisJCXByaW50ZigiRmFpbGVkIHRvIHNldCBwcmlvcml0eTogJXNcbiIsIHN0cmVycm9yKGVy
cm5vKSk7CisJCXJldHVybiAtMTsKKwl9CisJcmV0ID0gaW9jdGwoZmQsIFZJRElPQ19HX1BS
SU9SSVRZLCAmcHJpb3JpdHlfdG9fY29tcGFyZSk7CisJaWYgKHJldCA8IDApIHsKKwkJcHJp
bnRmKCJGYWlsZWQgdG8gZ2V0IG5ldyBwcmlvcml0eTogJXNcbiIsIHN0cmVycm9yKGVycm5v
KSk7CisJCXJlc3VsdCA9IC0xOworCQlnb3RvIGNsZWFudXA7CisJfQorCWlmIChwcmlvcml0
eV90b19jb21wYXJlICE9IG5ld19wcmlvcml0eSkgeworCQlwcmludGYoIlByaW9yaXR5IHdh
c24ndCBzZXQgLSB0ZXN0IGZhaWxlZFxuIik7CisJCXJlc3VsdCA9IC0xOwogCX0KIAotCS8q
IFByb2Nlc3MgYXJndW1lbnRzICovCi0Jd2hpbGUgKChvcHQgPSBnZXRvcHQoYXJnYywgYXJn
diwgImQ6IikpICE9IC0xKSB7Ci0JCXN3aXRjaCAob3B0KSB7Ci0JCWNhc2UgJ2QnOgotCQkJ
c3RybmNweSh2aWRlb19kZXYsIG9wdGFyZywgc2l6ZW9mKHZpZGVvX2RldikgLSAxKTsKLQkJ
CXZpZGVvX2RldltzaXplb2YodmlkZW9fZGV2KS0xXSA9ICdcMCc7Ci0JCQlicmVhazsKLQkJ
ZGVmYXVsdDoKLQkJCXByaW50ZigiVXNhZ2U6ICVzIFstZCA8L2Rldi92aWRlb1g+XVxuIiwg
YXJndlswXSk7Ci0JCQlleGl0KC0xKTsKLQkJfQorY2xlYW51cDoKKwlyZXQgPSBpb2N0bChm
ZCwgVklESU9DX1NfUFJJT1JJVFksICZvbGRfcHJpb3JpdHkpOworCWlmIChyZXQgPCAwKSB7
CisJCXByaW50ZigiRmFpbGVkIHRvIHJlc3RvcmUgcHJpb3JpdHk6ICVzXG4iLCBzdHJlcnJv
cihlcnJubykpOworCQlyZXR1cm4gLTE7CiAJfQorCXJldHVybiByZXN1bHQ7Cit9CisKK2lu
dCBsb29wX3Rlc3QoaW50IGZkKQoreworCWludCBjb3VudDsKKwlzdHJ1Y3QgdjRsMl90dW5l
ciB2dHVuZXI7CisJc3RydWN0IHY0bDJfY2FwYWJpbGl0eSB2Y2FwOworCWludCByZXQ7CiAK
IAkvKiBHZW5lcmF0ZSByYW5kb20gbnVtYmVyIG9mIGludGVyYXRpb25zICovCiAJc3JhbmQo
KHVuc2lnbmVkIGludCkgdGltZShOVUxMKSk7CiAJY291bnQgPSByYW5kKCk7CiAKLQkvKiBP
cGVuIFZpZGVvIGRldmljZSBhbmQga2VlcCBpdCBvcGVuICovCi0JZmQgPSBvcGVuKHZpZGVv
X2RldiwgT19SRFdSKTsKLQlpZiAoZmQgPT0gLTEpIHsKLQkJcHJpbnRmKCJWaWRlbyBEZXZp
Y2Ugb3BlbiBlcnJubyAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKLQkJZXhpdCgtMSk7Ci0J
fQotCiAJcHJpbnRmKCJcbk5vdGU6XG4iCiAJICAgICAgICJXaGlsZSB0ZXN0IGlzIHJ1bm5p
bmcsIHJlbW92ZSB0aGUgZGV2aWNlIG9yIHVuYmluZFxuIgogCSAgICAgICAiZHJpdmVyIGFu
ZCBlbnN1cmUgdGhlcmUgYXJlIG5vIHVzZSBhZnRlciBmcmVlIGVycm9yc1xuIgpAQCAtOTgs
NCArMTExLDQ2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJc2xlZXAo
MTApOwogCQljb3VudC0tOwogCX0KKwlyZXR1cm4gMDsKK30KKworaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQoreworCWludCBvcHQ7CisJY2hhciB2aWRlb19kZXZbMjU2XTsK
KwlpbnQgZmQ7CisJaW50IHRlc3RfcmVzdWx0OworCisJaWYgKGFyZ2MgPCAyKSB7CisJCXBy
aW50ZigiVXNhZ2U6ICVzIFstZCA8L2Rldi92aWRlb1g+XVxuIiwgYXJndlswXSk7CisJCWV4
aXQoLTEpOworCX0KKworCS8qIFByb2Nlc3MgYXJndW1lbnRzICovCisJd2hpbGUgKChvcHQg
PSBnZXRvcHQoYXJnYywgYXJndiwgImQ6IikpICE9IC0xKSB7CisJCXN3aXRjaCAob3B0KSB7
CisJCWNhc2UgJ2QnOgorCQkJc3RybmNweSh2aWRlb19kZXYsIG9wdGFyZywgc2l6ZW9mKHZp
ZGVvX2RldikgLSAxKTsKKwkJCXZpZGVvX2RldltzaXplb2YodmlkZW9fZGV2KS0xXSA9ICdc
MCc7CisJCQlicmVhazsKKwkJZGVmYXVsdDoKKwkJCXByaW50ZigiVXNhZ2U6ICVzIFstZCA8
L2Rldi92aWRlb1g+XVxuIiwgYXJndlswXSk7CisJCQlleGl0KC0xKTsKKwkJfQorCX0KKwor
CS8qIE9wZW4gVmlkZW8gZGV2aWNlIGFuZCBrZWVwIGl0IG9wZW4gKi8KKwlmZCA9IG9wZW4o
dmlkZW9fZGV2LCBPX1JEV1IpOworCWlmIChmZCA9PSAtMSkgeworCQlwcmludGYoIlZpZGVv
IERldmljZSBvcGVuIGVycm5vICVzXG4iLCBzdHJlcnJvcihlcnJubykpOworCQlleGl0KC0x
KTsKKwl9CisKKwl0ZXN0X3Jlc3VsdCA9IHByaW9yaXR5X3Rlc3QoZmQpOworCWlmICghdGVz
dF9yZXN1bHQpCisJCXByaW50ZigiUHJpb3JpdHkgdGVzdCAtIFBBU1NFRFxuIik7CisJZWxz
ZQorCQlwcmludGYoIlByaW9yaXR5IHRlc3QgLSBGQUlMRURcbiIpOworCisJbG9vcF90ZXN0
KGZkKTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3Bp
ZGZkLmggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZC5oCmluZGV4IDY5
MjJkNjQxN2UxYy4uODhkNjgzMGVlMDA0IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9waWRmZC9waWRmZC5oCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Bp
ZGZkL3BpZGZkLmgKQEAgLTkwLDcgKzkwLDYgQEAgc3RhdGljIGlubGluZSBpbnQgd2FpdF9m
b3JfcGlkKHBpZF90IHBpZCkKIAl9CiAKIAlyZXQgPSBXRVhJVFNUQVRVUyhzdGF0dXMpOwot
CWtzZnRfcHJpbnRfbXNnKCJ3YWl0cGlkIFdFWElUU1RBVFVTPSVkXG4iLCByZXQpOwogCXJl
dHVybiByZXQ7CiB9CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Bp
ZGZkL3BpZGZkX2ZkaW5mb190ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRm
ZC9waWRmZF9mZGluZm9fdGVzdC5jCmluZGV4IDNmZDhlOTAzMTE4Zi4uNGU4NmY5Mjc4ODBj
IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF9mZGlu
Zm9fdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX2Zk
aW5mb190ZXN0LmMKQEAgLTE0Myw2ICsxNDMsNyBAQCBzdGF0aWMgaW5saW5lIGludCBjaGls
ZF9qb2luKHN0cnVjdCBjaGlsZCAqY2hpbGQsIHN0cnVjdCBlcnJvciAqZXJyKQogCQlyID0g
LTE7CiAJfQogCisJa3NmdF9wcmludF9tc2coIndhaXRwaWQgV0VYSVRTVEFUVVM9JWRcbiIs
IHIpOwogCXJldHVybiByOwogfQogCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9waWRmZC9waWRmZF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRm
ZC9waWRmZF90ZXN0LmMKaW5kZXggZTJkZDRlZDg0OTg0Li4wMGEwN2U3YzU3MWMgMTAwNjQ0
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3Rlc3QuYworKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF90ZXN0LmMKQEAgLTExNSw3
ICsxMTUsOCBAQCBzdGF0aWMgaW50IHRlc3RfcGlkZmRfc2VuZF9zaWduYWxfZXhpdGVkX2Zh
aWwodm9pZCkKIAogCXBpZGZkID0gb3BlbihidWYsIE9fRElSRUNUT1JZIHwgT19DTE9FWEVD
KTsKIAotCSh2b2lkKXdhaXRfZm9yX3BpZChwaWQpOworCXJldCA9IHdhaXRfZm9yX3BpZChw
aWQpOworCWtzZnRfcHJpbnRfbXNnKCJ3YWl0cGlkIFdFWElUU1RBVFVTPSVkXG4iLCByZXQp
OwogCiAJaWYgKHBpZGZkIDwgMCkKIAkJa3NmdF9leGl0X2ZhaWxfbXNnKApkaWZmIC0tZ2l0
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcHJjdGwvc2V0LWFub24tdm1hLW5hbWUtdGVz
dC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcHJjdGwvc2V0LWFub24tdm1hLW5hbWUt
dGVzdC5jCmluZGV4IDI2ZDg1M2M1YTBjMS4uNDI3NWNiMjU2ZGNlIDEwMDY0NAotLS0gYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9wcmN0bC9zZXQtYW5vbi12bWEtbmFtZS10ZXN0LmMK
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcHJjdGwvc2V0LWFub24tdm1hLW5hbWUt
dGVzdC5jCkBAIC05Nyw3ICs5Nyw3IEBAIFRFU1RfRih2bWEsIHJlbmFtaW5nKSB7CiAJVEhf
TE9HKCJUcnkgdG8gcGFzcyBpbnZhbGlkIG5hbWUgKHdpdGggbm9uLXByaW50YWJsZSBjaGFy
YWN0ZXIgXFwxKSB0byByZW5hbWUgdGhlIFZNQSIpOwogCUVYUEVDVF9FUShyZW5hbWVfdm1h
KCh1bnNpZ25lZCBsb25nKXNlbGYtPnB0cl9hbm9uLCBBUkVBX1NJWkUsIEJBRF9OQU1FKSwg
LUVJTlZBTCk7CiAKLQlUSF9MT0coIlRyeSB0byByZW5hbWUgbm9uLWFub255bm91cyBWTUEi
KTsKKwlUSF9MT0coIlRyeSB0byByZW5hbWUgbm9uLWFub255bW91cyBWTUEiKTsKIAlFWFBF
Q1RfRVEocmVuYW1lX3ZtYSgodW5zaWduZWQgbG9uZykgc2VsZi0+cHRyX25vdF9hbm9uLCBB
UkVBX1NJWkUsIEdPT0RfTkFNRSksIC1FSU5WQUwpOwogfQogCmRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydW5fa3NlbGZ0ZXN0LnNoIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcnVuX2tzZWxmdGVzdC5zaAppbmRleCA5NzE2NWE4M2RmNjMuLjkyNzQzOTgw
ZTU1MyAxMDA3NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcnVuX2tzZWxmdGVz
dC5zaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydW5fa3NlbGZ0ZXN0LnNoCkBA
IC0yNiw2ICsyNiw3IEBAIFVzYWdlOiAkMCBbT1BUSU9OU10KICAgLWwgfCAtLWxpc3QJCQlM
aXN0IHRoZSBhdmFpbGFibGUgY29sbGVjdGlvbjp0ZXN0IGVudHJpZXMKICAgLWQgfCAtLWRy
eS1ydW4JCURvbid0IGFjdHVhbGx5IHJ1biBhbnkgdGVzdHMKICAgLWggfCAtLWhlbHAJCQlT
aG93IHRoaXMgdXNhZ2UgaW5mbworICAtbyB8IC0tb3ZlcnJpZGUtdGltZW91dAlOdW1iZXIg
b2Ygc2Vjb25kcyBhZnRlciB3aGljaCB3ZSB0aW1lb3V0CiBFT0YKIAlleGl0ICQxCiB9CkBA
IC0zMyw2ICszNCw3IEBAIEVPRgogQ09MTEVDVElPTlM9IiIKIFRFU1RTPSIiCiBkcnlydW49
IiIKK2tzZWxmdGVzdF9vdmVycmlkZV90aW1lb3V0PSIiCiB3aGlsZSB0cnVlOyBkbwogCWNh
c2UgIiQxIiBpbgogCQktcyB8IC0tc3VtbWFyeSkKQEAgLTUxLDYgKzUzLDkgQEAgd2hpbGUg
dHJ1ZTsgZG8KIAkJLWQgfCAtLWRyeS1ydW4pCiAJCQlkcnlydW49ImVjaG8iCiAJCQlzaGlm
dCA7OworCQktbyB8IC0tb3ZlcnJpZGUtdGltZW91dCkKKwkJCWtzZWxmdGVzdF9vdmVycmlk
ZV90aW1lb3V0PSIkMiIKKwkJCXNoaWZ0IDIgOzsKIAkJLWggfCAtLWhlbHApCiAJCQl1c2Fn
ZSAwIDs7CiAJCSIiKQpAQCAtODUsNyArOTAsNyBAQCBpZiBbIC1uICIkVEVTVFMiIF07IHRo
ZW4KIAlhdmFpbGFibGU9IiQoZWNobyAiJHZhbGlkIiB8IHNlZCAtZSAncy8gL1xuL2cnKSIK
IGZpCiAKLWNvbGxlY3Rpb25zPSQoZWNobyAiJGF2YWlsYWJsZSIgfCBjdXQgLWQ6IC1mMSB8
IHVuaXEpCitjb2xsZWN0aW9ucz0kKGVjaG8gIiRhdmFpbGFibGUiIHwgY3V0IC1kOiAtZjEg
fCBzb3J0IHwgdW5pcSkKIGZvciBjb2xsZWN0aW9uIGluICRjb2xsZWN0aW9ucyA7IGRvCiAJ
WyAtdyAvZGV2L2ttc2cgXSAmJiBlY2hvICJrc2VsZnRlc3Q6IFJ1bm5pbmcgdGVzdHMgaW4g
JGNvbGxlY3Rpb24iID4+IC9kZXYva21zZwogCXRlc3RzPSQoZWNobyAiJGF2YWlsYWJsZSIg
fCBncmVwICJeJGNvbGxlY3Rpb246IiB8IGN1dCAtZDogLWYyKQpkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfY2xvY2tfZ2V0cmVzLmMgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29fdGVzdF9jbG9ja19nZXRyZXMuYwpp
bmRleCAxNWRjZWUxNmZmNzIuLjM4ZDQ2YThiZjdjYiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfY2xvY2tfZ2V0cmVzLmMKKysrIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfY2xvY2tfZ2V0cmVzLmMKQEAg
LTg0LDEyICs4NCwxMiBAQCBzdGF0aWMgaW5saW5lIGludCB2ZHNvX3Rlc3RfY2xvY2sodW5z
aWduZWQgaW50IGNsb2NrX2lkKQogCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
CiB7Ci0JaW50IHJldDsKKwlpbnQgcmV0ID0gMDsKIAogI2lmIF9QT1NJWF9USU1FUlMgPiAw
CiAKICNpZmRlZiBDTE9DS19SRUFMVElNRQotCXJldCA9IHZkc29fdGVzdF9jbG9jayhDTE9D
S19SRUFMVElNRSk7CisJcmV0ICs9IHZkc29fdGVzdF9jbG9jayhDTE9DS19SRUFMVElNRSk7
CiAjZW5kaWYKIAogI2lmZGVmIENMT0NLX0JPT1RUSU1FCg==

--------------lXflhxVjGJkywNDDqdxwRMlp--
