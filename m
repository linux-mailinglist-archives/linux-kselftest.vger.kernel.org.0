Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062B722F2BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jul 2020 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbgG0OmC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jul 2020 10:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgG0Olw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jul 2020 10:41:52 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB70208E4;
        Mon, 27 Jul 2020 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595860912;
        bh=0XkNZGMfPjvvPJ4vDl6luNql4PL5ypWVUV/Rm+mizsE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jpg/EmyQDv9FT7kOivKMX8wFhGU4sFTB2CH3Fh4EZTjsJsvFBn7m7pngU0GoPyW+3
         39SrDAlP4E+C6K+8ut68HKiV0e/CnGbZncwAxpQzwd+vVR2JJIvbvJk/g27MBtu9Ku
         qK+mrjkQ3I6tKw3z/+lX1qAQaaqCDbWrPRjvxXS0=
Message-ID: <1595860910.4841.118.camel@kernel.org>
Subject: Re: [PATCH v3 06/19] fs/kernel_read_file: Split into separate
 include file
From:   Mimi Zohar <zohar@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Jul 2020 10:41:50 -0400
In-Reply-To: <20200724213640.389191-7-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
         <20200724213640.389191-7-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> From: Scott Branden <scott.branden@broadcom.com>
> 
> Move kernel_read_file* out of linux/fs.h to its own linux/kernel_read_file.h
> include file. That header gets pulled in just about everywhere
> and doesn't really need functions not related to the general fs interface.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/r/20200706232309.12010-2-scott.branden@broadcom.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
