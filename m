Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304B779BB40
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbjIKVUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243612AbjIKRYM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 13:24:12 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC02F5
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Sep 2023 10:24:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77dcff76e35so54673339f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Sep 2023 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694453044; x=1695057844; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sphhBNof8zq1/caB4nqaNWdPiAfc/xDFKkO3FH9aqFw=;
        b=FAalRym1fnQhG167KJjjqHUA5oDh7BuYJrCUoAo2zpeSzDPNUb5tDtRsNezXqTq3Jb
         +RwGU1/bjIcHblaQQ25SNvEGYr/28Gf6wgnJtZYMNEZgX6O+Hdyg2dMlQl99xxj2Dz16
         3K5lWSj7pF6h+ntJ6a3gT79WaMSGK/2CqnAqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694453044; x=1695057844;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sphhBNof8zq1/caB4nqaNWdPiAfc/xDFKkO3FH9aqFw=;
        b=CrUeI9v6hrB/YVDifMosE2JdQ8vwScEGLJwDlde40quE9ew66E1FRjI4qN4+rzFK/K
         EgA4W+xG6HnuiDrFmC/Th5WL7C74K6zrkRykUTlRxpfpHcOSsurEcYmbtwNIopxgdvKd
         2Jt+KFnq3EeOefA03mTC/UvY++S10ZUXcrF4ojaQIVJvPQr8NlO99jOjXKmO9M9iCNkn
         d67JihiiNPsEHJEFJzY4TIIgwFX9UJK8XwDBtGKRpTAG09zJ6RK8oA7WDjnyROiO/wi/
         yzYuTWrmFY/SC4nPcrEZKlJCBvD7n1HQ2+KAmWCWJZ9Loj2pNgvwyJlqChZkpVsTjZLi
         ax6w==
X-Gm-Message-State: AOJu0Ywtgky2cd+aQfuXQfW5EO/BwOlSTa14CdUCIcNh0jjqDd8ST/Eo
        +zdLyAmx/rHQilGQ3hSmOU+A/z1HBQ6tpRth71M=
X-Google-Smtp-Source: AGHT+IFbPp+CfbE1tmZWB+A8e6PyXi82Tle2mAGJx5YIB6jIjrlb44dzOhAyXsLG8p3bV2QyoQByDQ==
X-Received: by 2002:a05:6e02:60d:b0:345:e438:7381 with SMTP id t13-20020a056e02060d00b00345e4387381mr11302429ils.2.1694453043753;
        Mon, 11 Sep 2023 10:24:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x16-20020a920610000000b0034f3faebfddsm552048ilg.77.2023.09.11.10.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 10:24:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------F4BtTa1otajnCWynCa05KEj6"
Message-ID: <d08e3af8-b48d-ee6f-9e9c-b9a0129de405@linuxfoundation.org>
Date:   Mon, 11 Sep 2023 11:24:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.6-rc2
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
--------------F4BtTa1otajnCWynCa05KEj6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.6-rc2.

This kselftest fixes update for Linux 6.6-rc2 consists of fixes

-- kselftest runner script to propagate SIGTERM to runner child
    to avoid kselftest hang.
-- to install symlinks required for test execution to avoid test
    failures.
