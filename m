Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4901A75809F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 17:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjGRPRG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 11:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjGRPRF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 11:17:05 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3824E10FC
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 08:17:02 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so64608939f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689693421; x=1690298221;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uit5IHcZUOtje71ESB8VCjfX0uXPxZdb9ZzqfsupX7M=;
        b=WCAyixbJfwTNd5ylI4AcRbHT9nSO3M2Vr6/fabfn1NGh9XGOTjCrVKFC8HgrPBOHfe
         mTnouoVao1brulP3A2S6lNNkh76B57nUgcZbJdYZZK5xETxWeyO+SaEyNkGl6rAyRuUq
         m59Ezoh/xj+TlyxNYcf5It6Y6oNSbqMpa1mHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689693421; x=1690298221;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uit5IHcZUOtje71ESB8VCjfX0uXPxZdb9ZzqfsupX7M=;
        b=eeY/ligIYhLrOhNQTYjwhIAWHHFBqqy+B95q+qM8VtV18U5Ld/KUmMc+50CV2nm9AW
         JVSe9XU1Gdzm7TDEPLHPzC5pyohUaWhsrM06zfDalS6M6pZ8Xw73vcWn7azi6GV1R6j4
         4rsDh6CEpW01Mip8Y93REN+1qjcJX2/2Uywprx8PNDgiwKIzhmE5hZ0+pockMhYdJLZr
         x2ssoCQG3hlUfQrgO9hRL4K52J7DsIFdCpYeWly4r27hfwD40hmeGU8aHgg2j7DYfXEe
         vTyM56UfMMa7s1gwQR3XhkpRGM3IkObsg+0T9R2ifdgdbskh1NrVoPrsWsPn+m/OKABZ
         H2Fg==
X-Gm-Message-State: ABy/qLbg7sOoax6Ocms4Qm76Y/1xTiLh6qVGcE9BQECIQbAJNon24z1o
        sbP+KOYvDjoWRUIAP5DeRCp4mQmjKaSiV2ilQhma8b8K
X-Google-Smtp-Source: APBJJlFpFxfSfFJkUXmyItAzu1+1JxlRfE6myFOtKgxzvmpo5M2CxW6pMe0xbSuKfPmTrmjAZ4kfaw==
X-Received: by 2002:a05:6602:3799:b0:783:743c:fd01 with SMTP id be25-20020a056602379900b00783743cfd01mr3039265iob.0.1689693421503;
        Tue, 18 Jul 2023 08:17:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q16-20020a6bf210000000b00786dffc04e2sm653977ioh.25.2023.07.18.08.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 08:17:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------0nLz31uzIeMkqW9VHMmTj0eh"
Message-ID: <0d655122-a978-93ce-405c-c1eb1d264708@linuxfoundation.org>
Date:   Tue, 18 Jul 2023 09:17:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.5-rc3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------0nLz31uzIeMkqW9VHMmTj0eh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.5-rc3.

This Kselftest fixes update for Linux 6.5-rc3 consists of fixes to
bugs that are interfering with arm64 and riscv workflows. This update
also includes two fixes to timer and mincore tests that are causing
test failures.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.5-rc3

