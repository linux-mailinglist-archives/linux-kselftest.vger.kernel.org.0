Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC822F529
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jul 2020 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgG0Q3g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jul 2020 12:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgG0Q3g (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jul 2020 12:29:36 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3311C20719;
        Mon, 27 Jul 2020 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595867376;
        bh=8oCB6uea+aVDOj/Yx59qQSnN7cBU25mvgxQKlD5dQsQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J7PC4nMUIbBazsfj45I5T2O5RZXhlruY1Jd9CA0AJI5vjSA1UL5rdPqK1C7d/pPCV
         sLTGX0tw+4gnCZQY1RVslJDjjsiq48PwpQFy+rTHxjKdWcEnP6I7CAB4G6haKHwDTC
         YztTFKyEh1+gVHD8M0jLZgoi7JNzq9DWCvOKvMbE=
Message-ID: <1595867374.4841.135.camel@kernel.org>
Subject: Re: [PATCH v3 09/19] fs/kernel_read_file: Switch buffer size arg to
 size_t
From:   Mimi Zohar <zohar@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Jul 2020 12:29:34 -0400
In-Reply-To: <20200724213640.389191-10-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
         <20200724213640.389191-10-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> In preparation for further refactoring of kernel_read_file*(), rename
> the "max_size" argument to the more accurate "buf_size", and correct
> its type to size_t. Add kerndoc to explain the specifics of how the
> arguments will be used. Note that with buf_size now size_t, it can no
> longer be negative (and was never called with a negative value). Adjust
> callers to use it as a "maximum size" when *buf is NULL.
> 
> Acked-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
