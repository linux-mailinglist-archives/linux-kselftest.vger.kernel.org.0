Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE46D9BF3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 17:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbjDFPPx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbjDFPPv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 11:15:51 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C203249FF
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 08:15:49 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-32676c41887so179605ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680794149; x=1683386149;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SwJW32HUFSbqacbI3jOYaRioynoa1z7c5AASJQnUm6c=;
        b=GvmgjgBD4LulrBVpSC5amslG0BBPCGKVBR7FhBqYrndx1/k+0sFZDZZHOdkDD6SlgH
         KPBfljwfJxJEWvJpv6O8jjgVZ0boFHWffI8E2/MAbvOLwM0JecZth9o7aNF4q2K3E053
         hUEwGV+R7NVA1tZATFl5I6zvmMjBk3cTSFzaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794149; x=1683386149;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwJW32HUFSbqacbI3jOYaRioynoa1z7c5AASJQnUm6c=;
        b=HziFP2Dav1deB138Dsc7NxZABXF34DnNARDwJms8lzXBwveCLN2zGvdUu4GtnxTN4b
         ZeuEqmQW3pu7WWypHUShqFF4NpMMvI0J4AkbIq72FMBmHb/8XCpD0mUUVTnS2mkKC5Bk
         ogNls0e7BNYbClyJ2khvR6IAVXwu7qiPbNNaOIE3Ulukj442GEuk+42T91Jr+KsG3kWT
         NOe41GbpQo5vUxJGhQwVkrcXG+lmGGGyH/nGrtibA29eclV7L7hzLeBEB0HHD6IJqZ7y
         Npvqpg5vMzUUs/hxIZ6rTSOJ9JuNN/+Ngw4q35GrEXNVzMhsggnLNbkn88KisMUfv8Le
         xk1Q==
X-Gm-Message-State: AAQBX9fb7BZ6srFY1/axOeWcXBQZaLEY3rsUo29KXGQufBJj1jnKYK+H
        ORsjRVXDHri3BwdGIoaleMuvN7e4FpQSfe4cRcM=
X-Google-Smtp-Source: AKy350ZFYtq3itkV7pt++ykJ6TvKH9zWdY2BYB6Oydx8wrWAbdaW3sJoy4u9iqNBqZd9SAgoepzs5w==
X-Received: by 2002:a05:6e02:bee:b0:319:5431:5d5b with SMTP id d14-20020a056e020bee00b0031954315d5bmr2916208ilu.1.1680794149015;
        Thu, 06 Apr 2023 08:15:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r18-20020a92c5b2000000b00327392e5504sm380937ilt.68.2023.04.06.08.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 08:15:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------jCZDOs020xNWwUSNqV6tT9Up"
Message-ID: <f9f22f65-3151-6361-871b-a4a119fde11d@linuxfoundation.org>
Date:   Thu, 6 Apr 2023 09:15:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tuananhlfc@gmail.com
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.3-rc6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------jCZDOs020xNWwUSNqV6tT9Up
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.3-rc6.

This Kselftest fixes update for Linux 6.3-rc6 consists of one single
fix to mount_setattr_test build failure.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 05107edc910135d27fe557267dc45be9630bf3dd:

   selftests: sigaltstack: fix -Wuninitialized (2023-03-20 17:28:31 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.3-rc6

for you to fetch changes up to f1594bc676579133a3cd906d7d27733289edfb86:

   selftests mount: Fix mount_setattr_test builds failed (2023-03-31 09:18:45 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.3-rc6

This Kselftest fixes update for Linux 6.3-rc6 consists of one single
fix to mount_setattr_test build failure.

----------------------------------------------------------------
Anh Tuan Phan (1):
       selftests mount: Fix mount_setattr_test builds failed

  tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 +
  1 file changed, 1 insertion(+)
----------------------------------------------------------------
--------------jCZDOs020xNWwUSNqV6tT9Up
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.3-rc6.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.3-rc6.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21vdW50X3NldGF0dHIvbW91
bnRfc2V0YXR0cl90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tb3VudF9zZXRh
dHRyL21vdW50X3NldGF0dHJfdGVzdC5jCmluZGV4IDU4MjY2OWNhMzhlOS4uYzZhOGM3MzJi
ODAyIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tb3VudF9zZXRhdHRy
L21vdW50X3NldGF0dHJfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21v
dW50X3NldGF0dHIvbW91bnRfc2V0YXR0cl90ZXN0LmMKQEAgLTE4LDYgKzE4LDcgQEAKICNp
bmNsdWRlIDxncnAuaD4KICNpbmNsdWRlIDxzdGRib29sLmg+CiAjaW5jbHVkZSA8c3RkYXJn
Lmg+CisjaW5jbHVkZSA8bGludXgvbW91bnQuaD4KIAogI2luY2x1ZGUgIi4uL2tzZWxmdGVz
dF9oYXJuZXNzLmgiCiAK

--------------jCZDOs020xNWwUSNqV6tT9Up--
