Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39972706FFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjEQRv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQRv2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 13:51:28 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8099023
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 10:51:15 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-76c6e795650so7100739f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684345874; x=1686937874;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeGga+wRA3DdbN6qGermomi0t82TyTTjoICSjLR9Oak=;
        b=ZOWQ3xq8cR30z4CmAL/UBjRPsScKhCwFj+r8333u4PiRDsGDCMRjEyZtYqLGebnzpU
         q5oLs3cbabusvm5yTKq6qdQCFw6hLBYsIz1N+iaC58wPfCvybwGcSaSM3pZxw6djOnJn
         kx521tNH9qgu+ZeeWDlEo/3IqU+JpS4gD7z0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345874; x=1686937874;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeGga+wRA3DdbN6qGermomi0t82TyTTjoICSjLR9Oak=;
        b=fdGmtwQTSYkf/2NK676jrwnJvUIzmog4V+ads1za+tqMmZHrrEJo6wvHc2HucuAK2e
         Oev39kK0z5ORbdgHDy93dNyknfPGMwCDRoKjkb+5ww75Zeet5EOShzq6WNEc7aenX5ql
         nYM11Ef25Dr+gOiecuvTDS3ruFuvnHDBsmgc+ATJ7Zt+NGWrIYJOR1ZAqNKRbbMngkEb
         ekctZ6IRcY+NTLPr7tiDhoVr8BKu8hYAprQInLP51RMHL1lCbUWb8JQH/Oq9g7GPMtKY
         AeYa9d2Wya1DBcaY2eq1JwwCOzICuptWEoAuOqfwf2sDP/k6rVYmAHVL4KKv1AQ4wRwA
         zj1w==
X-Gm-Message-State: AC+VfDxIVtY455hSQHjt9tT2Cuu1N3baEgECxFPapa+YD56FZ7opsA8Y
        7Lhy1dPl0edNqeZKx0mK2P97BQ==
X-Google-Smtp-Source: ACHHUZ7i6LAUJx7suPIRn5udDpxPFW5/BSsgRqwXtOB28GbGFRFVKLyVGxOIh0VXUQg4hV/aHq8YHA==
X-Received: by 2002:a05:6602:371b:b0:76c:58d8:ff14 with SMTP id bh27-20020a056602371b00b0076c58d8ff14mr2537996iob.2.1684345874596;
        Wed, 17 May 2023 10:51:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l14-20020a6b750e000000b0076c872823b7sm4442428ioh.22.2023.05.17.10.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 10:51:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ZntvF0xiKTz6Lpdvi5kYi38P"
Message-ID: <eadfd317-7a66-2cf7-72ca-ee9b8b0aea91@linuxfoundation.org>
Date:   Wed, 17 May 2023 11:51:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     torvalds@linux-foundation.org
Cc:     skhan@linuxfoundation.org, shuah <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.4-rc3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------ZntvF0xiKTz6Lpdvi5kYi38P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.4-rc3.

This Kselftest fixes update for Linux 6.4-rc3 consists of:

- sgx test fix for false negatives.
- ftrace output is hard to parse and it masks inappropriate skips etc.
   This fix addresses the problems by integrating with kselftest runner.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.4-rc3

