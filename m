Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B210C372811
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 May 2021 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhEDJ2A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 May 2021 05:28:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:38055 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhEDJ1v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 May 2021 05:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1620120417; x=1651656417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VQ/a1Lg4gGku2HtYE9KiPPHcFeBRAiUZ7AcJxQWzW+Q=;
  b=JO32lqMePlVa4DhCvqXnr4OhifXuULHGBi/rB7jNO4ZC0IPer68pi06t
   3VyazDc6pwYQkoIhjT3emNIdEDWS1ENC5TErj3qeC3wuKq0BPUqBb4Kg3
   CKf+ftRDNdNuxZXv7I396I/JrvSJnrDKxln+mGNbzmY1ZiFZrSPdxjh2C
   M=;
X-IronPort-AV: E=Sophos;i="5.82,272,1613433600"; 
   d="scan'208";a="132879461"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 04 May 2021 09:26:34 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 0A329A04E5;
        Tue,  4 May 2021 09:26:26 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 4 May 2021 09:26:26 +0000
Received: from [10.85.99.170] (10.43.162.28) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May
 2021 09:26:21 +0000
Message-ID: <b4434730-9cd1-1d41-d012-f7beff7e351b@amazon.com>
Date:   Tue, 4 May 2021 11:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:89.0)
 Gecko/20100101 Thunderbird/89.0
Subject: Re: [PATCH v4] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid
 entries count
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "Denis V. Lunev" <den@openvz.org>,
        Sean Christopherson <seanjc@google.com>,
        Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
CC:     <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Jim Mattson" <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        "Andrew Jones" <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Like Xu <like.xu@linux.intel.com>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20210428172729.3551-1-valeriy.vdovin@virtuozzo.com>
 <YIoFFl72VSeuhCRt@google.com>
 <0d68dbc3-8462-7763-fbad-f3b895fcf6e6@redhat.com>
 <be7eedf7-03a2-f998-079d-b18101b8b187@openvz.org>
 <63e54361-0018-ad3b-fb2b-e5dba6a0f221@redhat.com>
 <048b3f3a-379d-cff3-20b6-fc74dd12a98f@openvz.org>
 <514b5373-c07b-ad34-5fba-f8850faf6d68@redhat.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <514b5373-c07b-ad34-5fba-f8850faf6d68@redhat.com>
X-Originating-IP: [10.43.162.28]
X-ClientProxiedBy: EX13D16UWC004.ant.amazon.com (10.43.162.72) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CgpPbiAwNC4wNS4yMSAxMDoyMSwgUGFvbG8gQm9uemluaSB3cm90ZToKPiAKPiBPbiAwNC8wNS8y
MSAxMDoxNSwgRGVuaXMgVi4gTHVuZXYgd3JvdGU6Cj4+IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQg
b25seSBzb21lIHRlc3Rpbmcgd2l0aGluIGtlcm5lbCBub3cuCj4+IFRob3VnaCB3ZSBoYXZlIHBs
YW5zIHRvIGV4cG9zZSBpdCBmb3IgUUFQSSBhcyB0aGUgc2VyaWVzCj4+IGluIFFFTVUKPj4gwqDC
oCBbUEFUQ0ggMS8yXSBxYXBpOiBmaXggZXJyb3IgaGFuZGxpbmcgZm9yIHgtdnotcXVlcnktY3B1
LW1vZGVsLWNwdWlkCj4+IMKgwqAgW1BBVENIIDIvMl0gcWFwaTogYmxhY2tsaXN0ZWQgeC12ei1x
dWVyeS1jcHUtbW9kZWwtY3B1aWQgaW4gdGVzdHMKPj4gaXMgbm90IGNvbWluZyBpbiBhIGdvb2Qg
d2F5Lgo+PiBUaGUgaWRlYSB3YXMgdG8gYXZvaWQgbWFudWFsIGNvZGUgcmV3b3JrIGluIFFFTVUg
YW5kCj4+IGV4cG9zZSBjb2xsZWN0ZWQgbW9kZWwgYXQgbGVhc3QgZm9yIGRlYnVnLgo+IAo+IEtW
TV9HRVRfQ1BVSUQyIGFzIGEgVk0gaW9jdGwgY2Fubm90IGV4cG9zZSB0aGUgd2hvbGUgdHJ1dGgg
YWJvdXQgQ1BVSUQKPiBlaXRoZXIsIHNpbmNlIGl0IGRvZXNuJ3QgaGFuZGxlIHRoZSBUU1hfQ1RS
TF9DUFVJRF9DTEVBUiBiaXQuwqAgR2l2ZW4KPiB0aGF0IFFFTVUgZG9lc24ndCBuZWVkIEtWTV9H
RVRfQ1BVSUQyOyBpdCBvbmx5IG5lZWRzIHRvIHNhdmUgd2hhdGV2ZXIgaXQKPiBwYXNzZWQgdG8g
S1ZNX1NFVF9DUFVJRDIuCgpXaGF0IGlmIHdlIGluc3RlYWQgZGVmbGVjdCBDUFVJRCBpbnRvIHVz
ZXIgc3BhY2Ugc28gaXQgY2FuIGVtdWxhdGUgaXQgaW4gCndoYXRldmVyIHdheSBpdCBsaWtlcz8g
SXMgdGhlIHBlcmZvcm1hbmNlIGRpZmZlcmVuY2UgZ29pbmcgdG8gYmUgCnJlbGV2YW50PyBBcmUg
cGVvcGxlIHN0aWxsIHVzaW5nIGNwdWlkIGFzIGJhcnJpZXIgdGhlc2UgZGF5cz8KCgpBbGV4CgoK
CkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEw
MTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0
aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVy
IEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

