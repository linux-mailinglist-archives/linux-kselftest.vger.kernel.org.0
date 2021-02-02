Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA530CE55
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Feb 2021 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhBBV55 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Feb 2021 16:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233881AbhBBV54 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Feb 2021 16:57:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07E0464F9C;
        Tue,  2 Feb 2021 21:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612303035;
        bh=aS7gJ5FXwVdLp47lueJyjeLHCdr7uQO+jexT6jY0RkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IW+8UN9J5T4F/W9W2vYEL5Fw2H3gCHmzArnfIk5p8xjxJjfS7sGP11shmnj6mtG/L
         rlFzsWNN4zvJ2+HSalQeHwubK7GbcLB3+TzwRSeSLcnRfAO+qZPJwox+xw3zWpywqZ
         alTKe1nMC62CJA2OxA/XaeqkLiBmT+xGptEyX2Qul77FQ1fzWjQIUbB5PGS4f8+Va/
         H9/ZCPeV36KOieJynnw7JJXAhufRkg7YcXCNP58gjW/1KPUS+FnCf6CgC6LFHS9GL6
         pg+LB6egoL8QEAvQzqR3txPAchZirQ2YB9Z+oV6B/g6wiwTbmZJEOJBxz7GZFS9Qus
         tVzYwDTdy3DOw==
Date:   Tue, 2 Feb 2021 23:57:08 +0200
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
Subject: Re: [PATCH v4 4/5] x86/sgx: Allows ioctl PROVISION to execute before
 CREATE
Message-ID: <YBnKtF5irw3vImmh@kernel.org>
References: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
 <20210201132653.35690-5-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201132653.35690-5-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 01, 2021 at 09:26:52PM +0800, Tianjia Zhang wrote:
> In the function sgx_create_enclave(), the direct assignment
> operation of attributes_mask determines that the ioctl PROVISION
> operation must be executed after the ioctl CREATE operation,
> which will limit the flexibility of sgx developers.

Please write acronyms correctly. It's not 'sgx'. It's 'SGX'.

Who are the "sgx developers" and how do they benefit from this?

/Jarkko