for you to fetch changes up to dbcf76390eb9a65d5d0c37b0cd57335218564e37:

   selftests/ftrace: Improve integration with kselftest runner (2023-05-08 11:10:13 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.4-rc3

This Kselftest fixes update for Linux 6.4-rc3 consists of:

- sgx test fix for false negatives.
- ftrace output is hard to parse and it masks inappropriate skips etc.
   This fix addresses the problems by integrating with kselftest runner.

----------------------------------------------------------------
Mark Brown (1):
       selftests/ftrace: Improve integration with kselftest runner

Yi Lai (1):
       selftests/sgx: Add "test_encl.elf" to TEST_FILES

  tools/testing/selftests/ftrace/Makefile        |  3 +-
  tools/testing/selftests/ftrace/ftracetest      | 63 ++++++++++++++++++++++++--
  tools/testing/selftests/ftrace/ftracetest-ktap |  8 ++++
  tools/testing/selftests/sgx/Makefile           |  1 +
  4 files changed, 71 insertions(+), 4 deletions(-)
  create mode 100755 tools/testing/selftests/ftrace/ftracetest-ktap
----------------------------------------------------------------
--------------ZntvF0xiKTz6Lpdvi5kYi38P
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.4-rc3.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.4-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9NYWtlZmlsZSBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9NYWtlZmlsZQppbmRleCBkNmUxMDZm
YmNlMTEuLmExZTk1NWQyZGU0YyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvZnRyYWNlL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFj
ZS9NYWtlZmlsZQpAQCAtMSw3ICsxLDggQEAKICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAKIGFsbDoKIAotVEVTVF9QUk9HUyA6PSBmdHJhY2V0ZXN0CitURVNUX1BST0dT
X0VYVEVOREVEIDo9IGZ0cmFjZXRlc3QKK1RFU1RfUFJPR1MgOj0gZnRyYWNldGVzdC1rdGFw
CiBURVNUX0ZJTEVTIDo9IHRlc3QuZCBzZXR0aW5ncwogRVhUUkFfQ0xFQU4gOj0gJChPVVRQ
VVQpL2xvZ3MvKgogCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJh
Y2UvZnRyYWNldGVzdCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9mdHJhY2V0
ZXN0CmluZGV4IGMzMzExYzhjNDA4OS4uMjUwNjYyMWU3NWRmIDEwMDc1NQotLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvZnRyYWNldGVzdAorKysgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvZnRyYWNldGVzdApAQCAtMTMsNiArMTMsNyBAQCBlY2hv
ICJVc2FnZTogZnRyYWNldGVzdCBbb3B0aW9uc10gW3Rlc3RjYXNlKHMpXSBbdGVzdGNhc2Ut
ZGlyZWN0b3J5KHMpXSIKIGVjaG8gIiBPcHRpb25zOiIKIGVjaG8gIgkJLWh8LS1oZWxwICBT
aG93IGhlbHAgbWVzc2FnZSIKIGVjaG8gIgkJLWt8LS1rZWVwICBLZWVwIHBhc3NlZCB0ZXN0
IGxvZ3MiCitlY2hvICIJCS1LfC0ta3RhcCAgT3V0cHV0IGluIEtUQVAgZm9ybWF0IgogZWNo
byAiCQktdnwtLXZlcmJvc2UgSW5jcmVhc2UgdmVyYm9zaXR5IG9mIHRlc3QgbWVzc2FnZXMi
CiBlY2hvICIJCS12diAgICAgICAgQWxpYXMgb2YgLXYgLXYgKFNob3cgYWxsIHJlc3VsdHMg
aW4gc3Rkb3V0KSIKIGVjaG8gIgkJLXZ2diAgICAgICBBbGlhcyBvZiAtdiAtdiAtdiAoU2hv
dyBhbGwgY29tbWFuZHMgaW1tZWRpYXRlbHkpIgpAQCAtODUsNiArODYsMTAgQEAgcGFyc2Vf
b3B0cygpIHsgIyBvcHRzCiAgICAgICBLRUVQX0xPRz0xCiAgICAgICBzaGlmdCAxCiAgICAg
OzsKKyAgICAtLWt0YXB8LUspCisgICAgICBLVEFQPTEKKyAgICAgIHNoaWZ0IDEKKyAgICA7
OwogICAgIC0tdmVyYm9zZXwtdnwtdnZ8LXZ2dikKICAgICAgIGlmIFsgJFZFUkJPU0UgLWVx
IC0xIF07IHRoZW4KIAl1c2FnZSAiLS1jb25zb2xlIGNhbiBub3QgdXNlIHdpdGggLS12ZXJi
b3NlIgpAQCAtMTc4LDYgKzE4Myw3IEBAIFRFU1RfRElSPSRUT1BfRElSL3Rlc3QuZAogVEVT
VF9DQVNFUz1gZmluZF90ZXN0Y2FzZXMgJFRFU1RfRElSYAogTE9HX0RJUj0kVE9QX0RJUi9s
b2dzL2BkYXRlICslWSVtJWQtJUglTSVTYC8KIEtFRVBfTE9HPTAKK0tUQVA9MAogREVCVUc9
MAogVkVSQk9TRT0wCiBVTlNVUFBPUlRFRF9SRVNVTFQ9MApAQCAtMjI5LDcgKzIzNSw3IEBA
IHBybG9nKCkgeyAjIG1lc3NhZ2VzCiAgICAgbmV3bGluZT0KICAgICBzaGlmdAogICBmaQot
ICBwcmludGYgIiQqJG5ld2xpbmUiCisgIFsgIiRLVEFQIiAhPSAiMSIgXSAmJiBwcmludGYg
IiQqJG5ld2xpbmUiCiAgIFsgIiRMT0dfRklMRSIgXSAmJiBwcmludGYgIiQqJG5ld2xpbmUi
IHwgc3RyaXBfZXNjID4+ICRMT0dfRklMRQogfQogY2F0bG9nKCkgeyAjZmlsZQpAQCAtMjYw
LDExICsyNjYsMTEgQEAgVE9UQUxfUkVTVUxUPTAKIAogSU5TVEFOQ0U9CiBDQVNFTk89MAor
Q0FTRU5BTUU9CiAKIHRlc3RjYXNlKCkgeyAjIHRlc3RmaWxlCiAgIENBU0VOTz0kKChDQVNF
Tk8rMSkpCi0gIGRlc2M9YGdyZXAgIl4jWyBcdF0qZGVzY3JpcHRpb246IiAkMSB8IGN1dCAt
ZjItIC1kOmAKLSAgcHJsb2cgLW4gIlskQ0FTRU5PXSRJTlNUQU5DRSRkZXNjIgorICBDQVNF
TkFNRT1gZ3JlcCAiXiNbIFx0XSpkZXNjcmlwdGlvbjoiICQxIHwgY3V0IC1mMi0gLWQ6YAog
fQogCiBjaGVja3JlcSgpIHsgIyB0ZXN0ZmlsZQpAQCAtMjc3LDQwICsyODMsNjggQEAgdGVz
dF9vbl9pbnN0YW5jZSgpIHsgIyB0ZXN0ZmlsZQogICBncmVwIC1xICJeI1sgXHRdKmZsYWdz
Oi4qaW5zdGFuY2UiICQxCiB9CiAKK2t0YXB0ZXN0KCkgeyAjIHJlc3VsdCBjb21tZW50Cisg
IGlmIFsgIiRLVEFQIiAhPSAiMSIgXTsgdGhlbgorICAgIHJldHVybgorICBmaQorCisgIGxv
Y2FsIHJlc3VsdD0KKyAgaWYgWyAiJDEiID0gIjEiIF07IHRoZW4KKyAgICByZXN1bHQ9Im9r
IgorICBlbHNlCisgICAgcmVzdWx0PSJub3Qgb2siCisgIGZpCisgIHNoaWZ0CisKKyAgbG9j
YWwgY29tbWVudD0kKgorICBpZiBbICIkY29tbWVudCIgIT0gIiIgXTsgdGhlbgorICAgIGNv
bW1lbnQ9IiMgJGNvbW1lbnQiCisgIGZpCisKKyAgZWNobyAkQ0FTRU5PICRyZXN1bHQgJElO
U1RBTkNFJENBU0VOQU1FICRjb21tZW50Cit9CisKIGV2YWxfcmVzdWx0KCkgeyAjIHNpZ3Zh
bAogICBjYXNlICQxIGluCiAgICAgJFBBU1MpCiAgICAgICBwcmxvZyAiCVske2NvbG9yX2dy
ZWVufVBBU1Mke2NvbG9yX3Jlc2V0fV0iCisgICAgICBrdGFwdGVzdCAxCiAgICAgICBQQVNT
RURfQ0FTRVM9IiRQQVNTRURfQ0FTRVMgJENBU0VOTyIKICAgICAgIHJldHVybiAwCiAgICAg
OzsKICAgICAkRkFJTCkKICAgICAgIHBybG9nICIJWyR7Y29sb3JfcmVkfUZBSUwke2NvbG9y
X3Jlc2V0fV0iCisgICAgICBrdGFwdGVzdCAwCiAgICAgICBGQUlMRURfQ0FTRVM9IiRGQUlM
RURfQ0FTRVMgJENBU0VOTyIKICAgICAgIHJldHVybiAxICMgdGhpcyBpcyBhIGJ1Zy4KICAg
ICA7OwogICAgICRVTlJFU09MVkVEKQogICAgICAgcHJsb2cgIglbJHtjb2xvcl9ibHVlfVVO
UkVTT0xWRUQke2NvbG9yX3Jlc2V0fV0iCisgICAgICBrdGFwdGVzdCAwIFVOUkVTT0xWRUQK
ICAgICAgIFVOUkVTT0xWRURfQ0FTRVM9IiRVTlJFU09MVkVEX0NBU0VTICRDQVNFTk8iCiAg
ICAgICByZXR1cm4gJFVOUkVTT0xWRURfUkVTVUxUICMgZGVwZW5kcyBvbiB1c2UgY2FzZQog
ICAgIDs7CiAgICAgJFVOVEVTVEVEKQogICAgICAgcHJsb2cgIglbJHtjb2xvcl9ibHVlfVVO
VEVTVEVEJHtjb2xvcl9yZXNldH1dIgorICAgICAga3RhcHRlc3QgMSBTS0lQCiAgICAgICBV
TlRFU1RFRF9DQVNFUz0iJFVOVEVTVEVEX0NBU0VTICRDQVNFTk8iCiAgICAgICByZXR1cm4g
MAogICAgIDs7CiAgICAgJFVOU1VQUE9SVEVEKQogICAgICAgcHJsb2cgIglbJHtjb2xvcl9i
bHVlfVVOU1VQUE9SVEVEJHtjb2xvcl9yZXNldH1dIgorICAgICAga3RhcHRlc3QgMSBTS0lQ
CiAgICAgICBVTlNVUFBPUlRFRF9DQVNFUz0iJFVOU1VQUE9SVEVEX0NBU0VTICRDQVNFTk8i
CiAgICAgICByZXR1cm4gJFVOU1VQUE9SVEVEX1JFU1VMVCAjIGRlcGVuZHMgb24gdXNlIGNh
c2UKICAgICA7OwogICAgICRYRkFJTCkKICAgICAgIHBybG9nICIJWyR7Y29sb3JfZ3JlZW59
WEZBSUwke2NvbG9yX3Jlc2V0fV0iCisgICAgICBrdGFwdGVzdCAxIFhGQUlMCiAgICAgICBY
RkFJTEVEX0NBU0VTPSIkWEZBSUxFRF9DQVNFUyAkQ0FTRU5PIgogICAgICAgcmV0dXJuIDAK
ICAgICA7OwogICAgICopCiAgICAgICBwcmxvZyAiCVske2NvbG9yX2JsdWV9VU5ERUZJTkVE
JHtjb2xvcl9yZXNldH1dIgorICAgICAga3RhcHRlc3QgMCBlcnJvcgogICAgICAgVU5ERUZJ
TkVEX0NBU0VTPSIkVU5ERUZJTkVEX0NBU0VTICRDQVNFTk8iCiAgICAgICByZXR1cm4gMSAj
IHRoaXMgbXVzdCBiZSBhIHRlc3QgYnVnCiAgICAgOzsKQEAgLTM3MSw2ICs0MDUsNyBAQCBf
X3J1bl90ZXN0KCkgeyAjIHRlc3RmaWxlCiBydW5fdGVzdCgpIHsgIyB0ZXN0ZmlsZQogICBs
b2NhbCB0ZXN0bmFtZT1gYmFzZW5hbWUgJDFgCiAgIHRlc3RjYXNlICQxCisgIHBybG9nIC1u
ICJbJENBU0VOT10kSU5TVEFOQ0UkQ0FTRU5BTUUiCiAgIGlmIFsgISAteiAiJExPR19GSUxF
IiBdIDsgdGhlbgogICAgIGxvY2FsIHRlc3Rsb2c9YG1rdGVtcCAkTE9HX0RJUi8ke0NBU0VO
T30tJHt0ZXN0bmFtZX0tbG9nLlhYWFhYWGAKICAgZWxzZQpAQCAtNDA1LDYgKzQ0MCwxNyBA
QCBydW5fdGVzdCgpIHsgIyB0ZXN0ZmlsZQogIyBsb2FkIGluIHRoZSBoZWxwZXIgZnVuY3Rp
b25zCiAuICRURVNUX0RJUi9mdW5jdGlvbnMKIAoraWYgWyAiJEtUQVAiID0gIjEiIF07IHRo
ZW4KKyAgZWNobyAiVEFQIHZlcnNpb24gMTMiCisKKyAgY2FzZWNvdW50PWBlY2hvICRURVNU
X0NBU0VTIHwgd2MgLXdgCisgIGZvciB0IGluICRURVNUX0NBU0VTOyBkbworICAgIHRlc3Rf
b25faW5zdGFuY2UgJHQgfHwgY29udGludWUKKyAgICBjYXNlY291bnQ9JCgoY2FzZWNvdW50
KzEpKQorICBkb25lCisgIGVjaG8gIjEuLiR7Y2FzZWNvdW50fSIKK2ZpCisKICMgTWFpbiBs
b29wCiBmb3IgdCBpbiAkVEVTVF9DQVNFUzsgZG8KICAgcnVuX3Rlc3QgJHQKQEAgLTQzOSw2
ICs0ODUsMTcgQEAgcHJsb2cgIiMgb2YgdW5zdXBwb3J0ZWQ6ICIgYGVjaG8gJFVOU1VQUE9S
VEVEX0NBU0VTIHwgd2MgLXdgCiBwcmxvZyAiIyBvZiB4ZmFpbGVkOiAiIGBlY2hvICRYRkFJ
TEVEX0NBU0VTIHwgd2MgLXdgCiBwcmxvZyAiIyBvZiB1bmRlZmluZWQodGVzdCBidWcpOiAi
IGBlY2hvICRVTkRFRklORURfQ0FTRVMgfCB3YyAtd2AKIAoraWYgWyAiJEtUQVAiID0gIjEi
IF07IHRoZW4KKyAgZWNobyAtbiAiIyBUb3RhbHM6IgorICBlY2hvIC1uICIgcGFzczoiYGVj
aG8gJFBBU1NFRF9DQVNFUyB8IHdjIC13YAorICBlY2hvIC1uICIgZmFpaToiYGVjaG8gJEZB
SUxFRF9DQVNFUyB8IHdjIC13YAorICBlY2hvIC1uICIgeGZhaWw6ImBlY2hvICRYRkFJTEVE
X0NBU0VTIHwgd2MgLXdgCisgIGVjaG8gLW4gIiB4cGFzczowIgorICBlY2hvIC1uICIgc2tp
cDoiYGVjaG8gJFVOVEVTVEVEX0NBU0VTICRVTlNVUFBPUlRFRF9DQVNFUyB8IHdjIC13YAor
ICBlY2hvIC1uICIgZXJyb3I6ImBlY2hvICRVTlJFU09MVkVEX0NBU0VTICRVTkRFRklORURf
Q0FTRVMgfCB3YyAtd2AKKyAgZWNobworZmkKKwogY2xlYW51cAogCiAjIGlmIG5vIGVycm9y
LCByZXR1cm4gMApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNl
L2Z0cmFjZXRlc3Qta3RhcCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9mdHJh
Y2V0ZXN0LWt0YXAKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5kZXggMDAwMDAwMDAwMDAwLi5i
MzI4NDY3OWVmM2EKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9mdHJhY2UvZnRyYWNldGVzdC1rdGFwCkBAIC0wLDAgKzEsOCBAQAorIyEvYmluL3NoIC1l
CisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKyMKKyMgZnRyYWNl
dGVzdC1rdGFwOiBXcmFwcGVyIHRvIGludGVncmF0ZSBmdHJhY2V0ZXN0IHdpdGggdGhlIGtz
ZWxmdGVzdCBydW5uZXIKKyMKKyMgQ29weXJpZ2h0IChDKSBBcm0gTHRkLiwgMjAyMworCisu
L2Z0cmFjZXRlc3QgLUsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Nn
eC9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9NYWtlZmlsZQppbmRl
eCA3NWFmODY0ZTA3YjYuLjUwYWFiNmI1N2RhMyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvc2d4L01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3NneC9NYWtlZmlsZQpAQCAtMTcsNiArMTcsNyBAQCBFTkNMX0NGTEFHUyA6PSAtV2FsbCAt
V2Vycm9yIC1zdGF0aWMgLW5vc3RkbGliIC1ub3N0YXJ0ZmlsZXMgLWZQSUMgXAogCSAgICAg
ICAtZm5vLXN0YWNrLXByb3RlY3RvciAtbXJkcm5kICQoSU5DTFVERVMpCiAKIFRFU1RfQ1VT
VE9NX1BST0dTIDo9ICQoT1VUUFVUKS90ZXN0X3NneAorVEVTVF9GSUxFUyA6PSAkKE9VVFBV
VCkvdGVzdF9lbmNsLmVsZgogCiBpZmVxICgkKENBTl9CVUlMRF9YODZfNjQpLCAxKQogYWxs
OiAkKFRFU1RfQ1VTVE9NX1BST0dTKSAkKE9VVFBVVCkvdGVzdF9lbmNsLmVsZgo=

--------------ZntvF0xiKTz6Lpdvi5kYi38P--
