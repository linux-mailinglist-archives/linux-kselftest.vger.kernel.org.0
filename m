Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21125FC9F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 19:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJLRce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJLRcc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 13:32:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC28573C15
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Oct 2022 10:32:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p16so8275257iod.6
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Oct 2022 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:cc:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+kQEr10CffGYkP9q7mTic/LVRYEHz5k8rQoBjrooJG0=;
        b=AXq22O9iap2zuRdKqLSGBpDoF6E3RuF6Yy/w/9C5nvyvhmbvLlqniXj0iC+vssKjSx
         B9s4768GXsAi2i8PgQCrcmz9ju7RFQofeR6Y34WpfeygAGY3nfs499L7ExvIE4cpOHLG
         ul+I3HcLNpg7RfbZ+PcjIR3UjXRXdNjMlc0NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:cc:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kQEr10CffGYkP9q7mTic/LVRYEHz5k8rQoBjrooJG0=;
        b=2XRTFAnIkANWpO+Wz4Z9vXvDp7CCBwgZiqC2lXw78lCBc5PrqbZ8zSeZL6/moMWuxZ
         S+4pzc5ItqyexW3IJXmcmny3jbhNuCdYNmsLcHy6goaX4U9V2ApX3/74rUrnnT3FjuSU
         gxGCrPgoBqk8wS3eotk/yJQCQHQdWFCvZX1KZoKnqYUf06Z1Gq0BPw5IxbUIZ9OzDoNM
         BnbhgiUyrL6kh7KQRk/BxPwsTmiO+rT/wASFvcJj/oKqlAeTY20UE5PY6O75RKCMFZNt
         OrkaHl1B2Zkd6zW0AnNLmxrwxWOmwlZuX6770Rj0O1V51IBJO2o84njc3qCoCMykSZ24
         fH9Q==
X-Gm-Message-State: ACrzQf1O+ywW3QU07URBhGIsAv68joKbdpMtOhyq/+F1bTG8qQgdXO21
        Egv4PtLzbkNVLDetKyTI1E+zUA==
X-Google-Smtp-Source: AMsMyM5ga/fIEIvc2NKHh9AOW5wqunRfgw5h3/xVIUAmxbmOgGwtx70x1pP/NAAzl/9EGjH5QS7wCA==
X-Received: by 2002:a6b:b887:0:b0:6bb:fc82:d94b with SMTP id i129-20020a6bb887000000b006bbfc82d94bmr9259243iof.205.1665595950219;
        Wed, 12 Oct 2022 10:32:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l8-20020a056e020e4800b002fa0ca86f76sm5946097ilk.15.2022.10.12.10.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 10:32:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------S7KDcRauXdkafrWSJvBRep1E"
Message-ID: <b78559c9-0ccd-5c25-bd51-bf3f80904c65@linuxfoundation.org>
Date:   Wed, 12 Oct 2022 11:32:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Kselftest second update for Linux 6.1-rc1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------S7KDcRauXdkafrWSJvBRep1E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following second Kselftest update for Linux 6.1-rc1.

This second Kselftest update for Linux 6.1-rc1 consists of fixes
and improvements to memory-hotplug test and a minor spelling fix
to ftrace test.

