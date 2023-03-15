Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7B6BBD0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 20:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjCOTNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjCOTNr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 15:13:47 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAD05BCBA
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 12:13:45 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d12so8279699ioe.10
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678907625;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=firYEzbau1rz6AMyjSnozTL0huc7Ka/bTTQHHSELIcM=;
        b=ahkGL9mWozK9Fh7UVDY4m6Z2dMJAV/mrqOUudt6rQB3Dusc9QD5Rb7YOKdxag/SwVk
         6Cr43zbtOQKH9gG9VSHMsUqLuoUG72ET6u/Eh1UXG9ubwH/e0NlRJrOfRCoS66sNBhNm
         erkW6PTZZOShNZ5njLJSGBnTWproyBexd7qgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907625;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=firYEzbau1rz6AMyjSnozTL0huc7Ka/bTTQHHSELIcM=;
        b=Ao0hDXXSsICumh6IlGza4sJW8TvzYOOrIT6KTbr+MEt8rbqAByEcbLqBE8IpFGlBkL
         xeKIAPthktP38V/U0XrBf9eFumFQDrSN8s24ETB046DhWNFiKSNtBKWppR57hhOiVZLZ
         seHHYW4oJmIXu2CjWK5D//kVMIE2nuqm3RMEAdw8tIatFfAXKFy0FswEIajlPt9SGQF6
         nrGyLtBRbIzWJ/vDgh99fXlTTw5V9VcWfl2BU1PNLQgSb7UokGflIFPRg0Gze6n4OKDy
         IC/xaMPGyb0Q5jgcIFoP+Te8r14gAGeo3I5uK14FWZqbuykISyIYmkmW1Vocql3JhD8W
         0gyw==
X-Gm-Message-State: AO0yUKVTlGkayYXGhqDyrHqzIP6hvE6Ox5LlVfNImsd0GEjQZOTh/y1p
        BAb53LqnkSjGLkSj8ysLJjqQcw==
X-Google-Smtp-Source: AK7set/zOrC+SqU1C1NY5pRRTThFsnPaeJlYzvQulzJXyr/ibXOKCTYZROERd0iq/yYK2iawIYB60w==
X-Received: by 2002:a6b:dd0c:0:b0:74c:99e8:7f44 with SMTP id f12-20020a6bdd0c000000b0074c99e87f44mr206821ioc.2.1678907624971;
        Wed, 15 Mar 2023 12:13:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g16-20020a02b710000000b004038a45ad89sm1898111jam.85.2023.03.15.12.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 12:13:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------1bHYaInLX0agow59HvT25o1X"
Message-ID: <2628e459-597b-3ab7-f330-e0f4659f3efc@linuxfoundation.org>
Date:   Wed, 15 Mar 2023 13:13:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.3-rc3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------1bHYaInLX0agow59HvT25o1X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.3-rc3.

This kselftest fixes update for Linux 6.3-rc3 consists of a fix to
amd-pstate test Makefile and a fix to LLVM build for i386 and x86_64
in kselftest common lib.mk.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.3-rc3

for you to fetch changes up to 624c60f326c6e5a80b008e8a5c7feffe8c27dc72:

   selftests: fix LLVM build for i386 and x86_64 (2023-03-10 13:41:10 -0700)

----------------------------------------------------------------
linux-kselftest-fixes-6.3-rc3

This kselftest fixes update for Linux 6.3-rc3 consists of a fix to
amd-pstate test Makefile and a fix to LLVM build for i386 and x86_64
in kselftest common lib.mk.

----------------------------------------------------------------
Guillaume Tucker (2):
       selftests: amd-pstate: fix TEST_FILES
       selftests: fix LLVM build for i386 and x86_64

  tools/testing/selftests/amd-pstate/Makefile | 13 +++++++++----
  tools/testing/selftests/lib.mk              |  2 ++
  2 files changed, 11 insertions(+), 4 deletions(-)
