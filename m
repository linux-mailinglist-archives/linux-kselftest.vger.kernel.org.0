Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2654B3028DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 18:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbhAYRXg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 12:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730980AbhAYRXB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 12:23:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A793C22B3B;
        Mon, 25 Jan 2021 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611595341;
        bh=NRxiUVpge9iTdgMnIs+QH2bpm+PmX8g8cC8kUYCHmWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlAcewIKQnWR6zGjEZUs6WwjDAn+mbS4O9h9TjncvZxG5s3FhRz8nRNmynog0+gO3
         w+QyZ/gEoXLEkBG5rluQSBniuyO/lG8bK6TG12pJABV5QKsvBkVyzetTfqYrWoMOpp
         v2ka4fPaYhPpOSbpvKvMlNkh4RgxeqoF8qtbXhWglFJWsAyKw4YAYRkN4LYivLuo40
         HDXiIc+ObdcKKXKre3UFp57M5oLY3TUr6JMB8+FOjf3H8OgIJvaeYgb8B4r0QvxJPz
         D6qFcZLhZuUZITt0WEHpwkrhKdb7mFl7NqvJniSqxndMENs9DkWJcc/kEW2jBELYkU
         8/PxXCvO0OJ+w==
Date:   Mon, 25 Jan 2021 19:22:18 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH v3 0/5] Some optimizations related to sgx
Message-ID: <YA7+Sl1UYnwveHfE@kernel.org>
References: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 24, 2021 at 02:29:02PM +0800, Tianjia Zhang wrote:
> This is an optimization of a set of sgx-related codes, each of which
> is independent of the patch. Because the second and third patches have
> conflicting dependencies, these patches are put together.
> 
> ---
> v3 changes:
>   * split free_cnt count and spin lock optimization into two patches
> 
> v2 changes:
>   * review suggested changes
> 
> Tianjia Zhang (5):
>   selftests/x86: Simplify the code to get vdso base address in sgx
>   x86/sgx: Optimize the locking range in sgx_sanitize_section()
>   x86/sgx: Optimize the free_cnt count in sgx_epc_section
>   x86/sgx: Allows ioctl PROVISION to execute before CREATE
>   x86/sgx: Remove redundant if conditions in sgx_encl_create

I remember asking about previous patches. I don't recall of getting
any responses to anything basically.

/Jarkko
