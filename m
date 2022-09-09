Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC955B3DDC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 19:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiIIRWC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 13:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiIIRWB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 13:22:01 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE8B9F8C
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Sep 2022 10:22:00 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g1so1946264iob.13
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Sep 2022 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=3Etc9WmkRLUabLzVnKHqxnZ1JREVH9qJ5PUutx84jrQ=;
        b=FN4Iqfk27BEwrm/oPJldpVlYgrxMtLjxStte25tvFybbnff/7IgrZc3Ot5C2m4M/E/
         XchPoM+zyXL9SHUcgsH1cegqESl7v7qIM9Ntc+6gub83OkdxAXa0Dvw0k6JK7Y/61iQk
         metMjenQ8GFGYqJFDz3e1xt5Zsa+I2WB11ooQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=3Etc9WmkRLUabLzVnKHqxnZ1JREVH9qJ5PUutx84jrQ=;
        b=3OfxkJoSkscOb2XkipLp9b+WtTfjaB0aELglMAAAvwoEI+4NhOM+ta29WnMvVK49eD
         CR64bqGELH2LOUM2uHQGtSPh/xWFcHiHXcPSwXwDZy/It0FgWfT8x4ljf2A2Nprjemnv
         m4at33Gz0XEQfPlho/iv012Su0dKSZuPoUPE/7O+q1igxE//fqUm6vPTVdbqwG925c7N
         Y5Yb8QDZPjVnTE/wshJtwccsMbJG0Tduy1T0xq2NlDa7ZLuKpOPRU7jW8WFZDJWzUtcl
         l0pvTboN3/t9mHxhCniVE0buNhEB1jb9UiC75ISNJGaVDU6tcXsFuA48BagO2MKKiQvL
         B7gw==
X-Gm-Message-State: ACgBeo2K3+oVI4IVimDxYJMY9yHJSg76Yr0nxM2Kl4eqtYN57C/Loyu9
        GqpiC01KbB6kwGwuPzVs1AqW/w==
X-Google-Smtp-Source: AA6agR4XV2RQPKYy1qWY6ZM9aaey8d2IcpcpNoWs/tvloEk8OmtE0Q32GunKASn2pNVDRWPnu4DTlA==
X-Received: by 2002:a05:6638:168a:b0:345:977d:dec0 with SMTP id f10-20020a056638168a00b00345977ddec0mr8122126jat.174.1662744119416;
        Fri, 09 Sep 2022 10:21:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 6-20020a056e0220c600b002eb4c9bb34asm343228ilq.55.2022.09.09.10.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 10:21:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------CPMvoEp0Py6k3a9YjRSeSkaH"
Message-ID: <daa35f0a-afca-ec6c-82d1-8c71b4250d7c@linuxfoundation.org>
Date:   Fri, 9 Sep 2022 11:21:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.0-rc5
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
--------------CPMvoEp0Py6k3a9YjRSeSkaH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.0-rc5.

This KUnit fixes update for Linux 6.0-rc5 consists of 2 fixes to test
build and a fix to incorrect taint reason reporting.