----------------------------------------------------------------
--------------1bHYaInLX0agow59HvT25o1X
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.3-rc3.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.3-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FtZC1wc3RhdGUvTWFrZWZp
bGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9hbWQtcHN0YXRlL01ha2VmaWxlCmluZGV4
IDVmZDE0MjRkYjM3ZC4uYzM4MmY1NzlmZTk0IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9hbWQtcHN0YXRlL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2FtZC1wc3RhdGUvTWFrZWZpbGUKQEAgLTQsMTAgKzQsMTUgQEAKICMgTm8gYmlu
YXJpZXMsIGJ1dCBtYWtlIHN1cmUgYXJnLWxlc3MgIm1ha2UiIGRvZXNuJ3QgdHJpZ2dlciAi
cnVuX3Rlc3RzIgogYWxsOgogCi11bmFtZV9NIDo9ICQoc2hlbGwgdW5hbWUgLW0gMj4vZGV2
L251bGwgfHwgZWNobyBub3QpCi1BUkNIID89ICQoc2hlbGwgZWNobyAkKHVuYW1lX00pIHwg
c2VkIC1lIHMvaS44Ni94ODYvIC1lIHMveDg2XzY0L3g4Ni8pCitBUkNIID89ICQoc2hlbGwg
dW5hbWUgLW0gMj4vZGV2L251bGwgfHwgZWNobyBub3QpCitBUkNIIDo9ICQoc2hlbGwgZWNo
byAkKEFSQ0gpIHwgc2VkIC1lIHMvaS44Ni94ODYvIC1lIHMveDg2XzY0L3g4Ni8pCiAKLVRF
U1RfUFJPR1MgOj0gcnVuLnNoCi1URVNUX0ZJTEVTIDo9IGJhc2ljLnNoIHRiZW5jaC5zaCBn
aXRzb3VyY2Uuc2gKK2lmZXEgKHg4NiwkKEFSQ0gpKQorVEVTVF9GSUxFUyArPSAuLi8uLi8u
Li9wb3dlci94ODYvYW1kX3BzdGF0ZV90cmFjZXIvYW1kX3BzdGF0ZV90cmFjZS5weQorVEVT
VF9GSUxFUyArPSAuLi8uLi8uLi9wb3dlci94ODYvaW50ZWxfcHN0YXRlX3RyYWNlci9pbnRl
bF9wc3RhdGVfdHJhY2VyLnB5CitlbmRpZgorCitURVNUX1BST0dTICs9IHJ1bi5zaAorVEVT
VF9GSUxFUyArPSBiYXNpYy5zaCB0YmVuY2guc2ggZ2l0c291cmNlLnNoCiAKIGluY2x1ZGUg
Li4vbGliLm1rCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saWIubWsg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saWIubWsKaW5kZXggZjc5MDBlNzVkMjMwLi4w
NTQwMDQ2MmM3NzkgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpYi5t
aworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saWIubWsKQEAgLTEwLDEyICsxMCwx
NCBAQCBlbmRpZgogQ0xBTkdfVEFSR0VUX0ZMQUdTX2FybSAgICAgICAgICA6PSBhcm0tbGlu
dXgtZ251ZWFiaQogQ0xBTkdfVEFSR0VUX0ZMQUdTX2FybTY0ICAgICAgICA6PSBhYXJjaDY0
LWxpbnV4LWdudQogQ0xBTkdfVEFSR0VUX0ZMQUdTX2hleGFnb24gICAgICA6PSBoZXhhZ29u
LWxpbnV4LW11c2wKK0NMQU5HX1RBUkdFVF9GTEFHU19pMzg2ICAgICAgICAgOj0gaTM4Ni1s
aW51eC1nbnUKIENMQU5HX1RBUkdFVF9GTEFHU19tNjhrICAgICAgICAgOj0gbTY4ay1saW51
eC1nbnUKIENMQU5HX1RBUkdFVF9GTEFHU19taXBzICAgICAgICAgOj0gbWlwc2VsLWxpbnV4
LWdudQogQ0xBTkdfVEFSR0VUX0ZMQUdTX3Bvd2VycGMgICAgICA6PSBwb3dlcnBjNjRsZS1s
aW51eC1nbnUKIENMQU5HX1RBUkdFVF9GTEFHU19yaXNjdiAgICAgICAgOj0gcmlzY3Y2NC1s
aW51eC1nbnUKIENMQU5HX1RBUkdFVF9GTEFHU19zMzkwICAgICAgICAgOj0gczM5MHgtbGlu
dXgtZ251CiBDTEFOR19UQVJHRVRfRkxBR1NfeDg2ICAgICAgICAgIDo9IHg4Nl82NC1saW51
eC1nbnUKK0NMQU5HX1RBUkdFVF9GTEFHU194ODZfNjQgICAgICAgOj0geDg2XzY0LWxpbnV4
LWdudQogQ0xBTkdfVEFSR0VUX0ZMQUdTICAgICAgICAgICAgICA6PSAkKENMQU5HX1RBUkdF
VF9GTEFHU18kKEFSQ0gpKQogCiBpZmVxICgkKENST1NTX0NPTVBJTEUpLCkK

--------------1bHYaInLX0agow59HvT25o1X--
