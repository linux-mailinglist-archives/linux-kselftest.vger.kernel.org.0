Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21134626EC9
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Nov 2022 10:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiKMJqP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Nov 2022 04:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMJqO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Nov 2022 04:46:14 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A802218C;
        Sun, 13 Nov 2022 01:46:13 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 13 Nov
 2022 17:41:10 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.167]
Date:   Sun, 13 Nov 2022 17:41:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/arm64: fix array_size.cocci warning
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <777ce8ba.12e.184705d4211.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+G2u3BjgRsDAA--.82W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DfwAWsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rml4IGZvbGxvd2luZyBjb2NjaWNoZWNrIHdhcm5pbmc6Cgp0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9hcm02NC9tdGUvY2hlY2tfbW1hcF9vcHRpb25zLmM6NjQ6MjQtMjU6CldBUk5JTkc6IFVzZSBB
UlJBWV9TSVpFCnRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FybTY0L210ZS9jaGVja19tbWFwX29w
dGlvbnMuYzo2NjoyMC0yMToKV0FSTklORzogVXNlIEFSUkFZX1NJWkUKdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYXJtNjQvbXRlL2NoZWNrX21tYXBfb3B0aW9ucy5jOjEzNToyNS0yNjoKV0FSTklO
RzogVXNlIEFSUkFZX1NJWkUKdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYXJtNjQvbXRlL2NoZWNr
X21tYXBfb3B0aW9ucy5jOjk2OjI1LTI2OgpXQVJOSU5HOiBVc2UgQVJSQVlfU0laRQp0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9hcm02NC9tdGUvY2hlY2tfbW1hcF9vcHRpb25zLmM6MTkwOjI0LTI1
OgpXQVJOSU5HOiBVc2UgQVJSQVlfU0laRQoKU2lnbmVkLW9mZi1ieTogS2FpTG9uZyBXYW5nIDx3
YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FybTY0L210
ZS9jaGVja19tbWFwX29wdGlvbnMuYyB8IDkgKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2FybTY0L210ZS9jaGVja19tbWFwX29wdGlvbnMuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2FybTY0L210ZS9jaGVja19tbWFwX29wdGlvbnMuYwppbmRleCBhMDRiMTJjMjFh
YzkuLjE3Njk0Y2FhZmY1MyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYXJt
NjQvbXRlL2NoZWNrX21tYXBfb3B0aW9ucy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2FybTY0L210ZS9jaGVja19tbWFwX29wdGlvbnMuYwpAQCAtNjEsOSArNjEsOCBAQCBzdGF0aWMg
aW50IGNoZWNrX2Fub255bW91c19tZW1vcnlfbWFwcGluZyhpbnQgbWVtX3R5cGUsIGludCBtb2Rl
LCBpbnQgbWFwcGluZywgaQogewogCWNoYXIgKnB0ciwgKm1hcF9wdHI7CiAJaW50IHJ1biwgcmVz
dWx0LCBtYXBfc2l6ZTsKLQlpbnQgaXRlbSA9IHNpemVvZihzaXplcykvc2l6ZW9mKGludCk7CisJ
aW50IGl0ZW0gPSBBUlJBWV9TSVpFKHNpemVzKTsKIAotCWl0ZW0gPSBzaXplb2Yoc2l6ZXMpL3Np
emVvZihpbnQpOwogCW10ZV9zd2l0Y2hfbW9kZShtb2RlLCBNVEVfQUxMT1dfTk9OX1pFUk9fVEFH
KTsKIAlmb3IgKHJ1biA9IDA7IHJ1biA8IGl0ZW07IHJ1bisrKSB7CiAJCW1hcF9zaXplID0gc2l6
ZXNbcnVuXSArIE9WRVJGTE9XICsgVU5ERVJGTE9XOwpAQCAtOTMsNyArOTIsNyBAQCBzdGF0aWMg
aW50IGNoZWNrX2ZpbGVfbWVtb3J5X21hcHBpbmcoaW50IG1lbV90eXBlLCBpbnQgbW9kZSwgaW50
IG1hcHBpbmcsIGludCB0YQogewogCWNoYXIgKnB0ciwgKm1hcF9wdHI7CiAJaW50IHJ1biwgZmQs
IG1hcF9zaXplOwotCWludCB0b3RhbCA9IHNpemVvZihzaXplcykvc2l6ZW9mKGludCk7CisJaW50
IHRvdGFsID0gQVJSQVlfU0laRShzaXplcyk7CiAJaW50IHJlc3VsdCA9IEtTRlRfUEFTUzsKIAog
CW10ZV9zd2l0Y2hfbW9kZShtb2RlLCBNVEVfQUxMT1dfTk9OX1pFUk9fVEFHKTsKQEAgLTEzMiw3
ICsxMzEsNyBAQCBzdGF0aWMgaW50IGNoZWNrX2NsZWFyX3Byb3RfbXRlX2ZsYWcoaW50IG1lbV90
eXBlLCBpbnQgbW9kZSwgaW50IG1hcHBpbmcpCiB7CiAJY2hhciAqcHRyLCAqbWFwX3B0cjsKIAlp
bnQgcnVuLCBwcm90X2ZsYWcsIHJlc3VsdCwgZmQsIG1hcF9zaXplOwotCWludCB0b3RhbCA9IHNp
emVvZihzaXplcykvc2l6ZW9mKGludCk7CisJaW50IHRvdGFsID0gQVJSQVlfU0laRShzaXplcyk7
CiAKIAlwcm90X2ZsYWcgPSBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFOwogCW10ZV9zd2l0Y2hfbW9k
ZShtb2RlLCBNVEVfQUxMT1dfTk9OX1pFUk9fVEFHKTsKQEAgLTE4Nyw3ICsxODYsNyBAQCBzdGF0
aWMgaW50IGNoZWNrX2NsZWFyX3Byb3RfbXRlX2ZsYWcoaW50IG1lbV90eXBlLCBpbnQgbW9kZSwg
aW50IG1hcHBpbmcpCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogewogCWludCBl
cnI7Ci0JaW50IGl0ZW0gPSBzaXplb2Yoc2l6ZXMpL3NpemVvZihpbnQpOworCWludCBpdGVtID0g
QVJSQVlfU0laRShzaXplcyk7CiAKIAllcnIgPSBtdGVfZGVmYXVsdF9zZXR1cCgpOwogCWlmIChl
cnIpCi0tIAoyLjI1LjEK
