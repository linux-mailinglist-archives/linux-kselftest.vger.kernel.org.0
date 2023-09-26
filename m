Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0537A7AEF8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjIZPY4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIZPY4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 11:24:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1013116
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 08:24:48 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3512b4eedf1so3758885ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695741888; x=1696346688; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz9sMTvIUxZN8rDQT7cU7OZY6iqEUW4DRQ6cOnr7tnQ=;
        b=gu3jY/4LB7Ls0qp7kAHIPw+jKiJeq+mVt85wekv5BGtQDJzvMIZDvOKCRJkWu07p3h
         FSv/lgIaCjjOvcH0N1od+/AWV38gHyvfDLGE42T/UVFg3ZQGgT/lG2XIO1/c0T0hBNSg
         JNxahoyJudFUkmPyR2HHYmBEQEh2ZFgHZquCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695741888; x=1696346688;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sz9sMTvIUxZN8rDQT7cU7OZY6iqEUW4DRQ6cOnr7tnQ=;
        b=PrBgbQK4naKS3MYK9PA7e8pLG08wrqlj64AMOOjRhgtd0LNQt5MY6YqVLLrl+VElwa
         dbFjqN1aSG2xM9TNuc72qB2k3ntPHLvUtKi9+LEsGPJiahH6dXbHaZqX121No0NuWPJ5
         At2FWa4sWVKCXnVW3v7o0cauip0Yxm/SbWTb9TPnQFIemIRatnl6rrtEeK4hWPD4gEHK
         KyZL5lYlAoEnPfAAaOBRGIsB1Cjr6PxtYtLBwnb73bBspqs/rqYhGM4fLrxOTlCe85/c
         +72x4ffo0LWHN30gXhxgVkSjI74EdUrBwLrw04HG9EDqgFFAWf6JYXSs4rN3x8CUzukB
         YB7A==
X-Gm-Message-State: AOJu0YwxJMmfOoMGUdD06Nzq36CbWsFEg3llOqvb2WnTquEus8GMzPQ+
        w0hj+u7P9VUV4p0aMJ2xD9URqW4URAHdAthKRH4=
X-Google-Smtp-Source: AGHT+IHhXxQeFfl6M89yV3/O+UqN2y+ZB3m0qhwa5+y4zFLAiEKE69mKlnxsMdpHTYruBx+25vz2WQ==
X-Received: by 2002:a05:6e02:f41:b0:351:54db:c1c9 with SMTP id y1-20020a056e020f4100b0035154dbc1c9mr1542364ilj.1.1695741888176;
        Tue, 26 Sep 2023 08:24:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x3-20020a056e021bc300b003513b61b472sm1608383ilv.38.2023.09.26.08.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 08:24:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------h1Dst0bFCEhvMn0AJ7NrkwTQ"
Message-ID: <f7b2da1d-6e47-0599-03d1-c1786ff69998@linuxfoundation.org>
Date:   Tue, 26 Sep 2023 09:24:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.6-rc4
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
--------------h1Dst0bFCEhvMn0AJ7NrkwTQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.6-rc4.

This kselftest fixes update for Linux 6.6-rc4 consists of one
single fix to unmount tracefs when test created mount.

diff is attached.

thanks.
-- Shuah

----------------------------------------------------------------
The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

   Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.6-rc4

