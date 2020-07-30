Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88D2329FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jul 2020 04:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgG3CZe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 22:25:34 -0400
Received: from namei.org ([65.99.196.166]:56448 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgG3CZe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 22:25:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 06U2PR12004264;
        Thu, 30 Jul 2020 02:25:27 GMT
Date:   Thu, 30 Jul 2020 12:25:27 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/17] fs/kernel_read_file: Switch buffer size arg to
 size_t
In-Reply-To: <20200729175845.1745471-8-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.2007301225180.3625@namei.org>
References: <20200729175845.1745471-1-keescook@chromium.org> <20200729175845.1745471-8-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 29 Jul 2020, Kees Cook wrote:

> In preparation for further refactoring of kernel_read_file*(), rename
> the "max_size" argument to the more accurate "buf_size", and correct
> its type to size_t. Add kerndoc to explain the specifics of how the
> arguments will be used. Note that with buf_size now size_t, it can no
> longer be negative (and was never called with a negative value). Adjust
> callers to use it as a "maximum size" when *buf is NULL.
> 
> Acked-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

