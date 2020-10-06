Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC128512C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Oct 2020 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgJFRsi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Oct 2020 13:48:38 -0400
Received: from namei.org ([65.99.196.166]:33334 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgJFRsi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Oct 2020 13:48:38 -0400
X-Greylist: delayed 1828 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 13:48:35 EDT
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 096HJreu007613;
        Tue, 6 Oct 2020 17:19:53 GMT
Date:   Wed, 7 Oct 2020 04:19:53 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        KP Singh <kpsingh@google.com>, Jessica Yu <jeyu@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/16] module: Call security_kernel_post_load_data()
In-Reply-To: <20201002173828.2099543-11-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.2010070419420.18879@namei.org>
References: <20201002173828.2099543-1-keescook@chromium.org> <20201002173828.2099543-11-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2 Oct 2020, Kees Cook wrote:

> Now that there is an API for checking loaded contents for modules
> loaded without a file, call into the LSM hooks.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: KP Singh <kpsingh@google.com>
> Acked-by: Jessica Yu <jeyu@kernel.org>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