for you to fetch changes up to 8ed99af4a266a3492d773b5d85c3f8e9f81254b6:

   selftests/user_events: Fix to unmount tracefs when test created mount (2023-09-18 11:04:52 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.6-rc4

This kselftest fixes update for Linux 6.6-rc4 consists of one
single fix to unmount tracefs when test created mount.

----------------------------------------------------------------
Beau Belgrave (1):
       selftests/user_events: Fix to unmount tracefs when test created mount

  tools/testing/selftests/user_events/abi_test.c     |  4 +++-
  tools/testing/selftests/user_events/dyn_test.c     |  5 ++++-
  tools/testing/selftests/user_events/ftrace_test.c  |  5 ++++-
  tools/testing/selftests/user_events/perf_test.c    |  5 ++++-
  .../selftests/user_events/user_events_selftests.h  | 24 +++++++++++++++++-----
  5 files changed, 34 insertions(+), 9 deletions(-)

----------------------------------------------------------------
--------------h1Dst0bFCEhvMn0AJ7NrkwTQ
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.6-rc4.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.6-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2FiaV90
ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91c2VyX2V2ZW50cy9hYmlfdGVzdC5j
CmluZGV4IDIyMzc0ZDI5ZmZkZC4uODIwMmYxMzI3YzM5IDEwMDY0NAotLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy91c2VyX2V2ZW50cy9hYmlfdGVzdC5jCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2FiaV90ZXN0LmMKQEAgLTkxLDE2ICs5MSwx
OCBAQCBzdGF0aWMgaW50IHJlZ19kaXNhYmxlKGxvbmcgKmVuYWJsZSwgaW50IGJpdCkKIAog
RklYVFVSRSh1c2VyKSB7CiAJbG9uZyBjaGVjazsKKwlib29sIHVtb3VudDsKIH07CiAKIEZJ
WFRVUkVfU0VUVVAodXNlcikgewotCVVTRVJfRVZFTlRfRklYVFVSRV9TRVRVUChyZXR1cm4p
OworCVVTRVJfRVZFTlRfRklYVFVSRV9TRVRVUChyZXR1cm4sIHNlbGYtPnVtb3VudCk7CiAK
IAljaGFuZ2VfZXZlbnQoZmFsc2UpOwogCXNlbGYtPmNoZWNrID0gMDsKIH0KIAogRklYVFVS
RV9URUFSRE9XTih1c2VyKSB7CisJVVNFUl9FVkVOVF9GSVhUVVJFX1RFQVJET1dOKHNlbGYt
PnVtb3VudCk7CiB9CiAKIFRFU1RfRih1c2VyLCBlbmFibGVtZW50KSB7CmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91c2VyX2V2ZW50cy9keW5fdGVzdC5jIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdXNlcl9ldmVudHMvZHluX3Rlc3QuYwppbmRleCAzMmM4
MjdhNTJkN2QuLmE4NTk4MDE5MGJlYSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvdXNlcl9ldmVudHMvZHluX3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy91c2VyX2V2ZW50cy9keW5fdGVzdC5jCkBAIC0xNDQsMTMgKzE0NCwxNiBAQCBkbyB7
IFwKIAogRklYVFVSRSh1c2VyKSB7CiAJaW50IGNoZWNrOworCWJvb2wgdW1vdW50OwogfTsK
IAogRklYVFVSRV9TRVRVUCh1c2VyKSB7Ci0JVVNFUl9FVkVOVF9GSVhUVVJFX1NFVFVQKHJl
dHVybik7CisJVVNFUl9FVkVOVF9GSVhUVVJFX1NFVFVQKHJldHVybiwgc2VsZi0+dW1vdW50
KTsKIH0KIAogRklYVFVSRV9URUFSRE9XTih1c2VyKSB7CisJVVNFUl9FVkVOVF9GSVhUVVJF
X1RFQVJET1dOKHNlbGYtPnVtb3VudCk7CisKIAl3YWl0X2Zvcl9kZWxldGUoKTsKIH0KIApk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdXNlcl9ldmVudHMvZnRyYWNl
X3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2Z0cmFjZV90
ZXN0LmMKaW5kZXggNmEyNjBjYWVlZGRjLi5kY2Q3NTA5ZmUyZTAgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL2Z0cmFjZV90ZXN0LmMKKysrIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdXNlcl9ldmVudHMvZnRyYWNlX3Rlc3QuYwpAQCAt
MjA0LDEwICsyMDQsMTEgQEAgRklYVFVSRSh1c2VyKSB7CiAJaW50IGRhdGFfZmQ7CiAJaW50
IGVuYWJsZV9mZDsKIAlpbnQgY2hlY2s7CisJYm9vbCB1bW91bnQ7CiB9OwogCiBGSVhUVVJF
X1NFVFVQKHVzZXIpIHsKLQlVU0VSX0VWRU5UX0ZJWFRVUkVfU0VUVVAocmV0dXJuKTsKKwlV
U0VSX0VWRU5UX0ZJWFRVUkVfU0VUVVAocmV0dXJuLCBzZWxmLT51bW91bnQpOwogCiAJc2Vs
Zi0+c3RhdHVzX2ZkID0gb3BlbihzdGF0dXNfZmlsZSwgT19SRE9OTFkpOwogCUFTU0VSVF9O
RSgtMSwgc2VsZi0+c3RhdHVzX2ZkKTsKQEAgLTIxOSw2ICsyMjAsOCBAQCBGSVhUVVJFX1NF
VFVQKHVzZXIpIHsKIH0KIAogRklYVFVSRV9URUFSRE9XTih1c2VyKSB7CisJVVNFUl9FVkVO
VF9GSVhUVVJFX1RFQVJET1dOKHNlbGYtPnVtb3VudCk7CisKIAljbG9zZShzZWxmLT5zdGF0
dXNfZmQpOwogCWNsb3NlKHNlbGYtPmRhdGFfZmQpOwogCmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy91c2VyX2V2ZW50cy9wZXJmX3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL3BlcmZfdGVzdC5jCmluZGV4IGY4OTMzOThjZGEw
NS4uNTI4OGU3NjhiMjA3IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91
c2VyX2V2ZW50cy9wZXJmX3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91
c2VyX2V2ZW50cy9wZXJmX3Rlc3QuYwpAQCAtMTExLDE2ICsxMTEsMTkgQEAgc3RhdGljIGlu
dCBjbGVhcihpbnQgKmNoZWNrKQogRklYVFVSRSh1c2VyKSB7CiAJaW50IGRhdGFfZmQ7CiAJ
aW50IGNoZWNrOworCWJvb2wgdW1vdW50OwogfTsKIAogRklYVFVSRV9TRVRVUCh1c2VyKSB7
Ci0JVVNFUl9FVkVOVF9GSVhUVVJFX1NFVFVQKHJldHVybik7CisJVVNFUl9FVkVOVF9GSVhU
VVJFX1NFVFVQKHJldHVybiwgc2VsZi0+dW1vdW50KTsKIAogCXNlbGYtPmRhdGFfZmQgPSBv
cGVuKGRhdGFfZmlsZSwgT19SRFdSKTsKIAlBU1NFUlRfTkUoLTEsIHNlbGYtPmRhdGFfZmQp
OwogfQogCiBGSVhUVVJFX1RFQVJET1dOKHVzZXIpIHsKKwlVU0VSX0VWRU5UX0ZJWFRVUkVf
VEVBUkRPV04oc2VsZi0+dW1vdW50KTsKKwogCWNsb3NlKHNlbGYtPmRhdGFfZmQpOwogCiAJ
aWYgKGNsZWFyKCZzZWxmLT5jaGVjaykgIT0gMCkKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL3VzZXJfZXZlbnRzX3NlbGZ0ZXN0cy5oIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdXNlcl9ldmVudHMvdXNlcl9ldmVudHNfc2VsZnRlc3Rz
LmgKaW5kZXggNjkwMzc4OTQyZjgyLi5lMWMzYzA2M2MwMzEgMTAwNjQ0Ci0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL3VzZXJfZXZlbnRzX3NlbGZ0ZXN0cy5o
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VzZXJfZXZlbnRzL3VzZXJfZXZlbnRz
X3NlbGZ0ZXN0cy5oCkBAIC0xMSwxMyArMTEsMTkgQEAKIAogI2luY2x1ZGUgIi4uL2tzZWxm
dGVzdC5oIgogCi1zdGF0aWMgaW5saW5lIGJvb2wgdHJhY2Vmc19lbmFibGVkKGNoYXIgKipt
ZXNzYWdlLCBib29sICpmYWlsKQorc3RhdGljIGlubGluZSB2b2lkIHRyYWNlZnNfdW5tb3Vu
dCh2b2lkKQoreworCXVtb3VudCgiL3N5cy9rZXJuZWwvdHJhY2luZyIpOworfQorCitzdGF0
aWMgaW5saW5lIGJvb2wgdHJhY2Vmc19lbmFibGVkKGNoYXIgKiptZXNzYWdlLCBib29sICpm
YWlsLCBib29sICp1bW91bnQpCiB7CiAJc3RydWN0IHN0YXQgYnVmOwogCWludCByZXQ7CiAK
IAkqbWVzc2FnZSA9ICIiOwogCSpmYWlsID0gZmFsc2U7CisJKnVtb3VudCA9IGZhbHNlOwog
CiAJLyogRW5zdXJlIHRyYWNlZnMgaXMgaW5zdGFsbGVkICovCiAJcmV0ID0gc3RhdCgiL3N5
cy9rZXJuZWwvdHJhY2luZyIsICZidWYpOwpAQCAtMzcsNiArNDMsOCBAQCBzdGF0aWMgaW5s
aW5lIGJvb2wgdHJhY2Vmc19lbmFibGVkKGNoYXIgKiptZXNzYWdlLCBib29sICpmYWlsKQog
CQkJcmV0dXJuIGZhbHNlOwogCQl9CiAKKwkJKnVtb3VudCA9IHRydWU7CisKIAkJcmV0ID0g
c3RhdCgiL3N5cy9rZXJuZWwvdHJhY2luZy9SRUFETUUiLCAmYnVmKTsKIAl9CiAKQEAgLTQ5
LDEzICs1NywxNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgdHJhY2Vmc19lbmFibGVkKGNoYXIg
KiptZXNzYWdlLCBib29sICpmYWlsKQogCXJldHVybiB0cnVlOwogfQogCi1zdGF0aWMgaW5s
aW5lIGJvb2wgdXNlcl9ldmVudHNfZW5hYmxlZChjaGFyICoqbWVzc2FnZSwgYm9vbCAqZmFp
bCkKK3N0YXRpYyBpbmxpbmUgYm9vbCB1c2VyX2V2ZW50c19lbmFibGVkKGNoYXIgKiptZXNz
YWdlLCBib29sICpmYWlsLCBib29sICp1bW91bnQpCiB7CiAJc3RydWN0IHN0YXQgYnVmOwog
CWludCByZXQ7CiAKIAkqbWVzc2FnZSA9ICIiOwogCSpmYWlsID0gZmFsc2U7CisJKnVtb3Vu
dCA9IGZhbHNlOwogCiAJaWYgKGdldHVpZCgpICE9IDApIHsKIAkJKm1lc3NhZ2UgPSAiTXVz
dCBiZSBydW4gYXMgcm9vdCI7CkBAIC02Myw3ICs3Miw3IEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCB1c2VyX2V2ZW50c19lbmFibGVkKGNoYXIgKiptZXNzYWdlLCBib29sICpmYWlsKQogCQly
ZXR1cm4gZmFsc2U7CiAJfQogCi0JaWYgKCF0cmFjZWZzX2VuYWJsZWQobWVzc2FnZSwgZmFp
bCkpCisJaWYgKCF0cmFjZWZzX2VuYWJsZWQobWVzc2FnZSwgZmFpbCwgdW1vdW50KSkKIAkJ
cmV0dXJuIGZhbHNlOwogCiAJLyogRW5zdXJlIHVzZXJfZXZlbnRzIGlzIGluc3RhbGxlZCAq
LwpAQCAtODUsMTAgKzk0LDEwIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB1c2VyX2V2ZW50c19l
bmFibGVkKGNoYXIgKiptZXNzYWdlLCBib29sICpmYWlsKQogCXJldHVybiB0cnVlOwogfQog
Ci0jZGVmaW5lIFVTRVJfRVZFTlRfRklYVFVSRV9TRVRVUChzdGF0ZW1lbnQpIGRvIHsgXAor
I2RlZmluZSBVU0VSX0VWRU5UX0ZJWFRVUkVfU0VUVVAoc3RhdGVtZW50LCB1bW91bnQpIGRv
IHsgXAogCWNoYXIgKm1lc3NhZ2U7IFwKIAlib29sIGZhaWw7IFwKLQlpZiAoIXVzZXJfZXZl
bnRzX2VuYWJsZWQoJm1lc3NhZ2UsICZmYWlsKSkgeyBcCisJaWYgKCF1c2VyX2V2ZW50c19l
bmFibGVkKCZtZXNzYWdlLCAmZmFpbCwgJih1bW91bnQpKSkgeyBcCiAJCWlmIChmYWlsKSB7
IFwKIAkJCVRIX0xPRygiU2V0dXAgZmFpbGVkIGR1ZSB0bzogJXMiLCBtZXNzYWdlKTsgXAog
CQkJQVNTRVJUX0ZBTFNFKGZhaWwpOyBcCkBAIC05Nyw0ICsxMDYsOSBAQCBzdGF0aWMgaW5s
aW5lIGJvb2wgdXNlcl9ldmVudHNfZW5hYmxlZChjaGFyICoqbWVzc2FnZSwgYm9vbCAqZmFp
bCkKIAl9IFwKIH0gd2hpbGUgKDApCiAKKyNkZWZpbmUgVVNFUl9FVkVOVF9GSVhUVVJFX1RF
QVJET1dOKHVtb3VudCkgZG8geyBcCisJaWYgKCh1bW91bnQpKSAgXAorCQl0cmFjZWZzX3Vu
bW91bnQoKTsgXAorfSB3aGlsZSAoMCkKKwogI2VuZGlmIC8qIF9VU0VSX0VWRU5UU19TRUxG
VEVTVFNfSCAqLwo=

--------------h1Dst0bFCEhvMn0AJ7NrkwTQ--