for you to fetch changes up to 569f8b501b177f21121d483a96491716ab8905f4:

   selftests/arm64: fix build failure during the "emit_tests" step (2023-07-14 12:33:35 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.5-rc3

This Kselftest fixes update for Linux 6.5-rc3 consists of fixes to
bugs that are interfering with arm64 and riscv workflows. This update
also includes two fixes to timer and mincore tests that are causing
test failures.

----------------------------------------------------------------
John Hubbard (2):
       selftests/riscv: fix potential build failure during the "emit_tests" step
       selftests/arm64: fix build failure during the "emit_tests" step

Minjie Du (1):
       tools: timers: fix freq average calculation

Ricardo Cañuelo (1):
       selftests/mincore: fix skip condition for check_huge_pages test

  tools/testing/selftests/arm64/Makefile             | 2 +-
  tools/testing/selftests/mincore/mincore_selftest.c | 4 ++--
  tools/testing/selftests/riscv/Makefile             | 2 +-
  tools/testing/selftests/timers/raw_skew.c          | 3 +--
  4 files changed, 5 insertions(+), 6 deletions(-)

----------------------------------------------------------------
--------------0nLz31uzIeMkqW9VHMmTj0eh
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.5-rc3.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.5-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FybTY0L01ha2VmaWxlIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYXJtNjQvTWFrZWZpbGUKaW5kZXggOTQ2MGNiZTgx
YmNjLi5hY2U4YjY3ZmIyMmQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2FybTY0L01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FybTY0L01h
a2VmaWxlCkBAIC00Miw3ICs0Miw3IEBAIHJ1bl90ZXN0czogYWxsCiAJZG9uZQogCiAjIEF2
b2lkIGFueSBvdXRwdXQgb24gbm9uIGFybTY0IG9uIGVtaXRfdGVzdHMKLWVtaXRfdGVzdHM6
IGFsbAorZW1pdF90ZXN0czoKIAlAZm9yIERJUiBpbiAkKEFSTTY0X1NVQlRBUkdFVFMpOyBk
bwkJCQlcCiAJCUJVSUxEX1RBUkdFVD0kKE9VVFBVVCkvJCRESVI7CQkJXAogCQltYWtlIE9V
VFBVVD0kJEJVSUxEX1RBUkdFVCAtQyAkJERJUiAkQDsJCVwKZGlmZiAtLWdpdCBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL21pbmNvcmUvbWluY29yZV9zZWxmdGVzdC5jIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbWluY29yZS9taW5jb3JlX3NlbGZ0ZXN0LmMKaW5kZXggNGM4
ODIzOGZjOGYwLi5lOTQ5YTQzYTYxNDUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL21pbmNvcmUvbWluY29yZV9zZWxmdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL21pbmNvcmUvbWluY29yZV9zZWxmdGVzdC5jCkBAIC0xNTAsOCArMTUwLDgg
QEAgVEVTVChjaGVja19odWdlX3BhZ2VzKQogCQlNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1P
VVMgfCBNQVBfSFVHRVRMQiwKIAkJLTEsIDApOwogCWlmIChhZGRyID09IE1BUF9GQUlMRUQp
IHsKLQkJaWYgKGVycm5vID09IEVOT01FTSkKLQkJCVNLSVAocmV0dXJuLCAiTm8gaHVnZSBw
YWdlcyBhdmFpbGFibGUuIik7CisJCWlmIChlcnJubyA9PSBFTk9NRU0gfHwgZXJybm8gPT0g
RUlOVkFMKQorCQkJU0tJUChyZXR1cm4sICJObyBodWdlIHBhZ2VzIGF2YWlsYWJsZSBvciBD
T05GSUdfSFVHRVRMQl9QQUdFIGRpc2FibGVkLiIpOwogCQllbHNlCiAJCQlUSF9MT0coIm1t
YXAgZXJyb3I6ICVzIiwgc3RyZXJyb3IoZXJybm8pKTsKIAl9CmRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9yaXNjdi9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3Jpc2N2L01ha2VmaWxlCmluZGV4IDlkZDYyOWNjODZhYS4uZjRiM2Q1YzlhZjVi
IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yaXNjdi9NYWtlZmlsZQor
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yaXNjdi9NYWtlZmlsZQpAQCAtNDMsNyAr
NDMsNyBAQCBydW5fdGVzdHM6IGFsbAogCWRvbmUKIAogIyBBdm9pZCBhbnkgb3V0cHV0IG9u
IG5vbiByaXNjdiBvbiBlbWl0X3Rlc3RzCi1lbWl0X3Rlc3RzOiBhbGwKK2VtaXRfdGVzdHM6
CiAJQGZvciBESVIgaW4gJChSSVNDVl9TVUJUQVJHRVRTKTsgZG8JCQkJXAogCQlCVUlMRF9U
QVJHRVQ9JChPVVRQVVQpLyQkRElSOwkJCVwKIAkJJChNQUtFKSBPVVRQVVQ9JCRCVUlMRF9U
QVJHRVQgLUMgJCRESVIgJEA7CQlcCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy90aW1lcnMvcmF3X3NrZXcuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVy
cy9yYXdfc2tldy5jCmluZGV4IDViZWNlZWVkMGQxMS4uNmViYTIwM2Y5ZGE3IDEwMDY0NAot
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvcmF3X3NrZXcuYworKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvcmF3X3NrZXcuYwpAQCAtMTI5LDggKzEy
OSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAlwcmludGYoIiVsbGQu
JWkoZXN0KSIsIGVwcG0vMTAwMCwgYWJzKChpbnQpKGVwcG0lMTAwMCkpKTsKIAogCS8qIEF2
ZyB0aGUgdHdvIGFjdHVhbCBmcmVxIHNhbXBsZXMgYWRqdGltZXggZ2F2ZSB1cyAqLwotCXBw
bSA9ICh0eDEuZnJlcSArIHR4Mi5mcmVxKSAqIDEwMDAgLyAyOwotCXBwbSA9IChsb25nIGxv
bmcpdHgxLmZyZXEgKiAxMDAwOworCXBwbSA9IChsb25nIGxvbmcpKHR4MS5mcmVxICsgdHgy
LmZyZXEpICogMTAwMCAvIDI7CiAJcHBtID0gc2hpZnRfcmlnaHQocHBtLCAxNik7CiAJcHJp
bnRmKCIgJWxsZC4laShhY3QpIiwgcHBtLzEwMDAsIGFicygoaW50KShwcG0lMTAwMCkpKTsK
IAo=

--------------0nLz31uzIeMkqW9VHMmTj0eh--
