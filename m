Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E0232A0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jul 2020 04:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgG3CbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 22:31:01 -0400
Received: from namei.org ([65.99.196.166]:56468 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgG3CbA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 22:31:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 06U2QGu7004321;
        Thu, 30 Jul 2020 02:26:16 GMT
Date:   Thu, 30 Jul 2020 12:26:16 +1000 (AEST)
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
Subject: Re: [PATCH v4 08/17] fs/kernel_read_file: Add file_size output
 argument
In-Reply-To: <20200729175845.1745471-9-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.2007301226060.3625@namei.org>
References: <20200729175845.1745471-1-keescook@chromium.org> <20200729175845.1745471-9-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 29 Jul 2020, Kees Cook wrote:

> In preparation for adding partial read support, add an optional output
> argument to kernel_read_file*() that reports the file size so callers
> can reason more easily about their reading progress.
> 
> Acked-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

