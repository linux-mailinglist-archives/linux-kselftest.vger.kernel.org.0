Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA122EA8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jul 2020 12:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgG0K5s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jul 2020 06:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgG0K5r (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jul 2020 06:57:47 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33B532070B;
        Mon, 27 Jul 2020 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595847467;
        bh=U/1331pETiuwhTM+IUIHu8BPQ+Psbv5olq3HsSqSQj4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BOOtDTGzLu1hTazCClx7HJFY7Dt9e0BGgjqhW55IgbB7sYLyFJQmkCiZsCNCbcDAN
         qbhKky3oNrVus9Cyuz3LIUQvJMOg0lqaOeqv0zAxcW3IpJh6GA0wELNna+X8ji8WNE
         0goynQGVKw1nTR64C36POjKqj7RQSApbiKx8wIkk=
Message-ID: <1595847465.4841.63.camel@kernel.org>
Subject: Re: [PATCH v3 12/19] firmware_loader: Use security_post_load_data()
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
Date:   Mon, 27 Jul 2020 06:57:45 -0400
In-Reply-To: <20200724213640.389191-13-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
         <20200724213640.389191-13-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> Now that security_post_load_data() is wired up, use it instead
> of the NULL file argument style of security_post_read_file(),
> and update the security_kernel_load_data() call to indicate that a
> security_kernel_post_load_data() call is expected.
> 
> Wire up the IMA check to match earlier logic. Perhaps a generalized
> change to ima_post_load_data() might look something like this:
> 
>     return process_buffer_measurement(buf, size,
>                                       kernel_load_data_id_str(load_id),
>                                       read_idmap[load_id] ?: FILE_CHECK,
>                                       0, NULL);
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

process_measurement() measures, verifies a file signature -  both
signatures stored as an xattr and as an appended buffer signature -
and augments audit records with the file hash. (Support for measuring,
augmenting audit records, and/or verifying fs-verity signatures has
yet to be added.)

As explained in my response to 11/19, the file descriptor provides the
file pathname associated with the buffer data.  In addition, IMA
policy rules may be defined in terms of other file descriptor info -
uid, euid, uuid, etc.

Recently support was added for measuring the kexec boot command line,
certificates being loaded onto a keyring, and blacklisted file hashes
(limited to appended signatures).  None of these buffers are signed.
 process_buffer_measurement() was added for this reason and as a
result is limited to just measuring the buffer data.

Whether process_measurement() or process_buffer_measurement() should
be modified, needs to be determined.  In either case to support the
init_module syscall, would at minimum require the associated file
pathname.

Mimi
