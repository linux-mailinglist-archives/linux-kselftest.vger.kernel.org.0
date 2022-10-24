Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0E060B4EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Oct 2022 20:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJXSIS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 14:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiJXSIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 14:08:00 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3741ABEC5
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 09:49:12 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id q5so2847840ilt.13
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=891IdAC6CjPU3houg/K1WEgsqjrUAZT4ffved4EQYDA=;
        b=TaRZkPb1/z/kV9Db//RMXbx8MK5LTkSyccyxyw5nqO7feqrdkaBAosOG6rCahvTmgV
         WSeg5F3DIzLWcbeoMHg8junZ4TJp56Ag24+XkrnsRJstzOYeddbehVKhQBtP2wzCm7dB
         JPQiAI2pt+Zk6vY6E7M0nbGL19LaLXNVnMT/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=891IdAC6CjPU3houg/K1WEgsqjrUAZT4ffved4EQYDA=;
        b=XuEwBDLVbMFpWB4vC985fHT/WdjUHJ6EtoXW/s8wfeToDT84SnpS5LGRhlWT8VFK8a
         XDhLzt95qeo1bwqlBuVEYNrY5TT7DPCiRvm/Tr8plPhigJfDyWClDKkFMfCGINRy4Kxg
         dLyQyfBIQuzwnpmFBBXapXLRQYN1QzukOC9dVP4MwEzbKXbSw4oXhsqOJeQZBkXkQwCG
         oPnu6Vchr+QbdD456fFTrpl4DQu50fFgj1ybS8nYJoRREyxYycHC8A/sda1BGelx5tIP
         QLTBMgOyLjQlWEZcQvSykO36RywuGrXF2k1+br276/v3UJGSMceG37ytxt4R9fsw/9+5
         9ZUQ==
X-Gm-Message-State: ACrzQf3HzYs82MPaEOW4mjKc5wIn24V6/fbZ4lewvndQuuDbMZCpmD2d
        YgWIocGTl6VT9brmouuObnS/iv0zLUcT+A==
X-Google-Smtp-Source: AMsMyM4X95FvpzI6NSk3WYvl5Tu0S3diBPj6eWa8tZDZ5IW9thNvqA27Rjt3z5OhnWbilf42kMfWqA==
X-Received: by 2002:a05:6602:3410:b0:6bc:c4b2:3577 with SMTP id n16-20020a056602341000b006bcc4b23577mr20608128ioz.52.1666629344157;
        Mon, 24 Oct 2022 09:35:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m2-20020a0566022e8200b00689257fef39sm101581iow.4.2022.10.24.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:35:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------VQ0pGbV09a28TYDKCWYl6zh9"
Message-ID: <b9c14ec8-b410-c742-3cb4-0067e2bf7100@linuxfoundation.org>
Date:   Mon, 24 Oct 2022 10:35:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.1-rc3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------VQ0pGbV09a28TYDKCWYl6zh9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.1-rc3.

This Kselftest fixes update for Linux 6.1-rc3 consists of:

- futex, intel_pstate, kexec build fixes
- ftrace dynamic_events dependency check fix
- memory-hotplug fix to remove redundant warning from test report

diff for this pull request is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.1-rc3

