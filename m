Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB936CC7C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjC1QUk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjC1QUj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 12:20:39 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A69CDBE0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 09:20:36 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id l9so6612850iln.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680020436;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb8vE9CVZdofxGXVlAjYvDgKBAc3WLUKxyRR2A+TD+Q=;
        b=FP/lr6w8sEFPr6Cyx6suPuJ0TeaarnfV88mDujzUw6o3H9VkoVPC16DEPOzyqbTXCr
         ypmP8Ccf1tPoqpuvLq670/nkMbCauwoQyD2GwCibMYgk3d/STgVrvnUuxeMbCrTI+2AF
         tfao+swjas47lH4xPy4k4uLl0NQM1BqRnWr8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680020436;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tb8vE9CVZdofxGXVlAjYvDgKBAc3WLUKxyRR2A+TD+Q=;
        b=a8ZT8MeaAC/RpqcxPZdGb0f5Vafr740T92ygzMzyl+VqGZlHgccXBPXxRBChoDRRvg
         YwT7U8GYM09hQKz8RvcYIKjAnzEPeRsw1pefbOIIr3DWwtd6GNIJbcB//6/H8G8kfO0C
         9MBOhxpkr2lJ06v1KlbFsFFMLcekph8KctQ11pUBN9mwA/M3bzQlQpqw6BgyGckgj2wL
         yYgQXGciGqqMnTqx16xQhP0u2VxbaetjdvvCyBv9oRrKlXpSShBObuCLJwe3s1s0pqFU
         Xb8A8lHR6qXkLVwZRnOVHIqtps3KytBvBVr3VbWSBvRfQvPYpSA9YODL2lXlefBR2/UL
         iCSg==
X-Gm-Message-State: AAQBX9fv2P5Wb6v/vlcdGM8b+z/sVEGFX0ZfHx1P8SN94Lh8PRoVeeRC
        lklt3HGn6AAyVsRPYPJwNjaqnhYAAsjCYm4TZBg=
X-Google-Smtp-Source: AKy350b5T9b5uzPVHlA1UEYW3EdQ9M017C8aVxEUFL808tJVV9OaNRvrjCM/5YT/9FBEZ8ko9LAVlw==
X-Received: by 2002:a05:6e02:1042:b0:323:504:cff6 with SMTP id p2-20020a056e02104200b003230504cff6mr8321618ilj.3.1680020435825;
        Tue, 28 Mar 2023 09:20:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n24-20020a056638121800b00406132281e4sm9840164jas.109.2023.03.28.09.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 09:20:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------nPru3AG9NjwKCsJiwkHVH0hO"
Message-ID: <dd25109e-5e5b-1233-31ba-f2fc19cc97bf@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 10:20:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     skhan@linuxfoundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.3-rc5
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
--------------nPru3AG9NjwKCsJiwkHVH0hO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.3-rc5.

