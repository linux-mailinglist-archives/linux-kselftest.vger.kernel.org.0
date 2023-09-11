Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4695879ADC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbjIKVT7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242797AbjIKQUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 12:20:50 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3358FCCA
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Sep 2023 09:20:45 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77dcff76e35so53802339f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Sep 2023 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694449244; x=1695054044; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LtrVyYntxriS8KdbRv4Ma1v0noE5M/v7Ijy9zhl0344=;
        b=PEBA8+lnN0lFG7DE9+yN1aW9pCaeLr4vKJzxgBwyNN5tzq1ttqANZ1FUUNjhL9mXR+
         PcJXk1tIRNeU30K96KFGOThz3aq6JFBcamHzGSxEWMMHQfs4f8XeTCEsnCHos0/Nx3WN
         8h8BrFeBrTr+4gExwf7RIEnzi2fUMEzXhaSXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694449244; x=1695054044;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtrVyYntxriS8KdbRv4Ma1v0noE5M/v7Ijy9zhl0344=;
        b=U8n1gSP2EwnwBXX+ApTwxn3G23syOLlrRCYn3/ErqIlMILHzOZht2oC5brJ6A3KSxj
         cpWPFD8/EfJo0EnBQVoKBVTYZOMbmIAdW8bUaio1k1p0Q7FLBzNG11RJ2FteUcAp6kbZ
         CPyUobPk/U82A12EeJulublDD7o9EQCPlNPQaCbBc+9H617r+9rQGAeoTpQb+pim6jKX
         JeaTaZpoAVEqK4+mSMIuv6RF121t27bXFl2Pb5GhkkFkepZsI8KJBO4u4/ZGqAUm/+yP
         7gGMJbfv+/KP/IMibhxYgIKl0SVM5um3G6zdUmvfATpQZG6E/+3Y7KOfWaxrOc966vSS
         mEVg==
X-Gm-Message-State: AOJu0YwDSNXo6P8Vnpx7TTJXDV1lnjhnMT4r80YEXpQ/VpHVCN7TAzqp
        +nCAbhuKNcra5mUPBfcAUMtd7A==
X-Google-Smtp-Source: AGHT+IFjqvSaWwr5wGb5V0K4enbHDaR40eM6CqvPeWlPuXYRrXMo2fMWqb3JHCxMzs6tvXM8Nxxe9Q==
X-Received: by 2002:a05:6602:499b:b0:792:6dd8:a65f with SMTP id eg27-20020a056602499b00b007926dd8a65fmr11809954iob.0.1694449244519;
        Mon, 11 Sep 2023 09:20:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i3-20020a02c603000000b004302760aa6bsm2227996jan.4.2023.09.11.09.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 09:20:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------C4KDad23lRefsYFyjwqtZ0O8"
Message-ID: <4928e6cd-f45e-20e9-08f6-acdb1281a2e6@linuxfoundation.org>
Date:   Mon, 11 Sep 2023 10:20:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.6-rc2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------C4KDad23lRefsYFyjwqtZ0O8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.6-rc2.

