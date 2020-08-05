Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DD123D220
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 22:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgHEUJO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 16:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbgHEQce (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:34 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 611972332B;
        Wed,  5 Aug 2020 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596639229;
        bh=dbGVB80eYa/nySFVWDJFfLJakBsIbNOmiAZCGTFt7no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aiidoivW6Ka39wLtz4Rev/xfeu3gn/KqTPMWcMp2RpfkimMpyH9umMo3mqAjVizCX
         4Ba9g+JuEE+1F2LMpKt9MJ3zqjc4VcDw6pIvqAxnAD31JOGx1wKeMHMd1vmu70PBnT
         21BTAUo97qU7VTMydLFvMz/JsKrurSCZF9fPrfuM=
Date:   Wed, 5 Aug 2020 16:53:43 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/17] module: Call security_kernel_post_load_data()
Message-ID: <20200805145342.GA22100@linux-8ccs>
References: <20200729175845.1745471-1-keescook@chromium.org>
 <20200729175845.1745471-12-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200729175845.1745471-12-keescook@chromium.org>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+++ Kees Cook [29/07/20 10:58 -0700]:
>Now that there is an API for checking loaded contents for modules
>loaded without a file, call into the LSM hooks.
>
>Cc: Jessica Yu <jeyu@kernel.org>
>Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Jessica Yu <jeyu@kernel.org>