diff for this pull request is attached

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 83e14a57d59f22a89ad7d59752f5b69189299531:

   docs:kselftest: fix kselftest_module.h path of example module (2022-10-05 11:05:18 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.1-rc1-2

for you to fetch changes up to 6a24247132db8122600dc5523e3a62fa8fd28367:

   docs: notifier-error-inject: Correct test's name (2022-10-07 10:32:16 -0600)

----------------------------------------------------------------
linux-kselftest-next-6.1-rc1-2

This second Kselftest update for Linux 6.1-rc1 consists of fixes
and improvements to memory-hotplug test and a minor spelling fix
to ftrace test.

----------------------------------------------------------------
Randy Dunlap (1):
       selftests/ftrace: func_event_triggers: fix typo in user message

Zhao Gongyi (4):
       selftests/memory-hotplug: Add checking after online or offline
       selftests/memory-hotplug: Restore memory before exit
       selftests/memory-hotplug: Adjust log info for maintainability
       docs: notifier-error-inject: Correct test's name

  .../fault-injection/notifier-error-inject.rst      |  4 +--
  .../ftrace/test.d/ftrace/func_event_triggers.tc    |  2 +-
  .../selftests/memory-hotplug/mem-on-off-test.sh    | 34 +++++++++++++++++-----
  3 files changed, 30 insertions(+), 10 deletions(-)
----------------------------------------------------------------
--------------S7KDcRauXdkafrWSJvBRep1E
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-6.1-rc1-2.diff"
Content-Disposition: attachment;
 filename="linux-kselftest-next-6.1-rc1-2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZmF1bHQtaW5qZWN0aW9uL25vdGlmaWVyLWVy
cm9yLWluamVjdC5yc3QgYi9Eb2N1bWVudGF0aW9uL2ZhdWx0LWluamVjdGlvbi9ub3RpZmll
ci1lcnJvci1pbmplY3QucnN0CmluZGV4IDE2NjhiNmU0OGQzYS4uZmRmMmRjNDMzZWFkIDEw
MDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2ZhdWx0LWluamVjdGlvbi9ub3RpZmllci1lcnJv
ci1pbmplY3QucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZmF1bHQtaW5qZWN0aW9uL25vdGlm
aWVyLWVycm9yLWluamVjdC5yc3QKQEAgLTkxLDggKzkxLDggQEAgRm9yIG1vcmUgdXNhZ2Ug
ZXhhbXBsZXMKIFRoZXJlIGFyZSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cyB1c2luZyB0aGUg
bm90aWZpZXIgZXJyb3IgaW5qZWN0aW9uIGZlYXR1cmVzCiBmb3IgQ1BVIGFuZCBtZW1vcnkg
bm90aWZpZXJzLgogCi0gKiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jcHUtaG90cGx1Zy9v
bi1vZmYtdGVzdC5zaAotICogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVtb3J5LWhvdHBs
dWcvb24tb2ZmLXRlc3Quc2gKKyAqIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NwdS1ob3Rw
bHVnL2NwdS1vbi1vZmYtdGVzdC5zaAorICogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVt
b3J5LWhvdHBsdWcvbWVtLW9uLW9mZi10ZXN0LnNoCiAKIFRoZXNlIHNjcmlwdHMgZmlyc3Qg
ZG8gc2ltcGxlIG9ubGluZSBhbmQgb2ZmbGluZSB0ZXN0cyBhbmQgdGhlbiBkbyBmYXVsdAog
aW5qZWN0aW9uIHRlc3RzIGlmIG5vdGlmaWVyIGVycm9yIGluamVjdGlvbiBtb2R1bGUgaXMg
YXZhaWxhYmxlLgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNl
L3Rlc3QuZC9mdHJhY2UvZnVuY19ldmVudF90cmlnZ2Vycy50YyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZnRyYWNlL2Z1bmNfZXZlbnRfdHJpZ2dlcnMudGMK
aW5kZXggMzE0NWIwZjE4MzVjLi44ZDI2ZDU1MDU4MDggMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZnRyYWNlL2Z1bmNfZXZlbnRfdHJpZ2dl
cnMudGMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9mdHJh
Y2UvZnVuY19ldmVudF90cmlnZ2Vycy50YwpAQCAtODUsNyArODUsNyBAQCBydW5fZW5hYmxl
X2Rpc2FibGUoKSB7CiAJZWNobyAkY2hlY2tfZGlzYWJsZSA+ICRFVkVOVF9FTkFCTEUKICAg
ICBkb25lCiAgICAgc2xlZXAgJFNMRUVQX1RJTUUKLSAgICBlY2hvICIgbWFrZSBzdXJlIGl0
J3Mgc3RpbGwgd29ya3MiCisgICAgZWNobyAiIG1ha2Ugc3VyZSBpdCBzdGlsbCB3b3JrcyIK
ICAgICB0ZXN0X2V2ZW50X2VuYWJsZWQgJGNoZWNrX2VuYWJsZV9zdGFyCiAKICAgICByZXNl
dF9mdHJhY2VfZmlsdGVyCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9t
ZW1vcnktaG90cGx1Zy9tZW0tb24tb2ZmLXRlc3Quc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9tZW1vcnktaG90cGx1Zy9tZW0tb24tb2ZmLXRlc3Quc2gKaW5kZXggNDZhOTdmMzE4
ZjU4Li43NGVlNTA2N2E4Y2UgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L21lbW9yeS1ob3RwbHVnL21lbS1vbi1vZmYtdGVzdC5zaAorKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9tZW1vcnktaG90cGx1Zy9tZW0tb24tb2ZmLXRlc3Quc2gKQEAgLTEzNCw2
ICsxMzQsMTYgQEAgb2ZmbGluZV9tZW1vcnlfZXhwZWN0X2ZhaWwoKQogCXJldHVybiAwCiB9
CiAKK29ubGluZV9hbGxfb2ZmbGluZV9tZW1vcnkoKQoreworCWZvciBtZW1vcnkgaW4gYGhv
dHBsdWdnYWJsZV9vZmZsaW5lX21lbW9yeWA7IGRvCisJCWlmICEgb25saW5lX21lbW9yeV9l
eHBlY3Rfc3VjY2VzcyAkbWVtb3J5OyB0aGVuCisJCQllY2hvICIkRlVOQ05BTUUgJG1lbW9y
eTogdW5leHBlY3RlZCBmYWlsIiA+JjIKKwkJCXJldHZhbD0xCisJCWZpCisJZG9uZQorfQor
CiBlcnJvcj0tMTIKIHByaW9yaXR5PTAKICMgUnVuIHdpdGggZGVmYXVsdCBvZiByYXRpbz0y
IGZvciBLc2VsZnRlc3QgcnVuCkBAIC0xOTcsOCArMjA3LDExIEBAIGVjaG8gLWUgIlx0IHRy
eWluZyB0byBvZmZsaW5lICR0YXJnZXQgb3V0IG9mICRob3RwbHVnZ2FibGVfbnVtIG1lbW9y
eSBibG9jayhzKToiCiBmb3IgbWVtb3J5IGluIGBob3RwbHVnZ2FibGVfb25saW5lX21lbW9y
eWA7IGRvCiAJaWYgWyAiJHRhcmdldCIgLWd0IDAgXTsgdGhlbgogCQllY2hvICJvbmxpbmUt
Pm9mZmxpbmUgbWVtb3J5JG1lbW9yeSIKLQkJaWYgb2ZmbGluZV9tZW1vcnlfZXhwZWN0X3N1
Y2Nlc3MgJG1lbW9yeTsgdGhlbgorCQlpZiBvZmZsaW5lX21lbW9yeV9leHBlY3Rfc3VjY2Vz
cyAkbWVtb3J5ICY+L2Rldi9udWxsOyB0aGVuCiAJCQl0YXJnZXQ9JCgoJHRhcmdldCAtIDEp
KQorCQkJZWNobyAiLT4gU3VjY2VzcyIKKwkJZWxzZQorCQkJZWNobyAiLT4gRmFpbHVyZSIK
IAkJZmkKIAlmaQogZG9uZQpAQCAtMjU3LDcgKzI3MCw3IEBAIHByZXJlcXVpc2l0ZV9leHRy
YQogZWNobyAwID4gJE5PVElGSUVSX0VSUl9JTkpFQ1RfRElSL2FjdGlvbnMvTUVNX0dPSU5H
X09GRkxJTkUvZXJyb3IKIGZvciBtZW1vcnkgaW4gYGhvdHBsdWdnYWJsZV9vbmxpbmVfbWVt
b3J5YDsgZG8KIAlpZiBbICQoKFJBTkRPTSAlIDEwMCkpIC1sdCAkcmF0aW8gXTsgdGhlbgot
CQlvZmZsaW5lX21lbW9yeV9leHBlY3Rfc3VjY2VzcyAkbWVtb3J5CisJCW9mZmxpbmVfbWVt
b3J5X2V4cGVjdF9zdWNjZXNzICRtZW1vcnkgJj4vZGV2L251bGwKIAlmaQogZG9uZQogCkBA
IC0yNjYsMTYgKzI3OSwxNiBAQCBkb25lCiAjCiBlY2hvICRlcnJvciA+ICROT1RJRklFUl9F
UlJfSU5KRUNUX0RJUi9hY3Rpb25zL01FTV9HT0lOR19PTkxJTkUvZXJyb3IKIGZvciBtZW1v
cnkgaW4gYGhvdHBsdWdnYWJsZV9vZmZsaW5lX21lbW9yeWA7IGRvCi0Jb25saW5lX21lbW9y
eV9leHBlY3RfZmFpbCAkbWVtb3J5CisJaWYgISBvbmxpbmVfbWVtb3J5X2V4cGVjdF9mYWls
ICRtZW1vcnk7IHRoZW4KKwkJcmV0dmFsPTEKKwlmaQogZG9uZQogCiAjCiAjIE9ubGluZSBh
bGwgaG90LXBsdWdnYWJsZSBtZW1vcnkKICMKIGVjaG8gMCA+ICROT1RJRklFUl9FUlJfSU5K
RUNUX0RJUi9hY3Rpb25zL01FTV9HT0lOR19PTkxJTkUvZXJyb3IKLWZvciBtZW1vcnkgaW4g
YGhvdHBsdWdnYWJsZV9vZmZsaW5lX21lbW9yeWA7IGRvCi0Jb25saW5lX21lbW9yeV9leHBl
Y3Rfc3VjY2VzcyAkbWVtb3J5Ci1kb25lCitvbmxpbmVfYWxsX29mZmxpbmVfbWVtb3J5CiAK
ICMKICMgVGVzdCBtZW1vcnkgaG90LXJlbW92ZSBlcnJvciBoYW5kbGluZyAob25saW5lID0+
IG9mZmxpbmUpCkBAIC0yODMsMTEgKzI5NiwxOCBAQCBkb25lCiBlY2hvICRlcnJvciA+ICRO
T1RJRklFUl9FUlJfSU5KRUNUX0RJUi9hY3Rpb25zL01FTV9HT0lOR19PRkZMSU5FL2Vycm9y
CiBmb3IgbWVtb3J5IGluIGBob3RwbHVnZ2FibGVfb25saW5lX21lbW9yeWA7IGRvCiAJaWYg
WyAkKChSQU5ET00gJSAxMDApKSAtbHQgJHJhdGlvIF07IHRoZW4KLQkJb2ZmbGluZV9tZW1v
cnlfZXhwZWN0X2ZhaWwgJG1lbW9yeQorCQlpZiAhIG9mZmxpbmVfbWVtb3J5X2V4cGVjdF9m
YWlsICRtZW1vcnk7IHRoZW4KKwkJCXJldHZhbD0xCisJCWZpCiAJZmkKIGRvbmUKIAogZWNo
byAwID4gJE5PVElGSUVSX0VSUl9JTkpFQ1RfRElSL2FjdGlvbnMvTUVNX0dPSU5HX09GRkxJ
TkUvZXJyb3IKIC9zYmluL21vZHByb2JlIC1xIC1yIG1lbW9yeS1ub3RpZmllci1lcnJvci1p
bmplY3QKIAorIworIyBSZXN0b3JlIG1lbW9yeSBiZWZvcmUgZXhpdAorIworb25saW5lX2Fs
bF9vZmZsaW5lX21lbW9yeQorCiBleGl0ICRyZXR2YWwK

--------------S7KDcRauXdkafrWSJvBRep1E--
