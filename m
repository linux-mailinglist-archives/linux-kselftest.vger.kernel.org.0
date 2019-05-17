Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD912164E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2019 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfEQJaK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 May 2019 05:30:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfEQJaK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 May 2019 05:30:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16E8D30ADC82;
        Fri, 17 May 2019 09:30:10 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 346D85D9C4;
        Fri, 17 May 2019 09:30:02 +0000 (UTC)
Date:   Fri, 17 May 2019 17:30:00 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Compile code with warnings enabled
Message-ID: <20190517093000.GO16681@xz-x1>
References: <20190517090445.4502-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517090445.4502-1-thuth@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 17 May 2019 09:30:10 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 17, 2019 at 11:04:45AM +0200, Thomas Huth wrote:
> So far the KVM selftests are compiled without any compiler warnings
> enabled. That's quite bad, since we miss a lot of possible bugs this
> way. Let's enable at least "-Wall" and some other useful warning flags
> now, and fix at least the trivial problems in the code (like unused
> variables).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Rebased to kvm/queue
>  - Fix warnings in state_test.c and evmcs_test.c, too

I still see these warnings (probably because the hyperv_cpuid.c is a
new test):

In file included from x86_64/hyperv_cpuid.c:18:
x86_64/hyperv_cpuid.c: In function ‘test_hv_cpuid’:
x86_64/hyperv_cpuid.c:61:33: warning: suggest parentheses around comparison in operand of ‘==’ [-Wparentheses]
   TEST_ASSERT(entry->padding[0] == entry->padding[1]
               ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
include/test_util.h:32:15: note: in definition of macro ‘TEST_ASSERT’
  test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
               ^
x86_64/hyperv_cpuid.c:62:8: warning: suggest parentheses around comparison in operand of ‘==’ [-Wparentheses]
   TEST_ASSERT(entry->padding[0] == entry->padding[1]
               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        == entry->padding[2] == 0,
        ^~~~~~~~~~~~~~~~~~~~
include/test_util.h:32:15: note: in definition of macro ‘TEST_ASSERT’
  test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
               ^
x86_64/hyperv_cpuid.c: In function ‘kvm_get_supported_hv_cpuid’:
x86_64/hyperv_cpuid.c:93:6: warning: unused variable ‘ret’ [-Wunused-variable]
  int ret;
      ^~~

The first two seem to be real bugs in the test code, and the 3rd one
might need a cleanup too.

Thanks,

-- 
Peter Xu
