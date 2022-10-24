Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E929B60B5E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Oct 2022 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJXSnj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJXSnZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 14:43:25 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1583108252
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 10:25:30 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id m6so9578556pfb.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/KDE+ZSByxuwvp2Mh5tqtliS1mJsjNthfkvCjtjqWOc=;
        b=VR70NOdmonY9xti+I2mftN/fO5MSCOEqOMQdyXu9zkTVzTpBpjogLNZx8Fpy1CX3WG
         Xof1GvwLdr9TOIwoFww+uPjBElVHHdeQ5J0KVEFNHf6ieSOglmrnNMK8gRzC1vnES/ki
         WH8UChPriwQx6YjdhH0x4iNga1Qh55tCl5u1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KDE+ZSByxuwvp2Mh5tqtliS1mJsjNthfkvCjtjqWOc=;
        b=wOohf/6Fys/CxuGBvjRzrLFx4PJ2DmNP11W4L04l/u7a+8uIv4BumLlEEfDxSgX5/S
         rhLeiJi9EMR6ZxES2QUgJYpLvYgXPzARMqAhPwExzjUQBY8ZiiI9/VZ5edpq9X0gsx5y
         TmdRRLk+4+VNaGV/yUhcE+pH8s5zCQLZUE/FhRXo3HxGIiFNfHzrfs3QLIFwfHMImEKC
         vBYHYothzFnxUpQ31c1XBrASIFQxFElKcWORVfVLcqeKqyFNGhopr0V52t8s2ZZ0O9+z
         R3f8mn7U+TEKS/96a1wy80Cmoj+xuom/shROJqDICrPIqnirmPT00coAitQUGS2Ae2Ck
         PQjA==
X-Gm-Message-State: ACrzQf3zvRQcBzac27GYQ2Jqb8EZtYdR2Im5DpMdMfpsPwGYxGN8nIfu
        aZ8+dCh8IXahfHnhNlf+w477c5266DpKVg==
X-Google-Smtp-Source: AMsMyM4s91x+KgOQrSOXBLmvilHsV0EQlDIBoGj6O1GMTz1aa1gRlmyEPkx1kemaKziqOIyLVtlSbg==
X-Received: by 2002:a05:6e02:1aab:b0:2fa:80c2:8375 with SMTP id l11-20020a056e021aab00b002fa80c28375mr21505543ilv.72.1666630149909;
        Mon, 24 Oct 2022 09:49:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h18-20020a056602155200b006bbddd49984sm109429iow.9.2022.10.24.09.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:49:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------RcXPsDbTzYcGigJSsyMdly3r"
Message-ID: <f2934916-9b69-9603-9ae3-580b0c3eb97d@linuxfoundation.org>
Date:   Mon, 24 Oct 2022 10:49:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.1-rc3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------RcXPsDbTzYcGigJSsyMdly3r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.1-rc3.

This KUnit fixes update for Linux 6.1-rc3 consists of one single fix
to update alloc_string_stream() callers to check for IS_ERR() instead
of NULL to be in sync with alloc_string_stream() returning IS_ERR().

diff for this pull request is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.1-rc3

for you to fetch changes up to 618887768bb71f0a475334fa5a4fba7dc98d7ab5:

   kunit: update NULL vs IS_ERR() tests (2022-10-18 15:08:42 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-6.1-rc3

This KUnit fixes update for Linux 6.1-rc3 consists of one single fix
to update alloc_string_stream() callers to check for IS_ERR() instead
of NULL to be in sync with alloc_string_stream() returning IS_ERR().

----------------------------------------------------------------
Dan Carpenter (1):
       kunit: update NULL vs IS_ERR() tests

  lib/kunit/string-stream.c | 4 ++--
  lib/kunit/test.c          | 2 +-
  2 files changed, 3 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------RcXPsDbTzYcGigJSsyMdly3r
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-6.1-rc3.diff"
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-6.1-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9zdHJpbmctc3RyZWFtLmMgYi9saWIva3VuaXQvc3Ry
aW5nLXN0cmVhbS5jCmluZGV4IGY1YWU3OWMzNzQwMC4uYTYwODc0NjAyMGE5IDEwMDY0NAot
LS0gYS9saWIva3VuaXQvc3RyaW5nLXN0cmVhbS5jCisrKyBiL2xpYi9rdW5pdC9zdHJpbmct
c3RyZWFtLmMKQEAgLTU2LDggKzU2LDggQEAgaW50IHN0cmluZ19zdHJlYW1fdmFkZChzdHJ1
Y3Qgc3RyaW5nX3N0cmVhbSAqc3RyZWFtLAogCWZyYWdfY29udGFpbmVyID0gYWxsb2Nfc3Ry
aW5nX3N0cmVhbV9mcmFnbWVudChzdHJlYW0tPnRlc3QsCiAJCQkJCQkgICAgICBsZW4sCiAJ
CQkJCQkgICAgICBzdHJlYW0tPmdmcCk7Ci0JaWYgKCFmcmFnX2NvbnRhaW5lcikKLQkJcmV0
dXJuIC1FTk9NRU07CisJaWYgKElTX0VSUihmcmFnX2NvbnRhaW5lcikpCisJCXJldHVybiBQ
VFJfRVJSKGZyYWdfY29udGFpbmVyKTsKIAogCWxlbiA9IHZzbnByaW50ZihmcmFnX2NvbnRh
aW5lci0+ZnJhZ21lbnQsIGxlbiwgZm10LCBhcmdzKTsKIAlzcGluX2xvY2soJnN0cmVhbS0+
bG9jayk7CmRpZmYgLS1naXQgYS9saWIva3VuaXQvdGVzdC5jIGIvbGliL2t1bml0L3Rlc3Qu
YwppbmRleCA5MDY0MGE0M2NmNjIuLjJhNjk5MmZlN2MzZSAxMDA2NDQKLS0tIGEvbGliL2t1
bml0L3Rlc3QuYworKysgYi9saWIva3VuaXQvdGVzdC5jCkBAIC0yNjUsNyArMjY1LDcgQEAg
c3RhdGljIHZvaWQga3VuaXRfZmFpbChzdHJ1Y3Qga3VuaXQgKnRlc3QsIGNvbnN0IHN0cnVj
dCBrdW5pdF9sb2MgKmxvYywKIAlrdW5pdF9zZXRfZmFpbHVyZSh0ZXN0KTsKIAogCXN0cmVh
bSA9IGFsbG9jX3N0cmluZ19zdHJlYW0odGVzdCwgR0ZQX0tFUk5FTCk7Ci0JaWYgKCFzdHJl
YW0pIHsKKwlpZiAoSVNfRVJSKHN0cmVhbSkpIHsKIAkJV0FSTih0cnVlLAogCQkgICAgICJD
b3VsZCBub3QgYWxsb2NhdGUgc3RyZWFtIHRvIHByaW50IGZhaWxlZCBhc3NlcnRpb24gaW4g
JXM6JWRcbiIsCiAJCSAgICAgbG9jLT5maWxlLAo=

--------------RcXPsDbTzYcGigJSsyMdly3r--
