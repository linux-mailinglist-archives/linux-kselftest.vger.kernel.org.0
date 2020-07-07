Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82909216E14
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 15:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGGNw7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 09:52:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgGGNw7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 09:52:59 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jso1q-0000YF-ES; Tue, 07 Jul 2020 13:52:58 +0000
Date:   Tue, 7 Jul 2020 15:52:57 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        christian@brauner.io, shuah@kernel.org
Subject: Re: [PATCH v3 0/2] selftests: pidfd: prefer ksft_test_result_skip to
 ksft_exit_*
Message-ID: <20200707135257.u65ggyr2hcgjfgyh@wittgenstein>
References: <20200707101936.12052-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707101936.12052-1-pbonzini@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 07, 2020 at 06:19:34AM -0400, Paolo Bonzini wrote:
> Calling ksft_exit_* results in executing fewer tests than planned, which
> is wrong for ksft_exit_skip or suboptimal (because it results in a bail
> out) for ksft_exit_fail_msg.
> 
> Using ksft_test_result_skip instead skips only one test and lets the
> test plan proceed as promised by ksft_set_plan.
> 
> Paolo

Thanks for fixing this, Paolo!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Shuah, want me to take it or do you want to take it?
