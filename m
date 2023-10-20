Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955AE7D14BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjJTRUF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 13:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjJTRUE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 13:20:04 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3BA3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 10:20:02 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-351610727adso1459105ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697822402; x=1698427202; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jk3ZSSeatr3lIVeOg2wA+LI5enZ+MOKk3ZrYh+aCyY=;
        b=BK0i2PChpnzpg/w07GQYKfHRpodtcFllZcIu4/UcDDx8w9tWzVAy9Ok+NKD6VrcysS
         qLlXhObKy0/TRKHqzpOJWdgUlA56G/4CX2wNO57iMaBvVkZdrYnCn1omv6tuTmrD+7Db
         goQn6Fb6mWuLNVs2dWAeGYJ8Ra8HqUbXXosAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822402; x=1698427202;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Jk3ZSSeatr3lIVeOg2wA+LI5enZ+MOKk3ZrYh+aCyY=;
        b=aZDuzCgJJkTisfjCrgsxyzczDSlnUV1bJoebDEavwnDehEPULsFqYufSi4+wUmxsZs
         iFXzi71XpLIJ6DNDgHgLJmihkdfq48YaN68wQ75NPCMGjO20HWAcg5x0pJEDU5rWMak+
         RtfV+wLn/RWhCjKmPI0gH4PZ5PmoyZwT2NGMa7yISDQxzr5f1g/V0fPezU5qv/BQCWXd
         +Hg7O9BDZ6L+aFSjzY4LDRBLdoJaacmBp9QMWrURDTx+CzWlUYpuiEwHKxMEGCxwRkK1
         goUi9p5iBzotby0MbPVJq+caEDtsjhgPWda4pZnxWpUWPOH6gr2NxgImUqw7FeQX2Tbf
         FYYw==
X-Gm-Message-State: AOJu0YzUebhFpcKrgoYCH1xLEJKKz7dNmQ09vkUb8X4RPExOahiRe9cB
        cNWdcU0qW1Xu0baDHSMnRqRnPQ==
X-Google-Smtp-Source: AGHT+IG5s/Wh0GiXVTRHGycjRqrkjj2WP6fjXT7R4vfOijDNRJcy+ruHZRUjngHSuX9EL04wbvxIcQ==
X-Received: by 2002:a05:6602:2c88:b0:7a6:7d87:1181 with SMTP id i8-20020a0566022c8800b007a67d871181mr3432486iow.2.1697822401899;
        Fri, 20 Oct 2023 10:20:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id gw8-20020a0566381ee800b00437a3c128dfsm655349jab.108.2023.10.20.10.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:20:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------gmVXVuiL9iWoW47fv3lRzrkr"
Message-ID: <817898d0-dbe1-4016-af10-abd1731748ea@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 11:20:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, skhan@linuxfoundation.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.6-rc7
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
--------------gmVXVuiL9iWoW47fv3lRzrkr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.6-rc7.

