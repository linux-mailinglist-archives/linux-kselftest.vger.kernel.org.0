Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0256E7A25DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjIOShp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjIOShU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:20 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98181A8
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 11:37:11 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34fcb08d1d5so372345ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694803031; x=1695407831; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cfnip7ULTIi7KZXWuViwiWCrPhtMR7Auy+Rj1RxAe+s=;
        b=QaaMYMp4b/EkVuuitBpmfz8lw25T2b8Far8BfQpDQhbr4b1X0aOWt4tFrAGbpM+z6E
         ye7t9ZlNTRZCmDKs8uzlJhMLK3XhpYkAXzEWq8S0fl8odJZNNBnP/zrWKKj+AaiEo6kZ
         oMCZQdwCwIKJ9APJOxW6Rr1OiD+YtM40aWOUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803031; x=1695407831;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cfnip7ULTIi7KZXWuViwiWCrPhtMR7Auy+Rj1RxAe+s=;
        b=KAS+hWNBF+O4vF6og39oMA40h9GMpjqYJhaHlZ1Hr/w82KKTAj5+4td7CZXWQK8FVF
         c6GzcQE7FdrZprPE9fni2xCFPySSBl2u9WO/hGcn5MvFD21xRFwzypAxk0mFCcRSw0wA
         SLZ195eWf93AnlfRIuRmzdw6Eg/1fY7lnGrFAKwl/ZEsDohumIeJoK7UB9Q9AleW3TA/
         Rfs2IPOAKZiJxpIDxzK8OrjeqSPDowdeaM51qq421jY/jRHuq4spegX4Am3xPsY96Qd5
         144GnhkhC3qiD3P1UcSgzuoSP9z2OW8/jILKyUEYMZ7Ch+27JzMi7NlQRWv1jV6EnJoD
         4TxA==
X-Gm-Message-State: AOJu0YzNsOguDZ7VV29LUGgoR3dEdoI+o/wAOj261XBL6ij2Jw8m4Qio
        i6xDjkYnegrjf0AYKVuaGsZ1RA==
X-Google-Smtp-Source: AGHT+IEIB+d9FGpy7VcNBYz1xAdn+b3MUeB3utp92Jv0qXjC07ixC0F7vIRGbEVBovRZ8g/v5RjJZg==
X-Received: by 2002:a92:907:0:b0:34f:2e07:685b with SMTP id y7-20020a920907000000b0034f2e07685bmr3359929ilg.0.1694803031011;
        Fri, 15 Sep 2023 11:37:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h6-20020a926c06000000b00348c7e5e915sm1292962ilc.5.2023.09.15.11.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 11:37:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------QgCeCf9J1BZIBGDemSNwtt0j"
Message-ID: <9e0ad8c3-4441-d054-208f-657fe4faff5e@linuxfoundation.org>
Date:   Fri, 15 Sep 2023 12:37:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest second fixes update for Linux 6.6-rc2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------QgCeCf9J1BZIBGDemSNwtt0j
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following second Kselftest fixes update for Linux 6.6-rc2.

This kselftest fixes update for Linux 6.6-rc2 consists of important
fixes to user_events test and ftrace test.

user_events test has been enabled for default run in Linux 6.6-rc1. The
following fixes are for bugs found since then:

- adds checks for dependencies and skips the test. user_events test
   requires root access, and tracefs and user_events enabled. It leaves
   tracefs mounted and a fix is in progress for that missing piece.

- creates user_events test-specific Kconfig fragments.

ftrace test fixes:

- unmounts tracefs for recovering environment. Fix identified during the
   above mentioned user_events dependencies fix.

- adds softlink to latest log directory improving usage.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.6-rc2

