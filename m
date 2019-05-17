Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F58F21232
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2019 04:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfEQCpP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 May 2019 22:45:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfEQCpP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 May 2019 22:45:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 962F936883;
        Fri, 17 May 2019 02:45:15 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACD8960A9D;
        Fri, 17 May 2019 02:45:12 +0000 (UTC)
Date:   Fri, 17 May 2019 10:45:10 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Compile code with warnings enabled
Message-ID: <20190517024510.GN16681@xz-x1>
References: <20190516130257.29445-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516130257.29445-1-thuth@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 17 May 2019 02:45:15 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas,

On Thu, May 16, 2019 at 03:02:57PM +0200, Thomas Huth wrote:
> So far the KVM selftests are compiled without any compiler warnings
> enabled. That's quite bad, since we miss a lot of possible bugs this
> way. Let's enable at least "-Wall" and some other useful warning flags
> now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  This patch fixes most of the warnings in the x86 code already - but
>  for some warnings, I was not quite sure (e.g. about the need for the
>  kvm_get_supported_cpuid_entry(1) in some tests), so I did not touch

If you mean the two calls in state_test and evmcs_test I would agree
they should be dropped directly.

Just to mention that the patch may not apply cleanly to kvm/queue now
probably because the dirty-log-test.c touchup recently, so may need a
rebase.  Otherwise it looks nice at least to me to have these checks.

Thanks,

-- 
Peter Xu
