Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7D22F311
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jul 2020 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgG0OxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jul 2020 10:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgG0OxJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jul 2020 10:53:09 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4EA22CB1;
        Mon, 27 Jul 2020 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595861588;
        bh=2+SGrb65KvR4X1ih7aJ7lLxKf5MslGgwPcpWX6hHtrI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D3JOPGeVhEwcrbwW3JzGu0YmOgkRYf5VbJU0NlFtx1xFokeX8gsDiJHwcWuHLawTK
         mwIZOQT1Ygx6stszWlayqAdaaqEIFJxx6IA8PSKTnDW0twddFs2zgyEDzfzVXhDb2s
         QzjrauGyvXpECiWRnJrmNw6dTff3uq7SNjNyDnQA=
Message-ID: <1595861586.4841.122.camel@kernel.org>
Subject: Re: [PATCH v3 07/19] fs/kernel_read_file: Split into separate
 source file
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
Date:   Mon, 27 Jul 2020 10:53:06 -0400
In-Reply-To: <20200724213640.389191-8-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
         <20200724213640.389191-8-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> These routines are used in places outside of exec(2), so in preparation
> for refactoring them, move them into a separate source file,
> fs/kernel_read_file.c.
> 
> Acked-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
