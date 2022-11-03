Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91B617DF9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 14:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKCNeE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiKCNeD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 09:34:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FDE63D5
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 06:34:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so1799901pjl.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1QqFy+VNTViKLjxab+1Xd32/kKSi0wuwBQO1qBHtEF8=;
        b=E1fbxisBK5k0dh/6Que4DMtXFBnSiMApGw5drLTPqiCJbZ8x3aouLUNXQFMB08/7+C
         KSaob9KNi88j/d5tKbPd9Zek65cV0aMBUfuJ5BS9v5IBzkmRO/vs1p5IJL/8bY4FM/sp
         hJw5A7DMlZmI/30Vao9W2VlUE8P90vtfa+PW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QqFy+VNTViKLjxab+1Xd32/kKSi0wuwBQO1qBHtEF8=;
        b=2nMgO5PwNSyRpfMeGNvE59ydsATAxXHCxP0Z5QOQ7shnERjERzegTREMxD5wNTmhuw
         Q6gF+Qoc6RqqMqbob/5ugCG/qkRlfTyhfs4FdYY+DxaJN8kShPtBf7tJgHrEzu3dE9fu
         4Y3buneZBlC3ACooF1BreDX8U6I7l1+7V7QjO7zY4jk3NMBVVZK2GcvHp+kuDr44CTNK
         p1b47Yo43Zy4lwXLj8Y1oS0vM3wyjHyiJYNE7KSgN1wJEIX++TetN0wzG0u6FmX3evnx
         nZuVSx7woH0xHDnSmL7iJRkqao97yyo8j3LMgdDrcjAG5/sN1eieYsqH4qpSddHprNT8
         vpng==
X-Gm-Message-State: ACrzQf1YTlDbhRCZzRDVwexBXy48xfmzCG1feM30ApGYSh+wHiuN56+8
        nZsi9M8fc0gmDIhIq3kKsFRsNg==
X-Google-Smtp-Source: AMsMyM6NGs7b/1Pg6bySVfF69pvW23dBz3md/qv8YnBd3S2o1/lNJ9g8cj8Z3LH7A9xfkQgPt1wtdA==
X-Received: by 2002:a17:90b:1b01:b0:213:ccc6:87ea with SMTP id nu1-20020a17090b1b0100b00213ccc687eamr25733268pjb.135.1667482441723;
        Thu, 03 Nov 2022 06:34:01 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b001784a45511asm684361plg.79.2022.11.03.06.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 06:34:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------dfbO8p2MzthdkvVctIQ258AK"
Message-ID: <6eae8f0b-2050-3c0f-828d-8b87262b1cef@linuxfoundation.org>
Date:   Thu, 3 Nov 2022 07:33:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.1-rc4
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------dfbO8p2MzthdkvVctIQ258AK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.1-rc4.