This Kselftest update for Linux 6.6-rc7 consists of one single fix
to assert check in user_events abi_test to properly check bit value
on Big Endian architectures. The current code treats the bit values
as Little Endian and the check fails on Big Endian.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c:

   selftests: Fix wrong TARGET in kselftest top level Makefile (2023-09-26 18:47:37 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest_active-fixes-6.6-rc7

for you to fetch changes up to cf5a103c98a6fb9ee3164334cb5502df6360749b:

   selftests/user_events: Fix abi_test for BE archs (2023-10-17 15:07:19 -0600)

----------------------------------------------------------------
linux_kselftest_active-fixes-6.6-rc7

This Kselftest update for Linux 6.6-rc7 consists of one single fix
to assert check in user_events abi_test to properly check bit value
on Big Endian architectures. The current code treats the bit values
as Little Endian and the check fails on Big Endian.

----------------------------------------------------------------
Beau Belgrave (1):
       selftests/user_events: Fix abi_test for BE archs

  tools/testing/selftests/user_events/abi_test.c | 16 +++++++++-------
  1 file changed, 9 insertions(+), 7 deletions(-)
----------------------------------------------------------------
--------------gmVXVuiL9iWoW47fv3lRzrkr
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest_active-fixes-6.6-rc7.diff"
Content-Disposition: attachment;
 filename="linux_kselftest_active-fixes-6.6-rc7.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2FiaV90
ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91c2VyX2V2ZW50cy9hYmlfdGVzdC5j
CmluZGV4IDgyMDJmMTMyN2MzOS4uZjU1NzVlZjIwMDdjIDEwMDY0NAotLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy91c2VyX2V2ZW50cy9hYmlfdGVzdC5jCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2FiaV90ZXN0LmMKQEAgLTQ3LDcgKzQ3LDcg
QEAgc3RhdGljIGludCBjaGFuZ2VfZXZlbnQoYm9vbCBlbmFibGUpCiAJcmV0dXJuIHJldDsK
IH0KIAotc3RhdGljIGludCByZWdfZW5hYmxlKGxvbmcgKmVuYWJsZSwgaW50IHNpemUsIGlu
dCBiaXQpCitzdGF0aWMgaW50IHJlZ19lbmFibGUodm9pZCAqZW5hYmxlLCBpbnQgc2l6ZSwg
aW50IGJpdCkKIHsKIAlzdHJ1Y3QgdXNlcl9yZWcgcmVnID0gezB9OwogCWludCBmZCA9IG9w
ZW4oZGF0YV9maWxlLCBPX1JEV1IpOwpAQCAtNjksNyArNjksNyBAQCBzdGF0aWMgaW50IHJl
Z19lbmFibGUobG9uZyAqZW5hYmxlLCBpbnQgc2l6ZSwgaW50IGJpdCkKIAlyZXR1cm4gcmV0
OwogfQogCi1zdGF0aWMgaW50IHJlZ19kaXNhYmxlKGxvbmcgKmVuYWJsZSwgaW50IGJpdCkK
K3N0YXRpYyBpbnQgcmVnX2Rpc2FibGUodm9pZCAqZW5hYmxlLCBpbnQgYml0KQogewogCXN0
cnVjdCB1c2VyX3VucmVnIHJlZyA9IHswfTsKIAlpbnQgZmQgPSBvcGVuKGRhdGFfZmlsZSwg
T19SRFdSKTsKQEAgLTkwLDcgKzkwLDggQEAgc3RhdGljIGludCByZWdfZGlzYWJsZShsb25n
ICplbmFibGUsIGludCBiaXQpCiB9CiAKIEZJWFRVUkUodXNlcikgewotCWxvbmcgY2hlY2s7
CisJaW50IGNoZWNrOworCWxvbmcgY2hlY2tfbG9uZzsKIAlib29sIHVtb3VudDsKIH07CiAK
QEAgLTk5LDYgKzEwMCw3IEBAIEZJWFRVUkVfU0VUVVAodXNlcikgewogCiAJY2hhbmdlX2V2
ZW50KGZhbHNlKTsKIAlzZWxmLT5jaGVjayA9IDA7CisJc2VsZi0+Y2hlY2tfbG9uZyA9IDA7
CiB9CiAKIEZJWFRVUkVfVEVBUkRPV04odXNlcikgewpAQCAtMTM2LDkgKzEzOCw5IEBAIFRF
U1RfRih1c2VyLCBiaXRfc2l6ZXMpIHsKIAogI2lmIEJJVFNfUEVSX0xPTkcgPT0gOAogCS8q
IEFsbG93IDAtNjQgYml0cyBmb3IgNjQtYml0ICovCi0JQVNTRVJUX0VRKDAsIHJlZ19lbmFi
bGUoJnNlbGYtPmNoZWNrLCBzaXplb2YobG9uZyksIDYzKSk7Ci0JQVNTRVJUX05FKDAsIHJl
Z19lbmFibGUoJnNlbGYtPmNoZWNrLCBzaXplb2YobG9uZyksIDY0KSk7Ci0JQVNTRVJUX0VR
KDAsIHJlZ19kaXNhYmxlKCZzZWxmLT5jaGVjaywgNjMpKTsKKwlBU1NFUlRfRVEoMCwgcmVn
X2VuYWJsZSgmc2VsZi0+Y2hlY2tfbG9uZywgc2l6ZW9mKGxvbmcpLCA2MykpOworCUFTU0VS
VF9ORSgwLCByZWdfZW5hYmxlKCZzZWxmLT5jaGVja19sb25nLCBzaXplb2YobG9uZyksIDY0
KSk7CisJQVNTRVJUX0VRKDAsIHJlZ19kaXNhYmxlKCZzZWxmLT5jaGVja19sb25nLCA2Mykp
OwogI2VuZGlmCiAKIAkvKiBEaXNhbGxvd2VkIHNpemVzIChldmVyeXRoaW5nIGJlc2lkZSA0
IGFuZCA4KSAqLwpAQCAtMjAwLDcgKzIwMiw3IEBAIHN0YXRpYyBpbnQgY2xvbmVfY2hlY2so
dm9pZCAqY2hlY2spCiAJZm9yIChpID0gMDsgaSA8IDEwOyArK2kpIHsKIAkJdXNsZWVwKDEw
MDAwMCk7CiAKLQkJaWYgKCoobG9uZyAqKWNoZWNrKQorCQlpZiAoKihpbnQgKiljaGVjaykK
IAkJCXJldHVybiAwOwogCX0KIAo=

--------------gmVXVuiL9iWoW47fv3lRzrkr--