This Kselftest fixes update for Linux 6.3-rc5 consists of one single
fix for sigaltstack test -Wuninitialized warning found when building
with clang.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 624c60f326c6e5a80b008e8a5c7feffe8c27dc72:

   selftests: fix LLVM build for i386 and x86_64 (2023-03-10 13:41:10 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.3-rc5

for you to fetch changes up to 05107edc910135d27fe557267dc45be9630bf3dd:

   selftests: sigaltstack: fix -Wuninitialized (2023-03-20 17:28:31 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.3-rc5

This Kselftest fixes update for Linux 6.3-rc5 consists of one single
fix for sigaltstack test -Wuninitialized warning found when building
with clang.

----------------------------------------------------------------
Nick Desaulniers (1):
       selftests: sigaltstack: fix -Wuninitialized

  .../selftests/sigaltstack/current_stack_pointer.h  | 23 ++++++++++++++++++++++
  tools/testing/selftests/sigaltstack/sas.c          |  7 +------
  2 files changed, 24 insertions(+), 6 deletions(-)
  create mode 100644 tools/testing/selftests/sigaltstack/current_stack_pointer.
----------------------------------------------------------------
--------------nPru3AG9NjwKCsJiwkHVH0hO
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.3-rc5.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.3-rc5.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NpZ2FsdHN0YWNrL2N1cnJl
bnRfc3RhY2tfcG9pbnRlci5oIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2lnYWx0c3Rh
Y2svY3VycmVudF9zdGFja19wb2ludGVyLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMDAwMDAwLi5lYTliZGYzYTkwYjEKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9zaWdhbHRzdGFjay9jdXJyZW50X3N0YWNrX3BvaW50ZXIuaApA
QCAtMCwwICsxLDIzIEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAq
LworCisjaWYgX19hbHBoYV9fCityZWdpc3RlciB1bnNpZ25lZCBsb25nIHNwIGFzbSgiJDMw
Iik7CisjZWxpZiBfX2FybV9fIHx8IF9fYWFyY2g2NF9fIHx8IF9fY3NreV9fIHx8IF9fbTY4
a19fIHx8IF9fbWlwc19fIHx8IF9fcmlzY3YKK3JlZ2lzdGVyIHVuc2lnbmVkIGxvbmcgc3Ag
YXNtKCJzcCIpOworI2VsaWYgX19pMzg2X18KK3JlZ2lzdGVyIHVuc2lnbmVkIGxvbmcgc3Ag
YXNtKCJlc3AiKTsKKyNlbGlmIF9fbG9vbmdhcmNoNjQKK3JlZ2lzdGVyIHVuc2lnbmVkIGxv
bmcgc3AgYXNtKCIkc3AiKTsKKyNlbGlmIF9fcHBjX18KK3JlZ2lzdGVyIHVuc2lnbmVkIGxv
bmcgc3AgYXNtKCJyMSIpOworI2VsaWYgX19zMzkweF9fCityZWdpc3RlciB1bnNpZ25lZCBs
b25nIHNwIGFzbSgiJTE1Iik7CisjZWxpZiBfX3NoX18KK3JlZ2lzdGVyIHVuc2lnbmVkIGxv
bmcgc3AgYXNtKCJyMTUiKTsKKyNlbGlmIF9feDg2XzY0X18KK3JlZ2lzdGVyIHVuc2lnbmVk
IGxvbmcgc3AgYXNtKCJyc3AiKTsKKyNlbGlmIF9fWFRFTlNBX18KK3JlZ2lzdGVyIHVuc2ln
bmVkIGxvbmcgc3AgYXNtKCJhMSIpOworI2Vsc2UKKyNlcnJvciAiaW1wbGVtZW50IGN1cnJl
bnRfc3RhY2tfcG9pbnRlciBlcXVpdmFsZW50IgorI2VuZGlmCmRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9zaWdhbHRzdGFjay9zYXMuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3NpZ2FsdHN0YWNrL3Nhcy5jCmluZGV4IGM1M2IwNzA3NTViNi4uOThkMzdj
Yjc0NGZiIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zaWdhbHRzdGFj
ay9zYXMuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zaWdhbHRzdGFjay9zYXMu
YwpAQCAtMjAsNiArMjAsNyBAQAogI2luY2x1ZGUgPHN5cy9hdXh2Lmg+CiAKICNpbmNsdWRl
ICIuLi9rc2VsZnRlc3QuaCIKKyNpbmNsdWRlICJjdXJyZW50X3N0YWNrX3BvaW50ZXIuaCIK
IAogI2lmbmRlZiBTU19BVVRPRElTQVJNCiAjZGVmaW5lIFNTX0FVVE9ESVNBUk0gICgxVSA8
PCAzMSkKQEAgLTQ2LDEyICs0Nyw2IEBAIHZvaWQgbXlfdXNyMShpbnQgc2lnLCBzaWdpbmZv
X3QgKnNpLCB2b2lkICp1KQogCXN0YWNrX3Qgc3RrOwogCXN0cnVjdCBzdGtfZGF0YSAqcDsK
IAotI2lmIF9fczM5MHhfXwotCXJlZ2lzdGVyIHVuc2lnbmVkIGxvbmcgc3AgYXNtKCIlMTUi
KTsKLSNlbHNlCi0JcmVnaXN0ZXIgdW5zaWduZWQgbG9uZyBzcCBhc20oInNwIik7Ci0jZW5k
aWYKLQogCWlmIChzcCA8ICh1bnNpZ25lZCBsb25nKXNzdGFjayB8fAogCQkJc3AgPj0gKHVu
c2lnbmVkIGxvbmcpc3N0YWNrICsgc3RhY2tfc2l6ZSkgewogCQlrc2Z0X2V4aXRfZmFpbF9t
c2coIlNQIGlzIG5vdCBvbiBzaWdhbHRzdGFja1xuIik7Cg==

--------------nPru3AG9NjwKCsJiwkHVH0hO--
