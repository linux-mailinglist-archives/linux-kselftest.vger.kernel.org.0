Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8043333B331
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 14:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhCONC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 09:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhCONC1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 09:02:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4281A64EB6;
        Mon, 15 Mar 2021 13:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615813346;
        bh=NUE6PgSeEbJexnyjtZ5o2zre1gcGihFeOE0jUFx/AtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRI8gBCIo3Gn+czcoeQLAdZ0QoItezhVswJGrLE/tVyAQpt5jpPLGAzx01hlC8yYt
         h+Vy8SC1H22hMjo1lfiGZ6dHxDXlTN3Bxphr4mOy61PgHx6P+5RmK8uEOkGnbirH34
         LTqGJ/J7y1xbTzJRzpCvsDL+eHaCcZTJlpS4vKQtEe0iFKRQvMjqZVYNlwa8aT6ir4
         cPuidHERJ4V3uXwJcoXY2tUhr1h/mYIU/amiWXZldxrzlC2jN0ph/sY2yq4B4ukN2P
         AyWd64aV8cGV3zUNsEEMHicdRP9V4qWOjvN5ANeYM+LcJnFyIXqrk2euYrr2HHEXq7
         6KzLXplRUZnoQ==
Date:   Mon, 15 Mar 2021 15:02:00 +0200
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
Subject: Re: [PATCH v6] selftests/x86: Use getauxval() to simplify the code
 in sgx
Message-ID: <YE9ayBnFIpwGiVVr@kernel.org>
References: <20210314111621.68428-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314111621.68428-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 14, 2021 at 07:16:21PM +0800, Tianjia Zhang wrote:
> Simplify the sgx code implemntation by using library function
> getauxval() instead of a custom function to get the base address
> of vDSO.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Shuah, Boris, which tree this should be picked?

/Jarkko
