Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B331479EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 10:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgAXJBP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 04:01:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60118 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726294AbgAXJBP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 04:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579856474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3iYgL1CWdHJApHD8cwe+xbLV8t0PTC6DfEHHLZgVxsM=;
        b=Xc2fltt1BNIzjzA6mAdd0K2h0EhVy2a4tPUKLCNWtN73vXI29AAGM1ADQxUry5v7bTXAyE
        1Bm+lCSi80AV91Ta7bll09RRSsqo4ADy5ka+cT8H+KVjN+7iYwYnxiB8EXeP5RcchxkB7l
        lbLIeL3Tr0WmV/G/bqdaVSN20CW+V34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-z4b7s3fCMc2Le6mAcApwhQ-1; Fri, 24 Jan 2020 04:01:13 -0500
X-MC-Unique: z4b7s3fCMc2Le6mAcApwhQ-1
Received: by mail-wm1-f71.google.com with SMTP id s25so374195wmj.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 01:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3iYgL1CWdHJApHD8cwe+xbLV8t0PTC6DfEHHLZgVxsM=;
        b=PZ5rxnNsqcoqf5qsVFHl+0Ptr2V+pm6dftsCMpE+CAYGrE8ZkfFDh9bCM1ZkUFxSSY
         v0DTVYGjX7DYIfbKZtTIJgwV8adENElWHm13hTUbKPlUgNwNdwDgu5HcngZRrX0YI1cn
         oTaC7VCSsYaGMsN02ocqqMlOTjbIoKOysk628GVnE5+wkQZu/2WqIBZ70zQGNJIbGWoO
         FV0L15UAF/VzwnnXasCfMN+Vr0RXlxeM+MT3bqIjesLBavNPsGSZHGd2x8hQKYqNtEPB
         NtjNhhAMhycQJhwpENUPatqnlAji8Jx34Jzg0uJtiLiPULKaER4yh3bCwmfz85A2fw8Y
         CMcQ==
X-Gm-Message-State: APjAAAV8oshPYsQdvojMg5LZ1Yvp7bDlFcdrTAQkOXKMspFd2ZkwG8oC
        LEUFVxAIT170NhNlshTE6F33FumNR3iz49upI5QQ1lDwTavJOf87sfyVSJq7Q+4kfgsT4IYkgxz
        U+zdLga5I4yK+guTzoYBlaxezRGTY
X-Received: by 2002:a5d:534d:: with SMTP id t13mr3188301wrv.77.1579856471900;
        Fri, 24 Jan 2020 01:01:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqws2epURdwL6t/bTe5dVjcFY3nad2m4EofmZZVw49VEywdNC8DKGv0/79MbgujGLBtB24Icxg==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr3188252wrv.77.1579856471547;
        Fri, 24 Jan 2020 01:01:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id s139sm5962936wme.35.2020.01.24.01.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 01:01:11 -0800 (PST)
Subject: Re: [PATCH v4 10/10] KVM: selftests: Move memslot 0 above KVM
 internal memslots
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-11-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aaf2afbb-1613-cc78-8b4f-6a7318acb22a@redhat.com>
Date:   Fri, 24 Jan 2020 10:01:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123180436.99487-11-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/20 19:04, Ben Gardon wrote:
> KVM creates internal memslots between 3 and 4 GiB paddrs on the first
> vCPU creation. If memslot 0 is large enough it collides with these
> memslots an causes vCPU creation to fail. Instead of creating memslot 0
> at paddr 0, start it 4G into the guest physical address space.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

This breaks all tests for me:

   $ ./state_test
   Testing guest mode: PA-bits:ANY, VA-bits:48,  4K pages
   Guest physical address width detected: 46
   ==== Test Assertion Failure ====
  lib/x86_64/processor.c:580: false
  pid=4873 tid=4873 - Success
     1	0x0000000000409996: addr_gva2gpa at processor.c:579
     2	0x0000000000406a38: addr_gva2hva at kvm_util.c:1636
     3	0x000000000041036c: kvm_vm_elf_load at elf.c:192
     4	0x0000000000409ea9: vm_create_default at processor.c:829
     5	0x0000000000400f6f: main at state_test.c:132
     6	0x00007f21bdf90494: ?? ??:0
     7	0x0000000000401287: _start at ??:?
  No mapping for vm virtual address, gva: 0x400000

Memslot 0 should not be too large, so this patch should not be needed.

Paolo