-- kselftest dependency checker script argument parsing.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9b1db732866bee060b9bca9493e5ebf5e8874c48:

   selftests: cachestat: use proper syscall number macro (2023-08-16 11:12:44 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.6-rc2

for you to fetch changes up to 3f3f384139ed147c71e1d770accf610133d5309b:

   selftests: Keep symlinks, when possible (2023-09-08 10:06:56 -0600)

----------------------------------------------------------------
linux-kselftest-next-6.6-rc2

This kselftest fixes update for Linux 6.6-rc2 consists of fixes

-- kselftest runner script to propagate SIGTERM to runner child
    to avoid kselftest hang.
-- to install symlinks required for test execution to avoid test
    failures.
-- kselftest dependency checker script argument parsing.

----------------------------------------------------------------
Björn Töpel (2):
       kselftest/runner.sh: Propagate SIGTERM to runner child
       selftests: Keep symlinks, when possible

Ricardo B. Marliere (1):
       selftests: fix dependency checker script

Zheng Yejian (1):
       selftests/ftrace: Correctly enable event in instance-event.tc

  .../ftrace/test.d/instances/instance-event.tc      |  2 +-
  tools/testing/selftests/kselftest/runner.sh        |  3 +-
  tools/testing/selftests/kselftest_deps.sh          | 77 ++++++++++++++++++----
  tools/testing/selftests/lib.mk                     |  4 +-
  4 files changed, 70 insertions(+), 16 deletions(-)
----------------------------------------------------------------
--------------F4BtTa1otajnCWynCa05KEj6
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-6.6-rc2.diff"
Content-Disposition: attachment; filename="linux-kselftest-next-6.6-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvaW5z
dGFuY2VzL2luc3RhbmNlLWV2ZW50LnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRy
YWNlL3Rlc3QuZC9pbnN0YW5jZXMvaW5zdGFuY2UtZXZlbnQudGMKaW5kZXggMGViNDdmYmIz
ZjQ0Li40MjQyMmU0MjUxMDcgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Z0cmFjZS90ZXN0LmQvaW5zdGFuY2VzL2luc3RhbmNlLWV2ZW50LnRjCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvaW5zdGFuY2VzL2luc3RhbmNlLWV2
ZW50LnRjCkBAIC0zOSw3ICszOSw3IEBAIGluc3RhbmNlX3JlYWQoKSB7CiAKIGluc3RhbmNl
X3NldCgpIHsKICAgICAgICAgd2hpbGUgOjsgZG8KLSAgICAgICAgICAgICAgICBlY2hvIDEg
PiBmb28vZXZlbnRzL3NjaGVkL3NjaGVkX3N3aXRjaAorICAgICAgICAgICAgICAgIGVjaG8g
MSA+IGZvby9ldmVudHMvc2NoZWQvc2NoZWRfc3dpdGNoL2VuYWJsZQogICAgICAgICBkb25l
IDI+IC9kZXYvbnVsbAogfQogCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9rc2VsZnRlc3QvcnVubmVyLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0
ZXN0L3J1bm5lci5zaAppbmRleCAxYzk1MmQxNDAxZDQuLjcwZTBhNDY1ZTMwZCAxMDA2NDQK
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0L3J1bm5lci5zaAorKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3QvcnVubmVyLnNoCkBAIC0zNiw3
ICszNiw4IEBAIHRhcF90aW1lb3V0KCkKIHsKIAkjIE1ha2Ugc3VyZSB0ZXN0cyB3aWxsIHRp
bWUgb3V0IGlmIHV0aWxpdHkgaXMgYXZhaWxhYmxlLgogCWlmIFsgLXggL3Vzci9iaW4vdGlt
ZW91dCBdIDsgdGhlbgotCQkvdXNyL2Jpbi90aW1lb3V0IC0tZm9yZWdyb3VuZCAiJGtzZWxm
dGVzdF90aW1lb3V0IiAkMQorCQkvdXNyL2Jpbi90aW1lb3V0IC0tZm9yZWdyb3VuZCAiJGtz
ZWxmdGVzdF90aW1lb3V0IiBcCisJCQkvdXNyL2Jpbi90aW1lb3V0ICIka3NlbGZ0ZXN0X3Rp
bWVvdXQiICQxCiAJZWxzZQogCQkkMQogCWZpCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9rc2VsZnRlc3RfZGVwcy5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2tzZWxmdGVzdF9kZXBzLnNoCmluZGV4IDRiYzE0ZDllOGZmMS4uZGU1OWNjOGYwM2MzIDEw
MDc1NQotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3RfZGVwcy5zaAor
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3RfZGVwcy5zaApAQCAtNDYs
MTEgKzQ2LDExIEBAIGZpCiBwcmludF90YXJnZXRzPTAKIAogd2hpbGUgZ2V0b3B0cyAicCIg
YXJnOyBkbwotICAgIGNhc2UgJGFyZyBpbgotICAgICAgICBwKQorCWNhc2UgJGFyZyBpbgor
CQlwKQogCQlwcmludF90YXJnZXRzPTEKIAlzaGlmdDs7Ci0gICAgZXNhYworCWVzYWMKIGRv
bmUKIAogaWYgWyAkIyAtZXEgMCBdCkBAIC05Miw2ICs5MiwxMCBAQCBwYXNzX2NudD0wCiAj
IEdldCBhbGwgVEFSR0VUUyBmcm9tIHNlbGZ0ZXN0cyBNYWtlZmlsZQogdGFyZ2V0cz0kKGdy
ZXAgLUUgIl5UQVJHRVRTICt8XlRBUkdFVFMgPSIgTWFrZWZpbGUgfCBjdXQgLWQgIj0iIC1m
MikKIAorIyBJbml0aWFsbHksIGluIExETElCUyByZWxhdGVkIGxpbmVzLCB0aGUgZGVwIGNo
ZWNrZXIgbmVlZHMKKyMgdG8gaWdub3JlIGxpbmVzIGNvbnRhaW5pbmcgdGhlIGZvbGxvd2lu
ZyBzdHJpbmdzOgorZmlsdGVyPSJcJChWQVJfTERMSUJTKVx8cGtnLWNvbmZpZ1x8UEtHX0NP
TkZJR1x8SU9VUklOR19FWFRSQV9MSUJTIgorCiAjIFNpbmdsZSB0ZXN0IGNhc2UKIGlmIFsg
JCMgLWVxIDIgXQogdGhlbgpAQCAtMTAwLDYgKzEwNCw4IEBAIHRoZW4KIAlsMV90ZXN0ICR0
ZXN0CiAJbDJfdGVzdCAkdGVzdAogCWwzX3Rlc3QgJHRlc3QKKwlsNF90ZXN0ICR0ZXN0CisJ
bDVfdGVzdCAkdGVzdAogCiAJcHJpbnRfcmVzdWx0cyAkMSAkMgogCWV4aXQgJD8KQEAgLTEx
Myw3ICsxMTksNyBAQCBmaQogIyBBcHBlbmQgc3BhY2UgYXQgdGhlIGVuZCBvZiB0aGUgbGlz
dCB0byBhcHBlbmQgbW9yZSB0ZXN0cy4KIAogbDFfdGVzdHM9JChncmVwIC1yIC0taW5jbHVk
ZT1NYWtlZmlsZSAiXkxETElCUyIgfCBcCi0JCWdyZXAgLXYgIlZBUl9MRExJQlMiIHwgYXdr
IC1GOiAne3ByaW50ICQxfScpCisJCWdyZXAgLXYgIiRmaWx0ZXIiIHwgYXdrIC1GOiAne3By
aW50ICQxfScgfCB1bmlxKQogCiAjIExldmVsIDI6IExETElCUyBzZXQgZHluYW1pY2FsbHku
CiAjCkBAIC0xMjYsNyArMTMyLDcgQEAgbDFfdGVzdHM9JChncmVwIC1yIC0taW5jbHVkZT1N
YWtlZmlsZSAiXkxETElCUyIgfCBcCiAjIEFwcGVuZCBzcGFjZSBhdCB0aGUgZW5kIG9mIHRo
ZSBsaXN0IHRvIGFwcGVuZCBtb3JlIHRlc3RzLgogCiBsMl90ZXN0cz0kKGdyZXAgLXIgLS1p
bmNsdWRlPU1ha2VmaWxlICI6IExETElCUyIgfCBcCi0JCWdyZXAgLXYgIlZBUl9MRExJQlMi
IHwgYXdrIC1GOiAne3ByaW50ICQxfScpCisJCWdyZXAgLXYgIiRmaWx0ZXIiIHwgYXdrIC1G
OiAne3ByaW50ICQxfScgfCB1bmlxKQogCiAjIExldmVsIDMKICMgbWVtZmQgYW5kIG90aGVy
cyB1c2UgcGtnLWNvbmZpZyB0byBmaW5kIG1vdW50IGFuZCBmdXNlIGxpYnMKQEAgLTEzOCwx
MSArMTQ0LDMyIEBAIGwyX3Rlc3RzPSQoZ3JlcCAtciAtLWluY2x1ZGU9TWFrZWZpbGUgIjog
TERMSUJTIiB8IFwKICMJVkFSX0xETElCUyA6PSAkKHNoZWxsIHBrZy1jb25maWcgZnVzZSAt
LWxpYnMgMj4vZGV2L251bGwpCiAKIGwzX3Rlc3RzPSQoZ3JlcCAtciAtLWluY2x1ZGU9TWFr
ZWZpbGUgIl5WQVJfTERMSUJTIiB8IFwKLQkJZ3JlcCAtdiAicGtnLWNvbmZpZyIgfCBhd2sg
LUY6ICd7cHJpbnQgJDF9JykKKwkJZ3JlcCAtdiAicGtnLWNvbmZpZ1x8UEtHX0NPTkZJRyIg
fCBhd2sgLUY6ICd7cHJpbnQgJDF9JyB8IHVuaXEpCiAKLSNlY2hvICRsMV90ZXN0cwotI2Vj
aG8gJGwyXzFfdGVzdHMKLSNlY2hvICRsM190ZXN0cworIyBMZXZlbCA0CisjIHNvbWUgdGVz
dHMgbWF5IGZhbGwgYmFjayB0byBkZWZhdWx0IHVzaW5nIGB8fCBlY2hvIC1sPGxpYm5hbWU+
YAorIyBpZiBwa2ctY29uZmlnIGRvZXNuJ3QgZmluZCB0aGUgbGlicywgaW5zdGVhZCBvZiB1
c2luZyBWQVJfTERMSUJTCisjIGFzIHBlciBsZXZlbCAzIGNoZWNrcy4KKyMgZS5nOgorIyBu
ZXRmaWx0ZXIvTWFrZWZpbGUKKyMJTERMSUJTICs9ICQoc2hlbGwgJChIT1NUUEtHX0NPTkZJ
RykgLS1saWJzIGxpYm1ubCAyPi9kZXYvbnVsbCB8fCBlY2hvIC1sbW5sKQorbDRfdGVzdHM9
JChncmVwIC1yIC0taW5jbHVkZT1NYWtlZmlsZSAiXkxETElCUyIgfCBcCisJCWdyZXAgInBr
Zy1jb25maWdcfFBLR19DT05GSUciIHwgYXdrIC1GOiAne3ByaW50ICQxfScgfCB1bmlxKQor
CisjIExldmVsIDUKKyMgc29tZSB0ZXN0cyBtYXkgdXNlIElPVVJJTkdfRVhUUkFfTElCUyB0
byBhZGQgZXh0cmEgbGlicyB0byBMRExJQlMsCisjIHdoaWNoIGluIHR1cm4gbWF5IGJlIGRl
ZmluZWQgaW4gYSBzdWItTWFrZWZpbGUKKyMgZS5nLjoKKyMgbW0vTWFrZWZpbGUKKyMJJChP
VVRQVVQpL2d1cF9sb25ndGVybTogTERMSUJTICs9ICQoSU9VUklOR19FWFRSQV9MSUJTKQor
bDVfdGVzdHM9JChncmVwIC1yIC0taW5jbHVkZT1NYWtlZmlsZSAiTERMSUJTICs9LipcJChJ
T1VSSU5HX0VYVFJBX0xJQlMpIiB8IFwKKwlhd2sgLUY6ICd7cHJpbnQgJDF9JyB8IHVuaXEp
CisKKyNlY2hvIGwxX3Rlc3RzICRsMV90ZXN0cworI2VjaG8gbDJfdGVzdHMgJGwyX3Rlc3Rz
CisjZWNobyBsM190ZXN0cyAkbDNfdGVzdHMKKyNlY2hvIGw0X3Rlc3RzICRsNF90ZXN0cwor
I2VjaG8gbDVfdGVzdHMgJGw1X3Rlc3RzCiAKIGFsbF90ZXN0cwogcHJpbnRfcmVzdWx0cyAk
MSAkMgpAQCAtMTY0LDI0ICsxOTEsMzIgQEAgYWxsX3Rlc3RzKCkKIAlmb3IgdGVzdCBpbiAk
bDNfdGVzdHM7IGRvCiAJCWwzX3Rlc3QgJHRlc3QKIAlkb25lCisKKwlmb3IgdGVzdCBpbiAk
bDRfdGVzdHM7IGRvCisJCWw0X3Rlc3QgJHRlc3QKKwlkb25lCisKKwlmb3IgdGVzdCBpbiAk
bDVfdGVzdHM7IGRvCisJCWw1X3Rlc3QgJHRlc3QKKwlkb25lCiB9CiAKICMgVXNlIHNhbWUg
cGFyc2luZyB1c2VkIGZvciBsMV90ZXN0cyBhbmQgcGljayBsaWJyYXJpZXMgdGhpcyB0aW1l
LgogbDFfdGVzdCgpCiB7CiAJdGVzdF9saWJzPSQoZ3JlcCAtLWluY2x1ZGU9TWFrZWZpbGUg
Il5MRExJQlMiICR0ZXN0IHwgXAotCQkJZ3JlcCAtdiAiVkFSX0xETElCUyIgfCBcCisJCQln
cmVwIC12ICIkZmlsdGVyIiB8IFwKIAkJCXNlZCAtZSAncy9cOi8gLycgfCBcCiAJCQlzZWQg
LWUgJ3MvKy8gLycgfCBjdXQgLWQgIj0iIC1mIDIpCiAKIAljaGVja19saWJzICR0ZXN0ICR0
ZXN0X2xpYnMKIH0KIAotIyBVc2Ugc2FtZSBwYXJzaW5nIHVzZWQgZm9yIGwyX190ZXN0cyBh
bmQgcGljayBsaWJyYXJpZXMgdGhpcyB0aW1lLgorIyBVc2Ugc2FtZSBwYXJzaW5nIHVzZWQg
Zm9yIGwyX3Rlc3RzIGFuZCBwaWNrIGxpYnJhcmllcyB0aGlzIHRpbWUuCiBsMl90ZXN0KCkK
IHsKIAl0ZXN0X2xpYnM9JChncmVwIC0taW5jbHVkZT1NYWtlZmlsZSAiOiBMRExJQlMiICR0
ZXN0IHwgXAotCQkJZ3JlcCAtdiAiVkFSX0xETElCUyIgfCBcCisJCQlncmVwIC12ICIkZmls
dGVyIiB8IFwKIAkJCXNlZCAtZSAncy9cOi8gLycgfCBzZWQgLWUgJ3MvKy8gLycgfCBcCiAJ
CQljdXQgLWQgIj0iIC1mIDIpCiAKQEAgLTE5Nyw2ICsyMzIsMjQgQEAgbDNfdGVzdCgpCiAJ
Y2hlY2tfbGlicyAkdGVzdCAkdGVzdF9saWJzCiB9CiAKK2w0X3Rlc3QoKQoreworCXRlc3Rf
bGlicz0kKGdyZXAgLS1pbmNsdWRlPU1ha2VmaWxlICJeVkFSX0xETElCU1x8XkxETElCUyIg
JHRlc3QgfCBcCisJCQlncmVwICJcKHBrZy1jb25maWdcfFBLR19DT05GSUdcKS4qfHwgZWNo
byAiIHwgXAorCQkJc2VkIC1lICdzLy4qfHwgZWNobyAvLycgfCBzZWQgLWUgJ3MvKSQvLycp
CisKKwljaGVja19saWJzICR0ZXN0ICR0ZXN0X2xpYnMKK30KKworbDVfdGVzdCgpCit7CisJ
dGVzdHM9JChmaW5kICQoZGlybmFtZSAiJHRlc3QiKSAtdHlwZSBmIC1uYW1lICIqLm1rIikK
Kwl0ZXN0X2xpYnM9JChncmVwICJeSU9VUklOR19FWFRSQV9MSUJTICtcPz0iICR0ZXN0cyB8
IFwKKwkJCWN1dCAtZCAiPSIgLWYgMikKKworCWNoZWNrX2xpYnMgJHRlc3QgJHRlc3RfbGli
cworfQorCiBjaGVja19saWJzKCkKIHsKIApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvbGliLm1rIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGliLm1rCmluZGV4
IGQxNzg1NDI4NWYyYi4uMTE4ZTA5NjRiZGE5IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9saWIubWsKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGliLm1r
CkBAIC0xMDYsNyArMTA2LDcgQEAgZW5kZWYKIHJ1bl90ZXN0czogYWxsCiBpZmRlZiBidWls
ZGluZ19vdXRfb2Zfc3JjdHJlZQogCUBpZiBbICJYJChURVNUX1BST0dTKSQoVEVTVF9QUk9H
U19FWFRFTkRFRCkkKFRFU1RfRklMRVMpIiAhPSAiWCIgXTsgdGhlbiBcCi0JCXJzeW5jIC1h
THEgJChURVNUX1BST0dTKSAkKFRFU1RfUFJPR1NfRVhURU5ERUQpICQoVEVTVF9GSUxFUykg
JChPVVRQVVQpOyBcCisJCXJzeW5jIC1hcSAtLWNvcHktdW5zYWZlLWxpbmtzICQoVEVTVF9Q
Uk9HUykgJChURVNUX1BST0dTX0VYVEVOREVEKSAkKFRFU1RfRklMRVMpICQoT1VUUFVUKTsg
XAogCWZpCiAJQGlmIFsgIlgkKFRFU1RfUFJPR1MpIiAhPSAiWCIgXTsgdGhlbiBcCiAJCSQo
Y2FsbCBSVU5fVEVTVFMsICQoVEVTVF9HRU5fUFJPR1MpICQoVEVTVF9DVVNUT01fUFJPR1Mp
IFwKQEAgLTEyMCw3ICsxMjAsNyBAQCBlbmRpZgogCiBkZWZpbmUgSU5TVEFMTF9TSU5HTEVf
UlVMRQogCSQoaWYgJChJTlNUQUxMX0xJU1QpLEBta2RpciAtcCAkKElOU1RBTExfUEFUSCkp
Ci0JJChpZiAkKElOU1RBTExfTElTVCkscnN5bmMgLWFMICQoSU5TVEFMTF9MSVNUKSAkKElO
U1RBTExfUEFUSCkvKQorCSQoaWYgJChJTlNUQUxMX0xJU1QpLHJzeW5jIC1hIC0tY29weS11
bnNhZmUtbGlua3MgJChJTlNUQUxMX0xJU1QpICQoSU5TVEFMTF9QQVRIKS8pCiBlbmRlZgog
CiBkZWZpbmUgSU5TVEFMTF9SVUxFCg==

--------------F4BtTa1otajnCWynCa05KEj6--