for you to fetch changes up to 7e021da80f48582171029714f8a487347f29dddb:

   selftests: tracing: Fix to unmount tracefs for recovering environment (2023-09-12 09:34:20 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.6-rc2

This kselftest fixes update for Linux 6.6-rc2 consists of important
fixes to user_events test and ftrace test.

user_events test has been enabled for default run in Linux 6.6-rc1. The
following fixes are for bugs found since then:

- adds checks for dependencies and skips the test. user_events test
   requires root access, and tracefs and user_events enabled. It leaves
   tracefs mounted and a fix is in progress for that missing piece.

- creates user_events test-specific Kconfig fragments.

ftrace test fixes:

- unmounts tracefs for recovering environment. Fix identified during the
   above mentioned user_events dependencies fix.

- adds softlink to latest log directory improving usage.

----------------------------------------------------------------
Beau Belgrave (1):
       selftests/user_events: Fix failures when user_events is not installed

Masami Hiramatsu (Google) (1):
       selftests: tracing: Fix to unmount tracefs for recovering environment

Naresh Kamboju (1):
       selftests: user_events: create test-specific Kconfig fragments

Steven Rostedt (Google) (1):
       ftrace/selftests: Add softlink to latest log directory

  tools/testing/selftests/ftrace/ftracetest          |  18 +++-
  tools/testing/selftests/user_events/abi_test.c     |   3 +
  tools/testing/selftests/user_events/config         |   1 +
  tools/testing/selftests/user_events/dyn_test.c     |   2 +
  tools/testing/selftests/user_events/ftrace_test.c  |   3 +
  tools/testing/selftests/user_events/perf_test.c    |   3 +
.../selftests/user_events/user_events_selftests.h  | 100 +++++++++++++++++++++
  7 files changed, 129 insertions(+), 1 deletion(-)
  create mode 100644 tools/testing/selftests/user_events/config
  create mode 100644 tools/testing/selftests/user_events/user_events_selftests.h
----------------------------------------------------------------
--------------QgCeCf9J1BZIBGDemSNwtt0j
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.6-rc2.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.6-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9mdHJhY2V0ZXN0
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL2Z0cmFjZXRlc3QKaW5kZXggY2I1
ZjE4YzA2NTkzLi5jNzc4ZDRkY2MxN2UgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2Z0cmFjZS9mdHJhY2V0ZXN0CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Z0cmFjZS9mdHJhY2V0ZXN0CkBAIC0zMSw2ICszMSw5IEBAIGVycl9yZXQ9MQogIyBrc2Vs
ZnRlc3Qgc2tpcCBjb2RlIGlzIDQKIGVycl9za2lwPTQKIAorIyB1bW91bnQgcmVxdWlyZWQK
K1VNT1VOVF9ESVI9IiIKKwogIyBjZ3JvdXAgUlQgc2NoZWR1bGluZyBwcmV2ZW50cyBjaHJ0
IGNvbW1hbmRzIGZyb20gc3VjY2VlZGluZywgd2hpY2gKICMgaW5kdWNlcyBmYWlsdXJlcyBp
biB0ZXN0IHdha2V1cCB0ZXN0cy4gIERpc2FibGUgZm9yIHRoZSBkdXJhdGlvbiBvZgogIyB0
aGUgdGVzdHMuCkBAIC00NSw2ICs0OCw5IEBAIHNldHVwKCkgewogCiBjbGVhbnVwKCkgewog
ICBlY2hvICRzY2hlZF9ydF9ydW50aW1lX29yaWcgPiAkc2NoZWRfcnRfcnVudGltZQorICBp
ZiBbIC1uICIke1VNT1VOVF9ESVJ9IiBdOyB0aGVuCisgICAgdW1vdW50ICR7VU1PVU5UX0RJ
Un0gfHw6CisgIGZpCiB9CiAKIGVycmV4aXQoKSB7ICMgbWVzc2FnZQpAQCAtMTI0LDYgKzEz
MCw3IEBAIHBhcnNlX29wdHMoKSB7ICMgb3B0cwogICAgIDs7CiAgICAgLS1sb2dkaXJ8LWwp
CiAgICAgICBMT0dfRElSPSQyCisgICAgICBMSU5LX1BUUj0KICAgICAgIHNoaWZ0IDIKICAg
ICA7OwogICAgICoudGMpCkBAIC0xNjAsMTEgKzE2NywxMyBAQCBpZiBbIC16ICIkVFJBQ0lO
R19ESVIiIF07IHRoZW4KIAkgICAgbW91bnQgLXQgdHJhY2VmcyBub2RldiAvc3lzL2tlcm5l
bC90cmFjaW5nIHx8CiAJICAgICAgZXJyZXhpdCAiRmFpbGVkIHRvIG1vdW50IC9zeXMva2Vy
bmVsL3RyYWNpbmciCiAJICAgIFRSQUNJTkdfRElSPSIvc3lzL2tlcm5lbC90cmFjaW5nIgor
CSAgICBVTU9VTlRfRElSPSR7VFJBQ0lOR19ESVJ9CiAJIyBJZiBkZWJ1Z2ZzIGV4aXN0cywg
dGhlbiBzbyBkb2VzIC9zeXMva2VybmVsL2RlYnVnCiAJZWxpZiBbIC1kICIvc3lzL2tlcm5l
bC9kZWJ1ZyIgXTsgdGhlbgogCSAgICBtb3VudCAtdCBkZWJ1Z2ZzIG5vZGV2IC9zeXMva2Vy
bmVsL2RlYnVnIHx8CiAJICAgICAgZXJyZXhpdCAiRmFpbGVkIHRvIG1vdW50IC9zeXMva2Vy
bmVsL2RlYnVnIgogCSAgICBUUkFDSU5HX0RJUj0iL3N5cy9rZXJuZWwvZGVidWcvdHJhY2lu
ZyIKKwkgICAgVU1PVU5UX0RJUj0ke1RSQUNJTkdfRElSfQogCWVsc2UKIAkgICAgZXJyX3Jl
dD0kZXJyX3NraXAKIAkgICAgZXJyZXhpdCAiZGVidWdmcyBhbmQgdHJhY2VmcyBhcmUgbm90
IGNvbmZpZ3VyZWQgaW4gdGhpcyBrZXJuZWwiCkBAIC0xODEsNyArMTkwLDEwIEBAIGZpCiBU
T1BfRElSPWBhYnNkaXIgJDBgCiBURVNUX0RJUj0kVE9QX0RJUi90ZXN0LmQKIFRFU1RfQ0FT
RVM9YGZpbmRfdGVzdGNhc2VzICRURVNUX0RJUmAKLUxPR19ESVI9JFRPUF9ESVIvbG9ncy9g
ZGF0ZSArJVklbSVkLSVIJU0lU2AvCitMT0dfVE9QX0RJUj0kVE9QX0RJUi9sb2dzCitMT0df
REFURT1gZGF0ZSArJVklbSVkLSVIJU0lU2AKK0xPR19ESVI9JExPR19UT1BfRElSLyRMT0df
REFURS8KK0xJTktfUFRSPSRMT0dfVE9QX0RJUi9sYXRlc3QKIEtFRVBfTE9HPTAKIEtUQVA9
MAogREVCVUc9MApAQCAtMjA3LDYgKzIxOSwxMCBAQCBlbHNlCiAgIExPR19GSUxFPSRMT0df
RElSL2Z0cmFjZXRlc3QubG9nCiAgIG1rZGlyIC1wICRMT0dfRElSIHx8IGVycmV4aXQgIkZh
aWxlZCB0byBtYWtlIGEgbG9nIGRpcmVjdG9yeTogJExPR19ESVIiCiAgIGRhdGUgPiAkTE9H
X0ZJTEUKKyAgaWYgWyAieC0kTElOS19QVFIiICE9ICJ4LSIgXTsgdGhlbgorICAgIHVubGlu
ayAkTElOS19QVFIKKyAgICBsbiAtZnMgJExPR19EQVRFICRMSU5LX1BUUgorICBmaQogZmkK
IAogIyBEZWZpbmUgdGV4dCBjb2xvcnMKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3VzZXJfZXZlbnRzL2FiaV90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy91c2VyX2V2ZW50cy9hYmlfdGVzdC5jCmluZGV4IDUxMjVjNDJlZmU2NS4uMjIzNzRkMjlm
ZmRkIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91c2VyX2V2ZW50cy9h
YmlfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2Fi
aV90ZXN0LmMKQEAgLTE5LDYgKzE5LDcgQEAKICNpbmNsdWRlIDxhc20vdW5pc3RkLmg+CiAK
ICNpbmNsdWRlICIuLi9rc2VsZnRlc3RfaGFybmVzcy5oIgorI2luY2x1ZGUgInVzZXJfZXZl
bnRzX3NlbGZ0ZXN0cy5oIgogCiBjb25zdCBjaGFyICpkYXRhX2ZpbGUgPSAiL3N5cy9rZXJu
ZWwvdHJhY2luZy91c2VyX2V2ZW50c19kYXRhIjsKIGNvbnN0IGNoYXIgKmVuYWJsZV9maWxl
ID0gIi9zeXMva2VybmVsL3RyYWNpbmcvZXZlbnRzL3VzZXJfZXZlbnRzL19fYWJpX2V2ZW50
L2VuYWJsZSI7CkBAIC05Myw2ICs5NCw4IEBAIEZJWFRVUkUodXNlcikgewogfTsKIAogRklY
VFVSRV9TRVRVUCh1c2VyKSB7CisJVVNFUl9FVkVOVF9GSVhUVVJFX1NFVFVQKHJldHVybik7
CisKIAljaGFuZ2VfZXZlbnQoZmFsc2UpOwogCXNlbGYtPmNoZWNrID0gMDsKIH0KZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2NvbmZpZyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2NvbmZpZwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjY0ZjdhOWE5MGNlYwotLS0gL2Rldi9udWxs
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2NvbmZpZwpAQCAt
MCwwICsxIEBACitDT05GSUdfVVNFUl9FVkVOVFM9eQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdXNlcl9ldmVudHMvZHluX3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3VzZXJfZXZlbnRzL2R5bl90ZXN0LmMKaW5kZXggOTFhNDQ0NGFkNDJiLi4z
MmM4MjdhNTJkN2QgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJf
ZXZlbnRzL2R5bl90ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdXNlcl9l
dmVudHMvZHluX3Rlc3QuYwpAQCAtMTUsNiArMTUsNyBAQAogI2luY2x1ZGUgPHVuaXN0ZC5o
PgogCiAjaW5jbHVkZSAiLi4va3NlbGZ0ZXN0X2hhcm5lc3MuaCIKKyNpbmNsdWRlICJ1c2Vy
X2V2ZW50c19zZWxmdGVzdHMuaCIKIAogY29uc3QgY2hhciAqYWJpX2ZpbGUgPSAiL3N5cy9r
ZXJuZWwvdHJhY2luZy91c2VyX2V2ZW50c19kYXRhIjsKIGNvbnN0IGNoYXIgKmVuYWJsZV9m
aWxlID0gIi9zeXMva2VybmVsL3RyYWNpbmcvZXZlbnRzL3VzZXJfZXZlbnRzL19fdGVzdF9l
dmVudC9lbmFibGUiOwpAQCAtMTQ2LDYgKzE0Nyw3IEBAIEZJWFRVUkUodXNlcikgewogfTsK
IAogRklYVFVSRV9TRVRVUCh1c2VyKSB7CisJVVNFUl9FVkVOVF9GSVhUVVJFX1NFVFVQKHJl
dHVybik7CiB9CiAKIEZJWFRVUkVfVEVBUkRPV04odXNlcikgewpkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdXNlcl9ldmVudHMvZnRyYWNlX3Rlc3QuYyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2Z0cmFjZV90ZXN0LmMKaW5kZXggNWJl
YjBhZWYxZDgxLi42YTI2MGNhZWVkZGMgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3VzZXJfZXZlbnRzL2Z0cmFjZV90ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvdXNlcl9ldmVudHMvZnRyYWNlX3Rlc3QuYwpAQCAtMTYsNiArMTYsNyBAQAog
I2luY2x1ZGUgPHVuaXN0ZC5oPgogCiAjaW5jbHVkZSAiLi4va3NlbGZ0ZXN0X2hhcm5lc3Mu
aCIKKyNpbmNsdWRlICJ1c2VyX2V2ZW50c19zZWxmdGVzdHMuaCIKIAogY29uc3QgY2hhciAq
ZGF0YV9maWxlID0gIi9zeXMva2VybmVsL3RyYWNpbmcvdXNlcl9ldmVudHNfZGF0YSI7CiBj
b25zdCBjaGFyICpzdGF0dXNfZmlsZSA9ICIvc3lzL2tlcm5lbC90cmFjaW5nL3VzZXJfZXZl
bnRzX3N0YXR1cyI7CkBAIC0yMDYsNiArMjA3LDggQEAgRklYVFVSRSh1c2VyKSB7CiB9Owog
CiBGSVhUVVJFX1NFVFVQKHVzZXIpIHsKKwlVU0VSX0VWRU5UX0ZJWFRVUkVfU0VUVVAocmV0
dXJuKTsKKwogCXNlbGYtPnN0YXR1c19mZCA9IG9wZW4oc3RhdHVzX2ZpbGUsIE9fUkRPTkxZ
KTsKIAlBU1NFUlRfTkUoLTEsIHNlbGYtPnN0YXR1c19mZCk7CiAKZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL3BlcmZfdGVzdC5jIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvdXNlcl9ldmVudHMvcGVyZl90ZXN0LmMKaW5kZXggOGIwOWJl
NTY2ZmEyLi5mODkzMzk4Y2RhMDUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3VzZXJfZXZlbnRzL3BlcmZfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3VzZXJfZXZlbnRzL3BlcmZfdGVzdC5jCkBAIC0xNyw2ICsxNyw3IEBACiAjaW5jbHVk
ZSA8YXNtL3VuaXN0ZC5oPgogCiAjaW5jbHVkZSAiLi4va3NlbGZ0ZXN0X2hhcm5lc3MuaCIK
KyNpbmNsdWRlICJ1c2VyX2V2ZW50c19zZWxmdGVzdHMuaCIKIAogY29uc3QgY2hhciAqZGF0
YV9maWxlID0gIi9zeXMva2VybmVsL3RyYWNpbmcvdXNlcl9ldmVudHNfZGF0YSI7CiBjb25z
dCBjaGFyICppZF9maWxlID0gIi9zeXMva2VybmVsL3RyYWNpbmcvZXZlbnRzL3VzZXJfZXZl
bnRzL19fdGVzdF9ldmVudC9pZCI7CkBAIC0xMTMsNiArMTE0LDggQEAgRklYVFVSRSh1c2Vy
KSB7CiB9OwogCiBGSVhUVVJFX1NFVFVQKHVzZXIpIHsKKwlVU0VSX0VWRU5UX0ZJWFRVUkVf
U0VUVVAocmV0dXJuKTsKKwogCXNlbGYtPmRhdGFfZmQgPSBvcGVuKGRhdGFfZmlsZSwgT19S
RFdSKTsKIAlBU1NFUlRfTkUoLTEsIHNlbGYtPmRhdGFfZmQpOwogfQpkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdXNlcl9ldmVudHMvdXNlcl9ldmVudHNfc2VsZnRl
c3RzLmggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91c2VyX2V2ZW50cy91c2VyX2V2ZW50
c19zZWxmdGVzdHMuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAu
LjY5MDM3ODk0MmY4MgotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3VzZXJfZXZlbnRzL3VzZXJfZXZlbnRzX3NlbGZ0ZXN0cy5oCkBAIC0wLDAgKzEsMTAw
IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLworCisjaWZuZGVm
IF9VU0VSX0VWRU5UU19TRUxGVEVTVFNfSAorI2RlZmluZSBfVVNFUl9FVkVOVFNfU0VMRlRF
U1RTX0gKKworI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CisjaW5jbHVkZSA8c3lzL3R5cGVzLmg+
CisjaW5jbHVkZSA8c3lzL21vdW50Lmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVk
ZSA8ZXJybm8uaD4KKworI2luY2x1ZGUgIi4uL2tzZWxmdGVzdC5oIgorCitzdGF0aWMgaW5s
aW5lIGJvb2wgdHJhY2Vmc19lbmFibGVkKGNoYXIgKiptZXNzYWdlLCBib29sICpmYWlsKQor
eworCXN0cnVjdCBzdGF0IGJ1ZjsKKwlpbnQgcmV0OworCisJKm1lc3NhZ2UgPSAiIjsKKwkq
ZmFpbCA9IGZhbHNlOworCisJLyogRW5zdXJlIHRyYWNlZnMgaXMgaW5zdGFsbGVkICovCisJ
cmV0ID0gc3RhdCgiL3N5cy9rZXJuZWwvdHJhY2luZyIsICZidWYpOworCisJaWYgKHJldCA9
PSAtMSkgeworCQkqbWVzc2FnZSA9ICJUcmFjZWZzIGlzIG5vdCBpbnN0YWxsZWQiOworCQly
ZXR1cm4gZmFsc2U7CisJfQorCisJLyogRW5zdXJlIG1vdW50ZWQgdHJhY2VmcyAqLworCXJl
dCA9IHN0YXQoIi9zeXMva2VybmVsL3RyYWNpbmcvUkVBRE1FIiwgJmJ1Zik7CisKKwlpZiAo
cmV0ID09IC0xICYmIGVycm5vID09IEVOT0VOVCkgeworCQlpZiAobW91bnQoTlVMTCwgIi9z
eXMva2VybmVsL3RyYWNpbmciLCAidHJhY2VmcyIsIDAsIE5VTEwpICE9IDApIHsKKwkJCSpt
ZXNzYWdlID0gIkNhbm5vdCBtb3VudCB0cmFjZWZzIjsKKwkJCSpmYWlsID0gdHJ1ZTsKKwkJ
CXJldHVybiBmYWxzZTsKKwkJfQorCisJCXJldCA9IHN0YXQoIi9zeXMva2VybmVsL3RyYWNp
bmcvUkVBRE1FIiwgJmJ1Zik7CisJfQorCisJaWYgKHJldCA9PSAtMSkgeworCQkqbWVzc2Fn
ZSA9ICJDYW5ub3QgYWNjZXNzIHRyYWNlZnMiOworCQkqZmFpbCA9IHRydWU7CisJCXJldHVy
biBmYWxzZTsKKwl9CisKKwlyZXR1cm4gdHJ1ZTsKK30KKworc3RhdGljIGlubGluZSBib29s
IHVzZXJfZXZlbnRzX2VuYWJsZWQoY2hhciAqKm1lc3NhZ2UsIGJvb2wgKmZhaWwpCit7CisJ
c3RydWN0IHN0YXQgYnVmOworCWludCByZXQ7CisKKwkqbWVzc2FnZSA9ICIiOworCSpmYWls
ID0gZmFsc2U7CisKKwlpZiAoZ2V0dWlkKCkgIT0gMCkgeworCQkqbWVzc2FnZSA9ICJNdXN0
IGJlIHJ1biBhcyByb290IjsKKwkJKmZhaWwgPSB0cnVlOworCQlyZXR1cm4gZmFsc2U7CisJ
fQorCisJaWYgKCF0cmFjZWZzX2VuYWJsZWQobWVzc2FnZSwgZmFpbCkpCisJCXJldHVybiBm
YWxzZTsKKworCS8qIEVuc3VyZSB1c2VyX2V2ZW50cyBpcyBpbnN0YWxsZWQgKi8KKwlyZXQg
PSBzdGF0KCIvc3lzL2tlcm5lbC90cmFjaW5nL3VzZXJfZXZlbnRzX2RhdGEiLCAmYnVmKTsK
KworCWlmIChyZXQgPT0gLTEpIHsKKwkJc3dpdGNoIChlcnJubykgeworCQljYXNlIEVOT0VO
VDoKKwkJCSptZXNzYWdlID0gInVzZXJfZXZlbnRzIGlzIG5vdCBpbnN0YWxsZWQiOworCQkJ
cmV0dXJuIGZhbHNlOworCisJCWRlZmF1bHQ6CisJCQkqbWVzc2FnZSA9ICJDYW5ub3QgYWNj
ZXNzIHVzZXJfZXZlbnRzX2RhdGEiOworCQkJKmZhaWwgPSB0cnVlOworCQkJcmV0dXJuIGZh
bHNlOworCQl9CisJfQorCisJcmV0dXJuIHRydWU7Cit9CisKKyNkZWZpbmUgVVNFUl9FVkVO
VF9GSVhUVVJFX1NFVFVQKHN0YXRlbWVudCkgZG8geyBcCisJY2hhciAqbWVzc2FnZTsgXAor
CWJvb2wgZmFpbDsgXAorCWlmICghdXNlcl9ldmVudHNfZW5hYmxlZCgmbWVzc2FnZSwgJmZh
aWwpKSB7IFwKKwkJaWYgKGZhaWwpIHsgXAorCQkJVEhfTE9HKCJTZXR1cCBmYWlsZWQgZHVl
IHRvOiAlcyIsIG1lc3NhZ2UpOyBcCisJCQlBU1NFUlRfRkFMU0UoZmFpbCk7IFwKKwkJfSBc
CisJCVNLSVAoc3RhdGVtZW50LCAiU2tpcHBpbmcgZHVlIHRvOiAlcyIsIG1lc3NhZ2UpOyBc
CisJfSBcCit9IHdoaWxlICgwKQorCisjZW5kaWYgLyogX1VTRVJfRVZFTlRTX1NFTEZURVNU
U19IICovCg==

--------------QgCeCf9J1BZIBGDemSNwtt0j--
