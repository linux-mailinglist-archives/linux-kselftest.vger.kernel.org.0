Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6167B9946
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 02:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjJEAbX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 20:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjJEAbW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 20:31:22 -0400
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 17:31:19 PDT
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ADCD7
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 17:31:19 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qoC81-0001NN-0B;
        Wed, 04 Oct 2023 20:22:09 -0400
Message-ID: <026a75f627bc7ffa45ead3fd6ecb9da7b5bc2692.camel@surriel.com>
Subject: Re: [PATCH 2/2] selftests/mm: Add a new test for madv and hugetlb
From:   Rik van Riel <riel@surriel.com>
To:     Breno Leitao <leitao@debian.org>, mike.kravetz@oracle.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Wed, 04 Oct 2023 20:22:08 -0400
In-Reply-To: <20231004171127.106056-2-leitao@debian.org>
References: <20231004171127.106056-1-leitao@debian.org>
         <20231004171127.106056-2-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTA0IGF0IDEwOjExIC0wNzAwLCBCcmVubyBMZWl0YW8gd3JvdGU6Cj4g
Cj4gK2NoYXIgKmh1Z2VfcHRyOwo+ICsKPiArLyogVG91Y2ggdGhlIG1lbW9yeSB3aGlsZSBpdCBp
cyBiZWluZyBtYWR2aXNlZCgpICovCj4gK3ZvaWQgKnRvdWNoKHZvaWQgKnVudXNlZCkKPiArewo+
ICvCoMKgwqDCoMKgwqDCoGNoYXIgKnB0ciA9IChjaGFyICopaHVnZV9wdHI7Cj4gKwo+ICvCoMKg
wqDCoMKgwqDCoGlmICghcHRyKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZw
cmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIGFsbG9jYXRlIG1lbW9yeVxuIik7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBlcnJvcigiIik7Cj4gK8KgwqDCoMKgwqDCoMKgfQoKSSdt
IG5vdCBzdXJlIHRoaXMgZXJyb3IgbWVzc2FnZSBtYWtlcyBhIGxvdCBvZiBzZW5zZQphd2F5IGZy
b20gd2hlcmUgdGhlIGh1Z2UgcGFnZSBnZXRzIGFsbG9jYXRlZC4KCj4gCj4gK8KgwqDCoMKgwqDC
oMKgd2hpbGUgKG1heC0tKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGh1Z2Vf
cHRyID0gbW1hcChOVUxMLCBNTUFQX1NJWkUsIFBST1RfUkVBRCB8Cj4gUFJPVF9XUklURSwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMgfAo+IE1BUF9IVUdFVExCLCAtMSwgMCk7
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoKHVuc2lnbmVkIGxvbmcp
aHVnZV9wdHIgPT0gLTEpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHBlcnJvcigiRmFpbGVkIHRvIGFsbG9jYXRlXG4iKTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB9CgpTaG91bGQgdGhlIHRlc3QgY2FzZSBqdXN0IGV4aXQgd2l0
aCBhbiBlcnJvciBoZXJlLCB3aGVuCnRoZSBhbGxvY2F0aW9uIGZhaWxzPwoKTG9vcGluZyBhcm91
bmQgd2hlbiBpdCBjYW5ub3QgZ2V0IG1lbW9yeSBzZWVtcyBwb2ludGxlc3MsCmJ1dCB0ZWxsaW5n
IHRoZSB1c2VyIHRoYXQgdGhlIGFsbG9jYXRpb24gZmFpbHMsIHdoZW4gaXQKc2hvdWxkIGNsZWFy
bHkgaGF2ZSBzdWNjZWVkZWQgY291bGQgYmUgdXNlZnVsLgoKVGhpcyB0ZXN0IGNhc2UgY2VydGFp
bmx5IHNlZW1zIHRvIGRvIHRoZSB0cmljayBpbiBzaG93aW5nCndoZXRoZXIgdGhlIHJhY2UgYmV0
d2VlbiBNQURWX0RPTlRORUVEIGFuZCBwYWdlIGZhdWx0cwpleGlzdHMgaW4gYSBwYXJ0aWN1bGFy
IGtlcm5lbC4KCgotLSAKQWxsIFJpZ2h0cyBSZXZlcnNlZC4K

