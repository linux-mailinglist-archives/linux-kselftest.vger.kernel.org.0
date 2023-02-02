Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE42688332
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjBBPzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 10:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjBBPy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:59 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567C65F20
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Feb 2023 07:54:48 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id g16so927222ilr.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Feb 2023 07:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QviJa5qI39tAiH+EiEAx1tSCEeoDFb1KygwG46vo/pc=;
        b=IByEkE/QTfZyYgc54DudkJ9C4OzJ7wrd15HwWBREBzET6HrzJl4/tJH6pm+20aGdjB
         4Un4q1V99zCeU+B0LEJqJr94BIJcpbx9ey/qAAsZUOwmDjtbYwVWmUNKc7WytVwT+6t4
         wYbv24H6hq1cCRKWKen2A1Gk+5xIW4Ofvspjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QviJa5qI39tAiH+EiEAx1tSCEeoDFb1KygwG46vo/pc=;
        b=7QaWLY0GKRPbf7UYC1s0HmJ+WuBkc+GxiKWGddgeVqQCvh6OAHbnL+AXqvNm1RwYEZ
         A8WQAG6U4LimSdQOnLmHJpr/jfhl35GwEU/i1qi4+j7jAd1P1isFC5NeBwjkJMEZ+WJm
         Wk4ExeY7EKNywFUQeZi4msTuxPivUklKNHOaiiGxSF9UkPIHF6iEHbFTUAybbmFxhlIm
         BbthJVGaLYYtBHmc+6zaXdRNXnxViFMa89Rzdo4iQxaZpVK8m5gP10FBEol3dgsg/PMH
         vtirgb6ON8O2VkjDLMl4Zs7rgR7JgXuv+RjOmp7S6hqnHE7moQZxpM2zyF1BI2rm0mS+
         mlJQ==
X-Gm-Message-State: AO0yUKWk1bS/lOkcUxiTQLgKqJG6Q2WvD/oNu2xSOwGLAwBiJ8vF8CbY
        qcQol8ngx6LIjkEpeSMXBnWyTw==
X-Google-Smtp-Source: AK7set9aAW6w80jF/hDK5HoNXYRly8m8EogWAmAnxNP+3TiB5O07eQGyh9B95hKOfJt0zfnDjInVMw==
X-Received: by 2002:a05:6e02:152:b0:310:cc70:a152 with SMTP id j18-20020a056e02015200b00310cc70a152mr4451064ilr.2.1675353287260;
        Thu, 02 Feb 2023 07:54:47 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d191-20020a0262c8000000b00346a98b0a76sm23084jac.77.2023.02.02.07.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:54:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------Jkey07lptSQW11mJ5KpqixFF"
Message-ID: <3e3c7d22-6338-87e0-314a-883429ba8ff0@linuxfoundation.org>
Date:   Thu, 2 Feb 2023 08:54:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.2-rc7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------Jkey07lptSQW11mJ5KpqixFF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.2-rc7.

This KUnit fixes update for Linux 6.2-rc7 consists of 3 fixes to bugs
that cause kernel crash, link error during build, and a third to fix
kunit_test_init_section_suites() extra indirection issue.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

   Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.2-rc7