for you to fetch changes up to cb05c81ada76a30a25a5f79b249375e33473af33:

   selftests/ftrace: fix dynamic_events dependency check (2022-10-18 14:27:23 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.1-rc3

This Kselftest fixes update for Linux 6.1-rc3 consists of:

- futex, intel_pstate, kexec build fixes
- ftrace dynamic_events dependency check fix
- memory-hotplug fix to remove redundant warning from test report

----------------------------------------------------------------
Ricardo Cañuelo (3):
       selftests/futex: fix build for clang
       selftests/intel_pstate: fix build for ARCH=x86_64
       selftests/kexec: fix build for ARCH=x86_64

Sven Schnelle (1):
       selftests/ftrace: fix dynamic_events dependency check

Zhao Gongyi (1):
       selftests/memory-hotplug: Remove the redundant warning information

  tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc   | 2 +-
  .../ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc   | 2 +-
  tools/testing/selftests/futex/functional/Makefile                   | 6 ++----
  tools/testing/selftests/intel_pstate/Makefile                       | 6 +++---
  tools/testing/selftests/kexec/Makefile                              | 6 +++---
  tools/testing/selftests/memory-hotplug/mem-on-off-test.sh           | 1 -
  6 files changed, 10 insertions(+), 13 deletions(-)
----------------------------------------------------------------
--------------VQ0pGbV09a28TYDKCWYl6zh9
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.1-rc3.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.1-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZHlu
ZXZlbnQvdGVzdF9kdXBsaWNhdGVzLnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRy
YWNlL3Rlc3QuZC9keW5ldmVudC90ZXN0X2R1cGxpY2F0ZXMudGMKaW5kZXggZGI1MjI1Nzdm
Zjc4Li5kM2E3OWRhMjE1YzggMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Z0cmFjZS90ZXN0LmQvZHluZXZlbnQvdGVzdF9kdXBsaWNhdGVzLnRjCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZHluZXZlbnQvdGVzdF9kdXBsaWNh
dGVzLnRjCkBAIC0xLDcgKzEsNyBAQAogIyEvYmluL3NoCiAjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wCiAjIGRlc2NyaXB0aW9uOiBHZW5lcmljIGR5bmFtaWMgZXZlbnQg
LSBjaGVjayBpZiBkdXBsaWNhdGUgZXZlbnRzIGFyZSBjYXVnaHQKLSMgcmVxdWlyZXM6IGR5
bmFtaWNfZXZlbnRzICJlWzpbPGdyb3VwPi9dPGV2ZW50Pl0gPGF0dGFjaGVkLWdyb3VwPi48
YXR0YWNoZWQtZXZlbnQ+IFs8YXJncz5dIjpSRUFETUUKKyMgcmVxdWlyZXM6IGR5bmFtaWNf
ZXZlbnRzICJlWzpbPGdyb3VwPi9dWzxldmVudD5dXSA8YXR0YWNoZWQtZ3JvdXA+LjxhdHRh
Y2hlZC1ldmVudD4gWzxhcmdzPl0iOlJFQURNRQogCiBlY2hvIDAgPiBldmVudHMvZW5hYmxl
CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQv
dHJpZ2dlci9pbnRlci1ldmVudC90cmlnZ2VyLXN5bnRoZXRpYy1lcHJvYmUudGMgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL3RyaWdnZXIvaW50ZXItZXZlbnQv
dHJpZ2dlci1zeW50aGV0aWMtZXByb2JlLnRjCmluZGV4IDkxNGZlMmU1ZDAzMC4uNjQ2MWMz
NzU2OTRmIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVz
dC5kL3RyaWdnZXIvaW50ZXItZXZlbnQvdHJpZ2dlci1zeW50aGV0aWMtZXByb2JlLnRjCisr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvdHJpZ2dlci9pbnRl
ci1ldmVudC90cmlnZ2VyLXN5bnRoZXRpYy1lcHJvYmUudGMKQEAgLTEsNyArMSw3IEBACiAj
IS9iaW4vc2gKICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKICMgZGVzY3Jp
cHRpb246IGV2ZW50IHRyaWdnZXIgLSB0ZXN0IGludGVyLWV2ZW50IGhpc3RvZ3JhbSB0cmln
Z2VyIGVwcm9iZSBvbiBzeW50aGV0aWMgZXZlbnQKLSMgcmVxdWlyZXM6IGR5bmFtaWNfZXZl
bnRzIHN5bnRoZXRpY19ldmVudHMgZXZlbnRzL3N5c2NhbGxzL3N5c19lbnRlcl9vcGVuYXQv
aGlzdCAiZVs6Wzxncm91cD4vXTxldmVudD5dIDxhdHRhY2hlZC1ncm91cD4uPGF0dGFjaGVk
LWV2ZW50PiBbPGFyZ3M+XSI6UkVBRE1FCisjIHJlcXVpcmVzOiBkeW5hbWljX2V2ZW50cyBz
eW50aGV0aWNfZXZlbnRzIGV2ZW50cy9zeXNjYWxscy9zeXNfZW50ZXJfb3BlbmF0L2hpc3Qg
ImVbOls8Z3JvdXA+L11bPGV2ZW50Pl1dIDxhdHRhY2hlZC1ncm91cD4uPGF0dGFjaGVkLWV2
ZW50PiBbPGFyZ3M+XSI6UkVBRE1FCiAKIGVjaG8gMCA+IGV2ZW50cy9lbmFibGUKIApkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0ZXgvZnVuY3Rpb25hbC9NYWtl
ZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L2Z1bmN0aW9uYWwvTWFrZWZp
bGUKaW5kZXggNzMyMTQ5MDExNjkyLi41YTBlMGRmOGRlOWIgMTAwNjQ0Ci0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L2Z1bmN0aW9uYWwvTWFrZWZpbGUKKysrIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0ZXgvZnVuY3Rpb25hbC9NYWtlZmlsZQpAQCAtMywx
MSArMywxMSBAQCBJTkNMVURFUyA6PSAtSS4uL2luY2x1ZGUgLUkuLi8uLi8gLUkuLi8uLi8u
Li8uLi8uLi91c3IvaW5jbHVkZS8KIENGTEFHUyA6PSAkKENGTEFHUykgLWcgLU8yIC1XYWxs
IC1EX0dOVV9TT1VSQ0UgLXB0aHJlYWQgJChJTkNMVURFUykgJChLSERSX0lOQ0xVREVTKQog
TERMSUJTIDo9IC1scHRocmVhZCAtbHJ0CiAKLUhFQURFUlMgOj0gXAorTE9DQUxfSERSUyA6
PSBcCiAJLi4vaW5jbHVkZS9mdXRleHRlc3QuaCBcCiAJLi4vaW5jbHVkZS9hdG9taWMuaCBc
CiAJLi4vaW5jbHVkZS9sb2dnaW5nLmgKLVRFU1RfR0VOX0ZJTEVTIDo9IFwKK1RFU1RfR0VO
X1BST0dTIDo9IFwKIAlmdXRleF93YWl0X3RpbWVvdXQgXAogCWZ1dGV4X3dhaXRfd291bGRi
bG9jayBcCiAJZnV0ZXhfcmVxdWV1ZV9waSBcCkBAIC0yNCw1ICsyNCwzIEBAIFRFU1RfUFJP
R1MgOj0gcnVuLnNoCiB0b3Bfc3JjZGlyID0gLi4vLi4vLi4vLi4vLi4KIERFRkFVTFRfSU5T
VEFMTF9IRFJfUEFUSCA6PSAxCiBpbmNsdWRlIC4uLy4uL2xpYi5tawotCi0kKFRFU1RfR0VO
X0ZJTEVTKTogJChIRUFERVJTKQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvaW50ZWxfcHN0YXRlL01ha2VmaWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaW50
ZWxfcHN0YXRlL01ha2VmaWxlCmluZGV4IDM5ZjBmYTJhOGZkNi4uMDVkNjZlZjUwYzk3IDEw
MDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9pbnRlbF9wc3RhdGUvTWFrZWZp
bGUKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaW50ZWxfcHN0YXRlL01ha2VmaWxl
CkBAIC0yLDEwICsyLDEwIEBACiBDRkxBR1MgOj0gJChDRkxBR1MpIC1XYWxsIC1EX0dOVV9T
T1VSQ0UKIExETElCUyArPSAtbG0KIAotdW5hbWVfTSA6PSAkKHNoZWxsIHVuYW1lIC1tIDI+
L2Rldi9udWxsIHx8IGVjaG8gbm90KQotQVJDSCA/PSAkKHNoZWxsIGVjaG8gJCh1bmFtZV9N
KSB8IHNlZCAtZSBzL2kuODYveDg2LyAtZSBzL3g4Nl82NC94ODYvKQorQVJDSCA/PSAkKHNo
ZWxsIHVuYW1lIC1tIDI+L2Rldi9udWxsIHx8IGVjaG8gbm90KQorQVJDSF9QUk9DRVNTRUQg
Oj0gJChzaGVsbCBlY2hvICQoQVJDSCkgfCBzZWQgLWUgcy9pLjg2L3g4Ni8gLWUgcy94ODZf
NjQveDg2LykKIAotaWZlcSAoeDg2LCQoQVJDSCkpCitpZmVxICh4ODYsJChBUkNIX1BST0NF
U1NFRCkpCiBURVNUX0dFTl9GSUxFUyA6PSBtc3IgYXBlcmYKIGVuZGlmCiAKZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tleGVjL01ha2VmaWxlIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMva2V4ZWMvTWFrZWZpbGUKaW5kZXggODA2YTE1MDY0OGMzLi42N2Zl
N2E0NmNiNjIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tleGVjL01h
a2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tleGVjL01ha2VmaWxlCkBA
IC0xLDEwICsxLDEwIEBACiAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9u
bHkKICMgTWFrZWZpbGUgZm9yIGtleGVjIHRlc3RzCiAKLXVuYW1lX00gOj0gJChzaGVsbCB1
bmFtZSAtbSAyPi9kZXYvbnVsbCB8fCBlY2hvIG5vdCkKLUFSQ0ggPz0gJChzaGVsbCBlY2hv
ICQodW5hbWVfTSkgfCBzZWQgLWUgcy9pLjg2L3g4Ni8gLWUgcy94ODZfNjQveDg2LykKK0FS
Q0ggPz0gJChzaGVsbCB1bmFtZSAtbSAyPi9kZXYvbnVsbCB8fCBlY2hvIG5vdCkKK0FSQ0hf
UFJPQ0VTU0VEIDo9ICQoc2hlbGwgZWNobyAkKEFSQ0gpIHwgc2VkIC1lIHMvaS44Ni94ODYv
IC1lIHMveDg2XzY0L3g4Ni8pCiAKLWlmZXEgKCQoQVJDSCksJChmaWx0ZXIgJChBUkNIKSx4
ODYgcHBjNjRsZSkpCitpZmVxICgkKEFSQ0hfUFJPQ0VTU0VEKSwkKGZpbHRlciAkKEFSQ0hf
UFJPQ0VTU0VEKSx4ODYgcHBjNjRsZSkpCiBURVNUX1BST0dTIDo9IHRlc3Rfa2V4ZWNfbG9h
ZC5zaCB0ZXN0X2tleGVjX2ZpbGVfbG9hZC5zaAogVEVTVF9GSUxFUyA6PSBrZXhlY19jb21t
b25fbGliLnNoCiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9y
eS1ob3RwbHVnL21lbS1vbi1vZmYtdGVzdC5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L21lbW9yeS1ob3RwbHVnL21lbS1vbi1vZmYtdGVzdC5zaAppbmRleCA3NGVlNTA2N2E4Y2Uu
LjYxMWJlODZlYWYzZCAxMDA3NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVt
b3J5LWhvdHBsdWcvbWVtLW9uLW9mZi10ZXN0LnNoCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL21lbW9yeS1ob3RwbHVnL21lbS1vbi1vZmYtdGVzdC5zaApAQCAtMTM4LDcgKzEz
OCw2IEBAIG9ubGluZV9hbGxfb2ZmbGluZV9tZW1vcnkoKQogewogCWZvciBtZW1vcnkgaW4g
YGhvdHBsdWdnYWJsZV9vZmZsaW5lX21lbW9yeWA7IGRvCiAJCWlmICEgb25saW5lX21lbW9y
eV9leHBlY3Rfc3VjY2VzcyAkbWVtb3J5OyB0aGVuCi0JCQllY2hvICIkRlVOQ05BTUUgJG1l
bW9yeTogdW5leHBlY3RlZCBmYWlsIiA+JjIKIAkJCXJldHZhbD0xCiAJCWZpCiAJZG9uZQo=


--------------VQ0pGbV09a28TYDKCWYl6zh9--