This kunit update for Linux 6.6-rc2 consists of important fixes to
possible memory leak, null-ptr-deref, wild-memory-access, and error
path bugs.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 25e324bc9cf2ee956eec1db384c39c1a17b7c44a:

   kunit: fix struct kunit_attr header (2023-08-21 08:07:56 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.6-rc2

for you to fetch changes up to 9076bc476d7ebf0565903c4b048442131825c1c3:

   kunit: Fix possible memory leak in kunit_filter_suites() (2023-09-05 12:30:06 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-6.6-rc2

This kunit update for Linux 6.6-rc2 consists of important fixes to
possible memory leak, null-ptr-deref, wild-memory-access, and error
path bugs.

----------------------------------------------------------------
David Gow (1):
       kunit: test: Make filter strings in executor_test writable

Jinjie Ruan (4):
       kunit: Fix wild-memory-access bug in kunit_free_suite_set()
       kunit: Fix the wrong err path and add goto labels in kunit_filter_suites()
       kunit: Fix possible null-ptr-deref in kunit_parse_glob_filter()
       kunit: Fix possible memory leak in kunit_filter_suites()

  lib/kunit/executor.c      | 48 ++++++++++++++++++++++++++++++++---------------
  lib/kunit/executor_test.c | 13 ++++++++-----
  lib/kunit/test.c          |  3 ++-
  3 files changed, 43 insertions(+), 21 deletions(-)

----------------------------------------------------------------
--------------C4KDad23lRefsYFyjwqtZ0O8
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-6.6-rc2.diff"
Content-Disposition: attachment; filename="linux-kselftest-kunit-6.6-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9leGVjdXRvci5jIGIvbGliL2t1bml0L2V4ZWN1dG9y
LmMKaW5kZXggNTE4MWFhMmU3NjBiLi5hNjM0ODQ4OWQ0NWYgMTAwNjQ0Ci0tLSBhL2xpYi9r
dW5pdC9leGVjdXRvci5jCisrKyBiL2xpYi9rdW5pdC9leGVjdXRvci5jCkBAIC02NSw3ICs2
NSw3IEBAIHN0cnVjdCBrdW5pdF9nbG9iX2ZpbHRlciB7CiB9OwogCiAvKiBTcGxpdCAic3Vp
dGVfZ2xvYi50ZXN0X2dsb2IiIGludG8gdHdvLiBBc3N1bWVzIGZpbHRlcl9nbG9iIGlzIG5v
dCBlbXB0eS4gKi8KLXN0YXRpYyB2b2lkIGt1bml0X3BhcnNlX2dsb2JfZmlsdGVyKHN0cnVj
dCBrdW5pdF9nbG9iX2ZpbHRlciAqcGFyc2VkLAorc3RhdGljIGludCBrdW5pdF9wYXJzZV9n
bG9iX2ZpbHRlcihzdHJ1Y3Qga3VuaXRfZ2xvYl9maWx0ZXIgKnBhcnNlZCwKIAkJCQkgICAg
Y29uc3QgY2hhciAqZmlsdGVyX2dsb2IpCiB7CiAJY29uc3QgaW50IGxlbiA9IHN0cmxlbihm
aWx0ZXJfZ2xvYik7CkBAIC03MywxNiArNzMsMjggQEAgc3RhdGljIHZvaWQga3VuaXRfcGFy
c2VfZ2xvYl9maWx0ZXIoc3RydWN0IGt1bml0X2dsb2JfZmlsdGVyICpwYXJzZWQsCiAKIAlp
ZiAoIXBlcmlvZCkgewogCQlwYXJzZWQtPnN1aXRlX2dsb2IgPSBremFsbG9jKGxlbiArIDEs
IEdGUF9LRVJORUwpOworCQlpZiAoIXBhcnNlZC0+c3VpdGVfZ2xvYikKKwkJCXJldHVybiAt
RU5PTUVNOworCiAJCXBhcnNlZC0+dGVzdF9nbG9iID0gTlVMTDsKIAkJc3RyY3B5KHBhcnNl
ZC0+c3VpdGVfZ2xvYiwgZmlsdGVyX2dsb2IpOwotCQlyZXR1cm47CisJCXJldHVybiAwOwog
CX0KIAogCXBhcnNlZC0+c3VpdGVfZ2xvYiA9IGt6YWxsb2MocGVyaW9kIC0gZmlsdGVyX2ds
b2IgKyAxLCBHRlBfS0VSTkVMKTsKKwlpZiAoIXBhcnNlZC0+c3VpdGVfZ2xvYikKKwkJcmV0
dXJuIC1FTk9NRU07CisKIAlwYXJzZWQtPnRlc3RfZ2xvYiA9IGt6YWxsb2MobGVuIC0gKHBl
cmlvZCAtIGZpbHRlcl9nbG9iKSArIDEsIEdGUF9LRVJORUwpOworCWlmICghcGFyc2VkLT50
ZXN0X2dsb2IpIHsKKwkJa2ZyZWUocGFyc2VkLT5zdWl0ZV9nbG9iKTsKKwkJcmV0dXJuIC1F
Tk9NRU07CisJfQogCiAJc3RybmNweShwYXJzZWQtPnN1aXRlX2dsb2IsIGZpbHRlcl9nbG9i
LCBwZXJpb2QgLSBmaWx0ZXJfZ2xvYik7CiAJc3RybmNweShwYXJzZWQtPnRlc3RfZ2xvYiwg
cGVyaW9kICsgMSwgbGVuIC0gKHBlcmlvZCAtIGZpbHRlcl9nbG9iKSk7CisKKwlyZXR1cm4g
MDsKIH0KIAogLyogQ3JlYXRlIGEgY29weSBvZiBzdWl0ZSB3aXRoIG9ubHkgdGVzdHMgdGhh
dCBtYXRjaCB0ZXN0X2dsb2IuICovCkBAIC0xNTIsMjEgKzE2NCwyNCBAQCBrdW5pdF9maWx0
ZXJfc3VpdGVzKGNvbnN0IHN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQgKnN1aXRlX3NldCwKIAl9
CiAJY29weV9zdGFydCA9IGNvcHk7CiAKLQlpZiAoZmlsdGVyX2dsb2IpCi0JCWt1bml0X3Bh
cnNlX2dsb2JfZmlsdGVyKCZwYXJzZWRfZ2xvYiwgZmlsdGVyX2dsb2IpOworCWlmIChmaWx0
ZXJfZ2xvYikgeworCQkqZXJyID0ga3VuaXRfcGFyc2VfZ2xvYl9maWx0ZXIoJnBhcnNlZF9n
bG9iLCBmaWx0ZXJfZ2xvYik7CisJCWlmICgqZXJyKQorCQkJZ290byBmcmVlX2NvcHk7CisJ
fQogCiAJLyogUGFyc2UgYXR0cmlidXRlIGZpbHRlcnMgKi8KIAlpZiAoZmlsdGVycykgewog
CQlmaWx0ZXJfY291bnQgPSBrdW5pdF9nZXRfZmlsdGVyX2NvdW50KGZpbHRlcnMpOwogCQlw
YXJzZWRfZmlsdGVycyA9IGtjYWxsb2MoZmlsdGVyX2NvdW50LCBzaXplb2YoKnBhcnNlZF9m
aWx0ZXJzKSwgR0ZQX0tFUk5FTCk7CiAJCWlmICghcGFyc2VkX2ZpbHRlcnMpIHsKLQkJCWtm
cmVlKGNvcHkpOwotCQkJcmV0dXJuIGZpbHRlcmVkOworCQkJKmVyciA9IC1FTk9NRU07CisJ
CQlnb3RvIGZyZWVfcGFyc2VkX2dsb2I7CiAJCX0KIAkJZm9yIChqID0gMDsgaiA8IGZpbHRl
cl9jb3VudDsgaisrKQogCQkJcGFyc2VkX2ZpbHRlcnNbal0gPSBrdW5pdF9uZXh0X2F0dHJf
ZmlsdGVyKCZmaWx0ZXJzLCBlcnIpOwogCQlpZiAoKmVycikKLQkJCWdvdG8gZXJyOworCQkJ
Z290byBmcmVlX3BhcnNlZF9maWx0ZXJzOwogCX0KIAogCWZvciAoaSA9IDA7ICZzdWl0ZV9z
ZXQtPnN0YXJ0W2ldICE9IHN1aXRlX3NldC0+ZW5kOyBpKyspIHsKQEAgLTE3OCw3ICsxOTMs
NyBAQCBrdW5pdF9maWx0ZXJfc3VpdGVzKGNvbnN0IHN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQg
KnN1aXRlX3NldCwKIAkJCQkJcGFyc2VkX2dsb2IudGVzdF9nbG9iKTsKIAkJCWlmIChJU19F
UlIoZmlsdGVyZWRfc3VpdGUpKSB7CiAJCQkJKmVyciA9IFBUUl9FUlIoZmlsdGVyZWRfc3Vp
dGUpOwotCQkJCWdvdG8gZXJyOworCQkJCWdvdG8gZnJlZV9wYXJzZWRfZmlsdGVyczsKIAkJ
CX0KIAkJfQogCQlpZiAoZmlsdGVyX2NvdW50ID4gMCAmJiBwYXJzZWRfZmlsdGVycyAhPSBO
VUxMKSB7CkBAIC0xOTUsMTAgKzIxMCwxMSBAQCBrdW5pdF9maWx0ZXJfc3VpdGVzKGNvbnN0
IHN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQgKnN1aXRlX3NldCwKIAkJCQlmaWx0ZXJlZF9zdWl0
ZSA9IG5ld19maWx0ZXJlZF9zdWl0ZTsKIAogCQkJCWlmICgqZXJyKQotCQkJCQlnb3RvIGVy
cjsKKwkJCQkJZ290byBmcmVlX3BhcnNlZF9maWx0ZXJzOworCiAJCQkJaWYgKElTX0VSUihm
aWx0ZXJlZF9zdWl0ZSkpIHsKIAkJCQkJKmVyciA9IFBUUl9FUlIoZmlsdGVyZWRfc3VpdGUp
OwotCQkJCQlnb3RvIGVycjsKKwkJCQkJZ290byBmcmVlX3BhcnNlZF9maWx0ZXJzOwogCQkJ
CX0KIAkJCQlpZiAoIWZpbHRlcmVkX3N1aXRlKQogCQkJCQlicmVhazsKQEAgLTIxMywxNyAr
MjI5LDE5IEBAIGt1bml0X2ZpbHRlcl9zdWl0ZXMoY29uc3Qgc3RydWN0IGt1bml0X3N1aXRl
X3NldCAqc3VpdGVfc2V0LAogCWZpbHRlcmVkLnN0YXJ0ID0gY29weV9zdGFydDsKIAlmaWx0
ZXJlZC5lbmQgPSBjb3B5OwogCi1lcnI6Ci0JaWYgKCplcnIpCi0JCWtmcmVlKGNvcHkpOwor
ZnJlZV9wYXJzZWRfZmlsdGVyczoKKwlpZiAoZmlsdGVyX2NvdW50KQorCQlrZnJlZShwYXJz
ZWRfZmlsdGVycyk7CiAKK2ZyZWVfcGFyc2VkX2dsb2I6CiAJaWYgKGZpbHRlcl9nbG9iKSB7
CiAJCWtmcmVlKHBhcnNlZF9nbG9iLnN1aXRlX2dsb2IpOwogCQlrZnJlZShwYXJzZWRfZ2xv
Yi50ZXN0X2dsb2IpOwogCX0KIAotCWlmIChmaWx0ZXJfY291bnQpCi0JCWtmcmVlKHBhcnNl
ZF9maWx0ZXJzKTsKK2ZyZWVfY29weToKKwlpZiAoKmVycikKKwkJa2ZyZWUoY29weSk7CiAK
IAlyZXR1cm4gZmlsdGVyZWQ7CiB9CmRpZmYgLS1naXQgYS9saWIva3VuaXQvZXhlY3V0b3Jf
dGVzdC5jIGIvbGliL2t1bml0L2V4ZWN1dG9yX3Rlc3QuYwppbmRleCA0MDg0MDcxZDBlYjUu
LmI0ZjZmOTZiMjg0NCAxMDA2NDQKLS0tIGEvbGliL2t1bml0L2V4ZWN1dG9yX3Rlc3QuYwor
KysgYi9saWIva3VuaXQvZXhlY3V0b3JfdGVzdC5jCkBAIC0xMTksNyArMTE5LDcgQEAgc3Rh
dGljIHZvaWQgcGFyc2VfZmlsdGVyX2F0dHJfdGVzdChzdHJ1Y3Qga3VuaXQgKnRlc3QpCiB7
CiAJaW50IGosIGZpbHRlcl9jb3VudDsKIAlzdHJ1Y3Qga3VuaXRfYXR0cl9maWx0ZXIgKnBh
cnNlZF9maWx0ZXJzOwotCWNoYXIgKmZpbHRlcnMgPSAic3BlZWQ+c2xvdywgbW9kdWxlIT1l
eGFtcGxlIjsKKwljaGFyIGZpbHRlcnNbXSA9ICJzcGVlZD5zbG93LCBtb2R1bGUhPWV4YW1w
bGUiLCAqZmlsdGVyID0gZmlsdGVyczsKIAlpbnQgZXJyID0gMDsKIAogCWZpbHRlcl9jb3Vu
dCA9IGt1bml0X2dldF9maWx0ZXJfY291bnQoZmlsdGVycyk7CkBAIC0xMjgsNyArMTI4LDcg
QEAgc3RhdGljIHZvaWQgcGFyc2VfZmlsdGVyX2F0dHJfdGVzdChzdHJ1Y3Qga3VuaXQgKnRl
c3QpCiAJcGFyc2VkX2ZpbHRlcnMgPSBrdW5pdF9rY2FsbG9jKHRlc3QsIGZpbHRlcl9jb3Vu
dCwgc2l6ZW9mKCpwYXJzZWRfZmlsdGVycyksCiAJCQlHRlBfS0VSTkVMKTsKIAlmb3IgKGog
PSAwOyBqIDwgZmlsdGVyX2NvdW50OyBqKyspIHsKLQkJcGFyc2VkX2ZpbHRlcnNbal0gPSBr
dW5pdF9uZXh0X2F0dHJfZmlsdGVyKCZmaWx0ZXJzLCAmZXJyKTsKKwkJcGFyc2VkX2ZpbHRl
cnNbal0gPSBrdW5pdF9uZXh0X2F0dHJfZmlsdGVyKCZmaWx0ZXIsICZlcnIpOwogCQlLVU5J
VF9BU1NFUlRfRVFfTVNHKHRlc3QsIGVyciwgMCwgImZhaWxlZCB0byBwYXJzZSBmaWx0ZXIg
JyVzJyIsIGZpbHRlcnNbal0pOwogCX0KIApAQCAtMTU0LDYgKzE1NCw3IEBAIHN0YXRpYyB2
b2lkIGZpbHRlcl9hdHRyX3Rlc3Qoc3RydWN0IGt1bml0ICp0ZXN0KQogCQkuc3RhcnQgPSBz
dWJzdWl0ZSwgLmVuZCA9ICZzdWJzdWl0ZVsyXSwKIAl9OwogCXN0cnVjdCBrdW5pdF9zdWl0
ZV9zZXQgZ290OworCWNoYXIgZmlsdGVyW10gPSAic3BlZWQ+c2xvdyI7CiAJaW50IGVyciA9
IDA7CiAKIAlzdWJzdWl0ZVswXSA9IGFsbG9jX2Zha2Vfc3VpdGUodGVzdCwgIm5vcm1hbF9z
dWl0ZSIsIGR1bW15X2F0dHJfdGVzdF9jYXNlcyk7CkBAIC0xNjgsNyArMTY5LDcgQEAgc3Rh
dGljIHZvaWQgZmlsdGVyX2F0dHJfdGVzdChzdHJ1Y3Qga3VuaXQgKnRlc3QpCiAJICogYXR0
cmlidXRlIGlzIHVuc2V0IGFuZCB0aHVzLCB0aGUgZmlsdGVyaW5nIGlzIGJhc2VkIG9uIHRo
ZSBwYXJlbnQgYXR0cmlidXRlCiAJICogb2Ygc2xvdy4KIAkgKi8KLQlnb3QgPSBrdW5pdF9m
aWx0ZXJfc3VpdGVzKCZzdWl0ZV9zZXQsIE5VTEwsICJzcGVlZD5zbG93IiwgTlVMTCwgJmVy
cik7CisJZ290ID0ga3VuaXRfZmlsdGVyX3N1aXRlcygmc3VpdGVfc2V0LCBOVUxMLCBmaWx0
ZXIsIE5VTEwsICZlcnIpOwogCUtVTklUX0FTU0VSVF9OT1RfRVJSX09SX05VTEwodGVzdCwg
Z290LnN0YXJ0KTsKIAlLVU5JVF9BU1NFUlRfRVEodGVzdCwgZXJyLCAwKTsKIAlrZnJlZV9h
dF9lbmQodGVzdCwgZ290LnN0YXJ0KTsKQEAgLTE5MSwxMiArMTkyLDEzIEBAIHN0YXRpYyB2
b2lkIGZpbHRlcl9hdHRyX2VtcHR5X3Rlc3Qoc3RydWN0IGt1bml0ICp0ZXN0KQogCQkuc3Rh
cnQgPSBzdWJzdWl0ZSwgLmVuZCA9ICZzdWJzdWl0ZVsyXSwKIAl9OwogCXN0cnVjdCBrdW5p
dF9zdWl0ZV9zZXQgZ290OworCWNoYXIgZmlsdGVyW10gPSAibW9kdWxlIT1kdW1teSI7CiAJ
aW50IGVyciA9IDA7CiAKIAlzdWJzdWl0ZVswXSA9IGFsbG9jX2Zha2Vfc3VpdGUodGVzdCwg
InN1aXRlMSIsIGR1bW15X2F0dHJfdGVzdF9jYXNlcyk7CiAJc3Vic3VpdGVbMV0gPSBhbGxv
Y19mYWtlX3N1aXRlKHRlc3QsICJzdWl0ZTIiLCBkdW1teV9hdHRyX3Rlc3RfY2FzZXMpOwog
Ci0JZ290ID0ga3VuaXRfZmlsdGVyX3N1aXRlcygmc3VpdGVfc2V0LCBOVUxMLCAibW9kdWxl
IT1kdW1teSIsIE5VTEwsICZlcnIpOworCWdvdCA9IGt1bml0X2ZpbHRlcl9zdWl0ZXMoJnN1
aXRlX3NldCwgTlVMTCwgZmlsdGVyLCBOVUxMLCAmZXJyKTsKIAlLVU5JVF9BU1NFUlRfRVEo
dGVzdCwgZXJyLCAwKTsKIAlrZnJlZV9hdF9lbmQodGVzdCwgZ290LnN0YXJ0KTsgLyoganVz
dCBpbiBjYXNlICovCiAKQEAgLTIxMSwxMiArMjEzLDEzIEBAIHN0YXRpYyB2b2lkIGZpbHRl
cl9hdHRyX3NraXBfdGVzdChzdHJ1Y3Qga3VuaXQgKnRlc3QpCiAJCS5zdGFydCA9IHN1YnN1
aXRlLCAuZW5kID0gJnN1YnN1aXRlWzFdLAogCX07CiAJc3RydWN0IGt1bml0X3N1aXRlX3Nl
dCBnb3Q7CisJY2hhciBmaWx0ZXJbXSA9ICJzcGVlZD5zbG93IjsKIAlpbnQgZXJyID0gMDsK
IAogCXN1YnN1aXRlWzBdID0gYWxsb2NfZmFrZV9zdWl0ZSh0ZXN0LCAic3VpdGUiLCBkdW1t
eV9hdHRyX3Rlc3RfY2FzZXMpOwogCiAJLyogV2FudDogc3VpdGUoc2xvdywgbm9ybWFsKSwg
TlVMTCAtPiBzdWl0ZShzbG93IHdpdGggU0tJUCwgbm9ybWFsKSwgTlVMTCAqLwotCWdvdCA9
IGt1bml0X2ZpbHRlcl9zdWl0ZXMoJnN1aXRlX3NldCwgTlVMTCwgInNwZWVkPnNsb3ciLCAi
c2tpcCIsICZlcnIpOworCWdvdCA9IGt1bml0X2ZpbHRlcl9zdWl0ZXMoJnN1aXRlX3NldCwg
TlVMTCwgZmlsdGVyLCAic2tpcCIsICZlcnIpOwogCUtVTklUX0FTU0VSVF9OT1RfRVJSX09S
X05VTEwodGVzdCwgZ290LnN0YXJ0KTsKIAlLVU5JVF9BU1NFUlRfRVEodGVzdCwgZXJyLCAw
KTsKIAlrZnJlZV9hdF9lbmQodGVzdCwgZ290LnN0YXJ0KTsKZGlmZiAtLWdpdCBhL2xpYi9r
dW5pdC90ZXN0LmMgYi9saWIva3VuaXQvdGVzdC5jCmluZGV4IDQ5Njk4YTE2ODQzNy4uNDIx
ZjEzOTgxNDEyIDEwMDY0NAotLS0gYS9saWIva3VuaXQvdGVzdC5jCisrKyBiL2xpYi9rdW5p
dC90ZXN0LmMKQEAgLTc4NCwxMiArNzg0LDEzIEBAIHN0YXRpYyBpbnQga3VuaXRfbW9kdWxl
X25vdGlmeShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLCB1bnNpZ25lZCBsb25nIHZhbCwK
IAogCXN3aXRjaCAodmFsKSB7CiAJY2FzZSBNT0RVTEVfU1RBVEVfTElWRToKLQkJa3VuaXRf
bW9kdWxlX2luaXQobW9kKTsKIAkJYnJlYWs7CiAJY2FzZSBNT0RVTEVfU1RBVEVfR09JTkc6
CiAJCWt1bml0X21vZHVsZV9leGl0KG1vZCk7CiAJCWJyZWFrOwogCWNhc2UgTU9EVUxFX1NU
QVRFX0NPTUlORzoKKwkJa3VuaXRfbW9kdWxlX2luaXQobW9kKTsKKwkJYnJlYWs7CiAJY2Fz
ZSBNT0RVTEVfU1RBVEVfVU5GT1JNRUQ6CiAJCWJyZWFrOwogCX0K

--------------C4KDad23lRefsYFyjwqtZ0O8--