for you to fetch changes up to 254c71374a70051a043676b67ba4f7ad392b5fe6:

   kunit: fix kunit_test_init_section_suites(...) (2023-01-31 09:10:38 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-6.2-rc7

This KUnit fixes update for Linux 6.2-rc7 consists of 3 fixes to bugs
that cause kernel crash, link error during build, and a third to fix
kunit_test_init_section_suites() extra indirection issue.

----------------------------------------------------------------
Arnd Bergmann (1):
       kunit: Export kunit_running()

Brendan Higgins (1):
       kunit: fix kunit_test_init_section_suites(...)

Rae Moar (1):
       kunit: fix bug in KUNIT_EXPECT_MEMEQ

  include/kunit/test.h |  6 +++---
  lib/kunit/assert.c   | 40 +++++++++++++++++++++++++---------------
  lib/kunit/test.c     |  1 +
  3 files changed, 29 insertions(+), 18 deletions(-)
----------------------------------------------------------------
--------------Jkey07lptSQW11mJ5KpqixFF
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-6.2-rc7.diff"
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-6.2-rc7.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUva3VuaXQvdGVzdC5oIGIvaW5jbHVkZS9rdW5pdC90ZXN0
LmgKaW5kZXggODdlYTkwNTc2YjUwLi4wOGQzNTU5ZGQ3MDMgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUva3VuaXQvdGVzdC5oCisrKyBiL2luY2x1ZGUva3VuaXQvdGVzdC5oCkBAIC0zMDMsNyAr
MzAzLDYgQEAgc3RhdGljIGlubGluZSBpbnQga3VuaXRfcnVuX2FsbF90ZXN0cyh2b2lkKQog
ICovCiAjZGVmaW5lIGt1bml0X3Rlc3RfaW5pdF9zZWN0aW9uX3N1aXRlcyhfX3N1aXRlcy4u
LikJCQlcCiAJX19rdW5pdF90ZXN0X3N1aXRlcyhDT05DQVRFTkFURShfX1VOSVFVRV9JRChh
cnJheSksIF9wcm9iZSksCVwKLQkJCSAgICBDT05DQVRFTkFURShfX1VOSVFVRV9JRChzdWl0
ZXMpLCBfcHJvYmUpLAlcCiAJCQkgICAgIyNfX3N1aXRlcykKIAogI2RlZmluZSBrdW5pdF90
ZXN0X2luaXRfc2VjdGlvbl9zdWl0ZShzdWl0ZSkJXApAQCAtNjgzLDggKzY4Miw5IEBAIGRv
IHsJCQkJCQkJCQkgICAgICAgXAogCQkucmlnaHRfdGV4dCA9ICNyaWdodCwJCQkJCSAgICAg
ICBcCiAJfTsJCQkJCQkJCSAgICAgICBcCiAJCQkJCQkJCQkgICAgICAgXAotCWlmIChsaWtl
bHkobWVtY21wKF9fbGVmdCwgX19yaWdodCwgX19zaXplKSBvcCAwKSkJCSAgICAgICBcCi0J
CWJyZWFrOwkJCQkJCQkgICAgICAgXAorCWlmIChsaWtlbHkoX19sZWZ0ICYmIF9fcmlnaHQp
KQkJCQkJICAgICAgIFwKKwkJaWYgKGxpa2VseShtZW1jbXAoX19sZWZ0LCBfX3JpZ2h0LCBf
X3NpemUpIG9wIDApKQkgICAgICAgXAorCQkJYnJlYWs7CQkJCQkJICAgICAgIFwKIAkJCQkJ
CQkJCSAgICAgICBcCiAJX0tVTklUX0ZBSUxFRCh0ZXN0LAkJCQkJCSAgICAgICBcCiAJCSAg
ICAgIGFzc2VydF90eXBlLAkJCQkJICAgICAgIFwKZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9h
c3NlcnQuYyBiL2xpYi9rdW5pdC9hc3NlcnQuYwppbmRleCBmNWI1MGJhYmUzOGQuLjA1YTA5
NjUyZjVhMSAxMDA2NDQKLS0tIGEvbGliL2t1bml0L2Fzc2VydC5jCisrKyBiL2xpYi9rdW5p
dC9hc3NlcnQuYwpAQCAtMjQxLDI0ICsyNDEsMzQgQEAgdm9pZCBrdW5pdF9tZW1fYXNzZXJ0
X2Zvcm1hdChjb25zdCBzdHJ1Y3Qga3VuaXRfYXNzZXJ0ICphc3NlcnQsCiAJbWVtX2Fzc2Vy
dCA9IGNvbnRhaW5lcl9vZihhc3NlcnQsIHN0cnVjdCBrdW5pdF9tZW1fYXNzZXJ0LAogCQkJ
CSAgYXNzZXJ0KTsKIAotCXN0cmluZ19zdHJlYW1fYWRkKHN0cmVhbSwKLQkJCSAgS1VOSVRf
U1VCVEVTVF9JTkRFTlQgIkV4cGVjdGVkICVzICVzICVzLCBidXRcbiIsCi0JCQkgIG1lbV9h
c3NlcnQtPnRleHQtPmxlZnRfdGV4dCwKLQkJCSAgbWVtX2Fzc2VydC0+dGV4dC0+b3BlcmF0
aW9uLAotCQkJICBtZW1fYXNzZXJ0LT50ZXh0LT5yaWdodF90ZXh0KTsKKwlpZiAoIW1lbV9h
c3NlcnQtPmxlZnRfdmFsdWUpIHsKKwkJc3RyaW5nX3N0cmVhbV9hZGQoc3RyZWFtLAorCQkJ
CSAgS1VOSVRfU1VCVEVTVF9JTkRFTlQgIkV4cGVjdGVkICVzIGlzIG5vdCBudWxsLCBidXQg
aXNcbiIsCisJCQkJICBtZW1fYXNzZXJ0LT50ZXh0LT5sZWZ0X3RleHQpOworCX0gZWxzZSBp
ZiAoIW1lbV9hc3NlcnQtPnJpZ2h0X3ZhbHVlKSB7CisJCXN0cmluZ19zdHJlYW1fYWRkKHN0
cmVhbSwKKwkJCQkgIEtVTklUX1NVQlRFU1RfSU5ERU5UICJFeHBlY3RlZCAlcyBpcyBub3Qg
bnVsbCwgYnV0IGlzXG4iLAorCQkJCSAgbWVtX2Fzc2VydC0+dGV4dC0+cmlnaHRfdGV4dCk7
CisJfSBlbHNlIHsKKwkJc3RyaW5nX3N0cmVhbV9hZGQoc3RyZWFtLAorCQkJCUtVTklUX1NV
QlRFU1RfSU5ERU5UICJFeHBlY3RlZCAlcyAlcyAlcywgYnV0XG4iLAorCQkJCW1lbV9hc3Nl
cnQtPnRleHQtPmxlZnRfdGV4dCwKKwkJCQltZW1fYXNzZXJ0LT50ZXh0LT5vcGVyYXRpb24s
CisJCQkJbWVtX2Fzc2VydC0+dGV4dC0+cmlnaHRfdGV4dCk7CiAKLQlzdHJpbmdfc3RyZWFt
X2FkZChzdHJlYW0sIEtVTklUX1NVQlNVQlRFU1RfSU5ERU5UICIlcyA9PVxuIiwKLQkJCSAg
bWVtX2Fzc2VydC0+dGV4dC0+bGVmdF90ZXh0KTsKLQlrdW5pdF9hc3NlcnRfaGV4ZHVtcChz
dHJlYW0sIG1lbV9hc3NlcnQtPmxlZnRfdmFsdWUsCi0JCQkgICAgIG1lbV9hc3NlcnQtPnJp
Z2h0X3ZhbHVlLCBtZW1fYXNzZXJ0LT5zaXplKTsKKwkJc3RyaW5nX3N0cmVhbV9hZGQoc3Ry
ZWFtLCBLVU5JVF9TVUJTVUJURVNUX0lOREVOVCAiJXMgPT1cbiIsCisJCQkJbWVtX2Fzc2Vy
dC0+dGV4dC0+bGVmdF90ZXh0KTsKKwkJa3VuaXRfYXNzZXJ0X2hleGR1bXAoc3RyZWFtLCBt
ZW1fYXNzZXJ0LT5sZWZ0X3ZhbHVlLAorCQkJCQltZW1fYXNzZXJ0LT5yaWdodF92YWx1ZSwg
bWVtX2Fzc2VydC0+c2l6ZSk7CiAKLQlzdHJpbmdfc3RyZWFtX2FkZChzdHJlYW0sICJcbiIp
OworCQlzdHJpbmdfc3RyZWFtX2FkZChzdHJlYW0sICJcbiIpOwogCi0Jc3RyaW5nX3N0cmVh
bV9hZGQoc3RyZWFtLCBLVU5JVF9TVUJTVUJURVNUX0lOREVOVCAiJXMgPT1cbiIsCi0JCQkg
IG1lbV9hc3NlcnQtPnRleHQtPnJpZ2h0X3RleHQpOwotCWt1bml0X2Fzc2VydF9oZXhkdW1w
KHN0cmVhbSwgbWVtX2Fzc2VydC0+cmlnaHRfdmFsdWUsCi0JCQkgICAgIG1lbV9hc3NlcnQt
PmxlZnRfdmFsdWUsIG1lbV9hc3NlcnQtPnNpemUpOworCQlzdHJpbmdfc3RyZWFtX2FkZChz
dHJlYW0sIEtVTklUX1NVQlNVQlRFU1RfSU5ERU5UICIlcyA9PVxuIiwKKwkJCQltZW1fYXNz
ZXJ0LT50ZXh0LT5yaWdodF90ZXh0KTsKKwkJa3VuaXRfYXNzZXJ0X2hleGR1bXAoc3RyZWFt
LCBtZW1fYXNzZXJ0LT5yaWdodF92YWx1ZSwKKwkJCQkJbWVtX2Fzc2VydC0+bGVmdF92YWx1
ZSwgbWVtX2Fzc2VydC0+c2l6ZSk7CiAKLQlrdW5pdF9hc3NlcnRfcHJpbnRfbXNnKG1lc3Nh
Z2UsIHN0cmVhbSk7CisJCWt1bml0X2Fzc2VydF9wcmludF9tc2cobWVzc2FnZSwgc3RyZWFt
KTsKKwl9CiB9CiBFWFBPUlRfU1lNQk9MX0dQTChrdW5pdF9tZW1fYXNzZXJ0X2Zvcm1hdCk7
CmRpZmYgLS1naXQgYS9saWIva3VuaXQvdGVzdC5jIGIvbGliL2t1bml0L3Rlc3QuYwppbmRl
eCBjOWViZjk3NWU1NmIuLjg5MGJhNWIzYTk4MSAxMDA2NDQKLS0tIGEvbGliL2t1bml0L3Rl
c3QuYworKysgYi9saWIva3VuaXQvdGVzdC5jCkBAIC0yMSw2ICsyMSw3IEBACiAjaW5jbHVk
ZSAidHJ5LWNhdGNoLWltcGwuaCIKIAogREVGSU5FX1NUQVRJQ19LRVlfRkFMU0Uoa3VuaXRf
cnVubmluZyk7CitFWFBPUlRfU1lNQk9MX0dQTChrdW5pdF9ydW5uaW5nKTsKIAogI2lmIElT
X0JVSUxUSU4oQ09ORklHX0tVTklUKQogLyoK

--------------Jkey07lptSQW11mJ5KpqixFF--