This Kselftest fixes update for Linux 6.1-rc4 consists of fixes to
pidfd test.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit cb05c81ada76a30a25a5f79b249375e33473af33:

   selftests/ftrace: fix dynamic_events dependency check (2022-10-18 14:27:23 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.1-rc4

for you to fetch changes up to 89c1017aac67ca81973b7c8eac5d021315811a93:

   selftests/pidfd_test: Remove the erroneous ',' (2022-11-02 03:09:57 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.1-rc4

This Kselftest fixes update for Linux 6.1-rc4 consists of fixes to
pidfd test.

----------------------------------------------------------------
Li Zhijian (2):
       ksefltests: pidfd: Fix wait_states: Test terminated by timeout
       selftests: pidfd: Fix compling warnings

Zhao Gongyi (1):
       selftests/pidfd_test: Remove the erroneous ','

  tools/testing/selftests/pidfd/Makefile     |  2 +-
  tools/testing/selftests/pidfd/pidfd_test.c |  4 +++-
  tools/testing/selftests/pidfd/pidfd_wait.c | 12 +++++++++++-
  3 files changed, 15 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------dfbO8p2MzthdkvVctIQ258AK
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.1-rc4.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.1-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL01ha2VmaWxlIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGlkZmQvTWFrZWZpbGUKaW5kZXggZjRhMmYyOGY5
MjZiLi43NzhiNmNkYzhhZWQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3BpZGZkL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL01h
a2VmaWxlCkBAIC0xLDUgKzEsNSBAQAogIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5Ci1DRkxBR1MgKz0gLWcgLUkuLi8uLi8uLi8uLi91c3IvaW5jbHVkZS8gLXB0
aHJlYWQKK0NGTEFHUyArPSAtZyAtSS4uLy4uLy4uLy4uL3Vzci9pbmNsdWRlLyAtcHRocmVh
ZCAtV2FsbAogCiBURVNUX0dFTl9QUk9HUyA6PSBwaWRmZF90ZXN0IHBpZGZkX2ZkaW5mb190
ZXN0IHBpZGZkX29wZW5fdGVzdCBcCiAJcGlkZmRfcG9sbF90ZXN0IHBpZGZkX3dhaXQgcGlk
ZmRfZ2V0ZmRfdGVzdCBwaWRmZF9zZXRuc190ZXN0CmRpZmYgLS1naXQgYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9waWRmZC9waWRmZF90ZXN0LmMKaW5kZXggOWEyZDY0OTAxZDU5Li5lMmRkNGVkODQ5
ODQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3Rl
c3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF90ZXN0LmMK
QEAgLTQxMyw3ICs0MTMsNyBAQCBzdGF0aWMgdm9pZCBwb2xsX3BpZGZkKGNvbnN0IGNoYXIg
KnRlc3RfbmFtZSwgaW50IHBpZGZkKQogCiAJYyA9IGVwb2xsX3dhaXQoZXBvbGxfZmQsIGV2
ZW50cywgTUFYX0VWRU5UUywgNTAwMCk7CiAJaWYgKGMgIT0gMSB8fCAhKGV2ZW50c1swXS5l
dmVudHMgJiBFUE9MTElOKSkKLQkJa3NmdF9leGl0X2ZhaWxfbXNnKCIlcyB0ZXN0OiBVbmV4
cGVjdGVkIGVwb2xsX3dhaXQgcmVzdWx0IChjPSVkLCBldmVudHM9JXgpICIsCisJCWtzZnRf
ZXhpdF9mYWlsX21zZygiJXMgdGVzdDogVW5leHBlY3RlZCBlcG9sbF93YWl0IHJlc3VsdCAo
Yz0lZCwgZXZlbnRzPSV4KSAiCiAJCQkJICAgIihlcnJubyAlZClcbiIsCiAJCQkJICAgdGVz
dF9uYW1lLCBjLCBldmVudHNbMF0uZXZlbnRzLCBlcnJubyk7CiAKQEAgLTQzNSw2ICs0MzUs
OCBAQCBzdGF0aWMgaW50IGNoaWxkX3BvbGxfZXhlY190ZXN0KHZvaWQgKmFyZ3MpCiAJICov
CiAJd2hpbGUgKDEpCiAJCXNsZWVwKDEpOworCisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyB2
b2lkIHRlc3RfcGlkZmRfcG9sbF9leGVjKGludCB1c2Vfd2FpdHBpZCkKZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3dhaXQuYyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3dhaXQuYwppbmRleCAwNzBjMWM4NzZkZjEu
LjBkY2I4MzY1ZGRjMyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGlk
ZmQvcGlkZmRfd2FpdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3Bp
ZGZkX3dhaXQuYwpAQCAtOTUsMjAgKzk1LDI4IEBAIFRFU1Qod2FpdF9zdGF0ZXMpCiAJCS5m
bGFncyA9IENMT05FX1BJREZEIHwgQ0xPTkVfUEFSRU5UX1NFVFRJRCwKIAkJLmV4aXRfc2ln
bmFsID0gU0lHQ0hMRCwKIAl9OworCWludCBwZmRbMl07CiAJcGlkX3QgcGlkOwogCXNpZ2lu
Zm9fdCBpbmZvID0gewogCQkuc2lfc2lnbm8gPSAwLAogCX07CiAKKwlBU1NFUlRfRVEocGlw
ZShwZmQpLCAwKTsKIAlwaWQgPSBzeXNfY2xvbmUzKCZhcmdzKTsKIAlBU1NFUlRfR0UocGlk
LCAwKTsKIAogCWlmIChwaWQgPT0gMCkgeworCQljaGFyIGJ1ZlsyXTsKKworCQljbG9zZShw
ZmRbMV0pOwogCQlraWxsKGdldHBpZCgpLCBTSUdTVE9QKTsKKwkJQVNTRVJUX0VRKHJlYWQo
cGZkWzBdLCBidWYsIDEpLCAxKTsKKwkJY2xvc2UocGZkWzBdKTsKIAkJa2lsbChnZXRwaWQo
KSwgU0lHU1RPUCk7CiAJCWV4aXQoRVhJVF9TVUNDRVNTKTsKIAl9CiAKKwljbG9zZShwZmRb
MF0pOwogCUFTU0VSVF9FUShzeXNfd2FpdGlkKFBfUElERkQsIHBpZGZkLCAmaW5mbywgV1NU
T1BQRUQsIE5VTEwpLCAwKTsKIAlBU1NFUlRfRVEoaW5mby5zaV9zaWdubywgU0lHQ0hMRCk7
CiAJQVNTRVJUX0VRKGluZm8uc2lfY29kZSwgQ0xEX1NUT1BQRUQpOwpAQCAtMTE3LDYgKzEy
NSw4IEBAIFRFU1Qod2FpdF9zdGF0ZXMpCiAJQVNTRVJUX0VRKHN5c19waWRmZF9zZW5kX3Np
Z25hbChwaWRmZCwgU0lHQ09OVCwgTlVMTCwgMCksIDApOwogCiAJQVNTRVJUX0VRKHN5c193
YWl0aWQoUF9QSURGRCwgcGlkZmQsICZpbmZvLCBXQ09OVElOVUVELCBOVUxMKSwgMCk7CisJ
QVNTRVJUX0VRKHdyaXRlKHBmZFsxXSwgIkMiLCAxKSwgMSk7CisJY2xvc2UocGZkWzFdKTsK
IAlBU1NFUlRfRVEoaW5mby5zaV9zaWdubywgU0lHQ0hMRCk7CiAJQVNTRVJUX0VRKGluZm8u
c2lfY29kZSwgQ0xEX0NPTlRJTlVFRCk7CiAJQVNTRVJUX0VRKGluZm8uc2lfcGlkLCBwYXJl
bnRfdGlkKTsKQEAgLTEzOCw3ICsxNDgsNyBAQCBURVNUKHdhaXRfc3RhdGVzKQogCiBURVNU
KHdhaXRfbm9uYmxvY2spCiB7Ci0JaW50IHBpZGZkLCBzdGF0dXMgPSAwOworCWludCBwaWRm
ZDsKIAl1bnNpZ25lZCBpbnQgZmxhZ3MgPSAwOwogCXBpZF90IHBhcmVudF90aWQgPSAtMTsK
IAlzdHJ1Y3QgY2xvbmVfYXJncyBhcmdzID0gewo=

--------------dfbO8p2MzthdkvVctIQ258AK--