Please note that this update touches drivers/thunderbolt and drivers/virt
Kconfig files.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 41a55567b9e31cb852670684404654ec4fd0d8d6:

   module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m (2022-08-15 13:51:07 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.0-rc5

for you to fetch changes up to 2a2dfc869d3345ccdd91322b023f4b0da84acbe7:

   tools: Add new "test" taint to kernel-chktaint (2022-09-07 14:51:12 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-6.0-rc5

This KUnit fixes update for Linux 6.0-rc5 consists of 2 fixes to test
build and a fix to incorrect taint reason reporting.

----------------------------------------------------------------
Joe Fradley (1):
       tools: Add new "test" taint to kernel-chktaint

Nico Pache (1):
       kunit: fix Kconfig for build-in tests USB4 and Nitro Enclaves

Sander Vanheule (1):
       kunit: fix assert_type for comparison macros

  drivers/thunderbolt/Kconfig         | 3 +--
  drivers/virt/nitro_enclaves/Kconfig | 2 +-
  include/kunit/test.h                | 6 +++---
  tools/debugging/kernel-chktaint     | 9 +++++++++
  4 files changed, 14 insertions(+), 6 deletions(-)
----------------------------------------------------------------
--------------CPMvoEp0Py6k3a9YjRSeSkaH
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-6.0-rc5.diff"
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-6.0-rc5.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGh1bmRlcmJvbHQvS2NvbmZpZyBiL2RyaXZlcnMvdGh1
bmRlcmJvbHQvS2NvbmZpZwppbmRleCBlNzZhNmMxNzM2MzcuLmYxMmQwYTNlZTNlMiAxMDA2
NDQKLS0tIGEvZHJpdmVycy90aHVuZGVyYm9sdC9LY29uZmlnCisrKyBiL2RyaXZlcnMvdGh1
bmRlcmJvbHQvS2NvbmZpZwpAQCAtMjksOCArMjksNyBAQCBjb25maWcgVVNCNF9ERUJVR0ZT
X1dSSVRFCiAKIGNvbmZpZyBVU0I0X0tVTklUX1RFU1QKIAlib29sICJLVW5pdCB0ZXN0cyIg
aWYgIUtVTklUX0FMTF9URVNUUwotCWRlcGVuZHMgb24gKFVTQjQ9bSB8fCBLVU5JVD15KQot
CWRlcGVuZHMgb24gS1VOSVQKKwlkZXBlbmRzIG9uIFVTQjQgJiYgS1VOSVQ9eQogCWRlZmF1
bHQgS1VOSVRfQUxMX1RFU1RTCiAKIGNvbmZpZyBVU0I0X0RNQV9URVNUCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZyBiL2RyaXZlcnMvdmlydC9u
aXRyb19lbmNsYXZlcy9LY29uZmlnCmluZGV4IGNlOTFhZGQ4MTQwMS4uZGM0ZDI1YzI2MjU2
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZworKysg
Yi9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZwpAQCAtMTcsNyArMTcsNyBA
QCBjb25maWcgTklUUk9fRU5DTEFWRVMKIAogY29uZmlnIE5JVFJPX0VOQ0xBVkVTX01JU0Nf
REVWX1RFU1QKIAlib29sICJUZXN0cyBmb3IgdGhlIG1pc2MgZGV2aWNlIGZ1bmN0aW9uYWxp
dHkgb2YgdGhlIE5pdHJvIEVuY2xhdmVzIiBpZiAhS1VOSVRfQUxMX1RFU1RTCi0JZGVwZW5k
cyBvbiBOSVRST19FTkNMQVZFUyAmJiBLVU5JVAorCWRlcGVuZHMgb24gTklUUk9fRU5DTEFW
RVMgJiYgS1VOSVQ9eQogCWRlZmF1bHQgS1VOSVRfQUxMX1RFU1RTCiAJaGVscAogCSAgRW5h
YmxlIEtVbml0IHRlc3RzIGZvciB0aGUgbWlzYyBkZXZpY2UgZnVuY3Rpb25hbGl0eSBvZiB0
aGUgTml0cm8KZGlmZiAtLWdpdCBhL2luY2x1ZGUva3VuaXQvdGVzdC5oIGIvaW5jbHVkZS9r
dW5pdC90ZXN0LmgKaW5kZXggYzk1ODg1NTY4MWNjLi44NDBhMmMzNzUwNjUgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUva3VuaXQvdGVzdC5oCisrKyBiL2luY2x1ZGUva3VuaXQvdGVzdC5oCkBA
IC04MjYsNyArODI2LDcgQEAgZG8gewkJCQkJCQkJCSAgICAgICBcCiAKICNkZWZpbmUgS1VO
SVRfRVhQRUNUX0xFX01TRyh0ZXN0LCBsZWZ0LCByaWdodCwgZm10LCAuLi4pCQkgICAgICAg
XAogCUtVTklUX0JJTkFSWV9JTlRfQVNTRVJUSU9OKHRlc3QsCQkJCSAgICAgICBcCi0JCQkJ
ICAgS1VOSVRfQVNTRVJUSU9OLAkJCSAgICAgICBcCisJCQkJICAgS1VOSVRfRVhQRUNUQVRJ
T04sCQkJICAgICAgIFwKIAkJCQkgICBsZWZ0LCA8PSwgcmlnaHQsCQkJICAgICAgIFwKIAkJ
CQkgICBmbXQsCQkJCQkgICAgICAgXAogCQkJCSAgICAjI19fVkFfQVJHU19fKQpAQCAtMTEx
Niw3ICsxMTE2LDcgQEAgZG8gewkJCQkJCQkJCSAgICAgICBcCiAKICNkZWZpbmUgS1VOSVRf
QVNTRVJUX0xUX01TRyh0ZXN0LCBsZWZ0LCByaWdodCwgZm10LCAuLi4pCQkgICAgICAgXAog
CUtVTklUX0JJTkFSWV9JTlRfQVNTRVJUSU9OKHRlc3QsCQkJCSAgICAgICBcCi0JCQkJICAg
S1VOSVRfRVhQRUNUQVRJT04sCQkJICAgICAgIFwKKwkJCQkgICBLVU5JVF9BU1NFUlRJT04s
CQkJICAgICAgIFwKIAkJCQkgICBsZWZ0LCA8LCByaWdodCwJCQkgICAgICAgXAogCQkJCSAg
IGZtdCwJCQkJCSAgICAgICBcCiAJCQkJICAgICMjX19WQV9BUkdTX18pCkBAIC0xMTU3LDcg
KzExNTcsNyBAQCBkbyB7CQkJCQkJCQkJICAgICAgIFwKIAogI2RlZmluZSBLVU5JVF9BU1NF
UlRfR1RfTVNHKHRlc3QsIGxlZnQsIHJpZ2h0LCBmbXQsIC4uLikJCSAgICAgICBcCiAJS1VO
SVRfQklOQVJZX0lOVF9BU1NFUlRJT04odGVzdCwJCQkJICAgICAgIFwKLQkJCQkgICBLVU5J
VF9FWFBFQ1RBVElPTiwJCQkgICAgICAgXAorCQkJCSAgIEtVTklUX0FTU0VSVElPTiwJCQkg
ICAgICAgXAogCQkJCSAgIGxlZnQsID4sIHJpZ2h0LAkJCSAgICAgICBcCiAJCQkJICAgZm10
LAkJCQkJICAgICAgIFwKIAkJCQkgICAgIyNfX1ZBX0FSR1NfXykKZGlmZiAtLWdpdCBhL3Rv
b2xzL2RlYnVnZ2luZy9rZXJuZWwtY2hrdGFpbnQgYi90b29scy9kZWJ1Z2dpbmcva2VybmVs
LWNoa3RhaW50CmluZGV4IGYxYWYyN2NlOWYyMC4uMjc5YmUwNjMzMmJlIDEwMDc1NQotLS0g
YS90b29scy9kZWJ1Z2dpbmcva2VybmVsLWNoa3RhaW50CisrKyBiL3Rvb2xzL2RlYnVnZ2lu
Zy9rZXJuZWwtY2hrdGFpbnQKQEAgLTE4Nyw2ICsxODcsNyBAQCBlbHNlCiAJZWNobyAiICog
YXV4aWxpYXJ5IHRhaW50LCBkZWZpbmVkIGZvciBhbmQgdXNlZCBieSBkaXN0cm9zICgjMTYp
IgogCiBmaQorCiBUPWBleHByICRUIC8gMmAKIGlmIFsgYGV4cHIgJFQgJSAyYCAtZXEgMCBd
OyB0aGVuCiAJYWRkb3V0ICIgIgpAQCAtMTk1LDYgKzE5NiwxNCBAQCBlbHNlCiAJZWNobyAi
ICoga2VybmVsIHdhcyBidWlsdCB3aXRoIHRoZSBzdHJ1Y3QgcmFuZG9taXphdGlvbiBwbHVn
aW4gKCMxNykiCiBmaQogCitUPWBleHByICRUIC8gMmAKK2lmIFsgYGV4cHIgJFQgJSAyYCAt
ZXEgMCBdOyB0aGVuCisJYWRkb3V0ICIgIgorZWxzZQorCWFkZG91dCAiTiIKKwllY2hvICIg
KiBhbiBpbi1rZXJuZWwgdGVzdCAoc3VjaCBhcyBhIEtVbml0IHRlc3QpIGhhcyBiZWVuIHJ1
biAoIzE4KSIKK2ZpCisKIGVjaG8gIkZvciBhIG1vcmUgZGV0YWlsZWQgZXhwbGFuYXRpb24g
b2YgdGhlIHZhcmlvdXMgdGFpbnQgZmxhZ3Mgc2VlIgogZWNobyAiIERvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGUvdGFpbnRlZC1rZXJuZWxzLnJzdCBpbiB0aGUgTGludXgga2VybmVsIHNv
dXJjZXMiCiBlY2hvICIgb3IgaHR0cHM6Ly9rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9h
ZG1pbi1ndWlkZS90YWludGVkLWtlcm5lbHMuaHRtbCIK

--------------CPMvoEp0Py6k3a9YjRSeSkaH--
